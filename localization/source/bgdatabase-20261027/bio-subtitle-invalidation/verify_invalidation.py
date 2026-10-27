#!/usr/bin/env python3
"""Reproduce phase94 bounded original metadata; never execute game assemblies."""
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
    found = [v for v in text.split('METHOD ')[1:] if v.splitlines()[0].startswith(signature + ' |')]
    assert len(found) == 1, signature
    return found[0]


def verify(out):
    baseline = load(HERE / 'baseline.json')
    inherited_path = ROOT / baseline['inheritedBaseline']
    assert sha(inherited_path) == baseline['inheritedBaselineSha256']
    inherited = load(inherited_path)
    counts = {}
    for group in ('inputs', 'frozenPins', 'owningHelpers', 'processReferences', 'installedSources'):
        for name, expected in inherited[group].items():
            p = DATA / name if group == 'installedSources' else Path(name) if Path(name).is_absolute() else ROOT / name
            assert sha(p) == expected, (group, name)
        counts[group] = len(inherited[group])
    prior = ROOT / baseline['priorBaseline']
    assert sha(prior) == baseline['priorBaselineSha256']
    old = load(prior)
    for group in ('priorFiles', 'metadataPins'):
        for name, expected in old[group].items():
            assert sha(Path(name) if Path(name).is_absolute() else ROOT / name) == expected, name
    for group in ('priorFiles', 'metadataPins', 'helperPins'):
        for name, expected in baseline[group].items():
            assert sha(Path(name) if Path(name).is_absolute() else ROOT / name) == expected, name
    for name, archive in [('README.md', 'previous-summary.md'), ('CHECKPOINT.json', 'previous-checkpoint.json')]:
        assert sha(HERE / archive) == baseline['summaryPins'][name]
    dlls = [Path(n) for n in baseline['metadataPins'] if Path(n).parent == DATA / 'Managed' and n.endswith('.dll')]
    assert len(dlls) == 150
    assert {p.name for p in dlls} == {p.name for p in (DATA / 'Managed').glob('*.dll')}
    assert subprocess.check_output(['dotnet', '--version'], text=True).strip() == '8.0.131'
    subprocess.run(['dotnet', 'build', str(HERE / 'InvalidationScopes.csproj'), '--nologo', '--verbosity', 'quiet'], check=True, capture_output=True)
    for name, expected in load(HERE / 'helper-pins.json').items():
        assert sha(ROOT / name) == expected, name
    texts = {}
    helper = ROOT / 'tools/probe/bin/Debug/net8.0/InspectMethods.dll'
    for row in load(HERE / 'il-commands.json'):
        assert row['exitCode'] == 0 and not row['stderr']
        r = subprocess.run(['dotnet', str(helper), str(DATA / 'Managed' / row['assembly']), row['type'], row['selection']], capture_output=True, check=True)
        assert not r.stderr
        p = out / row['output']
        p.write_bytes(r.stdout)
        assert sha(p) == row['sha256'] == sha(HERE / row['output']), row['output']
        texts[row['output']] = r.stdout.decode()
    r = subprocess.run(['dotnet', str(HERE / 'bin/Debug/net8.0/InvalidationScopes.dll'), str(DATA / 'Managed'), str(HERE / 'il-commands.json')], capture_output=True, check=True)
    assert not r.stderr
    (out / 'dependency-scopes.json').write_bytes(r.stdout)
    assert sha(out / 'dependency-scopes.json') == sha(HERE / 'dependency-scopes.json')
    scopes = json.loads(r.stdout)
    for row in scopes['directMethodOperands']:
        d = row['definition']
        assert sha(DATA / 'Managed' / d['module']) == d['sha256']
    dispatch = {v['method']: v['chain'] for v in scopes['concreteRendererDirtyDispatch']}
    for name in ('SetVerticesDirty', 'SetLayoutDirty'):
        assert len(dispatch[name]) == 1
        declaration = dispatch[name][0]['declarations']
        assert len(declaration) == 1 and declaration[0]['hasBody']
        assert 'Virtual' in declaration[0]['attributes'] and 'VtableLayoutMask' not in declaration[0]['attributes']
    assert [r['type'] for r in dispatch['IsActive']] == ['TMPro.TextMeshProUGUI', 'TMPro.TMP_Text', 'UnityEngine.UI.MaskableGraphic', 'UnityEngine.UI.Graphic', 'UnityEngine.EventSystems.UIBehaviour']
    assert all(not r['declarations'] for r in dispatch['IsActive'][:-1])
    pre = texts['panel-prewrite.il']
    get = body(pre, 'PixelCrushers.DialogueSystem.Subtitle PixelCrushers.DialogueSystem.StandardUISubtitlePanel::get_currentSubtitle()')
    set_ = body(pre, 'System.Void PixelCrushers.DialogueSystem.StandardUISubtitlePanel::set_currentSubtitle(PixelCrushers.DialogueSystem.Subtitle)')
    assert get.count('ldfld ') == 1 and '::m_currentSubtitle' in get and ': call' not in get
    assert set_.count('stfld ') == 1 and '::m_currentSubtitle' in set_ and ': call' not in set_
    check = body(pre, 'System.Void PixelCrushers.DialogueSystem.StandardUISubtitlePanel::CheckSubtitleAnimator(PixelCrushers.DialogueSystem.Subtitle)')
    ordered(check, 'brfalse IL_00e0', '::useAnimatedPortraits', 'brfalse IL_00e0', '::get_animator()', '::GetDialogueActorComponent(', '::GetSubtitlePanelNumber()', '::get_actorOverridingPanel()', '::GetSubtitlePanelIndex(', '::get_panelNumber()', '::get_isDefaultNPCPanel()', '::get_isDefaultPCPanel()', '::customSubtitlePanel', '::portraitAnimatorController', '::SetAnimatorAtEndOfFrame(', '::StartCoroutine(', 'IL_00d2: ldarg.0', 'IL_00d4: ldnull', '::SetAnimatorAtEndOfFrame(', '::StartCoroutine(')
    access = texts['panel-animator-access.il']
    ordered(access, '::m_animator', '::portraitImage', 'GetComponent<UnityEngine.Animator>()', 'stfld UnityEngine.Animator')
    assert '<SetAnimatorAtEndOfFrame>d__109' in access and '::MoveNext()' not in access
    dirty = texts['tmp-dirty.il']
    verts = body(dirty, 'System.Void TMPro.TextMeshProUGUI::SetVerticesDirty()')
    ordered(verts, '::op_Equality(', '::IsActive()', 'IL_0011: ret', '::IsRebuildingGraphics()', 'IL_0019: ret', '::RegisterCanvasElementForGraphicRebuild(', '::m_OnDirtyVertsCallback', 'UnityAction::Invoke()')
    assert '::m_VertsDirty' not in verts and 'Graphic::SetVerticesDirty()' not in verts
    layout = body(dirty, 'System.Void TMPro.TextMeshProUGUI::SetLayoutDirty()')
    ordered(layout, '::m_isPreferredWidthDirty', '::m_isPreferredHeightDirty', '::op_Equality(', '::IsActive()', 'IL_001f: ret', '::get_rectTransform()', '::MarkLayoutForRebuild(', '::m_isLayoutDirty', '::m_OnDirtyLayoutCallback', 'UnityAction::Invoke()')
    queue = texts['canvas-queue.il']
    ordered(queue, '::s_Instance', 'CanvasUpdateRegistry::.ctor()', 'stsfld', '::m_PerformingGraphicUpdate', 'brfalse.s IL_001a', 'Debug::LogError(', 'ldc.i4.0', 'IL_0019: ret', '::m_GraphicRebuildQueue', '::AddUnique(T)')
    ordered(texts['indexed-queue.il'], '::ContainsKey(', 'brfalse.s IL_0010', 'IL_000e: ldc.i4.0', 'IL_000f: ret', '::m_List', '::Add(!0)', '::m_Dictionary', '::get_Count()', 'ldc.i4.1', 'sub', '::Add(!0,!1)', 'ldc.i4.1', 'ret')
    ordered(texts['canvas-layout-queue.il'], '::m_LayoutRebuildQueue', '::Contains(T)', 'brfalse.s IL_0010', 'ldc.i4.0', 'ret', '::m_LayoutRebuildQueue', '::AddUnique(T)')
    assert 'm_PerformingLayoutUpdate' not in texts['canvas-layout-queue.il']
    ordered(texts['layout-root.il'], '::s_Rebuilders', '::Get()', '::Initialize(', '::TryRegisterCanvasElementForLayoutRebuild(', 'brtrue.s IL_002f', '::Release(T)')
    ordered(texts['layout-registration.il'], '::get_gameObject()', '::get_parent()', 'UnityEngine.UI.ILayoutGroup', '::GetComponents(', 'Behaviour::get_isActiveAndEnabled()', '::ValidController(', '::MarkLayoutRootForRebuild(')
    ordered(texts['canvas-constructor.il'], '::m_LayoutRebuildQueue', '::m_GraphicRebuildQueue', '::PerformUpdate()', '::add_willRenderCanvases(')
    ordered(texts['canvas-event.il'], '::willRenderCanvases', 'System.Delegate::Combine(', 'System.Threading.Interlocked::CompareExchange')
    assert 'impl=InternalCall' in texts['native-active-boundary.il'] and 'IL_' not in texts['native-active-boundary.il']
    assert 'Behaviour::get_isActiveAndEnabled()' in texts['ui-active.il']
    methods = [b for t in texts.values() for b in t.split('METHOD ')[1:]]
    result = dict(status='passed-static-scoped', metadataSelections=len(texts), methodDeclarations=len(methods), methodBodies=sum('\nIL_' in b for b in methods), nativeDeclarations=sum('impl=InternalCall' in b.splitlines()[0] for b in methods), directResolvedMethodOperands=len(scopes['directMethodOperands']), modulesResolved=sorted({v['definition']['module'] for v in scopes['directMethodOperands']}), retainedInputChecks=counts, metadataDllsPinned=len(dlls), retainedPhase93Files=len(baseline['priorFiles']), retainedPhase92Files=len(old['priorFiles']), reproducedSubstantiveOutputs=len(texts)+1, originalResourceReads=0, noMocks=True, gameAssemblyExecuted=False, gameLaunches=0, imagesOpened=0, gitMutations=0, authoredTranslations=0, sourceAcceptance='needs-review', editorial='not-run', runtime='not-run', visual='not-run', delivery='needs-review', usage=None)
    (out / 'verification.json').write_text(json.dumps(result, indent=2) + '\n')
    return result


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, required=True)
    out = parser.parse_args().output.resolve()
    assert HERE in out.parents and not out.exists()
    out.mkdir()
    print(json.dumps(verify(out)))
