"""Assemble seven independently accepted originals with explicit reuse evidence."""
import argparse,hashlib,json,os
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1];FAMILY=ROOT/'localization/screenshots/all30-owner-20261104-01'
def read(p):return json.loads(p.read_bytes())
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def write(p,v):p.write_text(json.dumps(v,ensure_ascii=False,indent=2)+'\n')
p=argparse.ArgumentParser(description=__doc__);p.add_argument('plan',type=Path);p.add_argument('--check-only',action='store_true');p.add_argument('--candidate',help='Use a separate final-<candidate> directory and preserve the earlier accepted set');a=p.parse_args();plan=read(a.plan);code=plan['locale'];assert a.candidate is None or a.candidate.isalnum();dest=FAMILY/code/('final-'+a.candidate if a.candidate else 'final');assert a.check_only or not dest.exists()
language=ROOT/'localization/languages'/(code+'.json');current=sha(language);native=Path(plan['nativeResources']);assert read(native/'manifest.json')['languageSha256']==current
assert sorted(r['order']for r in plan['frames'])==list(range(1,8)),'Exactly seven unique required frame orders'
images=[];reviews=[];bindings=[];originals=[]
affected=set(plan['affectedOrders']);assert affected<=set(range(1,8))
reuse=plan.get('reuseEvidence');previous=None
transition=plan.get('transitionEvidence');continuities=[];transition_orders=[]
if transition:
 assert a.candidate
 links=transition if isinstance(transition,list) else [transition]
 assert 1<=len(links)<=3
 for link in links:
  proof=Path(link['path']).resolve();assert proof.is_relative_to(FAMILY) and sha(proof)==link['sha256']
  continuity=read(proof);assert continuity['passed'] and continuity['locale']==code
  assert set(continuity['unaffectedOrders'])<set(range(1,8))
  if continuities:
   prev=continuities[-1]
   assert prev['newNativeManifestSha256']==continuity['oldNativeManifestSha256'] and prev['newLanguageSha256']==continuity['oldLanguageSha256']
  if continuity.get('unchangedNonHelperResources'):detail_proof=continuity['helperProof']
  else:
   assert continuity['exactRegisteredLayoutDelta']
   detail_proof=continuity['assetProof']
  detail_path=Path(detail_proof['path']).resolve()
  assert detail_path.is_relative_to(FAMILY) and sha(detail_path)==detail_proof['sha256'] and read(detail_path)['passed']
  continuities.append(continuity)
 assert continuities[-1]['newNativeManifestSha256']==sha(native/'manifest.json') and continuities[-1]['newLanguageSha256']==current
 assert len({link['oldNativeManifestSha256'] for link in continuities})==len(continuities)
if a.candidate and affected!=set(range(1,8)):
 assert reuse and sha(Path(reuse['path']))==reuse['sha256']
 evidence=read(Path(reuse['path']));assert evidence['passed'] and evidence['locale']==code
 assert evidence['newManifestSha256']==sha(native/'manifest.json') and set(evidence['unaffectedOrders'])==set(range(1,8))-affected
 for member in evidence.get('transitionChain',[]):
  member_path=Path(member['path']).resolve()
  assert member_path.is_relative_to(FAMILY) and sha(member_path)==member['sha256'] and read(member_path)['passed']
 previous=FAMILY/code/'final' if code!='ru' else FAMILY.parent/'ru-owner-20261104-final'
 accepted=read(previous/'acceptance.json');assert sha(previous/'acceptance.json')==evidence['previousAcceptanceSha256']
 assert accepted['gameClosed'] and not accepted['savedProgressWritten']
 if code=='ru':assert accepted['allVisualChecksPassed'] and accepted['screenCount']==7
 else:assert accepted['passed'] and accepted['allIndependentlyReviewed'] and accepted['frames']==7 and accepted['languageSha256']==evidence['oldLanguageSha256']
