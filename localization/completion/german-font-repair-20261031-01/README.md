# Shared German font-resource repair

Owner request: complete the missing shared German font support and resume the
existing German task. Other locales remain stopped; no technical stream returns.

The shared `locale_fonts.py` applies an explicit `locale-font-transform`
profile. `locale_font_profile.py` prepares the pinned
data from the accepted Russian font implementation and current German inputs.
No translation, normalization, font download, texture rewrite or installation is
performed. Frozen older executions and the accepted Russian build stay unchanged.

The actual output is
`outputs/locale-assets-20261026/de/font-resource-candidate-20261031-02/manifest.json`.
The source is the independently reviewed combined German candidate from0084/0085.

Actual changes: four native face objects, two ordinary TMP primary faces, seven
native component font pointers, the dynamic fallback and global fallback setting,
and4,286 metric-spacing fields under the existing accepted compensation formula.
All authored texts, component owners/materials and font sizes remain exact.
Complete selected-tree readback passes;124,216 other raw objects,1,220 Texture2D
objects,31 source companion streams, bundle compression/CAB membership and
Addressables CRC/size checks pass. The concrete embedded face covers all108
ordinary-role raw/NFC/NFD codepoints. The38 known-fictional-preserved dialogue
entries remain separately inventoried, with their font and acceptance unchanged.
Table/cmap evidence does not accept native rendering, fallback loading, marks or
layout; final readiness and applicationAllowed remain false.

Five font transformation/early-rejection tests and five saved-candidate transport
tests pass. A real interruption after three output writes left no final manifest;
resume reused and verified those same partial files and published the final
manifest. A fresh `--mode check` reproduced the expected complete artifact.
These filesystem tests do not replace the actual game renderer or independent
integration review.

Preflight corrections were local and published no accepted artifacts: the parser
needed the already-frozen dependency directory; unrelated Unity built-in resource
scripts were excluded from the managed Text/TMP selection; the known fictional
requirement group was separated from ordinary-font coverage; preserved streams
were verified against their exact accepted-Russian anchors rather than the slim
parser directory. The unpublished first profile is retained under
`outputs/font-transform-repair-20261031-01/` as diagnostic history.

To check the actual artifact:

```sh
.venv-assets314/bin/python -B tools/locale_fonts.py \
  --profile localization/resource-profiles/fonts.de.json --locale de \
  --output outputs/locale-assets-20261026/de/font-resource-candidate-20261031-02 \
  --mode check
```

The existing German lane resumes for a finite independent review of the actual
new font integration. Review the changed mechanism and target-specific resource
judgments; retain previous wording reviews and unchanged contexts. No model phase
exists solely to publish manifests or repeat missing-profile checks. All source,
editorial, native, runtime, packaging and publication holds remain explicit.
