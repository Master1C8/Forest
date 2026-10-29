#!/usr/bin/env python3
"""Accepted-only finite Russian51 stage; static private artifacts, never game execution.

BG projection is in memory. Managed output, rollback, reversal, ledger and receipt
are exclusive independent writes: partial output requires explicit reconciliation.
"""
import argparse
import base64
import copy
import hashlib
import importlib.util
import json
import os
from pathlib import Path
import re
import shutil
import subprocess
import sys

PROJECT = Path('/Users/antonkrutov/Desktop/Forest')
LOCAL = Path(__file__).resolve().parent
FROZEN = (LOCAL / 'remaining51-snapshot.json').is_file()
ROOT = LOCAL / 'inputs' if FROZEN else PROJECT
CONTRACT = LOCAL / 'contract' if FROZEN else PROJECT / 'localization/source/remaining51-application-20261029'
PACKET = 'localization/supplemental-ui/20261029-remaining-case51'
TARGET = '7df249ae9a9efdd538dfbdd628640964ef6a84e3ca03651b0ad89dddd5e38674'
PRIOR = '74a2f0e8a4851e128ba853837c31fc8d9c17fa7cdefae57505ae5c763ce0a9de'
BG_PRIOR = '7380c06467b5034f40b77e3a1049a7642c1f4346db9b608500d94c578ce2e877'
ORIGINAL = '46f43b212709b96ac51f2484d1564f863346fed8dc70f532860046226a020acf'
MAP = '96ce2c8983eac73940ea86af512d67c21153c21185dadd24c89763bcc4609de1'
CODEC = 'localization/source/bgdatabase-20261027/decode_inventory.py'
PEER = 'localization/source/bgdatabase-complete-values-20261027/frozen_independent_reader.py'
WIDTHS = {'BGFieldBool': 1, 'BGFieldInt': 4, 'BGFieldEnum': 4, 'BGFieldFloat': 4, 'BGFieldVector2': 8}


def need(ok, reason):
    if not ok:
        raise ValueError(reason)


def digest(b):
    return hashlib.sha256(b).hexdigest()


def sha(p):
    return digest(Path(p).read_bytes())


def enc(v):
    return (json.dumps(v, ensure_ascii=False, sort_keys=True, separators=(',', ':')) + '\n').encode()


def read(p):
    return json.loads(Path(p).read_bytes())


def rows(p):
    return [json.loads(x) for x in Path(p).read_text().splitlines()]


def emit(p, value):
    with Path(p).open('xb') as f:
        f.write(enc(value))


def module(path, name):
    spec = importlib.util.spec_from_file_location(name, path)
    m = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(m)
    return m


def validate_rows(targets, sources, *, locale):
    need(locale == 'ru', 'explicit-ru-locale-required')
    need(len(targets) == len({r['id'] for r in targets}) == 51, 'exact51-unique-ids-required')
    need([r['id'] for r in targets] == [r['id'] for r in sources], 'exact51-ordered-id-set')
    for t, s in zip(targets, sources):
        ident = s['id']
        need(t['locale'] == locale, 'target-locale:' + ident)
        need(t['source'] == s['source'] and t['sourceValueSha256'] == s['sourceValueSha256'], 'source-binding:' + ident)
        need(digest(json.dumps(s['source'], ensure_ascii=False, sort_keys=True, separators=(',', ':')).encode()) == s['sourceValueSha256'], 'canonical-source-value-hash:' + ident)
        need(t['sourceUtf8Sha256'] == s['sourceUtf8Sha256'] == digest(t['source'].encode()), 'source-utf8-hash:' + ident)
        need(t['targetUtf8Sha256'] == digest(t['target'].encode()), 'target-utf8-hash:' + ident)
        need('\\n' not in t['target'] and '\r' not in t['target'], 'raw-LF-required:' + ident)
        need(t['target'].strip() and '\0' not in t['target'], 'invalid-target:' + ident)
        tokens = lambda x: re.findall(r'<[^>]*>|\{[^{}]*\}|\[pic=\d+\]', x)
        need(tokens(t['source']) == tokens(t['target']), 'protected-placeholder-markup:' + ident)
        need(t['source'].count('\n') == t['target'].count('\n'), 'protected-LF:' + ident)
        trailing = lambda x: x[len(x.rstrip()):]
        need(trailing(t['source']) == trailing(t['target']), 'protected-final-space:' + ident)
    need(sum(bool(t['reusedEvidence']) for t in targets) == 3 and all(bool(t['reusedEvidence']) == (t['ordinal'] in [19, 20, 21]) for t in targets), 'retained3-new31-disjoint')


