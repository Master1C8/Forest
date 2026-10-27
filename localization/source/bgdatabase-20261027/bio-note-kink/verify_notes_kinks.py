#!/usr/bin/env python3
"""Static exact source/dependency verification; never execute the game assembly."""
import argparse
import collections
import hashlib
import itertools
import json
from pathlib import Path
import re
import subprocess
import sys
import tempfile
HERE=Path(__file__).resolve().parent
ROOT=HERE.parents[3]
sys.path[:0]=[str(HERE),str(HERE.parent/'bio-keywords'),str(HERE.parent/'bio-detail')]
from decode_notes_kinks import SOURCE, SOURCE_SHA, decode
from verify_keywords import build as verify_prior
from verify_bio import cell, encode_cell, generated_id, DATA

def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def dump(p,v):p.write_text(json.dumps(v,ensure_ascii=False,indent=2)+'\n')
def methods(path):
    return {part.split('::',1)[1].split('(',1)[0]:part for part in path.read_text().split('METHOD ')[1:]}
def select(rows,active):
    return next((r for r in rows if any(t in active for t in (r['cells']['enable_with_tags'] or []))),
                next((r for r in rows if r['cells']['is_default']),rows[0] if rows else None))
def display(text,hidden,unlocked,last=0,time=1):
    # Consequence of exact original UpdateKeywordText branch order, not runtime.
    shown=unlocked and not hidden
    return dict(text=text if shown else '???',color='revealed' if shown else 'unrevealed',newLabelAlpha=int(shown and last<time))

