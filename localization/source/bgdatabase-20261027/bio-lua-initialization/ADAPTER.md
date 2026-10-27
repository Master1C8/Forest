# Original Lua actor initialization boundaries

Phase0085 is text-only metadata work in canonical Forest. The actual ancestor CLI
options pin gpt-6.1-sol/high/OpenAI with no inherited history or child jobs. Parent
alone owns Git/index/HEAD. Parallel asset/editorial/Japanese lanes and the separate
Russian preview remain independent and untouched. No original game code, game,
GUI, image, save, authored translation or target overlay was executed or changed.

## Ordered initialization

The defaultDatabase setter is compiler-generated and only stores its reference.
Neither it nor its uppercase forwarding alias installs a database or populates Lua.
The manager constructor creates its loaded list and master database, then assigns
the default. GetMasterDatabase lazily calls Add(defaultDatabase) when the loaded
list is empty. Thus reading controller.masterDatabase can trigger population.

Controller Awake's previously pinned body can first destroy a duplicate controller.
For a surviving controller, it optionally clones initialDatabase when either
instantiateDatabase is true or warm-up mode is not numeric2. It copies the original
Unity object name onto the clone. After persistent settings/static flags are set,
Awake calls InitializeDatabase, InitializeDisplaySettings, InitializeLocalization,
then subscribes sceneLoaded. These are conditional method-order facts, not proof
of the selected instance, Unity callback order or success.

InitializeDatabase always creates a new manager from initialDatabase. If that input
compares nonnull and its Unity object name equals lastInitialDatabaseName, it calls
Add directly. Otherwise it calls Reset(KeepAllLoaded=0). The latter snapshots the
new manager's empty loaded list, calls Clear, then Add(default). Both nonnull routes
reach the manager's first Add: reset Lua tables, merge incoming data into master,
AddChatMapperVariables(master, pre-add loaded list), append incoming reference.
The Reset route has the extra Clear/table reset. Null input takes Reset/Clear but
Add skips population. The static last name updates only for nonnull initial input;
matching Unity object names neither compare database contents nor reuse old managers.

Reset(RevertToDefault=1) clears then adds default. KeepAllLoaded snapshots old
references, clears, adds default first, then re-adds old non-default references in
saved order. Null/already-loaded entries are skipped by Add. Other enum values
fall through without these resets. Controller parameterless ResetDatabase passes0;
its overload passes the supplied enum, guarded by a nonnull manager.

## Merge and script dependencies

DialogueDatabase.Add first merges emphasis settings and globalUserScript, sets up
caches, then appends actors/items/locations/variables/conversations via AddAssets.
For actors the collision key is raw Asset.Name, not ID or the converted Lua key.
An existing cache key wins; unseen keys append the SAME incoming object reference
in input order. There is no deep actor/field copy in this body. Conversations use
Title. SetupCaches builds only missing caches. CreateCache populates from existing
lists only when Application.isPlaying is true and keeps the first duplicate key;
this is a conditional branch, not a measured play state. This evidence does not
extend phase84's key-uniqueness coverage beyond its exact sixteen actor set.

Clear clears the five asset lists and resets caches. Its body does not clear
emphasisSettings or globalUserScript. AddGlobalUserScript uses the incoming script
when the current one is empty, otherwise joins two nonempty scripts with `; `.
Together with phase84's AddChatMapperVariables(master) script execution after table
population, an already accumulated master script can remain/reexecute after Clear
and further Add calls; reset must not be equated with a fresh empty-script master.
The two selected frozen source copies each have an exactly empty globalUserScript.
No live accumulated script, other DB, callback or successful Lua execution is proved.
The internal AddEmphasisSettings behavior is outside this phase's name-table scope.

DatabaseUtility uses Template.FromDefault, wrapper-type lookup and
CreateScriptableObject, then ResetEmphasisSettings. The manager passes false, so
this body skips its optional Player/Alert insertions. Actual wrapper resolution,
Unity allocation/default field values and failure behavior are still unexecuted.

## Localization and remaining mutation boundaries

InitializeLocalization may derive a language from the system, obtains/creates the
UI localization component and supplies a missing text table. A nonempty current
component language takes precedence; otherwise it uses the settings language.
SetLanguage obtains/creates the cached component, supplies a missing table, assigns
component.currentLanguage, settings.language, then Localization.language in that
order. Component setter callbacks and real current language are unresolved. Awake
initializes the DB before these calls; that alone does not prove no reentrant or
later mutation. Start later starts alert monitoring, may preload/warm up, registers
quest/Lua functions, sets its initialized flag and invokes initializationComplete.
Preload/warm-up/registration/callback bodies are not accepted by reading Start.

Six narrow metadata operand searches cover SetActorField and
SetLocalizedActorField only in Assembly-CSharp.dll, Assembly-CSharp-firstpass.dll
and Auto-asmdef-SecondPass.dll. All return zero matching instructions. This does
not establish absence of TFOL name writes through Lua.Run, raw table access,
reflection, native code, dynamically loaded assemblies or callbacks. No direct
caller was identified for a Name/Display Name argument trace in those searches.

The exact16 IDs remain `1,2,3,4,5,6,8,9,10,11,13,14,15,16,25,31`,126 registrations/
114 unique entries in both copies. readback/target-initialization-inputs.json retains
only their phase84 source fields/conditional outputs. Name values, Lua actor keys,
localized fields, CharacterInfo.Name, Transform identity and TFOL BGDatabase
NameplateName remain distinct. No current displayed name or Russian name overlay
has been accepted or authored.

## Reproduction and handoff

Run from canonical Forest, with a NEW output directory:

```
.venv-assets314/bin/python -B localization/source/bgdatabase-20261027/bio-lua-initialization/verify_initialization.py --output <new-directory>
```

The recipe imports unchanged phase84 verify_lua.py and reproduces every retained
readback byte-for-byte, including its source/resource/helper/150-DLL pins and exact
12246 candidate values in each copy. It replays this phase's15 successful metadata
selections as raw bytes, pins the unchanged inspector and earlier lifecycle/list
inputs, and asserts the reference-only setter and Clear-field boundary. It never
executes original assemblies. These are static checks, not Lua/.NET/Unity behavior,
semantic/editorial review or runtime acceptance. No synthetic engine execution is
claimed. Prior failed selections are inherited unchanged, never rerun.

Previous README/CHECKPOINT bytes are archived unchanged; separate summary writes
are not a transaction. summary-preservation.json records all unchanged sections.
Parent integration hashes are in the phase's integration manifest. Worker usage is
unknown; parent measures actual telemetry.

Next bounded work: follow only the actual UI localization currentLanguage setter
and its callbacks reaching Localization.language, plus exact controller
initializationComplete handlers where original direct subscriptions are identified.
Use actual method lists first and retain narrow scope; no broad scene/UI/save dump.
Manager Remove and any resulting Lua removal, wrapper/allocation, actual lifecycle,
loading/reset ordering, current Lua/metatables/save/global scripts and callbacks
remain unaccepted. Preserve phase79 GetState ordering,80/81 formatting,82 native
prepare/scene null-guid,83 participant/cache/Transform and84 lookup/fallback limits.
Complete source/special-scene/runtime manifest, save/serializer/nonlinear restore,
notification/rendering, Quest ordering/reflection/initial-unlock/counter, universal
semantic/independent diff/delta, final fonts/licenses/resources and delivery stay
pending. Accepted10/15/47/48 visuals and50 route are unchanged; spawn/other3 intros/
notebook/Bucky remain open. No53 replay or54.
