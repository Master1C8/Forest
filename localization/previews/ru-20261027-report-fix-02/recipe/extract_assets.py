#!/usr/bin/env python3
"""Read-only Unity export. Outputs are inspection inputs, not approved translations."""
import argparse
import collections
import hashlib
import json
import re
from pathlib import Path

import UnityPy
from UnityPy.helpers.TypeTreeGenerator import TypeTreeGenerator
from UnityPy.helpers.TypeTreeNode import TypeTreeNode
from PIL import Image, ImageDraw


def sha(path):
    h = hashlib.sha256()
    with path.open('rb') as f:
        for block in iter(lambda: f.read(1024 * 1024), b''):
            h.update(block)
    return h.hexdigest()


def json_default(value):
    if isinstance(value, (bytes, bytearray)):
        return {'$bytesHex': bytes(value).hex()}
    raise TypeError(type(value).__name__)


def canonical(value):
    return json.loads(json.dumps(value, ensure_ascii=True, default=json_default))


def dump(path, value):
    path.parent.mkdir(parents=True, exist_ok=True)
    encoded = json.dumps(value, ensure_ascii=True, indent=2, default=json_default) + '\n'
    path.write_text(encoded)


def strings(value, prefix=''):
    if isinstance(value, dict):
        for k, v in value.items():
            yield from strings(v, prefix + '/' + str(k).replace('~', '~0').replace('/', '~1'))
    elif isinstance(value, list):
        for i, v in enumerate(value):
            yield from strings(v, prefix + '/' + str(i))
    elif isinstance(value, str) and value:
        yield prefix, value


