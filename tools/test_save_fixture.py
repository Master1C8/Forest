"""Admission guards only; no mocked claim of Unity restoration."""
import hashlib
import json
from pathlib import Path
import tempfile
import unittest

from tools.probe.save_fixture import DATA, candidate_files, expectations, pinned_fixture

ROOT = Path(__file__).resolve().parents[1]
FIXTURE = ROOT / 'localization/probes/ru-20261026-43/qa-generated'


class SaveFixtureTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name)
        self.manifest = self.root / 'manifest.json'
        self.value = json.loads((FIXTURE / 'manifest.json').read_text())
        for name in self.value['files']:
            (self.root / name).write_bytes((FIXTURE / name).read_bytes())
        self.write_manifest()

    def write_manifest(self):
        self.manifest.write_text(json.dumps(self.value))
        self.pin = hashlib.sha256(self.manifest.read_bytes()).hexdigest()

    def populate(self):
        game = self.root / 'game'
        (game / DATA).mkdir(parents=True)
        for name in self.value['files']:
            (game / DATA / name).write_bytes((self.root / name).read_bytes())
        return game

    def test_actual_fixture_and_exact_candidate_positive_control(self):
        real = FIXTURE / 'manifest.json'
        state = expectations(real, hashlib.sha256(real.read_bytes()).hexdigest())
        self.assertEqual(state['playerRespawnData']['currentAreaSavekey'], 'central_forest')
        self.assertFalse(state['restoreVerified'])
        _, expected = pinned_fixture(self.manifest, self.pin)
        self.assertEqual(len(candidate_files(self.populate(), expected)), 2)

    def test_changed_manifest_pin_rejected_before_contents(self):
        with self.assertRaisesRegex(AssertionError, 'manifest pin mismatch'):
            pinned_fixture(self.manifest, '0' * 64)

    def test_owner_provenance_rejected(self):
        self.value['originalOwnerFilesUsed'] = True
        self.write_manifest()
        with self.assertRaisesRegex(AssertionError, 'Owner files'):
            pinned_fixture(self.manifest, self.pin)

    def test_wrong_destination_rejected(self):
        self.value['files']['tfol.savegame']['source'] = '../tfol.savegame'
        self.write_manifest()
        with self.assertRaisesRegex(AssertionError, 'destination'):
            pinned_fixture(self.manifest, self.pin)

    def test_same_size_changed_fixture_rejected(self):
        p = self.root / 'tfol.savegame'
        value = bytearray(p.read_bytes()); value[-1] ^= 1; p.write_bytes(value)
        with self.assertRaisesRegex(AssertionError, 'bytes differ'):
            pinned_fixture(self.manifest, self.pin)

    def test_extra_nested_save_rejected(self):
        _, expected = pinned_fixture(self.manifest, self.pin)
        game = self.populate()
        (game / 'nested').mkdir()
        (game / 'nested/tfol.savegame').write_bytes((self.root / 'tfol.savegame').read_bytes())
        with self.assertRaisesRegex(AssertionError, 'player files differ'):
            candidate_files(game, expected)

    def test_changed_candidate_rejected(self):
        _, expected = pinned_fixture(self.manifest, self.pin)
        game = self.populate()
        (game / DATA / 'tfol.settings').write_bytes(b'other')
        with self.assertRaisesRegex(AssertionError, 'player files differ'):
            candidate_files(game, expected)

    def test_symlinked_directory_rejected(self):
        _, expected = pinned_fixture(self.manifest, self.pin)
        game = self.populate()
        (game / 'linked').symlink_to(self.root, target_is_directory=True)
        with self.assertRaisesRegex(AssertionError, 'symlinks'):
            candidate_files(game, expected)

    def test_invalid_schema_version_with_matching_pins_rejected(self):
        path = self.root / 'tfol.savegame'
        data = json.loads(path.read_bytes()); data['savegame_version']['value'] = 'old'
        path.write_text(json.dumps(data))
        row = self.value['files']['tfol.savegame']
        row.update(bytes=path.stat().st_size, sha256=hashlib.sha256(path.read_bytes()).hexdigest())
        self.write_manifest()
        with self.assertRaisesRegex(AssertionError, 'Unsupported save version'):
            expectations(self.manifest, self.pin)


if __name__ == '__main__':
    unittest.main()
