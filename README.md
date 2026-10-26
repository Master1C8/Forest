# The Forest of Love: Russian localization work

## Current Russian localization

The owner selected standard localization and requested Russian (`ru`). The current
state is `CHECKPOINT.json`; the earlier export-only checkpoint is preserved in
`localization/history/asset-preparation-checkpoint.json`. The English and Russian
171-entry glossary snapshots in `localization/glossary/` match the accepted canonical
SiteForMods layers. This technical lane has authored no ordinary game translation. The owner-authorized parallel asset lane drafts in `localization/ru-assets/`; its work is separate and is not counted here. This is an unfinished localization, not a release.
The verified local archive `dist/forest-ru-technical-checkpoint-20261026.zip` contains
source candidates, glossary snapshots, tools and machine evidence, with exact ZIP
member readback. It contains no game assets, inspection DLL, installer or translated
corpus. Native review is recorded separately in the checkpoint and probe ledger.

Phase0013 traced the three inventory tickers (six native Text fields) and seven
adjacent quest fields. Phase0014 proved the notebook marker188 binds **225:195**,
the final line of PRIMARY129 → 191 → 192 → 193 → 194 → 195; marker188 is disconnected
control metadata. Candidate18 confirmed that loaded binding and the unavailable
Fast Forward route: all32 global chapters locked, only original New and Back buttons.

Phase0015 followed original New in fresh isolated candidates19 and20, reusing all
five candidate17 resources byte-for-byte. The game naturally traversed
StartMenu → SoftResetLoadingScene → ChapterSelect → IntroForest. Candidate19
verified all three gameplay tickers and their six Text bindings for the first time:
FixedWidths alone is active, MasterLog is closed, the notebook is unlearned and
an original cutscene is active. Serialized Driftwood placeholders and active Button
entries behind that closed panel do not establish visible or permitted inventory.

Candidate20 stopped before any Continue because the first active conversation was
**109:0**, the original `system/dynamicConversation` wrapper. Source tracing proves
`DialogueService.PlayDialogue` fires109 before installing the selected arc links.
The corrected recipe waits on its empty bootstrap nodes0/5/8 with the actual
`NewGame_Intro` identity and a pinned original named arc, then permits normal Continue
only on actual145 content. This repair compiles; its runtime remains untested.
The original IntroForest waypoint/cutscene flow leads to BunnyHouse and another
original intro stage; neither intro completion nor notebook access has been accepted.

The loaded notebook conversation is `GossipQuest_GetTheNotebook`, primary actor
`Scarlett`, quest `Act1_GossipQuest`. Its FullAvailabilityRule subcondition types
were read without evaluating them; concrete nested operands, actor eligibility and
listener multiplicity remain unverified. The updated read-only bridge prepares that
next measurement without running random-chance getters or forcing narrative state.

Both runs quit normally; their exact game/wrapper/crash-helper processes are absent,
the bridge is removed, and the original QA assembly is restored. Five candidate and
five original resource hashes and all seven frozen asset-lane inputs are unchanged.
Candidate20 also verifies every original `tfol.*` file recursively. Zero images were
captured or opened. See `localization/source/intro-20261026/source-trace.json` and
`localization/probes/ru-20261026-20/runtime-diagnosis.json` for the current boundary.

Reproduce the13 bounded original consumer groups and source-bound intro graph with
`python3 tools/inspect_newgame_source.py --output <new-project-evidence-directory>`.
For the next new runtime copy, freeze the updated `diagnose_newgame.py`, `command.py`,
current `intro-graph.json`, build/pin receipts and compiled bridge sources before launch.
Do not rerun or overwrite candidates18–20. `diagnose_notebook.py` remains menu-only;
`diagnose_newgame.py` targets ordinary intro completion but its corrected109 guard
and recursive condition fields still require runtime verification. Only after all
original MasterLog guards pass may the normal page3/ordinary-empty-cell probe proceed.

