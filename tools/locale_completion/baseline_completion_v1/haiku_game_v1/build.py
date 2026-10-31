"""Apply the accepted haiku mechanism to an explicit pinned locale game candidate.

Only Cecil reads the game DLL. CLR runs extracted predicate/helper fixtures whose
service, timer, callback and Unity boundaries are replaced. Shared manifest-last
publication is sequential; a saved manifest is the completion marker.
"""
import argparse
import collections
import importlib.util
import json
from pathlib import Path
import shutil
import subprocess


def sha(data):
    import hashlib
    return hashlib.sha256(data).hexdigest()


def encode(value):
    return (json.dumps(value, ensure_ascii=False, sort_keys=True, indent=2)+'\n').encode()


def need(ok, reason):
    if not ok:
        raise ValueError(reason)


def validate_map(mapping, locale, culture):
    need(mapping['locale'] == locale and culture.split('-')[0] == locale, 'explicit-locale-culture')
    need(mapping['context'] == 'oliver_coyotes_date2_haiku_finish', 'exact-finish-context')
    choices = mapping['choices']
    need(len(choices) == 9 and len({c['id'] for c in choices}) == 9, 'nine-unique-choice-identities')
    need([[int(c['id'].split(':')[2]) for c in choices if c['slot'] == s] for s in (1,2,3)] == [[325,410,406],[326,411,407],[327,412,408]], 'exact-slot-identities')
    for c in choices:
        need(c['context'] == mapping['context'] and c['conversationId'] == 303, 'choice-context')
        need(c['acceptedVerdict'] in ('clean','pass'), 'reviewed-choice')
        for field in ('source','target'):
            need(sha(c[field].encode()) == c[field+'Sha256'], 'choice-version')
        need(len(c['occurrences']) == 2, 'both-resource-occurrences')
    for s in (1,2,3):
        need(len({c['target'] for c in choices if c['slot'] == s}) == 3, 'unique-slot-labels')


