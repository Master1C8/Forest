"""Freeze this finite handoff. No runtime, builds of candidates or model work."""
from pathlib import Path
import sys,shutil,json,hashlib
ROOT=Path('/Users/antonkrutov/Desktop/Forest');CHECK=Path(__file__).resolve().parent
sys.path.insert(0,str(ROOT/'tools/probe'));sys.path.insert(0,str(ROOT/'tools'))
import capture_chapter_completion_ui as cc
import prepare_chapter_completion_qa as prep
import russian_chapter_gallery_case as a
out=CHECK/(sys.argv[1] if len(sys.argv)>1 else 'frozen');out.mkdir()
for n in prep.PROBE_HELPERS:shutil.copyfile(ROOT/'tools/probe'/n,out/n)
shutil.copyfile(ROOT/'tools/prepare_chapter_completion_review.py',out/'prepare_chapter_completion_review.py')
# legacy helper's adapter still validates genuine canonical accepted134 inputs.
plan,work,build=cc.candidate_validation(cc.CANDIDATE,locale='ru')
inputs=out/'cg-inputs';inputs.mkdir();a.snapshot(inputs,locale='ru')
cc.write(out/'cg-workload.json',work,True)
(out/'cg-values.tsv').write_text(''.join('\t'.join(v)+'\n' for v in work['values']))
(out/'cg-words.tsv').write_text(''.join(k+'\t'+cc.base64.b64encode(v.encode()).decode()+'\n' for k,v in work['words'].items()))
cg=cc.legacy();(out/'cg-cases.tsv').write_text(''.join('\t'.join([c['surface'],c['branch'],str(c['rowIndex']),c['kind'],str(c['ordinal']),cg.b64(c['argument']),cg.b64(c['expected'])])+'\n' for c in work['cases']))
selectors=json.loads((CHECK/'native-text-selectors.json').read_text());lines=[]
for r in selectors:
 surface='description' if r['path'].startswith('LevelSingletons') else 'oos';lines.append('\t'.join([surface,r['path'],str(r['alpha']),str(r['pathId'])]))
assert len(lines)==12
(out/'cc-selectors.tsv').write_text('\n'.join(lines)+'\n')
for n in ['native-controllers.json','native-text-selectors.json','source-routes.json']:
 shutil.copyfile(CHECK/n,out/n)
evidence=out/'source-evidence';evidence.mkdir()
for name,digest in json.loads((CHECK/'source-routes.json').read_text())['sourceBodyPins'].items():
 p=ROOT/name;assert cc.sha(p)==digest;shutil.copyfile(p,evidence/(cc.sha(p)+'.il'))
cc.write(out/'bundle-pins.json',{str(p.relative_to(out)):cc.sha(p) for p in out.rglob('*') if p.is_file()},True)
print(json.dumps(dict(status='frozen-not-run',cases=len(work['cases']),counts=work['counts'],files=len(cc.read(out/'bundle-pins.json')))))
