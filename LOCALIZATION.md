# Build a Forest language from one file

The deterministic compiler uses the accepted Russian Forest 0.45 implementation
as its common framework. A language file contains English source text, target
text, and optional font/point-size settings. It cannot supply commands, Python
modules, resource selectors or game-logic changes.

Build a language:

```sh
./forest-localize build localization/languages/ru.json
```

The default output is `dist/Forest-<locale>-<language-file-hash>/`. It contains
the complete shared-framework resource overlay under `The Forest of Love_Data/`
and an exact completion manifest. This command calls no translation model,
starts no queue, launches no game, and installs nothing. Input game files,
the accepted Russian build and player saves remain read-only.

The included `ru.json` carries the current saved Russian terminology revision;
`ru-baseline.json` reproduces the accepted earlier implementation unchanged.
`de.json` imports existing German data and authored wording into the same
framework. `es.json` supplies Spanish (Spain), `es-ES`, through the shared v2
catalog. Build it with `./forest-localize build localization/languages/es.json`.
These files retain their own editorial provenance; the compiler
does not award editorial, native or release acceptance.

## Language authoring

Prepare a complete file with the fixed English inventory:

```sh
./forest-localize template --framework forest045-shared-v2 \
  --locale fr --culture fr-FR --output localization/languages/fr.json
./forest-localize validate localization/languages/fr.json --details
```

Fill each `target` in the resulting JSON. Preserve the IDs and `source` values.
`null` means unread/untranslated and prevents compilation; an empty string is an
explicit value. The v2 14,606-entry inventory includes preserved dialogue
and technical values, which must follow their original control/preservation
rules. A source-equal target is not automatically an editorial pass.

```json
{
  "source": "Back",
  "target": "Назад"
}
```

One logical dialogue entry updates both physical copies. All edits to one Unity
object are merged before serialization. The existing source-aware dialogue guard,
whole-object readbacks, independent 51,572-state database readback, original
bundle compression/CAB checks and Addressables catalog updater are shared code.
Managed string edits use exact method/instruction identities and verify the
complete saved semantic tree and restoration of the original tree. The nine
haiku display/evaluation pairs must agree. Source/control keys stay in the
framework, outside the editable target mapping.

Visible quantities may use natural target-language words or digits. The compiler
does not equate numeral spelling with semantic fidelity: the source-to-target
audit must preserve the actual amount, order and context. Command operands,
placeholders and protected source values still retain their exact identities.
Regression: `2 copies` may become Czech `dva výtisky`, while changing or removing
the accompanying `[pic=3]` command still rejects before resource generation.

Optional `layout` entries map registered native component IDs to point sizes
from 8 to 128. Optional `fonts` entries select embedded faces from `fontAssets`:

```json
{
  "fonts": {
    "REGISTERED_ASSET:FONT_ID": {"asset": "FACE_SHA256", "family": "Font Family"}
  },
  "fontAssets": {"FACE_SHA256": "BASE64_TTF_OR_OTF_BYTES"},
  "layout": {"REGISTERED_ASSET:TEXT_ID": 10}
}
```

Only roles registered by `framework.json` are writable. Names, resource pointers,
materials, texture objects/streams and the fictional-language mapping are retained.
For a changed static TTF/OTF face, the compiler derives native ascent, descent and
line spacing from the actual font tables and removes stale kerning. The registered
dynamic TMP1017 consumer of Font439 receives matching face/legacy metrics. Its
source/fallback pointers and empty atlas caches are preserved; static or populated
caches reject a face replacement. The face must have a matching family, explicit
cap/x heights and a positive space advance. Unchanged baseline faces retain their
accepted metrics. These are table-scaled serialized inputs, not a Unity font import.
Existing shared runtime adapters supply the accepted Russian layout behavior.
The compiler also registers the seven original quest-list name templates in the
exact shared-v2 framework: `sharedassets2.assets:18330`, `18315`, `18305`,
`18314`, `18312`, `18344` and `18341` (repeat the asset prefix for each key).
Their original point size is14; a locale can set a smaller readable size without
changing canonical quest titles, word bindings or the frozen framework. The
exact framework/resource pins and original field values remain mandatory.
Additional scripts such as CJK/RTL can require appropriate face data and actual
target rendering/behavior validation. A successful compile alone does not prove
font coverage, shaping, layout, visual parity or gameplay correctness.

Font regression: replacing Font439 with the pinned Japanese CFF face must also
replace TMP1017's Liberation Sans face metadata, preserve TMP1020's fallback and
all atlas/fictional resources, and round-trip the saved object trees. The same
mechanism handles the Chinese face without a locale branch; locales that select
no replacement face keep their resource behavior.

## Continue and verify

```sh
./forest-localize build localization/languages/ru.json --output dist/My-Language
./forest-localize build localization/languages/ru.json --output dist/My-Language --mode check
```

After an interruption use `--mode resume` with the same input, engine and output.
The input marker is written first, resource files use exclusive creation, and
the completion manifest is written last. Existing partial bytes must match.
Changed inputs, unexpected files and conflicting outputs reject. This is a
resumable build, not a multi-file installation transaction. Completed artifacts
use `check`; an unchanged build does not overwrite them.

## One-time migration and reproducibility

The framework catalog and manifest are versioned. Bulky `base/`, `references/`
and managed inspection snapshots stay locally in the same canonical project;
they are hash-bound reconstructible resources, like the existing original game
assets. Recreate a missing framework using the exact original game and accepted
Russian data directories:

