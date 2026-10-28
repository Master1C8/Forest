# Corpus-bound font preparation

Canonical project: `/Users/antonkrutov/Desktop/Forest`. This is static preparation,
not renderer feasibility, installation or release acceptance. No game was launched.

## Current evidence and remaining scope

The phase118 role matrix is a preserved baseline. Its custom-nameplate descendant
gap was resolved by [the original binding supplement](nameplate-original-binding-20261027/ADAPTER.md):
controller4311 -> root2849 -> leaf2442 / GO942 -> native Text4545 -> original
Font369 `MatchupPro_TFOL`, with null material PPtr. Plugin portrait-name3695 /
Font367 is outside that subtree. This gives109 distinct selected Text/TMP
identities, not a complete live-component or displayed-text denominator. Reuse
the stored binding/verification fingerprints instead of recovering that subtree again.

[The 30-locale interface preflight](../font-checks/supplemental-30-20261028.json)
checks the immutable935-unit packets against original and pinned candidate faces.
It keeps raw/NFC/NFD requirements and each face separate. It does not cover newly
discovered omissions, later wording, actual per-role shaping, bidi, fallback
selection or native layout. Updated wording must invalidate the affected checks.

[The current texture-preserving boundary](no-texture-feasibility-20261028.md)
and [its guard controls](no-texture-guard-20261028.json) reject the known
atlas-rewriting `--coherent-tmp-face` mode in both canonical preview builders,
before output creation. Other resource changes still require byte-exact original
Texture2D/stream comparison. No font resource or texture has been produced by this
preparation, and the fictional mouse3324/material3/atlas245 mapping stays separate.

The remaining font deliverable is a complete source/editorial-bound requirement
set for each actual role, appropriate face/resource bindings and native evidence
for the required scripts. Neither cmap coverage nor an old synthetic Russian
probe accepts those predicates. Runtime testing remains stopped by the owner.

## Preserved dialogue-corpus and candidate checks

The original-font check covers all 12,246 saved dialogue-family IDs in each of
`ru`, `zh`, `es`, `es-419`, `pt-BR`, `ja` and `de`. Input hashes in
`../font-checks/dialogue-20261027-02.json` identify the exact revisions. The
requirement set conservatively includes command operands and preserved source;
it does not guess font roles or combine unverified fallback faces.

Eleven original Font resources were checked. Embedded Liberation Sans covers
the recorded Western/Cyrillic requirements except `Ɡ` and `Ɪ`, which occur in
exact-preserved constructed-language rows. It lacks 2,210 characters in the
Chinese requirement set and 1,517 in Japanese. These counts concern this logical
superset, not actual missing-glyph observations. An unembedded external face
such as Arial has unknown coverage, never an assumed empty or complete cmap.

Two unmodified, single-face Regular candidates are stored in `noto-cjk/`:

| Locale | Face | Source version |
| --- | --- | --- |
| `zh` | Noto Sans CJK SC Regular | 2.004 |
| `ja` | Noto Sans CJK JP Regular | 2.004 |

`noto-cjk/provenance.json` pins the upstream commit, exact download URLs,
SHA-256 values and license. The upstream SIL Open Font License and README are
included, and the fonts retain their embedded copyright notices. These files
are candidates; they have not been installed or substituted into game assets.

`../font-checks/cjk-candidates-20261027-01.json` records actual cmap, metrics,
positive U+0020 advance and outline bounds for 2,292 Chinese-corpus characters
and 1,609 Japanese-corpus characters. The twelve missing phonetic characters
are confined to 38 exact-preserved constructed-language rows per locale;
`cjk-missing-source-classification.json` binds each occurrence to existing
provisional source classifications. Do not force this ordinary face onto the
fictional-language role or treat a fallback union as verified font selection.

Reproduce the static checks with the project's existing FontTools environment:

```sh
.venv-assets314/bin/python -m unittest discover -s tools -p test_font_corpus_preflight.py -v
.venv-assets314/bin/python tools/font_corpus_preflight.py --locales ru zh es es-419 pt-BR ja de --output localization/font-checks/NEW-original-check.json
.venv-assets314/bin/python tools/check_cjk_candidates.py --locales zh ja --requirements localization/font-checks/NEW-original-check.json --output localization/font-checks/NEW-candidate-check.json
```

Each output path must be new. Recheck affected requirements after editorial
changes. Actual font-role bindings, TMP atlases, mark placement, shaping, line
spacing, narrow UI wrapping, dynamic inputs, image text and native-size
readability remain separate requirements. Font tables and outline bounds
cannot establish those properties. Runtime testing remains stopped by the owner.

The earlier original-font report ending in `-01.json` is historical and was
superseded before acceptance: an empty external resource must have unknown
coverage. The current index and regression test preserve that correction.

