import pathlib,json,hashlib,re,collections
ROOT=pathlib.Path('/Users/antonkrutov/Desktop/Forest');CHECK=ROOT/'outputs/ru-console62-case-wording-20261029/check';OUT=ROOT/'localization/supplemental-ui/20261029-console-case62';BASE=ROOT/'localization/source/shared-source-completion-20261028/admission-v1'
def sha(b):return hashlib.sha256(b).hexdigest()
def load(p):return json.loads(pathlib.Path(p).read_text())
def rows(p):return [json.loads(l) for l in pathlib.Path(p).read_text().splitlines()]
def write(p,v):p.write_text(json.dumps(v,ensure_ascii=False,indent=2)+'\n')
def jl(p,v):p.write_text(''.join(json.dumps(x,ensure_ascii=False,separators=(',',':'))+'\n' for x in v))
assert load(CHECK/'runtime-check.json')['status']=='verified-before-localized-content'
OUT.mkdir(exist_ok=True)
a=rows(CHECK/'assigned.jsonl');ctx=rows(CHECK/'context110.jsonl');assert len(a)==62 and len(ctx)==110
assert len({r['bindingId'] for r in ctx})==110
assert [r for r in ctx if r['currentRole']=='display-console-wording']==a
ledger=rows(BASE/'managed-literal-inventory.jsonl');dec=load(BASE/'phase139/compiled-role-decisions.json')['decisions'];dm={r['id']:r for r in dec};console=load(BASE/'compiled-console-source-context.json');gm={g['method']:g for g in console['groups']}
bodies={};bodyfiles={}
for p in sorted((BASE/'phase138').glob('game-*.il')):
 text=p.read_text()
 for m in re.finditer(r'^METHOD (.+?) \|[^\n]*\n(.*?)(?=^METHOD |\Z)',text,re.M|re.S):
  method=m[1];body=m[2];bodies[method]=body;bodyfiles[method]={'path':str(p.relative_to(ROOT)),'sha256':sha(p.read_bytes()),'startLine':text[:m.start()].count('\n')+1,'endLine':text[:m.end()].count('\n')}
def literal(method,offset):
 body=bodies[method];m=re.search(r'^IL_'+format(offset,'04x')+r': ldstr (.*?)(?=\nIL_|\nMETHOD |\Z)',body,re.M|re.S);assert m,(method,offset)
 return json.loads(m[1])
sc=[]
for r in ctx:
 t=ledger[r['typedLedger']['line']-1];d=dm[r['bindingId']];assert t['id']==r['bindingId'] and t['role']==r['currentRole'];assert t['sourceValueSha256']==r['sourceValueSha256']==sha(json.dumps(r['source'],ensure_ascii=False).encode());assert literal(t['method'],t['offset'])==r['source']
 g=gm[t['method']]
 sc.append({**r,'method':t['method'],'offset':t['offset'],'typedRecord':t,'sourceStage':{'decision':t['decision'],'application':t['application'],'priorRole':r['registryRole'],'sourceFindingStatus':'open; precise prior roles retained'},'phase139Decision':d,'producerBody':bodyfiles[t['method']],'assemblyGroup':g['key'],'assemblyContract':g['contract'],'consumerInstructions':g['consumerInstructions'],'conditionalOnly':True,'actualPresentationEligibility':'open','deliveryLogLevelAndNativeRendering':'not-run'})
jl(OUT/'source-context.jsonl',sc)
jl(OUT/'protected-controls.jsonl',[{'bindingId':r['bindingId'],'bindingOrdinal':r['bindingOrdinal'],'source':r['source'],'preservedValue':r['source'],'sourceValueSha256':r['sourceValueSha256'],'currentRole':r['currentRole'],'typedLedger':r['typedLedger']} for r in ctx if r['currentRole']!='display-console-wording'])
write(OUT/'source-findings.json',{'retained':console['retainedSourceFindings'],'additionalObservedContracts':[{'group':'TriggersCommands::Reset','fact':'LogWarning prefix is emitted even for a null lookup; no success predicate inferred.'},{'group':'TriggersCommands::Info','fact':'Null lookup leaves String.Empty status; no invented not-set or unknown status.'},{'group':'InventoryCommands::PlayerHas','fact':'Both true and false branches call LogError; truth is not inferred from severity.'},{'group':'DateCommands::Find','fact':'Original header says dialogues for the Date subset; retain dialogue wording.'}], 'reclassification':'open; no prior role edits'})
extras=[]
for d in load(BASE/'phase138/compiled-role-decisions.json')['decisions']:
 if d['contract'] not in ['command-namespace-input-and-suggestion','simulation-scene-state-and-label']:continue
 value=literal(d['method'],d['offset']);assert sha(json.dumps(value,ensure_ascii=False).encode())==d['sourceValueSha256']
 extras.append({'bindingId':d['id'],'source':value,'preservedValue':value,'sourceValueSha256':d['sourceValueSha256'],'role':d['role'],'contract':d['contract'],'producerBody':bodyfiles[d['method']]})
