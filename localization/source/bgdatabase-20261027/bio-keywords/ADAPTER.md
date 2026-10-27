# Phase0073: original BioKeyword identities, controls and persistence

Static source supplement for The Forest of Love 0.45, appended alongside the
unchanged phase72 BioDetail evidence. Current CLI argv pins gpt-6.1-sol/high/OpenAI.
Parent alone integrates Git. No target text, source/glossary repairs, game/GUI,
image input, agents, nested model jobs or asset/editorial lane writes occurred.
The separate Russian preview and every parallel lane remain untouched.

## Exact data boundary

`decode_keywords.py` reuses the unchanged v5 Reader/envelope and BioDetail's typed
string-column decoder. It decodes all BioKeyword111x4 cells:444 stored spans,
zero absent cells. All111 `bio_text` values are nonempty display candidates;
333 name/savekey/plugin_db_trigger_name states are protected. Each column has111
distinct values. Candidate classification is not an accepted visible denominator,
editorial reading, proof of slot use or runtime reachability.

All25 previously decoded rows are byte/value/ID/span-identical, including the
100 exact prior cell selectors. The other86 rows add344 cell states and86 display
candidates. All37 BioDetail slot references still resolve to the same25 keyword
rows. Full BioNote/BioKink tables and their slot assignments are deliberately
outside this supplement; `dependency-bindings.json` marks them pending rather
than guessing from names or control prefixes.

Preserve original distinctions such as internal `Town Aerial Taxi` versus control
`town_arial_taxi`, `BDSM Sub` versus display `BDSM - Sub`, `Town Mom` versus display
`“The Town Mom”`, `Verile`, and display `FOOD`. The stored `Question Marks` row has
literal `???` display text. It is a present authored source value, distinct from
the critter consumer's unknown-slot `???` mask and from a null slot. No correction,
glossary fact, pronoun/identity inference or Russian wording was authored.

`verify_keywords.py` invokes the unchanged prior verifier in a temporary directory
and compares all8 prior outputs. It verifies19 frozen pins,7 owning helpers,
285 earlier evidence hashes, all63 phase72 evidence hashes,9 original installed
resource/DLL hashes, original resources.assets:320 raw TextAsset and the506640-byte
payload. It also compares both12246-candidate source copies and all128 BIO controls
in both trees. Five generated sheet/field BGIds match original generated getters.
31 new exact Cecil selections and44 reused phase72 selections reproduce. One early
read-only method query named nonexistent SaveBioKeywords and was rejected with
Unknown method; the corrected query uses the actual CreateBioKeywordData. No game
assembly was executed. Reencoding all444 selected spans preserves the entire
payload byte-for-byte; this is no-op static preservation, not reinsertion.

## Control input -> registration -> execution

The original AddArcPreconditionsAndTriggers uppercases the substring before `(`
(or the whole title if absent), then dispatches exact `BIO`. It operates on loaded
manifest dialogues; enumeration of source controls alone does not prove loading.
The bounded source adapter mirrors only this BIO selector on frozen ASCII titles.

AddConversationTriggerUnlockBioFragment takes outgoingLinks[0], looks up that
entry ID in the same Conversation, then processes each dialogue arc containing
that entry. It does not use a translated label to identify the destination.
It extracts the title substring from after the first `(` to before the last
character, splits on comma, and uses trimmed actor/key when there are exactly2
arguments. Otherwise actor comes from dialogue.primaryActor.pluginDbName and the
first argument is the key. Blank actor/key throws; actor plugin lookup must exist.
It then applies case-sensitive String.Replace for ALL `note_` substrings and ALL
`kink_` substrings, in that order, not merely a prefix strip.

Registration stores conversation/local destination IDs, actor dbName and that
normalized plugin keyword key in ArcTriggerUnlockBioFragment. The trigger is added
before the optional current-keyword dictionary check. If that check succeeds, the
loader also adds the dialogue dbName to keyword.unlockedByDialogueDbNames. Missing
keyword metadata therefore does not itself prove no trigger was registered.
Arc membership, sorting/count-parent recursion, actual loaded Dialogue set,
implicit primary actor resolution and actual execution/reachability remain open.

`readback/bio-controls.json` retains exact title pointers, all original source and
destination fields/conditions/scripts, ordered outgoing links, first local target,
related candidate context and exact Actor/keyword identity cells. All128 source
controls occur identically in both trees (256 physical occurrences). No Title
pointer is a translated dialogue candidate.113 explicit actor/key controls resolve
to existing exact current Actor and BioKeyword rows.15 single-argument legacy
controls have keys absent from current BioKeyword111; their implicit primary actors
are unverified. Preserve those controls, never remap them by spelling similarity.
They are a source/consumer finding with unknown reachability, not a repaired bug,
accepted unlock, new translation unit or reason to stop the authorized draft lanes.

