"""Prove named layout-only native deltas before reusing unaffected screenshots."""
import argparse,copy,hashlib,json,subprocess
from pathlib import Path
from forest_localization.core import engines,registered_layout_roles
ROOT=Path(__file__).resolve().parents[1]
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def read(p):return json.loads(p.read_bytes())
p=argparse.ArgumentParser(description=__doc__);p.add_argument('old',type=Path);p.add_argument('new',type=Path);p.add_argument('output',type=Path);p.add_argument('--status-single-line-fit',action='store_true');a=p.parse_args()
assert not a.output.exists()
old,new=read(a.old/'manifest.json'),read(a.new/'manifest.json');assert old['locale']==new['locale']
assert set(old['files'])==set(new['files'])
doc=read(ROOT/'localization/languages'/(new['locale']+'.json'));assert sha(ROOT/'localization/languages'/(new['locale']+'.json'))==new['languageSha256']
framework=ROOT/'localization/framework'/doc['framework']['id'];assert sha(framework/'framework.json')==doc['framework']['sha256'];f=read(framework/'framework.json');roles=registered_layout_roles(f,sha(framework/'framework.json'))
U,Generator,tree,canonical,comp,inv,writer=engines();gen=Generator('2020.3.24f1');gen.load_local_dll_folder(str(framework/'references'))
changes=[];fields=[]
for name in old['files']:
    for folder,m in [(a.old,old),(a.new,new)]:assert sha(folder/name)==m['files'][name]['sha256']
    if old['files'][name]==new['files'][name]:continue
    changes.append(name)
    if name=='Managed/VNRevivalQuestLayout.dll':continue
    assert name in ['level1','sharedassets0.assets','sharedassets2.assets'],('Unexpected native delta',name)
    left,right=U.load(str(a.old/name)),U.load(str(a.new/name));left.path=right.path='/Applications/TheForestOfLove.app/Contents/Resources/Data'
    before,after=comp.objects(left),comp.objects(right);assert set(before)==set(after)
    for pid in before:
        if before[pid].get_raw_data()==after[pid].get_raw_data():continue
        role=name+':'+str(pid);assert role in roles and role in doc['layout'],('Unregistered changed object',role)
        pointer=roles[role]['pointer'];keys=pointer.lstrip('/').split('/');b,t=tree(before[pid],gen),tree(after[pid],gen);restored=copy.deepcopy(t);x,y,z=b,t,restored
        for key in keys[:-1]:x,y,z=x[key],y[key],z[key]
        assert y[keys[-1]]==doc['layout'][role];z[keys[-1]]=x[keys[-1]]
        assert canonical(b)==canonical(restored),('Non-size fields changed',role)
        fields.append(dict(role=role,pointer=pointer,before=x[keys[-1]],after=y[keys[-1]]))
