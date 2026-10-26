"""Compile/read back the bounded passive diagnostic delta; no game or images."""
import ast
import hashlib
import json
from pathlib import Path
import re
import subprocess

out=Path(__file__).resolve().parent
root=out.parents[3]
prior=root/'localization/source/tutorial-20261026/phase0061'
source=Path('/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest/The Forest of Love_Data/Managed')
inspector=root/'tools/probe/bin/Debug/net8.0/InspectMethods.dll'
readback=out/'compiled-readback'
assert not readback.exists(), 'Immutable readback already exists; inspect it, never overwrite'
sha=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
load=lambda p:json.loads(p.read_text())
def write(p,v):p.write_text(json.dumps(v,indent=2)+'\n')
def inspect(dll,typ,method):
 return subprocess.check_output(['dotnet',str(inspector),str(dll),typ,method],text=True)
def normalize(value):
 value=re.sub(r'(b__|<>9__)(\d+)(_)',r'\1N\3',value)
 value=re.sub(r'(<[A-Za-z0-9_]+>d__)(\d+)',r'\1N',value)
 return re.sub(r'(<>c__DisplayClass)(\d+)(_)',r'\1N\3',value)
def bodies(dll):
 result={}
 for typ in inspect(dll,'--types','').splitlines():
  names=sorted(set(re.findall(r'::([^:(]+)\(',inspect(dll,typ,'--list'))))
  if not names:continue
  for block in re.split(r'(?m)^METHOD ',inspect(dll,typ,','.join(names)))[1:]:
   key=normalize(block.split(' | ',1)[0]);assert key not in result
   result[key]='METHOD '+block
 return result
baseline=load(out/'baseline.json')
assert all(sha(Path(p))==h for p,h in baseline['all19Pins'].items())
assert sha(source/'Assembly-CSharp.dll')=='46f43b212709b96ac51f2484d1564f863346fed8dc70f532860046226a020acf'
refs=sorted(source.glob('*.dll'));assert len(refs)==150
old_refs=load(root/'localization/probes/ru-20261026-51/bridge-build.json')['originalManagedReferences']
assert {p.name:sha(p) for p in refs}==old_refs
readback.mkdir()
for n in ['ForestProbe.cs','diagnose_newgame.py']:(out/n).write_bytes((root/'tools/probe'/n).read_bytes())
compiler=Path(load(root/'localization/probes/ru-20261026-51/bridge-build.json')['compiler'])
modes={}
for mode in ['original','synthetic']:
 dll=out/f'ForestProbe.after.{mode}.dll'
 args=['dotnet',str(compiler),'-nologo','-target:library','-nostdlib+','-out:'+str(dll)]
 if mode=='synthetic':args+=['-define:SYNTHETIC_TUTORIAL_CHOICES']
 p=subprocess.run(args+['-r:'+str(p) for p in refs]+[str(out/'ForestProbe.cs')],capture_output=True,text=True)
 (out/f'{mode}-compile.txt').write_text(p.stdout+p.stderr);assert p.returncode==0
 before=bodies(prior/f'ForestProbe.after.{mode}.dll');after=bodies(dll)
 assert len(before)==83 and set(before)<=set(after)
 exact=[k for k in before if before[k]==after[k]]
 ordinal=[k for k in before if before[k]!=after[k] and normalize(before[k])==normalize(after[k])]
 changed=[k for k in before if normalize(before[k])!=normalize(after[k])]
 added=sorted(set(after)-set(before))
 assert set(changed)=={'System.Void ForestProbe::Awake()','System.Void ForestProbe::Update()',
                       'System.Void ForestProbe::OnDestroy()','System.Void ForestProbe::LateUpdate()'},changed
 assert added==['System.Void ForestProbe/LifecycleRow::.ctor()', 'System.Void ForestProbe::ObserveLifecycle(System.String)',
                 'System.Void ForestProbe::ObserveUnityQuitting()', 'System.Void ForestProbe::OnApplicationQuit()'],added
 new=after['System.Void ForestProbe::ObserveLifecycle(System.String)']
 for bad in ['Application::Quit(', '::CanTrigger(', '::HasAvailableMessages(', '::IsSatisfied(', '::TakeControl(',
             '::Fire(', '::PlayDialogue(', '::SetValue(', '::Invoke(', '::set_position(', '::set_velocity(', '::set_ignoreInput']:
  assert bad not in new,bad
 assert 'Application::add_wantsToQuit' not in ''.join(after.values())
 (readback/(mode+'.il')).write_text(''.join(after[k] for k in sorted(after)))
 for k in changed+added:
  ident=hashlib.sha256(k.encode()).hexdigest()[:16]
  (readback/(mode+'-'+ident+'.after.il')).write_text(after[k])
  if k in before:(readback/(mode+'-'+ident+'.before.il')).write_text(before[k])
 modes[mode]=dict(exact=exact,compilerOrdinalOnly=ordinal,changed=changed,added=added,
                  dllSha256=sha(dll),allBodiesSha256=sha(readback/(mode+'.il')))
