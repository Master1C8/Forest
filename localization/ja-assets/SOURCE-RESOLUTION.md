# Japanese held-source resolution recipe

This adapter belongs only to the Japanese provisional asset lane. Shared source,
other locales and the Git/index remain read-only. Keep the exact verified
`gpt-6.1-sol` / high / OpenAI selection, with fresh contexts and no nested jobs.

Original authored TSVs and their hold reasons remain immutable. Add a new frozen
receipt under `resolutions/` for each bounded source group. Bind every resolution
to the original stable ID, source hash, pointer, both physical occurrences, target
hash, original hold reason/hash and immutable own-lane evidence hashes. Never
replace a saved target through this mechanism. Target retirement still requires
the separate immutable retirement receipt contract.

`resolution_support.py` accepts exact detached-source preservation, reviewed ordinary
bracket display, the six exact source-bound provisional display candidates in
phase 0034, the nine exact narration fields in phase 0037, and the 43 exact
constructed-language preservations in phase 0035, plus exactly five OPEN source-warning
preservations in phase 0038.
Other disposition categories or new display candidates require their own
actual source/consumer/font/reveal evidence and an explicitly tested extension;
the category names in the counters do not accept them automatically.

Detached-source preservation requires conservative whole-source graph traversal:
start at every first, `isRoot`, titled or arc-keyed entry, follow every outgoing
cross-conversation link, and ignore conditions to overapproximate reachability.
Verify the actual loader's title/arc selection and link recursion. Require the
resolved node to be outside that reachable graph. Preserve the entire original
field byte for byte, retain its denominator/occurrences and classify it separately
from Japanese wording. Static detachment does not rule out external direct-node
selection and does not establish global runtime invisibility. Names, capitalization,
colons and an authoring-like appearance alone never justify preservation.

Square brackets remain opaque by default, including unknown controls. Open only
explicitly reviewed outer bracket ordinals in source-bound display receipts. Keep
both delimiters and all nested Lua/engine/unknown controls, rich-text tags, brace
placeholders, numeric literals and line separators exact. The two flower narration
occurrences at `131:153` and `540:232` are approved as ordinary display prose by the
concrete FormattedText and UI/typewriter consumer chain. They are not a rule to
open every bracketed field. The same directly authored Japanese wording is stored
in `0031-translation/flower-display.tsv` and bound in its receipt.

Concrete regressions: an unknown bracket must reject body edits; a changed nested
Lua operand, numeric literal inside an opened display bracket, placeholder, rich
text tag or separator must fail for that intended reason. A known engine control
must reject prose reclassification. A candidate that becomes reachable must reject
its old detached disposition even when its snapshot proof is otherwise refreshed.
An existing target must reject resolution overwrite. `check_resolutions.py` exercises
matching positive controls and these negative boundaries.

Run from the canonical Forest folder:

```sh
PYTHONDONTWRITEBYTECODE=1 python3 localization/ja-assets/check_resolutions.py --output outputs/locale-assets-20261026/ja/<current-phase>/guard-tests.json
PYTHONDONTWRITEBYTECODE=1 python3 localization/ja-assets/corpus.py build
PYTHONDONTWRITEBYTECODE=1 python3 localization/ja-assets/check_poetry.py
```

`prepare_resolution_0031.py` and `freeze_resolution_0031.py` reproduce phase 0031's
bounded source evidence and receipt; they do not generate Japanese wording. They
refuse to change existing frozen evidence. Phase-specific preservation/recovery
checks are `verify_preservation_0031.py` and `check_resolution_rebuild.py`.

Phase 0032's bounded resolver is
`outputs/locale-assets-20261026/ja/0032-translation/resolve_detached.py`. It freezes
400 next-held detached records in canonical source order, through a complete
conversation boundary, and uses the same exact source-preservation adapter.
Its receipt retains source facts, both physical occurrences, original holds,
independently rebuilt conservative topology and four hashed loader/arc consumer
files. No new Japanese wording is generated or credited. The guard checker now
tests all current receipts together and requires a new explicit output path, so
running a new phase cannot overwrite phase 0031's historical guard receipt.
Regression: adding a second resolution group must validate both groups, preserve
the first group's targets and all original authored TSVs, and leave prior evidence
unchanged; a checker hard-coded to only the first group's count is insufficient.

The builder validates resolutions before output writes, then replaces individual
files atomically. The corpus as a whole is not a transaction. A failure after the
overlay write may leave earlier unresolved/status files in place. Rebuild from the
saved batches and receipts, verify the first recovery postcondition, then verify an
unchanged repeat. The fault-injection fixture does this within the permitted output
lane; it does not run the game or test engine reinsertion.

