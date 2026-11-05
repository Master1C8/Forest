"""Prove a named, bounded helper-only repair before reusing native frames."""
import argparse,hashlib,json,subprocess
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
def read(p):return json.loads(p.read_bytes())
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
p=argparse.ArgumentParser(description=__doc__);p.add_argument('old',type=Path);p.add_argument('new',type=Path);p.add_argument('output',type=Path);p.add_argument('--mode',choices=['resident-body','disabled-resident-additions','complex-gallery-quest-layout','complex-native-painter-order'],default='resident-body');a=p.parse_args()
old=read(a.old/'manifest.json');new=read(a.new/'manifest.json');assert old['locale']==new['locale'] and old['languageSha256']==new['languageSha256'];assert set(old['files'])==set(new['files'])
changed=[]
for name in old['files']:
 for folder,manifest in [(a.old,old),(a.new,new)]:assert sha(folder/name)==manifest['files'][name]['sha256']
 if old['files'][name]!=new['files'][name]:changed.append(name)
assert changed==['Managed/VNRevivalQuestLayout.dll'],('Expected helper-only repair',changed)
shared=(ROOT/'tools/forest_localization/Managed.cs').read_text().replace('static class Program {','static partial class Program {').replace('static void Main(','static void LegacyMain(').replace('m.Body.CodeSize<64','m.Body.Instructions.Sum(i=>i.GetSize())<64')
code='''using Mono.Cecil;
static partial class Program {
 static void Main(string[] args) {
  using var old=ModuleDefinition.ReadModule(args[0]);using var next=ModuleDefinition.ReadModule(args[1]);var a=Tree(old);var b=Tree(next);
  foreach(var tree in new[]{a,b}){var parts=tree["module"].Split('|');parts[6]="<MVID>";tree["module"]=string.Join("|",parts);}
  var changed=a.Keys.Union(b.Keys).Where(k=>!a.TryGetValue(k,out var x)||!b.TryGetValue(k,out var y)||x!=y).Order().ToArray();
  if(args[3]=="resident-body")Need(changed.Length>0&&changed.All(k=>k.Contains("VNRevivalImageCaptions/ResidentBody")),"only-resident-body-delta:"+string.Join(",",changed));
  else if(args[3]=="complex-gallery-quest-layout"){
   var expected=new[]{"body:System.Void ForestComplexText.Runtime::Bind()","method:System.Void ForestComplexText.Runtime::GalleryDirection(TMPro.TMP_Text)","body:System.Void ForestComplexText.Runtime::GalleryDirection(TMPro.TMP_Text)","method:System.Void ForestComplexText.Runtime::QuestHeadingClearance(TMPro.TMP_Text)","body:System.Void ForestComplexText.Runtime::QuestHeadingClearance(TMPro.TMP_Text)"};
   Need(changed.Order().SequenceEqual(expected.Order()),"exact-gallery-quest-layout-delta:"+string.Join(",",changed));
   Need(expected.Skip(1).All(k=>!a.ContainsKey(k)),"new-scoped-layout-methods");
  }
  else if(args[3]=="complex-native-painter-order")Need(changed.SequenceEqual(new[]{"body:System.Void ForestComplexText.LegacyMirror::Awake()"}),"only-native-painter-order-delta:"+string.Join(",",changed));
  else {foreach(var row in a)Need(b.TryGetValue(row.Key,out var value)&&value==row.Value,"existing-helper-entry-changed:"+row.Key);Need(changed.Length>0&&changed.All(k=>k.Contains("VNRevivalImageCaptions")),"only-unreachable-resident-additions");}
  Save(args[2],new {passed=true,mode=args[3],oldHelperSha256=HashFile(args[0]),newHelperSha256=HashFile(args[1]),retainedEntries=a.Count-a.Keys.Count(k=>changed.Contains(k)),changedEntries=changed,moduleIdentityNormalized="MVID only",allOtherHelperEntriesExact=true});
 }
}'''
key=hashlib.sha256((shared+code).encode()).hexdigest();work=ROOT/'outputs/screenshot-compatibility'/key;work.mkdir(parents=True,exist_ok=True);tool=work/'bin/Release/net8.0/Compare.dll'
if not tool.exists():
 (work/'Shared.cs').write_text(shared);(work/'Compare.cs').write_text(code);cecil=ROOT/'tools/locale_completion/resource_composition_v1/managed_saved/bin/Debug/net8.0/Mono.Cecil.dll';(work/'Compare.csproj').write_text('<Project Sdk="Microsoft.NET.Sdk"><PropertyGroup><OutputType>Exe</OutputType><TargetFramework>net8.0</TargetFramework><ImplicitUsings>enable</ImplicitUsings><Nullable>enable</Nullable></PropertyGroup><ItemGroup><Reference Include="Mono.Cecil"><HintPath>'+str(cecil)+'</HintPath></Reference></ItemGroup></Project>');subprocess.run(['dotnet','build',str(work/'Compare.csproj'),'-c','Release','--nologo','-v','quiet'],check=True)
assert not a.output.exists();proof=a.output.with_suffix('.helper.json');assert not proof.exists();subprocess.run(['dotnet',str(tool),str(a.old/'Managed/VNRevivalQuestLayout.dll'),str(a.new/'Managed/VNRevivalQuestLayout.dll'),str(proof),a.mode],check=True)
a.output.write_text(json.dumps(dict(passed=True,locale=old['locale'],oldManifestSha256=sha(a.old/'manifest.json'),newManifestSha256=sha(a.new/'manifest.json'),languageSha256=old['languageSha256'],changedResources=changed,helperProof=read(proof),boundary='Same language and every other native resource exact. Only the explicitly selected helper delta changes; unaffected screen reuse still requires scene-specific applicability evidence.'),indent=2)+'\n');print(json.dumps(dict(passed=True,changedResources=changed,mode=a.mode)))
