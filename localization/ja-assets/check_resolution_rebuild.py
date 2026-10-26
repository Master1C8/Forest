"""Exercise partial-write recovery in an isolated fixture inside the permitted lane."""
import contextlib,hashlib,io,json,pathlib,shutil
import corpus
ROOT=pathlib.Path(__file__).resolve().parents[2]
HERE=pathlib.Path(__file__).resolve().parent
PHASE=ROOT/'outputs/locale-assets-20261026/ja/0031-translation'
FIXTURE=PHASE/'partial-write-fixture'
FIXTURE.mkdir(exist_ok=True)
assets=FIXTURE/'ja-assets';out=FIXTURE/'status'
assets.mkdir(exist_ok=True);out.mkdir(exist_ok=True)
# Authored batches are read through one symlink. No writes occur through it.
link=assets/'batches'
if link.exists():assert link.resolve()==HERE/'batches'
else:link.symlink_to(HERE/'batches',target_is_directory=True)
for name in ['unchanged-reasons.json']:
    shutil.copyfile(HERE/name,assets/name)
shutil.copyfile(ROOT/'outputs/locale-assets-20261026/ja/input-pins.json',out/'input-pins.json')
corpus.HERE=assets;corpus.OUT=out
real_dump=corpus.dump
before_marker={'fixture':'old unresolved from previous generation'}
real_dump(assets/'unresolved.json',before_marker)
progress_marker={'fixture':'old status from previous generation'}
real_dump(out/'progress.json',progress_marker)
def fail_between_writes(path,value):
    if path==assets/'unresolved.json':raise RuntimeError('injected after overlay replacement before unresolved replacement')
    real_dump(path,value)
corpus.dump=fail_between_writes
try:
    with contextlib.redirect_stdout(io.StringIO()):corpus.build()
except RuntimeError as e:
    assert str(e)=='injected after overlay replacement before unresolved replacement'
else:raise AssertionError('Fault not reached')
expected=(HERE/'dialogue.ja.jsonl').read_bytes()
assert (assets/'dialogue.ja.jsonl').read_bytes()==expected
assert json.loads((assets/'unresolved.json').read_text())==before_marker
assert json.loads((out/'progress.json').read_text())==progress_marker
corpus.dump=real_dump
with contextlib.redirect_stdout(io.StringIO()):corpus.build()
assert (assets/'dialogue.ja.jsonl').read_bytes()==expected
assert json.loads((assets/'unresolved.json').read_text())==json.loads((HERE/'unresolved.json').read_text())
assert json.loads((out/'progress.json').read_text())['retainedIds']==11062
first={str(p.relative_to(FIXTURE)):hashlib.sha256(p.read_bytes()).hexdigest() for p in [assets/'dialogue.ja.jsonl',assets/'unresolved.json',out/'progress.json',out/'continuation.md']}
with contextlib.redirect_stdout(io.StringIO()):corpus.build()
second={str(p.relative_to(FIXTURE)):hashlib.sha256(p.read_bytes()).hexdigest() for p in [assets/'dialogue.ja.jsonl',assets/'unresolved.json',out/'progress.json',out/'continuation.md']}
assert first==second
report={'status':'passed','boundary':'Real corpus output writer in an own-lane isolated fixture; pinned real source, saved batches and resolution receipts used. Runtime and engine reinsertion not exercised.',
        'fault':'Injected after overlay replacement and before unresolved replacement. Old unresolved/status remain; no transaction or rollback claimed.',
        'recovery':'First resumed build restores exact overlay, unresolved and status postconditions from saved authored batches/receipts.',
        'repeat':'A subsequent unchanged build preserves the same overlay, unresolved, status and continuation hashes after the first recovery postcondition was verified.',
        'artifactHashes':second}
(PHASE/'partial-write-recovery.json').write_text(json.dumps(report,indent=2)+'\n')
print(json.dumps({'partialWriteRecovery':'passed','repeatAfterVerifiedRecovery':'passed','retainedIds':11062}))
