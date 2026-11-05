"""Conservative advance-width preflight for the seven known Scarlett facts.

This reads the exact configured native face. It neither simulates Unity clipping
nor establishes shaping, wrapping, language or visual acceptance.
"""
import argparse,base64,hashlib,io,json
from pathlib import Path
import UnityPy
from fontTools.ttLib import TTFont
ROOT=Path(__file__).resolve().parents[1];FAMILY=ROOT/'localization/screenshots/all30-owner-20261104-01'
p=argparse.ArgumentParser(description=__doc__);p.add_argument('locales',nargs='+');p.add_argument('--apply',action='store_true');p.add_argument('--output',type=Path,required=True);a=p.parse_args()
ref=json.loads((ROOT/'localization/languages/fr.json').read_bytes())
sources={'BDSM - Dom','Switch','Interspecies','Town Gossip','Farmer Past','“The Town Mom”','Married'}
ids={r['source']:k for k,r in ref['translations'].items() if k.startswith('bgdb:resources.assets:320/sheet/l7q0WkqA70qZcKsOchc8NQ/') and r['source'] in sources}
assert set(ids)==sources
asset=ROOT/'localization/framework/forest045-shared/base/sharedassets0.assets';env=UnityPy.load(str(asset));base=bytes(next(o for o in env.objects if o.path_id==369).read_typetree()['m_FontData'])
roles=[r['pathId'] for r in json.loads((FAMILY/'fr/resident-field-inventory.json').read_bytes())];assert len(roles)==15
records=[]
for code in a.locales:
 path=ROOT/'localization/languages'/(code+'.json');old=path.read_bytes();doc=json.loads(old);spec=doc.get('fonts',{}).get('sharedassets0.assets:369');raw=base if spec is None else base64.b64decode(doc['fontAssets'][spec['asset']]);font=TTFont(io.BytesIO(raw));cmap=font.getBestCmap();units=font['head'].unitsPerEm
 rows=[];missing=set()
 for source,k in sorted(ids.items()):
  row=doc['translations'][k];assert row['source']==source;target=row['target'];missing.update(c for c in target if ord(c)not in cmap)
  width=sum(font['hmtx'][cmap[ord(c)]][0] for c in target if ord(c)in cmap)/units
  rows.append(dict(id=k,source=source,target=target,advanceAt10=round(width*10,3)))
 maximum=max(r['advanceAt10'] for r in rows);size=next((s for s in [10,9,8] if maximum*s/10<=80),None) if not missing else None
 changed=False
 if a.apply and size is not None and size<10:
  assert code not in ['ru','de','fr','es','pt-BR'],'Preserve already captured or live exact-version inputs'
  for pid in roles:doc['layout']['sharedassets2.assets:'+str(pid)]=size
  path.write_text(json.dumps(doc,ensure_ascii=False,sort_keys=True,indent=2)+'\n');changed=path.read_bytes()!=old
 records.append(dict(locale=code,beforeSha256=hashlib.sha256(old).hexdigest(),afterSha256=hashlib.sha256(path.read_bytes()).hexdigest(),fontSha256=hashlib.sha256(raw).hexdigest(),availableWidth=80,maximumAdvanceAt10=round(maximum,3),recommendedPointSize=size,missingCodepoints=[f'U+{ord(c):04X}'for c in sorted(missing)],changed=changed,values=rows,visualAcceptance='not-established'))
a.output.write_text(json.dumps(dict(rows=records,method='Unshaped hmtx advance sum;80 of original82 width, minimum8pt. Native review remains required. No text changed.'),ensure_ascii=False,indent=2)+'\n')
print(json.dumps([dict(locale=r['locale'],size=r['recommendedPointSize'],maximum=r['maximumAdvanceAt10'],missing=len(r['missingCodepoints']),changed=r['changed'])for r in records]))
