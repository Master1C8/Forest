#!/usr/bin/env python3
"""Reproduce scoped static BIO registry/arc eligibility from original bytes and IL.

Never loads game code, launches a game, translates text, or changes source inputs.
Registry selection, graph inclusion, trigger registration and execution are distinct.
"""
import argparse
import collections
import gc
import hashlib
import json
from pathlib import Path
import re
import subprocess
import sys

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[3]
sys.path[:0] = [str(HERE), str(HERE.parent/'bio-detail')]
from decode_registration import SOURCE, SOURCE_SHA, decode
from verify_bio import cell, encode_cell, generated_id, DATA


def sha(p):
    return hashlib.sha256(p.read_bytes()).hexdigest()


def dump(p, value):
    p.write_text(json.dumps(value, ensure_ascii=False, indent=2)+'\n')


def fields(record):
    result = {f['title']: f['value'] for f in record['fields']}
    assert len(result) == len(record['fields']), 'duplicate-field-title'
    return result


def unique(rows, key):
    result = {key(r): r for r in rows}
    assert len(result) == len(rows), 'duplicate-mapping-key'
    return result


def populate(conv, registry, player_id):
    """Original ordered roots, NAMED indirection and local-only visited DFS.

    Conditions, scripts, connector flags and link priorities are deliberately not
    evaluated by the original population routine. This is graph membership only.
    """
    entries = unique(conv['dialogueEntries'], lambda e: e['id'])
    assert all(e['conversationID'] == conv['id'] for e in entries.values())
    arcs = []
    for kind, prefix in [('PRIMARY','p'), ('SECONDARY','s'), ('IDLE','i'), ('NAMED','n')]:
        roots = [e for e in entries.values() if fields(e).get('Title') == kind]
        # Original Find selects the first; retain evidence if any duplicates exist.
        if not roots:
            continue
        root = roots[0]
        assert root['outgoingLinks'], 'orphaned-dialogue-arc-root'
        for link_index, link in enumerate(root['outgoingLinks']):
            holder = entries[link['destinationDialogueID']]
            first = holder
            if kind == 'NAMED':
                assert holder['outgoingLinks'], 'named-holder-missing-first-link'
                first = entries[holder['outgoingLinks'][0]['destinationDialogueID']]
            ff = fields(first)
            suffix = ff.get('TfolUniqueDataKeySuffix')
            assert suffix and suffix.strip(), 'arc-missing-manual-suffix'
            assert re.search('^['+prefix+'][0-9]*', suffix), 'arc-suffix-convention'
            generated = registry['cells']['name']+'_'+suffix
            assert generated not in [a['generatedName'] for a in arcs if a['kind'] == kind]
            assert suffix not in [a['suffix'] for a in arcs], 'duplicate-arcsByDbArcSuffix-key'
            question = None
            if kind == 'PRIMARY' and registry['cells']['has_player_initiated_question']:
                if int(ff.get('Actor', '0')) == player_id:
                    question = first['id']
                else:
                    assert 'none' in ff.get('Sequence','').lower(), 'missing-primary-player-question'
                    assert first['outgoingLinks'], 'question-proxy-missing-first-link'
                    next_entry = entries[first['outgoingLinks'][0]['destinationDialogueID']]
                    assert int(fields(next_entry).get('Actor','0')) == player_id, 'proxy-not-player-question'
                    question = next_entry['id']
            ordered = []
            seen = set()
            ignored = []
            def walk(e):
                if e['id'] in seen:
                    return
                seen.add(e['id'])
                ordered.append(e['id'])
                for li, edge in enumerate(e['outgoingLinks']):
                    if edge['destinationConversationID'] == e['conversationID']:
                        walk(entries[edge['destinationDialogueID']])
                    else:
                        ignored.append(dict(entryId=e['id'], linkIndex=li, link=edge))
            walk(first)
            arcs.append(dict(conversationId=conv['id'], registryRowId=registry['id'],
                kind=kind, rootEntryId=root['id'], matchingRootIds=[e['id'] for e in roots],
                rootLinkIndex=link_index, rootLink=link,
                namedHolderId=holder['id'] if kind == 'NAMED' else None,
                customName=fields(holder).get('Title') if kind == 'NAMED' else None,
                firstEntryId=first['id'], firstEntryFields=first['fields'], suffix=suffix,
                generatedName=generated, generatedSavekey=registry['cells']['savekey']+'_'+suffix,
                playerQuestionEntryId=question, orderedEntryIds=ordered,
                ignoredCrossConversationLinks=ignored,
                boundary='static original population; no condition/script evaluation or story reachability'))
    return arcs


