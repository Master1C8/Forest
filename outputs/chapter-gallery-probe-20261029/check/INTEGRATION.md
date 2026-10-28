# Finite chapter/gallery probe handoff

Scope: static implementation only, game0.45, bounded Russian134 case. No game,
GUI, screenshot, model queue, installer, production or Git operation ran here.
Root README/CHECKPOINT and the adapter/builder/targets/fonts/textures are untouched.
The final compile is `compile-03/compile.json`; it targets readonly candidate17
assemblies and includes the isolated product/readiness-file branch. The original
bridge also compiles without the new conditional define in `legacy-compile-01/`.

## Delivered interfaces

- `tools/probe/ChapterGalleryUiProbe.cs`: original data/cache readback, gallery
  numbering and hint consumer, OOS setter and description setter; geometry and
  restoration. Conditional dispatch is in ForestProbe.cs.
- `tools/probe/prepare_bridge.py --chapter-gallery-compile-only <new-output>
  --managed <candidate-managed>`: no installation or game launch. Function
  `compile_chapter_gallery(output, managed, product)` also pins the isolated
  product and readiness file for a parent-staged runtime.
- `tools/probe/capture_chapter_gallery_ui.py`: `prepare`, `capture`, `reconcile`,
  `finish`. No game launcher, navigation, process termination or model calls.
- `tools/prepare_chapter_gallery_review.py`: complete native manifest/context
  preparation only. Shared `tools/review_screenshots.py` owns future compressed
  review queue initialization; no historical locale queue is used.

## Parent prerequisites

1. Build the accepted134 case through the existing readonly adapter/builder.
   Genuine `load_inputs(locale='ru')` now passes; its accepted target SHA is in
   `input-evidence.json`. This finding does not accept a built candidate.
2. Verify the complete candidate and write its `chapter-gallery-readback.json`
   from actual readbacks, using this contract:

   - `status: complete-static-readback`, `caseId: chapter-titles-and-gallery-hints`,
     `locale: ru`, `buildSha256`, `targetSha256`, exact adapter `sourcePins`,
     `baselineBuildSha256` of candidate17, and `files` mapping every build.json
     artifact path to its actual probeSha256.
   - `bg`: actual accepted adapter `chapterGalleryDatabaseProjection` receipt:
     selectedCells113, absentStates16, unselectedColumns286, complete113 target
     ID/hash readback, exact preservation/restoration evidence.
   - `native`: actual two `chapterGalleryInitialProjection` receipts, with all18
     selected ID/target hashes and `/m_text` selectors. Append
     `postSaveReadback: true` and `allOtherObjectBytesPreserved: true` ONLY after
     independently verifying the saved assets and immediate-prior object/tree
     preservation at these selectors. Builder plan receipts alone do not prove
     that boundary. Preserve existing candidate17 typography/resource changes.
   - `managed`: actual `chapterGalleryCodeProjection`/code readback receipt,
     source hash equal to adapter MANAGED_BEFORE, three selected strings,
     ten protected strings, full method reversal/readback and actual target DLL.

   Candidate files outside resources.assets/sharedassets0.assets/
   sharedassets2.assets/Managed/Assembly-CSharp.dll must remain candidate17-exact.
   The guard rejects incomplete/stale/draft receipts. Do not set true flags merely
   to make preparation proceed.
3. Stage an unhooked independent copy under `localization/probes/`, preserving
   the existing isolation workflow. Actual PlayerSettings AND app.info AND the
   staged build.json identity must be VNRevivalQA /
   `ForestRuChapterGalleryProbe<digits_and_underscores>`. Stage no player files.
   Supply `qa-preparation.json` with parentBuild, parentBuildSha256,
   ownerFilesUsed=false, fixtureDirectory and fixtureManifestSha256. Its generated
   fixture manifest must declare originalOwnerFilesUsed=false, with only
   tfol.settings and tfol.savegame; both staged files must match those inputs.
   All build artifact hashes must match the candidate, except the isolated
   globalgamemanagers identity, whose staged hash must match staged build.json.
   No old hook, ForestProbe.dll or localized-original backup may be present.
4. With that isolated game closed, run:

```text
python3 -B tools/probe/capture_chapter_gallery_ui.py prepare --locale ru --candidate <accepted-complete-candidate> --run <parent-staged-run>
```

Preparation snapshots the accepted adapter/source/dependencies/evidence, all
project runtime helpers, injector and C# sources before compilation/installation.
It compiles/installs only into the staged copy and writes final execution pins
last. Partial writes are visible, not a transaction. After interruption, inspect
that existing attempt before selecting another output; never run it without its
complete final preparation/pins receipt or rewrite a live snapshot.

## Later parent-owned execution

