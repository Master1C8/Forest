# Concrete TMP array-sizing consumer

The Forest of Love 0.45; Russian standard localization, technical phase0101.
Static original metadata/IL only, with verified actual codex ancestor options
`gpt-6.1-sol/high/OpenAI` and `--ignore-user-config`. Options were isolated before
the known `--output-last-message` delimiter, before shlex parsing. No following
prompt/history was parsed or emitted. See execution-model.json for the initial
process-column parsing failure and successful separate executable/options check;
metadata work began only after the successful check.

Original Unity.TextMeshPro.dll SHA256:
`775eab21aef1558df02968234ce1e506c2685c95813ba7cbb89e8f3e9102c483`.
Exact selected body:
`System.Int32 TMPro.TextMeshProUGUI::SetArraySizes(TMPro.TMP_Text/UnicodeChar[])`.
It is virtual, not new-slot, not final, with no explicit overrides and genericArity0.
All 1325 export lines / 1323 IL instructions were read in four contiguous portions:
1–340,341–650,651–980,981–1325 (`IL_0000` through `IL_0f89`). No unread caller range.
Resolved declarations are not transitive dependency-body coverage or live receiver
selection. The TMP_Text base implementation and GenerateTextMesh were not exported.

## State and input boundaries

Before inspecting input length, the body resets count/bold/parsing/no-parsing fields,
copies style/weight (bit1 forces700), clears the style stack, sets weight-stack default,
copies current font/material, resets current material index, and initializes shared
static material-reference stack/lookup/array state through calls. It creates textInfo
from m_InternalTextProcessingArraySize or grows characterInfo to that size. Actual
construction/resize/material/font/native effects are still dependency boundaries.
No local handler, transaction, null-input preflight or rollback protects prior effects.

For overflow value1 it requests ellipsis; a missing ellipsis character changes overflow
to3 before optional warning. Different ellipsis/current font IDs conditionally select
a preset fallback material or the font material, register it and set its referenceCount0.
For overflow6, non-Unity-null linked component and !preferred-value calculation, it
walks linked components: set_text(Empty), virtual ClearMesh, textInfo.Clear, next getter.
There is no local visited/cycle guard. Concrete receivers and dependency effects remain
unknown; base declarations do not prove successful clearing.

The character loop is bounded by supplied array.Length and stops on unicode0, rather
than using the earlier processing-size field as its termination count. It grows a
null/insufficient characterInfo to totalCount+1 via the three-argument generic Resize.
With rich text and '<', exact ValidateHtmlTag receives input and index+1. Success
replaces index with the returned end; non-sprite tags skip to the loop tail. Failed
validation proceeds to ordinary processing without a caller rollback; validation's
body/side effects remain unread. Sprite-tag success writes truncated Char(57344+
spriteIndex), sprite/font/material/textElement fields, original source start index and
end.stringIndex-start+1 length, restores the saved material index, and increments counts.
It does not establish actual tag validity or sprite-table bounds.

## Character, font and missing-glyph paths

For ordinary elementType0, style bits16/8/32 take ordered case branches. They narrow
to Char for BCL IsLower/IsUpper and ToUpper/ToLower; these are opaque runtime calls,
not invariant/full-scalar shaping evidence. The working value then goes to exact
GetTextElement(UInt32,currentFont,internalStyle,internalWeight,out alternateTypeface).
No caller scalar validation appears. The GetTextElement body is the next unread boundary.

A managed-null result mutates input[index].unicode to the configured missing character
(getter may be called twice), or9633 if zero, BEFORE the next lookup. It then calls
GetCharacterFromFontAsset with boolean true; if still null, conditionally calls the
explicit settings fallback-list overload and then settings default-font overload.
Still null: it writes32 and calls the current-font utility, then writes3 and calls it
again. These last two stages do not explicitly repeat the settings-list/default branches;
the called utility's own behavior remains unread. All three input writes leave original
stringIndex/length unchanged. Earlier case conversion alone changes a local value.

There is no final caller null rejection before warnings/elementType dereference: after
the last miss, an enabled warning can dereference null via get_unicode; with warnings
disabled, IL_0740 still calls get_elementType. Signed comparison with65535 chooses the
warning format; it is not scalar validation. A successful return is not guaranteed.

ElementType1 with a different text-asset instance ID can switch currentFont to an
isinst TMP_FontAsset result. CharacterInfo retains textElement, alternate flag, narrowed
Char, original stringIndex/length and current font. ElementType2 instead creates a
sprite material reference, writes sprite fields/counts, restores saved material index
and continues. Actual element/font types, IDs, glyphs and asset state remain unknown.

