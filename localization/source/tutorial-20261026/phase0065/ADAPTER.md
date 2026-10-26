# Phase0065: shipped native Quit consumer readback

Text-only static work. Actual coordinator PID78315 is explicitly launched with
`--ignore-user-config --model gpt-6.1-sol`, OpenAI/high and multi_agent disabled.
No agents, nested model jobs, images, game launches, source predicates, callbacks,
focus/input changes, publication or deployment. Seven asset lanes remain independent
and read-only; technical lane alone owns Git/index. Actual worker usage is unknown;
parent accounts from request telemetry.

## Applicability and reproducible readback

Run `python3 localization/source/tutorial-20261026/phase0065/inspect-native-quit.py`.
This reads files and invokes only static Apple binary inspection tools. It checks
five newly pinned installed files plus the three external startup pins from52.
`native-consumers.json` records hashes, PE imports/strings, Objective-C methods,
Mach-O UUID and local SDK enum/reason definitions. Six bounded function excerpts
are retained in five assembly files; two PE ranges share `windows-quit.asm.txt`.

Installed CrossOver is26.3.0.39832, BuildTag `cxoffice-26.3.0rc2`, build timestamp
20260715T103801Z. `winemac.so` is x86_64, UUID DF65B8E0-BB5D-31C5-BAE1-87E3AA493D35.
The current installed PE driver hash is3d88a8e1f918e7593b396fff995ac344f7297eab74d3966eb6f1b1f1821b4955.
The current installed Unix driver hash isa46e1c63a5096210626d64ef6c62ddea7632f95dbcf437b1a3bf006d43dcf532.
Candidate52's task log records builtin winemac.drv loaded in Windows00cc (204),
but did not hash these two driver files at load time. Current readback therefore
establishes the installed consumer, not retrospective byte identity of52's image.
The unchanged three startup pins are corroboration, not a substitute for that gap.
A future candidate must freeze both new driver hashes before its own launch.
No generic upstream Wine revision is treated as this shipped implementation.

## New concrete consumer knowledge

1. `WineApplicationController applicationShouldTerminate:` at0xcaa0 reads the
   current AppleEvent and its `why?` attribute. It constructs an event with type2,
   maps `logo`/`rlgo` to reason1, `rrst` to2, `rsdn` to3 and other values to0.
   It locks `eventQueues` (ivar32, lock40), posts to each registered queue, and
   returns2 (`NSTerminateLater`) when the queue list is nonempty; the empty-list
   branch returns1 (`NSTerminateNow`). Candidate52's actual AppKit Later log is
   consistent with that route; it does not reveal which queue/Windows message ran.
2. Unix handler0x40c00, identified by its referenced exact function string
   `macdrv_app_quit_requested`, translates reason1 to flag0x80000000, otherwise0,
   then calls `KeUserModeCallback` with its stored callback pointer when nonzero.
   This is a native driver boundary, separate from the managed lifecycle JSONL.
   The type2 dispatcher-table link is not independently decoded here; the future
   handler trace must establish actual event delivery rather than assume it.
3. PE request function0x180002520 identifies itself in trace strings as
   `macdrv_app_quit_request`. It enumerates same-process windows through helper
   0x180001f90, allocates32 initial slots, sets aggregate result TRUE, and sends
   message0x11 (`WM_QUERYENDSESSION`) using imported `SendMessageCallbackW`.
   A query failure with ERROR_INVALID_WINDOW_HANDLE0x578 is supplied as success;
   other query-send failures become refusal. A zero-window list returns without
   entering the callbacks; do not infer a completed reply for that branch.
4. PE callback0x180002980 identifies itself as `quit_callback`. A FALSE query
   response from a still-existing window clears the aggregate result and replies
   FALSE early; a destroyed-window apparent refusal is ignored. After all query
   callbacks it sends0x16 (`WM_ENDSESSION`) with the aggregate result. After all
   end-session callbacks, it replies if necessary and, when result remains TRUE,
   calls IAT0x180008250: `kernel32.dll!TerminateProcess`, with RCX=-1/EDX=0 at
   0x180002bea..0x180002bf3. This is a real shipped abrupt process-termination
   route; neither its presence nor AppKit YES proves the call executed in52.
5. Cocoa reply handler0xcca0 forwards YES/NO to `replyToApplicationShouldTerminate:`.
   Before YES, if not already externally terminating (ivar328), it also calls
   `postExternalQuitRequest`. The latter can distribute
   `WineExternalQuitRequestNotification`; its receiver filters SourcePID/AUMID/
   ExeName/WineConfigDir/WinePrefix, marks its external-termination flag, and calls
   NSApp terminate:. This reveals another installed propagation mechanism; there
   is no observed notification delivery or evidence attributing52 to this path.

The last fact prevents equating every Cocoa quit with a Unity callback. It does
not identify an upstream human/system/automation action or override the actual
received `(aevt,quit)`/Dock evidence. No crash, OOM, source exception, numerical
game status or owner action is established. Missing managed quit/destroy rows
remain missing observations; the new static route is a hypothesis to distinguish.

## A material passive diagnostic is available

The exact PE trace gates test bit0x08 of the `macdrv` channel byte at0x180003000.
Existing messages include query send/result, aggregate reply, end-session send/
completion and `terminating process`. Candidate52 enabled timestamp/pid/tid,
loaddll/seh/process after `-all`; it did not enable macdrv. Missing such messages
in52 cannot reject this path. `diagnostic-plan.json` specifies the changed boundary
and finite interpretation rules for a future one-use candidate.

The next work must add narrowly retained termination-only trace collection to the
existing task stderr path before considering a launch. Do not store or inspect
broad macdrv input/window/clipboard records, owner content, global logs or another
application's history. Keep actual PID identity, queue/readiness/input/deadline/
no-replay guards, original181/Bucky limits and restoration requirements. Trace
availability must be checked as part of this new candidate's own observation;
absence is unknown, never a passed termination branch. Do not inject a message
or callback, veto quit or alter game source/physics/authority just to exercise it.

Regression: AppKit Later/YES plus missing managed lifecycle rows is not a source
failure diagnosis; read the actual installed Windows termination consumer, pin
its version/hash and distinguish callback/message/termination evidence. An
unchanged debug mask cannot observe trace gates disabled by `-all`.

No53 exists from this phase. All consumed43..52 inputs/evidence and pending51/52
commands are preserved; no compiler/preflight rerun on52. Accepted10/15/47/48
visuals and50 route stay scoped and unchanged. Initial spawn/other three
introductions/notebook/Bucky loaded consumers, complete source/BGDatabase/parser/
special-scene, editorial/final fonts/licenses/resources and local delivery remain
pending. Provisional asset drafting continues under the owner exception.
