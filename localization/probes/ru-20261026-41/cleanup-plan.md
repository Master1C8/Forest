# One-use candidate41 and normal cleanup

Preparation phase0037 launches zero games and opens zero images. This exact candidate
is prepared for one later authorized diagnostic launch, never a replay of40/39/38.
Do not rewrite frozen helpers or resources after this preparation.

Before launch: run `python3 localization/probes/ru-20261026-41/verify-preflight.py`.
Require passed static checks, no launch/observer receipts, all frozen hashes, all19
live-lane pins, original assets/player files, QA identity and empty QA persistence.
A failed prerequisite holds the launch. Do not create another candidate as a retry.

Next work phase may launch exactly once from canonical root, using Python3 and this
candidate's immutable `diagnose_newgame.py`, candidate directory, `--retain-exit` and
`--startup-diagnostics`. Preserve40's opt-in logging for comparison. The wrapper writes
its own separate `wrapper.stdout` and `wrapper.stderr`; the exact-child wait routine
exclusively creates `observer.stdout`/`observer.stderr` with `xb`. Record wrapper PID
and argv before detaching. Reconcile observer-child/launch and actual task processes
before any other launch. Missing numeric status remains unknown. Do not redirect
wrapper output to the observer filenames or infer its exit from process absence.

Observer readiness limit300s; source-bound intro observation uses its separate actual
frame/progression gates. Passive focus capture is bounded1024 records/420s and native
observations512. It records actual callbacks/getter/cache/watcher and task-window PID,
windowID/frontmostPid. No names/owner content, activation or focus-policy workaround.
Stop at first failed/unknown command or eligibility boundary. Never wait indefinitely
for focus. Preserve terminal pair/graph/response/input/focus/root-body/door/pair/sweep,
LEFT-before-DOWN gates; no blind repeat or alternate story/axis/transform path.

The unchanged normal finally path acknowledges restore-input-policy (no-op under
original policy), then quit; waits30s for exact game/crash processes; restores the
original Assembly-CSharp.dll in the isolated QA game and removes ForestProbe.dll only
when those processes are absent. The original installation/player files stay intact.
Do not broadly kill Wine/CrossOver or stop any authorized translation lane. Unknown
pending commands require reconciliation; do not overwrite or resubmit them.

After actual observer and wrapper terminate, run frozen `verify-postrun.py`. It checks
all frozen bytes with exactly the two cleanup DLL exceptions, originals/all19 pins,
resource pairs/catalog/app identity, owner files, exact process absence, empty QA
persistence and the retained numeric exact-child exit. Generated QA tfol.* files in the
isolated copy are recorded and preserved. A failed route is not runtime acceptance.
No screenshot review or localization-delivery gate can pass from these static checks.
