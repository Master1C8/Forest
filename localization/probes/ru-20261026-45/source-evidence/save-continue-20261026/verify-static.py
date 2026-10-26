"""Verify phase0046 static evidence and unchanged originals; never launch a game."""
from pathlib import Path
import datetime
import hashlib
import json
import subprocess

root = Path('/Users/antonkrutov/Desktop/Forest')
out = Path(__file__).resolve().parent
prior = root / 'localization/probes/ru-20261026-43'
source = Path('/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest')
data = 'The Forest of Love_Data'


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def load(path):
    return json.loads(path.read_text())


pins = load(prior / 'all-input-pins.json')
refs = load(prior / 'bridge-build.json')['originalManagedReferences']
others = load(prior / 'original-game-files.json')
owner = load(prior / 'owner-player-before.json')
report = load(prior / 'build.json')
checks = {
    'all19LiveLanePins': len(pins) == 19 and all(sha(Path(p)) == h for p, h in pins.items()),
    'all150OriginalManagedReferences': len(refs) == 150 and all(sha(source / data / 'Managed' / n) == h for n, h in refs.items()),
    'original262OtherGameFiles': len(others) == 262 and all(sha(source / n) == h for n, h in others.items()),
    'originalResourcePairs': len(report['files']) == 5 and all(sha(source / data / r['path']) == r['sourceSha256'] for r in report['files']),
    'ownerPlayerFilesUnchanged': owner == {str(p.relative_to(source)): sha(p) for p in source.rglob('tfol.*') if p.is_file()},
    'originalIdentity': (source / data / 'app.info').read_bytes() == b"Carrot's Critters _ Vulpine Visions\nThe Forest of Love",
    'originalCatalog': sha(source / data / 'StreamingAssets/aa/catalog.json') == load(root / 'assets/source-v2/source-files.json')['StreamingAssets/aa/catalog.json']['sha256'],
    'extractionPins': all(sha(out / n) == h for n, h in load(out / 'extraction.json')['files'].items()),
    'extractionRecipe': sha(root / 'tools/inspect_save_source.py') == load(out / 'extraction.json')['recipeSha256'],
    'bridgeCompileSource': sha(root / 'tools/probe/ForestProbe.cs') == load(out / 'bridge-verification.json')['sourceSha256'],
    'candidate44NotCreated': not (root / 'localization/probes/ru-20261026-44').exists(),
    'canonicalMain': subprocess.check_output(['git', 'branch', '--show-current'], cwd=root, text=True).strip() == 'main',
    'focusedTestSourcePins': all(sha(root / n) == h for n, h in load(out / 'tests.json')['sourceHashes'].items()),
}
old_tests = load(root / 'localization/source/process-lifetime-20261026/phase0044-tests.json')
checks['old70TestSourcePinsUnchanged'] = all(sha(root / n) == h for n, h in old_tests['sourceHashes'].items())
rows = subprocess.check_output(['ps', '-axo', 'pid,ppid,command'], text=True).splitlines()
markers = ['winewrapper.exe --run -- ', 'The Forest of Love.exe', 'UnityCrashHandler64.exe', 'diagnose_newgame.py', 'target_keyboard']
prefixes = [str(root / 'localization/probes/'), str(root / 'localization/probes/').replace('/', '\\'),
            str(source) + '/', str(source).replace('/', '\\') + '\\']
remaining = [r.strip() for r in rows if any(m in r for m in markers) and any(p in r for p in prefixes)]
checks['noForestRuntimeOrHelperProcess'] = not remaining
qa = source.parent / 'users/crossover/AppData/LocalLow/VNRevivalQA/ForestRuRendererProbe'
checks['qaPersistentDirectoryEmpty'] = qa.is_dir() and not any(qa.rglob('*'))
value = dict(status='passed-static-only' if all(checks.values()) else 'failed',
             verifiedAt=datetime.datetime.now(datetime.timezone.utc).isoformat(), checks=checks,
             remainingTaskProcesses=remaining, gameLaunches=0, imagesOpened=0,
             originalWrites=0, assetLaneWrites=0,
             scope='Static source/fixture admission/diagnostic compile. QA persistence directory emptiness is file hygiene only, not absence of PlayerPrefs or proof of restoration.')
(out / 'verification.json').write_text(json.dumps(value, indent=2) + '\n')
print(json.dumps(value, indent=2))
assert all(checks.values())
