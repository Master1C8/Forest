"""Version-bound accepted corrections over the immutable historical935 packet."""
import argparse
import hashlib
import json
from pathlib import Path
import re
import shutil

ROOT = Path('/Users/antonkrutov/Desktop/Forest')
OLD = ROOT / 'localization/supplemental-ui/20261027'
FINAL = ROOT / 'localization/supplemental-ui/20261029-existing935'
JOBS = ROOT / 'outputs/ru-ui935-review-20261029'


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def read(path):
    return json.loads(path.read_text())


def rows(path):
    data = [json.loads(line) for line in path.read_text().splitlines()]
    assert len(data) == len({r['id'] for r in data}) == 935, 'exact935-unique-ids'
    return {r['id']: r for r in data}


def load_inputs(*, locale):
    assert locale == 'ru', 'explicit-supported-locale-required'
    local = Path(__file__).parent
    frozen = (local / 'ui935-inputs.json').exists()
    if frozen:
        for name, expected in read(local / 'ui935-inputs.json').items():
            assert Path(name).name == name and sha(local / name) == expected, 'ui935-snapshot-pin'
    folder = local if frozen else FINAL
    path = folder / ('ui935-acceptance.json' if frozen else 'ru.acceptance.json')
    assert path.is_file(), 'ui935-editorial-acceptance-required'
    accepted = read(path)
    assert accepted['status'] == 'accepted-russian-ui935' and accepted['locale'] == locale
    assert Path(accepted['targetFile']).name == accepted['targetFile'], 'ui935-target-basename'
    base = local / 'ui935-base-targets.jsonl' if frozen else OLD / 'ru.jsonl'
    target = local / 'ui935-accepted-targets.jsonl' if frozen else FINAL / accepted['targetFile']
    catalog = local / 'ui935-source-catalog.json' if frozen else OLD / 'source-catalog.json'
    assert sha(base) == accepted['baseTargetSha256'] and sha(target) == accepted['targetSha256']
    assert sha(catalog) == accepted['sourceCatalogSha256']
    source = {r['id']: r for r in read(catalog)['units']}
    before, after = rows(base), rows(target)
    assert before.keys() == after.keys() == source.keys()
    for key in before:
        assert before[key]['source'] == after[key]['source'] == source[key]['source']
        assert isinstance(after[key]['target'], str) and after[key]['target'].strip()
    assert {k for k in before if before[k]['target'] != after[k]['target']} == set(accepted['changedIds'])
    for kind, record in accepted['evidence'].items():
        name = record['file']; assert Path(name).name == name
        assert sha(folder / name) == record['sha256'], 'ui935-evidence-pin:' + kind
        receipt = read(folder / name)
        assert receipt['status'] == 'passed' and receipt['targetSha256'] == accepted['targetSha256']
    return before, after, accepted


def apply_accepted(records, *, locale):
    before, after, _ = load_inputs(locale=locale)
    result = []
    for row in records:
        key = row['id']; assert key in before and row['source'] == before[key]['source']
        assert row['target'] == before[key]['target'], 'ui935-exact-before:' + key
        result.append(dict(row, target=after[key]['target']))
    return result


def snapshot(folder, *, locale):
    _, _, accepted = load_inputs(locale=locale)
    folder = Path(folder); local = Path(__file__).parent
    assert not (folder / 'ui935-inputs.json').exists(), 'new-ui935-snapshot-manifest-required'
    frozen = (local / 'ui935-inputs.json').exists()
    files = {
        'russian_ui935.py': Path(__file__),
        'ui935-base-targets.jsonl': local / 'ui935-base-targets.jsonl' if frozen else OLD / 'ru.jsonl',
        'ui935-accepted-targets.jsonl': local / 'ui935-accepted-targets.jsonl' if frozen else FINAL / accepted['targetFile'],
        'ui935-source-catalog.json': local / 'ui935-source-catalog.json' if frozen else OLD / 'source-catalog.json',
        'ui935-acceptance.json': local / 'ui935-acceptance.json' if frozen else FINAL / 'ru.acceptance.json',
    }
    for record in accepted['evidence'].values():
        files[record['file']] = (local if frozen else FINAL) / record['file']
    assert all(not (folder / name).exists() for name in files), 'new-ui935-snapshot-required'
    for name, path in files.items():
        shutil.copyfile(path, folder / name)
    (folder / 'ui935-inputs.json').write_text(json.dumps({n: sha(folder / n) for n in files}, indent=2) + '\n')


