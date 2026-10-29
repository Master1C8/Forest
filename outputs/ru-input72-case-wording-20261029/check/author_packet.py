import json,hashlib
from pathlib import Path
R=Path('/Users/antonkrutov/Desktop/Forest');C=R/'outputs/ru-input72-case-wording-20261029/check';O=R/'localization/supplemental-ui/20261029-input-case72'
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def textsha(t):return hashlib.sha256(t.encode()).hexdigest()
def load(p):return json.loads(p.read_text())
def jl(p):return [json.loads(l) for l in p.read_text().splitlines()]
def write(n,x):(O/n).write_text(json.dumps(x,ensure_ascii=False,indent=2)+'\n')
def rows(n,x):(O/n).write_text(''.join(json.dumps(z,ensure_ascii=False,separators=(',',':'))+'\n' for z in x))
a=jl(C/'assigned.jsonl');sc=jl(O/'source-context.jsonl')
# Every phrase below is directly authored by the assigned model. Ordinals refer
# to the immutable assignment; this script only transfers and validates wording.
T={
1:'ВВОД',2:'РЕГИСТР',3:'ГОТОВО',4:'ВВОД',5:'ГОТОВО',
6:'Нажми любую клавишу',7:'Нажми любую клавишу',
8:'Текст можно ввести с обычной клавиатуры\nили с экранной — она поддерживает сенсорный экран и геймпад!',
9:'Нажми любую клавишу',10:'Нажми любую клавишу',11:'Нажми любую клавишу',12:'Нажми любую клавишу',
13:'ВВОД',14:'РЕГИСТР',15:'ВВОД',
16:'Нажми любую клавишу',17:'Нажми любую клавишу',18:'Нажми любую клавишу',19:'Нажми любую клавишу',20:'Нажми любую клавишу',21:'Нажми любую клавишу',22:'Нажми любую клавишу',23:'Нажми любую клавишу',24:'Нажми любую клавишу',25:'Нажми любую клавишу',26:'Нажми любую клавишу',27:'Нажми любую клавишу',28:'Нажми любую клавишу',29:'Нажми любую клавишу',30:'Нажми любую клавишу',
31:'Инв.',
32:'Нажми [Shift] или [X] на геймпаде, чтобы сделать рывок',
33:'Нажми [Shift] или [X] на геймпаде, чтобы сделать рывок',
34:'Нажми [Shift] или [X] на геймпаде, чтобы сделать рывок',
35:'Нажми [Shift] или [X] на геймпаде, чтобы сделать рывок',
36:'Нажми [Shift] или [X] на геймпаде, чтобы сделать рывок',
37:'Нажми [Shift] или [X] на геймпаде, чтобы сделать рывок',
38:'Когда закончишь, нажми [Escape] или [B] на геймпаде!',
39:'Когда закончишь, нажми [Escape] или [B] на геймпаде!',
40:'Когда закончишь, нажми [Escape] или [B] на геймпаде!',
41:'Когда закончишь, нажми [Escape] или [B] на геймпаде!',
42:'Когда закончишь, нажми [Escape] или [B] на геймпаде!',
43:'Когда закончишь, нажми [Escape] или [B] на геймпаде!',
44:'Инв.',
45:'Когда закончишь, нажми [Escape] или [B] на геймпаде!',
46:'Когда закончишь, нажми [Escape] или [B] на геймпаде!',
47:'ВВОД',48:'ГОТОВО',
49:'Текст можно ввести с обычной клавиатуры\nили с экранной — она поддерживает сенсорный экран и геймпад!',
50:'РЕГИСТР',51:'ВВОД',52:'РЕГИСТР',53:'ВВОД',54:'ГОТОВО',55:'ВВОД',
56:'Когда закончишь, нажми [Escape] или [B] на геймпаде!',
57:'Когда закончишь, нажми [Escape] или [B] на геймпаде!',
58:'Когда закончишь, нажми [Escape] или [B] на геймпаде!',
59:'Когда закончишь, нажми [Escape] или [B] на геймпаде!',
60:'Быстро нажимай [Spacebar] или [A] на геймпаде, чтобы сжимать мышцы!',
61:'Быстро нажимай [Spacebar] или [A] на геймпаде, чтобы сжимать мышцы!',
62:'Донеси семя до Скарлетт, пока оно свежее и тёплое.\n\n\nБыстро нажимай [Spacebar] или [A] на геймпаде, чтобы сжимать мышцы!',
63:'Донеси семя до Скарлетт, пока оно свежее и тёплое.\n\n\nБыстро нажимай [Spacebar] или [A] на геймпаде, чтобы сжимать мышцы!',
64:'Быстро нажимай [Spacebar] или [A] на геймпаде, чтобы сжимать мышцы!',
65:'Быстро нажимай [Spacebar] или [A] на геймпаде, чтобы сжимать мышцы!',
66:'Донеси семя до Скарлетт, пока оно свежее и тёплое.\n\n\nБыстро нажимай [Spacebar] или [A] на геймпаде, чтобы сжимать мышцы!',
67:'Донеси семя до Скарлетт, пока оно свежее и тёплое.\n\n\nБыстро нажимай [Spacebar] или [A] на геймпаде, чтобы сжимать мышцы!',
68:'Донеси семя до Скарлетт, пока оно свежее и тёплое.\n\n\nБыстро нажимай [Spacebar] или [A] на геймпаде, чтобы сжимать мышцы!',
69:'Донеси семя до Скарлетт, пока оно свежее и тёплое.\n\n\nБыстро нажимай [Spacebar] или [A] на геймпаде, чтобы сжимать мышцы!',
70:'Быстро нажимай [Spacebar] или [A] на геймпаде, чтобы сжимать мышцы!',
71:'Быстро нажимай [Spacebar] или [A] на геймпаде, чтобы сжимать мышцы!',
72:'Подарок Скарлетт. Этот полезный атлас помогает путешественникам ориентироваться в лесу! Открой его клавишей [M] или [Select].'
}
assert set(T)==set(range(1,73))
pins=load(O/'input-pins.json');reuse=[]
for i in [8,72]:
 x=a[i-1];ref=x['wordingReferences'][0];p=R/ref['path'];z=jl(p)[ref['line']-1];assert z['id']==x['bindingId'] and z['source']==x['source'] and z['target']==T[i];assert textsha(T[i])==ref['targetUtf8Sha256']
 acc=p.parent/'ru.acceptance.json';v=load(acc);assert v['targetSha256']==sha(p);pins[str(p)]=sha(p);pins[str(acc)]=sha(acc)
 evidence=[]
 if i==8:
  for e in v['evidence'].values():
   ep=p.parent/e['file'];assert sha(ep)==e['sha256'];q=load(ep);assert q['targetSha256']==sha(p) and q['status']=='passed';pins[str(ep)]=sha(ep);evidence.append({'path':str(ep),'sha256':sha(ep)})
 else:
  for name,expected in v['evidencePins'].items():
   ep=Path(name);assert sha(ep)==expected; pins[str(ep)]=expected
  # Exact accepted source/target row in the independent review input, plus row receipt.
  pp=R/'outputs/inventory-display-20261028/independent-01/review/pairs.jsonl';rr=R/'outputs/inventory-display-20261028/independent-01/review/reviews.jsonl'
  pair=[u for u in jl(pp) if u['id']==x['bindingId']];assert len(pair)==1 and pair[0]['target']==T[i] and pair[0]['source']==x['source']
  receipt=[u for u in jl(rr) if u.get('id')==x['bindingId']];assert len(receipt)==1;evidence=[{'path':str(rr),'sha256':sha(rr),'row':receipt[0]}]
 reuse.append({'id':x['bindingId'],'reference':ref,'verifiedSourceExact':True,'verifiedTargetUtf8Exact':True,'acceptance':str(acc),'acceptanceSha256':sha(acc),'evidence':evidence,'scope':'wording only; input-case contract and runtime separate'})
