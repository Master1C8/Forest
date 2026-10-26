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
    def test_loaded_geometry_requires_real_scene_owned_body_and_pair_rows(self):
        rows = [
            'travelGuards | gameplay=True | anyEvent=False | conversation=False | axis=0,0,0',
            'travelPlayer | id=10 | path=Spawned/Player | active=True | enabled=True',
            'travelBody | id=11 | owner=10 | path=Spawned/Player',
            'travelBody | id=13 | owner=10 | path=Spawned/Player/PlayerFootSensor',
            'travelDoor | id=20 | path=Spawned/Environment/Content/Environment/Doorways/DoorwayToCentralForest | scene=BunnyHouse | destination=CentralForest',
            'travelCollider | id=12 | owner=10 | path=Spawned/Player | tag=Player | rigidbody=Spawned/Player#11',
            'travelCollider | id=14 | owner=10 | path=Spawned/Player/PlayerFootSensor | tag=Untagged | rigidbody=Spawned/Player/PlayerFootSensor#13',
            'travelCollider | id=21 | owner=20',
            'travelPair | playerCollider=12 | doorCollider=21',
        ]
        self.assertEqual(intro.loaded_travel(dict(scene='BunnyHouse', diagnostics=rows))['body']['id'], '11')
        with self.assertRaisesRegex(AssertionError, 'requires BunnyHouse'):
            intro.loaded_travel(dict(scene='StartMenu', diagnostics=rows))
        wrong_body = [r.replace('id=11 | owner=10', 'id=11 | owner=99') for r in rows]
        with self.assertRaisesRegex(AssertionError, 'Body does not belong'):
            intro.loaded_travel(dict(scene='BunnyHouse', diagnostics=wrong_body))
        with self.assertRaisesRegex(AssertionError, 'Missing actual enabled collider-pair'):
            intro.loaded_travel(dict(scene='BunnyHouse', diagnostics=rows[:-1]))
        with self.assertRaisesRegex(AssertionError, 'requires guarded idle gameplay'):
            intro.loaded_travel(dict(scene='BunnyHouse', diagnostics=[r.replace('axis=0,0,0', 'axis=-1,0,0') for r in rows]))

    def test_final_content_and_free_flags_do_not_replace_original_cleanup(self):
        s = dict(scene='BunnyHouse', conversationActive=False)
        guards = 'guards | gameplay=True | dustin=False | glitch=False | anyEvent=False | notebookLearned=False'
        cleanup = 'introCleanup | remainingControllers=0 | bedControllers=1 | activeBedControllers=1'
        trigger = 'trigger | name=Cutscene_IntroBunnyHouse | count=1'
        self.assertTrue(intro.intro_complete(s, guards, {249}, [cleanup, trigger]))
        for old, new in [('remainingControllers=0', 'remainingControllers=1'),
                         ('bedControllers=1', 'bedControllers=0'),
                         ('activeBedControllers=1', 'activeBedControllers=0')]:
            self.assertFalse(intro.intro_complete(s, guards, {249}, [cleanup.replace(old, new), trigger]))
        for count in ['absent', '0']:
            self.assertFalse(intro.intro_complete(s, guards, {249}, [cleanup, trigger.replace('count=1', 'count='+count)]))
        self.assertFalse(intro.intro_complete(s, guards, set(), [cleanup, trigger]))
        self.assertFalse(intro.intro_complete(s, guards.replace('anyEvent=False', 'anyEvent=True'), {249}, [cleanup, trigger]))
        with self.assertRaisesRegex(AssertionError, 'Missing or ambiguous diagnostic: introCleanup'):
            intro.intro_complete(s, guards, {249}, [trigger])
        with self.assertRaisesRegex(AssertionError, 'Missing or ambiguous diagnostic: introCleanup'):
            intro.intro_complete(s, guards, {249}, [cleanup, cleanup, trigger])

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
        self.assertEqual(intro.intro_action(s, GRAPH), 'continue-bound 145 205')
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

    def test_bound_continue_receipt_distinguishes_dispatch_from_original_progression(self):
        s = state(259)
        receipt = dict(expectedConversationId=145, expectedEntryId=259,
                       actualConversationId=145, actualEntryId=259, active=True, result='applied')
        self.assertEqual(intro.continue_outcome(s, receipt), 'applied')
        for actual, active in [(259, False), (260, True)]:
            stale = dict(receipt, actualEntryId=actual, active=active, result='stale')
            self.assertEqual(intro.continue_outcome(s, stale), 'stale')
            with self.assertRaisesRegex(AssertionError, 'Inconsistent game-thread'):
                intro.continue_outcome(s, dict(stale, result='applied'))
        with self.assertRaisesRegex(AssertionError, 'does not match submission'):
            intro.continue_outcome(s, dict(receipt, expectedEntryId=260))

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
