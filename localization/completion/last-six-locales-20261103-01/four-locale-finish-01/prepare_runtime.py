"""Prepare explicit QA configuration from exact edited language and delivered resources."""
import argparse
import hashlib
import json
from pathlib import Path

ROOT=Path('/Users/antonkrutov/Desktop/Forest')
C=Path('localization/completion/last-six-locales-20261103-01')
W=C/'four-locale-finish-01'
S=Path('localization/completion/five-new-locales-20261101-01')


def sha(p):return hashlib.sha256((ROOT/p).read_bytes()).hexdigest()
def pin(p):return dict(path=str(p),sha256=sha(p))


def main(loc):
    language_path=Path('localization/languages')/(loc+'.json')
    language=json.loads((ROOT/language_path).read_text())
    candidate=Path('dist')/('Forest-'+loc+'-single-file-final-20261103-01')
    manifest=json.loads((ROOT/candidate/'manifest.json').read_text())
    assert manifest['languageSha256']==sha(language_path) and manifest['locale']==loc
    dest=W/(loc+'-native');assert not (ROOT/dest).exists();(ROOT/dest).mkdir()
    source=[json.loads(s) for s in (ROOT/S/'source-context.jsonl').read_text().splitlines()]
    labels=[dict(r, target=language['translations'][r['id']]['target'],targetSha256=hashlib.sha256(language['translations'][r['id']]['target'].encode()).hexdigest()) for r in source if r['id'].startswith('level1:') and r['source'] in ['Play','Options\n','Gallery','Quit','Controls','Report a Bug']]
    assert len(labels)==42
    label_path=dest/'main-menu-expectations.jsonl'
    with (ROOT/label_path).open('x') as f:
        for r in labels:f.write(json.dumps(r,ensure_ascii=False)+'\n')
    def one(source):
        values={v['target'] for k,v in language['translations'].items() if k.startswith('level1:') and v['source']==source}
        assert len(values)==1,(source,values)
        return next(iter(values))
    framework=Path('localization/framework')/language['framework']/'framework.json'
    config=dict(projectRoot=str(ROOT),locale=loc,culture=language['culture'],
                run='localization/probes/'+loc+'-20261103-compiled-01',candidate=str(candidate),phase=str(dest),
                evidence='localization/visual-qa/'+loc+'-compiled-20261103-01',product='ForestQA'+loc.upper()+'CompiledProbe20261103_01',
                scope='Finite native baseline: original loaded menu/settings, original resumed-fixture dialogue and next-state guard when available, all48 inventory and four neighbor branches, worst-height inventory frame, original Finley quest pane. Full story, all special callbacks/haiku, artwork textures and other platforms remain separate.',
                compiledLanguage=pin(language_path),textAcceptance=pin(W/'editorial'/(loc+'.json')),framework=pin(framework),
                staticLabels=pin(label_path),
                menuGuards=dict(play=one('Play'),settings=[one('Fullscreen:'),one('Back')]),
                questBodyId='bgdb:resources.assets:320/sheet/t0mvbnMW90imSoe6SezMKA/row/k7McLhqBMESbYs8NcZIjMg/field/gt2E0tKZz0yCT5P2xrS3sA')
    files=[Path('tools/probe/locale_runtime_v1')/n for n in ['prepare.py','runner.py','compiled_contract.py','preflight.py','LocaleRuntimeProbe.cs']]
    files.extend([language_path,W/'editorial'/(loc+'.json'),label_path,framework])
    config['entryPins']=[pin(p) for p in files]
    p=dest/'config.json'
    with (ROOT/p).open('x') as f:json.dump(config,f,ensure_ascii=False,indent=2);f.write('\n')
    print(str(p))


if __name__=='__main__':
    p=argparse.ArgumentParser();p.add_argument('locale',choices=['hu','nl','ro','sr']);main(p.parse_args().locale)