def accept():
    # Reconcile genuine complete reviews; no semantic verdict is generated here.
    from inventory_display_review import check_pins
    before, after = rows(OLD / 'ru.jsonl'), rows(FINAL / 'ru.edited.jsonl')
    assert before.keys() == after.keys()
    evidence = {}
    for stage, directory in [('fullSemantic', 'initial-02'), ('independent', 'independent-01')]:
        job = JOBS / directory; state = read(job / 'job.json'); check_pins(read(job / 'config.json'))
        assert state['status'] == 'review-complete-awaiting-parent' and state['exitCode'] == 0 and not state['errors']
        runtime = read(job / 'review/runtime-verification.json')['actualRuntime']
        assert runtime['turn'] == {'model': 'gpt-6.1-sol', 'effort': 'high'}
        assert runtime['session']['model_provider'] == 'openai' and runtime['session']['parent_thread_id'] is None
        decisions = rows(job / 'review/reviews.jsonl'); pairs = rows(job / 'pairs.jsonl')
        assert decisions.keys() == pairs.keys() == after.keys()
        result = read(job / 'review/result.json')
        assert result['reviewedIds'] == state['reviewedIds'] == 935
        assert result['reviewsSha256'] == sha(job / 'review/reviews.jsonl')
        expected = before if stage == 'fullSemantic' else after
        for key in expected:
            assert expected[key]['source'] == pairs[key]['source'] and expected[key]['target'] == pairs[key]['target']
            for field in ('source', 'target'):
                assert decisions[key][field + 'Sha256'] == hashlib.sha256(pairs[key][field].encode()).hexdigest()
            if stage == 'independent':
                assert decisions[key]['verdict'] == 'pass'
        evidence[stage] = dict(status='passed', targetSha256=sha(FINAL / 'ru.edited.jsonl'),
                               reviewedIds=935, reviewsSha256=sha(job / 'review/reviews.jsonl'),
                               originatingJob=str(job.relative_to(ROOT)), wholeGameAccepted=False)
    initial = rows(JOBS / 'initial-02/review/reviews.jsonl')
    changed = {key for key in before if before[key]['target'] != after[key]['target']}
    repair = read(FINAL / 'repair-batch-01.json')
    assert changed == set(repair['changedIds']) and len(changed) == 32
    assert repair['targetSha256'] == sha(FINAL / 'ru.edited.jsonl')
    for key in before:
        assert before[key]['source'] == after[key]['source']
        if key in changed:
            assert initial[key]['verdict'] == 'finding' and initial[key]['proposedTarget'] == after[key]['target']
            assert re.findall(r'<[^>]*>|\{\d+\}', before[key]['source']) == re.findall(r'<[^>]*>|\{\d+\}', after[key]['target'])
            assert before[key]['source'].count('\r\n') == after[key]['target'].count('\r\n')
        else:
            assert before[key] == after[key] and initial[key]['verdict'] == 'pass'
    evidence['fullSemantic']['authorRepairSha256'] = sha(FINAL / 'repair-batch-01.json')
    evidence['finalDeterministic'] = dict(status='passed', targetSha256=sha(FINAL / 'ru.edited.jsonl'),
                                        sourceIds=935, changedIds=32, unchangedIds=903,
                                        sourceAndProtectedSyntaxExact=True, semanticJudgmentGenerated=False)
    accepted = dict(status='accepted-russian-ui935', locale='ru', targetFile='ru.edited.jsonl',
                    baseTargetSha256=sha(OLD / 'ru.jsonl'), targetSha256=sha(FINAL / 'ru.edited.jsonl'),
                    sourceCatalogSha256=sha(OLD / 'source-catalog.json'), changedIds=sorted(changed), evidence={},
                    targetEditorialAccepted=True, ordinaryTranslationEntryAllowed=False, wholeGameAccepted=False)
    for kind, receipt in evidence.items():
        name = 'ru935.' + kind + '.json'; path = FINAL / name
        assert not path.exists()
        path.write_text(json.dumps(receipt, indent=2) + '\n')
        accepted['evidence'][kind] = dict(file=name, sha256=sha(path))
    path = FINAL / 'ru.acceptance.json'; assert not path.exists()
    path.write_text(json.dumps(accepted, indent=2) + '\n')
    load_inputs(locale='ru')


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--accept', action='store_true')
    args = parser.parse_args()
    if args.accept:
        accept()
    before, after, accepted = load_inputs(locale='ru')
    print(json.dumps(dict(status=accepted['status'], units=len(after), changed=len(accepted['changedIds']))))
