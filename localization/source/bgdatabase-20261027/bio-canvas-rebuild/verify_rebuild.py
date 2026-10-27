#!/usr/bin/env python3
"""Reproduce bounded original Canvas/TMP metadata; never execute game code."""
import argparse
import hashlib
import json
import subprocess
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[3]
DATA = Path('/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest/The Forest of Love_Data')


def sha(p):
    h = hashlib.sha256()
    with p.open('rb') as f:
        for block in iter(lambda: f.read(4 * 1024 * 1024), b''):
            h.update(block)
    return h.hexdigest()


def load(p):
    return json.loads(p.read_text())


def ordered(text, *tokens):
    pos = 0
    for token in tokens:
        pos = text.index(token, pos) + len(token)


def body(text, signature):
    found = [s for s in text.split('METHOD ')[1:] if s.splitlines()[0].startswith(signature + ' |')]
    assert len(found) == 1, signature
    return found[0]


def exact_projection(raw, signatures):
    parts = raw.decode().split('METHOD ')
    selected = [b for b in parts[1:] if b.split(' |')[0] in signatures]
    assert len(selected) == len(signatures) and len(set(signatures)) == len(signatures)
    return (parts[0] + ''.join('METHOD ' + b for b in selected)).encode()


def check_pins(pins):
    for name, expected in pins.items():
        assert sha(Path(name) if Path(name).is_absolute() else ROOT / name) == expected, name


