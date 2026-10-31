"""Remove only source-identical files in restored, inactive German QA copies.

The original source, accepted Russian build, changed resources, saves, captures,
logs, frozen execution and active input dependency closure are never selected.
No process is stopped. Each unlink has an exact retained reconstruction anchor.
"""
import argparse
import hashlib
import json
import os
from pathlib import Path
import shutil
import subprocess
import time

ROOT = Path(__file__).resolve().parents[3]
HERE = Path(__file__).resolve().parent
SCOPE = ROOT/'localization/de-assets/completion/game-tests-20261031-01'
LANE = ROOT/'outputs/locale-assets-20261026/de/workflow-v3-completion-20261030'
ANCHORS = [ROOT/'localization/previews/ru-20261029-narrative42-01/game',
           Path('/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest')]
HASHES = {}


def identity(p):
    s = p.stat()
    return [s.st_dev, s.st_ino, s.st_size, s.st_mtime_ns, s.st_mode, s.st_nlink, s.st_flags]


def sha(p):
    stamp = identity(p)
    key = tuple(stamp)
    if key not in HASHES:
        h = hashlib.sha256()
        with p.open('rb') as f:
            for chunk in iter(lambda: f.read(4*1024**2), b''):
                h.update(chunk)
        assert identity(p) == stamp, ('Changed while hashing', str(p))
        HASHES[key] = h.hexdigest()
    return HASHES[key]


def read(p):
    return json.loads(p.read_bytes())


def write(p, value):
    with p.open('x') as f:
        json.dump(value, f, ensure_ascii=False, indent=2); f.write('\n')


def rel(p):
    return str(p.relative_to(ROOT))


def tracked():
    return set(subprocess.check_output(['git','ls-files','-z'], cwd=ROOT).decode().split('\0'))


def safe_file(p):
    assert p.is_relative_to(SCOPE) and p.is_file() and not p.is_symlink()
    assert not any(a.is_symlink() for a in p.parents if a.is_relative_to(ROOT))
    assert not p.stat().st_flags, ('Protected file flags', rel(p))


