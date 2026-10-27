using Mono.Cecil;
using Mono.Cecil.Cil;
using System.Text.Json;
using System.Security.Cryptography;

if(args.Length<3)throw new Exception("inspect source.dll output.json | patch source.dll targets.json output.dll receipt.json");
string Hash(byte[] bytes)=>Convert.ToHexString(SHA256.HashData(bytes)).ToLowerInvariant();
var sourceHash=Hash(File.ReadAllBytes(args[1]));
bool items=args[0].EndsWith("-items");
var original="46f43b212709b96ac51f2484d1564f863346fed8dc70f532860046226a020acf";
var gallery="c41ae1394482f65f5ee27790e63969ef96357e68153fedee8a8dde1a69182065";
if(sourceHash!=(args[0]=="patch-items"?gallery:original))throw new Exception("Unexpected pinned input assembly");
using var module=ModuleDefinition.ReadModule(args[1]);
string Body(MethodDefinition method) {
    if(!method.HasBody)return "<none>";
    var list=method.Body.Instructions;
    string Index(Instruction? i)=>i==null?"end":"@"+list.IndexOf(i);
    string Operand(object? value)=>value switch {null=>"",Instruction i=>Index(i),Instruction[] a=>string.Join(",",a.Select(Index)),_=>value.ToString()??""};
    return "locals="+method.Body.InitLocals+":"+string.Join(",",method.Body.Variables.Select(v=>v.VariableType.FullName))+"\n"+
        string.Join("\n",list.Select(i=>i.OpCode+" "+Operand(i.Operand)))+"\n"+
        string.Join("\n",method.Body.ExceptionHandlers.Select(h=>h.HandlerType+" "+h.CatchType+" "+Index(h.TryStart)+" "+Index(h.TryEnd)+" "+Index(h.HandlerStart)+" "+Index(h.HandlerEnd)+" "+Index(h.FilterStart)));
}
IEnumerable<TypeDefinition> Types(IEnumerable<TypeDefinition> types) {foreach(var t in types){yield return t;foreach(var n in Types(t.NestedTypes))yield return n;}}
var methods=Types(module.Types).SelectMany(t=>t.Methods).ToDictionary(m=>m.FullName);
var before=methods.ToDictionary(p=>p.Key,p=>Body(p.Value));
var itemMethods=new Dictionary<string,string[]> {
 ["TheForestOfLove.ItemGetNotification"]=new[]{"ShowInventoryItemNotification"},
 ["TheForestOfLove.DialogueCanvasItemGetNotificationController"]=new[]{"ShowNotification"},
 ["TheForestOfLove.DialogueCanvasItemLostNotificationController"]=new[]{"TakeItem"},
 ["TheForestOfLove.OverworldItemGetNotificationLite"]=new[]{"ShowNotification"},
 ["TheForestOfLove.OverworldAllInOneNotificationItem"]=new[]{"ConfigureItemFoundNotification","ConfigureItemGetNotification","ConfigureItemLostNotification"}
};
var owner=module.GetType("TheForestOfLove.StartScreenGalleryMenu");
var names=new[]{"ShowDefaultStorySelectionText","UpdateStorySelectionText","ShowDefaultMovieSelectionText","UpdateMovieSelectionText"};
var selected=items?itemMethods.SelectMany(p=>module.GetType(p.Key).Methods.Where(m=>p.Value.Contains(m.Name))).ToArray():owner.Methods.Where(m=>names.Contains(m.Name)).ToArray();
if(selected.Length!=(items?7:4))throw new Exception("Ambiguous notification/gallery consumer methods");
var units=selected.SelectMany(m=>m.Body.Instructions.Where(i=>i.OpCode==OpCodes.Ldstr && (!items || (string)i.Operand!="show")).Select(i=>new {
    id="il:Assembly-CSharp.dll/"+m.FullName+"/IL_"+i.Offset.ToString("x4"), method=m.FullName,
    offset=i.Offset, instructionIndex=m.Body.Instructions.IndexOf(i), source=(string)i.Operand
})).ToArray();
if(items && selected.Sum(m=>m.Body.Instructions.Count(i=>i.OpCode==OpCodes.Ldstr && (string)i.Operand=="show"))!=3)throw new Exception("Expected three protected animator triggers");
if(units.Length!=(items?8:6) || units.Select(u=>u.source).Distinct().Count()!=(items?8:4))throw new Exception("Unexpected finite display source scope");
var options=new JsonSerializerOptions{WriteIndented=true,Encoder=System.Text.Encodings.Web.JavaScriptEncoder.UnsafeRelaxedJsonEscaping};
if(args[0]=="inspect" || args[0]=="inspect-items") {
    if(File.Exists(args[2]))throw new Exception("Output exists");
    File.WriteAllText(args[2],JsonSerializer.Serialize(new{schemaVersion=1,sourceSha256=sourceHash,units},options)+"\n");return;
}
if((args[0]!="patch" && args[0]!="patch-items") || args.Length!=5 || File.Exists(args[3]) || File.Exists(args[4]))throw new Exception("Invalid output arguments");
var targets=JsonDocument.Parse(File.ReadAllText(args[2])).RootElement.EnumerateArray().ToDictionary(x=>x.GetProperty("id").GetString()!,x=>x);
if(!units.Select(u=>u.id).ToHashSet().SetEquals(targets.Keys))throw new Exception($"Exact {units.Length}-unit target coverage required");
foreach(var u in units) {
    var row=targets[u.id];if(row.GetProperty("source").GetString()!=u.source)throw new Exception("Source cell mismatch");
    var text=row.GetProperty("target").GetString();if(string.IsNullOrWhiteSpace(text))throw new Exception("Empty target");
    methods[u.method].Body.Instructions[u.instructionIndex].Operand=text;
}
var expected=methods.ToDictionary(p=>p.Key,p=>Body(p.Value));
module.Write(args[3]);
using var readback=ModuleDefinition.ReadModule(args[3]);
var after=Types(readback.Types).SelectMany(t=>t.Methods).ToDictionary(m=>m.FullName,m=>Body(m));
if(!before.Keys.ToHashSet().SetEquals(after.Keys) || expected.Any(p=>after[p.Key]!=p.Value))throw new Exception("Whole method-inventory readback failed");
var changed=before.Keys.Where(k=>before[k]!=after[k]).ToArray();
if(!changed.ToHashSet().SetEquals(selected.Select(m=>m.FullName)))throw new Exception("Unexpected changed method set");
// Reverse only the selected display operands; every original branch/opcode/local/handler must match.
var restored=Types(readback.Types).SelectMany(t=>t.Methods).ToDictionary(m=>m.FullName);
foreach(var u in units)restored[u.method].Body.Instructions[u.instructionIndex].Operand=u.source;
if(before.Any(p=>Body(restored[p.Key])!=p.Value))throw new Exception("Unselected IL changed");
File.WriteAllText(args[4],JsonSerializer.Serialize(new{sourceSha256=sourceHash,targetSha256=Hash(File.ReadAllBytes(args[3])),selectedStrings=units.Length,changedMethods=changed,wholeMethodInventoryReadback=true,allOriginalBodiesRestored=true},options)+"\n");
