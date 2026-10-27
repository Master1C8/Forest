"""Approved journal header terms in all24 actual TMP fields;legacy Images stay disabled."""
import copy,hashlib,json,re,unicodedata
from pathlib import Path
ROOT=Path('/Users/antonkrutov/Desktop/Forest');SOURCE=ROOT/'localization/source/quest-family-ui-20261028';PACKET=ROOT/'localization/supplemental-ui/20261027'
def sha(p):return hashlib.sha256(Path(p).read_bytes()).hexdigest()
def inventory():return json.loads((SOURCE/'journal-header-addendum.json').read_text())
def render(unit,glossary,locale):
 term=glossary[unit['glossaryId']]['term'];term=term.replace('i','İ').replace('ı','I') if locale=='tr' else term;title=term.upper();end=1
 while end<len(title) and unicodedata.category(title[end]).startswith('M'):end+=1
 assert title and '<' not in title;sizes=re.findall(r'<size=(\d+)>',unit['source']);assert len(sizes)==2 and sizes[0]==sizes[1]
 return '<size='+sizes[0]+'>'+title[:end]+'</size>'+title[end:]
def validate(unit,target,glossary,locale):
 assert target==render(unit,glossary,locale);assert len(re.findall(r'<size=(22|30)>',target))==1 and target.count('</size>')==1
 return True
def records(locale):
 scope=json.loads((PACKET/'locale-scope.json').read_text());assert locale in scope['targetLocales'];p=ROOT/'localization/glossary'/(locale+'.json');assert sha(p)==scope['approvedGlossaries']['locales'][locale]['sha256'];g=json.loads(p.read_text());return [dict(id=r['id'],source=r['source'],target=render(r,g,locale)) for r in inventory()['rows']]
def addendum(existing):
 inv=inventory();units=[{k:r[k] for k in ['id','family','source','glossaryId','hierarchy']} for r in inv['rows']];assert len(existing)==911 and len(units)==24 and not {r['id'] for r in existing}&{r['id'] for r in units};return units,inv['preserveExactly'],{str(p.relative_to(ROOT)):sha(p) for p in [SOURCE/'journal-header-addendum.json',Path(__file__)]}
def load_inputs():
 local=Path(__file__).parent
 if (local/'journal-header-pins.json').exists():
  for n,h in json.loads((local/'journal-header-pins.json').read_text()).items():assert sha(local/n)==h
  return json.loads((local/'journal-header-inventory.json').read_text()),json.loads((local/'journal-header-targets.json').read_text())
 return inventory(),records('ru')
def snapshot(folder):
 import shutil
 shutil.copy2(Path(__file__),folder/'journal_header_ui.py');inv,rows=load_inputs()
 for n,v in [('journal-header-inventory.json',inv),('journal-header-targets.json',rows)]:(folder/n).write_text(json.dumps(v,ensure_ascii=False,indent=2)+'\n')
 (folder/'journal-header-pins.json').write_text(json.dumps({n:sha(folder/n) for n in ['journal-header-inventory.json','journal-header-targets.json']},indent=2)+'\n')
def plan(objects,generator):
 from extract_assets import read_tree
 inv,rows=load_inputs();targets={r['id']:r for r in rows};result={}
 for r in inv['rows']:
  t=read_tree(objects[r['pathId']],generator);assert t==r['sourceTree'],('journal-header-before-tree',r['pathId']);target=targets[r['id']];assert target['source']==t['m_text'];t=copy.deepcopy(t);t['m_text']=target['target'];result[r['pathId']]=t
 for pid in [18877,18883]:assert read_tree(objects[pid],generator)['m_Enabled']==0,'legacy-heading-Image-must-stay-disabled'
 assert len(result)==24;return result,dict(fields=24,terms=['tfol-053','tfol-054'],onlyTextChanged=True,sourceFontSizesAndRectsPreserved=True,dropCap='Complete approved uppercased term,first grapheme uses original22/30 emphasis;source second emphasis adapts to target title;no first glyph splitting of combining marks',legacyImagesRemainDisabled=True)
