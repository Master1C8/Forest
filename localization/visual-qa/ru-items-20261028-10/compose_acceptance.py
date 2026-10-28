"""Compose exact-source visual evidence; retain all original ledgers."""
import hashlib
import json
from pathlib import Path

HERE=Path(__file__).resolve().parent
DETAIL=HERE.with_name(HERE.name+'-icon-detail')
sha=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
load=lambda p:json.loads(p.read_text())

def verified(base):
    manifest=load(base/'native-manifest.json')
    ledger=load(base/'review.json')
    assert ledger['inputs']['provenance:sourceManifest']==sha(base/'native-manifest.json')
    assert len(manifest['images'])==len(ledger['images'])==2
    for source,row in zip(manifest['images'],ledger['images']):
        assert source['order']==row['order']
        assert ledger['inputs']['provenance:source-image:'+source['filename']]==source['sha256']
    return manifest,ledger

def clean(row):
    assert not row['findings']
    assert row['reviewer'].startswith('gpt-6.1-sol/high')
    assert all(value=='passed' or key=='rtl' and value=='not-applicable' for key,value in row['checks'].items())

original,old=verified(HERE)
followup,new=verified(DETAIL)
assert original['images'][0]['sha256']==followup['images'][0]['sha256']
binding=load(DETAIL/'crop-binding.json')
assert binding['sourceSha256']==original['images'][0]['sha256']
assert binding['cropSha256']==followup['images'][1]['sha256']
clean(new['images'][0]);clean(new['images'][1]);clean(old['images'][1])
result={'schemaVersion':1,'status':'passed-exact-source-crop-followup','acceptedNativeFrames':2,
    'nativeManifestSha256':sha(HERE/'native-manifest.json'),
    'primaryLedgerSha256':sha(HERE/'review.json'),'followupLedgerSha256':sha(DETAIL/'review.json'),
    'accepted':[{'filename':original['images'][0]['filename'],'nativeSha256':original['images'][0]['sha256'],
        'judgment':'Follow-up full-frame row1 with paired source-bound native-pixel crop row2','checks':new['images'][0]['checks']},
        {'filename':original['images'][1]['filename'],'nativeSha256':original['images'][1]['sha256'],
        'judgment':'Unchanged primary row2','checks':old['images'][1]['checks']}],
    'boundary':'Two actual item notification frames only. The diagnostic crop is not a third game capture. Original needs-review ledger remains unchanged. No source/editorial/full-game gate promoted.'}
output=HERE/'final-acceptance.json'
assert not output.exists()
output.write_text(json.dumps(result,indent=2)+'\n')
print(json.dumps({'status':result['status'],'acceptedNativeFrames':2}))
