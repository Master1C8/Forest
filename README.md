# The Forest of Love: localization asset preparation

Canonical project: `/Users/antonkrutov/Desktop/Forest`.

The local source is **The Forest of Love 0.45** (PlayerSettings `bundleVersion`),
installed at `/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest`.
The player uses Unity **2020.3.24f1**; the Addressables bundle reports
**2020.3.22f1**. The source language observed in display assets is English.
`tfol.settings` is a mutable player-settings file, not the authoritative build version.
The unrelated Helltaker archive originally present in this folder was left untouched.

## View only textures containing text

Open [the filtered gallery](review/index.html). It contains **110 distinct images**
with visible text, representing **120 source texture occurrences**. Click an image
to open its native PNG. Each card retains every exact source/container and path ID.
The selected originals are also copied into `review/textures/`, with readable filenames.
`dist/text-bearing-textures.zip` contains a portable gallery, all 110 selected PNGs,
contact sheets and the source-ID manifest; all ZIP members were read back and compared
to the delivered files. It does not include unrelated textures or font atlases.

The gallery includes 12 tutorials, 65 interface images, 9 illustrations/item atlases,
5 UI mockups and 19 development/engine images. Runtime reachability is unverified;
mockups and editor/engine graphics are clearly labeled. Six distinct font atlases
(eight source occurrences) are listed separately in `review/font-atlases.json`.

`texture-review.json` is the manual selection. `review/text-bearing-textures.json`
binds it to the complete texture manifest and groups duplicates only when decoded
RGBA pixels and dimensions match. All 1,375 exported textures were visually screened
on 29 contact sheets. Small inventory/quest/rune atlases received additional native-size
inspection. Screening is not proof that every tiny mark in every illustration is text-free.

Local Apple Vision OCR supplied candidates; it did not decide acceptance or generate
wording. Accurate OCR stalled during Apple neural-engine initialization, including
with `usesCPUOnly`. A bounded legacy fast/revision-1 probe succeeded; that path processed
all 1,375 images. One 2×2 empty transparent texture was rejected as too small. It was
visually inspected and is not a text candidate. No external OCR/translation service was used.

## Extracted resources and provenance

`assets/source-v2/` contains PNGs at original dimensions and alpha, six exact TextAsset
payloads, eleven font records and available font bytes, Sprite/atlas/UI/font/component
typetrees, a complete object inventory and source SHA-256 manifest. The binary BGDatabase
payload is saved as `.bin`; it must not be mistaken for UTF-8 text.

The extraction includes both scene/shared resources and the Addressables bundle.
IDs use `source-file!/internal-serialized-file:pathId` for bundled objects. This avoids
collisions and preserves the exact source file, internal CAB name, path ID, texture
format, dimensions, mip count and original object fingerprint. Compressed texture bytes
remain in the untouched installation; PNGs are editable decoded exports, not replacement
Unity containers. Preserve alpha, dimensions, IDs, Sprite rectangles/pivots/borders,
material references and container bindings when preparing future replacements.

Large JSON metadata is versioned in `assets/source-v2/metadata.tar.gz`, with an exact
member read-back receipt in `metadata-archive.json`. The expanded working files are
ignored by Git. Restore them after checkout with:

```sh
tar -xzf assets/source-v2/metadata.tar.gz -C assets/source-v2
```

The primary dialogue resource is the Pixel Crushers DialogueDatabase, present in both
the Addressables bundle and `sharedassets0.assets:3336`; its extracted structure includes
627 conversations, 39 actors and 10 item/quest records in each copy. The string-field
inventory retains both occurrences rather than collapsing IDs. BGDatabase, dialogue
database controls, C# literals and scene/runtime consumers still need semantic
classification before a complete translation-source handoff. Unknown fields default
to `preserve-exactly-pending-consumer-review`, not permission to translate.

## Reproduce and verify

Use Python 3.14 and the project-local `.venv-assets314`. Exact package versions are in
`requirements-assets.lock`; Apple Vision requires macOS/Xcode command-line tools.
The initial export used the already installed UnityPy 1.25.4/Pillow 13.0.0 environment
read-only; all final tools use this project's own environment.

