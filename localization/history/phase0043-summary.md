## Phase0043: deadline accounting repaired; consumed42 cleaned up normally

The canonical command observer now captures the exact helper's output in temporary
files. If process/file bookkeeping crosses the absolute deadline, it polls the exact
child and consumes an already completed result without another wait or submission.
Exit0, an exact first-line command ACK and unique real game presence (except Quit)
are required before clearing the hold. Running/nonzero/missing/wrong-ACK outcomes
retain the hold and reject restore/Quit/replay; only the exact transport is reaped.
The original IntroObservationBudget, main loop and all source/input/route guards are
unchanged. Completing a transport never extends the story budget.

All68 focused tests pass, including a real command.py/ACK/exit0 positive control
which completes while bookkeeping crosses the deadline. Its stage budget still
rejects further story work. Matching running, exit7, absent ACK and overlapping
wrong ACK controls exercise their intended rejection boundaries. Wine/Unity identities
and the clock are fixtures; these tests establish transport handling, not native
progression or renderer acceptance. The initial test invocation had one nonexistent
class-name error; the complete corrected suite and final hashes are recorded.

A separate hash/process-bound reconciliation confirmed consumed42's single exact
Continue145:214 ACK, applied receipt and retained transport19865 exit0. Its actual
exit instant relative to the old deadline remains unknown. No story action was
replayed. The normal no-op restore-input-policy and Quit each received a new exact
ACK and helper exit0. All exact QA launcher/game/crash processes disappeared before
the original QA assembly was restored and ForestProbe.dll removed. Numeric launcher
and game exit codes remain unknown. The original observer exit1, failed cleanup,
failed final-verification and all37 immutable snapshot files remain intact.

The separately named phase0043 final verification passes all15 checks:385 frozen
files unchanged with the2 intended DLL cleanup exceptions, original150 managed and
262 other files,5 resource pairs,19 live-lane pins and owner saves unchanged.
QA-generated tfol.settings is preserved; QA persistence is empty. Zero new game
launches, prepared candidates, story commands or images occurred in this phase.

Evidence: `localization/source/process-lifetime-20261026/command-deadline-repair.json`
and `phase0043-tests.json`; consumed42's separate `phase0043-command-reconciliation.json`,
`phase0043-cleanup.json` and `phase0043-final-verification.json`. Candidate42 remains
a failed consumed runtime through BunnyHouse145:214; no post-Continue state or terminal
pair was observed. Accepted10/15 visuals,29/36 menu,33 scopedLEFT and40 intro remain
reusable. Natural CentralForest/tutorial/notebook/inventory and complete source,
special-scene/renderer/editorial/final delivery remain pending. All7 authorized asset
lanes continue untouched. Next: bounded static attribution of consumed42 observation
overhead, before another runtime investment; preserve hard/idle budgets and all guards.
Previous summary: `localization/history/phase0042-summary.md`.
