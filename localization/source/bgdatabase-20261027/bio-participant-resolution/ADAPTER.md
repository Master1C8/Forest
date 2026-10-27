# Exact original BIO participant resolution

Phase0083 is a text-only, append-only source supplement. Actual CLI options,
excluding prompt text, verify gpt-6.1-sol/high/OpenAI. No agents/nested models,
images, game execution, GUI/preview, original writes, authored overlays or Git
mutations. Parent alone integrates. Parallel assets/editorial/Japanese and the
actual Russian preview remain independent and untouched.

## Exact source and identity set

`readback/target-participants.json` preserves all126 registrations/114 unique
entries, their exact Actor/Conversant fields, original conversation roles and
source pointers. Every target Conversant is1. The union is exactly
`1,2,3,4,5,6,8,9,10,11,13,14,15,16,25,31`. Only these16 identities are bound to
existing phase71 Actor evidence in `readback/target-actor-identities.json`.
Both frozen trees must agree exactly. No full-scene/UI/save dump is needed.

Entry getters use first exact Actor/Conversant fields -> LookupInt -> LookupValue
-> Tools.StringToInt -> SafeConvert.ToInt -> Int32.TryParse. Failed conversion
returns0, not a null participant. All actual selected values are canonical ASCII
decimal in range. The verifier rejects any other spelling instead of claiming to
implement every culture-sensitive .NET numeric conversion in Python.

Plugin IDs/Name, BGDatabase Actor row IDs/dbName, registration target Actor,
CharacterInfo.id/nameInDatabase/Name and Unity Transform are separate identities.
For example plugin2 is bunny -> Scarlett; plugin8 is bird -> Penny. A BIO
registration targeting Scarlett does not make every speaker on that line Scarlett.
The frozen registration target is retained separately from requested speaker ID.

## Construction and cache before scene invocation

`GetState` resolves both entry IDs at IL_006a..0083 after prepare/Lua/onExecute,
before the scene-event argument and subtitle parsing. `skipExecution` does not
skip participant resolution. These are unchanged-source conditional inputs;
earlier callbacks may change them in actual play.

Model construction creates its own integer-keyed CharacterInfo cache and calls
SetParticipants before first GetState for a found conversation. SetParticipants
uses conversation Actor/Conversant IDs and the supplied transforms, resolves actor
first, stores both role infos, sets Lua participants and identifies the PC portrait.
Missing conversation leaves firstState null and can log; it does not initialize
the two participant infos on that path.

The one-argument GetCharacterInfo first calls GetCharacterTransform, which compares
the requested ID against current m_actorInfo.id, then m_conversantInfo.id. Actor
wins if both equal, even with a null transform; neither returns null. These role
infos are dereferenced without null guards. The comparison uses resolved IDs,
which can differ from original conversation fields. Source-role labels in the
readback explicitly assume unchanged participants/no component override, not live
selection. The one-argument wrapper performs this step even before a cache hit.

The two-argument overload returns an existing cache entry by REQUESTED ID without
recomputing from a new transform or override. On a miss it obtains DialogueActor
from the supplied transform (self, then children, then parent; null returns null).
There is no enabled check in this helper or in the constructor's use of its result.
A valid component's actor string is looked up in m_database by Name. A missing
named actor falls back to numeric GetActor(requestedID). Numeric lookup is first
exact Asset.id equality. Missing both retains requested ID and empty database
name; it does not reject the request. Existing phase71 name-cache/exact-name
evidence is retained for the string overload.

For a found actor, the selected actor's id and Name become construction inputs.
Thus a DialogueActor override can change CharacterInfo.id while the cache key
stays the requested ID. CharacterType is independently computed from the REQUESTED
ID, not the selected override ID. If the supplied transform compares null and
the selected Name is nonempty, the global registered transform is tried. The outer
local DialogueActor variable was captured before that lookup and is not refreshed.
Portrait selection and a possible AssignPortraitSprite callback occur before cache
insertion; the callback writes only this CharacterInfo.portrait. Their real assets,
callback success and runtime effects are not accepted here. Requested -1 returns
the newly constructed info without adding it to the cache; other misses are added
under the requested key. The own-assembly field-use scan shows the cache created
in .ctor, used here and read by SetActorPortraitSprite; it is not evidence against
reflection/external mutation. Public CharacterInfo fields remain mutable.

