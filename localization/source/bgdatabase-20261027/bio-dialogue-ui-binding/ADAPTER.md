# Original direct dialogue UI binding

Phase0090 is static text-only work in canonical Forest. Actual ancestor options
verify gpt-6.1-sol/high/OpenAI. Parent alone owns Git/index/HEAD and integrates these
artifacts. No game assembly execution, game/GUI/image input, translation, overlay,
agent/model/CLI nesting or Git mutation occurred. Parallel asset/editorial/Japanese
lanes and the actual Russian preview remain independent and untouched.

## Direct original resource facts

Phase89's original manager displaySettings.dialogueUI `(fileID0,pathID744)` binding
is reused by hashes. The unchanged header-aligned `tools/extract_assets.py` reader
now reads that original GameObject and its six exact components, only:

| Path ID | Original declared identity | Raw bytes | Whole frozen export parity |
| --- | --- | ---: | --- |
| 744 | GameObject, OverworldDialogueCanvas | 111 | yes |
| 2454 | UnityEngine.RectTransform | 120 | no frozen export |
| 2220 | UnityEngine.Canvas | 55 | no frozen export |
| 3796 | UnityEngine.UI.CanvasScaler | 80 | yes |
| 3797 | TheForestOfLove.FollowUICamera | 32 | yes |
| 4193 | TheForestOfLove.UI.AutomaticDepthSortUI | 40 | yes |
| 4110 | TheForestOfLove.DialogueSkipProgressIndicator | 32 | yes |

All seven raw hashes/byte counts match the pinned inventory; all six components'
GameObject pointers return to744. Local component/UI pointers use fileID0, the same
sharedassets0.assets. The two native types have original decoded structures and
raw-identity checks, not invented export parity. No transform hierarchy was dumped.

The four script pointers use fileID1, whose actual external mapping is
`globalgamemanagers.assets`. Each exact MonoScript is read from that original file;
raw hash, bytes, declared class/namespace/assembly and full frozen script export all
match. These are external mappings, not same-file path IDs. The original file hash
is checked against the frozen source-files manifest.

The first resource attempt rejected an incorrect resources.assets mapping assertion.
An exact external-path probe established globalgamemanagers.assets. The revised
recipe pins/verifies that dependency and succeeds in readback-v2. The failed recipe,
baseline and outcome remain in attempts.json; no original files were changed.

## Consumer selection and its limits

Metadata-only reads establish complete base chains and transitive interfaces of
these six direct types. None implements PixelCrushers.DialogueSystem.IDialogueUI;
none is a legacy Text/TMP/AbstractDialogueUI subtype. Inherited IEnumerable on
RectTransform is a positive control for traversal. Every resolved module path/hash
matches an original pinned Managed DLL. The small DirectTypes helper exists only
because the unchanged InspectMethods helper does not print interfaces. It reads
metadata using Mono.Cecil and never loads game assemblies for execution.

DisplaySettings.dialogueUI is declared **GameObject**. GetDialogueUI validates its
cached interface and returns it. ValidateCurrentDialogueUI uses a managed reference
test: an existing nonnull cached interface bypasses selection. Otherwise it calls
GetDialogueUIFromDisplaySettings, conditionally loads the default, and may write the
selected MonoBehaviour's GameObject back to settings. The default identity and live
cache are not established here.

For a nonnull settings GameObject, GetDialogueUIFromDisplaySettings calls IsPrefab.
The nonprefab route calls native GetComponentInChildren(Type) with IDialogueUI and
casts its result. The prefab route instantiates the GameObject, performs the same
native child-interface search and handles missing/result type branches. No fixed
one of the six direct components is the requested interface consumer.

Tools.IsPrefab consults native null comparison, activeInHierarchy, transform parent,
parent activeSelf and FindObjectsOfType. Serialized active/enabled booleans cannot
select the live branch or prove activation, object selection, dispatch or rendering.
The absence of a direct IDialogueUI on these six types does not establish that the
game lacks a dialogue UI, nor that default loading occurred.

The original RectTransform2454 has exactly one child pointer `(0,2447)`. Only that
next inventory identity is pinned in metadata-readback/next-consumer.json. Its
original child transform, direct GameObject/components and actual interface consumer
remain unresolved. Follow this one dependency next; do not repeat language/table
metadata or broadly scan the hierarchy. No legacy Text/TMP renderer is accepted.

## Reproduction and evidence

Use NEW directories within this supplement:

```text
.venv-assets314/bin/python -B localization/source/bgdatabase-20261027/bio-dialogue-ui-binding/verify_binding.py --output localization/source/bgdatabase-20261027/bio-dialogue-ui-binding/<new-resource-directory>
dotnet build localization/source/bgdatabase-20261027/bio-dialogue-ui-binding/DirectTypes.csproj --nologo --verbosity quiet
.venv-assets314/bin/python -B localization/source/bgdatabase-20261027/bio-dialogue-ui-binding/verify_metadata.py --output localization/source/bgdatabase-20261027/bio-dialogue-ui-binding/<new-metadata-directory>
```

readback-v2 verifies19 frozen pins,7 helpers,10 original source files, all150 original
Managed DLLs with filename-set parity and92 prior/input files. Prior metadata/source
computations are retained by hashes, not rerun. The earlier12246 values/copy,24492
occurrences,16 actor IDs,126 registrations and114 entries remain conditional evidence.
metadata-readback reproduces11 exact metadata selections and six method bodies,
checks six complete type/interface chains, native-selection boundaries and the sole
next child pointer. No dependency is mocked; the unexecuted game/native lifecycle
boundary remains explicit. Reproducibility hashes bind recipes, inputs and outputs.

README/CHECKPOINT prior bytes are archived exactly. Their updates are separate
writes, not a transaction. summary-preservation.json checks every previous section
except the explicitly changed current summary fields, including preliminaryEditorial,
russianActualPreview, parallelLocaleDrafts and localeStatus. Parent receives an exact
project-relative integration manifest; worker usage is unknown and parent-measured.

Preserve79 GetState order,80/81 formatting limits,82 scene-null-GUID constraints,
83 participant/cache/selected-ID/Transform distinctions,84 typed Lua/fallback and
85–89 reset/script/singleton/callback/table/cache/reentrancy/serialized-state caveats.
Actual controller/DB/Lua/metatables/language/loading/save/global scripts/callbacks/
lifecycle/delivery/rendering/BIO/reachability remain unaccepted. Complete source and
special scenes/runtime manifest, serializer/nonlinear restore, notification/rendering,
Quest ordering/reflection/initial-unlock/counter, universal semantic/independent
diff/delta, final fonts/licenses/resources/runtime/delivery remain pending. Accepted
10/15/47/48 visuals and50 route remain unchanged; spawn/other3 intros/notebook/Bucky
stay open. No53 replay/no54, preview interaction, publication/deployment/server work.
