"""Read-only verification of the finite42 delivered application handoff."""
import argparse
import hashlib
import json
from pathlib import Path
ROOT=Path('/Users/antonkrutov/Desktop/Forest')
HERE=Path(__file__).resolve().parent

def sha(path):
 h=hashlib.sha256()
 with path.open('rb') as f:
  for block in iter(lambda:f.read(1024*1024),b''):h.update(block)
 return h.hexdigest()
def read(path):return json.loads(path.read_bytes())
def main():
 p=argparse.ArgumentParser(description=__doc__);p.add_argument('--check',action='store_true',required=True);p.parse_args()
 manifest=read(HERE/'output-manifest.json')
 for name,info in manifest['files'].items():
  path=ROOT/name;assert path.stat().st_size==info['bytes'] and sha(path)==info['sha256'],name
 for name,info in read(HERE/'input-pins.json').items():
  path=ROOT/name;assert path.stat().st_size==info['bytes'] and sha(path)==info['sha256'],name
 result=read(HERE/'Result.json');assert result['status']=='complete-finite42-static-application-stage'
 assert result['appliedStaticFields']==42 and result['assigned']==150 and result['selectedWholePages']==7
 assert result['protectedInactiveFields']==78 and result['sourceHeldFields']==30
 assert not result['sourceGateAccepted'] and not result['ordinaryTranslationEntryAllowed'] and not result['wholeGameAccepted']
 w=ROOT/result['evidenceRoot']
 frozen=w/'execution-03/narrative'
 for name,digest in read(frozen/'narrative-snapshot.json')['files'].items():assert sha(frozen/name)==digest,('frozen-dependency',name)
 private=read(w/'verification-03/positive/Result.json')
 assert private['files']==result['files'] and private['wholeSerializedCABReversedByteExact'] and private['wholeBundleReversedByteExact'] and private['noOpBundleEqualsSource']
 assert private['bundleCompression']=='original-flags' and private['sourceBundleFlags']==private['savedBundleFlags']==194
 assert len(read(w/'verification-03/validation.json')['checks'])==192
 assert len(read(w/'guard-verification-01/validation.json')['checks'])==12
 assert len(read(w/'serialized-excluded-verification-03/validation.json')['checks'])==108
 assert read(w/'guard-reuse.json')['status']=='version-matching-owning-functions-unchanged'
 names=['verification-03/positive','verification-03/reproduced','verification-03/fresh-after-failure']
 def fingerprint(d):return {str(p.relative_to(d)):sha(p) for p in sorted(d.rglob('*')) if p.is_file()}
 assert len({json.dumps(fingerprint(w/name),sort_keys=True) for name in names})==1
 print('Finite42 application accepted:42 fields/seven whole pages;150 readbacks;192+12 controls;108 serialized exclusions;original compression;fresh-process bytes exact. Full build/runtime/global gates remain separate.')
if __name__=='__main__':main()
