# Remaining Play, Gallery and Options captions

The owner's three 20:22 screenshots show English Continue/Start-from/act labels,
Gallery labels and counters, Help, dialogue state, cheat caption and Delete
Savegame. The Stretch caption touches its Off value. The painted title artwork
is subject to the owner's texture-only notify rule.

## Complete bounded source and consumers

`menu-inventory.json` enumerates all 282 TMP text fields under the three reported
menus and their actual linked New Game, Delete Savegame and Quit confirmations.
The links come from MainMenuController8642, not guessed panel names. All fields
retain original IDs, hierarchy, font role and source values. The extraction recipe
is `tools/inspect_remaining_menu_ui.py`; repeated extraction compares exact bytes.

The six gallery labels in `gallery-code.json` are original `ldstr` operands in
four named StartScreenGalleryMenu methods. They write runtime Movies/Stories
headings and unlocked/total counters. Serialized Movie 1/8 / Story 1/8 placeholders
are overwritten by these consumers. Both setters were read: they copy the result
to every TMP child. No display-text comparison occurs in these setters. Exact IL
and controller bindings remain alongside the inventory.

`MenuPatch` changes only those six operands. Its readback compares the complete
method inventory, branches, locals and exception handlers; reversing the six
operands restores every original method body. Actual counter fields, array lengths,
secret-story exclusions, unlock logic and every other method remain equivalent.
The language generator separately preserves format parameters, size tags, line
breaks and numeric values. This does not waive the existing lost-photo counter hold.

## Caption separation

The Fullscreen and Stretch six-layer labels sit below fixed-width hidden TMP
preferred-size providers. Their caption containers originally had a centered pivot
and height-only ContentSizeFitter. Russian text extends past that fixed origin into
the state label. The repair uses each existing TMP preferred-width provider and
ContentSizeFitter, sets a right pivot and a shared caption boundary, and leaves
the value origins, fonts, selection handlers and text sizes intact.

Runtime geometry is measured in common root-Canvas coordinates. This scene uses
a world-space Canvas without a worldCamera: a null-camera WorldToScreenPoint
returns world coordinates, not screen pixels. The observer records its coordinate
space explicitly. The positive control measured gaps of 52.93792 and 36.330866
root-Canvas units. Temporarily restoring only the original caption layout, with
the same Russian text, font and viewport, gave 1.41793 and -2.16913 units; Stretch
overlap reproduced. The fixed layout was restored in a finally block.

## Artifact and verification boundaries

`localization/previews/ru-20261027-menu-fix/game/` is the uninstrumented Russian
candidate, based on `ru-20261027-quest-fix`. All earlier text/font/name/objective
repairs remain. 204 previously English fields change; the other 78 selected text
fields were already Russian and are retained. Four layout objects and the six
managed display literals are repaired. Complete selected-object readback and
unselected raw-object equality pass. Only level1, the localized managed assembly,
isolated product identity and app.info differ from the baseline. Texture pixels
are unchanged. Owner save files remain in the old player preview.

The immutable `build.json` describes construction-time status; later runtime and
visual receipts are separate, hash-bound evidence. Do not rewrite construction
receipts underneath active review queues.

QA uses its own versioned profile and the pinned, QA-generated save fixture43,
never owner progress. Inspection opens the actual panels directly and bypasses
first-time tutorial navigation. That staging proves the loaded text, original
formatter and renderer; it does not prove the bypassed user route. No destructive
confirmation or cheat action is accepted. The localized assembly is retained
before diagnostic injection and restored after the task-owned game exits.

The early fixture has no unlocked chapter, so the original PlayMenu hides the
Start-from row. `play-fast-forward.il` records that predicate. A separate affected
capture stages the existing Act 1 row's visibility without changing text, chapter
records or save flags. Chapter-unlock behavior is not a result of this test.
The visibility staging runs after the panel's deferred Start; otherwise Start
would hide the just-staged row again. Attempt05 exposed that ordering, cleaned up
normally, and attempt06 captured the visible original Act 1 controls successfully.

Failed QA attempts remain intact: 01 rejected the new product at the diagnostic
identity guard; its surviving Windows child was separately reconciled and the
localized assembly restored. 02 exposed an overloaded Open reflection call and
cleaned up normally. 03 captured valid Play/Gallery frames, then exposed the
observer's world-versus-pixel unit error. 04 retained those valid frames and passed
the corrected geometry controls plus the remaining four panels. Subsequent
affected work replaces only the missing conditional Play workload and resolves
the Gallery artwork context. Private runtime/review evidence is under
`localization/probes/ru-menu-20261027-*` and `outputs/menu-ui-20261027-2022/`.

The final six-frame caption/layout acceptance combines the four unchanged passed
frames with the passed affected Play and Gallery reviews. The exact Gallery art
binding is Image8975 -> sharedassets1 Sprite442 `gallery_logo`, confirmed by
read-only active-Image metadata. It is a separate texture-only English heading,
covered by the owner's notify-only instruction, alongside the game-title logo.
One intermediate Gallery judgment passed every check but encoded this accepted
exception as an open finding. Its raw result is retained; a clarified Gallery-only
schema context produced an empty-open-findings, passed result on the same bytes.
No texture was modified or unreviewed visual defect waived.

`validation.json` binds actual resource readback, runtime controls, all six selected
per-image results, unchanged-frame reuse and measured review usage. The native
acceptance is limited to these six Russian frames with the declared artwork
exceptions; hosted, whole-game and other-language gates remain separate.

All 11 earlier preview tests, five locale-scope tests and three new menu tests
passed. The new controls reject unexpected existing text, preserve every other
selected text-object property and retain the exact earlier 212 JSONL records in
all 30 locales.

## Shared language packet

The shared supplemental catalog appends 234 source IDs: 228 additional serialized
fields and six code literals. It now has 446 records per locale / 13,380 targets
across all 30 non-English locales, including Russian. Earlier 212-record packets
are retained verbatim in history. Metagame confirmation wording does not assign
the avatar's gender to the physical player. Other-language independent editorial,
font/resource integration and runtime/visual gates remain separate and pending.

Regression: a few translated menu buttons cannot establish coverage of submenu
labels, confirmations or runtime string builders. Enumerate the complete bounded
menu family and actual consumers, compare every rendering layer, satisfy the
reported conditional workload, and verify the glyph boundaries in one known space.
Painted English artwork must be source-bound and reported under the owner's
texture instruction, not silently rewritten or granted an unrelated text exception.
