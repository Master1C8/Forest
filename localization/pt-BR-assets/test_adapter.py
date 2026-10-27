"""Static regressions for the pt-BR occurrence-bound bracket adapter.

Uses the actual corpus validator and real pinned source trees. Synthetic scanner
pairs exercise grammar preservation without pretending to execute the engine.
No translated wording is generated and no corpus output is modified.
"""
import hashlib
import json
from pathlib import Path
import runpy
import sys

sys.dont_write_bytecode = True
HERE = Path(__file__).resolve().parent
corpus = runpy.run_path(str(HERE / 'corpus.py'))
controls = corpus['controls']
scan = corpus['scan']
checks = []


def reject(name, action, reason):
    try:
        action()
    except AssertionError as error:
        assert reason in str(error), (name, 'wrong rejection boundary', str(error))
        checks.append({'test': name, 'result': 'rejected', 'boundary': str(error)})
    else:
        raise AssertionError(name + ' unexpectedly accepted')


def pair(source, target, ordinals=()):
    source_tokens, source_visible = scan(source, ordinals)
    target_tokens, target_visible = scan(target, ordinals)
    assert source_tokens == target_tokens, 'protected control mismatch'
    import re
    assert re.findall(r'\d+', source_visible) == re.findall(r'\d+', target_visible), 'number mismatch'
    for separator in ('\n', '\r', '|'):
        assert source.count(separator) == target.count(separator), 'line separator mismatch'


receipts = corpus['load_hold_resolutions']()
for ident, receipt in receipts.items():
    row = corpus['BYID'][ident]
    corpus['validate_pair'](row, receipt['target'])
    checks.append({'test': ident, 'result': 'accepted',
                   'boundary': 'actual occurrence/source/evidence-bound validator, both pinned source trees'})
    reject(ident + ' without approval',
           lambda: pair(row['source'], receipt['target']), 'protected control mismatch')
    reject(ident + ' missing closing delimiter',
           lambda: corpus['validate_pair'](row, receipt['target'][:-1]), 'Unbalanced bracket')
    reject(ident + ' extra closing delimiter',
           lambda: corpus['validate_pair'](row, receipt['target'] + ']'), 'protected control mismatch')
    reject(ident + ' injected control',
           lambda: corpus['validate_pair'](row, receipt['target'][:-1] + '[pic=9]]'), 'protected control mismatch')
    reject(ident + ' engine replacement',
           lambda: corpus['validate_pair'](row, '[var=flower]'), 'became an engine control')
    original = row['source']
    try:
        row['source'] += ' '
        reject(ident + ' stale source approval', corpus['load_display_spans'], 'Display source binding mismatch')
    finally:
        row['source'] = original
    original = row['occurrences']
    try:
        row['occurrences'] = original[:1]
        reject(ident + ' occurrence removed', corpus['load_display_spans'], 'Display occurrence binding mismatch')
    finally:
        row['occurrences'] = original

# Paired positives keep the same unrelated syntax as the corresponding negative.
source = '[pic=3][A flower [lua(Variable["key]"][1])] [var=Name] <b>2</b> {0}|\n]'
target = '[pic=3][Uma flor [lua(Variable["key]"][1])] [var=Name] <b>2</b> {0}|\n]'
pair(source, target, (1,))
checks.append({'test': 'nested quoted Lua with bracket inside its key', 'result': 'accepted',
               'boundary': 'scanner; exact nested operands, rich text, placeholders, numbers and separators'})
for name, old, new in [
        ('pic operand', '[pic=3]', '[pic=4]'),
        ('quoted Lua key', '"key]"', '"chave]"'),
        ('nested Lua index', '[1]', '[2]'),
        ('variable operand', '[var=Name]', '[var=Nome]'),
        ('rich text', '<b>', '<i>'),
        ('placeholder', '{0}', '{1}'),
        ('unknown bracket', '[opaque=7]', '[opaque=8]')]:
    a = source + '[opaque=7]'
    b = target + '[opaque=7]'
    pair(a, b, (1,))
    reject('changed ' + name, lambda a=a, b=b, old=old, new=new: pair(a, b.replace(old, new), (1,)),
           'protected control mismatch')
reject('changed number in approved prose', lambda: pair(source, target.replace('>2<', '>3<'), (1,)), 'number mismatch')
reject('changed pipe separator in approved prose', lambda: pair(source, target.replace('|', ''), (1,)), 'line separator mismatch')
reject('changed newline in approved prose', lambda: pair(source, target.replace('\n', ''), (1,)), 'line separator mismatch')
pair('[An unknown bracket]', '[An unknown bracket]')
reject('unapproved unknown prose translation', lambda: pair('[An unknown bracket]', '[Um colchete desconhecido]'), 'protected control mismatch')
reject('display approval missing in target', lambda: pair('[Flower]', 'Flor', (0,)), 'Missing approved bracket')
pair('[A flower [lua(Variable["a\\\"b]"][1])]]', '[Uma flor [lua(Variable["a\\\"b]"][1])]]', (0,))
checks.append({'test': 'escaped quote and nested Lua index', 'result': 'accepted', 'boundary': 'scanner'})
manifest = json.loads((HERE / 'display-spans.json').read_text())
binding = {**manifest['consumerEvidence'][0], 'sha256': '0' * 64}
reject('changed consumer evidence', lambda: corpus['verify_file'](binding), 'evidence hash mismatch')

saved = {r['id']: r for r in map(json.loads, (HERE / 'dialogue.pt-BR.jsonl').read_text().splitlines())}
for ident in ['ds:505:1165:Dialogue Text', 'ds:512:938:Dialogue Text']:
    row = saved[ident]
    corpus['validate_pair'](row, row['target'])
    checks.append({'test': ident + ' source anomaly retained', 'result': 'accepted',
                   'boundary': 'actual source/storage validator, both pinned copies'})
    reject(ident + ' source anomaly removed',
           lambda row=row: corpus['validate_pair'](row, row['target'].replace(']]', ']', 1)),
           'protected control mismatch')

report = {'locale': 'pt-BR', 'status': 'passed', 'checks': checks,
          'checkCount': len(checks),
          'corpusSha256': hashlib.sha256((HERE / 'corpus.py').read_bytes()).hexdigest(),
          'manifestSha256': hashlib.sha256((HERE / 'display-spans.json').read_bytes()).hexdigest(),
          'limits': 'Static source/storage validator only. No engine execution, runtime rendering or independent semantic audit.'}
if len(sys.argv) > 1:
    output = Path(sys.argv[1]).resolve()
    allowed = HERE.parents[1] / 'outputs/locale-assets-20261026/pt-BR'
    assert output.is_relative_to(allowed), 'Report must stay in own output lane'
    output.write_text(json.dumps(report, ensure_ascii=False, indent=2) + '\n')
print(json.dumps({'status': report['status'], 'checks': report['checkCount']}))
