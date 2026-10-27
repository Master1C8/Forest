# Exact TMP dynamic character-addition boundary

The Forest of Love 0.45, Russian standard localization, technical phase0104.
Original metadata/IL only. Verified actual codex ancestor56499 with explicit
`gpt-6.1-sol` / `high` / `openai` and `--ignore-user-config` before metadata work.
Read comm and ppid separately; isolated options before `--output-last-message`
before shlex parsing. No following prompt or previous conversation was read.
No agents, nested model/CLI jobs, original assembly/native execution, game/GUI,
preview, images, resource decoding, authored translation or Git mutations.

Original Unity.TextMeshPro.dll SHA256:
`775eab21aef1558df02968234ce1e506c2685c95813ba7cbb89e8f3e9102c483`.
Exact selected entry:
`System.Boolean TMPro.TMP_FontAsset::TryAddCharacterInternal(System.UInt32,TMPro.TMP_Character&)`.
Assembly/HideBySig, IL/body=true, nonvirtual/not new-slot/not final,
genericArity0, no explicit overrides. Complete287-line export,285 instructions,
IL_0000–IL_02cd. Six indispensable direct dependency bodies fully read in218
export lines/206 instructions: source font getter3,FaceInfo point-size getter7,
FontEngine.LoadFontFace(Font,Int32)8,TMP_Character constructor22,
FontEngine.TryAddGlyphToTexture(exact lists/out-Glyph overload)161,
Glyph.atlasIndex setter5. Total7 bodies/491 instructions, zero unread selected
ranges. TextCoreModule hash `5d36823b178018de4ce2aaeec2eed70912a48908f3ddbe721a18fcb106e1d3be`.
No overload was substituted; native behavior was not inferred from names.

## Output and mutation contract

Entry first writes caller out character=null. Normal false returns are missing
Unicode cache hit, nonzero font-load status, missing glyph after numeric aliases,
unreadable current texture, and exhausted/disabled multi-atlas attempt. All later
out stores follow newobj and lead only to true. Thus normal false leaves null,
normal true a constructed nonnull character. This closes phase103's hypothetical
false/non-null out path for this exact method. Exceptions are separate: a late
collection/feature failure can leave output and partially mutated state. No local
handler or rollback exists; this is not a reentrancy or native correctness proof.

Load source font at stored point size before glyph lookup. Missing glyph160 retries32;
173/8209 retry45. A still-zero index caches ORIGINAL Unicode as missing. Existing
glyph index bypasses atlas preflight: construct character using original Unicode,
store caller out, append character table, dictionary.Add, return true. Duplicate
character, null field/collection, scalar, bounds and atlas mode guards are absent.
Upstream Dynamic guard remains phase103 evidence; this entry itself has none.

New glyph path checks virtual Texture readability; warning literals are diagnostic
fragments, not proven player-visible inventory. If width OR height is zero, Resize
stored dimensions, discard its bool, then native ResetAtlasTexture. Add receives
packing numeric0, padding, free/used lists, render mode,current texture,local glyph
ref. On true: set atlas index; append glyph table; glyph dictionary.Add; construct
character/store caller out; append character table; character dictionary.Add;
append index to total/newly-added lists; conditional feature registration; true.
A failed first add can call unread SetupNewAtlasTexture and try once more. A second
failure returns false without rollback. Setup's exact mutation boundary is next.

Direct FontEngine load wrapper forwards to InternalCall and returns its status.
GetGlyphIndex and ResetAtlasTexture are InternalCall/no-body declarations. The
read glyph-add wrapper caches counts, may replace TWO shared arrays separately
with NextPowerOfTwo(sum+1), copies input rectangles, then calls exact InternalCall
TryAddGlyphToTexture_Internal with count references. Native true constructs/stores
a Glyph, clears the two lists in order and copies back by updated counts. False
sets glyph out null, without clearing/copying lists. Earlier array/native effects
can survive false; unchecked sums, no null/overflow guards, locks or rollback.
Mathf.Max, Glyph marshalling constructor and underlying native behavior remain open.

TMP_Character constructor writes element type numeric1, forwards Unicode/asset/glyph/
index/scale setters and reads glyph.index; their unread bodies are explicitly listed.
Source font/point-size getters read fields; atlas setter writes Glyph.m_AtlasIndex.
Concrete Texture2D virtual overrides, Resize,name/logging,settings/registration,
SetupNewAtlasTexture and ReadFontAssetDefinition remain unread. Original font3323/
material7, actual resources, Unicode coverage, shaping, layout and rendering unaccepted.

## Reproduction and continuation

```text
python3 -B localization/source/bgdatabase-20261027/bio-tmp-add-character/verify_add_character.py --output localization/source/bgdatabase-20261027/bio-tmp-add-character/<new-output-directory>
```

The verifier reuses frozen InspectMethods/phase100 BackingScopes and pinned bin
contents/Cecil, SDK8.0.131, without rebuild. It checks all931 inherited unique
files/150 DLLs plus29 phase103 files; reproduces exact selected exports and scopes;
checks declaration identities, ordered branches/output stores/returns/mutations,
39 method operands,64 fields,27 opaque BCL operands,29 unique direct declarations,
6 InternalCall declarations and zero handlers. These checks support the actual full
IL reading; they do not replace native/resource/runtime/editorial acceptance.
See metadata-verified/verification.json and source-trace.json for exact results.

Next work reads exact SetupNewAtlasTexture() from next-consumer.json, only indispensable
new direct dependencies; retain ReadFontAssetDefinition as separately unread unless
indispensable. Do not replay unchanged selected bodies or decode font resources.
All phase79–103 controller/DB/Lua/metatable/language/save/callback/reachability,
parser/style/resource/shared-state,source/special-scene/editorial/font/runtime/visual/
delivery limits remain pending in the inherited trace. Accepted10/15/47/48 visuals/
50 route unchanged; spawn/other3 intros/notebook/Bucky open. No53 replay/no54.

Previous README/CHECKPOINT bytes archived exactly. Update only current binding plus
one checkpoint section; preserve all prior sections and exact following README bytes,
especially preliminaryEditorial,russianActualPreview,parallelLocaleDrafts,localeStatus.
Separate guarded summary writes are not a transaction; postconditions are verified.
Parent alone owns Git/index/HEAD and integrates exact artifact manifest hashes.
All localization/*-assets/,asset/editorial/Japanese jobs,frozen inputs and actual
preview remain independent/read-only. No operational job or prior supplement edits.
Request token usage unavailable to this worker; parent accounts from actual telemetry.
