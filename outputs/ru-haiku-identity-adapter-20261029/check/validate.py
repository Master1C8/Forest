#!/usr/bin/env python3
"""Finite adapter regression suite; never starts a game or a model."""
import ast
import argparse
import copy
import importlib.util
import json
import shutil
import subprocess
import sys
from pathlib import Path

ROOT = Path('/Users/antonkrutov/Desktop/Forest')
CHECK = ROOT / 'outputs/ru-haiku-identity-adapter-20261029/check'
spec = importlib.util.spec_from_file_location('haiku_adapter', ROOT / 'tools/russian_haiku_identity.py')
h = importlib.util.module_from_spec(spec); spec.loader.exec_module(h)
parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('--output', type=Path, default=CHECK / 'regression-final')
args = parser.parse_args()
out = args.output.resolve()
assert ROOT in out.parents
out.mkdir(exist_ok=False)
results = []


def reject(name, action, reason):
    try:
        action()
    except ValueError as e:
        assert str(e) == reason, (name, str(e), reason)
    else:
        raise AssertionError(name)
    results.append(dict(name=name, passed=True, expectedReason=reason))


plan = h.load_inputs(locale='ru')
reject('missing-locale', lambda: h.load_inputs(locale=None), 'explicit-ru-locale-required')
reject('wrong-locale', lambda: h.load_inputs(locale='en'), 'explicit-ru-locale-required')
for name, mutate, reason in [
    ('missing-ninth-choice', lambda p: p['choices'].pop(), 'exact-nine-choices-required'),
    ('wrong-context', lambda p: p.update(context='any-question'), 'wrong-context'),
    ('wrong-source-version', lambda p: p.update(originalAssemblySha256='0' * 64), 'wrong-source-or-target-version'),
    ('wrong-target-version', lambda p: p.update(corpusSha256='0' * 64), 'wrong-source-or-target-version'),
    ('draft-poem-receipt', lambda p: p['choices'][0].update(acceptedVerdict='needs-review'), 'accepted-russian-choice-required'),
    ('wrong-choice-step', lambda p: p['choices'][0].update(slot=2), 'wrong-slot-identity'),
]:
    p = copy.deepcopy(plan); mutate(p)
    reject(name, lambda: h.validate_plan(p), reason)
p = copy.deepcopy(plan)
p['choices'][1].update(target=p['choices'][0]['target'], targetSha256=p['choices'][0]['targetSha256'])
reject('ambiguous-exact-slot-labels', lambda: h.validate_plan(p), 'ambiguous-slot-labels')
h.validate_plan(plan)

# Exercise the real loader's byte-integrity boundary with one changed corpus.
fake_root = out / 'wrong-target-inputs'
for name in h.read(h.CONTRACT / 'input-pins.json'):
    dest = fake_root / name; dest.parent.mkdir(parents=True, exist_ok=True)
    if name == h.CORPUS:
        dest.write_bytes((ROOT / name).read_bytes() + b'\n')
    else:
        dest.symlink_to(ROOT / name)
reject('wrong-target-bytes-real-loader', lambda: h.load_inputs(locale='ru', root=fake_root), 'input-pin:' + h.CORPUS)

backend = CHECK / 'execution-delivery/HaikuIdentityPatch.dll'
candidate = ROOT / 'localization/previews/ru-20261029-chapter-gallery-02/game/The Forest of Love_Data/Managed/Assembly-CSharp.dll'
patched = CHECK / 'delivery/Assembly-CSharp.ru-haiku.dll'
wrong_source = out / 'wrong-source.dll'
wrong_source.write_bytes(candidate.read_bytes() + b'changed-input')
reject('wrong-source-bytes-real-adapter', lambda: h.patch(wrong_source, out / 'rejected.dll', out / 'rejected.json', locale='ru', backend=backend), 'supported-input-assembly-hash')
assert not (out / 'rejected.dll').exists() and not (out / 'rejected.json').exists()

