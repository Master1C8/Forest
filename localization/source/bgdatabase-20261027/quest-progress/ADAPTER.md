# Phase0068: Quest progress source and native details pane

Text-only static work with gpt-6.1-sol/high/OpenAI verified from current CLI argv.
No game launches, image input, target wording, agents or nested model jobs. Seven
owner-authorized asset lanes remain independent and read-only to this lane.

## Exact source and readback

This supplement reuses the phase0067 v5 envelope and Reader without changing them.
It checks all existing InventoryItem evidence hashes and all19 frozen input pins.
The original `resources.assets:320` TextAsset `bansheegz_database` is reopened and
compared with all506640 exported bytes, its raw object hash and original manifest.
Original resources.assets, sharedassets2 and both owning DLL hashes match.

`decoded.json` decodes QuestProgressLogText `9yCd/l1J50q4ulgVkTG+qQ`:119 ordered
rows, all6 columns. The adjacent Quest `t0mvbnMW90imSoe6SezMKA` has38 ordered rows;
only name, savekey, bio_title, bio_description and initial_progress_log_unlocks
are decoded. Its other7 columns retain exact opaque envelope spans/hashes. This
does not accept those columns or the other26 entirely undecoded BGDatabase sheets.

`inspect-00.il` proves single-relation cells are16-byte BGIds or null; shipped
FromBytes clears non-16-byte segments. Our decoder rejects malformed nonempty
widths instead of crediting them as valid empty links. `relation-config.il` binds
version1 + target sheet ID. `multiple-config.il` binds version2 + target sheet ID
+ allowDuplicates; initial_progress_log_unlocks has allowDuplicates=false. Lists
retain element order/multiplicity, not a set conversion. The existing sparse
row/cumulative-end framing is reused on exact original valuesOffset/valuesBytes
spans, never an expansion of the old parser's InventoryItem values capture.

`readback/visible-fields.jsonl` contains195 display-candidate cell states:119 log
texts and76 adjacent Quest title/description states. Of these177 contain text;
18 absent Quest cells are explicit null states, not translated phrases. The709
protected states are identities/savekeys, priorities and relations. All904 states
match;757 stored spans re-encode exactly,147 absent states stay absent. In-memory
no-op reconstruction equals the complete original input. This is neither Unity
resource reinsertion nor a translated-resource round trip.

All13 generated sheet/column constant-ID checks pass. All149 relation edges resolve:
119 logs belong to28 distinct Quest rows;30 initial log references are stored in28
Quest lists. Exact row/column selectors and byte spans are in the manifests. The
percent-encoded BGId selectors are supplement IDs, not frozen-corpus JSON pointers.

Names/savekeys are actually unique in both selected sheets, matching their unique
key declarations. No map is built before checking this. Log wording has113 distinct
values across119 occurrences; five repeated-value groups retain all row IDs,
including three different `Check back with Maverick later.` occurrences. Equal
wording never merges records. All119 priorities are0; every replacement relation
is absent. A future nonunique name must reject keyed lookup, not overwrite a row.

## Source to output

The unchanged phase0067 loader evidence binds original TextAsset -> BGRepoBinaryV5.
`loader.il` GenerateManifest calls GenerateQuests before GenerateQuestProgressLogText.
Both enumerate without a predicate/comparison. `quest-callback.il` copies DB
bio_title/bio_description to Narrative.Quest title/description. `log-callback.il`
resolves the actual Quest object, copies name/savekey/log_text/priority into
QuestProgressLogEntry and adds each instance to its Quest list, global list and
identity dictionaries. `getter-uses.il` finds one log_text getter consumer: that
callback. Replacement links are bound in a separate second pass (`loader.il`,
IL_003b..0064); none is populated in this original source.

`log-state.il` loads saved isUnlocked/timeUnlocked, Unlock sets the original story
clock once and optionally fires the event, ResetUnlock clears state. Recursive
root selection first requires every traversed entry unlocked, then follows
replaceEarlierLog. `history.il` groups by root, selects lower-priority children
(latest unlocked time for equal child priority), sorts roots by ascending priority,
and returns text from the end into current/1Back/2Back. Preserve the actual IL:
its dictionary ContainsKey check uses the candidate, not root; with the original
all-null replacement graph candidate==root. Hypothetical nonnull replacement
graphs have not been runtime-tested and are not repaired here.

The two loader comparisons and history comparison use priority only. With all
priorities0 they provide no tie breaker. Do not infer an exact output order from
row indices, names or unlock chronology, or substitute a stable sort in an adapter.

`pane.il` repeats exactly the prior pane's IL instructions. Generic output at
IL_084a..0954 writes title/description, calls GenerateLogTextHistory, then for
status200 shifts current into1Back and1Back into2Back and inserts
`[Quest Completed]`. Current falls back to empty; older slots use the serialized
emptyHistoryDefaultText, with bullet visibility derived from displayed emptiness.
The prior bindings are reused after evidence/resource checks and seven original
native Text object raw-hash comparisons: controller18307; title18322,
description18320, current18343,1Back18338,2Back18342,3Back16317,4Back13986.
All use the prior sharedassets0:369 font reference; this is not Cyrillic/font
feasibility or evidence that their serialized placeholders are live source text.

