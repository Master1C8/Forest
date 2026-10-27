"""Reconcile the complete Quest display family against existing verified source evidence."""
import hashlib,json,sys
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1];sys.path.insert(0,str(ROOT/'localization/source/bgdatabase-20261027'))
from decode_inventory import parse,variable_cells
SOURCE=ROOT/'localization/source/quest-family-ui-20261028'
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def build():
 p=ROOT/'assets/source-v2/text-assets/90744c19ec-resources.assets-320.bin';data=p.read_bytes();assert hashlib.sha256(data).hexdigest()=='41834cda2f3ea6f010234f3ca2332e31b95b990ab38a8940b0d92f000477fda9';env=parse(data)
 evidence=ROOT/'localization/source/bgdatabase-20261027/quest-progress/readback/visible-fields.jsonl';states=[json.loads(l) for l in evidence.read_text().splitlines()];assert len(states)==195
 catalog=json.loads((ROOT/'localization/supplemental-ui/20261027/history/before-quests/source-catalog.json').read_text());existing={u['id']:u for u in catalog['units']};en=json.loads((ROOT/'localization/glossary/en.json').read_text());terms={}
 for row in en:terms.setdefault(row['term'],[]).append(row['id'])
 protected=[];sheets=[]
 for name,selected in [('Quest',{'bio_title','bio_description'}),('QuestProgressLogText',{'log_text'})]:
  sheet=next(s for s in env['sheets'] if s['name']==name);sheets.append(dict(name=name,id=sheet['id'],rowIds=sheet['rowIds'],fields={f['name']:f['id'] for f in sheet['fields'] if f['name'] in selected}))
  for f in sheet['fields']:
   blob=data[f['valuesOffset']:f['valuesOffset']+f['valuesBytes']]
   if f['name'] not in selected:protected.append(dict(sheetId=sheet['id'],field=f['name'],fieldId=f['id'],expectedBlobSha256=hashlib.sha256(blob).hexdigest()))
   else:
    cells,_=variable_cells(dict(f,valuesHex=blob.hex()),len(sheet['rowIds']))
    for r in [r for r in states if r['sheet']==name and r['field']==f['name']]:assert sheet['rowIds'][r['rowIndex']]==r['rowId'] and (cells[r['rowIndex']].decode() if cells[r['rowIndex']] is not None else None)==r['source']
 units=[];retained=[];phrases=[];keys={}
 def phrase(source):
  if source not in keys:keys[source]='quest.'+str(len(phrases));phrases.append(dict(key=keys[source],source=source))
  return keys[source]
 for r in states:
  if r['source'] is None:continue
  u=dict(r,family='quest-family',context=r['sheet']+' row'+str(r['rowIndex'])+' '+r['field'])
  if u['id'] in existing:assert existing[u['id']]['source']==u['source'];retained.append(u['id']);continue
  if u['field']=='bio_title' and u['source'] in terms:
   assert len(terms[u['source']])==1;u['glossaryId']=terms[u['source']][0]
  else:u['phrase']=phrase(u['source'])
  units.append(u)
 code=json.loads((SOURCE/'code.json').read_text())
 for r in code['units']:units.append(dict(r,family='quest-code',context=r['method'],phrase=phrase(r['source'])))
 assert len(retained)==6 and len(units)==199 and len({u['id'] for u in units})==199 and not (set(existing)&{u['id'] for u in units});assert len(protected)==15
 pins=[p,evidence,ROOT/'localization/source/bgdatabase-20261027/quest-progress/history.il',ROOT/'localization/source/bgdatabase-20261027/quest-progress/pane.il',ROOT/'localization/source/bgdatabase-20261027/quest-consumers/quest-log.il',ROOT/'localization/source/bgdatabase-20261027/quest-consumers/dependency-groups.json',SOURCE/'code.json',SOURCE/'ui-overwritten-fields.json']
 return dict(schemaVersion=1,sourceSha256=sha(p),sourcePins={str(x.relative_to(ROOT)):sha(x) for x in pins},sourceStates=states,sheets=sheets,units=units,retainedExistingIds=retained,phrases=phrases,preserveExactly=protected,scope='All177 nonempty Quest title/description/log cells and28 compiled display operands. Six existing cells retained;199 new units. Eighteen null states,15 unselected columns,3 count format strings and original identities remain protected. Source UI placeholders are overwritten by actual consumers and preserved.',specialCases=['The3 lost-photo Contains predicates are replaced by provenance from original history selection and completion shifting;never compare target wording.','Afterstorm32 regional states x2 completion states retain fixed fragment order and exact source punctuation cleanup;all-regions-active source anomaly remains explicit.','Greetings16 encounter/intro combinations and independent notification branches preserve identities and order.','Storm independent queued outputs,quantity==7 versus>=7,dormant completion literal and DONE prefixes preserve source branches.'])
if __name__=='__main__':
 raw=(json.dumps(build(),ensure_ascii=False,indent=2)+'\n').encode();out=SOURCE/'inventory.json'
 if '--check' in sys.argv:assert out.read_bytes()==raw
 else:out.write_bytes(raw)
 d=json.loads(raw);print('199 new units;177 total DB display cells;28 code operands;',len(d['phrases']),'authored phrase groups;15 protected columns')
