"""Prepare the finite113-cell shared source family without changing frozen inputs.

This is append-only source/application preparation, not whole-game admission,
translation, editorial acceptance or runtime reachability evidence.
"""
import argparse
import base64
import collections
import hashlib
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
OUT = ROOT / 'localization/source/gallery-chapter-display-20261028'


def sha(data):
    return hashlib.sha256(data).hexdigest()


def derive():
    pins = {}

    def read(name):
        data = (ROOT / name).read_bytes()
        pins[name] = dict(sha256=sha(data), bytes=len(data))
        return data

    def rows(name):
        return [json.loads(line) for line in read(name).decode().splitlines()]

    audit = 'outputs/ru-completion-reconciliation-20261028/check/'
    evidence = rows(audit + 'untranslated-display-inputs.jsonl')
    cells = rows('localization/source/bgdatabase-complete-values-20261027/verified/cells.jsonl')
    assert len(cells) == len({r['id'] for r in cells}) == 51572
    by_id = {r['id']: r for r in cells}
    by_row = collections.defaultdict(dict)
    for cell in cells:
        if cell['sheet'] in ('Movie', 'Chapter'):
            by_row[(cell['sheet'], cell['rowId'])][cell['field']] = cell
    selected = {('Movie', 'hint_phrase'): 57, ('Chapter', 'title'): 28, ('Chapter', 'description'): 28}
    units = []
    for item in evidence:
        if (item.get('sheet'), item.get('field')) not in selected:
            continue
        cell = by_id[item['id']]
        assert cell['stored'] and isinstance(cell['source'], str) and cell['source']
        assert base64.b64decode(cell['sourceBytesBase64']).decode() == item['source'] == cell['source']
        assert cell['sourceSpan'] == item['sourceSpan'] and cell['rowIndex'] == item['rowIndex']
        assert sha(json.dumps(cell['source'], ensure_ascii=False, separators=(',', ':')).encode()) == item['sourceValueSha256']
        context = by_row[(cell['sheet'], cell['rowId'])]
        context_fields = ['name', 'movie', 'savekey'] if cell['sheet'] == 'Movie' else ['name', 'parent', 'hide_in_list', 'enable_with_tags', 'title', 'description']
        units.append(dict(id=cell['id'], family='gallery-hint' if cell['sheet'] == 'Movie' else 'chapter-' + cell['field'],
                          source=cell['source'], sourceUtf8Sha256=sha(cell['source'].encode()),
                          sourceValueSha256=item['sourceValueSha256'], sheet=cell['sheet'], sheetId=cell['sheetId'],
                          field=cell['field'], fieldId=cell['fieldId'], rowId=cell['rowId'], rowIndex=cell['rowIndex'],
                          sourceSpan=cell['sourceSpan'], consumer=item['consumer'], consumerMethods=item['consumerMethods'],
                          sourceRowContext={name: context[name]['source'] for name in context_fields},
                          reachability='Conservative complete stored family. Original hide/tag/unlock/selection branches are preserved; per-row runtime reachability is unaccepted.'))
    assert collections.Counter((r['sheet'], r['field']) for r in units) == selected
    assert len(units) == len({r['id'] for r in units}) == 113
    scope = json.loads(read('localization/supplemental-ui/20261027/locale-scope.json'))
    manifest = json.loads(read('localization/supplemental-ui/20261027/manifest.json'))
    coverage = []
    for locale in scope['targetLocales']:
        name = 'localization/supplemental-ui/20261027/' + locale + '.jsonl'
        packet = rows(name)
        assert len(packet) == len({r['id'] for r in packet}) == 935
        assert pins[name]['sha256'] == manifest['locales'][locale]['sha256']
        assert not {r['id'] for r in units} & {r['id'] for r in packet}
        coverage.append(dict(locale=locale, frozen935Sha256=pins[name]['sha256'], additionalSourceIds=[r['id'] for r in units],
                             targetStatus='not-authored-or-reused', editorial='not-run', application='missing'))
    assert len(coverage) == 30
    pins[str(Path(__file__).relative_to(ROOT))] = dict(sha256=sha(Path(__file__).read_bytes()), bytes=Path(__file__).stat().st_size)
    return {'source.jsonl': units, 'input-pins.json': pins, 'thirty-locale-coverage.json': coverage,
            'manifest.json': dict(schemaVersion=1, game='The Forest of Love', build='0.45', sourceLocale='en',
                                  sourceUnits=113, distinctSourceValues=len({r['source'] for r in units}),
                                  fields={sheet + '.' + field: count for (sheet, field), count in selected.items()},
                                  status='append-only-source-family-prepared;owning-source-gate-pending',
                                  targetLocales=scope['targetLocales'], wholeGameSourceAccepted=False,
                                  ordinaryWholeGameTranslationEntryAllowed=False, sourceExtractionRepeated=False,
                                  frozen935PacketsChanged=False, readyDialogueChanged=False,
                                  boundary='Exact complete three-column family, reused consumer evidence and source-row context. Does not resolve whole-field callbacks/effects/special scenes, selected runtime reachability, glossary applicability, Russian wording or application.',
                                  nextAction='Resolve exact source/context decisions, reuse only version-matching existing targets or author the admitted bounded delta; review through the universal semantic/independent protocol, then project only these three columns with whole-payload restoration.',
                                  atomicity='Products are precomputed then written sequentially. A partial directory is not a completed handoff.')}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--check', action='store_true')
    args = parser.parse_args()
    products = derive()
    if not args.check:
        assert not OUT.exists(), 'Reconcile prior output before retrying'
        OUT.mkdir()
    for name, value in products.items():
        data = (''.join(json.dumps(r, ensure_ascii=False, separators=(',', ':')) + '\n' for r in value)
                if name.endswith('.jsonl') else json.dumps(value, ensure_ascii=False, indent=2) + '\n').encode()
        if args.check:
            assert (OUT / name).read_bytes() == data, ('Source reproduction mismatch', name)
        else:
            (OUT / name).write_bytes(data)
    print(json.dumps(dict(status='verified' if args.check else 'prepared', selectors=113, locales=30, wholeGameAccepted=False)))


if __name__ == '__main__':
    main()
