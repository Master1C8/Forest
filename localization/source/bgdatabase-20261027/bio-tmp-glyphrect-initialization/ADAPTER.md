# GlyphRect explicit zero initialization

The Forest of Love 0.45, Russian standard localization, technical phase0113.
The actual ancestor codex executable/options verified gpt-6.1-sol/high/OpenAI
and --ignore-user-config before metadata work; prompt/history was not inspected.
Parent owns Git/index/HEAD. Authorized parallel lanes and actual preview remain
independent and untouched.

Pinned UnityEngine.TextCoreModule.dll SHA256:
`5d36823b178018de4ce2aaeec2eed70912a48908f3ddbe721a18fcb106e1d3be`.
Frozen InspectMethods/BackingScopes/Cecil readers parse metadata only. No reader
was rebuilt and no original game type/native code was loaded or invoked.

Read initializer.il lines1–9 completely: one explicit private static .cctor,
seven instructions. It pushes four zeros, invokes the exact four-Int32 GlyphRect
constructor, stores the result into s_ZeroGlyphRect and returns. The direct
constructor is already accepted in phase105 and reused by exact declaration/module
and checkpoint source-trace hashes, without rereading its body. Its normal result
has zero x/y/width/height. The field is Private, Static, InitOnly. There are no
local branches, handlers, logs, native calls or rollback in the selected initializer.
No new direct managed dependency remains unread. Actual runtime initialization
timing/trigger/completion, current field value, later writes/reflection, failures,
concurrency and consumer selection remain unobserved.

## Corrected provenance

The prior brief incorrectly identifies a retained phase105 atlas zero field operand.
That exact dependency-scopes file has no such operand; it pins GlyphRect through
its four-Int32 constructor declaration. This phase used that verified type/module
pin to inspect initialization. Its newly found zero field/store does not establish
an atlas zero read. Historical artifacts remain unchanged. caller-reconciliation.json
records the actual constructor call/declaration and missing claimed zero operand.
Never infer a consumer edge solely from a matching type or a prose handoff.

The next phase should reconcile only the exact synthesis zero getter/field operand
and resolve/read the still-unread TMP_Character base/unicode/glyphIndex/scale chain
from phase107 exact dependency declarations. Do not reread atlas/definition/synthesis
bodies or broaden to other GlyphRect overloads, native operations or logger writers.

## Reproduction and limits

```text
python3 -B localization/source/bgdatabase-20261027/bio-tmp-glyphrect-initialization/verify_initialization.py --output localization/source/bgdatabase-20261027/bio-tmp-glyphrect-initialization/<new-output-directory>
```

First verifier exit0. Initializer/scopes reproduce byte-exactly; exact opcode,
field, constructor-reuse and no-claimed-atlas-zero assertions pass. 44 direct retained
files and seven process-reference hashes verify. All28 phase112 reproducibility
pins were checked; inherited931 files/150 DLLs were not rehashed in full this phase.
Hash parity and mechanical assertions are distinct from the actual full selected
initializer reading recorded in source-trace.json. No mocks. Usage unavailable to
worker; parent measures the request. No agents/nested model jobs.

Current summary/checkpoint prior bytes are archived, with guarded separate writes
and postcondition receipts; those writes are not a transaction. Every previous
checkpoint section except nextAction/updatedAt and all following README bytes
are preserved. Parent integrates the verified artifacts; worker has no Git authority.

All prior controller/DB/Lua/metatable/language/loading/save/global/callback/delivery/
BIO/reachability/parser/style/reentrancy/native/serialized/resource limits remain.
Texture constructor return alone does not prove native readiness; logger and upgrade
ordering remain conditional. d__109/d__104 MoveNext, color accessors, concrete
callbacks and font3323/material7 remain open. Complete source/special-scene/runtime
manifest, serializer/nonlinear restore, Quest ordering/reflection/initial-unlock/
counter, full semantic/independent diff/delta, final fonts/licenses/resources/runtime/
visual/delivery remain pending. Conditional12246 values/copy,24492 occurrences,
16 actor IDs,126 registrations/114 entries do not prove live selection. Accepted
10/15/47/48 visuals/50 route unchanged;spawn/other3 intros/notebook/Bucky open.
Parallel drafting and preliminary editorial exceptions pass no gate.

No Git mutation, original/native execution, resource decoding, game/GUI/preview/image
access, frozen source/glossary/configuration/lane edit, 53 replay/54, competing overlay,
publication/deployment or server work occurred.
