# Original single child dialogue UI consumer

Phase0091 is static, text-only work in canonical Forest. The actual ancestor CLI
options verify gpt-6.1-sol/high/OpenAI with user configuration ignored and no fallback.
Parent alone owns Git/index/HEAD. No agents, nested model/CLI jobs, original game
assembly execution, game/GUI/images, authored translation or target overlay occurred.
All asset/editorial/Japanese lanes and the actual Russian preview remain independent
and untouched. Worker usage is unknown; parent measures it.

## Original child and direct components

Phase90's sole child pointer from RectTransform2454 is retained by hashes. The
unchanged header-aligned extract_assets reader now reads original2447 and follows
only its direct GameObject737 and five component entries (including2447 itself):

| Path ID | Original declared identity | Raw bytes | Whole frozen export parity |
| --- | --- | ---: | --- |
| 2447 | UnityEngine.RectTransform | 228 | no frozen export |
| 737 | GameObject, VN Template Standard Dialogue UI | 107 | yes |
| 3926 | PixelCrushers.DialogueSystem.Wrappers.StandardDialogueUI | 236 | yes |
| 3664 | TheForestOfLove.KeyTriggerHelper | 88 | yes |
| 3870 | TheForestOfLove.DialogueCanvasNarratorLayoutController | 104 | yes |
| 4311 | TheForestOfLove.DialogueNameplateController | 104 | yes |

These six objects total867 raw bytes. Original2447 points back to parent2454 and
to GameObject737; all four MonoBehaviours point back to737. The ten stored child
transform pointers are retained in2447's decoded structure but none was followed.
Every selected raw identity/hash/byte count matches the pinned inventory. Native
RectTransform has no frozen export; exact raw identity and native decoded structure
are verified without inventing export parity.

Each MonoScript fileID1 resolves through the actual external mapping to original
globalgamemanagers.assets. Exact script targets5402,300,4746,1958 have original
raw identity and whole frozen-export parity. UI/component references fileID0 remain
within sharedassets0.assets. Names/path IDs alone are not external resolution.

## Identified interface consumer and dispatch boundary

The selected StandardDialogueUI wrapper3926 resolves to Auto-asmdef-FirstPass.dll.
Its full original chain is wrapper -> StandardDialogueUI -> CanvasDialogueUI ->
AbstractDialogueUI -> MonoBehaviour -> Behaviour -> Component -> UnityEngine.Object
-> System.Object. AbstractDialogueUI declares IDialogueUI; StandardDialogueUI adds
IStandardDialogueUI. All resolved chain module paths/hashes match original pinned
Managed DLLs. This establishes a stored descendant interface consumer of the
serialized root744, not an actual controller selection.

The wrapper declares only a constructor. Base StandardDialogueUI exposes the
typed StandardUIDialogueControls conversationUIElements field. Its ShowSubtitle
closes standardMenuControls before calling abstract subtitle-controls ShowSubtitle
through get_standardSubtitleControls. HideSubtitle uses the same getter and the
StandardUISubtitleControls HideSubtitle call. These are metadata instructions only;
controls initialization, concrete virtual dispatch, panel selection and delivery
have not run. Other three direct MonoBehaviour type/interface chains were not read;
no claim that3926 is the unique interface consumer in the whole hierarchy is made.

The UI wrapper derives from AbstractDialogueUI, not legacy Text or TMP. Nonnull
TMP-named fields on the custom controllers, and the alert wrapper's m_uiText field,
are stored references; their target bytes/renderers were not followed or accepted.
No legacy/TMP subtitle renderer is established by this phase.

Phase90's cached-interface/native-child-search distinction still applies. Existing
managed cache can bypass settings selection; prefab clone, default fallback and
settings writeback remain conditional. Serialized m_IsActive/m_Enabled and the
stored hierarchy do not prove native search success, instantiation, activation,
selected live object, lifecycle or rendering.

