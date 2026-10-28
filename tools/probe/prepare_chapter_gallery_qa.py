"""Stage a uniquely identified disposable copy; never launch a game."""
import argparse
import copy
import ctypes
import hashlib
import json
import os
from pathlib import Path
import re
import shutil

import UnityPy
from capture_chapter_gallery_ui import validate_candidate, prepare

ROOT = Path('/Users/antonkrutov/Desktop/Forest')
DATA = 'The Forest of Love_Data'


def sha(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def stage(candidate, run, fixture, resume_partial=False):
    candidate, run, fixture = candidate.resolve(), run.resolve(), fixture.resolve()
    assert run.parent == ROOT / 'localization/probes' and run.exists() == resume_partial
    assert re.fullmatch(r'ru-chapter-gallery-\d{8}-\d{2}', run.name)
    _, _, build = validate_candidate(candidate, locale='ru')
    manifest = json.loads((fixture / 'manifest.json').read_text())
    assert fixture.is_relative_to(ROOT / 'localization/probes') and manifest['originalOwnerFilesUsed'] is False
    assert set(manifest['files']) == {'tfol.savegame', 'tfol.settings'}
    assert all(sha(fixture / n) == r['sha256'] for n, r in manifest['files'].items())
    assert not list((candidate / 'game').rglob('tfol.*'))
    product = 'ForestRuChapterGalleryProbe' + run.name.removeprefix('ru-chapter-gallery-').replace('-', '_')
    if resume_partial:
        assert not any((run / n).exists() for n in ['qa-preparation.json', 'build.json', 'cg-inputs', 'launch.json'])
        assert json.loads((run / 'staging-failure-01.json').read_text())['gameLaunched'] is False
        files = [p for p in (run / 'game').rglob('*') if p.is_file()]
        for path in files:
            source = candidate / 'game' / path.relative_to(run / 'game')
            assert source.is_file() and sha(source) == sha(path) and source.stat().st_ino != path.stat().st_ino
        (run / 'partial-clone-validation.json').write_text(json.dumps(dict(status='verified-for-missing-file-continuation',
            parentBuild=str(candidate), parentBuildSha256=sha(candidate / 'build.json'),
            existingFiles={str(p.relative_to(run / 'game')): sha(p) for p in files},
            noOverwrite=True, noGameOrBridgeStarted=True), indent=2) + '\n')
    else:
        run.mkdir()
    lib = ctypes.CDLL('/usr/lib/libSystem.B.dylib', use_errno=True)
    def clone(src, dest):
        if Path(dest).exists():
            assert resume_partial and sha(src) == sha(dest) and os.stat(src).st_ino != os.stat(dest).st_ino
            return dest
        if lib.clonefile(os.fsencode(src), os.fsencode(dest), 0):
            shutil.copyfile(src, dest)
        assert os.stat(src).st_ino != os.stat(dest).st_ino and sha(src) == sha(dest)
        return dest
    shutil.copytree(candidate / 'game', run / 'game', copy_function=clone, dirs_exist_ok=resume_partial)
    data = run / 'game' / DATA
    env = UnityPy.load(str(data / 'globalgamemanagers'))
    objects = {o.path_id: o for o in env.objects}
    player = next(o for o in env.objects if o.type.name == 'PlayerSettings')
    original = player.read_typetree(); expected = copy.deepcopy(original)
    assert original['companyName'] == 'VNRevivalQA' and original['productName'] == build['saveIsolation']['productName']
    expected['productName'] = product
    unchanged = {pid: hashlib.sha256(o.get_raw_data()).hexdigest() for pid, o in objects.items() if pid != player.path_id}
    player.save_typetree(expected)
    (data / 'globalgamemanagers').write_bytes(next(iter(env.files.values())).save())
    got = {o.path_id: o for o in UnityPy.load(str(data / 'globalgamemanagers')).objects}
    assert got[player.path_id].read_typetree() == expected
    assert all(hashlib.sha256(got[pid].get_raw_data()).hexdigest() == digest for pid, digest in unchanged.items())
    (data / 'app.info').write_text('VNRevivalQA\n' + product)
    build['saveIsolation']['productName'] = product
    next(r for r in build['files'] if r['path'] == 'globalgamemanagers')['probeSha256'] = sha(data / 'globalgamemanagers')
    owned_fixture = run / 'fixture-inputs'; owned_fixture.mkdir()
    for name in ['manifest.json'] + list(manifest['files']):
        shutil.copyfile(fixture / name, owned_fixture / name)
    for name in manifest['files']:
        shutil.copyfile(owned_fixture / name, data / name)
    def write(name, value):
        (run / name).write_text(json.dumps(value, ensure_ascii=False, indent=2) + '\n')
    write('build.json', build)
    write('qa-preparation.json', dict(parentBuild=str(candidate), parentBuildSha256=sha(candidate / 'build.json'),
          ownerFilesUsed=False, fixtureDirectory=str(owned_fixture), fixtureManifestSha256=sha(owned_fixture / 'manifest.json'),
          sourceDisposableFixture=str(fixture), sourceFixtureManifestSha256=sha(fixture / 'manifest.json'),
          onlyPlayerSettingsFieldChanged='productName', allOtherGlobalObjectsByteExact=True,
          scope='Independent unhooked runtime copy; original game/saves unused; no process launched'))
    shutil.copyfile(Path(__file__), run / Path(__file__).name)
    # The owning preparation validates these exact staged inputs again, snapshots
    # all later-loaded dependencies, compiles and installs only the QA bridge.
    prepare(candidate, run, locale='ru')
    print(json.dumps(dict(status='prepared-not-run', run=str(run), product=product)))


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--candidate', type=Path, required=True)
    parser.add_argument('--run', type=Path, required=True)
    parser.add_argument('--fixture', type=Path, required=True)
    parser.add_argument('--resume-verified-partial-clone', action='store_true')
    args = parser.parse_args()
    stage(args.candidate, args.run, args.fixture, args.resume_verified_partial_clone)
