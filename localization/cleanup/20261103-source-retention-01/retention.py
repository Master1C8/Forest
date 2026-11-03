"""Prepare a finite source/rebuild/work-in-progress retention manifest; no removal."""
import collections
import gzip
import hashlib
import json
import os
from pathlib import Path
import re
import stat
import subprocess

ROOT = Path('/Users/antonkrutov/Desktop/Forest')
HERE = Path(__file__).resolve().parent
ROOT_NAMES = {'tools', 'localization', 'outputs', 'assets', 'dist', 'review'}
SOURCE_EXT = {'.py', '.cs', '.csproj', '.swift', '.sh', '.command', '.js', '.ts', '.c', '.h', '.il', '.md', '.tsv', '.po', '.pot', '.xml', '.toml', '.yaml', '.yml'}
EXCLUDED_PARTS = {'vendor', 'node_modules', 'bin', 'obj', 'deps', '__pycache__'}
SHA_CACHE = {}
LIVE = ['outputs/last-six-locales-20261103-01/hi', 'outputs/last-six-locales-20261103-01/sw',
        'localization/editorial-delivery/last-six-locales-20261103-01/hi',
        'localization/completion/last-six-locales-20261103-01/hi',
        'localization/completion/last-six-locales-20261103-01/sw',
        'localization/completion/last-six-locales-20261103-01/hi-authoring-01',
        'localization/case-decisions/last-six-locales-20261103-01/hi',
        'localization/case-decisions/last-six-locales-20261103-01/sw']


def sha(p):
    s=p.stat();key=(s.st_dev,s.st_ino,s.st_size,s.st_mtime_ns)
    if key in SHA_CACHE:
        return SHA_CACHE[key]
    h = hashlib.sha256()
    with p.open('rb') as f:
        for b in iter(lambda:f.read(1024**2), b''):
            h.update(b)
    assert (p.stat().st_dev,p.stat().st_ino,p.stat().st_size,p.stat().st_mtime_ns)==key
    SHA_CACHE[key]=h.hexdigest()
    return h.hexdigest()


def under(n, roots):
    return any(n.casefold() == r.casefold() or n.casefold().startswith(r.casefold()+'/') for r in roots)


def all_files():
    for d, ds, fs in os.walk(ROOT, followlinks=False):
        ds[:] = sorted(n for n in ds if n != '.git' and not (Path(d)/n).is_symlink())
        for n in sorted(fs):
            p = Path(d)/n
            if p.is_file() and not p.is_symlink():
                yield p


def path_value(value):
    if not isinstance(value, str) or '\n' in value or len(value) > 1000:
        return None
    p = Path(value)
    if p.is_absolute():
        if not p.is_relative_to(ROOT):
            return None
        p = p.relative_to(ROOT)
    if not p.parts or p.parts[0] not in ROOT_NAMES or '..' in p.parts:
        return None
    actual = ROOT/p
    return str(p) if actual.is_file() and not actual.is_symlink() else None


def pinned(d):
    if isinstance(d, dict):
        p = path_value(d.get('path'))
        if p and re.fullmatch('[0-9a-f]{64}', str(d.get('sha256', ''))):
            yield p
        for k, v in d.items():
            p = path_value(k)
            if p and isinstance(v, str) and re.fullmatch('[0-9a-f]{64}', v):
                yield p
            p = path_value(v)
            if p and (k+'Sha256' in d or k in {'sourcePacket', 'preservation', 'approvedLocaleGlossary', 'sourceGlossary'}):
                yield p
            if isinstance(v, (dict, list)):
                yield from pinned(v)
    elif isinstance(d, list):
        for v in d:
            yield from pinned(v)


def documents(p):
    try:
        if p.suffix == '.jsonl':
            with p.open() as f:
                for line in f:
                    if line.strip():
                        yield json.loads(line)
        elif p.suffix == '.json':
            yield json.loads(p.read_text())
    except (ValueError, UnicodeError):
        return


def references(p):
    """Scan complete JSON bytes for file paths and exact content hashes.

    This is a conservative storage index, never a semantic judgment. A file is
    followed only when its real SHA256 occurs in the complete same document.
    Streaming avoids recursively visiting millions of unrelated wording fields.
    """
    if p.suffix not in {'.json','.jsonl'}:
        return
    names=set();hashes=set();tail=b''
    path_re=re.compile(rb'"((?:/Users/antonkrutov/Desktop/Forest/)?(?:tools|localization|outputs|assets|dist)/[^"\r\n]{1,1000})"')
    hash_re=re.compile(rb'"([0-9a-f]{64})"')
    with p.open('rb') as f:
        for chunk in iter(lambda:f.read(1024**2),b''):
            data=tail+chunk
            for m in path_re.finditer(data):
                try:
                    name=path_value(json.loads(b'"'+m.group(1)+b'"'))
                except (ValueError,UnicodeError,OSError):
                    name=None
                if name:names.add(name)
            hashes.update(m.group(1).decode() for m in hash_re.finditer(data))
            tail=data[-2048:]
    for name in sorted(names):
        if sha(ROOT/name) in hashes:
            yield name


