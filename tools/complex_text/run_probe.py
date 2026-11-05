"""Run a prepared bounded native probe; always reconcile the owned supervisor."""
from pathlib import Path
import argparse, hashlib, json, os, shutil, struct, subprocess, sys, time
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'tools'))
import capture_language_screens as capture

def main():
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('--attempt',required=True);p.add_argument('--gallery',action='store_true');a=p.parse_args()
    assert a.attempt.isalnum()
    run=ROOT/'localization/probes'/('locale-owner-shots-20261104-ar-'+a.attempt)
    assert (run/'probe-preparation.json').exists() and not (run/'launch.json').exists()
    shutil.copy2(__file__,run/'execution/run_probe.py')
    env=dict(os.environ,FOREST_CAPTURE_RUN=run.name)
    with (run/'session.log').open('wb') as log:
        child=subprocess.Popen([str(ROOT/'.venv-assets314/bin/python'),'-B',str(run/'execution/source/native_capture_session.py')],env=env,stdout=log,stderr=subprocess.STDOUT,start_new_session=True)
        failure=None
        try:
            deadline=time.monotonic()+300
            while not (run/'bridge-ready.txt').exists():
                assert child.poll() is None,'Supervisor exited before bridge'
                if time.monotonic()>deadline:raise TimeoutError('Bounded native startup deadline')
                time.sleep(.25)
            capture.command(run,'show-menu')
            def ready(s,prefix):
                rows=[x for x in s['details'] if x.startswith('render-ready|'+prefix) and '/Controls/' in x and x.split('|')[1].endswith('/Name')]
                return len(rows)>=2 and all(float(x.split('|alpha=')[1].split('|')[0])>.95 and int(x.split('|chars=')[1].split('|')[0])>0 and x.endswith('cull=False') for x in rows)
            s=capture.wait_state(run,lambda s:ready(s,'Canvas/MainMenu/'),'shaped-menu',45)
            (run/'foreground-note.json').write_text(json.dumps(dict(focused=s['focused'],reason='Finite native shaping probe; foreground fallback retained to avoid proven hidden-frame stalls; no background claim.'))+'\n')
            for order,slug,command in [(1,'shaped-menu',None),(2,'shaped-samples','shape-samples')]:
                if order==2 and a.gallery:
                    capture.click(run,'Canvas/MainMenu/Controls/Gallery')
                    capture.wait_state(run,lambda s:'Canvas/GalleryMenu/Controls/Column/Back' in s['buttons'] and ready(s,'Canvas/GalleryMenu/'),'shaped-gallery',45)
                    capture.command(run,'capture ar-03-shaped-gallery.png',timeout=75)
                    deadline=time.monotonic()+20
                    while time.monotonic()<deadline:
                        f=run/'ar-03-shaped-gallery.png'
                        if f.exists() and f.read_bytes()[-12:]==b'\0\0\0\0IEND\xaeB`\x82':break
                        time.sleep(.1)
                    else:raise TimeoutError('Gallery PNG not complete')
                if command:capture.command(run,command)
                path=run/('ar-'+str(order).zfill(2)+'-'+slug+'.png')
                capture.command(run,'capture '+path.name,timeout=75)
                deadline=time.monotonic()+20
                while time.monotonic()<deadline:
                    if path.exists():
                        b=path.read_bytes()
                        if b[-12:]==b'\0\0\0\0IEND\xaeB`\x82':
                            assert struct.unpack('>II',b[16:24])==(2880,1800);break
                    time.sleep(.1)
                else:raise TimeoutError('PNG not complete')
            capture.command(run,'quit')
        except BaseException as e:
            failure=repr(e);(run/'failure.request').write_text(failure+'\n')
        finally:
            (run/'finish.request').write_text('Bounded probe complete\n')
            try:child.wait(timeout=45)
            except subprocess.TimeoutExpired:
                raise RuntimeError('Reconcile surviving exact supervisor/child before any retry')
        cleanup=json.loads((run/'cleanup.json').read_bytes())
        assert all(cleanup[k] for k in ['taskProcessStopped','ownerSaveSettingsUnchanged','taskSaveByteExact','bridgeRemoved','localizedAssemblyRestored','settingsRestored'])
        (run/'probe-result.json').write_text(json.dumps(dict(failure=failure,automatedResult='fail' if failure else 'pass',visualReview='pending',cleanup=cleanup),indent=2)+'\n')
        if failure:raise RuntimeError(failure)
        print(run)
if __name__=='__main__':main()
