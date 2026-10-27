"""Check pinned, uninstalled CJK candidates against version-bound logical text.

FontTools outline bounds exercise actual font data, not the Unity renderer.
The original-font report is a conservative requirement set, not resolved roles.
"""
import argparse
import json
import math
from pathlib import Path
import unicodedata

from fontTools.pens.boundsPen import BoundsPen
from fontTools.ttLib import TTFont
from font_corpus_preflight import ROOT, digest, inspect_font


def run(locales, requirements, output):
    choices = {'zh': ('NotoSansCJKsc-Regular.otf', 'NotoSansCJKsc-Regular'),
               'ja': ('NotoSansCJKjp-Regular.otf', 'NotoSansCJKjp-Regular')}
    assert locales and len(locales) == len(set(locales)) and set(locales) <= choices.keys()
    assert not output.exists() and ROOT in output.resolve().parents
    provenance = ROOT / 'localization/fonts/noto-cjk/provenance.json'
    spec = json.loads(provenance.read_text())
    raw_requirements = requirements.read_bytes()
    required = json.loads(raw_requirements)
    result = {'status': 'offline-candidate-preflight-only', 'requirements': str(requirements.relative_to(ROOT)),
              'requirementsSha256': digest(raw_requirements), 'sourceCommit': spec['commit'],
              'provenanceSha256': digest(provenance.read_bytes()), 'locales': {},
              'limits': ['Uninstalled candidates; no Unity/TMP shaping, loading, atlas or readability acceptance.',
                         'Logical requirement superset includes commands and fictional-language roles.',
                         'Final edited text, UI/image text and dynamic inputs require affected rechecks.']}
    for locale in locales:
        corpus = required['corpora'][locale]
        assert digest((ROOT / corpus['path']).read_bytes()) == corpus['sha256'], 'Stale corpus requirements'
        filename, expected_face = choices[locale]
        path = provenance.parent / filename
        data = path.read_bytes()
        assert digest(data) == spec['files'][filename]['sha256'], 'Candidate data drift'
        available, metrics = inspect_font({'m_FontData': data})
        assert metrics['postscriptName'] == expected_face, 'Wrong candidate face'
        assert metrics['spaceAdvance'] > 0 and metrics['unitsPerEm'] > 0
        assert metrics['ascent'] > metrics['descent']
        missing = [c for c in corpus['characters'] if ord(c) not in available]
        checks = []
        with TTFont(path) as font:
            glyphs = font.getGlyphSet()
            cmap = font.getBestCmap()
            for char in corpus['characters']:
                if ord(char) not in available:
                    continue
                name = cmap[ord(char)]
                pen = BoundsPen(glyphs)
                glyphs[name].draw(pen)
                blank_allowed = unicodedata.category(char).startswith('Z')
                valid = pen.bounds is not None and all(math.isfinite(v) for v in pen.bounds)
                assert blank_allowed or valid, 'Empty/invalid required glyph: ' + repr(char)
                checks.append({'codepoint': f'U+{ord(char):04X}', 'glyph': name,
                               'bounds': pen.bounds, 'blankSpaceAllowed': blank_allowed})
            version = font['name'].getDebugName(5)
        result['locales'][locale] = {'font': str(path.relative_to(ROOT)), 'sha256': digest(data),
                                    'version': version, 'metrics': metrics,
                                    'requiredCharacters': len(corpus['characters']), 'missing': ''.join(missing),
                                    'missingCount': len(missing), 'glyphChecks': checks,
                                    'corpusSha256': corpus['sha256']}
    for locale in locales:
        corpus = required['corpora'][locale]
        assert digest((ROOT / corpus['path']).read_bytes()) == corpus['sha256'], 'Corpus changed during check'
    with output.open('x') as stream:
        stream.write(json.dumps(result, ensure_ascii=False, indent=2) + '\n')
    return result


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--locales', nargs='+', required=True)
    parser.add_argument('--requirements', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    report = run(args.locales, args.requirements.resolve(), args.output.resolve())
    print(json.dumps({locale: {'missing': row['missing'], 'checkedGlyphs': len(row['glyphChecks'])}
                      for locale, row in report['locales'].items()}, ensure_ascii=False))
