using Mono.Cecil;
using Mono.Cecil.Cil;
using System.Security.Cryptography;
if(args.Length!=3)throw new Exception("source Managed, bridge DLL, new patched assembly path");
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
module.Write(args[2]);
using var readback=ModuleDefinition.ReadModule(args[2]);
var current=Types(readback.Types).SelectMany(t=>t.Methods).ToDictionary(m=>m.FullName,Body);
if(!originals.Keys.Order().SequenceEqual(current.Keys.Order()))throw new Exception("Method inventory changed");
var changed=originals.Keys.Where(k=>originals[k]!=current[k]).ToArray();
if(changed.Length!=1 || changed[0]!=method.FullName)throw new Exception("Unexpected method changes");
Console.WriteLine("Probe hook readback verified; only MainMenuController.Start changed, all other methods bytecode-equivalent.");