The quest consumer has three `Contains("lost photos")` tests over displayed history
before appending photo counters. This needs a bounded consumer adapter before localized
logs are integrated. Compiled visible fragments and protected quest/actor/trigger
identities are recorded in the supplemental source finding; frozen source and special
scene inputs remain unchanged. Neither this discovery nor the static candidate passes
runtime, visual, full source, special-scene or editorial acceptance.

The first CLI session ended at the bounded protocol's two-original context limit.
The owner authorizes sequential technical CLI sessions with clean contexts and a
parallel asset-translation CLI. The technical lane alone owns Git transactions;
the asset lane owns only `localization/ru-assets/` and its operational directory. `tools/run_serial_ru.py` preserves
that boundary: text-only repair/capture phases hand off to fresh bounded review-only
phases, using the skill's external review deadline. Independent fresh editorial
review is authorized sequentially and remains unperformed until actual evidence exists.
The owner permits provisional asset drafting before remaining renderer/source
acceptance; this exception does not pass any technical or editorial gate.

Every CLI phase explicitly pins `gpt-6.1-sol / high / OpenAI` and rejects Astra before
a request. No agents, nested model jobs, external translation services, publication or
deployment are authorized by this continuation. The active CLI phase exclusively owns
technical project edits and the Git index; the parent monitors the serial job. The updated
scope and phase-result contract are in `localization/CLI-TASK.md`.

Rebuild the current bounded candidate into a **new** probe directory with:

```sh
.venv-assets314/bin/python tools/build_renderer_probe.py --output localization/probes/ru-next --sample-surface new-game --repair-cyrillic-metrics --coherent-legacy-face --coherent-tmp-face
python3 tools/probe/prepare_bridge.py localization/probes/ru-next
```

The builder refuses an existing output. `prepare_bridge.py` also refuses an existing
bridge snapshot; reconcile partial/live execution rather than overwriting it. The
runtime command and exact hashes are in the versioned launch/build receipts. Cleanup
removes the inspection DLL and restores the original assembly in the stopped QA copy;
this changes only the inspection hook, not the verified candidate asset files.

Prior technical controls and the failed font candidate are under
`localization/probes/ru-20261026-06/`; the repaired candidate is under
`localization/probes/ru-20261026-07/`.
Attempt 04 exercised the real typewriter and normal Continue button through synthetic
entries 197, 199, 200 and 202 to original entry 203. Combining marks and trailing spaces
completed; the uncorrected TMP field reported overflow. Attempt 05 stopped on an
incorrect singleton assumption: the bundle contains 75 subtitle components. Attempt
06 preserves each component's original maximum size, adds bounded auto-sizing,
calibrates the existing Cyrillic TMP fallback by cap-height ratio, and replaces only
the existing legacy fallback font's data/metrics using the game's Liberation Sans.
These are technical candidates, not final corpus-bound font approval. The native
attempt-06 frame was fully reviewed: layout/normal progression passed their bounded
checks, but Cyrillic nameplate cap height/weight mismatched the adjacent original
pixel digits. Decomposed-mark placement remains uncertain. The visual ledger records
1 reviewed, 0 passed, 1 failed, 0 pending for this one-frame pilot. The complete shared
feasibility gate is failed; mass translation remains blocked. This does not imply that
Russian support is impossible. Further shared-font repair and fresh bounded native
review are required, alongside the remaining renderer/source gates.

Attempt 07 tests one shared-resource repair: both native primary/fallback Font objects
in both asset copies use the game's embedded Liberation Sans Regular 2.00.1, while
retaining object identity, material/texture links and fallback links. Exact reopened
font-byte/table checks passed; all unselected objects, including the fictional TMP
mapping, remain unchanged. This deliberately changes the native pixel face to a
coherent outline face for the bounded candidate; final style/readability acceptance
still requires native review. `font-provenance.json` pins the embedded SIL OFL 1.1
metadata; final redistribution must include its full license notice.

