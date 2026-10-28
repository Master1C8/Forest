# Static character preflight for the 30 supplemental locales

This report covers the exact existing 935-unit packet for each of the 30 target
locales. It is preparation for the omission repair, not acceptance of those
packets, the newly discovered source, or a delivered game build.

`supplemental-30-20261028.json` pins the source catalog, locale scope, all 30
target files, original font metadata, candidate provenance, and both inspecting
scripts: 50 input fingerprints. Ordered IDs and source values match the common
catalog in every locale. Eleven original font resources and two existing,
unmodified Noto CJK candidates were inspected separately. An external Arial
resource without an embedded character map has unknown coverage.

The script reports raw, NFC, and NFD character sets separately and their union.
The union is a conservative superset: markup and normalization alternatives can
overstate rendered requirements. Missing source families can add requirements.
Consequently neither the union nor the current packet is a final character set.
For example, the two CJK candidates contain every raw Russian codepoint in this
packet but lack two combining characters introduced by its NFD form. That is a
normalization-path question, not proof that the Russian game shows two boxes.

Original embedded Liberation Sans covers this packet's raw Russian and Hebrew
sets. It lacks 650 raw Simplified Chinese, 654 Traditional Chinese, 482 Japanese,
43 Arabic, 59 Hindi, and 58 Thai codepoints. These are static cmap differences,
not observed rendering failures. The existing CJK candidates cover the raw CJK
sets, but cmap coverage does not select the proper locale glyph forms. Their
coverage cannot fix Arabic, Hindi, Hebrew, or Thai requirements.

Actual component/font-role bindings, fallback assignment, fictional-script
mapping, Arabic joining, bidi ordering, Indic/Thai shaping, marks, spacing,
wrapping, and native readability still require their own evidence. Hebrew cmap
coverage alone does not establish correct RTL layout. No fallback union or
unverified face is treated as a passed role. The existing fictional-language
font mapping remains unchanged.

Reproduce with a new project-owned output path:

```sh
.venv-assets314/bin/python -B tools/supplemental_font_preflight.py \
  --output localization/font-checks/NEW-supplemental-check.json
```

Recheck affected corpus requirements after source admission and target repairs.
Do not reuse this report to pass source, editorial, renderer, or release gates.
The check launches no game and changes no fonts, textures, installation files,
or saves. Source and input fingerprint failures occur before output creation;
the single exclusive report write is not a multi-file transaction.

Regression: raw precomposed coverage and NFD combining-mark coverage must remain
separate; an absent external cmap must remain unknown; all 30 exact packet
identities must be checked before any font coverage report is written.
