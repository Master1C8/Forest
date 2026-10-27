"""Deterministic class inventory from explicit authored selectors; no verdict generation."""
import pathlib,json,re,unicodedata,hashlib
R=pathlib.Path(__file__).parent;P=R.parents[1]/'independent-batches-v1/ru'
rows=[json.loads(l) for l in (P/'full-pairs.jsonl').read_text().splitlines()]
findings=[json.loads(l) for l in (R/'findings.jsonl').read_text().splitlines()]
norm=lambda s:re.sub(r'\s+',' ',re.sub(r'^(?:\[pic[ac]?=[0-9A-Za-z_]+\])*','',unicodedata.normalize('NFKC',s).casefold()).translate(str.maketrans({'’':"'",'‘':"'",'–':'-','—':'-','‑':'-'}))).strip()
sources={norm(x['source']) for x in rows if x['id'] in {x['id'] for x in findings}}
spec=[
('provider-recipient',r'sexual favou?rs?|business transactions?|work and pleasure',None),
('enthusiasts',r'enthusiast|popular kinks',r'знаток'),
('trend-love',r'current trend|love of course',r'^\[pic=4\]Любви'),
('anonymous-planter',r'whoever|planted',None),
('duration-approval',r"didn.t take long|guy.s got it",r'продержал'),
('fixed-expression',None,r'то,? что надо'),
('saliva-inference',r'saliva|spit on',None),
('cute-judgment',r'cute too|lady thought',None),
('cleaning-method',r'clean(?:ing|ed)? (?:you|me|him|her|them|us|it)?\s*(?:off|up)|clean (?:off|up)|clean you',r'вылиз|слиз'),
('appreciation-object',r'appreciate',r'мы (?:очень )?ценим'),
('toy-agreement',r'\b(?:dildo|toy)\b',None),
('gift-custom',r'customary|anonym|\bsaint\b',None),
('probability-strength',r'probably|perhaps|\blikely\b|\bmaybe\b',r'наверняка|несомненно|безусловно'),
('sure-belief',r"\b(?:i.m|i am) sure\b|\bsure of\b",None),
('tight-stretch',r'stretch|tight fit',None),
('spying-time',r'spying|peeped|catch her',None),
('collection-after',r'after.*collect|collect.*after',None),
('light-source',r'\b(?:a|the|some|you|get|find|source of) light\b|lantern|fireflies',r'раздобыть.*свет|источник света'),
('funeral-callback',r'funeral|sacrific',None),
('why-ask',r'why.*ask|what.*ask',r'что вы спрашиваете'),
('fear-degree',r'terrifi|petrifi|scared|afraid|fear',None),
]
classes={}; union=set()
for name,sp,tp in spec:
 hits=[]
 for x in rows:
  sm=bool(sp and re.search(sp,x['source'],re.I));tm=bool(tp and re.search(tp,x['target'],re.I))
  yes=(sm and tm) if name=='probability-strength' else sm or tm
  if yes:hits.append(x['id']);union.add(x['id'])
 classes[name]={'sourceRegex':sp,'targetRegex':tp,'mode':'AND' if name=='probability-strength' else 'OR','ids':hits}
repeats=[x['id'] for x in rows if norm(x['source']) in sources];union.update(repeats)
classes['normalized-finding-repetitions']={'normalization':'NFKC, apostrophe/dash variants, casefold, whitespace','ids':repeats}
(R/'class-spec.json').write_text(json.dumps(classes,ensure_ascii=False,indent=2)+'\n')
selected=[x for x in rows if x['id'] in union]
(R/'class-rows.jsonl').write_text(''.join(json.dumps(x,ensure_ascii=False,separators=(',',':'))+'\n' for x in selected))
for name,x in classes.items():print(name,len(x['ids']))
print('union',len(selected))
