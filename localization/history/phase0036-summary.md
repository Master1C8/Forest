## Phase0036: focus producers traced; passive diagnostic build verified

Static original IL establishes the standalone chain: Unity's real manager focus
callback updates the Rewired callback cache, focus watcher and change dispatch.
The standalone watcher does not poll Application.isFocused; Unity's getter is a
native InternalCall. The previously unnamed other watcher tracks runInBackground.
This identifies the observation boundaries; the cause of40's loaded focus loss
remains unknown. Native engine focus behavior and callback ordering are unverified.

The existing bridge now records its own Unity focus/pause callbacks, the Unity
focusChanged event and bounded LateUpdate states, with actual frame/clocks/scene
and original Unity/Rewired eligibility. Records remain in memory until an acknowledged
snapshot (or terminal limit), avoiding concurrent heartbeat truncation. The native
helper's passive observe mode returns only task-window/frontmost PID scalars and
keeps unavailable/ambiguous identity explicit. No focus, policy, input, scene or story
workaround was added. Existing route and first-failure guards remain unchanged.
An ordinary --retain-exit wrapper now waits for the exact observer child and retains
its measured OS status; missing status remains unknown.

C# compiled against all150 pinned original managed references; passive IL and Swift
SIL readback passed. Swift compiled and performed one actual no-game/no-window scalar
observation. All55 focused tests passed; these exercise non-game child/transport,
fixture boundaries and the retained actual40 focus rejection. Unity callback tracing,
serialization and real task-window identity still need runtime verification. All14
existing guard bodies,29 consumed40 evidence files and19 live-lane input pins match.
No game was launched; candidate41 is not prepared. No image was opened/captured and no asset lane was modified.

Next: prepare one new immutable41 carrying these exact passive diagnostics, with no
launch in that preparation phase. The changed hypothesis is the first divergence of
native task-window identity, Unity callbacks/getter and Rewired cache/watcher from
menu through loaded gameplay. Preserve40/39/38 as consumed, all original policies,
accepted10/15 visuals and other valid runtime evidence. Source/special-scene,
editorial, full renderer and final delivery remain pending. Primary evidence:
`localization/source/focus-transition-20261026/{source-trace,static-build,verification}.json`.
Previous runtime summary: `localization/history/phase0035-summary.md`.
