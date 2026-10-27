"""Static original-font coverage against explicitly selected saved dialogue corpora.

This uses a conservative logical-character superset, including command operands.
It neither selects runtime font roles nor claims rendered/shaped glyph coverage.
"""
import argparse
import collections
import hashlib
import io
import json
from pathlib import Path
import unicodedata

from fontTools.ttLib import TTFont

ROOT = Path(__file__).resolve().parents[1]


def digest(raw):
    return hashlib.sha256(raw).hexdigest()


def required_characters(rows):
    ids = [r['id'] for r in rows]
    if len(ids) != len(set(ids)):
        raise ValueError('Duplicate corpus ID')
    counts = collections.Counter()
    for row in rows:
        if digest(row['target'].encode()) != row['targetSha256']:
            raise ValueError('Target hash mismatch: ' + row['id'])
        counts.update(c for c in row['target'] if not unicodedata.category(c).startswith('C'))
    return counts


def inspect_font(tree):
    data = bytes(tree['m_FontData'])
    if not data:
        if not tree['m_CharacterRects']:
            return None, {'kind': 'unavailable-embedded-face-and-character-map',
                          'family': tree['m_FontNames'], 'spaceAdvance': None,
                          'embeddedFaceSha256': None, 'redistribution': 'not-established'}
        available = {r['index'] for r in tree['m_CharacterRects']}
        spaces = [r['advance'] for r in tree['m_CharacterRects'] if r['index'] == 32]
        return available, {'kind': 'serialized-bitmap-indices', 'family': tree['m_FontNames'],
                           'spaceAdvance': spaces[0] if len(spaces) == 1 else None,
                           'embeddedFaceSha256': None, 'redistribution': 'not-established'}
    with TTFont(io.BytesIO(data)) as font:
        cmap = font.getBestCmap() or {}
        available = {cp for cp, glyph in cmap.items() if glyph != '.notdef'}
        space = cmap.get(32)
        metrics = {
            'kind': 'embedded-sfnt-cmap', 'family': font['name'].getDebugName(1),
            'subfamily': font['name'].getDebugName(2), 'postscriptName': font['name'].getDebugName(6),
            'spaceAdvance': font['hmtx'][space][0] if space in font['hmtx'].metrics else None,
            'unitsPerEm': font['head'].unitsPerEm,
            'ascent': font['hhea'].ascent, 'descent': font['hhea'].descent,
            'lineGap': font['hhea'].lineGap, 'embeddedFaceSha256': digest(data),
            'licenseText': font['name'].getDebugName(13),
            'licenseUrl': font['name'].getDebugName(14),
            'copyright': font['name'].getDebugName(0),
            'redistribution': 'not-established-by-name-table',
        }
    return available, metrics


def run(locales, output):
    if not locales or len(locales) != len(set(locales)):
        raise ValueError('Explicit unique locales required')
    output = output.resolve()
    if ROOT not in output.parents or output.exists():
        raise ValueError('New immutable project output required')
    index_path = ROOT / 'assets/source-v2/fonts.json'
    index_raw = index_path.read_bytes()
    source_raw = (ROOT / 'localization/source/dialogue-candidates.jsonl').read_bytes()
    source = [json.loads(s) for s in source_raw.splitlines()]
    source_ids = {r['id'] for r in source}
    assert len(source) == len(source_ids) == 12246
    pins = {str(index_path): digest(index_raw),
            str(ROOT / 'localization/source/dialogue-candidates.jsonl'): digest(source_raw)}
    corpora = {}
    demand = {}
    for locale in locales:
        if locale not in {'ru', 'zh', 'es', 'es-419', 'pt-BR', 'ja', 'de'}:
            raise ValueError('Unknown explicit saved locale: ' + locale)
        path = ROOT / f'localization/{locale}-assets/dialogue.{locale}.jsonl'
        raw = path.read_bytes()
        rows = [json.loads(s) for s in raw.splitlines()]
        counts = required_characters(rows)
        assert len(rows) == len(source) and {r['id'] for r in rows} == source_ids
        pins[str(path)] = digest(raw)
        demand[locale] = set(map(ord, counts))
        corpora[locale] = {'path': str(path.relative_to(ROOT)), 'sha256': digest(raw),
                           'ids': len(rows), 'distinctRequiredCharacters': len(counts),
                           'characters': ''.join(sorted(counts, key=ord))}
    fonts = []
    for entry in json.loads(index_raw):
        path = ROOT / 'assets/source-v2' / entry['tree']
        raw = path.read_bytes()
        assert digest(raw) == entry['treeSha256'], 'Original font tree changed'
        pins[str(path)] = digest(raw)
        available, metrics = inspect_font(json.loads(raw))
        coverage = {}
        for locale in locales:
            missing = demand[locale] - available if available is not None else None
            coverage[locale] = {'missingCount': len(missing),
                                'missing': ''.join(map(chr, sorted(missing))),
                                'allRequiredCodepointsPresent': not missing} if missing is not None else {
                                    'missingCount': None, 'missing': None,
                                    'allRequiredCodepointsPresent': None,
                                    'reason': 'No embedded face or serialized character map; actual external font selection is unverified.'}
        fonts.append({'id': entry['id'], 'name': entry['name'], 'tree': entry['tree'],
                      'treeSha256': digest(raw), 'availableCodepoints': len(available) if available is not None else None,
                      'spaceHasPositiveAdvance': metrics['spaceAdvance'] is not None and metrics['spaceAdvance'] > 0,
                      'metrics': metrics, 'coverage': coverage})
    for path, expected in pins.items():
        assert digest(Path(path).read_bytes()) == expected, 'Input changed during static check: ' + path
    report = {
        'schemaVersion': 1, 'game': 'The Forest of Love', 'version': '0.45',
        'status': 'static-original-font-character-inventory-only',
        'sourceFamilySha256': digest(source_raw), 'corpora': corpora, 'fonts': fonts,
        'inputPins': pins, 'method': 'All saved logical target characters except Unicode category C; conservative superset includes commands, detached source and fictional-language text. Each original font is tested separately; no assumed fallback union.',
        'limits': ['No runtime font-role or fallback assignment accepted.',
                   'No rendered shape, mark attachment, shaping, wrapping or readability acceptance.',
                   'TMP serialized atlases, fictional-font mappings, dynamic inputs, UI and image-text inventory are separate.',
                   'Original-font presence or license name tables do not establish redistribution rights.',
                   'Full game inventory and renderer feasibility remain unaccepted; game not launched.'],
    }
    output.parent.mkdir(parents=True, exist_ok=True)
    with output.open('x') as stream:
        stream.write(json.dumps(report, ensure_ascii=False, indent=2) + '\n')
    return report


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--locales', nargs='+', required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    result = run(args.locales, args.output)
    print(json.dumps({'fonts': len(result['fonts']), 'locales': list(result['corpora']),
                      'output': str(args.output)}, ensure_ascii=False))
