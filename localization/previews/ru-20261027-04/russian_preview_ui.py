"""Source-bound Russian preview display fields and TMP face-metric compensation.

No identity substitutions or per-string whitespace normalization. BGDatabase framing
is parsed by the existing pinned v5 reader. Only two Actor display cells are edited;
every other column blob and all schema/row identities are compared after decoding.
"""
import copy
import hashlib
import struct

WARNING_TEXT = {
 'This is an <u>ADULT GAME</u> featuring a ton\nof <u>EXPLICIT CONTENT.</u>':
 'Это <u>ИГРА ДЛЯ ВЗРОСЛЫХ</u> с обилием\n<u>ОТКРОВЕННОГО КОНТЕНТА.</u>',
 'This is an <color=#EE1005><u>ADULT GAME</u></color> featuring a ton\nof <color=#EE1005><u>EXPLICIT CONTENT.</u></color>':
 'Это <color=#EE1005><u>ИГРА ДЛЯ ВЗРОСЛЫХ</u></color> с обилием\n<color=#EE1005><u>ОТКРОВЕННОГО КОНТЕНТА.</u></color>',
 'If you are a kid, <u>GET OUTA HERE!</u>\nIf not, please enjoy!':
 'Если ты ребёнок, <u>УХОДИ ОТСЮДА!</u>\nА если нет — приятной игры!',
 'If you are a kid, <color=#EE1005><u>GET OUTA HERE!</u></color>\nIf not, please enjoy!':
 'Если ты ребёнок, <color=#EE1005><u>УХОДИ ОТСЮДА!</u></color>\nА если нет — приятной игры!',
}
ACTOR_ID = 'A5FQ9EyucE2xuZaKCq62yA'
DISPLAY_VALUES = {'nameplate_name': ('Scarlett', 'Скарлетт'),
                  'full_name': ('Scarlett Tenderpaw', 'Скарлетт Нежнолапка')}

def f32(x):
 return struct.unpack('<f', struct.pack('<f', x))[0]

def metric_spacing(old, new, spacing):
 """TMP uses lineSpacing * fontSize * .01, independently of face point size.

Preserve authored baseline distance after a face replacement, including its
cap-height scale. This applies to every binding, including outline/glow copies,
not just strings which currently contain an explicit newline. Evidence: shipped
TextMeshProUGUI.GenerateTextMesh IL_0356..037d, 0157..0177, 355e..35a6.
 """
 for face in (old, new):
  assert face['m_PointSize'] > 0 and face['m_Scale'] > 0 and face['m_LineHeight'] > 0, 'invalid-face-metrics'
 return f32(spacing + 100 * (old['m_LineHeight'] * old['m_Scale'] / old['m_PointSize']
                            - new['m_LineHeight'] * new['m_Scale'] / new['m_PointSize']))

def typography_plan(objects, generator, old_face, new_face, font_id, file_id=0):
 from extract_assets import read_tree
 plan, receipt = {}, []
 for pid,obj in objects.items():
  if obj.type.name != 'MonoBehaviour': continue
  if obj.parse_monobehaviour_head().m_Script.deref().read().m_ClassName != 'TextMeshProUGUI': continue
  tree=read_tree(obj,generator)
  if tree.get('m_fontAsset') != {'m_FileID': file_id, 'm_PathID': font_id}: continue
  before=tree['m_lineSpacing']; tree['m_lineSpacing']=metric_spacing(old_face,new_face,before)
  if tree.get('m_text') in WARNING_TEXT: tree['m_text']=WARNING_TEXT[tree['m_text']]
  plan[pid]=tree
  receipt.append({'pathId':pid,'sourceLineSpacing':before,'targetLineSpacing':tree['m_lineSpacing'],
                  'translatedWarning':tree.get('m_text') in WARNING_TEXT.values()})
 return plan, receipt

def replace_exact(value, before, after):
 # Equality, never substring tests: overlapping old/new values remain unambiguous.
 assert before != after, 'ambiguous-replacement'
 assert value == before, 'unexpected-before-value'
 return after

