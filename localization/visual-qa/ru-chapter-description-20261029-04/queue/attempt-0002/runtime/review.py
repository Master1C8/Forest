#!/usr/bin/env python3
"""Initialize/check complete per-image evidence; never generate visual judgments."""
import argparse
from collections import Counter
from datetime import datetime
import hashlib
import json
import os
from pathlib import Path
import tempfile

CHECKS = ('layout', 'glyphs', 'content', 'contamination', 'rtl')
IDENTITY = ('game', 'locale', 'order', 'direction', 'url', 'filename', 'sha256', 'width', 'height')


def digest(data):
    return hashlib.sha256(data).hexdigest()


def unique_object(pairs):
    result = {}
    for key, value in pairs:
        if key in result:
            raise ValueError(f'Duplicate JSON key: {key}')
        result[key] = value
    return result


def load(path):
    if path.is_symlink() or not path.is_file():
        raise ValueError(f'Expected regular evidence file: {path.name}')
    return json.loads(path.read_bytes(), object_pairs_hook=unique_object)


def inventory_rows(root, manifest=None):
    if manifest is not None:
        return local_rows(root, manifest)
    inventory = load(root / 'inventory.json')
    if inventory.get('schemaVersion') != 1 or inventory.get('selection', {}).get('localeMode') != 'all':
        raise ValueError('Full review requires a current --all-locales export.')
    locales = inventory['locales']
    if not locales or len(set(locales)) != len(locales):
        raise ValueError('Missing or duplicate inventory locales.')
    receipts = ['inventory.json', 'downloads.json']
    initial = load(root / 'downloads.json')
    downloads = {}
    for item in initial:
        if item['url'] in downloads or item['status'] not in ('downloaded', 'failed'):
            raise ValueError('Duplicate URL or invalid download status.')
        downloads[item['url']] = item
    if (root / 'retry-downloads.json').exists():
        receipts.append('retry-downloads.json')
        retry = load(root / 'retry-downloads.json')
        if len({item['url'] for item in retry}) != len(retry):
            raise ValueError('Duplicate retry URL.')
        if {item['url'] for item in retry} != {item['url'] for item in initial if item['status'] == 'failed'}:
            raise ValueError('Retry receipt does not cover exactly the failed downloads.')
        downloads.update({item['url']: item for item in retry})
    rows, slots, urls = [], set(), set()
    for slot in inventory['slots']:
        key = (slot['game'], slot['locale'])
        if key in slots or slot['locale'] not in locales or slot.get('direction') not in ('ltr', 'rtl'):
            raise ValueError('Duplicate/unknown slot or missing catalog direction.')
        slots.add(key)
        images = slot['images']
        if (slot['unresolvedCount'] != 0 or slot['expectedVisibleCount'] != len(images)
                or slot['storedCount'] != len(images)):
            raise ValueError(f'Unresolved or non-visible stored screenshots: {key}')
        for order, image in enumerate(images, 1):
            url = image['url']
            urls.add(url)
            item = downloads.get(url, {})
            if item.get('status') != 'downloaded':
                raise ValueError(f'Missing successful download: {key}/{order}')
            filename = item.get('filename', '')
            if not filename or Path(filename).name != filename:
                raise ValueError('Unsafe image filename.')
            image_path = root / filename
            if image_path.is_symlink() or not image_path.is_file():
                raise ValueError('Missing regular image file.')
            if digest(image_path.read_bytes()) != item['sha256']:
                raise ValueError(f'Image hash changed: {key}/{order}')
            if any(type(item.get(k)) is not int or item[k] <= 0 for k in ('width', 'height')):
                raise ValueError('Missing positive image dimensions.')
            rows.append(dict(game=key[0], locale=key[1], order=order, direction=slot['direction'],
                             url=url, filename=filename, sha256=item['sha256'],
                             width=item['width'], height=item['height']))
    games = {game for game, _ in slots}
    mode = inventory['selection'].get('documentMode', 'published')
    if mode == 'latest-draft':
        if (not inventory['selection'].get('game') or inventory.get('publicGameCount') != 0
                or inventory.get('draftGameCount') != 1
                or any(item.get('downloadMethod') != 'authenticated-maintenance-original' for item in downloads.values())):
            raise ValueError('Draft review requires one exact authenticated draft-original inventory.')
        game_count = inventory['draftGameCount']
    elif mode == 'published':
        game_count = inventory['publicGameCount']
    else:
        raise ValueError('Unknown screenshot document selection.')
    if (not rows or len(games) != game_count
            or slots != {(game, locale) for game in games for locale in locales}):
        raise ValueError('Empty or incomplete game/locale inventory.')
    selected_game = inventory['selection'].get('game')
    if selected_game and games != {selected_game}:
        raise ValueError('Inventory differs from selected game.')
    if set(downloads) != urls:
        raise ValueError('Download receipt differs from inventory URL set.')
    return {'schemaVersion': 1, 'inputs': {name: digest((root / name).read_bytes()) for name in receipts},
            'images': rows}


