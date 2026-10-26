#!/usr/bin/env python3
"""Read back the bounded original120:181 route and original response listener.

Never evaluate availability, run a game, change frozen sources or rewrite outputs.
"""
import argparse
import hashlib
import json
from pathlib import Path
import subprocess

import UnityPy
from UnityPy.helpers.TypeTreeGenerator import TypeTreeGenerator
from extract_assets import read_tree, canonical

ROOT = Path(__file__).resolve().parents[1]
SOURCE = Path('/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest/The Forest of Love_Data')
TREE = ROOT / 'assets/source-v2/trees/57009919ee-sharedassets0.assets-3336.json'
TREE_SHA = '41749d8b093ab438a9fc73519993809cee8b1288c5fbc6fab46782a1b899d69b'
ROUTE = [181, 182, 183, 184, 185, *range(163, 181), 186, 187]


def sha(p):
    return hashlib.sha256(p.read_bytes()).hexdigest()


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', required=True, type=Path)
    out = parser.parse_args().output.resolve()
    assert ROOT in out.parents and not out.exists(), 'Require new canonical-project output'
    assert not any(p.endswith('-assets') for p in out.relative_to(ROOT).parts)
    assert sha(TREE) == TREE_SHA
    env = UnityPy.load(str(SOURCE / 'sharedassets0.assets'))
    objects = {o.path_id: o for o in env.objects}
    assert len(objects) == len(env.objects)
    generator = TypeTreeGenerator('2020.3.24f1')
    generator.load_local_dll_folder(str(SOURCE / 'Managed'))
    database = canonical(read_tree(objects[3336], generator))
    assert database == json.loads(TREE.read_text()), 'Fresh original database/export mismatch'
    conversation, = [c for c in database['conversations'] if c['id'] == 120]
    entries = []
    for eid in [158, 159, *ROUTE]:
        e, = [e for e in conversation['dialogueEntries'] if e['id'] == eid]
        f = {f['title']: f['value'] for f in e['fields']}
        assert len(f) == len(e['fields'])
        entries.append(dict(id=eid, actor=f['Actor'], conversant=f['Conversant'], text=f['Dialogue Text'],
            menuText=f['Menu Text'], sequence=f['Sequence'], responseMenuSequence=f['Response Menu Sequence'],
            conditions=e['conditionsString'], script=e['userScript'], isGroup=e['isGroup'],
            onExecute=e['onExecute'], outgoingLinks=e['outgoingLinks']))
    controls = {}
    for pid in [4387, 4541]:
        tree = canonical(read_tree(objects[pid], generator))
        assert tree == json.loads((ROOT / f'assets/source-v2/trees/57009919ee-sharedassets0.assets-{pid}.json').read_text())
        controls[str(pid)] = tree
    assert controls['4387']['button'] == {'m_FileID': 0, 'm_PathID': 4541}
    assert controls['4541']['m_OnClick']['m_PersistentCalls']['m_Calls'] == []
    inspector = ROOT / 'tools/probe/bin/Debug/net8.0/InspectMethods.dll'
    groups = {
        'ResponseButton': ('Auto-asmdef-FirstPass.dll', 'PixelCrushers.DialogueSystem.StandardUIResponseButton', 'Awake,Start,OnClick,SetCurrentResponse'),
        'EventBaseFields': ('UnityEngine.CoreModule.dll', 'UnityEngine.Events.UnityEventBase', '--fields'),
        'InvocationListFields': ('UnityEngine.CoreModule.dll', 'UnityEngine.Events.InvokableCallList', '--fields'),
        'InvocationFields': ('UnityEngine.CoreModule.dll', 'UnityEngine.Events.InvokableCall', '--fields'),
    }
    files, commands = {}, {}
    for key, (assembly, type_, methods) in groups.items():
        argv = ['dotnet', str(inspector), str(SOURCE / 'Managed' / assembly), type_, methods]
        files[key + '.il'] = subprocess.check_output(argv)
        commands[key + '.il'] = argv
    plan = dict(conversation=120, selectedEntry=181, successor=182, route=ROUTE,
        sourceTreeSha256=TREE_SHA, entries=entries,
        boundary='Ordinary original181 only; no trigger mutation, alternate159 selection or notebook readiness claim')
    files['route-plan.json'] = (json.dumps(plan, ensure_ascii=False, indent=2) + '\n').encode()
    files['response-controls.json'] = (json.dumps(controls, ensure_ascii=False, indent=2) + '\n').encode()
    out.mkdir(parents=True)
    for name, data in files.items():
        (out / name).write_bytes(data)
    (out / 'extraction.json').write_text(json.dumps(dict(status='passed-source-only',
        recipeSha256=sha(Path(__file__)), sourceTreeSha256=TREE_SHA,
        sourceResourceSha256=sha(SOURCE / 'sharedassets0.assets'),
        assemblies={n: sha(SOURCE / 'Managed' / n) for n in ['Assembly-CSharp.dll', 'Auto-asmdef-FirstPass.dll', 'UnityEngine.CoreModule.dll']},
        commands=commands, inspectorSha256=sha(inspector),
        files={n: hashlib.sha256(b).hexdigest() for n, b in files.items()},
        imagesOpened=0, gameLaunches=0,
        writeBoundary='Independent file writes; manifest and every declared hash required before reuse'), indent=2) + '\n')
    print(f'Pinned {len(entries)} original entries, two controls and four listener groups: {out}')


if __name__ == '__main__':
    main()
