# Phase0076: original BIO registry selection, primary actors and arc inclusion

Static, text-only source supplement for The Forest of Love0.45 in the canonical
Forest checkout. `execution-model.json` records actual current CLI argv with
`gpt-6.1-sol/high/OpenAI` pinned. Parent alone owns Git/index/HEAD. No worker
Git mutation, nested model/CLI/agent work, authored translation, images, GUI/game
interaction, original install/save writes, publication or deployment. All asset
and editorial lanes and the independently operated Russian preview remain untouched.
This supplement does not accept complete source, story execution or localization.

## Original bytes and scope

`decode_registration.py` reuses the unchanged v5 envelope/Reader and accepted
BioDetail typed codecs. It selects exactly seven columns from all600 original
Dialogue rows: `name`, `savekey`, `plugin_db_name`, `type`, `primary_actor`,
`initial_actor`, `has_player_initiated_question`. The other nine columns remain
opaque. The4200 selected cell states are protected runtime identities, relations
or controls; no display candidate or target overlay is created. There are3601
stored spans and599 absent states (all but one initial_actor). Exact reencoding
of selected spans preserves all506640 original bytes. This is a static no-op,
not Unity reinsertion, packaged-resource loading or rendering.

All eight generated sheet/field BGIds match original getters.1201 exact relation
edges resolve into the original Actor39 or DialogueType7 row-ID inventories;
DialogueType values and other Dialogue dependencies are not decoded/accepted here.
600 unique names, savekeys and plugin names are checked without dropping duplicate
identities. All600 primary actors and the one initial override resolve by original
Actor BGId. An absent initial actor falls back to primary; that does not change
primaryActor. No actor is inferred from a conversation name, speaker ID or species.

## Construction and registry selection

Original GenerateManifest obtains DialogueManager.databaseManager.defaultDatabase,
generates actors/keywords/bios/quests before dialogues, then performs dialogue
preconditions/triggers, arc preconditions/triggers and final trigger prioritization.
Static lookup compatibility with both exported databases does not prove which
object is selected or modified at runtime.

GenerateDialogues invokes DB.Dialogue.ForEachEntity with null predicate and null
comparison. The generated wrapper forwards these nulls; BGMetaEntity enumerates
store indices in order and calls the action for every row. The callback constructs
one Narrative.Dialogue for each row. It sets pluginDbName from plugin_db_name,
gets its Conversation by exact title, and sets primaryActor from the exact
`actorsByDbActor[dbDialogue.primary_actor]` relation. It separately stores
primaryActorDbName. Conversation Actor/Conversant fields and entry speakers are
not the authority for this assignment. InitialActor is assigned independently.

Original database title cache and fallback Find both use exact title identity.
CreateCache uses Conversation.Title, retains the first duplicate key and only
populates during Application.isPlaying; fallback still finds exact equality.
Both frozen copies have627 unique conversation titles/IDs. Each of the600 registry
plugin names matches exactly one conversation in each copy;27 conversations have
no registry row. The callback does not filter rows by legacy/vslice name, source
conversation type, story conditions or tags. It adds the constructed object to
manifest lists/dictionaries and type-specific collections. Lists are subsequently
sorted by ascending priority; equal-priority stability is not established.

This is registry-selection evidence, not a successful full GenerateManifest run.
Callback guards for missing conversations, date settings/prefabs, quest linkage,
gossip questions and other dependencies can throw. Their complete data validity,
runtime manifest mutations and story reachability are not accepted in this scope.
No conversation or candidate is removed merely because this registry lacks it.

## Arc construction and static membership

The callback calls PopulateDialogueArcs in exactly PRIMARY, SECONDARY, IDLE, NAMED
order, preserving each root's outgoing-link order. Original GetDialogueEntry(title)
uses first exact-title Find. An absent root creates no arcs; a present root with no
links throws. For NAMED, a root link first selects a holder whose Title becomes
customName, then the holder's FIRST outgoing destination becomes the arc's first
entry. Other root types start directly at the root-link local destination.
These root/holder lookups use destination entry IDs in the same Conversation.

A first entry needs a nonblank TfolUniqueDataKeySuffix. Original regular expressions
check only the unanchored-ending prefixes `^[p][0-9]*`, `^[s][0-9]*`, `^[i][0-9]*`,
`^[n][0-9]*`; the suffix itself is NOT trimmed. Generated name/savekey concatenate
original registry identity, `_`, and the exact suffix. Duplicate per-kind names and
shared suffix dictionary keys are checked. Preserve the real trailing newline in
`Idles_Vslice_Mouse_i2\n`; do not normalize it or silently strengthen the grammar.
Primary-question assignment is also checked: a first Player entry, or a Sequence
containing `none` with a first outgoing Player destination. The dialogue-type warning
condition does not change these population branches; type applicability is unaccepted.

RecursivelyPopulateDialogueEntries adds an entry once using object membership, then
visits outgoing links in order only when destinationConversationID equals the current
entry's conversationID. The exported entries/IDs are unique, so exact ID traversal
preserves this identity. The original routine never evaluates conditions, userScript,
connector flags or link priority. It has visited deduplication for cycles. The static
transcription reproduces1103 arcs and10781 ordered entry memberships in BOTH copies.
This count is graph inclusion, not1103 playable/accepted scenes.

