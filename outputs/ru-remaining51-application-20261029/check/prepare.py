import pathlib,json,hashlib,subprocess,shutil
R=pathlib.Path('/Users/antonkrutov/Desktop/Forest'); C=R/'outputs/ru-remaining51-application-20261029/check'; S=R/'localization/source/remaining51-application-20261029';P=R/'localization/supplemental-ui/20261029-remaining-case51'
sha=lambda p:hashlib.sha256(pathlib.Path(p).read_bytes()).hexdigest()
write=lambda p,v:pathlib.Path(p).write_text(json.dumps(v,ensure_ascii=False,indent=2)+'\n')
ps=subprocess.check_output(['ps','-axo','pid,ppid,command'],text=True)
# Commands of this observer are not builder readers; only actual Python/build commands count.
live=[x for x in ps.splitlines() if 'build_russian_preview.py' in x and ('/python' in x or 'python3 -B /' in x)];assert not live,live
lsof=subprocess.run(['lsof','-t',str(R/'tools/build_russian_preview.py')],capture_output=True,text=True)
assert not lsof.stdout.strip()
write(C/'builder-live-read-check.json',{'liveReaders':live,'lsofExit':lsof.returncode,'builderSha256':sha(R/'tools/build_russian_preview.py'),'parentRuntime':'immutable frozenv3 plus candidate02 per dispatch; not modified'})
shutil.copy2(R/'tools/build_russian_preview.py',C/'build_russian_preview.before.py')
write(C/'protected-root-pins.json',{n:sha(R/n) for n in ['README.md','CHECKPOINT.json']})
S.mkdir(exist_ok=False)
a=json.loads((P/'ru.acceptance.json').read_text()); pins=dict(a['evidence']);pins.update(json.loads((P/'input-pins.json').read_text()))
for n in ['ru.acceptance.json','source-application-admission.json','producer-evidence.jsonl']:pins[str((P/n).relative_to(R))]=sha(P/n)
for n in ['tools/russian_actor_names.py','localization/source/bgdatabase-20261027/decode_inventory.py','localization/source/bgdatabase-complete-values-20261027/frozen_independent_reader.py','assets/source-v2/text-assets/90744c19ec-resources.assets-320.bin']:pins[n]=sha(R/n)
for n,h in pins.items():assert sha(R/n)==h,n
write(S/'input-pins.json',pins)
s=[json.loads(x) for x in (P/'source-context.jsonl').read_text().splitlines()];t=[json.loads(x) for x in (P/'ru.prepared.jsonl').read_text().splitlines()]
mp=[]
for x,y in zip(s,t):
 assert x['id']==y['id']
 r={k:y[k] for k in ['id','ordinal','source','target','sourceUtf8Sha256','targetUtf8Sha256','sourceValueSha256']}
 r['alreadyApplied']=bool(y['reusedEvidence'])
 if x['id'].startswith('il:'):r.update(method=x['originalLiteral']['method'],offset=x['originalLiteral']['offset'],instructionIndex=x['originalLiteral']['index'])
 else:r.update(sheetId=x['id'].split('/sheet/')[1].split('/')[0],fieldId='HiklKG8OqUO1pxWl3D3PlA',rowId=x['rowId'],rowIndex=x['rowIndex'],sourceSpan=x['sourceSpan'])
 mp.append(r)
write(S/'mapping.json',{'locale':'ru','rows':mp,'newBG':17,'newCompiled':31,'retainedCompiled':3})
write(S/'contract-pins.json',{n:sha(S/n) for n in ['input-pins.json','mapping.json']})
print('prepared contract',sha(S/'mapping.json'))
