using System.IO.Compression;
using System.Security.Cryptography;
using System.Text;
using System.Text.Json;
using System.Text.Json.Nodes;
using System.Buffers.Binary;
using VNRevival.Forest;

class Program {
    static readonly string[] Names = {
        "Managed/Assembly-CSharp.dll", "Managed/VNRevivalInventoryLayout.dll", "Managed/VNRevivalQuestLayout.dll",
        "StreamingAssets/aa/StandaloneWindows64/defaultlocalgroup_assets_all_298c5a4d1d1846b1a8d2c7d5da3f319c.bundle",
        "StreamingAssets/aa/catalog.json", "level1", "level5", "level6", "resources.assets",
        "sharedassets0.assets", "sharedassets1.assets", "sharedassets15.assets", "sharedassets2.assets", "sharedassets4.assets"
    };
    static string Root;
    static string Codec;
    static string CodecSha;
    static int assertions;
    static string Hash(byte[] b) { return Convert.ToHexString(SHA256.HashData(b)).ToLowerInvariant(); }
    static void Check(bool value, string reason) { ++assertions; if (!value) throw new Exception(reason); }
    static void Reject(Action action, string message) {
        try { action(); } catch (Exception e) {
            Check(e.GetBaseException().Message.Contains(message), "wrong rejection: " + e);
            return;
        }
        throw new Exception("Expected rejection: " + message);
    }
    static string PathOf(string root, string name) { return Path.Combine(root, Installer.DataName, name); }
    static void Write(string path, byte[] bytes) { Directory.CreateDirectory(Path.GetDirectoryName(path)); File.WriteAllBytes(path, bytes); }
    static byte[] Cab(string prefix, int i) { return Encoding.UTF8.GetBytes(prefix + " resource " + i + " 日本語 عربي"); }
    static byte[] Content(string prefix, int i) {
        if (i == 3) return TinyBundle(Cab(prefix, i)).bundle;
        return Cab(i == 8 ? "unchanged positive control" : prefix, i);
    }
    static (byte[] bundle, byte[] recipe) TinyBundle(byte[] asset) {
        byte[] stream = Encoding.UTF8.GetBytes("unchanged stream data — never translated or overwritten");
        void Number(Stream target, ulong value, int bytes) {
            for (int n=bytes-1;n>=0;--n) target.WriteByte((byte)(value >> (n*8)));
        }
        void Text(Stream target, string value) { target.Write(Encoding.ASCII.GetBytes(value)); target.WriteByte(0); }
        using var info = new MemoryStream(); info.Write(new byte[16]); Number(info,1,4);
        ulong count = (ulong)(asset.Length+stream.Length);
        Number(info,count,4); Number(info,count,4); Number(info,0,2); Number(info,2,4);
        Number(info,0,8); Number(info,(ulong)asset.Length,8); Number(info,4,4); Text(info,"CAB-fixture");
        Number(info,(ulong)asset.Length,8); Number(info,(ulong)stream.Length,8); Number(info,0,4); Text(info,"CAB-fixture.resS");
        byte[] suffix = info.ToArray();
        using var header = new MemoryStream();Text(header,"UnityFS");Number(header,7,4);Text(header,"5.x.x");Text(header,"2020.3.24f1");
        Number(header,64+count+(ulong)suffix.Length,8);Number(header,(ulong)suffix.Length,4);Number(header,(ulong)suffix.Length,4);Number(header,192,4);
        while(header.Length<64)header.WriteByte(0); byte[] prefix=header.ToArray();
        using var bundle = new MemoryStream();bundle.Write(prefix);bundle.Write(asset);bundle.Write(stream);bundle.Write(suffix);
        using var recipe = new MemoryStream();recipe.Write(Encoding.ASCII.GetBytes("FRSTBND1"));
        Number(recipe,(ulong)prefix.Length,4);Number(recipe,(ulong)suffix.Length,4);Number(recipe,1,4);Number(recipe,(ulong)asset.Length,8);recipe.Write(prefix);
        Number(recipe,count,4);Number(recipe,count,4);Number(recipe,0,2);Number(recipe,0,1);recipe.Write(suffix);
        return (bundle.ToArray(),recipe.ToArray());
    }
    static bool NewFile(int i) { return i == 1 || i == 2; }
    static object Pin(string prefix, int i) {
        byte[] data = Content(prefix, i);
        return new { path = Names[i], sha256 = prefix == "original" && NewFile(i) ? null : Hash(data), bytes = prefix == "original" && NewFile(i) ? 0 : data.Length };
    }
    static object Recipe(string prefix, int i, Dictionary<string, byte[]> chunks, Dictionary<string, byte[]> recipes) {
        byte[] storage = i == 3 ? Cab(prefix,i) : Content(prefix,i); string blob = Hash(storage);chunks[blob]=storage;
        byte[] recipe = i == 3 ? TinyBundle(storage).recipe : null;
        string key = recipe == null ? null : Hash(recipe); if(recipe!=null)recipes[key]=recipe;
        object segment = i == 8 ? new { @base=6,offset=0,bytes=storage.Length,blob=(string)null } :
            new { @base=-1,offset=0,bytes=storage.Length,blob };
        return new { path=Names[i],sha256=Hash(Content(prefix,i)),bytes=Content(prefix,i).Length,
            storageBytes=storage.Length,storageSha256=blob,bundleRecipe=key,bundleRecipeBytes=recipe==null?0:recipe.Length,segments=new [] { segment } };
    }
    static string Fixture(string name) {
        string game = Path.Combine(Root, name);
        Directory.CreateDirectory(game);
        Write(Path.Combine(game, Installer.ExeName), Content("executable", 0));
        Write(PathOf(game, "globalgamemanagers.assets"), Content("identity", 0));
        for (int i = 0; i < Names.Length; ++i) if (!NewFile(i)) Write(PathOf(game, Names[i]), Content("original", i));
        Write(PathOf(game, "app.info"), Content("owner identity", 0));
        Write(PathOf(game, "tfol.settings"), Content("owner settings", 0));
        Write(PathOf(game, "other-mod.dll"), Content("unrelated mod", 0));
        Write(Path.Combine(game, "saves/player.sav"), Content("save", 0));
        return game;
    }
    static string MakePackage(string name, Action<JsonObject> mutate = null) {
        string package = Path.Combine(Root, name + ".zip");
        var chunks = new Dictionary<string, byte[]>(); var recipes = new Dictionary<string, byte[]>();
        object[] baseline = Enumerable.Range(0,Names.Length).Where(i=>!NewFile(i)).Select(i=>Pin("original",i)).Concat(new [] {
            (object)new { path="__bundle.asset",sha256=Hash(Cab("original",3)),bytes=Cab("original",3).Length }
        }).ToArray();
        var manifest = new Dictionary<string, object> {
            ["format"] = 3, ["gameVersion"] = "0.45", ["dataDirectory"] = Installer.DataName,
            ["identityPath"] = "globalgamemanagers.assets", ["identitySha256"] = Hash(Content("identity", 0)),
            ["originals"] = Enumerable.Range(0, Names.Length).Select(i => Pin("original", i)).ToArray(),
            ["baselines"] = baseline,
            ["locales"] = new [] { "first", "second" }.Select(code => new {
                code, name = code, culture = code, languageSha256 = Hash(Content(code, 0)),
                files = Enumerable.Range(0, Names.Length).Select(i => Recipe(code, i, chunks, recipes)).ToArray()
            }).ToArray()
        };
        var document = JsonSerializer.SerializeToNode(manifest).AsObject();
        if (mutate != null) mutate(document);
        using (var z = ZipFile.Open(package, ZipArchiveMode.Create)) {
            void Entry(string path, byte[] data) { using var s = z.CreateEntry(path).Open(); s.Write(data); }
            Entry("manifest.json", JsonSerializer.SerializeToUtf8Bytes(document));
            foreach (var chunk in chunks) Entry("chunks/" + chunk.Key, chunk.Value);
            foreach (var recipe in recipes) Entry("recipes/" + recipe.Key, recipe.Value);
        }
        return package;
    }
    static string Wrap(string package) {
        if (!package.EndsWith(".zip", StringComparison.Ordinal)) return package;
        string packed = package + ".forestpack";
        if (!File.Exists(packed)) {
            using var p = System.Diagnostics.Process.Start(new System.Diagnostics.ProcessStartInfo {
                FileName = "python3", ArgumentList = { "-B", "tools/forest_payload.py", package, packed },
                UseShellExecute = false, RedirectStandardOutput = true
            });
            p.StandardOutput.ReadToEnd(); p.WaitForExit(); Check(p.ExitCode == 0, "fixture payload wrapping failed");
        }
        return packed;
    }
    static void Apply(string game, string package, string code) {
        package=Wrap(package); Installer.Apply(game, package, Installer.Hash(package), code, Codec, CodecSha, null);
    }
    static void AssertGame(string game, string prefix) {
        for (int i = 0; i < Names.Length; ++i) {
            string p = PathOf(game, Names[i]);
            if (prefix == "original" && NewFile(i)) Check(!File.Exists(p), "owned added DLL survived restore");
            else Check(File.ReadAllBytes(p).SequenceEqual(Content(prefix, i)), "wrong resource " + p);
        }
        foreach (var pair in new [] { ("app.info", "owner identity"), ("tfol.settings", "owner settings"), ("other-mod.dll", "unrelated mod") })
            Check(File.ReadAllBytes(PathOf(game, pair.Item1)).SequenceEqual(Content(pair.Item2, 0)), "player file overwritten");
        Check(File.ReadAllBytes(Path.Combine(game, "saves/player.sav")).SequenceEqual(Content("save", 0)), "save overwritten");
    }
    static void CrashChild(string game, string package, string checkpoint) {
        using var p = System.Diagnostics.Process.Start(new System.Diagnostics.ProcessStartInfo {
            FileName = "dotnet",
            ArgumentList = { typeof(Program).Assembly.Location, "crash", game, package, checkpoint },
            UseShellExecute = false
        });
        p.WaitForExit(); Check(p.ExitCode == 77, "child did not reach crash boundary " + checkpoint);
    }
    static void RealPackage(string package, string original) {
        string game = Path.Combine(Root, "real-compiler-payload"); Directory.CreateDirectory(game);
        Write(Path.Combine(game, Installer.ExeName), Content("fixture exe, never run", 0));
        using var zip = ZipFile.OpenRead("dist/windows-installer-work/ForestLanguages.zip");
        using var manifestStream = zip.GetEntry("manifest.json").Open();
        using var manifest = JsonDocument.Parse(manifestStream);
        string data = Path.Combine(original, Installer.DataName);
        foreach (var f in manifest.RootElement.GetProperty("originals").EnumerateArray()) {
            string name = f.GetProperty("path").GetString();
            if (f.GetProperty("sha256").ValueKind != JsonValueKind.Null) Write(PathOf(game, name), File.ReadAllBytes(Path.Combine(data, name)));
        }
        Write(PathOf(game, "globalgamemanagers.assets"), File.ReadAllBytes(Path.Combine(data, "globalgamemanagers.assets")));
        byte[] identity = Content("preserved identity", 0), settings = Content("preserved settings", 0), save = Content("personal player save", 0);
        Write(PathOf(game, "app.info"), identity); Write(PathOf(game, "tfol.settings"), settings);
        Write(PathOf(game, "tfol.savegame"), save);
        // Each actual compiler recipe runs through the shipping C# materializer and
        // transaction, then a fresh invocation checks the persisted previous version.
        string[] targetCodes = (Environment.GetEnvironmentVariable("FOREST_TEST_LOCALES") ?? "hi,sw,uk,ru").Split(',');
        Check(targetCodes.Length > 0 && targetCodes.Distinct().Count() == targetCodes.Length, "invalid actual test locale selection");
        var targetLocales = manifest.RootElement.GetProperty("locales").EnumerateArray().Where(x => targetCodes.Contains(x.GetProperty("code").GetString())).ToArray();
        Check(targetLocales.Length == targetCodes.Length, "actual test locale selection is incomplete");
        int count = 0;
        foreach (var locale in targetLocales) {
            string code = locale.GetProperty("code").GetString();
            Apply(game, package, code);
            foreach (var f in locale.GetProperty("files").EnumerateArray())
                Check(Installer.Hash(PathOf(game, f.GetProperty("path").GetString())) == f.GetProperty("sha256").GetString(), "real compiler payload differs");
            Check(File.ReadAllBytes(PathOf(game, "app.info")).SequenceEqual(identity), "actual payload changed identity");
            Check(File.ReadAllBytes(PathOf(game, "tfol.settings")).SequenceEqual(settings), "actual payload changed settings");
            Check(File.ReadAllBytes(PathOf(game, "tfol.savegame")).SequenceEqual(save), "actual payload changed personal save");
            Console.WriteLine("actual payload passed: " + code); count++;
        }
        Apply(game, package, "en");
        Check(File.ReadAllBytes(PathOf(game, "tfol.savegame")).SequenceEqual(save), "English restore changed personal save");
        foreach (var f in manifest.RootElement.GetProperty("originals").EnumerateArray()) {
            string name = f.GetProperty("path").GetString();
            Check(f.GetProperty("sha256").ValueKind == JsonValueKind.Null ? !File.Exists(PathOf(game, name)) :
                  Installer.Hash(PathOf(game, name)) == f.GetProperty("sha256").GetString(), "real original restore mismatch");
        }
        Console.WriteLine("Representative real compiler locales installed/switched/restored: " + count);
    }
    static int Main(string[] args) {
        Installer.TestTemporaryRoot=Path.GetFullPath("dist/windows-installer-work/core-temp");
        Directory.CreateDirectory(Installer.TestTemporaryRoot);
        Codec = Path.GetFullPath(Environment.GetEnvironmentVariable("FOREST_TEST_CODEC") ?? "dist/windows-installer-work/forest-bundle"); CodecSha = Installer.Hash(Codec);
        if (args.Length == 2 && args[0] == "manifest") {
            using var archive = ZipFile.OpenRead(args[1]);
            var reader = typeof(Installer).GetMethod("LoadManifest", System.Reflection.BindingFlags.Static | System.Reflection.BindingFlags.NonPublic);
            if (reader == null) throw new Exception("Shipping manifest reader is unavailable");
            try { reader.Invoke(null, new object[] { archive }); }
            catch (System.Reflection.TargetInvocationException e) { throw e.InnerException ?? e; }
            Console.WriteLine("PASS shipping manifest reader: all locale/resource recipes accepted; no install"); return 0;
        }
        if (args.Length > 0 && args[0] == "actual") {
            Root=Path.GetFullPath(args[1]); Directory.CreateDirectory(Root);
            RealPackage(Path.GetFullPath(args[2]),Path.GetFullPath(args[3]));
            Console.WriteLine("PASS actual payload: " + assertions + " assertions. No real game executed."); return 0;
        }
        if (args.Length > 0 && args[0] == "apply") { Apply(args[1], args[2], args[3]); return 0; }
        if (args.Length > 0 && args[0] == "crash") {
            Installer.TestCheckpoint = checkpoint => { if (checkpoint == args[3]) Environment.Exit(77); };
            Apply(args[1], args[2], "second"); return 3;
        }
        Root = Path.GetFullPath(args.Length > 0 ? args[0] : "dist/windows-installer-work/tests");
        Directory.CreateDirectory(Root);
        try {
            string package = MakePackage("valid");
            string game = Fixture("switch");
            Apply(game, package, "first"); AssertGame(game, "first");
            string unicode = Fixture("ゲーム путь"); Apply(unicode, package, "first"); AssertGame(unicode, "first");
            Apply(game, package, "second"); AssertGame(game, "second");
            using (var fresh = System.Diagnostics.Process.Start(new System.Diagnostics.ProcessStartInfo {
                FileName = "dotnet", ArgumentList = { typeof(Program).Assembly.Location, "apply", game, package, "first" }, UseShellExecute = false
            })) { fresh.WaitForExit(); Check(fresh.ExitCode == 0, "fresh-process language switch failed"); }
            AssertGame(game, "first");
            using (var state = JsonDocument.Parse(File.ReadAllBytes(Path.Combine(game, ".vnrevival-forest/state.json"))))
                Check(state.RootElement.GetProperty("locale").GetString() == "first", "selection did not persist");
            Apply(game, package, "second"); AssertGame(game, "second");
            Apply(game, package, "second"); AssertGame(game, "second"); // verified repeat after first postcondition
            Apply(game, package, "en"); AssertGame(game, "original");
            Apply(game, package, "en"); AssertGame(game, "original");
            string invalidPath = MakePackage("invalid-path", m => m["originals"][0]["path"] = "../escape");
            Reject(() => Apply(game, invalidPath, "first"), "Unknown resource path"); AssertGame(game, "original");
            string duplicate = MakePackage("duplicate-path", m => m["originals"][1]["path"] = Names[0]);
            Reject(() => Apply(game, duplicate, "first"), "Duplicate resource path");
            string recipe = MakePackage("invalid-recipe", m => {
                m["locales"][0]["files"][0]["segments"][0]["blob"] = null;
            });
            Reject(() => Apply(game, recipe, "first"), "Invalid segment source");
            // A valid pin over damaged content still fails the reconstructed target.
            string badChunk = MakePackage("bad-chunk");
            using (var z = ZipFile.Open(badChunk, ZipArchiveMode.Update)) {
                using var doc = JsonDocument.Parse(z.GetEntry("manifest.json").Open());
                string entry = "chunks/" + doc.RootElement.GetProperty("locales")[0].GetProperty("files")[0].GetProperty("segments")[0].GetProperty("blob").GetString();
                int size = (int)z.GetEntry(entry).Length;
                z.GetEntry(entry).Delete();
                using var stream = z.CreateEntry(entry).Open();
                stream.Write(Enumerable.Repeat((byte)0, size).ToArray());
            }
            Reject(() => Apply(game, badChunk, "first"), "Chunk checksum failed"); AssertGame(game, "original");
            Reject(() => Installer.Apply(game, Wrap(package), new string('0', 64), "first", Codec, CodecSha, null), "missing or damaged");
            Reject(() => Apply(game, package, "unknown"), "Choose a language");
            string modified = Fixture("unknown-mod");
            Write(PathOf(modified, Names[0]), Content("foreign patch", 0));
            Reject(() => Apply(modified, package, "first"), "Unexpected or modified");
            Check(!Directory.Exists(Path.Combine(modified, ".vnrevival-forest")), "claimed a foreign game");
            string collision = Fixture("added-dll-collision"); Write(PathOf(collision, Names[1]), Content("foreign DLL", 1));
            Reject(() => Apply(collision, package, "first"), "Unexpected or modified");
            string owner = Fixture("foreign-owned-folder"); Directory.CreateDirectory(Path.Combine(owner, ".vnrevival-forest"));
            Reject(() => Apply(owner, package, "first"), "unknown .vnrevival-forest");
            string wrongVersion = Fixture("wrong-version"); Write(PathOf(wrongVersion, "globalgamemanagers.assets"), Content("other game version", 0));
            Reject(() => Apply(wrongVersion, package, "first"), "version 0.45 only");
            string lockedGame=Fixture("game-executable-in-use");
            using(var lease=new FileStream(Path.Combine(lockedGame,Installer.ExeName),FileMode.Open,FileAccess.Read,FileShare.None))
                Reject(() => Apply(lockedGame,package,"first"),"being used by another process");
            AssertGame(lockedGame,"original");
            string linked = Fixture("linked"); string away = Path.Combine(Root, "outside"); Directory.Move(PathOf(linked, "Managed"), away);
            Directory.CreateSymbolicLink(PathOf(linked, "Managed"), away);
            Reject(() => Apply(linked, package, "first"), "Linked folders");
            string concurrent = Fixture("concurrent"); Apply(concurrent, package, "first");
            using (var locked = new FileStream(Path.Combine(concurrent, ".vnrevival-forest/install.lock"), FileMode.Open, FileAccess.ReadWrite, FileShare.None))
                Reject(() => Apply(concurrent, package, "second"), "being used by another process");
            AssertGame(concurrent, "first");
            string corruptBackup = Fixture("corrupt-backup"); Apply(corruptBackup, package, "first");
            Write(Path.Combine(corruptBackup, ".vnrevival-forest/originals", Names[0]), Content("bad backup", 0));
            Reject(() => Apply(corruptBackup, package, "en"), "original backup has changed"); AssertGame(corruptBackup, "first");
            // Every actual replacement boundary, plus pre-write and post-commit.
            var checkpoints = new List<string> { "journal", "verified", "state-ready", "committed" };
            for (int i = 0; i < Names.Length; ++i) { checkpoints.Add("moved-" + i); checkpoints.Add("applied-" + i); }
            foreach (string checkpoint in checkpoints) {
                string crash = Fixture("crash-" + checkpoint); Apply(crash, package, "first");
                CrashChild(crash, package, checkpoint);
                Check(File.Exists(Path.Combine(crash, ".vnrevival-forest/journal.json")), "crash evidence missing");
                Apply(crash, package, "en"); AssertGame(crash, "original");
                Check(!File.Exists(Path.Combine(crash, ".vnrevival-forest/journal.json")), "recovery left an open transaction");
            }
            // Normal exceptions exercise the in-process rollback path.
            string rollback = Fixture("rollback"); Apply(rollback, package, "first");
            Installer.TestCheckpoint = p => { if (p == "applied-5") throw new IOException("injected write failure"); };
            Reject(() => Apply(rollback, package, "second"), "injected write failure");
            Installer.TestCheckpoint = null; AssertGame(rollback, "first");
            foreach (var checkpoint in new [] { "copy-ready-" + Names[0], "copy-ready-package" }) {
                string first = Fixture("first-install-crash-" + (checkpoint.EndsWith("package") ? "cache" : "original"));
                CrashChild(first, package, checkpoint);
                AssertGame(first, "original");
                Apply(first, package, "first"); AssertGame(first, "first");
                Apply(first, package, "en"); AssertGame(first, "original");
            }
            string conflict = Fixture("interrupted-external-edit"); Apply(conflict, package, "first");
            CrashChild(conflict, package, "applied-5");
            Write(PathOf(conflict, Names[5]), Content("external edit during crash", 5));
            Reject(() => Apply(conflict, package, "en"), "Resource changed during interrupted installation");
            Check(File.ReadAllBytes(PathOf(conflict, Names[5])).SequenceEqual(Content("external edit during crash", 5)), "recovery overwrote an external edit");
            Check(File.Exists(Path.Combine(conflict, ".vnrevival-forest/journal.json")), "lost conflicted recovery journal");
            Write(PathOf(conflict, Names[5]), Content("second", 5));
            Apply(conflict, package, "en"); AssertGame(conflict, "original");
            if (args.Length == 3) RealPackage(Path.GetFullPath(args[1]), Path.GetFullPath(args[2]));
            Console.WriteLine("PASS: " + assertions + " assertions; core transaction and recovery tested. Windows UI/PowerShell/game runtime not exercised.");
            return 0;
        } catch (Exception e) { Console.Error.WriteLine(e); return 1; }
    }
}