def verify_snapshot():
    if FROZEN:
        for n, h in read(LOCAL / 'remaining51-snapshot.json')['files'].items():
            need(sha(LOCAL / n) == h, 'snapshot-pin:' + n)


def load_inputs(*, locale):
    need(locale == 'ru', 'explicit-ru-locale-required')
    verify_snapshot()
    need(sha(CONTRACT / 'mapping.json') == MAP, 'accepted-mapping-hash')
    for n, h in read(CONTRACT / 'contract-pins.json').items():
        need(sha(CONTRACT / n) == h, 'contract-pin:' + n)
    p = ROOT / PACKET
    need((p / 'ru.acceptance.json').is_file(), 'bounded-editorial-acceptance-required')
    a = read(p / 'ru.acceptance.json')
    need(a['status'] == 'bounded-russian-editorial-accepted' and a['locale'] == locale and a['targetEditorialAccepted'], 'accepted-russian51-required')
    need(a['wordingOccurrences'] == 51 and a['newIndependentSemanticRows'] == 48 and a['retainedAcceptedRows'] == 3 and not a['exactFinalDelta'], 'complete51-acceptance-required')
    need(sha(p / 'ru.prepared.jsonl') == a['targetSha256'] == TARGET, 'accepted-target-hash')
    for n, h in read(CONTRACT / 'input-pins.json').items():
        need(sha(input_path(n)) == h, 'input-pin:' + n)
    need(sha(p / a['sourceDisposition']) == a['sourceDispositionSha256'], 'source-disposition-pin')
    admission = read(p / a['sourceDisposition'])
    need(admission['status'] == 'finite51-static-source-application-design-admitted' and admission['protectedRecords'] == 2135, 'finite-source-admission')
    for n, h in a['evidence'].items():
        need(sha(input_path(n)) == h, 'accepted-evidence-pin:' + n)
    t, s = rows(p / 'ru.prepared.jsonl'), rows(p / 'source-context.jsonl')
    validate_rows(t, s, locale=locale)
    plan = read(CONTRACT / 'mapping.json')
    need([r['id'] for r in plan['rows']] == [r['id'] for r in s], 'mapping-id-set')
    for r, target in zip(plan['rows'], t):
        need(all(r[k] == target[k] for k in ['id', 'ordinal', 'source', 'target', 'sourceUtf8Sha256', 'targetUtf8Sha256', 'sourceValueSha256']), 'mapping-target-version')
    return plan


def _use(plan, locale):
    accepted = load_inputs(locale=locale)
    need(plan is None or plan == accepted, 'accepted-plan-version')
    return accepted


def bg_inventory(data, parse=None, variable_cells=None):
    """Every state, including absent/fixed-width/opaque fields, by exact stable ID."""
    import urllib.parse
    codec = module(ROOT / CODEC, 'remaining51_codec') if parse is None else None
    parse = parse or codec.parse
    variable_cells = variable_cells or codec.variable_cells
    env = parse(data)
    states = {}
    for s in env['sheets']:
        for f in s['fields']:
            blob = data[f['valuesOffset']:f['valuesOffset'] + f['valuesBytes']]
            kind = f['type'].split(',')[0].rsplit('.', 1)[-1]
            if kind in WIDTHS:
                w = WIDTHS[kind]
                need(len(blob) in (0, w * len(s['rowIds'])), 'fixed-field-size')
                cells = [blob[i*w:(i+1)*w] if blob else None for i in range(len(s['rowIds']))]
            else:
                cells, _ = variable_cells(dict(f, valuesHex=blob.hex()), len(s['rowIds']))
            for i, row in enumerate(s['rowIds']):
                ident = 'bgdb:resources.assets:320/sheet/' + urllib.parse.quote(s['id'], safe='') + '/row/' + urllib.parse.quote(row, safe='') + '/field/' + urllib.parse.quote(f['id'], safe='')
                need(ident not in states, 'duplicate-bg-id')
                states[ident] = cells[i]
    need(len(states) == 51572, 'complete51572-states-required')
    return env, states


