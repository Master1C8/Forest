"""Behavioral guards for held source dispositions and bracket display validation."""
import argparse,copy,json,pathlib,sys
from resolution_support import topology,verify_record,validate_text,scan_controls,apply_resolutions
ROOT=pathlib.Path(__file__).resolve().parents[2]
HERE=pathlib.Path(__file__).resolve().parent
PHASE=ROOT/'outputs/locale-assets-20261026/ja/0031-translation'
parser=argparse.ArgumentParser(description=__doc__)
parser.add_argument('--output',type=pathlib.Path,required=True,help='New guard receipt in the current Japanese phase; historical evidence is immutable')
args=parser.parse_args()
output=args.output.resolve()
assert output.is_relative_to(ROOT/'outputs/locale-assets-20261026/ja'), 'Guard evidence outside own output lane'
assert not output.exists(), 'Existing guard evidence is immutable'
receipt=json.loads((HERE/'resolutions/0031-source-bound.json').read_text())
facts={r['id']:r for r in json.loads((PHASE/'source-facts.json').read_text())['records']}
proofs={r['id']:r for r in json.loads((PHASE/'source-topology.json').read_text())['records']}
rows={r['id']:r for r in map(json.loads,(ROOT/'localization/source/dialogue-candidates.jsonl').read_text().splitlines())}
man=json.loads((ROOT/'localization/source/dialogue-manifest.json').read_text())
trees=[json.loads((ROOT/s['tree']).read_text()) for s in man['sources']]
topo=topology(trees)
checks=[]
def passed(name):checks.append({'check':name,'status':'passed'})
def reject(name,reason,fn):
    try:fn()
    except AssertionError as e:
        assert reason in str(e),(name,str(e))
        passed(name)
    else:raise AssertionError('Expected rejection: '+name)
def verify(record,topo_arg=topo):
    ident=record['id'];verify_record(record,rows[ident],record['originalHoldReason'],facts[ident],proofs[ident],topo_arg)
for r in receipt['records']:verify(r)
passed('All 405 actual records satisfy source, pointer, occurrence, target, hold and topology bindings')
flower=next(r for r in receipt['records'] if r['disposition']=='translatable-bracketed-display')
detached=next(r for r in receipt['records'] if r['disposition']=='preserved-detached-source')
for name,field,value,reason in [
 ('Changed source hash','sourceSha256','0'*64,'source hash'),
 ('Changed source pointer','pointer','/conversations/0','pointer'),
 ('Dropped physical occurrence','occurrences',flower['occurrences'][:1],'occurrence'),
 ('Changed target hash','targetSha256','0'*64,'target hash'),
 ('Unapproved display bracket ordinal','ordinaryBracketOrdinals',[1],'bracket decision')]:
    bad=copy.deepcopy(flower);bad[field]=value
    reject(name,reason,lambda bad=bad:verify(bad))
bad=copy.deepcopy(detached);bad['target']+='x'
from resolution_support import sha
bad['targetSha256']=sha(bad['target'].encode())
reject('Source preservation cannot change wording even with matching target hash','Preserved source changed',lambda:verify(bad))
# Prove the negative reaches the topology guard, rather than a stale snapshot guard.
key=(rows[detached['id']]['conversationId'],rows[detached['id']]['entryId'])
changed_topo=list(topo);changed_topo[3]=topo[3]|{key}
proof=copy.deepcopy(proofs[detached['id']]);proof['reachableFromConservativeRoots']=True
reject('A newly reachable candidate cannot be retained as detached','Detached resolution is reachable',lambda:verify_record(detached,rows[detached['id']],detached['originalHoldReason'],facts[detached['id']],proof,changed_topo))
source='[ordinary [lua(Variable["seed"])] <b>1</b> {name} [mystery=a]]'
target='[test [lua(Variable["seed"])] <b>1</b> {name} [mystery=a]]'
validate_text(source,target,[0]);passed('Approved display body allows prose while preserving nested Lua, rich text, number, placeholder and unknown bracket')
for name,new,reason in [
 ('Nested Lua operand change',target.replace('seed','seeds'),'controls'),
 ('Unknown nested bracket change',target.replace('mystery=a','mystery=b'),'controls'),
 ('Rich-text tag change',target.replace('<b>','<i>'),'controls'),
 ('Placeholder change',target.replace('{name}','{other}'),'controls'),
 ('Number changed within display prose',target.replace('>1<','>2<'),'Numeric'),
 ('Display separator injected',target+'|','separator')]:
    reject(name,reason,lambda new=new:validate_text(source,new,[0]))
reject('Unapproved bracket body remains opaque','controls',lambda:validate_text('[ordinary]','[changed]'))
reject('Known engine tag cannot become ordinary prose','Engine tag',lambda:scan_controls('[lua(x)]',[0]))
validate_text(flower['target'],flower['target'],[0]);passed('Exact Japanese outer display brackets accepted')
reject('Digits added inside actual flower prose','Numeric',lambda:validate_text(rows[flower['id']]['source'],flower['target'][:-1]+'123]',[0]))
reject('Lost display delimiter rejected','Unbalanced bracket',lambda:validate_text(rows[flower['id']]['source'],flower['target'][:-1],[0]))
# Actual apply layer: every current receipt, with a matching overwrite rejection.
# The earlier flower fixture remains unchanged; later groups extend the real apply input.
all_records=[r for p in sorted((HERE/'resolutions').glob('*.json')) for r in json.loads(p.read_text())['records']]
held={r['id']:r['originalHoldReason'] for r in all_records};targets={}
assert len(held)==len(all_records), 'Repeated resolution ID across receipts'
assert len(apply_resolutions(targets,held,rows,trees))==len(all_records) and not held
assert set(targets)=={r['id'] for r in all_records}
assert all(targets[r['id']]['target']==r['target'] for r in all_records)
passed('Apply resolves exactly '+str(len(all_records))+' pre-existing holds from all current receipts')
reject('Existing saved target cannot be overwritten','existing held ID',lambda:apply_resolutions({flower['id']:{'target':'saved'}},{r['id']:r['originalHoldReason'] for r in all_records},rows,trees))
result={'status':'passed','checks':checks,'count':len(checks),'boundary':'Own-lane deterministic resolution adapter and static graph. No replaced runtime/renderer behavior is credited.'}
output.write_text(json.dumps(result,ensure_ascii=False,indent=2)+'\n')
print(json.dumps({'status':'passed','checks':len(checks)}))
