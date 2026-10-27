# Exact TMP legacy glyph-adjustment upgrade

The Forest of Love 0.45, Russian standard localization, technical phase0109.
Static original IL/metadata only. Actual codex ancestor72630 was verified before
metadata: executable basename codex, explicit gpt-6.1-sol/high/OpenAI and
--ignore-user-config. Options isolated before --output-last-message; no following
prompt/history read. Parent alone owns Git/index/HEAD; worker Git mutations0.
No agents/nested model jobs, game/native execution, GUI/preview, images, resource
decoding or authored translations. All parallel lanes remain independent/read-only.

Unity.TextMeshPro.dll SHA256
`775eab21aef1558df02968234ce1e506c2685c95813ba7cbb89e8f3e9102c483`.
CoreModule SHA256
`32572aef39e4e9b2cd1b732d0e01998874993344c5682662fad513a3e7e49658`.
Frozen InspectMethods/phase100 BackingScopes/Cecil reused without rebuilding;
only Cecil reads original assemblies. SDK8.0.131.

## Full bounded reading

UpgradeGlyphAdjustmentTableToFontFeatureTable:110 instructions/112 lines,
IL_0000–IL_0153, read lines1–112. Eight indispensable new direct constructors/
getters:53 instructions/69 lines, read lines1–69. Total9 bodies/163 instructions/
181 lines, zero unread selected ranges. The exact direct get_glyphIndex accessor
and caller's pair-dictionary rebuild/key logic are reused from phase106 by hashes.
Object.name and Debug.Log managed wrappers remain separately unread.

Logging occurs first. Create a feature table only when managed-null; its constructor
allocates an empty list then dictionary. Snapshot legacy list Count once, then
unconditionally replace feature records list with new List(capacity=count).
Existing feature-table identity/dictionary remain; dictionary can be stale until
caller's later rebuild. No legacy-table/list null guards in this method.

For each captured source position, reload legacy table/list and fetch its pair.
Direct firstGlyph/secondGlyph fields are keys for character-dictionary TryGetValue.
Each result starts at index0; a successful lookup reads that character's glyphIndex.
Missing keys retain0 without warning/skip. These source values are not blindly copied
as current glyph indices. Null pair/dictionary/returned character can fail; real
serialized values/readiness remain unverified.

Copy first then second adjustment, each in exact xPlacement,yPlacement,xAdvance,
yAdvance order. Each source value-type getter is reloaded four times. Value ctor
stores raw values; adjustment ctor stores mapped index then value record. Pair ctor
stores first,second,then featureLookupFlags numeric0. No scaling,clamp,finiteness
check,swap,sort,dedup or packed-key construction in these selected bodies.

Append each new pair to the current feature list. Only after the whole captured-count
loop completes: legacyTable.kerningPairs=null, then font.m_KerningTable=null.
External old-list references keep their elements; shared legacy-table references see
its list field null. Tail stores are separate; no intervening call/ordinary single-
thread throwing operation follows the first tail store. Concurrency/interruption is
not executed. A direct rerun has no local null early return; retained caller guards
on legacy table/list and positive Count.

List replacement and prefix Adds survive later conversion failure; old legacy input
and an existing dictionary can remain. No handler,rollback or lock. Caller then
allocate/Clears pair dictionary and inserts UInt32 (second<<16)|first, first computed
key winning, without masking/range checks. Existing collision/missing-index0 risks
remain static deductions, not observed game behavior. No direct registration or
material/native call in selected9 bodies; unread logging/BCL/transitive effects open.

## Reproduce and validation boundary

```text
python3 -B localization/source/bgdatabase-20261027/bio-tmp-font-feature-upgrade/verify_feature_upgrade.py --output localization/source/bgdatabase-20261027/bio-tmp-font-feature-upgrade/<new-output-directory>
```

metadata-verified-02/verification.json is passed-static-scoped,process exit0:
byte-exact two exports/scopes;20 resolved method operands,38 fields,11 opaque BCL
operands,11 unique direct declarations,zero handlers.8 new direct bodies,1 reused
body,2 unread direct wrappers. Inherited931 files/150 DLLs and29/25/28/35/32 files
from phases103–107 plus26 phase108 files verify;7 process-reference hashes match.

Attempt1 exported identical bytes but failed a verifier assertion: the expected
constructor token used ::TMP_Type instead of TMPro.TMP_Type. Exact failed verifier
snapshot and outputs remain; only assertion spelling changed for attempt2. No
metadata export failure, reader rebuild or original/native invocation. Deterministic
assertions corroborate recorded full reading; they do not execute replaced BCL/native
mechanisms or establish runtime/editorial correctness. Usage unavailable to worker.

Next: exact five resolved CoreModule material/name/logging wrappers in next-consumer.
Keep six-argument Texture2D ctor,implicit GlyphRect initializer and forwarded character
base/unicode/glyphIndex/scale setters separately unread. No substitute overloads or
GenerateTextMesh. Retain phases79–108 controller/DB/Lua/language/loading/save/global/
callback/BIO/reachability/parser/style/native-selection/serialized/resource limits;
concrete typewriter/notifications/dirty callbacks and d__109/d__104 MoveNext stay open.

Complete source/special-scene/runtime manifest,serializer/nonlinear restore,Quest
ordering/reflection/unlock/counter,full semantic/independent diff/delta,final fonts/
licenses/resources/runtime/visual/delivery remain pending. Counts12246/24492,16 actor
IDs and126 registrations/114 entries do not prove live selection. Accepted10/15/47/48
visuals/50 route unchanged;spawn/other3 intros/notebook/Bucky open. No53 replay/no54,
competing overlay,preview interaction or publication/deployment. Parallel drafting/
preliminary editorial exceptions pass no gate.

Exact prior README/CHECKPOINT archived. Only current README prefix,checkpoint
nextAction/updatedAt and one new section change. Every old section and following
README bytes are preserved, including preliminaryEditorial,russianActualPreview,
parallelLocaleDrafts,localeStatus. Separate guarded writes are not a transaction;
actual postconditions verified. Parent integrates the exact manifest.