OnExecute passes the stored actor dbName and plugin keyword key to
NarrativeActions.UnlockBioKeyword. That action returns immediately when
`Instanced Event Vslice` is active; otherwise it resolves actor dbName and keyword
plugin trigger through DataService. Each keyword lookup checks its exact dictionary,
logs an error and returns null when absent. Actor-null behavior, invalid saved state,
legacy controls and uninspected Notes/Kinks behavior are not declared safe.

Actor.UnlockBioKeyword tries each nonnull CurrentBioDetail, CurrentBioNotes and
CurrentBioKinks, ORs the three results (all eligible categories are attempted),
and emits onUnlockActorBioKeyword only when at least one succeeds. The accepted
BioDetail method compares the actual keyword reference with its bios list, rejects
null/unrelated/already-known, then records dbName plus StoryClock. Notes/Kinks
methods and exact topology await the next bounded family.

Actor.Introduce returns if already introduced; otherwise sets encountered/introduced
and attempts all3 current BioDetail keyword unlocks directly, discarding their
booleans, then emits encounter/introduction events. This direct route does not call
Actor.UnlockBioKeyword or its bio-keyword event. The critter pane's introduced-actor
unlock attempts and masked `{0}\n{1}\n{2}` legacy display remain the unchanged phase72
binding. OnBioUnlocked first requires PlayerLearnedNotebook, then queues actor
notification type6; keyword wording is not directly rendered in that handler.
Notification construction/rendering is outside this supplement.

## Save/load identity boundary

SaveActor skips actors excluded from savestate, loads/creates the record by actor
savekey, and calls CreateBioKeywordData for the current Detail/Notes/Kinks category
dictionaries (or null for absent current categories). The detail variants share the
actor-owned detail dictionary as already traced in phase72. CreateBioKeywordData
returns for null input; otherwise it upserts each known keyword into the saved
category dictionary by keyword.savekey. Each record contains keywordSavekey and
original timeUnlocked; existing records update these two values. It does not clear
saved entries absent from input. Savestate.SaveActorData upserts by actorSavekey.
No display text is copied to this keyword record.

Actor.Load passes VALUES from each saved category dictionary to LoadBioKeywords.
That method resolves record.keywordSavekey through the current savekey dictionary,
skips missing keywords, skips an already-present dbName, and adds the keyword and
saved timeUnlocked keyed by current dbName. It does not clear existing runtime
category dictionaries or replace an already-known timestamp. This code evidence
is not proof of repeated save-load lifecycle safety; caller initialization/order
and on-disk serializer/migration behavior remain unverified. SavegameBioKeywordData
DeepCopy copies only keywordSavekey/timeUnlocked. A bounded field search also finds
DeepCopyDialogues/RestoreNonlinearContent consumers; their larger restoration and
migration behavior is explicitly not accepted here. Translating name/savekey/plugin
keys would alter unlock, restore and cross-dialogue dependencies.

## Reproduce and continue

```
.venv-assets314/bin/python -B localization/source/bgdatabase-20261027/bio-keywords/verify_keywords.py --output <new-directory>
```

`reproducibility.json` binds a fresh decoder and byte-for-byte comparison of all8
new readback outputs. The reused verifier's exact malformed relation/bool controls
exercise parser boundaries, not game behavior. No resource reinsertion or renderer
was tested. Source controls remain context with preserve-exactly roles, never
inflated semantic coverage. No frozen shared inventory or target overlay changed.

Regression requirements for future integration: translating bio_text while retaining
all three identities must preserve category unlock/save/load behavior; identical
name/text spelling must not merge field roles; real Question Marks text and unknown
mask remain distinct. note_/kink_ replacement is global/case-sensitive and must not
be silently normalized. Missing legacy keys and implicit actors remain visible
findings; an inactive/unloaded control is not proof of absence. Repeated load must
account for skip-existing and unchanged timestamps; SaveActor merges, not clears.
Vslice blocks the NarrativeActions route but does not establish that all direct
unlock routes are blocked. These are requirements, not executed runtime tests.

Next: append-only BioNote/BioKink family data and bounded selection/unlock/assembled
critter output consumers, resolving exact relations to this111-row keyword table.
Keep source/special scenes, actual reachable states, full semantic/independent diff,
final fonts/licenses/resources/reinsertion/runtime/delivery and existing Quest
uncertainties pending. Accepted10/15/47/48 visuals and50 route remain unchanged;
no53 replay/no54. Parent integrates exact files; worker usage is unknown.
