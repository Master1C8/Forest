# Phase0072: original BioDetail, overrides and related keyword slots

Text-only static supplement for The Forest of Love0.45. The current process argv
verifies gpt-6.1-sol/high/OpenAI. Parent alone owns Git/index/HEAD. No agents,
nested model jobs, target overlays, image input, GUI/runtime interaction, original
resource writes or deployment occurred. All parallel asset/editorial lanes and
the separate Russian preview remain independent and untouched.

## Exact source and preservation

`decode_bio.py` reuses the unchanged v5 envelope/Reader and prior string, bool,
single/multiple-relation and sprite-key codecs. It decodes all BioDetail18x10
cells, then only the25 distinct BioKeyword rows referenced by line1/line2/line3
(25x4 cells out of111 total keyword rows). Unreferenced keyword row values are
opaque; reading their column envelope/spans does not accept their content.
All row indices, field order, BGIds, spans and absent states are retained.

The280 selected cell states contain226 stored spans and54 absent states.
`readback/visible-fields.jsonl` retains61 candidate states:36 absent override
states and25 nonempty bio_text values. Nulls are coverage states, not translated
phrases. `readback/preserve-exactly.jsonl` contains219 identity/control/resource
states. All73 relation edges resolve to exact existing Actor, Tag or selected
BioKeyword rows/cells. Source fields named name/savekey/plugin_db_trigger_name,
portrait addresses, relations and booleans stay protected. In particular, the
original `town_arial_taxi` key is not corrected to match visible `Town Aerial Taxi`.

All36 original nameplate/full-name overrides are absent. This adds no present
name override wording and does not authorize inventing one. The shipped FullName
getter still checks/returns overrideNameplateName, while overrideFullName is
loaded separately and has no read in the prior bounded Assembly-CSharp search.
Keep the anomaly and default-display mapping separate from source identities.
No source/glossary fact, target text or frozen candidate inventory was changed.

`verify_bio.py` compares all19 frozen pins,7 helpers,285 prior supplement evidence
hashes (74+46+44+49+72),9 installed resource/DLL hashes, the original TextAsset raw
object and506640-byte payload. It checks16 generated sheet/field BGIds,44 exact
Cecil selections and all12246 candidates in both frozen trees (24492 values).
Reencoding the226 stored spans leaves the entire original payload byte-identical.
This is selected-span static preservation, not reinsertion or a Unity round trip.

## Input -> related list -> selected/cache state

`manifest-order.il` loads Tags and BioKeywords before Actors and ActorBios.
The phase71 `bios-loader.il` and `bio-loader-callback.il` are hash-bound reused
evidence. GenerateActorBios enumerates each DB Actor's typed reverse BioDetail
relation and appends each created runtime detail to actor.bioDetails. It copies
name and both overrides separately, resolves line1/2/3 through the exact DB-keyword
dictionary, and appends enabling tags through the exact DB-tag dictionary.
The slots are species, age and role, in that order. No text spelling establishes
character identity, pronouns or glossary facts independently of these bindings.

The generated Actor reverse getter calls virtual BGFieldRelationSingle.GetRelatedIn
with one Actor BGId, then copies the result by index into a typed list. This
single-ID path enables the reverse cache. Constructors leave allowDuplicates
false; Ensure creates ReverseRelationCacheValue, whose dirty list is populated
from a set and then Sort()ed. BGEntity.CompareTo compares Index. The store also
enumerates its array by ascending index when building the cache. Thus the frozen
initial reverse result is ascending BioDetail row index, preserved by the typed
copy and loader append. This is original-code evidence; no game assembly was
executed. Later database mutations and other cache configurations are unverified.
The unrelated HashSet-of-target-IDs overload does not determine this path's order.

`multiple-getter.il` resolves enabling-tag IDs in stored list order and skips
missing targets. All18 original lists contain one valid exact Tag; no missing
target is silently accepted. Main/main is row0, and Instanced Event Vslice/
instanced_event_vslice is row12 of the existing Tag supplement.

`actor-selection.il` chooses the first detail having ANY active enabling tag;
only if none match does it choose the first default, then list[0], then null.
There are17 distinct related actors, exactly the17 actors not excluded from the
critter log;22 actors have no detail. This equality does not accept other critter
requirements. Charlotte alone has two details: row2 default/Main, then row15
nondefault/Instanced Event Vslice. Static tag truth table:

