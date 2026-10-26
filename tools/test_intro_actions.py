"""Source-bound action guards only; real response delivery is a separate runtime check."""
import copy
import importlib.util
import json
from pathlib import Path
import unittest

ROOT = Path(__file__).resolve().parents[1]
spec = importlib.util.spec_from_file_location('intro', ROOT / 'tools/probe/diagnose_newgame.py')
intro = importlib.util.module_from_spec(spec)
spec.loader.exec_module(intro)
GRAPH = json.loads((ROOT / 'localization/source/intro-20261026/intro-graph.json').read_text())


def state(entry=205):
    return dict(conversationActive=True, conversationId=145, entryId=entry,
                narrativeDbName='NewGame_Intro', narrativeArcName='bunny_says_hello',
                conversationState='How are ya feeling?', responses=[])


class IntroActions(unittest.TestCase):
    def test_response_transport_requires_complete_serialized_records(self):
        s = dict(responseCount=0, responseRecords=[])
        self.assertEqual(intro.decode_state(s)['responses'], [])
        r = dict(path='Original/Response', text='I’m ok.', targetPath='Original/Menu',
                 conversationId=145, entryId=206, visible=True, clickable=True)
        self.assertEqual(intro.decode_state(dict(responseCount=1, responseRecords=[json.dumps(r)]))['responses'], [r])
        with self.assertRaisesRegex(AssertionError, 'serialization missing'):
            intro.decode_state(dict(responseCount=0))
        with self.assertRaisesRegex(AssertionError, 'Incomplete bridge response readback'):
            intro.decode_state(dict(responseCount=1, responseRecords=[]))
        del r['targetPath']
        with self.assertRaisesRegex(AssertionError, 'Incomplete response row'):
            intro.decode_state(dict(responseCount=1, responseRecords=[json.dumps(r)]))

    def test_normal_continue_and_exact_original_response(self):
        s = state()
        self.assertEqual(intro.intro_action(s, GRAPH), 'continue')
        s['responses'] = [dict(conversationId=145, entryId=206, visible=True,
                               clickable=True, targetPath='Original/ResponseMenu')]
        self.assertEqual(intro.intro_action(s, GRAPH), 'response 205 145 206')
        s['responses'][0]['entryId'] = 207
        with self.assertRaisesRegex(AssertionError, 'Response differs from source successor'):
            intro.intro_action(s, GRAPH)

    def test_response_branch_and_hidden_stale_response(self):
        s = state()
        r = dict(conversationId=145, entryId=206, visible=True, clickable=True, targetPath='Original/Menu')
        s['responses'] = [r, copy.copy(r)]
        with self.assertRaisesRegex(AssertionError, 'Stop at response branch'):
            intro.intro_action(s, GRAPH)
        s['responses'][1]['visible'] = False
        self.assertEqual(intro.intro_action(s, GRAPH), 'response 205 145 206')
        s['responses'][0]['targetPath'] = ''
        with self.assertRaisesRegex(AssertionError, 'Unexpected response target'):
            intro.intro_action(s, GRAPH)

    def test_original_branch_holds(self):
        graph = copy.deepcopy(GRAPH)
        e = next(e for e in graph['entries'] if e['id'] == 205)
        e['outgoingLinks'].append(copy.copy(e['outgoingLinks'][0]))
        with self.assertRaisesRegex(AssertionError, 'Stop at original branching dialogue'):
            intro.intro_action(state(), graph)

    def test_wrapper_waits_and_rejects_each_unexpected_identity(self):
        for entry in [0, 5, 8]:
            s = state(entry)
            s.update(conversationId=109, conversationState='')
            self.assertIsNone(intro.intro_action(s, GRAPH))
        for field, value, reason in [
            ('entryId', 9, 'Unexpected wrapper content'),
            ('conversationState', 'visible', 'Wrapper contains visible dialogue'),
            ('narrativeDbName', 'OtherStory', 'Wrapper belongs to another story'),
            ('narrativeArcName', 'other_arc', 'Unexpected intro arc'),
        ]:
            s = state(0)
            s.update(conversationId=109, conversationState='')
            s[field] = value
            with self.assertRaisesRegex(AssertionError, reason):
                intro.intro_action(s, GRAPH)

    def test_empty_metadata_and_inactive_wait_but_unknown_conversation_holds(self):
        empty = next(e['id'] for e in GRAPH['entries']
                     if not next(f['value'] for f in e['fields'] if f['title'] == 'Dialogue Text')
                     and len(e['outgoingLinks']) <= 1)
        self.assertIsNone(intro.intro_action(state(empty), GRAPH))
        # Original145:188 fans out to six named arc roots. It is metadata,
        # so waiting must precede the visible-content single-successor guard.
        self.assertIsNone(intro.intro_action(state(188), GRAPH))
        s = state()
        s['conversationActive'] = False
        self.assertIsNone(intro.intro_action(s, GRAPH))
        s.update(conversationActive=True, conversationId=225)
        with self.assertRaisesRegex(AssertionError, 'Stop at unexpected dialogue'):
            intro.intro_action(s, GRAPH)


if __name__ == '__main__':
    unittest.main()
