"""Host admission fixtures replace Unity/physics; never native runtime proof.

The bridge is separately compiled/read back against original managed assemblies.
No test posts a keyboard event, evaluates an oracle or launches a game.
"""
import copy
import json
from pathlib import Path
import sys
import unittest
from unittest.mock import patch

sys.path.insert(0, str(Path(__file__).resolve().parent))
import test_native_input as native_test
from test_native_input import gameplay as probe

ROOT = Path(__file__).resolve().parents[1]


def fixture():
    actor, player = probe.BUCKY_ACTOR, probe.BUCKY_PLAYER
    def component(path, typename, identity, **fields):
        return dict(path=path, type='TheForestOfLove.'+typename, id=str(identity), active='True', enabled='True', **fields)
    rows = dict(guards=dict(gameplay='True', anyEvent='False', conversation='False'),
        actor=component(actor, 'Gameplay.CritterActor', 11, gameObject='12', dbName='Bucky'),
        controller=component(actor+'/Interaction/InteractionUiController', 'InteractionUiController', 21,
            gameObject='22', authorityId='22', touching='True', available='Talk', disallowed=''),
        trigger=component(actor+'/Interaction/DialogueTrigger', 'Interaction.DialogueInteractionTrigger', 31,
            gameObject='32', authorityId='32', touching='True', mode='0', triggered='False', cooldown='0',
            blocked='False', onCollision='False', withoutUi='False', namedTrigger='', maxTimes='0'),
        settings=component(actor+'/Interaction/DialogueTrigger', 'DialogueSettings', 41,
            actor='Bucky', dialogue='- Untagged -', arc=''),
        ui=component('Gameplay UI/Interaction UI', 'InteractionUi', 51, activeCount='1', visible='True',
            locked='True', selected='0', available='Talk'),
        bindings=dict.fromkeys(['actor', 'listener', 'actorParent', 'settingsObject', 'controllerDescendant',
            'triggerDescendant', 'listenerDescendant'], 'True'),
        collision=component(actor+'/Interaction/InteractionArea', 'CollisionEventListener', 61,
            collider='62', colliderType='UnityEngine.CapsuleCollider2D', colliderCount='1', colliderEnabled='True',
            isTrigger='True', size='1,0.6,0', offset='0,0.21,0', scale='1,1,1', rootTouch='True', ignoredPair='False'),
        player=component(player, 'Player', 71, body='72', rootCollider='73', canInteract='True', bodyType='Dynamic',
            bodySimulated='True', rootColliderEnabled='True', rootIsTrigger='False', rootTag='Player', velocity='0,0,0'))
    controller_callback = actor+'/Interaction/InteractionUiController#21::TheForestOfLove.InteractionUiController::'
    trigger_callback = actor+'/Interaction/DialogueTrigger#31::TheForestOfLove.Interaction.DialogueInteractionTrigger::'
    rows['ui']['callbacks'] = controller_callback+'OnInterationOptionSelected'
    for key, suffix, include_trigger in [('enter', 'OnTriggerEnter2D', True), ('stay', 'OnTriggerStay2D', False), ('exit', 'OnTriggerExit2D', True)]:
        callbacks = [controller_callback+suffix] + ([trigger_callback+suffix] if include_trigger else [])
        rows[key] = dict(persistent='0', callbacks=','.join(sorted(callbacks)))
    identity = dict(company='VNRevivalQA', product='ForestRuRendererProbe',
        dataPath='Y:/Desktop/Forest/localization/probes/unit-bucky/game/'+probe.DATA,
        persistentDataPath='C:/QA/VNRevivalQA/ForestRuRendererProbe', scene='CentralForest')
    sample = dict(identity, frame=100, realtime=2., choiceMode='original')
    state = dict(identity, frame=101, realtime=2.1, diagnosticsReady=True, dataServicePresent=True,
        manifestPresent=True, dataServiceInstance=99, notReady=[], conversationActive=False,
        responses=[], narrativeDbName='', narrativeArcName='')
    return sample, state, rows


def encode(sample, rows):
    return dict(sample, diagnostics=['bucky'+key.title()+' | '+' | '.join(k+'='+v for k, v in row.items()) for key, row in rows.items()])


