# Debug logger initialization and conditional dispatch

The Forest of Love 0.45, Russian standard localization, technical phase0111.
This is static source-consumer evidence, not runtime or localization acceptance.
Before metadata work the actual ancestor executable basename `codex` was checked
with separate comm/ppid reads. Its options before `--output-last-message` verified
explicit `gpt-6.1-sol`, high reasoning, openai provider, `--ignore-user-config`.
The following prompt/history was not inspected. See execution-model.json.
Parent alone owns Git/index/HEAD. Authorized asset/editorial/Japanese lanes and the
actual preview remain independent. No agents, nested model jobs or lane writes.

Pinned UnityEngine.CoreModule.dll SHA256:
`32572aef39e4e9b2cd1b732d0e01998874993344c5682662fad513a3e7e49658`.
Frozen InspectMethods and phase100 BackingScopes/Cecil were reused without rebuilding.
SDK8.0.131. These readers parse metadata; they never load/invoke original game code.

## Complete selected reading

All initialization.il lines1–9, construction-dispatch.il lines1–72,
direct-dependencies.il lines1–118 and leaf-dependencies.il lines1–15 were read.
Total14 managed bodies/176 instructions/214 export lines/16 declarations;
one abstract interface and one native declaration have no managed body.
No unread selected range remains. Exact signatures filter overloaded reader output;
missing, duplicate or ambiguous matches are rejected. Counts alone are not reading.

Debug::.cctor creates two separate Logger/DebugLogHandler pairs. It stores the first
in Assembly Static InitOnly s_DefaultLogger, then creates/stores the second in
Assembly Static s_Logger. It does not copy one receiver to both fields. Logger's
constructor stores the supplied handler, enables logging and sets numeric filter3
through exact setters, each a direct private backing-field store. These are initial
settings; no live receiver, subsequent settings, field writers or replacements were
observed. Other type initializers and runtime allocation behavior remain unexecuted.

The allocated type justifies reading the two exact matching Logger.Log methods,
both Public Final Virtual new-slot. This is a conditional implementation path, not
observation of current interface dispatch or an interface-table inspection.
Each filters first. Disabled logging rejects; when enabled numeric4 is allowed;
otherwise filter4 rejects, and requested severity <= filter passes. Unchanged
constructor defaults permit the retained Debug wrapper severities3 and2. A rejected
log returns before handler lookup, allocation, message conversion or dispatch.
No coherent settings snapshot or lock is provided by these selected methods.

On the taken path the handler is captured before allocating one Object element and
converting the message. Both methods pass severity and format `{0}`; context is null
for the two-argument method or forwarded unchanged for the other. GetString maps null
to `Null`; IFormattable gets ToString(null, InvariantCulture), otherwise virtual
Object.ToString is called. BCL/concrete message code remains opaque and may throw or
reenter. This does not prove custom message callbacks in retained string-based font
logging. Later handler replacement need not affect the captured receiver.

ILogHandler.LogFormat is abstract. The separately allocated DebugLogHandler justifies
its exact matching concrete method, which calls String.Format(format,args), then
Internal_Log(severity, numeric LogOption0, formatted string, context). Internal_Log
is an Assembly Static InternalCall without managed body. Its
ThreadAndSerializationSafeAttribute name is retained; no attribute arguments or
thread/native behavior are established. Native output is conditional on receivers,
filtering and successful conversion/formatting, and was not executed.

All14 managed bodies have zero exception handlers and no direct delegate Invoke or
lock/rollback. Stores during construction/initialization are ordered, not a transaction;
type-initialization failure/exposure/retry behavior is not executed. No new selected
body writes font/material/registration state. Retained feature logging precedes its
feature mutations; retained legacy version1.1.0 precedes name/log calls. Logging
failure can therefore prevent later selected stores or leave the already written
version advanced, under the retained conditional path. No actual failure/reentry
was observed. Native/BCL/transitive callbacks and other implementations remain open.

## Verification and continuation

```text
python3 -B localization/source/bgdatabase-20261027/bio-tmp-logger-dispatch/verify_dispatch.py --output localization/source/bgdatabase-20261027/bio-tmp-logger-dispatch/<new-output-directory>
```

metadata-verified/verification.json passed on the first verifier run, exit0.
Four exports plus scopes are byte-exact.19 resolved method operands/12 unique
declarations,8 field operands,6 opaque BCL operands,zero handlers. Every selected
direct UnityEngine managed dependency is read; this is not a transitive runtime
closure. Assertions verify exact identities, stores, dispatch, conversion, boundaries
and the recorded actual reading. No mocks replace the original IL. Inherited931
files/150 DLLs, phase103–110 supplements and7 process references remain hash-verified.
Measured model usage is unavailable to this worker; parent accounts for the request.

Next bounded work reads the exact six-argument Texture2D constructor already pinned
by phase105 atlas setup, with only indispensable NEW direct managed dependencies.
No texture/font resources are decoded. GlyphRect implicit initializer/current zero,
TMP_Character forwarded base/unicode/glyphIndex/scale setters, other logger
initializers/writers/settings and actual callback/receiver state remain separately
unread. Reuse earlier parser/style/backing/array-sizing/lookup/addition/atlas/definition/
synthesis/legacy/feature traces by hash. Retain79–110 controller/DB/Lua/metatable/
language/loading/save/global/callback/delivery/BIO/reachability/native/serialized
limits; d__109/d__104 MoveNext, concrete typewriter/notifications/dirty callbacks,
font3323/material7 remain open.

Complete source/special-scene/runtime manifest, serializer/nonlinear restore, Quest
ordering/reflection/initial-unlock/counter, universal semantic/independent diff/delta,
final fonts/licenses/resources/runtime/visual/delivery remain pending. Conditional
12246 values/copy,24492 occurrences,16 actor IDs,126 registrations/114 entries do not
prove live selection. Accepted10/15/47/48 visuals/50 route are unchanged;spawn/other3
intros/notebook/Bucky remain open. Parallel draft/preliminary editorial exceptions
pass no gate. No original/native execution, images, game/GUI/preview, resource
decoding,53 replay/54,competing overlay, publication/deployment/server or Git action.

Previous README/CHECKPOINT bytes are archived. Only the README current prefix and
checkpoint nextAction/updatedAt plus the new section change. Preserve every old
section and following README bytes, especially preliminaryEditorial,
russianActualPreview, parallelLocaleDrafts and localeStatus. Separate guarded writes
are not a transaction; verify actual postconditions. Parent integrates exact artifacts.