def main():
    assert not (HERE/'source-retention-plan.json.gz').exists()
    all_paths = list(all_files())
    print(json.dumps(dict(stage='inventory',files=len(all_paths))),flush=True)
    by_name = {str(p.relative_to(ROOT)):p for p in all_paths}
    tracked = set(subprocess.check_output(['git', 'ls-files', '-z'], cwd=ROOT, text=True).split('\0'))
    dirty = set(subprocess.check_output(['git', 'diff', '--name-only', '-z'], cwd=ROOT, text=True).split('\0'))
    dirty.discard('')
    inputs = json.loads((HERE/'minimal-attempt-03/minimal-build-inputs.json').read_text())['files']
    keep = {n:'verified-normal-build-input' for n in inputs}
    archive = {}
    current = {p.stem:json.loads(p.read_text()) for p in (ROOT/'localization/languages').glob('*.json')}
    hashes = {loc:{k:hashlib.sha256(v['target'].encode()).hexdigest() if v['target'] is not None else None
                   for k,v in d['translations'].items()} for loc,d in current.items()}
    pngs = set()
    native = ROOT/'localization/completion/last-six-locales-20261103-01/four-locale-finish-01/native-delivery'
    for p in native.glob('??.json'):
        d = json.loads(p.read_text())
        for ref in references(p):
            archive[ref]='exact-final-native-acceptance-dependency'
        for r in d['images']:
            ledger = ROOT/r['reviewLedger']['path']
            archive[str(ledger.relative_to(ROOT))] = 'actual-final-native-review'
            # Preserve the actual used packet, its image inputs, answer, usage and provenance.
            attempt = r['actualReview']['reviewer'].rsplit('; ',1)[1]
            packet = ledger.parent/'queue'/attempt
            if packet.is_dir():
                for q in packet.rglob('*'):
                    if q.is_file() and not q.is_symlink():
                        archive[str(q.relative_to(ROOT))] = 'used-final-native-review-packet'
            manifest = d.get('menuReplacement') if r['sourceImage']['order'] == 1 else None
            if not manifest:
                manifest = d
            folder = (ROOT/manifest['nativeManifest']['path']).parent
            image = folder/'upload'/r['sourceImage']['filename']
            assert image.is_file() and sha(image) == r['sourceImage']['sha256']
            archive[str(image.relative_to(ROOT))] = 'original-accepted-native-frame'
    for n,p in by_name.items():
        parts = p.relative_to(ROOT).parts
        if len(parts) == 1 and p.suffix not in {'.zip', '.bundle'}:
            keep[n] = 'root-project-source-or-owner-file'
        elif n == 'Helltaker-Languages-0.1.0-Windows.zip':
            keep[n] = 'unrelated-existing-owner-input-not-selected'
        if n in dirty:
            keep[n] = 'preexisting-working-change-preserved'
        if under(n, LIVE):
            keep[n] = 'unfinished-Hindi-or-Swahili-work-preserved'
        if parts[0] == '.venv-assets314':
            keep[n] = 'current-unfinished-work-and-build-toolchain'
        if p.suffix.lower() in SOURCE_EXT and not set(parts)&EXCLUDED_PARTS and not parts[0].startswith('.venv'):
            keep[n] = 'editable-source-or-source-context'
        if n.startswith('tools/') and p.suffix in {'.json','.jsonl'} and not set(parts)&EXCLUDED_PARTS:
            keep[n] = 'source-tool-configuration-or-test-fixture'
        if n.startswith('localization/completion/') and p.suffix == '.json' and p.stat().st_size <= 65536:
            keep[n] = 'compact-workflow-and-acceptance-record'
        if n.startswith('localization/cleanup/20261103-source-retention-01/'):
            keep[n] = 'current-storage-verification-and-recovery-record'
        if p.name.lower().startswith(('glossary','name-decisions')) and p.suffix in {'.json','.jsonl'} and p.stat().st_size < 2*1024**2:
            keep[n] = 'editable-approved-terminology-input'
        if p.name.lower().startswith(('ofl','license','licence','copyright')) and p.stat().st_size < 1024**2 and not set(parts)&EXCLUDED_PARTS:
            keep[n] = 'input-license'
        if p.name.lower().startswith('tfol.') or p.suffix.lower() in {'.sav','.save','.savegame','.settings'} or 'savegame' in p.name.lower() or 'playerprefs' in p.name.lower():
            keep[n] = 'all-save-and-settings-files-preserved'
        # Keep all untracked source investigations: unlike regenerated outputs,
        # their necessity has not been disproved by a remote source binding.
        if n.startswith('localization/source/') and n not in tracked:
            keep[n] = 'unique-untracked-source-input-preserved'
        # Pin small original source/acceptance records. Large review files are
        # selected by actual current-version IDs below, never by a default pass.
        if n not in tracked and n.startswith(('localization/editorial-delivery/','localization/case-decisions/')) and p.suffix == '.json':
            if re.search(r'(handoff|manifest|acceptance|final|bindings|coverage|review|receipt|ledger)',p.name,re.I):
                if p.stat().st_size < 1024**2:
                    archive.setdefault(n,'canonical-original-editorial-or-case-record')
        if n not in tracked and n.startswith(('localization/editorial-delivery/','localization/case-decisions/')) and p.suffix == '.jsonl' and re.search(r'(review|judg|bind|read|coverage|ledger)',p.name,re.I):
            loc = next((loc for loc in sorted(current,key=len,reverse=True) if any(part == loc or part.startswith(loc+'-') for part in parts)),None)
            if loc:
                for row in documents(p):
                    if isinstance(row,dict):
                        ident = row.get('id',row.get('unitId'))
                        if ident in hashes[loc] and row.get('targetSha256') == hashes[loc][ident]:
                            archive.setdefault(n,'original-wording-evidence-containing-current-exact-version')
                            break
    # All later-read pinned inputs of unfinished tasks stay at their original
    # locations. Follow actual SHA-bound references, not permissive read roots.
    queue = collections.deque(n for n in keep if under(n,LIVE) and Path(n).suffix in {'.json','.jsonl'})
    seen = set()
    while queue:
        n = queue.popleft()
        if n in seen:
            continue
        seen.add(n)
        for ref in references(ROOT/n):
            if ref not in keep:
                keep[ref] = 'unfinished-work-transitive-pinned-input'
                queue.append(ref)
        if len(seen)%100==0:print(json.dumps(dict(stage='unfinished-input-closure',visited=len(seen),queued=len(queue))),flush=True)
    queue = collections.deque(archive)
    seen = set()
    while queue:
        n = queue.popleft()
        if n in seen:
            continue
        seen.add(n)
        for ref in references(ROOT/n):
            if ref not in keep and ref not in archive:
                archive[ref] = 'pinned-original-evidence-dependency'
                queue.append(ref)
        if len(seen)%100==0:print(json.dumps(dict(stage='original-evidence-closure',visited=len(seen),queued=len(queue))),flush=True)
    archive = {n:r for n,r in archive.items() if n not in keep}
    unknown = []
    for n,p in by_name.items():
        if n not in keep and p.relative_to(ROOT).parts[0] not in ROOT_NAMES | {'.venv-assets'}:
            keep[n] = 'unclassified-owner-input-preserved'
            unknown.append(n)
    def record(n,reason):
        p=by_name[n];s=p.stat()
        return dict(path=n,reason=reason,bytes=s.st_size,mode=stat.S_IMODE(s.st_mode),mtimeNs=s.st_mtime_ns,
                    signature=[s.st_dev,s.st_ino,s.st_size,s.st_mtime_ns],sha256=sha(p))
    kept = [record(n,r) for n,r in sorted(keep.items()) if n in by_name]
    evidence = [record(n,r) for n,r in sorted(archive.items()) if n in by_name]
    discarded = [dict(path=n,bytes=p.stat().st_size,signature=[p.stat().st_dev,p.stat().st_ino,p.stat().st_size,p.stat().st_mtime_ns],
                      reason='retained-in-current-Git-history' if n in tracked else 'superseded-generated-output-or-build-context',tracked=n in tracked)
                 for n,p in by_name.items() if n not in keep and n not in archive]
    result=dict(sourceHead=subprocess.check_output(['git','rev-parse','HEAD'],text=True).strip(),
                keep=kept,evidence=evidence,discard=discarded,unknownKept=unknown,
                boundary='No deletion performed. Evidence is original retained data, not new semantic acceptance. Unfinished work and all saves remain at original paths.')
    with gzip.open(HERE/'source-retention-plan.json.gz','xt') as f:
        json.dump(result,f)
    summary={k:dict(files=len(v),bytes=sum(r['bytes'] for r in v)) for k,v in [('keep',kept),('evidence',evidence),('discard',discarded)]}
    summary['keepByReason']={r:sum(x['bytes'] for x in kept if x['reason']==r) for r in sorted({x['reason'] for x in kept})}
    summary['unknownKept']=unknown
    with (HERE/'source-retention-summary.json').open('x') as f:
        json.dump(summary,f,indent=2);f.write('\n')
    print(json.dumps(summary),flush=True)


if __name__ == '__main__':
    main()
