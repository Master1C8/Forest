#!/usr/bin/env python3
"""Verify original BioKeyword cells, exact controls and bounded IL; static only."""
import argparse
import collections
import hashlib
import json
from pathlib import Path
import subprocess
import sys
import tempfile
HERE=Path(__file__).resolve().parent
ROOT=HERE.parents[3]
sys.path[:0]=[str(HERE),str(HERE.parent/'bio-detail')]
from decode_keywords import SOURCE, SOURCE_SHA, decode
from verify_bio import build as verify_prior, cell, encode_cell, generated_id, DATA

def sha(p): return hashlib.sha256(p.read_bytes()).hexdigest()
def dump(p,v): p.write_text(json.dumps(v,ensure_ascii=False,indent=2)+'\n')
def fields(record):
    names=[f['title'] for f in record['fields']]
    assert len(names)==len(set(names)), 'duplicate-field-name'
    return {f['title']:f['value'] for f in record['fields']}

def build(out):
    baseline=json.loads((HERE/'baseline.json').read_text())
    for p,h in baseline['priorBioDetailEvidence'].items():
        assert sha(HERE.parent/'bio-detail'/p)==h, p
    # Reuse original verifier unchanged. Its temporary outputs are compared with
    # all eight accepted prior outputs, never written over the prior supplement.
    with tempfile.TemporaryDirectory(prefix='forest-bio-keywords-prior-') as temp:
        tmp=Path(temp); previous=verify_prior(tmp)
        prior_outputs={p.name:sha(p) for p in tmp.iterdir() if p.is_file()}
        assert len(prior_outputs)==8
        for name,h in prior_outputs.items(): assert sha(HERE.parent/'bio-detail/readback'/name)==h, name
    raw=SOURCE.read_bytes();decoded=decode(raw)
    assert decoded==json.loads((HERE/'decoded.json').read_text())
    sheet=decoded['sheets'][0]
    cmds=json.loads((HERE/'il-commands.json').read_text())
    assert len(cmds)==len({c['output'] for c in cmds})
    for c in cmds:
        actual=subprocess.check_output(['dotnet',str(ROOT/'tools/probe/bin/Debug/net8.0/InspectMethods.dll'),str(DATA/'Managed'/c['assembly']),c['type'],c['selection']])
        assert actual==(HERE/c['output']).read_bytes() and hashlib.sha256(actual).hexdigest()==c['sha256']
    generated=(HERE.parent/'bio-detail/db-keyword.il').read_text()
    assert generated_id(generated,'get_MetaDefault')==sheet['id']
    display,protected,multiplicity=[],[],{}
    rebuilt=bytearray(raw)
    reasons={'name':'Runtime dbName; actor-owned unlock dictionary key. Separate from visible text even when equal.',
             'bio_text':'Runtime text/display candidate; exact Notes/Kinks slot relations and masks remain pending.',
             'savekey':'SavegameBioKeywordData.keywordSavekey and saved category dictionary key; lookup restores dbName.',
             'plugin_db_trigger_name':'Exact BIO loader/NarrativeActions plugin lookup key; not display text.'}
    for f in sheet['fields']:
        assert generated_id(generated,'get__'+f['name'])==f['id']
        kind=f['type'].split(',')[0].rsplit('.',1)[-1]
        groups=collections.defaultdict(list)
        for row in sheet['rows']:
            c=cell(sheet,row,f['name']);span=c['sourceSpan'];assert span is not None
            encoded=encode_cell(kind,c['source']);start,size=span['offset'],span['bytes']
            assert raw[start:start+size]==encoded and len(encoded)==size
            rebuilt[start:start+size]=encoded
            c.update(sourceBytesHex=encoded.hex(),role='authored-display-candidate' if f['name']=='bio_text' else 'preserve-exactly',reason=reasons[f['name']])
            (display if f['name']=='bio_text' else protected).append(c)
            groups[json.dumps(c['source'],ensure_ascii=False)].append(row['id'])
        multiplicity[f['name']]=dict(states=111,absent=0,nonempty=sum(bool(r['cells'][f['name']]) for r in sheet['rows']),distinct=len(groups),duplicates=[dict(source=json.loads(k),rowIds=v) for k,v in groups.items() if len(v)>1])
        assert len(groups)==111
    assert bytes(rebuilt)==raw and len(display)==111 and len(protected)==333
    assert len({c['id'] for c in display+protected})==444
    old=json.loads((HERE.parent/'bio-detail/decoded.json').read_text())['sheets'][1]
    reconciled=[]
    for prior in old['rows']:
        row=next(r for r in sheet['rows'] if r['id']==prior['id']);assert row==prior
        for f in sheet['fields']:assert cell(sheet,row,f['name'])==cell(old,prior,f['name'])
        reconciled.append(dict(rowId=row['id'],rowIndex=row['index'],cellIds=[cell(sheet,row,f['name'])['id'] for f in sheet['fields']]))
    assert len(reconciled)==25
    actors=json.loads((HERE.parent/'actor-identity/decoded.json').read_text())['sheets'][0]
    actor_by_plugin={r['cells']['plugin_db_name']:r for r in actors['rows']};assert len(actor_by_plugin)==39
    keyword_by_plugin={r['cells']['plugin_db_trigger_name']:r for r in sheet['rows']};assert len(keyword_by_plugin)==111
    details=json.loads((HERE.parent/'bio-detail/decoded.json').read_text())['sheets'][0]
    manifest=json.loads((ROOT/'localization/source/dialogue-manifest.json').read_text())
    candidates=[json.loads(x) for x in (ROOT/'localization/source/dialogue-candidates.jsonl').read_text().splitlines()]
    candidate_by_pointer={c['pointer']:c['id'] for c in candidates}
    copies=[];controls_by_copy=[]
    for copy in manifest['sources']:
        assert sha(ROOT/copy['tree'])==copy['treeSha256']
        tree=json.loads((ROOT/copy['tree']).read_text());controls=[]
        assert len({c['id'] for c in tree['conversations']})==627
        for ci,conv in enumerate(tree['conversations']):
            entries={e['id']:e for e in conv['dialogueEntries']};assert len(entries)==len(conv['dialogueEntries'])
            for ei,entry in enumerate(conv['dialogueEntries']):
                ef=fields(entry);title=ef.get('Title','');prefix=title[:title.index('(')] if '(' in title else title
                if prefix.upper()!='BIO':continue
                assert '(' in title and title.endswith(')'), 'unexpected-bio-title-grammar'
                args=title[title.index('(')+1:-1].split(',')
                assert len(args) in (1,2), 'unbounded-original-bio-arguments'
                actor_plugin=args[0].strip() if len(args)==2 else None
                key=(args[1] if len(args)==2 else args[0]).strip().replace('note_','').replace('kink_','')
                actor=actor_by_plugin.get(actor_plugin);keyword=keyword_by_plugin.get(key)
                if actor_plugin is not None: assert actor is not None
                links=entry['outgoingLinks'];assert links, 'bio-has-no-first-link'
                first=links[0];target=entries[first['destinationDialogueID']]
                fi=next(i for i,f in enumerate(entry['fields']) if f['title']=='Title')
                pointer=f'/conversations/{ci}/dialogueEntries/{ei}/fields/{fi}/value'
                assert pointer not in candidate_by_pointer, 'bio-control-in-translated-candidates'
                ti=next(i for i,e in enumerate(conv['dialogueEntries']) if e['id']==target['id'])
                relevant=[dict(id=c['id'],pointer=c['pointer'],source=c['source']) for c in candidates
                          if c['pointer'].startswith(f'/conversations/{ci}/dialogueEntries/{ti}/')]
                controls.append(dict(id=f'dialogue-control:conversation:{conv["id"]}:entry:{entry["id"]}:Title',
                    conversationId=conv['id'],entryId=entry['id'],pointer=pointer,source=title,role='preserve-exactly',
                    conversationTitle=fields(conv).get('Title'),conversationFields=conv['fields'],sourceEntryFields=entry['fields'],
                    sourceConditions=entry.get('conditionsString'),sourceUserScript=entry.get('userScript'),outgoingLinks=links,
                    firstLinkDestinationId=target['id'],firstLinkDestinationFields=target['fields'],destinationCandidateContext=relevant,
                    destinationConditions=target.get('conditionsString'),destinationUserScript=target.get('userScript'),
                    argumentCount=len(args),actorPluginDbName=actor_plugin,
                    actorResolution='exact-current-Actor-plugin-key' if actor else 'implicit dialogue.primaryActor; current Dialogue construction not traced',
                    actorIdentityCells=[cell(actors,actor,f) for f in ('name','savekey','plugin_db_name')] if actor else [],
                    normalizedKeywordTrigger=key,keywordRowId=keyword['id'] if keyword else None,
                    keywordIdentityCells=[cell(sheet,keyword,f) for f in ('name','savekey','plugin_db_trigger_name')] if keyword else [],
                    keywordDisplayCellId=cell(sheet,keyword,'bio_text')['id'] if keyword else None,
                    currentKeywordResolution='resolved' if keyword else 'missing-current-key; preserve original legacy control; no repair',
                    registrationBoundary='Candidate only: loader requires a loaded Dialogue and arc containing first local destination; actual arc membership/order/execution/reachability unverified',
                    executionGuard='NarrativeActions returns when Instanced Event Vslice tag active; otherwise resolves actor dbName and plugin keyword key',
                    revealBoundary='Actor attempts CurrentBioDetail/Notes/Kinks; emits unlock event only if any TryUnlockKeyword succeeds; exact Notes/Kinks topology pending'))
        controls_by_copy.append(controls)
        copies.append(dict(object=copy['object'],tree=copy['tree'],sha256=copy['treeSha256'],exactCandidateValues=12246,exactBioControlTitles=len(controls)))
    assert controls_by_copy[0]==controls_by_copy[1]
    controls=controls_by_copy[0];assert len(controls)==128
    assert sum(c['keywordRowId'] is not None for c in controls)==113
    assert sum(c['argumentCount']==1 and c['keywordRowId'] is None for c in controls)==15
    dependencies=[]
    for row in sheet['rows']:
        refs=[]
        for detail in details['rows']:
            for f in ('line1','line2','line3'):
                if detail['cells'][f]==row['id']:
                    refs.append(dict(detailRelationCell=cell(details,detail,f),actorRowId=detail['cells']['actor'],slot={'line1':'species','line2':'age','line3':'role'}[f],
                        activeTags=detail['cells']['enable_with_tags'],isDefault=detail['cells']['is_default']))
        dependencies.append(dict(keywordRowId=row['id'],rowIndex=row['index'],displayCell=cell(sheet,row,'bio_text'),
            protectedCells=[cell(sheet,row,f) for f in ('name','savekey','plugin_db_trigger_name')],
            bioDetailReferences=refs,bioControlIds=[c['id'] for c in controls if c['keywordRowId']==row['id']],
            notesKinksReferences='not-decoded; next bounded family, never inferred from wording or note_/kink_ prefix',
            persistence='Actor-owned dictionaries keyed by dbName; save category records keyed by savekey with keywordSavekey/timeUnlocked; load maps savekey to current keyword and adds absent dbName',
            sourceAcceptance='needs-review',reinsertion='not-run',runtime='not-run',editorial='not-run'))
    # Original method bodies are pinned above; no game code is executed here.
    for filename,needles in {
        'actor-unlock-load.il':['Actor::get_CurrentBioDetail','Actor::get_CurrentBioNotes','Actor::get_CurrentBioKinks','NarrativeEvents::onUnlockActorBioKeyword','SavegameBioKeywordData::keywordSavekey','BioKeyword::dbName'],
        'keyword-lookups.il':['DataService::CreateBioKeywordData','BioKeyword::savekey','SavegameBioKeywordData::timeUnlocked','DataManifest::bioKeywordsByPluginDbTriggerName'],
        'trigger-loader.il':['ldstr "note_"','ldstr "kink_"','System.String::Replace','ldstr "unrecognized bio fragment key!"','ArcTriggerUnlockBioFragment::.ctor'],
        'narrative-unlock.il':['QuestTriggerHelper::InVsliceStoryInstance','DataService::GetActorByDbName','DataService::GetBioKeywordByPluginDbTriggerName'],
        'vslice-control.il':['ldstr "Instanced Event Vslice"','DataService::IsTagActive'],
        'arc-dispatch.il':['ldstr "BIO"','AddConversationTriggerUnlockBioFragment'],
    }.items():
        content=(HERE/filename).read_text()
        assert all(n in content for n in needles), filename
    for name,rows in [('visible-fields.jsonl',display),('preserve-exactly.jsonl',protected)]:
        (out/name).write_text(''.join(json.dumps(c,ensure_ascii=False)+'\n' for c in rows))
    dump(out/'dependency-bindings.json',dependencies);dump(out/'bio-controls.json',controls)
    dump(out/'multiplicity.json',multiplicity);dump(out/'prior-row-reconciliation.json',reconciled);dump(out/'source-copies.json',copies)
    stats=dict(status='passed-static-scoped',bioKeywordRows=111,columns=4,exactCellStates=444,displayCandidateStates=111,
        nonemptyDisplayCandidates=111,protectedStates=333,storedSpansReencoded=444,absentStates=0,generatedConstantIdsMatched=5,
        priorRowsReconciled=25,newlyDecodedRows=86,bioControlTitles=128,bioControlOccurrences=256,resolvedCurrentKeywordControls=113,
        legacyMissingKeywordControls=15,implicitPrimaryActorControls=15,controlsAreTranslationUnits=False,
        bioDetailKeywordReferences=sum(len(d['bioDetailReferences']) for d in dependencies),keywordRowsWithBioDetailReferences=sum(bool(d['bioDetailReferences']) for d in dependencies),
        exactIlSelections=len(cmds),reusedPriorIlSelections=previous['exactIlSelections'],frozenPinsUnchanged=previous['frozenPinsUnchanged'],
        helpersChecked=previous['helpersChecked'],priorEvidenceHashes=previous['priorEvidenceHashes'],priorBioDetailEvidenceHashes=len(baseline['priorBioDetailEvidence']),
        priorReadbackOutputsMatched=len(prior_outputs),checkedInstalledSources=previous['checkedInstalledSources'],sourceSha256=SOURCE_SHA,exportedBytes=len(raw),
        dialogueCopies=2,exactDialogueSourceOccurrences=24492,noOpWholeInputBytesEqual=True,
        bioNoteBioKinkDataDecoded=False,sourceAcceptance='needs-review; bounded static supplement',wholeGameSourceAcceptance=False,
        reinsertion='not-run',runtime='not-run',visual='not-run',editorial='not-run',gameLaunches=0,imagesOpened=0,gameAssemblyExecuted=False,
        translationAuthored=False,gitMutations=0,usage='Unknown in worker; parent measures telemetry')
    dump(out/'verification.json',stats)
    return stats

if __name__=='__main__':
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('--output',required=True,type=Path);a=p.parse_args()
    assert not a.output.exists();a.output.mkdir(parents=True)
    print(json.dumps(build(a.output)))
