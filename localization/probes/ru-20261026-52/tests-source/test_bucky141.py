"""Pure host routing fixtures replace Unity producers/time, never native proof."""
import copy
import json
from pathlib import Path
import sys
import unittest
from unittest.mock import patch

sys.path.insert(0, str(Path(__file__).resolve().parent))
from test_native_input import gameplay as probe
import prepare_bucky141 as source

PLAN = source.plan()
ENTRIES = probe.bucky141_plan_guard(PLAN)
ROOT = Path(__file__).resolve().parents[1]
IDENTITY = dict(company='VNRevivalQA', product='ForestRuRendererProbe', scene='CentralForest',
    dataPath='Y:/Desktop/Forest/localization/probes/unit-bucky141/game/'+probe.DATA,
    persistentDataPath='C:/QA/VNRevivalQA/ForestRuRendererProbe')


def completion(frame=10, end=None):
    rows = ['guards | gameplay=True | anyEvent=False | conversation=False',
        'quest | name=Act1_TutorialQuest | status=100',
        'questDialogue | name=TutorialQuest_BeaverIntroduction | actor=Bucky | initialActor=Narrator | status='+('200' if end else '0')+' | conversation=141 | type=Quest | first=False | last=False',
        'primaryArc | dialogue=TutorialQuest_BeaverIntroduction | suffix=p1 | status='+('100' if end else '0')+' | entry=215',
        'buckyNotebookTrigger | conversation=225 | entry=195 | executed=False',
        'buckyCompletion | notebookLearned=False | observerArmed='+str(end is not None)+' | lineEnd='+json.dumps(end, separators=(',', ':'))]
    rows += ['trigger | name='+name+' | count='+str(int(end is not None and name=='intro_from_beaver')) for name in probe.BUCKY141_COUNTS]
    return dict(IDENTITY, frame=frame, realtime=float(frame), choiceMode='original', diagnostics=rows)


def state(eid=215, frame=11, typing=False, menu=True):
    e = ENTRIES[eid]
    text = e['text'].split(']', 1)[1] if e['text'].startswith('[pic=') else e['text']
    result = dict(IDENTITY, frame=frame, realtime=float(frame), typing=typing, conversationActive=True,
        conversationId=141, entryId=eid, conversationState=text, narrativeDbName='TutorialQuest_BeaverIntroduction',
        narrativeArcName='p1', diagnosticsReady=True, dataServicePresent=True, manifestPresent=True,
        dataServiceInstance=99, notReady=[], responses=[], bucky212EndRecord='',
        bucky141Record=json.dumps(dict(choiceMode='original', frame=frame, conversationId=141, entryId=eid,
            actorId=e['actor'], conversantId=e['conversant'], sourceText=e['text'], graphVerified=True)))
    if eid == 215 and menu:
        for choice in [216, 217]:
            label = ENTRIES[choice]['text']
            result['responses'].append(dict(conversationId=141, entryId=choice, text=label,
                visible=True, clickable=True, targetPath=probe.TUTORIAL_UI,
                path=probe.TUTORIAL_TEXT_PANEL+'/Response Menu Panel/Viewport/Content/Response: '+label))
        path = result['responses'][1]['path']
        result['bucky217Record'] = json.dumps(dict(choiceMode='original', frame=frame, conversationId=141,
            sourceId=215, destinationId=217, successorId=194, text='Yes', path=path, targetPath=probe.TUTORIAL_UI,
            listenerMethod='OnClick', listenerTargetPath=path, buttonInstance=21, controllerInstance=22,
            declinedButtonInstance=23, declinedControllerInstance=24, typing=False, graphVerified=True, listenerVerified=True,
            controllerType=probe.BUCKY141_WRAPPER, declinedControllerType=probe.BUCKY141_WRAPPER,
            listenerDeclaringType=probe.BUCKY141_LISTENER, declinedListenerDeclaringType=probe.BUCKY141_LISTENER))
    return result


def armed():
    tracker = probe.Bucky141Transitions(PLAN, completion(), 0.)
    s = state()
    action = tracker.observe(s, 1.)
    native = dict(json.loads(s['bucky217Record']), frame=12, result='submitted')
    transport = dict(command=action, transportExitCode=0, acknowledgement='stamp OK '+action,
        submittedAt=1., acknowledgedAt=1.5)
    return tracker, s, action, transport, native


