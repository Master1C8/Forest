"""Read back exact prepared bridge bodies; no gameplay or image access."""
import ast
import hashlib
import json
from pathlib import Path
import re
import subprocess

out=Path(__file__).resolve().parent
root=out.parents[3]
inspector=root/'tools/probe/bin/Debug/net8.0/InspectMethods.dll'
readback=out/'compiled-readback';readback.mkdir(exist_ok=True)

def inspect(dll,typename,method):
    return subprocess.check_output(['dotnet',str(inspector),str(dll),typename,method],text=True)

def normalize(value):
    value=re.sub(r'(b__|<>9__)(\d+)(_)',r'\1N\3',value)
    value=re.sub(r'(<[A-Za-z0-9_]+>d__)(\d+)',r'\1N',value)
    return re.sub(r'(<>c__DisplayClass)(\d+)(_)',r'\1N\3',value)

def bodies(dll):
    result={}
    for typename in inspect(dll,'--types','').splitlines():
        names=sorted(set(re.findall(r'::([^:(]+)\(',inspect(dll,typename,'--list'))))
        if not names:continue
        for block in re.split(r'(?m)^METHOD ',inspect(dll,typename,','.join(names)))[1:]:
            key=normalize(block.split(' | ',1)[0])
            assert key not in result,('ambiguous normalized signature',key)
            result[key]='METHOD '+block
    return result

summary={}
for mode in ['original','synthetic']:
    before,after=(bodies(out/f'ForestProbe.{version}.{mode}.dll') for version in ['before','after'])
    exact=[];ordinal=[];changed=[]
    assert set(before)<=set(after),'Missing original bridge bodies'
    for key,old in before.items():
        new=after[key]
        if new==old:exact.append(key)
        elif normalize(new)==normalize(old):ordinal.append(key)
        else:changed.append(key)
        if old!=new:
            name=hashlib.sha256(key.encode()).hexdigest()[:16]
            for version,value in [('before',old),('after',new)]:(readback/(mode+'-'+name+'.'+version+'.il')).write_text(value)
    added=sorted(set(after)-set(before))
    assert changed==['System.Void ForestProbe::Update()'],changed
    assert added==['System.String[] ForestProbe::BuckyApproachDiagnostics()'],added
    new=after[added[0]]
    for forbidden in ['::CanTrigger(', '::HasAvailableMessages(', '::IsSatisfied(', '::TakeControl(',
            '::Fire(', '::PlayDialogue(', '::SetValue(', '::Invoke(', '::set_position(', '::set_velocity(']:
        assert forbidden not in new,forbidden
    (readback/(mode+'-BuckyApproachDiagnostics.il')).write_text(new)
    summary[mode]=dict(exact=exact,compilerOrdinalOnly=ordinal,changed=changed,added=added,newReaderActionCallsAbsent=True)

old=(out/'ForestProbe.cs.before').read_text();new=(out/'ForestProbe.cs').read_text()
start='    void Update() {';end='    void RestoreInputPolicy()'
segment=lambda value:value.split(start,1)[1].split(end,1)[0]
assert segment(new).replace('diagnostics=BuckyApproachDiagnostics()','diagnostics=BuckyInteractionDiagnostics()')==segment(old)
summary['oldCommandsExactExceptBuckySnapshotReader']=True

def definitions(path):
    return {n.name:ast.dump(n,include_attributes=False) for n in ast.parse(path.read_text()).body if isinstance(n,(ast.FunctionDef,ast.ClassDef))}

a,b=definitions(out/'diagnose_newgame.py.before'),definitions(out/'diagnose_newgame.py')
changed=sorted(k for k in a if a[k]!=b.get(k))
assert changed==['continue_from_fixture','launch_options','main'],changed
assert a['ContinueObservationBudget']==b['ContinueObservationBudget']
summary['host']=dict(exact=sorted(k for k in a if a[k]==b.get(k)),changed=changed,added=sorted(set(b)-set(a)),ContinueObservationBudgetExact=True)
names=json.loads((root/'localization/source/focus-transition-20261026/verification.json').read_text())['unchangedGuardBodies']
original=definitions(root/'localization/probes/ru-20261026-43/diagnose_newgame.py')
assert len(names)==14 and all(original[k]==b[k] for k in names)
summary['original14GuardsExact']=names
old=(out/'diagnose_newgame.py.before').read_text();new=(out/'diagnose_newgame.py').read_text()
start="            assert 'Canvas/PlayMenu/Controls/New' in state['buttons']"
end="            print('Original intro completed in', state['scene'], guards, flush=True)"
assert old.split(start,1)[1].split(end,1)[0]==new.split(start,1)[1].split(end,1)[0]
summary['defaultNewBranchExact']=True
summary['baselineHead']=json.loads((out/'baseline.json').read_text())['head']
summary['inputs']={str(p.relative_to(root)):hashlib.sha256(p.read_bytes()).hexdigest() for p in [
    out/'ForestProbe.cs.before',out/'ForestProbe.cs',out/'diagnose_newgame.py.before',out/'diagnose_newgame.py',
    out/'ForestProbe.before.original.dll',out/'ForestProbe.after.original.dll',out/'ForestProbe.before.synthetic.dll',out/'ForestProbe.after.synthetic.dll']}
(readback/'comparison.json').write_text(json.dumps(summary,indent=2)+'\n')
print(json.dumps(dict(modes={m:{k:len(summary[m][k]) for k in ['exact','compilerOrdinalOnly','changed','added']} for m in ['original','synthetic']},hostUnchanged=len(summary['host']['exact']),originalGuards=len(names))))