def project_bg(data, parse, variable_cells, *, locale, plan=None):
    plan = _use(plan, locale)
    actor = module(ROOT / 'tools/russian_actor_names.py', 'remaining51_actor')
    before, states = bg_inventory(data, parse, variable_cells)
    selected = [r for r in plan['rows'] if r['id'].startswith('bgdb:')]
    need(len(selected) == 17 and all(not r['alreadyApplied'] for r in selected), 'exact17-bg-required')
    s = next(x for x in before['sheets'] if x['id'] == selected[0]['sheetId'])
    need(s['name'] == 'ActorGossipGreeting' and s['rowIds'] == [r['rowId'] for r in selected], 'bg-row-identity-order')
    f = next(x for x in s['fields'] if x['id'] == selected[0]['fieldId'])
    need(f['name'] == 'greeting_text_test' and f['type'].split(',')[0].endswith('.BGFieldText'), 'active-bg-field-identity')
    old = data[f['valuesOffset']:f['valuesOffset'] + f['valuesBytes']]
    cells, _ = variable_cells(dict(f, valuesHex=old.hex()), 17)
    for r in selected:
        need(states[r['id']] == r['source'].encode(), 'bg-source-before:' + r['id'])
        cells[r['rowIndex']] = r['target'].encode()
    # Validate all 85 original unselected fields, including the 17 dormant siblings.
    for r in rows(ROOT / PACKET / 'preserve-exactly.jsonl'):
        if r['kind'] == 'BG-unselected-field':
            c = r['cell']; expected = None if c['sourceBytesBase64'] is None else base64.b64decode(c['sourceBytesBase64'])
            need(states[c['id']] == expected, 'bg-protected-state:' + c['id'])
    need(digest(data) == BG_PRIOR, 'supported-prior-bg-payload-hash')
    result = actor.replace_columns(data, [(f, actor.encode_cells(old, cells))])
    after, new = bg_inventory(result, parse, variable_cells)
    need(set(new) == set(states), 'bg-state-id-set')
    changed = [i for i in states if states[i] != new[i]]
    need(set(changed) == {r['id'] for r in selected}, 'bg-exact17-changed-set')
    for r in selected:
        need(new[r['id']] == r['target'].encode(), 'bg-target-readback')
    sf = next(x for x in after['sheets'] if x['id'] == s['id'])
    nf = next(x for x in sf['fields'] if x['id'] == f['id'])
    need(actor.replace_columns(result, [(nf, old)]) == data, 'bg-whole-prior-restoration')
    return result, dict(selectedCells=17, independentlyRequiredStates=51572, comparedStates=len(states), changedIds=changed,
                        protectedBGRecords=85, dormantSiblingsPreserved=17, fullImmediatePriorPayloadRestored=True,
                        beforePayloadSha256=digest(data), targetPayloadSha256=digest(result))


def compile_backend(folder):
    folder = Path(folder)
    verify_snapshot()
    root = LOCAL
    project = root / 'remaining51_patch/Remaining51Patch.csproj'
    # Version-specific SDK and dependency pins are checked before compilation.
    compiler = read(root / 'remaining51_patch/compiler-pins.json')
    for n, h in compiler['files'].items():
        need(sha(compiler_path(n)) == h, 'compiler-pin:' + n)
    env = dict(os.environ, DOTNET_CLI_TELEMETRY_OPTOUT='1', DOTNET_NOLOGO='1', DOTNET_ROOT=str(compiler_path(compiler['dotnet']).parent))
    subprocess.run([str(compiler_path(compiler['dotnet'])), 'build', str(project), '--nologo', '--verbosity', 'quiet', '-o', str(folder), '-p:BaseIntermediateOutputPath=' + str(folder / 'obj') + '/'], cwd=project.parent, env=env, check=True)
    emit(folder / 'compiled-pins.json', {
        'sourcePins': {n: sha(root / 'remaining51_patch' / n) for n in ['Program.cs', 'Remaining51Patch.csproj', 'compiler-pins.json', 'global.json']},
        'files': {str(p.relative_to(folder)): sha(p) for p in sorted(folder.rglob('*')) if p.is_file() and 'obj' not in p.relative_to(folder).parts},
    })
    return folder / 'Remaining51Patch.dll'


def patch_managed(source, output, receipt, *, locale, backend, plan=None):
    plan = _use(plan, locale)
    source, output, receipt = map(Path, (source, output, receipt))
    need(sha(source) == PRIOR, 'supported-prior-haiku-assembly-hash')
    need(all(not p.exists() for p in [output, receipt] + [Path(str(output) + x) for x in ['.before.dll', '.reversed.dll', '.methods.jsonl']]), 'new-output-required')
    need(PROJECT in output.resolve().parents and PROJECT in receipt.resolve().parents, 'project-owned-output-required')
    backend = Path(backend)
    compiled = read(backend.parent / 'compiled-pins.json')
    for n, expected in compiled['sourcePins'].items():
        need(sha(LOCAL / 'remaining51_patch' / n) == expected, 'compiled-source-pin:' + n)
    for n, expected in compiled['files'].items():
        need(sha(backend.parent / n) == expected, 'compiled-backend-pin:' + n)
    compiler = read(LOCAL / 'remaining51_patch/compiler-pins.json')
    host = compiler_path(compiler['dotnet'])
    need(sha(host) == compiler['files'][compiler['dotnet']], 'runtime-host-pin')
    subprocess.run([str(host), str(backend), 'patch', str(source), str(CONTRACT / 'mapping.json'), str(output), str(receipt)], check=True)
    result = read(receipt)
    need(sha(output) == result['outputSha256'] and result['wholeAssemblyReadback'] and result['serializedReversalByteExact'], 'managed-postcondition')
    return result


