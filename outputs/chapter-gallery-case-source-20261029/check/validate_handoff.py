#!/usr/bin/env python3
"""Validate the finite handoff, including appended evidence, without mutations."""
import hashlib
import importlib.util
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[3]
OUT = ROOT / 'localization/source/chapter-gallery-case-20261029'
def sha(p):
    return hashlib.sha256(Path(p).read_bytes()).hexdigest()
def load(p):
    return json.loads(Path(p).read_text())
def rows(p):
    return [json.loads(l) for l in Path(p).read_text().splitlines()]

manifest = load(OUT/'handoff-manifest.json')
assert {p.name for p in OUT.iterdir()} == set(manifest['products']) | {'handoff-manifest.json'}
for name, pin in manifest['products'].items():
    assert sha(OUT/name) == pin['sha256'] and (OUT/name).stat().st_size == pin['bytes'], ('handoff-product',name)
for name, pin in manifest['additionalEvidence'].items():
    assert sha(ROOT/name) == pin['sha256'], ('handoff-evidence',name)
for name, pin in load(OUT/'input-pins.json').items():
    assert sha(ROOT/name) == pin['sha256'], ('source-input', name)
recipe=ROOT/'tools/chapter_gallery_case_source.py'
spec=importlib.util.spec_from_file_location('chapter_gallery_case_source',recipe)
mod=importlib.util.module_from_spec(spec);spec.loader.exec_module(mod)
expected={n:mod.encode(n,v) for n,v in mod.derive().items()}
mod.verify_products({n:(OUT/n).read_bytes() for n in expected},expected)
source=rows(OUT/'source.jsonl');original=rows(OUT/'original-members.jsonl');absence=rows(OUT/'absence.jsonl');protected=rows(OUT/'preserve-exactly.jsonl')
assert len(original)==len(set(r['id'] for r in original))==153
assert len(source)==134 and len(absence)==16 and len(protected)==10
assert len(set(r['id'] for r in original) & set(r['id'] for r in source))==132
assert all(r['source'] is None and not r['sourceState']['stored'] for r in absence)
ctx=load(OUT/'producer-context.json');initial=rows(OUT/'initial-display-context.jsonl')
assert len(initial)==19
bindings={r['group']:r for r in ctx['serializedProducerBindings']}
assert not set(bindings['confirmation-live']['exactPotentialTmpDescendants']) & {r['id'] for r in initial}
assert bindings['confirmation-live']['rootGameObject']=='sharedassets2.assets:3483'
assert ctx['outOfSync']['wrapper']=="''{0}''"
selection=rows(OUT/'selection-identities.jsonl')
assert len(selection)==59 and len({r['hintId'] for r in selection})==59
assert sum(r['hintStored'] for r in selection)==57
assert len(ctx['identifier']['unselectedMovieHintStateIds'])==6
retained=load(OUT/'retained-candidate-references.json')
assert sha(ROOT/retained['retainedSource'])==retained['retainedSourceSha256']
for r in retained['candidates']:
    assert sha(ROOT/r['artifact'])==r['artifactSha256']
    assert next(s for s in source if s['id']==r['destinationId'])['source']==r['source']
    if 'sourceArtifact' in r:assert sha(ROOT/r['sourceArtifact'])==r['sourceArtifactSha256']
read_receipt=load(ROOT/'outputs/chapter-gallery-case-source-20261029/check/source-read-receipts.json')
assert sha(read_receipt['assembly'])==read_receipt['assemblySha256']==mod.ASSEMBLY
ui_manifest=load(ROOT/'outputs/pause-inventory-bio-completion-20261028/ui-consumer-index/manifest.json')
assert ui_manifest['sourceSha256']==mod.ASSEMBLY
assert sha(ROOT/'outputs/pause-inventory-bio-completion-20261028/ui-consumer-index/bodies.jsonl')==ui_manifest['bodiesSha256']
for doc in ['manifest.json','case-decision.json']:
    d=load(OUT/doc);assert not d['targetEditorialAccepted'] and not d['wholeGameAccepted']
print(json.dumps({'status':'passed-final-static-handoff','originalMembers':153,'all153Accounted':True,'sourceOccurrences':134,'distinctSourceValues':92,'absent':16,'protectedManagedOperands':10,'configuredOptions':59,'configuredStoredHints':57,'locales':30,'retainedRussianCandidates':12,'runtime':'not-run','targetEditorialAccepted':False,'wholeGameAccepted':False,'boundary':'Exact source/version/physical-selector and artifact integrity; not semantic target review, implementation or runtime.'}))
