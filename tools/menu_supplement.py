"""Append the complete remaining menu source fields to the existing UI packet."""
import hashlib
import json
from pathlib import Path
import re

ROOT = Path(__file__).resolve().parents[1]
SOURCE = ROOT / 'localization/source/menu-remaining-ui-20261027'
PHRASES = [
 ('menu.continue','Continue Saved Game\n'), ('menu.start-from','Start from:'),
 ('menu.act','Act {0}'), ('menu.act-heading','ACT {0}'), ('menu.latest','Latest'),
 ('menu.soon','Coming Soon...'), ('menu.dialogue','Dialogue:'),
 ('menu.unlock-all','Unlock All (Cheat)'), ('menu.help','Help'),
 ('menu.movie-item','Movie {0}/{1}'), ('menu.story-item','Story {0}/{1}'),
 ('menu.delete','Delete\nSavegame'), ('menu.new-game','Start New Game\n'),
 ('menu.confirm-new','This will erase your earlier progress. Are you sure?'),
 ('menu.confirm-delete','Are you sure you want to delete your savegame?'),
 ('menu.confirm-quit','Are you sure you want to quit?'),
 ('menu.unsaved','Unsaved progress will be lost!'),
 ('gallery.movies','Movies'), ('gallery.stories','Stories'),
 ('gallery.movies-count','Movies\n<size=12>({0}/{1} unlocked)</size>'),
 ('gallery.stories-count','Stories\n<size=12>({0}/{1} unlocked)</size>'),
]


def source_addendum(existing):
    assert hashlib.sha256((SOURCE / 'menu-inventory.json').read_bytes()).hexdigest() == '128a0cdec222e929d7217ec9520674c7f8c025febaf3d5bd1963f0e936173f08'
    assert hashlib.sha256((SOURCE / 'gallery-code.json').read_bytes()).hexdigest() == 'cf9c996d6f4bddc723accda2fb7842af4817d0cb48c46bbf6351ecca34c02635'
    inventory = json.loads((SOURCE / 'menu-inventory.json').read_text())
    code = json.loads((SOURCE / 'gallery-code.json').read_text())
    assert len(inventory['rows']) == 282 and len(code['units']) == 6
    assert inventory['sourceSha256'] == '5ff0636003eed46615678c124f42320eb9a8c66baa0870ec11c9faa42db78db0'
    assert code['sourceSha256'] == '46f43b212709b96ac51f2484d1564f863346fed8dc70f532860046226a020acf'
    direct = {s:k for k,s in PHRASES}
    direct.update({'Back':'report.back','Yes':'report.yes','No':'report.no',
                   'On':'settings.on','Off':'settings.off','Music':'settings.music',
                   'Effects':'settings.effects','Fullscreen:':'settings.fullscreen',
                   'Stretch:':'settings.stretch','Scale:':'settings.scale'})
    by_id = {u['id']:u for u in existing}; added=[]
    for row in inventory['rows']:
        source = row['source']; args=[]
        match = re.fullmatch('(Act|ACT) ([1-5])', source)
        item = re.fullmatch('(Movie|Story) (1)/(8)',source)
        if match:
            phrase='menu.act' if match[1]=='Act' else 'menu.act-heading';args=[int(match[2])]
        elif item:
            phrase='menu.movie-item' if item[1]=='Movie' else 'menu.story-item';args=[1,8]
        else:
            phrase=direct[source]
        assert row['kind']=='TextMeshProUGUI' and row['font']=={'m_FileID':5,'m_PathID':3323}
        if row['id'] in by_id:
            assert by_id[row['id']]['source']==source
            continue
        unit=dict(id=row['id'],family='menu',source=source,phrase=phrase,context=row['hierarchy'])
        if args:unit['formatArgs']=args
        added.append(unit)
    for row in code['units']:
        added.append(dict(id=row['id'],family='gallery-code',source=row['source'],phrase=direct[row['source']],
                          context=row['method'],instructionIndex=row['instructionIndex'],ilOffset=row['offset']))
    assert len(added)==234 and len({u['id'] for u in existing+added})==446
    pins={str(p.relative_to(ROOT)):hashlib.sha256(p.read_bytes()).hexdigest() for p in
          [SOURCE/'menu-inventory.json',SOURCE/'gallery-code.json',SOURCE/'controller-bindings.json',
           SOURCE/'gallery-labels.il',SOURCE/'gallery-setters.il',SOURCE/'menu-navigation.il',SOURCE/'menu-confirmations.il',
           SOURCE/'play-fast-forward.il',SOURCE/'play-fast-forward-init.il',SOURCE/'graphics-findings.json',ROOT/'tools/menu_supplement.py',
           ROOT/'tools/inspect_remaining_menu_ui.py',ROOT/'tools/menu_patch/Program.cs',ROOT/'tools/menu_patch/MenuPatch.csproj']}
    return added, pins


def render(unit,phrases):
    value=phrases[unit['phrase']]
    return value.format(*unit['formatArgs']) if unit.get('formatArgs') else value
