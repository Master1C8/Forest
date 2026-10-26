#!/usr/bin/env python3
"""Bounded original-object, typed-cell and consumer-ID verification; no game run."""
import argparse
import collections
import hashlib
import json
from pathlib import Path
import re
import struct
import subprocess
import sys
from urllib.parse import quote

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[3]
sys.path.insert(0, str(ROOT / 'tools'))
from extract_assets import canonical
from decode_quest import SOURCE, SOURCE_SHA, bgid, decode, decode_cell, encode_cell
import UnityPy

DATA = Path('/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest/The Forest of Love_Data')


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def dump(path, value):
    path.write_text(json.dumps(canonical(value), ensure_ascii=False, indent=2) + '\n')


def selector(sheet, row, field):
    return 'bgdb:resources.assets:320/sheet/' + quote(sheet, safe='') + '/row/' + quote(row, safe='') + '/field/' + quote(field, safe='')


def rejected(fn, reason):
    try:
        fn()
    except AssertionError as exc:
        assert reason in str(exc)
    else:
        raise AssertionError('Expected rejection: ' + reason)


def generated_id(il, name):
    starts = list(re.finditer(r'^METHOD [^\n]*::' + re.escape(name) + r'\(\)', il, re.M))
    assert len(starts) == 1, name
    body = il[starts[0].end():].split('\nMETHOD ', 1)[0]
    pair = [int(n) for n in re.findall(r'ldc.i8 (-?\d+)', body)]
    assert len(pair) == 2
    return bgid(struct.pack('<QQ', *(n % (1 << 64) for n in pair)))


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('--output', required=True, type=Path)
    args = p.parse_args()
    assert not args.output.exists()
    baseline = json.loads((HERE / 'baseline.json').read_text())
    assert len(baseline['pins']) == 19
    assert all(sha(Path(n)) == h for n, h in baseline['pins'].items())
    assert all(sha(ROOT / n) == h for n, h in baseline['owningHelpers'].items())
    previous = json.loads((HERE.parent / 'verification.json').read_text())
    assert all(sha(HERE.parent / n) == h for n, h in previous['evidence'].items())
    source = json.loads((ROOT / 'assets/source-v2/source-files.json').read_text())
    checked = ('resources.assets', 'sharedassets2.assets', 'Managed/Assembly-CSharp.dll', 'Managed/BGDatabase.dll')
    assert all(sha(DATA / n) == source[n]['sha256'] for n in checked)
    raw = SOURCE.read_bytes()
    assert sha(SOURCE) == SOURCE_SHA
    record = next(r for r in json.loads((ROOT / 'assets/source-v2/text-assets.json').read_text()) if r['id'] == 'resources.assets:320')
    env = UnityPy.load(str(DATA / 'resources.assets'))
    obj = [o for o in env.objects if o.path_id == 320 and Path(o.assets_file.name).name == 'resources.assets']
    assert len(obj) == 1 and obj[0].type.name == 'TextAsset'
    assert hashlib.sha256(obj[0].get_raw_data()).hexdigest() == record['rawSha256']
    asset = obj[0].read()
    original = asset.m_Script.encode('utf-8', 'surrogateescape') if isinstance(asset.m_Script, str) else bytes(asset.m_Script)
    assert asset.m_Name == 'bansheegz_database' and original == raw
    decoded = json.loads((HERE / 'decoded.json').read_text())
    assert decoded == decode(raw)
    # Read actual serialized native Text outputs, reusing the existing inspector's
    # bindings only after original resource/evidence equality. Never decode pixels.
    prior_dir = ROOT / 'localization/source/inventory-20261026'
    prior = json.loads((prior_dir / 'source-trace.json').read_text())
    assert all(sha(prior_dir / n) == h for n, h in prior['evidence'].items())
    bindings = json.loads((prior_dir / 'bindings.json').read_text())
    panes = [c for c in bindings['controllers'] if c['class'] == 'QuestLogDetailsPane']
    assert len(panes) == 1
    pane = panes[0]
    ui_env = UnityPy.load(str(DATA / 'sharedassets2.assets'))
    objects = {o.path_id: o for o in ui_env.objects}
    for binding in pane['textBindings'].values():
        pid = int(binding['id'].split(':')[-1])
        assert hashlib.sha256(objects[pid].get_raw_data()).hexdigest() == binding['rawSha256']
    commands = json.loads((HERE / 'il-commands.json').read_text())
    for row in commands:
        actual = subprocess.check_output(['dotnet', str(ROOT / 'tools/probe/bin/Debug/net8.0/InspectMethods.dll'),
                                         str(DATA / 'Managed' / row['assembly']), row['type'], row['selection']])
        assert actual == (HERE / row['output']).read_bytes()
        assert hashlib.sha256(actual).hexdigest() == row['sha256']
    pane_il = (HERE / 'pane.il').read_text()
    assert [line for line in pane_il.splitlines() if line.startswith('IL_')] == [
        line for line in (prior_dir / 'QuestLogDetailsPane.il').read_text().splitlines() if line.startswith('IL_')]
    visible, protected, edges, multiplicity, constants = [], [], [], {}, 0
    rebuilt, cells, spans = bytearray(raw), 0, 0
    # Uniqueness checked before constructing lookups; equal wording is kept as
    # distinct occurrences, never keyed by visible text.
    for s in decoded['sheets']:
        assert len(s['rows']) == len(set(r['id'] for r in s['rows']))
        for name in ('name', 'savekey'):
            vals = [r['cells'][name] for r in s['rows']]
            assert len(vals) == len(set(vals)) and None not in vals
    sheets = {s['id']: s for s in decoded['sheets']}
    lookups = {s['id']: {r['id']: r for r in s['rows']} for s in decoded['sheets']}
    for s in decoded['sheets']:
        il = (HERE / ('db-log.il' if s['name'] == 'QuestProgressLogText' else 'db-quest.il')).read_text()
        assert generated_id(il, 'get_MetaDefault') == s['id']
        constants += 1
        for f in s['fields']:
            assert generated_id(il, 'get__' + f['name']) == f['id']
            constants += 1
            groups = collections.defaultdict(list)
            kind = f['type'].split(',')[0].rsplit('.', 1)[-1]
            for row in s['rows']:
                value, span = row['cells'][f['name']], row['spans'][f['name']]
                groups[json.dumps(value, ensure_ascii=False, sort_keys=True)].append(row['id'])
                cells += 1
                if span is None:
                    assert value is None
                else:
                    encoded = encode_cell(kind, value)
                    offset, size = span['offset'], span['bytes']
                    assert len(encoded) == size and encoded == raw[offset:offset + size]
                    rebuilt[offset:offset + size] = encoded
                    spans += 1
                ident = selector(s['id'], row['id'], f['id'])
                item = dict(id=ident, sheet=s['name'], sheetId=s['id'], rowId=row['id'], rowIndex=row['index'],
                            field=f['name'], fieldId=f['id'], source=value, sourceSpan=span,
                            role='authored-display-candidate' if f['name'] in ('log_text', 'bio_title', 'bio_description') else 'preserve-exactly')
                if item['role'] == 'authored-display-candidate':
                    item.update(consumer='DB getter -> DialogueSystemLoader -> QuestLogDetailsPane native Text; see source-trace.json',
                                reachability='not-run; null state is not a translatable phrase')
                    visible.append(item)
                else:
                    item['reason'] = 'Identity/save key, priority or relation identity/order. Never translated as wording.'
                    protected.append(item)
                if kind.startswith('BGFieldRelation'):
                    target = f['targetSheetId']
                    assert target in lookups
                    refs = [] if value is None else (value if isinstance(value, list) else [value])
                    for i, ref in enumerate(refs):
                        assert ref in lookups[target], (ident, ref)
                        edges.append(dict(sourceCellId=ident, elementIndex=i, targetSheetId=target, targetRowId=ref,
                                          targetName=lookups[target][ref]['cells']['name']))
            multiplicity[s['name'] + '.' + f['name']] = dict(occurrences=len(s['rows']), distinctValuesIncludingNull=len(groups),
                absentCells=sum(r['spans'][f['name']] is None for r in s['rows']),
                duplicates=[dict(source=json.loads(k), rowIds=v) for k, v in groups.items() if len(v) > 1])
    assert bytes(rebuilt) == raw
    assert cells == 904 and spans == 757 and constants == 13
    assert len(visible) == 195 and len(protected) == 709
    assert len({e['id'] for e in visible + protected}) == cells
    # Every literal occurrence in this one output method gets an explicit role.
    # This supplements, and does not overwrite, the live lanes' source inventory.
    visible_offsets = {
        '01fe', '020e', '0220', '0232', '0244', '0257', '02a9',
        '041d', '04a0', '04ba', '04d4', '0506', '0662', '067a',
        '0692', '06aa', '06c2', '070d', '08c8', '09b1', '0a08', '0a5f'}
    comparisons = {'0999', '09f0', '0a47'}
    join_controls = {'0269', '026e'}
    literals = []
    for offset, text in re.findall(r'^IL_([0-9a-f]+): ldstr "(.*)"$', pane_il, re.M):
        role = ('visible-compiled-fragment' if offset in visible_offsets else
                'preserve-exactly-display-comparison' if offset in comparisons else
                'preserve-exactly-assembly-punctuation' if offset in join_controls else
                'preserve-exactly-runtime-identity')
        literals.append(dict(id='QuestLogDetailsPane.UpdateSelectedQuest@IL_' + offset,
                             file='pane.il', offset='IL_' + offset, source=text, role=role))
    assert len([e for e in literals if e['role'] == 'visible-compiled-fragment']) == len(visible_offsets)
    assert len([e for e in literals if e['role'] == 'preserve-exactly-display-comparison']) == 3
    log = next(s for s in decoded['sheets'] if s['name'] == 'QuestProgressLogText')
    quest = next(s for s in decoded['sheets'] if s['name'] == 'Quest')
    matches = [r for r in log['rows'] if 'lost photos' in r['cells']['log_text']]
    assert len(matches) == 1 and matches[0]['id'] == 'jH2Voma0+UW3ZWjlU3KdLQ'
    group = [r for r in log['rows'] if r['cells']['quest'] == matches[0]['cells']['quest']]
    assert [r['cells']['name'] for r in group] == ['MelodyFlipbookQuest_1', 'MelodyFlipbookQuest_2', 'MelodyFlipbookQuest_3']
    assert {r['cells']['priority'] for r in log['rows']} == {0}
    assert all(r['cells']['replace_earlier_log_text'] is None for r in log['rows'])
    qrow = next(r for r in quest['rows'] if r['id'] == matches[0]['cells']['quest'])
    trigger_keys = re.findall(r'ldstr "(melody_flipbook_story_unlock_\d+)"', (HERE / 'photo-count.il').read_text())
    assert trigger_keys == ['melody_flipbook_story_unlock_%02d' % i for i in range(1, 10)]
    assert 'IL_0000: ldc.i4.s 9\nIL_0002: ret' in (HERE / 'photo-count.il').read_text()
    source_cells = [e for e in visible + protected if
                    (e['sheet'] == log['name'] and e['rowId'] in {r['id'] for r in group}) or
                    (e['sheet'] == quest['name'] and e['rowId'] == qrow['id'])]
    counter = dict(id='quest-melody-flipbook-display-comparison', status='scoped-static-source-finding',
        sourceCells=source_cells,
        affectedTextCellIds=[e['id'] for e in visible if e['sheet'] == log['name'] and e['rowId'] == matches[0]['id']],
        literalDependencies=[e for e in literals if e['offset'][3:] in comparisons or e['offset'] in ('IL_095f', 'IL_09b1', 'IL_0a08', 'IL_0a5f', 'IL_08c8')],
        protectedTriggerKeys=trigger_keys, totalPhotos=9,
        outputBindings={k: pane['textBindings'][k]['id'] for k in ('stepHistoryCurrent', 'stepHistory1Back', 'stepHistory2Back')},
        observedBehavior='For MelodyFlipbookQuest only, each nonblank displayed current/1Back/2Back text containing case-sensitive lost photos gets a space plus ({0}/{1}). Numerator counts the nine exact trigger flags; denominator is compiled9. Completion prepends [Quest Completed] and shifts histories first.',
        ordering='All119 priorities0, all119 replacement links absent. History sorts by priority only, reads from end; equal-priority order is not proven. Do not equate row order, unlock chronology or text equality with slot identity.',
        adapterRequirement='Carry the original quest/log row identity through history selection and completion shifting. Append the counter to the selected lost-photos row independently of target wording in all three slots. Keep quest/save/trigger identities, root/priority selection, completion behavior, numerator, denominator and spacing/format arguments unchanged. Do not translate Contains operands or replace English phrases globally.',
        acceptanceScenarios=[
            'Same lost-photos identity in each of current/1Back/2Back with translated display wording still appends exactly one counter, including completion shift.',
            'Each of nine exact flags independently increments numerator; none=0/9 and all=9/9; target wording never changes flags/count.',
            'Sibling _1/_3, another quest, a blank slot, and an unrelated row with identical display wording get no lost-photos counter.',
            'Incomplete/completed status changes slots exactly as original, preserving identity and target text; equal text retains distinct row IDs.'],
        adapter='not-implemented', runtime='not-run', visual='not-run', localeDecision='needs-review; no wording authored',
        completeness='Bounded three-log/one-quest/counter group only. Underlying flag producers/story reachability, other output consumers, shared registry reconciliation and final resource binding pending.')
    # Same valid field type/boundary, changing only the malformed relation width.
    for value in (None, b'', bytes(range(16))):
        decoded_relation = decode_cell('BGFieldRelationSingle', value)
        assert encode_cell('BGFieldRelationSingle', decoded_relation) == (b'' if value is None else value)
    for n in (1, 15, 17):
        rejected(lambda n=n: decode_cell('BGFieldRelationSingle', bytes(n)), 'invalid-single-relation-width')
    assert decode_cell('BGFieldRelationMultiple', bytes(range(16)) * 2) == [bgid(bytes(range(16)))] * 2
    rejected(lambda: decode_cell('BGFieldRelationMultiple', bytes(17)), 'invalid-multiple-relation-width')
    args.output.mkdir(parents=True)
    for name, content in [('visible-fields.jsonl', visible), ('preserve-exactly.jsonl', protected)]:
        (args.output / name).write_text(''.join(json.dumps(row, ensure_ascii=False) + '\n' for row in content))
    dump(args.output / 'relations.json', edges)
    dump(args.output / 'multiplicity.json', multiplicity)
    dump(args.output / 'compiled-literals.json', dict(method='QuestLogDetailsPane.UpdateSelectedQuest', occurrences=literals,
        boundary='One complete selected output method, not complete game compiled-literal inventory. Visible fragments are candidates, not authored target text.'))
    dump(args.output / 'counter-dependency.json', counter)
    dump(args.output / 'native-text-bindings.json', dict(source=bindings['source'], controller=pane,
        boundary='Seven original serialized native Text objects; runtime listener/visibility/font feasibility not tested.'))
    dump(args.output / 'verification.json', dict(status='passed-static-scoped', checkedInstalledSources={n: source[n]['sha256'] for n in checked},
        textAssetRawSha256=record['rawSha256'], exportedBytes=len(raw), sourceSha256=SOURCE_SHA,
        logRows=119, logColumns=6, adjacentQuestRows=38, adjacentQuestColumns=5,
        exactCellStates=cells, storedSpansReencoded=spans, absentStates=cells-spans,
        displayCandidateStates=len(visible), nonemptyDisplayCandidates=sum(bool(e['source']) for e in visible), protectedStates=len(protected),
        relationEdges=len(edges), consumerConstantIdsMatched=constants, exactIlSelections=len(commands), nativeTextRawHashesChecked=7,
        priorPaneInstructionsEqual=True, compiledLiteralOccurrences=len(literals), compiledVisibleFragments=len(visible_offsets),
        displayComparisonOccurrences=3, lostPhotosSourceRows=len(matches),
        frozenPinsUnchanged=19, allInventoryEvidenceHashesUnchanged=True, noOpInputBytesEqual=bytes(rebuilt)==raw,
        reconstructedInputSha256=hashlib.sha256(rebuilt).hexdigest(), singleRelationPositiveAndMalformedWidthControls=True,
        multipleRelationOrderMultiplicityAndMalformedWidthControls=True, gameLaunches=0, imagesOpened=0,
        gameAssemblyExecuted=False, translationAuthored=False, resourceReinsertion='not-run', runtime='not-run', visual='not-run',
        sourceAcceptance='needs-review; supplement only; other Quest columns/families and special-scene dependencies pending'))
    print(json.dumps(dict(cells=cells, storedSpans=spans, candidateStates=len(visible), nonemptyCandidates=sum(bool(e['source']) for e in visible),
                          protectedStates=len(protected), relations=len(edges), constants=constants, ilSelections=len(commands))))


if __name__ == '__main__':
    main()
