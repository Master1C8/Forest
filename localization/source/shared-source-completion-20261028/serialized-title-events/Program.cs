// Read only the exact metadata needed to decide the title-event serialization boundary.
using Mono.Cecil;
using System.Security.Cryptography;
using System.Text.Json;
if(args.Length != 1) throw new ArgumentException("pinned-original-game-assembly");
var expected="46f43b212709b96ac51f2484d1564f863346fed8dc70f532860046226a020acf";
string Hash() => Convert.ToHexString(SHA256.HashData(File.ReadAllBytes(args[0]))).ToLowerInvariant();
if(Hash()!=expected) throw new InvalidOperationException("Wrong original assembly");
using var assembly=AssemblyDefinition.ReadAssembly(args[0]);
IEnumerable<TypeDefinition> AllTypes(IEnumerable<TypeDefinition> ts) {
 foreach(var t in ts) { yield return t; foreach(var n in AllTypes(t.NestedTypes)) yield return n; }
}
var types=AllTypes(assembly.MainModule.Types).ToDictionary(t=>t.FullName);
bool DerivesFromStory(TypeDefinition t) {
 var seen=new HashSet<string>();
 while(t.BaseType!=null && seen.Add(t.FullName)) {
  if(t.BaseType.FullName=="TheForestOfLove.GeneralStoryUIController") return true;
  if(!types.TryGetValue(t.BaseType.FullName,out t!)) return false;
 }
 return false;
}
var specs=new Dictionary<string,string[]> {
 ["TheForestOfLove.GeneralStoryUIController"]=["onDialogueEmptyWithTitledLine","onDialogueLine","onAdvanceMoment"],
 ["TheForestOfLove.Narrative.DialogueService"]=["onDialogueLineBegin_AnyPassthruTitledLine"],
 ["TheForestOfLove.Events.StringPrimitiveEvent"]=[]
};
var result=specs.Select(s=> {
 var t=types[s.Key];
 var fields=s.Value.Select(n=>t.Fields.Single(f=>f.Name==n)).Select(f=>new {
  name=f.FullName, attributes=f.Attributes.ToString(), isStatic=f.IsStatic,
  customAttributes=f.CustomAttributes.Select(a=>a.AttributeType.FullName).ToArray()
 }).ToArray();
 return new {type=t.FullName,baseType=t.BaseType?.FullName,attributes=t.Attributes.ToString(),
  customAttributes=t.CustomAttributes.Select(a=>a.AttributeType.FullName).ToArray(),fields};
}).ToArray();
if(Hash()!=expected) throw new InvalidOperationException("Assembly changed");
Console.WriteLine(JsonSerializer.Serialize(new {sourceSha256=expected,types=result,
 storyDerivedTypes=types.Values.Where(DerivesFromStory).Select(t=>t.FullName).Order().ToArray()
},new JsonSerializerOptions {WriteIndented=true}));
