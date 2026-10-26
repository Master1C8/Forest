"""Explicit admission/host guards; mocked states do not prove Unity rendering."""
import copy
import importlib.util
import json
from pathlib import Path
import tempfile
import unittest
import sys
from unittest.mock import patch

sys.path.insert(0, str(Path(__file__).resolve().parent))
from test_save_continue import PREFIX, tutorial, response, stamp, probe
from legacy_choice_font import CHOICE_SAMPLES
spec = importlib.util.spec_from_file_location('prepare_bridge', Path(__file__).parent / 'probe/prepare_bridge.py')
prepare = importlib.util.module_from_spec(spec); spec.loader.exec_module(prepare)


def synthetic():
    rows = [response(159), response(181)]
    for r in rows:
        r['text'] = probe.SYNTHETIC_CHOICES[r['entryId']]
        r['path'] = probe.TUTORIAL_TEXT_PANEL + '/Response Menu Panel/Viewport/Content/Response: ' + r['text']
    s = tutorial(158, rows)
    record = json.loads(s['tutorialCompletionRecord']); record['choiceMode'] = 'synthetic'
    s['tutorialCompletionRecord'] = json.dumps(record)
    s['rendererDiagnostics'] = [r['path'] + '/Response Text | UnityEngine.UI.Text | ' + r['text'] +
        ' | font=MatchupPro_TFOL | size=12 | style=Normal | fontNames=Liberation Sans | dynamic=True' +
        ''.join(' | '+k+'=True' for k in ['hasYo','hasShortI','hasDigit1','hasSpace','hasDiaeresis','hasBreve']) for r in rows]
    return s


