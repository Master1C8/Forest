"""Verify the bounded counter resource contract without rewriting evidence."""
import argparse
import hashlib
import json
from pathlib import Path

ROOT = Path('/Users/antonkrutov/Desktop/Forest')
HERE = Path(__file__).resolve().parent


def read(path):
    return json.loads(path.read_bytes())


def sha(path):
    h = hashlib.sha256()
    with path.open('rb') as stream:
        for block in iter(lambda:stream.read(1024**2),b''):
            h.update(block)
    return h.hexdigest()


def rows(path):
    return [json.loads(line) for line in path.read_text().splitlines()]


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--check',action='store_true',required=True)
    parser.parse_args()
    for name,info in read(HERE/'input-pins.json').items():
        path = ROOT/name
        assert path.stat().st_size == info['bytes'] and sha(path) == info['sha256'],name
    manifest = read(HERE/'output-manifest.json')
    for name,info in manifest['files'].items():
        path = ROOT/name
        assert path.stat().st_size == info['bytes'] and sha(path) == info['sha256'],name
    native = rows(HERE/'native75-current.jsonl')
    managed = read(HERE/'managed15-current.json')['rows']
    assert len(native) == len({r['id'] for r in native}) == 75
    assert len(managed) == len({r['id'] for r in managed}) == 15
    proposal = read(HERE/'proposed-dispositions.json')
    allowed,retained,held = map(set,[proposal['proposedStaticApplication'],proposal['retainedAccepted'],proposal['protectedOrHeld']])
    assert list(map(len,[allowed,retained,held])) == [15,13,62]
    assert allowed|retained|held == {r['id'] for r in native+managed}
    assert sum(map(len,[allowed,retained,held])) == 90
    assert 'level23:770/m_Text' in held and not proposal['executableApplication']
    packet = ROOT/'localization/supplemental-ui/20261029-counter-case90'
    targets = {r['id']:r for r in rows(packet/'ru.prepared.jsonl')}
    assert len(targets) == 29
    for row in native:
        expected = targets[row['id']]['target'] if row['category'] == 'reused' else row['source']
        assert row['currentValue'] == expected
        if row['id'] in allowed:
            assert row['acceptedTarget'] == targets[row['id']]['target']
            assert row['fontPointer']['m_PathID'] == 369
    for row in managed:
        expected = targets[row['id']]['target'] if row['category'] == 'reused' else row['source']
        assert row['actual'] == expected and row['completeCurrentBodySha256']
    coverage = read(HERE/'font15-current.json')
    assert {r['id'] for r in coverage['rows']} == allowed
    assert coverage['faceSha256'] == 'e5b0af421ea2bfbc1ac8d251d647268087ae82786234c57f757d1f0b90fa8b49'
    assert all(not r['missingCmap']['raw'] and not r['missingCmap']['NFC'] for r in coverage['rows'])
    assert {r['id'] for r in rows(HERE/'routes15-current.jsonl')} == allowed
    result = read(HERE/'Result.json')
    assert result['proposedStaticFields'] == 15 and result['executableApplicationFields'] == 0
    assert not result['sourceGateAccepted'] and not result['wholeGameAccepted']
    print('Counter90 resource contract verified:75 native/15compiled;15 proposed/13 retained/62 held;all15 concrete native-face raw/NFC subsets pass.')


if __name__ == '__main__':
    main()
