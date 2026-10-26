#!/usr/bin/env python3
"""Reproduce exact BioDetail source readback and bounded original consumers.

Static only: no resource writes, game assembly execution, images or target text.
"""
import argparse
import collections
import hashlib
import itertools
import json
from pathlib import Path
import subprocess
import sys
from urllib.parse import quote

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[3]
sys.path[:0] = [str(HERE), str(HERE.parent/'quest-progress'), str(ROOT/'tools')]
from decode_bio import SOURCE, SOURCE_SHA, decode, decode_cell, encode_cell
from verify_quest import generated_id, rejected
from extract_assets import canonical
import UnityPy

DATA = Path('/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest/The Forest of Love_Data')
DISPLAY = {'BioDetail': ('nameplate_name_override','full_name_override'), 'BioKeyword': ('bio_text',)}
REASONS = {
    'name': 'Original runtime dbName / dictionary / keyword-data identity; preserve spelling',
    'actor': 'Exact Actor relation ID; reverse relation builds runtime actor.bioDetails list',
    'bio_portrait': 'Addressables resource key, not display text; callback supplies portrait sprite',
    'nameplate_name_override': 'Nullable display override used by BOTH NameplateName and FullName; all original cells absent',
    'full_name_override': 'Nullable separately loaded override; no read in bounded original Assembly-CSharp field search; all cells absent',
    'line1': 'Exact BioKeyword relation -> species slot; null is not invented text',
    'line2': 'Exact BioKeyword relation -> age slot; null is not invented text',
    'line3': 'Exact BioKeyword relation -> role slot; null is not invented text',
    'enable_with_tags': 'Protected Tag relation IDs; any active tag selects first matching BioDetail',
    'is_default': 'Protected fallback flag; first default chosen only after no tagged match',
    'bio_text': 'BioKeyword.text -> BioDetail slot text -> critter subtitles after keyword unlock; display candidate, no editorial acceptance',
    'savekey': 'Keyword save identity; preserve exact source including town_arial_taxi spelling',
    'plugin_db_trigger_name': 'Exact plugin keyword trigger lookup identity; preserve separately from bio_text',
}


def sha(p):
    return hashlib.sha256(p.read_bytes()).hexdigest()


def dump(p, value):
    p.write_text(json.dumps(canonical(value), ensure_ascii=False, indent=2)+'\n')


def selector(sheet, row, field):
    return 'bgdb:resources.assets:320/sheet/'+quote(sheet,safe='')+'/row/'+quote(row,safe='')+'/field/'+quote(field,safe='')


def cell(sheet, row, field):
    f = next(f for f in sheet['fields'] if f['name'] == field)
    return dict(id=selector(sheet['id'],row['id'],f['id']), sheet=sheet['name'],sheetId=sheet['id'],
                rowId=row['id'],rowIndex=row['index'],field=field,fieldId=f['id'],source=row['cells'][field],sourceSpan=row['spans'][field])