def read_tree(obj, generator):
    """Prefer the source schema; generate only when the native schema fails.

    Some empty component classes are parsed correctly by Unity's base schema,
    while a generated schema changes header alignment without failing byte count.
    Always compare component identity against UnityPy's independent base reader.
    """
    try:
        tree = obj.read_typetree(check_read=True)
    except (ValueError, EOFError, AssertionError) as native_error:
        if obj.type.name != 'MonoBehaviour':
            raise
        head = obj.parse_monobehaviour_head()
        script = head.m_Script.deref().read()
        fullname = (script.m_Namespace + '.' if script.m_Namespace else '') + script.m_ClassName
        # TypeTreeGeneratorAPI 0.0.10 omits Unity's padding after m_Enabled.
        # Without it m_Script is read three bytes early, while later alignment
        # can still make the total consumed byte count appear correct.
        cache_key = ('forest-header-aligned:' + script.m_AssemblyName, fullname)
        nodes = generator.cache.get(cache_key)
        if nodes is None:
            generated = generator.get_nodes_up(script.m_AssemblyName, fullname)
            flat = [{k: v for k, v in row.items() if k != 'm_Children'} for row in generated.to_dict_list()]
            enabled = next(row for row in flat if row['m_Level'] == 1 and row['m_Name'] == 'm_Enabled')
            enabled['m_MetaFlag'] |= 0x4000
            # Rebuild the tree: mutating a node's flag does not invalidate its
            # cached compiled reader, even when the getter shows the new flag.
            nodes = TypeTreeNode.from_list(flat)
            generator.cache[cache_key] = nodes
        tree = obj.read_typetree(nodes=nodes, check_read=True)
    if obj.type.name == 'MonoBehaviour':
        head = obj.parse_monobehaviour_head()
        assert tree['m_Script'] == {'m_FileID': head.m_Script.m_FileID, 'm_PathID': head.m_Script.m_PathID}, f'Script identity changed: {obj.assets_file.name}:{obj.path_id}'
        assert tree['m_GameObject'] == {'m_FileID': head.m_GameObject.m_FileID, 'm_PathID': head.m_GameObject.m_PathID}, 'GameObject identity changed'
        assert tree['m_Enabled'] == head.m_Enabled and tree['m_Name'] == head.m_Name, 'Component header changed'
    return tree


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--source', type=Path, required=True)
    ap.add_argument('--output', type=Path, required=True)
    args = ap.parse_args()
    root, out = args.source.resolve(), args.output.resolve()
    if out.exists() or root == out or root in out.parents:
        raise ValueError('Require new output outside installation')
    out.mkdir(parents=True)
    for d in ['textures', 'sheets', 'trees', 'text-assets', 'fonts']:
        (out / d).mkdir()
    source = {}
    for p in sorted(root.rglob('*')):
        if p.is_file():
            source[p.relative_to(root).as_posix()] = {'bytes': p.stat().st_size, 'sha256': sha(p)}
    dump(out / 'source-files.json', source)
    env = UnityPy.load(str(root))
    generator = TypeTreeGenerator('2020.3.24f1')
    generator.load_local_dll_folder(str(root / 'Managed'))
    objects, textures, fields, text_assets, fonts, failures = [], [], [], [], [], []
    classes = collections.Counter()
    versions = set()
    for obj in sorted(env.objects, key=lambda o: (o.assets_file.name, o.path_id)):
        asset = Path(obj.assets_file.name).name
        container = obj.assets_file
        internal = []
        while container.parent is not env:
            internal.insert(0, container.name)
            container = container.parent
        candidates = [p for p in source if Path(p).name == container.name]
        if len(candidates) != 1:
            raise ValueError(f'Ambiguous source asset {asset}: {candidates}')
        source_file = candidates[0]
        asset = source_file + (('!/' + '/'.join(internal)) if internal else '')
        key = f'{asset}:{obj.path_id}'
        filename = hashlib.sha256(asset.encode()).hexdigest()[:10] + '-' + Path(obj.assets_file.name).name + '-' + str(obj.path_id)
        raw = obj.get_raw_data()
        row = {'id': key, 'asset': asset, 'sourceFile': source_file, 'internalAsset': internal, 'pathId': obj.path_id,
               'type': obj.type.name, 'bytes': len(raw),
               'rawSha256': hashlib.sha256(raw).hexdigest()}
        versions.add(obj.assets_file.unity_version)
        kind = obj.type.name
        try:
            if kind == 'MonoBehaviour':
                h = obj.parse_monobehaviour_head()
                s = h.m_Script.deref().read()
                row['class'] = s.m_Namespace + '.' + s.m_ClassName
                row['assembly'] = s.m_AssemblyName
                kind = row['class']
            if obj.type.name == 'Texture2D':
                d = obj.read()
                tx = dict(row, name=d.m_Name, width=d.m_Width, height=d.m_Height,
                          format=int(d.m_TextureFormat), mipCount=d.m_MipCount)
                if d.m_Width and d.m_Height:
                    image = d.image
                    if image.size != (d.m_Width, d.m_Height):
                        raise ValueError('Dimension mismatch')
                    path = out / 'textures' / (filename + '.png')
                    image.save(path)
                    tx.update(path=path.relative_to(out).as_posix(), sha256=sha(path), mode=image.mode,
                              status='exported', textReview='pending')
                else:
                    tx['status'] = 'empty-runtime-texture'
                textures.append(tx)
            elif obj.type.name == 'TextAsset':
                d = obj.read()
                data = d.m_Script.encode('utf-8', 'surrogateescape') if isinstance(d.m_Script, str) else bytes(d.m_Script)
                try:
                    data.decode('utf-8', 'strict')
                    suffix = '.txt'
                except UnicodeDecodeError:
                    suffix = '.bin'
                path = out / 'text-assets' / (filename + suffix)
                path.write_bytes(data)
                text_assets.append(dict(row, name=d.m_Name, path=path.relative_to(out).as_posix(),
                                        sha256=sha(path), classification='mixed-format-review-required'))
            elif obj.type.name in ['MonoBehaviour', 'TextMesh', 'Font', 'Sprite', 'SpriteAtlas', 'PlayerSettings', 'GameObject', 'Material', 'MonoScript']:
                tree = read_tree(obj, generator)
                path = out / 'trees' / (filename + '.json')
                dump(path, tree)
                row['tree'] = path.relative_to(out).as_posix()
                row['treeSha256'] = sha(path)
                if obj.type.name in ['MonoBehaviour', 'TextMesh']:
                    for pointer, value in strings(tree):
                        field = pointer.rsplit('/', 1)[-1]
                        known = field in ['m_Text', 'm_text'] and kind in ['UnityEngine.UI.Text', 'TMPro.TextMeshProUGUI', 'TMPro.TextMeshPro', 'TextMesh']
                        fields.append({'id': key + pointer, 'object': key, 'pointer': pointer,
                                       'value': value, 'class': kind,
                                       'classification': 'initial-display-value' if known else 'preserve-exactly-pending-consumer-review'})
                if obj.type.name == 'Font':
                    fonts.append(dict(row, name=tree.get('m_Name'), fontNames=tree.get('m_FontNames')))
                    d = obj.read()
                    if d.m_FontData:
                        (out / 'fonts' / (filename + '.font')).write_bytes(bytes(d.m_FontData))
        except Exception as exc:
            failures.append({'id': key, 'type': kind, 'error': type(exc).__name__ + ': ' + str(exc)})
        classes[kind] += 1
        objects.append(row)
    exported = [t for t in textures if t['status'] == 'exported']
    for start in range(0, len(exported), 48):
        sheet = Image.new('RGB', (1440, 1440), '#34343c')
        draw = ImageDraw.Draw(sheet)
        for i, tx in enumerate(exported[start:start + 48]):
            x, y = i % 6 * 240, i // 6 * 180
            with Image.open(out / tx['path']) as im:
                thumb = im.convert('RGBA'); thumb.thumbnail((234, 139))
                sheet.paste(thumb, (x + (240 - thumb.width) // 2, y), thumb)
            draw.text((x + 3, y + 140), f'{start+i:04d} ' + tx['id'].replace('sharedassets', 'sa')[:30], fill='white')
            draw.text((x + 3, y + 156), tx['name'][:35], fill='white')
        sheet.save(out / 'sheets' / f'{start // 48 + 1:03d}.jpg', quality=88)
    for name, data in [('objects', objects), ('textures', textures), ('string-fields', fields),
                       ('text-assets', text_assets), ('fonts', fonts), ('failures', failures)]:
        dump(out / (name + '.json'), data)
    summary = {'game': 'The Forest of Love', 'version': '0.45', 'unity': sorted(versions),
               'sourceRoot': str(root), 'UnityPy': UnityPy.__version__,
               'sourceManifestSha256': sha(out / 'source-files.json'),
               'extractorSha256': sha(Path(__file__)),
               'counts': {'objects': len(objects), 'textures': len(textures), 'exportedTextures': len(exported),
                          'stringFields': len(fields), 'textAssets': len(text_assets), 'fonts': len(fonts),
                          'failures': len(failures), 'sheets': (len(exported)+47)//48},
               'classes': dict(classes.most_common()), 'gameWrites': False,
               'sourceAcceptance': 'needs-review: consumer classification and special-scene discovery pending',
               'reinsertion': 'not-run', 'runtime': 'not-run'}
    dump(out / 'report.json', summary)
    print(json.dumps(summary['counts']), flush=True)


if __name__ == '__main__':
    main()