def active_closure(games):
    state = read(LANE/'status.json'); phase = Path(state['phases'][-1]['phase'])
    task = read(phase/'task.json')
    seeds = [phase/'task.json', phase/'brief.md']
    seeds += [ROOT/p['path'] for p in task['task'].get('entryPins', [])]
    immutable = [Path(p) if Path(p).is_absolute() else ROOT/p for p in task['job'].get('immutablePins', {})]
    for name in [task['task'].get('reviewPacket'), *task['task'].get('contextPackets', [])]:
        if name: seeds.append(ROOT/name)
    if task.get('losslessView'): seeds.append(ROOT/task['losslessView']['path'])
    # Global immutable contracts stay untouched. Their old receipt/provenance
    # graphs are not all inputs to this step; explicit entry/context manifests
    # carry the current finite dependency closure.
    seen = set(); protected = {p.resolve() for p in immutable}; protected_games = set(); queue = list(seeds)
    read_roots = {p.resolve().parent for p in seeds}
    while queue:
        p = queue.pop().resolve()
        if p in seen or not p.is_file() or not p.is_relative_to(ROOT): continue
        seen.add(p); protected.add(p)
        assert len(seen) <= 20000, 'Active dependency closure needs explicit broader reconciliation'
        for game in games:
            if p.is_relative_to(game.parent): protected_games.add(rel(game))
        # Request/event streams are retained evidence, not executable input
        # manifests. Following tool outputs would crawl unrelated chat history.
        if p.name in {'events.jsonl','observer.stdout.jsonl','last-message.txt','transcript.jsonl'}: continue
        if p.suffix not in {'.json','.jsonl','.md','.txt','.py'}: continue
        # Large corpus payloads are preserved themselves, not treated as code.
        if p.stat().st_size > 2*1024**2: continue
        text = p.read_text(errors='strict')
        for game in games:
            if str(game.parent) in text or rel(game.parent) in text:
                protected_games.add(rel(game))
        # Inspect referenced historical evidence for direct game bindings, but
        # do not turn its entire old provenance into current-step dependencies.
        if not any(p.is_relative_to(base) for base in read_roots): continue
        if p.suffix not in {'.json','.jsonl'}: continue
        try:
            if p == phase/'task.json':
                # The current task has its complete entry/context pins. The
                # job's old ownerResume/firstTask receipts are historical state,
                # not additional inputs to the current finite assignment.
                data = task['task']
            elif p.suffix == '.json': data = read(p)
            else:
                data = []
                for line in text.splitlines():
                    if not line.strip(): continue
                    # Existing source-context transport has one framed header
                    # followed by ordinary JSONL rows; retain its whole object.
                    prefix, separator, body = line.partition(' {')
                    words = prefix.split()
                    if separator and len(words) == 2 and words[0] == 'CONVERSATION' and words[1].isdigit():
                        line = '{' + body
                    data.append(json.loads(line))
        except ValueError: raise RuntimeError('Unread active metadata: '+rel(p))
        # Only hash-bound declarations extend the immutable input closure.
        # Arbitrary historical filenames remain protected files, but are not
        # instructions to traverse every old audit/chat in the repository.
        refs = set(); structures = [data]
        def digest(v):
            return isinstance(v,str) and len(v)==64 and all(c in '0123456789abcdef' for c in v.lower())
        while structures:
            value = structures.pop()
            if isinstance(value,dict):
                if isinstance(value.get('path'),str) and digest(value.get('sha256')): refs.add(value['path'])
                for key,item in value.items():
                    if digest(item): refs.add(key)
                    if isinstance(item,dict) and digest(item.get('sha256')): refs.add(key)
                    if isinstance(item,str) and digest(value.get(key+'Sha256')): refs.add(item)
                    if isinstance(item,(dict,list)): structures.append(item)
            elif isinstance(value,list): structures.extend(value)
        pending = [data,*refs]
        while pending:
            value = pending.pop()
            if isinstance(value, dict): pending.extend(value.values())
            elif isinstance(value, list): pending.extend(value)
            elif isinstance(value, str) and len(value) < 1600:
                if '\n' in value or any(len(part.encode()) > 255 for part in Path(value).parts): continue
                if not (value.startswith(('/','localization/','outputs/','tools/','assets/','dist/','review/','../'))
                        or Path(value).suffix in {'.json','.jsonl','.md','.py','.assets','.dll','.bin','.bundle','.png','.webp'}): continue
                for candidate in [ROOT/value, p.parent/value]:
                    resolved=candidate.resolve()
                    if resolved.is_relative_to(ROOT):
                        for game in games:
                            if resolved.is_relative_to(game.parent): protected_games.add(rel(game))
                        if candidate.is_file():
                            protected.add(resolved)
                            if value in refs and candidate.suffix in {'.json','.jsonl'}: queue.append(candidate)
    return dict(phase=str(phase), files=sorted(map(str, protected)), games=sorted(protected_games),
                metadataFilesRead=len(seen))


def process_guard(game):
    lines = subprocess.check_output(['ps','-axo','pid=,command='], text=True).splitlines()
    variants = [str(game), str(game).replace('/','\\'), str(game).replace('/Users/antonkrutov','',1).replace('/','\\')]
    return not any(any(v in row for v in variants) for row in lines)


def cleanup_ok(run):
    p = run/'cleanup.json'
    if not p.is_file(): return False
    c = read(p)
    return (all(c.get(k) is True for k in ['taskOwnedProcessesAbsent','originalGameByteExact',
            'parentCandidateByteExact','fixtureRestored','bridgeRemoved'])
            and c.get('ownerSaveFilesUsed') is False and not c.get('cleanupErrors'))