def local_rows(root, manifest):
    """An explicit complete native set; never pretend it is a hosted export."""
    data = load(manifest)
    if data.get('schemaVersion') != 1 or data.get('kind') != 'native-screenshots':
        raise ValueError('Expected native-screenshots manifest schemaVersion 1.')
    if not isinstance(data.get('scope'), str) or not data['scope'].strip() or not data.get('provenance'):
        raise ValueError('Native inventory requires explicit scope and provenance files.')
    inputs = {'nativeManifest': digest(manifest.read_bytes())}
    for name, item in data['provenance'].items():
        path = Path(item['path'])
        if not path.is_absolute() or path.is_symlink() or not path.is_file():
            raise ValueError('Provenance requires an absolute regular evidence file.')
        actual = digest(path.read_bytes())
        if actual != item['sha256']:
            raise ValueError('Native provenance hash changed.')
        inputs['provenance:' + name] = actual
    rows, slots = [], set()
    for item in data['images']:
        key = (item['game'], item['locale'], item['order'])
        if (key in slots or not all(isinstance(v, str) and v for v in key[:2])
                or type(key[2]) is not int or key[2] <= 0
                or item['direction'] not in ('ltr', 'rtl')):
            raise ValueError('Invalid/duplicate native slot.')
        slots.add(key)
        filename = item['filename']
        if not filename or Path(filename).name != filename:
            raise ValueError('Unsafe image filename.')
        path = root / filename
        if path.is_symlink() or not path.is_file() or digest(path.read_bytes()) != item['sha256']:
            raise ValueError('Native image missing or hash changed.')
        if any(type(item.get(k)) is not int or item[k] <= 0 for k in ('width', 'height')):
            raise ValueError('Missing positive image dimensions.')
        rows.append({**{key: item[key] for key in IDENTITY if key != 'url'}, 'url': None})
    if not rows:
        raise ValueError('Empty native inventory.')
    return {'schemaVersion': 1, 'inputs': inputs, 'images': rows}


def initialize(root, review_path, manifest=None):
    report = inventory_rows(root, manifest)
    for row in report['images']:
        row.update(reviewer=None, reviewedAt=None, observations='', findings=[],
                   checks={key: 'pending' for key in CHECKS})
    # Exclusive creation preserves previous cycles and never marks images passed.
    with review_path.open('x') as stream:
        stream.write(json.dumps(report, ensure_ascii=False, indent=2) + '\n')
    return len(report['images'])