Its paired samples test raw NFD `Е\u0308 и\u0306` and canonically equivalent NFC `Ё й`
without dropping accents or adopting a blanket normalization exemption. Candidate
source fields and the accepted glossary are NFC, but the complete corpus and dynamic
input requirements remain unaccepted. The capture recipe guards actual dialogue
states and normal Continue handling. The first attempt stopped on the omitted
`SoftResetLoadingScene`; its restored failure is preserved in `runtime-attempt-01/`.
The corrected guard includes that source-backed New Game loading transition and
never sends Continue during loading. Keep this transition in future capture recipes.
The corrected run captured both unchanged 1440×900 native frames, completed normal
197 → 199 → 200 → 202 → unchanged 203 progression without overflow, and restored/stopped
the QA copy. Runtime diagnostics confirm the native Text loads Liberation Sans at
size 14 with Cyrillic/digit coverage. Original installed assets/player files remain
byte-identical. The complete two-original packet was independently reviewed in fresh serial phase
0002: both frames fail the TMP glyph gate. Raw NFD marks sit right of their bases,
and pixel Latin/digits remain heavier than outline Cyrillic. The native nameplate
passes coherent height/weight/baseline and NFC mark placement in those exact frames.
These observations do not accept other text roles or the complete renderer.

Candidate10 (`localization/probes/ru-20261026-10/`) replaces the shared TMP
primary face using the same embedded Liberation Sans for Cyrillic, Latin and digits.
It preserves font/material/atlas object identity, the bitmap shader and 1024×1024
Alpha8 dimensions, with a cleared readable atlas and smooth hinted raster glyphs.
`tools/tmp_dialogue_font.py` derives four Russian canonical base/mark placements
from the embedded font's composite accent geometry and uses TMP's existing pair
table; logical NFD/NFC strings and zero mark advances are preserved. This is a
bounded mechanism, not general mark-to-base/mark-to-mark shaping acceptance.
Candidate10 completed normal progression and captured/restored the new NFD/NFC pair;
its two originals independently passed all applicable visual checks in fresh phase
0004. The coherent face/weight/baseline and raw NFD/NFC mark attachment pass only
these exact ordinary-dialogue/nameplate samples. All other surfaces remain unverified.
Its nested glyph diagnostic array
was omitted by Unity JsonUtility, as was the prior text-object array. No actual
per-character metrics are claimed. The canonical bridge now uses string arrays for
future measurement; that format compiles but has not run. Current captures and bridge
snapshots are preserved. No runtime font or text repair lives in the inspection bridge. Final corpus/fonts and all other
renderer paths remain gated. The first static attempt's float32 mismatch (08) and
the readable-atlas prerequisite discovered before launching 09 remain preserved.
Rebuilds must retain exact float32 scale, readable cleared atlas and smooth bitmap
mode together; static cmap/readback cannot establish native glyph attachment.

The bounded menu/settings source trace is `localization/source/settings-consumers.json`,
reproduced with `.venv-assets314/bin/python tools/inspect_menu_source.py --output <new-json>`.
Fullscreen, Scale and Stretch labels each have six TMP components in their face/glow
hierarchy, all bound to `sharedassets0.assets:3323`. Reinsertion must preserve every
physical copy. This is three traced logical groups, not a complete UI inventory.
`--sample-surface menu-settings` selects distinct synthetic samples for all 18 occurrences
and changes only their `/m_text` fields. Menu navigation and native visual acceptance
remain separate from the exact no-op/readback checks.
Candidate11 statically passed all five resource round trips, then the real OptionsMenu
loaded the Fullscreen/Stretch samples (six copies each) without reported overflow.
Its capture guard stopped before Back because it wrongly required Scale simultaneously.
`OptionsMenu.ConfigureForEverythingElse` and `OnClickFullscreen` prove the reciprocal
visibility: Stretch in fullscreen, Scale in windowed mode. Future capture guards must
follow those states rather than require all labels at once. Scale values are eight
Image slots selected by `UpdateWindowScaleFactorUI`, not TMP numeric literals.
The original failed runtime result and restoration are retained; one byte-identical
native failure capture is pinned for bounded review of the two visible samples only.
Its one original independently failed layout/glyph review in phase 0006: the two
synthetic labels passed their bounded observations, but the Stretch `Off` value
showed displaced overlapping contours. Phase 0007 imported that real failure; the
ledger checker rejects it (1 reviewed, 1 failed). The two check findings describe
one observed value defect, not two proven mechanisms.

