# Original global table forwarding and field lookup

Phase0087 is static, text-only work in canonical Forest. The actual ancestor CLI
options pin gpt-6.1-sol/high/OpenAI; no inherited history, agents or nested model
jobs. Parent alone owns Git/index/HEAD. All asset/editorial/Japanese lanes and the
actual Russian preview remain independent and untouched. No game/GUI/images,
original assembly execution, save change, authored translation or target overlay.

## Distinct language and table routes

GlobalTextTable.instance only returns its cached s_instance. It performs no search
or creation. The selected base Awake installs this reference only when Unity's
null comparison succeeds; OnDestroy clears it only for that same Unity object.
The marked runtime initializer sets it null. Lifecycle order, subclass dispatch
and actual instance are unexecuted. UILocalizationManager.instance, in contrast,
has the search/creation behavior retained in phase86.

GlobalTextTable.currentLanguage forwards both ways to UILocalizationManager.instance.
Its textTable getter returns null without a live cached GlobalTextTable, otherwise
that object's m_textTable. The setter does nothing without that object. Otherwise
it stores the table BEFORE conditionally obtaining the UI singleton and calling
UpdateUIs with GlobalTextTable.currentLanguage. It does not assign the UI manager's
own table field. The UI singleton getter itself may have native creation/lifecycle
effects, and UpdateUIs may reenter; no atomic or final state is inferred.

Thus an explicitly assigned UI-manager table, a GlobalTextTable table and a
LocalizeUI component's table must not be equated. Phase86 proved the UI manager's
getter can fall back to the global table. That one-way fallback is not a universal
identity assertion. The LocalizeUI accessor remains a next-scope dependency.

GlobalTextTable.Lookup(string) returns empty for null/empty input, returns the
original input without a global table, otherwise calls the string/string table
overload using the UI singleton's current language name. It does not read the
TextTable static currentLanguageID. The latter is used by GetFieldText overloads;
its simple setter and static default0 do not establish its live value or linkage
to DialogueSystem.Localization's separately cached ID.

Lookup(StringField) returns empty for null, otherwise first resolves StringField.value
and then treats that resulting string as a global lookup key. A StringField with its
own table resolves its numeric field ID using the UI language name. Its other paths
select StringAsset.text or its stored text. These are two successive lookup stages,
not proof that a StringField's original field name is passed directly to the global
table. StringAsset.text's implementation and actual serialized values are not read
here. StringField's four selected accessors simply read their own backing fields.

## Language and field selection

TextTable.GetLanguageID(name) tests the languages dictionary and returns its value
or0. It has no null/empty guard. HasLanguage(string), by contrast, explicitly accepts
null/empty, and HasLanguage(int) accepts0. Their checks must not be substituted for
GetLanguageID. The dictionary's null-key behavior is delegated and unexecuted; do
not claim null safely maps to0. Unknown nonnull names select0 without checking the
blank-translation fallback flag. Dictionary comparer/content/language identities
are not inferred from defaults or serialized lists.

GetFieldID(name) enumerates nonnull field values, uses String.Equals(fieldName,name)
and returns the first matching dictionary key, else0. GetField(string) passes that
result to GetField(int). GetField(int) tests key presence and returns the value or
null. Consequently a missing field name can select an existing field0 even when
its name differs. This is a conditional sentinel collision, not evidence that the
original resources contain field0 or that any displayed field is wrong. Constructor
nextFieldID1 does not prove field0 absent. Duplicate names, dictionary enumeration,
null entries and actual mappings remain unaccepted. HasField(string) inherits this
route; it is not an independent exact-name existence test.

GetFieldTextForLanguage(field, numericLanguage) first resolves the field. A missing
string-key field returns the requested string unchanged; a missing numeric field
returns GetFieldName(id), which returns empty if that key is absent. GetFieldName
does not guard a present null field before calling get_fieldName.

For an existing nonnull field, HasTextForLanguage means dictionary key present AND
value not null/empty. A nonempty requested translation is returned after replacing
literal backslash-n with LF, before consulting the fallback flag. Whitespace counts
as nonempty. Otherwise language0 is fetched. A nonempty language0 value is used only
when useDefaultLanguageForBlankTranslations is true; otherwise the string overload
uses the supplied field name, and the numeric overload uses GetFieldName(id). This
fallback result also receives backslash-n replacement. The missing-field early
return does not. Requested language0 with nonempty text already succeeds before
the flag, even when that flag is false. TextTableField.GetTextForLanguage returns
empty for a missing key and the stored value for a present key, including null.

The TextTable fallback flag is a separate static field from
DialogueSystem.Localization.useDefaultIfUndefined. Their setters each store only
their own boolean. Static default true and language ID0 are initialization facts,
not current runtime values. No table contents or final name/UI output are accepted.

## Reproduction and handoff

From canonical Forest with a NEW output directory:

```
.venv-assets314/bin/python -B localization/source/bgdatabase-20261027/bio-language-table/verify_table.py --output <new-directory>
```

The recipe imports unchanged phase86 verification, compares its complete readback
path set and every byte, and replays this phase's exact metadata selections against
the original plugin through the unchanged Cecil helper. Raw capture preserves both
literal backslash-n and physical LF operands. Ordered assertions exercise metadata
branches, forwarding, sentinel and flag boundaries; they do not execute the engine
or test runtime lookup. No substitute renderer or semantic audit is used.

Previous README/CHECKPOINT bytes are archived exactly. Their updates are separate
writes, not a transaction. The parent integration manifest pins substantive files
and reports worker usage unknown; parent measures. Process-binding references and
all frozen source/glossary/helper/resource pins are retained without changing inputs.

Next bounded scope: the original controller InitializeLocalization/GetLocalizedText
and LocalizeUI table accessor/initialization, inspecting actual lists first. Determine
which table each selected route actually requests and any exact metadata-identified
override dependency. Do not infer a live instance, serialized table contents or
absence of subclasses from a method-name search; no broad scene/UI/save dump.

Preserve phase79 GetState order,80/81 formatting bounds,82 native prepare/null-GUID
limits,83 actor/cache/selected-ID/Transform distinctions,84 typed Lua/fallback and
85/86 reset/script/order/reentrancy caveats. Actual lifecycle/controller/DB/Lua/
metatables/language/loading/save/global-script/callback/delivery/rendering/BIO/
reachability remain unaccepted. Complete source/special-scene/runtime manifest,
serializer/nonlinear restore, notification/rendering, Quest ordering/reflection/
initial-unlock/counter, universal semantic/independent diff/delta, final fonts/
licenses/resources/runtime/delivery remain pending. Accepted10/15/47/48 visuals and
50 route unchanged; spawn/other3 intros/notebook/Bucky open. No53 replay/no54.
