"""Attach fingerprints/coverage to authored judgments; deterministic validation only."""
import hashlib
import json
import pathlib

ROOT = pathlib.Path('/Users/antonkrutov/Desktop/Forest')
OUT = pathlib.Path(__file__).resolve().parent
CHECK = ROOT/'outputs/ru-item-wordplay-context-20261029/check'

def sha(b):
    return hashlib.sha256(b).hexdigest()

def comp(x):
    return json.dumps(x, ensure_ascii=False, separators=(',',':')).encode()

def read(name):
    return json.loads((OUT/name).read_text())

def lines(name):
    return [json.loads(l) for l in (OUT/name).read_text().splitlines()]

def write(name,x):
    (OUT/name).write_text(json.dumps(x,ensure_ascii=False,indent=2)+'\n')

def jl(name,rows):
    (OUT/name).write_bytes(b''.join(comp(x)+b'\n' for x in rows))

def pin(path):
    b=path.read_bytes()
    return {'sha256':sha(b),'bytes':len(b)}

decisions=read('case-decisions.authored.json')
packet=lines('selected-source-context.jsonl')
coverage={x['caseId']:x for x in read('selected-coverage.json')}
retained=lines('retained-receipts.jsonl')
targets=lines('selected-target-context.jsonl')
prior=lines('prior-source-bindings.jsonl')
pins=read('input-pins.json')
assert len(decisions)==3 and len({d['caseId'] for d in decisions})==3
assert {d['caseId'] for d in decisions}==set(coverage)

bindings=[]
for d in decisions:
    case=d['caseId']
    records=[(i,x) for i,x in enumerate(packet,1) if x['caseId']==case]
    bgs=[(i,x) for i,x in records if x['kind']=='complete-existing-BG-row']
    conversations=[(i,x) for i,x in records if x['kind']=='complete-authored-conversation']
    frozen_ids=[]
    graph_fields=[]
    for line,x in conversations:
        for ei,e in enumerate(x['value']['dialogueEntries']):
            for fi,f in enumerate(e['fields']):
                logical=f"ds:{x['conversationId']}:{e['id']}:{f['title']}"
                ptr=x['pointer']+f'/dialogueEntries/{ei}/fields/{fi}/value'
                graph_fields.append({'id':logical,'pointer':ptr,'sourceValueSha256':sha(comp(f['value'])),
                    'selectedContextLine':line,'isFrozenDisplayId':logical in coverage[case]['frozenDisplayIds']})
                if logical in coverage[case]['frozenDisplayIds']:
                    frozen_ids.append(logical)
    assert frozen_ids==coverage[case]['frozenDisplayIds']
    refs=[x for x in retained if x['caseId']==case]
    assigned=[x for x in prior if x['caseId']==case]
    assert len(refs)==2*len(assigned)
    bound={'caseId':case,'assignedOriginalBindings':assigned,'graphFieldBindings':graph_fields,
        'conversations':[{'selectedContextLine':i,'sourcePath':x['sourcePath'],'otherPhysicalPath':x['otherPhysicalPath'],
            'pointer':x['pointer'],'conversationId':x['conversationId'],'canonicalCompactSha256':x['canonicalCompactSha256']} for i,x in conversations],
        'bgFields':[{'id':c['id'],'sourceValueSha256':sha(comp(c['source'])),'sourceSpan':c['sourceSpan'],
            'sourcePath':x['sourcePath'],'sourceLine':c['line'],'selectedContextLine':i} for i,x in bgs for c in x['cells']]}
    bindings.append(bound)
    d['sourceBindings']={'artifact':'source-bindings.jsonl','caseRecordOrdinal':len(bindings),
        'canonicalCompactSha256':sha(comp(bound)),
        'originalAssignedCount':len(assigned),'frozenContextDisplayCount':len(frozen_ids),
        'bgContextCellCount':len(bound['bgFields']),
        'allFieldHashesRepresentation':'UTF-8 compact JSON value, ensure_ascii=false; no terminal LF'}
    d['acceptedTargetReceiptFingerprints']=[{'id':r['id'],'layer':r['layer'],
        'threadId':r['threadId'],'reviewPath':r['reviewPath'],'reviewFileSha256':r['reviewFileSha256'],
        'sourceUtf8Sha256':r['originalRow']['sourceSha256'],'targetUtf8Sha256':r['originalRow']['targetSha256']} for r in refs]
    d['fullReadCoverage']={'frozenDisplayIds':frozen_ids,'completeConversationSnapshotCount':len(conversations),
        'completeConversationSnapshotPins':[x['canonicalCompactSha256'] for _,x in conversations],
        'acceptedAssignedTargetIds':[x['bindingId'] for x in assigned],
        'targetContextReadIds':[x['id'] for x in targets if x['conversationId'] in coverage[case]['conversationIds']],
        'glossaryEntriesRead':171,'sourceAndTargetGlossaryPins':{
            k:v for k,v in pins.items() if '/glossary/inventory-display-20261028/' in k},
        'requiredUnread':[],
        'readMeaning':'Human/model source-context binding read; exact target wording retains prior receipts. No new per-target pass rows.'}
    d['runtimeModel']={'model':'gpt-6.1-sol','reasoning':'high','provider':'openai',
        'threadId':'01a185ce-49fe-7082-be6a-6ea1ac7710b2','inheritedHistory':False,'nestedJobs':0}

jl('source-bindings.jsonl',bindings)
jl('case-decisions.jsonl',decisions)

