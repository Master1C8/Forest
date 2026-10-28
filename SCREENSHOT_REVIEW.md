# Screenshot review

New review work uses the shared queue maintained in the canonical SiteForMods checkout.
Existing capture and review processes are not modified or redirected.

New queue initialization automatically prepares WebP quality 80 copies, with
longest edge at most 1280 pixels and no upscaling. Originals, upload files
and source receipts remain unchanged. Native and hosted source bindings
are pinned separately. This changes model input, not release assets.

Entry point: `python3 tools/review_screenshots.py`. Read the complete protocol at
`../SiteForMods/tools/codex-skills/screenshot-common/references/QUEUE.md`.

Run `python3 tools/review_screenshots.py --help` for options. Initialization requires a complete
native manifest or hosted export, a compact acceptance context, explicit
`--model gpt-6.1-sol --reasoning high`, and paths inside this project.
Use a new queue directory outside upload images. All inspection commands
remain text-only; `run` submits nothing without `--execute`.

Only already authorized review may use `run --execute` (one packet) or
`run --execute --all` (sequential fresh processes). Existing matching ledger
judgments are retained after the prior owner has completed and released it.
Each new attempt is immutable, externally timed and never automatically retried.
A held queue requires status inspection and explicit reconciliation; never
delete an active lock or recapture valid originals because a model disconnected.

This entry point changes no translation, runtime, complete visual coverage,
RTL, publication or server permission requirements.

Before capture acceptance, establish the actual workload, including required
sprite/texture resources. Loaded string rows alone do not prove that a notification
icon is available in a staged menu. Regression:48 valid item rows with a null
selected sprite must reject before visual acceptance; load the original fixture
scene through its real route and bind the sprite. Record actual PNG dimensions
and independent client/physical-screen diagnostics instead of assuming launch
arguments define the rendered viewport. A changed disposable screen-resolution
field is distinct from a changed savegame; verify both boundaries explicitly.

For native Text, compare effective ancestor opacity to the authored color alpha,
not an arbitrary0.9 threshold. The inventory's original17274/17292 labels use
black at alpha0.6509804. Preserve that color. Preferred text height includes
renderer padding and is only a warning by itself: retain it, check generated
characters and glyph vertices against active masks, then inspect the native
frame. Regression: the complete16-character title «Бутылочка смазки» has source
alpha0.6509804 and preferred24.5 versus rect23; neither metric alone proves
invisibility or clipping. Actual missing characters/mask clipping/readability
remain defects or needs-review, never automatic passes.

Scene-loading readiness commands may need more than the generic20-second bridge
acknowledgement deadline. The inventory runner gives the same pending request75
seconds; a timeout remains an unknown outcome. Reconcile its action log and exact
live process before resubmission or restart. Regression: items-ready is consumed
during original Continue loading and acknowledged after the observer times out;
the same task-owned process subsequently reaches CentralForest. Adopt its verified
remaining workload and preserve the failed initial receipts instead of relaunching
the game or resetting the fixture. Do not rewrite live execution snapshots.

The inventory glitch producer preserves bare CR inside its32-character fake-code
fragment after replacing LF with spaces. TMP resets the pen horizontally for CR,
so complete character counts, preferred height and in-rect vertices can all pass
while the action suffix visibly overprints code. Check both an original-produced
CR fragment and a non-CR control. Select, read back and deactivate each fragment
in one bridge Update so the0.5s callback cannot replace it between commands;
restore the fixture's PRNG state, wait one inactive game-time interval, and verify
the unchanged text again after capture. A mode label alone is not case coverage.
Preserve the logical producer/trace/substring/
timer and test the final display adapter separately: CR becomes an actual line
break and the unchanged action suffix gets its own line. Enumerate all finite
fragment starts for the current multiline box and review both native frames.
