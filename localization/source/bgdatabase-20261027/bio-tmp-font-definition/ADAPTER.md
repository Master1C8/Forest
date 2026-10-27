# Exact TMP font-definition initialization

The Forest of Love 0.45, Russian standard localization, technical phase0106.
Static original metadata/IL only. Actual codex ancestor64733 verified before metadata:
`gpt-6.1-sol` / `high` / `openai`, `--ignore-user-config`. No inherited conversation,
agents, nested model/CLI jobs, original managed/native execution, game/GUI/preview,
images, resource decoding, authored translation or Git mutation.

Original Unity.TextMeshPro.dll SHA256
`775eab21aef1558df02968234ce1e506c2685c95813ba7cbb89e8f3e9102c483`.
CoreModule `32572aef39e4e9b2cd1b732d0e01998874993344c5682662fad513a3e7e49658`;
TextCoreModule `5d36823b178018de4ce2aaeec2eed70912a48908f3ddbe721a18fcb106e1d3be`.

## Full reading and exact boundary

Exact public nonvirtual `ReadFontAssetDefinition()` has70 instructions,72 export
lines, IL_0000–IL_00e3. Read completely. Its indispensable dictionary dispatcher,
five FaceInfo accessors and name-hash body have63 instructions/77 lines. The three
dispatcher-direct dictionary bodies have196 instructions/202 lines, read in contiguous
ranges1–180 and181–202. Their indispensable glyph/character accessors and pair-key
constructor have45 instructions/57 lines; the constructor's three record/index getters
have9 instructions/15 lines. Total20 bodies,383 instructions,423 lines, zero unread
selected ranges. These dependency steps establish exact mapping/key mutations, not
blanket acceptance of transitive calls. Prior Object inequality and lazy-character
getter reading are reused by verified hashes without replay.

Definition conditionally upgrades when retained Unity inequality(material,null) and
IsNullOrEmpty(version) both pass. It then always dispatches glyph → character → pair
dictionary initialization, followed by the resolved UNREAD synthesis/face-metric body.
The definition body itself has no dirty/non-null-table early return.

The retained lazy getter calls definition only if its character dictionary is managed
null. Each dictionary initializer allocates a missing dictionary or clears an existing
one. Thus an exception after character dictionary allocation can leave a nonnull partial
dictionary which the next lazy getter returns without retrying definition. This is a
conditional static failure boundary, not evidence that the real asset fails.

Glyph initialization clears/allocates dictionary, index list, newly-added index list in
order, snapshots glyph-table Count, and keeps the first entry for each glyph index.
Dictionary Add precedes index-list Add. Character initialization reloads table Count
each iteration, reads unicode and glyphIndex before duplicate checking, and keeps first
unicode. It first Adds the character, then directly writes textAsset=this, then resolves
the glyph dictionary indexer, then directly writes glyph. A missing glyph can therefore
leave the entry/textAsset changed with an old glyph. FallbackSearchQueryLookup is only
allocated/cleared after successful completion of that loop. No local rollback or guards
for null tables/elements, mutation, sharing or exceptions.

The pair initializer conditionally calls an unread legacy upgrade, then unconditionally
dereferences FontFeatureTable and allocates/clears its dictionary. A null records list
skips iteration after that clearing. Its key constructor and exact getters compute
UInt32 `(secondGlyphIndex <<16) | firstGlyphIndex`, without16-bit input checks/masks.
First computed key wins; full index pairs can collide. Derived examples: (0,0) and
(0,65536) both key0; (65536,0) and (0,1) both key65536. Real indices/collisions unknown.

Sharing would matter: identical index-list fields make appends populate NewlyAdded;
shared character objects can be rebound by another asset; shared feature tables expose
dictionary rebuild effects to other owners. These are conditional consequences of
actual field writes, not assertions that real resources alias. No direct global
registration operand occurs in the selected20 bodies; unread callees may still register.

After synthesis, field accessors default scale0 to1 and strike-offset0 to capLine/2.5.
No finiteness/positivity guard. If padding0 and native HasProperty(GradientScale) true,
GetFloat → conv.i4 → unchecked subtract1 supplies padding. Earlier material guard does
not protect this block. HasProperty is InternalCall; GetFloat's managed body is unread.
Then two independent Object.name calls supply hashCode and name+suffix materialHashCode.
Exact simple hash scans UTF-16 Char units, starting0, unchecked `((h<<5)+h) XOR char`;
no case folding or normalization. Dirty=false is the final normal store. Exceptions can
leave tables/objects/metrics/padding/first hash changed before later stores. No handlers.

## Reproduce and continue

```text
python3 -B localization/source/bgdatabase-20261027/bio-tmp-font-definition/verify_font_definition.py --output localization/source/bgdatabase-20261027/bio-tmp-font-definition/<new-output-directory>
```

Frozen InspectMethods, phase100 BackingScopes, bin/Cecil dependencies reused, SDK8.0.131.
The verifier checks inherited pinned evidence, all five byte-exact IL reexports and
exact metadata scopes, module hashes,20 bodies/383 instructions,29 method operands,
78 fields,31 opaque runtime operands,26 unique declarations,1 native declaration,
zero handlers, and relevant branch/mutation ordering. The real original assembly is
read as metadata, never loaded or invoked. No mocks replace native/BCL mechanisms.

One documentation-construction attempt failed before boundary/trace output because
opaqueRuntimeOperands already carried a boundary key and dict(**row,boundary=...)
duplicated it. The existing rows were preserved instead; no metadata reader failed or
changed. The successful earlier retained-consumers write is accounted for. See the
verification history for the actual verification outcome.

Next read exact AddSynthesizedCharactersAndFaceMetrics() from next-consumer.json.
UpgradeFontAsset and UpgradeGlyphAdjustmentTableToFontFeatureTable remain separately
unread, as do GetFloat/Object.name wrappers and forwarded six-argument Texture2D ctor.
No whole-source, special-scene, renderer, editorial, native, resource, font, runtime,
visual or delivery gate passes. Retain79–105 limits, actual font3323/material7 unknowns,
accepted10/15/47/48 visuals/50 route and open spawn/other3 intros/notebook/Bucky. No53
replay/no54, competing overlay, preview control or frozen source/glossary/inventory edits.

Exact prior README/CHECKPOINT bytes are archived. Preserve every old checkpoint section
except current nextAction/updatedAt; add one scoped section and replace only the current
README binding, preserving following bytes. Separate guarded writes are not transactional;
verify their actual postconditions. Parent alone owns Git/index/HEAD and integrates exact
artifacts. All asset/editorial/Japanese lanes and actual preview remain independent and
read-only. Worker usage is unavailable; parent collects actual telemetry.
