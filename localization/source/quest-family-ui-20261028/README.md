# Complete Quest display repair

Canonical source is the game0.45 English BGDatabase payload pinned by
`inventory.json`, plus the28 exact compiled display operands in `code.json`.
The former tutorial repair selected only six cells. This addition reconciles
all38 Quest rows (title/description) and all119 QuestProgressLogText rows:
195 states,177 nonempty display cells and18 nulls. Six existing translated cells
are retained;199 new core source units plus24 actual journal header fields are appended in
every one of30 locales.
All26 additional glossary-backed titles use the approved locale terms.
The157 other distinct phrases are directly authored, never script-generated.
Frozen12246-ID dialogue inventories and active editorial lanes are unchanged.

`special-decisions/` contains actual locale wording for all38 special keys,
prepared before ordinary119-key authoring. These are author decisions, not
independent editorial passes. `locale-authoring/` preserves the bounded23-locale
CLI handoff, all reviewed author keys, its10 collected self-edit repairs,
final hashes and measured usage. The coordinator authored the other seven.
`author-findings.json` records additional specific corrections, including the
female former roommates Claire/Violet in Russian and Spanish.

## Technical boundaries

Three source tests for English `lost photos` previously controlled the counter.
`tools/quest_patch/Program.cs` now records provenance from the exact entries
selected by the original history algorithm and shifts the selected slot on
completion. It preserves the original sort/replacement semantics, all nine
photo trigger keys, count/total producers, format strings, branch conditions,
locals and exception handlers. Static runtime-only booleans are never save keys.
All original method bodies restore exactly after reversing the bounded patch.
The final layout also hooks the original notification after its16 label writes;
its queue guards, scheduling, animation triggers and events remain unchanged.

`tools/russian_quest_family.py` projects all177 cells with exact before-payload,
row/field identity,18-null,15 technical-column, readback and whole-payload
restoration checks. `tools/quest_supplement.py` and the common generator preserve
each old712-record prefix byte-for-byte and add199 identical source IDs per
locale. The resulting935 records x30 locales are28,050 targets.
The original quantities, logical AND region groups, fixed region order,
comma cleanup, greetings states, independent storm notifications and dormant
completion branches are retained. The source all-regions-complete-but-active
`More critters .` anomaly remains explicit; no invented game behavior repairs it.

`scroll-view-cache.il` proves the content-null IsActive guard:assigning viewport
before content skipped cache invalidation. The repair assigns content first,
then viewport through the normal public API. Native QA checks the actual internal
view reference and stable top/bottom positions.

The native detail pane originally had an unconfigured ScrollRect and no wrapping
for step histories. Complete Russian regional text exceeded the right viewport.
The helper uses that ScrollRect, a bounded viewport, complete text wrapping and
actual generated glyph bounds for body flow while preserving font,size and art.
Title and portrait stay fixed. Description and history scroll in the left
column,reserving the whole source portrait/backing rectangle at every position.
Refreshes preserve normalized scroll position. Native HUD16 face/outline layers share a
320-unit wrapping column and retain their source offsets,font and size24.
No texture, save, quest identity, unlock or ownership field is translated.

## Finite acceptance

| Artifact / predicate | Evidence | Remaining boundary |
| --- | --- | --- |
|195 source states /28 compiled operands | inventory,code,original consumer traces | This finite family is complete;whole-game inventory remains separately owned |
|30 locale append files |935 units each;old712 prefix preserved;source/glossary/placeholder checks | Independent semantic/diff review and each locale's application/fonts/RTL/runtime remain pending |
|Counter identity |1040 actual managed-history scenarios,12,480 slot assertions;original/patched selections/text equal | CLR test replaces Unity loader/UI/real flags |
|Russian loaded source and live consumers | QA receipts compare195 loaded states;512 photo masks,60 pane slot/count cases,64 regional/status states | Fixtures are reversible in memory;no owner save,award,dialogue advancement or user-input acceptance |
|Native journal and HUD fit | Exact final capture and review receipts are linked by validation.json | All6 final actual per-frame judgments pass;physical input/natural progression remain unrun |
|Owner progress | Disposable products/fixture only;original player preview preserved | Owner launch/compatible save transfer is a separate explicit action |
|Release | Local repair and supplemental inputs only | No publication,deployment,installer or whole-game acceptance |

## Notify-only artwork

The remaining English Active/Completed headings are painted sprites:
Image18317 → Sprite544 `QuestLog_Label_Active` and Image18345 → Sprite593
`QuestLog_Label_Completed`,both sharedassets2. L/R navigation icons are fixed
sharedassets0 sprites386/381. Their pixels remain unchanged.

The initial Quest Log texture classification was WRONG:its legacy Image18877 is
disabled. Quest Log and Critter Log are actual TMP text,24 face/outline/provider
fields across the two size variants. `journal-label-classification-correction.json`
withdraws that earlier exemption without altering immutable past review inputs.
All24 fields now reuse approved terms tfol-054/tfol-053 in every locale. Source
16/20 base sizes,22/30 first-grapheme emphasis,fonts,rects and disabled Images
remain protected. One complete title replaces English two-initial emphasis,
matching the existing Notebook title recipe. Other-locale shaping/fonts remain
separate gates. Map/Inventory header terms are absent from the approved glossary;
they are native text outside this bounded approved header application,not textures.

## Reproduction and lessons

Run `tools/inspect_quest_family.py --check`, the supplemental generator `--check`,
and the focused Quest/UI regressions. Final build metadata identifies the exact
immutable recipe and helper DLL. The incremental build is verified separately
from the updated but unrun full rebuild recipe.

A source label is not a technical identifier merely because a prototype contains
it:trace its actual consumer. Conversely,never translate an English comparison
operand to make one example pass;replace the wording dependency with verified
identity. TextGenerator character coverage does not establish ink bounds or
portrait clearance. A top/bottom pair must prove distinct normalized positions
and full body coverage after actual native layout settles.

For screenshot review,copy each packet's actual index;never reset indices by
packet length or infer them from filenames. Inspect only assigned images.
Preserve invalid answers and genuine findings,without inventing imports or passes.
Future worker runs must freeze all later-read helpers,not only their brief.
Current author inputs are bound to unchanged source/glossary and exact selected
wording functions;the additive helper source-pin list does not alter translation.

HUD rendering fixtures bypass normal journal/queue guards. The first final cycle
reopened the journal because its Boolean argument means suppressSounds,not
visibility. A guarded close now toggles only while visible. The
corrected fixture explicitly hides that unrelated journal root,reports its
inactive state,and restores it before exit. This is a harness correction,not
evidence of a product queue defect. All30 visible and8 empty loaded title states
are checked separately for bounds/empty UI text;this is not38 semantic screenshot
judgments. Cold-host transport failures retain their exact process identity and
receipts;the final fresh runner has bounded90-second command transport without
restarting a bottle or common Wine service.

Final local result:all6 final native frames pass actual visual review,all45
focused regressions pass,and the final CSharp matches the1040/12480 verified
managed-history test version. `validation.json` and `native-evidence.json` bind
originals,prepared inputs,loaded fields,restoration and the actual artifact.
