"""Normal single-file build plus verified incremental native resource port."""
from pathlib import Path
import argparse,hashlib,json,os,subprocess,sys
ROOT=Path(__file__).resolve().parents[1];FAMILY=ROOT/'localization/screenshots/all30-owner-20261104-01'
try:import UnityPy
except ModuleNotFoundError:
    interpreter=ROOT/'.venv-assets314/bin/python';assert interpreter.exists(),'Project asset interpreter is required'
    os.execv(str(interpreter),[str(interpreter),'-B',str(Path(__file__).resolve()),*sys.argv[1:]])
sys.path.insert(0,str(ROOT/'tools'));import forest_macos
def read(p):return json.loads(p.read_bytes())
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
p=argparse.ArgumentParser(description=__doc__);p.add_argument('locale');p.add_argument('--cycle',default='01');p.add_argument('--resume',action='store_true');a=p.parse_args();assert a.cycle.isalnum()
code=a.locale;language=ROOT/'localization/languages'/(code+'.json');assert language.is_file() and code!='ru'
wording=next(row for row in read(FAMILY/'caption-wording-01.json')['rows'] if row['locale']==code)
old=ROOT/'dist/windows-installer-work/overlays'/code;native=ROOT/'dist/macos-installer-work/overlays'/code
assert read(old/'manifest.json')['languageSha256']==wording['beforeSha256']==read(native/'manifest.json')['languageSha256']
compiled=ROOT/'dist'/('Forest-'+code+'-owner-screens-20261104-'+a.cycle);output=ROOT/'dist/all30-owner-screens-native-delta'/code/a.cycle
assert a.resume or (not compiled.exists() and not output.exists())
log=FAMILY/(code+'-compiler-'+a.cycle+'.log')
if compiled.exists():
    marker=read(compiled/'manifest.json');assert a.resume and marker['languageSha256']==sha(language)
    from forest_localization.core import engine_fingerprint
    assert marker['compilerSha256']==engine_fingerprint()[1],'Completed compiler inputs changed'
    for name,pin in marker['files'].items():assert sha(compiled/name)==pin['sha256']
else:
    with log.open('wb') as stream:subprocess.run([str(ROOT/'forest-localize'),'build',str(language),'--output',str(compiled)],check=True,stdout=stream,stderr=subprocess.STDOUT)
if output.exists():
    assert a.resume and not (output/'manifest.json').exists(),'Do not replace a complete native output'
    interrupted=output.with_name(output.name+'-interrupted');assert not interrupted.exists();output.rename(interrupted)
new=read(compiled/'manifest.json');prior=read(old/'manifest.json');shared=[]
for name,pin in new['files'].items():
    if pin!=prior['files'].get(name):continue
    source=old/name;target=compiled/name;assert sha(source)==sha(target)==pin['sha256']
    link=target.with_name(target.name+'.verified-link');assert not link.exists();os.link(source,link);link.replace(target);shared.append(name)
# Reuse unchanged native serialized members and stream/bundle bytes. The shared
# adapter independently ports every changed assembly or serialized resource.
forest_macos.WORK=ROOT/'dist/all30-owner-screens-native-work-v2'/(code+'-'+a.cycle);tool=forest_macos.managed()
with (FAMILY/(code+'-native-'+a.cycle+'.log')).open('wb') as stream:
    # The adapter writes compact receipts; subprocess diagnostics stay in this job.
    changed=[name for name,pin in new['files'].items() if pin!=prior['files'].get(name)]
    if any(name.endswith('.bundle') or name.endswith('/catalog.json') for name in changed):
        full_work=ROOT/'dist/all30-owner-screens-native-full-work'/(code+'-'+a.cycle)
        result=forest_macos.port_full_compiled_overlay(code,compiled,native,output,full_work)
    else:result=forest_macos.port_changed_overlay(code,compiled,old,native,output,tool)
record=dict(locale=code,languageSha256=sha(language),compiled=str(compiled),native=str(output),unchangedWindowsMembersShared=shared,nativeManifestSha256=sha(output/'manifest.json'),nativeManifest=result,modelRequests=0)
(FAMILY/(code+'-resources-'+a.cycle+'.json')).write_text(json.dumps(record,indent=2)+'\n')
print(json.dumps(dict(locale=code,compiled=str(compiled),native=str(output),changedResources=result['reuse']['changedResources'])))