Candidate12 (`localization/probes/ru-20261026-12/`) tests one bounded geometry
hypothesis and adds actual per-glyph/layout measurements. The two source `Off`
face/glow groups are unchanged in candidate11. Their black layer has preferred
fitted height, while four children have fixed height 50. The candidate stretches
those eight children to the fitted parent, preserving text/colors/material/size
and native outline offsets. Static no-op/readback checks pass; only 18 sample
text fields plus these 8 RectTransforms differ in level1, and the other four
resources are byte-identical to candidate11. This is an experimental candidate,
not a credited visual repair. The initial inference from serialized split `Top`
fields was contradicted by actual runtime `Center` alignment (the old
`m_textAlignment=514` is also present). Always resolve actual alignment before
claiming a cause from serialized fields. Exact migration code remains untraced.

`tools/probe/capture_settings.py` now follows reciprocal visibility and actual
Stretch, Fullscreen and Back buttons. Candidate12 passed the complete guarded
menu route, captured fullscreen 1440×900 and windowed 960×540 originals, and
stopped/restored the QA copy. Both opaque `Off` layer families have identical
local glyph origins/metrics at runtime with their retained outline offsets;
no equivalent candidate11 glyph measurements exist, so this is not a measured
improvement claim. Windowed index 1 selects exactly the 2x Image from 8 slots.
Scale up/down input and the other 7 active slots are still untested. Fullscreen
and Stretch return to initial states; the game normalizes its QA scale index
from 0 to 1, so no byte-exact QA configuration restoration is claimed. Original
installed assets/player files remain unchanged. The bridge is removed and the
task-owned processes are absent. The complete two-original packet was independently
reviewed in fresh phase 0008
and imported in text-only phase 0009: fullscreen failed layout/glyphs because
Stretch Off still overprints; windowed passed its visible checks, including
Fullscreen Off, raw NFD marks and baked 2x. This does not accept other states
or the renderer. The failed geometry experiment remains historical evidence.

The diagnostic-only run `localization/probes/ru-20261026-13/` reuses the exact
candidate12 resource bytes and measures Images under OptionsMenu/Controls, including actual
enabled/active state, sprite, alpha, culling and bounds. The original controller
binds Stretch No to GameObject 2032 and Fullscreen No to GameObject 1683; its
configuration/toggle methods change GameObject activation, preserving Image.enabled.
At runtime Stretch Off has an enabled, opaque, unculled `TitleScreenButtonLabels_Off`
Image in addition to six TMP components. The neighboring Fullscreen Off has the
same baked sprite disabled. All 11 OptionsMenu Image families with a complete
six-layer TMP NameContainer were checked; exactly this one legacy Image remains
enabled. Equal TMP layer metrics did not enumerate this second rendering path.
The diagnostic run captured/opened no images, returned through actual Back,
stopped, removed the bridge and preserved the installed assets/player files.

`--repair-settings-value-images` in the existing builder disables only the
legacy Images with complete, consistent TMP replacement families. It fails on
ambiguous/incomplete replacement topology and changed pinned duplicate selection;
cursors and the eight baked Scale images have no such replacement and remain
excluded. Matching positive/negative static controls verify that one inconsistent
TMP copy is rejected for the intended reason. Candidate14 retains candidate12's
experimental geometry so its incremental scene difference can be limited to
Image 9708 `/m_Enabled: 1 -> 0`. The repair is in the asset recipe, never a runtime
bridge mutation. All five no-op/readback checks passed; exact candidate12-to14
readback proves
only that one incremental field differs. The first runtime stopped because the
diagnostic collector covered only Controls while the 11-family guard also
requires Delete Savegame. The failed attempt and successful cleanup are retained.
Candidate15 reuses the exact candidate14 asset bytes with a newly snapshotted
bridge that measures all OptionsMenu Images. Its capture/review status is
recorded in CHECKPOINT.json; static/runtime checks cannot credit visual repair.

