using Mono.Cecil;
using Mono.Cecil.Cil;
using System.Security.Cryptography;
if(args.Length!=3 && !(args.Length==4 && args[3]=="--inventory-sample"))throw new Exception("source Managed, bridge DLL, new patched assembly path [--inventory-sample]");
var dir=Path.GetFullPath(args[0]);
var source=Path.Combine(dir,"Assembly-CSharp.dll");
if(Convert.ToHexString(SHA256.HashData(File.ReadAllBytes(source))).ToLowerInvariant()!="46f43b212709b96ac51f2484d1564f863346fed8dc70f532860046226a020acf")throw new Exception("Wrong game build");
if(File.Exists(args[2]))throw new Exception("Output exists");
using var module=ModuleDefinition.ReadModule(source);
using var bridge=ModuleDefinition.ReadModule(args[1]);
string Body(MethodDefinition method) {
    if(!method.HasBody)return "<none>";
    var instructions=method.Body.Instructions;
    string Operand(object? value)=>value switch {
        null=>"",Instruction i=>"@"+instructions.IndexOf(i),
        Instruction[] list=>string.Join(",",list.Select(i=>"@"+instructions.IndexOf(i))),_=>value.ToString()??""
    };
    return string.Join("\n",instructions.Select(i=>i.OpCode+" "+Operand(i.Operand)));
}
IEnumerable<TypeDefinition> Types(IEnumerable<TypeDefinition> types) {
    foreach(var type in types){yield return type;foreach(var nested in Types(type.NestedTypes))yield return nested;}
}
var originals=Types(module.Types).SelectMany(t=>t.Methods).ToDictionary(m=>m.FullName,Body);
var method=module.GetType("TheForestOfLove.MainMenuController").Methods.Single(x=>x.Name=="Start");
var call=Instruction.Create(OpCodes.Call,module.ImportReference(bridge.GetType("ForestProbe").Methods.Single(x=>x.Name=="Install")));
method.Body.GetILProcessor().InsertBefore(method.Body.Instructions[0],call);
var intended=new HashSet<string>{method.FullName};
if(args.Length==4) {
    // Synthetic empty-cell path only. Keep branch operands, item identities,
    // quantities and all non-display literals bytecode-equivalent.
    var ticker=module.GetType("TheForestOfLove.InventoryInfoTicker").Methods.Single(x=>x.Name=="OnCellSelected");
    var samples=new Dictionary<string,string>{
        ["Nothin’"]="Ёж Йй 123 — Latin!",
        ["You’ve got a whole lot of it."]="Е\u0308 и\u0306; Ё й. Щъ Ыь Эю Яя; 123 — Latin!"
    };
    foreach(var pair in samples) {
        var matches=ticker.Body.Instructions.Where(i=>i.OpCode==OpCodes.Ldstr && (string)i.Operand==pair.Key).ToArray();
        if(matches.Length!=1)throw new Exception("Synthetic inventory source literal missing or ambiguous: "+pair.Key);
        matches[0].Operand=pair.Value;
    }
    intended.Add(ticker.FullName);
}
var expected=Types(module.Types).SelectMany(t=>t.Methods).ToDictionary(m=>m.FullName,Body);
module.Write(args[2]);
using var readback=ModuleDefinition.ReadModule(args[2]);
var current=Types(readback.Types).SelectMany(t=>t.Methods).ToDictionary(m=>m.FullName,Body);
if(!originals.Keys.Order().SequenceEqual(current.Keys.Order()))throw new Exception("Method inventory changed");
var changed=originals.Keys.Where(k=>originals[k]!=current[k]).ToArray();
if(!intended.SetEquals(changed) || expected.Any(pair=>current[pair.Key]!=pair.Value))throw new Exception("Unexpected method/instruction changes");
Console.WriteLine("Exact probe readback verified; changed methods: "+string.Join(", ",changed)+"; all other methods bytecode-equivalent.");
