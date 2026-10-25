#!/usr/bin/env python3
"""Recover the recorded failed metadata exports from pinned game assemblies."""
import json
from pathlib import Path
import UnityPy
from UnityPy.helpers.TypeTreeGenerator import TypeTreeGenerator
from extract_assets import dump, sha, strings, read_tree

ROOT = Path(__file__).resolve().parents[1]
OUT = ROOT / 'assets/source-v2'


def main():
    report = json.loads((OUT / 'report.json').read_text())
    root = Path(report['sourceRoot'])
    original = OUT / 'failures-initial.json'
    if original.exists():
        raise ValueError('Repair already attempted; inspect existing outcome before continuation')
    original.write_bytes((OUT / 'failures.json').read_bytes())
    dump(OUT / 'report-initial.json', report)
    source = json.loads((OUT / 'source-files.json').read_text())
    for rel, r in source.items():
        assert sha(root / rel) == r['sha256'], 'Source changed: ' + rel
    env = UnityPy.load(str(root))
    generator = TypeTreeGenerator('2020.3.24f1')
    generator.load_local_dll_folder(str(root / 'Managed'))
    live = {}
    for obj in env.objects:
        asset = obj.assets_file
        internal = []
        while asset.parent is not env:
            internal.insert(0, asset.name)
            asset = asset.parent
        paths = [p for p in source if Path(p).name == asset.name]
        assert len(paths) == 1
        name = paths[0] + (('!/' + '/'.join(internal)) if internal else '')
        key = f'{name}:{obj.path_id}'
        assert key not in live
        live[key] = obj
    rows = json.loads((OUT / 'objects.json').read_text())
    by_id = {r['id']: r for r in rows}
    fields = json.loads((OUT / 'string-fields.json').read_text())
    failures = []
    recovered = []
    for failure in json.loads(original.read_text()):
        key = failure['id']
        obj = live[key]
        row = by_id[key]
        try:
            tree = read_tree(obj, generator)
            import hashlib
            filename = hashlib.sha256(row['asset'].encode()).hexdigest()[:10] + '-' + Path(obj.assets_file.name).name + '-' + str(obj.path_id) + '.json'
            path = OUT / 'trees' / filename
            dump(path, tree)
            row.update(tree=path.relative_to(OUT).as_posix(), treeSha256=sha(path),
                       metadataRecovery='game-assemblies' if obj.type.name == 'MonoBehaviour' else 'binary-safe-json')
            if obj.type.name == 'MonoBehaviour':
                for pointer,value in strings(tree):
                    field = pointer.rsplit('/',1)[-1]
                    kind = row['class']
                    known = field in ['m_text','m_Text'] and kind in ['UnityEngine.UI.Text','TMPro.TextMeshProUGUI','TMPro.TextMeshPro']
                    fields.append({'id':key+pointer,'object':key,'pointer':pointer,'value':value,'class':kind,
                                   'classification':'initial-display-value' if known else 'preserve-exactly-pending-consumer-review'})
            recovered.append(key)
        except Exception as exc:
            failures.append(dict(failure, recoveryError=type(exc).__name__+': '+str(exc)))
    dump(OUT / 'objects.json', rows)
    dump(OUT / 'string-fields.json', fields)
    dump(OUT / 'failures.json', failures)
    dump(OUT / 'metadata-recovery.json', {'recovered':recovered,'unresolved':failures,
         'TypeTreeGeneratorAPI':'0.0.10','scriptSha256':sha(Path(__file__)),
         'sourceManifestSha256':sha(OUT / 'source-files.json')})
    report['counts'].update(stringFields=len(fields),failures=len(failures))
    report['metadataRecovery']={'recovered':len(recovered),'unresolved':len(failures),
                               'TypeTreeGeneratorAPI':'0.0.10','scriptSha256':sha(Path(__file__))}
    dump(OUT / 'report.json',report)
    print(json.dumps(report['metadataRecovery']),flush=True)


if __name__=='__main__':
    main()
