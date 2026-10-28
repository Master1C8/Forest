using Mono.Cecil;
using Mono.Cecil.Cil;
using System.Security.Cryptography;
using System.Text.Json;

if(args.Length!=5)throw new Exception("source.dll expectedHash targets.json output.dll receipt.json");
string Hash(byte[] data)=>Convert.ToHexString(SHA256.HashData(data)).ToLowerInvariant();
var sourceHash=Hash(File.ReadAllBytes(args[0]));
if(sourceHash!=args[1] || File.Exists(args[3]) || File.Exists(args[4]))throw new Exception("Input fingerprint/output guard");
using var module=ModuleDefinition.ReadModule(args[0]);
IEnumerable<TypeDefinition> Types(IEnumerable<TypeDefinition> types){foreach(var t in types){yield return t;foreach(var n in Types(t.NestedTypes))yield return n;}}
string Body(MethodDefinition method){
    if(!method.HasBody)return "<none>";
    var list=method.Body.Instructions;
    string Index(Instruction? i)=>i==null?"end":"@"+list.IndexOf(i);
    string Operand(object? value)=>value switch {null=>"",Instruction i=>Index(i),Instruction[] a=>string.Join(",",a.Select(Index)),_=>value.ToString()??""};
    return "locals="+method.Body.InitLocals+":"+string.Join(",",method.Body.Variables.Select(v=>v.VariableType.FullName))+"\n"+
        string.Join("\n",list.Select(i=>i.OpCode+" "+Operand(i.Operand)))+"\n"+
        string.Join("\n",method.Body.ExceptionHandlers.Select(h=>h.HandlerType+" "+h.CatchType+" "+Index(h.TryStart)+" "+Index(h.TryEnd)+" "+Index(h.HandlerStart)+" "+Index(h.HandlerEnd)+" "+Index(h.FilterStart)));
}
var methods=Types(module.Types).SelectMany(t=>t.Methods).ToDictionary(m=>m.FullName);
var before=methods.ToDictionary(p=>p.Key,p=>Body(p.Value));
var name="System.Void TheForestOfLove.InventoryInfoTicker::OnCellSelected(TheForestOfLove.InventoryCellUiController)";
var method=methods[name];
var expectedSources=new Dictionary<int,string>{{0x010c,"SOMETHING?"},{0x0111,"Nope, more nothing."},{0x011d,"Nothin’"},{0x0122,"You’ve got a whole lot of it."}};
var strings=method.Body.Instructions.Where(i=>i.OpCode==OpCodes.Ldstr).ToArray();
if(strings.Length!=4 || !strings.Select(i=>i.Offset).ToHashSet().SetEquals(expectedSources.Keys))throw new Exception("Exact four literal consumers required");
var targets=JsonDocument.Parse(File.ReadAllText(args[2])).RootElement.EnumerateArray().ToDictionary(r=>r.GetProperty("id").GetString()!,r=>r);
var ids=expectedSources.Keys.Select(o=>"il:Assembly-CSharp.dll/"+name+"/IL_"+o.ToString("x4")).ToHashSet();
if(!ids.SetEquals(targets.Keys))throw new Exception("Exact four-ID coverage required");
var restores=new List<(int index,string source)>();
foreach(var instruction in strings){
    var source=expectedSources[instruction.Offset];
    var row=targets["il:Assembly-CSharp.dll/"+name+"/IL_"+instruction.Offset.ToString("x4")];
    if((string)instruction.Operand!=source || row.GetProperty("source").GetString()!=source || row.GetProperty("locale").GetString()!="ru")throw new Exception("Unexpected source/locale");
    var target=row.GetProperty("target").GetString();
    if(string.IsNullOrWhiteSpace(target) || target.Contains('\0'))throw new Exception("Invalid target");
    restores.Add((method.Body.Instructions.IndexOf(instruction),source));instruction.Operand=target;
}
var expected=methods.ToDictionary(p=>p.Key,p=>Body(p.Value));
module.Write(args[3]);
using var readback=ModuleDefinition.ReadModule(args[3]);
var after=Types(readback.Types).SelectMany(t=>t.Methods).ToDictionary(m=>m.FullName);
if(!before.Keys.ToHashSet().SetEquals(after.Keys) || expected.Any(p=>Body(after[p.Key])!=p.Value))throw new Exception("Whole method inventory readback failed");
var changed=before.Keys.Where(k=>before[k]!=Body(after[k])).ToArray();
if(changed.Length!=1 || changed[0]!=name)throw new Exception("Unexpected changed methods");
foreach(var (index,source) in restores)after[name].Body.Instructions[index].Operand=source;
if(before.Any(p=>Body(after[p.Key])!=p.Value))throw new Exception("Unselected instruction/local/branch/handler changed");
var options=new JsonSerializerOptions{WriteIndented=true};
File.WriteAllText(args[4],JsonSerializer.Serialize(new{sourceSha256=sourceHash,targetSha256=Hash(File.ReadAllBytes(args[3])),selectedStrings=4,changedMethods=changed,wholeMethodInventoryReadback=true,allOriginalBodiesRestored=true},options)+"\n");
