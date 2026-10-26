#!/usr/bin/env python3
"""Read only original158 graph/control and IL; never launch or change game assets."""
import hashlib
import json
from pathlib import Path
import subprocess
import sys

import UnityPy
from UnityPy.helpers.TypeTreeGenerator import TypeTreeGenerator

from extract_assets import read_tree, canonical

ROOT = Path(__file__).resolve().parents[1]
SOURCE = Path('/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest/The Forest of Love_Data')
OUT = ROOT / 'localization/source/save-continue-20261026/phase0050'


def sha(p):
    return hashlib.sha256(p.read_bytes()).hexdigest()


def main():
    OUT.mkdir(exist_ok=True)
    assert not (OUT / 'extraction.json').exists(), 'Preserve existing source extraction'
    inspector = ROOT / 'tools/probe/bin/Debug/net8.0/InspectMethods.dll'
    commands = {}
    for filename, assembly, typename, methods in [
        ('AnalyzePCResponses.il','Auto-asmdef-FirstPass.dll','PixelCrushers.DialogueSystem.ConversationController','AnalyzePCResponses'),
        ('OriginalButton.il','Assembly-CSharp.dll','TheForestOfLove.TextMeshProUIContinueButtonFastForward','OnFastForward'),
        ('OriginalFastForward.il','Assembly-CSharp.dll','TheForestOfLove.CustomTypewriterEffectTextMeshPro','FastForwardTextOrAdvanceDialogue_Internal')]:
        argv = ['dotnet',str(inspector),str(SOURCE/'Managed'/assembly),typename,methods]
        data = subprocess.check_output(argv)
        (OUT/filename).write_bytes(data)
        commands[filename] = argv
    env = UnityPy.load(str(SOURCE/'sharedassets0.assets'))
    objects = {o.path_id:o for o in env.objects}
    assert len(objects) == len(env.objects)
    generator = TypeTreeGenerator('2020.3.24f1')
    generator.load_local_dll_folder(str(SOURCE/'Managed'))

    def path(go):
        g = objects[go].read()
        transform = g.m_Component[0].component.deref().read()
        parent = transform.m_Father
        return (path(parent.deref().read().m_GameObject.path_id)+'/' if parent.path_id else '')+g.m_Name

    rows = {}
    for pid in [3633,4571,4572,4633,3640]:
        tree = canonical(read_tree(objects[pid],generator))
        rows[str(pid)] = dict(path=path(tree['m_GameObject']['m_PathID']),tree=tree,
            rawSha256=hashlib.sha256(objects[pid].get_raw_data()).hexdigest())
    panel,button,handler = [rows[str(n)]['tree'] for n in [3633,4572,4633]]
    assert panel['continueButton']['m_PathID'] == 4572
    assert panel['subtitleText']['m_textMeshProUGUI']['m_PathID'] == 4571
    call, = button['m_OnClick']['m_PersistentCalls']['m_Calls']
    assert call['m_Target']['m_PathID'] == 4633 and call['m_MethodName'] == 'OnFastForward' and call['m_CallState'] == 2
    assert handler['febucciTypewriterEffect']['m_PathID'] == 3640
    assert handler['hideContinueButtonOnContinue'] == 0 and handler['continueSubtitlePanel'] == handler['continueAlertPanel'] == 1
    # All selected values must equal the verified original export; no source edits.
    for pid,row in rows.items():
        exported=ROOT/f'assets/source-v2/trees/57009919ee-sharedassets0.assets-{pid}.json'
        assert row['tree'] == json.loads(exported.read_text()), pid
    (OUT/'original-controls.json').write_text(json.dumps(rows,ensure_ascii=False,indent=2)+'\n')
    database = read_tree(objects[3336],generator)
    conversation, = [c for c in database['conversations'] if c['id']==120]
    prefix = json.loads((ROOT/'localization/source/save-continue-20261026/tutorial-prefix.json').read_text())
    selected = []
    for eid in [158,159,181]:
        e, = [e for e in conversation['dialogueEntries'] if e['id']==eid]
        fields = {f['title']:f['value'] for f in e['fields']}
        p, = [p for p in prefix['entries'] if p['id']==eid]
        for key,title in [('text','Dialogue Text'),('menuText','Menu Text'),('sequence','Sequence'),('responseMenuSequence','Response Menu Sequence'),('actor','Actor'),('conversant','Conversant')]:
            assert p[key] == fields[title], (eid,key)
        assert p['conditions']==e['conditionsString'] and p['script']==e['userScript']
        assert p['outgoingLinks']==e['outgoingLinks'] and p['onExecute']==e['onExecute']
        selected.append(canonical(e))
    (OUT/'original-entries.json').write_text(json.dumps(selected,ensure_ascii=False,indent=2)+'\n')
    report = dict(status='passed-source-only',sourceFile=str(SOURCE/'sharedassets0.assets'),
        sourceFileSha256=sha(SOURCE/'sharedassets0.assets'),
        assemblies={n:sha(SOURCE/'Managed'/n) for n in ['Assembly-CSharp.dll','Auto-asmdef-FirstPass.dll']},
        inspectorSha256=sha(inspector),recipeSha256=sha(Path(__file__)),commands=commands,
        files={p.name:sha(p) for p in OUT.iterdir() if p.suffix in ['.json','.il']},
        boundary='Original IL and exact readback/export parity for five controls and three graph entries. No assertion of live waitForContinue or typewriter hang; no runtime/visual acceptance.')
    (OUT/'extraction.json').write_text(json.dumps(report,indent=2)+'\n')
    print('Original158 graph/control/AnalyzePCResponses extraction verified; no game launched')


if __name__=='__main__':
    main()
