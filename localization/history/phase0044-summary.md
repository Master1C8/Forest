## Phase0044: redundant successful-transport scan removed; overhead bounded

The offline four-file attribution of consumed42 records113 commands and519 lifetime
events. Command brackets occupy192.339492s of a295.703486s span, with103.363994s in
mixed gaps. ACK-to-reaped intervals total98.514461s; the overlapping returned-to-reaped
intervals total40.958235s. These are measured brackets, not pure process-scan costs or
estimates of saved time. Native focus/file/initial-scan/sleep shares and source-only
waiting cannot be isolated from the old samples. Unity realtime and frame deltas
continue across host work and must not be added to it.

After a helper has already been reaped by communicate, its exact exit0/ACK and fresh
transport-returned game check now permit the final transport-reaped record to reuse
that dated process sample. The record explicitly names the source sample and time.
Before-command, in-flight, returned, failure and next-command process checks remain
fresh; no cached success authorizes another command. The final record still checks
pending bytes and polls the launcher. Failed/running/unknown commands retain the hold
and fresh final observation. All70 focused tests pass, including a real helper success
and matching next-command game-loss control; Wine/Unity and timing are fixtures.

Minimal monotonic scan and passive-focus/native brackets now distinguish those costs
on a future run. They do not measure append/flush time. IntroObservationBudget, main,
all other functions/classes, hard/idle limits, original timing and source/input/route
and focus guards are byte-identical. No native speedup or progression is claimed.

Evidence: `localization/source/process-lifetime-20261026/observation-overhead-repair.json`,
`phase0044-overhead-attribution.json`, `phase0044-tests.json` and
`phase0044-verification.json`; reproducible analyzer `tools/attribute_intro_observation.py`.
All19 frozen lane inputs are unchanged. No live QA processes, launch, new candidate,
story command or image occurred. Candidate42 remains consumed/stopped with its unknown
exit timing and original failures preserved; phase0043 cleanup remains authoritative.
Accepted10/15 visuals,29/36 menu,33 scopedLEFT and40 intro remain reusable. Complete
source/special-scene/renderer/editorial/delivery acceptance is still pending. All7
owner-authorized asset lanes continue untouched. Next: prepare a new immutable43 with
this repair and complete protection preflight before one bounded authorized runtime.
Previous summary: `localization/history/phase0043-summary.md`.
