"""Validate authored remaining-column decisions against original source evidence.

Deterministic ID/byte checks only. This does not generate semantic judgments,
translate text, or pass the global source/renderer gate.
"""
import base64
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[2]


def sha(p):
    return hashlib.sha256(p.read_bytes()).hexdigest()


def main():
    decisions = json.loads((HERE / 'remaining-bgdatabase-decisions.json').read_text())['columns']
    bindings = json.loads((HERE / 'generated-field-binding-readback.json').read_text())
    descriptor_path = HERE / 'evidence/remaining-column-source-descriptors.json'
    columns = json.loads(descriptor_path.read_text())
    ledger = ROOT / 'localization/source/bgdatabase-complete-values-20261027/verified/cells.jsonl'
    original = ROOT / 'assets/source-v2/text-assets/90744c19ec-resources.assets-320.bin'
    assert sha(original) == '41834cda2f3ea6f010234f3ca2332e31b95b990ab38a8940b0d92f000477fda9'
    data = original.read_bytes()
    assert len(decisions) == len(bindings['checks']) == len(columns) == 29
    dmap = {(r['sheet'], r['field']): r for r in decisions}
    bmap = {(r['sheet'], r['field']): r for r in bindings['checks']}
    assert len(dmap) == len(bmap) == 29
    for col in columns:
        key = col['sheet'], col['field']
        decision, binding = dmap[key], bmap[key]
        assert decision['fieldId'] == binding['fieldId'] == col['fieldBinding']['fieldId']
        assert binding['sheetId'] == col['fieldBinding']['sheetId']
        assert decision['states'] == col['states']
    rows = []
    for line in ledger.open():
        row = json.loads(line)
        if (row['sheet'], row['field']) in dmap:
            rows.append(row)
    assert len(rows) == len({r['id'] for r in rows}) == 3279
    present = absent = display = display_present = 0
    restored = bytearray(data)
    for row in rows:
        decision = dmap[row['sheet'], row['field']]
        assert row['fieldId'] == decision['fieldId']
        is_display = decision['role'] == 'display'
        display += is_display
        if not row['stored']:
            assert row['source'] is None and row['sourceBytesBase64'] is None and row['sourceSpan'] is None
            absent += 1
            continue
        raw = base64.b64decode(row['sourceBytesBase64'], validate=True)
        assert raw.decode('utf-8') == row['source']
        span = row['sourceSpan']; start = span['offset']; end = start + span['bytes']
        assert data[start:end] == raw
        restored[start:end] = raw
        present += 1; display_present += is_display
    assert (present, absent, display, display_present) == (3263, 16, 146, 130)
    assert bytes(restored) == data
    report = dict(schemaVersion=1, status='passed-static-decisions-readback',
                  columns=29, states=3279, stored=present, absent=absent,
                  displayStates=display, nonemptyDisplayStates=display_present,
                  protectedStates=len(rows)-display,
                  generatedGetterColumns=29, generatedTableIds=14,
                  exactValueReadback=True, wholeOriginalPayloadRestored=True,
                  sourcePins={str(p.relative_to(ROOT)): sha(p) for p in [ledger, original, descriptor_path, Path(__file__), HERE/'remaining-bgdatabase-decisions.json', HERE/'generated-field-binding-readback.json']},
                  boundary='Machine identity/UTF-8/source-span preservation, not independent semantic judgment, reinsertion, runtime or global source acceptance.')
    target = HERE / 'remaining-column-readback.json'
    encoded = (json.dumps(report, indent=2) + '\n').encode()
    if target.exists():
        assert target.read_bytes() == encoded, 'readback-artifact-drift'
    else:
        target.write_bytes(encoded)
    print(json.dumps({k: report[k] for k in ('columns','states','stored','absent','displayStates','nonemptyDisplayStates','protectedStates')}))


if __name__ == '__main__':
    main()
