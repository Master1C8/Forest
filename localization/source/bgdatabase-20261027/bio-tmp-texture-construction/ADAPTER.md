# Texture2D format validation and native creation boundary

The Forest of Love 0.45, Russian standard localization, technical phase0112.
Static source-consumer evidence only. The actual ancestor executable basename
`codex` and options before `--output-last-message` verified explicit
`gpt-6.1-sol`, high reasoning, OpenAI and `--ignore-user-config`. Separate comm/ppid
reads precede isolated option parsing; prompt/history was not inspected.
Parent alone owns Git/index/HEAD. All authorized asset/editorial/Japanese lanes
and the live actual preview remain independent and untouched.

Pinned CoreModule SHA256:
`32572aef39e4e9b2cd1b732d0e01998874993344c5682662fad513a3e7e49658`.
Frozen InspectMethods/phase100 BackingScopes/Cecil were reused, without rebuilding,
under SDK8.0.131. They parse metadata and never load/invoke original assemblies.

## Complete selected reading

Read all texture-constructor.il lines1–47, direct-dependencies.il lines1–100,
validation-dependencies.il lines1–67 and leaf-dependencies.il lines1–26.
Total12 managed bodies/201 instructions/240 export lines/17 declarations;
five selected InternalCall declarations have no managed body. No selected unread
range remains. One managed logger getter and one abstract interface declaration
reuse phase110 hashes; default conditional dispatch reuses phase111. Previous
atlas/definition/synthesis/upgrade bodies were not reread. Exact signatures filter
overload output and reject missing/ambiguous/duplicate selections.

The exact six-argument Texture2D constructor is the phase105 four-argument
constructor's direct operand at18, downstream of SetupNewAtlasTexture's newobj
at77. Its base chain is Texture::.ctor → Object::.ctor → opaque System.Object::.ctor.
Then ValidateFormat(format) decides whether creation is attempted. False returns
normally without format mapping, crunch testing or Internal_Create. Thus a normal
managed constructor return alone does not establish native texture or atlas readiness.

On true, GetGraphicsFormat receives format and `!linear`. Numeric flags start at0
when mipCount==1, otherwise1. IsCrunchFormat returns true for numeric TextureFormat
28/29/64/65 and causes OR64. The constructor forwards this,width,height,mipCount,
mapped graphics format,flags,nativeTex to Internal_Create. No enum-name decoding,
actual parameter values or native dimensions/mip/pointer validity were established.

ValidateFormat first calls SupportsTextureFormat. That boxes TextureFormat and
uses IsValidEnumValue, whose body calls opaque GetType/Enum.IsDefined. False
causes ArgumentException before SupportsTextureFormatNative. The native support
result true accepts. Otherwise native IsCompressedTextureFormat must be true
before GetGraphicsFormat(format,false) and CanDecompressFormat are called. The
latter managed overload forwards boolean true to its native two-argument overload.
A true decompression result accepts. Native support/compression/mapping/
decompression and BCL enum results remain unexecuted. No live platform support
claim is made.

If both routes reject, ValidateFormat performs constrained Object.ToString on
format, opaque String.Format with its diagnostic literal, then LogError(message,
this), and only then returns false. The newly read LogError wrapper obtains
unityLogger and calls ILogger.Log with numeric severity0 and exact supplied context.
The getter's single s_Logger capture and abstract interface reuse phase110. The
phase111 allocated default Logger/filter/handler path remains conditional; unchanged
enabled=true/filter3 would permit0. Actual receivers/settings/writers were not
observed. Conversion/formatting/interface/native failures or reentry may prevent
returning false, while filtering may suppress output. No diagnostic output was run.

Internal_Create forwards all seven inputs to private static Internal_CreateImpl,
an InternalCall with no managed body. False constructs UnityException with the
exact invalid-parameters message and throws; true returns. UnityException forwards
the message to opaque SystemException::.ctor then calls opaque set_HResult with
-2147467261. No native effect, allocation/failure, output or callback was executed.
FreeFunctionAttribute names on native declarations are retained; attribute arguments
and semantics are not decoded. Selected bodies contain no direct field stores,
exception handlers, local rollback/lock or delegate Invoke. This does not imply
native/BCL effects are absent or transactional.

## Verification and continuation

```text
python3 -B localization/source/bgdatabase-20261027/bio-tmp-texture-construction/verify_construction.py --output localization/source/bgdatabase-20261027/bio-tmp-texture-construction/<new-output-directory>
```

First verifier exit0: four exports and final scopes reproduce byte-exactly;
19 method operands/18 unique direct declarations,0 fields,8 opaque BCL operands,
zero handlers. Every selected direct Unity managed dependency is read or its exact
getter reused; one abstract declaration and five native declarations stay explicit.
Assertions check original IL identities, branch/order/argument boundaries and
recorded actual reading. Byte parity is distinct from semantic reading. No mocks.
Inherited931 files/150 DLLs,phase103–111 supplements and7 process references verify.
Usage is unknown to this worker; parent measures the request. No nested jobs/agents.

Next bounded work resolves/reads the exact GlyphRect static initializer behind the
retained atlas zero field operand. Current live zero value stays unobserved.
TMP_Character forwarded base/unicode/glyphIndex/scale remain separately unread.
Do not broaden logger writers/settings, reexecute atlas work or decode resources.

Retain phase79–111 controller/DB/Lua/metatable/language/loading/save/global/callback/
delivery/BIO/reachability/parser/style/reentrancy/native-selection/serialized/resource
limits. Feature log-before-mutation and legacy version1.1.0-before-name/log ordering
remain conditional, without actual failure/reentry/alias evidence. d__109/d__104
MoveNext,color accessors,concrete typewriter/notifications/dirty callbacks and
font3323/material7 stay open. Complete source/special-scene/runtime manifest,
serializer/nonlinear restore,Quest ordering/reflection/initial-unlock/counter,
universal full semantic/independent diff/delta,final fonts/licenses/resources/
runtime/visual/delivery remain pending. Conditional12246 values/copy,24492
occurrences,16 actor IDs,126 registrations/114 entries do not prove live selection.
Accepted10/15/47/48 visuals/50 route unchanged;spawn/other3 intros/notebook/Bucky open.
Parallel drafting/preliminary editorial exceptions pass no gate.

Previous README/CHECKPOINT bytes are archived. Only the current technical README
prefix and checkpoint nextAction/updatedAt plus the new section change; all previous
sections and following README bytes are preserved. Separate guarded writes are not
a transaction; summary-preservation.json records actual postconditions. Parent
integrates verified artifacts. No Git mutations, game/native execution, images,
GUI/preview,resource decoding,53 replay/54,competing overlay,publication/deployment
or server work occurred.