assert collections.Counter(x['contract'] for x in extras)=={'command-namespace-input-and-suggestion':103,'simulation-scene-state-and-label':17}
jl(OUT/'protected-external-identities.jsonl',extras)
refs=['/Users/antonkrutov/.codex/instructions/sitefor-mods.md','/Users/antonkrutov/.codex/instructions/game-localization-prompt.md','/Users/antonkrutov/.codex/instructions/game-localization-audit-workflow.md']+[str(pathlib.Path('/Users/antonkrutov/.codex/skills/vn-game-localize/references')/(n+'.md')) for n in ['COMMON','WORKFLOW','CHECKPOINT','SPECIAL-SCENES','CHARACTERS','ROUTING']]
write(OUT/'process-binding.json',{'game':'The Forest of Love','version':'0.45','locale':'ru','type':'standard','stage':'translate-edit: bounded special-case preparation only','canonicalProcessBinding':load(ROOT/'CHECKPOINT.json')['processBinding'],'references':{p:sha(pathlib.Path(p).read_bytes()) for p in refs},'independentReview':'pending','ordinaryTranslationEntryAllowed':False,'sourceGateAccepted':False,'wholeGameAccepted':False,'rootStatusWrites':'prohibited; technical lane owns README/CHECKPOINT','runtime':'not-run; parent owns integration'})
paths=[CHECK/'brief.md',CHECK/'dispatch.json',CHECK/'runtime-verification.json',CHECK/'runtime-check.json',CHECK/'assigned.jsonl',CHECK/'context110.jsonl',BASE/'phase139/compiled-role-decisions.json',BASE/'compiled-console-source-context.json',BASE/'phase138/compiled-role-decisions.json',BASE/'phase144/compiled-role-decisions.json',BASE/'phase144/producer-bodies.jsonl',BASE/'phase144/receiver-bodies.jsonl']+[ROOT/'localization/glossary/inventory-display-20261028'/n for n in ['en.json','ru.json','handoff.json']]+[ROOT/p['path'] for p in bodyfiles.values() if any(x['producerBody']['path']==p['path'] for x in sc+extras)]+[BASE/'phase138'/n for n in ['console-contract.il','console-entry.il']]+[BASE/'phase139'/n for n in ['stats-entry.il','stats-field-uses.il','stats-input-producers.il']]
pins={str(p.relative_to(ROOT)):sha(p.read_bytes()) for p in paths}
write(OUT/'input-pins.json',{'files':pins,'typedLedgerFileAtReadSha256':sha((BASE/'managed-literal-inventory.jsonl').read_bytes()),'typedLedgerVerification':'All110 exact 1-based rows; unrelated parent additions do not change applicability.','glossaryEntries':171,'glossaryRead':'complete paired en/ru 1-86 and87-171; handoff read and bound','version':'0.45','sourceLocale':'en','targetLocale':'ru','previousAcceptedTargets':0,'frozenDialogueExpectedSha256':'462c91c948c3564225aeaf71da972c7426e5b5c068eaca7bab64e22e70e36587','frozenDialogueAction':'not read or changed; outside this packet'})
write(CHECK/'context-preparation.json',{'context':110,'assigned':62,'protected':48,'assemblies':len(gm),'assignedAssemblies':len({r['method'] for r in sc if r['currentRole']=='display-console-wording'}),'protectedExternal':len(extras),'reusedFullBodies':32,'newIL':0,'sourceExtractionRerun':False})
print('Prepared110 context bindings,62 assigned,48 protected,32 whole producer methods;103 command namespaces and17 scene identities pinned.')
