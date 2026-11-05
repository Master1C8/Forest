"""Prove a named, bounded helper-only repair before reusing native frames."""
import argparse,hashlib,json,subprocess
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
def read(p):return json.loads(p.read_bytes())
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
p=argparse.ArgumentParser(description=__doc__);p.add_argument('old',type=Path);p.add_argument('new',type=Path);p.add_argument('output',type=Path);p.add_argument('--mode',choices=['resident-body','disabled-resident-additions','complex-gallery-quest-layout','complex-native-painter-order','hosted-layout','hosted-layout-ru-quest'],default='resident-body');a=p.parse_args()
old=read(a.old/'manifest.json');new=read(a.new/'manifest.json');assert old['locale']==new['locale'] and (a.mode=='hosted-layout' or old['languageSha256']==new['languageSha256']);assert set(old['files'])==set(new['files'])
assert a.mode!='hosted-layout-ru-quest' or old['locale']=='ru'
changed=[]
for name in old['files']:
 for folder,manifest in [(a.old,old),(a.new,new)]:assert sha(folder/name)==manifest['files'][name]['sha256']
 if old['files'][name]!=new['files'][name]:changed.append(name)
helper='Managed/VNRevivalQuestLayout.dll'
assert changed==[helper] or (a.mode=='hosted-layout' and old['locale']=='uk' and set(changed)=={helper,'sharedassets2.assets'}),('Unexpected resource delta',changed)
shared=(ROOT/'tools/forest_localization/Managed.cs').read_text().replace('static class Program {','static partial class Program {').replace('static void Main(','static void LegacyMain(').replace('m.Body.CodeSize<64','m.Body.Instructions.Sum(i=>i.GetSize())<64')
code='''using Mono.Cecil;
using Mono.Cecil.Cil;
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
  else if(args[3]=="hosted-layout"||args[3]=="hosted-layout-ru-quest"){
   string[] signatures={"VNRevivalImageCaptions/VersionContrast","VNRevivalImageCaptions/ResidentBody","VNRevivalImageCaptions::VersionLabel(","VNRevivalImageCaptions::Gallery(","VNRevivalImageCaptions::Residents(","VNRevivalImageCaptions::residentBodyTopLift","ForestComplexText.Runtime::CritterHeadingClearance(","ForestComplexText.Runtime::QuestHeadingClearance(","ForestComplexText.TextShaper::LayoutNumber(","ForestComplexText.TextShaper::CritterHeadingScale(","ForestComplexText.TextShaper::QuestHeading", "ForestComplexText.TextShaper::get_CritterHeadingScale(","ForestComplexText.TextShaper::get_QuestHeading"};
   var oldCaptions=old.GetType("VNRevivalImageCaptions");var newCaptions=next.GetType("VNRevivalImageCaptions");
   var counter=newCaptions.Methods.SingleOrDefault(m=>m.Name=="ScaleGalleryCounters");
   bool dormantCounters=false;
   if(counter!=null&&!oldCaptions.Methods.Any(m=>m.Name==counter.Name)) {
    var gallery=newCaptions.Methods.Single(m=>m.Name=="Gallery");
    var call=gallery.Body.Instructions.SingleOrDefault(i=>i.Operand is MethodReference r&&r.FullName==counter.FullName);
    var first=counter.Body.Instructions.Where(i=>i.OpCode!=OpCodes.Nop).Take(7).ToArray();
    // Current nonoptimized Roslyn emits a boolean local and conditional
    // branch around a direct return (or branch to the final return).
    dormantCounters=call?.Previous?.Operand is float scale&&scale==1&&first.Length==7&&first[0].OpCode==OpCodes.Ldarg_1&&
      first[1].OpCode==OpCodes.Ldc_R4&&(float)first[1].Operand==1&&first[2].OpCode==OpCodes.Ceq&&
      ((first[3].OpCode==OpCodes.Stloc_0&&first[4].OpCode==OpCodes.Ldloc_0)||
       (first[3].OpCode==OpCodes.Stloc_1&&first[4].OpCode==OpCodes.Ldloc_1))&&
      (first[5].OpCode==OpCodes.Brfalse_S||first[5].OpCode==OpCodes.Brfalse)&&
      (first[6].OpCode==OpCodes.Ret||first[6].Operand is Instruction target&&target.OpCode==OpCodes.Ret);
   }
   bool DormantCounterEntry(string k)=>dormantCounters&&(k.Contains("VNRevivalImageCaptions::ScaleGalleryCounters(")||k.Contains("VNRevivalImageCaptions/CounterPose")||k.EndsWith("VNRevivalImageCaptions::counterPoses"));
   bool ScopedResidentEntry(string k)=>k.Contains("VNRevivalImageCaptions::InstallResidentBody(")||k.Contains("VNRevivalImageCaptions::ScaleCritterHeading(")||k.EndsWith("VNRevivalImageCaptions::preferenceHeadingLift");
   const string russianQuest="body:System.Void VNRevivalQuestLayout::RussianStatusHeadings(UnityEngine.Component,UnityEngine.Font)";
   bool quest=args[3]=="hosted-layout-ru-quest";
   Need(!quest||changed.Contains(russianQuest),"Expected exact Russian quest method body delta");
   Need(changed.Length>0&&changed.All(k=>k=="resources"||signatures.Any(k.Contains)||DormantCounterEntry(k)||ScopedResidentEntry(k)||(quest&&k==russianQuest)),"only-scoped-hosted-layout-delta:"+string.Join(",",changed));
   var oldEmbedded=old.Resources.OfType<EmbeddedResource>().ToDictionary(r=>r.Name,r=>Hash(r.GetResourceData()));
   var newEmbedded=next.Resources.OfType<EmbeddedResource>().ToDictionary(r=>r.Name,r=>Hash(r.GetResourceData()));
   var resourceChanges=oldEmbedded.Keys.Union(newEmbedded.Keys).Where(k=>!oldEmbedded.TryGetValue(k,out var x)||!newEmbedded.TryGetValue(k,out var y)||x!=y).Order().ToArray();
   Save(args[2],new {passed=true,mode=args[3],oldHelperSha256=HashFile(args[0]),newHelperSha256=HashFile(args[1]),changedEntries=changed,resourceChanges,dormantCounters,moduleIdentityNormalized="MVID only",allOtherHelperEntriesExact=true});return;
  }
  else {foreach(var row in a)Need(b.TryGetValue(row.Key,out var value)&&value==row.Value,"existing-helper-entry-changed:"+row.Key);Need(changed.Length>0&&changed.All(k=>k.Contains("VNRevivalImageCaptions")),"only-unreachable-resident-additions");}
  Save(args[2],new {passed=true,mode=args[3],oldHelperSha256=HashFile(args[0]),newHelperSha256=HashFile(args[1]),retainedEntries=a.Count-a.Keys.Count(k=>changed.Contains(k)),changedEntries=changed,moduleIdentityNormalized="MVID only",allOtherHelperEntriesExact=true});
 }
}'''
key=hashlib.sha256((shared+code).encode()).hexdigest();work=ROOT/'outputs/screenshot-compatibility'/key;work.mkdir(parents=True,exist_ok=True);tool=work/'bin/Release/net8.0/Compare.dll'
if not tool.exists():
 (work/'Shared.cs').write_text(shared);(work/'Compare.cs').write_text(code);cecil=ROOT/'tools/locale_completion/resource_composition_v1/managed_saved/bin/Debug/net8.0/Mono.Cecil.dll';(work/'Compare.csproj').write_text('<Project Sdk="Microsoft.NET.Sdk"><PropertyGroup><OutputType>Exe</OutputType><TargetFramework>net8.0</TargetFramework><ImplicitUsings>enable</ImplicitUsings><Nullable>enable</Nullable></PropertyGroup><ItemGroup><Reference Include="Mono.Cecil"><HintPath>'+str(cecil)+'</HintPath></Reference></ItemGroup></Project>');subprocess.run(['dotnet','build',str(work/'Compare.csproj'),'-c','Release','--nologo','-v','quiet'],check=True)
assert not a.output.exists();proof=a.output.with_suffix('.helper.json');assert not proof.exists();subprocess.run(['dotnet',str(tool),str(a.old/'Managed/VNRevivalQuestLayout.dll'),str(a.new/'Managed/VNRevivalQuestLayout.dll'),str(proof),a.mode],check=True)
a.output.write_text(json.dumps(dict(passed=True,locale=old['locale'],oldManifestSha256=sha(a.old/'manifest.json'),newManifestSha256=sha(a.new/'manifest.json'),languageSha256=new['languageSha256'],oldLanguageSha256=old['languageSha256'],changedResources=changed,helperProof=read(proof),boundary='Only the listed native resource bytes changed. Unaffected screen reuse still requires exact language and scene-specific applicability evidence.'),indent=2)+'\n');print(json.dumps(dict(passed=True,changedResources=changed,mode=a.mode)))
