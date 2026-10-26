"""Static adapter regressions; exercises the build's actual validation boundary."""
import ast
import copy
import json
import pathlib
import re
import sys

sys.dont_write_bytecode = True
import corpus
import display_spans as spans

HERE = pathlib.Path(__file__).resolve().parent
ROOT = HERE.parents[1]
OUT = ROOT / 'outputs/locale-assets-20261026/es-419/0035-translation'
results = []


def passed(name, boundary, **extra):
    results.append({'name': name, 'status': 'passed', 'boundary': boundary, **extra})


def rejects(name, reason, action):
    try:
        action()
    except AssertionError as exc:
        assert reason in str(exc), (name, 'wrong rejection boundary', str(exc))
        passed(name, reason, observed=str(exc))
    else:
        raise AssertionError(name + ' unexpectedly accepted')


rows = {r['id']: r for r in map(json.loads, (HERE / corpus.OVERLAY).read_text().splitlines())}
manifest = json.loads((HERE / 'display-spans.json').read_text())
before = json.loads((OUT / 'before.json').read_text())
baseline = json.loads((OUT / 'preservation-before.json').read_text())
assert len(rows) == len(corpus.ROWS) == 12246
assert sum(len(r['occurrences']) for r in rows.values()) == 24492
assert json.loads((HERE / 'unresolved.json').read_text()) == []
assert set(rows) == set(corpus.BYID)
passed('Complete pinned draft', 'Actual built overlay inventory', candidates=12246, occurrences=24492, holds=0)

for ident, expected in before['targetHashes'].items():
    assert rows[ident]['targetSha256'] == spans.sha(rows[ident]['target'].encode()) == expected
for path, expected in baseline['batches'].items():
    assert spans.sha((ROOT / path).read_bytes()) == expected, path
assert len(before['targetHashes']) == 12244
assert set(rows) - set(before['targetHashes']) == spans.ALLOWED_IDS
passed('Saved translations and batches preserved', 'Actual target bytes and entire prior TSV byte streams', targets=12244, batches=len(baseline['batches']))

reasons = json.loads((HERE / 'unchanged-reasons.json').read_text())
for ident in sorted(spans.ALLOWED_IDS):
    row = corpus.BYID[ident]
    target = rows[ident]['target']
    spans.validate_target(row, target, corpus.DISPLAY_SPANS, reasons)
    assert spans.scan(row['source'], [0])[0] == spans.scan(target, [0])[0] == ['[', ']']
    passed('Flower accepted: ' + ident, 'Actual occurrence-bound build validator; exact bracket delimiters')
    rejects('Original opaque scanner still rejects flower prose: ' + ident,
            'protected controls mismatch', lambda: spans.validate_target(row, target, {}, reasons))
    rejects('English flower is not punctuation: ' + ident,
            'unchanged visible text requires an individual reason', lambda: spans.validate_target(row, row['source'], corpus.DISPLAY_SPANS, reasons))
    rejects('Added visible flower number: ' + ident,
            'number mismatch', lambda: spans.validate_target(row, target.replace('flor', 'flor 2'), corpus.DISPLAY_SPANS, reasons))
    rejects('Added flower newline: ' + ident,
            'line separator mismatch', lambda: spans.validate_target(row, target.replace('flor', 'flor\n'), corpus.DISPLAY_SPANS, reasons))
    rejects('Lost flower delimiter: ' + ident,
            'Missing approved display bracket', lambda: spans.validate_target(row, target[1:-1], corpus.DISPLAY_SPANS, reasons))
    rejects('Extra flower delimiter: ' + ident,
            'Unmatched display closing bracket', lambda: spans.validate_target(row, target + ']', corpus.DISPLAY_SPANS, reasons))
    rejects('Flower turned into engine command: ' + ident,
            'Engine command cannot occupy display span', lambda: spans.validate_target(row, '[nosubtitle]', corpus.DISPLAY_SPANS, reasons))
    injected = target[:-1] + ' [lua(Variable["seed"] == "ready]")]]'
    rejects('Nested Lua injected into flower: ' + ident,
            'protected controls mismatch', lambda: spans.validate_target(row, injected, corpus.DISPLAY_SPANS, reasons))

# Real corpus controls: keep the valid translated target as the positive control.
pic = next(r for r in rows.values() if r['target'].startswith('[pic=6]'))
spans.validate_target(corpus.BYID[pic['id']], pic['target'], corpus.DISPLAY_SPANS, reasons)
rejects('Actual portrait operand mutation', 'protected controls mismatch',
        lambda: spans.validate_target(corpus.BYID[pic['id']], pic['target'].replace('[pic=6]', '[pic=7]', 1), corpus.DISPLAY_SPANS, reasons))
tagged = next(r for r in rows.values() if '<cfade>' in r['target'])
spans.validate_target(corpus.BYID[tagged['id']], tagged['target'], corpus.DISPLAY_SPANS, reasons)
rejects('Actual rich-text control mutation', 'protected controls mismatch',
        lambda: spans.validate_target(corpus.BYID[tagged['id']], tagged['target'].replace('<cfade>', '<b>', 1), corpus.DISPLAY_SPANS, reasons))

