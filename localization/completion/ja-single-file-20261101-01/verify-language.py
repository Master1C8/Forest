"""Version-bound wording, preservation and conservative font-corpus proof."""
import hashlib,json,unicodedata
from pathlib import Path
ROOT=Path(__file__).resolve().parents[3]
sha=lambda b:hashlib.sha256(b).hexdigest()
read=lambda p:json.loads(p.read_bytes())
bind=lambda p:dict(path=str(p.relative_to(ROOT)),sha256=sha(p.read_bytes()))
base=ROOT/'localization/editorial-delivery/ja-single-file-20261101-01'
control=ROOT/'localization/completion/ja-single-file-20261101-01'
language=ROOT/'localization/languages/ja.json';d=read(language);old=read(base/'ja.json')
changes=read(base/'repair-01/changes.json');ids={r['id'] for r in changes['changes']}
actual={i for i,r in d['translations'].items() if r!=old['translations'][i]}
assert actual==ids and len(actual)==7
assert all(isinstance(r['target'],str) for r in d['translations'].values())
assert all(r['source']==old['translations'][i]['source'] for i,r in d['translations'].items())
policy=read(control/'source-preservation.json')['baselinePreserved'];preserved=[]
for i,h in policy.items():
 row=d['translations'][i]
 assert sha(row['source'].encode())==h==sha(row['target'].encode()),i
 preserved.append(i)
assert len(preserved)==1781 and len(d['translations'])==14606
assert d['fonts']==old['fonts'] and d['fontAssets']==old['fontAssets'] and d['layout']==old['layout']
oldproof=read(base/'final-font-corpus.json');texts=[dict(id=i,target=v['target']) for i,v in sorted(d['translations'].items()) if i not in policy]
requirements={}
for form in ['raw','NFC','NFD']:
 normalized=[dict(id=r['id'],target=r['target'] if form=='raw' else unicodedata.normalize(form,r['target'])) for r in texts]
 cps=sorted({ord(c) for r in normalized for c in r['target'] if not unicodedata.category(c).startswith('C')})
 assert cps==oldproof['requirements'][form]['codepoints'] and not oldproof['requirements'][form]['missing'],form
 requirements[form]=dict(codepoints=cps,distinct=len(cps),corpusSha256=sha(json.dumps(normalized,ensure_ascii=False,separators=(',',':')).encode()),sameCharacterSetAsVerifiedPrimary=True,missing=[])
proof=dict(language=bind(language),primarySnapshot=bind(base/'ja.json'),exactChangedIds=sorted(actual),preservedExact=len(preserved),ordinaryCorpus=len(texts),fontRoles=d['fonts'],fontCoverageBasis=bind(base/'final-font-corpus.json'),requirements=requirements,sourcePolicy=bind(control/'source-preservation.json'),boundary='Exact source preservation and corpus/face equality reuse. Conservative full ordinary corpus checked against every selected face; not actual role allocation, native shaping/fallback/atlas/layout acceptance.')
(ROOT/'outputs/ja-single-file-20261101-01/final-language-corpus-proof.json').write_text(json.dumps(proof,ensure_ascii=False,indent=2)+'\n')
print(json.dumps(dict(units=14606,ordinary=len(texts),preservedExact=len(preserved),changes=len(actual),null=0,fontRoles=len(d['fonts']),characterSetsUnchanged=True)))
