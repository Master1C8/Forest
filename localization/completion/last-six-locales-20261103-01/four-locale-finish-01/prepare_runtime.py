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


def main(loc,attempt=1):
    language_path=Path('localization/languages')/(loc+'.json')
    language=json.loads((ROOT/language_path).read_text())
    candidate=Path('dist')/('Forest-'+loc+'-single-file-final-20261103-01')
    manifest=json.loads((ROOT/candidate/'manifest.json').read_text())
    assert manifest['languageSha256']==sha(language_path) and manifest['locale']==loc
    assert 1<=attempt<=99
    dest=W/(loc+'-native'+('-%02d'%attempt if attempt>1 else ''))
    if (ROOT/dest).exists():
        assert {p.name for p in (ROOT/dest).iterdir()}=={'main-menu-expectations.jsonl'},'Reconcile finalized or unknown native control files'
    else:(ROOT/dest).mkdir()
    source=[json.loads(s) for s in (ROOT/S/'source-context.jsonl').read_text().splitlines()]
    labels=[dict(r, target=language['translations'][r['id']]['target'],targetSha256=hashlib.sha256(language['translations'][r['id']]['target'].encode()).hexdigest()) for r in source if r['id'].startswith('level1:') and r['source'] in ['Play','Options\n','Gallery','Quit','Controls','Report a Bug']]
    assert len(labels)==42
    label_path=dest/'main-menu-expectations.jsonl'
    label_content=''.join(json.dumps(r,ensure_ascii=False)+'\n' for r in labels)
    if (ROOT/label_path).exists():assert (ROOT/label_path).read_text()==label_content,'Partial expectation bytes differ'
    else:
        with (ROOT/label_path).open('x') as f:f.write(label_content)
    def one(source_text,prefix):
        selected=[r for r in source if r['source']==source_text and any(c.get('hierarchy','').startswith(prefix) for c in r.get('consumerContext',[]))]
        values={language['translations'][r['id']]['target'] for r in selected}
        assert len(values)==1,(source_text,prefix,values)
        return next(iter(values))
    framework=Path('localization/framework')/language['framework']['id']/'framework.json'
    assert sha(framework)==language['framework']['sha256']
    config=dict(projectRoot=str(ROOT),locale=loc,culture=language['culture'],
                run='localization/probes/'+loc+'-20261103-compiled-%02d'%attempt,candidate=str(candidate),phase=str(dest),
                evidence='localization/visual-qa/'+loc+'-compiled-20261103-%02d'%attempt,product='ForestQA'+loc.upper()+'CompiledProbe20261103_%02d'%attempt,
                scope='Finite native baseline: original loaded menu/settings, original resumed-fixture dialogue and next-state guard when available, all48 inventory and four neighbor branches, worst-height inventory frame, original Finley quest pane. Full story, all special callbacks/haiku, artwork textures and other platforms remain separate.',
                compiledLanguage=pin(language_path),textAcceptance=pin(W/'editorial'/(loc+'.json')),framework=pin(framework),
                staticLabels=pin(label_path),
                menuGuards=dict(play=one('Play','Canvas/MainMenu/Controls/Start/'),settings=[one('Fullscreen:','Canvas/OptionsMenu/Controls/Fullscreen/'),one('Back','Canvas/OptionsMenu/Controls/Back/')]),
                questBodyId='bgdb:resources.assets:320/sheet/t0mvbnMW90imSoe6SezMKA/row/k7McLhqBMESbYs8NcZIjMg/field/gt2E0tKZz0yCT5P2xrS3sA')
    files=[Path('tools/probe/locale_runtime_v1')/n for n in ['prepare.py','runner.py','compiled_contract.py','preflight.py','LocaleRuntimeProbe.cs']]
    files.extend([language_path,W/'editorial'/(loc+'.json'),label_path,framework])
    config['entryPins']=[pin(p) for p in files]
    p=dest/'config.json'
    with (ROOT/p).open('x') as f:json.dump(config,f,ensure_ascii=False,indent=2);f.write('\n')
    print(str(p))


if __name__=='__main__':
    p=argparse.ArgumentParser();p.add_argument('locale',choices=['hu','nl','ro','sr']);p.add_argument('--attempt',type=int,default=1);a=p.parse_args();main(a.locale,a.attempt)
