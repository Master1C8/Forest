"""Final-stage, two-operand quest notification repair with immutable build inputs."""
import hashlib
import json
from pathlib import Path
import shutil
import subprocess

ROOT = Path('/Users/antonkrutov/Desktop/Forest')
PACKET = ROOT / 'localization/hotfixes/ru-quest-notifications-20261029'


def sha(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def load_inputs(folder=None):
    folder = Path(folder) if folder else PACKET
    if (folder / 'pins.json').exists():
        for name, expected in json.loads((folder / 'pins.json').read_text()).items():
            if sha(folder / name) != expected:
                raise ValueError(('quest-notification-snapshot-pin', name))
    review = json.loads((folder / 'independent-review.json').read_text())
    if review['inputs']['targets']['sha256'] != sha(folder / 'targets.json') or review['inputs']['packet']['sha256'] != sha(folder / 'review-packet.json'):
        raise ValueError('Quest notification review version mismatch')
    if review['result'] != 'clean' or review['findings'] or review['coverage']['reviewedIds'] != 2:
        raise ValueError('Quest notification review not accepted')
    return folder


def snapshot(output):
    folder = Path(output) / 'quest-notification'
    folder.mkdir()
    local = Path(__file__).parent / 'quest-notification'
    source = load_inputs(local if local.is_dir() else None)
    for name in ['targets.json', 'review-packet.json', 'independent-review.json']:
        shutil.copy2(source / name, folder / name)
    for name in ['Program.cs', 'QuestNotificationPatch.csproj']:
        shutil.copy2((source if local.is_dir() else ROOT / 'tools/quest_notification_patch') / name, folder / name)
    shutil.copy2(Path(__file__), Path(output) / Path(__file__).name)
    (folder / 'pins.json').write_text(json.dumps({p.name: sha(p) for p in folder.iterdir()}, indent=2) + '\n')
    load_inputs(folder)
    return folder


def patch(source, target, receipt, folder):
    folder = load_inputs(folder)
    compiled = folder / 'compiled'
    intermediate = folder / 'obj'
    subprocess.run(['dotnet', 'build', str(folder / 'QuestNotificationPatch.csproj'),
                    '--output', str(compiled), '-p:BaseIntermediateOutputPath=' + str(intermediate.resolve()) + '/'],
                   check=True, stdout=subprocess.DEVNULL)
    subprocess.run(['dotnet', str(compiled / 'QuestNotificationPatch.dll'), 'patch', str(source),
                    str(folder / 'targets.json'), str(target), str(receipt)], check=True)
    return json.loads(Path(receipt).read_text())
