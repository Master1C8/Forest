#!/usr/bin/env python3
"""Reproduce scoped Quest consumers from original bytes/IL; never execute game code."""
import argparse
import collections
import hashlib
import json
from pathlib import Path
import re
import subprocess
import sys

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[3]
PRIOR = HERE.parent / 'quest-progress'
DATA = Path('/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest/The Forest of Love_Data')
sys.path[:0] = [str(ROOT / 'tools'), str(PRIOR)]
from decode_quest import SOURCE, decode, encode_cell
from extract_assets import read_tree, canonical
import UnityPy
from UnityPy.helpers.TypeTreeGenerator import TypeTreeGenerator


def sha(p):
    return hashlib.sha256(p.read_bytes()).hexdigest()


def dump(p, value):
    p.write_text(json.dumps(canonical(value), ensure_ascii=False, indent=2) + '\n')


def methods(text):
    current, instructions = None, []
    for line in text.splitlines():
        if line.startswith('METHOD '):
            if current:
                yield current, instructions
            current, instructions = line[7:].split(' | ', 1)[0], []
        elif current and line.startswith('IL_'):
            instructions.append(line)
    if current:
        yield current, instructions


def native_bindings():
    """Reuse exporter/tree helpers for one original notification controller hierarchy."""
    env = UnityPy.load(str(DATA / 'sharedassets2.assets'))
    objects = {o.path_id: o for o in env.objects}
    gen = TypeTreeGenerator('2020.3.24f1')
    gen.load_local_dll_folder(str(DATA / 'Managed'))
    cache = {}
    def tree(pid):
        if pid not in cache:
            cache[pid] = read_tree(objects[pid], gen)
        return cache[pid]
    def class_name(obj):
        return obj.parse_monobehaviour_head().m_Script.deref().read().m_ClassName
    selected = [o for o in objects.values() if o.type.name == 'MonoBehaviour' and class_name(o) == 'QuestUpdatedUI']
    assert len(selected) == 1, 'notification-controller-count'
    controller = selected[0]
    go = tree(controller.path_id)['m_GameObject']['m_PathID']
    def transform(go_id):
        refs = [c['component']['m_PathID'] for c in tree(go_id)['m_Component']
                if objects[c['component']['m_PathID']].type.name in ('RectTransform', 'Transform')]
        assert len(refs) == 1
        return refs[0]
    touched = {controller.path_id, go}
    def children(tr):
        touched.add(tr)
        return [c['m_PathID'] for c in tree(tr)['m_Children']]
    def descend(tr, parts):
        if not parts:
            return tr
        candidates = [c for c in children(tr) if tree(tree(c)['m_GameObject']['m_PathID'])['m_Name'] == parts[0]]
        assert len(candidates) == 1, ('native-path', parts)
        return descend(candidates[0], parts[1:])
    externals = [x.path for x in next(iter(env.files.values())).externals]
    groups = {}
    def collect(tr, trail, active=True):
        touched.add(tr)
        node = tree(tr); gid = node['m_GameObject']['m_PathID']; touched.add(gid)
        g = tree(gid); active = active and bool(g['m_IsActive'])
        trail = trail + '/' + g['m_Name']
        entries = []
        for comp in g['m_Component']:
            pid = comp['component']['m_PathID']; obj = objects[pid]
            if obj.type.name == 'MonoBehaviour' and class_name(obj) == 'Text':
                value = tree(pid); font = value['m_FontData']['m_Font']; touched.add(pid)
                entries.append(dict(id='sharedassets2.assets:' + str(pid), relativePath=trail,
                    activeSelf=bool(g['m_IsActive']), serializedSubtreeActive=active,
                    serializedText=value['m_Text'], rawSha256=hashlib.sha256(obj.get_raw_data()).hexdigest(),
                    font=('sharedassets2.assets' if font['m_FileID'] == 0 else externals[font['m_FileID'] - 1]) + ':' + str(font['m_PathID']),
                    fontData=value['m_FontData'], rect=node))
        for child in children(tr):
            entries.extend(collect(child, trail, active))
        return entries
    for group, leaf in [('previousStepText', 'OldObjTextContainer'), ('currentStepText', 'NewObjTextContainer')]:
        path = 'UiContainer/AnimatorContainer/' + leaf
        target = descend(transform(go), path.split('/'))
        groups[group] = dict(findPath=path, allTextDescendants=collect(target, ''),
            runtimeSelection='GetComponentsInChildren<Text>() at Start, includeInactive=false; later runtime hierarchy/activation not observed')
    return dict(controller='sharedassets2.assets:' + str(controller.path_id), groups=groups,
        hierarchyObjectHashes={str(pid): hashlib.sha256(objects[pid].get_raw_data()).hexdigest() for pid in sorted(touched)},
        runtime='not-run', visual='not-run', fontFeasibility='not-established')