shared=(ROOT/'tools/forest_localization/Managed.cs').read_text().replace('static class Program {','static partial class Program {').replace('static void Main(','static void LegacyMain(').replace('m.Body.CodeSize<64','m.Body.Instructions.Sum(i=>i.GetSize())<64')
code='''using Mono.Cecil;
static partial class Program {static void Main(string[] args){
 using var old=ModuleDefinition.ReadModule(args[0]);using var next=ModuleDefinition.ReadModule(args[1]);var a=Tree(old);var b=Tree(next);
 foreach(var t in new[]{a,b}){var p=t["module"].Split('|');p[6]="<MVID>";t["module"]=string.Join("|",p);}
 var allowed=new[]{"body:System.Void VNRevivalImageCaptions::Gallery(UnityEngine.Component)","body:System.Void VNRevivalImageCaptions::Residents(UnityEngine.Component)","body:System.Void VNRevivalImageCaptions::ScaleGalleryCounters(UnityEngine.Component,System.Single)","body:System.Void VNRevivalQuestLayout::RussianStatusHeadings(UnityEngine.Component,UnityEngine.Font)"};
 var changed=a.Keys.Union(b.Keys).Where(k=>!a.TryGetValue(k,out var x)||!b.TryGetValue(k,out var y)||x!=y).Order().ToArray();
 foreach(var row in a)if(!allowed.Contains(row.Key)&&!row.Key.Contains("VNRevivalImageCaptions/ResidentBody"))Need(b.TryGetValue(row.Key,out var v)&&v==row.Value,"retained-helper:"+row.Key);
 Need(changed.All(k=>allowed.Contains(k)||k.Contains("VNRevivalImageCaptions/ResidentBody")||!a.ContainsKey(k)&&k.Contains("VNRevivalImageCaptions")),"only-caption-layout-helper-delta");
 foreach(var entry in new[]{("VNRevivalImageCaptions","Gallery"),("VNRevivalImageCaptions","Residents"),("VNRevivalQuestLayout","RussianStatusHeadings")}){
  var x=old.GetType(entry.Item1).Methods.Single(m=>m.Name==entry.Item2);var y=next.GetType(entry.Item1).Methods.Single(m=>m.Name==entry.Item2);
  string[] Strings(MethodDefinition m)=>m.Body.Instructions.Where(i=>i.OpCode==Mono.Cecil.Cil.OpCodes.Ldstr).Select(i=>(string)i.Operand).ToArray();
  var target=Strings(y);
  if(entry.Item2=="RussianStatusHeadings"&&args[3]=="status-single-line-fit"){
   string guard="Native quest status heading does not fit its original band";
   Need(!Strings(x).Contains(guard)&&target.Count(s=>s==guard)==1,"one-new-technical-status-fit-guard");target=target.Where(s=>s!=guard).ToArray();
  }
  Need(Strings(x).SequenceEqual(target),"caption-wording-retained:"+entry.Item2);
 }
 Save(args[2],new {passed=true,changedEntries=changed,allOtherEntriesExact=true,captionWordingExact=true,moduleIdentityNormalized="MVID only"});
}}
'''
key=hashlib.sha256((shared+code).encode()).hexdigest();work=ROOT/'outputs/screenshot-compatibility'/key;work.mkdir(parents=True,exist_ok=True)
(work/'Shared.cs').write_text(shared);(work/'Compare.cs').write_text(code)
cecil=ROOT/'tools/locale_completion/resource_composition_v1/managed_saved/bin/Debug/net8.0/Mono.Cecil.dll'
(work/'Compare.csproj').write_text('<Project Sdk="Microsoft.NET.Sdk"><PropertyGroup><OutputType>Exe</OutputType><TargetFramework>net8.0</TargetFramework><ImplicitUsings>enable</ImplicitUsings><Nullable>enable</Nullable></PropertyGroup><ItemGroup><Reference Include="Mono.Cecil"><HintPath>'+str(cecil)+'</HintPath></Reference></ItemGroup></Project>')
subprocess.run(['dotnet','build',str(work/'Compare.csproj'),'-c','Release','--nologo','-v','quiet'],check=True)
proof=a.output.with_suffix('.helper.json');assert not proof.exists()
subprocess.run(['dotnet',str(work/'bin/Release/net8.0/Compare.dll'),str(a.old/'Managed/VNRevivalQuestLayout.dll'),str(a.new/'Managed/VNRevivalQuestLayout.dll'),str(proof),'status-single-line-fit'if a.status_single_line_fit else'default'],check=True)
a.output.write_text(json.dumps(dict(passed=True,locale=new['locale'],oldManifestSha256=sha(a.old/'manifest.json'),newManifestSha256=sha(a.new/'manifest.json'),changedResources=changes,changedFields=fields,helperProof=read(proof),boundary='Only registered point sizes and scoped gallery/resident/status-heading helper changes; no wording, data, other code or font resource changes. Per-scene applicability and original image review still required.'),indent=2)+'\n')
print(json.dumps(dict(passed=True,changedResources=changes,pointSizeFields=len(fields))))
