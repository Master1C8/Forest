# Phase0075: original BioNote/BioKink slots and critter output

Static, text-only supplement for The Forest of Love0.45. Current CLI argv pins
`gpt-6.1-sol/high/OpenAI` in `phase0075-execution-model.json`. Parent alone owns
Git/index/HEAD. No agents, nested model requests, target translations, game/GUI
interaction, image input, original installation/save writes or deployment.
All authorized asset/editorial lanes and the independent Russian preview remain
untouched. This is bounded source evidence, not complete source acceptance.

## Recovery and exact source

Phase74 left a complete baseline, model receipt and six complete IL selections;
there was no saved decoder or decoded table to reuse. The six selections were
freshly reproduced from the original DLL and matched their recorded hashes before
reuse. Its historical model receipt and command manifest remain unchanged. The
phase74 interruption records are not rewritten. Phase73 is reused, not replayed
as a model turn; its unchanged deterministic verifiers run only to validate inputs.

`decode_notes_kinks.py` reuses the unchanged v5 envelope/Reader and string, bool,
single/multiple relation codecs. It decodes only BioNote17x16 and BioKink17x22;
all646 cell states retain row/field order, exact BGIds, source values and spans.
All are protected: names are runtime identity; actor/keyword/tag relations,
hide flags and defaults are control data. No new display candidate is invented.
The111 existing BioKeyword rows/444 cells and111 display candidate IDs reconcile
exactly with the prior supplement. Text remains in BioKeyword.bio_text.

There are520 stored selected spans and126 absent states. Reencoding these spans
leaves all506640 original bytes equal. This is static no-op preservation, not
resource reinsertion, Unity round trip or rendered proof. All40 generated sheet/
field BGIds match original getters. All197 nonnull relation edges resolve to
exact existing Actor39, Tag18 or BioKeyword111 rows/cells.

Verification checks19 frozen pins,7 helpers,285 older evidence hashes plus63
BioDetail and50 BioKeyword hashes,9 installed resources/DLLs, the original
TextAsset/payload,17 current plus31 keyword and44 BioDetail exact Cecil selections,
all8 keyword and8 BioDetail readbacks and24492 dialogue values in both frozen
copies. A separate fresh decoder and all11 new readbacks reproduce byte-for-byte.
Cecil reads assembly metadata/bodies; the game assembly is never executed.

## Input -> list membership -> selection and unlock

`db-actor-reverse.il` proves both typed Actor getters call the same virtual
single-Actor-BGId GetRelatedIn path accepted for BioDetail and copy by index.
The hash-bound prior cache chain sorts BGEntity.Index. Loader callback loops
preserve this initial row order; later mutations/cache configurations are unknown.

GenerateActorBios passes actor.keywordDataNotes/Kinks by reference into each
category, copies row identity/default, resolves each nonnull slot via the exact
DB-keyword dictionary, copies that slot's hide flag, then adds the keyword to
its category membership list EVEN WHEN HIDDEN. Null relations skip the complete
keyword/hidden/list-add block; all126 original null slots have false hide flags.
Tags are resolved through the exact DB-tag dictionary before category append.
The constructor retains the actor-owned dictionary; it does not copy/clear it.

Each table has one row for each of17 nonexcluded actors, and no row for22 other
actors. Every row is default and has the exact Main tag. CurrentBioNotes/Kinks
choose first ANY-active-tag match, else first default, else list[0], else null;
nonnull selections cache until SetDirtyBioData. Thus each of these17 actors
selects its one row whether Main is active or inactive.112 static truth-table
cases include the22 missing actors per table. Actual story tags, listener timing,
loaded manifests and save lifecycle remain unverified. Charlotte's two BioDetail
variants and Main-before-Vslice priority remain separate, unchanged evidence.

Text getters return keyword.text or null. Unlock getters use keyword.dbName in
the actor-owned category dictionary; timestamp getters return zero when locked.
TryUnlockKeyword compares the actual keyword object against the category list,
rejects unmatched or already-known keys, then adds keyword and StoryClock time.
It does not inspect hidden flags, text or note_/kink_ prefixes. Null cannot match
the original nonnull-only lists; there is no separate explicit null guard in
this method. Hidden slots can unlock, persist and contribute to Actor's event
success while their individual visible cells remain masked. Repeated attempts
retain existing dictionary state/timestamps. Runtime event/notification behavior
and broader save-load initialization/restore are not accepted here.

