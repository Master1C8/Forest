## Phase0029: passive startup boundaries traced and statically verified

Original BuildSettings identifies FirstLaunch before StartMenu. Pinned scene/source
bytes establish the active RootActivator hierarchy and its original Awake/scene-change
logic, then the PrefabDropper queue. None of the original Assembly-CSharp methods has
a RuntimeInitializeOnLoadMethod attribute. The exact cause of37's missing readiness
is still unknown; high load was not promoted to a diagnosis.

`prepare_bridge.py RUN --startup-markers` now optionally prefixes only original
RootActivator Awake/scene-change, PrefabDropper Awake and MainMenu Start with Unity
logger calls. Early bootstrap hooks have no bridge reference. Bridge logs distinguish
Install entry/actual identity, accepted identity, AddComponent, Awake, READY and return.
No focus, map, input, story, object-state or original scene-flow replacement was added.
The injector verifies all serialized methods and, after removing allowed prefixes,
all original hook/bootstrap instructions, branches, locals and exception handlers.

Both utilities and the fresh bridge compiled. Five static cases passed: baseline,
startup markers, inventory sample, combined flags, and exact duplicate-flag rejection
with a valid positive control. Evidence/recipe: `localization/source/startup-boundary-20261026/`
and `tools/inspect_startup_source.py`. These checks establish source/IL preservation,
not Unity startup, original eligibility, renderer or route acceptance. No game or
image was launched; no38 was prepared.37's consumed artifacts and pending command
remain unchanged; all asset lanes remain outside technical writes/index ownership.

Next: one new fully pinned immutable38 can test this changed startup instrumentation,
with accepted resource bytes and the strict original two-frame idle/menu gate before
New. Preserve every loaded Player/map/focus/filter/story/door/ingress/release guard.
An entered marker proves only that boundary; absence still includes JIT/scheduling/
logger possibilities. Stop at the first unexplained boundary; never relaunch37.
All broader localization acceptance and final-delivery gates remain pending.

## Phase0028: strict original eligibility guards; startup37 failed before readiness

The shared gameplay gate now requires actual original Rewired ready/global/filter,
focus watcher, inputAllowed and IsInputAllowed(Keyboard), native keyboard support,
Player1 and exact original movement maps/bindings. Travel dumps emit the same
read-only predicates. Every pulse/release sample retains eligibility and identity
checks; story changes require a real original DOWN doorway transition. Consumer
ingress must match native/Rewired/actionAxes/FullAxis in one frame. Release also
requires zero velocity of an existing root body. No observed values are fed back.
Source getter/iterator IL is pinned in `localization/source/gameplay-eligibility-20261026/`.

32 focused tests passed before the one immutable37 launch; the bridge compiled
with exact instruction readback.37 failed its300s readiness deadline before the
bridge, menu gate, New/intro or any native pulse. Failed runtime/cleanup receipts
remain intact. The unacknowledged restore-input-policy command is preserved and
was never replayed. Normal Quit was unavailable. Only exact task game/handler PIDs
were terminated; a new CrashHandler was discovered by full executable-path
verification and separately removed. Final verification confirms all task processes
absent,338 frozen dependencies (336 exact plus2 intended DLL cleanup exceptions),
150 original references,5 resource pairs,7 pins and owner files unchanged. QA
persistence is empty and no tfol files were generated. No images were opened/captured.

High workstation load and a timed-out native sample are observations, not a proven
startup cause. The later33-test run passed31 (including the new late-child regression),
with2 child-interpreter startup timeouts; this is not a clean rerun. See candidate37
`runtime-diagnosis.json`, `tests.json` and `final-verification.json`.
New original eligibility/map/runtime acceptance remains pending.
Next: trace the pre-MainMenu startup boundary and change the technical hypothesis
before another candidate. Never relaunch37 or repeat an unchanged menu/intro.
Accepted10/15/29/33/36 evidence and all source/editorial/final-delivery gates remain
separate. Authorized Russian and six other asset lanes remain untouched.

## Phase0027: QA-policy menu delivery and release observed

Immutable36 completed one menu-only trial in106.572s. Original-policy passive
readiness used2 actual idle frames; QA-policy readiness used15. The public
ignoreInputWhenAppNotInFocus=False setter changed the real filter and retained
actual eligibility. One600ms process-targeted LEFT produced57 real frames:
native/Rewired/Unity down1 each, async down2; one matching frame had original
player action axes and InputHelper.FullAxis=-1,0,0. All8 keys and axes then released.
The original policy was restored and12 real idle frames observed before normal Quit.

Actual Unity focus=True throughout, with another macOS app frontmost. This does
not prove actual unfocused QA delivery or a benefit from changing the filter.
No original-policy pulse, New/intro, gameplay movement or images ran in this trial.
35's failed startup and late one-frame focus=False rejection remain separate evidence.
See localization/probes/ru-20261026-36/runtime-diagnosis.json.

Post-run text/hash cleanup verification passed: task PIDs32268/32310/32313 absent,
327 frozen dependencies (325 exact plus2 intended DLL restore/removal exceptions),
150 original references,5 source/candidate resource pairs and7 pins unchanged.
Original install/player files are unchanged, the bridge is removed and QA persistence
is empty. The isolated game naturally generated its own tfol.settings, hashed and
preserved; all nested tfol.* were excluded before launch.25 focused tests passed.

Next repair actual eligibility checks in the original-policy gameplay guards, then
prepare one fresh guarded natural-route candidate with original focus/filter/maps/
Player/story/door eligibility. Refuse New before real menu readiness and refuse DOWN
on any failed loaded guard. Do not repeat36 or force focus. The left-then-down route,
tutorial/notebook/inventory, broad source/renderer/editorial and final delivery remain
pending. Accepted10/15 visuals,29 menu and33 scoped LEFT evidence retain their limits.
The prior current summary is archived in localization/history/phase0026-summary.md.
