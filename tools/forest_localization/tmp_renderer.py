"""Registered direct-TMP display route, shared byte-identically by Mac/Windows."""
import json,subprocess
RESOURCE='Managed/Unity.TextMeshPro.dll'
ORIGINAL='775eab21aef1558df02968234ce1e506c2685c95813ba7cbb89e8f3e9102c483'
def build(doc,files,root,directory,work,need):
    if not doc.get('complexText'):return []
    d=work/'tmp-input-route';d.mkdir()
    shared=(root/'tools/forest_localization/Managed.cs').read_text().replace('static class Program {','static partial class Program {').replace('static void Main(','static void LegacyMain(').replace('m.Body.CodeSize<64','m.Body.Instructions.Sum(i=>i.GetSize())<64')
    (d/'Shared.cs').write_text(shared);(d/'Patch.cs').write_bytes((root/'tools/forest_localization/TmpPreprocessorPatch.cs').read_bytes())
    cecil=root/'tools/locale_completion/resource_composition_v1/managed_saved/bin/Debug/net8.0/Mono.Cecil.dll'
    (d/'Patch.csproj').write_text('<Project Sdk="Microsoft.NET.Sdk"><PropertyGroup><OutputType>Exe</OutputType><TargetFramework>net8.0</TargetFramework><ImplicitUsings>enable</ImplicitUsings><Nullable>enable</Nullable><EnableDefaultCompileItems>false</EnableDefaultCompileItems></PropertyGroup><ItemGroup><Compile Include="Shared.cs"/><Compile Include="Patch.cs"/><Reference Include="Mono.Cecil"><HintPath>'+str(cecil)+'</HintPath></Reference></ItemGroup></Project>')
    subprocess.run(['dotnet','build',str(d/'Patch.csproj'),'--nologo','-v','quiet'],check=True)
    target=d/'Unity.TextMeshPro.dll'
    command=['dotnet',str(d/'bin/Debug/net8.0/Patch.dll'),str(directory/'references/Unity.TextMeshPro.dll'),str(target),str(d/'receipt.json')]
    if doc['locale']=='th':command.append('thai-wrap')
    subprocess.run(command,check=True)
    files[RESOURCE]=target.read_bytes();return [dict(asset=RESOURCE,sharedTmpInputRoute=json.loads((d/'receipt.json').read_bytes()))]
