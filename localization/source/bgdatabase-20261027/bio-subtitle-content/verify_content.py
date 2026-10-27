#!/usr/bin/env python3
"""Reproduce bounded original subtitle content metadata without game execution."""
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
    rows = [b for b in text.split('METHOD ')[1:] if b.splitlines()[0].startswith(signature + ' |')]
    assert len(rows) == 1, signature
    return rows[0]

def verify(out):
    baseline = load(HERE / 'baseline.json')
    prior = ROOT / baseline['inheritedBaseline']
    assert sha(prior) == baseline['inheritedBaselineSha256']
    inherited = load(prior)
    counts = {}
    for group in ('inputs', 'frozenPins', 'owningHelpers', 'processReferences', 'installedSources'):
        for name, expected in inherited[group].items():
            p = DATA / name if group == 'installedSources' else Path(name) if Path(name).is_absolute() else ROOT / name
            assert sha(p) == expected, (group, name)
        counts[group] = len(inherited[group])
    for group in ('priorFiles', 'metadataPins'):
        for name, expected in baseline[group].items():
            p = Path(name) if Path(name).is_absolute() else ROOT / name
            assert sha(p) == expected, name
    for name, archive in [('README.md', 'previous-summary.md'), ('CHECKPOINT.json', 'previous-checkpoint.json')]:
        assert sha(HERE / archive) == baseline['summaryPins'][name]
    dllpins = load(ROOT / 'localization/source/bgdatabase-20261027/bio-prepare-bindings/binding-pins.json')
    for name, expected in dllpins.items():
        assert sha(Path(name)) == expected, name
    dlls = [Path(n) for n in dllpins if Path(n).parent == DATA / 'Managed' and n.endswith('.dll')]
    assert len(dlls) == 150
    assert {p.name for p in dlls} == {p.name for p in (DATA / 'Managed').glob('*.dll')}
    assert subprocess.check_output(['dotnet', '--version'], text=True).strip() == '8.0.131'
    subprocess.run(['dotnet', 'build', str(HERE / 'DependencyScopes.csproj'), '--nologo', '--verbosity', 'quiet'], check=True, capture_output=True)
    for name, expected in load(HERE / 'helper-pins.json').items():
        assert sha(ROOT / name) == expected, name
    helper = ROOT / 'tools/probe/bin/Debug/net8.0/InspectMethods.dll'
    texts = {}
    for row in load(HERE / 'il-commands.json'):
        assert row['exitCode'] == 0 and not row['stderr']
        r = subprocess.run(['dotnet', str(helper), str(DATA / 'Managed' / row['assembly']), row['type'], row['selection']], capture_output=True, check=True)
        assert not r.stderr
        p = out / row['output']; p.write_bytes(r.stdout)
        assert sha(p) == row['sha256'] == sha(HERE / row['output']), row['output']
        texts[row['output']] = r.stdout.decode()
    r = subprocess.run(['dotnet', str(HERE / 'bin/Debug/net8.0/DependencyScopes.dll'), str(DATA / 'Managed'), str(HERE / 'il-commands.json')], capture_output=True, check=True)
    assert not r.stderr
    (out / 'dependency-scopes.json').write_bytes(r.stdout)
    assert sha(out / 'dependency-scopes.json') == sha(HERE / 'dependency-scopes.json')
    scopes = json.loads(r.stdout)
    assert scopes['storedRendererPropertyDispatch'][0]['type'] == 'TMPro.TextMeshProUGUI'
    assert scopes['storedRendererPropertyDispatch'][0]['declarations'] == []
    assert scopes['storedRendererPropertyDispatch'][1]['type'] == 'TMPro.TMP_Text'
    assert len(scopes['storedRendererPropertyDispatch'][1]['declarations']) == 2
    for row in scopes['directMethodOperands']:
        assert sha(DATA / 'Managed' / row['module']) == row['sha256']
    content = texts['panel-set-content.il']
    ordered(content, 'IL_0001: brtrue.s IL_0004', 'IL_0003: ret', '::set_currentSubtitle(', '::CheckSubtitleAnimator(', '::StopTyping(', '::accumulateText', '::SetFormattedText(', '::m_accumulatedText', '::delayTypewriterUntilOpen', '::StartTypingWhenFocused(', '::StartTyping(', '::frameLastSetContent')
    fmt = texts['panel-format.il']
    ordered(fmt, '::GetUIFormattedText(', 'System.String::Concat(', 'UITextField::set_text(', '::SendTextChangeMessage(', '::get_haveSavedOriginalColor()', '::get_emphases()', 'UITextField::set_color(')
    setter = body(texts['text-field-write.il'], 'System.Void PixelCrushers.UITextField::set_text(System.String)')
    ordered(setter, '::get_textMeshProUGUI()', 'brfalse.s IL_001a', 'TMPro.TMP_Text::set_text(', 'IL_001a: ldarg.0', '::get_uiText()', 'UnityEngine.UI.Text::set_text(', 'IL_0034: ret')
    assert setter.count(': ret') == 1  # Both independent writes; not getter-style fallback.
    getter = body(texts['text-field-write.il'], 'System.String PixelCrushers.UITextField::get_text()')
    ordered(getter, 'TMPro.TMP_Text::get_text()', 'IL_0019: ret', '::get_uiText()', 'UnityEngine.UI.Text::get_text()')
    notify = body(texts['ui-format-and-notify.il'], 'System.Void PixelCrushers.DialogueSystem.UITools::SendTextChangeMessage(PixelCrushers.UITextField)')
    ordered(notify, '::get_gameObject()', 'IL_000e: ret', '::get_gameObject()', 'ldstr "OnTextChange"', 'GameObject::SendMessage(')
    assert '::dialogueUI' not in notify  # Separate Text overload uses global UI, not this one.
    select = texts['typewriter-select.il']
    ordered(select, '::get_textMeshProUGUI()', 'GetComponent<PixelCrushers.DialogueSystem.AbstractTypewriterEffect>()', 'IL_001c: ldloc.0', '::op_Equality', '::get_uiText()', 'GetComponent<PixelCrushers.DialogueSystem.AbstractTypewriterEffect>()')
    for name in ('StartTyping', 'StopTyping'):
        segment = [b for b in texts['typewriter-dispatch.il'].split('METHOD ')[1:] if '::' + name + '(' in b.splitlines()[0]][0]
        ordered(segment, '::GetTypewriter(', '::op_Inequality', 'Behaviour::get_enabled()', 'AbstractTypewriterEffect::' + name + '(')
    tmp = body(texts['tmp-content-property.il'], 'System.Void TMPro.TMP_Text::set_text(System.String)')
    ordered(tmp, '::m_IsTextBackingStringDirty', '::get_Length()', 'System.String::op_Equality', 'IL_0034: ret', 'stfld System.Boolean TMPro.TMP_Text::m_IsTextBackingStringDirty', 'stfld System.String TMPro.TMP_Text::m_text', '::m_inputSource', '::m_havePropertiesChanged', 'Graphic::SetVerticesDirty()', 'Graphic::SetLayoutDirty()')
    result = dict(status='passed-static-scoped', metadataSelections=len(texts), methodBodies=sum(t.count('\nMETHOD ') for t in texts.values()), directResolvedMethodOperands=len(scopes['directMethodOperands']), originalResourceReads=0, retainedPriorSupplementFiles=len(baseline['priorFiles']), retainedInputChecks=counts, metadataDllsPinned=len(dlls), regressionAssertions=['Null subtitle returns before mutation; StopTyping precedes formatted content write and later typing.', 'SetFormattedText concatenates accumulation prefix and optional italic UI text, writes, notifies, then colors.', 'UITextField setter independently writes both nonnull fields; getter prefers TMP.', 'Stored TextMeshProUGUI inherits TMP_Text text properties without override.', 'TMP setter has equal-string no-op guard; mutation invalidates geometry/layout without proving rendering.', 'UITextField notification uses its own GameObject; legacy Text overload global-UI route is distinct.', 'Typewriter uses native component lookup then enabled effect dispatch; no concrete effect selected here.'], noMocks=True, gameAssemblyExecuted=False, gameLaunches=0, imagesOpened=0, gitMutations=0, authoredTranslations=0, sourceAcceptance='needs-review', editorial='not-run', runtime='not-run', visual='not-run', delivery='needs-review', usage=None)
    (out / 'verification.json').write_text(json.dumps(result, indent=2) + '\n')
    return result

if __name__ == '__main__':
    p = argparse.ArgumentParser(description=__doc__); p.add_argument('--output', type=Path, required=True)
    out = p.parse_args().output.resolve()
    assert HERE in out.parents and not out.exists()
    out.mkdir()
    print(json.dumps(verify(out)))