Linked conversation updates fetch the conversation and return if absent. They
replace actor info only for a changed ActorID whose database Actor is a player,
then identify the PC portrait and return. Otherwise they can similarly replace
conversant info for a changed player ConversantID. They do not replace all roles
unconditionally or clear the CharacterInfo cache in this body.

## Transform registry, fallback and displayed name

RegisterActorTransform ignores empty name/null-comparing transform, otherwise
adds or overwrites the string key. Unregister ignores those invalid inputs, then
removes an existing KEY without checking equality against its stored transform.
Consequently an old component's disable can remove a replacement's registration;
this source behavior is preserved, not repaired. GetRegisteredActorTransform uses
the exact dictionary key and returns null if absent. DialogueActor OnEnable and
OnDisable invoke these functions using actor and its own transform. Actual
registration order, selected objects and transient state remain unaccepted.

CharacterInfo's constructor stores the supplied fields. If the transform compares
null and database Name is nonempty, it calls FindSpecifier(name,true). For these16
plain original names, that path tries the registry, then GameObject.Find, then
returns null; true excludes hard-find/resource enumeration on the plain-name
path. The separate tag= branch is case-insensitive, can use hard tag search and
is not used by these16 original names. No matching GameObject or registered
transform is established by this metadata.

If FindSpecifier succeeds, it changes this.transform. The next call to
GetDialogueActorComponent still uses the ORIGINAL constructor argument, not
this.transform. This distinction must survive a future adapter or proof. A
component on an argument returned from the outer registry lookup can be read in
the constructor; a component on a transform found only inside the constructor
is not reread through the updated field.

Without an argument component, Name comes from GetLocalizedDisplayNameInDatabase:
Lua localized Display Name -> localized Name -> original database name (each
fallback rejects null/empty or exact nil), then FormattedText.ParseCode. With a
component, its virtual GetActorName is used; it starts from actor or object name,
reads Lua Name and the localized display helper, and may run FormattedText.Parse
for [lua/[var. Constructor portrait fallback uses masterDatabase, a separate
lookup from m_database. Current Lua values/language, overrides, portraits and
actual emitted names are not accepted. This is not permission to translate Name,
plugin identities, original fields or create a competing overlay.

Finally GetState tests speakerInfo.transform with Unity null semantics to choose
its GameObject, otherwise DialogueManager.instance.gameObject, before conditionally
invoking the scene event. There is no guard against null speakerInfo or a missing
manager in that fallback body. Manager fallback supplies an event argument; it
does not replace participant identity. Exact null EventGuid/scene and native
prepare constraints from phase82 remain in force.

## Verification and limits

Run from canonical Forest:

```
.venv-assets314/bin/python -B localization/source/bgdatabase-20261027/bio-participant-resolution/verify_participants.py --output <new-directory>
```

This reuses unchanged verify_prepare.py for the frozen19 pins/7 helpers, original
resources, all12246 candidate values in both copies, prior evidence,150 DLL pins
and exact phase82 readbacks. It replays the36 successful new Cecil selections,
then checks exact target fields and only the selected16 actor mappings in both
copies. `il-commands.json` binds commands and outputs. Only metadata is read;
original assemblies are never loaded for execution. Supplied Python controls
exercise transcription distinctions with Unity/.NET/Lua/search/portrait mechanisms
replaced, and cannot prove any of those real mechanisms.

Previous README/CHECKPOINT bytes are archived unchanged. Summary writes are
separate, not a transaction; preservation evidence must retain all existing
sections, especially preliminaryEditorial/russianActualPreview/parallelLocaleDrafts/
localeStatus. Parent receives the exact integration manifest. Worker usage is
unknown; parent measures actual telemetry.

Next bounded boundary: exact original Lua localized actor-field/Name extraction
and initialization used by these16 participant identities, including language,
fallback/null/nil and ParseCode dependencies. Reuse current field/name evidence;
no runtime or full save/scene dumps. Complete source/special-scene, runtime
selection/mutation/delivery/BIO/reachability, save/serializer/nonlinear restore,
notification/rendering, Quest ordering/reflection/initial-unlock/counter, universal
semantic/independent diff/delta, final fonts/licenses/resources and local delivery
remain pending. Accepted10/15/47/48 visuals and50 route unchanged; spawn/other3
intros/notebook/Bucky remain open. No53 replay or54.