## Lost-photo counter dependency

`readback/counter-dependency.json` expands the exact three MelodyFlipbookQuest
log rows, one Quest's five selected cells, comparison/format/completion literals,
nine protected trigger keys and three native Text bindings into one bounded group.
Only row `jH2Voma0+UW3ZWjlU3KdLQ` / `MelodyFlipbookQuest_2` has the case-sensitive
substring `lost photos`: `Find all the lost photos.` Its siblings are `_1` and `_3`;
the Quest identity is `8pIJ4zKdu0qDM08Tlzlqyg` / `MelodyFlipbookQuest`.

After history selection and completion shifting, the pane tests current/1Back/
2Back displayed nonblank strings at IL_0999/09f0/0a47. A match appends exactly
` ({0}/{1})`. `photo-count.il` independently counts the exact nine
melody_flipbook_story_unlock_01..09 flags; the total method returns9. Translating
the displayed sentence breaks this predicate. Translating comparison operands
or global text replacement is not a safe repair and has not been done.

Required adapter: retain source quest/log identity alongside selected/shifted
histories and attach the counter by that identity independently of authored target
wording. Preserve original root/priority choice, slot shifting, saved/trigger
identities, count producer, spacing and format arguments. Check the affected row
in all three slots, completed and incomplete states, individual/all/no flags;
siblings, other quests, blank slots and an unrelated row with equal displayed
wording must not acquire a counter. These are acceptance requirements, not executed
adapter/runtime tests. No target wording or implementation is accepted here.

## Concrete gaps and next bounded work

`initial-uses.il` is a real empty Cecil call-fragment result for
`Quest::get_initial_progress_log_unlocks` in original Assembly-CSharp. The38 rows'
stored30 links are verified, but a loader/unlock consumer is not established.
SetStatusStarted changes status and invokes events, without reading that property.
Do not infer initial unlocking from the column name. Reflection/other entry points
remain possible; the empty direct-call result is not proof the field is unused.

The pane bypasses generic history for Act3_AfterstormQuest, Act3_StormQuest and
Act1_GreetingsQuest. Its complete selected method has75 literal occurrences:
22 visible compiled fragments,3 protected display comparisons,2 exact punctuation
operands and48 runtime-identity occurrences. These exact occurrences are in
`readback/compiled-literals.json`; they are not a full game literal inventory.
Afterstorm assembles regional fragments and trims `, .` via Replace; Storm and
Greetings select exact named rows and compiled completion text. They need grouped
source/adaptation reconciliation, not broad substitution or source correction.

`log-text-uses.il` also identifies QuestLog.OnQuestLogUpdated and Storm's
OnCollectedAllTheFlyingPages_StormQuest, including its callback. Those consumers
are not yet fully traced here; runtime mutation/alternate output could invalidate
an isolated scalar handoff. Next inspect those exact method bodies and their
dependent row/literal groups, then reconcile the initial-unlock gap. All other
Quest controls, complete shared source/special-scene discovery and final corpus
remain pending. Existing frozen inventories and the shared registry stay untouched.

Accepted10/15/47/48 visuals and50 route remain unchanged.53 stays consumed; no54,
unchanged runtime retry, quit suppression, input/focus/story/authority changes or
owner/global-history inquiry. Initial spawn/other3 intros/notebook/Bucky consumers,
editorial, final fonts/licenses/resources and local delivery are still pending.
Provisional asset drafting remains authorized; this source finding is not a passed
source gate or permission to silently merge new inputs into live lane snapshots.

## Reproduce

Use fresh paths from canonical Forest:

```text
.venv-assets314/bin/python localization/source/bgdatabase-20261027/quest-progress/decode_quest.py --output <new-json>
.venv-assets314/bin/python localization/source/bgdatabase-20261027/quest-progress/verify_quest.py --output <new-directory>
```

The verifier repeats each exact selection in il-commands.json with the existing
Cecil inspector. It never executes game assemblies. It checks actual source and
consumer-ID/readback boundaries, plus valid empty/16-byte single-relation controls,
malformed1/15/17-byte rejections and ordered duplicate-preserving list codecs.
Malformed-width controls change only width after the intended type guard; these
are strict extraction checks, not claims that the shipped game rejects malformed
bytes. Reproduction must match the decoded file and every readback file exactly.
New summaries and source acceptance remain separate from static mechanical success.

Regression: all-zero priorities must not become a claimed chronological ordering;
an absent replacement column must not be credited as exercised replacement behavior.
Changing a displayed phrase must not silently disable its counter; attaching the
counter to every equal target string also fails. Single-relation null is not a
16-byte zero ID or an arbitrary malformed segment. Multiple-relation config's final
byte is allowDuplicates, as proved by shipped IL; it is not a guessed reverse flag.
Usage in this worker is unknown; parent measures actual request telemetry.
