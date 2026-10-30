"""Bounded real-input regression; no models, original game execution or patching."""
import json
from pathlib import Path
import subprocess
import sys
import tempfile

ROOT = Path(__file__).resolve().parents[3]
sys.path.insert(0, str(ROOT/'tools'))
import locale_resources as r

HERE = Path(__file__).resolve().parent
BASE = ROOT/'outputs/locale-assets-20261026'
OLD = BASE/'workflow-v3-completion-20261030-01/technical'
NEW = BASE/'shared-resource-factory'


def pin(path):
    return dict(path=str(path.relative_to(ROOT)), sha256=r.sha(path.read_bytes()))


def rows(path):
    return r.index([r.parse(x) for x in path.read_bytes().splitlines()])


def verify():
    checks=[]
    command=[sys.executable,'-B','-m','unittest','discover','-s','tools','-p','test_locale_resources.py','-q']
    unit=subprocess.run(command,cwd=ROOT,capture_output=True,text=True,check=True)
    checks.append(dict(name='unit-regressions',command=command,exitCode=unit.returncode,
                       output=unit.stderr.strip(),boundary='Synthetic wording/reviews; real common filesystem publisher. No semantic or native proof.'))
    for family,locale in [('narrative150','pt-BR'),('narrative150','de'),('haiku27','pt-BR'),('haiku27','es')]:
        profile=ROOT/f'localization/resource-profiles/{family}.{locale}.json'
        output=NEW/locale/(family+'-v4')
        result=r.run(profile,locale,output,'check')
        checks.append(dict(name='real-artifact-check',result=result,profile=pin(profile),manifest=pin(output/'manifest.json')))
        try:r.run(profile,'wrong-locale',output/'negative-control')
        except ValueError as error:r.require(str(error)=='explicit-locale','wrong-negative-boundary')
        else:raise AssertionError('wrong locale accepted')
    before=rows(OLD/'0061-technical/delivery/pages25.jsonl')
    after=rows(NEW/'pt-BR/narrative150-v4/pages25.jsonl')
    r.require(set(before)==set(after),'pt-page-set')
    for id_,row in before.items():
        for key in ['locale','source','target','sourceSha256','targetSha256','physicalIds']:
            r.require(row[key]==after[id_][key],'pt-page-parity:'+key)
    before=rows(OLD/'0061-technical/delivery/selectors150.jsonl')
    after=rows(NEW/'pt-BR/narrative150-v4/selectors150.jsonl')
    r.require(set(before)==set(after),'pt-selector-set')
    for id_,row in before.items():
        current=after[id_]
        for key in ['locale','pageId','role']:r.require(row[key]==current[key],'pt-selector-parity:'+key)
        for new,old in [('fontAsset','primary'),('material','material'),('spriteAsset','sprite'),('fontSize','size'),('fontColor','color')]:
            r.require(current['binding'][new]==row['binding'][old],'pt-resource-binding:'+new)
        for key in ['id','reviewerThreadId']:r.require(row['receipt'][key]==current['wordingReceipt'][key],'pt-receipt-identity')
        r.require(row['receipt']['path']==current['wordingReceipt']['file']['path'],'pt-receipt-path')
    checks.append(dict(name='Portuguese-legacy-parity',pages=25,selectors=150,
        boundary='Exact original/target strings, hashes, physical membership, roles, font/material/sprite/size/color and reviewer identity; historical metadata retained by pinned references. Not whole-file byte equality.'))
    for locale,prior,culture in [('pt-BR','0059-technical/delivery','pt-BR'),('es','0063-technical/delivery-v2','es-ES')]:
        old,new=OLD/prior,NEW/locale/'haiku27-v4'
        for name in ['mapping.json','resource-tool/Program.cs','runtime27-fixtures.json','selector-dispositions.jsonl']:
            r.require((old/name).read_bytes()==(new/name).read_bytes(),'haiku-parity:'+locale+':'+name)
        tests=r.parse((new/'clr-tests.json').read_bytes())
        r.require(tests['passed'] and len(tests['fixtures'])==27 and tests['cultureResults']=={'en-US':27,culture:27,'tr-TR':27},'haiku-real-workload')
        checks.append(dict(name='haiku-legacy-parity-and-isolated-CLR',locale=locale,tuples=27,
            cultureResults=tests['cultureResults'],mapControls=7,runtimeNegatives=len(tests['negative']),
            structuralNegatives=len(tests['structuralNegative']),factoryBinding=pin(new/'factory-binding.json'),
            boundary='Generated C# and saved maps/fixtures/dispositions match prior delivery. Only isolated extracted CIL fixtures execute; original game, callbacks, Unity UI and native rendering remain untested. Compiled DLL byte equality is not claimed.'))
        with tempfile.TemporaryDirectory(prefix='resource-culture-control-',dir=ROOT/'outputs') as temp:
            profile=ROOT/f'localization/resource-profiles/haiku27.{locale}.json'
            data=r.parse(profile.read_bytes());data['culture']='wrong-culture'
            path=Path(temp)/'profile.json';path.write_bytes(r.encode(data))
            out=NEW/locale/'negative-culture-must-not-exist'
            r.require(not out.exists(),'negative-output-already-exists')
            try:r.run(path,locale,out)
            except ValueError as error:r.require(str(error)=='explicit-culture','culture-negative-boundary')
            else:raise AssertionError('wrong culture accepted')
            r.require(not out.exists(),'culture-negative-wrote-output')
        checks.append(dict(name='real-culture-negative',locale=locale,reason='explicit-culture',outputCreated=False,
                           positiveControl='Same pinned snapshot and backend passed above; only profile culture changed.'))
    result=dict(schemaVersion=1,status='passed',engine=pin(ROOT/'tools/locale_resources.py'),
        verificationRecipe=pin(Path(__file__)),tests=checks,modelRequestsIssued=0,
        scope='Shared resource preparation only; no new translation or readiness percentage credited.',
        independentTechnicalReview='pending-for-new-factory',**r.HELD)
    (HERE/'verification.json').write_bytes(r.encode(result))
    print(json.dumps(dict(status='passed',checks=len(checks),verification=str(HERE/'verification.json'))))


if __name__=='__main__':verify()
