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
framework. These files retain their own editorial provenance; the compiler
does not award editorial, native or release acceptance.

## Language authoring

Prepare a complete file with the fixed English inventory:

```sh
./forest-localize template --framework forest045-shared \
  --locale fr --culture fr-FR --output localization/languages/fr.json
./forest-localize validate localization/languages/fr.json --details
```

Fill each `target` in the resulting JSON. Preserve the IDs and `source` values.
`null` means unread/untranslated and prevents compilation; an empty string is an
explicit value. The complete 14,594-entry inventory includes preserved dialogue
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
Existing shared runtime adapters supply the accepted Russian layout behavior.
Additional scripts such as CJK/RTL can require appropriate face data and actual
target rendering/behavior validation. A successful compile alone does not prove
font coverage, shaping, layout, visual parity or gameplay correctness.

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
fills missing targets from existing authored JSONL rows, selecting an exact
ID/source match or a unique source/target mapping. Conflicts remain unread.
These are migration commands; ordinary builds depend only on the language JSON,
the shared framework and the local compiler dependencies, not historic phases,
editorial queues, technical inboxes or model jobs.

Run the small input/publication regressions with:

```sh
.venv-assets314/bin/python -B -m unittest discover -s tools -p test_forest_localize.py -v
```

Actual resource tests, byte comparisons and build provenance are recorded in
`localization/framework/verification-20261031.json`. The previous German queue
remains owner-stopped. Final gameplay/visual review, activation in a game copy,
installer creation, publication and deployment retain their separate authority.
