# Notebook eligibility and the next ordinary progression boundary

Phase0055 is text-only. Candidate48's independent synthetic-choice visual result
was imported once and checked separately. No game ran and no images were opened.
This supplement leaves all frozen source/glossary/special-scene inputs unchanged.

## What the existing loaded data actually says

`original/loaded-notebook-conditions.json` retains all102 reflected fields from
candidate48's original `StartMenu` read-only dump, with its exact source hash.
It identifies conversation225 as `GossipQuest_GetTheNotebook`, Scarlett,
`Act1_GossipQuest`, status Default; its primary arc starts at191. The original
quest diagnostic reports type `Quest`, first=True, last=True. Its name does not
select a gossip consumer. These are menu-time observations, not a measurement
of post-tutorial gameplay availability.

The loaded FullAvailabilityRule has three nonempty prerequisite lists:

- `questsAll.quests`: `Act1_TutorialQuest`, requireAll=True, negateCondition=False.
- `tagsAll.tags`: `Main Act 1`, requireAll=True, negateCondition=False.
- `antiTagsAny.tags`: `Instanced Event`, requireAll=False, negateCondition=True.

`PrecedingQuests.il` checks `quest.isCompleted`, not started or any played dialogue.
`QuestCompletion.il` defines completed as status200. `PrecedingTags.il` requires
the positive tag and rejects the active negative tag. The captured tutorial quest
status is0, so this prerequisite is unsatisfied under the ordinary non-bypass
configuration. This is a source interpretation of the captured operands, not a
new runtime call. Debug bypasses remain prohibited and their current values are
not established by this snapshot.

The other loaded collections are empty, governingRule is null and percentChance
is0. `ChanceState.il` proves this particular zero chance returns true before the
random path; it does not mean a random roll with zero success probability. This
does not establish every other consumer's neutral semantics or overall availability.

## The correct interaction route avoids a circular prerequisite

`InteractionModes.il` pins Quest=0, Detail=1, Gossip=2; `DialogueTypes.il` pins
Quest=200, Gossip=400. In `StorySelection.il`, `HasAvailableMessages` Quest mode's
inferred route calls `GetFirstEncounteredUnplayedPrimaryQuestDialogue`; the oracle
requires an incomplete/tag-available quest, incomplete dialogue, satisfied
preconditions, matching actor, no player-initiated question and unplayed primary
arcs. Date selection and other ordinary authority/interaction guards still apply.

The Gossip=2 branch explicitly requires `PlayerLearnedNotebook()` and rejects
instanced stories/capstones. Calling that branch to obtain the first notebook
would fail before selection. Use Scarlett's naturally offered **Quest** option
when it becomes available; do not call the oracle or start225 directly to make it
available. The actual loaded Scarlett control/authority/selection remains untested.

## Reuse the existing four-trigger completion rule

The already traced tutorial rule is retained as an exact bounded excerpt from
the pinned original `TutorialTriggers.il`, IL_020c through before IL_02ce. An event
for any of `intro_from_beaver`, `intro_from_mouse`, `intro_from_otter`, or
`give_sugar_to_bunny` calls CompleteQuest only when all four fired and the quest
is not already200. Completing120 alone is insufficient. `CompleteQuestHelper.il`,
`DialogueTriggerDispatch.il`, `CompleteQuestTrigger.il`, `TriggerAction.il` and
`QuestCompletion.il` now bind the complete request -> one-use trigger ->
SetStatusCompleted -> status200 and quest-log notification chain without invoking it.

The source graph's trigger markers bind to the line reached by their outgoing
link, not to the disconnected marker itself:

| Conversation | Marker | Exact trigger | Bound content line |
| --- | --- | --- | --- |
| 141 | 192 | `intro_from_beaver` | 212 |
| 142 | 193 | `intro_from_mouse` | 164 |
| 143 | 193 | `intro_from_otter` | 170 |
| 129 | 228 | `give_sugar_to_bunny` | 178 |
| 225 | 188 | `notebook_unlocked` | 195 |

Original225 root129 ->191 ->192 ->193 ->194 ->195 is unchanged. Continue through
the real195 line-end; observing195 alone does not prove trigger/listener execution.
Before opening inventory, retain all original MasterLog no-event/gameplay/notebook
guards and then verify actual page/cell/ticker output. No trigger/quest/arc/save
mutation is permitted as a diagnostic shortcut.

## Concrete next bounded runtime preparation

Use a new immutable candidate in original-choice mode. Reuse the accepted QA43
Continue fixture only under its existing admission/readiness checks; initial spawn
remains unverified. The existing prefix stops at unselected120:158 by design.
Add a separately source-bound normal response181 command/host plan, never a generic
terminal override, and preserve the original/synthetic distinction and existing
negative guards. Original181 reads `The love. Definitely the love.` and goes
181 ->182 ->183 ->184 ->185 ->163 ->164 through187.159 is an alternative branch;
neither is authorized for synthetic candidate48 replay. Source conditions, actors,
links, response listener and actual control must be checked before the normal click.

Guard actual successor182 and the subsequent source route through187, then original
conversation/event cleanup and fresh read-only tutorial/actor/interaction diagnostics.
Do not infer all four prerequisite triggers or notebook readiness from this first
conversation. This is the next dependency to measure before traversing the other
three introductions, sugar acquisition/delivery and Scarlett's notebook Quest option.
Keep the original no-menu158 completion path and selected-response-vs-subtitle
coverage distinctions. A first observed position differing from the fixture remains
an explicit initial-spawn gap, independent of normal continuation.

## Diagnostic rule and regression

`FullAvailability.il` combines nested results with IL `and`, not a short-circuit
guard. After the governing-rule check, a false earlier operand does not prevent
later chance evaluation. `ChanceState.il`'s nonzero path writes scene-load/random/
unlucky-roll state. Never call IsSatisfied/HasAvailableMessages/CanTrigger/oracle
availability merely to print diagnostics, even when an earlier prerequisite appears
false. Read fields/cached options only. Regression: a false area prerequisite plus
a nonzero chance rule must not trigger a random roll during a diagnostic dump.
The zero-chance notebook snapshot is a positive source control, not permission to
evaluate generic predicates.

## Reproduce and acceptance limits

```sh
.venv-assets314/bin/python tools/inspect_notebook_eligibility.py --output <new-project-directory>
```

The recipe reads the hash-pinned original assembly/tree, existing diagnostic inputs
and original Cecil inspector; it does not execute game methods. All16 consumer
groups,102 loaded fields and seven complete original conversations have byte/hash
readback; a second fresh extraction was compared. Output files are independent
writes, not a multi-file transaction; the extraction manifest must exist and every
declared hash must match before reuse.

This establishes bounded source/selection knowledge. BGDatabase's complete field
inventory, actual gameplay availability, ordinary choice181 progression, initial
spawn, notebook trigger execution, inventory rendering, full special-scene/editorial,
final fonts/license/resources and delivery remain pending. All seven authorized
parallel asset lanes continue independently and remain read-only to this lane.
No authored translation overlay, publication or deployment was produced.