## Exact next dependency

Original3926 stores conversationUIElements.defaultNPCSubtitlePanel=(fileID0,pathID3633),
also subtitlePanels[0]. Only its inventory identity is pinned in
metadata-readback/next-consumer.json: StandardUISubtitlePanel wrapper,256 bytes.
Its original bytes and renderer have not been read. The other stored defaults do
not establish a selected panel either.

Next trace StandardUIDialogueControls.get_standardSubtitleControls and the exact
abstract/concrete ShowSubtitle panel-selection path. Then read original3633 and
only indispensable direct bindings. A default pointer must remain distinct from
the actual selected panel. Do not traverse2447's ten-child hierarchy or rescan tables,
languages, controller/root metadata or source candidates.

## Verification and reproduction

```text
.venv-assets314/bin/python -B localization/source/bgdatabase-20261027/bio-dialogue-ui-child/verify_binding.py --output localization/source/bgdatabase-20261027/bio-dialogue-ui-child/<new-resource-directory>
dotnet build localization/source/bgdatabase-20261027/bio-dialogue-ui-child/ChildType.csproj --nologo --verbosity quiet
.venv-assets314/bin/python -B localization/source/bgdatabase-20261027/bio-dialogue-ui-child/verify_metadata.py --output localization/source/bgdatabase-20261027/bio-dialogue-ui-child/<new-metadata-directory>
```

The resource readback verifies19 frozen pins,7 unchanged helpers,10 original source
files, all150 Managed DLLs including filename-set parity, and141 prior/input files.
Earlier source/metadata computations are retained by hashes, not replayed. Prior
12246 values/copy,24492 occurrences,16 actor IDs,126 registrations and114 entries
remain conditional evidence, not live names or delivery acceptance.

The metadata readback reproduces seven successful selections, three method bodies
and the complete single selected type/interface chain. The narrow ChildType helper
uses Mono.Cecil metadata only, reusing the existing six-type helper's algorithm with
one new exact selection; existing helpers remain byte-identical. .NET SDK8.0.131,
source/binary/dependency hashes and reproduction outputs are pinned. bin/obj are
ignored; reproduce by rebuilding at the canonical path. No dependency is mocked;
the original game/native lifecycle and renderer boundaries remain unexecuted.

The first receipt preparation rejected quoted ps config values before resource
read; parsing the options with shlex repaired the receipt. Two metadata selections
then rejected an assumed Assembly-CSharp-firstpass.dll location. The resolved type
chain established actual Auto-asmdef-FirstPass.dll; corrected, changed-input selections
succeeded. Empty failed outputs, exit/stderr and initial selections remain in
il-commands.json and attempts-metadata.json. They are not successful metadata reads.

Previous README/CHECKPOINT bytes are archived exactly. Current summary writes are
separate operations, not a transaction. summary-preservation.json verifies every
old checkpoint section except current nextAction/updatedAt, plus the four required
parallel/editorial/preview/locale sections. The new supplement is added separately.
The parent receives exact project-relative hashes; this worker does not integrate Git.

Preserve79 GetState order,80/81 formatter bounds,82 scene-null-GUID limits,
83 participant/cache/selected-ID/Transform distinctions,84 typed Lua/fallback and
85–90 reset/script/singleton/callback/table/cache/reentrancy/serialized-state/native
child-selection caveats. Actual controller/DB/Lua/metatables/language/loading/save/
global scripts/callbacks/lifecycle/delivery/rendering/BIO/reachability stay unaccepted.
Complete source/special-scene/runtime manifest, serializer/nonlinear restore,
notification/rendering, Quest ordering/reflection/initial-unlock/counter, universal
semantic/independent diff/delta, final fonts/licenses/resources/runtime/delivery remain
pending. Accepted10/15/47/48 visuals and50 route are unchanged; spawn/other3 intros/
notebook/Bucky remain open. No53 replay/no54, publication/deployment/server work.
