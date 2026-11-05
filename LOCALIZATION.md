# Build a Forest language from one file

The deterministic compiler uses the accepted Russian Forest 0.45 implementation
as its common framework. A language file contains English source text, target
text, and optional font/point-size settings. It cannot supply commands, Python
modules, resource selectors or game-logic changes.

Build a language:

```sh
./forest-localize build localization/languages/ru.json
```

The default output is `dist/Forest-<locale>-<language-file-hash>/`. It contains
the complete shared-framework resource overlay under `The Forest of Love_Data/`
and an exact completion manifest. This command calls no translation model,
starts no queue, launches no game, and installs nothing. Input game files,
the accepted Russian build and player saves remain read-only.

The included `ru.json` carries the current saved Russian terminology revision;
`ru-baseline.json` reproduces the accepted earlier implementation unchanged.
`de.json` imports existing German data and authored wording into the same
framework. `es.json` supplies Spanish (Spain), `es-ES`, through the shared v2
catalog. Build it with `./forest-localize build localization/languages/es.json`.
These files retain their own editorial provenance; the compiler
does not award editorial, native or release acceptance.

## Language authoring

Prepare a complete file with the fixed English inventory:

```sh
./forest-localize template --framework forest045-shared-v2 \
  --locale fr --culture fr-FR --output localization/languages/fr.json
./forest-localize validate localization/languages/fr.json --details
```

Fill each `target` in the resulting JSON. Preserve the IDs and `source` values.
`null` means unread/untranslated and prevents compilation; an empty string is an
explicit value. The v2 14,606-entry inventory includes preserved dialogue
and technical values, which must follow their original control/preservation
rules. A source-equal target is not automatically an editorial pass.

```json
{
  "source": "Back",
  "target": "Назад"
}
```

One logical dialogue entry updates both physical copies. All edits to one Unity
object are merged before serialization. The existing source-aware dialogue guard,
whole-object readbacks, independent 51,572-state database readback, original
bundle compression/CAB checks and Addressables catalog updater are shared code.
Managed string edits use exact method/instruction identities and verify the
complete saved semantic tree and restoration of the original tree. The nine
haiku display/evaluation pairs must agree. Source/control keys stay in the
framework, outside the editable target mapping.

Visible quantities may use natural target-language words or digits. The compiler
does not equate numeral spelling with semantic fidelity: the source-to-target
audit must preserve the actual amount, order and context. Command operands,
placeholders and protected source values still retain their exact identities.
Regression: `2 copies` may become Czech `dva výtisky`, while changing or removing
the accompanying `[pic=3]` command still rejects before resource generation.

Optional `layout` entries map registered native component IDs to point sizes
from 8 to 128. Optional `fonts` entries select embedded faces from `fontAssets`:

```json
{
  "fonts": {
    "REGISTERED_ASSET:FONT_ID": {"asset": "FACE_SHA256", "family": "Font Family"}
  },
  "fontAssets": {"FACE_SHA256": "BASE64_TTF_OR_OTF_BYTES"},
  "layout": {"REGISTERED_ASSET:TEXT_ID": 10}
}
```