def parent_chain(conv, arc, target):
    """Original first predecessor in DFS order, not shortest-path distance.

    An observer bound detects recursive cycles instead of claiming a result the
    original unbounded recursion cannot establish. Original code has no such guard.
    """
    entries = unique(conv['dialogueEntries'], lambda e: e['id'])
    chain = [target]
    while target != arc['firstEntryId']:
        parent = next((i for i in arc['orderedEntryIds'] for edge in entries[i]['outgoingLinks']
            if edge['destinationConversationID'] == conv['id'] and edge['destinationDialogueID'] == target), None)
        if parent is None:
            return dict(status='original-would-throw-missing-parent', chain=chain)
        chain.append(parent)
        if parent in chain[:-1]:
            return dict(status='original-unbounded-parent-cycle', chain=chain)
        target = parent
    return dict(status='resolved', chain=chain, numberOfDialogueEntriesInArcBeforeTargetNode=len(chain)-1)


def graph_cases():
    """Changed-boundary controls for the static transcription, not runtime tests."""
    def entry(i, title, links=(), **f):
        values=dict(Title=title,Actor='1',Sequence='',**f)
        return dict(id=i,conversationID=1,fields=[dict(title=k,value=v) for k,v in values.items()],
            outgoingLinks=[dict(destinationConversationID=c,destinationDialogueID=d) for c,d in links])
    row=dict(id='registry',cells=dict(name='Registry',savekey='registry',has_player_initiated_question=False))
    base=[entry(0,'PRIMARY',[(1,1)]),entry(1,'first',[(1,2),(2,3)],TfolUniqueDataKeySuffix='p1'),
          entry(2,'second',[(1,1)]),entry(3,'other')]
    a=populate(dict(id=1,dialogueEntries=base),row,1)[0]
    assert a['orderedEntryIds']==[1,2] and len(a['ignoredCrossConversationLinks'])==1
    # Change just the cross-conversation destination: now entry3 is included.
    changed=json.loads(json.dumps(base));changed[1]['outgoingLinks'][1]['destinationConversationID']=1
    b=populate(dict(id=1,dialogueEntries=changed),row,1)[0]
    assert b['orderedEntryIds']==[1,2,3]
    branching=[entry(0,'PRIMARY',[(1,1)]),entry(1,'first',[(1,2),(1,5)],TfolUniqueDataKeySuffix='p1'),
        entry(2,'long-a',[(1,3)]),entry(3,'long-b',[(1,4)]),entry(4,'target'),entry(5,'short',[(1,4)])]
    bc=dict(id=1,dialogueEntries=branching);ba=populate(bc,row,1)[0]
    pc=parent_chain(bc,ba,4)
    assert pc['chain']==[4,3,2,1] and pc['numberOfDialogueEntriesInArcBeforeTargetNode']==3
    empty=populate(dict(id=1,dialogueEntries=[]),row,1)
    assert empty==[]
    named=[entry(0,'NAMED',[(1,4)]),entry(4,'custom',[(1,1)]),entry(1,'first',TfolUniqueDataKeySuffix='n1')]
    n=populate(dict(id=1,dialogueEntries=named),row,1)[0]
    assert n['namedHolderId']==4 and n['firstEntryId']==1 and n['orderedEntryIds']==[1]
    # Valid earlier guards; fail specifically on the manual suffix.
    bad=json.loads(json.dumps(base));bad[1]['fields']=[f for f in bad[1]['fields'] if f['title']!='TfolUniqueDataKeySuffix']
    try:
        populate(dict(id=1,dialogueEntries=bad),row,1)
        raise RuntimeError('expected exact rejection')
    except AssertionError as error:
        assert str(error)=='arc-missing-manual-suffix'
    return dict(localCycleDeduplicated=True,crossConversationExcluded=True,matchingLocalPositiveIncluded=True,
                absentRootProducesNoArc=True,namedIndirectionExact=True,
                parentPriorityUsesFirstOrderedPredecessorNotShortestPath=True,
                manualSuffixNegativeReason='arc-missing-manual-suffix',manualSuffixPositive=True,
                boundary='static algorithm controls; replaces game execution and cannot establish it')


