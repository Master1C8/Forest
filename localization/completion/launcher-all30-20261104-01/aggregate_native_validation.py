"""Reuse exact old native checks and join the three newly read-back locales."""
from pathlib import Path
import json,hashlib
R=Path('/Users/antonkrutov/Desktop/Forest');C=R/'localization/completion/launcher-all30-20261104-01';W=R/'dist/macos-installer-work'
def h(p):return hashlib.sha256(p.read_bytes()).hexdigest()
oldpath=C/'baseline-MacOS-native-resources.json';old=json.loads(oldpath.read_bytes());build=json.loads((C/'baseline-MacOS-build-receipt.json').read_bytes());assert old['passed'] and h(oldpath)==build['sourcePins']['MacOS/native-resources.json']
originals=R/'MacOS/original-inputs.json';assert h(originals)==build['sourcePins']['MacOS/original-inputs.json'];(C/'baseline-MacOS-original-inputs.json').write_bytes(originals.read_bytes())
oldby={r['locale']:r for r in old['localesEvidence']};fresh={}
for code in ['hi','sw','uk']:
 p=C/(code+'-native-resource-validation.json');d=json.loads(p.read_bytes());assert d['passed'] and d['locales']==1;fresh[code]=d['localesEvidence'][0]
records=json.loads((W/'resources.json').read_bytes());compiled={r['locale']:r for r in json.loads((R/'Windows/compiler-receipts.json').read_bytes())['locales']};assert len(records)==len(compiled)==30
proofs=[]
for record in records:
 code=record['locale'];evidence=(fresh if code in fresh else oldby)[code];assert evidence['languageSha256']==record['languageSha256']==compiled[code]['languageSha256'];assert evidence['files']==record['files'] and len(record['files'])==14
 for name,pin in record['files'].items():
  p=W/'overlays'/code/name;assert p.stat().st_size==pin['bytes'] and h(p)==pin['sha256']
 assert evidence['bundleReadback']['serializedExact'] and evidence['bundleReadback']['completeNativeStreamExact']
 entry=dict(evidence);entry['readbackOrigin']='new-current-attempt' if code in fresh else 'retained-exact-version-matching-published-evidence';proofs.append(entry)
result=dict(passed=True,locales=30,resources=14,completeNativeStreamingReadbacks=30,newCompleteNativeStreamingReadbacks=3,reusedVersionMatchingNativeStreamingReadbacks=27,retainedEvidence=dict(path=str(oldpath.relative_to(R)),sha256=h(oldpath),buildReceiptSha256=h(C/'baseline-MacOS-build-receipt.json'),originalInputsSha256=h(originals)),gameLaunched=False,rendererAcceptance='not-run',boundary='Exact current native resource bytes; three fresh complete stream readbacks plus27 preserved version-matching readbacks. Excludes Unity execution/rendering.',localesEvidence=proofs)
(R/'MacOS/native-resources.json').write_text(json.dumps(result,sort_keys=True,indent=2)+'\n');print('Native resource evidence: all30 exact versions,27 retained +3 newly verified')
