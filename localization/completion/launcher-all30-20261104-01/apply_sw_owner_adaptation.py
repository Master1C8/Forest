"""Apply only the owner-selected seven-syllable pair, then prepare its exact review."""
from pathlib import Path
import copy,json,hashlib,subprocess,os,sys
R=Path('/Users/antonkrutov/Desktop/Forest');C=R/'localization/completion/launcher-all30-20261104-01';A=R/'outputs/launcher-all30-20261104-01/sw/repair-cloud-01';D=R/'localization/editorial-delivery/launcher-all30-20261104-01/sw/owner-adaptation-01'
def h(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def sh(s):return hashlib.sha256(s.encode()).hexdigest()
def rows(p):return [json.loads(l) for l in p.read_text().splitlines()]
def save(p,d):p.write_text(json.dumps(d,ensure_ascii=False,indent=2)+'\n')
def jl(p,rr):p.write_text(''.join(json.dumps(r,ensure_ascii=False)+'\n' for r in rr))
receipt=json.loads((A/'process-exit.json').read_bytes());assert receipt['exitCode']==0
runtime=json.loads((A/'runtime-verification.json').read_bytes());probe=subprocess.run(['ps','-p',str(runtime['pid']),'-o','command='],capture_output=True,text=True);assert str(A) not in probe.stdout,'Original author still alive'
owner=C/'sw-owner-poetic-adaptation.json';decision=json.loads(owner.read_bytes());assert decision['target']=='Nibebe mawinguni'
canonical=R/'localization/languages/sw.json';before=canonical.read_bytes();assert sh(before.decode())=='b73412e153efc70ac5940fd577d96520f3f2c5ac7e9e81a216c1c6f062316dfe'
D.mkdir(exist_ok=False);(D/'language-before.json').write_bytes(before);data=json.loads(before);tr=data['translations'];pair=['ds:303:407:Dialogue Text',next(k for k in tr if '::VNRevivalRuHaiku_Resolve(' in k and k.endswith('@62'))]
for k in pair:assert tr[k]['source']=='Take me high above the clouds' and tr[k]['target']=='Nirukishe mawingu';tr[k]['target']=decision['target']
final=(json.dumps(data,ensure_ascii=False,indent=2)+'\n').encode();(D/'language-final.json').write_bytes(final)
previous=json.loads(before);assert {k for k in tr if tr[k]!=previous['translations'][k]}==set(pair)
assert {k:v for k,v in data.items() if k!='translations'}=={k:v for k,v in previous.items() if k!='translations'}
old=R/'localization/editorial-delivery/launcher-all30-20261104-01/sw/repair-01';art=R/'localization/editorial-delivery/launcher-all30-20261104-01/sw/repair-cloud-01';basis=rows(art/'proposal-bounded-basis.jsonl')
for row in basis:
 row.pop('proposalOnly',None);row.get('context',{}).pop('proposedMeter',None)
 if row['id'] in pair:row['target']=decision['target'];row['targetSha256']=sh(row['target'])
 elif row['id'].startswith('derived:'):
  row['target']='\n'.join(tr[k]['target'] for k in row['context']['lineIds']);row['targetSha256']=sh(row['target'])
products=[r for r in basis if r['id'].startswith('derived:')];assert len(products)==27
affected=[r for r in products if pair[0] in r['context']['lineIds']];assert len(affected)==9
jl(D/'bounded-review-basis.jsonl',basis);jl(D/'all27-products.jsonl',products);jl(D/'authored-pair.jsonl',[r for r in basis if r['id'] in pair])
deps=[dict(id=r['id'],causedBy=[pair[0]],reason='The exact owner-approved in/among-cloud poetic adaptation changes this middle line; rejudge the complete original product without changing its original outcome identity.',evidence=dict(path=str(owner.relative_to(R)),sha256=h(owner))) for r in affected];jl(D/'invalidated-products.jsonl',deps)
subprocess.run([sys.executable,'-B',str(R/'tools/locale_review_work.py'),'prepare-scope','--packet',str(D/'bounded-review-basis.jsonl'),'--authored',str(D/'authored-pair.jsonl'),'--dependencies',str(D/'invalidated-products.jsonl'),'--output',str(D/'independent-delta')],check=True,cwd=R)
scope=json.loads((D/'independent-delta/scope.json').read_bytes());assert len(scope['primaryIds'])==2 and len(scope['reviewIds'])==11
# A single-file atomic commit. All selected evidence is written before changing canonical wording.
tmp=canonical.with_suffix('.owner-adaptation.pending');assert not tmp.exists();tmp.write_bytes(final);os.replace(tmp,canonical);assert h(canonical)==h(D/'language-final.json')
save(D/'application.json',dict(ownerDecision=dict(path=str(owner.relative_to(R)),sha256=h(owner)),languageBeforeSha256=sh(before.decode()),languageFinalSha256=h(canonical),changedIds=pair,other14604EntriesUnchanged=True,sourceAndControlValuesUnchanged=True,manualSyllables=['Ni','be','be','ma','wi','ngu','ni'],requiredMeter=[5,7,5],sourceAdaptation='In/among plural clouds replaces above clouds by explicit owner choice; first-person transport request remains.',independentAcceptance='pending',native='not-run'))
print(str(D.relative_to(R)))