def verify(out):
    baseline = load(HERE / 'baseline.json')
    old_path = ROOT / baseline['priorBaseline']
    assert sha(old_path) == baseline['priorBaselineSha256']
    old = load(old_path)
    inherited_path = ROOT / old['inheritedBaseline']
    assert sha(inherited_path) == old['inheritedBaselineSha256']
    inherited = load(inherited_path)
    counts = {}
    for group in ('inputs', 'frozenPins', 'owningHelpers', 'processReferences', 'installedSources'):
        for name, expected in inherited[group].items():
            p = DATA / name if group == 'installedSources' else Path(name) if Path(name).is_absolute() else ROOT / name
            assert sha(p) == expected, (group, name)
        counts[group] = len(inherited[group])
    prior_path = ROOT / old['priorBaseline']
    assert sha(prior_path) == old['priorBaselineSha256']
    prior = load(prior_path)
    for pins in (baseline['priorFiles'], baseline['metadataPins'], old['priorFiles'], old['metadataPins'], old['helperPins'], prior['priorFiles'], prior['metadataPins']):
        check_pins(pins)
    check_pins(load(old_path.parent / 'helper-pins.json'))
    for name, archive in [('CHECKPOINT.json', 'previous-checkpoint.json'), ('README.md', 'previous-summary.md')]:
        assert sha(HERE / archive) == baseline['summaryPins'][name]
    dlls = [Path(n) for n in baseline['metadataPins'] if Path(n).parent == DATA / 'Managed' and n.endswith('.dll')]
    assert len(dlls) == 150
    assert {p.name for p in dlls} == {p.name for p in (DATA / 'Managed').glob('*.dll')}
    assert subprocess.check_output(['dotnet', '--version'], text=True).strip() == '8.0.131'
    subprocess.run(['dotnet', 'build', str(HERE / 'CanvasScopes.csproj'), '--nologo', '--verbosity', 'quiet'], capture_output=True, check=True)
    if (HERE / 'helper-pins.json').exists():
        check_pins(load(HERE / 'helper-pins.json'))
    texts = {}
    for row in load(HERE / 'il-commands.json'):
        assert row['exitCode'] == 0 and not row['stderr']
        r = subprocess.run(['dotnet', str(ROOT / 'tools/probe/bin/Debug/net8.0/InspectMethods.dll'), str(DATA / 'Managed' / row['assembly']), row['type'], row['selection']], capture_output=True, check=True)
        assert not r.stderr
        raw = r.stdout
        if 'signatures' in row:
            (out / row['rawOutput']).write_bytes(raw)
            assert sha(out / row['rawOutput']) == row['rawSha256'] == sha(HERE / row['rawOutput'])
            # Regression: name-only SetMaterial exports both overloads; the actual
            # consumer calls (Material,Int32), never the (Material,Texture) wrapper.
            assert 'SetMaterial(UnityEngine.Material,UnityEngine.Texture)' in raw.decode()
            raw = exact_projection(raw, row['signatures'])
            assert 'SetMaterial(UnityEngine.Material,UnityEngine.Texture)' not in raw.decode()
        (out / row['output']).write_bytes(raw)
        assert sha(out / row['output']) == row['sha256'] == sha(HERE / row['output'])
        texts[row['output']] = raw.decode()
    for row in load(HERE / 'scope-commands.json'):
        cmd = ['dotnet', str(HERE / 'bin/Debug/net8.0/CanvasScopes.dll'), str(DATA / 'Managed'), str(HERE / row['commands'])]
        if row['dispatch']:
            cmd.append(row['dispatch'])
        r = subprocess.run(cmd, capture_output=True, check=True)
        assert not r.stderr
        (out / row['output']).write_bytes(r.stdout)
        assert sha(out / row['output']) == row['sha256'] == sha(HERE / row['output'])
    scopes = load(out / 'dependency-scopes.json')
    for row in scopes['directMethodOperands']:
        d = row['definition']
        assert sha(DATA / 'Managed' / d['module']) == d['sha256']
    chains = {r['method']: r['chain'] for r in scopes['concreteRendererDispatch']}
    for name in ('Rebuild', 'UpdateMaterial', 'get_materialForRendering', 'UpdateMeshPadding'):
        assert len(chains[name]) == 1
        d = chains[name][0]['declarations']
        assert len(d) == 1 and d[0]['hasBody'] and d[0]['isVirtual'] and not d[0]['isNewSlot']
    assert len(chains['GenerateTextMesh']) == 1 and chains['GenerateTextMesh'][0]['declarations'][0]['isNewSlot']
    for name in ('LayoutComplete', 'GraphicUpdateComplete'):
        assert [r['type'] for r in chains[name]] == ['TMPro.TextMeshProUGUI', 'TMPro.TMP_Text', 'UnityEngine.UI.MaskableGraphic', 'UnityEngine.UI.Graphic']
        assert all(not r['declarations'] for r in chains[name][:-1])
        assert body(texts['graphic-completion.il'], 'System.Void UnityEngine.UI.Graphic::' + name + '()').splitlines()[1:] == ['IL_0000: ret']
    assert [r['type'] for r in chains['IsDestroyed']] == ['TMPro.TextMeshProUGUI', 'TMPro.TMP_Text', 'UnityEngine.UI.MaskableGraphic', 'UnityEngine.UI.Graphic', 'UnityEngine.EventSystems.UIBehaviour']
    assert all(not r['declarations'] for r in chains['IsDestroyed'][:-1])
    assert {r['name']: r['value'] for r in scopes['canvasUpdateValues']} == dict(Prelayout=0, Layout=1, PostLayout=2, PreRender=3, LatePreRender=4, MaxUpdateValue=5)
    update = texts['canvas-update.il']
    ordered(update, '::BeginSample(', '::CleanInvalidItems()', '::m_PerformingLayoutUpdate', '::Sort(', 'IL_0023: ldc.i4.0', 'ICanvasElement::Rebuild(', 'IL_006e: ldc.i4.2', 'ble.s IL_0027', '::LayoutComplete()', '::Clear()', 'stfld System.Boolean UnityEngine.UI.CanvasUpdateRegistry::m_PerformingLayoutUpdate', '::EndSample(', 'ClipperRegistry::Cull()', '::m_PerformingGraphicUpdate', 'IL_00c7: ldc.i4.3', 'ICanvasElement::Rebuild(', 'IL_012c: ldc.i4.5', 'blt.s IL_00cc', '::GraphicUpdateComplete()', '::Clear()', 'stfld System.Boolean UnityEngine.UI.CanvasUpdateRegistry::m_PerformingGraphicUpdate')
    eh = next(r['handlers'] for r in scopes['exceptionHandlers'] if r['caller'] == 'System.Void UnityEngine.UI.CanvasUpdateRegistry::PerformUpdate()')
    assert eh == [dict(kind='Catch', catchType='System.Exception', tryStart=56, tryEnd=74, handlerStart=74, handlerEnd=87, filterStart=None), dict(kind='Catch', catchType='System.Exception', tryStart=210, tryEnd=246, handlerStart=246, handlerEnd=271, filterStart=None)]
    assert all(not r['handlers'] for r in scopes['exceptionHandlers'] if r['caller'] != 'System.Void UnityEngine.UI.CanvasUpdateRegistry::PerformUpdate()')
    clean = body(texts['canvas-cleanup.il'], 'System.Void UnityEngine.UI.CanvasUpdateRegistry::CleanInvalidItems()')
    assert clean.count('::IsDestroyed()') == 2 and clean.count('::RemoveAt(') == 4
    ordered(clean, '::get_Count()', 'ldc.i4.1', 'sub', 'brtrue.s IL_002e', '::RemoveAt(', '::IsDestroyed()', '::RemoveAt(', '::LayoutComplete()', '::m_GraphicRebuildQueue', 'brtrue.s IL_007e', '::RemoveAt(', '::IsDestroyed()', '::RemoveAt(', '::GraphicUpdateComplete()')
    valid = body(texts['canvas-cleanup.il'], 'System.Boolean UnityEngine.UI.CanvasUpdateRegistry::ObjectValidForUpdate(UnityEngine.UI.ICanvasElement)')
    ordered(valid, 'cgt.un', 'isinst UnityEngine.Object', '::op_Inequality(')
    assert 'IsActive' not in valid
    ordered(texts['ui-destroyed.il'], 'ldnull', '::op_Equality(', 'ret')
    ordered(texts['indexed-remove.il'], '::m_Dictionary', '::Remove(!0)', 'pop', 'bne.un.s IL_0037', '::RemoveAt(', 'IL_0037: ldarg.0', '::get_Count()', 'ldc.i4.1', 'sub', '::get_Item(', '::set_Item(', '::m_Dictionary', '::set_Item(', '::RemoveAt(')
    rebuild = texts['tmp-rebuild.il']
    ordered(rebuild, '::op_Equality(', 'IL_0009: ret', 'ldarg.1', 'brtrue.s IL_0031', '::m_autoSizeTextContainer', '::GetPreferredValues(', 'RectTransform::set_sizeDelta(', 'IL_0031: ldarg.1', 'ldc.i4.3', 'bne.un.s IL_0051', '::OnPreRenderCanvas()', '::m_isMaterialDirty', 'Graphic::UpdateMaterial()', 'stfld System.Boolean TMPro.TMP_Text::m_isMaterialDirty')
    assert 'Graphic::Rebuild(' not in rebuild
    pre = texts['tmp-pre-render.il']
    ordered(pre, '::m_isAwake', '::IsActive()', '::m_ignoreActiveState', 'IL_0018: ret', '::m_canvas', 'Graphic::get_canvas()', 'IL_0041: ret', '::m_fontAsset', '::LogWarning(', 'IL_0070: ret', '::m_havePropertiesChanged', '::m_isLayoutDirty', '::checkPaddingRequired', '::UpdateMeshPadding()', '::ParseInputText()', '::UpdateFontFeaturesForFontAssetsInQueue()', '::m_enableAutoSizing', 'Mathf::Clamp(', 'stfld System.Boolean TMPro.TMP_Text::m_havePropertiesChanged', 'stfld System.Boolean TMPro.TMP_Text::m_isLayoutDirty', 'stfld System.Boolean TMPro.TMP_Text::m_ignoreActiveState', 'stfld System.Boolean TMPro.TMP_Text::m_IsAutoSizePointSizeSet', 'stfld System.Int32 TMPro.TMP_Text::m_AutoSizeIterationCount', '::GenerateTextMesh()', '::m_AutoSizeIterationCount', '::m_IsAutoSizePointSizeSet', 'brfalse.s IL_011c')
    assert 'm_AutoSizeMaxIterationCount' not in pre
    material = texts['tmp-update-material.il']
    ordered(material, '::m_sharedMaterial', '::op_Equality(', '::get_canvasRenderer()', 'IL_001c: ret', '::set_materialCount(', 'Graphic::get_materialForRendering()', '::SetMaterial(UnityEngine.Material,System.Int32)')
    assert texts['native-material-boundary.il'].count('impl=InternalCall') == 2 and 'IL_' not in texts['native-material-boundary.il']
    assert len(scopes['directMethodOperands']) == 67
    wide = load(out / 'dependency-scopes-name-selection.json')
    assert len(wide['directMethodOperands']) == 71
    assert not any('UnityEngine.Texture)' in r['caller'] for r in scopes['directMethodOperands'])
    methods = [b for t in texts.values() for b in t.split('METHOD ')[1:]]
    result = dict(status='passed-static-scoped', metadataSelections=len(texts), methodDeclarations=len(methods), methodBodies=sum('\nIL_' in b for b in methods), nativeDeclarations=sum('impl=InternalCall' in b.splitlines()[0] for b in methods), directResolvedMethodOperands=len(scopes['directMethodOperands']), concreteDispatchChains=len(chains), exceptionHandlers=len(eh), modulesResolved=sorted({r['definition']['module'] for r in scopes['directMethodOperands']}), retainedInputChecks=counts, metadataDllsPinned=len(dlls), retainedPhase94Files=len(baseline['priorFiles']), retainedPhase93Files=len(old['priorFiles']), retainedPhase92Files=len(prior['priorFiles']), reproducedSubstantiveOutputs=len(texts)+6, incidentalNameSelectionOverloads=1, incidentalExtraResolvedOperands=4, originalResourceReads=0, noMocks=True, gameAssemblyExecuted=False, gameLaunches=0, imagesOpened=0, gitMutations=0, authoredTranslations=0, sourceAcceptance='needs-review', editorial='not-run', runtime='not-run', visual='not-run', delivery='needs-review', usage=None)
    (out / 'verification.json').write_text(json.dumps(result, indent=2) + '\n')
    return result


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', required=True, type=Path)
    out = parser.parse_args().output.resolve()
    assert HERE in out.parents and not out.exists()
    out.mkdir()
    print(json.dumps(verify(out)))
