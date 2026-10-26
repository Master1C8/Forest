#!/usr/bin/env python3
"""Verify original Actor cells, identity/output bindings and frozen source copies.

Static Cecil/UnityPy read only. Never execute game assemblies or reinsert resources.
"""
import argparse
import collections
import hashlib
import json
from pathlib import Path
import re
import subprocess
import sys
from urllib.parse import quote

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[3]
sys.path[:0] = [str(HERE), str(HERE.parent / 'quest-progress'), str(ROOT / 'tools')]
from decode_actor import SOURCE, SOURCE_SHA, decode, decode_cell, encode_cell
from verify_quest import generated_id, rejected
from extract_assets import canonical
import UnityPy

DATA = Path('/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest/The Forest of Love_Data')
DISPLAY = ('nameplate_name', 'full_name')
REASONS = {
    'name': 'BGEntity.Name -> runtime dbName, dictionary/trigger/actor lookup identity; not display spelling',
    'savekey': 'Runtime savekey -> Savestate.LoadActorData and actorSavekey; preserve save identity',
    'plugin_db_name': 'Exact PixelCrushers actor Name lookup and player/narrator comparisons; preserve identity',
    'exclude_from_save': 'Runtime isExcludedFromSavestate guards saving/restoration; protected boolean',
    'exclude_from_critter_log': 'Runtime isExcludedFromCritterLog guards critter-log/map enumeration; protected boolean',
    'nameplate_name': 'Default NameplateName display candidate; BioDetail/custom/reveal/movie paths can replace it; keep dbName identities separate',
    'full_name': 'Default FullName display candidate; shipped getter uses overrideNameplateName rather than overrideFullName; preserve original anomaly',
}


def sha(p):
    return hashlib.sha256(p.read_bytes()).hexdigest()


def dump(p, data):
    p.write_text(json.dumps(canonical(data), ensure_ascii=False, indent=2) + '\n')


def selector(sheet, row, field):
    return 'bgdb:resources.assets:320/sheet/' + quote(sheet, safe='') + '/row/' + quote(row, safe='') + '/field/' + quote(field, safe='')


def method(file, name):
    text = (HERE / file).read_text()
    starts = list(re.finditer(r'^METHOD [^\n]*::' + re.escape(name) + r'\(', text, re.M))
    assert len(starts) == 1, (file, name)
    return text[starts[0].start():].split('\nMETHOD ', 1)[0]


