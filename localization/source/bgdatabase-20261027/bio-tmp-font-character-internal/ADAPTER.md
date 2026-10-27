# Exact TMP internal font-character selection

The Forest of Love 0.45, Russian standard localization, technical phase0103.
Original metadata/IL only. Ancestor executable basename `codex`, explicit
`gpt-6.1-sol` / `high` / `openai` and `--ignore-user-config` verified before
metadata work. Separate comm/ppid reads; options isolated before the known
`--output-last-message` boundary and before shlex parsing. No following prompt,
parent/previous conversation, original managed/native code or images loaded.

Original Unity.TextMeshPro.dll SHA256:
`775eab21aef1558df02968234ce1e506c2685c95813ba7cbb89e8f3e9102c483`.
Exact selected entry:
`TMPro.TMP_Character TMPro.TMP_FontAssetUtilities::GetCharacterFromFontAsset_Internal(System.UInt32,TMPro.TMP_FontAsset,System.Boolean,TMPro.FontStyles,TMPro.FontWeight,System.Boolean&)`.
Private/Static/HideBySig, IL/hasBody=true, nonvirtual/not new-slot/not final,
genericArity0, no explicit overrides. Full export212 lines/210 instructions,
IL_0000–IL_01c4. Four indispensable direct font getters add22 export lines/
17 instructions (atlas mode3, character lookup8, fallback list3, weight table3).
All227 selected instructions read, zero unread selected ranges. Original enum
metadata separately confirms Italic=2 and Dynamic=1. No sibling overload,
GenerateTextMesh body or font resource was substituted.

## Selection, shared state and limits

The internal entry FIRST writes alternative-typeface output false and initializes
local character null. It tests only Italic style bit2 here. Nonitalic weight400
skips alternate table lookup. Otherwise the weight table uses default slot4;
explicit100..900 in100 increments select slots1..9, other numeric weights keep4.
The italic bit selects italicTypeface versus regularTypeface. No independent
Bold-bit test, weight normalization, null-font or weight-array length guard
occurs in this body. Upstream style/weight preparation remains separate.

For a Unity-nonnull alternate font, try its dictionary first. A true TryGetValue
sets alternative=true and returns its out value without a separate null check.
On miss, only Dynamic mode1 permits TryAddCharacterInternal; true again sets
alternative=true and returns the local without checking it for null. Then try
the original font dictionary and Dynamic addition in the same order, without
setting alternative=true on these paths. These branch contracts alone do not
prove a real glyph, valid scalar or successful visible output.

Fallback traversal requires local character == managed null AND includeFallbacks.
The local is not reset after a failed glyph-add call; false with an out-modified
nonnull character would skip fallback and reach the final null return. The
unread glyph-add body's actual output contract must therefore be checked.
No source Unicode, current font, material or glyph field is directly written here.

On fallback, a nonnull list getter is called again, then the list reference and
Count are cached. Empty returns null. Cached-count order skips Unity-null fonts,
obtains each candidate ID, and gates it on shared k_SearchedAssets.Add(id).
False skips the candidate. After a successful shared Add, the current source
font's FallbackSearchQueryLookup.Add(id) runs, its bool is discarded, and the
exact internal method recurses with candidate, true, unchanged Unicode/style/
weight and the SAME out-bool reference. First managed-nonnull result returns;
otherwise continue, finally null. Each recursive entry resets the output false.

This body does not initialize/clear the shared set or seed the current font ID.
Phase102 wrappers own initialization. The internal shared-set bool gate differs
from the outer list wrapper's discarded source-query Add result. Query failure
can follow shared-set and ID-cache mutations. No local handlers, rollback, locks,
list snapshot or reentrancy protection exist in the five selected bodies. The
conditional visited-set gate does not prove general termination under arbitrary
mutation/reentrancy. No separate alternate-font fallback traversal occurs here.

Atlas-mode, weight-table and fallback-table getters return their fields directly.
The character-lookup getter checks its dictionary field; if null it calls exact
ReadFontAssetDefinition, reloads the field and returns without a post-call guard.
That definition body and TryAddCharacterInternal remain unread. Repeated getter
calls are separate calls, not evidence of immutable resources. Three exact prior
bodies (two Object comparisons and the cached TMP_Asset instance ID getter) are
reused by declaration/module/body-container hashes, without replay.

## Reproduction and next boundary

```text
python3 -B localization/source/bgdatabase-20261027/bio-tmp-font-character-internal/verify_character_internal.py --output localization/source/bgdatabase-20261027/bio-tmp-font-character-internal/<new-output-directory>
```

metadata-verified/verification.json passes:5 bodies/227 instructions,14 resolved
method operands,9 fields,6 opaque BCL/runtime operands,10 unique declarations,
0 handlers. Ordered branch/operand assertions cover lookup order, weight mapping,
Dynamic guards, local/output handling, lazy definition and both set operations.
All931 retained unique files,150 original DLLs and30 phase102 files verify.
Frozen InspectMethods and phase100 BackingScopes binaries and all pinned bin
dependencies/loaded Cecil parity reused; SDK8.0.131, no reader rebuild. No mocks
or original execution. Counts/hash checks support the full recorded reading;
they are not semantic, native, resource, renderer or editorial acceptance.

Next exact unread boundary is pinned in next-consumer.json:
`System.Boolean TMPro.TMP_FontAsset::TryAddCharacterInternal(System.UInt32,TMPro.TMP_Character&)`.
Assembly/HideBySig, IL/hasBody=true, nonvirtual/not new-slot/not final,
genericArity0, no explicit overrides, same original module/hash. Read this body
and only indispensable new direct managed dependencies, then pin the actual
glyph/font/native boundary. Also retain the exact unread ReadFontAssetDefinition
declaration in that packet. Do not infer native behavior from either declaration.

Previous README/CHECKPOINT bytes are archived exactly. Existing checkpoint
sections, especially preliminaryEditorial/russianActualPreview/parallelLocaleDrafts/
localeStatus, are preserved. Summary writes are separate, not transactional;
postconditions and unchanged following README bytes are verified. Parent alone
owns Git/index/HEAD and integrates exact manifest hashes; worker performs no Git
mutations. Parallel asset/editorial/Japanese lanes and actual preview remain
independent/read-only. No agents, nested model/CLI jobs, overlays or translation.
Measured model usage is unavailable to this worker; parent accounts for its request.

Retain all phase79–102 source/GetState/formatter/null-GUID/participant/cache/
Transform/typed-Lua/fallback/reset/singleton/table/reentrancy/serialized-state/
native-selection/conditional-panel/write/coroutine/notification/queue/pre-render/
parser/style/backing/array-sizing/resource limits. Panel3633/TMP4571 remains
conditional, not live UI proof. Controller/DB/Lua/metatables/language/loading/save/
global scripts/callbacks/BIO/reachability, d__109/d__104 MoveNext,color accessors,
concrete typewriter/notifications/dirty callbacks,font3323/material7 remain open.
Complete source/special-scene/runtime manifest,serializer/nonlinear restore,Quest
ordering/reflection/initial-unlock/counter,universal full semantic/independent diff/
delta,final fonts/licenses/resources/runtime/visual/delivery remain pending.
Conditional12246 values/copy,24492 occurrences,16 actor IDs,126 registrations/114
entries do not prove live selection. Accepted10/15/47/48 visuals/50 route unchanged;
spawn/other3 intros/notebook/Bucky open. No53 replay/no54. No protected/frozen
source/glossary/inventory/config,asset/editorial/job/preview or older-helper edits.
