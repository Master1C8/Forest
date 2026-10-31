"""Apply a finite authored terminology delta to a verified saved Unity build.

No model, game, installation or semantic acceptance. Reuse the existing tree,
BG readback, serialization and Addressables mechanisms; publish manifest last.
"""
import argparse
import ast
import copy
import hashlib
import importlib.util
import json
from pathlib import Path
import shutil
import sys
import tempfile

ROOT = Path(__file__).resolve().parents[1]


def need(ok, why):
    if not ok:
        raise ValueError(why)


def sha(data):
    return hashlib.sha256(data).hexdigest()


def read(path):
    return json.loads(path.read_bytes())


def module(path, name):
    spec = importlib.util.spec_from_file_location(name, path)
    result = importlib.util.module_from_spec(spec); spec.loader.exec_module(result)
    return result


def local(name):
    path = (ROOT/name).resolve()
    need(path.is_relative_to(ROOT), 'canonical-project-path')
    return path


def run(profile_path, locale, output, mode):
    profile = read(profile_path)
    need(locale == profile['locale'] and profile['culture'], 'explicit-locale')
    need(output.is_relative_to(ROOT/'dist') and output != ROOT/'dist', 'new-delivery-output')
    need(sys.version == profile['python'] and sha(Path(sys.executable).read_bytes()) == profile['pythonExecutableSha256'], 'pinned-python')
    for pin in profile['pins']:
        need(sha(local(pin['path']).read_bytes()) == pin['sha256'], 'input-pin:'+pin['path'])
    base = local(profile['baseData'])
    need(not output.is_relative_to(base) and not base.is_relative_to(output), 'preserve-accepted-build')
    changes = [json.loads(s) for s in local(profile['dialogueChanges']).read_text().splitlines() if s]
    bg = read(local(profile['bgChanges']))
    need(len(changes) == len({r['id'] for r in changes}) and len(bg) == len({r['id'] for r in bg}), 'unique-authored-ids')
    need(read(local(profile['preflight']))['passed'] is True, 'text-preflight')
    need(shutil.disk_usage(ROOT).free - sum((base/n).stat().st_size for n in profile['assets'])*3 >= 5*1024**3, 'five-GiB-reserve')
    sys.path.insert(0, str(ROOT/'tools'))
    import UnityPy
    from UnityPy.helpers.TypeTreeGenerator import TypeTreeGenerator
    import extract_assets as ex
    import addressables_catalog as catalog
    engine = module(local(profile['compositionHelper']), 'terminology_engine')
    inventory = module(local(profile['inventoryHelper']), 'terminology_inventory')
    # Reuse exactly the owning serializer function, avoiding unrelated live-build
    # imports and frozen-input reads in the full historical builder module.
    path = local(profile['treeWriter'])
    node = next(n for n in ast.parse(path.read_text()).body if isinstance(n, ast.FunctionDef) and n.name == 'save_tree')
    scope = {}; exec(compile(ast.Module(body=[node], type_ignores=[]), str(path), 'exec'), scope)
    save_tree = scope['save_tree']
    generator = TypeTreeGenerator('2020.3.24f1')
    generator.load_local_dll_folder(str(base/'Managed'))
    output.mkdir(parents=True, exist_ok=True)
    data_root = output/'The Forest of Love_Data'
    receipts, bindings = [], {}

    def publish(name, data):
        path = data_root/name
        if mode == 'check':
            need(path.is_file() and path.read_bytes() == data, 'actual-output:'+name)
        elif path.exists():
            need(mode == 'resume' and path.read_bytes() == data, 'conflicting-or-existing-output:'+name)
        else:
            path.parent.mkdir(parents=True, exist_ok=True)
            with path.open('xb') as stream:
                stream.write(data)
        bindings[name] = dict(bytes=len(data), sha256=sha(data), beforeSha256=sha((base/name).read_bytes()))

    for name in profile['assets']:
        before = UnityPy.load(str(base/name)); env = UnityPy.load(str(base/name))
        objects = engine.objects(env); expected = {}; selected = profile['dialogueObjects'].get(name)
        selected_ids = ([selected] if selected is not None else []) + ([320] if name == 'resources.assets' else [])
        for pid in selected_ids:
            original = ex.read_tree(objects[pid], generator)
            if name == 'resources.assets':
                raw = original['m_Script'].encode('utf-8', errors='surrogateescape')
                result, proof = engine.bg_project(raw, bg, inventory)
                tree = copy.deepcopy(original); tree['m_Script'] = result.decode('utf-8', errors='surrogateescape')
                receipts.append(dict(asset=name, bg=proof))
            else:
                edits = [dict(r, source=r['before']) for r in changes]
                tree = engine.merged_edits(original, edits)
                # Every unchanged dialogue/control/metadata field is part of the
                # complete-tree comparison, including technical/dormant values.
                receipts.append(dict(asset=name, logicalDialogueChanges=len(edits)))
            expected[pid] = tree
            save_tree(objects[pid], tree, generator)
        data = env.file.save(packer='original') if name.endswith('.bundle') else env.file.save()
        after = UnityPy.load(data); after.path = str((base/name).parent)
        proof = engine.verify_resource(before, after, expected, ex, generator)
        reversed_env = UnityPy.load(data); reversed_env.path = str((base/name).parent)
        reverse_objects = engine.objects(reversed_env); originals = engine.objects(before)
        for pid in selected_ids:
            reverse_objects[pid].set_raw_data(originals[pid].get_raw_data())
        reversed_data = reversed_env.file.save(packer='original') if name.endswith('.bundle') else reversed_env.file.save()
        need(reversed_data == (base/name).read_bytes(), 'complete-container-reversal:'+name)
        receipts.append(dict(asset=name, completeContainerReversal=True, **proof))
        publish(name, data)
        print(json.dumps(dict(asset=name, status='verified')), flush=True)
    bundle = profile['bundle']; catalog_name = 'StreamingAssets/aa/catalog.json'
    with tempfile.TemporaryDirectory(prefix='terminology-catalog-', dir=output) as temp:
        path = Path(temp)/'catalog.json'
        proof = catalog.update_catalog(base/catalog_name, path, base/bundle, data_root/bundle)
        receipts.append(dict(asset=catalog_name, **proof)); publish(catalog_name, path.read_bytes())
    result = dict(schemaVersion=1, locale=locale, culture=profile['culture'],
        baseline=profile['baselineAcceptance'], profile=dict(path=str(profile_path.relative_to(ROOT)), sha256=sha(profile_path.read_bytes())),
        files=bindings, dialogueChanges=len(changes), physicalDialogueChanges=2*len(changes),
        databaseChanges=len(bg), receipts=receipts, unchangedBaselineFiles=profile['unchangedBaselineFiles'],
        installed=False, gameTesting='not-run', semanticReview='Author edit; owner deferred review to human editors',
        publicationBoundary='Independent exclusive file writes; manifest published last, not a multi-file installation transaction.')
    manifest = output/'manifest.json'
    if mode == 'check' or manifest.exists():
        need(manifest.exists() and read(manifest) == result, 'complete-manifest')
    else:
        with manifest.open('x') as stream:
            json.dump(result, stream, ensure_ascii=False, indent=2); stream.write('\n')
    return dict(passed=True, output=str(output), dialogueChanges=len(changes), databaseChanges=len(bg), files=len(bindings))


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--profile', type=Path, required=True)
    parser.add_argument('--locale', required=True)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--mode', choices=['build', 'resume', 'check'], required=True)
    args = parser.parse_args()
    print(json.dumps(run(args.profile.resolve(), args.locale, args.output.resolve(), args.mode)))
