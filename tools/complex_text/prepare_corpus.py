"""Derive one corpus-bound font/map; never rewrite logical game wording."""
from pathlib import Path
import argparse,base64,hashlib,json
import fontTools,uharfbuzz
from font_shaping import FontAugmenter,validate_shaped_value,FONTTOOLS_VERSION,UHARFBUZZ_VERSION

SPECS={
 'ar':dict(mode=1,script='arab',language='ar',baseDirection='R',ranges=((0x0600,0x06FF),(0x0750,0x077F),(0x08A0,0x08FF))),
 'fa':dict(mode=1,script='arab',language='fa',baseDirection='R',ranges=((0x0600,0x06FF),(0x0750,0x077F),(0x08A0,0x08FF))),
 'he':dict(mode=2,script='hebr',language='he',baseDirection='R',ranges=((0x0590,0x05FF),)),
 'hi':dict(mode=3,script='deva',language='hi',baseDirection='L',ranges=((0x0900,0x097F),(0xA8E0,0xA8FF))),
 'th':dict(mode=4,script='thai',language='th',baseDirection='L',ranges=((0x0E00,0x0E7F),)),
}
def sha(b):return hashlib.sha256(b).hexdigest()
def main():
 p=argparse.ArgumentParser(description=__doc__);p.add_argument('--language',type=Path,required=True);p.add_argument('--output',type=Path,required=True);a=p.parse_args()
 assert (fontTools.__version__,uharfbuzz.__version__)==(FONTTOOLS_VERSION,UHARFBUZZ_VERSION),'Pinned shaping dependencies required'
 raw=a.language.read_bytes();doc=json.loads(raw);assert doc.get('complexText') is True
 spec=SPECS[doc['locale']];faces={r['asset'] for r in doc['fonts'].values()};assert len(faces)==1,'One explicitly selected shared complex face is required'
 asset=faces.pop();source=base64.b64decode(doc['fontAssets'][asset],validate=True);assert sha(source)==asset
 assert not a.output.exists();a.output.mkdir(parents=True)
 source_path=a.output/'source.ttf';source_path.write_bytes(source);augmenter=FontAugmenter(source_path,spec)
 assert not any(0xE000<=c<=0xF8FF for c in augmenter.font.getBestCmap()),'Source PUA cmap must be unoccupied'
 values={r['target'] for r in doc['translations'].values()};assert None not in values
 values.update(r['target'] for r in doc.get('imageCaptions',{}).values())
 exact={}
 for logical in sorted(values):
  shaped=augmenter.shape_rich_text(logical)
  validate_shaped_value(logical,shaped,augmenter,'complete target corpus')
  if logical!=shaped:exact[logical]=shaped
 rows=['VNREVIVAL1\t'+str(spec['mode'])+'\t'+str(int(spec['baseDirection']=='R'))]
 for key,value in sorted(doc.get('complexTextLayout',{}).items()):
  rows.append('L\t'+base64.b64encode(key.encode()).decode()+'\t'+base64.b64encode(str(value).encode()).decode())
 for kind,items in [('E',exact),('S',augmenter.span_mappings)]:
  rows.extend(kind+'\t'+base64.b64encode(k.encode()).decode()+'\t'+base64.b64encode(v.encode()).decode() for k,v in sorted(items.items()))
 wrap_receipt=None
 if doc['locale']=='th':
  from thai_wrap import build
  breaks,wrap_receipt=build(exact,augmenter.span_mappings)
  rows.extend('B\t'+base64.b64encode(k.encode()).decode()+'\t'+base64.b64encode(v.encode()).decode() for k,v in sorted(breaks.items()))
 (a.output/'shaping-map.tsv').write_text('\n'.join(rows)+'\n')
 augmenter.save(a.output/'shaped.ttf');prepared=(a.output/'shaped.ttf').read_bytes();new_asset=sha(prepared)
 # This document is an internal font-input view. Logical wording is identical.
 derived=json.loads(raw);derived['fontAssets'][new_asset]=base64.b64encode(prepared).decode()
 for role in derived['fonts']:derived['fonts'][role]['asset']=new_asset
 assert derived['translations']==doc['translations'] and derived.get('imageCaptions')==doc.get('imageCaptions')
 (a.output/'font-input.json').write_text(json.dumps(derived,ensure_ascii=False,sort_keys=True,indent=2)+'\n')
 receipt=dict(locale=doc['locale'],languageSha256=sha(raw),sourceFaceSha256=asset,preparedFaceSha256=new_asset,
  mode=spec['mode'],rtl=spec['baseDirection']=='R',logicalStrings=len(values),exactMappings=len(exact),spanMappings=len(augmenter.span_mappings),glyphInstances=len(augmenter.rows),
  mapSha256=sha((a.output/'shaping-map.tsv').read_bytes()),logicalWordingUnchanged=True,dependencies=dict(fonttools=fontTools.__version__,uharfbuzz=uharfbuzz.__version__),
  boundary='Deterministic font/map preparation only; independent target native acceptance remains required')
 if wrap_receipt is not None:receipt['thaiWordWrap']=wrap_receipt
 (a.output/'receipt.json').write_text(json.dumps(receipt,indent=2)+'\n');print(json.dumps(receipt))
if __name__=='__main__':main()
