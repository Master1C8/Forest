// Read-only complete original game assembly index. Never loads game code.
using Mono.Cecil;
using Mono.Cecil.Cil;
using System.Security.Cryptography;
using System.Text.Json;

if (args.Length < 2 || args.Length > 4 || args.Length == 3 && args[2] != "--ui-bodies" || args.Length == 4 && args[2] != "--db-bindings") throw new ArgumentException("original-Assembly-CSharp.dll new-output-directory [--ui-bodies | --db-bindings decisions.json]");
var input = Path.GetFullPath(args[0]);
var output = Path.GetFullPath(args[1]);
var expected = "46f43b212709b96ac51f2484d1564f863346fed8dc70f532860046226a020acf";
string Hash(string p) => Convert.ToHexString(SHA256.HashData(File.ReadAllBytes(p))).ToLowerInvariant();
if (Hash(input) != expected || Directory.Exists(output)) throw new InvalidOperationException("Wrong original assembly or occupied output");
Directory.CreateDirectory(output);
using var assembly = AssemblyDefinition.ReadAssembly(input);
IEnumerable<TypeDefinition> Types(IEnumerable<TypeDefinition> all) {
    foreach (var t in all) { yield return t; foreach (var n in Types(t.NestedTypes)) yield return n; }
}
var types = Types(assembly.MainModule.Types).ToArray();
var methods = types.SelectMany(t => t.Methods).ToArray();
var options = new JsonSerializerOptions { WriteIndented = false };
if(args.Length==4) {
    using var spec=JsonDocument.Parse(File.ReadAllText(args[3]));
    var columns=spec.RootElement.GetProperty("columns").EnumerateArray().ToArray();
    var selected=new Dictionary<string,MethodDefinition>();
    var binding=new List<object>();
    foreach(var col in columns) {
        string sheet=col.GetProperty("sheet").GetString()!,field=col.GetProperty("field").GetString()!;
        var type=types.Single(t=>t.FullName=="TheForestOfLove.DB."+sheet);
        var getter=type.Methods.Single(m=>m.Name=="get_"+field);
        var meta=type.Methods.Single(m=>m.Name=="get_MetaDefault");
        selected[getter.FullName]=getter;selected[meta.FullName]=meta;
        var storage=type.Methods.SingleOrDefault(m=>m.Name=="get__"+field);
        if(storage!=null)selected[storage.FullName]=storage;
        binding.Add(new {sheet,field,fieldId=col.GetProperty("fieldId").GetString(),getter=getter.FullName,metaGetter=meta.FullName,storageGetter=storage?.FullName});
    }
    using var stream=new StreamWriter(Path.Combine(output,"bodies.jsonl"));
    foreach(var method in selected.Values)stream.WriteLine(JsonSerializer.Serialize(new {method=method.FullName,instructions=method.Body.Instructions.Select((i,n)=>new {index=n,offset=i.Offset,opcode=i.OpCode.Name,operand=i.Operand?.ToString()}).ToArray()},options));
    stream.Close();
    File.WriteAllText(Path.Combine(output,"manifest.json"),JsonSerializer.Serialize(new {sourceSha256=expected,columns=binding,bodyCount=selected.Count,bodiesSha256=Hash(Path.Combine(output,"bodies.jsonl")),specSha256=Hash(args[3]),boundary="Exact29 requested field wrappers and14 owning table getters only; no runtime or framework recursion."},new JsonSerializerOptions {WriteIndented=true}));
    if(Hash(input)!=expected)throw new InvalidOperationException("Source changed");
    Console.WriteLine(JsonSerializer.Serialize(new {columns=binding.Count,bodies=selected.Count}));return;
}
if (args.Length == 3) {
    var selected=methods.Where(m=>m.HasBody && m.Body.Instructions.Any(i=>i.Operand is MethodReference target &&
        ((target.Name is "set_text" or "SetText" or "ShowText") && (target.DeclaringType.Namespace.StartsWith("TMPro") || target.DeclaringType.Namespace.StartsWith("UnityEngine.UI") || target.DeclaringType.Namespace.StartsWith("Febucci"))))).ToArray();
    using var stream=new StreamWriter(Path.Combine(output,"bodies.jsonl"));
    foreach(var method in selected) stream.WriteLine(JsonSerializer.Serialize(new {method=method.FullName,instructions=method.Body.Instructions.Select((i,n)=>new {index=n,offset=i.Offset,opcode=i.OpCode.Name,operand=i.Operand?.ToString()}).ToArray()},options));
    stream.Close();
    File.WriteAllText(Path.Combine(output,"manifest.json"),JsonSerializer.Serialize(new {source=input,sourceSha256=expected,methods=selected.Select(m=>m.FullName).ToArray(),bodiesSha256=Hash(Path.Combine(output,"bodies.jsonl")),boundary="Only complete actual UIText/TMP/Febucci setter-consumer methods; no framework recursion or game execution."},new JsonSerializerOptions {WriteIndented=true}));
    if(Hash(input)!=expected) throw new InvalidOperationException("Source changed");
    Console.WriteLine(JsonSerializer.Serialize(new {uiConsumerMethods=selected.Length}));
    return;
}
using var literals = new StreamWriter(Path.Combine(output,"literals.jsonl"));
using var calls = new StreamWriter(Path.Combine(output,"calls.jsonl"));
using var fields = new StreamWriter(Path.Combine(output,"field-uses.jsonl"));
using var bodies = new StreamWriter(Path.Combine(output,"database-consumer-bodies.jsonl"));
int literalCount=0, callCount=0, fieldCount=0, dbBodies=0;
object Instruction(Instruction i,int index) => new { index, offset=i.Offset, opcode=i.OpCode.Name, operand=i.Operand?.ToString() };
foreach (var method in methods.Where(m => m.HasBody)) {
    var ins = method.Body.Instructions;
    bool db = ins.Any(i => i.Operand is MethodReference m && m.DeclaringType.Namespace == "TheForestOfLove.DB" && method.DeclaringType.Namespace != "TheForestOfLove.DB");
    if (db) {
        bodies.WriteLine(JsonSerializer.Serialize(new { method=method.FullName, instructions=ins.Select((i,n)=>Instruction(i,n)).ToArray() },options));
        dbBodies++;
    }
    for (int n=0;n<ins.Count;n++) {
        var i=ins[n];
        if (i.OpCode == OpCodes.Ldstr) {
            literals.WriteLine(JsonSerializer.Serialize(new { method=method.FullName, type=method.DeclaringType.FullName, offset=i.Offset, index=n, value=(string)i.Operand, before=ins.Take(n).TakeLast(8).Select((x,k)=>Instruction(x,Math.Max(0,n-8)+k)).ToArray(), after=ins.Skip(n+1).Take(12).Select((x,k)=>Instruction(x,n+1+k)).ToArray() },options));
            literalCount++;
        }
        if (i.Operand is MethodReference called) {
            calls.WriteLine(JsonSerializer.Serialize(new { method=method.FullName, offset=i.Offset, index=n, opcode=i.OpCode.Name, called=called.FullName, targetType=called.DeclaringType.FullName },options));
            callCount++;
        }
        if (i.Operand is FieldReference field) {
            fields.WriteLine(JsonSerializer.Serialize(new { method=method.FullName, offset=i.Offset, index=n, opcode=i.OpCode.Name, field=field.FullName, targetType=field.DeclaringType.FullName },options));
            fieldCount++;
        }
    }
}
literals.Close();calls.Close();fields.Close();bodies.Close();
if (Hash(input)!=expected) throw new InvalidOperationException("Original assembly changed during read");
var files=Directory.GetFiles(output).ToDictionary(p=>Path.GetFileName(p)!,p=>new { bytes=new FileInfo(p).Length, sha256=Hash(p) });
File.WriteAllText(Path.Combine(output,"manifest.json"),JsonSerializer.Serialize(new { schemaVersion=1, source=input, sourceSha256=expected, assemblyFullName=assembly.Name.FullName, moduleMvid=assembly.MainModule.Mvid, types=types.Length, methods=methods.Length, managedBodies=methods.Count(m=>m.HasBody), literalCount, callCount, fieldCount, databaseConsumerBodies=dbBodies, files, boundary="Cecil metadata/CIL indexing only; no game execution, translation, source classification or acceptance. Literal windows are navigation, not complete method review." },new JsonSerializerOptions { WriteIndented=true }));
Console.WriteLine(JsonSerializer.Serialize(new { types=types.Length,methods=methods.Length,literalCount,databaseConsumerBodies=dbBodies }));
