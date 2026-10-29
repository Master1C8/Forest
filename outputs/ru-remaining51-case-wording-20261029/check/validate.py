"""Deterministic data/grammar boundary checks; no semantic pass generation."""
import json,hashlib,pathlib,re,copy
R=pathlib.Path('/Users/antonkrutov/Desktop/Forest');C=R/'outputs/ru-remaining51-case-wording-20261029/check';O=R/'localization/supplemental-ui/20261029-remaining-case51'
def load(p):return json.loads(pathlib.Path(p).read_text())
def jl(p):return [json.loads(l) for l in pathlib.Path(p).open()]
def sha(p):return hashlib.sha256(pathlib.Path(p).read_bytes()).hexdigest()
def valsha(s):return hashlib.sha256(json.dumps(s,ensure_ascii=False).encode()).hexdigest()
A=jl(C/'assigned51.jsonl');contexts=jl(O/'source-context.jsonl');P=jl(O/'preserve-exactly.jsonl');rows=jl(O/'ru.prepared.jsonl');pins=load(O/'input-pins.json');accepted=jl(R/'localization/supplemental-ui/20261029-chapter-gallery-case/ru.edited.jsonl');amap={r['id']:r for r in accepted}
B='localization/source/shared-source-completion-20261028/'
cache={}
def filejl(p):
 if p not in cache:cache[p]=jl(R/p)
 return cache[p]
def protected_validate(ps):
 assert len(ps)==len(P),'preserve-count'
 for p in ps:
  if p['kind']=='BG-unselected-field':assert filejl(p['file'])[p['line']-1]==p['cell'],'preserve-BG-exact'
  elif p['kind']=='Adventure-protected-identity':assert {k:v for k,v in p.items() if k!='kind'} in filejl(B+'adventure-source/preserve-exactly.jsonl'),'preserve-Adventure-identity'
  elif p['kind']=='unselected-producer-instruction':
   method=filejl(p['path'])[p['line']-1];assert method['method']==p['method'],'preserve-method-identity'
   assert p['instruction'] in method['instructions'],'preserve-instruction-exact'
  else:
   assert p['kind']=='selected-source-contract','preserve-kind'
   a=next(a for a in A if a['id']==p['id']);assert a['source']==p['source'] and a['sourceValueSha256']==p['sourceValueSha256'],'preserve-source-exact'
def grammar(s):
 tokens=[];stack=[];i=0
 while i<len(s):
  if s[i]=='<':
   m=re.match(r'</?(?:SIZE|size)(?:=(?:10|22))?>',s[i:]);assert m,'grammar-tag'
   t=m.group();assert t in ['<SIZE=22>','</SIZE>','<size=10>','</size>'],'grammar-tag-supported'
   if t.startswith('</'):assert stack and stack.pop()==t[2:-1],'grammar-nesting'
   else:stack.append(t[1:].split('=')[0])
   tokens.append(t);i+=len(t)
  elif s.startswith('[pic=',i):
   m=re.match(r'\[pic=\d+\]',s[i:]);assert m,'grammar-pic';tokens.append(m.group());i+=len(m.group())
  elif s[i]=='{':
   m=re.match(r'\{\d+\}',s[i:]);assert m,'grammar-placeholder';tokens.append(m.group());i+=len(m.group())
  elif s[i] in ['}','[',']']:raise AssertionError('grammar-delimiter')
  elif s[i]=='\n':tokens.append('\n');i+=1
  else:i+=1
 assert not stack,'grammar-unclosed';return tokens
def validate(rs,ps=P):
 assert len(rs)==51 and len({r['id'] for r in rs})==51,'coverage-unique51'
 assert [r['id'] for r in rs]==[a['id'] for a in A],'coverage-order'
 for i,(a,r,c) in enumerate(zip(A,rs,contexts)):
  assert r['source']==a['source'] and r['sourceValueSha256']==a['sourceValueSha256']==valsha(a['source']),'source-binding'
  assert r['ordinal']==i and r['locale']=='ru' and r['targetApplied'] is False,'row-contract'
  assert r['sourceUtf8Sha256']==hashlib.sha256(a['source'].encode()).hexdigest(),'source-raw-hash'
  t=r['target'];assert isinstance(t,str) and t,'target-required'
  assert r['targetUtf8Sha256']==hashlib.sha256(t.encode()).hexdigest(),'target-hash'
  assert grammar(t)==grammar(a['source']),'protected-control-order'
  assert re.search(r'\s*$',t).group()==c['protectedControls']['trailingWhitespace'],'trailing-whitespace'
  assert '\\n' not in t and '\r' not in t,'raw-newline-contract'
  if i in [19,20,21]:assert t==amap[a['id']]['target'] and a['source']==amap[a['id']]['source'],'accepted-reuse'
  if i==32:assert t.startswith('[pic=2]') and t.count('[pic=2]')==1,'portrait-prefix'
 protected_validate(ps)
 return True
