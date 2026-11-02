"""Finite parent-owned common-compiler builds; no model or runtime requests."""
from pathlib import Path
import datetime
import hashlib
import json
import subprocess

ROOT = Path('/Users/antonkrutov/Desktop/Forest')
CONTROL = Path(__file__).resolve().parent


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def save(path, value):
    pending = path.with_suffix(path.suffix + '.pending')
    pending.write_text(json.dumps(value, indent=2) + '\n')
    pending.replace(path)


def now():
    return datetime.datetime.now(datetime.timezone.utc).isoformat()


def main():
    cfg = json.loads((CONTROL / 'manifest.json').read_text())
    out = ROOT / cfg['output']
    out.mkdir(exist_ok=True)
    assert not (out / 'status.json').exists(), 'Reconcile existing build request'
    rows = [dict(locale=j['locale'], status='queued') for j in cfg['jobs']]
    for job, row in zip(cfg['jobs'], rows):
        target, artifact = ROOT / job['language'], ROOT / job['artifact']
        assert sha(target) == job['languageSha256'] and not artifact.exists()
    save(out / 'status.json', dict(lanes=rows, atUTC=now()))
    for job, row in zip(cfg['jobs'], rows):
        target, artifact = ROOT / job['language'], ROOT / job['artifact']
        try:
            for mode in ['build', 'check']:
                assert sha(target) == job['languageSha256'], 'Input changed; preserve artifacts'
                args = ['./forest-localize', 'build', job['language'], '--output', job['artifact'], '--mode', mode]
                with (out / (job['locale'] + '-' + mode + '.stdout.log')).open('x') as stdout, (out / (job['locale'] + '-' + mode + '.stderr.log')).open('x') as stderr:
                    child = subprocess.Popen(args, cwd=ROOT, stdin=subprocess.DEVNULL, stdout=stdout, stderr=stderr)
                    row.update(status='building' if mode == 'build' else 'checking', pid=child.pid, argv=args)
                    save(out / 'status.json', dict(lanes=rows, atUTC=now()))
                    code = child.wait()
                row[mode + 'ExitCode'] = code
                assert code == 0, (job['locale'], mode, code)
            check = json.loads((out / (job['locale'] + '-check.stdout.log')).read_text())
            marker = json.loads((artifact / 'manifest.json').read_text())
            assert check['passed'] and check['resources'] == 16 and not check['installed'] and check['newModelRequests'] == 0
            assert marker['languageSha256'] == job['languageSha256'] == sha(target)
            assert len(marker['files']) == 16
            for name, binding in marker['files'].items():
                candidates = [p for p in [artifact / name, artifact / 'The Forest of Love_Data' / name] if p.is_file()]
                assert len(candidates) == 1
                path = candidates[0]
                assert path.stat().st_size == binding['bytes'] and sha(path) == binding['sha256']
            receipt = dict(status='compiled-and-verified', locale=job['locale'], artifact=job['artifact'],
                           languageSha256=job['languageSha256'], manifestSha256=sha(artifact / 'manifest.json'),
                           independentVersionMatchingCoverage=12825, resourceHashesVerified=16,
                           compilerResult=check, buildExitCode=0, checkExitCode=0, atUTC=now(),
                           installed=False, newModelRequests=0, native='not-authorized-not-run', release='not-accepted')
            save(out / (job['locale'] + '-receipt.json'), receipt)
            row.update(status='compiled-and-verified', receipt=str((out / (job['locale'] + '-receipt.json')).relative_to(ROOT)))
        except Exception as error:
            row.update(status='failed-preserve-artifacts', error=repr(error))
        save(out / 'status.json', dict(lanes=rows, atUTC=now()))
    save(out / 'finished.json', dict(lanes=rows, atUTC=now(), automaticRetry=False, newModelRequests=0))


if __name__ == '__main__':
    main()
