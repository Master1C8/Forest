# Exact TMP synthesized characters and face metrics

The Forest of Love 0.45, Russian standard localization, technical phase0107.
Static original metadata/IL only. Actual codex ancestor67984 verified before metadata:
`gpt-6.1-sol` / `high` / `openai`, `--ignore-user-config`. No inherited conversation,
agents, nested model/CLI jobs, original execution, game/GUI/preview, images, resource
decoding, authored translations or Git mutations. Parent integrates this evidence.

Original Unity.TextMeshPro.dll SHA256
`775eab21aef1558df02968234ce1e506c2685c95813ba7cbb89e8f3e9102c483`;
TextCoreModule `5d36823b178018de4ce2aaeec2eed70912a48908f3ddbe721a18fcb106e1d3be`.

## Complete bounded reading

Exact AddSynthesizedCharactersAndFaceMetrics:130 instructions/132 lines,
IL_0000–IL_0161. Its indispensable helper and five new metric accessors:
90 instructions/102 lines. Four indispensable glyph dependencies:69 instructions/
77 lines. Exact marshalling constructor:25 instructions/27 lines. All four complete
exports read contiguously,338 lines,12 bodies/314 instructions,zero unread selected
ranges. Six exact prior complete direct managed bodies reused by verified hashes.

The entry initializes faceLoaded=false. Atlas mode numeric1 alone attempts the
retained source-font/pointSize/LoadFontFace path and captures result==0 once. It then
calls the helper for numeric codes3,9,10,11,13,1564,8203,8206,8207,8232,8233,8288, in
that order. The third bool is true only for3/9. Neither failed font loading nor other
population modes stop synthesis.

The helper preserves every existing dictionary key by immediate return. For absent
keys with faceLoaded=true, GetGlyphIndex is a native presence test. Nonzero index
and third bool=false returns without adding. For3/9 with nonzero index, it queries
the exact native glyph wrapper using flags10 when (atlasRenderMode &4)==4, else8.
Native wrapper true constructs a Glyph from the returned marshalling fields and
passes it to the retained TMP_Character constructor before dictionary Add. Wrapper
false returns without a placeholder. Native state/results remain unexecuted.

False faceLoaded or index0 instead allocates a fresh Glyph with index0, five metric
fields0, scale1, atlasIndex0 and a rectangle copied from get_zero. That accessor only
copies Private Static InitOnly s_ZeroGlyphRect; its implicit initializer/value remain
unread. Do not infer zero rectangle coordinates from its name. The retained character
constructor still has separately unread forwarded base/unicode/glyphIndex/scale
boundaries; phase106's exact textAsset/glyph setter evidence remains applicable.
This helper only Adds to the character dictionary; it does not directly add entries
to serialized character/glyph tables, glyph dictionary/index lists or atlas textures.

After the12 calls, zero capLine uses current dictionary entry88/X's glyphIndex to
index the separate glyph dictionary, copies metrics.horizontalBearingY and stores
capLine. Then zero meanLine does the same for120/x. Only character ContainsKey is
guarded. Missing glyph keys/null entries can fail after prior mutations. Nonzero/NaN
metrics skip defaulting; there is no clamp, sign/finiteness or glyph-identity guard.

There are no handlers, rollback, lock, dirty-state commit or direct registration
operands in these12 bodies. Earlier successful Adds/capLine changes survive a later
exception; shared aliases would observe writes, but actual sharing is unknown. The
retained lazy dictionary getter may suppress retry after partial initialization.
Native/BCL/implicit initializer/transitive registration effects remain open.

## Reproduce and hand off

```text
python3 -B localization/source/bgdatabase-20261027/bio-tmp-synthesized-characters/verify_synthesis.py --output localization/source/bgdatabase-20261027/bio-tmp-synthesized-characters/<new-output-directory>
```

The first verifier run passed: four byte-exact IL reexports, metadata scopes,
12 bodies/314 instructions,34 method operands,42 field operands,11 opaque BCL operands,
19 unique direct declarations,2 native declarations,zero handlers and branch/order
assertions. SDK8.0.131; frozen InspectMethods/BackingScopes/Cecil reused without rebuild.
Inherited931 files/150 DLLs and29 phase103/25 phase104/28 phase105/35 phase106 files
retain hash parity. Originals are read as metadata, never loaded or invoked. No mocks
replace native/BCL mechanisms. Deterministic checks support but do not replace the
recorded full IL reading, and pass no runtime, glyph or rendering gate.

One documentation write failed because relative/absolute Path values were mixed;
execution-model.json had already been written. The repaired construction used project
relative paths and retained the verified record; no metadata failure or replay.

Next read exact UpgradeFontAsset() from next-consumer.json and indispensable new
direct managed dependencies. Feature upgrade, Material.GetFloat/Object.name, forwarded
six-argument Texture2D constructor and implicit GlyphRect initializer stay separately
unread. Retain all phase79–106 source/consumer/runtime limits and pending complete
source/special-scene/editorial/final-font/resource/runtime/visual/delivery gates.
Accepted10/15/47/48 visuals/50 route are unchanged; spawn/other3 intros/notebook/Bucky
remain open. No53 replay/no54, competing overlay, preview or frozen-input writes.

Exact prior README/CHECKPOINT bytes are archived. Only the current README binding and
checkpoint nextAction/updatedAt plus one new scoped section change. Protected locale,
editorial and preview sections and all following README bytes are preserved. Separate
guarded writes are not transactional; actual postconditions are recorded. Parent owns
Git/index/HEAD. All parallel asset/editorial/Japanese lanes and actual preview remain
independent/read-only. Usage is unavailable here; parent collects actual telemetry.