def plan():
    files = []; held = []; git = tracked()
    games = [r/'game' for r in sorted(SCOPE.glob('runtime-*')) if (r/'game').is_dir()]
    closure = active_closure(games)
    print(json.dumps(dict(activeMetadata=closure['metadataFilesRead'],protectedGames=closure['games'])),flush=True)
    for game in games:
        run = game.parent
        if not cleanup_ok(run) or rel(game) in closure['games'] or not process_guard(game):
            held.append(dict(path=rel(game), reason='active-reference, live-process or unverified cleanup')); continue
        receipt = run/'cleanup.json'; receipt_sha = sha(receipt)
        for base, dirs, names in os.walk(game, followlinks=False):
            dirs[:] = [d for d in dirs if not (Path(base)/d).is_symlink()]
            for name in sorted(names):
                p = Path(base)/name
                if (p.is_symlink() or rel(p) in git or str(p.resolve()) in closure['files']
                        or name.startswith('tfol.') or name == 'app.info' or p.stat().st_flags): continue
                safe_file(p); relative = p.relative_to(game)
                for anchor_root in ANCHORS:
                    anchor = anchor_root/relative
                    if (not anchor.is_file() or anchor.is_symlink()
                            or anchor.stat().st_size != p.stat().st_size): continue
                    if sha(p) != sha(anchor): continue
                    files.append(dict(path=rel(p), game=rel(game), identity=identity(p), sha256=sha(p),
                        anchor=str(anchor), anchorIdentity=identity(anchor), cleanup=rel(receipt), cleanupSha256=receipt_sha))
                    break
        print('verified',run.name,'selectedFiles',len(files),flush=True)
    result = dict(schemaVersion=1, at=time.time(), root=str(ROOT), phase=closure['phase'],
        protectedClosure=closure, held=held, deletions=files, logicalBytes=sum(r['identity'][2] for r in files),
        freeBefore=shutil.disk_usage(ROOT).free,
        meaning='Only independently retained byte-identical files; all unique outputs and restoration evidence survive.')
    write(HERE/'plan.json', result)
    print(json.dumps(dict(files=len(files), logicalGiB=round(result['logicalBytes']/2**30,3), held=held,
                         protectedMetadataFiles=len(closure['files']), freeGiB=round(result['freeBefore']/2**30,3))),flush=True)


def apply():
    data = read(HERE/'plan.json'); assert data['root'] == str(ROOT)
    git = tracked(); games = [ROOT/g for g in sorted({r['game'] for r in data['deletions']})]
    closure = active_closure(games)
    selected = [r for r in data['deletions'] if r['game'] not in closure['games'] and str(ROOT/r['path']) not in closure['files']]
    # Verify the complete selected content and retained anchors before any unlink.
    for r in selected:
        p = ROOT/r['path']; a = Path(r['anchor']); safe_file(p)
        assert r['path'] not in git and identity(p) == r['identity'] and sha(p) == sha(a) == r['sha256']
        assert identity(a) == r['anchorIdentity'] and sha(ROOT/r['cleanup']) == r['cleanupSha256']
    if read(LANE/'status.json')['phases'][-1]['phase'] != closure['phase']:
        closure = active_closure(games)
        selected = [r for r in selected if r['game'] not in closure['games']
                    and str(ROOT/r['path']) not in closure['files']]
    count = total = 0; stop = None; current_game = None
    with (HERE/'deleted.jsonl').open('x') as journal:
        for r in selected:
            if r['game'] != current_game:
                current_game = r['game']
                state = read(LANE/'status.json')
                if state['phases'][-1]['phase'] != closure['phase']:
                    stop = 'Active phase changed; remaining files preserved'; break
                assert cleanup_ok((ROOT/r['game']).parent) and process_guard(ROOT/r['game'])
            p = ROOT/r['path']; a = Path(r['anchor']); safe_file(p)
            assert identity(p) == r['identity'] and identity(a) == r['anchorIdentity']
            assert sha(p) == sha(a) == r['sha256'] and r['path'] not in git
            p.unlink(); count += 1; total += r['identity'][2]
            journal.write(json.dumps(r,ensure_ascii=False)+'\n'); journal.flush()
    result = dict(files=count, logicalBytesRemoved=total, freeBefore=data['freeBefore'],
        freeAfter=shutil.disk_usage(ROOT).free, stoppedReason=stop,
        activePhasePreserved=True, trackedFilesDeleted=0, uniqueFilesDeleted=0,
        capturesLogsSavesFrozenExecutionAndChangedResourcesPreserved=True,
        note='Free-space delta is observed, not inferred from logical bytes; APFS sharing and concurrent work affect it.')
    write(HERE/'result.json', result); print(json.dumps(result),flush=True)


if __name__ == '__main__':
    assert Path.cwd().resolve() == ROOT
    parser = argparse.ArgumentParser(); parser.add_argument('action', choices=['plan','apply'])
    {'plan':plan, 'apply':apply}[parser.parse_args().action]()
