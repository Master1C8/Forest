"""Compile both bridge modes and compare every body to verified phase0061."""
from pathlib import Path
import ast,hashlib,json,re,subprocess
root=Path('/Users/antonkrutov/Desktop/Forest');run=root/'localization/probes/ru-20261026-51'
prior=root/'localization/source/tutorial-20261026/phase0061'
assert not any((run/n).exists() for n in ['launch.json','wrapper-launch.json','observer-child.json','runtime-result.json','command.txt','compiled-readback']), 'Consumed/already inspected51: preserve exact evidence; never rebuild in place'
inspect=root/'tools/probe/bin/Debug/net8.0/InspectMethods.dll'
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def load(p):return json.loads(p.read_text())
def write(p,v):p.write_text(json.dumps(v,indent=2)+'\n')
bridge=load(run/'bridge-build.json');compiler=bridge['compiler']
refs=Path('/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest/The Forest of Love_Data/Managed')
args=['dotnet',compiler,'-nologo','-target:library','-nostdlib+','-define:SYNTHETIC_TUTORIAL_CHOICES','-out:'+str(run/'ForestProbe.synthetic-check.dll')]+['-r:'+str(p) for p in sorted(refs.glob('*.dll'))]+[str(run/'bridge-source/ForestProbe.cs')]
r=subprocess.run(args,capture_output=True,text=True);(run/'synthetic-compile.txt').write_text(r.stdout+r.stderr);assert r.returncode==0
out=run/'compiled-readback';out.mkdir()
def extract(dll,typename,method):return subprocess.check_output(['dotnet',str(inspect),str(dll),typename,method],text=True)
def bodies(dll):
 result={}
 for typ in extract(dll,'--types','').splitlines():
  names=sorted(set(re.findall(r'::([^:(]+)\(',extract(dll,typ,'--list'))))
  if not names:continue
  for block in re.split(r'(?m)^METHOD ',extract(dll,typ,','.join(names)))[1:]:
   key=block.split(' | ',1)[0];assert key not in result;result[key]='METHOD '+block
 return result
modes={}
for mode,filename in [('original','ForestProbe.dll'),('synthetic','ForestProbe.synthetic-check.dll')]:
 before=bodies(prior/f'ForestProbe.after.{mode}.dll');after=bodies(run/filename)
 assert before==after,[k for k in set(before)|set(after) if before.get(k)!=after.get(k)]
 (out/(mode+'.il')).write_text(''.join(after[k] for k in sorted(after)))
 modes[mode]=dict(methods=len(after),allExact=True,baselineSha256=sha(prior/f'ForestProbe.after.{mode}.dll'),candidateSha256=sha(run/filename),ilSha256=sha(out/(mode+'.il')))
def bodies_ast(p):return {n.name:ast.dump(n,include_attributes=False) for n in ast.parse(p.read_text()).body if isinstance(n,(ast.FunctionDef,ast.ClassDef))}
a=bodies_ast(run/'diagnose_newgame.py');b=bodies_ast(root/'localization/probes/ru-20261026-43/diagnose_newgame.py')
names=load(prior/'compiled-readback/comparison.json')['original14GuardsExact'];assert len(names)==14 and all(a[n]==b[n] for n in names)
assert sha(run/'diagnose_newgame.py')==sha(prior/'diagnose_newgame.py')==sha(root/'tools/probe/diagnose_newgame.py')
assert sha(run/'bridge-source/ForestProbe.cs')==sha(prior/'ForestProbe.cs')==sha(root/'tools/probe/ForestProbe.cs')
old=load(prior/'compiled-readback/comparison.json');assert old['defaultNewBranchExact'] and old['host']['ContinueObservationBudgetExact']
write(run/'bridge-verification.json',dict(status='passed-static-only',modes=modes,sourceSha256=sha(run/'bridge-source/ForestProbe.cs'),allBodiesExactPhase0061=True,phase0061ComparisonSha256=sha(prior/'compiled-readback/comparison.json'),inspectorSha256=sha(inspect),defaultNewBranchUnchanged=True,ContinueObservationBudgetExact=True,original14GuardsExact=names,boundary='Both fresh compiled modes every method exactly equals verified0061 IL; hook injector independently verifies original bodies/branches/locals/handlers. No runtime proof.'))
write(run/'guard-verification.json',dict(status='passed-static-only',all14OriginalGuards=names,defaultNewBranchUnchanged=True,ContinueObservationBudgetExact=True,phase0061HostExact=True,sourceSha256=sha(run/'diagnose_newgame.py')))
toolchain=load(root/'localization/probes/ru-20261026-50/toolchain-pins.json')
for k in ['passiveReadback','inspectorBuild']:toolchain.pop(k,None)
assert all(sha(Path(p))==h for group in ['csharpCompiler','swiftCompiler'] for p,h in toolchain[group].items())
toolchain.update(inspector=sha(inspect),nativeSourceSha256=sha(run/'target_keyboard.swift'),nativeBinarySha256=sha(run/'target_keyboard'),bridgeReadbackSha256=sha(run/'bridge-verification.json'),boundary='Current original/synthetic bridge IL and freshly compiled Swift; no native event')
write(run/'toolchain-pins.json',toolchain)
print(json.dumps(dict(modes=modes,originalGuards=len(names),defaultNewExact=True)))
