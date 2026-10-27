# Original Subtitle input and callback trace

This append-only phase0079 supplement connects the original plugin's field selection,
Subtitle construction and local line callbacks to phase78's126 BIO registrations and
1103 original arc contexts. It contains no authored translation, new display inventory,
game execution, images or Git mutations. Parent owns integration. All parallel asset
and editorial lanes and the separate Russian preview remain independent and untouched.

`source-trace.json` records the exact findings and IL locators. `il-commands.json`
pins44 successful selections/56 bodies from the unchanged metadata inspector. The
installed game assemblies are read as metadata only. `execution-model.json` records
the actual current CLI launch with gpt-6.1-sol/high/OpenAI; no agents or nested requests.

## Selected fields and construction

`Field.Lookup` uses the first exact, case-sensitive title. Assigned fields must have a
nonempty value; whitespace counts. Dialogue localization uses a field named exactly
the current language. Menu and sequence localization use suffixed field names. Missing
or empty localized fields fall back to their base field; these selectors do not test
`useDefaultIfUndefined`. `subtitleText` uses nonempty current dialogue text, otherwise
current menu text. This is raw content before `FormattedText.Parse`.

Both frozen copies reproduce126 target registrations and1103 arc-first input records.
The targets have120 empty sequences and6 `None()` sequences;120 raw subtitles select
Dialogue Text and6 select Menu Text. All126 target registrations have positive actor
IDs and nongroup entries. A synthetic `ru` language parameter selects the same original
fields because these records have no assigned localized fields. This says nothing
about the actual runtime language or the separately translated preview.

`GetState` sends `OnPrepareConversationLine`, marks an entry displayed, and runs its
Lua/script and execution events before obtaining the raw text and sequence. The
`skipExecution` argument gates script/onExecute and scene events, not the prepare
message, displayed mark or Lua setup. Two target registrations share the same original
108:116 script `Variable["mouse/treeId"] = 777`; all original target onExecute persistent
call lists are empty. Runtime listeners and scene events remain unaccepted.

The constructor stores the selected values and original entry reference, then may
append `TextInput(...)` from a parsed input prompt. Model construction with initial
ID -1 alone applies the empty-sequence/empty-formatted-text `None()` fix. Explicit
initial IDs bypass it. Controller startup can subsequently change a first group state
with sequence exactly empty to nongroup `Continue()`; null is a separate case.

`FormattedText.Parse` has real Lua, variable, autocase, pipe, flag, picture, prompt,
position, panel and emphasis processing. Its helper outputs are pending. Neither the
raw fields nor an arc's cached first entry establish actual formatted Subtitle input.

## Callback boundary

`ConversationController.GotoState` installs current state and active record, performs
linked-conversation handling when needed, and returns early for group states. Its
nongroup path calls `StartSubtitle`.

`StartSubtitle` broadcasts `OnConversationLine` **before** checking visibility,
calling UI.ShowSubtitle, replacing `{{default}}`, preprocessing shortcuts or playing
the sequence. The begin handler can therefore receive a line never shown. A blank
sequence's default is passed to PlaySequence without storing it in Subtitle.sequence.
For a nonempty sequence, default substitution and shortcut replacement can change
the field later; `{{end}}` substitution is in the preprocessing return value.

The plugin broadcasts the same Subtitle to a valid speaker, a valid distinct listener,
then the manager. It does not deduplicate the manager against participant transforms
or overlapping hierarchies. DialogueSystemEvents forwards to its UnityEvents. The
service subscribes using one FindObjectOfType result without an explicit null guard;
removal performs another lookup with a nonnull check. Base lifecycle guards and the
subscription order are pinned, but actual selected instance, scene hierarchy,
persistent listeners, relative lifecycle execution and delivery remain unverified.

FinishSubtitle waits for Continue when required. Otherwise it stops an existing
sequencer, hides lastSubtitle, clears its one-shot notify flag, emits line-end only
when stored `_subtitle` is nonnull, then emits FinishedSubtitleHandler. The payload
is **lastSubtitle**, whereas `_subtitle` is only the gate. The plugin field-use scan
finds one `_subtitle` store in the shown branch and no clear. Thus, on a fresh view,
a first hidden line lacks that gate; a hidden line after a shown line can retain it.
This is conditional original control flow, not a runtime observation or unlock proof.

Phase78's begin handler still handles triggering before actor state. Its line-end
uses formatted text; direct builder preplay uses raw subtitleText. Under unchanged
inputs and a false spoken latch, the six explicit None targets bypass the actor
check and can reach the implicit line-end handler. Current Dialogue/Arc, previous
latch, mutation, callback success and story reachability remain unaccepted.

## Reproduction and limits

Run `execution-recipe.json` using a new output directory. The verifier checks19 frozen
pins,7 owning helpers, all previous supplement hashes including73 phase78 files,
9 installed resources/DLLs and every12246 candidate value in both frozen copies.
It also matches all7 freshly regenerated phase78 readbacks and re-runs44 original
metadata selections. The final5 outputs in `readback-v2/` and `readback-reproduced/`
are byte-identical. `readback/` is retained exploratory output before the final five
callback selections and finish controls; it is superseded.

The24 synthetic controls verify only Python transcriptions with supplied fields,
formatted outputs and event state. They replace the parser, Lua, Unity objects,
callbacks and renderer. No test here accepts those replaced boundaries.

Next is bounded source work on actual FormattedText helpers and the mutable prepare/
scene input boundary. Complete source/special-scene, runtime manifest, save/restore,
notification/rendering, universal editorial/diff/delta, final fonts/resources and
delivery remain pending. Existing accepted visuals10/15/47/48 and route50 retain
their exact prior scope; runtime53 is consumed, no54 is requested.

Previous README and CHECKPOINT bytes are archived without alteration. Current summary
updates preserve every locale row, preliminaryEditorial, russianActualPreview and
parallelLocaleDrafts. Worker token telemetry is unavailable; parent measures it.
