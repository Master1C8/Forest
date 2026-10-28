"""Read-only character/face preflight for the existing30 supplemental packets.

This measures a conservative character superset for the current supplemental
corpus. Raw markup and NFC/NFD alternatives can overstate rendered requirements;
omitted source families can add requirements. It is not font selection,
shaping/readability acceptance or permission to edit font/texture resources.
"""
import argparse
import hashlib
import json
from pathlib import Path
import unicodedata

from fontTools.ttLib import TTFont
from font_corpus_preflight import inspect_font

ROOT = Path(__file__).resolve().parents[1]
PACKET = ROOT / 'localization/supplemental-ui/20261027'


def sha(p):
    return hashlib.sha256(p.read_bytes()).hexdigest()


def coverage(available, demand):
    if available is None:
        return dict(missingCount=None, missing=None, allCodepointsPresent=None,
                    reason='External face without embedded cmap/serialized glyphs;coverage unknown.')
    missing = sorted(demand - available)
    return dict(missingCount=len(missing), missing=''.join(map(chr, missing)),
                allCodepointsPresent=not missing)


def run(output):
    output = output.resolve()
    assert ROOT in output.parents and not output.exists(), 'New project-owned output required'
    manifest_path = PACKET / 'manifest.json'
    scope_path = PACKET / 'locale-scope.json'
    manifest = json.loads(manifest_path.read_text())
    scope = json.loads(scope_path.read_text())
    catalog_path = PACKET / 'source-catalog.json'
    assert sha(catalog_path) == manifest['sourceCatalogSha256']
    catalog = json.loads(catalog_path.read_text())
    ids = [r['id'] for r in catalog['units']]
    assert len(ids) == len(set(ids)) == 935
    locales = scope['targetLocales']
    assert len(locales) == len(set(locales)) == 30 and 'en' not in locales
    pins = {str(p.relative_to(ROOT)): sha(p) for p in [manifest_path, scope_path, catalog_path, Path(__file__), ROOT/'tools/font_corpus_preflight.py']}
    demand, form_demand, corpora = {}, {}, {}
    for locale in locales:
        path = PACKET / f'{locale}.jsonl'
        assert sha(path) == manifest['locales'][locale]['sha256']
        pins[str(path.relative_to(ROOT))] = sha(path)
        rows = [json.loads(line) for line in path.read_text().splitlines()]
        assert [r['id'] for r in rows] == ids
        assert [r['source'] for r in rows] == [r['source'] for r in catalog['units']]
        text = ''.join(r['target'] for r in rows)
        forms = {'raw': text, 'NFC': unicodedata.normalize('NFC', text),
                 'NFD': unicodedata.normalize('NFD', text)}
        form_demand[locale] = {
            form: {ord(c) for c in value if not unicodedata.category(c).startswith('C')}
            for form, value in forms.items()
        }
        chars = set().union(*form_demand[locale].values())
        demand[locale] = chars
        corpora[locale] = dict(path=str(path.relative_to(ROOT)), sha256=sha(path), units=len(rows),
                               rawNfcNfdCharacters=len(chars), codepoints=sorted(chars),
                               controls=sorted({ord(c) for c in text if unicodedata.category(c).startswith('C')}),
                               direction='rtl' if locale in ('ar','fa','he') else 'ltr',
                               joiningBidiReordering='required-separate-native-proof' if locale in ('ar','fa','he','hi','th') else 'marks-spacing-and-layout-still-require-native-proof')
    def corpus_coverage(available, locale):
        result = coverage(available, demand[locale])
        result['forms'] = {form: coverage(available, chars)
                           for form, chars in form_demand[locale].items()}
        return result
    original_index = ROOT / 'assets/source-v2/fonts.json'
    pins[str(original_index.relative_to(ROOT))] = sha(original_index)
    fonts = []
    for entry in json.loads(original_index.read_text()):
        path = ROOT / 'assets/source-v2' / entry['tree']
        assert sha(path) == entry['treeSha256']
        pins[str(path.relative_to(ROOT))] = sha(path)
        available, metrics = inspect_font(json.loads(path.read_text()))
        fonts.append(dict(kind='original-resource', id=entry['id'], name=entry['name'], metrics=metrics,
                          spaceHasPositiveAdvance=metrics['spaceAdvance'] is not None and metrics['spaceAdvance'] > 0,
                          coverage={locale: corpus_coverage(available, locale) for locale in locales}))
    provenance_path = ROOT / 'localization/fonts/noto-cjk/provenance.json'
    provenance = json.loads(provenance_path.read_text())
    pins[str(provenance_path.relative_to(ROOT))] = sha(provenance_path)
    for filename, expected_ps in [('NotoSansCJKsc-Regular.otf','NotoSansCJKsc-Regular'),('NotoSansCJKjp-Regular.otf','NotoSansCJKjp-Regular')]:
        path = provenance_path.parent / filename
        assert sha(path) == provenance['files'][filename]['sha256']
        pins[str(path.relative_to(ROOT))] = sha(path)
        with TTFont(path) as font:
            assert font['name'].getDebugName(6) == expected_ps
            cmap = font.getBestCmap() or {}
            available = {cp for cp, name in cmap.items() if name != '.notdef'}
            space = cmap.get(32)
            advance = font['hmtx'][space][0] if space else None
            metrics = dict(family=font['name'].getDebugName(1),subfamily=font['name'].getDebugName(2),
                           postscriptName=font['name'].getDebugName(6),unitsPerEm=font['head'].unitsPerEm,
                           ascent=font['hhea'].ascent,descent=font['hhea'].descent,lineGap=font['hhea'].lineGap,
                           spaceAdvance=advance)
        fonts.append(dict(kind='pinned-unmodified-offline-candidate',path=str(path.relative_to(ROOT)),sha256=sha(path),
                          metrics=metrics,spaceHasPositiveAdvance=advance is not None and advance>0,
                          coverage={locale:corpus_coverage(available,locale) for locale in locales},
                          glyphLocaleForms='SC/JP face identity explicit;coverage does not select appropriate Traditional Chinese or other local glyph forms.'))
    for name, digest in pins.items():
        assert sha(ROOT/name) == digest, ('input-changed', name)
    report = dict(schemaVersion=1,status='static-supplemental-character-superset-only',targetCount=30,
                  corpora=corpora,fonts=fonts,inputPins=pins,textureEdits=False,fontResourceEdits=False,gameLaunch=False,
                  limits=['Existing935-unit inputs only;new source/corrected wording invalidates affected character requirements.',
                          'Conservative raw/NFC/NFD superset retains markup letters;not an exact rendered-character set.',
                          'No actual runtime role/fallback assignment,outline/readability/shaping/bidi/line-break or native acceptance.',
                          'Every face tested separately;no unverified fallback union or locale removal.',
                          'No feasibility or source gate is passed by this report.'])
    output.parent.mkdir(parents=True,exist_ok=True)
    with output.open('x') as stream:stream.write(json.dumps(report,ensure_ascii=False,indent=2)+'\n')
    return report


if __name__ == '__main__':
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output',type=Path,required=True)
    result=run(parser.parse_args().output)
    print(json.dumps(dict(locales=result['targetCount'],faces=len(result['fonts']),status=result['status'])))
