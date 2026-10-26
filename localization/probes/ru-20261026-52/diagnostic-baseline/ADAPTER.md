# Phase0063: native quit diagnosis and passive evidence

Text-only work under actual PID75736, explicitly gpt-6.1-sol/high/OpenAI with
multi_agent disabled. No agents, nested model jobs, game launch, native input,
images opened, publication or deployment. All seven asset lanes remain read-only
and independent; technical lane alone owns the index and commits.

## Candidate51: narrower observed boundary

The new exact-PID, five-second unified-log read establishes this sequence:

- 2026-10-27 03:23:15.148+07:00, native75065 receives `(aevt,quit)` with
  `target=Dock` in Apple's event description.
- 03:23:15.149, AppKit explicitly handles a Quit AppleEvent and checks termination.
- 03:23:15.150, the application delegate returns NSTerminateLater.
- 03:23:16.001, the application replies YES and termination is approved.

`candidate51-native-quit.txt` contains only these exact75065 event/termination
lines. The upstream human/system/automation action remains unknown. This does
not prove owner action, a crash, OOM, a source consumer exception or a numeric
game exit status. In particular, argv-selector absence and actual OS absence
were not measured as interchangeable boundaries in51.

The original last acknowledged save dump at20:23:15.793Z falls after the native
request and before its approval. The later pending dump-intro has no ACK and
remains unchanged. No request is replayed or deleted. Prior runtime evidence is
historical and is not rewritten to pretend the new information was known then.

`original/` contains repeatably extracted, hash-bound Assembly-CSharp shutdown
consumers: five Application.Quit instructions in four methods, including guarded
QuitHelper, debug save clearing, DevRoom input and console quit. Main-menu and
pause quit call QuitHelper. These are static possible paths, not observed calls.
DumpIntro and its compiled body remain unchanged; no new consumer failure is
established. Do not invoke any of these shutdown/debug methods as a diagnostic.

## Changed diagnostic input for a future candidate52

The canonical disposable bridge now appends bounded `lifecycle.jsonl` scalar rows
for Awake, 1Hz heartbeat, command-read/ACK/failure, Unity's quitting event,
OnApplicationQuit and OnDestroy. Rows bind Unity frame/realtime/UTC/Windows PID,
scene and the current command. A final `limit` row bounds the log to4096 rows;
IO failure disables further rows and emits a diagnostic. Missing rows remain
unknown: they cannot prove an absent callback or a crash. No wantsToQuit veto,
source predicate invocation, callback replay, focus/input policy change or
story/authority/physics write was added. Existing restoration remains intact.

The host records a separate numeric PID/ppid/lstart/state/executable sample for
the first unique argv-matched game and retains that PID/birth when argv vanishes.
It distinguishes same-PID/birth presence, absence, PID reuse and unknown ps
results. ps targets only the previously selected PID, has a2s timeout and never
signals/waits for the game. lstart has one-second precision and the samples are
sequential, not atomic identity proof. Reused transport samples retain their
actual sample times. Numeric evidence NEVER substitutes for the existing exact
argv guard or supplies a numeric game exit code. A vanished argv still holds all
further commands, even when the numeric PID remains alive.

## Verification and boundaries

Both fresh original/synthetic bridges compile against the exact150 original
references. In each mode65 old bodies are byte-identical in IL text,14 differ
only in verified compiler-generated ordinals,4 contain the intended diagnostic
insertions, and4 logger/row helpers are added. Removing precisely the diagnostic
insertions recovers the ENTIRE old bridge source byte-for-byte. All14 original
host guards, main/default New, ContinueObservationBudget and every other old
host function remain exact; only observe_lifetime adds diagnostic data.
`compiled-readback/comparison.json` and immutable full IL record the comparison.
The unchanged injector itself is not rebuilt or installed in this phase.

133 focused tests pass. The129 existing tests cover the unchanged finite host;
four new tests exercise real ps/child lifetime, argv-loss refusal, PID reuse,
malformed/absent/timed-out samples and ambiguous initial binding. Unity argv,
source state and native input remain fixtures. Earlier test-fixture failures and
the actual corrections are accounted in tests.json; they are not runtime failures.
No Unity callback or new runtime acceptance is claimed.

Regression recipe: after a received Quit AppleEvent, record its actual sequence
instead of inferring a crash from UnityCrashHandler. If argv disappears while
numeric PID/birth still exists, preserve both observations and reject the next
command. Never accept numeric evidence as an alternative selector. Missing logger
rows, ps errors or birth ambiguity remain unknown rather than proving exit.

Next freeze a NEW52 using these exact changed sources, all later-read helpers,
133-test binding, both bridge modes/150 references, QA43 fixture, all19 input
pins and original181/Bucky141 plans. Do not rerun51 preparation/compiler/preflight/
runtime. The old0062 preparation requires129/exact0061 and must not simply be run
with a different directory. Reuse verified resource bytes/readback, preserve all
source/input/deadline/no-replay/native-event guards, then one authorized runtime
may follow after full immutable preflight. No accepted visuals are invalidated
by this diagnostic-only source preparation; new runtime remains not-run.

Preservation count correction: original-game-files.json has262 TOTAL files,
including150 managed DLLs. Historical field names saying “other262” overlap that
subset. The first0063 preservation assertion incorrectly expected412 distinct
files and failed on count alone; all262 hashes matched. The phase recipe now
checks262 total/150 subset explicitly, avoiding duplicate coverage accounting.
All11 preservation checks pass, including358 frozen51 dependencies,19 lane pins,
owner files, pending command and QA cleanup. No historical receipt is rewritten.