Only roles registered by `framework.json` are writable. Names, resource pointers,
materials, texture objects/streams and the fictional-language mapping are retained.
For a changed static TTF/OTF face, the compiler derives native ascent, descent and
line spacing from the actual font tables and removes stale kerning. The registered
dynamic TMP1017 consumer of Font439 receives matching face/legacy metrics. Its
source/fallback pointers and empty atlas caches are preserved; static or populated
caches reject a face replacement. The face must have a matching family, explicit
cap/x heights and a positive space advance. Unchanged baseline faces retain their
accepted metrics. These are table-scaled serialized inputs, not a Unity font import.
Existing shared runtime adapters supply the accepted Russian layout behavior.
The optional `imageCaptions` object replaces the two registered text-bearing
Images through native UI text, without changing texture pixels. Its exact roles
are `gallery` (`source: "Gallery"`) and `residents` (`source: "Residents"`), each
with an explicit nonempty `target`. Unspecified means preserve the existing
framework; unknown roles, line breaks or NUL characters reject. The compiler builds the
existing quest helper with these captions and hooks only the original menu and
critter-log `Start` methods. Complete method-tree readback and reversal protect
the original code. The helper also uses the actual portrait bounds and available
left column when placing quest history, measuring from an unscrolled origin.
The two layout method bodies and the status-caption glyph guard change; other
existing helper entries remain exact. The guard checks the actual authored
heading characters rather than requiring Cyrillic from every locale. Optional
`imageCaptionSizes` maps `gallery`/`residents` to point sizes12–64; omitted sizes
retain50/18. Rebuilding uses deterministic compilation. This feature does not award
editorial or native visual acceptance to another locale.
The compiler also registers the seven original quest-list name templates in the
exact shared-v2 framework: `sharedassets2.assets:18330`, `18315`, `18305`,
`18314`, `18312`, `18344` and `18341` (repeat the asset prefix for each key).
Their original point size is14; a locale can set a smaller readable size without
changing canonical quest titles, word bindings or the frozen framework. The
exact framework/resource pins and original field values remain mandatory.
The same pinned resource also registers the six dynamic resident-note fields
and nine preference fields at their original10pt. Locale `layout` values may
reduce these to the supported minimum8pt when a complete value exceeds its
original82×12 cell. This changes point size only; wording, row geometry and
undiscovered facts remain intact. Native review must still establish that the
complete strings fit and remain readable. Regression: French “Bavarde du village”,
“« Maman du village »” and “BDSM - Dominante” must display completely.
For values that still exceed the cells at8pt, optional boolean
`residentTextLayout: true` enables the common resident-body layout. It retains
the original three-column order, all six notes, nine preferences and unknown
facts, wraps complete text, measures generated ink and grows row heights.
It tries the configured point size down to8pt, then uses a bounded ScrollRect
if necessary; the portrait and identity block stay fixed. This option requires
`imageCaptions`. Native review must inspect every required fact and any scroll
boundary. Unshaped advance measurements select candidates, not visual passes.
Optional `residentBodyTopLift` (0–24 canvas units), `residentPreferenceGap`
(0–12) and `residentBodyBottomInset` (1–4, default 4) reserve space around the
original dividers. These values require resident reflow. The first fact row
stays below the portrait when the top of the body moves up. The adapter measures
the actual shaped TMP glyphs for complex scripts. Verify both dividers, the
portrait, and all fact rows in a capture; moving the top of a still overflowing
viewport can leave bottom aligned text in its original position.
Additional scripts such as CJK/RTL can require appropriate face data and actual
target rendering/behavior validation. A successful compile alone does not prove
font coverage, shaping, layout, visual parity or gameplay correctness.

Optional `galleryCounterScale` (0.6–1, default1) scales each original gallery
counter group while retaining its original top-left corner. This preserves the
logical counter, tags and thumbnail geometry. Center-pivot scaling alone can
leave Japanese closing punctuation under the first thumbnail. Native review
must establish a readable gap. The seven resident-name templates at12pt and the
native speaker label `sharedassets0.assets:4545` at14pt are also registered point
size roles; their exact resource/version guards remain mandatory.

`complexText: true` opts ar/fa/he/hi/th into the shared experimental script
adapter. Select one explicit merged general-purpose face through the existing
font roles; fictional fonts remain outside those roles. A separate pinned
`.venv-shaping` (`tools/complex_text/requirements.txt`) derives a corpus-bound font
and map. Canonical wording and control values remain logical. Positioned cluster
outlines and zero-advance slots preserve logical character indices for animated
text. TMP input preprocessing handles both ordinary parsing and direct
`SetText`/`GetTextInfo` used by Febucci. The additional registered
`Managed/Unity.TextMeshPro.dll` starts from the exact same immutable original on
Windows and macOS; all other assembly entries are checked. Native Unity Text
uses display-only TMP children while preserving original Text components and
references. Full target native, animation and screenshot acceptance remains
required. Compiler success or corpus idempotence is not that acceptance.

`residentProfileFit: true` is available to the complex script adapter for the original
resident `FullName` and `Subtitles` fields. Their exact rectangles and hierarchy
are checked. The shaped display fits the existing rectangle without truncating
logical lines or moving the portrait. Native verification must show the name,
each original subtitle line and clear space around the portrait and dividers.

