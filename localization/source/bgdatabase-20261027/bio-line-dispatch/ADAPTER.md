# Phase0078: implicit and dynamic original line-end callers

The Forest of Love0.45, Russian technical lane, static text-only evidence.
`execution-model.json` records actual gpt-6.1-sol/high/OpenAI argv. Parent alone
owns Git/index/HEAD. Parallel locale assets/editorial work and the separate Russian
preview remain independent and untouched. No images, game/GUI interaction, assembly
execution, nested CLI/model jobs, authored translation or source repair occurred.

## Implicit line-end at line begin

`Handler_OnConversationLineBegin` calls HandleDialogueLineTriggering BEFORE
HandleDialogueLineActor. The triggering method checks the subtitle entry ActorID
(the exact Actor field via LookupInt). If positive, and Subtitle.sequence is null
or its ToLower result does not contain `none`, it resolves the manifest actor by
plugin ID and calls CheckIfActorChanged. That method returns false for null or
unchanged plugin actor ID; otherwise it records the new plugin ID, invokes
onConversationLineCurrentActorChanged and returns true. Only a true result sets
encounteredSpokenLineInCurrentDialogue. No CurrentActor setter occurs in that step.

If that latch remains false, HandleDialogueLineTriggering invokes the subtitle
line-end handler immediately. Under its existing CurrentDialogue guard, that emits
onDialogueLineArcTriggerCheck with CURRENT Dialogue/Arc and the ORIGINAL subtitle
conversation/entry IDs. It precedes HandleDialogueLineActor and therefore may precede
the later CurrentActor update. The accompanying actor/text line-end event need not
describe the subtitle's actor. Do not use its actor argument as BIO target identity.
BIO still depends on the registered exact arc/IDs and the phase77 execution/action
guards; the triggering method neither calls ForceExecute nor bypasses them.

`Initialize` resets the latch to false and lastCurrentLineDialogueDbConversantId to
-1. The only original assembly references to these fields are pinned in the two
state-use searches. Initialize is called from Start, conversation end and cancel.
End/cancel invoke callbacks BEFORE initialization; callback exceptions can prevent
the later reset. Once set true, the latch is not reset by a linked-conversation
callback in this body set. A missing actor can leave it false. Actual callbacks,
reentrancy and field mutation are not modeled as guaranteed successful execution.

HandleDialogueLineActor separately suppresses sequences containing `none`, `delay`
OR `continue`. HandleDialogueLineTriggering suppresses only the actor-change check
for `none`. A Delay/Continue sequence therefore does not establish an implicit
line-end: a resolved changed actor can first set the latch. This is substring
matching, not a parser of exact sequence commands. The Python controls use ASCII
synthetic inputs; .NET culture-sensitive ToLower is not certified equivalent for
arbitrary Unicode. Original Subtitle.sequence construction/defaults/overrides remain
pending. Entry Sequence values in target contexts are source evidence, not actual
constructed Subtitle.sequence or evidence of first spoken/playable lines.

## Dynamic construction and preplayed first nodes

BuildDynamicConversation obtains the first active conversation and the default
database. It returns when the controller reports no active conversation; a missing
controller is not checked before callvirt. It looks up exact original conversation
`system/dynamicConversation`, entries PASSTHROUGH/DYNAMICROOT/DYNAMICQUESTIONS/
GENERICFAREWELL, and clears the root/question outgoing links. The frozen templates
resolve to conversation109, entries5/8/10/9 in both copies. Nine exact
`system/dynamicQuestions/<plugin actor name>` conversations each select the first
entry whose Title equals START. The selected source fields/links remain exact.

Question-menu mode links DYNAMICROOT to the actor-specific question conversation,
and DYNAMICQUESTIONS to each cached arc's ORIGINAL first node plus the farewell.
This branch has no direct preplayed line-end. It does not prove which question
will be displayed, interpreted, selected or reached.

The other branch iterates every supplied cached arc. With skipPlayerQuestion=false,
it links DYNAMICROOT directly to the original first entry. With true, it resolves
that original conversation/first entry, substitutes pluginDbFirstPlayerQuestionDialogueEntry
when nonnull, then compares the FIRST and QUESTION OBJECT REFERENCES. If unequal,
including a null question reference, it calls the integer line-end overload with
the ORIGINAL FIRST entry's conversationID/id/subtitleText. This occurs before
the subsequent question actor lookup and first outgoing-link access. Thus a later
lookup/link error cannot retroactively erase a completed earlier event.

For a selected question whose actor Name is exactly `player`, the first outgoing
link's destinationDialogueID becomes the dynamic destination, looked up in the
ORIGINAL conversation. destinationConversationID is ignored here. Otherwise the
dynamic destination remains the original first entry, even if it was preplayed.
This can produce another later callback; phase77's normal executed flag remains a
separate deduplication boundary. The builder never assigns CurrentDialogue/Arc
from its loop variable. Every synthetic event carries the service's current
context, which can differ from the cached arc. Finally it forces the next model
state toward PASSTHROUGH; neither event emission nor link construction proves
successful model transition, visible text or player action.

`get_subtitleText` chooses nonempty currentDialogueText, otherwise currentMenuText.
Those use GetCurrentDialogueTextField/GetCurrentMenuTextField and FieldValue.
Localization/fallback field selection behind those helpers remains pending;
the exact original source candidates are retained without claiming display output.

