# Original language initialization and synchronous UI boundaries

Phase0086 uses metadata only in canonical Forest. Actual ancestor CLI options pin
gpt-6.1-sol/high/OpenAI, no inherited history, agents or nested model jobs. Parent
alone owns Git/index/HEAD. Parallel locale assets/editorial/Japanese and the actual
Russian preview remain independent and untouched. No original assembly, game,
GUI, image, save, authored translation or target overlay was executed or modified.

## Singleton and write order

The original UILocalizationManager.currentLanguage setter does not use its receiver.
It resolves instance, stores m_currentLanguage there, resolves instance again, then
synchronously calls UpdateUIs(argument). There is no unchanged-value guard and no
direct Localization.language call in either setter or UpdateUIs. UI textTable get/
set also resolve the singleton, whereas the prefs settings getters use the receiver.
Do not equate the controller's cached component reference with the effective target.

instance first checks its cached Unity object, then FindObjectOfType. If still null,
it finds GlobalTextTable and adds a manager to that object's GameObject, or creates
a new named GameObject and adds one there. Those native calls, actual singleton
identity, duplicate instances and component lifecycle/reentrancy are unexecuted.
textTable falls back to GlobalTextTable.textTable when the singleton field is null;
the fallback accessor implementation remains outside this phase.

UpdateUIs writes the receiver's m_currentLanguage again. When its prefs flag is
true and its key is nonempty, it calls PlayerPrefs.SetString before discovering UI
objects. The inactive flag chooses FindObjectsOfType or the plugin's include-inactive
helper; each result receives a virtual LocalizeUI.UpdateText call. No object count,
derived dispatch target, native UI event, callback success or persisted write is proved.

Combined with phase85 SetLanguage, the conditional synchronous order is:
controller UI setter/UpdateUIs -> settings.language -> Localization.language setter.
The last setter stores m_language and invalidates m_currentLanguageID to -1 BEFORE
querying DialogueManager.instance, getting/adding a UI manager and invoking its
currentLanguage setter. If all calls return normally and that manager path is taken,
there are two UI updates even for an unchanged argument. This is a method-path fact,
not a measured count or atomic update. The first UI traversal precedes both later
writes. Virtual callbacks can interrupt/reenter; an outer invocation may subsequently
overwrite nested state. No stable final value is inferred.

## Lifecycle and name lookup flags

Awake conditionally installs the first singleton reference. It may load PlayerPrefs
when enabled, key nonempty and present, writing this instance's private language field
directly without UpdateUIs or Localization.language. The constructor's Language key,
true prefs/inactive defaults and empty language are defaults, not proof of serialized
or live settings. Start is an iterator factory. Its MoveNext yields WaitForEndOfFrame
first, then reads currentLanguage through the singleton and calls UpdateUIs on its
captured instance. Actual coroutine scheduling/instance equality remain unaccepted.

The base LocalizeUI.UpdateText is virtual, returns if not started, checks a table and
HasLanguage using the UI singleton language, then updates eligible Text/Dropdown/TMP
surfaces through virtual GetLocalizedText. That method delegates absent-field/table
cases to GlobalTextTable.Lookup; otherwise it requests the table field with
GlobalTextTable.currentLanguage. Those global accessors, table implementation,
derived overrides and downstream native effects are not accepted by this reading.
This does not establish a direct callback from UI to Localization.language.

Localization.isDefaultLanguage uses IsNullOrEmpty(m_language). Static initialization
and the marked runtime initializer set empty language, ID -1 and useDefaultIfUndefined
true. The language setter leaves the fallback flag unchanged; its dedicated setter
only stores the supplied boolean. GetCurrentLanguageID lazily asks a nonnull table
when its cache is -1 and returns0 while still -1. Table identity, selected language,
initializer order and actual flag are not measured. Phase84's conditional name
fallback outputs are retained, not promoted to current displayed-name acceptance.

## Direct subscription and flag search limits

Four original DLLs were searched for method operands containing
DialogueSystemController::add_initializationComplete: Assembly-CSharp.dll,
Assembly-CSharp-firstpass.dll, Auto-asmdef-SecondPass.dll and Auto-asmdef-FirstPass.dll.
All four have zero matches. The event accessors combine/remove System.Action through
a CompareExchange loop; neither invokes a handler. No direct subscriber was identified
in that exact scope, so there is no handler body to attribute. Reflection, aliases,
raw field writes, scripts, dynamic/native code and other assemblies remain outside
the search; do not infer an empty live event from it.

The same four DLLs' set_useDefaultIfUndefined operand searches find only the uppercase
forwarding alias in the plugin DLL. The alias is retained. This does not cover calls
to that alias, direct field writes or every flag mutation. No actual fallback value
or lack of mutations is claimed.

## Reproduction and remaining scope

From canonical Forest, use a NEW output directory:

```
.venv-assets314/bin/python -B localization/source/bgdatabase-20261027/bio-language-initialization/verify_language.py --output <new-directory>
```

The recipe imports unchanged phase85 verification and compares its entire readback
tree byte-for-byte, including19 frozen pins/7 helpers/9 installed resources/150 DLLs,
12246 source values in each of2 copies and16 actor identities/126 registrations/114
unique entries. It replays19 new successful metadata selections/25 bodies as raw bytes
and checks the actual write/call order, singleton redirection, virtual boundary and
unchanged fallback-flag boundary. No mocked engine execution or semantic acceptance.
Previous README/CHECKPOINT bytes are archived exactly; their updates are separate
writes, not a transaction. Summary preservation and parent integration hashes are
recorded separately. Worker usage unknown; parent measures.

Next bounded static scope: actual GlobalTextTable language/table forwarding and the
TextTable language-ID/field selection reached here; inspect method lists first and
trace only dependencies relevant to language/name initialization. Resolve any actual
override/callback only when exact original metadata identifies it. No broad UI/scene/
save dump, runtime launch, image opening,53 replay or54. Existing supplements/frozen
sources/glossaries/assets/jobs are read-only; parent alone integrates.

Preserve phase79 GetState order,80/81 formatting bounds,82 native prepare/null-GUID
limits,83 participant/cache/Transform distinctions,84 typed lookup/fallback and85
reset/script caveats. Actual lifecycle/DB/Lua/metatable/language/loading/save/global
script/callback/delivery/rendering/BIO/reachability remain unaccepted. Complete source/
special-scene/runtime manifest, serializer/nonlinear restore, notification/rendering,
Quest ordering/reflection/initial-unlock/counter, universal semantic/independent diff/
delta, final fonts/licenses/resources/runtime/delivery remain pending. Accepted10/15/
47/48 visuals and50 route unchanged; spawn/other3 intros/notebook/Bucky remain open.