prepared=[]
for i,(x,s) in enumerate(zip(a,sc),1):
 assert x['bindingId']==s['assigned']['bindingId']
 group=('key-actions' if x['source'] in ['ENTER','SHIFT','DONE'] else 'press-any-key' if x['source']=='Press any key' else 'report-placeholder' if i in [8,49] else 'inventory-shortcut' if i in [31,44] else 'dash-instruction' if 32<=i<=37 else 'finish-instruction' if i in list(range(38,44))+[45,46,56,57,58,59] else 'map-instruction' if i==72 else 'plant-full-instruction' if i in [62,63,66,67,68,69] else 'plant-button-hint')
 prepared.append({'id':x['bindingId'],'ordinal':i,'locale':'ru','caseId':x['caseId'],'source':x['source'],'sourceValueSha256':x['sourceValueSha256'],'sourceUtf8Sha256':textsha(x['source']),'target':T[i],'targetUtf8Sha256':textsha(T[i]),'status':'reused' if i in [8,72] else 'prepared','solutionGroup':group,'currentRole':x['currentRole'],'typedLedger':x['typedLedger'],'displayOnly':True,'targetApplied':False,'bindingStatus':'proposal-only; source/adapter/runtime gates remain pending','reuseReference':x['wordingReferences'][0] if i in [8,72] else None})
rows('ru.initial.jsonl',prepared);rows('ru.prepared.jsonl',prepared);write('reused-receipts.json',reuse)
write('input-pins.json',pins)
write('process-binding.json',{'game':'The Forest of Love','version':'0.45','sourceLocale':'en','locale':'ru','type':'standard','stage':'translate-edit: bounded pretranslation special-case wording preparation','existingBinding':'README.md:1300','guideSha256':sha(R/'README.md'),'processReferences':{k:v for k,v in pins.items() if '/.codex/' in k or '/codex-skills/shared/' in k},'runtimeIdentity':load(C/'runtime-check.json'),'scope':'72 caption/instruction wording units; 337 context members are not new target units','ordinaryTranslationEntryAllowed':False,'sourceGateAccepted':False,'rootCheckpointWrite':'prohibited by assignment; finite handoff only'})
print('Authored 70; reused exact verified receipts 2; prepared target rows 72.')
