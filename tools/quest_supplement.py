"""Shared199-unit Quest append;one source inventory and directly authored locale wording."""
import hashlib,json,re
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1];SOURCE=ROOT/'localization/source/quest-family-ui-20261028';PACKET=ROOT/'localization/supplemental-ui/20261027'
def inventory():return json.loads((SOURCE/'inventory.json').read_text())
def words(locale):
 scope=json.loads((PACKET/'locale-scope.json').read_text());assert locale in scope['targetLocales'],'Explicit supported locale required'
 value=json.loads((PACKET/'quest-wording'/(locale+'.json')).read_text());inv=inventory();assert set(value)=={p['key'] for p in inv['phrases']}
 for p in inv['phrases']:
  target=value[p['key']];source=p['source'];assert isinstance(target,str) and target.strip(),('quest-empty',locale,p['key'])
  assert target.count('\n')==source.count('\n'),('quest-line-count',locale,p['key'])
  assert re.findall(r'\{\d+\}',target)==re.findall(r'\{\d+\}',source),('quest-placeholders',locale,p['key'])
  assert not re.search(r'<[^>]+>',target)
  if source.endswith(', '):assert target.endswith(', '),('region-comma-join',locale,p['key'])
  if source=='DONE - ':assert target.endswith(' '),('done-prefix-join',locale)
  assert target==target.strip(' \t\r') or source.endswith(' ') and target.endswith(' ') and target[:-1]==target[:-1].strip(' \t\r')
 return value

def new_records(locale):
 w=words(locale);glossary=json.loads((ROOT/'localization/glossary'/(locale+'.json')).read_text());records=[]
 old=json.loads((PACKET/'history/before-quests/manifest.json').read_text())
 assert hashlib.sha256((ROOT/'localization/glossary'/(locale+'.json')).read_bytes()).hexdigest()==old['locales'][locale]['glossarySha256']
 for u in inventory()['units']:
  target=glossary[u['glossaryId']]['term'] if 'glossaryId' in u else w[u['phrase']]
  record=dict(id=u['id'],source=u['source'],target=target)
  if target==u['source']:
   assert 'glossaryId' in u;record['unchangedReason']='Approved glossary title'
  records.append(record)
 assert len(records)==199;return records

def all_records(locale):
 old=[json.loads(l) for l in (PACKET/'history/before-quests'/(locale+'.jsonl')).read_text().splitlines()];assert len(old)==712
 return old+new_records(locale)

def source_addendum(existing):
 inv=inventory();assert len(existing)==712;assert not ({u['id'] for u in existing}&{u['id'] for u in inv['units']})
 units=[]
 for r in inv['units']:
  u=dict(r)
  if u['source'].endswith(' '):u['lineEnding']='space'
  units.append(u)
 pins={str(p.relative_to(ROOT)):hashlib.sha256(p.read_bytes()).hexdigest() for p in [SOURCE/'inventory.json',SOURCE/'code.json',SOURCE/'counter-validation.json',ROOT/'tools/inspect_quest_family.py',ROOT/'tools/quest_supplement.py',ROOT/'tools/quest_patch/Program.cs',ROOT/'tools/quest_layout/QuestLayout.cs',ROOT/'tools/russian_quest_family.py']}
 return units,inv['preserveExactly'],pins