for p,h in pins.items():assert sha(R/p)==h,'input changed: '+p
assert load(C/'runtime-check.json')['status']=='verified'
# Actual saved supported assemblies and saved whole-method readback, not source-string membership.
original=R/'localization/probes/ru-20261026-11/game/The Forest of Love_Data/Managed/Assembly-CSharp.dll';assert sha(original)=='46f43b212709b96ac51f2484d1564f863346fed8dc70f532860046226a020acf'
pre=R/'localization/previews/ru-20261029-chapter-gallery-02';code=load(pre/'chapter-gallery-code-readback.json');dll=pre/'game/The Forest of Love_Data/Managed/Assembly-CSharp.dll';assert sha(dll)==code['targetSha256']
assert validate(rows)
neg=[]
def negative(name,idx,change,expected):
 r=copy.deepcopy(rows);change(r[idx]);r[idx]['targetUtf8Sha256']=hashlib.sha256(r[idx]['target'].encode()).hexdigest()
 try:validate(r)
 except AssertionError as e:
  assert str(e)==expected,(name,str(e),expected);neg.append({'name':name,'positive':'unchanged complete51 passes same validator','rejection':str(e),'passed':True});return
 raise AssertionError('negative accepted '+name)
negative('changed-format-argument',19,lambda r:r.update(target=r['target'].replace('{0}','{1}')),'protected-control-order')
negative('changed-portrait-control',32,lambda r:r.update(target=r['target'].replace('[pic=2]','[pic=3]')),'protected-control-order')
negative('changed-ornamental-size',33,lambda r:r.update(target=r['target'].replace('22','10',1)),'grammar-tag-supported')
negative('removed-status-LF',23,lambda r:r.update(target=r['target'].rstrip('\n')),'protected-control-order')
negative('removed-concat-space',25,lambda r:r.update(target=r['target'].rstrip(' ')),'trailing-whitespace')
negative('changed-source-with-rehashed-target',0,lambda r:r.update(source=r['source']+'!'),'source-binding')
negative('duplicate-ID',1,lambda r:r.update(id=rows[0]['id']),'coverage-unique51')
ps=copy.deepcopy(P);p=next(p for p in ps if p['kind']=='BG-unselected-field' and p['cell']['field']=='actor');p['cell']['source']='wrong-actor'
try:protected_validate(ps)
except AssertionError as e:
 assert str(e)=='preserve-BG-exact';neg.append({'name':'changed-BG-actor-relation','positive':'unchanged complete2135-record manifest passes the same exact-record comparison','rejection':str(e),'passed':True})
else:raise AssertionError('changed actor accepted')
result={'status':'passed-deterministic-preparation-only','rows':51,'sourceBindings':51,'targetControlsAndRawLF':51,'exactProtectedRecords':len(P),'inputPinsVerified':len(pins),'positiveControl':True,'negativeControls':neg,'actualSavedOriginalAssemblySha256':sha(original),'actualSavedBuild02AssemblySha256':sha(dll),'savedBuild02WholeMethodInventory':code['methodCount'],'alreadyProjectedAcceptedOperands':3,'newTargetApplication':False,'semanticJudgment':False,'runtime':'not-run','boundary':'Validates exact frozen inputs, prepared target grammar/joins and preserve manifest. No patcher/game/renderer invoked; negative mutations are in-memory copies only. Complete51 unchanged positive satisfies all other guards before each isolated negative.','files':{n:sha(O/n) for n in ['source-context.jsonl','preserve-exactly.jsonl','ru.initial.jsonl','ru.prepared.jsonl','input-pins.json']}}
(C/'preflight.json').write_text(json.dumps(result,ensure_ascii=False,indent=2)+'\n');print(json.dumps({k:v for k,v in result.items() if k not in ['files','negativeControls']},indent=2));print('Intended-boundary negatives:',len(neg))
