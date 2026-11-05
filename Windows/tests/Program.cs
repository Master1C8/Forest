using System.IO.Compression;
using System.Security.Cryptography;
using System.Text;
using System.Text.Json;
using System.Text.Json.Nodes;
using System.Buffers.Binary;
using System.Diagnostics;
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
    static string RendererPackage(string name, byte[] original, byte[] patched, Action<JsonObject> mutate = null) {
        string package = MakePackage(name);
        using var zip = ZipFile.Open(package, ZipArchiveMode.Update);
        var entry = zip.GetEntry("manifest.json"); JsonObject manifest;
        using (var stream = entry.Open()) manifest = JsonNode.Parse(stream).AsObject();
        entry.Delete();
        var originals = manifest["originals"].AsArray();
        originals.Add(JsonSerializer.SerializeToNode(new { path=Installer.RendererPath,bytes=original.Length,sha256=Hash(original) }));
        manifest["baselines"].AsArray().Add(originals.Last().DeepClone());
        var written = zip.Entries.Select(x => x.FullName).ToHashSet();
        foreach (var locale in manifest["locales"].AsArray()) {
            byte[] data = locale["code"].GetValue<string>() == "first" ? patched : original;
            var segments = new List<object>();
            for (int offset=0;offset<data.Length;offset+=65536) {
                byte[] block=data.Skip(offset).Take(65536).ToArray();string key=Hash(block);
                if (written.Add("chunks/"+key)) { using var stream=zip.CreateEntry("chunks/"+key).Open();stream.Write(block); }
                segments.Add(new { @base=-1,offset=0,bytes=block.Length,blob=key });
            }
            locale["files"].AsArray().Add(JsonSerializer.SerializeToNode(new { path=Installer.RendererPath,bytes=data.Length,sha256=Hash(data),storageBytes=data.Length,storageSha256=Hash(data),bundleRecipe=(string)null,bundleRecipeBytes=0,segments }));
        }
        if (mutate != null) mutate(manifest);
        using (var stream=zip.CreateEntry("manifest.json").Open()) stream.Write(JsonSerializer.SerializeToUtf8Bytes(manifest));
        return package;
    }
    static void RendererCases(string patchedPath) {
        byte[] original=File.ReadAllBytes("localization/framework/forest045-shared-v2/references/Unity.TextMeshPro.dll");
        byte[] patched=File.ReadAllBytes(patchedPath);
        Check(original.Length==370176 && Hash(original)==Installer.RendererOriginalSha256,"registered renderer prerequisite");
        Check(Hash(patched)!=Hash(original),"actual patched renderer prerequisite");
        string legacy=MakePackage("renderer-legacy14"),package=RendererPackage("renderer15",original,patched);
        string game=Fixture("renderer-upgrade");Write(PathOf(game,Installer.RendererPath),original);
        Apply(game,legacy,"first");AssertGame(game,"first");
        string statePath=Path.Combine(game,".vnrevival-forest/state.json");
        int OwnedCount()=>JsonNode.Parse(File.ReadAllText(statePath))["files"].AsArray().Count;
        void Module(byte[] expected)=>Check(File.ReadAllBytes(PathOf(game,Installer.RendererPath)).SequenceEqual(expected),"renderer readback differs");
        Check(OwnedCount()==14,"actual legacy ownership shape");
        byte[] foreign=Encoding.UTF8.GetBytes("unowned foreign renderer");Write(PathOf(game,Installer.RendererPath),foreign);
        Reject(()=>Apply(game,package,"first"),"Unexpected or modified resource");Module(foreign);AssertGame(game,"first");
        Check(OwnedCount()==14,"rejected upgrade changed ownership");Write(PathOf(game,Installer.RendererPath),original);
        Installer.TestCheckpoint=p=>{if(p=="applied-14")throw new IOException("injected renderer upgrade failure");};
        try { Reject(()=>Apply(game,package,"first"),"injected renderer upgrade failure"); }
        finally { Installer.TestCheckpoint=null; }
        AssertGame(game,"first");Module(original);Check(OwnedCount()==14,"failed upgrade changed old state");
        Apply(game,package,"first");AssertGame(game,"first");Module(patched);Check(OwnedCount()==15,"renderer upgrade not admitted");
        string backup=Path.Combine(game,".vnrevival-forest/originals",Installer.RendererPath);
        Check(File.ReadAllBytes(backup).SequenceEqual(original),"renderer backup must be original");
        Apply(game,package,"first");Module(patched);Check(File.ReadAllBytes(backup).SequenceEqual(original),"repeat refreshed original from patch");
        Apply(game,package,"second");AssertGame(game,"second");Module(original);
        Apply(game,package,"first");Module(patched);
        CrashChild(game,package,"applied-14");
        Check(File.Exists(Path.Combine(game,".vnrevival-forest/journal.json")),"renderer crash journal absent");
        Apply(game,package,"en");AssertGame(game,"original");Module(original);
        Reject(()=>Apply(game,legacy,"first"),"cannot be downgraded");AssertGame(game,"original");Module(original);
        string missing=RendererPackage("renderer-missing-locale",original,patched,m=>m["locales"][0]["files"].AsArray().RemoveAt(14));
        Reject(()=>Apply(game,missing,"first"),"Locale resource inventory differs");
        string wrong=RendererPackage("renderer-wrong-original",original,patched,m=>m["originals"][14]["sha256"]=new string('0',64));
        Reject(()=>Apply(game,wrong,"first"),"Unregistered original TMP renderer");
        AssertGame(game,"original");Module(original);
        File.WriteAllText(Path.Combine(Root,"renderer-result.json"),JsonSerializer.Serialize(new {passed=true,assertions,realRendererBytes=true,otherResources="synthetic",legacy14Upgrade=true,complexToNormalToEnglish=true,interruptedUpgradeRollback=true,hardCrashAtRendererRecovered=true,foreignRendererPreserved=true,gameLaunched=false}));
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
        string game = Path.Combine(Root, "real-compiler-payload");
        Check(!Directory.Exists(game),"Preserve previous actual payload test game");Directory.CreateDirectory(game);
        Write(Path.Combine(game, Installer.ExeName), Content("fixture exe, never run", 0));
        // Inspect the exact delivered envelope, rather than an unrelated raw
        // archive left in the default build directory.
        string decoded=Path.Combine(Root,"actual-package.zip");Check(!File.Exists(decoded),"Preserve previous decoded actual package");
        using(var inflate=Process.Start(new ProcessStartInfo {FileName=Codec,ArgumentList={"inflate",package,decoded},UseShellExecute=false})) {
            Check(inflate!=null,"actual package inflate started");
            if(!inflate.WaitForExit(180000)){inflate.Kill(entireProcessTree:true);inflate.WaitForExit();throw new Exception("actual package inflate deadline; owned child stopped, partial output preserved");}
            Check(inflate.ExitCode==0,"actual package inflate failed");
        }
        using(var input=File.OpenRead(package)) {
            byte[] header=new byte[80];input.ReadExactly(header);
            Check(Encoding.ASCII.GetString(header,0,8)=="FRSTPKG1","actual envelope identity");
            Check((ulong)new FileInfo(decoded).Length==BinaryPrimitives.ReadUInt64BigEndian(header.AsSpan(8,8))&&Installer.Hash(decoded)==Encoding.ASCII.GetString(header,16,64),"actual decoded archive binding");
        }
        using var zip = ZipFile.OpenRead(decoded);
        var manifestReader=typeof(Installer).GetMethod("LoadManifest",System.Reflection.BindingFlags.Static|System.Reflection.BindingFlags.NonPublic);
        Check(manifestReader!=null,"shipping manifest reader exists");
        try{manifestReader.Invoke(null,new object[]{zip});}catch(System.Reflection.TargetInvocationException e){throw e.InnerException??e;}
        using var manifestStream = zip.GetEntry("manifest.json").Open();
        using var manifest = JsonDocument.Parse(manifestStream);
        string data = Path.Combine(original, Installer.DataName);
        foreach (var f in manifest.RootElement.GetProperty("originals").EnumerateArray()) {
            string name = f.GetProperty("path").GetString();
            if (f.GetProperty("sha256").ValueKind != JsonValueKind.Null) {
                string source=Path.Combine(data,name);
                if(name==Installer.RendererPath&&!File.Exists(source))source=Path.GetFullPath("localization/framework/forest045-shared-v2/references/Unity.TextMeshPro.dll");
                byte[] bytes=File.ReadAllBytes(source);Check(bytes.Length==f.GetProperty("bytes").GetInt64()&&Hash(bytes)==f.GetProperty("sha256").GetString(),"actual original input binding: "+name);
                Write(PathOf(game,name),bytes);
            }
        }
        Write(PathOf(game, "globalgamemanagers.assets"), File.ReadAllBytes(Path.Combine(data, "globalgamemanagers.assets")));
        byte[] identity = Content("preserved identity", 0), settings = Content("preserved settings", 0), save = Content("personal player save", 0);
        Write(PathOf(game, "app.info"), identity); Write(PathOf(game, "tfol.settings"), settings);
        Write(PathOf(game, "tfol.savegame"), save);
        // Each actual compiler recipe runs through the shipping C# materializer and
        // transaction, then a fresh invocation checks the persisted previous version.
        string[] targetCodes = (Environment.GetEnvironmentVariable("FOREST_TEST_LOCALES") ?? "hi,sw,uk,ru").Split(',');
        Check(targetCodes.Length > 0 && targetCodes.Distinct().Count() == targetCodes.Length, "invalid actual test locale selection");
        if(targetCodes.SequenceEqual(new[]{"*"}))targetCodes=manifest.RootElement.GetProperty("locales").EnumerateArray().Select(x=>x.GetProperty("code").GetString()).ToArray();
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
        Installer.TestTemporaryRoot=Path.GetFullPath(Environment.GetEnvironmentVariable("FOREST_TEST_TEMPORARY_ROOT")??"dist/windows-installer-work/core-temp");
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
        if (args.Length == 3 && args[0] == "renderer") {
            Root=Path.GetFullPath(args[1]);Directory.CreateDirectory(Root);RendererCases(Path.GetFullPath(args[2]));
            Console.WriteLine("PASS renderer contract: "+assertions+" assertions; real DLL bytes, isolated synthetic game, no game executed");return 0;
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
