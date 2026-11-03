"""Bind actual complete native captures to their exact per-image review evidence."""
import argparse
import hashlib
import json
from pathlib import Path
import datetime

ROOT=Path('/Users/antonkrutov/Desktop/Forest')
W=Path('localization/completion/last-six-locales-20261103-01/four-locale-finish-01')


def read(p):return json.loads(p.read_text())
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def pin(p):return dict(path=str(p.relative_to(ROOT)),sha256=sha(p))
def clean(r):
    return (all(r['checks'].get(k)=='passed' for k in ['layout','glyphs','content','contamination']) and
            r['checks'].get('rtl')=='not-applicable' and not r.get('findings') and r.get('reviewedAt'))


def main(loc,attempt,resolutions,menu_replacement=None):
    folder=loc+'-native'+('-%02d'%attempt if attempt>1 else '')
    config_path=ROOT/W/folder/'config.json';config=read(config_path)
    run=ROOT/config['run'];evidence=ROOT/config['evidence'];runtime=read(run/'runtime-result.json');cleanup=read(run/'cleanup.json')
    assert runtime['automatedResult']=='pass' and len(runtime['captures'])==5
    assert all(cleanup[k] for k in ['taskOwnedProcessesAbsent','originalGameByteExact','parentCandidateByteExact','bridgeRemoved','localizedAssemblyRestored','fixtureRestored'])
    assert any(p['predicate']=='original-dialogue-next-state' and p['status']=='passed' for p in runtime['progress'])
    assert runtime['inventoryCases']>=52
    language=ROOT/config['compiledLanguage']['path'];assert sha(language)==config['compiledLanguage']['sha256']
    artifact=ROOT/config['candidate'];manifest=read(artifact/'manifest.json');assert manifest['languageSha256']==sha(language)
    for name,p in manifest['files'].items():assert sha(artifact/name)==p['sha256']
    ledger_path=evidence/'visual-review.json';base=read(ledger_path);extra=[(ROOT/p,read(ROOT/p)) for p in resolutions]
    replacement=None
    if menu_replacement:
        replacement_config_path=ROOT/menu_replacement;replacement_config=read(replacement_config_path)
        assert replacement_config['nativeBatch']=='main-menu-only'
        for key in ['locale','candidate','compiledLanguage','textAcceptance']:
            assert replacement_config[key]==config[key],('Changed retained baseline dependency',key)
        replacement_run=ROOT/replacement_config['run'];replacement_evidence=ROOT/replacement_config['evidence']
        replacement_result=read(replacement_run/'runtime-result.json')
        assert replacement_result['automatedResult']=='pass' and len(replacement_result['captures'])==1
        replacement_image=replacement_result['captures'][0]
        assert replacement_image['order']==1 and replacement_image['scene']=='StartMenu'
        replacement_cleanup=read(replacement_run/'cleanup.json')
        assert all(replacement_cleanup[k] for k in ['taskOwnedProcessesAbsent','originalGameByteExact','parentCandidateByteExact','bridgeRemoved','localizedAssemblyRestored','fixtureRestored'])
        replacement=dict(config=pin(replacement_config_path),runtime=pin(replacement_run/'runtime-result.json'),
                         cleanup=pin(replacement_run/'cleanup.json'),nativeManifest=pin(replacement_evidence/'native-manifest.json'),
                         retainedOtherFourExact=True)
    selected=[]
    for image in runtime['captures']:
        image_evidence=evidence;image_ledger=ledger_path;image_base=base
        if replacement and image['order']==1:
            image=replacement_image;image_evidence=replacement_evidence
            image_ledger=replacement_evidence/'visual-review.json';image_base=read(image_ledger)
        assert sha(image_evidence/'upload'/image['filename'])==image['sha256']
        primary=next(r for r in image_base['images'] if r['order']==image['order'])
        candidates=[(image_ledger,primary)]
        for path,ledger in extra:
            candidates.extend((path,r) for r in ledger['images'] if r['order']==image['order'])
        found=[(p,r) for p,r in candidates if clean(r) and all(r[k]==primary[k] for k in ['game','locale','order','direction','filename','sha256','width','height'])]
        assert found,('No exact complete visual judgment',loc,image['order'])
        path,row=found[-1]
        selected.append(dict(sourceImage=image,reviewLedger=pin(path),actualReview=row,
                             exactPreparedImageIdentityMatchesOriginal=True))
    report=dict(atUTC=datetime.datetime.now(datetime.timezone.utc).isoformat(),locale=loc,status='passed-bounded-native-baseline',
                language=config['compiledLanguage'],artifact=config['candidate'],artifactManifest=pin(artifact/'manifest.json'),
                config=pin(config_path),runtime=pin(run/'runtime-result.json'),cleanup=pin(run/'cleanup.json'),
                nativeManifest=pin(evidence/'native-manifest.json'),menuReplacement=replacement,images=selected,frames=5,
                independentOrdinary=12825,protectedExact=1781,inventoryConsumerMeasurements=runtime['inventoryCases'],
                actualDialogueNextState=[p for p in runtime['progress'] if p['predicate']=='original-dialogue-next-state'],
                scope=runtime['scope'],installed=False,release='not-published',
                boundary='Complete exact five-scene native baseline and original guarded dialogue progression; not a full story playthrough, every special callback, installer or other-platform acceptance.')
    directory=ROOT/W/'native-delivery';directory.mkdir(exist_ok=True);dest=directory/(loc+'.json')
    with dest.open('x') as f:json.dump(report,f,ensure_ascii=False,indent=2);f.write('\n')
    print(json.dumps(dict(locale=loc,passed=True,frames=5,artifact=config['candidate'],report=str(dest))))


if __name__=='__main__':
    p=argparse.ArgumentParser();p.add_argument('locale',choices=['hu','nl','ro','sr']);p.add_argument('--attempt',type=int,default=1);p.add_argument('--resolution',action='append',default=[]);p.add_argument('--menu-replacement');a=p.parse_args();main(a.locale,a.attempt,a.resolution,a.menu_replacement)
