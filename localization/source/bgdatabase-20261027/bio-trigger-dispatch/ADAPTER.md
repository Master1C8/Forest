# Phase0077: original BIO normal, forced and skip dispatch

Static text-only evidence for The Forest of Love0.45. The actual CLI argv in
`execution-model.json` pins gpt-6.1-sol/high/OpenAI. Parent alone owns Git/index/HEAD.
No game assembly execution, game/GUI/image input, nested model/CLI/agent, authored
translation, source/glossary/asset modification, publication or deployment. All
parallel asset/editorial lanes and the separate Russian preview remain untouched.
This supplement adds consumer knowledge; it does not accept complete localization.

## Normal dispatch and its state boundary

`DialogueService.Handler_OnConversationLineEnd(Subtitle)` extracts the subtitle's
original conversationID and entry ID. Both overloads return if CurrentDialogue is
null. The integer overload invokes onDialogueLineArcTriggerCheck with current
Dialogue/Arc and those original IDs, before its actor/text line-end event and
IsPlayerResponseAvailable reset. StoryManager's Add/RemoveEventListeners registers/
unregisters HandleArcTriggerCheck; that handler forwards to Dialogue.FireArcTriggers.
Actual registration lifetime, selected objects and upstream callback timing remain
unverified. Assembly-wide exact-name searches also identify HandleDialogueLineTriggering
and BuildDynamicConversation as callers; their nonstandard dispatch remains the next
bounded investigation, rather than being assumed equivalent to displayed dialogue.

FireArcTriggers iterates dialogue.arcTriggers in existing list order and calls
CheckTrigger(arc, conversationID, entryID). CheckTrigger admits identical arc references
or, on mismatch, a NULL INCOMING arc when allowNullArc is true. It then rejects a
previous execution unless allowExecuteMoreThanOnce, and invokes IsConditionSatisfied.
The original base condition compares BOTH IDs exactly. The BIO subclass defines only
its constructor and OnExecute, so it inherits that condition. Original BIO constructors/
registration do not opt into repeat, null-arc or skip flags; all begin false.

The key state boundary is `CheckTrigger IL_0030 set_isExecuted(true)` BEFORE
`IL_0036 OnExecute`. There is no success result or rollback in this path. A BIO action
that returns for Vslice, finds no applicable slot, finds only already-unlocked slots,
or throws after this mark does not undo it. A later normal check on that same instance
is rejected unless another authorized runtime path resets/replaces its state. No
save/restore persistence or lifetime is inferred from this in-memory flag.
Normal CheckTrigger does not consult the three skip-mode flags.

## Forced dispatch and skip

ForceFireArcTriggers checks each trigger's skipDuringDialogueSkip/ChapterSelect/
CheatCode against the corresponding Globals flag. It then admits equal arcs or a
NULL REGISTERED arc with allowNullArc. This null test differs from normal dispatch;
the verifier retains a matching positive/negative control. All126 original BIO
registrations have nonnull assigned arcs and all three skip flags false, so these
flags do not suppress them under unchanged original construction.

ForceExecute repeats the three skip guards and calls OnExecute directly. It checks
neither node IDs, isExecuted, nor allowExecuteMoreThanOnce; it never marks isExecuted.
Thus forced BIO action can recur even after normal execution. Its keyword insertion
is independently deduplicated by category dictionary, not by this dispatch routine.
This is a conditional static consequence, not proof a player can invoke that path.

QuestSkipController.TrySkipConversation obtains CurrentDialogue/CurrentArc and requires
CanSkip. Each registered handler can veto by Quest (when present), Dialogue or exact
dialogue dbName/arc customName. Handler implementations, actual lists and reachability
remain pending. SkipConversation sets DisableTriggeredEffects and isDialogueSkip,
marks a nonnull arc skipped, calls both skip-handler passes, then forces that nonnull
arc. It stops the conversation and clears typewriters. If completeStepIfSkippingAnyArc,
it additionally calls MarkConversationsAsPlayed(dbName, null). Its final flag reset,
log and autosave calls are not proof that earlier callbacks or persistence succeed.

MarkConversationsAsPlayed matches dialogue dbNames using String.Contains, not exact
equality, while temporarily setting DisableTriggeredEffects. MarkQuestStepAsPlayed
with a NULL customName marks the dialogue/all its arcs and directly ForceExecutes
EVERY trigger, without an arc filter. A nonnull customName marks the dialogue and
forces each arc whose customName is exactly equal. An empty nonnull string follows
that second branch. These paths can repeat actions already forced by SkipConversation;
no deduplication is assumed beyond the separate category dictionaries. Notification,
status-event callbacks, DisableTriggeredEffects semantics and save durability stay open.

## Exact BIO action, missing keys and successful unlock

BIO OnExecute passes targetActorDbName/pluginDbKeywordName unchanged to
NarrativeActions.UnlockBioKeyword. That method first checks the exact active tag
`Instanced Event Vslice`; DataService.IsTagActive uses activeTagsByDbName.ContainsKey.
If active, it returns BEFORE actor/key lookup. Normal trigger state is already marked.
When inactive it calls GetActorByDbName then GetBioKeywordByPluginDbTriggerName.
Each lookup explicitly ContainsKey/get_Item on success; absence LogErrors and returns
null. This is not an unchecked dictionary lookup or a legacy-to-modern key repair.
An absent actor is not guarded before the final Actor callvirt and can fail there;
the126 original registrations resolve actor identities, without accepting runtime
manifest construction/mutations.

