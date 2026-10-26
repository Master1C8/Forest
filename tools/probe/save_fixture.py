"""Read-only admission of explicitly pinned QA-generated save fixtures.

This checks bytes and paths only. It never establishes restoration or gameplay.
"""
import hashlib
import json
from pathlib import Path

DATA = 'The Forest of Love_Data'
FILES = {'tfol.savegame', 'tfol.settings'}


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def pinned_fixture(manifest_path, manifest_sha256):
    manifest_path = Path(manifest_path)
    assert not manifest_path.is_symlink() and sha(manifest_path) == manifest_sha256, 'Fixture manifest pin mismatch'
    manifest = json.loads(manifest_path.read_text())
    assert manifest['originalOwnerFilesUsed'] is False, 'Owner files are forbidden'
    assert manifest['inspectionBridgePresent'] is False, 'Fixture must come from cleaned QA run'
    assert set(manifest['files']) == FILES, 'Unexpected fixture file set'
    result = {}
    for name, row in manifest['files'].items():
        path = manifest_path.parent / name
        assert not path.is_symlink() and path.is_file(), 'Fixture must be a regular local file'
        assert row['source'] == DATA + '/' + name, 'Unexpected fixture destination'
        assert path.stat().st_size == row['bytes'] and sha(path) == row['sha256'], 'Fixture bytes differ from pin'
        result[name] = row['sha256']
    return manifest, result


def candidate_files(game, expected):
    """Require exactly the two authorized files, with no nested/alternate saves."""
    game = Path(game)
    assert game.is_dir() and not game.is_symlink(), 'Expected isolated game directory'
    assert set(expected) == FILES, 'Incomplete fixture admission'
    # A symlinked directory can hide an alternate save from rglob: reject it.
    assert not any(p.is_symlink() for p in game.rglob('*')), 'Candidate symlinks are forbidden'
    actual = {str(p.relative_to(game)): sha(p) for p in game.rglob('tfol.*') if p.is_file()}
    assert actual == {DATA + '/' + name: value for name, value in expected.items()}, 'Candidate player files differ from exact QA fixture set'
    return actual


def expectations(manifest_path, manifest_sha256):
    manifest, hashes = pinned_fixture(manifest_path, manifest_sha256)
    root = Path(manifest_path).parent
    save = json.loads((root / 'tfol.savegame').read_bytes())
    settings = json.loads((root / 'tfol.settings').read_bytes())
    assert save['savegame_version'] == {'__type': 'string', 'value': '231129'}, 'Unsupported save version'
    assert settings['config_version'] == {'__type': 'string', 'value': '220308'}, 'Unsupported config version'
    assert save['savegame_data']['__type'] == 'TheForestOfLove.Services.Persistence.Savestate,Assembly-CSharp'
    assert settings['config_data']['__type'] == 'TheForestOfLove.Services.Persistence.GlobalSavestate,Assembly-CSharp'
    data = save['savegame_data']['value']
    return {
        'manifestSha256': manifest_sha256, 'files': hashes,
        'lastObservedScene': manifest['lastObservedScene'],
        'playerRespawnData': data['playerRespawnData'], 'generalData': data['generalData'],
        'tags': data['tags'],
        'introDialogue': data['dialogueData']['NewGame_Intro'],
        'tutorialDialogue': data['dialogueData']['TutorialQuest_IntroFromBunny'],
        'tutorialArc': data['arcData']['TutorialQuest_IntroFromBunny_p1'],
        'tutorialQuest': data['questData']['act1_tutorialQuest'],
        'introTrigger': data['triggerData']['Cutscene_IntroBunnyHouse'],
        'lastGameplayLog': data['gameplayLogHistory'][-1],
        'restoreVerified': False, 'continuedExecutionVerified': False,
        'boundary': 'Static exact-byte fixture inspection; original Unity deserialization and continued execution remain unverified'
    }