## Caller gates and the complete original BIO cross-check

The assembly-wide caller search finds only PlayDialogue(string,string) and
PlayDialoguePlayerQuestion(string). PlayDialogue sets CurrentDialogue and its
selected original arc, actors, then Fire() before calling the builder. Missing
registry Dialogue follows a separate branch setting CurrentDialogue/Arc null
and never calls the builder. A blank arc argument selects first PRIMARY, else
IDLE, else NAMED. A nonblank argument searches exact customName in named arcs,
then exact generatedName. The generated fallback dereferences pluginDbSuffix
before its later null check; this possible failure is preserved, not repaired.

skipPlayerQuestion is true only for DialogueType.Gossip(400), with either a blank
arc argument or a generated-name fallback whose ORIGINAL suffix equals `p1`,
and DevCommandActive false. An exact named customName does not set it.
PlayDialoguePlayerQuestion sets CurrentArc null and calls question-menu mode with
skip=false. Its later linked callback can rebind the selected Dialogue to its first
primary arc; it does not itself preplay a node or prove UI selection. Fire(), event
listeners, cache contents and reentrant mutations remain unaccepted dependencies.

The seven original DialogueType.enum_type int32 cells (28 bytes) were decoded with
the existing framing/fixed codec, reencoded exactly, and bound to two generated
BGIds, the exact enum configuration and shipped StoredValueToEnum/ToObject. No
other type-sheet columns are decoded. This is a narrow control dependency, not
new display text. All600 registry type relations resolve to these seven rows.

`readback-v2/dynamic-arcs.json` binds all1103 original arcs to both skip branches,
question actors/first links, type cells and default/custom/generated-name rules.
No original skip-true simulation encounters a missing local target or link.
`target-line-contexts.json` retains all126 BIO registrations and their actual
target entry fields/conditions/scripts/links/candidate bindings and prior category
outcomes. Target owning types:47 Quest,15 Date,60 Gossip,2 FinalIdle,2 Manual.

Four registrations match their OWN arc's preplayed first node. Searching EVERY
original cached first-node possibility additionally retains the second108:118
registration: its i2-newline arc can match a first node from i1. The five
registration matches are108:118(i1 and i2-newline),92:132,299:1006 and440:1002.
All have non-Gossip owning types. None of the60 Gossip BIO registrations matches
ANY original cached first node. Therefore under unchanged original objects/types,
the two identified caller parameter rules, stable current context and successful
nonreentrant callbacks, this builder's direct preplay cannot satisfy an original
BIO node+owning-Dialogue+arc check. This excludes neither begin-time implicit
checks nor normal later line-end nor forced/skip execution. It is not runtime
proof, and does not cover object mutation, replacement, reflection or another
database. Unknown cache/context behavior is not silently assumed safe.

## Verification, boundaries and next dependency

`verify_lines.py` checks19 pins/7 helpers and all prior evidence groups, including
60 phase77 files, plus9 original resources/DLLs. The unchanged phase76 and77
verifiers were freshly run:10 and4 outputs match exactly, including the original
4200 registry states/126 registrations. All12246 values in EACH frozen copy are
also compared directly again.25 new metadata selections/39 method bodies reproduce
exactly.17 synthetic controls exercise the transcription only, replacing game
execution; actual subtitle construction, callback lifetime/timing, selected state,
manifest construction, visibility, story reachability and save behavior stay open.

The first `readback/` is retained as superseded exploratory output: it lacks the
all-cached-arcs exclusion bound/default-arc qualifier. It is not current evidence.
`readback-v2/` and `readback-reproduced/` are byte-identical final results.
`reproducibility.json` and `execution-recipe.json` bind them to final code.
Three mistargeted metadata selections failed before any game-code execution;
`inspection-attempts.json` preserves failures and their changed selections.
No other process was stopped or launched by this phase beyond read-only tools.

From the canonical checkout, use previously nonexistent output directories:

```
.venv-assets314/bin/python -B localization/source/bgdatabase-20261027/bio-dialogue-registration/verify_registration.py --output <new-registration-directory>
.venv-assets314/bin/python -B localization/source/bgdatabase-20261027/bio-trigger-dispatch/verify_dispatch.py --output <new-dispatch-directory>
.venv-assets314/bin/python -B localization/source/bgdatabase-20261027/bio-line-dispatch/verify_lines.py --output <new-directory>
```

Compare the first two outputs with the original10/4 files before reusing them;
this supplement's verifier checks the pinned registration-recheck/dispatch-recheck.
Next bounded work: original plugin Subtitle construction and line-begin/line-end
callback dispatch, especially sequence defaults/overrides and current text field
selection, to bind original targets to actual callback inputs without inferring
playability. No runtime needed. Complete source/special scenes, manifest and
callback success/reachability, nonlinear save/restore, notification/rendering,
Quest uncertainties, universal semantic/diff/delta, final fonts/licenses/resources/
reinsertion/runtime/delivery remain pending. Accepted10/15/47/48 visuals and50 route
unchanged; spawn/other3 intros/notebook/Bucky stay open. No53 replay/no54.
Parent integrates exact hashes. Usage unknown; parent measures telemetry.
