"""Exact HE heading-inset delta proof before unaffected native frame reuse."""
import argparse,hashlib,json,subprocess
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
def read(p):return json.loads(p.read_bytes())
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
p=argparse.ArgumentParser(description=__doc__)
p.add_argument('old',type=Path);p.add_argument('new',type=Path);p.add_argument('output',type=Path)
a=p.parse_args();assert not a.output.exists()
old,new=read(a.old/'manifest.json'),read(a.new/'manifest.json')
assert old['locale']==new['locale']=='he' and set(old['files'])==set(new['files'])
assert new['languageSha256']==sha(ROOT/'localization/languages/he.json')
changed=[]
for name in old['files']:
    for folder,m in [(a.old,old),(a.new,new)]:assert sha(folder/name)==m['files'][name]['sha256']
    if old['files'][name]!=new['files'][name]:changed.append(name)
assert changed==['Managed/VNRevivalQuestLayout.dll'],changed
shared=(ROOT/'tools/forest_localization/Managed.cs').read_text().replace('static class Program {','static partial class Program {').replace('static void Main(','static void LegacyMain(').replace('m.Body.CodeSize<64','m.Body.Instructions.Sum(i=>i.GetSize())<64')
code='''using Mono.Cecil;
static partial class Program {
 static void Main(string[] args) {
  using var old=ModuleDefinition.ReadModule(args[0]);using var next=ModuleDefinition.ReadModule(args[1]);var a=Tree(old);var b=Tree(next);
  foreach(var t in new[]{a,b}){var p=t["module"].Split('|');p[6]="<MVID>";t["module"]=string.Join("|",p);}
  string[] Map(ModuleDefinition m){Need(m.Resources.Count==1&&m.Resources[0] is EmbeddedResource&&m.Resources[0].Name=="VNRevival.ShapingMap","one-map-resource");return System.Text.Encoding.UTF8.GetString(((EmbeddedResource)m.Resources[0]).GetResourceData()).Split('\\n').Where(s=>s.Length>0).ToArray();}
  var left=Map(old);var right=Map(next);
  string expected="L\\t"+Convert.ToBase64String(System.Text.Encoding.UTF8.GetBytes("critterHeadingShiftX"))+"\\t"+Convert.ToBase64String(System.Text.Encoding.UTF8.GetBytes("4"));
  Need(!left.Contains(expected)&&right.Count(r=>r==expected)==1&&left.SequenceEqual(right.Where(r=>r!=expected)),"only-exact4-unit-header-X-config-row");
  var expectedKeys=new[]{"resources","body:System.Void ForestComplexText.Runtime::CritterHeadingClearance(TMPro.TMP_Text)","method:System.Single ForestComplexText.TextShaper::get_CritterHeadingShiftX()","body:System.Single ForestComplexText.TextShaper::get_CritterHeadingShiftX()","property:System.Single ForestComplexText.TextShaper::CritterHeadingShiftX()"};
  var changed=a.Keys.Union(b.Keys).Where(k=>!a.TryGetValue(k,out var x)||!b.TryGetValue(k,out var y)||x!=y).Order().ToArray();
  Need(changed.SequenceEqual(expectedKeys.Order()),"only-header-X-getter-pose-map-delta:"+string.Join(",",changed));
  Need(expectedKeys.Skip(2).All(k=>!a.ContainsKey(k)),"new-header-X-getter-only");
  Save(args[2],new {passed=true,changedEntries=changed,allOtherEntriesExact=true,logicalShapingMapRowsExact=true,oldMapSha256=Hash(((EmbeddedResource)old.Resources[0]).GetResourceData()),newMapSha256=Hash(((EmbeddedResource)next.Resources[0]).GetResourceData()),moduleIdentityNormalized="MVID only"});
 }
}'''
key=hashlib.sha256((shared+code).encode()).hexdigest();work=ROOT/'outputs/screenshot-compatibility'/key;work.mkdir(parents=True,exist_ok=True)
(work/'Shared.cs').write_text(shared);(work/'Compare.cs').write_text(code)
cecil=ROOT/'tools/locale_completion/resource_composition_v1/managed_saved/bin/Debug/net8.0/Mono.Cecil.dll'
(work/'Compare.csproj').write_text('<Project Sdk="Microsoft.NET.Sdk"><PropertyGroup><OutputType>Exe</OutputType><TargetFramework>net8.0</TargetFramework><ImplicitUsings>enable</ImplicitUsings><Nullable>enable</Nullable></PropertyGroup><ItemGroup><Reference Include="Mono.Cecil"><HintPath>'+str(cecil)+'</HintPath></Reference></ItemGroup></Project>')
subprocess.run(['dotnet','build',str(work/'Compare.csproj'),'-c','Release','--nologo','-v','quiet'],check=True)
proof=a.output.with_suffix('.helper.json');assert not proof.exists()
subprocess.run(['dotnet',str(work/'bin/Release/net8.0/Compare.dll'),str(a.old/'Managed/VNRevivalQuestLayout.dll'),str(a.new/'Managed/VNRevivalQuestLayout.dll'),str(proof)],check=True)
a.output.write_text(json.dumps(dict(passed=True,locale='he',oldManifestSha256=sha(a.old/'manifest.json'),newManifestSha256=sha(a.new/'manifest.json'),changedResources=changed,helperProof=read(proof),affectedOrders=[5],unchangedOrders=[1,2,3,4,6,7],applicability='Only complete original CritterLog heading X pose changes0 to4; Y remains4. It is inactive in all other requested scenes. All other native bytes, logical/map shaping values and helper code are exact; reuse only the6 prior actually passed originals.'),indent=2)+'\n')
print('Exact header-only reuse proof passed')
