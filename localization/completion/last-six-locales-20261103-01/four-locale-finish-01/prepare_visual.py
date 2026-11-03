"""Bind every actual native capture after restoration; prepare no model judgments."""
import argparse
import hashlib
import json
from pathlib import Path

ROOT=Path('/Users/antonkrutov/Desktop/Forest')
W=Path('localization/completion/last-six-locales-20261103-01/four-locale-finish-01')


def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def pin(p):return dict(path=str(p.resolve()),sha256=sha(p))


def quest_context(language,protected):
    grouped={}
    for ident,row in language['translations'].items():
        if ident in protected:continue
        title=(ident.startswith('bgdb:resources.assets:320/sheet/t0mvbnMW90imSoe6SezMKA/') and ident.endswith('/field/pFHvU0%2FmGUGVujz%2Bd6ktEA'))
        heading=(ident.startswith('sharedassets2.assets:') and 'UEST ' in row['source'] and '<size=' in row['source'])
        if title or heading:
            key=(row['source'],row['target']);grouped.setdefault(key,[]).append(ident)
    return [dict(ids=ids,source=source,target=target) for (source,target),ids in grouped.items()]


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
    language_path=ROOT/config['compiledLanguage']['path']
    assert sha(language_path)==config['compiledLanguage']['sha256']
    snapshot=evidence/'canonical-language.json'
    with snapshot.open('xb') as f:f.write(language_path.read_bytes())
    language=json.loads(snapshot.read_text())
    protected=json.loads((ROOT/'localization/completion/five-new-locales-20261101-01/source-preservation.json').read_text())['baselinePreserved']
    producer='managed:Managed/Assembly-CSharp.dll:System.String TheForestOfLove.CustomPortraitsUi::VNRevivalRussianSpeakerDisplay(System.String)'
    captions=[dict(index=int(k.rsplit('@',1)[1]),source=v['source'],target=v['target']) for k,v in language['translations'].items() if k.startswith(producer+'@') and k not in protected]
    paths={'capture':run/'runtime-result.json','cleanup':run/'cleanup.json','build':run/'build.json',
           'originalSource':run/'original-before.json','execution':run/'execution-pins.json',
           'compiledArtifact':ROOT/config['candidate']/'manifest.json',
           'finalTextAcceptance':ROOT/config['textAcceptance']['path'],'languageSnapshot':snapshot}
    manifest=dict(schemaVersion=1,kind='native-screenshots',scope=config['scope'],
                  provenance={k:pin(v) for k,v in paths.items()},images=captures)
    dest=evidence/'native-manifest.json'
    with dest.open('x') as f:json.dump(manifest,f,ensure_ascii=False,indent=2);f.write('\n')
    context=evidence/'acceptance.txt'
    with context.open('x') as f:
        f.write('The Forest of Love 0.45; exact compiled '+loc+' resources. Runtime/publishing locale mapping is '+loc+' -> '+loc+' from the exact language JSON and native capture metadata.\n')
        f.write('All captured native game frames in this manifest are in scope. Source game/owner saves are unchanged; cleanup and exact artifact hashes are pinned. Existing project game-thread bridge invokes original consumers and native Unity ScreenCapture. No desktop-region capture, annotation, synthetic replacement text or image editing.\n')
        f.write('Review complete visible text for glyphs/spacing/diacritics, clipping/wrapping/overlap, readability, literal tags, source fallback and contamination. LTR including Serbian Cyrillic. English names, source-backed quoted inscriptions and fictional script may be intentional; record uncertainty rather than infer a pass. OS/storefront/game notification banners are never accepted. This is visual review, not a new semantic corpus audit or proof of unexercised story/choice paths.\n')
        f.write('Source-bound speaker-name display contract from this exact independently reviewed target file: producer '+producer+'; each index reconstructs its full unit ID with @index. Inspect the TARGET spelling; an English spelling is intentional only where target==source. Technical protected keys are excluded. '+json.dumps(captions,ensure_ascii=False)+'\n')
        f.write('Source-bound original quest-list titles and ornamental quest headings from the same exact target snapshot. Repeated identical source/target pairs are grouped losslessly by their full IDs. Compare actual displayed wording, spacing and case to these authored values; do not infer a visual pass from their editorial acceptance. '+json.dumps(quest_context(language,protected),ensure_ascii=False)+'\n')
        for r in captures:
            f.write('\n'+r['filename']+'\nExpected state: '+r['boundary']+'\nActual source-bound text expectation: '+json.dumps(r['expected'],ensure_ascii=False)+'\n')
    assert context.stat().st_size<=32768
    print(json.dumps(dict(locale=loc,frames=len(captures),manifest=str(dest),root=str(upload),context=str(context))))


if __name__=='__main__':
    p=argparse.ArgumentParser();p.add_argument('locale',choices=['hu','nl','ro','sr']);p.add_argument('--attempt',type=int,default=1);a=p.parse_args();main(a.locale,a.attempt)