def build(out):
    baseline = json.loads((HERE/'baseline.json').read_text())
    assert len(baseline['pins']) == 19
    assert all(sha(Path(p)) == h for p,h in baseline['pins'].items())
    assert all(sha(ROOT/p) == h for p,h in baseline['owningHelpers'].items())
    prior = [('priorInventoryEvidence',''),('priorQuestEvidence','quest-progress'),
             ('priorConsumersEvidence','quest-consumers'),('priorControlsEvidence','quest-controls'),
             ('priorActorEvidence','actor-identity')]
    for key, directory in prior:
        assert all(sha(HERE.parent/directory/p) == h for p,h in baseline[key].items()), key
    assert sha(HERE.parent/'verification.json') == baseline['priorInventoryVerificationSha256']
    sources = json.loads((ROOT/'assets/source-v2/source-files.json').read_text())
    checked = ['resources.assets','sharedassets2.assets','Managed/Assembly-CSharp.dll','Managed/BGDatabase.dll',
               'sharedassets0.assets','StreamingAssets/aa/StandaloneWindows64/defaultlocalgroup_assets_all_298c5a4d1d1846b1a8d2c7d5da3f319c.bundle',
               'Managed/Assembly-CSharp-firstpass.dll','Managed/Auto-asmdef-FirstPass.dll','Managed/Auto-asmdef-SecondPass.dll']
    assert all(sha(DATA/p) == sources[p]['sha256'] for p in checked)
    rec = next(r for r in json.loads((ROOT/'assets/source-v2/text-assets.json').read_text()) if r['id']=='resources.assets:320')
    env = UnityPy.load(str(DATA/'resources.assets'))
    objs = [o for o in env.objects if o.path_id==320 and Path(o.assets_file.name).name=='resources.assets']
    assert len(objs)==1 and objs[0].type.name=='TextAsset'
    assert hashlib.sha256(objs[0].get_raw_data()).hexdigest()==rec['rawSha256']
    obj=objs[0].read()
    raw=obj.m_Script.encode('utf-8','surrogateescape') if isinstance(obj.m_Script,str) else bytes(obj.m_Script)
    assert obj.m_Name=='bansheegz_database' and raw==SOURCE.read_bytes() and sha(SOURCE)==SOURCE_SHA
    decoded=decode(raw)
    assert decoded==json.loads((HERE/'decoded.json').read_text())
    commands=json.loads((HERE/'il-commands.json').read_text())
    assert len(commands)==len({c['output'] for c in commands})
    for c in commands:
        actual=subprocess.check_output(['dotnet',str(ROOT/'tools/probe/bin/Debug/net8.0/InspectMethods.dll'),str(DATA/'Managed'/c['assembly']),c['type'],c['selection']])
        assert actual==(HERE/c['output']).read_bytes() and hashlib.sha256(actual).hexdigest()==c['sha256']
    detail, keywords=decoded['sheets']
    actors=json.loads((HERE.parent/'actor-identity/decoded.json').read_text())['sheets'][0]
    tags=next(s for s in json.loads((HERE.parent/'quest-controls/decoded.json').read_text())['sheets'] if s['name']=='Tag')
    sheets={s['id']:s for s in (detail,keywords,actors,tags)}
    visible, protected, relations, multiplicity=[],[],[],{}
    rebuilt=bytearray(raw)
    constants=0
    for sheet, filename in [(detail,'db-detail.il'),(keywords,'db-keyword.il')]:
        il=(HERE/filename).read_text()
        assert generated_id(il,'get_MetaDefault')==sheet['id']; constants+=1
        for f in sheet['fields']:
            assert generated_id(il,'get__'+f['name'])==f['id']; constants+=1
            kind=f['type'].split(',')[0].rsplit('.',1)[-1]
            groups=collections.defaultdict(list)
            for row in sheet['rows']:
                c=cell(sheet,row,f['name']); value,span=c['source'],c['sourceSpan']
                encoded=encode_cell(kind,value)
                if span is None:
                    assert value is None
                else:
                    start,size=span['offset'],span['bytes']
                    assert encoded==raw[start:start+size] and len(encoded)==size
                    rebuilt[start:start+size]=encoded
                c.update(sourceBytesHex=encoded.hex() if span is not None else None,
                         role='authored-display-candidate' if f['name'] in DISPLAY[sheet['name']] else 'preserve-exactly',reason=REASONS[f['name']])
                (visible if c['role']=='authored-display-candidate' else protected).append(c)
                groups[json.dumps(value,ensure_ascii=False,sort_keys=True)].append(row['id'])
                if kind.startswith('BGFieldRelation'):
                    targets=value if isinstance(value,list) else ([] if value is None else [value])
                    target=sheets[f['targetSheetId']]
                    for i,target_id in enumerate(targets):
                        matches=[r for r in target['rows'] if r['id']==target_id]
                        assert len(matches)==1
                        tr=matches[0]
                        relations.append(dict(sourceCellId=c['id'],sourceField=f['name'],sourceRowId=row['id'],relationIndex=i,
                                              targetSheet=target['name'],targetSheetId=target['id'],targetRowId=target_id,targetRowIndex=tr['index'],
                                              targetCells=[cell(target,tr,tf['name']) for tf in target['fields']]))
            multiplicity[sheet['name']+'.'+f['name']]=dict(states=len(sheet['rows']),absent=sum(r['spans'][f['name']] is None for r in sheet['rows']),
                distinctIncludingNull=len(groups),duplicates=[dict(source=json.loads(k),rowIds=v) for k,v in groups.items() if len(v)>1])
    cells=visible+protected
    assert len(cells)==len({c['id'] for c in cells})==280
    assert len(visible)==61 and len(protected)==219 and bytes(rebuilt)==raw
    assert all(r['cells'][f] is None for r in detail['rows'] for f in DISPLAY['BioDetail'])
    assert len(keywords['rows'])==25
    assert {r['id'] for r in keywords['rows']}=={r['cells'][f] for r in detail['rows'] for f in ('line1','line2','line3') if r['cells'][f]}
    assert {r['cells']['actor'] for r in detail['rows']}=={r['id'] for r in actors['rows'] if not r['cells']['exclude_from_critter_log']}
    # InspectMethods hashes pin complete original bodies. These assertions tie the
    # documented selection/order/cache findings to their specific IL boundaries.
    assert '::Sort()' in (HERE/'reverse-value.il').read_text()
    assert 'BGEntity::get_Index()' in (HERE/'entity-order.il').read_text() and 'System.Int32::CompareTo' in (HERE/'entity-order.il').read_text()
    assert 'ReverseRelationCacheValue<T,TStoreType>::.ctor()' in (HERE/'reverse-cache.il').read_text()
    assert 'GetRelatedIn(BansheeGz.BGDatabase.BGId' in (HERE/'db-actor-related.il').read_text()
    assert 'Actor::SetDirtyBioData()' in (HERE/'dirty-consumer.il').read_text()
    assert 'GameEvents::onActiveTagsChanged' in (HERE/'listeners.il').read_text()
    assert 'BioKeyword::dbName' in (HERE/'keyword-unlock.il').read_text() and '::ContainsKey(!0)' in (HERE/'keyword-unlock.il').read_text()
    assert (HERE/'cache-uses.il').read_text().count('stfld ')==2
    assert 'IL_0037: ldloc.1' in (HERE/'actor-selection.il').read_text() and 'IL_00c4: ldc.i4.0' in (HERE/'actor-selection.il').read_text()
    # Exact frozen candidate values in both source trees; no target lane access.
    manifest=json.loads((ROOT/'localization/source/dialogue-manifest.json').read_text())
    candidates=[json.loads(s) for s in (ROOT/'localization/source/dialogue-candidates.jsonl').read_text().splitlines()]
    assert len(candidates)==manifest['candidateUnits']==12246 and len({c['id'] for c in candidates})==12246
    copies=[]
    for copy in manifest['sources']:
        assert sha(ROOT/copy['tree'])==copy['treeSha256']
        tree=json.loads((ROOT/copy['tree']).read_text())
        for c in candidates:
            value=tree
            for part in c['pointer'].strip('/').split('/'):
                part=part.replace('~1','/').replace('~0','~')
                value=value[int(part)] if isinstance(value,list) else value[part]
            assert value==c['source']
        copies.append(dict(object=copy['object'],tree=copy['tree'],sha256=copy['treeSha256'],exactCandidateValues=len(candidates)))
    assert len(copies)==2
    dependencies=[]
    selections=[]
    for actor in actors['rows']:
        related=[r for r in detail['rows'] if r['cells']['actor']==actor['id']]
        related.sort(key=lambda r:r['index'])
        tag_ids=list(dict.fromkeys(t for r in related for t in r['cells']['enable_with_tags']))
        scenarios=[]
        for flags in itertools.product((False,True),repeat=len(tag_ids)):
            active={t for t,v in zip(tag_ids,flags) if v}
            chosen=next((r for r in related if active.intersection(r['cells']['enable_with_tags'])),None)
            reason='first-active-tag'
            if chosen is None:
                chosen=next((r for r in related if r['cells']['is_default']),None); reason='first-default'
            if chosen is None:
                chosen=related[0] if related else None; reason='list[0]' if chosen else 'empty-null'
            scenarios.append(dict(activeTagIds=[t for t in tag_ids if t in active],chosenRowId=chosen['id'] if chosen else None,reason=reason,
                                  boundary='Static consequence of original IL on frozen relation order; not runtime or reachability proof'))
        selections.append(dict(actorRowId=actor['id'],dbName=actor['cells']['name'],orderedDetailRowIds=[r['id'] for r in related],scenarios=scenarios))
        for row in related:
            own=[c for c in cells if c['sheet']=='BioDetail' and c['rowId']==row['id']]
            edges=[r for r in relations if r['sourceRowId']==row['id']]
            deps=dict(actorRowId=actor['id'],actorIdentityCells=[cell(actors,actor,f) for f in ('name','savekey','plugin_db_name')],
                      detailRowId=row['id'],detailIndex=row['index'],protectedCellIds=[c['id'] for c in own if c['role']=='preserve-exactly'],
                      overrideCellIds=[c['id'] for c in own if c['role']=='authored-display-candidate'],relations=edges,
                      slotRoles={'line1':'species','line2':'age','line3':'role'},
                      overrideSemantics='Both NameplateName and FullName read overrideNameplateName; original36 override cells absent; never repair source anomaly',
                      keywordDisplayCellIds=[cell(keywords,kr,'bio_text')['id'] for kr in keywords['rows'] if kr['id'] in [row['cells'][f] for f in ('line1','line2','line3')]],
                      displayRoute='Keyword bio_text -> runtime text -> slot getter -> keyword dbName unlock mask -> legacy subtitles {0}\\n{1}\\n{2}',
                      adaptation='Separate localized display mapping only; IDs/name/savekey/plugin trigger/tags/resource keys unchanged; no mapping authored',
                      sourceAcceptance='needs-review',runtime='not-run',editorial='not-run')
            dependencies.append(deps)
    # Existing codecs: controls before any source/target replacement; errors are
    # required to match the intended codec boundary, not any earlier exception.
    good=bytes(range(16))
    for kind,b in [('BGFieldRelationSingle',good),('BGFieldRelationMultiple',good*2),('BGFieldBool',b'\0'),('BGFieldBool',b'\1')]:
        assert encode_cell(kind,decode_cell(kind,b))==b
    rejected(lambda:decode_cell('BGFieldRelationSingle',good[:-1]),'invalid-single-relation-width')
    rejected(lambda:decode_cell('BGFieldRelationMultiple',good+b'\0'),'invalid-multiple-relation-width')
    rejected(lambda:decode_cell('BGFieldBool',b'\2'),'noncanonical-bool-byte')
    for name,rows in [('visible-fields.jsonl',visible),('preserve-exactly.jsonl',protected)]:
        (out/name).write_text(''.join(json.dumps(c,ensure_ascii=False)+'\n' for c in rows))
    dump(out/'relations.json',relations)
    dump(out/'dependency-bindings.json',dependencies)
    dump(out/'selection-scenarios.json',selections)
    dump(out/'multiplicity.json',multiplicity)
    dump(out/'source-copies.json',copies)
    stats=dict(status='passed-static-scoped',checkedInstalledSources={p:sources[p]['sha256'] for p in checked},textAssetRawSha256=rec['rawSha256'],
        sourceSha256=SOURCE_SHA,exportedBytes=len(raw),frozenPinsUnchanged=19,helpersChecked=len(baseline['owningHelpers']),priorEvidenceHashes={k:len(baseline[k]) for k,_ in prior},
        bioDetailRows=18,bioDetailColumns=10,referencedBioKeywordRows=25,bioKeywordColumns=4,bioKeywordTotalRows=len(keywords['rowIds']),
        exactCellStates=len(cells),displayCandidateStates=len(visible),nonemptyDisplayCandidates=sum(bool(c['source']) for c in visible),protectedStates=len(protected),
        storedSpansReencoded=sum(c['sourceSpan'] is not None for c in cells),absentStates=sum(c['sourceSpan'] is None for c in cells),relations=len(relations),
        actorDependencies=len(dependencies),actorsWithDetails=sum(bool(s['orderedDetailRowIds']) for s in selections),actorsWithoutDetails=sum(not s['orderedDetailRowIds'] for s in selections),
        detailActorSetEqualsCritterIncludedActorSet=True,
        originalOverrideStatesAbsent=36,generatedConstantIdsMatched=constants,exactIlSelections=len(commands),dialogueCopies=2,exactDialogueSourceOccurrences=24492,
        noOpWholeInputBytesEqual=True,malformedControlsRejected=True,relatedOrder='Ascending BGEntity.Index through reverse-cache Sort/CompareTo and generated typed copy; initial frozen data only',
        selection='First any-active tag; first default; list[0]; null. CurrentBioDetail caches nonnull until active-tag event dirty reset; actual tag reachability unverified',
        gameLaunches=0,imagesOpened=0,gameAssemblyExecuted=False,translationAuthored=False,gitMutations=0,reinsertion='not-run',runtime='not-run',visual='not-run',editorial='not-run',
        wholeGameSourceAcceptance=False,usage='Unknown in worker; parent measures telemetry')
    dump(out/'verification.json',stats)
    return stats


if __name__=='__main__':
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument('--output',required=True,type=Path)
    args=p.parse_args()
    assert not args.output.exists()
    args.output.mkdir(parents=True)
    print(json.dumps(build(args.output)))
