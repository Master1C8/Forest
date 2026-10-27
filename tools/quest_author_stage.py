"""Preserve directly authored Quest wording and bind the special-case preparation."""
import argparse,hashlib,json,re
from pathlib import Path
from quest_supplement import ROOT,SOURCE,PACKET,inventory,words,new_records
SPECIAL={f'quest.{n}' for n in [4,23,24,29,38,39,40,41,73,*range(110,118),136,137,138,*range(139,157)]}
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def authored(path):
 if path.suffix!='.tsv':return json.loads(path.read_text())
 value={}
 for line in path.read_text().splitlines():
  index,text=line.split('\t',1);assert index.isdigit();key='quest.'+index;assert key not in value
  value[key]=text.replace('\\n','\n')
 return value
def main():
 p=argparse.ArgumentParser();p.add_argument('action',choices=['context','special','merge','check']);p.add_argument('locale');p.add_argument('--input',type=Path);args=p.parse_args();locale=args.locale
 scope=json.loads((PACKET/'locale-scope.json').read_text());assert locale in scope['targetLocales'];path=PACKET/'quest-wording'/(locale+'.json');dec=SOURCE/'special-decisions';dec.mkdir(exist_ok=True)
 if args.action=='context':
  old=json.loads((PACKET/'wording.json').read_text()).get(locale) or json.loads((PACKET/'wording'/(locale+'.json')).read_text());g=json.loads((ROOT/'localization/glossary'/(locale+'.json')).read_text());print(json.dumps(dict(locale=locale,names=old['shortNames'],terms={k:v['term'] for k,v in g.items() if 44<=int(k.split('-')[1])<=115},aliases={k:g[k]['meaning'] for k in ['tfol-001','tfol-011']}),ensure_ascii=False));return
 if args.action=='special' and args.input:
  assert not path.exists();path.write_text(json.dumps(authored(args.input),ensure_ascii=False,indent=2)+'\n')
 value=json.loads(path.read_text())
 if args.action=='special':
  assert set(value)==SPECIAL and not (dec/(locale+'.json')).exists();assert set(re.findall(r'\{\d+\}',value['quest.139']))=={'{0}','{1}','{2}','{3}','{4}'};assert all(value[f'quest.{i}'].endswith(', ') for i in range(140,145));assert value['quest.146'].endswith(' ')
  (dec/(locale+'-wording.json')).write_bytes(path.read_bytes());record=dict(locale=locale,sourceInventorySha256=sha(SOURCE/'inventory.json'),glossarySha256=sha(ROOT/'localization/glossary'/(locale+'.json')),specialWordingSha256=sha(path),reviewedPhraseKeys=sorted(SPECIAL),reviewer='gpt-6.1-sol/high;coordinator author semantic review;not independent',cases=['greetings16 introduction-state combinations;directional DB and direction-free compiled labels distinct','storm independent queued branches,DONE prefix and dormant completion preserved','afterstorm32 regions x2 status states;source clause order,comma cleanup and all-complete-active anomaly retained','photo full three-step group;counter uses actual selected log identity and completion shift'],adapterValidation='counter-validation.json',pretranslationDecision='author-reviewed wording and feasible guarded identity adapter;separate runtime/resource/editorial gates retained')
  (dec/(locale+'.json')).write_text(json.dumps(record,ensure_ascii=False,indent=2)+'\n');print('special groups recorded',locale,len(value));return
 if args.action=='merge':
  extra=authored(args.input);expected={p['key'] for p in inventory()['phrases']}-SPECIAL;assert set(extra)==expected and set(value)==SPECIAL and not value.keys()&extra.keys()
  receipt=json.loads((dec/(locale+'.json')).read_text());assert sha(path)==receipt['specialWordingSha256']==sha(dec/(locale+'-wording.json'));value.update(extra);path.write_text(json.dumps(value,ensure_ascii=False,indent=2)+'\n')
 assert len(words(locale))==157 and len(new_records(locale))==199;print('complete authored Quest input',locale,'157 phrases;199 new records;26 approved glossary titles')
if __name__=='__main__':main()