# This corpus has no Lua/var/brace occurrences. Fixtures exercise exactly the
# production target validator; they do not claim a game/engine execution test.
fixture = {'id': 'fixture:controls', 'source': '[pic=6]Look [lua(Variable["seed"] == "ready]")]. [var=Key] <b>2</b> {player}.\nNext|end\r'}
fixture_target = '[pic=6]Mira [lua(Variable["seed"] == "ready]")]. [var=Key] <b>2</b> {player}.\nSigue|fin\r'
spans.validate_target(fixture, fixture_target, {}, {})
passed('Mixed control fixture positive control', 'Production target validator with synthetic source; no engine execution')
for name, old, new, reason in [
    ('Quoted Lua array operand', 'Variable["seed"]', 'Variable["leaf"]', 'protected controls mismatch'),
    ('Quoted Lua string with closing bracket', 'ready]', 'ready', 'protected controls mismatch'),
    ('Variable operand', '[var=Key]', '[var=Clave]', 'protected controls mismatch'),
    ('Brace placeholder', '{player}', '{jugador}', 'protected controls mismatch'),
    ('Numeric literal', '<b>2</b>', '<b>3</b>', 'number mismatch'),
    ('Pipe separator', '|', '', 'line separator mismatch'),
    ('CR separator', '\r', '', 'line separator mismatch'),
]:
    rejects(name + ' mutation', reason, lambda old=old, new=new: spans.validate_target(fixture, fixture_target.replace(old, new, 1), {}, {}))

unknown = {'id': 'fixture:unknown', 'source': 'Look [unapproved prose].'}
spans.validate_target(unknown, 'Mira [unapproved prose].', {}, {})
rejects('Unknown bracket remains opaque', 'protected controls mismatch', lambda: spans.validate_target(unknown, 'Mira [prosa no aprobada].', {}, {}))

bad = copy.deepcopy(manifest)
bad['evidence'][0]['sha256'] = '0' * 64
rejects('Evidence hash mismatch', 'Display evidence hash mismatch', lambda: spans.validate_manifest(bad, corpus.BYID, corpus.TREES))
badrows = dict(corpus.BYID)
ident = 'ds:131:153:Dialogue Text'
badrows[ident] = {**badrows[ident], 'source': badrows[ident]['source'] + ' '}
rejects('Source hash mismatch', 'Display source hash mismatch', lambda: spans.validate_manifest(manifest, badrows, corpus.TREES))
bad = copy.deepcopy(manifest)
bad['records'][0]['occurrences'] = bad['records'][0]['occurrences'][:1]
rejects('Occurrence mismatch', 'Display occurrence binding mismatch', lambda: spans.validate_manifest(bad, corpus.BYID, corpus.TREES))

# Only an in-memory source copy is changed, restored before further checks.
parent = corpus.TREES[1]
keys = corpus.BYID[ident]['pointer'].strip('/').split('/')
for key in keys[:-1]:
    parent = parent[int(key)] if isinstance(parent, list) else parent[key]
saved = parent[keys[-1]]
try:
    parent[keys[-1]] = saved + ' '
    rejects('Second serialized source copy mismatch', 'Display source copy mismatch', lambda: spans.validate_manifest(manifest, corpus.BYID, corpus.TREES))
finally:
    parent[keys[-1]] = saved
spans.load_manifest(corpus.BYID, corpus.TREES)
spans.load_resolutions(corpus.DISPLAY_SPANS, corpus.BYID)
passed('Manifest, evidence, both source copies and hold receipts', 'Full production loaders on restored real bytes')

# Prove that the shared scanner extraction changes no unapproved token sequence.
old_ast = ast.parse((OUT / 'corpus-before.py').read_text())
fn = next(n for n in old_ast.body if isinstance(n, ast.FunctionDef) and n.name == 'controls')
namespace = {'re': re}
exec(compile(ast.Module(body=[fn], type_ignores=[]), '<preserved-controls>', 'exec'), namespace)
checked = 0
for row in rows.values():
    for text in (row['source'], row['target']):
        assert namespace['controls'](text) == spans.scan(text)[0], row['id']
        checked += 1
passed('Default opaque scanner parity', 'Old/new scanner exact token equality on every source and built target', strings=checked)

report = {'status': 'passed', 'checks': results, 'overlaySha256': spans.sha((HERE / corpus.OVERLAY).read_bytes()),
          'helperSha256': spans.sha((HERE / 'corpus.py').read_bytes()),
          'adapterSha256': spans.sha((HERE / 'display_spans.py').read_bytes()),
          'testSha256': spans.sha(pathlib.Path(__file__).read_bytes()),
          'limits': 'Static adapter and actual overlay checks. Lua/var/brace cases are synthetic because pinned corpus has none. No engine/game execution, independent semantic audit or runtime rendering acceptance.'}
corpus.dump(OUT / 'display-span-validation.json', report)
print(json.dumps({'status': 'passed', 'checks': len(results), 'preservedTargets': 12244, 'preservedBatches': len(baseline['batches']), 'scannerParityStrings': checked}))