Candidate15's exact two native settings originals were independently reviewed in
fresh phase 0010 and imported once in text-only phase 0011. The native ledger checker
passes with 2 reviewed, 2 passed, 0 failed and 0 pending. Stretch Off now has a coherent
outline, both synthetic sample sets are readable, and the windowed raw-NFD marks are
above their bases. This accepts only these two synthetic settings states. The verified
candidate12-to14 delta, retained byte-for-byte in candidate15, is Image 9708 disabled; candidate12's retained
geometry experiment is not independently credited as a causal repair. Prior failures
remain intact. Candidate16 subsequently traces the normal Scale event and display limits below;
other Scale values remain visually unaccepted.

Phase 0011 found a separate live ru-assets CLI (PID 7943) in this checkout, conflicting
with its current one-active-CLI instruction. No game was launched, no image opened,
and no index mutation performed in this phase. That historical hold was resolved by the owner's explicit parallel authorization in
phase0012. The technical lane resumes with exclusive Git ownership and disjoint
paths; the other task's process and files remain untouched. See the bounded observation
and continuation brief under `outputs/ru-serial-20261026/0011-work/`.

For this bounded settings candidate use a fresh output with:

```sh
.venv-assets314/bin/python tools/build_renderer_probe.py --output localization/probes/ru-next-settings --sample-surface menu-settings --repair-cyrillic-metrics --coherent-legacy-face --coherent-tmp-face --repair-settings-glow --repair-settings-value-images
```

Keep expanded Image diagnostics for the full OptionsMenu and duplicate-Image
runtime guards in future settings captures; diagnostic scope must cover every
static replacement-family path, including controls outside Controls/. Regression:
Stretch Off has six coherent TMP layers plus a
still-enabled baked Off sprite; TMP-only metric equality must not pass that
state. Verify actual Image disablement and the neighboring Fullscreen Off,
then independently inspect fresh originals. Other renderer/source/editorial,
Scale interaction and final-corpus gates remain unaccepted.

Candidate16 reuses the same five resource hashes and traces Scale through original
`WindowController` IL and the serialized Select/Move bindings. On the actual 1440×900
display only 2× (960×540) is eligible: 1× is explicitly disabled, 3× has equal display
width and fails the strict less-than test, and larger modes exceed the display.
Normal Move events right/left retain index 1 and the same size; both option arrows
remain hidden. No successful resize or intermediate handler entry is claimed from
these no-ops. Arrow callbacks are bound to `EventTrigger.Select`; their `Button.onClick`
events are empty. Future positive resize checks must observe a real eligible next
mode and the navigation target. No flags or indices were forced. See
`localization/probes/ru-20261026-16/runtime-diagnosis.json`. Cleanup verifies all four
identified task processes absent, the temporary bridge removed, and installed/player
files unchanged. No new images were captured/opened. Unseen slots and other renderer
paths stay unaccepted; do not rerun unchanged Scale tests on this display.

The safe bridge dumps only scalar subtitle fields. Its `continue` command now invokes
the actual game typewriter/button handler. Direct `dialogueUI.OnContinue` is inadequate
progression evidence because it bypasses that handler. `prepare_bridge.py` compiles
against original managed references, snapshots its sources, and checks that the hook
changes only `MainMenuController.Start`. Never include this bridge in a player release.
The previous crash cause remains unproven; a successful scalar dump is not retrospective
proof of that cause. Startup can take minutes; queued commands are reconciled, not resent.

