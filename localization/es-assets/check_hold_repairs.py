"""Focused Spanish adapter regressions and input-only rebuild/preservation verification.

No model calls or wording generation. Execute only with exclusive ownership of this lane.
The intentional write failure exercises the local output commit boundary, not Unity runtime.
"""
import hashlib
import json
from pathlib import Path
import sys
import importlib.util

sys.dont_write_bytecode = True
HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
PHASE = ROOT/'outputs/locale-assets-20261026/es/0033-translation'
spec = importlib.util.spec_from_file_location('es_corpus', HERE/'corpus.py')
corpus = importlib.util.module_from_spec(spec)
spec.loader.exec_module(corpus)
checks = []

def sha(raw): return hashlib.sha256(raw).hexdigest()
def passed(name, boundary): checks.append({'name': name, 'status': 'passed', 'boundary': boundary})
def rejected(name, action, expected):
    try: action()
    except AssertionError as error:
        assert expected in str(error), (name, expected, str(error))
        passed(name, expected)
    else: raise AssertionError(name+' accepted invalid input')

def same_controls(source, target, ordinary=()):
    assert corpus.controls(source,ordinary)==corpus.controls(target,ordinary), 'protected control mismatch'

flower = corpus.BYID['ds:131:153:Dialogue Text']
overlay = HERE/'dialogue.es.jsonl'
rows = {r['id']:r for r in map(json.loads,overlay.read_text().splitlines())}
actual = rows[flower['id']]['target']
corpus.validate_text(flower,actual)
passed('actual ordinary flower prose', 'Source/evidence-bound occurrence accepts translated body and exact delimiters')
rejected('same source at unauthorized occurrence',lambda: corpus.validate_text({**flower,'id':'ds:199:182:Dialogue Text'},actual), 'protected control mismatch')
rejected('changed source fingerprint',lambda: corpus.validate_text({**flower,'source':flower['source']+' '},actual), 'ordinary source mismatch')
rejected('engine control replaces ordinary bracket',lambda: corpus.validate_text(flower,'[pic=2]'), 'Ordinary span became engine control')
rejected('unknown control injected into flower prose',lambda: corpus.validate_text(flower,actual[:-1]+' [future=alpha]]'), 'protected control mismatch')
rejected('number added inside prose bracket',lambda: corpus.validate_text(flower,actual[:-1]+' 2]'), 'number mismatch')
rejected('delimiter removed',lambda: corpus.validate_text(flower,actual[1:-1]), 'protected control mismatch')
rejected('extra closing delimiter',lambda: corpus.validate_text(flower,actual+']'), 'Unbalanced ordinary bracket delimiter')
rejected('separator injected',lambda: corpus.validate_text(flower,actual[:-1]+'|]'), 'line separator mismatch')

source = '[Narration [lua(Variable["a]b"])] [future=alpha] <b>{name}</b> 12]'
target = '[Narración [lua(Variable["a]b"])] [future=alpha] <b>{name}</b> 12]'
same_controls(source,target,(0,))
passed('nested quoted Lua positive control', 'Only outer ordinary prose changes; nested/unknown controls, markup and braces remain exact')
for name,bad in [('nested Lua operand',target.replace('a]b','a]c')),
                 ('unknown command operand',target.replace('future=alpha','future=beta')),
                 ('markup',target.replace('<b>','<i>')),
                 ('placeholder',target.replace('{name}','{nombre}'))]:
    rejected(name,lambda bad=bad:same_controls(source,bad,(0,)), 'protected control mismatch')
rejected('unclassified ordinary bracket stays protected',lambda:same_controls('[Flower]','[Flor]'), 'protected control mismatch')
ram=corpus.BYID['ds:199:182:Dialogue Text']
ram_target=rows[ram['id']]['target']
corpus.validate_text(ram,ram_target)
rejected('portrait control mutation',lambda:corpus.validate_text(ram,ram_target.replace('[pic=2]','[pic=3]')), 'protected control mismatch')
for ident in ['ds:71:147:Dialogue Text','ds:458:340:Dialogue Text','ds:458:346:Dialogue Text']:
    r=corpus.BYID[ident]; corpus.validate_text(r,r['source'])
    assert rows[ident]['status']=='preserved-detached-source-provisional'
    passed(ident+' byte-exact technical preservation', 'Exact candidate retained; excluded from translated-wording coverage')
gossip=corpus.BYID['ds:71:147:Dialogue Text']
rejected('technical record cannot become translated label',lambda:corpus.validate_text(gossip,'COTILLEOS:'), 'technical source preservation mismatch')

baseline=json.loads((PHASE/'preservation-baseline.json').read_text())
old={r['id']:r for r in map(json.loads,(PHASE/'initial-overlay.jsonl').read_text().splitlines())}
assert len(old)==12235 and len(rows)==12246
assert all(rows[ident]==row for ident,row in old.items()), 'Previous target or metadata changed'
for path,digest in baseline.items():
    if '/batches/' in path or path.endswith('unchanged-reasons.json'):
        assert sha((ROOT/path).read_bytes())==digest, path
passed('all previous rows and TSV byte streams', '12235 complete records, 103 TSV files and original unchanged-reasons bytes preserved')

expected=overlay.read_bytes()
progress_path=corpus.OUT/'progress.json'; checkpoint=progress_path.read_bytes()
original_dump=corpus.dump
class InjectedOutputFailure(RuntimeError): pass

def fail_after_overlay(path,value):
    if path==HERE/'unresolved.json': raise InjectedOutputFailure('after overlay replace, before unresolved replace')
    original_dump(path,value)
corpus.dump=fail_after_overlay
try:
    try: corpus.build()
    except InjectedOutputFailure: pass
    else: raise AssertionError('failure injection did not run')
finally: corpus.dump=original_dump
assert overlay.read_bytes()==expected and progress_path.read_bytes()==checkpoint
passed('failure between generated writes', 'Overlay replaced before injected unresolved write failure; checkpoint untouched. Per-file atomic replacement, no multi-file transaction/rollback claim')
# Remove only rebuildable generated outputs, retaining expected bytes in memory and
# all authored inputs. The normal build must recover without reading these outputs.
overlay.unlink(); (HERE/'unresolved.json').unlink()
corpus.build()
assert overlay.read_bytes()==expected
assert json.loads((HERE/'unresolved.json').read_text())==[]
assert corpus.pins()==corpus.PINS
current=json.loads(progress_path.read_text())
assert current['coverageCounts']=={'translatedWording':10920,'reviewedUnchanged':1323,'technicalSourcePreservation':3,'totalSavedCandidates':12246,'pinnedCandidates':12246}
passed('normal rebuild from saved authored inputs', 'Exact full overlay recovered after generated outputs removed, all pins stable, zero holds and honest coverage partition')
report={'status':'passed','checks':checks,'checkedCount':len(checks),'overlaySha256':sha(expected),
        'adapterSha256':sha((HERE/'corpus.py').read_bytes()),'testScriptSha256':sha(Path(__file__).read_bytes()),
        'preservedPreviousTargets':len(old),'preservedPreviousBatchStreams':103,
        'candidateCount':len(rows),'physicalOccurrences':sum(len(r['occurrences']) for r in rows.values()),
        'scope':'Python adapter/source bindings/storage only; original consumer IL inspected separately. No game runtime, renderer, full semantic or independent review credited.'}
(PHASE/'adapter-tests.json').write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n')
print(json.dumps({'checks':len(checks),'status':'passed','preservedTargets':len(old),'coverage':current['coverageCounts']}))