def build(out):
    b = json.loads((HERE / 'baseline.json').read_text())
    assert len(b['pins']) == 19 and all(sha(Path(p)) == h for p, h in b['pins'].items())
    assert all(sha(ROOT / p) == h for p, h in b['owningHelpers'].items())
    assert all(sha(PRIOR / p) == h for p, h in b['priorQuestEvidence'].items())
    assert sha(HERE.parent / 'verification.json') == b['priorInventoryVerificationSha256']
    assert all(sha(HERE.parent / p) == h for p, h in b['priorInventoryEvidence'].items())
    sources = json.loads((ROOT / 'assets/source-v2/source-files.json').read_text())
    checked = ['resources.assets', 'sharedassets2.assets', 'Managed/Assembly-CSharp.dll', 'Managed/BGDatabase.dll']
    assert all(sha(DATA / p) == sources[p]['sha256'] for p in checked)
    record = next(r for r in json.loads((ROOT / 'assets/source-v2/text-assets.json').read_text()) if r['id'] == 'resources.assets:320')
    env = UnityPy.load(str(DATA / 'resources.assets'))
    objs = [o for o in env.objects if o.path_id == 320 and Path(o.assets_file.name).name == 'resources.assets']
    assert len(objs) == 1 and objs[0].type.name == 'TextAsset'
    assert hashlib.sha256(objs[0].get_raw_data()).hexdigest() == record['rawSha256']
    asset = objs[0].read()
    raw = asset.m_Script.encode('utf-8', 'surrogateescape') if isinstance(asset.m_Script, str) else bytes(asset.m_Script)
    assert asset.m_Name == 'bansheegz_database' and raw == SOURCE.read_bytes()
    decoded = decode(raw)
    assert decoded == json.loads((PRIOR / 'decoded.json').read_text())
    commands = json.loads((HERE / 'il-commands.json').read_text())
    for c in commands:
        actual = subprocess.check_output(['dotnet', str(ROOT / 'tools/probe/bin/Debug/net8.0/InspectMethods.dll'),
                                         str(DATA / 'Managed' / c['assembly']), c['type'], c['selection']])
        assert actual == (HERE / c['output']).read_bytes()
        assert hashlib.sha256(actual).hexdigest() == c['sha256']
    sheets = {s['name']: s for s in decoded['sheets']}
    by_name = {}
    for name, s in sheets.items():
        names = [r['cells']['name'] for r in s['rows']]
        assert len(names) == len(set(names)) and None not in names
        by_name[name] = {r['cells']['name']: r for r in s['rows']}
    cells = [json.loads(l) for f in ['visible-fields.jsonl', 'preserve-exactly.jsonl'] for l in (PRIOR / 'readback' / f).read_text().splitlines()]
    assert len(cells) == 904 and len({c['id'] for c in cells}) == 904
    for c in cells:
        s = sheets[c['sheet']]
        row = s['rows'][c['rowIndex']]
        assert row['id'] == c['rowId'] and row['cells'][c['field']] == c['source']
        f = next(f for f in s['fields'] if f['id'] == c['fieldId'])
        span = c['sourceSpan']
        if span:
            kind = f['type'].split(',')[0].rsplit('.', 1)[-1]
            assert encode_cell(kind, c['source']) == raw[span['offset']:span['offset'] + span['bytes']]
        else:
            assert c['source'] is None
    # Exact method/offset identities prevent equal literal text or repeated offsets
    # in different methods being collapsed. Other helper literals are not handed off.
    output_files = ['quest-log.il', 'storm-event.il', 'storm-callback.il']
    visible_offsets = {'00bb', '00c2', '00d9', '00f5', '0111', '012d', '01bc', '0300', '033a'}
    route_offsets = {'00cb', '00e7', '0103', '011f', '0250', '0269', '0282', '029b', '02f0'}
    literals, lookups = [], []
    for filename in output_files:
        for method, il in methods((HERE / filename).read_text()):
            for i, line in enumerate(il):
                match = re.fullmatch(r'IL_([0-9a-f]+): ldstr "(.*)"', line)
                if not match:
                    continue
                offset, value = match.groups()
                visible = filename == 'quest-log.il' and offset in visible_offsets
                role = 'compiled-display-fragment' if visible else 'preserve-exactly'
                item = dict(id='Assembly-CSharp.dll::' + method + '@IL_' + offset, method=method,
                    ilFile=filename, offset='IL_' + offset, source=value, role=role,
                    reason='Notification wording' if visible else ('Case-sensitive Contains operand against lowercased dialogue identity' if filename == 'quest-log.il' and offset in route_offsets else 'Quest/log/actor/dialogue/arc identity'))
                if filename == 'quest-log.il' and offset == '01bc':
                    item['reachability'] = 'unreachable under preceding stable local V_11: completed exits at IL_01a6; preserve original dormant literal'
                literals.append(item)
                if i + 1 < len(il) and '::GetQuestProgressLogByDbName(System.String)' in il[i + 1]:
                    assert value in by_name['QuestProgressLogText'], ('unknown-log-name', value)
                    row = by_name['QuestProgressLogText'][value]
                    lookups.append(dict(literalId=item['id'], sourceName=value, rowId=row['id'],
                        questRowId=row['cells']['quest'], source=row['cells']['log_text'],
                        cells=[c for c in cells if c['sheet'] == 'QuestProgressLogText' and c['rowId'] == row['id']]))
    assert len(literals) == 46 and sum(x['role'] == 'compiled-display-fragment' for x in literals) == 9
    assert len({x['id'] for x in literals}) == len(literals)
    # Import the already exact-classified pane occurrences unchanged, preserving IDs.
    dump(out / 'compiled-literals.json', dict(newOutputOccurrences=literals, priorPaneManifest='../quest-progress/readback/compiled-literals.json', priorPaneSha256=sha(PRIOR / 'readback/compiled-literals.json'), scope='46 additional notification occurrences only;75 unchanged pane occurrences referenced separately'))
    pane_lookups = []
    for method, il in methods((PRIOR / 'pane.il').read_text()):
        for i, line in enumerate(il[:-1]):
            m = re.fullmatch(r'IL_([0-9a-f]+): ldstr "(.*)"', line)
            if m and '::GetQuestProgressLogByDbName(System.String)' in il[i + 1]:
                offset, name = m.groups(); assert name in by_name['QuestProgressLogText']
                row = by_name['QuestProgressLogText'][name]
                pane_lookups.append(dict(ilFile='../quest-progress/pane.il', offset='IL_' + offset, name=name, rowId=row['id']))
    names = {r['sourceName'] for r in lookups} | {r['name'] for r in pane_lookups}
    assert len(names) == 13
    selected_quests = {'Act3_StormQuest', 'Act3_AfterstormQuest', 'Act1_GreetingsQuest', 'AdventureModePlaceholder'}
    selected_ids = {by_name['QuestProgressLogText'][n]['id'] for n in names}
    selected_ids |= {by_name['Quest'][n]['id'] for n in selected_quests}
    referenced = [c for c in cells if c['rowId'] in selected_ids]
    dump(out / 'referenced-rows.json', referenced)
    dump(out / 'log-lookups.json', dict(notificationOccurrences=lookups, paneOccurrences=pane_lookups, distinctLogRows=13, all119NamesUnique=True, all119RowsRetainedIn='../quest-progress/decoded.json'))
    controls = []
    for filename, method_name, expected in [
        ('notify-queue.il', 'Start', [('000d', 'UiContainer/AnimatorContainer'), ('005f', 'UiContainer/AnimatorContainer/OldObjTextContainer'), ('007f', 'UiContainer/AnimatorContainer/NewObjTextContainer'), ('009a', 'UiContainer/Checkmark')]),
        ('notify-queue.il', 'TryShowNextQueuedNotification', [('009a', 'show'), ('00b7', 'show')]),
        ('page-collection.il', 'OnCollectedPage', [('003e', 'act3_thestorm_collected_enough_pages'), ('0080', '/')])]:
        bodies = [(m, il) for m, il in methods((HERE / filename).read_text()) if '::' + method_name + '(' in m]
        assert len(bodies) == 1
        method, il = bodies[0]
        actual = re.findall(r'^IL_([0-9a-f]+): ldstr "(.*)"$', '\n'.join(il), re.M)
        assert actual == expected, ('changed-control-literals', filename, method)
        controls.extend(dict(id='Assembly-CSharp.dll::' + method + '@IL_' + offset, file=filename,
                             method=method, offset='IL_' + offset, source=value, role='preserve-exactly')
                        for offset, value in actual)
    writes = [line for line in (HERE / 'log-text-writes.il').read_text().splitlines() if ': stfld ' in line]
    assert len(writes) == 1 and '<GenerateQuestProgressLogText>b__0' in writes[0]
    assert 'InventoryItemType::PageStormQuest = 420' in (HERE / 'item-enum.il').read_text()
    dump(out / 'preserve-exactly.json', dict(newCompiledOccurrences=[x for x in literals if x['role'] == 'preserve-exactly'],
        referencedProtectedCells=[c for c in referenced if c['role'] == 'preserve-exactly'],
        priorCompleteManifests=['../quest-progress/readback/preserve-exactly.jsonl', '../quest-progress/readback/compiled-literals.json'],
        controls=controls))
    initial = []
    log_rows = sheets['QuestProgressLogText']['rows']
    for row in sheets['Quest']['rows']:
        entries = [r for r in log_rows if r['cells']['quest'] == row['id']]
        links = row['cells']['initial_progress_log_unlocks']
        initial.append(dict(questRowId=row['id'], name=row['cells']['name'],
            declaredInitialCells=[c for c in cells if c['rowId'] == row['id'] and c['field'] == 'initial_progress_log_unlocks'],
            declaredInitialTargets=links or [],
            runtimeListCandidateRowIds=[r['id'] for r in entries],
            exactRuntimeFirstRow='unverified: original priority-only List.Sort, all priorities0; source list here is not runtime order',
            allDeclaredTargetsBelongToQuest=all(rid in {r['id'] for r in entries} for rid in links or [])))
    assert sum(len(x['declaredInitialTargets']) for x in initial) == 30
    assert sum(bool(x['declaredInitialTargets']) for x in initial) == 28
    assert all(x['allDeclaredTargetsBelongToQuest'] for x in initial)
    dump(out / 'initial-unlocks.json', dict(rows=initial, sourceColumnReferences=30, sourceColumnLists=28,
        startQuest='SetStatusStarted then if progressLogEntries.Count>0 Unlock(progressLogEntries[0], true); suppresses unlock event; no onQuestLogUpdated here',
        explicitLog='LogNewlyEnteredStep Unlock(entry,false), then onQuestLogUpdated(entry.quest); existing-unlock early return does not prevent latter event',
        adventure='RefreshQuestLabels AdventureModePlaceholder under availability/cheat/status/unlock guards calls SetStatusStarted and Unlock(progressLogEntries[0],false), toggling isCheatCode',
        eventSearch='onQuestStatusStarted field uses are cctor and SetStatusStarted only in original Assembly-CSharp; no compiled listener found',
        columnGetterSearch='../quest-progress/initial-uses.il; empty direct calls',
        columnLiteralSearch='db-initial-calls.il; empty exact ldstr',
        acceptance='Partial consumer resolution, not proof of dead column, exact first row, reflection/other assembly use or runtime unlock behavior'))
    native = native_bindings()
    dump(out / 'native-bindings.json', native)
    counts = {k: len(v['allTextDescendants']) for k, v in native['groups'].items()}
    report = dict(status='passed-static-scoped', installedSources={p:sources[p]['sha256'] for p in checked},
        originalExportBytes=len(raw), originalExportSha256=sha(SOURCE), textAssetRawSha256=record['rawSha256'],
        frozenPinsUnchanged=19, priorQuestEvidenceHashesChecked=len(b['priorQuestEvidence']),
        priorInventoryEvidenceHashesChecked=len(b['priorInventoryEvidence']),
        exactCellStatesRechecked=904, exactIlSelections=len(commands), additionalLiteralOccurrences=46,
        additionalDisplayFragments=9, additionalPreservedLiterals=37, distinctNamedLogRows=13,
        notificationLookupOccurrences=len(lookups), paneLookupOccurrences=len(pane_lookups),
        referencedCellStates=len(referenced), notificationTextDescendants=counts,
        nativeHierarchyHashesChecked=len(native['hierarchyObjectHashes']), initialRelationsChecked=30,
        logTextWrites='Original field search has one stfld: loader callback. Storm consumers are reads/local selections.',
        gameLaunches=0, imagesOpened=0, gameAssemblyExecuted=False, translationAuthored=False,
        reinsertion='not-run', runtime='not-run', visual='not-run', editorial='not-run',
        wholeGameSourceAcceptance=False, usage='Unknown in worker; parent measures telemetry')
    dump(out / 'verification.json', report)
    return report


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('--output', type=Path, required=True)
    args = p.parse_args()
    assert not args.output.exists()
    args.output.mkdir(parents=True)
    print(json.dumps(build(args.output)))


if __name__ == '__main__':
    main()
