"""Optional registered complex-script font/display adapter, owned by one compiler."""
import hashlib,json,subprocess
from pathlib import Path

LOCALES={'ar','fa','he','hi','th'}
SOURCES=['TextShaper.cs','Processor.cs','Runtime.cs','LegacyMirror.cs','BidiForForest.cs','BidiOrder.cs','MirrorGlyph.cs',
 'vendor/BidiSharp/BidiSharp/Source/BidiClass.cs','vendor/BidiSharp/BidiSharp/Source/Bidi_types.cs']

def validate(doc,need):
    need(type(doc.get('complexText',False)) is bool,'complex-text-boolean')
    if not doc.get('complexText'):
        need(not doc.get('complexTextLayout'),'complex-layout-requires-renderer');return
    need(doc['locale'] in LOCALES,'registered-complex-script-locale')
    need(bool(doc.get('fonts')) and len({r['asset'] for r in doc['fonts'].values()})==1,'one-explicit-complex-font-face')
    need(bool(doc.get('imageCaptions')),'complex-text-requires-shared-bootstrap')
    layout=doc.get('complexTextLayout',{})
    need(isinstance(layout,dict) and set(layout)<={'critterHeadingLift','critterHeadingShiftX'},'registered-complex-layout')
    need(all(type(v) in (int,float) and 0<=v<=8 for v in layout.values()),'complex-heading-lift-bounds')

def prepare(doc,root,work,need):
    if not doc.get('complexText'):return doc,None
    language=work/'complex-language.json';language.write_text(json.dumps(doc,ensure_ascii=False,sort_keys=True,indent=2)+'\n')
    target=work/'complex-text';interpreter=root/'.venv-shaping/bin/python'
    need(interpreter.is_file(),'missing-pinned-shaping-interpreter')
    subprocess.run([str(interpreter),'-B',str(root/'tools/complex_text/prepare_corpus.py'),'--language',str(language),'--output',str(target)],check=True)
    check=work/'complex-runtime-check';check.mkdir()
    names=['CorpusTests.cs','TextShaper.cs','BidiForForest.cs','BidiOrder.cs','MirrorGlyph.cs',
        'vendor/BidiSharp/BidiSharp/Source/BidiClass.cs','vendor/BidiSharp/BidiSharp/Source/Bidi_types.cs']
    pins={};sources=[]
    for name in names:
        data=(root/'tools/complex_text'/name).read_bytes();p=check/Path(name).name;p.write_bytes(data);sources.append(p)
        pins[name]=hashlib.sha256(data).hexdigest()
    project=check/'CorpusTests.csproj'
    project.write_text('<Project Sdk="Microsoft.NET.Sdk"><PropertyGroup><OutputType>Exe</OutputType><TargetFramework>net8.0</TargetFramework><EnableDefaultCompileItems>false</EnableDefaultCompileItems></PropertyGroup><ItemGroup>'+''.join('<Compile Include="'+str(p)+'"/>' for p in sources)+'<EmbeddedResource Include="'+str(target/'shaping-map.tsv')+'" LogicalName="VNRevival.ShapingMap"/></ItemGroup></Project>')
    result=subprocess.run(['dotnet','run','--project',str(project),'--',str(language)],check=True,capture_output=True,text=True)
    gate=json.loads(result.stdout.splitlines()[-1]);need(gate['failed']==0 and gate['checkedValues']==len(doc['translations']),'complete-display-corpus-gate')
    receipt=json.loads((target/'receipt.json').read_bytes());receipt['runtimeCorpusGate']=dict(**gate,sourcePins=pins)
    (target/'receipt.json').write_text(json.dumps(receipt,indent=2)+'\n')
    result=json.loads((target/'font-input.json').read_bytes());need(result['translations']==doc['translations'],'logical-wording-preserved')
    return result,target

def compiler_inputs(root,folder,derived):
    if derived is None:return [],[]
    sources=[]
    for name in SOURCES:
        target=folder/('Complex-'+Path(name).name);target.write_bytes((root/'tools/complex_text'/name).read_bytes());sources.append(target)
    return sources,['-resource:'+str(derived/'shaping-map.tsv')+',VNRevival.ShapingMap']
