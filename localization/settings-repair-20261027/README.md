# Russian settings repair

Scope: the settings screen in the owner's October 27 screenshot, reproduced from
the existing `ru-20261027-editorial-final` Russian dialogue preview. This is a
bounded UI repair, not complete game/source/font/editorial or release acceptance.

The active coordinator was verified as `gpt-6.1-sol`, high reasoning. No worker or
additional model job was launched. Other active language and technical lanes were
left running; their files, root README and root CHECKPOINT were not edited here.

## Cause and correction

The actual-preview recipe translated the main-menu captions and Back but omitted
the settings captions. Music and Effects have old texture assets, but their Image
components are disabled and the visible captions use TextMeshPro. Texture names
alone therefore do not identify the live rendering mechanism.

`tools/russian_settings_ui.py` binds nine explicit OptionsMenu hierarchy families
to 54 TextMeshPro components. All six face/outline/container occurrences receive
the same authored caption. Binding guards reject unexpected source values, fonts
or incomplete families. Other scenes, field values, fonts and geometry are retained.

| Source | Russian |
| --- | --- |
| Music | Музыка |
| Effects | Эффекты |
| Fullscreen: | Полный экран: |
| Stretch: | Растянуть: |
| Scale: | Масштаб: |
| On | Вкл. |
| Off | Выкл. |

The Stretch Off control additionally had `level1:9708`, an enabled legacy Image
under the complete text replacement. The existing source-bound image recipe now
runs by default in actual Russian builds; it disables that one Image. No texture
pixels are changed. The separate experimental glow-geometry flag is not enabled.

Regression: build an actual Russian preview without optional settings flags and
open Options. All captions and both toggle branches must be Russian; Stretch Off
must have one visible face and its normal outline, with Image 9708 disabled.
Switching out of fullscreen must expose the translated Scale caption. Merely
finding the old Music/Effects textures must never route this defect to texture work.

## Artifact and reproducibility

The uninstrumented output is
`localization/previews/ru-20261027-settings-fix/game/The Forest of Love.exe`.
Its `build.json` pins the baseline, recipe snapshots, all 54 text IDs, the Image
binding and exact selected/unselected object readback. Every other game file is
byte-identical to the baseline; only level1, isolated PlayerSettings identity and
app.info change. Baseline preview saves/settings are preserved and excluded from
the new isolated artifact.

```sh
.venv-assets314/bin/python -B tools/build_russian_settings_preview.py \
  --base localization/previews/ru-20261027-editorial-final \
  --output localization/previews/<new-attempt> \
  --qa-product ForestRuActual20261027_09
.venv-assets314/bin/python -B -m unittest discover -s tools -p test_russian_preview_ui.py
```

The incremental builder verifies the existing artifact and authored dialogue inputs
before reuse. It does not rerun extraction or rebuild unchanged dialogue/fonts.
The normal full-preview builder also applies the same settings plan automatically.
Writes are restricted to a new output directory. Files are not a transaction:
an interruption leaves an unaccepted partial attempt, and the final build receipt
is written only after all readback and preservation checks pass. Never overwrite
an existing attempt to retry.

## Runtime evidence boundary

The separate disposable QA copy is `localization/probes/ru-settings-20261027-01`.
`qa-preparation.json` binds it to the uninstrumented artifact and the already
verified candidate15 bridge/hook. Every managed reference is checked before reuse.
Only the QA copy receives the inspection assembly and legacy QA product identity.
The runner reuses the existing guarded settings route and records its result in
`runtime-result.json`, restoration in `cleanup.json`, and original native frames.

This attempt passed the nine focused tests and automated runtime checks. Both
native captures decode correctly and match their recorded viewports: fullscreen
1440×900 and windowed 960×540. Cleanup confirms the test process exited, its bridge
was removed, and original assets/player files stayed unchanged. The delivered
preview still has the original managed assembly and no inspection bridge.

`validation.json` links the exact evidence. `native-manifest.json` and
`native-review.json` retain both originals as **pending** semantic visual review;
no default pass rows or inherited candidate15 visual acceptance were used.

The intro input is bypassed by the existing FinishShowingMenu inspection command;
the actual Options, Stretch, Fullscreen and Back handlers are then exercised.
Runtime assertions check all visible translated layers, reciprocal control
visibility, text-overflow flags and all eleven legacy text Image bindings. These
checks do not replace semantic visual review, OS keyboard/controller delivery or
complete-game acceptance. Screenshot and cleanup status must be read from this
attempt's receipts, not inherited from the earlier synthetic candidate.
