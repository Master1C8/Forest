# Scheduled Canvas rebuild and concrete TMP pre-render path

Phase0095 is bounded original metadata work in canonical Forest. Parent alone
owns Git/index/HEAD. Parallel asset/editorial/Japanese lanes and the actual Russian
preview remain independent/read-only. No agents, nested model/CLI, game assembly
execution, original resource decoding, game/GUI/images, overlay or Git mutation.
Actual ancestor options verify gpt-6.1-sol/high/OpenAI/ignore-user-config. Prompt
tokens following the known final option/value were never parsed or emitted.
Worker usage is unknown; parent measures it.

## Registry dispatch and cleanup

CanvasUpdateRegistry.PerformUpdate is the exact delegate target pinned in phase94.
After profiling and invalid-item cleanup, it sets the layout flag, sorts the queue
and dispatches stages0–2 (Prelayout/Layout/PostLayout). LayoutComplete and Clear
precede flag reset. ClipperRegistry.Cull intervenes before the graphic flag and
stages3–4 (PreRender/LatePreRender), then GraphicUpdateComplete/Clear/flag reset.
Queue counts are read during iteration; this is not a snapshot or callback isolation.
Sort calls List.Sort and repairs dictionary indices; comparison semantics unread.

Exactly two System.Exception catches protect selected element processing. Layout
item lookup precedes its try; graphic lookup is inside its try. Catch logging uses
transform (and graphic logging re-fetches the item). Completion/cleanup/cull/Clear
and resets have no finally protection. No successful final cleanup is guaranteed.

CleanInvalidItems iterates backwards. Managed-null entries are removed; entries
whose IsDestroyed returns true are removed and then receive completion. The separate
ObjectValidForUpdate uses managed nonnull and Unity inequality for Unity wrappers;
it has no active-state test. Exact conditional TMP IsDestroyed inherits the final
UIBehaviour method returning Unity equality with null. Native object validity remains
unexecuted. IndexedSet.RemoveAt swaps the tail into a non-tail removal and updates
its dictionary index. Clear calls List.Clear then Dictionary.Clear; no transaction
or exception rollback is established.

## Concrete renderer, not interface/base operands

TextMeshProUGUI declares the Rebuild override itself, without a new slot/base call.
Unity-null returns. Prelayout optionally calculates preferred values with infinite
dimensions and assigns RectTransform.sizeDelta. PreRender calls the exact private
OnPreRenderCanvas, then conditionally invokes the concrete UpdateMaterial override
and clears material dirty. Other stages return. The Rebuild body has no cull guard;
deeper culling remains unread. Conditional TMP completion methods inherit Graphic's
ret-only bodies; other queue element types are not substituted with those bodies.

OnPreRenderCanvas requires awake and active-or-ignore-active, a cached/resolved
Canvas and nonnull font asset. Missing font warns and returns. Properties/layout
dirty gates optional concrete UpdateMeshPadding, exact TMP_Text.ParseInputText
and queued font-feature updates. Those bodies remain unread. Autosize setup and
properties/layout/ignore-active flag resets occur before the generation loop.
GenerateTextMesh repeats until its completion flag becomes true, incrementing the
counter after each successful return. No explicit iteration cap/finally appears
in this caller; the unread generator may impose bounds. Cleared dirty flags do
not establish completed generation or rendering after an intervening failure.

Concrete UpdateMaterial returns for null shared material or returned renderer.
Otherwise it sets native CanvasRenderer.materialCount=1, obtains virtual
materialForRendering and calls native SetMaterial(Material,Int32) with index0.
Both native declarations resolve original UnityEngine.UIModule.dll and have
InternalCall/no managed body. Exact materialForRendering and UpdateMeshPadding
overrides, plus GenerateTextMesh declaration, are pinned without reading their
bodies. No original Canvas/GameObject/font/material resource was decoded.

## Exact overload recipe and reproducibility

```text
python3 -B localization/source/bgdatabase-20261027/bio-canvas-rebuild/verify_rebuild.py --output localization/source/bgdatabase-20261027/bio-canvas-rebuild/<new-output-directory>
```

Frozen InspectMethods selects by method name, so SetMaterial initially exported
the unrelated Material/Texture wrapper too. Its raw export and4 extra resolved
operands remain explicit discovery evidence. The new recipe projects exact native
signatures and filters CanvasScopes by those same signatures. A regression checks
both raw overload presence and exclusion of the Texture wrapper from the selected
trace. Do not infer a texture route from that incidental export.

Ten exact selections reproduce16 declarations (14 managed bodies,2 native),
67 selected method operands,8 dispatch chains and2 exception handlers. Sixteen
substantive outputs reproduce byte-exactly, including discovery/projection controls.
Assertions inspect actual original metadata/IL, not mocked or executed game code.
An initial helper launch failed before build completion was reconciled; its rc1
is retained in provenance with missing diagnostics, never counted as success.
Later launches followed verified build completion. No original assembly was run.

19 frozen pins/7 helpers/7 process references/10 installed source files/150 original
DLLs/183 inherited inputs/65 phase92/39 phase93/53 phase94 files retain hash parity.
Installed resources were hashed, not decoded. Prior README/CHECKPOINT bytes are
archived exactly. Summary writes are separate, not transactional; all historical
sections are preserved, including preliminaryEditorial/russianActualPreview/
parallelLocaleDrafts/localeStatus. Parent integrates exact path/hash handoff.

## Next boundary and remaining acceptance

Next inspect exact TMP_Text.ParseInputText in original Unity.TextMeshPro.dll,
especially inputSource3 from the retained setter and indispensable direct managed
preprocessing/backing-array conversion. Stop/pin the next native/resource boundary.
No full GenerateTextMesh dump, hierarchy, font/material decoding or runtime is needed
for that parsing step. Padding/font-feature/native material/get_canvasRenderer/
materialForRendering and actual generation remain open.

Retain79–94 source/GetState/formatter/scene-null-GUID/participant/cache/Transform/
typed-Lua/fallback/reset/singleton/callback/table/reentrancy/serialized-state/native
selection/conditional panel/write/coroutine/notification/dirty limits. Actual
controller/DB/Lua/metatables/language/loading/save/global scripts/delivery/rendering/
BIO/reachability and complete source/special-scene/runtime manifest are unaccepted.
Serializer/nonlinear restore,notification/rendering,Quest ordering/reflection/
initial-unlock/counter,universal semantic/independent diff/delta,final fonts/licenses/
resources/runtime/delivery remain pending. Accepted10/15/47/48 visuals/50 route are
unchanged; spawn/other3 intros/notebook/Bucky open. No53 replay/no54, publication,
deployment or server work. Static queue/rebuild knowledge passes no broader gate.
