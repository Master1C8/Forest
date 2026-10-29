# Russian CritterLog compact layout

The resource adapter changes the 26 actual native `UnityEngine.UI.Text`
components under `LevelSingletons/MasterLog/CritterLog` and one full-name
rectangle. It preserves the delivered Liberation Sans Regular face, font pointer
`external5/sharedassets0.assets:369`, every material/color/alpha, all artwork,
unknown masks, NEW badges, object identities and all other raw object bytes.
It neither opens the game nor accesses saves or an installed game.

| Role | Components | Before → after | Fit contract |
| --- | ---: | --- | --- |
| Notes1–6, Kinks1–9 | 15 | 14 → 10 | One line, positive-pair advance bound ≤75 units |
| FullName | 1 | 18 → 14 | Complete name, advance ≤184, 186×18 rectangle |
| Subtitles | 1 | 14 → 11 | Up to three lines, each advance ≤184 |
| Resident names and selected glow copies | 7 | 14 → 12 | One line, advance ≤74, all copies match |
| Notes/Kinks titles | 2 | 16 → 13 | One line, advance ≤58 |

The cell rectangles are 82×12 with 14-unit row spacing. Their column origins
are 26, 106.1 and 184, so the smallest column pitch is only 77.9. A 75-unit text
bound avoids their existing rectangle overlap without moving columns. The face's
2,048-unit em and hhea ascent/descent/line-gap 1854/−434/67 give 11.499 units at
size10 and 12.649 at size11. Size10 fits a single line in the existing 12-unit
cell; multiline text does not fit. There is no best-fit shrink or ellipsis.
Horizontal wrap and vertical truncation are set to their bounded native values
for the cells, header, subtitles and titles. Those settings are containment
guards: final authored target fit is required independently, and truncation is
never an accepted substitute for complete visible text.

The sole geometry change is `RectTransform13285 /m_SizeDelta/y: 15 → 18`.
At size14 the measured hhea line height is 16.099. With the existing header top
at −4, the enlarged rectangle ends at −22, before subtitles begin at −24.
Position, width, anchors, pivot and all other rectangles remain unchanged.

Resident selected-name glow rectangles intentionally have 10/11-unit heights
inside a 16-unit row and currently permit vertical overflow. They retain that
baseline/alignment and overflow behavior at the smaller size12 (13.799-unit
hhea line height), preserving the existing layered artwork. All seven native
Text templates use size12, including inactive disabled/enabled templates and
the five selected glow/foreground copies. This still needs native visual
inspection; static metrics do not establish rasterized baseline placement.

## Consumer evidence

The old database-consumer IL contains the Actor full-name source binding but
does not contain these native UI bodies. The exact current bodies were read
using the existing read-only InspectMethods.dll, pinned in the output evidence:
CritterLog.Start/UpdateResidentLabelState/SelectResidentLabel;
NamedResident constructor/SetText/SetStatus; and
CritterLogBioPane.UpdateSelectedBio/UpdateKeywordText.

Start instantiates selected, enabled and disabled templates. NamedResident
SetText and SetStatus distribute the same name to every relevant native Text.
BioPane writes Actor.FullName, three newline-separated species/age/role fields,
six Notes and nine Kinks to the serialized component array. UpdateKeywordText
preserves hidden/unlocked decisions: unrevealed fields become `???`, their
existing color changes apply, and each NEW CanvasGroup retains its own time
comparison. These inspected consumers assign text/color/activity but do not
replace the serialized font size or face. No managed assembly is patched.

## Reuse and validation

`tools/russian_journal_layout.py` supplies `plan(objects,generator)`,
`snapshot(folder)`, `apply(source,output)` and
`validate_targets(rows,font_bytes)`. Caller-authored fit rows contain `id`,
`role` and `target`; the adapter never generates or changes wording. Metrics
retain nominal advances and add positive legacy/GPOS pair kerning without
crediting negative reductions. This remains static font evidence, not Unity
rendering or an exhaustive shaping model.

Apply to the exact current preview `The Forest of Love_Data/sharedassets2.assets`
with fresh `--output` and `--receipt` paths. It verifies the source container,
font container, all 152 managed DLL dependencies, 106 structural guards, exact
before trees and exact changed-pointer allowlists before writing. Snapshot
copies the adapter, type-tree helper and full plan, with a verified pin manifest.
It must be frozen after future recipe changes; existing snapshots are immutable.

The isolated patch changes exactly 27 of 18,905 objects. Saved trees match;
unselected objects remain byte-identical; restoring the original 27 raw objects
reproduces the whole original serialized container exactly. A frozen standalone
replay produces the same resource SHA-256. There is one exclusive resource write
after in-memory validation. The receipt is a separate write, not a transaction
with rollback across multiple files. Occupied outputs reject retry.

## Finite remaining acceptance

| Artifact/predicate | Evidence | Remaining uncertainty / next action |
| --- | --- | --- |
| All actual journal Text roles covered | Independently derived current GO/Transform hierarchy matches all 26 roles | None for this pinned resource |
| Resource integrity and reversible serialization | Exact 27 change set, whole-container reversal and saved readback | Parent combines with the wording stage and verifies final delivered bytes |
| Authored compact text fits every current field | All 111 supplied terms / 166 uses, 34 retained actor display fields for 17 eligible residents, 18 assembled subtitle variants, and two native section captions pass static bounds; all 36 BioDetail name overrides remain null | Parent completes independent semantic review and native readability review; no static overflow is recorded |
| Native readable journal without overlap/clipping | Not run in this worker | Parent's separately authorized native scenario and screenshot review on final artifact |
| Source/editorial/ordinary/release gates | Unchanged | All existing incomplete gates remain false; no publication or installation acceptance is inferred |

Model verified from this worker's own session metadata and turn context:
`gpt-6.1-sol`, `high`, provider `openai`. No descendants, other model jobs,
game/GUI/capture/installer execution, Git/index operation, root README/checkpoint
edit, real-game mutation or saves mutation occurred.

The complete fit evidence is
`outputs/ru-journal-compact-20261029/layout/final-target-fit.json`, bound to the
compact-target file, delivered resources container and BG payload hashes.
The longest possible three-line subtitle height from this static hhea test is
37.947 units, within the existing 39-unit rectangle even before applying the
source 0.8 line spacing. Short positive controls fit; deliberately overlong and
multiline cell controls report failure. Empty and duplicate-ID inputs reject.
The final immutable execution recipe is `layout/frozen-final-delivery/` under
that output directory; older frozen versions preserve intermediate evidence.
