// Forest-specific resource adapter for the proven VN Revival Windows installer.
// Compatible with Windows PowerShell 5.1/.NET Framework 4.8 and the net8 test host.
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.IO.Compression;
using System.Linq;
using System.Runtime.Serialization;
using System.Runtime.Serialization.Json;
using System.Security.Cryptography;
using System.Text;

namespace VNRevival.Forest {
    [DataContract] public class Fingerprint {
        [DataMember] public string path;
        [DataMember] public string sha256;
        [DataMember] public long bytes;
    }
    [DataContract] public class Segment {
        [DataMember(Name="base")] public int basis;
        [DataMember] public long offset;
        [DataMember] public int bytes;
        [DataMember] public string blob;
    }
    [DataContract] public class Resource : Fingerprint {
        [DataMember] public Segment[] segments;
        [DataMember] public long storageBytes;
        [DataMember] public string storageSha256;
        [DataMember] public string bundleRecipe;
        [DataMember] public long bundleRecipeBytes;
    }
    [DataContract] public class Locale {
        [DataMember] public string code;
        [DataMember] public string culture;
        [DataMember] public string name;
        [DataMember] public string languageSha256;
        [DataMember] public Resource[] files;
    }
    [DataContract] public class Manifest {
        [DataMember] public int format;
        [DataMember] public string gameVersion;
        [DataMember] public string dataDirectory;
        [DataMember] public string identityPath;
        [DataMember] public string identitySha256;
        [DataMember] public Fingerprint[] originals;
        [DataMember] public Fingerprint[] baselines;
        [DataMember] public Locale[] locales;
    }
    [DataContract] public class State {
        [DataMember] public int format;
        [DataMember] public string owner;
        [DataMember] public string transaction;
        [DataMember] public string locale;
        [DataMember] public string culture;
        [DataMember] public string package;
        [DataMember] public Fingerprint[] files;
    }
    [DataContract] public class Journal {
        [DataMember] public string transaction;
        [DataMember] public Fingerprint[] before;
        [DataMember] public Fingerprint[] desired;
    }