For a fallback font differing from base m_fontAsset, preset matching selects a fallback
material or font material, then registers it. A nonnull element with glyph.atlasIndex>0
calls the distinct three-argument fallback-material overload. Whitespace(Char-narrowed)
or8203 bypasses ordinary reference-count increment. Otherwise count<16383 increments;
at/above16383 a copied Material is registered and incremented. These are caller-side
branches, not proof of the utility's deduplication or native material construction.
Material/fallback fields are recorded; only the fallback-flag path restores the saved
font/material/index. There is no local finally/rollback on exceptions.

## Mesh allocation and native boundary

After scanning, preferred-value mode clears its flag and returns totalCount before
sprite/material counts and mesh/submesh work. The normal path writes spriteCount and
dictionary-count materialCount, grows meshInfo and subTextObjects, and may shrink
characterInfo when excess>256 (requested max(total+1,256), boolean true).

For each material, nonzero-index missing submesh can create AddSubTextObject and null
its vertices; pivot and material/font/sprite/fallback bindings can be changed. Mesh
vertices are allocated when absent or too small for referenceCount*4. Missing arrays
construct TMP_MeshInfo(mesh,count+1); existing arrays resize to NextPowerOfTwo(count+1)
for count<=1024 or count+256 otherwise. Optional shrink requires positive count and
excess vertices/4-count>256 and uses the same split. Helpers, arithmetic overflow,
native allocations and actual resulting capacities remain unexecuted boundaries.

The final scan starts at materialCount, stops at array end or the first Unity-null
subTextObject, and calls its canvasRenderer.SetMesh(null) only when index<meshInfo.Length.
Metadata resolves SetMesh to UnityEngine.UIModule.dll, InternalCall/no managed body;
Mathf.NextPowerOfTwo is also InternalCall. The caller can reach native mesh clearing;
this is neither generated glyph geometry nor rendered-output acceptance.

## Reproduction, preservation and limits

```text
python3 -B localization/source/bgdatabase-20261027/bio-tmp-array-sizes/verify_array_sizes.py --output localization/source/bgdatabase-20261027/bio-tmp-array-sizes/<new-output-directory>
```

The accepted metadata-readback/verification.json reproduces the exact IL and scope
export using frozen InspectMethods and phase100 BackingScopes binaries. No older
helper is rebuilt or changed; all helper bin dependencies and loaded Cecil parity
are pinned. 866 retained unique files, including150 DLLs and48 phase100 files, verify.
Three direct managed bodies (Object comparisons and generic stack SetDefault) are
reused by exact declaration/module/body-container hashes. Native NextPowerOfTwo is
retained as a declaration, not a managed body. All57 unique direct declarations and14
opaque runtime calls are classified in consumer-boundaries.json. New dependency
bodies remain unread. Zero local handlers; no original game/native code or mock ran.

Previous README/CHECKPOINT bytes are archived exactly. Existing checkpoint sections,
including preliminaryEditorial/russianActualPreview/parallelLocaleDrafts/localeStatus,
are preserved; only nextAction/updatedAt change and one new section is added. Summary
writes are separate guarded writes, not transactional. Parent alone integrates the
exact phase manifest; worker performs no Git/index/branch mutations. Usage is unknown
to this worker, not zero. Authorized parallel lanes and actual preview are untouched.

Retain phase79–100 source/GetState/formatter/null-GUID/participant/cache/Transform/
typed-Lua/fallback/reset/singleton/table/reentrancy/serialized-state/native-selection/
conditional panel/write/coroutine/notification/queue/pre-render/parser/style/resource
limits. Missing TMP Settings may fail before Normal fallback. Actual controller/DB/
Lua/metatables/language/loading/save/global scripts/callbacks/BIO/reachability remain
unaccepted. d__109/d__104 MoveNext,color accessors,concrete typewriter/notifications/
dirty callbacks,font3323/material7,complete source/special-scene/runtime manifest,
serializer/nonlinear restore,Quest ordering/reflection/initial-unlock/counter,universal
full semantic/independent diff/delta,final fonts/licenses/resources/runtime/visual/
delivery remain pending. Conditional12246 values/copy,24492 occurrences,16 actor IDs,
126 registrations/114 entries do not prove live selection. Accepted10/15/47/48 visuals/
50 route unchanged;spawn/other3 intros/notebook/Bucky open. No53 replay/no54. No images,
game/GUI/preview interaction, resource decoding, translation/overlay/frozen-input edit,
publication/deployment, agents or nested model/CLI jobs occurred. Static caller coverage
does not pass the source, renderer, editorial or local delivery gate.
