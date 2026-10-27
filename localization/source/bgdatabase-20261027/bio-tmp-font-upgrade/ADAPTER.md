# Exact TMP legacy font-asset upgrade

The Forest of Love 0.45, Russian standard localization, technical phase0108.
Static original metadata/IL only. Actual codex ancestor70569 was verified before
metadata: explicit gpt-6.1-sol/high/OpenAI with --ignore-user-config. Parent owns
Git/index/HEAD. No agents, nested model/CLI jobs, original assembly/native execution,
game/GUI/preview, images, resource decoding or authored translations.

Unity.TextMeshPro.dll SHA256
`775eab21aef1558df02968234ce1e506c2685c95813ba7cbb89e8f3e9102c483`;
TextCoreModule `5d36823b178018de4ce2aaeec2eed70912a48908f3ddbe721a18fcb106e1d3be`.
CoreModule `32572aef39e4e9b2cd1b732d0e01998874993344c5682662fad513a3e7e49658`.

## Complete bounded reading

Exact UpgradeFontAsset:429 instructions/431 lines,IL_0000–IL_055b. Read contiguous
lines1–160,161–300,301–431. Its21 indispensable new direct FaceInfo/Glyph accessors
and parameterless Glyph constructor:122 instructions/164 lines,read in full.
Total22 bodies/551 instructions/595 lines,zero unread selected ranges.11 exact prior
complete direct bodies reused by hashes. Four direct logging/name wrappers remain
unread. No substitute overload or GenerateTextMesh was inspected.

Version1.1.0 is stored before name/logging and all legacy accesses. Later exceptions
can leave version nonempty and prevent the retained conditional upgrade on retry.
The19 ordered FaceInfo setters are direct stores; both superscript/subscript size
come from legacy SubSize. Point size/atlas dimensions/padding use raw conv.i4, with
no clamp/finiteness guard. The exact mapping is in source-trace.json.

Null/empty atlas array is replaced by length1; otherwise its identity/remaining slots
remain. Element0 is unconditionally overwritten by the legacy atlas reference.
Numeric creation renderMode0/1/2/3/6/7 maps to4121/4117/4122/4118/16422/32806;
4/5/other values preserve the current mode. No texture pixels are copied here.

Legacy weight array is checked only for null/nonzero length before ordered slot4/7
copies; source/destination bounds and destination null are unguarded. Fallbacks
append without Clear/dedup/filtering and reload source Count every iteration. Under
normal BCL semantics explicit retries append duplicates; aliased source/target makes
the bound grow with each Add. These are derived risks,not observed game state.

Source GUID condition is literally reference-truthy OR String.op_Inequality(value,
String.Empty),with warning only if both are false. Do not describe it as a working
nonempty check. Ordinary null/empty semantics imply both null/empty reach assignment;
BCL behavior was not executed. Actual source font resolution stays unverified.

Current glyph table Clear precedes character table Clear. Legacy entries create new
glyphs with index=position+1,atlasIndex0,legacy scale/metrics. Rect coordinates are
(conv.i4(x),atlasHeight-conv.i4(y+height+0.5),conv.i4(width+0.5),
conv.i4(height+0.5)); this is not a general nearest-rounding claim. Glyph Add occurs
before character construction/Add. Negative/duplicate IDs are not rejected; the
retained definition later keeps first dictionary keys. Legacy lists remain intact.
Missing id32 causes index0 space creation with zero width/height/bearings and advance
ascentLine/5,scale1,atlasIndex0. Its rectangle comes from retained get_zero; the static
initializer/current value stay unread. Ordinary Glyph() instead uses initobj for its
own metrics/rectangle. Do not conflate those two mechanisms.

An unconditional tail ReadFontAssetDefinition reenters definition. Under unchanged
version1.1.0 it skips legacy upgrade,then rebuilds/synthesizes/defaults/hashes; an outer
definition resumes and repeats its own remaining work. Retained partial dictionary,
pair-key collision and lazy-retry limits apply. No handlers/rollback/locks or direct
registration/material-write operands in22 selected bodies. Shared references expose
mutations; actual aliases,reentrancy,unread feature upgrade and native/BCL effects
remain open. No runtime,source,renderer,editorial or delivery gate passes here.

## Reproduce

```text
python3 -B localization/source/bgdatabase-20261027/bio-tmp-font-upgrade/verify_upgrade.py --output localization/source/bgdatabase-20261027/bio-tmp-font-upgrade/<new-output-directory>
```

The first verifier produced a complete passed-static-scoped result: byte-exact two IL
reexports and scopes,22 bodies/551 instructions,40 resolved method operands,148 field
operands,19 opaque BCL operands,36 unique direct declarations,zero handlers. SDK8.0.131;
frozen InspectMethods/BackingScopes/Cecil reused without rebuild. All inherited931
files/150 DLLs plus29 phase103/25 phase104/28 phase105/35 phase106/32 phase107 files
retain parity. Eleven prior direct-body evidence files verify. No mocks replace native
or BCL mechanisms. Deterministic assertions support the separately recorded full IL
reading,not transitive execution or editorial acceptance.

The exec observer did not retain the first verifier's session/exit fields. Completed
verification.json/all exact outputs and absence of its task processes were reconciled;
no identical replay was performed. No metadata/preparation failure was observed.

Next read exact UpgradeGlyphAdjustmentTableToFontFeatureTable() with indispensable
new direct dependencies. Keep name/logging/Material.GetFloat wrappers,six-argument
Texture2D constructor,character forwarded setters/base and implicit GlyphRect initializer
separately unread. Retain79–107 source/renderer/editorial/runtime limits and all pending
complete source/special-scene/semantic-diff/fonts/licenses/resources/runtime/visual/
delivery gates. Accepted10/15/47/48 visuals/50 route unchanged;spawn/other3 intros/
notebook/Bucky open. No53 replay/no54/competing overlay or live-preview interaction.

Exact previous README/CHECKPOINT bytes archived. Only current README binding and
checkpoint nextAction/updatedAt plus one new section change; following owner/history
and every other checkpoint section remain unchanged. Separate guarded writes are not
a transaction. Parent integrates exact manifest; worker Git mutations0. Parallel asset,
locale/editorial/Japanese lanes and actual preview remain independent/read-only.
Usage unknown here; parent collects actual request telemetry.
