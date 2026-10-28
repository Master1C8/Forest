# Per-image visual acceptance

Applies to prepared copies bound to native originals or delivered gallery images. Review every frame;
a complete technical manifest or a passed earlier stage cannot substitute for this read.

## Inspect the whole frame

Review the full-frame WebP80 copy, longest edge at most 1280 pixels, without upscaling.
For unresolved details use a source-pixel crop under the same size limit and record its
source hash and bounds, or return needs-review. Crops supplement the full frame.
Never claim native-pixel precision from the reduced copy. Check all visible surfaces,
not only the main dialogue: title/menu, buttons, HUD/counters, speaker names, tooltips,
settings, save slots, logs, item descriptions, texture text and overlays when present.

- **Layout:** text stays inside its actual field with padding; no lost first/last
  characters, clipped ascenders/descenders/marks, button truncation, overlap, off-screen
  lines, broken wrapping or ellipsis hiding required information. Right alignment alone
  does not prove RTL support. Auto-sizing being enabled does not prove the text fits.
- **Glyphs/readability:** no tofu, replacement glyphs, detached marks, collapsed/missing
  spaces, broken joining, mismatched fallback fonts, unreadably small or faint text.
- **Content:** correct apparent locale and complete visible text; compare to authored
  text/source context for suspected omissions, unexpected source fallback, placeholders
  or visible rich-text/TMP tags. Intentional names/source literals need evidence, not a
  blanket failure or blanket exemption. This is not another full corpus semantic audit.
- **Contamination:** no OS/storefront/Game Mode/achievement/chat banner or added locale
  label. Record failure and request recapture; do not conceal it by editing the image.

## RTL on every frame

For every RTL image inspect each visible text area, both its paragraph and embedded runs:

1. Read Arabic/Persian/Hebrew in the intended order. Check letter joining where the
   script requires it, contextual forms, ligatures, vowel/combining marks and diacritics.
   Hebrew letters need correct order/marks, not Arabic-style joining.
2. Latin names, player input, acronyms and filenames remain internally LTR: `Sonic`,
   `Shadow`, `zel` must not become `cinoS`, `wodahS`, `lez`. Check placement relative to
   surrounding RTL words, not only the spelling of the isolated name.
3. Numbers, quantities, counters, currency, percentages, signs, fractions, times and dates
   preserve their intended digit order and separators. Check parentheses, quotes,
   colons, sentence punctuation and punctuation at RTL/LTR boundaries against context;
   visual position is contextual, not a rule to reverse every punctuation mark.
4. Paragraphs start/align as intended for the actual UI; inspect both field edges, long
   labels, multiline order, last lines and any icons. A whole-frame mirror is not a fix.
5. Compare static serialized/pre-shaped labels with dynamic dialogue/player values.
   PUA glyph paths must not be double-shaped or lose direction; inspect compensated
   Latin/digit runs after final rendering. Font cmap/PUA validators cannot prove this.

If a frame has no mixed text, record that limit while reviewing its other RTL content.
Across each RTL locale require a text-rich mixed RTL/LTR frame when the game can produce
one; otherwise record the missing scenario separately. Do not label an unexercised mixed
path passed or claim screenshot review proves dialogue progression or language-picker
navigation. Those require their existing runtime checks.

## Findings and repair closure

Use one row per image and identify every defect by bounding region or a precise UI label.
Severity: `blocker` (unreadable/wrong script or meaning-critical lost text), `major`
(overflow, clipping, reversed runs, broken marks, literal tags), `minor` (visible spacing,
alignment or readability defect). Every open objective defect blocks this gate, including
minor defects; uncertainty stays needs-review. Avoid preference-only redesign proposals.

Separate observed evidence from diagnosis. Trace the authored text → shaping/font/layout
→ packaged payload → native frame → encoded/hosted image boundary before proposing a fix.
Change the shared mechanism when the same defect class affects several locales. Review
all affected screenshots/locales after changes; central bidi/shaper changes invalidate
all dependent RTL frames. A new image or changed binding invalidates its old receipt.
Unchanged non-RTL evidence may be retained only with verified applicability. Append a new
cycle and link prior findings; never overwrite the failure evidence or imply the previous
version passed. Reupload is a separate authorized write.

Final report: scope and artifact identity, counts by locale and overall, each finding with
image/region, unresolved scenarios, review ledger and export hashes, precise next action.
Historical gallery quality and published-release status remain factual separate records.

The checklist incorporates observed project boundaries: Sonic's Unity/TMP/PUA mixed-run
reversal; No, I'm not a Human's Indonesian exit-button overflow despite enabled auto-size
and clean logs; and This Is the Police's correctly shaped Arabic paragraph retaining
left alignment. These motivate separate shaping, geometry and alignment checks; they
are not claims about the current releases or substitutes for new per-image evidence.