for frame in sorted(plan['frames'],key=lambda r:r['order']):
 order=frame['order'];source=Path(frame['capture']).resolve();review=Path(frame['review']).resolve();manifest=source/'native-manifest.json'
 ledger=read(review)
 if a.candidate and order not in affected:
  assert source==previous and review==previous/'review.json' and ledger['inputs']['nativeManifest']==sha(manifest)
  assert evidence['previousManifestSha256']==sha(manifest) and evidence['previousReviewSha256']==sha(review)
  captured_language=evidence['oldLanguageSha256']
 else:
  assert source.is_relative_to(FAMILY) and review.is_relative_to(FAMILY)
  capture=read(source/'capture.json');cleanup=capture['cleanup'];assert all(cleanup[k] for k in ['taskProcessStopped','ownerSaveSettingsUnchanged','taskSaveByteExact','bridgeRemoved','localizedAssemblyRestored','settingsRestored'])
  captured_language=capture['config']['languageSha256']
  if a.candidate:
   capture_version=capture['config']['nativeManifestSha256']
   if capture_version==sha(native/'manifest.json'):assert captured_language==current
   else:
    matched=[i for i,link in enumerate(continuities) if capture_version==link['oldNativeManifestSha256'] and captured_language==link['oldLanguageSha256']]
    assert len(matched)==1 and all(order in link['unaffectedOrders'] for link in continuities[matched[0]:])
    transition_orders.append(order)
 row=next(r for r in read(manifest)['images']if r['order']==order);judgment=next(r for r in ledger['images']if r['order']==order)
 assert row['locale']==judgment['locale']==code and judgment['filename']==row['sha256']+'.webp'
 assert not judgment['findings'] and all(v in ['passed','not-applicable']for v in judgment['checks'].values())
 assert judgment['reviewer'].startswith('gpt-6.1-sol/high;')
 original=source/'upload'/row['filename'];assert sha(original)==row['sha256']
 if captured_language!=current:assert (order not in affected and reuse) or order in transition_orders,'Changed language requires explicit unaffected-frame evidence'
 if a.candidate and 'provenance:crop' in ledger['inputs']:
  assert ledger['inputs']['provenance:original']==row['sha256']
  detail=next(r for r in ledger['images']if r['order']==5000+order)
  assert detail['locale']==code and detail['reviewer'].startswith('gpt-6.1-sol/high;') and not detail['findings']
  assert all(v in ['passed','not-applicable'] for v in detail['checks'].values())
 images.append(row);reviews.append(judgment);originals.append(original);bindings.append(dict(order=order,captureManifest=str(manifest),captureManifestSha256=sha(manifest),review=str(review),reviewSha256=sha(review),capturedLanguageSha256=captured_language))
if plan.get('reuseEvidence'):
 evidence=Path(plan['reuseEvidence']['path']);assert sha(evidence)==plan['reuseEvidence']['sha256']
if continuities:assert transition_orders,'Only supply a transition proof for an earlier bound capture that is actually reused'
if a.check_only:
 print(json.dumps(dict(locale=code,inputsValid=True,frames=7,filesystemModified=False)));raise SystemExit(0)
dest.mkdir();(dest/'upload').mkdir()
for original in originals:os.link(original,dest/'upload'/original.name)
write(dest/'native-manifest.json',dict(schemaVersion=1,kind='native-localization-capture',scope='Final seven requested '+code+' screenshots',images=images,sourceBindings=bindings))
write(dest/'review.json',dict(schemaVersion=1,inputs=dict(nativeManifest=sha(dest/'native-manifest.json')),images=reviews))
write(dest/'acceptance.json',dict(passed=True,locale=code,frames=7,allIndependentlyReviewed=True,sourceBindings=bindings,reuseEvidence=plan.get('reuseEvidence'),transitionEvidence=transition,reuseJustification=plan.get('reuseJustification'),languageSha256=current,nativeResources=str(native),savedProgressWritten=False,gameClosed=True))
print(json.dumps(dict(locale=code,accepted=7,final=str(dest))))