class SyntheticChoices(unittest.TestCase):
    def test_values_identical_to_frozen_resource_recipe(self):
        self.assertEqual({str(k):v for k,v in probe.SYNTHETIC_CHOICES.items()}, CHOICE_SAMPLES)

    def test_mode_requires_continue_and_new_default_is_original(self):
        self.assertEqual(probe.launch_options(['unused']).tutorial_choice_mode, 'original')
        with self.assertRaisesRegex(AssertionError, 'require exact QA43'):
            probe.launch_options(['unused','--tutorial-choice-mode','synthetic'])
        self.assertEqual(probe.launch_options(['unused','--continue-fixture','--tutorial-choice-mode','synthetic']).tutorial_choice_mode, 'synthetic')

    def test_each_complete_mode_positive_and_cross_mode_negative(self):
        original = tutorial(158,[response(159),response(181)])
        self.assertEqual(probe.tutorial_action(original,PREFIX),'target-settled')
        s = synthetic()
        self.assertEqual(probe.tutorial_action(s,PREFIX,'synthetic'),'target-settled')
        probe.choice_renderer_guard(s,PREFIX,'synthetic')
        for state, mode in [(s,'original'),(original,'synthetic')]:
            with self.assertRaisesRegex(AssertionError, 'choice mode differs'):
                probe.tutorial_action(state,PREFIX,mode)
        with self.assertRaisesRegex(AssertionError,'Unknown tutorial choice mode'):
            probe.tutorial_action(s,PREFIX,'auto')

    def test_wrong_text_and_mixed_pair_reject_at_text_guard(self):
        for eid in [159,181]:
            for wrong in ['other',response(eid)['text']]:
                s=synthetic();row=next(r for r in s['responses'] if r['entryId']==eid)
                row['path']=row['path'].replace(row['text'],wrong);row['text']=wrong
                with self.subTest(eid=eid,wrong=wrong),self.assertRaisesRegex(AssertionError,'choice binding/text'):
                    probe.tutorial_action(s,PREFIX,'synthetic')

    def test_synthetic_still_rejects_source_identity_and_control(self):
        for change,reason in [({'narrativeDbName':'other'},'narrative binding'),({'conversationId':119},'tutorial conversation')]:
            with self.assertRaisesRegex(AssertionError,reason):
                probe.tutorial_action(dict(synthetic(),**change),PREFIX,'synthetic')
        for key,value,reason in [('listenerMethod','Invoke','original control'),('buttonInstance',0,'control identity')]:
            s=synthetic();r=json.loads(s['tutorialCompletionRecord']);r[key]=value;s['tutorialCompletionRecord']=json.dumps(r)
            with self.assertRaisesRegex(AssertionError,reason):probe.tutorial_action(s,PREFIX,'synthetic')
        p=copy.deepcopy(PREFIX);next(e for e in p['entries'] if e['id']==159)['actor']='2'
        with self.assertRaisesRegex(AssertionError,'source text/actors'):probe.tutorial_action(synthetic(),p,'synthetic')
        s=synthetic();s['responses'][0]['targetPath']='other'
        with self.assertRaisesRegex(AssertionError,'choice binding/text'):probe.tutorial_action(s,PREFIX,'synthetic')

    def test_synthetic_completion_and_selection_stop(self):
        s=synthetic();s['responses']=[];r=json.loads(s['tutorialCompletionRecord']);r['menuPresent']=False;s['tutorialCompletionRecord']=json.dumps(r)
        self.assertEqual(probe.tutorial_action(s,PREFIX,'synthetic'),'complete-tutorial158')
        t=probe.TutorialTransitions(PREFIX,'synthetic')
        self.assertEqual(t.choice_mode,'synthetic')
        for eid in [159,181]:
            with self.assertRaisesRegex(AssertionError,'unapproved tutorial choice'):
                probe.tutorial_action(dict(synthetic(),entryId=eid),PREFIX,'synthetic')

    def test_renderer_checks_each_real_label_face_and_character(self):
        s=synthetic();probe.choice_renderer_guard(s,PREFIX,'synthetic')
        for old,new,reason in [('MatchupPro_TFOL','ManaSpace','font/face'),('Liberation Sans','other','font/face'),
                ('dynamic=True','dynamic=False','font/face'),('hasSpace=True','hasSpace=False','individual glyph'),
                ('hasBreve=True','hasBreve=False','individual glyph')]:
            bad=copy.deepcopy(s);bad['rendererDiagnostics'][0]=bad['rendererDiagnostics'][0].replace(old,new)
            with self.subTest(old=old),self.assertRaisesRegex(AssertionError,reason):probe.choice_renderer_guard(bad,PREFIX,'synthetic')

    def test_resource_mode_admission_exact_positive_and_negatives(self):
        with tempfile.TemporaryDirectory() as tmp:
            run=Path(tmp)
            build={'sampleSurface':'tutorial-choices','coherentChoiceFace':True,'choiceSamples':CHOICE_SAMPLES}
            def write(mode='synthetic'):
                (run/'build.json').write_text(json.dumps(build));(run/'bridge-build.json').write_text(json.dumps({'tutorialChoiceMode':mode}))
            write();probe.admit_choice_mode(run,'synthetic')
            with self.assertRaisesRegex(AssertionError,'Compiled tutorial choice mode'):probe.admit_choice_mode(run,'original')
            write('original')
            with self.assertRaisesRegex(AssertionError,'Original mode forbids'):probe.admit_choice_mode(run,'original')
            with self.assertRaisesRegex(AssertionError,'Original mode forbids'):prepare.choice_mode_admission(run,build,'original')
            build['choiceSamples']=dict(CHOICE_SAMPLES,**{'159':'wrong'});write()
            with self.assertRaisesRegex(AssertionError,'resource values differ'):probe.admit_choice_mode(run,'synthetic')
            with self.assertRaisesRegex(AssertionError,'resource values differ'):prepare.choice_mode_admission(run,build,'synthetic')
            build={'choiceSamples':{}};write('original');probe.admit_choice_mode(run,'original');prepare.choice_mode_admission(run,build,'original')

if __name__ == '__main__': unittest.main()