def project_actor_display(data, parse, variable_cells):
 env=parse(data); sheet=next(s for s in env['sheets'] if s['name']=='Actor')
 assert sheet['rowIds'].count(ACTOR_ID)==1, 'actor-identity-ambiguous'
 row=sheet['rowIds'].index(ACTOR_ID); edits=[]; receipts=[]
 for f in sheet['fields']:
  if f['name'] not in DISPLAY_VALUES: continue
  before,after=DISPLAY_VALUES[f['name']]
  start,size=f['valuesOffset'],f['valuesBytes']; blob=data[start:start+size]
  values,_=variable_cells(dict(f,valuesHex=blob.hex()),len(sheet['rowIds']))
  wanted=replace_exact(values[row].decode('utf-8'),before,after).encode('utf-8')
  n=struct.unpack_from('<i',blob)[0];pairs=[struct.unpack_from('<ii',blob,4+8*i) for i in range(n)]
  assert len({i for i,_ in pairs})==n and row in [i for i,_ in pairs]
  values[row]=wanted;total=0;newpairs=[];payload=b''
  for i,_ in pairs:
   assert values[i] is not None
   payload+=values[i];total+=len(values[i]);newpairs.append(struct.pack('<ii',i,total))
  newblob=struct.pack('<i',n)+b''.join(newpairs)+payload
  edits.append((start-4,start+size,struct.pack('<i',len(newblob))+newblob))
  receipts.append({'sheetId':sheet['id'],'rowId':ACTOR_ID,'rowIndex':row,'fieldId':f['id'],'field':f['name'],'source':before,'target':after})
 assert len(edits)==2, 'missing-display-field'
 result=data
 for a,b,v in sorted(edits,reverse=True):result=result[:a]+v+result[b:]
 verify_actor_projection(data,result,parse,variable_cells)
 return result,receipts

def verify_actor_projection(before,after,parse,variable_cells):
 a,b=parse(before),parse(after)
 assert len(a['sheets'])==len(b['sheets'])
 count=0
 for s,t in zip(a['sheets'],b['sheets']):
  assert {k:v for k,v in s.items() if k not in ('offset','endOffset','rowIdsOffset','fields')} == {k:v for k,v in t.items() if k not in ('offset','endOffset','rowIdsOffset','fields')}, 'schema-changed'
  assert len(s['fields'])==len(t['fields'])
  for f,g in zip(s['fields'],t['fields']):
   excluded={'offset','valuesOffset','valuesBytes','valuesSha256','valuesHex'}
   assert {k:v for k,v in f.items() if k not in excluded}=={k:v for k,v in g.items() if k not in excluded}, 'field-schema-changed'
   left=before[f['valuesOffset']:f['valuesOffset']+f['valuesBytes']];right=after[g['valuesOffset']:g['valuesOffset']+g['valuesBytes']]
   if s['name']=='Actor' and f['name'] in DISPLAY_VALUES:
    lv,_=variable_cells(dict(f,valuesHex=left.hex()),len(s['rowIds']));rv,_=variable_cells(dict(g,valuesHex=right.hex()),len(t['rowIds']))
    row=s['rowIds'].index(ACTOR_ID);old,new=DISPLAY_VALUES[f['name']]
    assert lv[row]==old.encode() and rv[row]==new.encode(), 'display-projection-mismatch'
    rv[row]=lv[row];assert rv==lv,'other-actor-display-changed';count+=1
   else:assert left==right,'unselected-column-changed'
 assert count==2
 return True


def load_bg_parser():
 from pathlib import Path
 import importlib.util
 local=Path(__file__).with_name('decode_inventory.py')
 path=local if local.is_file() else Path('/Users/antonkrutov/Desktop/Forest/localization/source/bgdatabase-20261027/decode_inventory.py')
 spec=importlib.util.spec_from_file_location('forest_bg_v5',path)
 module=importlib.util.module_from_spec(spec);spec.loader.exec_module(module)
 return module.parse,module.variable_cells