`localization/source/dialogue-manifest.json` binds 12,246 nonempty dialogue/menu
**candidate fields**, 24,492 physical occurrences, 627 conversations and 16,396 entries.
The two complete conversation trees agree. `tools/prepare_dialogue_source.py` records
each candidate's exact pointer and fingerprints every other tree value as protected.
This is a partial source family, not the game's accepted visible-ID denominator.
Inline controls, BGDatabase/UI/code/image consumers, 1,351 unresolved metadata records
and complete special-scene discovery still block source acceptance and mass translation.
The write-boundary test verifies continuation after the first file exists and the
second write fails; the two output files do not form an atomic transaction.

The earlier absence of TMP rows must not be used to infer that a screen is texture-only:
the scene-validity filter excluded the actual dialogue sample. Unfiltered enumeration
also includes hidden templates, so it cannot prove visibility. Baked textures exist,
but menu/settings renderer bindings require their own real-screen evidence. Speaker
nameplates use legacy `UnityEngine.UI.Text`; the mouse-language font is a separate
mapping that this ordinary-dialogue probe does not accept. See the source consumer
findings and regression catalog in `localization/source/consumer-findings.json`.

All locales use the shared process and editorial protocol pinned in the checkpoint.
This project binds its existing tools to those stages as follows; missing commands
remain explicit pending work rather than invented successful gates.

| Stage | Project command or artifact | Acceptance boundary |
| --- | --- | --- |
| `scope` | `CHECKPOINT.json` | Exact 0.45 source, `ru`, standard localization and canonical checkout. |
| `probe` | `.venv-assets314/bin/python tools/build_renderer_probe.py --output localization/probes/<new-run>` | Five bounded no-op/readback checks, then real synthetic Cyrillic rendering and normal-button progression on each required text path. |
| `source` | Existing extractor/validator; `tools/prepare_dialogue_source.py`; `special-scenes.json` | Shared complete visible inventory, consumer classification and preserve-exactly manifest; semantic handoff pending. |
| `glossary` | `localization/glossary/{en,ru}.json` | Accepted source and Russian layers, 171 IDs, canonical hashes and two review layers. |
| `translate-edit` | Pending source and probe gates | Direct model translation with immediate editing; every discovered special-scene group settled first. |
| `editorial` | Universal protocol pinned in checkpoint | One complete semantic audit, reproducible closures, independent diff/delta review and final structural gate. |
| `resources` | Existing texture inventory; final adapters pending | Final corpus-bound fonts, then applicable localized textures. |
| `package` | Pending adapter | Reproducible local deliverable with exact resource readback. |
| `runtime` | Isolated versioned runtime evidence | Actual packaged rendering, controls and semantic progression, separately from static checks. |
| `screenshot-upload` | Not requested | No website screenshot writes. |
| `screenshot-review` | Not applicable without upload | Does not inherit a pass from capture. |
| `delivery` | Canonical `main`, checkpoint and artifact hashes | Honest separate text/editorial/technical/runtime states. |

The renderer probe is a disposable runtime copy, not a competing project checkout.
It excludes player files and changes its QA company/product identity, TMP/native
font fallbacks, bounded subtitle auto-sizing, synthetic text fields and an explicitly
identified temporary inspection bridge. The bridge invokes guarded game-thread actions and captures the
native Unity backbuffer, avoiding desktop input and focus dependencies. It is more
deterministic than external mouse automation for this probe and must never ship in
the player package. The installed game, original DLLs and player saves are preserved.
The first partial probe exposed a validator bug: UnityPy ObjectReader retains the
original reader after `save_typetree`. The recipe now retains authored expected trees
and compares them with independently reopened files, instead of rereading the old
stream. The failed copy remains diagnostic evidence, not a successful probe.

The sections below describe the previously completed extraction, not Russian release
readiness. Its historical scope and limitations remain available.

Canonical project: `/Users/antonkrutov/Desktop/Forest`.

The local source is **The Forest of Love 0.45** (PlayerSettings `bundleVersion`),
installed at `/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest`.
The player uses Unity **2020.3.24f1**; the Addressables bundle reports
**2020.3.22f1**. The source language observed in display assets is English.
`tfol.settings` is a mutable player-settings file, not the authoritative build version.
The unrelated Helltaker archive originally present in this folder was left untouched.