for name, source, mapping, expected in [
    ('actual-backend-wrong-source', wrong_source, h.CONTRACT / 'mapping.json', 'supported-input-assembly-hash'),
    ('actual-backend-repeat', patched, h.CONTRACT / 'mapping.json', 'patch-state-not-pristine'),
]:
    output = out / (name + '.dll'); receipt = out / (name + '.json')
    r = subprocess.run(['dotnet', str(backend), 'patch', str(source), str(mapping), str(output), str(receipt)], capture_output=True, text=True)
    assert r.returncode == 2 and r.stderr.strip() == 'InvalidOperationException: ' + expected, (name, r.stderr)
    assert not output.exists() and not receipt.exists() and not Path(str(output) + '.before.dll').exists()
    results.append(dict(name=name, passed=True, expectedReason=expected, stderr=r.stderr.strip(), noOutputWritten=True))

# Verify the exact builder control order and snapshot-only late dependencies.
builder = (ROOT / 'tools/build_russian_preview.py').read_text()
ast.parse(builder)
assert builder.index("load_haiku_identity(locale='ru')") < builder.index('out.mkdir(parents=True)')
assert builder.index('snapshot_haiku_identity(out') < builder.index('runtime = out /')
assert builder.index("report['haikuIdentityCodeProjection']") > builder.index("report['chapterGalleryCodeProjection']")
assert "str(frozen / 'russian_haiku_identity.py')" in builder
results.append(dict(name='normal-builder-hook', passed=True, boundary='AST/control-order inspection only; no full game build'))

# Freeze all late dependencies and prove the frozen loader works without canonical imports.
snapshot_root = out / 'snapshot-proof'
snapshot_root.mkdir()
h.snapshot(snapshot_root, locale='ru')
snap = snapshot_root / 'haiku-identity'
subprocess.run([sys.executable, '-B', str(snap / 'russian_haiku_identity.py'), '--locale', 'ru', 'preflight'], check=True, stdout=subprocess.DEVNULL)
for name, digest in h.read(snap / 'snapshot-pins.json').items():
    assert h.sha(snap / name) == digest
results.append(dict(name='immutable-snapshot-preflight', passed=True, files=len(h.read(snap / 'snapshot-pins.json'))))

# Force a filesystem failure after payload writes, at the methods-ledger write.
# No fixture is credited as complete without its final receipt; the saved original remains exact.
failed = out / 'interrupted-write.dll'
Path(str(failed) + '.methods.jsonl').mkdir()
r = subprocess.run(['dotnet', str(backend), 'patch', str(candidate), str(h.CONTRACT / 'mapping.json'), str(failed), str(out / 'interrupted-write.json')], capture_output=True, text=True)
assert r.returncode == 2 and r.stderr.startswith('UnauthorizedAccessException:'), r.stderr
assert h.sha(failed) == h.sha(patched)
assert h.sha(Path(str(failed) + '.before.dll')) == h.CANDIDATE
assert h.sha(Path(str(failed) + '.reversed.dll')) == h.CANDIDATE
assert not (out / 'interrupted-write.json').exists()
repeat = subprocess.run(['dotnet', str(backend), 'patch', str(candidate), str(h.CONTRACT / 'mapping.json'), str(failed), str(out / 'interrupted-write.json')], capture_output=True, text=True)
assert repeat.returncode == 2 and repeat.stderr.strip() == 'InvalidOperationException: new-output-required'
results.append(dict(name='failure-between-payload-and-receipt-writes', passed=True, stderr=r.stderr.strip(), unchangedSource=True, exactBeforeAndReversedPayloads=True, completionReceiptAbsent=True, repeatRejected=True, boundary='per-file writes; no multi-file transaction; reconcile partial paths and choose a new attempt'))

for name, digest in h.read(h.CONTRACT / 'input-pins.json').items():
    assert h.sha(ROOT / name) == digest
assert h.sha(candidate) == h.CANDIDATE
h.write(out / 'validation.json', dict(passed=True, tests=results, count=len(results), positiveControl='real pinned accepted loader and candidate patch + actual CLR fixture', fullGameBuild='not-run', runtime='not-run'))
print(json.dumps({'passed': True, 'tests': len(results)}))
