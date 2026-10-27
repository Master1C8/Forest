# Component table binding and controller lookup

Phase0088 is static, text-only work in canonical Forest. Actual ancestor CLI
options verify gpt-6.1-sol/high/OpenAI. No inherited history, agents, nested model
jobs, original assembly execution, game/GUI/image access, authored translation,
overlay or Git mutation. Parent alone owns integration. Parallel asset/editorial/
Japanese lanes and the actual Russian preview remain independent and untouched.

## Component priority and base lifecycle

LocalizeUI.get_textTable first returns its own m_textTable when Unity considers it
nonnull. Otherwise it queries UILocalizationManager.instance.textTable; if that
query is null it returns GlobalTextTable.textTable, else it queries the UI singleton
and its table getter again. There is no cache assignment in this accessor. Repeated
accesses are not an atomic snapshot and may cross native creation/lifecycle effects.
Its setter only stores m_textTable; it does not refresh UI, assign the global table
or assign the UI singleton's field.

The reused UI-manager get_textTable/set_textTable bodies explicitly redirect to
UILocalizationManager.instance, rather than using their receiver's field. Therefore
the manager found on the controller GameObject by InitializeLocalization/SetLanguage
must not automatically be identified with the singleton whose table these accessors
read/write. Current-language accessors use their own receiver; table and language
selection are not a universal identity relationship. No live identity is accepted.

Base Start sets started=true before virtual UpdateText. Base OnEnable calls virtual
UpdateText without changing started. The reused base UpdateText exits when started
is false. This proves the selected base-method guard, not the execution order of
Unity callbacks, the absence of an override, or that every override obeys the guard.

get_fieldName normalizes stored null/empty to null, preserving nonempty whitespace.
SetFieldName obtains a legacy Text component if needed; with an empty supplied name
and a nonnull Text it stores that Text's current text, otherwise the supplied name.
It does not call UpdateText. The setter itself is also store-only. No current label,
serialized field, or renderer identity is inferred from these methods.

UpdateDropdownOptions clears the fieldNames list before virtual UpdateText. The
exact compiler-generated callback reached by the reused UpdateText appends each
OptionData's current text. Thus a base update before started can leave a cleared
list; this is conditional metadata behavior, not an observed defect. The earlier
dropdown option/caption indexing and native UI dependencies remain unexecuted.

## Two lookup routes

Reused LocalizeUI.GetLocalizedText checks its effective table and HasField(name).
Absent table/field routes to GlobalTextTable.Lookup(input); otherwise it queries
the effective table with the global/UI current language NAME. Repeated table getter
calls can observe different state. HasField inherits phase87's conditional field0
sentinel collision; it does not independently prove an exact-name match.

DialogueSystemController.GetLocalizedText is a nonvirtual selected method. It reads
displaySettings.localizationSettings.textTable directly. A Unity-null settings
table returns the original argument, including null/empty. With a nonnull table it
passes that table to Localization.GetCurrentLanguageID, then calls the numeric
language overload GetFieldTextForLanguage(input,id). A null/empty result returns
the original input; any nonempty result, including whitespace, returns directly.
There is no UI/global-table lookup in this method and no direct read of
Localization.useDefaultIfUndefined. TextTable's separate blank-translation flag and
fallback semantics still apply inside its selected numeric overload.

The reused Localization.GetCurrentLanguageID caches one static integer. Only when
the cache is -1 and the supplied table is Unity-nonnull does it resolve
Localization.language in that table. The selected method has no table-identity
cache key. A cached ID can consequently be reused for another supplied table; no
claim is made that current tables differ or that any output is wrong. The reused
Localization.language setter invalidates that ID before manager/native callbacks;
callbacks may repopulate it, so no final cache value is inferred from setter order.
This cache is distinct from TextTable.currentLanguageID and the UI language name.

Reused InitializeLocalization selects/creates a local manager conditionally,
conditionally assigns its table through the singleton-directed accessor, prefers
its nonempty currentLanguage, then calls SetLanguage. Reused SetLanguage obtains a
manager and conditionally supplies the display-settings table only inside its
initial null-manager path, then writes manager language, settings language and
Localization.language in order. These bodies establish conditional processing,
not serialized content, live manager identity, successful callbacks or rendering.

## Bounded derived-type evidence

An original metadata type-name query for LocalizeUI identified the exact
PixelCrushers.DialogueSystem.LocalizeUIText and PixelCrushers.Wrappers.LocalizeUI
targets. Their field metadata independently confirms base PixelCrushers.LocalizeUI.
Their complete declared-method lists contain neither GetLocalizedText nor UpdateText.
LocalizeUIText.Awake calls the deprecation warning helper; LocalizeText calls virtual
base UpdateText. The wrapper declares only its constructor. No override was found
in these two declared lists; this is not an exhaustive inheritance/discovery claim.
No claim is made about other differently named subclasses, active components or
Unity's callback dispatch. The warning helper is outside the text-table route.

## Reproduction and next dependency

From canonical Forest, use a NEW output directory:

```text
.venv-assets314/bin/python -B localization/source/bgdatabase-20261027/bio-localize-table-bindings/verify_bindings.py --output <new-directory>
```

The recipe imports unchanged phase87 verification, compares its entire readback
path set and bytes, verifies eight explicitly reused original metadata files, and
replays ten new selections/22 method bodies through the unchanged Cecil helper.
Assertions check actual branches/call ordering and scoped declared-method lists.
They do not execute original code, substitute a mocked engine, or pass semantic/
runtime acceptance. Raw metadata preserves string escape operands byte-for-byte.

The remaining immediate dependency is the serialized localization settings/table
reference of the already identified DialogueManager candidate sharedassets0:4608,
plus direct referenced table data if nonnull. Read its pinned export and verify
that bounded structure against original resource bytes with the existing aligned
reader. Do not recapture these completed method bodies or broadly dump scenes/UI/
saves to repeat conclusions. Null references are serialized facts only, not absence
of later-created/loaded tables. Actual lifecycle/DB/Lua/metatables/language/loading/
save/global scripts/callbacks/delivery/rendering/BIO/reachability remain unaccepted.

Previous README/CHECKPOINT bytes are archived exactly. Their summary updates are
separate writes, not a transaction; preservation and parent hashes are recorded.
No source, special-scene, editorial, font/license/resource, runtime or delivery gate
is promoted. Preserve phase79 GetState order,80/81 formatter bounds,82 prepare/
scene-null-GUID limits,83 participant/cache/selected-ID/Transform distinctions,
84 typed Lua/fallback,85 reset/script and86/87 callback/table/reentrancy caveats.
Exact16 actor IDs/126 registrations/114 entries remain conditional, not current
Lua/rendered names. Full source/special-scene/runtime manifest, serializer/nonlinear
restore, notification/rendering, Quest ordering/reflection/initial-unlock/counter,
universal semantic/independent diff/delta and final delivery remain pending.
Accepted10/15/47/48 visuals and50 route remain unchanged; spawn/other3 intros/
notebook/Bucky stay open. No53 replay/no54. Worker usage unknown; parent measures.
