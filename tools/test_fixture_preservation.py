import copy
import json
import unittest
from probe.fixture_preservation import settings_delta


class FixtureSettings(unittest.TestCase):
    def setUp(self):
        self.before = {'config_data': {'value': {'generalData': {
            'lastKnownScreenResolutionWidth': 1440,
            'lastKnownScreenResolutionHeight': 900,
            'finishedFirstLaunch': True}, 'chapterUnlocks': []}}}
        self.after = copy.deepcopy(self.before)
        self.after['config_data']['value']['generalData'].update(
            lastKnownScreenResolutionWidth=1024, lastKnownScreenResolutionHeight=768)

    def test_only_matching_resolution_metadata_is_permitted(self):
        encode = lambda value: json.dumps(value).encode()
        self.assertEqual(len(settings_delta(encode(self.before), encode(self.after), (1024, 768))), 2)
        for mutate in ('hidden-flag', 'unlock', 'wrong-resolution'):
            changed = copy.deepcopy(self.after)
            if mutate == 'hidden-flag':
                changed['config_data']['value']['generalData']['finishedFirstLaunch'] = False
            elif mutate == 'unlock':
                changed['config_data']['value']['chapterUnlocks'] = ['new']
            else:
                changed['config_data']['value']['generalData']['lastKnownScreenResolutionWidth'] = 1280
            with self.subTest(mutate=mutate), self.assertRaisesRegex(AssertionError, 'Unexpected disposable settings change'):
                settings_delta(encode(self.before), encode(changed), (1024, 768))


if __name__ == '__main__':
    unittest.main()
