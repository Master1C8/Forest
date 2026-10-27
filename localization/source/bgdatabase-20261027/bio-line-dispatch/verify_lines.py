#!/usr/bin/env python3
"""Reproduce original implicit/preplayed line dispatch; metadata only, no game code."""
import argparse
import collections
import hashlib
import json
from pathlib import Path
import re
import struct
import subprocess
import sys

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[3]
REG = HERE.parent / 'bio-dialogue-registration'
PRIOR = HERE.parent / 'bio-trigger-dispatch'
DATA = Path('/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest/The Forest of Love_Data')
sys.path[:0] = [str(HERE.parent), str(HERE.parent / 'bio-detail')]
from decode_inventory import SOURCE, SOURCE_SHA, Reader, parse
from verify_bio import generated_id


def sha(p):
    h = hashlib.sha256()
    with p.open('rb') as stream:
        for block in iter(lambda: stream.read(4 * 1024 * 1024), b''):
            h.update(block)
    return h.hexdigest()


def load(p):
    return json.loads(p.read_text())


def dump(p, value):
    p.write_text(json.dumps(value, ensure_ascii=False, indent=2) + '\n')


def fields(record):
    pairs = record['fields']
    result = {f['title']: f['value'] for f in pairs}
    assert len(result) == len(pairs), 'duplicate-field'
    return result


def unique(rows, key):
    result = {key(r): r for r in rows}
    assert len(result) == len(rows), 'duplicate-id'
    return result


def begin_dispatch(encountered, actor_id, sequence, resolved_id, last_id, current=True):
    """Synthetic subtitle inputs: actual construction/default sequence is not replaced proof."""
    changed = False
    if actor_id > 0 and not (sequence is not None and 'none' in sequence.lower()):
        if resolved_id is not None and resolved_id != last_id:
            changed = True
            last_id = resolved_id
            encountered = True
    return dict(encountered=encountered, lastActorId=last_id, actorChangedEvent=changed,
                callsLineEndHandler=not encountered, emitsArcCheck=not encountered and current)


def skip_first(first, question, question_actor_name, outgoing, skip):
    """Integer IDs stand for original object references in synthetic controls only."""
    if not skip:
        return dict(preplayed=None, destination=first, error=None)
    preplayed = first if first != question else None
    if question_actor_name is None:
        return dict(preplayed=preplayed, destination=None, error='actor-lookup-null-callvirt')
    if question_actor_name != 'player':
        return dict(preplayed=preplayed, destination=first, error=None)
    if not outgoing:
        return dict(preplayed=preplayed, destination=None, error='player-first-link-missing')
    return dict(preplayed=preplayed, destination=outgoing[0], error=None)


def controls():
    rows = []
    def check(name, got, expected):
        assert got == expected, (name, got, expected)
        rows.append(dict(name=name, actual=got, expected=expected))
    def b(enc=False, actor=0, seq=None, resolved=None, last=-1, current=True):
        return begin_dispatch(enc, actor, seq, resolved, last, current)
    def expected(enc=False, last=-1, changed=False, handler=True, event=True):
        return dict(encountered=enc, lastActorId=last, actorChangedEvent=changed,
                    callsLineEndHandler=handler, emitsArcCheck=event)
    check('no-positive-actor-before-spoken', b(), expected())
    check('none-sequence-positive-actor', b(actor=3, seq='None()', resolved=3), expected())
    check('substring-none-is-not-command-parser', b(actor=3, seq='Nonetheless()', resolved=3), expected())
    check('first-resolved-spoken-changes-latch', b(actor=3, seq='', resolved=3),
          expected(True, 3, True, False, False))
    check('delay-does-not-skip-triggering-actor-check', b(actor=3, seq='Delay(1)', resolved=3),
          expected(True, 3, True, False, False))
    check('continue-does-not-skip-triggering-actor-check', b(actor=3, seq='Continue()', resolved=3),
          expected(True, 3, True, False, False))
    check('missing-manifest-actor-keeps-latch-false', b(actor=3, seq='', resolved=None), expected())
    check('same-actor-keeps-latch-false', b(actor=3, seq='', resolved=3, last=3), expected(last=3))
    check('after-spoken-no-implicit-even-none', b(enc=True, seq='None()'), expected(True, -1, False, False, False))
    check('null-dialogue-handler-no-event', b(current=False), expected(event=False))
    check('builder-no-skip', skip_first(10, 11, 'player', [12], False),
          dict(preplayed=None, destination=10, error=None))
    check('builder-proxy-first-preplayed', skip_first(10, 11, 'player', [12], True),
          dict(preplayed=10, destination=12, error=None))
    check('builder-first-is-question-no-preplay', skip_first(10, 10, 'player', [12], True),
          dict(preplayed=None, destination=12, error=None))
    check('builder-null-question-still-preplays-first', skip_first(10, None, 'player', [12], True),
          dict(preplayed=10, destination=12, error=None))
    check('builder-nonplayer-still-preplays-but-retains-first', skip_first(10, None, 'beaver', [], True),
          dict(preplayed=10, destination=10, error=None))
    check('builder-missing-link-after-event', skip_first(10, None, 'player', [], True),
          dict(preplayed=10, destination=None, error='player-first-link-missing'))
    check('builder-missing-actor-after-event', skip_first(10, None, None, [], True),
          dict(preplayed=10, destination=None, error='actor-lookup-null-callvirt'))
    return dict(boundary='Synthetic Python transcription only; replaces original game execution and callback timing', cases=rows)


