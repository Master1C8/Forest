# Bucky ordinary admission and native transport preparation

Phase0059 is text-only implementation/preparation. No game, images, gameplay
predicates, model workers, target-text authoring or publication was used. The
active technical CLI was verified as PID67537, explicitly gpt-6.1-sol/high/OpenAI
with user config ignored and multi_agent disabled. Parent runner accounts usage;
per-request input/cache/output/reasoning telemetry is unavailable in this worker.

## Implemented boundary

`tools/probe/target_keyboard.swift` now accepts right and Return through the
existing CGEvent.postToPid backend. Each new DOWN requires both the inspected
native PID and window ID again at dispatch. Right remains100–1000ms; Return is
exactly100ms. Both edges are constructed first, INT/TERM are deferred for the
bounded synchronous press and UP targets the same PID. New recovery commands
also require the exact PID/window and remain authorized only by an actual task
DOWN receipt. No activation, global event or fallback was added. Existing
left/down interfaces remain. The helper is compiled under this preparation
directory only; this is not a new runtime candidate or native acceptance.

```text
target_keyboard <candidate> right 100 <inspected-pid> <inspected-window>
target_keyboard <candidate> return 100 <inspected-pid> <inspected-window>
target_keyboard <candidate> release-right <task-down-pid> <task-down-window>
target_keyboard <candidate> release-return <task-down-pid> <task-down-window>
```

The bridge adds read-only `dump-bucky` -> `bucky-interaction.json`. Its scalar
identity/frame/time and string rows preserve JsonUtility's known external-DLL
array constraint. It reads the exact active Bucky actor/controller, their types,
original settings/shared listener/UI bindings, both distinct authority stores
and their own **GameObject** IDs, cached options/mode and original UI delegate.
It reads actual collision runtime callbacks without Invoke/PrepareInvoke,
CapsuleCollider2D geometry, root CircleCollider2D.IsTouching and ignored-pair
state, Player.canInteract and body identity/velocity. Inherited private
maxTimesTriggerable is read from its exact declaring base type. The added
TriggerDbName getter is source-inspected and resolves the untagged marker to
the empty original override; it does not evaluate CanTrigger.

Keyboard samples additionally expose all original Return/Space/Control keys at
native, async, Rewired and Unity layers, gameplay GetButton(2)/GetButtonDown(2),
Unity Return edge and InputHelper.IsSubmitButtonDown. KeyboardMaps adds a separate
Submit binding list while retaining the accepted movement list. Reading these
values does not inject an axis/button or replace focus/watchers/controllers.

Three pure host guards were added to the existing diagnose_newgame.py:
`bucky_interaction_guard`, `bucky_submit_map_guard`, `bucky_input_released`.
They require fresh original-mode CentralForest identity/dependencies, no event
or conversation, exact types/paths/bindings, both natural touches/authorities,
visible **locked=True** Talk UI, original Quest mode/settings, exact listener
targets, actual root contact and idle physics. They additionally pin gameplay
action2 bindings and require all twelve observed keys/action2/both axes released.
These helpers are **not wired into a gameplay executor yet**. Cached Talk is
ordinary admission only; it never proves the eventual inferred141 dispatch.

## Verification and limits

All106 focused host/regression tests pass:7 Bucky tests (with boundary-specific
subcases),52 native-input,36 Continue and11 tutorial181. New fixtures explicitly
replace Unity fields, callbacks, contact and clock values; they prove host
rejection semantics, not the replaced producer or native event delivery.

The actual Swift executable passed11 no-delivery checks: passive absence and
invalid/missing action arguments/processes were rejected before posting. No
event was sent. Positive native right/Return, wrong PID/window after a live
unique-window admission and duration rejection after that admission remain
unexecuted. Do not relabel accepted historical left/down as this evidence.

Both before/after original and synthetic bridges compile against the pinned
installed managed assemblies. Synthetic retains the pre-existing unreachable
code warning; no new warning remains. Cecil readback compares every existing
method, overload and generated closure:50 exact bodies and14 compiler-ordinal-only
bodies per mode; only Update, KeyboardMaps and LateUpdate intentionally change.
Five added methods include the new record constructor and four readers/helpers.
The first two comparison attempts exposed generated lambda/iterator ordinal
changes; final comparison uniquely matches complete normalized signatures/bodies,
never drops those closures. Existing Update commands also have exact source
equality after removing only the new dump-bucky branch. All54 existing Python
top-level definitions, including class methods, are AST-identical. Original14,
seven prefix/readiness, terminal120:158/181 and generic-response guards remain.

Read `verification.json`, `compiled-readback/comparison.json`, `compile.json`,
the four test logs and `native-helper-checks.json`. The saved bounded
`verify-compiled.py` uses the before/after snapshots and existing Cecil inspector;
it performs no Unity execution. Compiled files here are inspection artifacts,
not ship-ready resources, and must never be copied to the original install.

## Concrete continuation

Implement dedicated source/control-bound141:215 -> original Yes217 selection,
actual194 observation and every actor/text/link194..212 plus true line-end/two
cleanup frames. Reuse exact Wrappers.StandardUIResponseButton/inherited base
OnClick admission from181; preserve original No216 separately and all existing
generic/terminal/synthetic restrictions. Add meaningful positive and wrong
actor/type/binding/choice/link/successor/stale/listener/replay/premature-cleanup
checks and compile/read back the affected bridge. ACK is never successor or time.

Then wire a finite separately named ordinary movement/Submit stage into the
existing host. Require unchanged QA43 Continue/readiness/prefix/181/full187/two
cleanup frames first, then measure its own post187 positions. Use short measured
right/down pulses, exact process/window and task-edge ownership, per-action
producer/consumer ingress, all-up/zero-axes evidence and stop on unchanged
displacement/unexpected state. Read Bucky fields without predicates; leave
Scarlett authority naturally. Do not write position/velocity/axis/collider or
simulate callbacks/acquire authority. Do not extend deadlines on ACK.

Only after focused checks/compiled readback may candidate51 be frozen with all
later-loaded helpers/source plans/configuration, normal preflight, QA43 fixture
and19 lane pins. No candidate51 directory or run-ready candidate was created here.
Never replay consumed50/49/48/47/46/45/44/43. QA files still equal43, not post187.
The accepted50 route/cleanup and10/15/47/48 visuals remain unchanged.

Source/BGDatabase/special-scene/editorial, native right/Return/ordinary141/trigger,
initial spawn/notebook/inventory, final fonts/licenses/resources and local
delivery gates remain pending. All seven independent authorized asset lanes
remain read-only to technical work; technical lane alone owns Git/index.
