import json,hashlib,re,itertools
from pathlib import Path
root=Path('/Users/antonkrutov/Desktop/Forest');b=root/'localization/source/shared-source-completion-20261028/admission-v1';o=b/'phase134'
def h(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def vh(v):return hashlib.sha256(json.dumps(v,ensure_ascii=False,sort_keys=True,separators=(',',':')).encode()).hexdigest()
def save(p,v):p.write_text(json.dumps(v,ensure_ascii=False,indent=2)+'\n')
x=json.loads((b/'continuation-decisions.json').read_text())
# Finite authored offset maps for complete bodies actually read in phase134.
C='preserve-control';D='preserve-diagnostic';O='preserve-object-identity';K='preserve-database-or-control-key';F='preserve-control-grammar';S='preserve-display-symbol';V='comparison-on-display'
choices={
('keyboard-generate.il','Generate()'):{F:[0x109,0x118,0x1fa,0x21d,0x4b2],D:[0x27f,0x288,0x2e6,0x2fd,0x481],O:[0x2da,0x475],C:[0x6ec,0x6f9]},
('keyboard-generate.il','ShiftUp()'):{C:[0x11]},('keyboard-generate.il','ShiftDown()'):{C:[0x11]},
('key-click.il','Click()'):{C:[0xf]},('keyboard-callback.il','KeySpace()'):{S:[1]},('keyboard-callback.il','KeyShift()'):{C:[0x18,0x24]},
('conversation-key-consumers.il','ValidateInputs()'):{D:[0xe,0x26]},('conversation-key-consumers.il','StartConversation()'):{D:[7]},
('plant-label-producer.il','LabelsNormal()'):{'preserve-animation-key':[6,0x16,0x26]},('plant-label-producer.il','LabelsOozingAlert()'):{'preserve-animation-key':[6,0x16,0x26]},
('data-key-consumers.il','GetTagByDbName(System.String)'):{D:[0x23]},('data-key-consumers.il','GetActorByDbName(System.String)'):{D:[0x23]},('data-key-consumers.il','GetQuestByDbName(System.String)'):{D:[0x23]},('data-key-consumers.il','GetQuestProgressLogByDbName(System.String)'):{D:[0x23]},('key-terminal-consumers.il','GetDialogueByDbName(System.String)'):{D:[0x23]},
('haiku-handler.il','ExecuteTrigger(System.String)'):{
V:[0x27e,0x294,0x2aa,0x2d0,0x2e6,0x2fc,0x31f,0x335,0x34b],
K:[1,0x16,0x2b,0x40,0x55,0x6a,0xd7,0x142,0x18b,0x1d4,0x21d,0x2b7,0x309,0x358,0x365,0x390,0x39d,0x3aa,0x3da,0x416,0x42b,0x440,0x455,0x46a,0x47f,0x494,0x4a9,0x4be,0x4d3,0x52b,0x540,0x55d,0x56b,0x570,0x580,0x595,0x5aa,0x5bf,0x5d4,0x60e,0x648,0x682]},
('haiku-continuation.il','<ExecuteTrigger>b__2()'):{K:[0,10]},
('haiku-trigger-binding.il','AddConversationFireNamedTrigger(TheForestOfLove.Narrative.DataManifest,TheForestOfLove.Narrative.Dialogue,PixelCrushers.DialogueSystem.DialogueEntry)'):{K:[0x23],D:[0x51,0x5c,0x18e,0x199]},
('haiku-trigger-single.il','AddConversationFireNamedTrigger_Single(TheForestOfLove.Narrative.Dialogue,PixelCrushers.DialogueSystem.DialogueEntry,PixelCrushers.DialogueSystem.DialogueEntry,TheForestOfLove.Narrative.Arc,System.Boolean)'):{F:[0xc,0x29],D:[0x44],K:[0x89]},
('dialogue-key-selection.il','PlayDialogue(System.String,System.String)'):{K:[0x17,0x48],D:[0x57,0x5d,0xa2,0xa8,0x190,0x196,0x1b3,0x1b9,0x1dc,0x1e2]},
('story-playdialogue.il','PlayDialogue(TheForestOfLove.Narrative.QuestManagerInteractionMode,TheForestOfLove.DialogueSettings)'):{K:[0x93],D:[9,0x3a,0x12f,0x14e,0x15f,0x170,0x20f]}}
methods={}
for f in o.glob('*.il'):
 for line in f.read_text().splitlines():
  if line.startswith('METHOD '):methods[line[7:].split(' | attributes=')[0]]=f.name
rows=list(map(json.loads,(root/'outputs/pause-inventory-bio-completion-20261028/managed-index/literals.jsonl').open()))
selected=[];used=set()
for r in rows:
 if r['method'] not in methods:continue
 f=methods[r['method']];short=r['method'].split('::')[1];key=(f,short)
 assert key in choices,('unclassified-complete-body',key)
 mapping={off:role for role,offsets in choices[key].items() for off in offsets};assert len(mapping)==sum(map(len,choices[key].values()))
 assert r['offset'] in mapping,(key,r['offset']);used.add((key,r['offset']))
 role=mapping[r['offset']]
 selected.append(dict(method=r['method'],offset=r['offset'],sourceValueSha256=vh(r['value']),role=role,evidence=f,reason=('Case-folded selected display-text keyword decides the haiku ending; requires locale-independent identity adapter, not ordinary prose replacement.' if role==V else 'Exact argument/store/branch use read in the complete pinned original body; no inference for unread literals.')))
assert used=={(k,i) for k,v in choices.items() for offsets in v.values() for i in offsets}
x['exactMethodLiterals']=selected
x['evidence']={p.name:h(p) for p in sorted(o.glob('*.il'))}
save(b/'continuation-decisions.json',x)
# Complete source/control context for both literary episodes, with exact physical occurrences.
m=json.loads((root/'localization/source/dialogue-manifest.json').read_text());trees=[]
for p in m['sources']:
 path=root/p['tree'];assert h(path)==p['treeSha256'];trees.append(json.loads(path.read_text()))
assert trees[0]['conversations']==trees[1]['conversations']
frozen=list(map(json.loads,(root/'localization/source/dialogue-candidates.jsonl').open()));byid={r['id']:r for r in frozen};contexts=[]
for ci,c in enumerate(trees[0]['conversations']):
 if c['id'] not in [302,303]:continue
 for ei,e in enumerate(c['dialogueEntries']):
  fields=[]
  for fi,f in enumerate(e['fields']):
   logical=f"ds:{c['id']}:{e['id']}:{f['title']}";pointer=f'/conversations/{ci}/dialogueEntries/{ei}/fields/{fi}/value'
   physical=[s['object']+pointer for s in m['sources']]
   if logical in byid:assert (byid[logical]['source'],byid[logical]['occurrences'])==(f['value'],physical)
   fields.append(dict(title=f['title'],type=f['type'],value=f['value'],sourceValueSha256=vh(f['value']),occurrences=physical,translationId=logical if logical in byid else None))
  contexts.append(dict(conversationId=c['id'],entryId=e['id'],fields=fields,outgoingLinks=e['outgoingLinks'],conditionsString=e['conditionsString'],userScript=e['userScript'],onExecute=e['onExecute'],isRoot=e['isRoot'],isGroup=e['isGroup'],falseConditionAction=e['falseConditionAction'],conditionPriority=e['conditionPriority']))
save(o/'haiku-source-context.json',dict(schemaVersion=1,sources=m['sources'],frozenSourceSha256=h(root/'localization/source/dialogue-candidates.jsonl'),conversations=[302,303],nodes=contexts,boundary='All source text, typed fields, scripts, callback state and links of both episodes, including dormant source nodes. Canvas geometry is not a semantic dependency. No new translation IDs are invented for control fields.'))
# Authored line/ending contracts; expansion and all27 comparisons are deterministic checks only.
lines=[[325,410,406],[326,411,407],[327,412,408]]
triples=[dict(ids=[325,326,327],keywords=['molded','raging','friends'],arc='bridge_ending',namedEntry=320,feedbackEntry=460),dict(ids=[406,407,408],keywords=['lovely','high','gone'],arc='penny_ending',namedEntry=466,feedbackEntry=430),dict(ids=[410,411,412],keywords=['bug','important','work'],arc='bug_ending',namedEntry=467,feedbackEntry=438)]
def original_ending(values):
 for t in triples:
  if all(k in v.lower() for k,v in zip(t['keywords'],values)):return t['arc']
 return 'mixed_ending'
combos=[]
for choice in itertools.product(*lines):
 vals=[byid[f'ds:303:{i}:Dialogue Text']['source'] for i in choice];actual=original_ending(vals)
 expected=next((t['arc'] for t in triples if t['ids']==list(choice)),'mixed_ending');assert actual==expected
 # Synthetic replacement has no English keywords. It is NOT translated target wording.
 changed=[f'__synthetic_display_{i}__' for i in choice];after=original_ending(changed)
 combos.append(dict(ids=[f'ds:303:{i}:Dialogue Text' for i in choice],sourceEnding=actual,syntheticDisplayOnlyEnding=after,displayOnlyChangesOutcome=after!=actual))
assert len(combos)==27 and sum(r['displayOnlyChangesOutcome'] for r in combos)==3
case=dict(schemaVersion=1,id='haiku-group',sourceStatus='exact-static-dependencies-bound;locale-independent-adapter-required',contextArtifact='phase134/haiku-source-context.json',contextSha256=h(o/'haiku-source-context.json'),
sourceIds=[r['id'] for r in frozen if r['conversationId'] in [302,303]],sourceIdsReason='Both complete literary conversations: explanations, poems, choices, all named endings and shared feedback. Not all lines by these characters elsewhere.',
choiceSlots=[[f'ds:303:{i}:Dialogue Text' for i in slot] for slot in lines],branchContracts=triples,defaultBranch=dict(arc='mixed_ending',namedEntry=468,feedbackEntry=446),
triggerSuccessors=[dict(triggerEntry=n,successor=s,triggerName=tr) for n,s,tr in [(424,419,'oliver_coyotes_date2_haiku_start'),(425,404,'oliver_coyotes_date2_haiku_line1'),(426,413,'oliver_coyotes_date2_haiku_line2'),(427,416,'oliver_coyotes_date2_haiku_line3'),(423,422,'oliver_coyotes_date2_haiku_finish')]],
consumerFlow=['DialogueSystemLoader.AddArcPreconditionsAndTriggers recognizes TRIGGER Title grammar.','AddConversationFireNamedTrigger selects first outgoing target; Single constructs ArcTriggerFireNamedTrigger for successor entry ID, not the source control node.','ResponseOptionsUI.SelectResponseOption stores ResponseOption.get_text as lastSelectedResponseOptionText.','Dates.ExecuteTrigger copies selected text into haikuLine1/2/3 and calls SetHaikuLine1/2/3.','Finish lowercases selected text and checks three exact English keyword triples in ordered branches, defaulting to mixed_ending.','Continuation callback sets Dates_OliverCoyotes_Dialogue2, Oliver and selected arc through QuestConversationHelper; all are protected keys.'],
comparisonLiteralIds=[f"il:Assembly-CSharp.dll/System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerDates::ExecuteTrigger(System.String)/IL_{i:04x}" for i in [0x27e,0x294,0x2aa,0x2d0,0x2e6,0x2fc,0x31f,0x335,0x34b]],
originalPredicateReplay=combos,replayBoundary='Pure replay of read original predicate against frozen source options, all3x3x3 combinations. Does not execute the game, loader trigger priority, text renderer or reinsertion. Synthetic labels demonstrate a failure mechanism, not locale wording or implemented repair.',
adaptationContract='Carry original option/entry identity separately from localized display strings; choose the same3 named outcomes and24 mixed outcomes. Do not translate comparison literals in isolation or rely on substring occurrence in target wording. Actual runtime adapter and reviewed locale literary wording remain pending.',
sourceAnomalies=['Control TRIGGER nodes have no normal incoming links in the exported graph; the loader registers triggers on their first successor. Preserve both records rather than rewiring the source graph.','Stored/source poem explanations and disconnected alternative/debug labels are retained; static inventory does not prove that every node is reached.'],
pending=['Actual current arc membership/trigger priority and gameplay execution are not runtime-tested.','ResponseOption display getter/body dependency is retained from phase133 body57; no new independent semantic review is claimed.','Complete common dialogue inline grammar and other special-scene discovery remain pending.','All30 locale literary wording/adapters/editorial checks remain pending.'],runtime='not-run',visual='not-run',textures='unchanged')
# Verify exact stored graph contracts before writing the case.
nodes={(r['conversationId'],r['entryId']):r for r in contexts}
for t in case['triggerSuccessors']:
 n=nodes[303,t['triggerEntry']];assert next(f['value'] for f in n['fields'] if f['title']=='Title')=='TRIGGER('+t['triggerName']+')';assert n['outgoingLinks'][0]['destinationDialogueID']==t['successor']
for t in triples+[case['defaultBranch']]:
 n=nodes[303,t['namedEntry']];assert next(f['value'] for f in n['fields'] if f['title']=='Title')==t['arc']
save(o/'haiku-source-dependencies.json',case)
print(json.dumps(dict(exactManagedLiteralDecisions=len(selected),haikuSourceIds=len(case['sourceIds']),haikuNodes=len(contexts),allSourceCombinations=len(combos),demonstratedBrokenBranches=3)))
