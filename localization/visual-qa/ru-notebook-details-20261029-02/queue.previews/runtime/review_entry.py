#!/usr/bin/env python3
"""Compress inputs before new queue creation. Existing queues retain frozen code."""
import argparse
import copy
import importlib.util
import json
from pathlib import Path
import sys

HERE = Path(__file__).resolve().parent


def module(name):
    spec = importlib.util.spec_from_file_location('screenshot_' + name, HERE / (name + '.py'))
    value = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(value)
    return value


def prepare_scope(source_root, destination, source_manifest=None):
    evidence, preview = module('review'), module('screenshot_preview')
    source_root, destination = source_root.resolve(), destination.resolve()
    expected = evidence.inventory_rows(source_root, source_manifest)
    if destination.is_relative_to(source_root):
        raise ValueError('Prepared review copies must be outside the source/upload image directory.')
    destination.mkdir(parents=True)  # Exclusive; partial preparation is preserved, never silently overwritten.
    (destination / 'images').mkdir()
    (destination / 'runtime').mkdir()
    provenance, converted, bindings, prepared = {}, [], [], {}
    def pin(name, path):
        path = path.resolve()
        provenance[name] = {'path': str(path), 'sha256': evidence.digest(path.read_bytes())}
    if source_manifest is not None:
        native = evidence.load(source_manifest)
        pin('sourceManifest', source_manifest)
        for name, row in native['provenance'].items():
            pin('source:' + name, Path(row['path']))
        source_kind = 'native'
    else:
        for name in expected['inputs']:
            pin('source:' + name, source_root / name)
        source_kind = 'hosted-export'
    for row in expected['images']:
        source = source_root / row['filename']
        before = source.read_bytes()
        if evidence.digest(before) != row['sha256']:
            raise ValueError('Source changed before compression.')
        if row['sha256'] not in prepared:
            target = destination / 'images' / (row['sha256'] + '.webp')
            prepared[row['sha256']] = preview.prepare(source, target)
        receipt = prepared[row['sha256']]
        if receipt['sourceDimensions'] != [row['width'], row['height']]:
            raise ValueError('Source image dimensions differ from the pinned inventory.')
        # Different slots with identical bytes still retain separate image judgments.
        item = copy.deepcopy(row)
        item.update(filename=Path(receipt['path']).name, sha256=receipt['sha256'],
                    width=receipt['width'], height=receipt['height'])
        converted.append(item)
        bindings.append({'source': row, 'sourcePath': str(source), 'preview': receipt})
        pin('source-image:' + row['filename'], source)
    for name in ('screenshot_preview.py', 'review_entry.py', 'review.py'):
        target = destination / 'runtime' / name
        target.write_bytes((HERE / name).read_bytes())
        pin('converter:' + name, target)
    binding = destination / 'source-bindings.json'
    binding.write_text(json.dumps({'policy': preview.POLICY, 'sourceKind': source_kind,
                                  'sourceInputs': expected['inputs'], 'images': bindings}, indent=2))
    pin('sourceBindings', binding)
    manifest = destination / 'manifest.json'
    manifest.write_text(json.dumps(dict(schemaVersion=1, kind='native-screenshots',
        scope='Complete prepared full-frame preview set from ' + source_kind + '; original files are provenance, not model input.',
        sourceKind=source_kind, representation=preview.POLICY, provenance=provenance, images=converted), indent=2))
    # Recheck the original receipts, image bytes and complete inventory after all writes.
    if evidence.inventory_rows(source_root, source_manifest) != expected:
        raise ValueError('Source scope changed during compression; preserve preparation and start a new bound scope.')
    evidence.inventory_rows(destination / 'images', manifest)
    return destination / 'images', manifest


def main(argv=None, project_root=None):
    argv = list(sys.argv[1:] if argv is None else argv)
    queue = module('review_queue')
    if not argv or argv[0] != 'init' or '--help' in argv or '-h' in argv:
        return queue.main(argv, project_root)
    parser = argparse.ArgumentParser(add_help=False)
    for key in ('queue', 'root', 'review', 'manifest', 'context'):
        parser.add_argument('--' + key, type=Path)
    parser.add_argument('--model')
    parser.add_argument('--reasoning')
    args, _ = parser.parse_known_args(argv[1:])
    if not all((args.queue, args.root, args.review, args.context, args.model, args.reasoning)):
        return queue.main(argv, project_root)
    queue.selection(args.model, args.reasoning)
    if project_root:
        for path in (args.queue, args.root, args.review, args.manifest, args.context):
            if path and not path.resolve().is_relative_to(project_root):
                raise ValueError('Review paths must stay inside the canonical project.')
    if args.queue.exists() or args.review.with_name(args.review.name + '.queue-owner.json').exists():
        raise ValueError('Existing queue or owned ledger; inspect status, never initialize over active work.')
    context = queue.bounded_text(args.context)
    if args.review.exists():
        raise ValueError('Compressed review uses a new ledger; preserve prior original-image judgments in their existing cycle.')
    prepared = args.queue.resolve().with_name(args.queue.name + '.previews')
    root, manifest = prepare_scope(args.root, prepared, args.manifest)
    instructions = (context + '\n\nOwner-approved review representation: full-frame WebP, quality 80, '
        'longest edge at most 1280 pixels, never upscaled. Judge the delivered prepared copy. '
        'Do not assume this is the original resolution. Original hashes, complete source scope and '
        'native/hosted provenance are pinned in source-bindings.json. If small text, glyphs, RTL marks '
        'or edges cannot be resolved, return needs-review with an exact region. A later affected packet '
        'may contain a source-pixel crop; never silently pass unreadable detail.\n')
    context_path = prepared / 'acceptance.txt'
    context_path.write_text(instructions)
    queue.bounded_text(context_path)
    for option, value in (('--root', root), ('--manifest', manifest), ('--context', context_path)):
        if option in argv:
            argv[argv.index(option) + 1] = str(value)
        else:
            argv += [option, str(value)]
    return queue.main(argv, project_root)


if __name__ == '__main__':
    try:
        main()
    except (ValueError, OSError, KeyError) as error:
        raise SystemExit(str(error))