def followed():
    tracker, s, action, transport, native = armed()
    tracker.acknowledge_selection(s, action, transport, native)
    for frame, eid in enumerate(probe.BUCKY141_ROUTE, 13):
        tracker.observe(state(eid, frame), float(frame-10))
    return tracker


def ended(frame=33, end=None):
    result = state(212, frame)
    result.update(conversationActive=False, typing=False, conversationState='', entryId=0,
        narrativeDbName='', narrativeArcName='', responses=[], bucky141Record='')
    result['bucky212EndRecord'] = json.dumps(end or dict(conversationId=141, entryId=212,
        dbName='TutorialQuest_BeaverIntroduction', arc='p1', count=1, frame=32, realtime=32.))
    return result


IDLE = dict(scene='CentralForest', gameplay=True, anyEvent=False, conversation=False, playerPresent=True)


class Bucky141(unittest.TestCase):
    def setUp(self):
        self.identity = patch.object(probe, 'RUN', Path('unit-bucky141'))
        self.identity.start()
        self.addCleanup(self.identity.stop)

    def test_exact_source_recipe_and_embedded_graph_calls(self):
        self.assertEqual(PLAN, json.loads((ROOT/'localization/source/tutorial-20261026/phase0060/source-plan/bucky141-plan.json').read_text()))
        code = (ROOT/'tools/probe/ForestProbe.cs').read_text()
        calls = code.split('    void Bucky141Graph() {\n', 1)[1].split('    }', 1)[0]
        self.assertEqual(calls, source.graph_calls(PLAN))
        self.assertEqual(ENTRIES[201]['actor'], 7)
        self.assertEqual(ENTRIES[206]['actor'], 1)
        self.assertEqual(ENTRIES[216]['outgoingLinks'], [])
        self.assertEqual(ENTRIES[217]['outgoingLinks'][0]['destinationDialogueID'], 194)

    def test_plan_rejects_wrong_actor_controls_link_sequence_text_and_pin(self):
        for key, value, reason in [('actor', 3, 'actors'), ('script', 'mutate()', 'controls'),
                ('outgoingLinks', [], 'link'), ('sequence', 'None()', 'sequence'),
                ('text', 'Wrong', 'full plan pin'), ('onExecute', {'m_PersistentCalls': {'m_Calls': [1]}}, 'callback')]:
            p = copy.deepcopy(PLAN)
            next(e for e in p['entries'] if e['id']==201)[key] = value
            with self.subTest(key=key), self.assertRaisesRegex(AssertionError, reason):probe.bucky141_plan_guard(p)

    def test_both_exact_choices_and_ready_typing_policy(self):
        s = state()
        self.assertEqual(probe.bucky217_selection_guard(s, ENTRIES)['destinationId'], 217)
        tracker = probe.Bucky141Transitions(PLAN, completion(), 0.)
        self.assertIsNone(tracker.observe(state(typing=True, menu=False), 1.))
        self.assertEqual(tracker.observe(state(frame=12), 2.), 'select-bucky217 12 21')
        for change, reason in [('missing', 'both exact choices'), ('duplicate', 'both exact choices'),
                ('text', 'response control'), ('target', 'response control'), ('hidden', 'response control')]:
            bad = copy.deepcopy(s)
            if change=='missing':bad['responses'].pop(0)
            if change=='duplicate':bad['responses'][0]=bad['responses'][1]
            if change=='text':bad['responses'][0]['text']='Yes'
            if change=='target':bad['responses'][1]['targetPath']='wrong'
            if change=='hidden':bad['responses'][0]['visible']=False
            with self.subTest(change=change), self.assertRaisesRegex(AssertionError, reason):probe.bucky217_selection_guard(bad, ENTRIES)

    def test_native_wrong_actor_type_listener_identity_mode_and_freshness(self):
        for field, value, reason in [('destinationId', 216, 'native source'), ('successorId', 195, 'native source'),
                ('frame', 10, 'native source'), ('choiceMode', 'synthetic', 'native binding'),
                ('controllerType', probe.BUCKY141_LISTENER, 'wrapper type'),
                ('declinedControllerType', probe.BUCKY141_LISTENER, 'wrapper type'),
                ('listenerDeclaringType', probe.BUCKY141_WRAPPER, 'inherited listener'),
                ('declinedListenerDeclaringType', 'Wrong', 'inherited listener'),
                ('listenerMethod', 'Invoke', 'native binding'), ('listenerVerified', False, 'unverified'),
                ('buttonInstance', 23, 'distinct control'), ('declinedControllerInstance', 0, 'distinct control')]:
            bad = state(); row = json.loads(bad['bucky217Record']); row[field]=value; bad['bucky217Record']=json.dumps(row)
            with self.subTest(field=field), self.assertRaisesRegex(AssertionError, reason):probe.bucky217_selection_guard(bad, ENTRIES)
        for field, value, reason in [('actorId', 3, 'actor/text'), ('sourceText', 'Wrong', 'actor/text'),
                ('graphVerified', False, 'graph unverified'), ('frame', 1, 'Stale')]:
            bad = state(); row=json.loads(bad['bucky141Record']);row[field]=value;bad['bucky141Record']=json.dumps(row)
            with self.subTest(field=field), self.assertRaisesRegex(AssertionError, reason):probe.bucky217_selection_guard(bad, ENTRIES)

    def test_ack_does_not_supply194_time_or_budget_and_cannot_replay(self):
        tracker, s, action, transport, native = armed()
        before = (tracker.frame, tracker.realtime, tracker.deadline, tracker.progress_at, tracker.previous)
        tracker.acknowledge_selection(s, action, transport, native)
        self.assertEqual((tracker.frame, tracker.realtime, tracker.deadline, tracker.progress_at, tracker.previous), before)
        self.assertFalse(tracker.receipt()['actual194Observed'])
        self.assertEqual(tracker.observed, [])
        with self.assertRaisesRegex(AssertionError, 'no replay'):tracker.acknowledge_selection(s, action, transport, native)
        tracker.observe(state(217, 12), 2.)
        self.assertFalse(tracker.receipt()['actual194Observed'])
        tracker.observe(state(194, 13), 3.)
        self.assertTrue(tracker.receipt()['actual194Observed'])

    def test_ack_wrong_binding_timestamp_source_and_unknown_outcome_reject(self):
        for change, reason in [('command', 'exact.*ACK'), ('exit', 'exact.*ACK'), ('time', 'Stale.*ACK'),
                ('receipt', 'receipt binding'), ('frame', 'Stale.*receipt'), ('host', 'Stale.*host')]:
            tracker, s, action, transport, native = armed()
            if change=='command':transport['acknowledgement']='stamp OK wrong'
            if change=='exit':transport['transportExitCode']=1
            if change=='time':transport['acknowledgedAt']=121
            if change=='receipt':native['declinedButtonInstance']=999
            if change=='frame':native['frame']=132
            if change=='host':tracker.frame=9
            with self.subTest(change=change), self.assertRaisesRegex(AssertionError, reason):tracker.acknowledge_selection(s, action, transport, native)

    def test_exact_successor_route_narrator_player_and_no_skip_backtrack(self):
        tracker, s, action, transport, native = armed();tracker.acknowledge_selection(s,action,transport,native)
        with self.assertRaisesRegex(AssertionError, 'successor194'):tracker.observe(state(195,13),3.)
        tracker.observe(state(194,13),3.)
        with self.assertRaisesRegex(AssertionError, 'skipped/backtracked'):tracker.observe(state(196,14),4.)
        tracker.observe(state(195,14),4.)
        with self.assertRaisesRegex(AssertionError, 'skipped/backtracked'):tracker.observe(state(194,15),5.)
        tracker=followed()
        self.assertEqual(tracker.observed, probe.BUCKY141_ROUTE)
        self.assertIsNone(tracker.action(state(212,32,typing=True)))
        self.assertEqual(tracker.action(state(212,32)), 'continue-bound 141 212')

    def test_wrong_narrative_mode_source_menu_and_readiness_reject(self):
        for field,value,reason in [('scene','BunnyHouse','scene identity'), ('narrativeDbName','other','narrative binding'),
                ('conversationId',120,'narrative binding'), ('narrativeArcName','p2','narrative binding'),
                ('conversationState','Wrong','rendered subtitle'), ('dataServicePresent',False,'dependencies not ready')]:
            tracker, s, action, transport, native=armed();tracker.acknowledge_selection(s,action,transport,native)
            bad=state(194,13);bad[field]=value
            if field=='dataServicePresent':bad.update(diagnosticsReady=False, manifestPresent=False,
                dataServiceInstance=0,notReady=['DataService._instance'])
            with self.subTest(field=field),self.assertRaisesRegex(AssertionError,reason):tracker.observe(bad,3.)
        tracker, s, action, transport, native=armed();tracker.acknowledge_selection(s,action,transport,native)
        bad=state(194,13);bad['responses']=state()['responses']
        with self.assertRaisesRegex(AssertionError,'unexpected response'):tracker.observe(bad,3.)

    def test_cleanup_cannot_substitute_route_or_real_end(self):
        tracker, s, action, transport, native=armed();tracker.acknowledge_selection(s,action,transport,native)
        with self.assertRaisesRegex(AssertionError,'before full212'):tracker.observe(ended(),3.,IDLE)
        for field,value in [('entryId',211),('count',2),('dbName','wrong'),('arc','wrong'),('frame',1),('frame',31),('realtime',1.),('realtime',31.)]:
            tracker=followed();bad=ended();end=json.loads(bad['bucky212EndRecord']);end[field]=value;bad['bucky212EndRecord']=json.dumps(end)
            with self.subTest(field=field),self.assertRaisesRegex(AssertionError,'real212 line-end'):tracker.observe(bad,23.,IDLE)
        tracker=followed();bad=ended();bad['bucky212EndRecord']=''
        with self.assertRaisesRegex(AssertionError,'real212 line-end'):tracker.observe(bad,23.,IDLE)

    def test_two_real_idle_frames_then_fresh_counts_status_notebook(self):
        tracker=followed();end=json.loads(ended()['bucky212EndRecord'])
        tracker.observe(ended(),23.,IDLE)
        self.assertEqual(tracker.deadline,38.)
        with self.assertRaisesRegex(AssertionError,'two real cleanup'):tracker.accept_completion(completion(34,end),24.)
        with self.assertRaisesRegex(AssertionError,'new real frame'):tracker.observe(ended(),24.,IDLE)
        with self.assertRaisesRegex(AssertionError,'no-event Player'):tracker.observe(ended(34),24.,dict(IDLE,anyEvent=True))
        tracker.observe(ended(34),24.,IDLE)
        self.assertEqual(tracker.deadline,38.)
        self.assertTrue(tracker.accept_completion(completion(35,end),25.)['actual194Observed'])
        with self.assertRaisesRegex(AssertionError,'already accepted'):tracker.accept_completion(completion(36,end),26.)

    def test_completion_count_delta_status_notebook_and_staleness_reject(self):
        for old,new,reason in [('name=intro_from_mouse | count=0','name=intro_from_mouse | count=1','named trigger delta'),
                ('name=intro_from_beaver | count=1','name=intro_from_beaver | count=0','named trigger delta'),
                ('notebookLearned=False','notebookLearned=True','cannot complete notebook'),
                ('entry=195 | executed=False','entry=195 | executed=True','cannot complete notebook'),
                ('suffix=p1 | status=100','suffix=p1 | status=0','status differs')]:
            tracker=followed();end=json.loads(ended()['bucky212EndRecord']);tracker.observe(ended(),23.,IDLE);tracker.observe(ended(34),24.,IDLE)
            bad=completion(35,end);bad['diagnostics']=[r.replace(old,new) for r in bad['diagnostics']]
            with self.subTest(old=old),self.assertRaisesRegex(AssertionError,reason):tracker.accept_completion(bad,25.)
        tracker=followed();end=json.loads(ended()['bucky212EndRecord']);tracker.observe(ended(),23.,IDLE);tracker.observe(ended(34),24.,IDLE)
        with self.assertRaisesRegex(AssertionError,'stale completion'):tracker.accept_completion(completion(34,end),25.)
        with self.assertRaisesRegex(AssertionError,'stale completion'):tracker.accept_completion(completion(37,end),25.)

    def test_fixed_stage_and_progress_budget_never_renew_on_ack_or_same_line(self):
        tracker,s,action,transport,native=armed();tracker.acknowledge_selection(s,action,transport,native)
        with self.assertRaisesRegex(AssertionError,'unchanged progress'):tracker.observe(state(frame=12),22.)
        tracker=followed();tracker.observe(ended(),23.,IDLE)
        with self.assertRaisesRegex(AssertionError,'fixed stage deadline'):tracker.observe(ended(34),39.,IDLE)


if __name__ == '__main__':
    unittest.main()
