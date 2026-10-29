"""Freeze and apply the reviewed exact-value Russian portrait-label mapper."""
import hashlib
import json
from pathlib import Path
import shutil
import subprocess

ROOT = Path('/Users/antonkrutov/Desktop/Forest')
PACKET = ROOT / 'localization/hotfixes/ru-speaker-display24-20261029'
INPUTS = ['targets.json', 'review-packet.json', 'source-labels.json', 'independent-review.json', 'font-requirements.json']


def sha(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def load_inputs(folder=None):
    local = Path(__file__).parent / 'speaker-display'
    folder = Path(folder) if folder else (local if (local / 'pins.json').exists() else PACKET)
    if (folder / 'pins.json').exists():
        for name, expected in json.loads((folder / 'pins.json').read_text()).items():
            if sha(folder / name) != expected:
                raise ValueError('Speaker snapshot pin: ' + name)
    rows = json.loads((folder / 'targets.json').read_text())
    source = json.loads((folder / 'source-labels.json').read_text())
    review = json.loads((folder / 'independent-review.json').read_text())
    font = json.loads((folder / 'font-requirements.json').read_text())
    if font['targetsSha256'] != sha(folder / 'targets.json') or font['missingCodepoints']:
        raise ValueError('Speaker font coverage/version required')
    if review['status'] != 'clean' or review['findings'] or review['coverage'] != 'complete':
        raise ValueError('Complete clean speaker review required')
    for name, key in [('targets.json', 'targetsSha256'), ('review-packet.json', 'packetSha256'), ('source-labels.json', 'sourceLabelsSha256')]:
        if sha(folder / name) != review[key]:
            raise ValueError('Speaker review version: ' + name)
    if len(rows) != 24 or {r['source'] for r in rows} != set(source['fullDisplayValues']) or review['displayValues'] != 24 or review['sourceMemberships'] != 31:
        raise ValueError('Exact24 speaker value scope required')
    if set(review['allIds']) != {r['id'] for r in rows}:
        raise ValueError('Speaker reviewed label coverage')
    memberships = {f"ds:{r['conversationId']}:{r['entryId']}:Title" for r in source['renameRows'] + source['forceNextRows']}
    if len(memberships) != 31 or set(review['allMembershipIds']) != memberships or {i for r in rows for i in r['memberships']} != memberships:
        raise ValueError('Speaker reviewed membership coverage')
    for row in rows:
        expected = {f"ds:{r['conversationId']}:{r['entryId']}:Title" for r in source['renameRows'] + source['forceNextRows'] if r['label'] == row['source']}
        if row['id'] != 'speaker-display:' + row['source'] or set(row['memberships']) != expected:
            raise ValueError('Speaker exact label binding')
    return folder


def snapshot(output):
    folder = Path(output) / 'speaker-display'
    folder.mkdir()
    local = Path(__file__).parent / 'speaker-display'
    source = load_inputs(local if local.is_dir() else None)
    for name in INPUTS:
        shutil.copy2(source / name, folder / name)
    for name in ['Program.cs', 'SpeakerDisplayPatch.csproj']:
        shutil.copy2((source if local.is_dir() else ROOT / 'tools/speaker_display_patch') / name, folder / name)
    shutil.copy2(Path(__file__), Path(output) / Path(__file__).name)
    # Compile only the immutable copied sources. The exact compiler/Cecil closure
    # is frozen before future patch calls, not recompiled from the checkout.
    subprocess.run(['dotnet', 'build', str(folder / 'SpeakerDisplayPatch.csproj'), '--output', str(folder / 'compiled'), '-p:BaseIntermediateOutputPath=' + str((folder / 'obj').resolve()) + '/'], check=True, stdout=subprocess.DEVNULL)
    names = INPUTS + ['Program.cs', 'SpeakerDisplayPatch.csproj', '../russian_speaker_display.py']
    names += [str(p.relative_to(folder)) for p in (folder / 'compiled').iterdir() if p.is_file() and p.suffix in ['.dll', '.json']]
    (folder / 'pins.json').write_text(json.dumps({n: sha(folder / n) for n in names}, indent=2) + '\n')
    load_inputs(folder)
    return folder


def patch(source, target, receipt, folder):
    folder = load_inputs(folder)
    if not (folder / 'pins.json').exists():
        raise ValueError('Frozen compiled speaker snapshot required')
    target, receipt = Path(target), Path(receipt)
    probe = target.with_name(target.stem + '.probe.dll')
    subprocess.run(['dotnet', str(folder / 'compiled/SpeakerDisplayPatch.dll'), 'patch', str(source), str(folder / 'targets.json'), str(target), str(receipt), str(probe)], check=True)
    result = json.loads(receipt.read_text())
    if result['targetsSha256'] != sha(folder / 'targets.json') or result['targetSha256'] != sha(target):
        raise ValueError('Speaker delivered patch readback')
    return result
