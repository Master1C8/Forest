"""Prepare one immutable Arabic native shaping probe without changing locale data."""
from pathlib import Path
import base64, hashlib, json, os, subprocess, sys

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT/'tools'))
sys.path.insert(0, str(Path(__file__).parent))

def sha(p): return hashlib.sha256(p.read_bytes()).hexdigest()
def write(p, v): p.write_text(json.dumps(v, ensure_ascii=False, indent=2)+'\n')

def fonts(run):
    from font_shaping import FontAugmenter, validate_shaped_value, FONTTOOLS_VERSION, UHARFBUZZ_VERSION
    import fontTools, uharfbuzz
    assert (fontTools.__version__, uharfbuzz.__version__) == (FONTTOOLS_VERSION, UHARFBUZZ_VERSION)
    spec = dict(script='arab', language='ar', baseDirection='R', ranges=((0x0600,0x06FF),(0x0750,0x077F),(0x08A0,0x08FF)))
    source = ROOT/'localization/fonts/complex-sources/NotoSansArabicLatin-Regular.ttf'
    augmenter = FontAugmenter(source, spec)
    values = set()
    old = ROOT/'localization/probes/locale-owner-shots-20261104-ar-02'
    for n, prefix in [(1,'Canvas/MainMenu/'),(2,'Canvas/OptionsMenu/'),(3,'Canvas/GalleryMenu/')]:
        snapshot = json.loads((old/f'state-before-{n}.json').read_bytes())
        values.update(base64.b64decode(r.split('\t')[1]).decode() for r in snapshot['texts'] if r.startswith(prefix))
    samples = ['العربية (١٢٣) — [456]', 'مرحبًا يا Scarlett!', 'الكاميرا 12/34 — TFoL.info',
        'التاريخ 2026-11-05', '<color=#88FFAA>النص العربي</color> <i>Latin</i>',
        '  العربية مع ١٢٣ و456  ', 'Scarlett 12/34 — 2026-11-05']
    values.update(samples)
    (run/'probe-language.json').write_bytes((ROOT/'localization/languages/ar.json').read_bytes())
    exact = {}
    for logical in sorted(values):
        shaped = augmenter.shape_rich_text(logical)
        validate_shaped_value(logical, shaped, augmenter, 'bounded native probe')
        if logical != shaped: exact[logical] = shaped
    samples.append('الكاميرا 12/34 — TFoL.info')
    (run/'samples.txt').write_text('\n'.join(samples)+'\n')
    rows = ['VNREVIVAL1\t1\t1']
    for kind, items in [('E', exact), ('S', augmenter.span_mappings)]:
        rows.extend(kind+'\t'+base64.b64encode(a.encode()).decode()+'\t'+base64.b64encode(b.encode()).decode() for a,b in sorted(items.items()))
    (run/'shaping-map.tsv').write_text('\n'.join(rows)+'\n')
    augmenter.save(run/'probe-shaped.ttf')
    write(run/'shaping.json',dict(source=str(source),sourceSha256=sha(source),fontSha256=sha(run/'probe-shaped.ttf'),
        mapSha256=sha(run/'shaping-map.tsv'),exactStrings=len(exact),spans=len(augmenter.span_mappings),glyphInstances=augmenter.rows,
        samplesLogical=samples[:-1]+['PREPARED: '+samples[2]],scope='Native feasibility only; no locale JSON changed'))

def resources(run):
    from forest_localization.core import engines
    from forest_localization.font_metrics import face_metrics, native_font, tmp_font
    U, Generator, tree, canonical, comp, inv, writer = engines()
    data = run/'game.app/Contents/Resources/Data'
    gen = Generator('2020.3.24f1'); gen.load_local_dll_folder(str(data/'Managed'))
    font = (run/'probe-shaped.ttf').read_bytes(); metrics = face_metrics(font, 'Noto Sans')
    proof = []
    doc=json.loads((run/'probe-language.json').read_bytes())
    for name, ids in [('resources.assets',[436,438,439]),('sharedassets0.assets',[368,369]),('level1',[])]:
        path = data/name; before = path.read_bytes(); original = U.load(before); env = U.load(before)
        original.path = env.path = str(data); obs = comp.objects(env); expected = {}
        for pid in ids: expected[pid] = native_font(tree(obs[pid],gen),font,metrics)
        if name == 'resources.assets': expected[1017] = tmp_font(tree(obs[1017],gen),metrics,439,'probe-shaped.ttf')
        if name == 'level1':
            for role,size in doc.get('layout',{}).items():
                if not role.startswith('level1:'):continue
                pid=int(role.split(':')[1]);current=tree(obs[pid],gen)
                assert 'm_fontSize' in current
                if current['m_fontSize']!=size:
                    current['m_fontSize']=size;expected[pid]=current
        for pid,t in expected.items(): writer(obs[pid],t,gen)
        raw = env.file.save(); saved = U.load(raw); saved.path = str(data)
        import extract_assets
        receipt = comp.verify_resource(original,saved,expected,extract_assets,gen)
        saved_obs, original_obs = comp.objects(saved), comp.objects(original)
        for pid in expected: saved_obs[pid].set_raw_data(original_obs[pid].get_raw_data())
        assert saved.file.save() == before, 'Exact reversal of non-font bytes'
        path.write_bytes(raw); proof.append(dict(asset=name,beforeSha256=hashlib.sha256(before).hexdigest(),afterSha256=sha(path),wholeContainerReversal=True,**receipt))
    write(run/'probe-resource-proof.json',proof)
    from forest_localization.tmp_renderer import build
    patched={};extra=run/'tmp-patch';extra.mkdir()
    def need(value,message):
        if not value:raise ValueError(message)
    receipts=build({'complexText':True},patched,ROOT,ROOT/'localization/framework/forest045-shared',extra,need)
    (data/'Managed/Unity.TextMeshPro.dll').write_bytes(patched['Managed/Unity.TextMeshPro.dll'])
    write(run/'tmp-route-proof.json',receipts)

