# Ordinary Bucky interaction: source and control preparation

Phase0058 is text-only: no game launch, image access, predicate execution or
translation. The existing tutorial extractor now has `--ordinary-bucky`; its
20 outputs reproduce byte-identically, including17 original consumer groups,
18 exact serialized objects and complete original conversation141. Both
extractions compile the read-only Cecil inspector from current pinned source.
Original managed/resource hashes and exported MonoBehaviour/GameObject equality
are checked before use. This supplement leaves all19 live-lane inputs unchanged.

## Exact ordinary input and touch path

`Input.il` binds gameplay `IsSubmitButtonDown` to Rewired action2 (`Action`),
whereas non-gameplay uses18. The original gameplay keyboard map binds2 to
LeftControl306, RightControl305, Return13 and Space32. Prefer Return for the
planned interaction: `Player.CheckInput` also handles the control keys directly.
The menu Return binding is18; a successful menu press does not prove gameplay2.
Original keyboard axes feed `Player.CheckInput` and `FixedUpdate`; the latter
uses normal Rigidbody movement. Never write an axis, position, velocity or collider.

At50's post187 measurement Player is(6,8), Bucky(7.8,6.3). These later positions
are not verified initial spawn or a restored post187 checkpoint. A future new
candidate must follow the original QA43 Continue/readiness/prefix/181 path and
measure its own post187 state before short right/down pulses. Right and Return
have **no native acceptance** yet; retain accepted left/down evidence separately.
The existing `target_keyboard.swift` deliberately permits only left/down and
their task-edge releases. No new input command was added in0058.

The original BuckyOnNorthShore prefab root3761 has exact script `CritterActor`
32067, inheriting SpawnableActor. Its actor tag resolves through external file7
to sharedassets2:13876, `Bucky`. InteractionArea6864 has trigger CapsuleCollider2D
12178, size(1,0.6), offset(0,0.21), and CollisionEventListener37348. These are
original prefab values; measure actual loaded transforms/collider geometry before
using them as runtime bounds. They do not establish an unobstructed walking route.

Controller28786 is exactly `TheForestOfLove.InteractionUiController`, with
trigger30977 and shared listener37348. Trigger30977 is exactly
`TheForestOfLove.Interaction.DialogueInteractionTrigger`, settings34291;
triggerOnCollision=False and allowTriggeringWithoutUi=False. Settings resolve
actor=Bucky, dialogue=`- Untagged -`, arc empty. `StoryDispatch.il` proves this
sentinel means **inferred schema**, not a named tutorial override.

`Collision.il`, `ControllerTouch.il` and `TriggerInput.il` trace real root Player
collider enter/exit -> listener -> both subscribers. Controller enter sets its
touch flag and calls TakeControl; the trigger independently acquires its own
authority through TryActivateTrigger. Leaving Scarlett's area must naturally
release her authority. Never call these callbacks or TakeControl to simulate touch.
The two authority stores are distinct and compare **GameObject** instance IDs,
not component IDs. One authority flag does not establish the other.

TakeControl requires an available/unlocked shared UI and unblocked trigger, locks
that UI, registers the original OnInterationOptionSelected delegate, takes its
authority and computes available options. `locked=True` is the expected acquired
state here. `Ui.Show`/SetAvailableOptions invoke the selected-option delegate;
Talk0 sets trigger interactionMode=Quest0. NavigateOptions consumes bumpers9/10,
not movement arrows. Only accept a naturally cached Talk/Quest state; do not call
UpdateAvailableOptions, HasAvailableMessages or an oracle for diagnostics.

Trigger Update consumes a fresh Submit edge. Its ordinary CanTrigger chain checks
base allowance, not already triggered, cooldown0, not blocked, settings present,
no dialogue/event, UI visible, Player.canInteract and its own authority. The source
uses this predicate for ordinary gameplay; QA may read those fields but must not
call the predicate itself. The ordinary update then calls Fire and PlayDialogue.
No bridge call to Fire/PlayDialogue or mutation of mode/authority is justified.

## Dispatch and exact source graph

Inferred Quest dispatch does **not** select141 solely because Talk was cached.
ChooseTargetStepAndArc first considers selected date, latest unplayed primary,
turn-in/new main/new side quest, then an available unplayed quest dialogue, and
later dynamic questions/gifts/idle. The primary-quest oracle checks incomplete,
tag-available quest; incomplete/precondition-satisfied dialogue; matching actor;
no player-initiated question and remaining primary arcs. These are source facts,
not newly evaluated availability. Observe the actual result and reject an
unexpected dialogue rather than forcing141 or bypassing the preceding choices.

Complete141 exactly equals the existing seven-conversation snapshot. Marker218
`PRIMARY` links215; the actual loaded primary arc `p1` starts at215 (observed50).
First subtitle215 is Narrator7, `He… seems to be quitely snoring… Wake him up?`.
Preserve the original typo. Its two original Player1 choices are No216 (terminal)
and Yes217 ->194. The planned selected response is217, selection-only until a real
subtitle proves otherwise. Actual successor194 must be observed separately from ACK.
Then the exact single-link content route is194..212. Narrator201 separates Bucky3
lines200 and202; Player206 introduces Rascal. Every actor/text/condition/script/
sequence/listener/link must remain source-bound; empty source controls are retained.
Do not loosen the existing original120:158 terminal restrictions or generic response
guards to reach this new menu. A dedicated141:215 ->217 boundary is required.

Disconnected marker192 `TRIGGER(intro_from_beaver)` points to212; FINISHSTEP225
and FINISHARC235 also point212. Existing original loader and line-end dispatch
bind the named trigger to212's end, not to reading marker192. Check actual
intro_from_beaver count after the real212 line-end and two distinct no-dialogue/
no-event cleanup frames, plus dialogue/arc status and the other three counts.
Seeing212 or receiving Continue ACK is insufficient. This first introduction
does not complete all four tutorial prerequisites or unlock the notebook.

## Next implementation and verification boundary

`interaction-plan.json` defines the exact new-candidate plan and rejection cases.
Next work prepares the bounded right/Return transport and read-only loaded Bucky
admission, then a source-bound217 selection/194..212 host extension. Preserve all
14 original and seven prefix/readiness guards, original New/Continue behavior,
synthetic separation, freshness, one-use and existing budgets. Any required new
stage budget must be finite and separately named; do not extend existing deadlines
on ACKs or repeat unchanged actions. Compile/read back the actual bridge and test
positive/rejection controls before freezing a new candidate. Preparation is still
pending: this phase does not claim a run-ready candidate or native input acceptance.

Reproduce with:

```sh
.venv-assets314/bin/python tools/inspect_tutorial_source.py --ordinary-bucky --output <new-project-directory>
```

Output writes are independent, not transactional; every declared hash plus the
manifest is required. This adds source knowledge, not a second inventory/pipeline.
Accepted10/15/47/48 visuals and50 progression/cleanup remain unchanged. No consumed
candidate50/49/48/47/46/45/44/43 may be replayed; QA disk files still equal43 and
are not a post187 restore checkpoint. Complete source/BGDatabase/special-scene,
initial spawn, notebook/inventory, editorial, final font/license/resources and
local delivery gates remain pending. All seven asset lanes continue read-only to
this technical lane. No publication/deployment occurred.

Regression: the shared UI being locked indicates ordinary ownership; requiring
unlocked during Submit would reject valid acquired state. Conversely, accepting
cached Talk alone would admit a different actor or a higher-priority dialogue.
Read exact controller/trigger GameObject authority, actual cached selection and
actual resulting141 before crediting the planned introduction.
