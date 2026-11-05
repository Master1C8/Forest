"""Registered native caption repair; data stays in the language document."""
import json, subprocess
from pathlib import Path

SOURCES={'gallery':'Gallery','residents':'Residents'}

def validate(doc, need):
    need(type(doc.get('questMinimumPointSize',12)) is int and 8<=doc.get('questMinimumPointSize',12)<=12,'quest-minimum-point-size')
    status_minimum=doc.get('questStatusHeadingMinimumPointSize',12)
    need(type(status_minimum)is int and 8<=status_minimum<=12,'quest-status-heading-minimum-point-size')
    single_line=doc.get('questStatusHeadingSingleLineFit',False)
    need(type(single_line)is bool,'quest-status-heading-single-line-boolean')
    need(not single_line or not doc.get('complexText'),'single-line-status-fit-requires-native-renderer')
    scale=doc.get('galleryCounterScale',1)
    need(type(scale) in (int,float) and .6<=scale<=1,'gallery-counter-scale')
    need(type(doc.get('residentTextLayout', False)) is bool,'resident-layout-boolean')
    heading_scale=doc.get('critterHeadingScale',1);heading_lift=doc.get('residentPreferenceHeadingLift',0)
    need(type(heading_scale)in(int,float)and .6<=heading_scale<=1,'critter-heading-scale')
    need(type(heading_lift)in(int,float)and 0<=heading_lift<=6,'resident-preference-heading-lift')
    need(heading_lift==0 or doc.get('residentTextLayout',False),'resident-heading-lift-requires-reflow')
    captions=doc.get('imageCaptions')
    if captions is None:
        need(status_minimum==12,'status-heading-fit-requires-caption-input')
        need(not single_line,'single-line-status-fit-requires-caption-input')
        need(not doc.get('imageCaptionSizes'),'caption-sizes-require-caption-input')
        need(not doc.get('residentTextLayout'),'resident-layout-requires-caption-input')
        need(scale==1,'counter-scale-requires-caption-input')
        need(heading_scale==1 and heading_lift==0,'resident-heading-layout-requires-caption-input')
        return
    need(isinstance(captions,dict) and set(captions)==set(SOURCES),'exact-registered-image-caption-roles')
    for role,source in SOURCES.items():
        row=captions[role]
        need(isinstance(row,dict) and set(row)=={'source','target'} and row['source']==source and
             isinstance(row['target'],str) and row['target'].strip() and not any(c in row['target'] for c in '\x00\r\n'),
             'registered-image-caption:'+role)
    sizes=doc.get('imageCaptionSizes',{})
    need(isinstance(sizes,dict) and set(sizes)<=set(SOURCES),'registered-image-caption-size-roles')
    for role,size in sizes.items():need(type(size)==int and 12<=size<=64,'image-caption-size:'+role)

