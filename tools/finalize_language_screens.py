"""Assemble seven independently accepted originals with explicit reuse evidence."""
import argparse,hashlib,json,os
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1];FAMILY=ROOT/'localization/screenshots/all30-owner-20261104-01'
def read(p):return json.loads(p.read_bytes())
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def write(p,v):p.write_text(json.dumps(v,ensure_ascii=False,indent=2)+'\n')
p=argparse.ArgumentParser(description=__doc__);p.add_argument('plan',type=Path);p.add_argument('--check-only',action='store_true');a=p.parse_args();plan=read(a.plan);code=plan['locale'];dest=FAMILY/code/'final';assert a.check_only or not dest.exists()
language=ROOT/'localization/languages'/(code+'.json');current=sha(language);native=Path(plan['nativeResources']);assert read(native/'manifest.json')['languageSha256']==current
assert sorted(r['order']for r in plan['frames'])==list(range(1,8)),'Exactly seven unique required frame orders'
images=[];reviews=[];bindings=[];originals=[]
for frame in sorted(plan['frames'],key=lambda r:r['order']):
 order=frame['order'];source=Path(frame['capture']).resolve();review=Path(frame['review']).resolve();assert source.is_relative_to(FAMILY) and review.is_relative_to(FAMILY)
 manifest=source/'native-manifest.json';capture=read(source/'capture.json');cleanup=capture['cleanup'];assert all(cleanup[k] for k in ['taskProcessStopped','ownerSaveSettingsUnchanged','taskSaveByteExact','bridgeRemoved','localizedAssemblyRestored','settingsRestored'])
 row=next(r for r in read(manifest)['images']if r['order']==order);judgment=next(r for r in read(review)['images']if r['order']==order)
 assert row['locale']==judgment['locale']==code and judgment['filename']==row['sha256']+'.webp'
 assert not judgment['findings'] and all(v in ['passed','not-applicable']for v in judgment['checks'].values())
 assert judgment['reviewer'].startswith('gpt-6.1-sol/high;')
 original=source/'upload'/row['filename'];assert sha(original)==row['sha256']
 if capture['config']['languageSha256']!=current:
  assert order not in plan['affectedOrders'] and plan.get('reuseEvidence'),'Changed language requires explicit unaffected-frame evidence'
 images.append(row);reviews.append(judgment);originals.append(original);bindings.append(dict(order=order,captureManifest=str(manifest),captureManifestSha256=sha(manifest),review=str(review),reviewSha256=sha(review),capturedLanguageSha256=capture['config']['languageSha256']))
if plan.get('reuseEvidence'):
 evidence=Path(plan['reuseEvidence']['path']);assert sha(evidence)==plan['reuseEvidence']['sha256']
if a.check_only:
 print(json.dumps(dict(locale=code,inputsValid=True,frames=7,filesystemModified=False)));raise SystemExit(0)
dest.mkdir();(dest/'upload').mkdir()
for original in originals:os.link(original,dest/'upload'/original.name)
write(dest/'native-manifest.json',dict(schemaVersion=1,kind='native-localization-capture',scope='Final seven requested '+code+' screenshots',images=images,sourceBindings=bindings))
write(dest/'review.json',dict(schemaVersion=1,inputs=dict(nativeManifest=sha(dest/'native-manifest.json')),images=reviews))
write(dest/'acceptance.json',dict(passed=True,locale=code,frames=7,allIndependentlyReviewed=True,sourceBindings=bindings,reuseEvidence=plan.get('reuseEvidence'),reuseJustification=plan.get('reuseJustification'),languageSha256=current,nativeResources=str(native),savedProgressWritten=False,gameClosed=True))
print(json.dumps(dict(locale=code,accepted=7,final=str(dest))))