Parent priority uses the first matching predecessor found in that ordered arc list,
then recurses to the first entry. It is not a shortest-path calculation. All126 BIO
registration parent chains resolve here; stored count and full chain are preserved.
Original code has no cycle bound in parent recursion; the verifier's observation
guard would record an unresolved cycle instead of certifying one. Synthetic positive/
negative controls check local cycles, changed cross-conversation inclusion, absent
roots, NAMED indirection, manual-suffix rejection with an otherwise valid control,
and a branching case whose first-parent count3 differs from shortest distance2.
These controls exercise the static transcription and replace game execution.

## The128 frozen BIO controls

All prior control identities, source fields, conditions/scripts, first destinations,
links, keyword identities and category memberships remain unchanged. Of128 controls,
125 have a registry-selected Dialogue and their first local destination belongs to
at least one populated arc. They produce126 statically eligible BIO registrations:
conversation108 entry118 `BIO(MouseKinkVoyeurism)` is eligible in BOTH original
Idles_Vslice_Mouse idle arcs, with parent counts0 and4. The BIO control node itself
need not be reached or belong to an arc: original registration checks its first
DESTINATION. It scans all entries of each registry-selected Conversation.

Three controls in unregistered conversation458 `act1/fastTravelDialogueTMP` are not
visited by this original manifest registry dispatch: entries391/392/393,
`BIO(bunny,note_townmom)`, `BIO(bird,kink_flirting)`, `BIO(bird,note_jokester)`.
Their keyword/category identities still exist. This does not prove the conversation,
its visible text or those concepts are globally unused; other consumers remain open.

All15 single-argument legacy controls now have exact implicit actor resolution from
the registry primary relation: Mabel2, Bucky5, Scarlett2, Charlotte3, Maverick3.
All15 legacy keyword keys remain absent from the current111-keyword table. Do not
map them to modern keys by spelling, species or similarity. They are still eligible
for registration (16 registrations because of the double arc), since registration
precedes optional keyword metadata lookup. The original Vslice execution guard is
separate; this supplement does not claim a legacy control succeeds or fails at runtime.

The110 explicit eligible controls resolve existing keyword keys;109 have potential
membership in at least one current BioDetail/Note/Kink row. The remaining control,
299:1006 `BIO(gator,kink_sizeplay)`, registers at first entry485 of named arc
`Dates_BuckyAugustus2_Dialogue_n1` for exact actor Augustus, key sizeplay, parent
count0. Its keyword metadata may be registered, while no current category contains
that key for Augustus. Preserve the source anomaly; never repair/remap it.

BIO argument normalization is the unchanged original case-sensitive global removal
of `note_` and `kink_`, after trimming argument strings. Registration uses actor.dbName,
conversation ID and first-destination entry ID. Optional keyword metadata membership
is added only if its current plugin key exists. It is neither category visibility nor
story reachability. Detail/Note/Kink tag selection, hidden flags, unlock dictionaries,
notification/save behavior, actual event timing and rendered output remain separate.
Charlotte's Main/Vslice priority and the FullName/nameplate-override anomaly are unchanged.

## Verification and reproduction

The unchanged phase75 verifier was executed into `prior-recheck/` and all11 outputs
match accepted prior readback bytes. Its chain checks19 frozen pins, seven helpers,
285 older evidence hashes plus63 BioDetail and50 BioKeyword hashes, nine installed
resources/DLLs,92 prior exact Cecil selections, eight Keyword/eight Detail readbacks
and24492 source values. This phase additionally pins41 prior Note/Kink artifact
hashes, rechecks the installed sources and reproduces27 original Cecil selections
(including lists and an empty type search; these are not27 method bodies).
The game assembly is read as metadata/bodies and never executed.

`inspection-attempts.json` preserves an exact-type absence, not a game failure.
Successful files produced before that probe were reconciled without replaying them.
`execution-recipe.json` records the verification command and frozen helper hashes;
initial output evidence is retained separately and is not credited with final code
version binding. The final algorithm and exact relation check are reproduced under
explicit hashes. `reproducibility.json` records actual comparisons, not an editorial pass.

From the canonical checkout, with previously nonexistent output paths:

```
.venv-assets314/bin/python -B localization/source/bgdatabase-20261027/bio-dialogue-registration/decode_registration.py --output <new-json>
.venv-assets314/bin/python -B localization/source/bgdatabase-20261027/bio-dialogue-registration/verify_registration.py --output <new-directory>
```

Reuse `prior-recheck/` only while its recipe/dependency hashes and outputs still match.
It is a prerequisite for the second command, not a replacement for fresh source checks.
The decoder/verifier never alters prior supplements, frozen sources, glossaries or assets.

Next boundary: bounded original FireArcTriggers/ForceFireArcTriggers/ArcTrigger.Execute
and their callers, exact actor/keyword lookup behavior and the Vslice guard as necessary
to distinguish registration, normal/forced dispatch, skip and successful unlock. Reuse
all126 registration targets and existing category evidence; do not accept actual story
reachability from graph inclusion. No runtime or image input is needed for this next trace.
Full source/special scenes, save initialization/serializer/nonlinear restore, notification
construction/rendering, full semantic/independent diff/delta, final fonts/licenses/
resources/reinsertion/runtime/delivery and prior Quest uncertainties remain pending.
Accepted10/15/47/48 visuals and50 route stay unchanged; initial spawn/other3 intros/
notebook/Bucky remain open. No53 replay/no54. Usage unknown; parent measures telemetry.
