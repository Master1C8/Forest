"""Finite coordinator-only local resource builds; no model or game execution."""
from pathlib import Path
import datetime
import hashlib
import json
import subprocess

ROOT = Path('/Users/antonkrutov/Desktop/Forest')
CONTROL = Path(__file__).resolve().parent
OUT = ROOT / 'outputs/six-new-locales-20261101-01/compiled-final'


def read(path):
    return json.loads(path.read_text())


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def save(path, value):
    temporary = path.with_suffix(path.suffix + '.pending')
    temporary.write_text(json.dumps(value, indent=2) + '\n')
    temporary.replace(path)


def now():
    return datetime.datetime.now(datetime.timezone.utc).isoformat()


def verify(locale):
    closure = read(CONTROL / (locale + '.json'))
    language = ROOT / closure['language']['path']
    assert sha(language) == closure['language']['sha256']
    artifact = ROOT / 'dist' / ('Forest-' + locale + '-single-file-final-20261101-01')
    marker = read(artifact / 'manifest.json')
    assert marker['languageSha256'] == closure['language']['sha256']
    assert marker['locale'] == locale and marker['installed'] is False
    assert marker['newModelRequests'] == 0 and marker['baselineUnits'] == 14606
    assert len(marker['files']) == 16
    for name, binding in marker['files'].items():
        path = artifact / name
        assert path.resolve().is_relative_to(artifact)
        assert path.stat().st_size == binding['bytes'] and sha(path) == binding['sha256']
    return dict(locale=locale, status='compiled-and-verified', artifact=str(artifact.relative_to(ROOT)),
                manifestSha256=sha(artifact / 'manifest.json'), languageSha256=marker['languageSha256'],
                resources=16, configuredFontRoles=marker['configuredFontRoles'],
                installed=False, nativeAcceptance=False, atUTC=now())


def main():
    OUT.mkdir(parents=True, exist_ok=True)
    assert not (OUT / 'status.json').exists(), 'Reconcile this exact run; never duplicate'
    results = [verify(locale) for locale in ['tr', 'fr', 'pl']]
    save(OUT / 'status.json', dict(status='running', results=results, atUTC=now()))
    for locale in ['ko', 'it', 'zh-TW']:
        closure = read(CONTROL / (locale + '.json'))
        language = ROOT / closure['language']['path']
        assert sha(language) == closure['language']['sha256']
        artifact = ROOT / 'dist' / ('Forest-' + locale + '-single-file-final-20261101-01')
        assert not artifact.exists(), 'Reconcile existing artifact before a resume'
        args = [str(ROOT / 'forest-localize'), 'build', str(language), '--output', str(artifact)]
        with (OUT / (locale + '.log')).open('x') as log:
            child = subprocess.Popen(args, cwd=ROOT, stdin=subprocess.DEVNULL, stdout=log,
                                     stderr=subprocess.STDOUT)
            save(OUT / 'active.json', dict(locale=locale, pid=child.pid, argv=args,
                 languageSha256=closure['language']['sha256'], launcherSha256=sha(Path(__file__)), atUTC=now()))
            code = child.wait()
        if code != 0:
            save(OUT / 'status.json', dict(status='needs-attention-no-retry', locale=locale,
                 exitCode=code, results=results, atUTC=now()))
            return
        result = verify(locale)
        result['exitCode'] = code
        results.append(result)
        save(OUT / 'status.json', dict(status='running' if locale != 'zh-TW' else 'complete',
             results=results, atUTC=now()))
    save(OUT / 'active.json', dict(status='finished', atUTC=now()))


if __name__ == '__main__':
    main()
