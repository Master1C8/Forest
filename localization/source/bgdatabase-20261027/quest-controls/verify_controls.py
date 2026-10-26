#!/usr/bin/env python3
"""Verify exact original Quest controls, Tag links, IL and two frozen dialogue copies.

No game assembly execution, pixels, translation, resources or prior evidence writes.
"""
import argparse
import collections
import hashlib
import json
from pathlib import Path
import subprocess
import sys
from urllib.parse import quote

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[3]
PRIOR = HERE.parent / 'quest-progress'
sys.path[:0] = [str(ROOT / 'tools'), str(HERE), str(PRIOR)]
from decode_controls import SOURCE, SOURCE_SHA, decode, decode_cell, encode_cell
from decode_quest import decode as prior_decode, encode_cell as prior_encode
from verify_quest import generated_id, rejected
from extract_assets import canonical
import UnityPy

DATA = Path('/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest/The Forest of Love_Data')


def sha(p):
    return hashlib.sha256(p.read_bytes()).hexdigest()


def dump(p, data):
    p.write_text(json.dumps(canonical(data), ensure_ascii=False, indent=2) + '\n')


def build(out):
    b = json.loads((HERE / 'baseline.json').read_text())
    assert len(b['pins']) == 19 and all(sha(Path(p)) == h for p, h in b['pins'].items())
    assert all(sha(ROOT / p) == h for p, h in b['owningHelpers'].items())
    for field, base in [('priorQuestEvidence', PRIOR), ('priorInventoryEvidence', HERE.parent),
                        ('priorConsumersEvidence', HERE.parent / 'quest-consumers')]:
        assert all(sha(base / p) == h for p, h in b[field].items()), field
    assert sha(HERE.parent / 'verification.json') == b['priorInventoryVerificationSha256']
    sources = json.loads((ROOT / 'assets/source-v2/source-files.json').read_text())
    checked = ['resources.assets', 'sharedassets2.assets', 'Managed/Assembly-CSharp.dll', 'Managed/BGDatabase.dll',
               'sharedassets0.assets', 'StreamingAssets/aa/StandaloneWindows64/defaultlocalgroup_assets_all_298c5a4d1d1846b1a8d2c7d5da3f319c.bundle']
    assert all(sha(DATA / p) == sources[p]['sha256'] for p in checked)
    rec = next(r for r in json.loads((ROOT / 'assets/source-v2/text-assets.json').read_text()) if r['id'] == 'resources.assets:320')
    env = UnityPy.load(str(DATA / 'resources.assets'))
    objs = [o for o in env.objects if o.path_id == 320 and Path(o.assets_file.name).name == 'resources.assets']
    assert len(objs) == 1 and objs[0].type.name == 'TextAsset'
    assert hashlib.sha256(objs[0].get_raw_data()).hexdigest() == rec['rawSha256']
    obj = objs[0].read(); raw = obj.m_Script.encode('utf-8', 'surrogateescape') if isinstance(obj.m_Script, str) else bytes(obj.m_Script)
    assert obj.m_Name == 'bansheegz_database' and raw == SOURCE.read_bytes() and sha(SOURCE) == SOURCE_SHA
    old = prior_decode(raw); assert old == json.loads((PRIOR / 'decoded.json').read_text())
    decoded = decode(raw); assert decoded == json.loads((HERE / 'decoded.json').read_text())
    commands = json.loads((HERE / 'il-commands.json').read_text())
    for c in commands:
        actual = subprocess.check_output(['dotnet', str(ROOT / 'tools/probe/bin/Debug/net8.0/InspectMethods.dll'),
                                         str(DATA / 'Managed' / c['assembly']), c['type'], c['selection']])
        assert actual == (HERE / c['output']).read_bytes() and hashlib.sha256(actual).hexdigest() == c['sha256']
    # Frozen candidate source is compared to both exact source-copy pointers.
    manifest = json.loads((ROOT / 'localization/source/dialogue-manifest.json').read_text())
    candidates = [json.loads(s) for s in (ROOT / 'localization/source/dialogue-candidates.jsonl').read_text().splitlines()]
    assert len(candidates) == manifest['candidateUnits'] == 12246
    assert len({r['id'] for r in candidates}) == len(candidates)
    copies = []
    for copy in manifest['sources']:
        assert sha(ROOT / copy['tree']) == copy['treeSha256']
        tree = json.loads((ROOT / copy['tree']).read_text())
        for row in candidates:
            value = tree
            for part in row['pointer'].strip('/').split('/'):
                part = part.replace('~1', '/').replace('~0', '~')
                value = value[int(part)] if isinstance(value, list) else value[part]
            assert value == row['source'], (copy['object'], row['id'])
        copies.append(dict(object=copy['object'], tree=copy['tree'], sha256=copy['treeSha256'], exactCandidateValues=len(candidates)))
    assert len(copies) == 2
    old_cells = [json.loads(s) for f in ['visible-fields.jsonl', 'preserve-exactly.jsonl'] for s in (PRIOR / 'readback' / f).read_text().splitlines()]
    old_sheets = {s['name']:s for s in old['sheets']}
    for c in old_cells:
        s = old_sheets[c['sheet']]; r = s['rows'][c['rowIndex']]; f = next(f for f in s['fields'] if f['id'] == c['fieldId'])
        assert c['rowId'] == r['id'] and c['source'] == r['cells'][c['field']]
        span = c['sourceSpan']
        if span:
            kind = f['type'].split(',')[0].rsplit('.',1)[-1]
            assert prior_encode(kind,c['source']) == raw[span['offset']:span['offset']+span['bytes']]
        else:
            assert c['source'] is None
    assert len(old_cells) == 904
    sheets = {s['name']:s for s in decoded['sheets']}; quest, tags = sheets['Quest'], sheets['Tag']
    tag_map = {r['id']: r for r in tags['rows']}; assert len(tag_map) == 18
    for key in ['name','savekey']:
        vals = [r['cells'][key] for r in tags['rows']]
        assert None not in vals and len(vals) == len(set(vals))
    protected, relations, multiplicity, constants = [], [], {}, 0
    rebuilt = bytearray(raw)
    for s in decoded['sheets']:
        il = (HERE / ('db-controls.il' if s['name'] == 'Quest' else 'db-tag.il')).read_text()
        assert generated_id(il,'get_MetaDefault') == s['id']; constants += 1
        for f in s['fields']:
            assert generated_id(il,'get__'+f['name']) == f['id']; constants += 1
            kind = f['type'].split(',')[0].rsplit('.',1)[-1]; groups = collections.defaultdict(list)
            for row in s['rows']:
                value,span = row['cells'][f['name']],row['spans'][f['name']]
                ident = 'bgdb:resources.assets:320/sheet/'+quote(s['id'],safe='')+'/row/'+quote(row['id'],safe='')+'/field/'+quote(f['id'],safe='')
                encoded = encode_cell(kind,value)
                if span is None:
                    assert value is None
                else:
                    start,size = span['offset'],span['bytes']; assert encoded == raw[start:start+size] and len(encoded) == size
                    rebuilt[start:start+size] = encoded
                protected.append(dict(id=ident,sheet=s['name'],sheetId=s['id'],rowId=row['id'],rowIndex=row['index'],field=f['name'],fieldId=f['id'],source=value,sourceSpan=span,sourceBytesHex=encoded.hex() if span else None,role='preserve-exactly',reason='Runtime identity, tag relation/order, boolean/integer control or sprite resource key; not authored display wording'))
                groups[json.dumps(value,ensure_ascii=False,sort_keys=True)].append(row['id'])
                if kind == 'BGFieldRelationMultiple':
                    assert f['targetSheetId'] == tags['id'] and f['allowDuplicates'] is False
                    for i, target in enumerate(value or []):
                        assert target in tag_map
                        relations.append(dict(sourceCellId=ident,elementIndex=i,targetSheetId=tags['id'],targetRowId=target,targetName=tag_map[target]['cells']['name'],targetSavekey=tag_map[target]['cells']['savekey']))
            multiplicity[s['name']+'.'+f['name']] = dict(occurrences=len(s['rows']), absentStates=sum(r['spans'][f['name']] is None for r in s['rows']), distinctValuesIncludingNull=len(groups), duplicates=[dict(source=json.loads(k),rowIds=v) for k,v in groups.items() if len(v)>1])
    assert bytes(rebuilt) == raw and len(protected) == 302 and constants == 11
    # Width and byte-preservation controls exercise the new bool codec only.
    for value in [b'\0',b'\1']:
        assert encode_cell('BGFieldBool',decode_cell('BGFieldBool',value)) == value
    for value in [b'',b'\0\1']:
        rejected(lambda value=value: decode_cell('BGFieldBool',value),'invalid-bool-width')
    rejected(lambda: decode_cell('BGFieldBool',b'\2'),'noncanonical-bool-byte')
    for value in [None,b'',bytes(range(16))*2]:
        assert encode_cell('BGFieldRelationMultiple',decode_cell('BGFieldRelationMultiple',value)) == (value or b'')
    rejected(lambda: decode_cell('BGFieldRelationMultiple',bytes(17)),'invalid-multiple-relation-width')
    by_quest = {r['id']:r for r in old_sheets['Quest']['rows']}
    dependencies = []
    for row in quest['rows']:
        related = [r for r in old_sheets['QuestProgressLogText']['rows'] if r['cells']['quest'] == row['id']]
        selected_cells = [c for c in protected if c['rowId']==row['id']]
        tag_ids = list(dict.fromkeys((row['cells']['enable_with_tags'] or [])+(row['cells']['disable_with_tags'] or [])))
        display = [c['id'] for c in old_cells if c['role']=='authored-display-candidate' and c['rowId'] in {row['id'],*(r['id'] for r in related)}]
        dependencies.append(dict(questRowId=row['id'],questName=by_quest[row['id']]['cells']['name'],controlCellIds=[c['id'] for c in selected_cells],displayCandidateCellIds=display,
            tagIdentityCellIds=[c['id'] for c in protected if c['sheet']=='Tag' and c['rowId'] in tag_ids],
            enableTagRowIds=row['cells']['enable_with_tags'],disableTagRowIds=row['cells']['disable_with_tags'],
            availability='No active disabling tag AND at least one active enabling tag. Runtime active set/reachability unverified.',
            hidden=row['cells']['bio_hidden'],isSideQuest=row['cells']['is_side_quest'],priority=row['cells']['priority'],portraitStoredKey=row['cells']['bio_portrait'],
            initialUnlock='Existing runtime list[0] paths unchanged; declared initial relations/exact first row/reflection remain unverified'))
    (out/'preserve-exactly.jsonl').write_text(''.join(json.dumps(c,ensure_ascii=False)+'\n' for c in protected))
    dump(out/'relations.json',relations);dump(out/'multiplicity.json',multiplicity);dump(out/'dependency-bindings.json',dependencies);dump(out/'source-copies.json',copies)
    stats = dict(status='passed-static-scoped',checkedInstalledSources={p:sources[p]['sha256'] for p in checked},textAssetRawSha256=rec['rawSha256'],exportedBytes=len(raw),sourceSha256=SOURCE_SHA,
        frozenPinsUnchanged=19,helpersChecked=len(b['owningHelpers']),priorInventoryEvidenceHashes=len(b['priorInventoryEvidence']),priorQuestEvidenceHashes=len(b['priorQuestEvidence']),priorConsumerEvidenceHashes=len(b['priorConsumersEvidence']),
        priorCellStatesRechecked=904,questRows=38,questNewColumns=7,tagRows=18,tagIdentityColumns=2,exactProtectedStates=len(protected),storedSpansReencoded=sum(c['sourceSpan'] is not None for c in protected),absentStates=sum(c['sourceSpan'] is None for c in protected),
        relationEdges=len(relations),enableRelationEdges=sum('enable_with_tags'==c['field'] and isinstance(c['source'],list) and len(c['source']) or 0 for c in protected),disableRelationEdges=sum('disable_with_tags'==c['field'] and isinstance(c['source'],list) and len(c['source']) or 0 for c in protected),
        generatedConstantIdsMatched=constants,exactIlSelections=len(commands),dialogueCopies=2,exactDialogueSourceOccurrences=24492,noOpWholeInputBytesEqual=True,
        hiddenQuests=sum(r['cells']['bio_hidden'] for r in quest['rows']),sideQuests=sum(r['cells']['is_side_quest'] for r in quest['rows']),portraitKeys=sum(bool(r['cells']['bio_portrait']) for r in quest['rows']),
        canonicalBoolAndMalformedControls=True,relationOrderMultiplicityAndMalformedControls=True,gameLaunches=0,imagesOpened=0,gameAssemblyExecuted=False,translationAuthored=False,gitMutations=0,
        reinsertion='not-run',runtime='not-run',visual='not-run',editorial='not-run',wholeGameSourceAcceptance=False,usage='Unknown in worker; parent measures telemetry')
    dump(out/'verification.json',stats)
    return stats


if __name__ == '__main__':
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('--output',type=Path,required=True);args=p.parse_args()
    assert not args.output.exists();args.output.mkdir(parents=True)
    print(json.dumps(build(args.output)))
