"""Release guard for the finite inventory-heading selector repair."""
import json
import hashlib


def validate_language(document, headings):
    rows = document['translations']
    for ident, source in headings.items():
        if ident not in rows or rows[ident].get('source') != source:
            raise ValueError('missing inventory heading selector: ' + ident)
        target = rows[ident].get('target')
        if not isinstance(target, str) or not target or target == source:
            raise ValueError('untranslated inventory heading: ' + ident)


def validate_selection(root, selection):
    directory = root / 'localization/framework'
    first = {r['id'] for r in json.loads((directory/'forest045-shared/catalog.json').read_bytes())}
    rows = [r for r in json.loads((directory/'forest045-shared-v2/catalog.json').read_bytes()) if r['id'] not in first]
    if len(rows) != 12 or any(r['source'] not in ['<size=22>I</size>NVENTORY', '<size=30>I</size>NVENTORY'] for r in rows):
        raise ValueError('inventory heading contract changed')
    headings = {r['id']: r['source'] for r in rows}
    for code, path in selection.items():
        try:
            validate_language(json.loads(path.read_bytes()), headings)
        except ValueError as error:
            raise ValueError(code + ': ' + str(error)) from error
    return dict(locales=len(selection), headingLayersPerLocale=12)


def validate_packed_sources(manifest, selection):
    rows = manifest['locales']
    codes = [r['code'] for r in rows]
    if len(codes) != len(set(codes)) or set(codes) != set(selection):
        raise ValueError('packed locale catalog differs')
    for row in rows:
        if hashlib.sha256(selection[row['code']].read_bytes()).hexdigest() != row['languageSha256']:
            raise ValueError('stale packed language: ' + row['code'])
