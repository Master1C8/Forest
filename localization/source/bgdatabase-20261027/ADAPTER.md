# Phase0067: BGDatabase inventory source and item-text consumers

Static text-only work, gpt-6.1-sol/high/OpenAI verified from current80584 argv.
No agents, nested model jobs, images, game launch, translations or deployment.
Seven authorized asset lanes remain independent and read-only. No shared helper,
frozen source/glossary/inventory or asset-lane file changed. Worker usage unknown;
the parent measures actual telemetry.

## Original source and exact selectors

The existing exporter identifies `resources.assets:320`, TextAsset
`bansheegz_database`. `verify_inventory.py` reopens that exact original Unity object,
checks its raw object hash and compares all506640 exported bytes with source-v2.
The installed resource, sharedassets2 and both owning DLLs match the original source
manifest. This is TextAsset reading only; no texture decoding or image inspection.
The original export remains classified decoder-pending; this separate supplement
does not rewrite the live lanes' frozen source family.

`BGLoaderForRepoResources` lists `bansheegz_database` first, loads TextAsset bytes;
`BGRepoBinaryV5` recognizes the version5 header. All29 sheet envelopes, row-ID arrays,
field headers/value-blob extents and keys consume the exact input with no tail.
Only InventoryItem cell values are decoded. Other28 sheets' value bytes remain
opaque, hash-bound extents, without semantic/source-acceptance claims. Header flags
outside this task use positional names instead of guessed meanings.

InventoryItem sheet ID is `0BzeuogxqUOTnLWmTpBxVw`. Its48 original ordered row IDs and
18 typed column IDs are in `inventory-decoded.json`. Six independent consumer-ID
checks match the generated sheet getter and name/savekey/title/notification_phrase/
description getters' two64-bit constants to the binary IDs. `get_db_Driftwood`
performs a name lookup: a natural-language-looking `name` is still an identity.

`readback/visible-fields.jsonl` retains144 candidate occurrences with sheet/row/column
IDs, exact values and original byte spans. Stable selectors percent-encode BGId
characters; they are supplement selectors, not JSON pointers into the frozen corpus.
`preserve-exactly.jsonl` records720 other cells, including names, savekeys, enum
integers, flags, positions, addressable paths, vector arrays and nested Tag-ID lists.
There are864 cell checks:818 stored spans re-encode byte-for-byte and46 absent
spriteAnimator cells stay absent. Replacing these original spans with re-encoded
values in memory yields the identical506640-byte input; this is no-op cell readback,
not a rewritten/reinserted Unity resource or a translated-resource round trip.

Names/savekeys/item_type happen to be unique across these48 rows. The schema's
`uk_savekey` key has IsUnique=false: its name is not uniqueness authority. No map
is built before uniqueness checks. Title has45 distinct strings, notification_phrase
45, description46. Package, Jar and Fireflies repetitions keep distinct row IDs;
Fireflies/FirefliesMore also have equal descriptions. None is silently deduplicated.
These are candidate fields, not144 accepted/reachable translation units.

## Consumer boundary and dynamic wording

`DialogueSystemLoader.GenerateItems` enumerates every DB.InventoryItem with null
predicate/comparison. Its callback copies name->dbName, savekey, item_type and the
three authored wording fields into Inventory.InventoryItem, with resource loaders,
flags, grid/equip coordinates, tags and priority handled separately. It fills the
name/savekey/item-type dictionaries with Add. The three wording getters occur only
in this callback in the exact Assembly-CSharp getter-use searches.

The original inventory consumer remains `InventoryCellUiController.OnSelected` ->
InventoryEvents -> InventoryInfoTicker.OnCellSelected -> UpdateItemInfoText -> two
UnityEngine.UI.Text components. The existing three-controller/six-Text binding
evidence and twelve evidence hashes are reused only after original resource/DLL
hash equality. Their physical/runtime listener multiplicity is still unmeasured.
Do not substitute serialized Driftwood placeholders for dynamic database text.

Ordinary item title/description enter the ticker for consumed/positive-quantity
items. Type405 can display its Where Are My Items? title/description in the original
instanced-story placeholder branch; type400 clears both ordinary fields and enters
the glitch renderer. Ordinary empty/grid(4,3) literals remain in the prior inventory
supplement. All48 rows remain in this source supplement, including masked cases;
reachability is not guessed from serialization or inactive=false.