## View only textures containing text

Open [the filtered gallery](review/index.html). It contains **110 distinct images**
with visible text, representing **120 source texture occurrences**. Click an image
to open its native PNG. Each card retains every exact source/container and path ID.
The selected originals are also copied into `review/textures/`, with readable filenames.
`dist/text-bearing-textures.zip` contains a portable gallery, all 110 selected PNGs,
contact sheets and the source-ID manifest; all ZIP members were read back and compared
to the delivered files. It does not include unrelated textures or font atlases.

The gallery includes 12 tutorials, 65 interface images, 9 illustrations/item atlases,
5 UI mockups and 19 development/engine images. Runtime reachability is unverified;
mockups and editor/engine graphics are clearly labeled. Six distinct font atlases
(eight source occurrences) are listed separately in `review/font-atlases.json`.

`texture-review.json` is the manual selection. `review/text-bearing-textures.json`
binds it to the complete texture manifest and groups duplicates only when decoded
RGBA pixels and dimensions match. All 1,375 exported textures were visually screened
on 29 contact sheets. Small inventory/quest/rune atlases received additional native-size
inspection. Screening is not proof that every tiny mark in every illustration is text-free.

Local Apple Vision OCR supplied candidates; it did not decide acceptance or generate
wording. Accurate OCR stalled during Apple neural-engine initialization, including
with `usesCPUOnly`. A bounded legacy fast/revision-1 probe succeeded; that path processed
all 1,375 images. One 2×2 empty transparent texture was rejected as too small. It was
visually inspected and is not a text candidate. No external OCR/translation service was used.

## Extracted resources and provenance

`assets/source-v2/` contains PNGs at original dimensions and alpha, six exact TextAsset
payloads, eleven font records and available font bytes, Sprite/atlas/UI/font/component
typetrees, a complete object inventory and source SHA-256 manifest. The binary BGDatabase
payload is saved as `.bin`; it must not be mistaken for UTF-8 text.

The extraction includes both scene/shared resources and the Addressables bundle.
IDs use `source-file!/internal-serialized-file:pathId` for bundled objects. This avoids
collisions and preserves the exact source file, internal CAB name, path ID, texture
format, dimensions, mip count and original object fingerprint. Compressed texture bytes
remain in the untouched installation; PNGs are editable decoded exports, not replacement
Unity containers. Preserve alpha, dimensions, IDs, Sprite rectangles/pivots/borders,
material references and container bindings when preparing future replacements.

Large JSON metadata is versioned in `assets/source-v2/metadata.tar.gz`, with an exact
member read-back receipt in `metadata-archive.json`. The expanded working files are
ignored by Git. Restore them after checkout with:

```sh
tar -xzf assets/source-v2/metadata.tar.gz -C assets/source-v2
```

The primary dialogue resource is the Pixel Crushers DialogueDatabase, present in both
the Addressables bundle and `sharedassets0.assets:3336`; its extracted structure includes
627 conversations, 39 actors and 10 item/quest records in each copy. The string-field
inventory retains both occurrences rather than collapsing IDs. BGDatabase, dialogue
database controls, C# literals and scene/runtime consumers still need semantic
classification before a complete translation-source handoff. Unknown fields default
to `preserve-exactly-pending-consumer-review`, not permission to translate.

## Reproduce and verify

Use Python 3.14 and the project-local `.venv-assets314`. Exact package versions are in
`requirements-assets.lock`; Apple Vision requires macOS/Xcode command-line tools.
The initial export used the already installed UnityPy 1.25.4/Pillow 13.0.0 environment
read-only; all final tools use this project's own environment.

```sh
/Users/antonkrutov/.local/share/uv/python/cpython-3.14.6-macos-aarch64-none/bin/python3.14 -m venv .venv-assets314
.venv-assets314/bin/pip install -r requirements-assets.lock
.venv-assets314/bin/python tools/extract_assets.py \
  --source '/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest/The Forest of Love_Data' \
  --output assets/new-export
.venv-assets314/bin/python tools/validate_exports.py assets/new-export
swiftc tools/ocr_textures.swift -o /tmp/forest-ocr-textures-fast
/tmp/forest-ocr-textures-fast assets/new-export/textures.json > assets/new-export/ocr-results.jsonl
.venv-assets314/bin/python tools/build_texture_gallery.py
```

