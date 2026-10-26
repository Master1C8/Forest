"""Check authored Japanese mora annotations, verse callbacks and source slot groups.

Storage/validation only: this script never generates translated wording.
"""
import hashlib
import itertools
import json
from pathlib import Path
import re

HERE = Path(__file__).resolve().parent
config = json.loads((HERE / 'locale.json').read_text())
assert config['locale'] == 'ja' and config['sourceLocale'] == 'en'
raw = (HERE / 'dialogue.ja.jsonl').read_bytes()
rows = {r['id']: r for r in map(json.loads, raw.decode().splitlines())}
annotation_raw = (HERE / 'poetry-scansion.json').read_bytes()
a = json.loads(annotation_raw)
assert a['locale'] == 'ja'
annotations = {}
for line in a['lines']:
    assert line['text'] not in annotations
    reading = line['reading']
    assert re.fullmatch('[ぁ-ゖー]+', reading)
    count = sum(c not in 'ゃゅょぁぃぅぇぉゎ' for c in reading)
    assert count == line['morae'], line
    annotations[line['text']] = count


def get(c, e, field='target'):
    return re.sub(r'^(?:\[pic[ac]?=[0-9A-Za-z_]+\])*', '',
                  rows[f'ds:{c}:{e}:Dialogue Text'][field])


def counts(lines):
    return [annotations[line] for line in lines]


def ids(c, entries):
    return [f'ds:{c}:{e}:Dialogue Text' for e in entries]


groups = []
for c, e in [(302, 516), (302, 559), (303, 343), (303, 350), (303, 376)]:
    lines = get(c, e).split('\n')
    assert counts(lines) == [5, 7, 5]
    groups.append({'ids': ids(c, [e]), 'target': lines, 'annotatedMorae': counts(lines)})
for c, entries, expected in [(302, [504, 581, 580], [5, 7, 5]),
                              (303, [325, 326, 327], [5, 7, 5]),
                              (303, [406, 407, 408], [8, 7, 5]),
                              (303, [410, 411, 412], [5, 7, 5])]:
    lines = [get(c, e) for e in entries]
    assert counts(lines) == expected
    groups.append({'ids': ids(c, entries), 'target': lines, 'annotatedMorae': counts(lines)})
assert get(303, 343) == get(303, 350)
singular = get(303, 350).split('\n')[-1]
assert singular == '我に福' and '「皆に福」' in get(303, 330)
assert annotations['皆に福'] == 5
poem = get(302, 516).split('\n')
assert get(300, 483).removeprefix('「') == poem[0]
assert get(300, 484).removesuffix('」') == poem[1]
assert poem[-1] in get(302, 520)
assert get(302, 504, 'source') == 'Two lovely ladies'
assert get(302, 581, 'source') == 'With a handsome equine stud'
assert get(302, 580, 'source') == 'It’s breeding season'
families = {325:'bridge', 326:'bridge', 327:'bridge',
            406:'penny', 407:'penny', 408:'penny',
            410:'bug', 411:'bug', 412:'bug'}
combinations = []
for entries in itertools.product([325, 406, 410], [326, 407, 411], [327, 408, 412]):
    lines = [get(303, e) for e in entries]
    expected = [8 if entries[0] == 406 else 5, 7, 5]
    assert counts(lines) == expected
    cats = {families[e] for e in entries}
    combinations.append({'ids': ids(303, entries), 'target': lines,
                         'annotatedMorae': counts(lines),
                         'sourceFamilyCombination': next(iter(cats)) if len(cats) == 1 else 'mixed'})
assert len(combinations) == 27
assert sum(c['sourceFamilyCombination'] == 'mixed' for c in combinations) == 24
assert sum(c['annotatedMorae'] == [5,7,5] for c in combinations) == 18
assert sum(c['annotatedMorae'] == [8,7,5] for c in combinations) == 9
report = {
    'locale': 'ja',
    'status': 'passed annotation bindings, callbacks and static combinations; one explicit overlength line; independent literary acceptance pending',
    'overlaySha256': hashlib.sha256(raw).hexdigest(),
    'scansionSha256': hashlib.sha256(annotation_raw).hexdigest(),
    'groups': groups, 'checkedGroups': len(groups),
    'checkedSelectableCombinations': 27, 'matchedSourceFamilies':3, 'mixedSourceFamilies':24,
    'strict575Combinations':18, 'explicit875Combinations':9,
    'callbacks':'exact quoted lines, earth reaction and repeated good-fortune poem checked',
    'personCorrection': {'singular':singular, 'collective':'皆に福', 'morae':[5,5]},
    'metricalExceptions':a['metricalExceptions'], 'combinations':combinations, 'limits':a['limits']
}
(HERE/'poetry-validation.json').write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n')
print(json.dumps({k:report[k] for k in ['locale','status','checkedGroups','checkedSelectableCombinations','strict575Combinations','explicit875Combinations','overlaySha256']}))