All current item-title/description/notificationPhrase field references are retained
in the three `--find-field-fragment-*` files. Title also feeds dialogue get/lost,
lightweight overworld and queued all-in-one notifications; description also feeds
developer-console search (not an ordinary player-text denominator). ItemGetNotification
formats `You got {0}!` with notificationPhrase and writes every child TMP text;
its guard suppresses types40/50/180 and an already-visible notification. Other paths
join title with `Item received: `, `Item delivered: `, `Item found: ` or their newline
variants. Prefix separators and the format placeholder are distinct source content.
PlankEE can substitute `Plank! <.<` in the lightweight path. `show` is an Animator
trigger and must stay exact. The13 exact source literals are recorded and checked in
`compiled-fragments.json`:9 visible fragments,3 trigger-key occurrences,1 mixed
fictional trace. This is six selected output-method files, not a complete literal scan.
Notification prefab activity, text-instance multiplicity and actual runtime use remain
unverified; title/phrase grammar must later be reviewed in assembled output.

## Special-scene/source findings and limits

Type400's `RandomizeGlitchItemInfoTickerText` deliberately uses a644-character
compiled fake NullReferenceException/stack trace, replaces LF with spaces (the four CR characters remain), selects a
substring and appends ` <color="purple">(Use Me)</color>`. Existing serialized active
FixedWidths controller17282 binds TMP15506, random interval0.5 and length32; the two
other ticker variants have null glitch references. The code computes Random.Range
arguments `0, originalLength - substringLength - 1`. This is authored fictional
display code, not an observed crash or actual reflection exception. Keep code-like
syntax, markup, string length/window bounds and visual effect in one adaptation
group; no target wording or feasible final adapter is claimed.

The Map description contains literal `[M]`/`[Select]` input hints. Rosetta Stone's
description explicitly connects to glyph deciphering. The cookie's icing text and
other callbacks require later reconciliation with the frozen special-scene registry;
these source findings do not pass that registry or invent isolated target solutions.
`source-trace.json` lists exact rows/fields and dependencies for this handoff.

Remaining: source/consumer coverage for the other28 BGDatabase sheets, all other
agreed source/parser/typed/UI/code/texture families and complete special scenes;
actual notifications, item/quest layouts, initial spawn/other3 introductions/notebook/
Bucky loaded consumers; editorial, final fonts/licenses/resources and local delivery.
Accepted10/15/47/48 visuals and50 original181/full187/cleanup remain unchanged.
53 remains consumed; no54, runtime retry, quit suppression, input/focus/story change
or owner/global-history investigation. Provisional parallel drafting remains authorized.

## Reproduction and regression

From the canonical checkout, use new output paths:

```text
python3 localization/source/bgdatabase-20261027/collect_il.py --output <new-il-directory>
python3 localization/source/bgdatabase-20261027/decode_inventory.py --output <new-json>
.venv-assets314/bin/python localization/source/bgdatabase-20261027/verify_inventory.py --output <new-directory>
```

`collect_il.py` uses the existing compiled Cecil inspector, never loads assemblies
for execution. It checks original DLL and unchanged owning-helper hashes.58 exact
selections were reproduced. The decoder and both source manifests reproduce byte
identically. `readback/verification.json` and `reproducibility.json` record actual
checks. Positive sparse rows2,0 retain order/missing1; a duplicate2 is rejected at
duplicate-row-index with every earlier guard satisfied. Trailing input is rejected.
An early verification selector incorrectly matched a getter call before its method
declaration; it was repaired to select one exact METHOD declaration before checks
passed. Initial text-mode IL collection also normalized four embedded CRLF pairs in
the fictional trace. Raw-byte collection/readback repaired that source-evidence defect;
the exact644-character literal and all four CR bytes are preserved. The collector
now rejects any changed byte. No game/source exception was inferred from either defect.

Regression: equal Fireflies wording must retain both row IDs and type430/435; a
uk_savekey label never proves unique schema semantics; nested relation IDs and
resource paths never become translated words. A scripted fake exception displayed
by the game is source content, not runtime exception evidence. No-op byte equality
does not establish resource reinsertion, rendering, editorial or full source acceptance.