```sh
./forest-localize migrate-russian \
  --original /absolute/path/to/original/The\ Forest\ of\ Love_Data \
  --baseline localization/previews/ru-20261029-narrative42-01/game/The\ Forest\ of\ Love_Data \
  --output localization/framework/forest045-shared \
  --language-output /absolute/path/to/new-ru-baseline.json --id forest045-shared
```

Migration checks the complete original 247-member data inventory and the accepted
Russian assembly/resource/font hashes. It excludes the QA product identity,
platform launchers and player data. `--resume` checks existing snapshot bytes
after a partial migration. It never rebuilds the historical Russian launcher.

`import-existing` imports a hash-verified saved locale candidate. `merge-wording`
fills missing targets from existing authored JSONL rows or shared JSON resource
plans with an `edits` array, selecting an exact
ID/source match or a unique source/target mapping. Conflicts remain unread.
These are migration commands; ordinary builds depend only on the language JSON,
the shared framework and the local compiler dependencies, not historic phases,
editorial queues, technical inboxes or model jobs.

The v1 difference-only catalog omitted twelve inventoried native inventory-heading
layers whose stored text was unchanged in the Russian baseline. The shared v2
catalog adds their exact original field identities. Reproduce this finite repair
from the verified v1 framework without changing it:

```sh
./forest-localize extend-native --framework forest045-shared \
  --id forest045-shared-v2 \
  --original /absolute/path/to/original/The\ Forest\ of\ Love_Data \
  --packet localization/framework/native-inventory-headings-20261031.jsonl
```

The command checks the original resource version and every original/baseline field,
copies the unchanged pinned companions, and publishes the new manifest last.
`--resume` verifies an existing partial output before continuing. Writes are
sequential, not a multi-file transaction. The regression test interrupts actual
file publication and resumes it; its Unity decoding boundary is replaced by a
fixture. The real Spanish saved-resource check separately reads all twelve layers.
Future unchanged-field omissions use this same explicit inventory mechanism.
Existing v1 language files and tested packages retain their exact old binding.

The Russian launcher source is now `localization/languages/ru.json`, rebound to
v2 from the immutable accepted `ru-baseline.json`. The former launcher override
selected v1 and therefore still displayed English inventory headings. The repair
adds only the twelve inventoried fields, preserving the 14,594 shipped wording
entries and the original initial-letter markup. Reproduce its source delta with
`python3 -B localization/completion/ru-inventory-heading-20261104-01/prepare.py`,
then use the normal compiler. `Windows/installer-config.json` owns source overrides
for both platform payload builders; a platform-specific Russian override must not
silently select the old file again. Regression: both packaged Russian resources
must read back all twelve headings as `ИНВЕНТАРЬ`, with every other object unchanged.

Launcher 1.1.2 also migrates German's unchanged v1 wording to v2 and adds its twelve
`INVENTAR` layers. The remaining 28 languages already contained the selectors.
`tools/forest_inventory_headings.py` gates both payload builders and final
packages: every selected locale must contain all twelve translated fields, and
the packed language hashes must match the current configured sources. The macOS
launch guard compares installed selected-language resource pins with the current
payload, while allowing an unchanged locale from an older overall package.
Old owned files can still be updated through normal Apply language.

For a verified existing Windows payload, `tools/build_windows_installer.py refresh`
updates changed non-bundle resources and retains exact unchanged bundle evidence.
Changed bundles require the full `payload` route. Every reconstructed resource
is checked, literal segments are limited to 65536 bytes by the shipping installer
contract, and unused blobs are pruned. Publication preserves the old archive,
manifest and receipt; replacements are sequential, with the receipt last.
An interruption is rejected as inconsistent, not treated as a multi-file
transaction. Regressions cover interruption after the first two writes, retained
recovery inputs, the 64 KiB limit, stale sources and English fallback.

Run the small input/publication regressions with:

```sh
.venv-assets314/bin/python -B -m unittest discover -s tools -p test_forest_localize.py -v
```

Actual resource tests, byte comparisons and build provenance are recorded in
`localization/framework/verification-20261031.json`. The previous German queue
remains owner-stopped. Final gameplay/visual review, activation in a game copy,
installer creation, publication and deployment retain their separate authority.

## German native test findings

The [2026-10-31 in-game test](localization/runtime-tests/de-single-file-20261031-01/README.md)
passed original UI/loading/choice and bounded inventory/quest checks. It found
twelve English inventory-heading layers omitted by the difference-only catalog,
and a German compound split without a hyphen in the quest list. The shared v2
catalog fixes the selector omission for new builds; Spanish includes all twelve
localized layers. The six-frame
visual gate is not accepted. The tested package remains unchanged. Launcher 1.1.2
now includes the German heading rebuild; the remaining layout/visual findings
are outside this heading repair and remain pending.

Filled JSON entries establish schema completeness only. Target selectors must
also cover the existing canonical inventory, including fields unchanged in the
Russian baseline. Reuse accepted mechanisms and exact target data; do not reopen
a global source audit or create another model stream.

Spanish conversion evidence and outstanding editorial/native predicates are in
`localization/language-imports/es-20261031/README.md`. Its source-preservation
receipt retains the old translated drafts for 619 protected original values and
two repaired service prefixes. Those source-contract repairs are not new Spanish
semantic passes. Ordinary builds consume the final language JSON directly.
