"""Adapter controls/budgets only; synthetic states never prove Unity restoration."""
import copy
import importlib.util
import json
from pathlib import Path
import tempfile
import unittest
from unittest.mock import patch

ROOT = Path(__file__).resolve().parents[1]
spec = importlib.util.spec_from_file_location('continue_probe', ROOT / 'tools/probe/diagnose_newgame.py')
probe = importlib.util.module_from_spec(spec)
spec.loader.exec_module(probe)
PREFIX = json.loads((ROOT / 'localization/source/save-continue-20261026/tutorial-prefix.json').read_text())
FIXTURE = json.loads((ROOT / 'localization/source/save-continue-20261026/fixture-binding.json').read_text())


def loaded():
    return dict(company='VNRevivalQA', product='ForestRuRendererProbe',
        dataPath='Y:/Desktop/Forest/localization/probes/ru-20261026-44/game/' + probe.DATA,
        scene='StartMenu', hasSavedPlaySession=True, isChapterSelect=False, isCheatCode=False,
        isFinishingSoftReset=False, gameplay=False, anyEvent=False, conversation=False, playerPresent=False,
        currentArea='CentralForest', lastArea='BunnyHouse', **FIXTURE['playerRespawnData'],
        **FIXTURE['generalData'], introStatus=200, tutorialIntroControllers=0,
        diagnostics=FIXTURE['lastRuntimeTutorialRows'])


def tutorial(entry=153, responses=None):
    text = next(e['text'] for e in PREFIX['entries'] if e['id'] == entry)
    if text.startswith('[pic='):
        text = text.split(']', 1)[1]
    state = dict(conversationActive=True, conversationId=120, entryId=entry,
        narrativeDbName='TutorialQuest_IntroFromBunny', narrativeArcName='',
        conversationState=text, responses=responses or [], typing=False,
        frame=1, realtime=1., scaledTime=1., timeScale=1., scene='CentralForest',
        diagnosticsReady=True, dataServicePresent=True, manifestPresent=True, dataServiceInstance=101, notReady=[])
    return stamp(state)


def stamp(state, **change):
    state = dict(state, **change)
    if state['entryId'] == 158:
        state['tutorialCompletionRecord'] = json.dumps(dict(
            frame=state['frame'], conversationId=120, entryId=158, text=state['conversationState'],
            sourceText='[pic=3]So tell me. What is it you’re here for?',
            panelPath=probe.TUTORIAL_TEXT_PANEL+'/Subtitle Panel 0',buttonPath=probe.TUTORIAL_TEXT_PANEL+'/Continue Button',
            textPath=probe.TUTORIAL_TEXT_PANEL+'/Subtitle Text',targetPath=probe.TUTORIAL_UI,
            listenerMethod='OnFastForward',listenerTargetPath=probe.TUTORIAL_TEXT_PANEL+'/Continue Button',
            sourceDestinations='120:159,120:181',pcDestinations='120:159,120:181',graphVerified=True,
            panelInstance=10,buttonInstance=20,textInstance=30,typing=state['typing'],menuPresent=bool(state['responses']),
            buttonActive=True,buttonEnabled=True,buttonInteractable=True))
    return state


def response(entry):
    text = next(e['text'] for e in PREFIX['entries'] if e['id'] == entry)
    return dict(conversationId=120, entryId=entry,
        path=probe.TUTORIAL_TEXT_PANEL+'/Response Menu Panel/Viewport/Content/Response: '+text,
        targetPath=probe.TUTORIAL_UI,visible=True,clickable=True,text=text)


def ack(action, at=1):
    return dict(command=action, acknowledgement='2026-10-27T00:00:00 OK ' + action,
                transportPid=12345, transportExitCode=0, submittedAt=at, acknowledgedAt=at)