def build(out):
    baseline = json.loads((HERE / 'baseline.json').read_text())
    assert len(baseline['pins']) == 19
    assert all(sha(Path(p)) == h for p, h in baseline['pins'].items())
    assert all(sha(ROOT / p) == h for p, h in baseline['owningHelpers'].items())
    for key, directory in [('priorQuestEvidence', 'quest-progress'), ('priorInventoryEvidence', ''),
                           ('priorConsumersEvidence', 'quest-consumers'), ('priorControlsEvidence', 'quest-controls')]:
        assert all(sha(HERE.parent / directory / p) == h for p, h in baseline[key].items()), key
    assert sha(HERE.parent / 'verification.json') == baseline['priorInventoryVerificationSha256']
    sources = json.loads((ROOT / 'assets/source-v2/source-files.json').read_text())
    checked = ['resources.assets', 'sharedassets2.assets', 'Managed/Assembly-CSharp.dll', 'Managed/BGDatabase.dll',
               'sharedassets0.assets', 'StreamingAssets/aa/StandaloneWindows64/defaultlocalgroup_assets_all_298c5a4d1d1846b1a8d2c7d5da3f319c.bundle',
               'Managed/Assembly-CSharp-firstpass.dll', 'Managed/Auto-asmdef-FirstPass.dll', 'Managed/Auto-asmdef-SecondPass.dll']
    assert all(sha(DATA / p) == sources[p]['sha256'] for p in checked)
    rec = next(r for r in json.loads((ROOT / 'assets/source-v2/text-assets.json').read_text()) if r['id'] == 'resources.assets:320')
    env = UnityPy.load(str(DATA / 'resources.assets'))
    objs = [o for o in env.objects if o.path_id == 320 and Path(o.assets_file.name).name == 'resources.assets']
    assert len(objs) == 1 and objs[0].type.name == 'TextAsset'
    assert hashlib.sha256(objs[0].get_raw_data()).hexdigest() == rec['rawSha256']
    obj = objs[0].read()
    raw = obj.m_Script.encode('utf-8', 'surrogateescape') if isinstance(obj.m_Script, str) else bytes(obj.m_Script)
    assert obj.m_Name == 'bansheegz_database' and raw == SOURCE.read_bytes() and sha(SOURCE) == SOURCE_SHA
    decoded = decode(raw)
    assert decoded == json.loads((HERE / 'decoded.json').read_text())
    commands = json.loads((HERE / 'il-commands.json').read_text())
    assert len(commands) == len({c['output'] for c in commands})
    for c in commands:
        actual = subprocess.check_output(['dotnet', str(ROOT / 'tools/probe/bin/Debug/net8.0/InspectMethods.dll'),
                                         str(DATA / 'Managed' / c['assembly']), c['type'], c['selection']])
        assert actual == (HERE / c['output']).read_bytes() and hashlib.sha256(actual).hexdigest() == c['sha256']
    sheet = decoded['sheets'][0]
    il = (HERE / 'db-actor.il').read_text()
    assert generated_id(il, 'get_MetaDefault') == sheet['id']
    constants = 1
    visible, protected, multiplicity = [], [], {}
    rebuilt = bytearray(raw)
    for f in sheet['fields']:
        assert generated_id(il, 'get__' + f['name']) == f['id']
        constants += 1
        kind = f['type'].split(',')[0].rsplit('.', 1)[-1]
        groups = collections.defaultdict(list)
        for row in sheet['rows']:
            value, span = row['cells'][f['name']], row['spans'][f['name']]
            encoded = encode_cell(kind, value)
            if span is None:
                assert value is None
            else:
                start, size = span['offset'], span['bytes']
                assert encoded == raw[start:start+size] and len(encoded) == size
                rebuilt[start:start+size] = encoded
            role = 'authored-display-candidate' if f['name'] in DISPLAY else 'preserve-exactly'
            c = dict(id=selector(sheet['id'], row['id'], f['id']), sheet='Actor', sheetId=sheet['id'], rowId=row['id'],
                     rowIndex=row['index'], field=f['name'], fieldId=f['id'], source=value, sourceSpan=span,
                     sourceBytesHex=encoded.hex() if span is not None else None, role=role, reason=REASONS[f['name']])
            (visible if f['name'] in DISPLAY else protected).append(c)
            groups[json.dumps(value, ensure_ascii=False, sort_keys=True)].append(row['id'])
        multiplicity[f['name']] = dict(occurrences=len(sheet['rows']), absentStates=sum(r['spans'][f['name']] is None for r in sheet['rows']),
            distinctValuesIncludingNull=len(groups), duplicates=[dict(source=json.loads(k), rowIds=v) for k,v in groups.items() if len(v)>1])
    cells = visible + protected
    assert len(cells) == len({c['id'] for c in cells}) == 273
    assert len(visible) == 78 and len(protected) == 195 and bytes(rebuilt) == raw
    for key in ('name', 'savekey', 'plugin_db_name'):
        values = [r['cells'][key] for r in sheet['rows']]
        assert None not in values and len(set(values)) == len(values), key
    for key in ('name', 'savekey', 'plugin_db_name'):
        matches = [k for k in sheet['keys'] if k['fieldIds'] == [next(f['id'] for f in sheet['fields'] if f['name'] == key)]]
        assert len(matches) == 1 and matches[0]['unique'] is True
    # Both unchanged dialogue trees and all candidate values. Identity maps do not
    # become translated candidates, and do not assume dialogue neighbors are sequential.
    manifest = json.loads((ROOT / 'localization/source/dialogue-manifest.json').read_text())
    candidates = [json.loads(s) for s in (ROOT / 'localization/source/dialogue-candidates.jsonl').read_text().splitlines()]
    assert len(candidates) == manifest['candidateUnits'] == 12246
    assert len({r['id'] for r in candidates}) == len(candidates)
    copies, mappings = [], []
    for copy in manifest['sources']:
        assert sha(ROOT / copy['tree']) == copy['treeSha256']
        tree = json.loads((ROOT / copy['tree']).read_text())
        for c in candidates:
            value = tree
            for part in c['pointer'].strip('/').split('/'):
                part = part.replace('~1', '/').replace('~0', '~')
                value = value[int(part)] if isinstance(value, list) else value[part]
            assert value == c['source'], (copy['object'], c['id'])
        names = []
        for i, actor in enumerate(tree['actors']):
            fields = [(j,f) for j,f in enumerate(actor['fields']) if f['title'] == 'Name']
            assert len(fields) == 1
            j, field = fields[0]
            names.append(dict(actorIndex=i, actorId=actor['id'], name=field['value'], pointer=f'/actors/{i}/fields/{j}/value'))
        assert len(names) == len({a['actorId'] for a in names}) == len({a['name'] for a in names})
        for row in sheet['rows']:
            matches = [n for n in names if n['name'] == row['cells']['plugin_db_name']]
            assert len(matches) <= 1
            mappings.append(dict(rowId=row['id'], dbName=row['cells']['name'], pluginDbName=row['cells']['plugin_db_name'],
                copyObject=copy['object'], tree=copy['tree'], treeSha256=copy['treeSha256'], matches=matches,
                status='exact-static-match' if matches else 'no-exact-original-plugin-actor', runtime='not-run'))
        copies.append(dict(object=copy['object'], tree=copy['tree'], sha256=copy['treeSha256'], exactCandidateValues=len(candidates), pluginActors=len(names)))
    assert len(copies) == 2
    for row in sheet['rows']:
        pair = [m for m in mappings if m['rowId'] == row['id']]
        assert len(pair) == 2 and pair[0]['matches'] == pair[1]['matches']
    # Assertions bind semantic findings to precise original instruction sequences.
    full = method('actor-display.il', 'get_FullName')
    assert 'overrideFullName' not in full and full.count('BioDetail::overrideNameplateName') == 2
    assert 'Actor::fullNameDbDefault' in full
    normal = method('nameplate.il', 'UpdateNameplate')
    assert 'GetActorByDbName' in normal and 'get_IsIntroduced' in normal and 'get_inStartMenu' in normal and 'InAnyInstancedStory' in normal
    assert 'IL_0076: ldstr "narrator"' in normal and 'IL_0099: ldstr "player"' in normal
    assert 'Actor::dbName' in method('nameplate-input.il', 'OnConversationLine_Handler')
    assert 'Asset::get_Name()' in (HERE / 'plugin-actor-compare.il').read_text() and 'System.String::Equals(System.String,System.String)' in (HERE / 'plugin-actor-compare.il').read_text()
    for file, name in [('named-label.il', 'SetText'), ('named-status.il', 'SetStatus'), ('map-label.il', 'SetSelectionLabelText'), ('portrait-label.il', 'UpdateChildLabels')]:
        assert 'set_text(System.String)' in method(file, name)
    for b in (b'\0', b'\1'):
        assert encode_cell('BGFieldBool', decode_cell('BGFieldBool', b)) == b
    for b in (b'', b'\0\1'):
        rejected(lambda b=b: decode_cell('BGFieldBool', b), 'invalid-bool-width')
    rejected(lambda: decode_cell('BGFieldBool', b'\2'), 'noncanonical-bool-byte')
    dependencies = []
    for row in sheet['rows']:
        own = [c for c in cells if c['rowId'] == row['id']]
        dependencies.append(dict(actorRowId=row['id'], actorRowIndex=row['index'], dbName=row['cells']['name'],
            protectedCellIds=[c['id'] for c in own if c['role']=='preserve-exactly'], defaultDisplayCellIds=[c['id'] for c in own if c['role']=='authored-display-candidate'],
            pluginMappings=[m for m in mappings if m['rowId']==row['id']],
            revealPolicy='Ordinary nameplate: ??? unless start menu, introduced or any instanced story. Critter log/bio/gossip: introduction masks. Movie/custom paths differ.',
            defaultConsumers=['DialogueNameplateController.UpdateNameplate','CritterLog.UpdateResidentLabelState','CustomPortraitsUi.OnConversationLine_Handler','MapUI.InitCritterLocations','OverworldAllInOneNotification.EnqueueGossipNotification','CritterLogBioPane.UpdateSelectedBio'],
            defaultOverride='BioDetail overrideNameplateName replaces both NameplateName and FullName. Related BioDetail rows/tags/reachability not decoded in this supplement.',
            saveExcluded=row['cells']['exclude_from_save'], critterAndMapExcluded=row['cells']['exclude_from_critter_log'],
            adaptation='Separate display-cell mapping; never translate dbName, savekey or pluginDbName; no target mapping authored'))
    for name, rows in [('visible-fields.jsonl', visible), ('preserve-exactly.jsonl', protected)]:
        (out/name).write_text(''.join(json.dumps(c,ensure_ascii=False)+'\n' for c in rows))
    dump(out/'multiplicity.json', multiplicity)
    dump(out/'dependency-bindings.json', dependencies)
    dump(out/'source-copies.json', copies)
    dump(out/'plugin-actor-bindings.json', mappings)
    stats = dict(status='passed-static-scoped', checkedInstalledSources={p:sources[p]['sha256'] for p in checked}, textAssetRawSha256=rec['rawSha256'],
        exportedBytes=len(raw), sourceSha256=SOURCE_SHA, frozenPinsUnchanged=19, helpersChecked=len(baseline['owningHelpers']),
        priorEvidenceHashes={k:len(baseline[k]) for k in ('priorInventoryEvidence','priorQuestEvidence','priorConsumersEvidence','priorControlsEvidence')},
        actorRows=39, actorColumns=7, exactCellStates=len(cells), displayCandidateStates=len(visible), nonemptyDisplayCandidates=sum(bool(c['source']) for c in visible),
        protectedStates=len(protected), storedSpansReencoded=sum(c['sourceSpan'] is not None for c in cells), absentStates=sum(c['sourceSpan'] is None for c in cells),
        saveExcluded=sum(r['cells']['exclude_from_save'] for r in sheet['rows']), critterLogAndMapExcluded=sum(r['cells']['exclude_from_critter_log'] for r in sheet['rows']),
        uniqueIdentityColumns=3, generatedConstantIdsMatched=constants, exactIlSelections=len(commands), dialogueCopies=2, exactDialogueSourceOccurrences=24492,
        pluginMappingStates=len(mappings), pluginExactMatches=sum(bool(m['matches']) for m in mappings), pluginMissingStates=sum(not m['matches'] for m in mappings),
        noOpWholeInputBytesEqual=True, canonicalBoolAndMalformedControls=True, sourceAnomaly='FullName uses overrideNameplateName; no source repair',
        gameLaunches=0, imagesOpened=0, gameAssemblyExecuted=False, translationAuthored=False, gitMutations=0,
        reinsertion='not-run', runtime='not-run', visual='not-run', editorial='not-run', wholeGameSourceAcceptance=False, usage='Unknown in worker; parent measures telemetry')
    dump(out/'verification.json', stats)
    return stats


if __name__ == '__main__':
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument('--output', type=Path, required=True)
    args=p.parse_args()
    assert not args.output.exists()
    args.output.mkdir(parents=True)
    print(json.dumps(build(args.output)))