def build(out):
    baseline=json.loads((HERE/'baseline.json').read_text())
    assert len(baseline['pins'])==19
    for p,h in baseline['pins'].items():assert sha(Path(p))==h,p
    for p,h in baseline['owningHelpers'].items():assert sha(ROOT/p)==h,p
    for key,directory in [('priorBioDetailEvidence','bio-detail'),('priorBioKeywordEvidence','bio-keywords')]:
        for p,h in baseline[key].items():assert sha(HERE.parent/directory/p)==h,(key,p)
    with tempfile.TemporaryDirectory(prefix='forest-note-kink-prior-') as tmp:
        prior=verify_prior(Path(tmp))
        prior_outputs={p.name:sha(p) for p in Path(tmp).iterdir() if p.is_file()}
        assert len(prior_outputs)==8
        for name,h in prior_outputs.items():assert sha(HERE.parent/'bio-keywords/readback'/name)==h,name
    raw=SOURCE.read_bytes();decoded=decode(raw)
    assert decoded==json.loads((HERE/'decoded.json').read_text())
    commands=json.loads((HERE/'phase0075-il-commands.json').read_text())
    assert len(commands)==len({c['output'] for c in commands})
    for c in commands:
        actual=subprocess.check_output(['dotnet',str(ROOT/'tools/probe/bin/Debug/net8.0/InspectMethods.dll'),str(DATA/'Managed'/c['assembly']),c['type'],c['selection']])
        assert actual==(HERE/c['output']).read_bytes() and hashlib.sha256(actual).hexdigest()==c['sha256'],c['output']
    keywords=json.loads((HERE.parent/'bio-keywords/decoded.json').read_text())['sheets'][0]
    # Fresh decode of all111 prior keyword rows, without adding/altering its supplement.
    from decode_keywords import decode as decode_keywords
    assert decode_keywords(raw)==json.loads((HERE.parent/'bio-keywords/decoded.json').read_text())
    actors=json.loads((HERE.parent/'actor-identity/decoded.json').read_text())['sheets'][0]
    tags=next(s for s in json.loads((HERE.parent/'quest-controls/decoded.json').read_text())['sheets'] if s['name']=='Tag')
    details=json.loads((HERE.parent/'bio-detail/decoded.json').read_text())['sheets'][0]
    sheets={s['id']:s for s in [keywords,actors,tags,*decoded['sheets']]}
    rowmaps={k:{r['id']:r for r in s['rows']} for k,s in sheets.items()}
    assert all(len(rowmaps[k])==len(s['rows']) for k,s in sheets.items())
    keyword_map=rowmaps[keywords['id']];actor_map=rowmaps[actors['id']]
    display_cells={r['id']:cell(keywords,r,'bio_text') for r in keywords['rows']}
    prior_visible=[json.loads(x) for x in (HERE.parent/'bio-keywords/readback/visible-fields.jsonl').read_text().splitlines()]
    assert len(prior_visible)==111
    for c in prior_visible:
        assert all(c[k]==display_cells[c['rowId']][k] for k in display_cells[c['rowId']])
    protected=[];relations=[];slots=[];multiplicity={};constants=0;stored=0;rebuilt=bytearray(raw)
    for sheet in decoded['sheets']:
        prefix,count=('note',6) if sheet['name']=='BioNote' else ('kink',9)
        generated=(HERE/f'db-{prefix}-getters.il').read_text()
        assert generated_id(generated,'get_MetaDefault')==sheet['id'];constants+=1
        for f in sheet['fields']:
            assert generated_id(generated,'get__'+f['name'])==f['id'];constants+=1
            kind=f['type'].split(',')[0].rsplit('.',1)[-1]
            groups=collections.defaultdict(list)
            for row in sheet['rows']:
                c=cell(sheet,row,f['name']);v,span=c['source'],c['sourceSpan'];encoded=encode_cell(kind,v)
                if span is None:assert v is None
                else:
                    start,size=span['offset'],span['bytes'];assert encoded==raw[start:start+size] and len(encoded)==size
                    rebuilt[start:start+size]=encoded;stored+=1
                reason=('Exact Actor/BioKeyword/Tag relation; display text remains in referenced BioKeyword.bio_text' if kind.startswith('BGFieldRelation') else 'Runtime row identity' if f['name']=='name' else 'Visibility/selection control; never translated')
                c.update(role='preserve-exactly',reason=reason,sourceBytesHex=encoded.hex() if span else None);protected.append(c)
                groups[json.dumps(v,ensure_ascii=False,sort_keys=True)].append(row['id'])
                if kind.startswith('BGFieldRelation'):
                    target=sheets[f['targetSheetId']]
                    values=v if isinstance(v,list) else ([] if v is None else [v])
                    for index,ident in enumerate(values):
                        tr=rowmaps[target['id']][ident]
                        relations.append(dict(sourceCellId=c['id'],sourceField=f['name'],sourceRowId=row['id'],relationIndex=index,
                            targetSheet=target['name'],targetRowId=ident,targetRowIndex=tr['index'],targetCells=[cell(target,tr,tf['name']) for tf in target['fields']]))
            multiplicity[sheet['name']+'.'+f['name']]=dict(states=17,absent=sum(r['spans'][f['name']] is None for r in sheet['rows']),
                distinctIncludingNull=len(groups),duplicates=[dict(source=json.loads(k),rowIds=v) for k,v in groups.items() if len(v)>1])
        for row in sheet['rows']:
            actor=actor_map[row['cells']['actor']]
            for i in range(1,count+1):
                key=row['cells'][f'{prefix}{i}'];hidden=row['cells'][f'hide_in_list{i}']
                assert key is not None or not hidden,'null slot hidden flag would require separate runtime-default evidence'
                slots.append(dict(sheet=sheet['name'],rowId=row['id'],rowIndex=row['index'],slot=i,
                    relationCell=cell(sheet,row,f'{prefix}{i}'),hideCell=cell(sheet,row,f'hide_in_list{i}'),
                    actorRelationCell=cell(sheet,row,'actor'),actorIdentityCells=[cell(actors,actor,f) for f in ('name','savekey','plugin_db_name')],
                    tagRelationCell=cell(sheet,row,'enable_with_tags'),tagCells=[[cell(tags,rowmaps[tags['id']][t],f['name']) for f in tags['fields']] for t in (row['cells']['enable_with_tags'] or [])],
                    defaultCell=cell(sheet,row,'is_default'),keywordRowId=key,
                    keywordIdentityCells=[cell(keywords,keyword_map[key],f) for f in ('name','savekey','plugin_db_trigger_name')] if key else [],
                    displayCandidate=display_cells[key] if key else None,
                    fragmentIndex=(i-1 if prefix=='note' else 6+i-1),inUnlockList=key is not None,
                    renderedWhenUnlocked=(key is not None and not hidden),runtimeHidden=hidden if key else False,
                    staticLocked=display(display_cells[key]['source'] if key else None,hidden,False),
                    staticUnlocked=display(display_cells[key]['source'] if key else None,hidden,key is not None),
                    runtime='not-run',reachability='needs-review'))
    assert len(protected)==646 and len({c['id'] for c in protected})==646 and bytes(rebuilt)==raw
    assert len(slots)==255 and constants==40
    # All original per-slot generated consumers share these exact mechanics.
    loader=(HERE.parent/'actor-identity/bio-loader-callback.il').read_text()
    critter=methods(HERE/'critter-output.il');selected=critter['UpdateSelectedBio'];update=critter['UpdateKeywordText']
    for prefix,count,typ in [('note',6,'BioNotes'),('kink',9,'BioKinks')]:
        bodies=methods(HERE/f'{prefix}-values-unlock.il')
        for i in range(1,count+1):
            assert f'{typ}::{prefix}{i}Keyword' in bodies[f'get_{prefix}{i}Text'] and 'BioKeyword::text' in bodies[f'get_{prefix}{i}Text']
            assert 'ldnull' in bodies[f'get_{prefix}{i}Text']
            assert '::ContainsKey(!0)' in bodies[f'get_is{prefix.capitalize()}{i}Unlocked'] and 'BioKeyword::dbName' in bodies[f'get_is{prefix.capitalize()}{i}Unlocked']
            assert 'BioKeywordData::timeUnlocked' in bodies[f'get_{prefix}{i}TimeUnlocked'] and 'ldc.r4 0' in bodies[f'get_{prefix}{i}TimeUnlocked']
            assert f'{typ}::get_{prefix}{i}Text()' in selected and f'{typ}::{prefix}{i}Hidden' in selected
            assert f'{typ}::get_is{prefix.capitalize()}{i}Unlocked()' in selected and f'{typ}::get_{prefix}{i}TimeUnlocked()' in selected
            # Membership Add happens even for hidden slots; null relation skips block.
            table='BioNote' if prefix=='note' else 'BioKink'
            assert f'{table}::get_{prefix}{i}()' in loader and f'{table}::get_hide_in_list{i}()' in loader
            assert f'{typ}::{prefix}{i}Keyword' in loader and f'{typ}::{prefix}{i}Hidden' in loader
            # The null branch skips the complete assignment/hidden/list-add block.
            first=loader.index(f'callvirt TheForestOfLove.DB.BioKeyword TheForestOfLove.DB.{table}::get_{prefix}{i}()')
            block=loader[first:]
            target=re.search(r'brfalse(?:\.s)? (IL_[0-9a-f]+)',block).group(1)
            block=block[:block.index(target+':')]
            assert all(x in block for x in (f'{typ}::{prefix}{i}Keyword',f'{typ}::{prefix}{i}Hidden',f'{typ}::{prefix}s','::Add(!0)'))
        unlock=bodies['TryUnlockKeyword']
        assert all(x in unlock for x in ['bne.un.s','::ContainsKey(!0)','BioKeyword::dbName','Globals::get_StoryClock()','::Add(!0,!1)'])
        assert 'Hidden' not in unlock and 'BioKeyword::text' not in unlock
        assert 'keywordData' in bodies['.ctor'] and 'ldarg.1' in bodies['.ctor']
    # Verify the real rendered target indices and getter order, not only token presence.
    index_pattern=r'ldfld [^\n]+::%s\nIL_[0-9a-f]+: ldc\.i4(?:\.s ([0-9]+)|\.([0-8]))\n'
    for array in ('fragments','newLabels'):
        indices=[int(a or b) for a,b in re.findall(index_pattern % array,selected)]
        assert indices==list(range(15)),(array,indices)
    called_slots=re.findall(r'callvirt System.String TheForestOfLove.Narrative.Bio(?:Notes|Kinks)::get_((?:note|kink)[0-9]+)Text',selected)
    assert called_slots==[f'note{i}' for i in range(1,7)]+[f'kink{i}' for i in range(1,10)]
    assert selected.count('call System.Void TheForestOfLove.CritterLogBioPane::UpdateKeywordText(')==15
    assert all(x in update for x in ['ldarg.s isBioKeywordUnlocked','ldarg.s isBioKeywordHidden','ldstr "???"','blt.s IL_0029','colorRevealedValue','colorUnrevealedValue'])
    assert 'System.String::Concat' not in selected and '::Sort' not in selected
    reverse=(HERE/'db-actor-reverse.il').read_text()
    assert reverse.count('GetRelatedIn(BansheeGz.BGDatabase.BGId,')==2 and reverse.count('ldc.i4.0')==2
    # The prior pinned single-relation/cache/Index chain remains applicable to both exact getter paths.
    assert '::Sort()' in (HERE.parent/'bio-detail/reverse-value.il').read_text()
    assert 'BGEntity::get_Index()' in (HERE.parent/'bio-detail/entity-order.il').read_text()
    scenarios=[];assembled=[]
    for sheet in decoded['sheets']:
        prefix,count=('note',6) if sheet['name']=='BioNote' else ('kink',9)
        related={a['id']:[r for r in sheet['rows'] if r['cells']['actor']==a['id']] for a in actors['rows']}
        assert {k for k,v in related.items() if v}=={a['id'] for a in actors['rows'] if not a['cells']['exclude_from_critter_log']}
        assert all(len(v)<=1 for v in related.values())
        for actor,rows in related.items():
            tagids=sorted({t for r in rows for t in (r['cells']['enable_with_tags'] or [])})
            for active_flags in itertools.product((False,True),repeat=len(tagids)):
                active={t for t,b in zip(tagids,active_flags) if b};chosen=select(rows,active)
                scenarios.append(dict(sheet=sheet['name'],actorRowId=actor,relatedRowIds=[r['id'] for r in rows],activeTagIds=sorted(active),chosenRowId=chosen['id'] if chosen else None,boundary='static tag truth table; actual tag reachability and cache lifecycle unverified'))
            for row in rows:
                row_slots=[s for s in slots if s['sheet']==sheet['name'] and s['rowId']==row['id']]
                assert [s['slot'] for s in row_slots]==list(range(1,count+1))
                assembled.append(dict(sheet=sheet['name'],rowId=row['id'],actorRowId=actor,
                    allLocked=[dict(fragmentIndex=s['fragmentIndex'],**s['staticLocked']) for s in row_slots],
                    allPresentUnlocked=[dict(fragmentIndex=s['fragmentIndex'],**s['staticUnlocked']) for s in row_slots],
                    boundary='Fixed independent legacy Text targets in slot order; no compaction, sorting or joined sentence; not rendered proof'))
    controls=json.loads((HERE.parent/'bio-keywords/readback/bio-controls.json').read_text())
    topology=[]
    for control in controls:
        actor=control['actorIdentityCells'][0]['rowId'] if control['actorIdentityCells'] else None;key=control['keywordRowId']
        matches=[s for s in slots if key is not None and s['keywordRowId']==key and s['actorRelationCell']['source']==actor]
        detail_matches=[dict(rowId=r['id'],slot=f,relationCell=cell(details,r,f)) for r in details['rows'] for f in ('line1','line2','line3') if key is not None and r['cells'][f]==key and r['cells']['actor']==actor]
        topology.append(dict(controlId=control['id'],actorRowId=actor,keywordRowId=key,
            noteKinkMatches=[dict(sheet=s['sheet'],rowId=s['rowId'],slot=s['slot'],hidden=s['runtimeHidden'],displayCellId=s['displayCandidate']['id']) for s in matches],bioDetailMatches=detail_matches,
            status='implicit-actor/missing-key-unresolved' if actor is None or key is None else 'exact-category-membership-found' if matches or detail_matches else 'no-current-category-membership',
            reachability='not-accepted; loaded Dialogue/arc selection and actual execution unverified'))
    dependencies=[]
    prior_dependencies=json.loads((HERE.parent/'bio-keywords/readback/dependency-bindings.json').read_text())
    for row in keywords['rows']:
        key=row['id'];refs=[s for s in slots if s['keywordRowId']==key]
        old=next(d for d in prior_dependencies if d['keywordRowId']==key)
        dependencies.append(dict(keywordRowId=key,displayCandidate=display_cells[key],
            noteKinkReferences=[dict(sheet=s['sheet'],rowId=s['rowId'],slot=s['slot'],relationCellId=s['relationCell']['id'],hideCellId=s['hideCell']['id'],hidden=s['runtimeHidden'],actorRowId=s['actorRelationCell']['source'],fragmentIndex=s['fragmentIndex']) for s in refs],
            bioDetailReferences=old['bioDetailReferences'],bioControlIds=old['bioControlIds'],
            currentFamilyUse='detail-or-note-or-kink' if refs or old['bioDetailReferences'] else 'no-slot-in-these-three-current-tables; other consumers unverified'))
    helper_cases=[dict(unlocked=u,hidden=h,lastViewed=last,timeUnlocked=time,expected=display('SOURCE',h,u,last,time),boundary='static original branch consequence; no game execution')
                  for u,h in itertools.product((False,True),repeat=2) for last,time in [(0,1),(1,1),(2,1)]]
    for name,rows in [('preserve-exactly.jsonl',protected)]:
        (out/name).write_text(''.join(json.dumps(c,ensure_ascii=False)+'\n' for c in rows))
    for name,value in [('relations.json',relations),('slot-bindings.json',slots),('dependency-bindings.json',dependencies),('multiplicity.json',multiplicity),('selection-scenarios.json',scenarios),('assembled-output.json',assembled),('bio-control-membership.json',topology),('display-helper-scenarios.json',helper_cases),('prior-keyword-reconciliation.json',dict(rows=111,cells=444,exactValuesIdsSpans=True,displayCandidateIdsUnchanged=True))]:dump(out/name,value)
    stats=dict(status='passed-static-scoped',tables={'BioNote':{'rows':17,'columns':16},'BioKink':{'rows':17,'columns':22}},
        protectedCellStates=len(protected),storedSpansReencoded=stored,absentStates=len(protected)-stored,newDisplayCandidates=0,
        exactSlotStates=len(slots),presentKeywordReferences=sum(s['keywordRowId'] is not None for s in slots),absentKeywordSlots=sum(s['keywordRowId'] is None for s in slots),
        hiddenPresentKeywordSlots=sum(s['runtimeHidden'] for s in slots),nonhiddenPresentKeywordSlots=sum(s['renderedWhenUnlocked'] for s in slots),
        referencedDistinctKeywordRows=len({s['keywordRowId'] for s in slots if s['keywordRowId']}),
        keywordsWithNoDetailNoteKinkSlot=sum(not d['bioDetailReferences'] and not d['noteKinkReferences'] for d in dependencies),
        exactRelationEdges=len(relations),generatedConstantIdsMatched=constants,selectionScenarios=len(scenarios),staticAssembledRows=len(assembled),displayHelperScenarios=len(helper_cases),
        bioControlsByMembership=dict(collections.Counter(c['status'] for c in topology)),
        exactIlSelections=len(commands),priorKeywordReadbacksMatched=8,priorBioKeywordEvidenceHashes=len(baseline['priorBioKeywordEvidence']),priorBioDetailEvidenceHashes=len(baseline['priorBioDetailEvidence']),
        frozenPinsUnchanged=prior['frozenPinsUnchanged'],helpersChecked=prior['helpersChecked'],priorEvidenceHashes=prior['priorEvidenceHashes'],checkedInstalledSources=prior['checkedInstalledSources'],
        priorKeywordRowsReconciled=111,priorKeywordCellsReconciled=444,exportedBytes=len(raw),sourceSha256=SOURCE_SHA,noOpWholeInputBytesEqual=True,
        dialogueCopies=2,exactDialogueSourceOccurrences=24492,wholeGameSourceAcceptance=False,sourceAcceptance='needs-review; bounded static supplement',
        reinsertion='not-run',runtime='not-run',visual='not-run',editorial='not-run',gameLaunches=0,imagesOpened=0,gameAssemblyExecuted=False,translationAuthored=False,gitMutations=0,usage='Unknown in worker; parent measures telemetry')
    dump(out/'verification.json',stats)
    return stats
if __name__=='__main__':
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('--output',required=True,type=Path);a=p.parse_args();assert not a.output.exists();a.output.mkdir(parents=True)
    print(json.dumps(build(a.output)))
