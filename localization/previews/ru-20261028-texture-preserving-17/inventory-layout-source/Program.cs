using Mono.Cecil;
using Mono.Cecil.Cil;
using System.Security.Cryptography;
using System.Text.Json;

if(args.Length!=5)throw new Exception("source.dll expectedHash helper.dll output.dll receipt.json");
string Hash(byte[] data)=>Convert.ToHexString(SHA256.HashData(data)).ToLowerInvariant();
var sourceHash=Hash(File.ReadAllBytes(args[0]));
if(sourceHash!=args[1]||File.Exists(args[3])||File.Exists(args[4]))throw new Exception("Input/output guard");
using var module=ModuleDefinition.ReadModule(args[0]);using var helper=ModuleDefinition.ReadModule(args[2]);
IEnumerable<TypeDefinition> Types(IEnumerable<TypeDefinition> types){foreach(var t in types){yield return t;foreach(var n in Types(t.NestedTypes))yield return n;}}
string Body(MethodDefinition m){
    if(!m.HasBody)return "<none>";var list=m.Body.Instructions;
    string Index(Instruction? i)=>i==null?"end":"@"+list.IndexOf(i);
    string Operand(object? o)=>o switch{null=>"",Instruction i=>Index(i),Instruction[] a=>string.Join(",",a.Select(Index)),_=>o.ToString()??""};
    return "locals="+m.Body.InitLocals+":"+string.Join(",",m.Body.Variables.Select(v=>v.VariableType.FullName))+"\n"+string.Join("\n",list.Select(i=>i.OpCode+" "+Operand(i.Operand)))+"\n"+string.Join("\n",m.Body.ExceptionHandlers.Select(h=>h.HandlerType+" "+h.CatchType+" "+Index(h.TryStart)+" "+Index(h.TryEnd)+" "+Index(h.HandlerStart)+" "+Index(h.HandlerEnd)+" "+Index(h.FilterStart)));
}
var methods=Types(module.Types).SelectMany(t=>t.Methods).ToDictionary(m=>m.FullName);var before=methods.ToDictionary(p=>p.Key,p=>Body(p.Value));
var name="System.Void TheForestOfLove.InventoryInfoTicker::UpdateItemInfoText(System.String,System.String)";var method=methods[name];var instructions=method.Body.Instructions;
var opcodes=new[]{OpCodes.Ldarg_0,OpCodes.Ldfld,OpCodes.Ldarg_1,OpCodes.Callvirt,OpCodes.Ldarg_0,OpCodes.Ldfld,OpCodes.Ldarg_2,OpCodes.Callvirt,OpCodes.Ret};
if(instructions.Count!=9||!instructions.Select(i=>i.OpCode).SequenceEqual(opcodes)||instructions[1].Operand.ToString()!="UnityEngine.UI.Text TheForestOfLove.InventoryInfoTicker::itemTitleText"||instructions[5].Operand.ToString()!="UnityEngine.UI.Text TheForestOfLove.InventoryInfoTicker::tickerText"||instructions[3].Operand.ToString()!="System.Void UnityEngine.UI.Text::set_text(System.String)"||instructions[7].Operand.ToString()!="System.Void UnityEngine.UI.Text::set_text(System.String)")throw new Exception("Exact original native text setter required");
var refs=module.AssemblyReferences.Select(r=>r.FullName).ToHashSet();
var apply=helper.GetType("VNRevivalInventoryLayout").Methods.Single(m=>m.Name=="Apply"&&m.IsStatic&&m.Parameters.Count==1&&m.Parameters[0].ParameterType.FullName=="System.Object");
var il=method.Body.GetILProcessor();var ret=instructions.Last();il.InsertBefore(ret,il.Create(OpCodes.Ldarg_0));il.InsertBefore(ret,il.Create(OpCodes.Call,module.ImportReference(apply)));
var expected=methods.ToDictionary(p=>p.Key,p=>Body(p.Value));module.Write(args[3]);
using var readback=ModuleDefinition.ReadModule(args[3]);var after=Types(readback.Types).SelectMany(t=>t.Methods).ToDictionary(m=>m.FullName);
if(!before.Keys.ToHashSet().SetEquals(after.Keys)||expected.Any(p=>Body(after[p.Key])!=p.Value))throw new Exception("Whole method readback failed");
var changed=before.Keys.Where(k=>before[k]!=Body(after[k])).ToArray();if(changed.Length!=1||changed[0]!=name)throw new Exception("Unexpected changed method set");
var extraRefs=readback.AssemblyReferences.Select(r=>r.FullName).Except(refs).ToArray();if(extraRefs.Length!=1||extraRefs[0]!=helper.Assembly.Name.FullName||!refs.IsSubsetOf(readback.AssemblyReferences.Select(r=>r.FullName)))throw new Exception("Unexpected assembly dependencies");
after[name].Body.Instructions.RemoveAt(9);after[name].Body.Instructions.RemoveAt(8);
if(before.Any(p=>Body(after[p.Key])!=p.Value))throw new Exception("Unselected instructions/branches/locals/handlers changed");
File.WriteAllText(args[4],JsonSerializer.Serialize(new{sourceSha256=sourceHash,targetSha256=Hash(File.ReadAllBytes(args[3])),helperSha256=Hash(File.ReadAllBytes(args[2])),selectedMethod=name,addedInstructions=2,addedAssemblyReferences=extraRefs,wholeMethodInventoryReadback=true,allOriginalBodiesRestored=true},new JsonSerializerOptions{WriteIndented=true})+"\n");
