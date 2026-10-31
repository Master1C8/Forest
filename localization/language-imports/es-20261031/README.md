# Spanish single-file conversion, October 31, 2026

Spanish (Spain), `es` / `es-ES`, is available in
`localization/languages/es.json`. The final file has 14,606 explicit targets and
zero unread targets. This is the registered storage inventory, including protected
values, not a count of distinct visible Spanish phrases or editorial acceptance.

```sh
./forest-localize build localization/languages/es.json
```

The verified output is `dist/Forest-es-b419595e61ea/`, containing 16 resource
overlay files and the completion/input manifests. It was not installed or run.
Ordinary compilation reads the one language JSON and shared framework directly.
No language-specific builder, worker, technical stream, translation service,
installer or game was started. The coordinator model was verified as
`gpt-6.1-sol`, high, OpenAI. Owner-stopped queues remain stopped.

## Migration and finite repairs

Existing Spanish dialogue, transferred family wording and saved shared resource
plans supplied the text. Current exact-ID/source matches take priority; ambiguous
source-only matches remain unread. `commands.json` and `input-pins.json` bind the
two migration steps and original data. The generic importer now also accepts a
shared JSON resource plan's `edits` array.

The shared `forest045-shared-v2` catalog adds twelve already inventoried inventory
heading layers omitted by the earlier Russian difference-only catalog. The new
extension command verifies exact original resource hashes and original/baseline
field values. It preserves the v1 framework and all resource snapshots. The saved
Spanish package reads back `<size=22>I</size>NVENTARIO` and
`<size=30>I</size>NVENTARIO` across all twelve actual native fields.

Forty-seven IDs needed new authored wording or an explicit contextual selection:
main-menu variants, two Finley inventory descriptions, Mouse's speaker caption and
the two journal section headings. `authored-additions.jsonl` includes twelve
additional heading proposals that were unnecessary because the first migration
already found their exact existing Spanish wording. Only the 47 IDs listed in the
language file's `newAuthoredIds` were newly applied. These versions have no newly
claimed independent review.

The first compilation correctly rejected a protected original value translated
by the old draft. A complete dialogue preflight found 619 such source-preservation
violations and two translated `ADVICE ` service prefixes. Every restored value
matches both the pinned source disposition and accepted baseline; the prefixes
retain the original Spanish display text. `source-preservation.json` preserves
all previous drafts and exact replacements. The old Spanish corpus and batches
were not modified, and source strings, controls and glossary were not changed.
These are source-contract repairs, not new semantic coverage or claims that the
source-held text can never be displayed.

## Verification and remaining acceptance

| Artifact/predicate | Evidence | State and next action |
| --- | --- | --- |
| Complete registered language file and controls | `final-preflight.json`: zero missing targets; all 12,246 dialogue IDs checked | Passed structurally. Do not infer a full semantic pass. |
| Saved resource overlay | `verification.json`, `build-manifest.json`: 16 exact file hashes, 14 readback proofs, twelve heading fields read from the saved output | Passed static compilation/readback. Existing German/Russian package hashes and v1 snapshot pins remain exact. |
| Shared compiler regressions | `unit-tests.log`: 13 passing tests | Input rejection, preserved controls, ambiguity, publication conflicts and actual partial-file continuation pass. Unity decoding is replaced only in the small native-extension publication test; real heading readback is separate. |
| Spanish character requirements | `font-preflight-final.json`: exact embedded faces and positive space advances | Liberation Sans covers the Spanish letters/punctuation, including `¡¿«»`. Moire faces lack Spanish glyphs; actual role/fallback allocation and fit remain unaccepted. Preserve the separate fictional-language mapping; do not replace it to cover its two phonetic characters. |
| Final editorial acceptance | Original exact-version receipts retained; 47 new authored IDs identified | Needs review. Reconcile final hashes with the owning retained evidence, then independently review the genuinely missing/invalidated units and their necessary context. No fresh reviewer was authorized or launched. |
| Native/game/visual behavior | No new game, GUI, fixture or screenshot execution | Not run. Complete the text prerequisites, then use applicable owner-authorized final game checks. Static font tables and saved strings do not establish native rendering or gameplay. |
| Installation/publication/release | No activation or publication | Not run; separate authority remains required. |

The extension's relative-path metadata prerequisite failed before creating its
output; the corrected command completed. The first saved-overlay inspection
needed the immutable framework's MonoScript companion, since an overlay does not
ship that unchanged original metadata file; inspection then passed without
changing the package. Initial failed build/inspection diagnostics remain under
`outputs/es-single-file-20261031-01/`. Their successful successors do not erase
the earlier attempts.

Framework and package publication use sequential exclusive writes and a final
completion manifest. They are not installation transactions. Existing matching
partial files are reusable only through verified continuation. No stopped model
job or interrupted editorial judgment was promoted to accepted coverage.
