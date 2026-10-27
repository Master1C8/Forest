# Subtitle panel selection and one original TMP consumer

Phase0092 is text-only, metadata/original-resource work. The actual ancestor CLI
option prefix, parsed with shlex before the prompt, pins gpt-6.1-sol/high/OpenAI
with ignore-user-config. No Astra/fallback, agents, nested model/CLI jobs, game
assembly execution, GUI/images, translation/overlay or Git mutation. Parent owns
Git/index/HEAD and integrates these exact artifacts. All locale asset/editorial
lanes, Japanese and the running Russian preview remain independent and untouched.
Usage is unknown here; parent measures it.

## Concrete dispatch and selection

The StandardUIDialogueControls getter simply returns m_standardSubtitleControls.
Its constructor creates StandardUISubtitleControls; Initialize passes the stored
array and NPC/PC defaults to those controls. Subtitle Initialize copies the array,
uses a nonnull supplied default or first builtin/null, sets default flags and
builtin indices, then calls ClearCache (its body was not inspected). This is a
conditional managed initialization route, not evidence that it ran on a live UI.

StandardUISubtitleControls derives AbstractUISubtitleControls and overrides
ShowSubtitle without calling the abstract implementation. Preserve this distinction:
the abstract empty-text/currentSubtitle/SetSubtitle/Show logic does not describe
the concrete override. The metadata verifier asserts both routes separately.

Concrete ShowSubtitle returns for a null Subtitle before calling GetPanel. For
other inputs GetPanel checks, in order:

1. Forced nonnull override panel.
2. A formatted-text panel index satisfying 0 <= index < builtin count, with
   actorOverridingPanel assigned to the speaker Transform.
3. The actor-ID override dictionary, also assigning the speaker Transform.
4. The speaker Transform route with an isNPC-dependent NPC/PC default fallback.

GetPanel itself returns defaultNPC for null input, but the concrete ShowSubtitle
null guard prevents that call on its null path. The Transform route can return
the default for a null Unity Transform. Otherwise it uses DialogueActor/panel
caches, native actor lookup, cached/new Bark UI, actor custom/numbered panel,
then fallback; a result may be cached. GetPanelFromNumber handles enum Default0,
UseBarkUI1 and Custom2 explicitly; builtin enums start at Panel0=3 and use unread
PanelNumberUtility.GetSubtitlePanelIndex. Actual dictionaries, Unity equality,
actor state, native queries and live selections are not executed or accepted.

ShowSubtitle selects before testing Bark UI, missing panel and empty text. Bark
UI calls BarkString with text, speaker/listener Transforms and sequence, then
returns. A selected panel with empty text goes to HideSubtitle. The normal route
maintains focus/history, can prefix the speaker Name using the panel format and
can alter subtitle color, then calls panel.ShowSubtitle and SupercedeOtherPanels.
No particular live state or callback effect is established by these instructions.

## Original panel and direct text binding

Only sharedassets0.assets:3633 and its direct subtitle text target4571 were read;
their two exact MonoScripts were resolved through the original externals table.

| Object | Identity | Raw bytes | Whole frozen export |
| --- | --- | ---: | --- |
| 3633 | Wrappers.StandardUISubtitlePanel, Auto-asmdef-FirstPass.dll | 256 | equal |
| 4571 | TMPro.TextMeshProUGUI, Unity.TextMeshPro.dll | 640 | equal |

Panel script(fileID1,pathID5405) resolves globalgamemanagers.assets:5405; text
script(fileID1,pathID5630) resolves globalgamemanagers.assets:5630. Both original
MonoScripts match raw identity and full frozen exports. fileID0 means the same
sharedassets0.assets, not a guessed cross-file ID.

Original3633 subtitleText is a PixelCrushers.UITextField: m_uiText is null,
m_textMeshProUGUI is(fileID0,pathID4571). Its wrapper declares only a constructor;
base ShowSubtitle can defer through a coroutine while panels close, otherwise
ShowSubtitleNow activates UI, opens/focuses and calls virtual SetContent, then
clears actor override. SetContent and UITextField write dispatch are not read yet.
Stored addSpeakerName0, accumulateText0, delayTypewriterUntilOpen0, waitForClose0
and empty persistent event lists do not prove current live state or delivery.

