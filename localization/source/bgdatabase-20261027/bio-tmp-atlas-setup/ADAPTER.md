# Exact TMP atlas-setup mutation boundary

The Forest of Love 0.45, Russian standard localization, technical phase0105.
Static original metadata and IL only. Actual codex ancestor60975 was verified as
`gpt-6.1-sol` / `high` / `openai` with `--ignore-user-config` before metadata work.
No inherited history, agents, nested model jobs, original assembly/native execution,
game/GUI/preview/images, resource decoding, translations or Git mutations.

Original Unity.TextMeshPro.dll SHA256:
`775eab21aef1558df02968234ce1e506c2685c95813ba7cbb89e8f3e9102c483`.
Exact entry `System.Void TMPro.TMP_FontAsset::SetupNewAtlasTexture()` is private,
nonvirtual IL, no overrides/generic parameters. Full73-line export,71 instructions,
IL_0000–IL_00af, read completely. Two indispensable new direct managed bodies read
in33 export lines: exact four-argument Texture2D constructor15 instructions and
four-Int32 GlyphRect constructor14 instructions. Total3 bodies/100 instructions,
zero unread selected ranges. CoreModule hash
`32572aef39e4e9b2cd1b732d0e01998874993344c5682662fad513a3e7e49658`;
TextCoreModule hash
`5d36823b178018de4ce2aaeec2eed70912a48908f3ddbe721a18fcb106e1d3be`.

## Ordered effects and failure state

Increment and store atlas index FIRST, then read array length. Resize by reference
to length*2 only for equality between length and new index. Arithmetic is unchecked;
there is no null, negative, overflow, upper-bound or zero-capacity repair. An index
already above length bypasses growth. Typical valid-state doubling is conditional.

Load stored dimensions and construct Texture2D with numeric format1 and mipChain=false,
then install in current slot. Construction precedes stelem.ref bounds checking.
Reload current slot and call original InternalCall ResetAtlasTexture, whose native
body is unavailable/unexecuted. There is no existing-slot release or readability
check here. The read constructor only forwards: false mipChain selects mipCount1,
linear=false, IntPtr.Zero, with original dimensions/format, into a resolved UNREAD
six-argument constructor. Validation, allocation and native behavior remain unknown.

After reset, border is0 when renderMode bit16 is set, else1. Clear free list, reload
it, append GlyphRect(0,0,width-border,height-border), then clear used list. The read
rectangle constructor directly assigns its four fields without checks. No clamp,
positive-size or stable-field check exists. Dimensions and list fields are reloaded
after native reset; no reentrancy/identity guarantee. If both list fields alias one
List, the final Clear removes the new free rectangle. This is a conditional static
boundary, not evidence that the real font aliases them.

No local handlers, rollback, locks or loops. A normally completed setup followed by
the caller's second normal false glyph-add retains setup mutations: index, possible
array growth, installed texture, reset and rectangle effects. Phase104's normal false
out-character=null contract remains valid; failed addition does not imply unchanged
font state. The read glyph wrapper can also leave shared-array/native effects.
Exceptions can stop at earlier partial state. These findings do not establish native
packing, actual font coverage or rendering.

## Reproduce and continue

```text
python3 -B localization/source/bgdatabase-20261027/bio-tmp-atlas-setup/verify_atlas_setup.py --output localization/source/bgdatabase-20261027/bio-tmp-atlas-setup/<new-output-directory>
```

Frozen InspectMethods/phase100 BackingScopes and pinned bin/Cecil dependencies are
reused without rebuild, SDK8.0.131. Retained931 unique files/150 DLLs and phase103's29
plus phase104's25 files verify by inherited exact pins. The verifier reproduces both
IL exports and exact scopes, asserts3 bodies/100 instructions,4 method operands,
22 fields,4 opaque runtime method operands,4 unique declarations,1 InternalCall
declaration, zero handlers, and branch/mutation/forwarding order. It does not execute
original assemblies or replace native behavior with mocks.

One metadata preparation attempt failed with signal6 because the new next-signature
input used objects instead of the frozen reader's string-array schema. Exact failed
input is retained; captured stderr was not retained, so no exact exception is claimed.
Reader source inspection established the mismatch and its TMP-only next-declaration
lookup. New input was corrected, old readers untouched; corrected metadata and the
first verifier run passed. Full accounting is in verification-history.json.

Next read exact ReadFontAssetDefinition() in next-consumer.json; its lazy dictionary
initialization remains unread. Keep the six-argument Texture2D constructor and prior
constructor/settings/Texture/Mathf/native boundaries explicitly open. Do not replay
unchanged bodies or decode fonts. All phase79–104 controller/DB/Lua/language/save/
callback/reachability/parser/style/resource/shared-state and complete source/special-
scene/editorial/font/runtime/visual/delivery gates remain pending. Accepted10/15/47/48
visuals/50 route unchanged; spawn/other3 intros/notebook/Bucky open. No53 replay/no54.

Exact previous summary/checkpoint bytes are archived. Update only current binding,
nextAction/updatedAt and one new checkpoint section; preserve every other section and
following README bytes, especially localeStatus,preliminaryEditorial,russianActualPreview,
parallelLocaleDrafts. Separate guarded writes are not transactional; exact postconditions
are checked. Parent alone owns Git/index/HEAD and integrates the exact manifest. All
asset/editorial/Japanese lanes, frozen inputs and actual preview remain independent/
read-only. Worker usage is unavailable; parent measures actual telemetry.