def run(root, profile_path, output, mode):
    root, profile_path, output = root.resolve(), profile_path.resolve(), output.resolve()
    profile_bytes = profile_path.read_bytes(); profile = json.loads(profile_bytes)
    prefix = (root/profile['writePrefix']).resolve()
    need(prefix.is_relative_to(root) and output.is_relative_to(prefix) and output != prefix, 'own-output')
    pins = {}
    def read(pin):
        p = (root/pin['path']).resolve()
        need(p.is_relative_to(root), 'project-input')
        data = p.read_bytes();need(sha(data) == pin['sha256'], 'pin:'+pin['path'])
        pins[pin['path']] = pin['sha256'];return data
    for pin in profile['pins']:
        read(pin)
    mapping_bytes = read(profile['mapping']);mapping = json.loads(mapping_bytes)
    validate_map(mapping, profile['locale'], profile['culture'])
    base = json.loads(read(profile['baseManifest']))
    base_dir = (root/profile['baseManifest']['path']).parent
    need(base['locale'] == profile['locale'] and base['culture'] == profile['culture'] and base['ready'] is False, 'base-locale')
    files = {}
    for name, pin in base['outputs'].items():
        data = (base_dir/name).read_bytes()
        need(len(data) == pin['bytes'] and sha(data) == pin['sha256'], 'base:'+name)
        files[name] = data
    candidate_hash = sha(files['Managed/Assembly-CSharp.dll'])
    settings = dict(locale=profile['locale'],culture=profile['culture'],candidateSha256=candidate_hash,
        mappingSha256=sha(mapping_bytes),helperPrefix='VNRevival'+profile['locale'].upper()+'Haiku_')
    work = (root/profile['workDirectory']).resolve()
    need(work.is_relative_to(prefix) and work != prefix, 'own-work')
    compiler_files = {name:read(pin) for name,pin in profile['compilerSources'].items()}
    read(profile['publisher'])
    if mode == 'build':
        need(not work.exists(), 'fresh-work-required');work.mkdir(parents=True)
        compiler = work/'compiler';compiler.mkdir()
        for name,data in compiler_files.items():
            path=compiler/name;path.parent.mkdir(parents=True,exist_ok=True);path.write_bytes(data)
        (work/'mapping.json').write_bytes(mapping_bytes)
        (work/'settings.json').write_bytes(encode(settings))
        (work/'input.dll').write_bytes(files['Managed/Assembly-CSharp.dll'])
        (work/'verified-inputs.json').write_bytes(encode(pins))
        subprocess.run([profile['dotnet'],'build',str(compiler/'Patch.csproj'),'--nologo','--verbosity','quiet'],check=True)
        exe=compiler/'bin/Debug/net8.0/Patch.dll'
        def backend(*args):
            subprocess.run([profile['dotnet'],str(exe),str(work/'settings.json'),*map(str,args)],check=True)
        backend('patch',work/'input.dll',work/'mapping.json',work/'Assembly-CSharp.dll',work/'patch-receipt.json')
        backend('test',compiler/'deps/Assembly-CSharp.original.dll',work/'Assembly-CSharp.dll',work/'mapping.json',work/'predicate-tests.json',work/'fixtures')
        backend('dump',work/'Assembly-CSharp.dll',work/'complete-tree.json')
    need((work/'settings.json').read_bytes() == encode(settings) and (work/'mapping.json').read_bytes() == mapping_bytes, 'frozen-settings-map')
    need((work/'input.dll').read_bytes() == files['Managed/Assembly-CSharp.dll'], 'frozen-candidate')
    for name,data in compiler_files.items():
        need((work/'compiler'/name).read_bytes() == data, 'frozen-compiler:'+name)
    need((work/'verified-inputs.json').read_bytes() == encode(pins), 'verified-inputs')
    receipt=json.loads((work/'patch-receipt.json').read_bytes())
    tests=json.loads((work/'predicate-tests.json').read_bytes())
    dll=(work/'Assembly-CSharp.dll').read_bytes()
    need(receipt['inputSha256'] == candidate_hash and receipt['outputSha256'] == sha(dll), 'actual-output-binding')
    need(receipt['wholeAssemblyReadback'] and receipt['structuralReversal'] and receipt['reversalByteIdentical'] and receipt['normalizedReversalSha256'] == candidate_hash, 'exact-reversal')
    need((work/'Assembly-CSharp.dll.reversed.dll').read_bytes() == files['Managed/Assembly-CSharp.dll'] == (work/'Assembly-CSharp.dll.before.dll').read_bytes(), 'exact-serialized-reversal')
    need(receipt['modifiedExistingMethods'] == 1 and receipt['addedPrivateMethods'] == 4 and receipt['existingMethodDefinitionsPreserved'], 'bounded-method-delta')
    need(tests['passed'] and tests['actualPatchedSha256'] == sha(dll) and tests['locale'] == profile['locale'] and tests['culture'] == profile['culture'], 'actual-consumer-binding')
    need(tests['cultureResults'] == {'en-US':27,profile['culture']:27,'tr-TR':27} and len(tests['resolverResults']) == 9, 'full-predicate-and-source-values')
    outcomes=dict(collections.Counter(t['actual'] for t in tests['fixtures']))
    need(outcomes == {'bridge_ending':1,'penny_ending':1,'bug_ending':1,'mixed_ending':24}, 'all-27-outcomes')
    files['Managed/Assembly-CSharp.dll']=dll
    for name in ('mapping.json','settings.json','patch-receipt.json','predicate-tests.json','verified-inputs.json'):
        files['evidence/haiku-'+name]=(work/name).read_bytes()
    manifest=dict(schemaVersion=1,kind='locale-owned-full-game-haiku-candidate',locale=profile['locale'],culture=profile['culture'],
        input=profile['baseManifest'],profile=dict(path=str(profile_path.relative_to(root)),sha256=sha(profile_bytes)),
        outputs={n:dict(bytes=len(b),sha256=sha(b)) for n,b in files.items()},sourceCompanions=base['sourceCompanions'],
        unchangedPriorOutputs=[n for n in base['outputs'] if n!='Managed/Assembly-CSharp.dll'],
        selectedIds=[c['id'] for c in mapping['choices']],methodDelta=dict(existingModified=1,privateAdded=4),outcomes=outcomes,
        semanticCoverageAdded=0,independentIntegrationReview='pending',native='not-run',runtime='not-run',package='not-run',ready=False,applicationAllowed=False,
        publicationBoundary='Shared manifest-last sequential publication; no multi-file transaction; no owner installation')
    def verify(out,marker,payload):
        need(json.loads((out/'manifest.json').read_bytes()) == marker, 'manifest-readback')
        need({str(p.relative_to(out)) for p in out.rglob('*') if p.is_file()} == set(payload)|{'manifest.json'}, 'exact-paths')
        for n,b in payload.items():
            need((out/n).read_bytes() == b, 'payload-readback:'+n)
    for n,h in pins.items():
        need(sha((root/n).read_bytes()) == h, 'input-changed:'+n)
    if mode == 'check':
        verify(output,manifest,files)
    else:
        spec=importlib.util.spec_from_file_location('shared_publisher',root/profile['publisher']['path'])
        publisher=importlib.util.module_from_spec(spec);spec.loader.exec_module(publisher)
        publisher.publish(files,output,prefix,manifest,verify)
    return dict(passed=True,locale=profile['locale'],mode=mode,actualAssemblySha256=sha(dll),outcomes=outcomes,
        existingMethods=receipt['existingMethods'],unchangedOutputs=len(manifest['unchangedPriorOutputs']),ready=False)


if __name__ == '__main__':
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument('--root',type=Path,required=True);p.add_argument('--profile',type=Path,required=True)
    p.add_argument('--output',type=Path,required=True);p.add_argument('--mode',choices=['build','check'],default='build')
    a=p.parse_args();print(json.dumps(run(a.root,a.profile,a.output,a.mode)))