```sh
/Users/antonkrutov/.local/share/uv/python/cpython-3.14.6-macos-aarch64-none/bin/python3.14 -m venv .venv-assets314
.venv-assets314/bin/pip install -r requirements-assets.lock
.venv-assets314/bin/python tools/extract_assets.py \
  --source '/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest/The Forest of Love_Data' \
  --output assets/new-export
.venv-assets314/bin/python tools/validate_exports.py assets/new-export
swiftc tools/ocr_textures.swift -o /tmp/forest-ocr-textures-fast
/tmp/forest-ocr-textures-fast assets/new-export/textures.json > assets/new-export/ocr-results.jsonl
.venv-assets314/bin/python tools/build_texture_gallery.py
```

The gallery builder deliberately binds to the reviewed `source-v2` manifest. A new
source export must be compared and the review rebound before its indices are reused.

The initial v2 export lacked schemas for some MonoBehaviours and could not serialize
binary Sprite fields. `repair_metadata.py` recovered 41,376 recorded failures with the
game's managed assemblies and binary-safe JSON. Initial failure/report receipts remain
separate. The normal extractor now includes both fixes. Remaining 1,351 metadata failures
are listed in `failures.json`; most involve FuzzySpriteRect and joystick maps. Those
records are unresolved, not accepted empty objects. The earlier `source-v1` stopped on
unmapped CAB provenance before exporting textures and is retained as ignored evidence.

The source schema takes precedence over generated schemas. TypeTreeGeneratorAPI
0.0.10 omits the 4-byte alignment flag after `m_Enabled`; it can shift `m_Script`
by three bytes while still consuming the expected total object size. The extractor
corrects that generated-schema flag and independently verifies every component's
Script/GameObject/Enabled/Name header. `repair_schema_headers.py` corrects existing
generated exports while requiring complete body/string equality outside `m_Script`.
Regression examples: `level1:8044` (an empty SoftMaskable) must retain the native base
schema; `level1:7339` (TMP) and `sharedassets3.assets:3271` (BOC.BTagged.Tag) must preserve
their real script references when a generated schema is necessary. Byte-count success
alone does not satisfy this check.
The corrected schema is rebuilt from flat nodes to invalidate the generator's compiled
reader cache. Changing a node flag in place can leave that reader using the old
alignment. `level0:107` is an additional regression control for this cache boundary.
The header repair is resumable after a partial write: every affected tree hash is
reconciled even when its corrected bytes were already written. Tree-file writes and
the final object manifest are separate commits to disk, not a multi-file transaction;
the final source validator and archive read-back must pass before delivery.

`validate_exports.py` checks source file SHA-256, every object ID/raw fingerprint,
every exported typetree and exact string value, TextAsset bytes, and every PNG's
dimensions, checksum and decoded RGBA pixels against the installed source. This tests
the extraction boundary. It does not test translation semantics, reinsertion, Unity
compression, renderer support, runtime loading or gameplay.

Use `tools/pack_metadata.py` only after extraction/repair has finished; it verifies
every archived member against the expanded working file. Do not rewrite a running
extractor's helpers. A future asset build should use a new output directory and compare
the current source manifest before reusing these results.

## Scope and next stage

This task exported original assets and identified baked text. It did not translate,
redraw textures, install a mod, launch the game, publish content or deploy anything.
No localization type or target locale was selected. `special-scenes.json` records
observed visual dependencies and the remaining discovery gaps. Source acceptance and
renderer feasibility remain unverified; extraction success is not a playable localization.

The texture reinsertion route is Unity Texture2D replacement in each owning serialized
file or Addressables bundle, preserving links and format/alpha/dimensions. It has not
been round-tripped. Bundle catalog/hash dependencies require investigation before
replacement; merely editing the PNG files cannot affect the game.

Official/reference research: [developer's game page](https://carrotscritters.itch.io/the-forest-of-love),
[Steam listing](https://store.steampowered.com/app/1683170/),
[existing TMP font-override discussion](https://github.com/bbepis/XUnity.AutoTranslator/issues/57),
and [UnityPy's extraction/type-generation documentation](https://github.com/K0lb3/UnityPy/blob/master/README.md).
These are technical leads, not evidence that a mod works with this exact build.

The coordinator model was verified from this chat's turn context as GPT-6.1 Sol,
reasoning high. No Astra model, worker, external translation model or subagent was used.