def check_report(expected, report):
    if report.get('schemaVersion') != 1 or report.get('inputs') != expected['inputs']:
        raise ValueError('Stale inventory/download evidence binding.')
    rows = report.get('images', [])
    if len(rows) != len(expected['images']):
        raise ValueError('Review image coverage differs from inventory.')
    counts = Counter()
    for row, target in zip(rows, expected['images']):
        if {key: row.get(key) for key in IDENTITY} != target:
            raise ValueError('Review slot identity/order/hash differs from inventory.')
        checks = row.get('checks', {})
        if set(checks) != set(CHECKS) or any(value not in ('pending', 'passed', 'failed', 'needs-review', 'not-applicable')
                                            for value in checks.values()):
            raise ValueError('Missing or invalid per-image checks.')
        accepted = all(checks[key] == 'passed' for key in CHECKS if key != 'rtl')
        accepted = accepted and checks['rtl'] == ('passed' if row['direction'] == 'rtl' else 'not-applicable')
        if accepted:
            if row.get('findings') != []:
                raise ValueError('Open findings cannot pass.')
            if any(not isinstance(row.get(key), str) or not row[key].strip()
                   for key in ('reviewer', 'reviewedAt', 'observations')):
                raise ValueError('Passed image lacks actual review attribution/observations.')
            timestamp = datetime.fromisoformat(row['reviewedAt'].replace('Z', '+00:00'))
            if timestamp.tzinfo is None:
                raise ValueError('Review timestamp requires timezone.')
        status = 'passed' if accepted else ('failed' if 'failed' in checks.values() else 'pending')
        counts[status] += 1
    return dict(total=len(rows), passed=counts['passed'], failed=counts['failed'], pending=counts['pending'])


def check(root, review_path, manifest=None):
    return check_report(inventory_rows(root, manifest), load(review_path))


