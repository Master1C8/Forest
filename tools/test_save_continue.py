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
    return dict(conversationActive=True, conversationId=120, entryId=entry,
        narrativeDbName='TutorialQuest_IntroFromBunny', narrativeArcName='',
        conversationState=text, responses=responses or [], typing=False,
        frame=1, realtime=1., scaledTime=1., timeScale=1., scene='CentralForest',
        diagnosticsReady=True, dataServicePresent=True, manifestPresent=True, dataServiceInstance=101, notReady=[])


def response(entry):
    return dict(conversationId=120, entryId=entry, targetPath='original-target',
        visible=True, clickable=True, text=next(e['text'] for e in PREFIX['entries'] if e['id'] == entry))


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
        self.assertIsNone(probe.tutorial_action(dict(s, typing=True), PREFIX))
        self.assertIsNone(probe.tutorial_action(tutorial(158), PREFIX))

    def test_wrong_choice_text_or_set_rejected(self):
        s = tutorial(158, [response(159), response(181)])
        bad = copy.deepcopy(s); bad['responses'][1]['text'] = 'changed'
        with self.assertRaisesRegex(AssertionError, 'choice binding/text'):
            probe.tutorial_action(bad, PREFIX)
        with self.assertRaisesRegex(AssertionError, 'choice set'):
            probe.tutorial_action(tutorial(158, [response(159)]), PREFIX)

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
        self.assertTrue(budget.observe_continue(3, dict(s, frame=2, realtime=2.), PREFIX)[1])

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