Thai alone adds an optional word-wrap hook to the original TMP word-candidate
boundary in both mesh renderers. Offline PyThaiNLP5.4.0/newmm and its CC0
`words_th.txt` produce corpus-bound word and Thai Character Cluster metadata;
no model or dictionary download runs in the game. Word breaks are preferred,
with cluster-safe fallback for a first word longer than its line. Unknown-word
tokenization boundaries inside a cluster are discarded. Logical text, glyph
slots and animated character counts remain unchanged; prepared serialized
values use the same boundaries. Other complex locales retain their exact
previous TMP module. The saved module is read back completely and its optional
prefixes are reversed to the original complete semantic tree.

Optional `complexTextLayout: {"critterHeadingLift": 4, "critterHeadingShiftX": 4}`
moves the original CritterLog heading group up and right by four canvas units.
Only its exact original pose, prior vertical pose or already-applied pose is
accepted; wording and inline font tags stay
unchanged. A source-bound crop must verify all descenders and portrait clearance.
`critterHeadingScale`, `questHeadingScale`, `questHeadingLift`, and
`questHeadingShiftX` configure the original heading groups for complex scripts.
Scale is 0.6–1; lift and shift are 0–8 canvas units. The quest defaults to a lift
of 4, zero shift and full scale. Do not configure both complex and native
CritterLog scaling for the same locale.
Optional `settingsBackLift` and `settingsDeleteLift` (0–8 canvas units) move
the original main-menu Settings label groups and their glows. The buttons,
cursors and hit areas keep their original positions. Verify the complete
labels and clearance in the Settings frame.
Regression: Hebrew final ן may intersect the divider even after shrinking the
heading enough to avoid its portrait; raising it can put a wider portion beside
the portrait again. Check both clearances together. A reduced full frame alone
cannot resolve that boundary. These changes require version-bound native acceptance.

The caption helper also sets the original `v0.45.1` label to white after the
main menu creates its logo. The exact path and component are checked at runtime;
the protected source label and scene controls are unchanged. Verify the badge
against its background in the menu and settings captures.

Menu-layout authoring must intersect inventory rows with
`registered_layout_roles(framework, language.framework.sha256)` before changing
point sizes. The inventory includes protected branding and dormant labels;
it is not itself an allowlist. Preserve every unregistered field and keep the
compiler's rejection guard. Regression: the24 Patreon/TFoL.info/dormant Continue
rows remain untouched while registered Korean menu rows receive14/10/12 sizes.

`questReadableCompletedText: true` darkens the original completed sidebar
label and the four older history roles in the pinned shared v2 resource.
The default keeps the source colors. Current, active, and selected text retain
their separate colors; wording, layouts, and saves are unchanged. Regression:
the five exact muted components change color even when their font-size fields
also have edits, and an unexpected source color rejects before publication.

`questStatusHeadingMinimumPointSize` (8–12, default12) registers the lower bound
for the Active/Completed sprite captions. It changes neither words nor list
geometry. A lower bound alone does not ensure fitting when the native control
permits wrapped vertical overflow; use the explicit measurement option below.
Exact non-quest
resources and helper entries must match before reusing the other six frames.
`questStatusHeadingSingleLineFit: true` opts the native Text route into explicit
single-line measurement. Wrap plus vertical overflow can retain the maximum
font and two lines regardless of a lower best-fit minimum; VI runtime proves
18 logical points (288 scaled generator points), two lines and preferred
width127 in an84-unit band even with minimum8. The opt-in assigns the text,
disables automatic fitting/wrapping, then measures width and height from18 down
to the configured minimum, with a2-unit inset. A non-fitting result rejects.
This option requires the native renderer; complex TMP mirrors retain their
separately accepted layout until an actual renderer-bound fitter is provided.

`critterHeadingScale` (0.6–1, default1) scales the entire original88×15 CritterLog
heading group, preserving the ratio of inline enlarged initials. The L/R prompts
are in sibling Controls and retain their original pose. Source/target scale,
anchors, pivot and size are guarded. `residentPreferenceHeadingLift` (0–6,
default0; requires `residentTextLayout`) lifts only the preference title after
fresh ink placement; its consumed row space and fact positions stay unchanged.
The original fact gap must still clear the preceding note row. Filipino
regression: shrinking the preference title to9pt still leaves the painted rule
through its text. A5.5-unit lift preserves1.5 units after the last note; a0.7
group scale separates the long upper title from R. Both clearances require native
whole-frame review, independently of the passing field/helper delta proofs.

