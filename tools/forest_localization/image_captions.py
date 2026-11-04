"""Registered native caption repair; data stays in the language document."""
import json, subprocess
from pathlib import Path

SOURCES={'gallery':'Gallery','residents':'Residents'}

def validate(doc, need):
    captions=doc.get('imageCaptions')
    if captions is None:return
    need(isinstance(captions,dict) and set(captions)==set(SOURCES),'exact-registered-image-caption-roles')
    for role,source in SOURCES.items():
        row=captions[role]
        need(isinstance(row,dict) and set(row)=={'source','target'} and row['source']==source and
             isinstance(row['target'],str) and row['target'].strip() and not any(c in row['target'] for c in '\x00\r\n'),
             'registered-image-caption:'+role)

def build(doc, files, root, directory, work, need):
    if 'imageCaptions' not in doc:return []
    assembly='Managed/Assembly-CSharp.dll';helper='Managed/VNRevivalQuestLayout.dll'
    folder=work/'image-captions';folder.mkdir()
    (folder/'original.dll').write_bytes(files[assembly]);(folder/'old-helper.dll').write_bytes(files[helper])
    source=(root/'tools/quest_layout/QuestLayout.cs').read_text()
    # Keep the already-authored status words from this exact language version.
    for old in ['Завершённые','Активные']:
        values=[r['target'] for key,r in doc['translations'].items() if '::RussianStatusHeadings(' in key and r['source']==('Completed' if old=='Завершённые' else 'Active')]
        need(len(values)==1,'caption-status-wording')
        source=source.replace('"'+old+'"',json.dumps(values[0],ensure_ascii=True))
    (folder/'QuestLayout.cs').write_text(source)
    caption=(root/'tools/quest_layout/ImageCaptions.cs').read_text()
    for role in SOURCES:caption=caption.replace('__'+role.upper()+'__',json.dumps(doc['imageCaptions'][role]['target'],ensure_ascii=True))
    (folder/'ImageCaptions.cs').write_text(caption)
    compiler=Path('/opt/homebrew/Cellar/dotnet@8/8.0.131/libexec/sdk/8.0.131/Roslyn/bincore/csc.dll')
    refs=sorted((directory/'references').glob('*.dll'));need(compiler.is_file() and refs,'caption-compiler-references')
    target=folder/'VNRevivalQuestLayout.dll'
    subprocess.run(['dotnet',str(compiler),'-nologo','-deterministic+','-target:library','-nostdlib+','-out:'+str(target)]+['-r:'+str(p) for p in refs]+[str(folder/'QuestLayout.cs'),str(folder/'ImageCaptions.cs')],check=True)
    shared=(root/'tools/forest_localization/Managed.cs').read_text().replace('static class Program {','static partial class Program {').replace('static void Main(','static void LegacyMain(')
    # Tree comparisons must use actual serialized instruction size after insertions.
    shared=shared.replace('m.Body.CodeSize<64','m.Body.Instructions.Sum(i=>i.GetSize())<64')
    (folder/'Shared.cs').write_text(shared)
    (folder/'CaptionPatch.cs').write_bytes((root/'tools/forest_localization/CaptionPatch.cs').read_bytes())
    cecil=root/'tools/locale_completion/resource_composition_v1/managed_saved/bin/Debug/net8.0/Mono.Cecil.dll'
    (folder/'Patch.csproj').write_text('<Project Sdk="Microsoft.NET.Sdk"><PropertyGroup><OutputType>Exe</OutputType><TargetFramework>net8.0</TargetFramework><ImplicitUsings>enable</ImplicitUsings><Nullable>enable</Nullable><EnableDefaultCompileItems>false</EnableDefaultCompileItems></PropertyGroup><ItemGroup><Compile Include="Shared.cs"/><Compile Include="CaptionPatch.cs"/><Reference Include="Mono.Cecil"><HintPath>'+str(cecil)+'</HintPath></Reference></ItemGroup></Project>')
    subprocess.run(['dotnet','build',str(folder/'Patch.csproj'),'--nologo','-v','quiet'],check=True)
    subprocess.run(['dotnet',str(folder/'bin/Debug/net8.0/Patch.dll'),str(folder/'original.dll'),str(folder/'old-helper.dll'),str(target),str(folder/'patched.dll'),str(folder/'assembly.json'),str(folder/'helper.json')],check=True)
    files[assembly]=(folder/'patched.dll').read_bytes();files[helper]=target.read_bytes()
    return [dict(asset=assembly,nativeImageCaptionPatch=json.loads((folder/'assembly.json').read_bytes())),dict(asset=helper,nativeImageCaptionPatch=json.loads((folder/'helper.json').read_bytes()))]
