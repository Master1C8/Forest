"""Launch one prepared isolated QA runner with the actual project environment."""
import argparse
import datetime
import json
from pathlib import Path
import subprocess

ROOT=Path(__file__).resolve().parents[3]


def main(config_path):
    config_path=Path(config_path).resolve()
    assert config_path.is_relative_to(ROOT)
    config=json.loads(config_path.read_text())
    run=ROOT/config['run']
    assert run.is_relative_to(ROOT/'localization/probes')
    assert json.loads((run/'qa-preparation.json').read_text())['status']=='prepared'
    assert not (run/'launch.json').exists() and not (run/'controller-launch.json').exists(),'Reconcile the existing execution, never duplicate it'
    # Resolving this symlink selects the base interpreter and discards pyvenv.cfg.
    # Keep its absolute lexical path; hash/version checks can resolve file bytes separately.
    interpreter=ROOT/'.venv-assets314/bin/python'
    probe=subprocess.run([str(interpreter),'-B','-c','import sys,PIL,json;print(json.dumps(dict(prefix=sys.prefix,executable=sys.executable,pillow=PIL.__version__)))'],capture_output=True,text=True,check=True)
    environment=json.loads(probe.stdout)
    assert Path(environment['prefix'])==ROOT/'.venv-assets314','Wrong runtime environment'
    args=[str(interpreter),'-B',str(run/'execution/runner.py')]
    receipt=dict(atUTC=datetime.datetime.now(datetime.timezone.utc).isoformat(),status='submission-pending-reconciliation',argv=args,environment=environment)
    path=run/'controller-launch.json'
    with path.open('x') as f:json.dump(receipt,f,indent=2);f.write('\n')
    with (run/'runner-stdout.log').open('x') as out,(run/'runner-stderr.log').open('x') as err:
        child=subprocess.Popen(args,cwd=ROOT,stdin=subprocess.DEVNULL,stdout=out,stderr=err,start_new_session=True)
    receipt.update(status='runner-started',pid=child.pid)
    temp=path.with_suffix('.pending');temp.write_text(json.dumps(receipt,indent=2)+'\n');temp.replace(path)
    print(json.dumps(dict(pid=child.pid,run=str(run),environment=environment)))


if __name__=='__main__':
    parser=argparse.ArgumentParser();parser.add_argument('--config',required=True);main(parser.parse_args().config)