The legacy `authoredIds` field is the retained-overlay count for supervisor
compatibility. Report `translatedWordingIds`, punctuation and exact source-preserved
categories separately. Source/editorial/special-scene/resource/runtime acceptance
remains open. This own-lane repair must not be silently overwritten by a shared
helper refresh; cross-locale integration remains with the owning technical lane.

Phase 0033's resolver in `0033-translation/resolve_detached.py` freezes all 507
remaining detached-source facts, from `ds:387:732:Dialogue Text` through
`ds:597:231:Dialogue Text`, using the same adapter and independent topology.
The current apply guard covers all 1,312 resolution records across three receipts.
No Japanese wording was added and no target retired. The supervisor's phase 0033
`before.json` retirement map is empty despite 55 existing retirement receipts;
this is not evidence of absence. The own pre-change `saved-inputs.json` binds the
complete retirement file hash, and `verify_preservation.py` verifies all 55
preserved targets and evidence. Regression: an empty supervisor summary must not
remove or invalidate an intact, independently bound retirement file. Never edit
the supervisor snapshot to repair this discrepancy.

Phase 0034 freezes six provisional display-field resolutions in
`0034-translation/resolve_display.py`: the metanarrative interruption at `43:11`,
Mabel's actions at `477:766` and `477:810`, and plant descriptions at `526:940`,
`526:948` and `526:951`. Japanese wording is authored in that phase's
`authored-display.tsv`; scripts only bind it. Complete original source conversations,
explicit titled-selector routes, both physical occurrences, static consumer copies,
glossary hash and immediate-edit decisions are retained. This does not establish
global runtime visibility or reclassify other directions, labels or placeholders.

The adapter pins the six exact source fingerprints. Every field must retain its
reviewed empty service fields, non-group execution state and empty serialized callback,
have an actual linked route from a titled selector, preserve all opaque controls and
narration asterisks, and bind its authored target and source to the frozen decision.
Regression: an authoring-like phrase can still be display prose; a suppressing sequence,
service title, group/script/callback, lost route, changed source, missing narration
delimiter or unchanged English must reject for its intended boundary after unrelated
earlier guards have been satisfied. `0034-translation/check_display.py` records 18
positive/negative checks. The shared own-lane guard also checks all 1,318 records from
four resolution receipts. Neither test is a renderer or runtime check.

Phase 0035's `0035-translation/resolve_mouse.py` freezes the 43 unfamiliar utterances
from seven complete source conversations. Approved Japanese glossary tfol-068 requires
preserving their unfamiliar character and reveal timing. Exact preservation covers
Latin/IPA payloads, whitespace, punctuation, controls and source anomalies, including
505:1142's repeated unclosed markup and 505:1165's extra bracket. These are visible
constructed-language records, counted separately from Japanese wording and detached
technical records. Existing ordinary-language reactions/explanations retain their targets.

The immutable Japanese `mouse-decisions.json` hash is pinned in the adapter. Every
source ID/hash, exact payload, prior hold, both occurrences, full seven-scene context,
selector route and font-control entries must match. The static loader/trigger/event/UI
trace and serialized OokLanguage_TMP map are retained in this lane. FONT(main) returns
do not establish that an unfamiliar utterance should be decoded or translated. Missing
source font-table codepoints remain a resource question; static maps do not prove actual
glyph rendering, fallbacks, trigger order or timing in game.

Concrete regression: a source-bound unfamiliar utterance passes byte for byte; replacing
it with Japanese, Latin transliteration, decoded English or a repaired spelling/tag/bracket
must fail even with a refreshed target hash. Changing an actual scene/font-control entry
and refreshing its proof must still fail the frozen context binding. A neighboring English
reveal with otherwise refreshed valid source/proof bindings must fail exact group membership.
The 24 checks in `0035-translation/check_mouse.py` exercise these boundaries and all 1,361
current resolutions together; the shared checker retains its 22 guards.

At phase 0035, source-warning dispositions were unsupported pending separate source-specific
decisions. Phase 0038 now supplies that exact decision for five IDs only, as documented below.
Never classify another dummy as new prose or decode unfamiliar mouse speech merely to eliminate
a hold. Phase preparation requires its original pre-build snapshot; do not replay it
against advanced targets. Builder replacements remain individually atomic; this extension
does not change the multi-file commit boundary or claim new partial-write recovery evidence.

Phase 0036's `0036-translation/resolve_detached.py` resolves 214 additional held
directions, attempt labels and speaker labels from source conversations 444, 445,
447, 448, 449, 451, 452, 453, 455 and 457. These decisions are derived from the
complete pinned source topology in this lane, rather than limited to the supplied
fact manifest's earlier detached category. The unchanged adapter and an independent
serialized-field traversal agree on all roots and reachable nodes. Every selected
record lies outside that conservative bound. Preserve detached chains as well as
nodes with no incoming links: absence of an immediate parent alone is insufficient.
Do not translate or repair these preserved cues, their punctuation or source typos.
This is no claim of global runtime invisibility or a source-inventory exclusion.

