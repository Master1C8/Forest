# Japanese single-file localization

The Japanese language document is `localization/languages/ja.json` (`ja-JP`),
using the same `forest045-shared-v2` framework and `./forest-localize build` route
as the other locales. It contains all 14,606 catalog entries: 12,825 ordinary
linguistic units and 1,781 exact preserved source/control/fictional values. The
211 initial null targets are filled. Historical drafts and owner-stopped queues
remain preserved.

The primary editor read all 12,825 ordinary source/target units and required
context, repaired 456 authored versions and independently handed them off with
151 concrete dependencies. The independent CLI reviewer read all 607 assigned
versions and 845 required context rows. Its four findings were two haiku choices
and their exact evaluation copies. Separate context observations identified
first-use priority, reconciliation wording and spoon/cuddling wordplay.

One consolidated seven-version repair addresses those findings. The owner
explicitly chose poetic 5–7–5 adaptations of “Oh falcon!” and “Why do you toil?”,
allowing affection and the exact present-necessity nuance to remain implicit.
No other source loss is authorized by that decision. The final independent delta
covers all nine display/evaluation pairs plus the three prose repairs (21 IDs),
207 full-scene context rows and all 27 selectable compositions. See
[acceptance.json](acceptance.json) for the actual version-bound verdicts and gates;
[repair inputs](../../editorial-delivery/ja-single-file-20261101-01/repair-01/changes.json)
retain before/after strings and rationale. Current independent closure covers
610 unique exact versions, not an invented independent reread of the whole corpus.

## Shared font repair

Each of the eight registered ordinary font roles selects the pinned OFL Noto
Sans CJK JP Regular 2.004 face. Conservative raw/NFC/NFD corpus character sets
are unchanged by the final repair and covered by that exact face; this is a
superset check rather than evidence that every string reaches every role.

The previous compiler replaced face data while retaining Liberation Sans native
and TMP metrics. The shared compiler now derives ascent, descent, line spacing
and dependent TMP1017 face/legacy metadata from actual static font tables,
clears stale native kerning, and rejects populated/static dynamic-font caches.
The registered Font439 → TMP1017 route, accepted TMP1020 fallback, materials,
atlases and fictional Font3324/material3/atlas245 remain preserved. The actual
Japanese TMP face metadata matches the previously verified import recipe.

Eighteen tests cover existing input/publication/control regressions, real JP/SC
font tables, the exact Japanese metric reference, positive pointer/atlas controls,
and wrong source/static/nonempty-cache rejection reasons. The final saved-byte
verifier checks the delivered overlay, all 247 original source members, 1,385
texture objects, eight font payloads/native metrics and the complete TMP projection.
These are static serialized-input checks, not Unity font-import acceptance.

Locales with no font replacement retain the existing path. The same shared
metric mechanism handles the Chinese selected face without a locale branch.
The earlier Chinese artifact and editorial acceptance are historical immutable
results; this Japanese task does not silently rebuild or accept Chinese fonts.

## Delivery and remaining gates

Build from the canonical language file:

```sh
./forest-localize build localization/languages/ja.json --output dist/My-Japanese-Build
```

The final artifact is `dist/Forest-ja-single-file-final-20261101-01`; its manifest,
resource hashes, compiler fingerprint and delivered-byte proofs are recorded in
`acceptance.json`. The earlier author build stays preserved as provenance.

Native CFF loading, actual fallback/atlas growth, shaping, Japanese wrapping and
layout, game interaction and release installation remain untested. No game,
GUI, screenshot, installer, publication, deployment or server session was started.
Human NSFW glossary review remains owner-deferred. Text/static acceptance does
not close those separate gates. The next runtime action requires the owner's
applicable instruction and must test this exact delivered version.

[Measured usage](usage-report.json) separates the three fresh CLI phases from
partial mixed coordinator work; cache and reasoning counts are subsets.

## Review preparation recipe

The review publication helper requires `contextPackets` to contain JSONL and the
next task to use a supported kind such as `work`. Keep pretty-printed structured
contracts immutable, pin/read them as documents, and, when a helper needs them
as packet input, provide one lossless JSONL wrapper per document. Do not pass a
multiline JSON file as JSONL or invent a next-task enum. Regression: both structured
haiku/context contracts round-trip semantically through the wrapper, every original
pin remains exact, the 21 assigned IDs and 207 required context rows remain unchanged,
and final publication succeeds without disabling validation. The delta phase retains
its original/effective task and `transport-adaptation.json` for this repair.
