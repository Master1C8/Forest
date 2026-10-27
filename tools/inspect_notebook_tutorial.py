"""Inspect the complete source notebook tutorial family, without changing assets."""
import json,hashlib
from pathlib import Path
import UnityPy
from UnityPy.helpers.TypeTreeGenerator import TypeTreeGenerator
from extract_assets import read_tree
ROOT=Path(__file__).resolve().parents[1]
DATA=ROOT/'localization/previews/ru-20261027-items-fixed/game/The Forest of Love_Data'
gen=TypeTreeGenerator('2020.3.24f1');gen.load_local_dll_folder(str(DATA/'Managed'))
objects={o.path_id:o for o in UnityPy.load(str(DATA/'sharedassets2.assets')).objects};cache={};classes={}
def tree(pid):
 if pid not in cache:cache[pid]=read_tree(objects[pid],gen)
 return cache[pid]
def cls(pid):
 if pid not in classes:
  obj=objects[pid];classes[pid]=obj.parse_monobehaviour_head().m_Script.deref().read().m_ClassName if obj.type.name=='MonoBehaviour' else obj.type.name
 return classes[pid]
def rect(go):return next(c['component']['m_PathID'] for c in tree(go)['m_Component'] if cls(c['component']['m_PathID']) in ['Transform','RectTransform'])
def path(go):
 r=tree(rect(go));father=r['m_Father']['m_PathID']
 return (path(tree(father)['m_GameObject']['m_PathID'])+'/' if father else '')+tree(go)['m_Name']
def descendants(r):
 yield r
 for child in tree(r)['m_Children']:yield from descendants(child['m_PathID'])
controller=tree(15851);rootgo=controller['m_GameObject']['m_PathID'];rootrect=rect(rootgo)
rows=[];images=[];protected=[]
for r in descendants(rootrect):
 go=tree(r)['m_GameObject']['m_PathID'];hierarchy=path(go)
 for comp in tree(go)['m_Component']:
  pid=comp['component']['m_PathID'];kind=cls(pid)
  if kind in ['TextMeshProUGUI','Text']:
   value=tree(pid);field='m_text' if kind=='TextMeshProUGUI' else 'm_Text';text=value[field]
   row=dict(id=f'sharedassets2.assets:{pid}/{field}',pathId=pid,field=field,kind=kind,source=text,hierarchy=hierarchy,sourceTree=value,rectId=r,sourceRect=tree(r))
   if text.strip():rows.append(row)
   else:protected.append(dict(id=row['id'],value=text,reason='Blank layout/label state'))
  if kind=='Image':
   value=tree(pid);images.append(dict(id=f'sharedassets2.assets:{pid}',hierarchy=hierarchy,sprite=value['m_Sprite']))
result=dict(schemaVersion=1,source='sharedassets2.assets',sourceSha256=hashlib.sha256((DATA/'sharedassets2.assets').read_bytes()).hexdigest(),controllerId=15851,controller=controller,root=rootgo,pages=controller['pages'],rows=rows,images=images,preserveExactly=protected)
phrase_sources={}
for row in rows:
 text=row['source'];normalized=text.replace('\r\n','\n').replace('\r','\n')
 if row['kind']=='Text':row['classification']='report-only paired legacy label; visible action name is a preserved sprite';continue
 row['classification']='display'
 if text=='<size=22>T</size>':key='title-first'
 elif text=='HE <size=22>N</size>OTEBOOK':key='title-rest'
 elif text.startswith('<size=22>'):key='title-small'
 elif text.startswith('<size=36>'):key='title-large'
 elif text=='(Tutorial)':key='caption'
 elif text.startswith("You've obtained"):key='intro'
 elif text.startswith('The Critters'):key='switch'
 elif text.startswith('The TALK'):key='talk'
 elif text.startswith('GOSSIP will'):key='details'
 elif text.startswith('All of your'):key='quests'
 elif text.startswith('As you meet'):key='critters'
 else:raise AssertionError(text)
 row['phrase']=key;row['lineEndings']=__import__('re').findall(r'\r\n|\r|\n',text);phrase_sources[key]=normalized
result['phraseSources']=phrase_sources
result['scope']='All five pages of GossipTutorialRedux15851;156 TMP display fields;30 paired native action labels and all38 Images preserved under texture-only rule'
result['specialCases']={'title':'Source two English word-initial emphasis spans become the target title first grapheme plus remainder; retain supported size22/36 syntax, valid nesting and the complete approved Notebook concept. Shared source IDs remain the same.','spriteLabels':'Body instructions retain exact TALK/GOSSIP label identifiers because their paired sprite artwork remains English under owner instruction. The localized Gossip concept may be supplied beside that literal.','lineBreaks':'Preserve the exact LF/CRLF/CR sequence per field, including trailing separators; target wording uses matching logical LF boundaries.'}
out=ROOT/'localization/source/notebook-tutorial-ui-20261027/inventory.json'
raw=(json.dumps(result,ensure_ascii=False,indent=2)+'\n').encode()
if out.exists():assert out.read_bytes()==raw,'notebook-inventory-drift'
else:out.write_bytes(raw)
print('source fields',len(rows),'pages',len(controller['pages']))
