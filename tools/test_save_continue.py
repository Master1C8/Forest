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
        frame=1, realtime=1., scaledTime=1., timeScale=1., scene='CentralForest')


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


if __name__ == '__main__':
    unittest.main()