Production packages containing this adapter must retain the OFL, BidiSharp MIT
and Unicode notices under `tools/complex_text/vendor` and
`localization/fonts/complex-sources`. Installer resource/baseline inventories must
include the optional TMP module before packaging; restoration must restore that
original when switching to a locale without the adapter.

Both installer producers normalize their installed inventory to15 resources,
including the registered original TMP module for locales without the adapter.
Normal compiler manifests still own16 resources; adapter manifests own17.
The stock TMP bytes come from the verified immutable framework reference when
minimal Windows recovery inputs omit that unchanged module. Its same exact hash
is required from the owner's game before installation. An old14-resource owned
installation can upgrade only while its previously unowned TMP remains original;
foreign modifications reject without being claimed or replaced. English restore
also restores the original renderer. Legacy14 payload refresh requires a full
normal rebuild before the15-resource refresh route can be used.

`FOREST_WINDOWS_WORK` and `FOREST_MAC_WORK` select separate task-owned packaging
work folders inside this project's `dist/`. `FOREST_MAC_ARCHIVE_NAME` and the
existing package/app name options permit versioned candidate deliverables while
preserving accepted packages. They do not select another source checkout or
authorize installation, game launch or publication. Validate the actual final
payload and all version-bound native acceptances before delivery.

Finite resource builds may run in two disjoint locale lanes after warming the
shared content-addressed compiler cache. Every native assembly-port tool build
uses its own `dist/all30-owner-screens-native-work-v2/<locale>-<cycle>/` folder.
The old shared tool directory is preserved. Regression: simultaneous Czech and
Bulgarian builds must never rewrite each other's SharedInspection.cs, project,
obj or binary outputs; final locale manifests and normal readback gates remain
independent. Native capture still owns one window sequentially.

Font regression: replacing Font439 with the pinned Japanese CFF face must also
replace TMP1017's Liberation Sans face metadata, preserve TMP1020's fallback and
all atlas/fictional resources, and round-trip the saved object trees. The same
mechanism handles the Chinese face without a locale branch; locales that select
no replacement face keep their resource behavior.

## Continue and verify

```sh
./forest-localize build localization/languages/ru.json --output dist/My-Language
./forest-localize build localization/languages/ru.json --output dist/My-Language --mode check
```

After an interruption use `--mode resume` with the same input, engine and output.
The input marker is written first, resource files use exclusive creation, and
the completion manifest is written last. Existing partial bytes must match.
Changed inputs, unexpected files and conflicting outputs reject. This is a
resumable build, not a multi-file installation transaction. Completed artifacts
use `check`; an unchanged build does not overwrite them.

## One-time migration and reproducibility

The framework catalog and manifest are versioned. Bulky `base/`, `references/`
and managed inspection snapshots stay locally in the same canonical project;
they are hash-bound reconstructible resources, like the existing original game
assets. Recreate a missing framework using the exact original game and accepted
Russian data directories:

```sh
./forest-localize migrate-russian \
  --original /absolute/path/to/original/The\ Forest\ of\ Love_Data \
  --baseline localization/previews/ru-20261029-narrative42-01/game/The\ Forest\ of\ Love_Data \
  --output localization/framework/forest045-shared \
  --language-output /absolute/path/to/new-ru-baseline.json --id forest045-shared
```

Migration checks the complete original 247-member data inventory and the accepted
Russian assembly/resource/font hashes. It excludes the QA product identity,
platform launchers and player data. `--resume` checks existing snapshot bytes
after a partial migration. It never rebuilds the historical Russian launcher.

`import-existing` imports a hash-verified saved locale candidate. `merge-wording`
fills missing targets from existing authored JSONL rows or shared JSON resource
plans with an `edits` array, selecting an exact
ID/source match or a unique source/target mapping. Conflicts remain unread.
These are migration commands; ordinary builds depend only on the language JSON,
the shared framework and the local compiler dependencies, not historic phases,
editorial queues, technical inboxes or model jobs.

The v1 difference-only catalog omitted twelve inventoried native inventory-heading
layers whose stored text was unchanged in the Russian baseline. The shared v2
catalog adds their exact original field identities. Reproduce this finite repair
from the verified v1 framework without changing it:

```sh
./forest-localize extend-native --framework forest045-shared \
  --id forest045-shared-v2 \
  --original /absolute/path/to/original/The\ Forest\ of\ Love_Data \
  --packet localization/framework/native-inventory-headings-20261031.jsonl
```