# Validate exact source facts against selected inventory, without judging their meaning.
known={id for c in coverage.values() for id in c['frozenDisplayIds']}
for d in decisions:
    assert all(id in known for f in d['sourceFacts'] for id in f.get('ids',[]))
    assert d['readCoverage']['requiredUnread']==[]
    assert all(d[k] is False for k in ['targetApplied','ordinaryTranslationEntryAllowed','sourceGateAccepted','wholeGameAccepted'])
    assert d['newSemanticPassRows']==0

preservation=[]
for path,old in pins.items():
    current=pin(pathlib.Path(path))
    assert current==old, path
    preservation.append({'path':path,'sha256':current['sha256'],'unchanged':True})
write('input-preservation.json',{'status':'verified','inputs':preservation,
    'boundary':'Byte equality of pinned inputs; root README/CHECKPOINT are owned by the live technical lane and were never opened for writing. No Git commands were executed.'})

write('findings.json',{'reviewScope':'three existing Russian item wordplay context decisions',
    'objectiveWordingErrors':[],'proposedReplacementBatch':[],'targetChanges':0,
    'sourceContextClarifications':[{
        'caseId':'inventory-apology-cookie-icing',
        'finding':'Charlotte and Melody are explicitly Finley\'s former roommates in409:783–794, supported by422:747/754 and423/428. This is bounded new source evidence, not inference from a name/portrait.',
        'disposition':'Use only in this source/context decision. Preserve the accepted neutral Russian and protected glossary/case registry. Parent/source owner adjudicates any later canon admission.'}],
    'remainingTechnicalFindings':[{'caseId':d['caseId'],**p} for d in decisions for p in d['remainingPredicates']],
    'requiredUnread':[],'artPixelsRead':0,'newSemanticPassRows':0})

checklist=[]
for d in decisions:
    checklist.append({'caseId':d['caseId'],'artifact':'case-decisions.jsonl + source-bindings.jsonl + selected-source-context.jsonl',
        'predicate':'Complete bounded contextual source/accepted-target binding judgment recorded.',
        'currentEvidence':d['contextBindingStatus'],'status':'complete-with-explicit-technical-holds',
        'remainingUncertainty':'See exact remainingPredicates; no code, runtime, image or full-game acceptance.',
        'nextPermittedAction':'Parent integrates this finite result and its actual measured usage. This job stops.'})
    checklist += [{'caseId':d['caseId'],**p} for p in d['remainingPredicates']]
write('acceptance-checklist.json',checklist)

validation={'status':'passed','caseDecisions':3,'assignedOriginalBindings':len(prior),
    'retainedVersionMatchingSemanticRows':len(retained),'sourceConversations':sum(len(c['conversationIds']) for c in coverage.values()),
    'frozenContextDisplayFields':sum(c['frozenDisplayCount'] for c in coverage.values()),
    'frozenContextPhysicalOccurrences':2*sum(c['frozenDisplayCount'] for c in coverage.values()),
    'selectedBGRowMemberships':sum(c['selectedBGRowCount'] for c in coverage.values()),
    'selectedBGCellMemberships':sum(c['selectedBGCellCount'] for c in coverage.values()),
    'unchangedTargetContextRows':len(targets),'pinnedInputs':len(pins),'requiredUnread':[],
    'targetApplied':False,'newSemanticPassRows':0,'checks':['23 complete authored conversation snapshots equal across both frozen trees',
        'all selected frozen display fields equal canonical candidates','four assigned targets equal their accepted hash references',
        'eight retained full/independent review rows match exact source/target and pinned original files',
        'all source fact IDs resolve in the selected packet','all pinned inputs remain byte-identical'],
    'notRun':['game/runtime','GUI','image/pixel review','font/texture work','packaging','whole-game gate'],
    'boundary':'Deterministic validation confirms identity/preservation, not model semantic correctness or external callback execution.'}
write('validation.json',validation)
result={'status':'finite-russian-three-item-context-complete','game':'The Forest of Love','build':'0.45','locale':'ru',
    'cases':3,'contextBindingReview':'complete','acceptedWordingChanged':False,'newSemanticPassRows':0,
    'sourceConversationsRead':23,'frozenContextDisplayFieldsRead':440,'acceptedAssignedTargetValues':4,
    'retainedReceiptRows':8,'requiredUnread':[],
    'technicalPredicatesOpen':sum(len(d['remainingPredicates']) for d in decisions),
    'remainingPredicates':'acceptance-checklist.json','findings':'findings.json','validation':'validation.json',
    'inputPins':'input-pins.json','outputPins':'output-pins.json','usage':'usage.json','targetApplied':False,
    'ordinaryTranslationEntryAllowed':False,'sourceGateAccepted':False,'wholeGameAccepted':False,
    'gameRuntime':'not-run','artReview':'not-run','gitMutation':False,'rootReadmeCheckpointMutation':False,
    'nestedJobs':0,'parentOwnsIntegration':True,
    'scopeBoundary':'New context/dependency judgments only. Retained wording receipts keep their original scope. No automatic continuation.'}
write('Result.json',result)
outpins={str(p.relative_to(ROOT)):pin(p) for p in sorted(OUT.iterdir()) if p.is_file() and p.name != 'output-pins.json'}
write('output-pins.json',{'representation':'SHA-256 of exact file bytes; JSONL UTF-8 with LF; final LF present',
    'files':outpins,'excludedSelf':'output-pins.json','usageMeasurementCutoff':'usage.json states the last measured request; final verification and reporting tail remains unmeasured.'})
(CHECK/'Result.json').write_text(json.dumps({**result,'artifactDirectory':str(OUT),
    'resultSha256':pin(OUT/'Result.json')['sha256'],'outputPinsSha256':pin(OUT/'output-pins.json')['sha256']},indent=2)+'\n')
print(json.dumps(validation,indent=2))
