# Phase0070: all remaining Quest controls and Tag identities

Text-only original-source supplement. Actual worker argv verified gpt-6.1-sol/high/
OpenAI; no inherited history, agents, nested model jobs, game, images or Git mutations.
Parent alone integrates. All seven asset lanes, six preliminary editorial lanes and
Japanese continue independently; the actual Russian preview is untouched.

## Exact input and codec boundary

`decode_controls.py` reuses the unchanged v5 envelope/Reader and Quest decoder.
It adds seven columns across38 original Quest rows (266 states), plus the complete
18x2 Tag identity table (36 states). Earlier five Quest columns and119x6 log states
remain unchanged and are freshly rechecked. This completes typed decoding of all12
Quest columns; it does not complete all Quest consumers or whole-game extraction.

`readback/preserve-exactly.jsonl` retains302 unique cell selectors, values, original
byte spans/hex, absent states and order. All302 are controls/identities/resource
keys, not authored display text.255 stored spans reencode exactly;47 are absent.
Replacing just those original spans reconstructs all506640 original bytes exactly;
this is a static selected-span no-op, not a resource reinsertion/Unity round trip.
Bool codec admits original0/1 bytes only, while documenting the shipped nonzero=true
semantics; malformed widths/noncanonical bytes reject rather than normalize. Int is
signed little-endian32. Variable strings and sprite keys retain UTF-8/nulls. Multiple
relations retain original sequence and multiplicity; both tag fields declare
allowDuplicates=false. Do not turn absent data into a newly stored empty list.

Sprite configuration is version2, Addressables loader, empty loader configuration,
location constraint0. The subclass's version2 reader is distinct from its base
class's version1 reader. `sprite-codec.il` binds the actual reader and stored-key
semantics; the values are28 plain asset paths and10 nulls, not Portrait-table links.
No pixel inspection, catalog resolution or successful runtime load is claimed.

The verifier checks all19 frozen pins,6 helpers,74 InventoryItem,46 Quest-progress
and44 consumer evidence hashes, six installed resource/DLL/bundle hashes, raw original
TextAsset hash and complete exported payload. Both frozen dialogue source trees are
hash-checked against their manifests and every12246 candidate pointer compares to
both copies (24492 occurrences). Original resource/bundle hashes bind these unchanged
exports; no game/renderer is executed. All33 exact Cecil selections reproduce without
executing game assemblies;11 sheet/field BGIds match generated getters. Fresh decode
and all six readback files reproduce byte-for-byte in a separate temporary directory;
`reproducibility.json` binds the exact scripts and outputs.

## Input -> runtime controls -> output selection

`db-controls.il` binds each original field/getter. The unchanged Quest loader callback
is `../quest-progress/quest-callback.il`; it copies bio_hidden to isHiddenInQuestLog,
priority to priority and is_side_quest to isSideQuest. It resolves each nonnull Tag
relation through tagsByDbTag and appends in enumeration order to initialized runtime
lists. `tag-callback.il` copies original Tag.name/savekey and binds both lookup maps.
`tag-active.il` tests activeTagsByDbName.ContainsKey using the original dbName.

`available.il` checks disabling tags first: any active one returns false immediately.
It then returns true only when at least one enabling tag is active. Thus enable is
OR, not AND; empty enable lists return false. Every original Quest has an enabling
list. Ten rows have both Main and Main Act 3, so either active name satisfies the
positive predicate; do not silently strengthen it to both. The48 enabling links and
one disabling link all resolve to actual Tag rows with stable identity and savekey.
The sole disabling link is GreatFallFeastQuest -> Disable Sidequests. Source semantics
are preserved; actual tag states/producers and reachable availability remain pending.

`readback/dependency-bindings.json` binds all38 Quest controls to their exact Tag
identity cells, existing bio title/description/log candidate IDs and runtime guards.
`questlog-start.il` excludes hidden Quests before creating labels and assigning title.
`../quest-consumers/quest-available.il` applies hidden guard before IsAvailableWithTags
on refresh. Generic notifications use a hidden guard only after special branches;
hidden does not prove all output paths unreachable.10 rows are hidden,28 not hidden.

Quest priority differs from log priority: Quest values include17 zeros,20 distinct
positive values and-999, whereas all119 log priorities remain0. Loader sorts Quests
ascending; active/completed Quest labels sort descending. Each comparator has no
secondary key. Equal-priority ordering stays unverified; do not infer it from input
row order, stable sort, or the existing initial-unlock relation column.

Seven rows are side quests. `oracle.il` uses isSideQuest to separate main/side choices,
then prefers eligible primary over supporting first-in-quest unstarted dialogues.
Its helper eligibility and complete Dialogue family are not traced here. `reset-tag.il`
is a dev reset path using enableWithTags.Contains; do not localize Tag identities.

Portrait loader first calls the original sprite getter and checks nonnull. Only then
it creates the generic loader using GetAddressablesAddress, stores the loader and
registers it in manifest.addressableAssets. `portrait-callback.il` assigns loaded
Sprite to Quest.portrait; existing pane methods consume it. Stored key presence alone
does not prove that the preliminary getter succeeds or that a portrait is displayed.

plugin_db_name_prefix values look like dialogue paths but their getter-call search
is empty in original Assembly-CSharp. They remain protected metadata with unresolved
consumer semantics. Other assemblies/reflection/editor tooling were not searched;
this is not a dead-data finding or permission to derive routing from the prefix.

## Preservation and next bounded work

StartQuest and AdventureModePlaceholder still use runtime progressLogEntries[0], not
the30 declared initial relations. Log priority-only sorting has no proven first row.
Reflection/other assemblies remain pending. Preserve all prior anomalies, the identity
counter adapter requirement, accepted10/15/47/48 visuals and50 route.53 is consumed;
no54, game relaunch or unchanged runtime retry is authorized here.

Reproduce from canonical Forest into a new output path:

```
.venv-assets314/bin/python localization/source/bgdatabase-20261027/quest-controls/verify_controls.py --output <new-directory>
```

Compare all six outputs to `readback/`. Source/special-scene, semantic/independent diff,
fonts/resources, reinsertion/runtime and local-delivery gates remain pending. The
next static supplement can cover the original39x7 Actor identity/display/control
columns and their loader/nameplate consumers, without changing frozen inputs or
accepted glossaries. No target wording or source repairs were authored here.
Usage telemetry is unavailable to this worker; parent measures the actual phase.
