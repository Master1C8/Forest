## Phase0039: native Quit event found; command lifetime observer repaired

Static investigation of consumed41 found exact PID4350 handling a `Quit AppleEvent`
at14:23:27.610391 UTC, approving termination, then `proc_exit` at14:23:27.758757.
The sender and numeric launcher/game exit remain unknown. The earlier Dock menu
assertion does not identify a sender; focus loss and crash-handler startup do not
establish causation. The retained final `dump-intro` command and missing receipt do
not prove that `DumpIntro` ran: the pinned bridge deletes the command before dispatch.
The raw75-second task-PID query and seven exact termination rows are preserved in
`localization/source/process-lifetime-20261026/` with query/provenance and diagnosis.

The existing observer now retains its exact launcher handle and records UTC/monotonic
process/command boundaries before, during and after ACK waits and cleanup. Its real
game selector excludes Wine wrappers and crash helpers. A disappearing/ambiguous game
fails at that boundary; only the ordinary file-transport child is reaped. A persistent
unresolved-command hold prevents further commands even when the bridge has already
dequeued the unknown action. Successful ACK clears the hold; acknowledged Quit may
remove the game. Future launch receipts record actual current HEAD and launch UTC.
Regression: an exited wrapper with a surviving game accepts one real file ACK; a live
wrapper/crash helper without the real game cannot submit; disappearance during ACK
wait preserves the command and holds every later submission, including cleanup.

Focused tests cover real Python child/file transport plus explicitly mocked game
process rows/bridge producers. They do not prove Wine/Unity behavior. All14 existing
route/story/input/focus/geometry/sweep guard bodies,38 consumed41 evidence hashes,
seven immutable binary/source pins and19 live-lane inputs remain unchanged. Zero game
launches, images or new runtime candidates in this phase. See `tests.json` and
`verification.json` for exact results and boundaries.

Next: prepare one new immutable42 with this corrected observer and unchanged original
policy/bridge/resource recipe, freezing every later-read dependency. No launch during
preparation; never replay41/40/39/38 or resubmit pending41. Accepted10/15 visuals,
29/36 menu,33 scopedLEFT and40 intro remain reusable. Full source/special-scene,
natural route, renderer, editorial and final delivery gates remain pending. All seven
parallel asset lanes remain owner-authorized and untouched. Previous phase summary:
`localization/history/phase0038-summary.md`.