The gallery builder deliberately binds to the reviewed `source-v2` manifest. A new
source export must be compared and the review rebound before its indices are reused.

The initial v2 export lacked schemas for some MonoBehaviours and could not serialize
binary Sprite fields. `repair_metadata.py` recovered 41,376 recorded failures with the
game's managed assemblies and binary-safe JSON. Initial failure/report receipts remain
separate. The normal extractor now includes both fixes. Remaining 1,351 metadata failures
are listed in `failures.json`; most involve FuzzySpriteRect and joystick maps. Those
records are unresolved, not accepted empty objects. The earlier `source-v1` stopped on
unmapped CAB provenance before exporting textures and is retained as ignored evidence.

The source schema takes precedence over generated schemas. TypeTreeGeneratorAPI
0.0.10 omits the 4-byte alignment flag after `m_Enabled`; it can shift `m_Script`
by three bytes while still consuming the expected total object size. The extractor
corrects that generated-schema flag and independently verifies every component's
Script/GameObject/Enabled/Name header. `repair_schema_headers.py` corrects existing
generated exports while requiring complete body/string equality outside `m_Script`.
Regression examples: `level1:8044` (an empty SoftMaskable) must retain the native base
schema; `level1:7339` (TMP) and `sharedassets3.assets:3271` (BOC.BTagged.Tag) must preserve
their real script references when a generated schema is necessary. Byte-count success
alone does not satisfy this check.
The corrected schema is rebuilt from flat nodes to invalidate the generator's compiled
reader cache. Changing a node flag in place can leave that reader using the old
alignment. `level0:107` is an additional regression control for this cache boundary.
The header repair is resumable after a partial write: every affected tree hash is
reconciled even when its corrected bytes were already written. Tree-file writes and
the final object manifest are separate commits to disk, not a multi-file transaction;
the final source validator and archive read-back must pass before delivery.

`validate_exports.py` checks source file SHA-256, every object ID/raw fingerprint,
every exported typetree and exact string value, TextAsset bytes, and every PNG's
dimensions, checksum and decoded RGBA pixels against the installed source. This tests
the extraction boundary. It does not test translation semantics, reinsertion, Unity
compression, renderer support, runtime loading or gameplay.

Use `tools/pack_metadata.py` only after extraction/repair has finished; it verifies
every archived member against the expanded working file. Do not rewrite a running
extractor's helpers. A future asset build should use a new output directory and compare
the current source manifest before reusing these results.

## Scope and next stage

This task exported original assets and identified baked text. It did not translate,
redraw textures, install a mod, launch the game, publish content or deploy anything.
At that historical export-only checkpoint, no localization type or target locale had been selected. `special-scenes.json` records
observed visual dependencies and the remaining discovery gaps. Source acceptance and
renderer feasibility remain unverified; extraction success is not a playable localization.

The texture reinsertion route is Unity Texture2D replacement in each owning serialized
file or Addressables bundle, preserving links and format/alpha/dimensions. It has not
been round-tripped. Bundle catalog/hash dependencies require investigation before
replacement; merely editing the PNG files cannot affect the game.

Official/reference research: [developer's game page](https://carrotscritters.itch.io/the-forest-of-love),
[Steam listing](https://store.steampowered.com/app/1683170/),
[existing TMP font-override discussion](https://github.com/bbepis/XUnity.AutoTranslator/issues/57),
and [UnityPy's extraction/type-generation documentation](https://github.com/K0lb3/UnityPy/blob/master/README.md).
These are technical leads, not evidence that a mod works with this exact build.

The coordinator model was verified from this chat's turn context as GPT-6.1 Sol,
reasoning high. No Astra model, worker, external translation model or subagent was used.
