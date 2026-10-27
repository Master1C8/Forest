# Exact CoreModule material, name and logging wrappers

The Forest of Love 0.45, Russian standard localization, technical phase0110.
This supplement records original static IL/metadata, not a runtime result.
The codex ancestor was verified before metadata: executable basename `codex`,
explicit `gpt-6.1-sol`, `model_reasoning_effort=high`, `model_provider=openai`,
`--ignore-user-config`. Options were isolated before `--output-last-message`
before shlex parsing; following prompt/history was not read. See execution-model.json.
Parent owns Git/index/HEAD. Worker made no Git mutations, agents/nested model jobs,
translations, game/native execution, images, GUI/preview interaction or resource decoding.
All authorized asset/editorial/Japanese lanes and the actual preview remain independent.

Pinned UnityEngine.CoreModule.dll SHA256:
`32572aef39e4e9b2cd1b732d0e01998874993344c5682662fad513a3e7e49658`.
Frozen InspectMethods and phase100 BackingScopes/Cecil were reused without rebuild.
Only the metadata readers ran; no original assembly or native method was invoked.
SDK8.0.131. The original install and owner saves were not changed.

## Complete bounded reading

wrappers.il lines1–48 were read completely: five exact bodies,38 instructions.
direct-dependencies.il lines1–14 were read completely: exact get_unityLogger body,
2 instructions,plus two InternalCall and two abstract-interface declarations.
Total6 bodies/40 instructions/62 export lines/10 declarations,zero unread selected
ranges. No substitute GetFloat(String) or other Debug overload was selected.

GetFloat(Int32) forwards this and the unchanged integer to GetFloatImpl(Int32),
a Private nonvirtual InternalCall with no managed body,then returns its Single.
Object.name forwards this to static GetName(Object),an InternalCall with no body,
then returns its String. Neither wrapper locally validates,rewrites,clamps,allocates
or stores. NativeName/FreeFunction attribute names are retained; their arguments
were not decoded. Native validation,property values,object identity,callbacks,
thread rules and possible side effects remain unverified. Names do not prove purity.

The three Debug wrappers fetch current unityLogger before passing severity numeric3
for Log or2 for LogWarning. They forward the exact message and optional context
in order via callvirt to the corresponding abstract virtual new-slot ILogger.Log.
The getter is only ldsfld Debug.s_Logger then ret. The field is Assembly Static
ILogger; current concrete receiver,initialization,writers and settings remain open.
No local filtering,formatting,ToString,null guard,fallback or delegate Invoke occurs.
Do not replace interface dispatch with an assumed Logger/native implementation.

No direct field stores,allocation,handler,rollback,lock,registration,material write
or delegate operand occurs in these six bodies. Native/interface callees can still
throw or reenter; static type initialization and transitive effects remain unread.
Each logging invocation captures the field once; replacing the global field later
need not replace that in-flight receiver. Under normal managed semantics a null
receiver can fail at callvirt; no actual null/runtime state was observed.

Retained feature-upgrade logs precede its feature mutations. Retained legacy upgrade
commits version1.1.0 before name/log calls. Thus a name/logger failure may respectively
prevent later stores or leave the legacy version advanced and suppress conditional
retry. These are static implications,not observed callbacks or failures. Preserve all
prior partial-state,alias,dictionary/key and lazy-retry evidence unchanged by hash.

## Reproduce and limits

```text
python3 -B localization/source/bgdatabase-20261027/bio-tmp-font-native-wrappers/verify_wrappers.py --output localization/source/bgdatabase-20261027/bio-tmp-font-native-wrappers/<new-output-directory>
```

metadata-verified/verification.json passed on the first verifier run,exit0.
Two exports and dependency scopes reproduce byte-exactly:8 resolved method operands,
1 field,0 opaque BCL operands,5 unique direct declarations,0 handlers. The assertions
check identity,argument order,dispatch/native/abstract flags and recorded read ranges.
They corroborate full model reading; they neither execute native/logger dependencies
nor replace source/editorial/runtime/visual acceptance. No mocks were used.

Inherited931 files/150 DLLs and29/25/28/35/32 phase103–107 files,26 phase108 files,
31 phase109 files and7 process references verify unchanged. Failed prior assertion
attempt remains preserved; no old helper/output was edited or rerun for export.
Current inherited checks only hash those prior exports. Usage is unavailable here.

Next: exact Debug static initialization and its directly justified concrete logger
construction/dispatch,within a fresh bounded work context. Current field value and
all replacement paths remain distinct from initialization. Six-argument Texture2D
ctor,GlyphRect initializer and forwarded TMP_Character base/setters remain separately
unread. Retain79–109 controller/DB/Lua/language/loading/save/global/callback/BIO/
reachability/parser/style/native-selection/serialized/resource limits. d__109/d__104
MoveNext,concrete typewriter/notifications/dirty callbacks,font3323/material7 remain open.

Complete source/special-scene/runtime manifest,serializer/nonlinear restore,Quest
ordering/reflection/unlock/counter,universal full semantic/independent diff/delta,
final fonts/licenses/resources/runtime/visual/delivery remain pending. Conditional
12246 values/copy,24492 occurrences,16 actor IDs,126 registrations/114 entries do not
prove live selection. Accepted10/15/47/48 visuals/50 route stay unchanged;spawn/other3
intros/notebook/Bucky remain open. Provisional drafting/preliminary editorial exceptions
pass no gate. No53 replay/no54,competing overlay,publication/deployment/server work.

Previous README/CHECKPOINT bytes are archived. Only the current README prefix and
checkpoint nextAction/updatedAt plus this supplement's new section change. Preserve
all old sections and following README bytes,especially preliminaryEditorial,
russianActualPreview,parallelLocaleDrafts,localeStatus. Separate guarded writes are
not a transaction; actual postconditions are verified. Parent integrates exact hashes.
