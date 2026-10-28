# Font feasibility under the owner's no-texture constraint

This is a source-bound preparation note for the 30-locale omission repair.
No font, texture, game package, target wording, installation, or save was changed.
No game or screenshot review was run. It does not pass renderer feasibility.

The existing renderer builder has two materially different paths. Its normal
fallback path changes TMP Settings to reference the existing dynamic fallback
asset 1017 and adjusts face metrics. Its `--coherent-tmp-face` path also selects
the primary font's atlas Texture2D, marks it readable, changes its filter mode,
replaces its image data with zero bytes, and clears stream information. Therefore
that option must not be reused for this task's texture-preserving builds.
Earlier accepted Russian previews remain immutable historical artifacts; this
instruction does not retrofit or undo them.

`tmp_dialogue_font.coherent_tmp_face` also implements only four Cyrillic
diaeresis/breve pairs. Its derivation reads the TrueType `glyf` composite table.
The pinned Noto CJK candidates are OTF files, so neither general script shaping
nor compatibility with that derivation may be inferred from their cmap coverage.
This helper cannot be relabeled as a universal 30-language font solution.

The next bounded feasibility implementation should first test whether the
existing dynamic fallback can use an appropriate embedded outline face while
every original Texture2D object and external texture stream stays byte-identical.
Font data, actual source-Font PPtrs, face metrics, character/glyph caches and
fallback assignment require coherent, per-role evidence. Runtime-generated
dynamic glyph caches must be distinguished from modified texture-file assets;
their correct behavior is not established by this note. Do not clear or redraw
an original atlas as a shortcut.

| Predicate | Current evidence | Exact next action |
| --- | --- | --- |
| Reject texture edits before build writes | Existing coherent-TMP branch explicitly changes Texture2D | Add a texture-preserving build plan/guard before using that branch; reject an incompatible plan before creating outputs. |
| Original font-image bytes survive | No new package built | Compare every original Texture2D raw object and texture-stream file against source after the affected resource build. A font name or selected-object count is insufficient. |
| Actual native/TMP face and binding | Existing original role matrix and custom-nameplate binding; 30-packet static character report | Bind each affected role to its actual face/resource, then use a minimal isolated native probe with the exact required scripts. |
| Character and glyph requirements | `font-checks/supplemental-30-20261028.json` covers only the old 935-unit packets | Recompute affected requirements after source admission and target edits; keep raw/NFC/NFD results separate. |
| CJK locale forms and readability | Only pinned SC/JP candidates; cmap is static | Verify the proper locale face, metrics and actual glyph appearance; shared codepoint coverage does not select Traditional Chinese forms. |
| Joining, bidi, reordering and marks | Not established for Arabic, Persian, Hebrew, Hindi or Thai | Run actual role-specific minimal probes before dependent mass authoring. Record a concrete architecture decision only if those results require one. |
| Fictional writing | Original mouse font mapping is separately source-bound | Preserve font command `mouse`, original glyph mapping and untouched atlas. Ordinary language fallback/shaping must not replace that role. |

Future authorized captures/reviews must follow `SCREENSHOT_REVIEW.md` and
`tools/review_screenshots.py`. Keep the coordinator text-only and prepare new
WebP input at quality 80, longest edge at most 1280, retaining originals. Do not
launch this work through a historical screenshot queue or infer new authority
from the checklist.

Regression: a texture-preserving plan with `--coherent-tmp-face` must be rejected
at the plan boundary; an unchanged repeated build is not proof of preservation.
The positive control must show the intended new face on the actual role while
original texture objects/streams remain exact. Native/script/layout results and
source/editorial/release acceptance stay separate.