| Main | Instanced Event Vslice | Selected detail |
| --- | --- | --- |
| false | false | row2, default fallback |
| false | true | row15, tagged match |
| true | false | row2, tagged match |
| true | true | row2, first tagged match |

The row15 role points to Temporary Bodyguard; row2 role is absent. These are
distinct source cells and conditional display dependencies. Actual reachable tag
combinations, story timing and which variant a saved game selects remain unknown.
`selection-scenarios.json` enumerates every boolean combination of the related
tag IDs for each original actor, as static consequences, not runtime tests.

CurrentBioDetail chooses when its cache is null, then retains a nonnull detail.
SetDirtyBioData clears current Detail/Notes/Kinks together. The only direct caller
in the bounded original Assembly-CSharp search is ActorTrackingService's
OnActiveTagsChanged, which iterates all actors. Add/RemoveEventListeners binds
that handler to GameEvents.onActiveTagsChanged. Both NarrativeActions.UpdateTags
overloads invoke the event only if their local changed flag is true. Actor.Load
does not directly clear this cache in the inspected body. Listener lifecycle,
save-load ordering, reflection/other assemblies and actual event delivery remain
unverified; this is not a blanket cache-invalidation runtime guarantee.

## Display, unlock and resource boundary

`keyword-callback.il` loads BioKeyword.bio_text into runtime text and keeps name,
savekey and plugin trigger in separate lookup dictionaries. The25 selected
bio_text values remain candidates only. Full111-row keyword/trigger/save consumers
and the remaining86 rows belong to the next bounded family.

`bio-values.il` returns the corresponding keyword.text or null; unlock checks use
actor-owned keywordData keyed by original keyword.dbName. `keyword-unlock.il`
rejects null/unrelated/already-known keywords and adds a matching keyword with
StoryClock time when absent. The reused critter-bio.il clears the whole pane if
any current Detail/Notes/Kinks is absent. When introduced, it attempts to unlock
the three current Detail keywords before displaying them. It otherwise uses the
existing unlock mask, so introduction and prior keyword state must not be replaced
by a blanket always-visible rule. Three output slots are assembled with the
original `{0}\n{1}\n{2}` format and unknown slots use `???`, through legacy Text.
Notes/Kinks availability, other unlock routes and actual UI reachability remain
pending. No target wording or actual rendering is accepted here.

The portrait key goes through GetAddressablesAddress/SetAssetKey; the captured
closure callback stores the loaded Sprite into runtime bioPortrait.17 original
keys are nonnull; Charlotte's row15 portrait is absent. Keep that null and all
addresses exact. No Addressables load, texture inspection or fallback behavior
was tested. These resource states remain independent of display wording.

## Reproduction and remaining gates

From canonical Forest, with a new output directory:

```
.venv-assets314/bin/python -B localization/source/bgdatabase-20261027/bio-detail/verify_bio.py --output <new-directory>
```

`reproducibility.json` binds a fresh decoder and all8 readback outputs compared
byte-for-byte in a separate temporary directory. Matching positive codec controls
and exact malformed-width/noncanonical-bool rejection exercise parsing boundaries;
they do not exercise renderer, resource loader or game state.

Regression requirements for later integration: preserve Charlotte's two row IDs
and tag priority; both tags true selects row2 under frozen initial order; switching
to row15 requires the original event/cache mechanism; no active tag falls back to
row2. Shared Mouse/species text may share a display translation but must not merge
actors, relations or unlock state. Town Aerial Taxi must retain town_arial_taxi as
its control key. Absent overrides/full names/portrait remain absent. Keep the
FullName nameplate-override anomaly and the ordinary introduction masks. These
runtime scenarios are requirements, not executed checks.

Next: append-only full BioKeyword111x4/control/unlock consumer supplement, reusing
these25 exact rows and pinning the86 newly inspected rows separately. Do not broaden
to BioNote/BioKink or accept their semantics incidentally. Quest ordering/reflection/
counter uncertainties remain unchanged. Complete source/special scenes, semantic/
independent diff, final fonts/licenses/resources, reinsertion/runtime and delivery
remain open. Accepted10/15/47/48 visuals and50 route are unchanged; no53 replay/no54.
Usage is unknown in this worker; parent measures actual telemetry and integrates
the exact files without a worker commit.
