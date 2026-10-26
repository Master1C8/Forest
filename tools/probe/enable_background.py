"""Repair the existing isolated probe; future probes set this in their builder."""
from pathlib import Path
import hashlib
import json
import UnityPy

root = Path(__file__).resolve().parents[2]
run = root / 'localization/probes/ru-20261026-03'
path = run / 'game/The Forest of Love_Data/globalgamemanagers'
assert not (run / 'background-repair.json').exists()
env = UnityPy.load(str(path))
objects = {obj.path_id: obj for obj in env.objects}
player = next(obj for obj in objects.values() if obj.type.name == 'PlayerSettings')
before = player.read_typetree()
assert before['companyName'] == 'VNRevivalQA' and before['productName'] == 'ForestRuRendererProbe'
assert before['runInBackground'] is False
expected = before.copy(); expected['runInBackground'] = True
old_hash = hashlib.sha256(path.read_bytes()).hexdigest()
raw = {pid: obj.get_raw_data() for pid, obj in objects.items() if pid != player.path_id}
player.save_typetree(expected)
path.write_bytes(next(iter(env.files.values())).save())
reopened = {obj.path_id: obj for obj in UnityPy.load(str(path)).objects}
assert reopened.keys() == objects.keys()
assert reopened[player.path_id].read_typetree() == expected
assert all(reopened[pid].get_raw_data() == value for pid, value in raw.items())
(run / 'background-repair.json').write_text(json.dumps({
    'oldSha256': old_hash, 'newSha256': hashlib.sha256(path.read_bytes()).hexdigest(),
    'changedFields': ['/runInBackground'], 'before': False, 'after': True,
    'exactReadback': 'passed', 'unselectedRawObjectEquality': 'passed',
    'scope': 'Isolated QA player settings only; source installation untouched.'
}, indent=2) + '\n')
print('Isolated background execution enabled; exact readback passed.')