def build(out):
    baseline=json.loads((HERE/'baseline.json').read_text())
    for p,h in baseline['pins'].items():
        assert sha(Path(p))==h,p
    for p,h in baseline['owningHelpers'].items():
        assert sha(ROOT/p)==h,p
    evidence_groups={'priorQuestEvidence':'quest-progress','priorInventoryEvidence':None,
        'priorConsumersEvidence':'quest-consumers','priorControlsEvidence':'quest-controls',
        'priorActorEvidence':'actor-identity','priorBioDetailEvidence':'bio-detail',
        'priorBioKeywordEvidence':'bio-keywords','priorBioNoteKinkEvidence':'bio-note-kink'}
    # Older groups use their original path base; unchanged prior verifier covers
    # them with those exact semantics. Check the three immediate families here.
    for key in ('priorBioDetailEvidence','priorBioKeywordEvidence','priorBioNoteKinkEvidence'):
        base=HERE.parent/evidence_groups[key]
        for p,h in baseline[key].items():
            assert sha(base/p)==h,(key,p)
    prior=json.loads((HERE/'prior-recheck/verification.json').read_text())
    assert prior['status']=='passed-static-scoped'
    oldread=HERE.parent/'bio-note-kink/readback'
    priorfiles=sorted(p for p in oldread.iterdir() if p.is_file())
    assert len(priorfiles)==11
    for p in priorfiles:
        assert sha(HERE/'prior-recheck'/p.name)==sha(p),p.name
    for path,h in prior['checkedInstalledSources'].items():
        assert sha(DATA/path)==h,path
    commands=json.loads((HERE/'il-commands.json').read_text())
    assert len(commands)==len({c['output'] for c in commands})
    for c in commands:
        actual=subprocess.check_output(['dotnet',str(ROOT/'tools/probe/bin/Debug/net8.0/InspectMethods.dll'),
            str(DATA/'Managed'/c['assembly']),c['type'],c['selection']])
        assert actual==(HERE/c['output']).read_bytes() and hashlib.sha256(actual).hexdigest()==c['sha256'],c['output']
    raw=SOURCE.read_bytes();decoded=decode(raw)
    assert decoded==json.loads((HERE/'decoded.json').read_text())
    sheet=decoded['sheets'][0]
    getters=(HERE/'db-dialogue-getters.il').read_text()
    assert generated_id(getters,'get_MetaDefault')==sheet['id']
    protected=[];relations=[];rebuilt=bytearray(raw);stored=0
    envelope=json.loads((HERE.parent/'inventory-decoded.json').read_text())['envelope']
    targets={s['id']:s for s in envelope['sheets']}
    for f in sheet['fields']:
        assert generated_id(getters,'get__'+f['name'])==f['id'],f['name']
        kind=f['type'].split(',')[0].rsplit('.',1)[-1]
        for row in sheet['rows']:
            c=cell(sheet,row,f['name']);span=c['sourceSpan'];enc=encode_cell(kind,c['source'])
            if span is not None:
                start,size=span['offset'],span['bytes'];assert enc==raw[start:start+size]
                rebuilt[start:start+size]=enc;stored+=1
            else:
                assert c['source'] is None
            c.update(role='preserve-exactly',sourceBytesHex=enc.hex() if span else None,
                reason='Registry identity, Actor/type relation or arc control; never a display translation unit')
            protected.append(c)
            if kind=='BGFieldRelationSingle' and c['source'] is not None:
                target=targets[f['targetSheetId']]
                assert target['name']==('DialogueType' if f['name']=='type' else 'Actor')
                assert target['rowIds'].count(c['source'])==1
                relations.append(dict(sourceCell=c,targetSheet=target['name'],targetSheetId=target['id'],
                    targetRowId=c['source'],targetRowIndex=target['rowIds'].index(c['source'])))
    assert len(protected)==4200 and len({c['id'] for c in protected})==4200 and bytes(rebuilt)==raw
    assert len(relations)==1201
    actors=json.loads((HERE.parent/'actor-identity/decoded.json').read_text())['sheets'][0]
    actor_by_id=unique(actors['rows'],lambda r:r['id'])
    actor_by_plugin=unique(actors['rows'],lambda r:r['cells']['plugin_db_name'])
    for row in sheet['rows']:
        assert row['cells']['primary_actor'] in actor_by_id
        assert row['cells']['initial_actor'] is None or row['cells']['initial_actor'] in actor_by_id
    by_plugin=unique(sheet['rows'],lambda r:r['cells']['plugin_db_name'])
    unique(sheet['rows'],lambda r:r['cells']['name']);unique(sheet['rows'],lambda r:r['cells']['savekey'])
    oldcontrols=json.loads((HERE.parent/'bio-keywords/readback/bio-controls.json').read_text())
    oldmembers=json.loads((HERE.parent/'bio-note-kink/readback/bio-control-membership.json').read_text())
    membership=unique(oldmembers,lambda c:c['controlId'])
    candidates=[json.loads(l) for l in (ROOT/'localization/source/dialogue-candidates.jsonl').read_text().splitlines()]
    assert len(candidates)==12246 and len({c['id'] for c in candidates})==12246
    manifest=json.loads((ROOT/'localization/source/dialogue-manifest.json').read_text())
    copy_results=[];copy_evidence=[]
    for copy in manifest['sources']:
        assert sha(ROOT/copy['tree'])==copy['treeSha256']
        tree=json.loads((ROOT/copy['tree']).read_text())
        for c in candidates:
            value=tree
            for part in c['pointer'].strip('/').split('/'):
                value=value[int(part)] if isinstance(value,list) else value[part]
            assert value==c['source'],c['id']
        conv_by_title=unique(tree['conversations'],lambda c:fields(c)['Title'])
        conv_by_id=unique(tree['conversations'],lambda c:c['id'])
        assert len(conv_by_title)==627 and set(by_plugin)<=set(conv_by_title)
        plugin_actors=unique(tree['actors'],lambda a:fields(a)['Name'])
        player_id=plugin_actors['player']['id']
        registry_bindings=[];all_arcs=[];arc_by_conversation={}
        for row in sheet['rows']:
            c=conv_by_title[row['cells']['plugin_db_name']]
            primary=actor_by_id[row['cells']['primary_actor']]
            initial=actor_by_id[row['cells']['initial_actor']] if row['cells']['initial_actor'] else primary
            arcs=populate(c,row,player_id)
            all_arcs+=arcs;arc_by_conversation[c['id']]=arcs
            registry_bindings.append(dict(registryRowId=row['id'],registryRowIndex=row['index'],
                registryCells=[cell(sheet,row,f['name']) for f in sheet['fields']],
                primaryActorIdentityCells=[cell(actors,primary,f) for f in ('name','savekey','plugin_db_name')],
                initialActorRowId=initial['id'],initialFallbackToPrimary=row['cells']['initial_actor'] is None,
                conversationId=c['id'],conversationFields=c['fields'],arcNames=[a['generatedName'] for a in arcs],
                selection='present in original600-row registry; successful full manifest execution unverified'))
        records=[]
        for old in oldcontrols:
            conv=conv_by_id[old['conversationId']]
            entry=next(e for e in conv['dialogueEntries'] if e['id']==old['entryId'])
            assert fields(entry)['Title']==old['source'] and entry['fields']==old['sourceEntryFields']
            assert entry['outgoingLinks']==old['outgoingLinks']
            row=by_plugin.get(old['conversationTitle'])
            primary=actor_by_id[row['cells']['primary_actor']] if row else None
            actor=actor_by_plugin[old['actorPluginDbName']] if old['argumentCount']==2 else primary
            matching=[a for a in arc_by_conversation.get(conv['id'],[]) if old['firstLinkDestinationId'] in a['orderedEntryIds']]
            registrations=[]
            for arc in matching:
                chain=parent_chain(conv,arc,old['firstLinkDestinationId'])
                assert actor is not None
                registrations.append(dict(arcName=arc['generatedName'],arcKind=arc['kind'],
                    firstEntryId=arc['firstEntryId'],triggerConversationId=conv['id'],
                    triggerDialogueEntryId=old['firstLinkDestinationId'],targetActorDbName=actor['cells']['name'],
                    pluginDbKeywordName=old['normalizedKeywordTrigger'],parentPriority=chain,
                    optionalKeywordMetadataAdded=old['keywordRowId'] is not None and chain['status']=='resolved'))
            status=('conversation-absent-from-original-Dialogue-registry' if row is None else
                'first-destination-not-in-any-populated-arc' if not matching else
                'static-registration-eligible' if all(r['parentPriority']['status']=='resolved' for r in registrations) else
                'registration-parent-priority-unresolved')
            records.append(dict(controlId=old['id'],conversationId=conv['id'],entryId=entry['id'],
                source=old['source'],sourcePointer=old['pointer'],sourceFields=entry['fields'],
                sourceConditions=entry.get('conditionsString'),sourceUserScript=entry.get('userScript'),
                outgoingLinks=entry['outgoingLinks'],firstLocalDestinationId=old['firstLinkDestinationId'],
                originalFirstLinkIsLocal=entry['outgoingLinks'][0]['destinationConversationID']==conv['id'],
                registryRowId=row['id'] if row else None,
                primaryActorRelation=cell(sheet,row,'primary_actor') if row else None,
                primaryActorRowId=primary['id'] if primary else None,
                actorArgumentMode='explicit-plugin-name' if old['argumentCount']==2 else 'exact-Dialogue-primaryActor-relation',
                resolvedActorIdentityCells=[cell(actors,actor,f) for f in ('name','savekey','plugin_db_name')] if actor else [],
                normalizedKeywordTrigger=old['normalizedKeywordTrigger'],keywordRowId=old['keywordRowId'],
                currentKeywordResolution=old['currentKeywordResolution'],status=status,registrations=registrations,
                priorCategoryMembership=membership[old['id']],
                categoryMembershipAfterActorResolution=('missing-current-key; no category reference can be resolved' if old['keywordRowId'] is None else membership[old['id']]['status']),
                reachability='not-accepted; no runtime/story-state execution',
                executionGuard='Original NarrativeActions returns in Instanced Event Vslice; otherwise exact actor/keyword lookups; no legacy-key repair'))
        result=dict(registry=registry_bindings,arcs=all_arcs,controls=records,
            unregisteredConversations=[dict(conversationId=c['id'],conversationFields=c['fields'],
                bioControlIds=[x['controlId'] for x in records if x['conversationId']==c['id']])
                for c in tree['conversations'] if fields(c)['Title'] not in by_plugin])
        copy_results.append(result)
        copy_evidence.append(dict(object=copy['object'],tree=copy['tree'],sha256=copy['treeSha256'],
            conversations=627,registryMatchedConversations=600,exactCandidateValues=12246,exactBioControlTitles=128))
        del tree,conv_by_id,conv_by_title,plugin_actors
        gc.collect()
    assert len(copy_results)==2 and copy_results[0]==copy_results[1]
    result=copy_results[0];controls=result['controls']
    legacy=[c for c in controls if c['actorArgumentMode']=='exact-Dialogue-primaryActor-relation']
    assert len(legacy)==15 and all(c['resolvedActorIdentityCells'] and c['keywordRowId'] is None for c in legacy)
    # Bind the original order/filter boundaries to exact bodies, beyond data-only matches.
    gen=(HERE/'generate-dialogues.il').read_text();callback=(HERE/'generate-dialogue-callback.il').read_text()
    assert 'IL_0027: ldnull\nIL_0028: ldnull\nIL_0029: call System.Void TheForestOfLove.DB.Dialogue::ForEachEntity' in gen
    assert callback.index('Dialogue::get_primary_actor()') < callback.index('Dialogue::primaryActor\n')
    assert 'actorsByDbActor' in callback and 'Conversation::get_Actor' not in callback
    assert [x for x in re.findall(r'ldstr "([A-Z]+)"',callback) if x in ('PRIMARY','SECONDARY','IDLE','NAMED')]==['PRIMARY','SECONDARY','IDLE','NAMED']
    il=(HERE/'populate-arcs.il').read_text()
    recursive=il.split('METHOD System.Void TheForestOfLove.Narrative.DialogueSystemLoader::RecursivelyPopulateDialogueEntries',1)[1]
    assert all(s in recursive for s in ('::Contains(!0)','::Add(!0)','Link::destinationConversationID','DialogueEntry::conversationID','bne.un.s IL_0050'))
    assert all(s not in recursive for s in ('conditionsString','userScript','::priority','isConnector'))
    stats=dict(status='passed-static-scoped',dialogueRows=600,selectedColumns=7,protectedCellStates=4200,
        storedSpansReencoded=stored,absentCellStates=4200-stored,generatedConstantIdsMatched=8,
        exactRelationEdges=len(relations),
        newDisplayCandidates=0,registryMatchedConversations=600,conversationsPerFrozenCopy=627,
        unregisteredConversations=len(result['unregisteredConversations']),populatedArcs=len(result['arcs']),
        arcEntryMemberships=sum(len(a['orderedEntryIds']) for a in result['arcs']),
        bioControls=128,controlsByRegistrationStatus=dict(collections.Counter(c['status'] for c in controls)),
        staticBioRegistrations=sum(len(c['registrations']) for c in controls),implicitActorsResolved=15,
        legacyKeysStillAbsent=15,legacyControlsByActor=dict(collections.Counter(c['resolvedActorIdentityCells'][0]['source'] for c in legacy)),
        staticRegistrationParentStatuses=dict(collections.Counter(r['parentPriority']['status'] for c in controls for r in c['registrations'])),
        frozenPinsUnchanged=19,helpersChecked=7,checkedInstalledSources=prior['checkedInstalledSources'],
        priorEvidenceHashes=prior['priorEvidenceHashes'],priorBioDetailEvidenceHashes=len(baseline['priorBioDetailEvidence']),
        priorBioKeywordEvidenceHashes=len(baseline['priorBioKeywordEvidence']),priorBioNoteKinkEvidenceHashes=len(baseline['priorBioNoteKinkEvidence']),
        priorExactIlSelections=17+31+44,currentExactIlSelections=len(commands),
        currentExactMethodBodies=sum((HERE/c['output']).read_text().count('\nMETHOD ') for c in commands),
        priorNoteKinkReadbacksMatched=11,
        priorKeywordAndBioDetailReadbacksMatched=16,dialogueCopies=2,exactDialogueSourceOccurrences=24492,
        exportedBytes=len(raw),sourceSha256=SOURCE_SHA,noOpWholeInputBytesEqual=True,
        wholeGameSourceAcceptance=False,successfulManifestExecution='not-run; other callback guards and dependent tables not accepted',
        sourceAcceptance='needs-review; scoped static registry/arc eligibility only',reinsertion='not-run',runtime='not-run',visual='not-run',editorial='not-run',
        storyReachability='not-accepted',gameLaunches=0,imagesOpened=0,gameAssemblyExecuted=False,
        translationAuthored=False,gitMutations=0,usage='Unknown in worker; parent measures telemetry')
    (out/'preserve-exactly.jsonl').write_text(''.join(json.dumps(c,ensure_ascii=False)+'\n' for c in protected))
    for name,data in [('registry-bindings.json',result['registry']),('arc-membership.json',result['arcs']),
        ('bio-registration.json',controls),('implicit-actors.json',legacy),
        ('unregistered-conversations.json',result['unregisteredConversations']),('relations.json',relations),('source-copies.json',copy_evidence),
        ('static-graph-controls.json',graph_cases()),('verification.json',stats)]:
        dump(out/name,data)
    return stats


if __name__=='__main__':
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('--output',type=Path,required=True)
    a=p.parse_args();assert not a.output.exists();a.output.mkdir(parents=True)
    print(json.dumps(build(a.output)))
