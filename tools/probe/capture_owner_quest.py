"""Capture the current Russian quest through original UI, with complete row bounds.

Requires an already prepared, supervised, task-owned native capture process.
Never launches a game or changes a save. Originals use exclusive filenames.
"""
import argparse, json, subprocess, time
from pathlib import Path

ROOT=Path(__file__).resolve().parents[2]
p=argparse.ArgumentParser(description=__doc__);p.add_argument('run',type=Path);p.add_argument('--align-complete-rows',action='store_true');a=p.parse_args();run=a.run.resolve()
assert run.parent==ROOT/'localization/probes' and run.name.startswith('ru-owner-shots-')
assert not (run/'ru-06-hot-takes.png').exists()
deadline=time.monotonic()+90
while not (run/'bridge-ready.txt').exists():
    if time.monotonic()>deadline:raise TimeoutError('Native bridge not ready; preserve supervised process')
    time.sleep(.25)
def command(value):
    subprocess.run(['python3','-B',str(ROOT/'tools/probe/native_capture_command.py'),str(run),value],check=True,stdout=subprocess.DEVNULL)
def state(name=None):
    command('dump');raw=(run/'state.json').read_bytes()
    if name:(run/('state-'+name+'.json')).write_bytes(raw)
    return json.loads(raw)
def click(address):
    assert address in state()['buttons'],address
    command('click '+address)
command('show-menu');click('Canvas/MainMenu/Controls/Start');click('Canvas/PlayMenu/Controls/Continue')
deadline=time.monotonic()+75
while not any(row.startswith('player|') for row in state()['details']):
    if time.monotonic()>deadline:raise TimeoutError('Original current-save load not ready')
    time.sleep(.5)
command('page QuestLog');command('quest Горячие кадры')
scrolls=[row.split('\t')[0] for row in state()['scrolls'] if row.split('\t')[0].endswith(('/QuestDetails','/QuestsScrollView'))]
assert len(scrolls)==2
# Selection auto-scrolls the left list. Set BOTH positions after the FINAL
# selection, not before a later reselection that can move the list again.
for address in scrolls:command('scroll '+address+' 1')
if a.align_complete_rows:command('align-quest-list')
time.sleep(1)
final=state('quest-capture-ready')
for row in final['scrolls']:
    parts=row.split('\t')
    if parts[0] in scrolls and (not a.align_complete_rows or parts[0].endswith('/QuestDetails')):assert abs(float(parts[1])-1)<.001,row
detail=[row for row in final['geometry'] if '/QuestDetails/' in row]
assert len(detail)==4 and all('\toutside=0\t' in row for row in detail)
command('capture ru-06-hot-takes.png');(run/'finish.request').touch()
print('Captured current quest with verified scroll positions and all four text roles inside the viewport')
