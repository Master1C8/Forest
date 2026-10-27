# Five-page notebook tutorial repair

The two supplied screenshots show GossipTutorialRedux page1 and page2 in the
pinned game version. The matching modern text is sharedassets2's PagedTutorial
15851, referenced by ItemGetNotification18057.gossipTutorialPrefab. This differs
from the unused older gold-border GossipTutorial_1/_2 image assets.

The complete five-page inventory contains186 text fields:156 TMP display fields
(title parts, captions and six-layer explanatory paragraphs) plus30 legacy action
labels paired with the source button sprites. The156 TMP source IDs are appended
to the common packet for all30 locales; prior556 target lines remain byte-exact
prefixes. Each locale now has712 records /21,360 targets overall. Approved Notebook,
Critter Log, Quest Log and Gossip concepts supply terminology. Title emphasis is
adapted to the target first grapheme without splitting combining marks; supported
size22/36 markup remains valid and the complete title is retained. LF/CRLF/CR
sequences, including trailing separators, are preserved per field.

The owner forbids texture fixes. All Images, Sprites, texture pixels and paired
legacy action labels remain unchanged. TALK/GOSSIP are retained verbatim in body
instructions so they refer to the actual visible sprite controls. artwork-bindings.json
pins Continue, Gossip, Talk, Talk Extra, Examine and the embedded sample-log artwork.
These are report-only artwork findings across all30 locales, not hidden text omissions.
The source old-image inspection used two WebP80 copies at840x468 with no upscaling;
original files remain unchanged. No texture was rendered or replaced.

The overlap comes from source lineSpacing−32 still being used after the shared
TMP face changed. russian_notebook_ui.py applies the proven metric_spacing formula
to every selected TMP field, retaining the original baseline-distance contract:
source−32 becomes3.760270357131958 with the delivered Russian face. Thirty
multiline face/glow child RectTransforms inherit their preferred-height parent
through vertical stretch anchors and zero height delta. Their original offsets,
pivots and horizontal geometry remain exact. Font resources, sizes, controls,
game/save state and unrelated fields are not patched. The selected complete type trees read back exactly and all unselected
raw objects remain byte-identical. The normal full and incremental build recipes
include the correction; a full dialogue/font rebuild is not claimed.

The Russian candidate is localization/previews/ru-20261028-notebook-final/game/ with
isolated identity ForestRuActual20261028_03. Its parent is items-fixed; earlier
menu, Actor, quest and item repairs remain. Only sharedassets2 plus the isolated
product identity/app.info change. Player saves are excluded from the artifact.

QA uses its own cloned synthetic fixture and never owner progress. Attempt01
opened the popup as soon as its resource existed in ChapterSelect, before the
actual gameplay scene rendered. All156 loaded strings and positive line gaps
matched, but the native image was black; preflight rejected it without a model
review. The copy exited and restored its localized assembly; fixture bytes and
parent artifact remained unchanged. Attempt02 waited for inGameplayScene and a
nonblank game render; pages1/2 captured, then page3 exposed real overflow in the
fixed50-unit face/glow child fields. The30-rect height-inheritance repair resolves
that shared cause without shortening the text or shrinking the font. Attempt03
exposed a capture observer that rejected empty visibility rows before waiting for
FadeIn; its immutable failure is retained. Attempt04 polls actual visibility and
captures all five pages from CentralForest. All156 loaded strings match; visible
fields have no overflow, fit the UI Camera viewport, and have positive line gaps.
Each attempt restored its private localized assembly and removed its bridge;
owner save files were never used, fixture hashes and parent artifacts are unchanged.
The first complete native review rejected the manual English title spacing. The
existing complete-title variant now replaces TitleWKerning on all five pages:
ten guarded source GameObject active states, with its original36/28-unit styled
text and no new font size or geometry. Source page1 has no caption; pages2–5 do.
Attempt05 captures the final title variant after suspending only the synthetic
fixture's unrelated dialogue canvas. Its source text is logged; dialogue is not
advanced and this staging is not a product change or award-flow test. The
complete final five-frame native manifest is bound to this build, runtime,
cleanup and exact acceptance context. Page visibility is staged through the
original PagedTutorial method without Submit or
Finish; this does not prove live award events, user input or save continuation.
Capture, native visual acceptance, independent editorial and full-game readiness
remain distinct. See validation.json for the actual final evidence and unresolved
gates. Other-language font/resource/runtime/visual and independent editorial gates
are pending; the30 authored inputs are not30 packaged games.

Regressions: changing a TMP face while retaining source lineSpacing−32 must
trigger metric compensation on every outline/face copy. A long paragraph must
exercise both preferred-height provider and its fixed-height replicas; overflow
on a child is a failure even when parent glyph bounds fit. A popup opened while
only its resource is loaded must wait for a rendered gameplay scene and FadeIn,
not accept a black transitional frame or treat zero visible rows as a pass.
Source-bound tests reject changed source text and changed child geometry before
mutation, verify all30 prior556 prefixes and preserve exact mixed line endings.

The source sample-log illustrations intentionally preview only part of the log.
The original Quest/Critter masks580/541 fade their bottom rows to alpha0; source
Image trees, Sprite raw data and original illustration pixels remain identical.
The source-pixel page5 detail is bound to its native original and exact crop
bounds, not used to hide any localized glyph. English sample artwork, Continue
and source action buttons are report-only under the owner's instruction.

Additional regression: manual English initial/rest positions can split a
translated single-word heading despite complete strings and valid bounds. Use
the existing full-title source variant, retain every translated alternate field,
and review all five pages after the shared switch. Caption expectations must
follow actual source presence; never invent a missing page1 caption.

Final bounded result: all five native frames and the required page5 source-bound
detail pass actual visual review. `native-review.json` retains each original
reviewer, timestamp, observations and checks; `retained-reviews.json` binds the
unchanged-frame receipts. The complete ledger checker passes. All33 code/data
regressions pass. Independent editorial, other-locale applications, full-game,
live-award/input and owner-save continuation remain separate unrun gates.

When a review requires a full frame and its crop together, pass `--max-images 2`
to the queue execution command; initialization alone does not retain that limit.
An incomplete pair remains needs-review until both are inspected together.