## Current role and requirement supplement, phase147

[The current109-component reconciliation](role-requirements-20261028/ADAPTER.md)
resolves the finite role/source/candidate assignment in10 requirement profiles.
[Its acceptance checklist](role-requirements-20261028/acceptance-checklist.json)
extends the preserved118/119 checklists. It supersedes their uniform saved-dialogue
applicability wording and historical custom-root gap without changing those packets.

Only18 selected settings layers directly join old935. Explicit dynamic joins bind
item titles/descriptions, quest fields/history and custom nameplate candidates;
48 nonempty item descriptions and all four compiled empty-cell literals lack old935
targets. Missing nonempty strings and absent DB states remain separate. All30
immutable interface packets receive profile-specific raw/NFC/NFD requirement and
per-face subset checks. Empty projections never pass coverage. The seven saved
dialogue corpora stay separate from these interface projections and current final
role wording remains unverified. No live target overlay is read.

Pinned Noto SC/JP Regular2.004 and LiberationSans439 remain trial candidates,
with explicit face/hash/license/application limits. Fictional mouse3324/material3/
atlas245 and38 pinned phonetic rows are preserved. No resource or texture is made.
Next static work must produce a finite resource plan for original dynamic fallback
1017/native roles and the pinned candidates under the existing no-texture guard.
Actual native shaping/bidi/marks/metrics/narrow layout/input and loaded-face proof
still require applicable owner-authorized runtime; repeated cmap checks cannot
pass them. Source/editorial/final fonts/resource/runtime/release gates remain open.

## Current resource plan, phase148

[The exact binding/change/readback plan](resource-plan-20261028/PLAN.md) completes
the former next static assignment without producing font or texture assets.
It preserves all109 selected bindings and84 candidate decisions, pins original
1017 -> source Font439 / material10 / empty runtime atlas74, and distinguishes
global missing-character fallback from whole-face native replacement. Default
TMP1018 already has local fallback1017. The three native367 inventory/plugin
labels need their own exact pointer selector; the response helper cannot select
them. Pinned CJK OTF candidates are incompatible with the current hardcoded439
recipe until a coherent import/metrics path and native loading are verified.

The normal path leaves primary static TMP tables/materials/atlases unchanged.
Both --coherent-tmp-face guards remain unchanged. Full original texture-object/
external-stream equality and a matching actual new-face positive control are
specified but not run; dynamic in-memory caches are a separate native boundary.
The new15-row checklist extends the previous finite checklist without waiving
any source/editorial/font/resource/runtime/visual/delivery gate.

`python3 -B localization/fonts/resource-plan-20261028/plan.py --check` reproduces
163 pinned inputs,140 resource facts and nine targeted metadata rejection controls.
No original install, game, image, builder or font parser is opened. Next static
work binds the10 profiles to currently available immutable editorial deliveries
for the seven saved locales; missing/active and unbound role states stay explicit.

## Russian runtime supplement, 2026-10-28

`russian-runtime-20261028/CURRENT.md` and `current-status.json` record the current boundary: six candidate05 menu frames retain visual acceptance; after the authorized bottle restart, candidate06 notifications2 and quest7 frames pass native/visual checks. A native-pixel crop resolves the received icon. Both new jobs run fullscreen after the original resolution-reset, with exact disposable save bytes; windowed mode remains unaccepted. All original1,385 texture objects and complete streams compare exact. The earlier README/verification.json retain the initial dynamic multi-atlas repair evidence. Three native367 pointer changes pass static checks; individual live fields remain untested. Existing role/resource packets retain historical fingerprints; old builder pins are superseded, not refreshed.


## Immutable editorial applicability, phase150

[The verified finite handoff](final-corpus-bindings-20261028/ADAPTER.md) completes the70-cell source/target applicability reconciliation and reuses existing149 data outputs. Three exact current corpora have12,246 IDs/24,492 occurrences each; four locales lack a final immutable editorial delivery. Existing935 projections contribute2,093 exact role/locale target joins without filling48 item descriptions or four compiled empty-cell omissions. Saved dialogue hashes for ru/zh/de are superseded. Russian NFD U+0306/U+0308 and German NFD U+0300/U+0308 exceed the old report universe and cannot inherit font coverage. No font scans or new resources were produced.

Parent recovered the original pinned bind.py bytes after the accidental phase150 replacement; the original --check reproduces all preserved outputs. Both later revisions remain separately preserved. verify_phase150.py --recovered-recipe --check verifies55 current pins and13 rejection controls; use parent-recovery-verification.json for the current state. Historical phase150 receipts retain their original recovery gap. No unchanged static continuation is proposed. Exact role allocation/omitted-source target deliveries and the existing source-policy/native decisions remain the next owning actions. Preserve the separate Russian runtime supplement and every full-game acceptance gate.