# Undo exactly the diagnostic-only source insertions. Every original command,
# source getter/control/restore branch and original field must remain byte-equal.
old=(out/'ForestProbe.cs.before').read_text();new=(out/'ForestProbe.cs').read_text()
start=new.index('    private int lifecycleSequence;');end=new.index('    private bool? originalIgnoreUnfocused;',start)
new=new[:start]+new[end:]
for addition in ['        Application.quitting+=ObserveUnityQuitting;\n        ObserveLifecycle("awake");\n',
                 '            ObserveLifecycle("command-ack");\n', '            ObserveLifecycle("command-fail");\n',
                 '        } finally {\n            lifecycleCommand=null;\n',
                 '        ObserveLifecycle("destroy");\n        Application.quitting-=ObserveUnityQuitting;\n',
                 '        if(Time.realtimeSinceStartup>=nextLifecycleRecord) {\n            nextLifecycleRecord=Time.realtimeSinceStartup+1f;\n            ObserveLifecycle("heartbeat");\n        }\n']:
 assert new.count(addition)==1,addition
 new=new.replace(addition,'')
new=new.replace('        var text=File.ReadAllText(command).Trim();\n        lifecycleCommand=text;\n        ObserveLifecycle("command-read");\n        File.Delete(command);','        var text=File.ReadAllText(command).Trim();File.Delete(command);')
start=new.index('    // Passive, bounded append-only scalars.');end=new.index('    void RestoreInputPolicy()',start)
new=new[:start]+new[end:]
assert new==old,'Unexpected bridge source delta'
def definitions(p):return {n.name:ast.dump(n,include_attributes=False) for n in ast.parse(p.read_text()).body if isinstance(n,(ast.FunctionDef,ast.ClassDef))}
a=definitions(out/'diagnose_newgame.py.before');b=definitions(out/'diagnose_newgame.py')
assert [k for k in a if a[k]!=b.get(k)]==['observe_lifetime']
assert sorted(set(b)-set(a))==['numeric_identity_evidence','numeric_pid_snapshot']
guards=load(prior/'compiled-readback/comparison.json')['original14GuardsExact']
c=definitions(root/'localization/probes/ru-20261026-43/diagnose_newgame.py')
assert len(guards)==14 and all(b[n]==c[n] for n in guards)
assert a['ContinueObservationBudget']==b['ContinueObservationBudget'] and a['main']==b['main']
write(readback/'comparison.json',dict(status='passed-static-only',modes=modes,
 sourceDelta='Only bounded lifecycle logger and native PID/birth evidence; original bridge source exactly recovered by removing explicit additions',
 hostChanged=['observe_lifetime'],hostAdded=['numeric_identity_evidence','numeric_pid_snapshot'],
 original14GuardsExact=guards,defaultNewAndMainExact=True,ContinueObservationBudgetExact=True,
 originalManagedReferences=old_refs,compiler=str(compiler),compilerSha256=sha(compiler),inspectorSha256=sha(inspector),
 inputs={str(p.relative_to(root)):sha(p) for p in [out/'ForestProbe.cs.before',out/'ForestProbe.cs',out/'diagnose_newgame.py.before',out/'diagnose_newgame.py']},
 boundary='Compiled diagnostic delta; no Unity callbacks, new runtime, renderer or source acceptance'))
original=out/'original';original.mkdir()
dll=source/'Assembly-CSharp.dll'
queries=[('quit-calls.il','--find-call-fragment','Application::Quit'),
 ('QuitHelper.il','TheForestOfLove.QuitHelper','Quit'),
 ('MainMenuQuit.il','TheForestOfLove.MainMenuController','Quit'),
 ('PauseQuit.il','TheForestOfLove.PauseScreenUIManager','Quit'),
 ('DebugClearSavegame.il','TheForestOfLove.DebugHelper','DebugClearSavegame'),
 ('DevRoomUpdate.il','TheForestOfLove.DevTools.DevRoomController','Update'),
 ('DevConsoleQuit.il','TheForestOfLove.DevConsoleCommands/MiscCommands','Quit'),
 ('QuitHelper-callers.il','--find-call-fragment','QuitHelper::Quit')]
for filename,typ,method in queries:(original/filename).write_text(inspect(dll,typ,method))
assert len((original/'quit-calls.il').read_text().splitlines())==5
write(original/'extraction.json',dict(source=str(dll),sha256=sha(dll),inspectorSha256=sha(inspector),
 files={p.name:sha(p) for p in original.glob('*.il')},
 scope='Five static Application.Quit call instructions in four Assembly-CSharp methods; only static possible paths, no runtime invocation evidence. QuitHelper source leaves editor/standalone/Android guards intact.'))
print(json.dumps(dict(modes={m:{k:len(modes[m][k]) for k in ['exact','compilerOrdinalOnly','changed','added']} for m in modes},originalGuards=14,sourceQuitInstructions=5)))
