"""Bind every actual native capture after restoration; prepare no model judgments."""
import argparse
import hashlib
import json
from pathlib import Path

ROOT=Path('/Users/antonkrutov/Desktop/Forest')
W=Path('localization/completion/last-six-locales-20261103-01/four-locale-finish-01')


def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def pin(p):return dict(path=str(p.resolve()),sha256=sha(p))


def main(loc,attempt=1):
    config=json.loads((ROOT/W/(loc+'-native'+('-%02d'%attempt if attempt>1 else ''))/'config.json').read_text())
    run=ROOT/config['run'];evidence=ROOT/config['evidence'];upload=evidence/'upload'
    result=json.loads((run/'runtime-result.json').read_text())
    cleanup=json.loads((run/'cleanup.json').read_text())
    assert result['automatedResult']=='pass' and result['locale']==loc
    assert all(cleanup[k] for k in ['taskOwnedProcessesAbsent','originalGameByteExact','parentCandidateByteExact','bridgeRemoved','localizedAssemblyRestored','fixtureRestored'])
    captures=result['captures'];assert captures
    assert {p.name for p in upload.iterdir()}=={r['filename'] for r in captures}
    for r in captures:
        assert r['locale']==loc and r['runtimeLocale']==loc and sha(upload/r['filename'])==r['sha256']
    paths={'capture':run/'runtime-result.json','cleanup':run/'cleanup.json','build':run/'build.json',
           'originalSource':run/'original-before.json','execution':run/'execution-pins.json',
           'compiledArtifact':ROOT/config['candidate']/'manifest.json',
           'finalTextAcceptance':ROOT/config['textAcceptance']['path']}
    manifest=dict(schemaVersion=1,kind='native-screenshots',scope=config['scope'],
                  provenance={k:pin(v) for k,v in paths.items()},images=captures)
    dest=evidence/'native-manifest.json'
    with dest.open('x') as f:json.dump(manifest,f,ensure_ascii=False,indent=2);f.write('\n')
    context=evidence/'acceptance.txt'
    with context.open('x') as f:
        f.write('The Forest of Love 0.45; exact compiled '+loc+' resources. Runtime/publishing locale mapping is '+loc+' -> '+loc+' from the exact language JSON and native capture metadata.\n')
        f.write('All captured native game frames in this manifest are in scope. Source game/owner saves are unchanged; cleanup and exact artifact hashes are pinned. Existing project game-thread bridge invokes original consumers and native Unity ScreenCapture. No desktop-region capture, annotation, synthetic replacement text or image editing.\n')
        f.write('Review complete visible text for glyphs/spacing/diacritics, clipping/wrapping/overlap, readability, literal tags, source fallback and contamination. LTR including Serbian Cyrillic. English names, source-backed quoted inscriptions and fictional script may be intentional; record uncertainty rather than infer a pass. OS/storefront/game notification banners are never accepted. This is visual review, not a new semantic corpus audit or proof of unexercised story/choice paths.\n')
        for r in captures:
            f.write('\n'+r['filename']+'\nExpected state: '+r['boundary']+'\nActual source-bound text expectation: '+json.dumps(r['expected'],ensure_ascii=False)+'\n')
    assert context.stat().st_size<=32768
    print(json.dumps(dict(locale=loc,frames=len(captures),manifest=str(dest),root=str(upload),context=str(context))))


if __name__=='__main__':
    p=argparse.ArgumentParser();p.add_argument('locale',choices=['hu','nl','ro','sr']);p.add_argument('--attempt',type=int,default=1);a=p.parse_args();main(a.locale,a.attempt)