The command checks the original resource version and every original/baseline field,
copies the unchanged pinned companions, and publishes the new manifest last.
`--resume` verifies an existing partial output before continuing. Writes are
sequential, not a multi-file transaction. The regression test interrupts actual
file publication and resumes it; its Unity decoding boundary is replaced by a
fixture. The real Spanish saved-resource check separately reads all twelve layers.
Future unchanged-field omissions use this same explicit inventory mechanism.
Existing v1 language files and tested packages retain their exact old binding.

The Russian launcher source is now `localization/languages/ru.json`, rebound to
v2 from the immutable accepted `ru-baseline.json`. The former launcher override
selected v1 and therefore still displayed English inventory headings. The repair
adds only the twelve inventoried fields, preserving the 14,594 shipped wording
entries and the original initial-letter markup. Reproduce its source delta with
`python3 -B localization/completion/ru-inventory-heading-20261104-01/prepare.py`,
then use the normal compiler. `Windows/installer-config.json` owns source overrides
for both platform payload builders; a platform-specific Russian override must not
silently select the old file again. Regression: both packaged Russian resources
must read back all twelve headings as `ИНВЕНТАРЬ`, with every other object unchanged.

Launcher 1.1.2 also migrates German's unchanged v1 wording to v2 and adds its twelve
`INVENTAR` layers. The remaining 28 languages already contained the selectors.
`tools/forest_inventory_headings.py` gates both payload builders and final
packages: every selected locale must contain all twelve translated fields, and
the packed language hashes must match the current configured sources. The macOS
launch guard compares installed selected-language resource pins with the current
payload, while allowing an unchanged locale from an older overall package.
Old owned files can still be updated through normal Apply language.

For a verified existing Windows payload, `tools/build_windows_installer.py refresh`
updates changed non-bundle resources and retains exact unchanged bundle evidence.
Changed bundles require the full `payload` route. Every reconstructed resource
is checked, literal segments are limited to 65536 bytes by the shipping installer
contract, and unused blobs are pruned. Publication preserves the old archive,
manifest and receipt; replacements are sequential, with the receipt last.
An interruption is rejected as inconsistent, not treated as a multi-file
transaction. Regressions cover interruption after the first two writes, retained
recovery inputs, the 64 KiB limit, stale sources and English fallback.

Run the small input/publication regressions with:

```sh
.venv-assets314/bin/python -B -m unittest discover -s tools -p test_forest_localize.py -v
```

Actual resource tests, byte comparisons and build provenance are recorded in
`localization/framework/verification-20261031.json`. The previous German queue
remains owner-stopped. Final gameplay/visual review, activation in a game copy,
installer creation, publication and deployment retain their separate authority.

## German native test findings

The [2026-10-31 in-game test](localization/runtime-tests/de-single-file-20261031-01/README.md)
passed original UI/loading/choice and bounded inventory/quest checks. It found
twelve English inventory-heading layers omitted by the difference-only catalog,
and a German compound split without a hyphen in the quest list. The shared v2
catalog fixes the selector omission for new builds; Spanish includes all twelve
localized layers. The six-frame
visual gate is not accepted. The tested package remains unchanged. Launcher 1.1.2
now includes the German heading rebuild; the remaining layout/visual findings
are outside this heading repair and remain pending.

Filled JSON entries establish schema completeness only. Target selectors must
also cover the existing canonical inventory, including fields unchanged in the
Russian baseline. Reuse accepted mechanisms and exact target data; do not reopen
a global source audit or create another model stream.

Spanish conversion evidence and outstanding editorial/native predicates are in
`localization/language-imports/es-20261031/README.md`. Its source-preservation
receipt retains the old translated drafts for 619 protected original values and
two repaired service prefixes. Those source-contract repairs are not new Spanish
semantic passes. Ordinary builds consume the final language JSON directly.

## Installer resource identity regression

Run installer producers in the pinned project asset environment when they need
`lz4.block`; the system Python does not provide that dependency. Native macOS
inventory checks and payload production both use
`forest_macos.native_resource_paths`: map the single Windows framework bundle
identity to the registered StandaloneOSX identity before comparing resource sets.
All other names remain exact. Missing or ambiguous source bundle identities reject.
Regression: all30 native manifests pass the mapped inventory, while a missing
bundle or an additional native bundle in the Windows framework rejects before
payload compression. A Windows path must never be treated as a native original.