Regression: a held label outside the earlier supplied detached-fact group must still
receive an exact source-bound decision when complete topology supports it. A routed
placeholder must not be swept into that group merely because it looks unfinished.
All five routed literal placeholders at 50:82, 50:87, 52:128, 52:129 and 496:20
remain held, with complete source conversations and precise findings in this phase.
Nine reachable narration fields remain independent translation work. The phase's
verification reconstructs its original 228 holds, preserves all earlier targets,
batches, receipts and retirement evidence, and accounts for all 12,246 candidates.

Phase 0037 resolves those nine fields with directly authored Japanese from four
complete pinned source conversations, exact titled-selector routes, serialized
execution state and the static subtitle/formatting/callback consumers. The actual
nonempty fields lack suppressing service fields, groups, scripts and callbacks.
This is a provisional display classification, not a global visibility assertion.
The five unfinished routed placeholders retain their original holds; a category
counter never authorizes source-warning preservation.

Narration decisions now pin both semantic spans and complete reviewed scene
context. Standalone narration must retain exactly one nonempty asterisk pair
after any exact portrait prefix, with no speech added outside it. The one mixed
field at 949:712 must remain one indivisible field: initial asterisk-enclosed
narration, one ASCII space, then nonempty speech outside the asterisks. Its frozen
source and target span bindings preserve Oliver withdrawing from Augustus's mouth
and Augustus's disappointed response. Do not apply the old whole-field end-asterisk
assumption to this explicitly reviewed mixed field, or use its exception for a
different ID. All unknown brackets and ordinary control guards remain unchanged.

Concrete regression: a source-bound mixed field passes with its original narration
and speech order. Deleting either span, enclosing the speech as narration, swapping
their contents, changing the join or adding a spoken tail to standalone narration
must reject for the intended span boundary with refreshed target hashes. Portrait
prefixes, source fingerprints, actual routes, execution state, neighboring context
and source-warning rejection are also checked. The phase checker uses source fixtures;
it cannot establish real engine parsing, font choice, timing or rendered output.


Phase 0038 implements the parent technical disposition in
`outputs/locale-assets-20261026/ja/source-repair-20261027-final-five/source-decision.json`.
This is conservative provisional preservation authority, not a new owner quote or
source acceptance. The adapter admits only `ds:50:82:Dialogue Text`,
`ds:50:87:Dialogue Text`, `ds:52:128:Dialogue Text`, `ds:52:129:Dialogue Text`
(complete `[pic=1]placeholder`) and `ds:496:20:Dialogue Text` (complete `[pic=1]TBD`).
Every value remains byte-exact, controls included, with `sourceDefectStatus: OPEN`.
These routed fields remain in the candidate denominator; no Japanese wording,
source fix, technical exclusion or global runtime invisibility is credited.

The immutable `0038-translation/warning-decisions.json` pins this five-member group,
parent decision, full original entries/scenes, source hashes/pointers, both physical
occurrences, original holds and hashed own-lane/static consumer evidence. All prior
receipts, original TSV holds and retirement receipts/evidence remain intact.
`resolution_support.py` requires all five exact warning records together; arbitrary
new English and unreviewed IDs cannot use this exception. `corpus.py` persists five
separate `sourceWarnings` in progress/result and OPEN status on overlay rows.

Regression: all five complete original values pass, while changed bytes/control,
refreshed but changed source/target hashes, pointer or occurrence loss, unknown ordinary
English, a missing/duplicate member, defect closure and existing-target overwrite
reject at their intended boundaries. Run phase 0038's `check_warnings.py`, the shared
`check_resolutions.py`, phase 0038's adapted `check_narration.py` and `check_poetry.py`.
The narration harness retains the nine accepted source/target decisions and rejects
using this five-ID exception for any narration field. It leaves the prior immutable
harness/report intact.

Provisional pinned-family coverage can now be 12,246 retained IDs / 24,492 occurrences
with zero drafting holds: 10,611 Japanese wording, 63 punctuation, 1,524 detached-source,
43 unfamiliar-language and five source warnings. Full source/editorial/resource/renderer/
runtime/release acceptance remains pending. Handoff to the shared source/editorial lane;
never launch an unchanged drafting loop to invent the absent intended dialogue.
Individual atomic file replacements remain the builder's commit boundary; no new
multi-file transaction or partial-write recovery evidence is claimed.
