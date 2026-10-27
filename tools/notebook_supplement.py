"""Append the complete current five-page notebook tutorial; preserve sprite wording."""
import hashlib,json,re,unicodedata
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
SOURCE=ROOT/'localization/source/notebook-tutorial-ui-20261027'
PACKET=ROOT/'localization/supplemental-ui/20261027'
KEYS={'caption','intro','switch','talk','details','quests','critters'}

def inputs():
 inv=json.loads((SOURCE/'inventory.json').read_text());wording=json.loads((PACKET/'notebook-wording.json').read_text())
 assert len(inv['pages'])==5 and len(inv['rows'])==186
 assert len(wording)==30 and all(set(w)==KEYS for w in wording.values())
 for locale,words in wording.items():
  for key,text in words.items():
   source=inv['phraseSources'][key]
   assert text and text.count('\n')==source.count('\n'),('notebook-line-count',locale,key)
   assert '\r' not in text
   for literal in ['TALK','GOSSIP']:
    assert text.count(literal)==source.count(literal),('actual-sprite-control-reference',locale,key,literal)
 return inv,wording

def source_addendum(existing):
 inv,_=inputs();units=[dict(id=r['id'],family='notebook',source=r['source'],phrase=r['phrase'],lineEndings=r['lineEndings'],context=r['hierarchy'],kind=r['kind']) for r in inv['rows'] if r['classification']=='display']
 assert len(existing)==556 and len(units)==156 and len({u['id'] for u in existing+units})==712
 protected=[dict(id=r['id'],expected=r['source'],reason=r['classification']) for r in inv['rows'] if r['classification']!='display']+inv['preserveExactly']
 pins={str(p.relative_to(ROOT)):hashlib.sha256(p.read_bytes()).hexdigest() for p in [SOURCE/'inventory.json',SOURCE/'layout.json',SOURCE/'paged-consumers.il',SOURCE/'consumer.il',SOURCE/'artwork-bindings.json',ROOT/'tools/notebook_supplement.py',ROOT/'tools/inspect_notebook_tutorial.py',ROOT/'tools/russian_notebook_ui.py']}
 return units,protected,pins

def title_parts(term):
 title=term.upper();end=1
 while end<len(title) and unicodedata.category(title[end]).startswith('M'):end+=1
 assert end<len(title) and '<' not in title
 return title[:end],title[end:]

def render(unit,words,glossary):
 key=unit['phrase']
 if key.startswith('title-'):
  first,rest=title_parts(glossary['tfol-071']['term'])
  if key=='title-first':return '<size=22>'+first+'</size>'
  if key=='title-rest':return rest
  return '<size='+('22' if key=='title-small' else '36')+'>'+first+'</size>'+rest
 value=words[key];ends=iter(unit['lineEndings'])
 return re.sub('\n',lambda _:next(ends),value)

def validate(unit,target,words,glossary):
 assert target==render(unit,words,glossary)
 assert re.findall(r'\r\n|\r|\n',target)==unit['lineEndings']
 if unit['phrase'].startswith('title-'):
  assert re.sub(r'</?size(?:=\d+)?>','',target)
  tags=re.findall(r'<[^>]+>',target);assert tags in ([],['<size=22>','</size>'],['<size=36>','</size>'])
 else:assert not re.search(r'<[^>]+>',target)
 return True