class SaveContinue(unittest.TestCase):
    def setUp(self):
        self.run_patch = patch.object(probe, 'RUN', ROOT / 'localization/probes/ru-20261026-44')
        self.run_patch.start()
        self.addCleanup(self.run_patch.stop)

    def test_new_remains_strict_with_matching_positive_control(self):
        with tempfile.TemporaryDirectory() as tmp:
            game = Path(tmp)
            self.assertIsNone(probe.admit_session(game, game, False))
            (game / 'tfol.savegame').write_text('existing')
            with self.assertRaisesRegex(AssertionError, 'New forbids every'):
                probe.admit_session(game, game, False)

    def test_continue_requires_pinned_fixture(self):
        with tempfile.TemporaryDirectory() as tmp:
            with self.assertRaises(FileNotFoundError):
                probe.admit_session(Path(tmp), Path(tmp), True)

    def test_continue_adapter_admits_only_the_real_exact_fixture(self):
        with tempfile.TemporaryDirectory() as tmp:
            run = Path(tmp)
            fixture = ROOT / 'localization/probes/ru-20261026-43/qa-generated'
            (run / 'qa-fixture').mkdir()
            (run / 'game' / probe.DATA).mkdir(parents=True)
            for name in ['manifest.json', 'tfol.settings', 'tfol.savegame']:
                (run / 'qa-fixture' / name).write_bytes((fixture / name).read_bytes())
                if name != 'manifest.json':
                    (run / 'game' / probe.DATA / name).write_bytes((fixture / name).read_bytes())
            self.assertEqual(probe.admit_session(run / 'game', run, True)['files'], FIXTURE['files'])
            (run / 'game' / 'tfol.extra').write_text('extra')
            with self.assertRaisesRegex(AssertionError, 'player files differ'):
                probe.admit_session(run / 'game', run, True)

    def test_loaded_exact_values_positive_control(self):
        probe.loaded_fixture_guard(loaded(), FIXTURE)

    def test_missing_session_rejected_at_intended_guard(self):
        s = loaded(); s['hasSavedPlaySession'] = False
        with self.assertRaisesRegex(AssertionError, 'saved session not loaded'):
            probe.loaded_fixture_guard(s, FIXTURE)

    def test_loaded_value_rejections(self):
        for key, value, reason in [('currentArea', 'IntroForest', 'saved areas'),
                ('introStatus', 0, 'intro state'), ('storyClock', 0, 'story clock'),
                ('finishedDialogueTutorial', True, 'tutorial completion'),
                ('isChapterSelect', True, 'menu flags')]:
            with self.subTest(key=key):
                s = loaded(); s[key] = value
                with self.assertRaisesRegex(AssertionError, reason):
                    probe.loaded_fixture_guard(s, FIXTURE)

    def test_saved_vector_nonfinite_and_mismatch(self):
        for x in [float('nan'), float('inf'), 6.]:
            s = copy.deepcopy(loaded()); s['lastPosition']['x'] = x
            with self.assertRaisesRegex(AssertionError, 'saved vector'):
                probe.loaded_fixture_guard(s, FIXTURE)

    def test_wrong_tag_or_unplayed_records_rejected(self):
        for row in ['activeTags | values=Tag(Main),Tag(Main Act 1)', FIXTURE['lastRuntimeTutorialRows'][3]]:
            s = loaded(); s['diagnostics'] = [r for r in s['diagnostics'] if r != row]
            with self.assertRaisesRegex(AssertionError, 'Missing or ambiguous|records differ'):
                probe.loaded_fixture_guard(s, FIXTURE)

    def test_continue_control_positive_and_missing_control(self):
        s = dict(loaded(), components=['PlayMenu Canvas/PlayMenu'], buttons=['Canvas/PlayMenu/Controls/Continue'])
        probe.continue_menu_guard(s)
        for buttons in [[], ['Canvas/PlayMenu/Controls/New'], s['buttons'] * 2]:
            with self.assertRaisesRegex(AssertionError, 'Continue control unavailable'):
                probe.continue_menu_guard(dict(s, buttons=buttons))

    def test_source_linear_continue(self):
        for entry in range(153, 158):
            self.assertEqual(probe.tutorial_action(tutorial(entry), PREFIX), 'continue-bound 120 ' + str(entry))

    def test_source_single_response_binding(self):
        s = tutorial(153, [response(154)])
        self.assertEqual(probe.tutorial_action(s, PREFIX), 'response 153 120 154')
        for key, value in [('entryId', 155), ('text', 'wrong meaning'), ('targetPath', '')]:
            bad = copy.deepcopy(s); bad['responses'][0][key] = value
            with self.assertRaisesRegex(AssertionError, 'sole response differs'):
                probe.tutorial_action(bad, PREFIX)

    def test_exact_source_text_and_binding_rejections(self):
        for key, value, reason in [('conversationId', 145, 'conversation'), ('entryId', 159, 'unapproved'),
                ('conversationState', 'wrong', 'exact source'), ('narrativeArcName', 'other', 'binding')]:
            s = tutorial(); s[key] = value
            with self.assertRaisesRegex(AssertionError, reason):
                probe.tutorial_action(s, PREFIX)

    def test_two_choices_stop_without_action(self):
        s = tutorial(158, [response(159), response(181)])
        self.assertEqual(probe.tutorial_action(s, PREFIX), 'target-settled')
        self.assertIsNone(probe.tutorial_action(stamp(s, typing=True), PREFIX))
        self.assertEqual(probe.tutorial_action(tutorial(158), PREFIX),'complete-tutorial158')

    def test_acknowledged_response_allows_only_destination_or_its_source_successor(self):
        for next_entry in [154, 155]:
            with self.subTest(next_entry=next_entry):
                t = probe.TutorialTransitions(PREFIX)
                s = tutorial(153, [response(154)])
                t.observe(s, 1)
                t.acknowledge_response(s, 'response 153 120 154', ack('response 153 120 154'))
                t.observe(dict(tutorial(next_entry), frame=2, realtime=2.), 2)
                self.assertEqual(t.observed, [153, next_entry])
                self.assertEqual(t.responses[0]['destination'], 154)
                self.assertEqual(t.transitions[0]['observed'], next_entry)
                self.assertIsNone(t.pending)

    def test_unacknowledged_skip_and_unrelated_or_backward_states_rejected(self):
        for acknowledged, target, reason in [(False,155,'Unexpected tutorial source transition'),
                (True,156,'Unexpected acknowledged'), (True,153,'Unexpected acknowledged')]:
            t = probe.TutorialTransitions(PREFIX); s = tutorial(153,[response(154)])
            t.observe(s,1)
            if acknowledged:t.acknowledge_response(s,'response 153 120 154',ack('response 153 120 154'))
            with self.subTest(acknowledged=acknowledged,target=target):
                with self.assertRaisesRegex(AssertionError,reason):
                    t.observe(dict(tutorial(target),frame=2,realtime=2.),2)
        t = probe.TutorialTransitions(PREFIX)
        t.observe(tutorial(),1);t.observe(dict(tutorial(154),frame=2),2)
        with self.assertRaisesRegex(AssertionError,'Unexpected tutorial source transition'):
            t.observe(dict(tutorial(),frame=3),3)

    def test_response_missing_wrong_or_stale_ack_never_authorizes_progress(self):
        s=tutorial(153,[response(154)]); action='response 153 120 154'
        for transport, reason in [(None,'Missing exact'),
                (dict(ack(action),command='response 153 120 155'),'Missing exact'),
                (dict(ack(action),transportExitCode=1),'Missing exact'),
                (dict(ack(action),acknowledgement='old OK response 153 120 155'),'Missing exact'),
                (ack(action,0),'Stale response')]:
            with self.subTest(transport=transport):
                t=probe.TutorialTransitions(PREFIX);t.observe(s,1)
                with self.assertRaisesRegex(AssertionError,reason):t.acknowledge_response(s,action,transport)
                self.assertIsNone(t.pending)
                with self.assertRaisesRegex(AssertionError,'Unexpected tutorial source transition'):
                    t.observe(dict(tutorial(155),frame=2),2)
        t=probe.TutorialTransitions(PREFIX);t.observe(s,1)
        with self.assertRaisesRegex(AssertionError,'Stale tutorial action observation'):
            t.acknowledge_response(dict(s,frame=0),action,ack(action))

    def test_response_guard_rejects_wrong_text_destination_replay_and_terminal_action(self):
        action='response 153 120 154'; s=tutorial(153,[response(154)])
        t=probe.TutorialTransitions(PREFIX);t.observe(s,1)
        for key,value in [('text','wrong'),('entryId',155)]:
            bad=copy.deepcopy(s);bad['responses'][0][key]=value
            with self.assertRaisesRegex(AssertionError,'sole response differs'):
                t.acknowledge_response(bad,action,ack(action))
        with self.assertRaisesRegex(AssertionError,'Only an exact sole response'):
            t.acknowledge_response(s,'response 153 120 155',ack('response 153 120 155'))
        t.acknowledge_response(s,action,ack(action))
        with self.assertRaisesRegex(AssertionError,'already acknowledged'):
            t.acknowledge_response(s,action,ack(action))
        terminal=tutorial(158,[response(159),response(181)])
        with self.assertRaisesRegex(AssertionError,'stop before choices'):
            probe.TutorialTransitions(PREFIX).acknowledge_response(terminal,'response 158 120 159',ack('response 158 120 159'))

    def test_response_ack_does_not_renew_budget_or_fabricate_subtitle_coverage(self):
        b=probe.ContinueObservationBudget(0);t=probe.TutorialTransitions(PREFIX)
        s=tutorial(153,[response(154)]);t.observe(s,1);b.observe_continue(1,s,PREFIX)
        t.acknowledge_response(s,'response 153 120 154',ack('response 153 120 154',20))
        self.assertEqual((b.progress_at,b.deadline,t.observed),(1,31,[153]))
        with self.assertRaisesRegex(AssertionError,'forward progress stalled: dialogue'):
            b.check(31)

    def test_exact_consumed45_samples_replay_host_accounting_without_game_relaunch(self):
        rows=json.loads((ROOT/'localization/probes/ru-20261026-45/continue-observations.json').read_text())
        states=[r['intro'] for r in rows if r['intro'] and r['intro']['conversationActive']]
        self.assertEqual([s['frame'] for s in states],[570,629,702])
        t=probe.TutorialTransitions(PREFIX)
        t.observe(states[0],1);t.observe(states[1],2)
        t.acknowledge_response(states[1],'response 153 120 154',ack('response 153 120 154',2))
        t.observe(states[2],3)
        self.assertEqual(t.observed,[153,155])
        self.assertEqual(t.responses[0]['response'][0]['text'],'Much better.')
        self.assertEqual(t.transitions,[dict(source=153,selectedResponse=154,observed=155,frame=702,kind='acknowledged-response')])

    def test_phase46_mocked_command_file_sequence_requires_completion_before_terminal_pair(self):
        # Real46: source153 -> selected154 -> observed155..158, non-typing/no menu.
        # This exercises host commands/files/guards only, never Unity or real pixels.
        sequence=[dict(tutorial(),typing=True),tutorial(153,[response(154)]),
                  tutorial(155),tutorial(156),tutorial(157),
                  tutorial(158),tutorial(158),
                  tutorial(158,[response(159),response(181)]),tutorial(158,[response(159),response(181)])]
        with tempfile.TemporaryDirectory() as tmp:
            run=Path(tmp);(run/'tutorial-prefix.json').write_text(json.dumps(PREFIX))
            ready=dict(loaded(),diagnosticsReady=True,dataServicePresent=True,manifestPresent=True,
                       dataServiceInstance=101,notReady=[])
            menu=dict(ready,components=['PlayMenu Canvas/PlayMenu'],buttons=['Canvas/PlayMenu/Controls/Continue'])
            calls=[];index=0;current=None
            def native(cmd,**kwargs):
                nonlocal index,current
                calls.append(cmd)
                if cmd=='dump-save-continuation':
                    saved=dict(ready)
                    if len(calls)>2:saved.update(scene='CentralForest',playerPresent=True,gameplay=True,
                        playerPath='SpawnedContent/Player/Content/Player(Clone)',playerInstance=100,
                        tutorialIntroControllers=1,playerPosition=FIXTURE['playerRespawnData']['lastPosition'])
                    (run/'save-continuation.json').write_text(json.dumps(saved))
                elif cmd=='dump-intro':
                    current=stamp(sequence[index],frame=570+index*60,realtime=30.+index,
                        responseRecords=[json.dumps(r) for r in sequence[index]['responses']],
                        responseCount=len(sequence[index]['responses']))
                    index+=1;(run/'intro-state.json').write_text(json.dumps(current))
                elif cmd.startswith('continue-bound '):
                    (run/'continue-receipt.json').write_text(json.dumps(dict(result='applied',active=True,
                        expectedConversationId=120,expectedEntryId=current['entryId'],
                        actualConversationId=120,actualEntryId=current['entryId'])))
                elif cmd=='complete-tutorial158':
                    (run/'completion158-receipt.json').write_text(json.dumps(dict(
                        json.loads(current['tutorialCompletionRecord']),result='applied',frame=current['frame']+1)))
                elif cmd.startswith('capture '):(run/cmd[8:]).write_bytes(b'mocked file boundary; no image')
                elif cmd=='dump':(run/'state.json').write_text(json.dumps(current))
                return ack(cmd)
            with patch.object(probe,'RUN',run),patch.object(probe,'command',side_effect=native), \
                 patch.object(probe,'qa_identity'),patch.object(probe.time,'monotonic',return_value=1), \
                 patch.object(probe.time,'sleep'):
                probe.continue_from_fixture(menu,FIXTURE,probe.ContinueObservationBudget(0))
            result=json.loads((run/'continue-progression.json').read_text())
            evidence=result['subtitleAndResponseEvidence']
            self.assertEqual(evidence['observedSubtitleEntries'],[153,155,156,157,158])
            self.assertEqual(evidence['selectedResponses'][0]['destination'],154)
            self.assertEqual(len(result['actualTerminalFrames']),2)
            self.assertEqual(calls.count('response 153 120 154'),1)
            self.assertEqual(calls.count('complete-tutorial158'),1)
            self.assertFalse(any(c=='continue-bound 120 158' for c in calls))
            self.assertEqual(evidence['completion158']['native']['result'],'applied')
            self.assertFalse(any(c.startswith('response 158 ') for c in calls))
            self.assertEqual(result['choicesSubmitted'],0)

    def test_wrong_choice_text_or_set_rejected(self):
        s = tutorial(158, [response(159), response(181)])
        bad = copy.deepcopy(s); bad['responses'][1]['text'] = 'changed'
        with self.assertRaisesRegex(AssertionError, 'choice binding/text'):
            probe.tutorial_action(bad, PREFIX)
        with self.assertRaisesRegex(AssertionError, 'choice set'):
            probe.tutorial_action(tutorial(158, [response(159)]), PREFIX)

    def terminal_observation(self):
        t=probe.TutorialTransitions(PREFIX)
        for frame,eid in enumerate(range(153,159),1):
            s=stamp(tutorial(eid),frame=frame,realtime=float(frame))
            t.observe(s,float(frame))
        return t,s

    def test_terminal_original_control_and_source_matching_rejections(self):
        s=tutorial(158)
        self.assertEqual(probe.tutorial_action(s,PREFIX),'complete-tutorial158')
        for key,value,reason in [('frame',0,'Stale/wrong'),('text','other','Stale/wrong'),
                ('buttonPath','other button','original control'),('panelPath','other panel','original control'),
                ('textPath','other text','original control'),('listenerMethod','SelectResponse','original control'),
                ('listenerTargetPath','other target','original control'),('buttonInstance',0,'identity missing'),
                ('pcDestinations','120:159','native destinations'),('sourceDestinations','120:181','native destinations'),
                ('graphVerified',False,'native destinations'),('buttonActive',False,'Continue unavailable'),
                ('buttonEnabled',False,'Continue unavailable'),('buttonInteractable',False,'Continue unavailable'),
                ('menuPresent',True,'menu disagreement'),('typing',True,'menu disagreement')]:
            bad=copy.deepcopy(s);row=json.loads(bad['tutorialCompletionRecord']);row[key]=value
            bad['tutorialCompletionRecord']=json.dumps(row)
            with self.subTest(key=key),self.assertRaisesRegex(AssertionError,reason):
                probe.tutorial_action(bad,PREFIX)
        for key,value,reason in [('conditions','Variable.other','source conditions'),
                ('text','A different destination','source text/actors'),('actor','2','source text/actors')]:
            bad=copy.deepcopy(PREFIX);next(e for e in bad['entries'] if e['id']==159)[key]=value
            with self.subTest(key=key),self.assertRaisesRegex(AssertionError,reason):
                probe.tutorial_action(s,bad)
        bad=copy.deepcopy(PREFIX);next(e for e in bad['entries'] if e['id']==158)['outgoingLinks'][0]['originDialogueID']=157
        with self.assertRaisesRegex(AssertionError,'source destinations'):
            probe.tutorial_action(s,bad)
        bad=dict(s);bad.pop('tutorialCompletionRecord')
        with self.assertRaisesRegex(AssertionError,'Missing native'):
            probe.tutorial_action(bad,PREFIX)

    def test_terminal_response_controls_are_exact_and_all_must_be_clickable(self):
        s=tutorial(158,[response(159),response(181)])
        self.assertEqual(probe.tutorial_action(s,PREFIX),'target-settled')
        for key,value,reason in [('path','other','binding/text'),('targetPath','other','binding/text'),
                ('visible',False,'not visible/clickable'),('clickable',False,'not visible/clickable'),
                ('conversationId',119,'binding/text'),('entryId',159,'choice set')]:
            bad=copy.deepcopy(s);bad['responses'][1][key]=value
            with self.subTest(key=key),self.assertRaisesRegex(AssertionError,reason):
                probe.tutorial_action(bad,PREFIX)

    def test_terminal_completion_applied_and_menu_race_are_acknowledged_without_choice(self):
        for result in ['applied','menu-present']:
            t,s=self.terminal_observation();action='complete-tutorial158'
            receipt=dict(json.loads(s['tutorialCompletionRecord']),result=result,frame=7,menuPresent=result=='menu-present')
            t.acknowledge_completion(s,action,ack(action,6),receipt)
            self.assertEqual(t.completion['native']['result'],result)
            for frame in [8,9]:t.observe(stamp(tutorial(158,[response(159),response(181)]),frame=frame),frame)
            self.assertEqual(t.observed,[153,154,155,156,157,158])
            self.assertEqual(t.responses,[])
            with self.assertRaisesRegex(AssertionError,'already acknowledged'):
                t.acknowledge_completion(s,action,ack(action,6),receipt)

    def test_terminal_completion_missing_stale_ack_or_receipt_fails_before_credit(self):
        action='complete-tutorial158'
        for transport,change,reason in [(None,{},'Missing exact completion'),
                (dict(ack(action,6),command='continue-bound 120 158'),{},'Missing exact completion'),
                (dict(ack(action,6),transportExitCode=1),{},'Missing exact completion'),
                (dict(ack(action,6),acknowledgement='old OK response 158 120 159'),{},'Missing exact completion'),
                (ack(action,5),{},'Stale completion acknowledgement'),
                (ack(action,6),{'frame':0},'Stale native completion'),
                (ack(action,6),{'buttonInstance':99},'Native completion binding'),
                (ack(action,6),{'text':'wrong'},'Native completion binding'),
                (ack(action,6),{'pcDestinations':'120:159'},'Native completion binding'),
                (ack(action,6),{'result':'stale'},'Missing native completion'),
                (ack(action,6),{'typing':True},'Native completion outcome'),
                (ack(action,6),{'menuPresent':True},'Native completion outcome'),
                (ack(action,6),{'buttonEnabled':False},'Native Continue unavailable')]:
            t,s=self.terminal_observation();receipt=dict(json.loads(s['tutorialCompletionRecord']),result='applied');receipt.update(change)
            with self.subTest(change=change,transport=transport),self.assertRaisesRegex(AssertionError,reason):
                t.acknowledge_completion(s,action,transport,receipt)
            self.assertIsNone(t.completion)
        t,s=self.terminal_observation()
        with self.assertRaisesRegex(AssertionError,'Missing native completion receipt'):
            t.acknowledge_completion(s,action,ack(action,6),None)
        with self.assertRaisesRegex(AssertionError,'Stale Tutorial158 action'):
            t.acknowledge_completion(stamp(s,frame=5),action,ack(action,6),{})

    def test_terminal_choices_and_old_generic_continue_cannot_be_completion(self):
        t,s=self.terminal_observation()
        for action in ['response 158 120 159','response 158 120 181','continue-bound 120 158']:
            with self.subTest(action=action),self.assertRaisesRegex(AssertionError,'no terminal choice'):
                t.acknowledge_completion(s,action,ack(action,6),{})
        for eid in [159,181]:
            with self.assertRaisesRegex(AssertionError,'unapproved tutorial choice'):
                probe.tutorial_action(tutorial(eid),PREFIX)

    def test_completion_ack_and_menu_do_not_renew_idle_or_add_subtitle_ids(self):
        t,s=self.terminal_observation();b=probe.ContinueObservationBudget(0)
        b.observe_continue(6,s,PREFIX);before=(b.started,b.stage_started,b.progress_at,b.deadline)
        receipt=dict(json.loads(s['tutorialCompletionRecord']),result='applied',frame=7)
        t.acknowledge_completion(s,'complete-tutorial158',ack('complete-tutorial158',20),receipt)
        self.assertEqual((b.started,b.stage_started,b.progress_at,b.deadline),before)
        self.assertFalse(b.observe_continue(25,stamp(tutorial(158,[response(159),response(181)]),frame=8,realtime=8.),PREFIX)[1])
        self.assertEqual((b.started,b.stage_started,b.progress_at,b.deadline),before)
        self.assertEqual(t.observed,[153,154,155,156,157,158])
        with self.assertRaisesRegex(AssertionError,'forward progress stalled: dialogue'):b.check(36)

    def test_wrapper_is_passive_and_bounded(self):
        s = dict(tutorial(), conversationId=109, entryId=8, conversationState='')
        self.assertIsNone(probe.tutorial_action(s, PREFIX))
        with self.assertRaisesRegex(AssertionError, 'wrapper content'):
            probe.tutorial_action(dict(s, entryId=9), PREFIX)

    def test_same_real_frame_rejected_and_terminal_needs_pair(self):
        budget = probe.ContinueObservationBudget(0)
        s = tutorial(158, [response(159), response(181)])
        self.assertFalse(budget.observe_continue(1, s, PREFIX)[1])
        with self.assertRaisesRegex(AssertionError, 'new real frame'):
            budget.observe_continue(2, s, PREFIX)
        self.assertTrue(budget.observe_continue(3, stamp(s, frame=2, realtime=2.), PREFIX)[1])

    def test_original_limits_and_clock_ticks_do_not_reset_idle(self):
        self.assertEqual(probe.ContinueObservationBudget.HARD_SECONDS, 360)
        self.assertEqual(probe.ContinueObservationBudget.LIMITS, dict(bootstrap=(120, 60), dialogue=(240, 30), cleanup=(60, 15)))
        b = probe.ContinueObservationBudget(0)
        b.observe_continue(1, tutorial(), PREFIX)
        b.observe_continue(20, dict(tutorial(), frame=2, realtime=2.), PREFIX)
        self.assertEqual(b.progress_at, 1)
        with self.assertRaisesRegex(AssertionError, 'forward progress stalled: dialogue'):
            b.observe_continue(31, dict(tutorial(), frame=3, realtime=3.), PREFIX)


    def test_scalar_readiness_matching_ready_control(self):
        s = tutorial()
        self.assertTrue(probe.continue_diagnostic_ready(s))
        for reason in ['DataManifest.generalData', 'DataManifest.triggersByTriggerName',
                       'quest.Act1_TutorialQuest.primaryArcs', 'GameStateManager.isEventActive']:
            self.assertFalse(probe.continue_diagnostic_ready(dict(s, diagnosticsReady=False, notReady=[reason])))
        self.assertFalse(probe.continue_diagnostic_ready(dict(s, diagnosticsReady=False,
            dataServicePresent=False, manifestPresent=False, dataServiceInstance=0, notReady=['DataService._instance'])))
        self.assertFalse(probe.continue_diagnostic_ready(dict(s, diagnosticsReady=False,
            manifestPresent=False, notReady=['DataService._manifest'])))

    def test_readiness_rejects_inconsistent_and_arbitrary_failures(self):
        for change, reason in [({'diagnosticsReady':False}, 'readiness/list disagree'),
              ({'notReady':['DataManifest.generalData']}, 'readiness/list disagree'),
              ({'diagnosticsReady':False,'notReady':['NullReferenceException']}, 'Unknown not-ready'),
              ({'diagnosticsReady':False,'dataServicePresent':False,'notReady':['DataService._instance']}, 'absent singleton'),
              ({'diagnosticsReady':False,'manifestPresent':False,'notReady':['DataManifest.generalData']}, 'absent manifest'),
              ({'dataServiceInstance':0}, 'service instance identity')]:
            with self.subTest(change=change):
                with self.assertRaisesRegex(AssertionError, reason):
                    probe.continue_diagnostic_ready(dict(tutorial(), **change))

    def test_scalar_wait_never_renews_idle_or_hard_budgets(self):
        b = probe.ContinueObservationBudget(0)
        for now, scene, missing in [(1,'StartMenu','DataService._instance'),
                (20,'SoftResetLoadingScene','DataService._manifest'),
                (59,'ChapterSelect','DataManifest.generalData')]:
            s = dict(tutorial(), frame=now, realtime=float(now), scene=scene,
                     diagnosticsReady=False, notReady=[missing])
            if missing=='DataService._instance':
                s.update(dataServicePresent=False,manifestPresent=False,dataServiceInstance=0)
            elif missing=='DataService._manifest':s.update(manifestPresent=False)
            self.assertEqual(b.observe_not_ready(now,s), (None,False))
            self.assertEqual((b.started,b.stage_started,b.progress_at,b.deadline), (0,0,0,60))
        with self.assertRaisesRegex(AssertionError, 'forward progress stalled: bootstrap'):
            b.observe_not_ready(60,s)
        with self.assertRaisesRegex(AssertionError, 'total hard limit'):
            b.observe_not_ready(360,s)

    def test_not_ready_scene_and_post_dialogue_loss_fail_at_intended_boundaries(self):
        s = dict(tutorial(), diagnosticsReady=False, notReady=['DataManifest.generalData'])
        with self.assertRaisesRegex(AssertionError, 'Unexpected not-ready scene'):
            probe.ContinueObservationBudget(0).observe_not_ready(1,dict(s,scene='BunnyHouse'))
        b = probe.ContinueObservationBudget(0)
        b.observe_continue(1,tutorial(),PREFIX)
        with self.assertRaisesRegex(AssertionError, 'disappeared after tutorial'):
            b.observe_not_ready(2,dict(s,frame=2,realtime=2.))
        with self.assertRaisesRegex(AssertionError, 'Full diagnostic dependencies not ready'):
            probe.ContinueObservationBudget(0).observe_continue(1,s,PREFIX)

    def test_readiness_to_real_dialogue_retains_original_caps_and_frames(self):
        b = probe.ContinueObservationBudget(0)
        s = dict(tutorial(), diagnosticsReady=False, notReady=['DataManifest.generalData'])
        b.observe_not_ready(1,s)
        with self.assertRaisesRegex(AssertionError, 'new real frame'):
            b.observe_continue(2,tutorial(),PREFIX)
        b.observe_continue(3,dict(tutorial(),frame=2,realtime=2.),PREFIX)
        self.assertEqual((b.started,b.stage_started,b.progress_at), (0,3,3))
        self.assertEqual(b.deadline,33)


    def test_observer_skips_intro_after_scalar_save_and_rechecks_intro_readiness(self):
        # Mock command/file transport and identity only; actual adapter/budget/fixture
        # guards execute. This cannot establish Unity lifecycle or deserialization.
        ready = dict(loaded(), diagnosticsReady=True, dataServicePresent=True,
                     manifestPresent=True, dataServiceInstance=101, notReady=[])
        menu = dict(ready, components=['PlayMenu Canvas/PlayMenu'], buttons=['Canvas/PlayMenu/Controls/Continue'])
        for transitional in [False, True]:
            with self.subTest(transitional=transitional), tempfile.TemporaryDirectory() as tmp:
                run = Path(tmp); (run/'tutorial-prefix.json').write_text(json.dumps(PREFIX))
                calls=[]; save_count=0; intro_count=0
                def native(cmd, **kwargs):
                    nonlocal save_count, intro_count
                    calls.append(cmd)
                    if cmd=='dump-save-continuation':
                        save_count+=1
                        sample=dict(ready)
                        if transitional and save_count==2:
                            sample.update(diagnosticsReady=False,dataServicePresent=False,manifestPresent=False,
                                dataServiceInstance=0,notReady=['DataService._instance'],frame=1,realtime=1.,scaledTime=1.,timeScale=1.)
                        (run/'save-continuation.json').write_text(json.dumps(sample))
                    if cmd=='dump-intro':
                        intro_count+=1
                        if not transitional or intro_count==2:raise RuntimeError('stop at ready intro boundary')
                        (run/'intro-state.json').write_text(json.dumps(dict(tutorial(),diagnosticsReady=False,
                            notReady=['DataManifest.generalData'],frame=2,realtime=2.,responseRecords=[],responseCount=0)))
                with patch.object(probe,'RUN',run), patch.object(probe,'command',side_effect=native), \
                     patch.object(probe,'qa_identity'), patch.object(probe.time,'monotonic',return_value=1), \
                     patch.object(probe.time,'sleep'):
                    with self.assertRaisesRegex(RuntimeError,'stop at ready intro boundary'):
                        probe.continue_from_fixture(menu,FIXTURE,probe.ContinueObservationBudget(0))
                if transitional:
                    self.assertEqual(calls, ['dump-save-continuation','menu PlayMenu OnClickContinue',
                        'dump-save-continuation','dump-save-continuation','dump-intro','dump-save-continuation','dump-intro'])
                    rows=json.loads((run/'continue-observations.json').read_text())
                    self.assertEqual(len(rows),2)
                    self.assertTrue(all(row['action'] is None and row['budget']['idle']==1 for row in rows))
                else:
                    self.assertEqual(calls,['dump-save-continuation','menu PlayMenu OnClickContinue','dump-save-continuation','dump-intro'])


if __name__ == '__main__':
    unittest.main()