def build(doc, files, root, directory, work, need, complex_directory=None):
    if 'imageCaptions' not in doc:return []
    assembly='Managed/Assembly-CSharp.dll';helper='Managed/VNRevivalQuestLayout.dll'
    folder=work/'image-captions';folder.mkdir()
    (folder/'original.dll').write_bytes(files[assembly]);(folder/'old-helper.dll').write_bytes(files[helper])
    source=(root/'tools/quest_layout/QuestLayout.cs').read_text()
    status_guard='text.resizeTextMinSize=12;text.resizeTextMaxSize=18;'
    need(source.count(status_guard)==1,'exact-status-heading-fit-selector')
    source=source.replace(status_guard,'text.resizeTextMinSize='+str(doc.get('questStatusHeadingMinimumPointSize',12))+';text.resizeTextMaxSize=18;')
    if doc.get('questStatusHeadingSingleLineFit'):
        slot='text.text=value;image.enabled=false;'
        need(source.count(slot)==1,'exact-native-status-single-line-selector')
        fit='''text.text=value;
            // Wrap with vertical overflow lets native best-fit retain two lines.
            // Measure the assigned text unwrapped, at each actual native size.
            text.resizeTextForBestFit=false;text.horizontalOverflow=HorizontalWrapMode.Overflow;
            float availableWidth=text.rectTransform.rect.width-2,availableHeight=text.rectTransform.rect.height-2;
            bool fitted=false;
            for(int point=18;point>=__MINIMUM__;point--){text.fontSize=point;if(text.preferredWidth<=availableWidth&&text.preferredHeight<=availableHeight){fitted=true;break;}}
            if(!fitted)throw new InvalidOperationException("Native quest status heading does not fit its original band");
            image.enabled=false;'''
        source=source.replace(slot,fit.replace('__MINIMUM__',str(doc.get('questStatusHeadingMinimumPointSize',12))))
    minimum=str(doc.get('questMinimumPointSize',12))
    for old in ['Math.Max(12,s.descriptionPointSize-reduction)','Math.Max(12,s.historyPointSizes[i]-reduction)', 'Mathf.Max(s.historyPointSizes))-12;float needed=0;']:
        need(source.count(old)==1,'exact-quest-minimum-selector')
        source=source.replace(old,old.replace('12',minimum,1))
    # Keep the already-authored status words from this exact language version.
    for old in ['Завершённые','Активные']:
        values=[r['target'] for key,r in doc['translations'].items() if '::RussianStatusHeadings(' in key and r['source']==('Completed' if old=='Завершённые' else 'Active')]
        need(len(values)==1,'caption-status-wording')
        source=source.replace('"'+old+'"',json.dumps(values[0],ensure_ascii=True))
    (folder/'QuestLayout.cs').write_text(source)
    caption=(root/'tools/quest_layout/ImageCaptions.cs').read_text()
    heading_layout=doc.get('critterHeadingScale',1)!=1 or doc.get('residentPreferenceHeadingLift',0)!=0
    if not heading_layout:
        slot='        preferenceHeadingLift=__PREFERENCE_HEADING_LIFT__;ScaleCritterHeading(owner,__CRITTER_HEADING_SCALE__);\n'
        need(caption.count(slot)==1,'exact-optional-log-heading-bootstrap')
        caption=caption.replace(slot,'')
    for role in SOURCES:caption=caption.replace('__'+role.upper()+'__',json.dumps(doc['imageCaptions'][role]['target'],ensure_ascii=True))
    for role,default in [('gallery',50),('residents',18)]:caption=caption.replace('__'+role.upper()+'_SIZE__',str(doc.get('imageCaptionSizes',{}).get(role,default)))
    caption=caption.replace('__RESIDENT_REFLOW__',str(doc.get('residentTextLayout',False)).lower())
    caption=caption.replace('__GALLERY_COUNTER_SCALE__',str(doc.get('galleryCounterScale',1))+'f')
    caption=caption.replace('__CRITTER_HEADING_SCALE__',str(doc.get('critterHeadingScale',1))+'f')
    caption=caption.replace('__PREFERENCE_HEADING_LIFT__',str(doc.get('residentPreferenceHeadingLift',0))+'f')
    from forest_localization import complex_text
    extra_sources,extra_args=complex_text.compiler_inputs(root,folder,complex_directory)
    if complex_directory is not None:
        caption=caption.replace('public static void Gallery(Component owner) {','public static void Gallery(Component owner) {ForestComplexText.Runtime.Install();')
        source=source.replace('static Vector2 InkY(Text text,RectTransform relative) {','static Vector2 InkY(Text text,RectTransform relative) { Vector2 shaped; if(ForestComplexText.LegacyMirror.TryInkY(text,relative,out shaped))return shaped;')
        (folder/'QuestLayout.cs').write_text(source)
    (folder/'ImageCaptions.cs').write_text(caption)
    resident=(root/'tools/quest_layout/ResidentTextBody.cs').read_text()
    if not heading_layout:
        slot='            kinksTitle.rectTransform.anchoredPosition+=new Vector2(0,preferenceHeadingLift);\n'
        need(resident.count(slot)==1,'exact-optional-resident-heading-lift')
        resident=resident.replace(slot,'')
    (folder/'ResidentTextBody.cs').write_text(resident)
    (folder/'GalleryCounterLayout.cs').write_bytes((root/'tools/quest_layout/GalleryCounterLayout.cs').read_bytes())
    names=['QuestLayout.cs','ImageCaptions.cs','ResidentTextBody.cs','GalleryCounterLayout.cs']
    if heading_layout:
        (folder/'LogHeadingLayout.cs').write_bytes((root/'tools/quest_layout/LogHeadingLayout.cs').read_bytes());names.append('LogHeadingLayout.cs')
    compiler=Path('/opt/homebrew/Cellar/dotnet@8/8.0.131/libexec/sdk/8.0.131/Roslyn/bincore/csc.dll')
    refs=sorted((directory/'references').glob('*.dll'));need(compiler.is_file() and refs,'caption-compiler-references')
    target=folder/'VNRevivalQuestLayout.dll'
    subprocess.run(['dotnet',str(compiler),'-nologo','-deterministic+','-target:library','-nostdlib+','-out:'+str(target)]+extra_args+['-r:'+str(p) for p in refs]+[str(folder/name) for name in names]+[str(p) for p in extra_sources],check=True)
    shared=(root/'tools/forest_localization/Managed.cs').read_text().replace('static class Program {','static partial class Program {').replace('static void Main(','static void LegacyMain(')
    # Tree comparisons must use actual serialized instruction size after insertions.
    shared=shared.replace('m.Body.CodeSize<64','m.Body.Instructions.Sum(i=>i.GetSize())<64')
    (folder/'Shared.cs').write_text(shared)
    (folder/'CaptionPatch.cs').write_bytes((root/'tools/forest_localization/CaptionPatch.cs').read_bytes())
    cecil=root/'tools/locale_completion/resource_composition_v1/managed_saved/bin/Debug/net8.0/Mono.Cecil.dll'
    (folder/'Patch.csproj').write_text('<Project Sdk="Microsoft.NET.Sdk"><PropertyGroup><OutputType>Exe</OutputType><TargetFramework>net8.0</TargetFramework><ImplicitUsings>enable</ImplicitUsings><Nullable>enable</Nullable><EnableDefaultCompileItems>false</EnableDefaultCompileItems></PropertyGroup><ItemGroup><Compile Include="Shared.cs"/><Compile Include="CaptionPatch.cs"/><Reference Include="Mono.Cecil"><HintPath>'+str(cecil)+'</HintPath></Reference></ItemGroup></Project>')
    subprocess.run(['dotnet','build',str(folder/'Patch.csproj'),'--nologo','-v','quiet'],check=True)
    subprocess.run(['dotnet',str(folder/'bin/Debug/net8.0/Patch.dll'),str(folder/'original.dll'),str(folder/'old-helper.dll'),str(target),str(folder/'patched.dll'),str(folder/'assembly.json'),str(folder/'helper.json')],check=True)
    if complex_directory is not None:
        receipt=json.loads((complex_directory/'receipt.json').read_bytes())
        need(json.loads((folder/'helper.json').read_bytes())['shapingMapSha256']==receipt['mapSha256'],'embedded-shaping-map-readback')
    files[assembly]=(folder/'patched.dll').read_bytes();files[helper]=target.read_bytes()
    return [dict(asset=assembly,nativeImageCaptionPatch=json.loads((folder/'assembly.json').read_bytes())),dict(asset=helper,nativeImageCaptionPatch=json.loads((folder/'helper.json').read_bytes()))]