    public static class Installer {
        public const string Owner = "VNRevival.Forest.Localization";
        public const string DataName = "The Forest of Love_Data";
        public const string ExeName = "The Forest of Love.exe";
        static readonly string[] Paths = new [] {
            "Managed/Assembly-CSharp.dll", "Managed/VNRevivalInventoryLayout.dll", "Managed/VNRevivalQuestLayout.dll",
            "StreamingAssets/aa/StandaloneWindows64/defaultlocalgroup_assets_all_298c5a4d1d1846b1a8d2c7d5da3f319c.bundle",
            "StreamingAssets/aa/catalog.json", "level1", "level5", "level6", "resources.assets",
            "sharedassets0.assets", "sharedassets1.assets", "sharedassets15.assets", "sharedassets2.assets", "sharedassets4.assets"
        };
        // Isolated tests inject failures into the actual transaction, never a mock installer.
        public static Action<string> TestCheckpoint;
        public static string TestTemporaryRoot;
        static void Tick(string name) { if (TestCheckpoint != null) TestCheckpoint(name); }
        static void Need(bool condition, string message) { if (!condition) throw new InvalidOperationException(message); }
        public static string Hash(string path) {
            using (var stream = File.OpenRead(path)) using (var sha = SHA256.Create())
                return BitConverter.ToString(sha.ComputeHash(stream)).Replace("-", "").ToLowerInvariant();
        }
        static bool IsHash(string s) { return s != null && s.Length == 64 && s.All(c => c >= '0' && c <= '9' || c >= 'a' && c <= 'f'); }
        static T Read<T>(Stream stream) {
            return (T)new DataContractJsonSerializer(typeof(T), new DataContractJsonSerializerSettings { MaxItemsInObjectGraph = 4000000 }).ReadObject(stream);
        }
        static T ReadFile<T>(string path) { using (var stream = File.OpenRead(path)) return Read<T>(stream); }
        static void Atomic<T>(string path, T data) {
            string temp = path + "." + Guid.NewGuid().ToString("N") + ".tmp";
            try {
                using (var stream = new FileStream(temp, FileMode.CreateNew, FileAccess.Write, FileShare.None)) {
                    new DataContractJsonSerializer(typeof(T), new DataContractJsonSerializerSettings { MaxItemsInObjectGraph = 4000000 }).WriteObject(stream, data);
                    stream.Flush(true);
                }
                if (Path.GetFileName(path) == "state.json") Tick("state-ready");
                if (File.Exists(path)) File.Replace(temp, path, null); else File.Move(temp, path);
            } finally { if (File.Exists(temp)) File.Delete(temp); }
        }
        static void NoLinks(string path) {
            var cursor = new DirectoryInfo(Path.GetFullPath(path));
            while (cursor != null) {
                if (cursor.Exists) Need((cursor.Attributes & FileAttributes.ReparsePoint) == 0, "Linked folders are not supported: " + cursor.FullName);
                cursor = cursor.Parent;
            }
            if (File.Exists(path)) Need((File.GetAttributes(path) & FileAttributes.ReparsePoint) == 0, "Linked files are not supported: " + path);
        }
        static string Child(string root, string name) {
            Need(!String.IsNullOrEmpty(name) && !name.Contains("\\") && !name.Contains(":") && !Path.IsPathRooted(name)
                && name.Split('/').All(x => x.Length > 0 && x != "." && x != ".."), "Unsafe package path.");
            string path = Path.GetFullPath(Path.Combine(root, name.Replace('/', Path.DirectorySeparatorChar)));
            Need(path.StartsWith(Path.GetFullPath(root).TrimEnd(Path.DirectorySeparatorChar) + Path.DirectorySeparatorChar,
                                 StringComparison.OrdinalIgnoreCase), "Package path escapes its folder.");
            NoLinks(path);
            return path;
        }
        static void ValidateFiles(Fingerprint[] files) {
            Need(files != null && files.Length == Paths.Length, "Incomplete resource list.");
            Need(files.Select(x => x.path).Distinct(StringComparer.OrdinalIgnoreCase).Count() == Paths.Length, "Duplicate resource path.");
            Need(new HashSet<string>(files.Select(x => x.path), StringComparer.Ordinal).SetEquals(Paths), "Unknown resource path.");
            foreach (var f in files) Need(f.bytes >= 0 && f.bytes <= 300000000 && (IsHash(f.sha256) || f.sha256 == null && f.bytes == 0), "Invalid resource fingerprint.");
        }
        static void Verify(string root, Fingerprint[] files) {
            ValidateFiles(files);
            foreach (var f in files) {
                string p = Child(root, f.path);
                Need(!Directory.Exists(p), "A resource path is a folder: " + f.path);
                Need(f.sha256 == null ? !File.Exists(p) : File.Exists(p) && new FileInfo(p).Length == f.bytes && Hash(p) == f.sha256,
                     "Unexpected or modified resource: " + f.path + ". Restore the original game or this installer's last installed version first.");
            }
        }
        static void CopyVerified(string from, string to, Fingerprint f) {
            Directory.CreateDirectory(Path.GetDirectoryName(to));
            // A killed first install must not publish a half-written permanent
            // original or package cache. Only a verified copy receives its name.
            string temp = to + "." + Guid.NewGuid().ToString("N") + ".tmp";
            try {
                using (var input = File.OpenRead(from)) using (var output = new FileStream(temp, FileMode.CreateNew, FileAccess.Write, FileShare.None)) {
                    input.CopyTo(output); output.Flush(true);
                }
                Need(new FileInfo(temp).Length == f.bytes && Hash(temp) == f.sha256, "File copy verification failed: " + f.path);
                Tick("copy-ready-" + f.path);
                File.Move(temp, to);
            } finally { if (File.Exists(temp)) File.Delete(temp); }
        }
        static byte[] Entry(ZipArchive archive, string name, long length) {
            var entry = archive.GetEntry(name);
            Need(entry != null && entry.Length == length && length <= 300000000, "Missing or invalid package entry: " + name);
            using (var stream = entry.Open()) using (var memory = new MemoryStream()) {
                stream.CopyTo(memory); return memory.ToArray();
            }
        }
        static Manifest LoadManifest(ZipArchive archive) {
            Need(archive.Entries.Select(x => x.FullName).Distinct(StringComparer.OrdinalIgnoreCase).Count() == archive.Entries.Count, "Duplicate archive entry.");
            var entry = archive.GetEntry("manifest.json");
            Need(entry != null && entry.Length <= 40000000, "Missing or oversized package manifest.");
            Manifest m; using (var s = entry.Open()) m = Read<Manifest>(s);
            Need(m.format == 3 && m.gameVersion == "0.45" && m.dataDirectory == DataName && m.identityPath == "globalgamemanagers.assets" && IsHash(m.identitySha256), "Unsupported game package.");
            ValidateFiles(m.originals);
            Need(m.baselines != null && m.baselines.Length == m.originals.Count(x => x.sha256 != null)+1
                && m.baselines.Select(x => x.path).Distinct(StringComparer.OrdinalIgnoreCase).Count() == m.baselines.Length, "Invalid source dictionary.");
            Need(m.baselines.Count(x => x.path == "__bundle.asset" && IsHash(x.sha256) && x.bytes > 0 && x.bytes < 536870912) == 1, "Missing original bundle asset.");
            foreach (var f in m.baselines.Where(x => x.path != "__bundle.asset"))
                Need(m.originals.Any(x => x.path == f.path && x.sha256 == f.sha256 && x.bytes == f.bytes && x.sha256 != null), "Invalid source dictionary binding.");
            Need(m.locales != null && m.locales.Length > 0 && m.locales.Length <= 31 && m.locales.Select(x => x.code).Distinct().Count() == m.locales.Length, "Invalid language list.");
            foreach (var locale in m.locales) {
                Need(locale.code != "en" && !String.IsNullOrEmpty(locale.code) && locale.code.All(c => Char.IsLetterOrDigit(c) || c == '-'), "Invalid locale code.");
                ValidateRecipes(locale.files, m.baselines);
            }
            return m;
        }
        static void ValidateRecipes(Resource[] files, Fingerprint[] bases) {
            ValidateFiles(files);
            foreach (var f in files) {
                Need(IsHash(f.sha256) && IsHash(f.storageSha256) && f.storageBytes >= 0 && f.storageBytes < 536870912 && f.segments != null && f.segments.Length <= 50000, "Invalid resource recipe.");
                Need(f.path == Paths[3] ? IsHash(f.bundleRecipe) && f.bundleRecipeBytes > 0 && f.bundleRecipeBytes < 100000000 :
                    f.bundleRecipe == null && f.storageBytes == f.bytes && f.storageSha256 == f.sha256, "Invalid bundle storage binding.");
                long total = 0;
                foreach (var x in f.segments) {
                    Need(x.bytes > 0 && x.bytes <= 65536 && x.offset >= 0, "Invalid recipe segment.");
                    Need(x.blob != null ? IsHash(x.blob) && x.basis == -1 : x.basis >= 0 && x.basis < bases.Length && x.offset <= bases[x.basis].bytes-x.bytes, "Invalid segment source.");
                    total += x.bytes;
                }
                Need(total == f.storageBytes, "Invalid recipe length.");
            }
        }
        static string Quote(string value) {
            var result = new StringBuilder("\""); int slashes = 0;
            foreach (char c in value) {
                if (c == '\\') { slashes++; continue; }
                result.Append('\\', c == '"' ? slashes * 2 + 1 : slashes); slashes = 0; result.Append(c);
            }
            result.Append('\\', slashes * 2); return result.Append('"').ToString();
        }
        static string Relative(string from, string to) {
            var root = new Uri(Path.GetFullPath(from).TrimEnd(Path.DirectorySeparatorChar) + Path.DirectorySeparatorChar);
            string path = Uri.UnescapeDataString(root.MakeRelativeUri(new Uri(Path.GetFullPath(to))).ToString());
            Need(!Path.IsPathRooted(path) && path.All(c => c <= 127), "Codec source must have an ASCII relative resource path.");
            return path;
        }
        static void Codec(string codec, string directory, params string[] args) {
            var start = new ProcessStartInfo { FileName = codec, WorkingDirectory = directory,
                Arguments = String.Join(" ", args.Select(Quote)), UseShellExecute = false, CreateNoWindow = true, RedirectStandardError = true };
            using (var process = Process.Start(start)) {
                string error = process.StandardError.ReadToEnd(); process.WaitForExit();
                Need(process.ExitCode == 0, "The selected language could not be prepared. " + error.Substring(0, Math.Min(error.Length, 500)));
            }
        }
        static void Materialize(ZipArchive archive, Manifest m, Locale locale, string originals, string stage, string codec) {
            string work = Directory.GetParent(stage).FullName;
            string originalAsset = Child(work, "__source.asset");
            string originalBundle = Child(originals, Paths[3]);
            Codec(codec, work, "extract", Relative(work, originalBundle), "__source.asset");
            var streams = new List<FileStream>();
            try {
                foreach (var b in m.baselines) {
                    string path = b.path == "__bundle.asset" ? originalAsset : Child(originals, b.path);
                    Need(Matches(path, b), "Original resource dictionary checksum failed.");
                    streams.Add(File.OpenRead(path));
                }
                foreach (var f in locale.files) {
                    string dest = Child(stage, f.path);
                    string storage = f.bundleRecipe == null ? dest : Child(stage, "__target.asset");
                    Directory.CreateDirectory(Path.GetDirectoryName(storage));
                    using (var output = new FileStream(storage, FileMode.CreateNew, FileAccess.Write, FileShare.None)) {
                        var copy = new byte[65536];
                        foreach (var x in f.segments) {
                            if (x.blob != null) {
                                byte[] block = Entry(archive, "chunks/" + x.blob, x.bytes);
                                using (var sha = SHA256.Create()) Need(BitConverter.ToString(sha.ComputeHash(block)).Replace("-", "").ToLowerInvariant() == x.blob, "Chunk checksum failed.");
                                output.Write(block, 0, block.Length);
                            } else {
                                FileStream input = streams[x.basis]; input.Position = x.offset; int left = x.bytes;
                                while (left > 0) { int n = input.Read(copy, 0, left); Need(n > 0, "Truncated original resource."); output.Write(copy, 0, n); left -= n; }
                            }
                        }
                        output.Flush(true);
                    }
                    Need(new FileInfo(storage).Length == f.storageBytes && Hash(storage) == f.storageSha256, "Storage reconstruction checksum failed.");
                    if (f.bundleRecipe != null) {
                        byte[] recipe = Entry(archive, "recipes/" + f.bundleRecipe, f.bundleRecipeBytes);
                        string recipePath = Child(stage, "__recipe.bin"); File.WriteAllBytes(recipePath, recipe);
                        Need(Hash(recipePath) == f.bundleRecipe, "Bundle recipe checksum failed.");
                        Directory.CreateDirectory(Path.GetDirectoryName(dest));
                        Codec(codec, stage, "pack", Relative(stage, originalBundle), "__target.asset", "__recipe.bin", f.path);
                        File.Delete(recipePath); File.Delete(storage);
                    }
                    Need(Matches(dest, f), "Prepared resource checksum failed: " + f.path);
                }
            } finally { foreach (var stream in streams) stream.Dispose(); }
            File.Delete(originalAsset); Verify(stage, locale.files);
        }
        static bool Matches(string path, Fingerprint f) {
            NoLinks(path);
            return !Directory.Exists(path) && (f.sha256 == null ? !File.Exists(path) : File.Exists(path) && new FileInfo(path).Length == f.bytes && Hash(path) == f.sha256);
        }
        static void CleanupTransaction(string owned, string id) {
            string work = Child(owned, "transactions/" + id);
            // Delete only our closed transaction after verifying it contains no links.
            if (Directory.Exists(work)) {
                foreach (string p in Directory.EnumerateFileSystemEntries(work, "*", SearchOption.AllDirectories)) NoLinks(p);
                Directory.Delete(work, true);
            }
            string journal = Child(owned, "journal.json");
            if (File.Exists(journal)) File.Delete(journal);
        }
        static bool SafeId(string id) { Guid parsed; return id != null && id.Length == 32 && Guid.TryParseExact(id, "N", out parsed); }
        static void Recover(string data, string owned) {
            string path = Child(owned, "journal.json");
            if (!File.Exists(path)) return;
            Journal journal = ReadFile<Journal>(path);
            Need(SafeId(journal.transaction), "Invalid recovery journal.");
            ValidateFiles(journal.before); ValidateFiles(journal.desired);
            var statePath = Child(owned, "state.json");
            State state = File.Exists(statePath) ? ReadFile<State>(statePath) : null;
            if (state != null && state.transaction == journal.transaction) {
                Verify(data, journal.desired); CleanupTransaction(owned, journal.transaction); return;
            }
            string before = Child(owned, "transactions/" + journal.transaction + "/before");
            foreach (var f in journal.before) {
                var desired = journal.desired.Single(x => x.path == f.path);
                string target = Child(data, f.path), backup = Child(before, f.path);
                if (File.Exists(backup)) {
                    Need(Matches(backup, f), "Recovery copy has changed: " + f.path);
                    Need(!File.Exists(target) && !Directory.Exists(target) || Matches(target, desired) || Matches(target, f), "Resource changed during interrupted installation: " + f.path);
                    if (File.Exists(target)) File.Delete(target);
                    Directory.CreateDirectory(Path.GetDirectoryName(target)); File.Move(backup, target);
                } else if (f.sha256 == null) {
                    if (File.Exists(target)) {
                        Need(Matches(target, desired), "Unknown file in interrupted installation: " + f.path);
                        File.Delete(target);
                    }
                    Need(!Directory.Exists(target), "A resource path became a folder.");
                } else Need(Matches(target, f), "Missing recovery copy: " + f.path);
            }
            Verify(data, journal.before); CleanupTransaction(owned, journal.transaction);
        }
        static void GuardGame(string root) {
            NoLinks(root);
            Need(File.Exists(Path.Combine(root, ExeName)), "Choose the folder containing The Forest of Love.exe.");
            NoLinks(Path.Combine(root, ExeName));
            // Never terminate a player process. A matching name is conservatively held.
            foreach (var p in Process.GetProcessesByName("The Forest of Love")) {
                using (p) { Need(p.HasExited, "Close The Forest of Love before changing its language."); }
            }
        }
        public static void Apply(string root, string package, string expectedSha, string code, string codec, string codecSha, Action<string> status) {
            GuardGame(Path.GetFullPath(root)); NoLinks(package); NoLinks(codec);
            Need(IsHash(expectedSha) && File.Exists(package) && Hash(package) == expectedSha, "The language package is missing or damaged. Extract the complete installer again.");
            Need(IsHash(codecSha) && File.Exists(codec) && Hash(codec) == codecSha, "The installer helper is missing or damaged. Extract the complete installer again.");
            string tempRoot = TestTemporaryRoot ?? Path.GetTempPath(); NoLinks(tempRoot);
            string temp = Path.Combine(tempRoot, "VNRevival-Forest-" + Guid.NewGuid().ToString("N"));
            Directory.CreateDirectory(temp);
            string envelope = Child(temp, "payload.forestpack"), decoded = Child(temp, "payload.zip");
            try {
                if (status != null) status("Opening the offline language package…");
                CopyVerified(package, envelope, new Fingerprint { path = "__archive", bytes = new FileInfo(package).Length, sha256 = expectedSha });
                byte[] header = new byte[80];
                using (var stream = File.OpenRead(envelope)) {
                    int read = 0; while (read < header.Length) { int n = stream.Read(header, read, header.Length-read); Need(n > 0, "Truncated language package."); read += n; }
                }
                Need(Encoding.ASCII.GetString(header,0,8) == "FRSTPKG1", "Invalid language package envelope.");
                ulong length = 0; for (int i=8;i<16;++i) length=(length<<8)|header[i];
                string hash = Encoding.ASCII.GetString(header,16,64);
                Need(length>0 && length<2147483647 && IsHash(hash), "Invalid language package header.");
                Codec(Path.GetFullPath(codec), temp, "inflate", "payload.forestpack", "payload.zip");
                Need(new FileInfo(decoded).Length==(long)length && Hash(decoded)==hash, "Decoded package checksum failed.");
                ApplyZip(root, package, expectedSha, code, codec, codecSha, status, decoded);
            } finally {
                // Never recursively erase an unexpected file in an application temp folder.
                try { NoLinks(envelope); NoLinks(decoded); if(File.Exists(envelope))File.Delete(envelope); if(File.Exists(decoded))File.Delete(decoded); Directory.Delete(temp); }
                catch (IOException) { } catch (UnauthorizedAccessException) { }
            }
        }
        static void ApplyZip(string root, string package, string expectedSha, string code, string codec, string codecSha, Action<string> status, string decoded) {
            Need(IsHash(expectedSha), "Invalid package pin.");
            root = Path.GetFullPath(root); package = Path.GetFullPath(package);
            GuardGame(root); NoLinks(package);
            codec = Path.GetFullPath(codec); NoLinks(codec);
            Need(IsHash(codecSha) && File.Exists(codec) && Hash(codec) == codecSha, "The installer helper is missing or damaged. Extract the complete installer again.");
            Need(File.Exists(package) && Hash(package) == expectedSha, "The language package is missing or damaged. Extract the complete installer again.");
            string data = Child(root, DataName);
            string owned = Child(root, ".vnrevival-forest");
            using (var gameLease = new FileStream(Path.Combine(root, ExeName), FileMode.Open, FileAccess.Read, FileShare.None))
            using (var archiveStream = File.OpenRead(decoded)) using (var archive = new ZipArchive(archiveStream, ZipArchiveMode.Read)) {
                Manifest m = LoadManifest(archive);
                Locale locale = code == "en" ? null : m.locales.SingleOrDefault(x => x.code == code);
                Need(code == "en" || locale != null, "Choose a language included in this installer.");
                string identity = Child(data, m.identityPath);
                Need(File.Exists(identity) && Hash(identity) == m.identitySha256, "This installer supports the original Windows game version 0.45 only.");
                string marker = Child(owned, "owner.txt");
                if (Directory.Exists(owned)) Need(File.Exists(marker) && File.ReadAllText(marker) == Owner, "An unknown .vnrevival-forest folder exists. No game files were replaced.");
                else {
                    Verify(data, m.originals); // Unknown manual patches fail before ownership creation.
                    string initialize = owned + "." + Guid.NewGuid().ToString("N") + ".init";
                    Directory.CreateDirectory(initialize);
                    string initialMarker = Child(initialize, "owner.txt");
                    File.WriteAllText(initialMarker, Owner, new UTF8Encoding(false));
                    try { Directory.Move(initialize, owned); }
                    catch (IOException) {
                        Need(Directory.Exists(owned) && File.Exists(marker) && File.ReadAllText(marker) == Owner,
                            "An unknown .vnrevival-forest folder exists. No game files were replaced.");
                    } finally {
                        if (Directory.Exists(initialize)) { File.Delete(initialMarker); Directory.Delete(initialize); }
                    }
                }
                using (var installationLock = new FileStream(Child(owned, "install.lock"), FileMode.OpenOrCreate, FileAccess.ReadWrite, FileShare.None)) {
                    Recover(data, owned);
                    string statePath = Child(owned, "state.json");
                    State old = File.Exists(statePath) ? ReadFile<State>(statePath) : null;
                    if (old != null) Need(old.owner == Owner && old.format == 1 && SafeId(old.transaction), "Invalid installer ownership state.");
                    Fingerprint[] previous = old == null ? m.originals : old.files;
                    Verify(data, previous);
                    // Original backups are permanent and never refreshed from translated resources.
                    string originals = Child(owned, "originals");
                    foreach (var f in m.originals) {
                        string dest = Child(originals, f.path);
                        if (f.sha256 == null) Need(!File.Exists(dest) && !Directory.Exists(dest), "Unexpected original backup.");
                        else if (!File.Exists(dest)) {
                            Need(old == null, "The original backup is missing. No game files were changed.");
                            CopyVerified(Child(data, f.path), dest, f);
                        } else Need(Matches(dest, f), "The original backup has changed. No game files were changed.");
                    }
                    // Persist only fingerprints, not derived recipe objects. Framework's
                    // serializer otherwise requires a game-unrelated KnownType graph.
                    Fingerprint[] desired = (locale == null ? m.originals : locale.files.Cast<Fingerprint>()).Select(
                        x => new Fingerprint { path = x.path, sha256 = x.sha256, bytes = x.bytes }).ToArray();
                    string id = Guid.NewGuid().ToString("N");
                    string work = Child(owned, "transactions/" + id), stage = Child(work, "stage"), before = Child(work, "before");
                    Directory.CreateDirectory(stage);
                    bool journalWritten = false;
                    try {
                        if (status != null) status("Preparing the selected language…");
                        if (locale != null) Materialize(archive, m, locale, originals, stage, codec);
                        else foreach (var f in desired.Where(x => x.sha256 != null)) CopyVerified(Child(originals, f.path), Child(stage, f.path), f);
                        Verify(stage, desired);
                        // Keep the complete offline pack for later switches. Never execute it.
                        string cache = Child(owned, "packages/" + expectedSha + "/ForestLanguages.forestpack");
                        if (!File.Exists(cache)) CopyVerified(package, cache, new Fingerprint { path = "package", bytes = new FileInfo(package).Length, sha256 = expectedSha });
                        else Need(Hash(cache) == expectedSha, "The installed language cache has changed.");
                        GuardGame(root); Verify(data, previous);
                        Atomic(Child(owned, "journal.json"), new Journal { transaction = id, before = previous, desired = desired });
                        journalWritten = true; Tick("journal");
                        int index = 0;
                        foreach (var f in desired) {
                            string target = Child(data, f.path), saved = Child(before, f.path);
                            var prior = previous.Single(x => x.path == f.path);
                            Need(Matches(target, prior), "Resource changed while preparing installation: " + f.path);
                            if (File.Exists(target)) {
                                Directory.CreateDirectory(Path.GetDirectoryName(saved)); File.Move(target, saved);
                            }
                            Tick("moved-" + index);
                            if (f.sha256 != null) {
                                Directory.CreateDirectory(Path.GetDirectoryName(target)); File.Move(Child(stage, f.path), target);
                            }
                            Tick("applied-" + index); index++;
                        }
                        Verify(data, desired); Tick("verified");
                        Atomic(statePath, new State { format = 1, owner = Owner, transaction = id, locale = code,
                            culture = locale == null ? "en" : locale.culture, package = expectedSha, files = desired });
                        Tick("committed");
                        CleanupTransaction(owned, id);
                    } catch {
                        if (journalWritten) Recover(data, owned);
                        else if (Directory.Exists(work)) {
                            foreach (string p in Directory.EnumerateFileSystemEntries(work, "*", SearchOption.AllDirectories)) NoLinks(p);
                            Directory.Delete(work, true);
                        }
                        throw;
                    }
                    if (status != null) status(code == "en" ? "Original English files restored." : "Language installed. You can launch the game.");
                }
            }
        }
    }
}
