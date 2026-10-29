// Read-only comparison of the exact game classes used by the description route.
using Mono.Cecil;
using Mono.Cecil.Cil;
using System.Security.Cryptography;
using System.Text.Json;

if(args.Length!=3 || File.Exists(args[2]))throw new ArgumentException("old-dll new-dll new-receipt");
string Hash(string p)=>Convert.ToHexString(SHA256.HashData(File.ReadAllBytes(p))).ToLowerInvariant();
IEnumerable<TypeDefinition> Types(IEnumerable<TypeDefinition> types){foreach(var t in types){yield return t;foreach(var n in Types(t.NestedTypes))yield return n;}}
using var old=AssemblyDefinition.ReadAssembly(args[0]);using var current=AssemblyDefinition.ReadAssembly(args[1]);
var left=Types(old.MainModule.Types).ToDictionary(t=>t.FullName);var right=Types(current.MainModule.Types).ToDictionary(t=>t.FullName);
var requested=new[]{"ChapterSelectUI","PauseHelper","PauseScreenUIManager","PauseScreenUiController","PauseScreenMainMenu","StartScreenMainMenu","PlayMenu"};
var selected=new HashSet<string>();
foreach(var name in requested){var t=left.Values.Single(t=>t.Name==name);selected.Add(t.FullName);}
// These local base bodies own panel open/close and lifecycle behavior. Stop at
// the external assembly boundary; this is no framework-source exploration.
foreach(var name in selected.ToArray()){
 var t=left[name];while(t.BaseType!=null && left.TryGetValue(t.BaseType.FullName,out var b)){selected.Add(b.FullName);t=b;}
}
foreach(var t in left.Values)if(selected.Any(name=>t.FullName.StartsWith(name+"/",StringComparison.Ordinal)))selected.Add(t.FullName);
object Operand(object? operand,MethodDefinition method)=>operand switch{
 null=>"", Instruction i=>"branch:"+method.Body.Instructions.IndexOf(i),
 Instruction[] rows=>rows.Select(i=>method.Body.Instructions.IndexOf(i)).ToArray(),
 ParameterDefinition p=>"parameter:"+p.Index+":"+p.ParameterType.FullName,
 VariableDefinition v=>"local:"+v.Index+":"+v.VariableType.FullName,
 IMetadataTokenProvider m when m is MemberReference member=>member.FullName,
 _=>operand.ToString()!};
object Method(MethodDefinition m)=>new{
 name=m.FullName,attributes=(int)m.Attributes,impl=(int)m.ImplAttributes,
 parameters=m.Parameters.Select(p=>new{p.Name,type=p.ParameterType.FullName,attributes=(int)p.Attributes,p.Constant}),
 body=m.HasBody?new{m.Body.InitLocals,m.Body.MaxStackSize,
  locals=m.Body.Variables.Select(v=>v.VariableType.FullName),
  instructions=m.Body.Instructions.Select(i=>new{op=i.OpCode.Name,value=Operand(i.Operand,m)}),
  handlers=m.Body.ExceptionHandlers.Select(h=>new{type=h.HandlerType.ToString(),catchType=h.CatchType?.FullName,
   start=m.Body.Instructions.IndexOf(h.TryStart),end=m.Body.Instructions.IndexOf(h.TryEnd),
   handlerStart=m.Body.Instructions.IndexOf(h.HandlerStart),handlerEnd=m.Body.Instructions.IndexOf(h.HandlerEnd),filter=m.Body.Instructions.IndexOf(h.FilterStart)})}:null};
object Type(TypeDefinition t)=>new{t.FullName,attributes=(int)t.Attributes,baseType=t.BaseType?.FullName,
 interfaces=t.Interfaces.Select(i=>i.InterfaceType.FullName),
 fields=t.Fields.Select(f=>new{f.Name,type=f.FieldType.FullName,attributes=(int)f.Attributes,f.Constant,initial=Convert.ToHexString(f.InitialValue)}),
 methods=t.Methods.Select(Method)};
var checks=new List<object>();int methods=0,bodies=0;
foreach(var name in selected.Order()){
 if(!right.ContainsKey(name))throw new InvalidOperationException("Missing selected type:"+name);
 var a=JsonSerializer.Serialize(Type(left[name]));var b=JsonSerializer.Serialize(Type(right[name]));
 if(a!=b)throw new InvalidOperationException("Changed selected class:"+name);
 methods+=left[name].Methods.Count;bodies+=left[name].Methods.Count(m=>m.HasBody);
 checks.Add(new{type=name,methods=left[name].Methods.Count,sha256=Convert.ToHexString(SHA256.HashData(System.Text.Encoding.UTF8.GetBytes(a))).ToLowerInvariant()});
}
if(bodies<50)throw new InvalidOperationException("Empty or incomplete selected workload");
File.WriteAllText(args[2],JsonSerializer.Serialize(new{status="selected-game-route-classes-identical",oldAssemblySha256=Hash(args[0]),newAssemblySha256=Hash(args[1]),requested,classes=checks,methods,bodies,
 boundary="Complete selected local classes, nested types and local bases: metadata, fields, methods, locals, instructions and exception handlers. No new semantic interpretation or external framework acceptance.",runtime="not-run"},new JsonSerializerOptions{WriteIndented=true})+"\n");
