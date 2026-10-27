# Original participant Lua display-name inputs

Phase0084 is a text-only, append-only supplement for the exact sixteen participant
IDs established by phase83. Actual ancestor CLI options, with prompt omitted, pin
gpt-6.1-sol/high/OpenAI. Parent alone owns Git/index/HEAD and integrates these files.
Parallel asset/editorial/Japanese lanes and the separate Russian preview remain
independent and untouched. No images, game/GUI, original-code execution, authored
overlay, nested model/CLI job or Git mutation occurred.

## Lookup and initialization

`source-trace.json` provides exact method and IL locators. Actor lookup reads the
global `Actor` Lua table directly. Both actor names and field titles pass through
StringToTableIndex. It replaces double quotes, ASCII spaces, hyphens and parentheses
with underscores; slash conversion depends on a flag whose static default is true.
LF becomes literal backslash-n and CR is removed. Case, apostrophes, existing
backslashes and tabs remain. Keys and values must not be conflated: Text fields
become LuaString of the unchanged value, not a converted key or an escaped script.

Default language means null/empty, not `en`. A nonempty language adds an underscore
and its exact value before key conversion. GetLocalizedTableField first reads that
key. With UseDefaultIfUndefined=true, absent/null, LuaNil or LuaString with null/empty
Text retries the base field. Literal string `nil`, whitespace, false and zero do
not trigger that fallback. The separate CharacterInfo display consumer tries
localized Display Name, localized Name, then the passed original database name;
it rejects null/empty/exact lowercase `nil`. Whitespace and `NIL` survive.

NoResult contains null; asString returns empty for that case, otherwise ToString.
LuaString returns its Text, and LuaNil returns `nil`. ParseCode maps null to empty
and runs Lua-tag then variable-tag replacement only when a bracket exists. It does
not run the entire formatting pipeline. Phase80's actual evaluator/order/iteration
limits remain applicable; no expression was executed here.

DialogueActor.GetActorName first reads unlocalized Lua Name using its actor/object
name, then passes the returned VALUE into the localized-display helper as another
actor key. A later Name mutation can therefore change the second lookup identity.
Its later `[lua`/`[var` branch can call full Parse with masterDatabase emphasis
settings. This does not prove the original component or resulting live name.

Lua initialization creates the global environment and null NoResult. DialogueLua's
static constructor initializes ChatMapper tables; its separate runtime reset body
does not itself reset these tables. DatabaseManager.Add resets tables when no DB is
loaded, merges into master, calls AddChatMapperVariables with master and the pre-add
loaded list, then appends the incoming DB. Null/already-loaded input does nothing.
Clear resets tables before clearing master/list. The actual controller/default
setter/merge/reset sequence remains the next bounded dependency.

AddToTable skips raw asset Names already supplied by loaded databases. Otherwise
it creates each actor subtable under the converted Name, inserts converted field
titles with typed values in order, and uses AddRaw for the initial population or
SetKeyValue later. These are overwrite-capable APIs, not uniqueness validators.
Missing-key lookup can consult a metatable's `__index` table/function. No current
metatable, initialization order, database selection or mutation is accepted.
AddChatMapperVariables may run globalUserScript after table population; that field
is exactly empty in both selected frozen database copies.

## Exact sixteen-actor binding

`readback/target-lua-inputs.json` binds IDs
`1,2,3,4,5,6,8,9,10,11,13,14,15,16,25,31` independently in both source copies.
Each selected actor has one Text0 Name, with no Display Name or normalized localized
Name/Display Name variants. All sixteen original actor keys are unchanged and
unique within this selected set. All Name values lack brackets. This does not
claim collision coverage for the other actors.

Under explicit post-population/no-mutation conditions, Lua Name is the original
plugin name. The display helper returns it for all 64 supplied default/ru and flag
combinations per copy. These are conditional static results, not current Lua or
CharacterInfo.Name acceptance. The output separately retains exact BGDatabase
row/dbName/nameplate_name values and byte spans. TFOL's nameplate controller uses
its own Actor/introduced/custom/scene paths; BGDatabase NameplateName is not
inserted as plugin Display Name by this initialization recipe.

## Reproduction and limits

From canonical Forest, with a NEW output directory:

```
.venv-assets314/bin/python -B localization/source/bgdatabase-20261027/bio-participant-lua/verify_lua.py --output <new-directory>
```

The verifier imports unchanged verify_participants.py, reproduces every retained
phase83 readback byte-for-byte, and reuses its frozen source/resource/DLL/helper
checks. It then repeats all successful new Cecil selections as raw bytes and binds
only the sixteen actor field sets and corresponding BG rows in both copies.
The supplied positive/negative controls replace Lua/.NET/Unity and dynamic parsing;
they cannot pass those mechanisms or any editorial/runtime gate.

One guessed LuaScriptWriter type-list query failed and is retained separately in
failed-selections.json. It was not retried. The actual DialogueLua method list
establishes the direct initializer. Initial text-mode capture normalized a CR
literal; capture-correction.json records the changed raw-byte query and exact
before/after hashes. The verifier now compares raw bytes and separately asserts
the real CR and LF literals. No inspector or previous supplement was changed.

Previous README/CHECKPOINT bytes are archived unchanged. Summary writes are
separate, not a transaction. Preservation checks retain all previous sections,
especially preliminaryEditorial/russianActualPreview/parallelLocaleDrafts/localeStatus.
The parent integration manifest gives exact paths and SHA-256 values. Worker usage
is unknown; parent measures telemetry.

Next: bounded original defaultDatabase setter/master merge/controller initialization
and narrow name-field mutation dependencies, using actual method lists first.
Actual Lua/language/reset/loading, cache/override/Transform/manager/scene selection,
callbacks, native SendMessage, Subtitle delivery/rendering/BIO/reachability remain
unaccepted. Complete source/special-scene/runtime manifest, save/serializer/nonlinear
restore, notification/rendering, Quest ordering/reflection/initial-unlock/counter,
universal semantic/independent diff/delta, final fonts/licenses/resources and local
delivery remain pending. Accepted10/15/47/48 visuals and50 route remain unchanged;
spawn/other3 intros/notebook/Bucky remain open. No53 replay or54.