def main():
    if len(sys.argv)>1 and sys.argv[1]=='resources': return resources(Path(sys.argv[2]))
    import capture_language_screens as capture
    attempt = sys.argv[sys.argv.index('--attempt')+1] if '--attempt' in sys.argv else 'shape01'
    assert attempt.isalnum()
    run = ROOT/'localization/probes'/('locale-owner-shots-20261104-ar-'+attempt)
    resume = '--resume-prelaunch' in sys.argv
    if resume:
        assert run.exists() and not (run/'launch.json').exists() and not (run/'build.json').exists()
        (run/'execution/source').rename(run/'execution/source-failed-compile-01')
    else:
        assert not run.exists(); run.mkdir(); fonts(run)
    frozen = capture.freeze(run)
    cs = (frozen/'NativeCaptureProbe.cs').read_text()
    cs = cs.replace('void Awake() {', 'void Awake() { ForestComplexText.ProbeAdapter.Install(Root);')
    cs = cs.replace('if(cmd=="dump")Dump();', 'if(cmd=="shape-samples")ForestComplexText.ProbeAdapter.Samples();\n            else if(cmd=="dump")Dump();')
    marker='s.texts=texts.ToArray();'
    assert cs.count(marker)==1
    if 'render-ready|' not in cs: cs=cs.replace(marker,"""
        foreach(var t in Resources.FindObjectsOfTypeAll<TextMeshProUGUI>())
            if(t.gameObject.activeInHierarchy && (Address(t.transform).StartsWith(\"Canvas/MainMenu/\") || Address(t.transform).StartsWith(\"Canvas/GalleryMenu/\")))
                details.Add(\"render-ready|\"+Address(t.transform)+\"|alpha=\"+(t.color.a*t.canvasRenderer.GetAlpha()*t.canvasRenderer.GetInheritedAlpha()).ToString(System.Globalization.CultureInfo.InvariantCulture)+\"|chars=\"+t.textInfo.characterCount+\"|cull=\"+t.canvasRenderer.cull);
        """+marker)

    for name in ['TextShaper.cs','Processor.cs','Runtime.cs','ProbeAdapter.cs','LegacyMirror.cs','BidiForForest.cs','BidiOrder.cs','MirrorGlyph.cs']:
        p=Path(__file__).parent/name; (frozen/name).write_bytes(p.read_bytes())
        body = p.read_text().replace('__LEGACY_ENABLED__',str('--legacy' in sys.argv).lower())
        imports = [r for r in body.splitlines() if r.startswith('using ')]
        body = '\n'.join(r for r in body.splitlines() if not r.startswith('using '))
        cs = '\n'.join(imports)+'\n'+cs+'\n'+body
    for name in ['BidiClass.cs','Bidi_types.cs']:
        p=Path(__file__).parent/'vendor/BidiSharp/BidiSharp/Source'/name
        (frozen/name).write_bytes(p.read_bytes());cs+='\n'+p.read_text()
    (frozen/'NativeCaptureProbe.cs').write_text(cs)
    p=frozen/'prepare_native_capture.py';s=p.read_text()
    old="'-nostdlib+','-out:'+str(execution/'ForestProbe.dll')"
    assert s.count(old)==1
    s=s.replace(old,old+",'-resource:'+str(RUN/'shaping-map.tsv')+',VNRevival.ShapingMap'")
    p.write_text(s)
    family=ROOT/'localization/screenshots/all30-owner-20261104-01'
    plan=json.loads((family/'plan.json').read_bytes())
    env=dict(os.environ,FOREST_CAPTURE_RUN=run.name,FOREST_CAPTURE_LOCALE='ar',FOREST_CAPTURE_SOURCE=plan['sourceFixture'],
        FOREST_CAPTURE_OVERLAY=str(ROOT/'dist/all30-owner-screens-native-delta/ar/01'))
    with (run/('preparation-02.log' if resume else 'preparation.log')).open('wb') as log:
        subprocess.run([str(ROOT/'.venv-assets314/bin/python'),'-B',str(p)]+(['--resume-prelaunch'] if resume else []),env=env,check=True,stdout=log,stderr=subprocess.STDOUT)
        subprocess.run([str(ROOT/'.venv-assets314/bin/python'),'-B',str(Path(__file__)),'resources',str(run)],check=True,stdout=log,stderr=subprocess.STDOUT)
        subprocess.run(['codesign','--force','--deep','--sign','-',str(run/'game.app')],check=True,stdout=log,stderr=subprocess.STDOUT)
    write(run/'probe-preparation.json',dict(scope='Arabic TMP native feasibility',logicalLocaleSha256=sha(ROOT/'localization/languages/ar.json'),
        sourcePins={str(p.relative_to(ROOT)):sha(p) for p in [Path(__file__),*sorted(Path(__file__).parent.glob('*.cs')),Path(__file__).parent/'font_shaping.py']},
        frozenPins={p.name:sha(p) for p in frozen.iterdir()},fontResourcesProofSha256=sha(run/'probe-resource-proof.json')))
    print(run)

if __name__=='__main__': main()
