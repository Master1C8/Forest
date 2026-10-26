# Phase0071: original Actor identity, display defaults and controls

Text-only static supplement for The Forest of Love0.45. Worker argv verifies
`gpt-6.1-sol/high/OpenAI`. No agents, nested model jobs, images, game execution,
Git/index/branch mutation, original writes, authored target overlays or live-preview
interaction. Parent alone integrates; all parallel asset/editorial lanes remain intact.

## Exact source boundary

`decode_actor.py` reuses the unchanged v5 envelope/Reader, sparse string decoder,
and phase70 bool/string codecs. It decodes the complete original Actor39x7 table:
273 unique cell states,241 stored byte spans and32 absent states. Original row order,
field order, BGIds, nulls and byte spans are retained. Reencoding only stored spans
reconstructs all506640 original bytes exactly. This is a selected-span static no-op,
not resource reinsertion or a Unity load/save round trip.

`readback/visible-fields.jsonl` contains78 default-display states:46 nonempty values
and32 absent states. `readback/preserve-exactly.jsonl` contains195 identity/control
states. Null candidate states are retained for exact coverage, not translated phrases.
Both display defaults are candidates requiring a separate localized display mapping;
source acceptance and actual rendering remain open. No target wording was authored.

All3 identity columns are nonnull and unique, and their original declared unique keys
match the field IDs. Duplicate display values remain distinct cells: eight Mouse
nameplates and the two Charlotte nameplates must not be merged by source spelling.
Do not manufacture full names for absent original cells or infer character facts from
internal actor keys. Existing approved glossary/character decisions remain unchanged.

The verifier binds19 frozen pins,7 unchanged helpers,74 InventoryItem/46 Quest-progress/
44 consumer/49 Quest-control evidence hashes,9 original installed resource/DLL files,
the original TextAsset raw object and its complete exported payload. All55 Cecil
selections reproduce without executing game assemblies;8 generated sheet/field BGIds
match the original table. All12246 dialogue candidates compare exactly to both frozen
trees (24492 occurrences). All39 Actor plugin identities match exactly, with identical
actor IDs/indices/field pointers in both source copies (78 mapping states).

One initial Cecil selection looked for the plugin type in Assembly-CSharp and failed
because it is in Auto-asmdef-FirstPass. This was a static tool type-lookup failure;
`inspection-findings.json` preserves it. Bounded exact-type queries identified the
actual assembly before method selection. No game process or original resource changed.

## Input -> identity/state -> output

`actor-callback.il` copies BGEntity.Name to dbName and Actor.savekey/plugin_db_name
to separate runtime identity fields. It creates lookup dictionaries by dbName,
DB Actor object, plugin name and nonnull plugin ID; it also creates per-actor dialogue
lists. plugin name equality with player/narrator sets protected flags. SaveActor checks
exclude_from_save before reading/writing the original actor savekey. Nameplate/default
wording never replaces those identities.

`plugin-actor-get.il`, `plugin-actor-compare.il` and `plugin-asset-name.il` trace
PixelCrushers lookup: GetActor checks its name cache, otherwise compares Asset.Name
with String.Equals; Asset.Name reads the exact Name field. Frozen-tree matching is
static source evidence, not proof that a loaded runtime cache contains that actor.

`actor-display.il` binds NameplateName and FullName. Each checks CurrentBioDetail
and its nonnull overrideNameplateName, otherwise returns its respective default.
The shipped FullName getter does NOT read overrideFullName. `bio-loader-callback.il`
shows both original override fields loaded separately; the bounded field-use search
finds overrideFullName written but not read in original Assembly-CSharp. Preserve
this source anomaly; do not repair the original or silently use the full-name override.
Other assemblies/reflection and actual BioDetail source rows are not accepted here.
CurrentBioDetail caches a choice: first detail having any active enabling tag, else
first default, else list[0], else null. Related rows/order/tags/reachability need the
next bounded supplement, including cache invalidation; no override coverage is claimed.

`nameplate-input.il` passes runtime dbName to ordinary UpdateNameplate, not translated
NameplateName. Custom nonblank nameplates take precedence. Otherwise blank input hides;
a lowercased dbName containing narrator hides; one containing player returns without
the normal name update. Other dbNames resolve through GetActorByDbName. Visible output
is ??? until introduction, except start-menu or any-instanced-story bypasses. The
normal name then flows through NameplateName to legacy UnityEngine.UI.Text.
Protected triggers everyone/unison produce separate visible (Everyone)/(Both) literals;
these are code-literal candidates, not Actor default cells or translated control IDs.
Their complete trigger inputs and adaptation remain outside Actor-cell acceptance.

`critter-log.il` excludes22 actors from list creation using exclude_from_critter_log,
leaving17. Its labels show ??? until introduction; SetText/SetStatus write legacy Text.
`critter-bio.il` clears the pane if actor or any current Detail/Notes/Kinks is absent;
otherwise introduction controls FullName versus ???. Species/age/role and note/kink
fragments are separate pending source families. Excluded-from-save11 and excluded-from-
critter/map22 are separate flags, not permission to drop all their dialogue nameplates.

`map-nameplate.il` also filters by critter exclusion, stores dbName and displayName
separately, and resolves coordinates with dbName. `map-selected.il` passes displayName
to `map-label.il`, which writes both TMP and legacy Text. No display-name comparison
is present in these traced paths; selection/reachability and actual hidden-name map
behavior are unverified. `gossip-nameplate.il` stores ??? or NameplateName according
to introduction. Notification code appends it to separate English code fragments
Gossip Unlocked\nfor / Critter Log Unlocked\nfor; those fragments need their own mapping.

`portrait-nameplate.il` is a separate movie path gated by movie/show-nameplates state.
It uses protected dbName keys in replaceNames and may output that custom value instead
of NameplateName. Default names reach TMP via UpdateChildLabels. That path does not
establish the ordinary introduction mask for movies. Other portrait/forced-name inputs,
movie fields, standalone code fragments and related resources remain pending inventory.
All six NameplateName call sites and the one FullName call site in original Assembly-
CSharp are retained. This bounded call search does not prove absence in other assemblies,
reflection or editor tools and does not accept every consumer for resource replacement.

## Reproduction and remaining gates

From canonical Forest:

```
.venv-assets314/bin/python localization/source/bgdatabase-20261027/actor-identity/verify_actor.py --output <new-directory>
```

Fresh decoding and all7 readback files reproduce byte-for-byte in separate temporary
paths; `reproducibility.json` pins scripts and outputs. Bool controls include both valid
0/1 bytes and exact rejection of invalid width/noncanonical values. These tests exercise
static parsing/preservation; no mocked test is credited as actual runtime acceptance.

Regression scenarios for later display integration: translated Scarlett default must
leave bunny plugin lookup/savekey/dbName unchanged; unintroduced ordinary output stays
???; movie replaceNames remains keyed by original dbName; FullName with a nonnull
nameplate override follows that override even when full-name override differs; absent
full_name stays absent; all eight Mouse cells retain separate IDs; critter exclusion
does not remove valid dialogue nameplates. These are requirements, not run runtime tests.

Next bounded work is original BioDetail18x10 and its exact Actor/Tag/BioKeyword relation
bindings, loader/selection/cache consumers and override dependencies. Keep all other
families pending. Do not retranslate accepted glossaries, mutate frozen inventories,
replay53, start54, or operate the separate Russian preview. Accepted10/15/47/48 visuals
and50 route remain valid unchanged. Complete source/special-scene, semantic/independent
diff, final fonts/resources, reinsertion/runtime and delivery gates stay open.
Usage is unknown in this worker; parent measures actual telemetry.
