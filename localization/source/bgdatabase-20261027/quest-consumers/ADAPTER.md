# Phase0069: additional Quest outputs and initial unlock consumers

Text-only original-source work, gpt-6.1-sol/high/OpenAI verified from this CLI's
explicit argv. No game launches, image input, authored target text, agents or
nested model jobs. All seven provisional asset lanes remain independent/read-only.
This supplement changes no frozen source/glossary/registry or earlier evidence.

## Source and exact reproducibility

The verifier reopens original resources.assets:320 `bansheegz_database`, checks
its raw object and all506640 exported bytes, original resource/consumer DLL hashes,
all19 frozen pins, all74 InventoryItem and46 Quest evidence hashes and six helper
hashes. Fresh decode reproduces all904 selected Quest/log cell states. It reruns
27 exact Cecil selections without executing game assemblies. See `baseline.json`,
`il-commands.json`, `readback/verification.json` and `reproducibility.json`.
`attempts.json` preserves one failed metadata selector and its corrected exact list;
no model request or game was launched by these tools.

`readback/log-lookups.json` resolves13 notification lookup occurrences and14 pane
occurrences to13 distinct log row IDs in the actual119-row table. Their98 source
cell states (13x6 logs plus4x5 related Quest rows) retain selectors, values, byte
spans and relation targets in `referenced-rows.json`. Equal wording never merges
occurrences. `compiled-literals.json` classifies46 new notification literals:
9 display fragments,37 protected identity/comparison operands. The pane's75 exact
occurrences are referenced unchanged. One unreachable display literal remains
explicitly dormant rather than being removed. `preserve-exactly.json` additionally
pins eight exact queue/path/counter control occurrences and protected source cells.
These manifests supplement rather than replace the frozen inventory.

## Notification paths, not text mutation

`quest-log.il` OnQuestLogUpdated reads log text into locals. `storm-event.il` and
`storm-callback.il` do the same and call ShowNotification. The complete original
text-field-use search has only one stfld: the existing loader callback. The Storm
methods do not mutate QuestProgressLogEntry.text; the previous unverified mutation
candidate is resolved as read/local selection/queued output.

`dependency-groups.json` contains four bounded groups with exact cell/literal IDs,
conditions, assembly order, limits, source anomalies and required acceptance checks.
Greetings matches lowercased dialogue identity against gator/bird/dash/introduction
with four independent checks in that order; this permits0..4 enqueues per call.
Penny/Dustin/Finley introduction plus Augustus encounter state selects its prompt
or compiled completion. Compiled Meet labels omit directions present in DB logs;
retain both occurrences. These operands are protected identities, not display text.

Storm similarly permits0..5 ordered enqueues for maverickandmabel/intothestorm/
scarlettandpeter/buckyminigame/lastpage. A status200 quest exits before any message;
[Quest Completed] at IL_01bc is unreachable under the stable local condition.
Item420 is PageStormQuest. Some variants test quantity==7, while Bucky's later
branch tests>=7. Preserve quantity>7 behavior and independent predicate matches;
the static maximum is not proof that real dialogue names match all predicates.

The page collector invokes its event at quantity>=7. Outside chapter-select/cheat,
the event either enqueues(_5,_2), or starts the exact Mabel conversation/arc, assigns
the callback after StartConversation, then spawns a stuck page. The callback later
enqueues(_5,_5a). The helper subscribes to dialogue finish OR cancel; its handler
captures the static callback, resets inputs/updates tags and invokes the captured
action without a dialogue-name check. Timing, successful start and actual callback
reachability remain unverified. Do not silently reorder or repair this source.

Other quests use generic history; completion shifts it and inserts Quest Completed!.
The notification sends previous=1Back/current=current and discards2Back. Its hidden/
chapter/cheat guards apply after special branches. The initial dbName access is not
null-safe even though a later generic null guard exists; no repair is made here.

ShowNotification creates a fresh two-string node and enqueues without deduplication
or cap. Update schedules0.5s when no event is active, notification is hidden and
queue nonempty, then TryShow rechecks before FIFO dequeue. It writes both strings
to all collected labels; the old nonblank string controls the checkmark. Queue
clearing can discard entries; enqueue count is not displayed-notification count.
`native-bindings.json` pins controller sharedassets2:14479 and65 hierarchy hashes:
8 old/8 new Text descendants, all subtree-active in original serialization, with
paths, raw hashes, font references and rects. Start collects active descendants;
runtime changes/animation and actual visible multiplicity remain unverified. These
16 shadow/white/normal outputs do not create16 authored phrases or prove Cyrillic.

## Special details pane dependencies

Storm's explicit slots bypass generic history. Flags can prepend DONE - even to a
null local, creating a prefix-only string. The three finished flags set the current
completion label independently of quest status; status200 alone does not force it.
Greetings has five explicit slots/actor overrides, independent of generic unlock
selection. Afterstorm has five regional AND groups and32 possible region states:
none complete uses two DB rows; otherwise it joins unfinished regions in fixed
North/South/West/Central/Perch order and applies exact Replace(", .", "."). All
regions complete produces `More critters .` before the status override. Preserve
this anomaly; target wording/assembly needs a grouped decision. Its64 region/status
states are required future checks, not executed renderer or semantic acceptance.
Actor/dialogue/trigger families and their full source bindings remain pending.

## Initial unlock: partial gap resolved

`start-trigger.il` binds DialogueTriggerStartQuest -> NarrativeActions.StartQuest.
After SetStatusStarted, StartQuest tests runtime progressLogEntries.Count and calls
Unlock(list[0], true); true suppresses the unlock event. It does not emit
onQuestLogUpdated. LogNewlyEnteredStep calls Unlock(entry,false), then emits the
update event even when Unlock returns early for an existing unlock. CompleteQuest
also emits that event. QuestLog subscribes/unsubscribes in `log-hooks.il`.

`refresh.il` has a separate AdventureModePlaceholder path gated by availability,
cheat/status/unlock state. It temporarily sets isCheatCode, calls SetStatusStarted
and Unlock(list[0],false). This is an additional runtime mechanism, not a read of
the declared initial-unlock relation column. The38 typed Quest rows'30 declared
links in28 lists all target logs owned by the same Quest (`initial-unlocks.json`).
The initial getter-call search and exact column-literal search are empty. The
started-event field scan contains only its initializer and emitter, no compiled
listener in original Assembly-CSharp. Reflection/other assemblies remain untraced;
this does not prove dead data. Runtime list[0] is not statically assigned a row:
all priorities0, and the original List.Sort comparator has no tie breaker. Do not
replace this with declared links, row order or a stable sort without an adapter.

## Reproduce and next work

From canonical Forest, use a fresh output path:

```
.venv-assets314/bin/python localization/source/bgdatabase-20261027/quest-consumers/verify_consumers.py --output <new-directory>
```

Compare all seven generated readback files byte-for-byte. This verifies original
source/IL/typed-reference/native-object boundaries, not reinsertion or game behavior.
Complete shared source and special-scene acceptance remain needs-review; editorial,
adapter implementation, resources, renderer/runtime and local delivery stay pending.
Next decode the remaining seven Quest columns and their actual availability/loader
consumers in a separate supplement; preserve initial-order/reflection gaps explicitly.
Accepted10/15/47/48 visuals and50 route remain unchanged.53 stays consumed, no54 or
unchanged runtime retry. Initial spawn/other3 intros/notebook/Bucky, final fonts and
licenses remain pending. Usage unknown in worker; parent measures actual telemetry.
