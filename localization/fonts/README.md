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
