# Subtitle content write through the original TMP property

Phase0093 is bounded text-only metadata work in the canonical Forest checkout.
The actual ancestor CLI option prefix pins gpt-6.1-sol/high/OpenAI with
ignore-user-config. No Astra/fallback, nested model/CLI jobs or agents were used.
Parent alone owns Git/index/HEAD. Asset/editorial/Japanese lanes and the running
Russian preview remain independent/read-only. No original game code execution,
resource decoding, game/GUI/images, translation, overlay or Git mutation occurred.
Worker usage is unknown; parent measures it.

## Conditional managed content path

The original Auto-asmdef-FirstPass.dll StandardUISubtitlePanel.SetContent returns
for a null Subtitle. Otherwise it sets currentSubtitle and calls the still-unread
CheckSubtitleAnimator before portrait handling and the subtitle content write.
Portrait setters/native calls can also intervene; this phase does not establish
successful completion or follow portrait resources.

The subtitle path then performs these operations:

1. StopTyping(subtitleText).
2. Choose an empty prefix/fromIndex0 when accumulateText is false, or the saved
   accumulated string and its length after rich-text/TMP/RPG-code stripping.
3. SetFormattedText(subtitleText, prefix, subtitle.formattedText).
4. When accumulating, save the getter's current text plus a newline.
5. When delayTypewriterUntilOpen is true and the panel lacks focus, start the
   StartTypingWhenFocused coroutine; otherwise call StartTyping immediately.
6. Store the current frameCount after those calls.

The coroutine factory captures panel/text/fromIndex in exact nested type
StandardUISubtitlePanel/<StartTypingWhenFocused>d__104. Its MoveNext body is
unread; the factory alone does not prove when it runs or resumes. Original panel
3633 stored accumulateText0/delayTypewriterUntilOpen0, but mutable live state is
unexecuted. Accumulation stripping bodies and frame/focus/native behavior are not
accepted by this trace.

SetFormattedText concatenates the prefix with UITools.GetUIFormattedText. That
formatter returns empty for null input, wraps text in <i>...</i> for italic, and
otherwise returns its text. The caller writes before notifying, saving the
original color if necessary, and setting either original color or first-emphasis
color. A null formatter result path is not a successful full SetFormattedText
path: subsequent emphases access still dereferences the FormattedText object.
UITextField color accessors and formatter property accessors remain uninspected.

## Exact text dispatch and original stored binding

UITextField getters return the stored fields. get_text prefers a nonnull TMP
component, then legacy Text, then empty. In contrast, set_text independently tests
and writes TMP followed by legacy Text: it can write both if both are present.
Do not describe the setter as a TMP-or-legacy fallback.

The previously verified original panel3633 has legacy null and TMP4571 in its
subtitleText. Conditional on selecting that panel, preserving those bindings and
reaching its write, UITextField dispatches to TMP_Text.set_text on original
TextMeshProUGUI4571. The direct operand's metadata scope resolves to original
Unity.TextMeshPro.dll, SHA256
775eab21aef1558df02968234ce1e506c2685c95813ba7cbb89e8f3e9102c483.
Exact declared-method inspection proves TextMeshProUGUI declares neither get_text
nor set_text; its base TMP_Text declares both virtual properties. This distinguishes
static operand resolution from the relevant concrete inherited implementation.
The original panel/text resource outputs were retained by hashes, not decoded again.

TMP_Text.set_text returns early only when the backing string is not dirty and
both old/new strings are nonnull, equal-length and equal. Otherwise it clears the
backing-string dirty flag, assigns m_text, sets input source3 and properties-changed,
then calls virtual Graphic.SetVerticesDirty and SetLayoutDirty. Their concrete
implementations and native scheduling/mesh/font/layout/rendering remain unread.
get_text may call unread InternalTextBackingArrayToString when the backing array
is dirty, otherwise it returns m_text. A managed string assignment is not rendered
text or final font/corpus acceptance.

## Notifications and typewriter bounds

The exact UITextField overload of SendTextChangeMessage selects its GameObject
(TMP first, legacy second) and calls native GameObject.SendMessage("OnTextChange",
UITextField, options1) if nonnull. The separately emitted legacy Text overload
uses a cached/global AbstractDialogueUI and parent lookup. It is not this call's
route. Actual receivers/reentrancy/native delivery remain unexecuted.

TypewriterUtility.GetTypewriter requests AbstractTypewriterEffect by native
GetComponent on TMP, then tries legacy Text if no effect was found. StartTyping
and StopTyping require a nonnull enabled effect before virtual dispatch. No
concrete effect/component, callback outcome or letter visibility is established.
No GameObject/components/hierarchy, portraits, other panels, font3323/material7
or scene/save/table/language/manager/root/source candidate was traversed.

## Reproduction and regression

```text
python3 -B localization/source/bgdatabase-20261027/bio-subtitle-content/verify_content.py --output localization/source/bgdatabase-20261027/bio-subtitle-content/<new-output-directory>
```

The verifier first checks inherited pins and original DLL filename-set parity,
then builds the small new metadata-only DependencyScopes helper, verifies its
source/binary/dependencies, reruns10 exact selections/16 method bodies using
unchanged InspectMethods/Mono.Cecil, and reproduces64 direct PixelCrushers/TMP
operand resolutions plus the exact renderer property declaration chain. All
11 substantive outputs reproduce byte-exactly. The helper resolves only selected
method operands and the known renderer property chain; it is not a game runner
or a general discovery framework. No dependency was mocked.

Checks retain183 prior input files,65 previous supplement files,19 frozen pins,
7 owning helpers,7 process references,10 installed resources and150 original DLLs.
Regressions distinguish dual independent writes from preferred getter fallback,
the precise notification overload, static operand resolution from concrete
inherited property dispatch, conditional enabled native effect selection, and
managed invalidation from actual rendering.

Previous README/CHECKPOINT bytes are archived exactly. Summary writes are separate
operations, not a transaction. Preservation checks compare every old checkpoint
section except updatedAt/nextAction and verify all historical README bytes remain.
Parent receives exact file hashes for integration; this worker performs no Git work.

## Next bound and retained gates

Next inspect CheckSubtitleAnimator and currentSubtitle accessors before the write,
then the concrete TextMeshProUGUI SetVerticesDirty/SetLayoutDirty implementations
and indispensable directly called registration methods, resolving modules from
metadata. Pin the next native/resource boundary rather than traversing hierarchy.
Keep <StartTypingWhenFocused>d__104.MoveNext, color accessors, concrete typewriter,
font3323/material7 and notification receivers explicitly unread until needed.

Retain79 GetState order,80/81 formatter bounds,82 scene-null-GUID limits,
83 participant/cache/selected-ID/Transform distinctions,84 typed Lua/fallback,
85–89 reset/script/singleton/callback/table/cache/reentrancy/serialized-state limits,
90 cached-interface/native selection,91 inherited UI versus live selection and
92 concrete subtitle selection/stored panel/TMP versus initialized live state.
Actual controller/DB/Lua/metatables/language/loading/save/global scripts/callbacks/
delivery/rendering/BIO/reachability remain unaccepted. Complete source/special-scene/
runtime manifest,serializer/nonlinear restore,notification/rendering,Quest ordering/
reflection/initial-unlock/counter,universal semantic/independent diff/delta,final
fonts/licenses/resources/runtime/delivery remain pending. Accepted10/15/47/48
visuals/50 route unchanged; spawn/other3 intros/notebook/Bucky open. No53 replay/
no54,publication,deployment or server work.
