"""Apply the existing common compiler and verify the actual delivered overlay."""
import argparse
import datetime
import fcntl
import hashlib
import json
from pathlib import Path
import subprocess
import sys

ROOT=Path('/Users/antonkrutov/Desktop/Forest')
sys.path.insert(0,str(ROOT/'tools/probe/locale_runtime_v1'))
from compiled_contract import text_gate

C=Path('localization/completion/last-six-locales-20261103-01')
W=C/'four-locale-finish-01'
O=Path('outputs/last-six-locales-20261103-01/resource-builds-01')


def sha(p):return hashlib.sha256((ROOT/p).read_bytes()).hexdigest()
def now():return datetime.datetime.now(datetime.timezone.utc).isoformat()
def pin(p):return dict(path=str(p),sha256=sha(p))
def save(p,d):
    t=p.with_suffix(p.suffix+'.pending');t.write_text(json.dumps(d,ensure_ascii=False,indent=2)+'\n');t.replace(p)


def main(loc,revision=1,acceptance=None):
    assert 1<=revision<=99
    output=ROOT/O.parent/('resource-builds-%02d'%revision);output.mkdir(parents=True,exist_ok=True)
    with (ROOT/O.parent/'four-locale-compiler.lock').open('a') as lock:
        fcntl.flock(lock,fcntl.LOCK_EX|fcntl.LOCK_NB)
        receipt=output/(loc+'-receipt.json');assert not receipt.exists(),'Reconcile existing receipt before another build'
        language=Path('localization/languages')/(loc+'.json')
        config=dict(locale=loc,compiledLanguage=pin(language),textAcceptance=pin(Path(acceptance) if acceptance else W/'editorial'/(loc+'.json')))
        text_gate(ROOT,config)
        artifact=Path('dist')/('Forest-'+loc+'-single-file-final-20261103-%02d'%revision)
        assert not (ROOT/artifact).exists(),'Reconcile partial/completed resource artifact, never overwrite'
        record=dict(locale=loc,status='building',startedAtUTC=now(),language=pin(language),textAcceptance=config['textAcceptance'],artifact=str(artifact),newModelRequests=0)
        save(receipt,record)
        for mode in ['build','check']:
            args=[str(ROOT/'forest-localize'),'build',str(language),'--output',str(artifact),'--mode',mode]
            with (output/(loc+'-'+mode+'-stdout.log')).open('x') as so,(output/(loc+'-'+mode+'-stderr.log')).open('x') as se:
                result=subprocess.run(args,cwd=ROOT,stdin=subprocess.DEVNULL,stdout=so,stderr=se)
            record[mode+'ExitCode']=result.returncode
            record['status']='checking' if mode=='build' and not result.returncode else 'build-or-check-failed' if result.returncode else 'verifying-delivered-files'
            save(receipt,record)
            if result.returncode:raise RuntimeError('Common compiler '+mode+' failed; retain exact logs and partial bytes')
        manifest=json.loads((ROOT/artifact/'manifest.json').read_text())
        assert manifest['locale']==loc and manifest['languageSha256']==sha(language)
        assert len(manifest['files'])==16
        for name,p in manifest['files'].items():
            actual=ROOT/artifact/name
            assert actual.stat().st_size==p['bytes'] and sha(artifact/name)==p['sha256'],name
        text_gate(ROOT,config)
        record.update(status='built-and-verified',completedAtUTC=now(),manifest=pin(artifact/'manifest.json'),resources=manifest['files'],resourcesVerified=16,
                      native='pending',release='not-accepted',installed=False,
                      boundary='Normal common build/check plus actual delivered hashes/sizes and exact wording version. No native/font/visual acceptance inferred.')
        save(receipt,record)
        print(json.dumps(dict(locale=loc,passed=True,artifact=str(artifact),resources=16)))


if __name__=='__main__':
    p=argparse.ArgumentParser();p.add_argument('locale',choices=['hu','nl','ro','sr']);p.add_argument('--revision',type=int,default=1);p.add_argument('--acceptance');a=p.parse_args();main(a.locale,a.revision,a.acceptance)