def next_packet(root, review_path, packet_path, manifest=None, max_images=2, max_bytes=2*1024*1024,
                single_original=False):
    # These are conservative transport budgets, not a measured optimum or token estimate.
    if not 1 <= max_images <= 2 or not 1 <= max_bytes <= 2*1024*1024:
        raise ValueError('Packet limits: 1–2 images and at most 2 MiB encoded image bytes.')
    if single_original and max_images != 1:
        raise ValueError('Original-size pilot requires --max-images 1.')
    expected = inventory_rows(root, manifest)
    before = review_path.read_bytes()
    report = load(review_path)
    counts = check_report(expected, report)
    rows, size, locale = [], 0, None
    for index, row in enumerate(report['images']):
        if 'pending' not in row['checks'].values():
            continue
        identity = (row['game'], row['locale'])
        if locale is not None and identity != locale:
            continue
        path = (root / row['filename']).resolve()
        encoded = 4 * ((path.stat().st_size + 2) // 3) + 128
        if encoded > max_bytes and not single_original:
            if rows:
                break
            raise ValueError(f'Single image exceeds transport budget: {path.name}; keep pending; use --single-original --max-images 1 for a bounded original-size pilot, never resize or skip it.')
        if len(rows) >= max_images or (size + encoded > max_bytes and not single_original):
            break
        locale = identity
        rows.append({'index': index, 'path': str(path), 'encodedBytesEstimate': encoded, 'review': row})
        size += encoded
    if review_path.read_bytes() != before:
        raise ValueError('Review changed during packet preparation.')
    packet = {'schemaVersion': 1, 'reviewSha256': digest(before), 'inputs': expected['inputs'],
              'singleOriginalPilot': single_original, 'overDefaultBudget': size > 2*1024*1024,
              'encodedBytesEstimate': size, 'images': rows}
    with packet_path.open('x') as stream:
        stream.write(json.dumps(packet, ensure_ascii=False, indent=2) + '\n')
    return {**counts, 'packetImages': len(rows), 'encodedBytesEstimate': size}


def apply_packet(root, review_path, packet_path, result_path, manifest=None):
    """One coordinator imports a bounded, reviewer-authored result atomically."""
    lock = review_path.with_name(review_path.name + '.lock')
    # A stale lock requires reconciliation, never automatic deletion by a retry.
    with lock.open('x') as stream:
        stream.write(str(os.getpid()) + '\n')
    temporary = None
    try:
        expected = inventory_rows(root, manifest)
        before = review_path.read_bytes()
        report, packet, result = load(review_path), load(packet_path), load(result_path)
        check_report(expected, report)
        if (packet.get('schemaVersion') != 1 or packet.get('reviewSha256') != digest(before)
                or packet.get('inputs') != expected['inputs']):
            raise ValueError('Stale packet; reconcile current review before importing.')
        if result.get('packetSha256') != digest(packet_path.read_bytes()):
            raise ValueError('Result does not bind the exact packet.')
        selected = packet.get('images', [])
        incoming = result.get('images', [])
        if not 1 <= len(selected) <= 2 or len(incoming) != len(selected):
            raise ValueError('Result must cover exactly the nonempty bounded packet.')
        indices = set()
        for entry, row in zip(selected, incoming):
            index = entry['index']
            if type(index) is not int or index < 0 or index >= len(report['images']) or index in indices:
                raise ValueError('Invalid/duplicate packet index.')
            indices.add(index)
            old = report['images'][index]
            if entry['review'] != old or 'pending' not in old['checks'].values():
                raise ValueError('Packet would replace an existing completed review.')
            if {key: row.get(key) for key in IDENTITY} != {key: old[key] for key in IDENTITY}:
                raise ValueError('Result slot identity differs from packet.')
            if any(not isinstance(row.get(k), str) or not row[k].strip()
                   for k in ('reviewer', 'reviewedAt', 'observations')):
                raise ValueError('Every result needs reviewer attribution and observations.')
            timestamp = datetime.fromisoformat(row['reviewedAt'].replace('Z', '+00:00'))
            if timestamp.tzinfo is None:
                raise ValueError('Review timestamp requires timezone.')
            checks = row.get('checks', {})
            if set(checks) != set(CHECKS) or 'pending' in checks.values():
                raise ValueError('Every selected image requires a completed judgment or needs-review.')
            findings = row.get('findings')
            if not isinstance(findings, list):
                raise ValueError('Findings must be a list.')
            if any(v in ('failed', 'needs-review') for v in checks.values()) and not findings:
                raise ValueError('Failure/uncertainty requires concrete findings.')
            if any(not all(isinstance(f.get(k), str) and f[k].strip() for k in
                           ('check', 'severity', 'region', 'observed', 'expected', 'nextAction')) for f in findings):
                raise ValueError('Incomplete finding.')
            report['images'][index] = row
        counts = check_report(expected, report)
        with tempfile.NamedTemporaryFile(mode='w', dir=review_path.parent, prefix='.review-', delete=False) as stream:
            temporary = Path(stream.name)
            stream.write(json.dumps(report, ensure_ascii=False, indent=2) + '\n')
            stream.flush()
            os.fsync(stream.fileno())
        # Recheck dependencies immediately before the single-file commit.
        if inventory_rows(root, manifest) != expected or review_path.read_bytes() != before:
            raise ValueError('Inputs/review changed during import.')
        os.replace(temporary, review_path)
        return counts
    finally:
        if temporary is not None:
            temporary.unlink(missing_ok=True)
        lock.unlink()


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('action', choices=('init', 'check', 'next', 'apply'))
    parser.add_argument('export', type=Path)
    parser.add_argument('--review', required=True, type=Path)
    parser.add_argument('--manifest', type=Path, help='Explicit native set; omit for hosted all-locale export')
    parser.add_argument('--packet', type=Path)
    parser.add_argument('--result', type=Path)
    parser.add_argument('--max-images', type=int, default=2)
    parser.add_argument('--max-bytes', type=int, default=2*1024*1024)
    parser.add_argument('--single-original', action='store_true', help='One original-size pilot; no resizing or batch budget increase')
    args = parser.parse_args()
    if args.action == 'init':
        print(f'Initialized {initialize(args.export, args.review, args.manifest)} pending image rows. No visual review performed.')
    elif args.action == 'next':
        if args.packet is None:
            parser.error('next requires --packet <new-file>')
        print(json.dumps(next_packet(args.export, args.review, args.packet, args.manifest, args.max_images, args.max_bytes, args.single_original)))
    elif args.action == 'apply':
        if args.packet is None or args.result is None:
            parser.error('apply requires --packet and --result')
        print(json.dumps(apply_packet(args.export, args.review, args.packet, args.result, args.manifest)))
    else:
        result = check(args.export, args.review, args.manifest)
        print(json.dumps(result))
        if result['passed'] != result['total']:
            raise SystemExit(1)
        print('Complete review evidence coverage passed; visual judgments are reviewer-authored.')


if __name__ == '__main__':
    try:
        main()
    except (ValueError, OSError, KeyError, TypeError) as error:
        raise SystemExit(str(error))