## Slots -> displayed output

All255 exact slots are recorded, including126 absent and129 present keyword
references.86 distinct keyword rows are referenced by these two tables. There
are22 hidden present slots (4 Notes,18 Kinks) and107 nonhidden present slots.
No hidden slot is removed from source coverage or from the unlock list.

CritterLogBioPane requires actor and all3 current categories; otherwise it clears
name/subtitles, uses empty portrait, and fills its fragment array with `???` in
unrevealed color and zero new-label alpha. With valid categories it records the
actor as viewed, uses the Detail portrait, masks the FullName until introduced,
and uses the established species/age/role newline template. Introduction only
attempts the3 Detail unlocks here; it does not automatically unlock Notes/Kinks.
The preserved FullName/overrideNameplateName anomaly is unchanged.

The pane passes Notes1..6 into fragments/newLabels[0..5], then Kinks1..9 into
[6..14]. Original IL indices and all15 getter/hidden/unlock/time argument groups
are checked. There is no joining, sorting or compaction. UpdateKeywordText shows
the source text in revealed color only when unlocked AND not hidden; otherwise
it shows `???` in unrevealed color. A new label is alpha1 only for a shown value
whose unlock time is strictly greater than the actor's last-viewed time; equality
is alpha0.12 independent helper branch/time scenarios and34 all-locked/all-present-
unlocked row assemblies are static consequences, not executed game tests or an
exhaustive joint reachability claim. UpdateViewedBios resolves viewed actor names,
sets each timeLastViewedInCritterLog to StoryClock and clears the viewed list;
caller lifecycle and actual rendering remain pending. Resource array lengths,
labels, hierarchy, fonts, layout and visual readability are not established.

## Cross-family findings and regressions

All128 prior BIO controls retain exact identities.112 explicit controls have a
matching slot in at least one current category row; this is potential membership,
not proof that the row/Dialogue/arc is selected or the command executes.15 legacy
single-argument controls still have absent current keys/unknown implicit actors.
The remaining explicit control, conversation299 entry1006
`BIO(gator,kink_sizeplay)`, resolves both identities but has no matching keyword
in ANY current BioDetail/BioNote/BioKink row for that actor. Preserve it as a source
anomaly; do not remap by similarity or repair original content.

Two of111 keyword display candidates have no slot in these three current tables:
row15 `Swinging` and row92 `???`. This does not prove they are globally unused.
The present authored `???`, null slots and UI unknown mask remain distinct.
All original spelling/punctuation/keys, including `town_arial_taxi`, `Verile` and
`FOOD`, are preserved; no identity/gender/glossary facts are inferred.

Concrete regression: the same Traveler keyword is hidden in Augustus/Penny Notes
and nonhidden in Dustin/Oliver Notes. Its display ID must stay one source ID while
all distinct actor/slot/hide dependencies survive. Unlocking a hidden slot must
still yield a mask; changing only hidden=false yields the source text. A missing
slot always remains masked. Equal last-viewed/unlock times must not mark NEW.
An explicit BIO prefix does not establish category membership or visibility.
`slot-bindings.json` and `bio-control-membership.json` retain these distinctions.

## Reproduce and next boundary

Run from the canonical checkout, with new output paths:

```
.venv-assets314/bin/python -B localization/source/bgdatabase-20261027/bio-note-kink/decode_notes_kinks.py --output <new-json>
.venv-assets314/bin/python -B localization/source/bgdatabase-20261027/bio-note-kink/verify_notes_kinks.py --output <new-directory>
```

Next: bounded original GenerateDialogues/primaryActor/arc registration tracing
for the existing128 BIO controls, especially the15 legacy single-argument cases
and299:1006. Loaded Dialogue selection and static registration are distinct from
actual story reachability. Save lifecycle/serializer/nonlinear restore, notification
construction/rendering, remaining source sheets/special scenes, full semantic and
independent diff acceptance, final fonts/licenses/resources/reinsertion/runtime/
delivery and prior Quest uncertainties stay pending. Accepted10/15/47/48 visuals
and50 route are unchanged; no53 replay/no54. Usage unknown; parent measures telemetry.