def snapshot(out, *, locale):
    load_inputs(locale=locale)
    dest = Path(out) / 'remaining51'
    need(not dest.exists(), 'new-snapshot-required')
    files = {'russian_remaining51_case.py': Path(__file__).read_bytes()}
    builder = LOCAL / 'build_russian_preview.py' if FROZEN else PROJECT / 'tools/build_russian_preview.py'
    files['build_russian_preview.py'] = builder.read_bytes()
    for name in ['input-pins.json', 'mapping.json', 'contract-pins.json']:
        files['contract/' + name] = (CONTRACT / name).read_bytes()
    for n, h in read(CONTRACT / 'input-pins.json').items():
        # Absolute policy references receive a private relative copy and a binding map.
        rel = 'absolute/' + n.lstrip('/') if Path(n).is_absolute() else n
        files['inputs/' + rel] = input_path(n).read_bytes()
    # Runtime loader uses original absolute references only for policy checks; freeze
    # their resolution into this manifest and rewrite no source/acceptance bytes.
    absolute = {n: 'absolute/' + n.lstrip('/') for n in read(CONTRACT / 'input-pins.json') if Path(n).is_absolute()}
    files['absolute-bindings.json'] = enc(absolute)
    backend_root = LOCAL / 'remaining51_patch'
    for p in backend_root.rglob('*'):
        if p.is_file() and not any(x in p.relative_to(backend_root).parts for x in ['bin', 'obj']):
            files['remaining51_patch/' + str(p.relative_to(backend_root))] = p.read_bytes()
    # Freeze the full compiler/host/runtime/reference-pack dependency tree too.
    for name, h in read(backend_root / 'compiler-pins.json')['files'].items():
        raw = compiler_path(name).read_bytes()
        need(digest(raw) == h, 'snapshot-compiler-pin:' + name)
        files['compiler/' + name.lstrip('/')] = raw
    # Resolve and validate ALL bytes before first destination write.
    dest.mkdir(parents=True)
    for n, b in files.items():
        p = dest / n; p.parent.mkdir(parents=True, exist_ok=True)
        with p.open('xb') as f:
            f.write(b)
    dotnet = read(backend_root / 'compiler-pins.json')['dotnet']
    (dest / 'compiler' / dotnet.lstrip('/')).chmod(0o755)
    emit(dest / 'remaining51-snapshot.json', {'files': {n: digest(b) for n, b in files.items()}, 'commitBoundary': 'exclusive independent files; final manifest marks complete snapshot; reconcile partial directory, never retry over it'})
    return dest


def compiler_path(n):
    return LOCAL / 'compiler' / n.lstrip('/') if FROZEN else Path(n)


def input_path(n):
    if FROZEN and Path(n).is_absolute():
        return ROOT / read(LOCAL / 'absolute-bindings.json')[n]
    return ROOT / n


# Keep acceptance/source bytes untouched while redirecting frozen absolute pins.
# All actual loader pin resolutions use this one boundary.
def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('--locale', required=True)
    sub = p.add_subparsers(dest='command', required=True)
    sub.add_parser('preflight')
    s = sub.add_parser('snapshot'); s.add_argument('--output', type=Path, required=True)
    c = sub.add_parser('compile'); c.add_argument('--output', type=Path, required=True)
    a = sub.add_parser('patch')
    for n in ['input', 'output', 'receipt', 'backend']:
        a.add_argument('--' + n, type=Path, required=True)
    args = p.parse_args()
    if args.command == 'preflight':
        plan = load_inputs(locale=args.locale); print(json.dumps({'passed': True, 'occurrences': len(plan['rows']), 'newBG': 17, 'newCompiled': 31, 'retainedCompiled': 3}))
    elif args.command == 'snapshot':
        snapshot(args.output, locale=args.locale)
    elif args.command == 'compile':
        load_inputs(locale=args.locale); compile_backend(args.output)
    else:
        patch_managed(args.input, args.output, args.receipt, locale=args.locale, backend=args.backend)


if __name__ == '__main__':
    main()