def build(out):
    baseline = load(HERE / 'baseline.json')
    for p, h in baseline['pins'].items():
        assert sha(Path(p)) == h, p
    for p, h in baseline['owningHelpers'].items():
        assert sha(ROOT / p) == h, p
    directories = dict(priorInventoryEvidence='', priorQuestEvidence='quest-progress',
        priorConsumersEvidence='quest-consumers', priorControlsEvidence='quest-controls',
        priorActorEvidence='actor-identity', priorBioDetailEvidence='bio-detail',
        priorBioKeywordEvidence='bio-keywords', priorBioNoteKinkEvidence='bio-note-kink',
        priorRegistrationEvidence='bio-dialogue-registration', priorTriggerDispatchEvidence='bio-trigger-dispatch')
    for group, directory in directories.items():
        for p, h in baseline[group].items():
            assert sha(HERE.parent / directory / p) == h, (group, p)
    prior = load(PRIOR / 'readback/verification.json')
    for p, h in prior['checkedInstalledSources'].items():
        assert sha(DATA / p) == h, p
    for old, fresh, count in [(REG/'readback', HERE/'registration-recheck', 10),
                              (PRIOR/'readback', HERE/'dispatch-recheck', 4)]:
        files = sorted(p for p in old.iterdir() if p.is_file())
        assert len(files) == count
        for p in files:
            assert (fresh/p.name).read_bytes() == p.read_bytes(), p.name
    commands = load(HERE/'il-commands.json')
    assert len(commands) == len({c['output'] for c in commands})
    for c in commands:
        actual = subprocess.check_output(['dotnet', str(ROOT/'tools/probe/bin/Debug/net8.0/InspectMethods.dll'),
            str(DATA/'Managed'/c['assembly']), c['type'], c['selection']])
        assert actual == (HERE/c['output']).read_bytes(), c['output']
        assert hashlib.sha256(actual).hexdigest() == c['sha256'], c['output']
    trigger_il = (HERE/'line-triggering.il').read_text()
    assert 'IL_0028: br.s IL_002b' in trigger_il and 'IL_0059: brtrue.s IL_0062' in trigger_il
    assert trigger_il.index('::CheckIfActorChanged(') < trigger_il.index('::encounteredSpokenLineInCurrentDialogue')
    begin_il = (HERE/'line-begin.il').read_text()
    assert begin_il.index('::HandleDialogueLineTriggering(') < begin_il.index('::HandleDialogueLineActor(')
    dynamic_il = (HERE/'dynamic-conversation.il').read_text()
    assert 'IL_0192: brfalse IL_024a' in dynamic_il and 'IL_01e0: beq.s IL_020c' in dynamic_il
    assert dynamic_il.index('::Handler_OnConversationLineEnd(') < dynamic_il.index('IL_020c: ldloc.2')
    assert 'DialogueService::set_CurrentArc(' not in dynamic_il and 'DialogueService::set_CurrentDialogue(' not in dynamic_il
    assert 'IL_0239: ldfld System.Int32 PixelCrushers.DialogueSystem.Link::destinationDialogueID' in dynamic_il
    assert dynamic_il.count('::destinationConversationID') == 0
    codec = (HERE/'enum-codec.il').read_text()
    assert 'System.Enum::ToObject(System.Type,System.Int32)' in codec

    # Only the seven enum_type cells are new BGDatabase decoding. Reuse the exact
    # accepted envelope and fixed four-byte codec, bind generated BGIds and config.
    raw = SOURCE.read_bytes()
    assert hashlib.sha256(raw).hexdigest() == SOURCE_SHA
    envelope = parse(raw)
    assert envelope == load(HERE.parent/'inventory-decoded.json')['envelope']
    sheet = next(s for s in envelope['sheets'] if s['name'] == 'DialogueType')
    f = next(f for f in sheet['fields'] if f['name'] == 'enum_type')
    assert f['type'].split(',')[0].endswith('.BGFieldEnum')
    cfg = Reader(bytes.fromhex(f['configHex']))
    assert cfg.integer() == 1 and cfg.string() == 'TheForestOfLove.Narrative.DialogueType' and cfg.pos == len(cfg.data)
    getters = (HERE/'db-type-getters.il').read_text()
    assert generated_id(getters, 'get_MetaDefault') == sheet['id']
    assert generated_id(getters, 'get__enum_type') == f['id']
    enum_names = {int(v): name for name, v in re.findall(r'DialogueType::(\w+) = (\d+)', (HERE/'dialogue-type.il').read_text())}
    start, size = f['valuesOffset'], f['valuesBytes']
    blob = raw[start:start+size]
    assert len(sheet['rowIds']) == 7 and size == 28 and hashlib.sha256(blob).hexdigest() == f['valuesSha256']
    enum_rows = []
    for i, ident in enumerate(sheet['rowIds']):
        b = blob[i*4:i*4+4]; value = struct.unpack('<i', b)[0]
        assert struct.pack('<i', value) == b and value in enum_names
        enum_rows.append(dict(sheetId=sheet['id'], rowId=ident, rowIndex=i, fieldId=f['id'],
            field='enum_type', source=value, enumName=enum_names[value], sourceBytesHex=b.hex(),
            sourceSpan=dict(offset=start+i*4, bytes=4), role='preserve-exactly'))
    by_type = unique(enum_rows, lambda r: r['rowId'])

    arc_list = load(REG/'readback/arc-membership.json')
    registry = load(REG/'readback/registry-bindings.json')
    reg_by_conv = unique(registry, lambda r: r['conversationId'])
    targets = load(PRIOR/'readback/dispatch-targets.json')
    manifest = load(ROOT/'localization/source/dialogue-manifest.json')
    candidates = [json.loads(line) for line in (ROOT/'localization/source/dialogue-candidates.jsonl').read_text().splitlines()]
    assert len(candidates) == len(unique(candidates, lambda r:r['id'])) == 12246
    candidates_by_node = collections.defaultdict(list)
    for c in candidates:
        candidates_by_node[c['conversationId'],c['entryId']].append(c)
    copies = []; source_copies = []
    for copy in manifest['sources']:
        assert sha(ROOT/copy['tree']) == copy['treeSha256']
        tree = load(ROOT/copy['tree'])
        for c in candidates:
            value = tree
            for part in c['pointer'].strip('/').split('/'):
                value = value[int(part)] if isinstance(value, list) else value[part]
            assert value == c['source'], c['id']
        convs = unique(tree['conversations'], lambda c:c['id'])
        actors = unique(tree['actors'], lambda a:a['id'])
        entries = {cid:unique(c['dialogueEntries'],lambda e:e['id']) for cid,c in convs.items()}
        default_arcs = {}
        for cid in reg_by_conv:
            eligible = [a for a in arc_list if a['conversationId']==cid]
            chosen = next((a for kind in ('PRIMARY','IDLE','NAMED') for a in eligible if a['kind']==kind), None)
            default_arcs[cid] = chosen['generatedName'] if chosen else None
        arcs = []
        for a in arc_list:
            cid = a['conversationId']; first = entries[cid][a['firstEntryId']]
            assert first['fields'] == a['firstEntryFields'] and first['conversationID'] == cid
            qid = a['playerQuestionEntryId']; question = entries[cid][qid] if qid is not None else first
            actor_id = int(fields(question).get('Actor', '0'))
            actor = actors.get(actor_id); name = fields(actor)['Name'] if actor else None
            links = question['outgoingLinks']
            result = skip_first(first['id'], qid, name, [l['destinationDialogueID'] for l in links], True)
            if result['error'] is None and result['destination'] not in entries[cid]:
                result.update(destination=None, error='local-conversation-destination-missing')
            reg = reg_by_conv[cid]; cells = {c['field']:c for c in reg['registryCells']}
            type_row = by_type[cells['type']['source']]
            # PlayDialogue's unqualified path has an explicit positive skip only
            # for Gossip, unless DevCommandActive. Named customName remains false;
            # generated-name fallback permits skip only for exact p1 suffix.
            row = dict(arcName=a['generatedName'], arcKind=a['kind'], conversationId=cid,
                originalFirstEntryId=first['id'], originalPlayerQuestionEntryId=qid,
                firstEntryFields=first['fields'], questionEntryFields=question['fields'],
                questionActorId=actor_id, questionActorName=name, originalQuestionOutgoingLinks=links,
                dialogueTypeCell=cells['type'], resolvedDialogueType=type_row,
                builderSkipFalse=dict(preplayed=None, destination=first['id'], error=None),
                builderSkipTrue=result,
                callerSkipGate=dict(dialogueTypeMustEqual=400, actualType=type_row['source'],
                    devCommandMustBeFalse=True, selectedByDefaultArcCall=default_arcs[cid]==a['generatedName'],
                    customNameCall=False, generatedNameCall=a['suffix']=='p1'),
                requiredEventContext='CurrentDialogue must own exact trigger list; CurrentArc must be same original arc reference; no loop-local reassignment',
                runtime='not-run; no cache/selection/conditions/scripts/link priority or story reachability acceptance')
            arcs.append(row)
        arc_by_name = unique(arcs, lambda a:a['arcName'])
        target_rows = []
        for t in targets:
            r = t['registration']; cid = r['triggerConversationId']; eid = r['triggerDialogueEntryId']
            entry = entries[cid][eid]; ff = fields(entry); a = arc_by_name[r['arcName']]
            preplay_match = a['builderSkipTrue']['preplayed'] == eid
            # The builder iterates the entire live cache without updating current
            # context. Test every original first node, including another arc in
            # the same conversation; the owning trigger's first node alone is
            # an insufficient exclusion bound (108:118 has two registrations).
            cached_matches = [x['arcName'] for x in arcs if
                x['conversationId']==cid and x['builderSkipTrue']['preplayed']==eid]
            target_rows.append(dict(controlId=t['controlId'], registrationIndex=t['registrationIndex'],
                registration=r, exactTargetEntry=entry,
                targetCandidates=candidates_by_node[cid,eid],
                originalEntryActorId=int(ff.get('Actor','0')), originalEntrySequence=ff.get('Sequence'),
                subtitleSequenceBinding='not-accepted: Subtitle.sequence may come from override/defaults; entry field alone is not actual Subtitle',
                beginDispatch='line-end while encounteredSpokenLineInCurrentDialogue stays false; original IDs, current Dialogue/Arc; before HandleDialogueLineActor',
                builderSkipTruePreplayNodeMatch=preplay_match,
                builderSkipTrueMatchingCachedArcNames=cached_matches,
                registeredDialogueIsGossip=a['resolvedDialogueType']['source']==400,
                playDialogueBuilderPreplayTypePossible=bool(cached_matches) and a['resolvedDialogueType']['source']==400,
                priorInactiveTagOutcome=t['vsliceInactiveOutcome'],
                priorCategoryMembership=t['potentialCategoryMembership'],
                runtime='not-run; no emitted callback, successful unlock or playability claim'))
        templates = []
        for c in tree['conversations']:
            title = fields(c)['Title']
            if title == 'system/dynamicConversation' or title.startswith('system/dynamicQuestions/'):
                titles = ('PASSTHROUGH','DYNAMICROOT','DYNAMICQUESTIONS','GENERICFAREWELL') if title == 'system/dynamicConversation' else ('START',)
                selected = []
                for title_key in titles:
                    found = [e for e in c['dialogueEntries'] if fields(e)['Title']==title_key]
                    assert len(found)==1, (title,title_key)
                    selected.append(found[0])
                templates.append(dict(conversationId=c['id'], originalConversationFields=c['fields'],
                    selectedEntries=selected, role='preserve-exactly template IDs/titles/links; no visibility or inclusion-to-reachability inference'))
        copies.append(dict(arcs=arcs, targets=target_rows, templates=templates))
        source_copies.append(dict(tree=copy['tree'], sha256=copy['treeSha256'], exactCandidateValues=12246,
                                  conversations=len(convs), targetRegistrations=len(target_rows)))
    assert len(copies)==2 and copies[0]==copies[1]
    result = copies[0]; all_targets = result['targets']
    matches = [r for r in all_targets if r['builderSkipTruePreplayNodeMatch']]
    all_cached_matches = [r for r in all_targets if r['builderSkipTrueMatchingCachedArcNames']]
    permitted = [r for r in all_cached_matches if r['playDialogueBuilderPreplayTypePossible']]
    cases = controls()
    for name,value in [('dynamic-arcs.json',result['arcs']), ('target-line-contexts.json',all_targets),
        ('dynamic-templates.json',result['templates']),('dialogue-type-cells.json',enum_rows),
        ('source-copies.json',source_copies),('line-controls.json',cases)]:
        dump(out/name, value)
    stats = dict(status='passed-static-scoped', frozenPinsUnchanged=len(baseline['pins']),
        helpersChecked=len(baseline['owningHelpers']), priorEvidenceHashes={g:len(baseline[g]) for g in directories},
        checkedInstalledSources=prior['checkedInstalledSources'], registrationReadbacksMatched=10, dispatchReadbacksMatched=4,
        freshlyReproducedRegistrationSelections=27, freshlyReproducedDispatchSelections=29,
        freshIlSelections=len(commands), freshMethodBodies=sum((HERE/c['output']).read_text().count('\nMETHOD ') for c in commands),
        exactCandidateValuesPerCopy=12246, sourceCopies=2, exactSourceOccurrences=24492,
        newEnumCells=7, newEnumBytesReencoded=28, generatedTypeIdsMatched=2,
        arcs=len(result['arcs']), registeredBioTargetContexts=len(all_targets),
        skipTrueFirstNodeBioMatches=len(matches), gossipTypePermitsPreplayMatches=len(permitted),
        skipTrueBioRegistrationsMatchingAnyOriginalCachedArc=len(all_cached_matches),
        targetDialogueTypes=dict(collections.Counter(arc_by_name[r['registration']['arcName']]['resolvedDialogueType']['enumName'] for r in all_targets)),
        skipTrueLinkErrors=dict(collections.Counter(r['builderSkipTrue']['error'] for r in result['arcs'] if r['builderSkipTrue']['error'])),
        dynamicTemplates=len(result['templates']), syntheticControls=len(cases['cases']),
        newDisplayCandidates=0, authoredTranslations=0, wholeGameSourceAcceptance=False,
        subtitleConstruction='not-accepted', callbackOrdering='static local instruction order only; plugin dispatch not accepted',
        storyReachability='not-accepted', runtime='not-run', visual='not-run', editorial='not-run', reinsertion='not-run',
        gameAssemblyExecuted=False, gameLaunches=0, imagesOpened=0, gitMutations=0,
        usage='unknown in worker; parent measures telemetry')
    dump(out/'verification.json', stats)
    return stats


if __name__ == '__main__':
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('--output', type=Path, required=True)
    args = p.parse_args()
    assert not args.output.exists(), 'output must be new'
    args.output.mkdir(parents=True)
    print(json.dumps(build(args.output)))
