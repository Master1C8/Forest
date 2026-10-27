"""Check directly authored pt-BR scansion, complete haiku groups and callbacks.

Deterministic annotation checks do not independently establish pronunciation,
meaning or literary quality. No translated wording is generated here.
"""
import hashlib
import itertools
import json
from pathlib import Path
import re

HERE = Path(__file__).resolve().parent
CONFIG = json.loads((HERE / 'locale.json').read_text())
assert CONFIG['locale'] == 'pt-BR' and CONFIG['sourceLocale'] == 'en'
raw = (HERE / 'dialogue.pt-BR.jsonl').read_bytes()
rows = {r['id']: r for r in map(json.loads, raw.decode().splitlines())}
annotation_raw = (HERE / 'poetry-scansion.json').read_bytes()
annotation = json.loads(annotation_raw)
assert annotation['locale'] == CONFIG['locale']


def letters(text):
    return ''.join(c for c in text.casefold() if c.isalpha())


annotated = {}
for line in annotation['lines']:
    assert line['text'] not in annotated
    assert letters(line['text']) == letters(line['scansion']), line
    count = len(line['scansion'].split('-')) - line['finalUncountedSyllables']
    assert count == line['count'], line
    annotated[line['text']] = count


def get(conversation, entry):
    return re.sub(r'^(?:\[pic[ac]?=[0-9A-Za-z_]+\])*', '',
                  rows[f'ds:{conversation}:{entry}:Dialogue Text']['target'])


def counts(lines):
    return [annotated[line] for line in lines]


checks = []
for conversation, entry in [(302, 516), (302, 559), (303, 343),
                             (303, 350), (303, 376)]:
    lines = get(conversation, entry).split('\n')
    actual = counts(lines)
    assert actual == [5, 7, 5], (conversation, entry, actual)
    checks.append({'ids': [f'ds:{conversation}:{entry}:Dialogue Text'],
                   'target': lines, 'annotatedPoeticSyllables': actual})
for conversation, ids in [(302, [504, 581, 580]),
                           (303, [325, 326, 327]),
                           (303, [406, 407, 408]),
                           (303, [410, 411, 412])]:
    lines = [get(conversation, entry) for entry in ids]
    actual = counts(lines)
    assert actual == [5, 7, 5], (conversation, ids, actual)
    checks.append({'ids': [f'ds:{conversation}:{entry}:Dialogue Text' for entry in ids],
                   'target': lines, 'annotatedPoeticSyllables': actual})

assert get(303, 343) == get(303, 350)
singular = get(303, 350).split('\n')[-1]
plural = 'Quanta sorte temos'
assert singular == 'Quanta sorte eu tenho' and singular != plural
assert f'"{plural}"' in get(303, 330) and annotated[plural] == 5
poem = get(302, 516).split('\n')
for entry, line in zip([483, 484], poem):
    assert get(300, entry).strip('"') == line
assert poem[-1].upper() in get(302, 520)

families = {325: 'bridge', 326: 'bridge', 327: 'bridge',
            406: 'penny', 407: 'penny', 408: 'penny',
            410: 'bug', 411: 'bug', 412: 'bug'}
combinations = []
for ids in itertools.product([325, 406, 410], [326, 407, 411], [327, 408, 412]):
    lines = [get(303, entry) for entry in ids]
    actual = counts(lines)
    assert actual == [5, 7, 5]
    cats = {families[entry] for entry in ids}
    combinations.append({'ids': [f'ds:303:{entry}:Dialogue Text' for entry in ids],
                         'target': lines, 'annotatedPoeticSyllables': actual,
                         'sourceFamilyCombination': next(iter(cats)) if len(cats) == 1 else 'mixed'})
assert len(combinations) == 27
assert sum(c['sourceFamilyCombination'] == 'mixed' for c in combinations) == 24

report = {
    'locale': 'pt-BR',
    'status': 'passed exact annotation/group/callback/combinatorial checks; independent literary review pending',
    'overlaySha256': hashlib.sha256(raw).hexdigest(),
    'scansionSha256': hashlib.sha256(annotation_raw).hexdigest(),
    'checkedPoemGroups': checks,
    'checkedSelectableCombinations': 27,
    'matchedSourceFamilies': 3,
    'mixedSourceFamilies': 24,
    'callbackEquality': 'passed: 300:483/484 quotes and 302:520 reaction bind 302:516',
    'personCorrection': {'singular': singular, 'plural': plural, 'poeticMeter': [5, 5]},
    'combinations': combinations,
    'limits': [
        'Author-supplied scansion is not independent phonological or semantic verification.',
        'Portuguese synalepha and counting through the last stressed syllable are explicitly annotated.',
        'All 27 static field combinations were assembled; game selection, conditions, timing, layout and rendering were not exercised.',
        'Mixed combinations intentionally retain the source incongruity.',
        'No shared registry, source, links, conditions or runtime controls were changed.'
    ]
}
(HERE / 'poetry-validation.json').write_text(json.dumps(report, ensure_ascii=False, indent=2) + '\n')
print(json.dumps({'locale': 'pt-BR', 'groups': len(checks), 'combinations': 27,
                  'annotationBinding': 'passed', 'callbacks': 'passed',
                  'overlaySha256': report['overlaySha256']}))