The parent retains game/runtime and route ownership. This assignment did not
start that work. Before attachment, the parent writes task-process.json for the
actual surviving game process: integer pid, executable equal to the run's exact
absolute `game/The Forest of Love.exe` path, and psIdentity equal to the trimmed
full output of `ps -p <pid> -o lstart= -o command=`. That identity must contain the
exact run executable path. A launcher PID that already exited is not enough;
reconcile actual children first. The runner never kills or relaunches anything.

Parent establishes each visible original native screen in turn. The harness
requires one existing active scene consumer, its real text root, enabled labels,
and known gallery/OOS hierarchy membership. It does not manufacture an active
root. An unavailable/ambiguous surface or camera is a concrete runtime blocker,
not permission to activate AdventureName GO2510 or spoof progression/unlocks.
Original routes/native binding readiness still need runtime verification.

Run the frozen helper for each ready surface:

```text
python3 -B <run>/cg-helpers/capture_chapter_gallery_ui.py capture --run <run> --surface gallery
python3 -B <run>/cg-helpers/capture_chapter_gallery_ui.py capture --run <run> --surface oos
python3 -B <run>/cg-helpers/capture_chapter_gallery_ui.py capture --run <run> --surface description
```

Each surface reads all113 values and16 absences from DB entities and manifest
records. Gallery additionally checks all59 original option identities. It measures
3363 hint/identifier combinations (57x59), four fallback branches,28 OOS wrapped
titles and28 description fixtures:3423 total. Gallery arguments are deliberately
conservative cross-product fixtures, including six hints without configured
selection options; they do not prove actual selectable progression. Missing
record is a temporary removed map entry; other hints use a shallow clone. The map,
original record and static fields restore before that command returns.

Original gallery methods construct numbering and exactly two LF separators.
OOS uses the original setter with the pinned `''{0}''` literal as a pure argument
fixture. Calling BaseSpawner would cause delayed callbacks/version effects and
is deliberately outside this probe; its actual predicates remain untested.
Descriptions call original UpdateTooltipText. Original typography/layout is never
repaired or fit by the harness. It records generated character sequence, actual
per-character fonts/glyphs/point sizes, overflow, mesh bounds, masks, opacity and
measured screen/physical dimensions. Measurements are observations, not visual
judgments. Any native binding mismatch fails closed and requires parent evidence.

Representatives are selected only after complete per-surface measurements:
tallest, widest, longest text and smallest actual glyph point size per branch,
plus a representative for each observed issue class. All measured issue IDs stay
explicit. Captures include the entire native frame; every selected frame requires
review, and unpictured issue cases are not accepted by inference. No capture is
required for nonexistent absent text.

Every command gets a durable offset/action receipt.75s transport waiting and15s
same-request late ACK reconciliation never resubmit an unknown command. On an
unknown result, preserve the process/request and use only:

```text
python3 -B <run>/cg-helpers/capture_chapter_gallery_ui.py reconcile --run <run> --receipt <run>/cg-command-receipts/<existing-receipt>.json
```

A partial surface attempt remains incomplete, even if an ACK is later recovered.
No automatic surface replay/resume is implemented; the parent must account for
its exact completed work and any live process before choosing a subsequent action.
A known failed display action permits only the restoration command. An unknown
command blocks new restoration commands as well; pending requests are never
replaced. Native text is normally restored at the end of each surface.

After the parent closes this exact task-owned game, the frozen `finish --run`
requires all three complete receipts and no surviving task process, restores the
localized assembly/removes the bridge, independently verifies unchanged parent
artifacts and disposable save bytes, and separately checks settings resolution
changes with the existing fixture verifier. It writes cg-completion.json last.
A fixture failure or partial restoration does not create completion; inspect and
reconcile rather than blindly rerunning finish against changed pins.

Then use the frozen prepare_chapter_gallery_review.py with --run and --output
inside localization/visual-qa. It pins every original frame and complete finite
measurements/restoration/acceptance provenance and writes manifest/context only.
The parent may separately initialize shared review through
`python3 tools/review_screenshots.py init`, explicit Sol/high, using the original
run as --root. That entry prepares separate WebP80 <=1280 copies; do not replace
original PNGs or feed images into this coordinator. Every future review request
retains its own authorization and fresh-process requirements.

## Remaining gates

Complete candidate, parent staging, actual native routes/camera bindings, all3423
runtime observations, save/settings restoration and every representative frame
are pending. Six inactive AdventureName initial selectors remain reachability
unknown; live Adventure.Title is a separate case. Ordinary translation entry,
global pretranslation, whole-game and release gates remain false. No automatic
follow-up or Git integration is performed here; the parent owns both integration
and usage accounting.
