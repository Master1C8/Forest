# Forest complex-script feasibility

The owner-approved Arabic feasibility probe is complete. The shared compiler
now supports ar/fa/he/hi/th. Each has its own accepted seven-scene native set in
`localization/screenshots/all30-owner-20261104-01/<locale>/final/`. Those receipts
bind exact resource/language versions; they do not establish unexercised scenes.
Runtime verification uses disposable game copies. Locale wording, control
identities and owner saves remain unchanged.

`font_shaping.py` derives deterministic positioned PUA glyphs from the existing
Sonic mechanism. Provenance and the OFL font license are retained. The pinned
environment is `.venv-shaping`; install `requirements.txt` there, without changing
the established asset compiler environment.

`TextShaper` runs through TMP's `ITextPreprocessor`. The component's logical
`text` remains unchanged. Native Unity Text is tested through a display-only TMP
child in `LegacyMirror`; the source component, text and references remain intact.
The original mesh is suppressed only during rendering. Accepted scenes exercise
menu opacity, settings, gallery controls, inventory, quest history, resident
selection refresh and the original Maverick dialogue. Preserve those exact
receipts and their explicit per-frame reuse proofs; wider game coverage remains
separate from these finite checks.

The first native blind test found coherent Arabic joining but reversed Arabic
digits. A second test found counter/URL run-order reversal. Glyph preparation now
retains logical numeric runs; `BidiOrder` resolves display order with pinned
BidiSharp source. Numeric date/counter separators receive numeric-field treatment
without changing their glyphs. Rich-text style metadata follows glyphs. Prepared
values are serialized and read back in the probe, with a no-double-shaping check.
This is bounded corpus evidence, not exhaustive Unicode conformance. The retained
vendor implements Unicode6.3; supplementary characters and U+FFFF reject in this
experimental adapter. Do not silently widen its accepted scope.

Reproduce the adapter and cheap checks before native preparation:

```
python3 -B tools/complex_text/prepare_bidi_source.py
.venv-shaping/bin/python -B -m unittest discover -s tools/complex_text -p test_font_shaping.py
dotnet run --project tools/complex_text/BidiTests.csproj
```

`prepare_probe.py --attempt <new-id> --legacy` freezes the bridge, map, source and
font resources. `run_probe.py --attempt <id> --gallery` uses original menu callbacks,
guards actual rendered menu opacity/characters/culling, captures native PNGs and
waits for save-preserving cleanup. Keep every immutable attempt and rejection.
`stage_probe_review.py` prepares hash-bound queues; it sends no model request.
Fresh explicit Sol/high/OpenAI review is separately authorized by the owner.

The first automated probe exposed a readiness defect: active buttons and loaded
strings can precede the menu's visible animation. Reuse the rendered-state guard;
do not treat an empty menu as evidence about shaping.

The complete Arabic route also exposed two layout boundaries outside string bidi:
the gallery label and On/Off values are separate original controls, and the
foreground quest panel can cover a heading's descenders. Group ordering must
preserve the original controls and callbacks. Heading acceptance requires visible
clearance, using a source-bound crop when the full-frame preview is ambiguous.
Do not accept an unchanged logical string or character count as proof of either.

Review preparation must include the authored inventory heading and complete camera
description, plus the quest heading, every sidebar title, description and all history entries. Deduplicate
identical source variants; do not omit these fields or repeat whole dialogue audits.