def keyboard_fixture():
    row = native_test.NativeReleaseObservation().eligibility_fixture()
    maps = json.loads(row['keyboardMaps'])['maps']
    source = json.loads((ROOT/'localization/source/tutorial-20261026/phase0058/original/input-bindings.json').read_text())
    for actual, original in zip(maps, source['keyboardMaps']):
        actual['submit'] = [dict(action=b['_actionId'], key=b['_keyboardKeyCode'], type=b['_elementType'],
            range=b['_axisRange'], pole=b['_axisContribution'], modifier1=b['_modifierKey1'], modifier2=b['_modifierKey2'],
            modifier3=b['_modifierKey3'], invert=bool(b['_invert']), enabled=True)
            for b in original['actionElementMaps'] if b['_actionId'] in [2, 18]]
    row['keyboardMaps'] = json.dumps(dict(maps=maps))
    for layer in ['native', 'async', 'rewired', 'unity']:
        row[layer+'SubmitUp'] = 'True'
        row[layer+'SubmitDown'] = ''
    row.update(rewiredAction2Held='False', rewiredAction2Down='False', helperSubmitDown='False', unityReturnDown='False',
        actionAxes='0,0,0', fullAxis='0,0,0', bodyVelocity='0,0,0')
    return row


class BuckyAdmission(unittest.TestCase):
    def setUp(self):
        self.run = patch.object(probe, 'RUN', Path('/unit-bucky'))
        self.run.start()
        self.addCleanup(self.run.stop)

    def test_original_locked_positive_and_wrong_actor_type_bindings_rejected(self):
        sample, state, rows = fixture()
        admitted = probe.bucky_interaction_guard(encode(sample, rows), state)
        self.assertEqual(admitted['ui']['locked'], 'True')
        for component, key, value, reason in [('actor', 'dbName', 'Scarlett', 'actor differs'),
                ('actor', 'type', 'TheForestOfLove.Gameplay.SpawnableActor', 'type/path'),
                ('controller', 'type', 'Other.Controller', 'type/path'), ('trigger', 'type', 'Other.Trigger', 'type/path'),
                ('bindings', 'actor', 'False', 'bindings'), ('bindings', 'listener', 'False', 'bindings'),
                ('bindings', 'settingsObject', 'False', 'bindings'), ('bindings', 'actorParent', 'False', 'bindings')]:
            bad = copy.deepcopy(rows); bad[component][key] = value
            with self.subTest(component=component, key=key), self.assertRaisesRegex(AssertionError, reason):
                probe.bucky_interaction_guard(encode(sample, bad), state)

    def test_authority_gameobject_not_component_and_both_natural_touches(self):
        sample, state, rows = fixture()
        probe.bucky_interaction_guard(encode(sample, rows), state)
        for component in ['controller', 'trigger']:
            for key, value, reason in [('authorityId', rows[component]['id'], 'GameObject authority'),
                    ('authorityId', '999', 'GameObject authority'), ('touching', 'False', 'natural touch')]:
                bad = copy.deepcopy(rows); bad[component][key] = value
                with self.subTest(component=component, key=key, value=value), self.assertRaisesRegex(AssertionError, reason):
                    probe.bucky_interaction_guard(encode(sample, bad), state)

    def test_cached_talk_alone_cannot_admit_mode_ui_listener_or_contact(self):
        sample, state, rows = fixture()
        probe.bucky_interaction_guard(encode(sample, rows), state)
        for component, key, value, reason in [('trigger', 'mode', '1', 'ordinary guards'),
                ('trigger', 'triggered', 'True', 'ordinary guards'), ('trigger', 'cooldown', '1', 'ordinary guards'),
                ('trigger', 'blocked', 'True', 'ordinary guards'), ('trigger', 'withoutUi', 'True', 'ordinary guards'),
                ('controller', 'disallowed', 'Talk', 'unavailable/disallowed'), ('controller', 'available', '', 'unavailable/disallowed'),
                ('ui', 'locked', 'False', 'shared UI'), ('ui', 'selected', '1', 'shared UI'), ('ui', 'visible', 'False', 'shared UI'),
                ('ui', 'callbacks', 'wrong', 'option listener'), ('enter', 'callbacks', '', 'collision listener'),
                ('exit', 'persistent', '1', 'collision listener'), ('collision', 'rootTouch', 'False', 'collider/contact'),
                ('collision', 'ignoredPair', 'True', 'collider/contact'), ('collision', 'scale', '2,1,1', 'geometry'),
                ('player', 'canInteract', 'False', 'not idle/eligible'), ('settings', 'dialogue', 'TutorialQuest_BeaverIntroduction', 'inferred settings')]:
            bad = copy.deepcopy(rows); bad[component][key] = value
            with self.subTest(component=component, key=key), self.assertRaisesRegex(AssertionError, reason):
                probe.bucky_interaction_guard(encode(sample, bad), state)

    def test_mode_scene_freshness_event_and_original_dependency_guard(self):
        sample, state, rows = fixture()
        for bad_sample, bad_state, reason in [(dict(sample, choiceMode='synthetic'), state, 'original mode'),
                (dict(sample, frame=0), state, 'Stale Bucky frame'), (dict(sample, frame=102), state, 'Stale Bucky frame'),
                (sample, dict(state, frame=221), 'Stale Bucky frame'), (sample, dict(state, realtime=4.01), 'Stale Bucky time'),
                (sample, dict(state, realtime=float('nan')), 'Stale Bucky time'), (sample, dict(state, scene='BunnyHouse'), 'scene differs'),
                (sample, dict(state, conversationActive=True), 'already active'),
                (sample, dict(state, diagnosticsReady=False, notReady=['DataService._manifest']), 'Inconsistent present manifest')]:
            with self.subTest(reason=reason), self.assertRaisesRegex(AssertionError, reason):
                probe.bucky_interaction_guard(encode(bad_sample, rows), bad_state)
        bad = copy.deepcopy(rows); bad['guards']['anyEvent'] = 'True'
        with self.assertRaisesRegex(AssertionError, 'gameplay/event guards'):
            probe.bucky_interaction_guard(encode(sample, bad), state)
        duplicate = encode(sample, rows); duplicate['diagnostics'].append(duplicate['diagnostics'][0])
        with self.assertRaisesRegex(AssertionError, 'ambiguous diagnostic'):
            probe.bucky_interaction_guard(duplicate, state)

    def test_submit_map_is_gameplay2_and_not_menu18(self):
        row = keyboard_fixture()
        probe.bucky_submit_map_guard(row)
        for change, reason in [('action', 'bindings differ'), ('key', 'bindings differ'), ('duplicate', 'bindings differ'),
                ('modifier', 'flags differ'), ('disabled', 'flags differ')]:
            maps = json.loads(row['keyboardMaps']); b = maps['maps'][0]['submit'][0]
            if change == 'action': b['action'] = 18
            elif change == 'key': b['key'] = 0
            elif change == 'duplicate': maps['maps'][0]['submit'].append(copy.deepcopy(b))
            elif change == 'modifier': b['modifier1'] = 1
            else: b['enabled'] = False
            with self.subTest(change=change), self.assertRaisesRegex(AssertionError, reason):
                probe.bucky_submit_map_guard(dict(row, keyboardMaps=json.dumps(maps)))
        with self.assertRaisesRegex(AssertionError, 'Original keyboard eligibility'):
            probe.bucky_submit_map_guard(dict(row, focused='False'))

    def test_all_layers_all_keys_action2_and_axes_required_after_release(self):
        row = keyboard_fixture()
        self.assertTrue(probe.bucky_input_released(row))
        for key, value in [(layer+suffix, value) for layer in ['native', 'async', 'rewired', 'unity']
                for suffix, value in [('SubmitUp', 'False'), ('SubmitDown', 'Return'), ('MovementUp', 'False'), ('MovementDown', 'D')]] + [
                ('helperSubmitDown', 'True'), ('rewiredAction2Held', 'True'), ('rewiredAction2Down', 'True'),
                ('unityReturnDown', 'True'), ('actionAxes', '1,0,0'), ('fullAxis', '0,-1,0'), ('bodyVelocity', '0.1,0,0')]:
            with self.subTest(key=key): self.assertFalse(probe.bucky_input_released(dict(row, **{key: value})))

    def test_task_down_receipt_requires_same_mode_pid_window_for_new_actions(self):
        identity = dict(pid=12, windowID=34)
        for action in ['right', 'return']:
            stdout = json.dumps(dict(identity, mode=action))+'\npost'+action.title()+'Down pid=12 window=34 unixTime=1\n'
            self.assertTrue(probe.posted_task_down(stdout, action, identity))
            self.assertFalse(probe.posted_task_down(stdout, action, dict(pid=13, windowID=34)))
            self.assertFalse(probe.posted_task_down(stdout, action, dict(pid=12, windowID=35)))
            self.assertFalse(probe.posted_task_down(stdout, 'down', identity))
            self.assertFalse(probe.posted_task_down(stdout.split('\n')[0], action, identity))


if __name__ == '__main__':
    unittest.main()
