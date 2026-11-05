"""Rebuild the shared inventory helper only for the opt-in complex renderer."""
import json,subprocess
from pathlib import Path
def build(doc,files,root,directory,work,need):
    if not doc.get('complexText'):return []
    d=work/'inventory-helper';d.mkdir();old=d/'old.dll';old.write_bytes(files['Managed/VNRevivalInventoryLayout.dll'])
    source=d/'InventoryLayout.cs';source.write_bytes((root/'tools/forest_localization/InventoryLayout.cs').read_bytes())
    compiler=Path('/opt/homebrew/Cellar/dotnet@8/8.0.131/libexec/sdk/8.0.131/Roslyn/bincore/csc.dll')
    refs=sorted((directory/'references').glob('*.dll'));target=d/'VNRevivalInventoryLayout.dll'
    subprocess.run(['dotnet',str(compiler),'-nologo','-deterministic+','-target:library','-nostdlib+','-out:'+str(target)]+['-r:'+str(p) for p in refs]+[str(source)],check=True)
    shared=(root/'tools/forest_localization/Managed.cs').read_text().replace('static class Program {','static partial class Program {').replace('static void Main(','static void LegacyMain(')
    shared=shared.replace('m.Body.CodeSize<64','m.Body.Instructions.Sum(i=>i.GetSize())<64')
    (d/'Shared.cs').write_text(shared);(d/'Proof.cs').write_bytes((root/'tools/forest_localization/InventoryHelperProof.cs').read_bytes())
    cecil=root/'tools/locale_completion/resource_composition_v1/managed_saved/bin/Debug/net8.0/Mono.Cecil.dll'
    (d/'Proof.csproj').write_text('<Project Sdk="Microsoft.NET.Sdk"><PropertyGroup><OutputType>Exe</OutputType><TargetFramework>net8.0</TargetFramework><ImplicitUsings>enable</ImplicitUsings><Nullable>enable</Nullable><EnableDefaultCompileItems>false</EnableDefaultCompileItems></PropertyGroup><ItemGroup><Compile Include="Shared.cs"/><Compile Include="Proof.cs"/><Reference Include="Mono.Cecil"><HintPath>'+str(cecil)+'</HintPath></Reference></ItemGroup></Project>')
    subprocess.run(['dotnet','build',str(d/'Proof.csproj'),'--nologo','-v','quiet'],check=True)
    subprocess.run(['dotnet',str(d/'bin/Debug/net8.0/Proof.dll'),str(old),str(target),str(d/'receipt.json')],check=True)
    files['Managed/VNRevivalInventoryLayout.dll']=target.read_bytes()
    return [dict(asset='Managed/VNRevivalInventoryLayout.dll',adaptiveInventoryHelper=json.loads((d/'receipt.json').read_bytes()))]