Original4571 has stored font size14, autosizing0, wrapping1, richText1, RTL0,
font(fileID0,pathID3323) and shared material(fileID0,pathID7). Its stored test
string is retained as original resource data, not accepted as runtime-visible
source and not added to the frozen inventory. Font/material targets, portrait
name3695, other panels, GameObjects/components and child2447's hierarchy were not
followed. No glyph/font/corpus/layout/visual acceptance follows from a TMP identity.

## Verification and reproduction

```text
.venv-assets314/bin/python -B localization/source/bgdatabase-20261027/bio-subtitle-panel-selection/verify_panel.py --output localization/source/bgdatabase-20261027/bio-subtitle-panel-selection/<new-panel-directory>
.venv-assets314/bin/python -B localization/source/bgdatabase-20261027/bio-subtitle-panel-selection/verify_text.py --output localization/source/bgdatabase-20261027/bio-subtitle-panel-selection/<new-text-directory>
.venv-assets314/bin/python -B localization/source/bgdatabase-20261027/bio-subtitle-panel-selection/verify_metadata.py --output localization/source/bgdatabase-20261027/bio-subtitle-panel-selection/<new-metadata-directory>
```

All17 new selections/16 method bodies reproduce byte-exactly using the unchanged
InspectMethods/Mono.Cecil helper and .NET SDK8.0.131. Original resource outputs
also reproduce byte-exactly (four files including both verifications). Checks
verify19 frozen pins,7 unchanged helpers,10 installed resources,150 DLLs including
filename-set parity, and183 prior inputs. Earlier table/source/manager/root/child
computations are retained by hashes rather than replayed. Source, helper binary,
dependency and output hashes are pinned. No dependency was mocked; original
managed execution and native lifecycle/rendering boundaries remain unexecuted.

Regression: an abstract callvirt operand must not be mistaken for execution of
that abstract type's implementation. Inspect the identified concrete override
before asserting ordering/guards or default selection. A stored default, null
GetPanel fallback and null ShowSubtitle guard have distinct semantics. The
reproduction verifier checks this distinction and the selection/mutation order.

Previous README/CHECKPOINT bytes are archived exactly. Current summary writes
are separate operations, not a transaction; summary-preservation verifies every
previous section except nextAction/updatedAt and the four required parallel,
editorial, preview and locale sections. Parent receives exact project-relative
SHA256 bindings. No Git operation is delegated to this worker.

## Next bound and retained gates

Trace exact StandardUISubtitlePanel.SetContent in Auto-asmdef-FirstPass.dll and
its actual UITextField/format/typewriter write route, resolving modules from
metadata. next-consumer.json pins this method and unread font3323/material7
inventory identities. Follow an original resource only when that trace needs
its direct pointer. Do not broaden to hierarchy, other panels, scenes or saves.

Retain79 GetState order,80/81 formatter bounds,82 scene-null-GUID limits,
83 participant/cache/selected-ID/Transform distinctions,84 typed Lua/fallback,
85–89 reset/script/singleton/callback/table/cache/reentrancy/serialized-state
limits,90 cached-interface/native-selection and91 inherited stored consumer
versus actual UI/panel/renderer selection. Current panel/TMP bytes add a stored
consumer binding, not live native selection, initialized controls or text writes.
Actual controller/DB/Lua/metatables/language/loading/save/global scripts/callbacks/
delivery/rendering/BIO/reachability remain unaccepted. Complete source/special-scene/
runtime manifest, serializer/nonlinear restore, notification/rendering, Quest
ordering/reflection/initial-unlock/counter, universal semantic/independent diff/
delta, final fonts/licenses/resources/runtime/delivery remain pending. Accepted
10/15/47/48 visuals and50 route unchanged; spawn/other3 intros/notebook/Bucky open.
No53 replay/no54, publication, deployment or server work.
