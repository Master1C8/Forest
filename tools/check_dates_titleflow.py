#!/usr/bin/env python3
"""Exercise reviewed resource projection boundaries on a data-only source fixture."""
import argparse
import json
from pathlib import Path
import subprocess


def check(source, output_root, runtime):
    import russian_dates_titleflow as adapter
    import russian_bell_title_layout as layout
    source, output_root = Path(source).resolve(), Path(output_root).resolve()
    output_root.mkdir()
    outcomes = []
    contract, _ = adapter.load_inputs()
    assert adapter.sha(source / contract['resource']) == contract['sourceSha256']
    (output_root / 'snapshot').mkdir()
    frozen = adapter.snapshot(output_root / 'snapshot')
    result_path = output_root / 'frozen-result'
    subprocess.run([str(runtime), '-B', str(frozen / 'russian_dates_titleflow.py'), '--locale', 'ru', '--source', str(source), '--output', str(result_path)], check=True, stdout=subprocess.DEVNULL)
    result = json.loads((result_path / 'Result.json').read_text())
    assert result['datesTextFields'] == 36 and result['changedObjects'] == 86
    assert result['actualSavedReadbackVerified'] and result['wholeContainerReversalByteExact']
    outcomes.append(dict(check='Fresh frozen CLI with relocated existing narrative runtime; saved native bytes, exact86 objects and reversal', passed=True))
    try:
        adapter.apply(source, result_path)
    except AssertionError as e:
        assert str(e) == 'New exclusive output required'
    else:
        raise AssertionError('Occupied output accepted')
    outcomes.append(dict(check='Occupied complete output refuses replacement', passed=True))
    partial = output_root / 'interrupted-result'
    try:
        adapter.apply(source, partial, fail_after_resource=True)
    except RuntimeError as e:
        assert str(e) == 'injected-after-dates-resource-before-receipt'
    else:
        raise AssertionError('Interruption did not run')
    assert (partial / contract['resource']).is_file() and not (partial / 'Result.json').exists()
    assert adapter.sha(partial / contract['resource']) == result['targetSha256']
    try:
        adapter.apply(source, partial)
    except AssertionError as e:
        assert str(e) == 'New exclusive output required'
    else:
        raise AssertionError('Partial occupied output accepted')
    outcomes.append(dict(check='Failure after real resource write leaves no completion receipt; partial output refuses blind retry', passed=True))
    bad_source = output_root / 'wrong-source'
    bad_source.mkdir()
    (bad_source / contract['resource']).write_bytes(b'wrong-resource')
    try:
        adapter.apply(bad_source, output_root / 'must-not-exist')
    except AssertionError as e:
        assert e.args[0] == ('Source binding', contract['resource'])
    else:
        raise AssertionError('Wrong source accepted')
    assert not (output_root / 'must-not-exist').exists()
    outcomes.append(dict(check='Complete valid editorial inputs reach exact source-hash rejection before output', passed=True))
    layout_contract, guards, _ = layout.load_contract()
    trees = {pid: row['expectedTree'] for pid, row in guards.items()}
    assert len(layout.plan_from_trees(trees)[0]) == 50
    import copy
    wrong = copy.deepcopy(trees)
    pid = layout_contract['families'][0]['variants']['Title']['gameObject']
    wrong[pid]['m_IsActive'] = False
    try:
        layout.plan_from_trees(wrong)
    except AssertionError as e:
        assert e.args[0][0] == 'bell-before-tree' and e.args[0][1] == pid
    else:
        raise AssertionError('Unexpected source activation accepted')
    outcomes.append(dict(check='Matching complete layout positive control; one changed source activation rejects at named before-tree guard', passed=True))
    assert adapter.sha(source / contract['resource']) == contract['sourceSha256']
    return dict(checks=outcomes, result=result, sourceUnchanged=True, runtimeVisualAccepted=False, boundary='Real resource parser/serializer and frozen CLI, no game process. Synthetic overlay-chain tests are separate; no native visible-fit claim.')


if __name__ == '__main__':
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('--source', type=Path, required=True)
    p.add_argument('--output', type=Path, required=True)
    p.add_argument('--runtime', type=Path, required=True)
    a = p.parse_args()
    print(json.dumps(check(a.source, a.output, a.runtime.resolve()), ensure_ascii=False, indent=2))
