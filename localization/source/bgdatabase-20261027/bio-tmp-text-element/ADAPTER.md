# Exact TMP text-element lookup

The Forest of Love 0.45; Russian standard localization, technical phase0102.
Static original metadata/IL only. Actual codex ancestor options verify
`--model gpt-6.1-sol`, `model_reasoning_effort=high`, `model_provider=openai`,
`--ignore-user-config`; separate comm/ppid reads and options isolated BEFORE
`--output-last-message` and shlex parsing. No following prompt/history was read
or emitted. No model workers, nested CLI/model jobs or new metadata helpers.

Original Unity.TextMeshPro.dll SHA256:
`775eab21aef1558df02968234ce1e506c2685c95813ba7cbb89e8f3e9102c483`.
Exact entry:
`TMPro.TMP_TextElement TMPro.TMP_Text::GetTextElement(System.UInt32,TMPro.TMP_FontAsset,TMPro.FontStyles,TMPro.FontWeight,System.Boolean&)`.
Assembly/HideBySig, IL, nonvirtual, not new-slot/final, genericArity0, no explicit
overrides. Full main export:154 lines/152 instructions, IL_0000–IL_0159.
Only three indispensable direct managed dependencies were additionally read:
exact six-argument GetCharacterFromFontAsset, exact SEVEN-argument
GetCharacterFromFontAssets (including sourceFontAsset), and TMP_Asset.get_instanceID.
Their complete retained export:93 lines/87 instructions (17/60/10 respectively).
All239 instructions of four selected bodies read; zero unread selected ranges.
Name-based frozen reader output is filtered by exact signatures before retaining
utility exports; no sibling overload is substituted or credited as read.

## Lookup and side effects

1. Supplied font with includeFallbacks=false; then its nonnull/nonempty fallback
   list with includeFallbacks=true. Each successful managed result returns.
2. Compare supplied/base font instance IDs. Equal skips the base-font routes.
   Unequal tries base font with false. Direct hit writes currentMaterialIndex=0,
   then reads shared materialReferences[0].material into currentMaterial and returns.
   An exception reading that shared array can leave index changed. No currentFontAsset
   write occurs here. On miss, a nonempty base-font fallback table is tried with true,
   but sourceFontAsset is STILL the supplied font (IL_00ab ldarg.2). This hit returns
   without the direct-hit material reset.
3. Try the component sprite asset, global font fallback list, default font, default
   sprite, in that order, each with true; finally return null. Sprite/default asset
   guards use Unity Object inequality. Global fallback list also receives supplied
   sourceFontAsset. Repeated settings getter calls are not snapshots. Settings/sprite
   bodies are unread here; retain the earlier missing-Settings failure boundary.

No local Unicode validation/case conversion, source unicode write, glyph inspection,
shaping, layout or rendering occurs in the entry body. It does not itself initialize
the out bool; dependency calls may change it. No selected body has a local handler,
rollback or lock. Declaration resolution does not prove current inputs/resources.

The single-font wrapper creates/clears shared static k_SearchedAssets only for true,
then delegates all parameters to the private internal lookup. False skips initialization
and clearing. This wrapper does not itself initialize the out flag or reject null fonts.

The seven-argument list wrapper first sets the out flag false, then returns null for
null/empty lists BEFORE shared-search reset. For true it creates/clears that same static
set. It caches Count once and iterates in order, skipping Unity-null candidates.
For each other candidate, sourceFontAsset.FallbackSearchQueryLookup.Add(candidate ID)
runs and its bool is popped. Internal lookup runs regardless of that Add result.
There is no wrapper-level duplicate rejection; internal recursion/cycle handling is
unread. A missing source/query set can fail after earlier out/static/ID mutations.
No list snapshot or local concurrent-mutation/reentrancy protection is established.

TMP_Asset.get_instanceID calls UnityEngine.Object.GetInstanceID only when cached
m_InstanceID is zero, stores the return, then returns the field. Thus comparison and
query recording can change font asset caches. Exact Object.GetInstanceID resolves to
UnityEngine.CoreModule.dll (SHA256
`32572aef39e4e9b2cd1b732d0e01998874993344c5682662fad513a3e7e49658`),
IL/hasBody=true, nonvirtual/genericArity0/no explicit override. Its body is unread here;
this is a managed boundary, not proof of native behavior. Two accepted Object comparison
bodies are reused by exact declaration/module/body-container hashes, without rereading.

## Reproduction and next boundary

```text
python3 -B localization/source/bgdatabase-20261027/bio-tmp-text-element/verify_text_element.py --output localization/source/bgdatabase-20261027/bio-tmp-text-element/<new-output-directory>
```

`metadata-verified/verification.json` passed after correcting one local expected
per-body count error (initial failed assertion retained in verification-history.json).
239 instructions,25 resolved method operands,27 fields,11 opaque runtime operands,
11 unique direct declarations,0 handlers. All901 retained unique files verify,
including150 original DLLs and25 phase101 files. Frozen InspectMethods/BackingScopes
readers, all their bin dependencies and actual loaded Cecil parity are pinned; no
reader rebuild, original code execution, mock, resource decoding, game/GUI/preview,
images, translation or Git mutation. The initial partial metadata-readback is preserved
as a failed verification attempt, never as a passed receipt.

Next exact unread font-selection body, pinned in next-consumer.json:
`TMPro.TMP_Character TMPro.TMP_FontAssetUtilities::GetCharacterFromFontAsset_Internal(System.UInt32,TMPro.TMP_FontAsset,System.Boolean,TMPro.FontStyles,TMPro.FontWeight,System.Boolean&)`.
Private/Static/HideBySig, IL/hasBody=true, nonvirtual/not new-slot/not final,
genericArity0/no explicit overrides, same original TMP module/hash. Resolve only
indispensable new dependencies and pin the actual glyph/font/native boundary after
reading it. Do not substitute another overload or GenerateTextMesh/resource decoding.
Other unread helpers remain explicit in consumer-boundaries.json.

Previous README/CHECKPOINT bytes are archived exactly; existing checkpoint sections,
including preliminaryEditorial/russianActualPreview/parallelLocaleDrafts/localeStatus,
are preserved. Separate guarded summary writes are not transactional. Parent alone owns
Git/index/HEAD and integrates exact manifest hashes; this worker has no Git mutations.
Authorized asset/editorial/Japanese lanes and actual preview remain independent/read-only;
none were stopped, automated or used as a blocker. Usage is unknown to this worker.

Retain all phase79–101 source/GetState/formatter/null-GUID/participant/cache/Transform/
typed-Lua/fallback/reset/singleton/table/reentrancy/serialized-state/native-selection/
conditional-panel/write/coroutine/notification/queue/pre-render/parser/style/resource
limits. Conditional panel3633/TMP4571 is not live selection. Actual controller/DB/Lua/
metatables/language/loading/save/global scripts/callbacks/BIO/reachability, d__109/d__104
MoveNext,color accessors,concrete typewriter/notifications/dirty callbacks,font3323/
material7 remain unaccepted. Complete source/special-scene/runtime manifest,serializer/
nonlinear restore,Quest ordering/reflection/initial-unlock/counter,universal full semantic/
independent diff/delta,final fonts/licenses/resources/runtime/visual/delivery remain pending.
Conditional12246 values/copy,24492 occurrences,16 actor IDs,126 registrations/114 entries
do not prove live selection. Accepted10/15/47/48 visuals/50 route unchanged;spawn/other3
intros/notebook/Bucky open. No53 replay/no54. No frozen source/glossary/inventory/config,
asset/editorial/job/preview or older-helper edits. No source,renderer or editorial gate
passes from this bounded metadata trace.