An absent keyword is passed as null. BioDetail.TryUnlockKeyword explicitly returns
false for null. BioNotes/BioKinks have no early null guard: they compare each stored
keyword reference to the argument BEFORE dereferencing dbName. The accepted original
loader adds only resolved, nonnull keyword relations to these lists. Under that
unchanged original construction, null matches nothing, both return false, and no
unlock event is emitted. This is NOT unconditional null safety: a runtime-mutated
list containing null could instead match and fail on the later dereference.

For a present keyword, each currently selected nonnull category can add only a member
of its own keyword list and only when its dbName is absent from its keywordData.
Insertion stores the keyword reference and Globals.StoryClock. Actor tries Detail,
Notes and Kinks in order, ORs their results without short-circuiting these calls,
and invokes onUnlockActorBioKeyword only when at least one added data. Already present
or absent members return false. Hidden display flags do not gate TryUnlockKeyword;
unlock, category selection, notification, displayed text and durable save are separate.
Tag/priority selection and prior membership evidence are reused unchanged.

## All original registrations and preserved anomalies

`readback/dispatch-targets.json` retains every exact phase76 registration, actor cell,
target pair, arc identity (including i2's actual trailing newline), parent chain/count
and prior category membership. These are conditional dispatch targets, not playable
scene counts.125 controls yield126 registrations:

- 109 have potential original category membership; current selection and saved state
  still determine whether any insertion succeeds.
- 15 missing legacy keys yield16 registrations (108:118 is in two original idle arcs).
  Outside Vslice they LogError/return null and cannot unlock under original lists.
  Do not remap or delete them, infer a runtime failure, or claim they are reached.
- 299:1006 still registers Augustus/sizeplay at Dates_BuckyAugustus2_Dialogue_n1 entry485,
  yet has no slot in any original category for Augustus. It produces no category
  insertion under those tables; no source repair is applied.

The three original controls in unregistered458 remain separately recorded in
`readback/outside-registry.json`; global use is unverified and candidates remain intact.

## Verification and reproduction

`verify_dispatch.py` checks19 frozen pins,7 unchanged helpers,285 older evidence hashes,
63 Detail/50 Keyword/41 Note-Kink/72 Registration files and9 original installed
resources/DLLs. The unchanged phase76 verifier was freshly run into `prior-recheck/`;
all10 outputs exactly match, including all12246 candidate values in BOTH frozen
627-conversation copies, selected-span no-op, registry and126 registrations.
That run reproduces27 original Cecil selections/41 bodies. This supplement's29
selections/29 bodies are freshly reproduced by its verifier. Selection counts include
lists/searches; the empty earlier guessed event fragment is retained, and the actual
onDialogueLineArcTriggerCheck field is separately traced.92 older selections are
reused under unchanged evidence hashes, not claimed as freshly executed.

`readback/dispatch-controls.json` has30 explicitly synthetic transcription checks for
exact-ID/arc failures with matching positives, repeated normal vs forced action,
the different null-arc rules and all mode combinations of original false BIO flags.
These exercise the Python transcription, replacing game execution. IL equality and
synthetic controls establish neither actual event timing nor story reachability.
`inspection-attempts.json` records the mistyped data-directory failure and nonexistent
Execute method selection. Neither executed game code; successful earlier outputs were
preserved before adapting to actual CheckTrigger/ForceExecute method metadata.

From the canonical checkout, using previously nonexistent output directories:

```
.venv-assets314/bin/python -B localization/source/bgdatabase-20261027/bio-dialogue-registration/verify_registration.py --output <new-prior-directory>
.venv-assets314/bin/python -B localization/source/bgdatabase-20261027/bio-trigger-dispatch/verify_dispatch.py --output <new-directory>
```

The second command validates this supplement's pinned `prior-recheck/`; separately
compare a fresh prior-directory to the ten original registration outputs when reusing
that prerequisite. `execution-recipe.json` and `reproducibility.json` bind current
code/dependencies and the independently generated readback comparison. No assembly
execution or reinsertion is used. No new source candidates or translations are created.

Next: trace the exact original HandleDialogueLineTriggering/BuildDynamicConversation
normal-event callers, preserving original IDs and distinguishing implicit/preplayed
dispatch from actually displayed or player-selected lines. Bound any extra condition/
arc-selection inspection to these callers; leave broad save/UI and other sheets out.
Full source/special scenes, manifest callback dependencies, actual selection/reachability,
save initialization/serializer/nonlinear restore, notification/rendering, universal
semantic/independent diff/delta, final fonts/licenses/resources/reinsertion/runtime/
delivery and existing Quest uncertainties remain pending. Accepted10/15/47/48 visuals
and50 route stay unchanged; initial spawn/other3 intros/notebook/Bucky stay open.
No53 replay/no54. Parent integrates exact hashes; worker usage unknown.
