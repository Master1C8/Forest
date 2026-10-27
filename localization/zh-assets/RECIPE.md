# Simplified Chinese dialogue/menu draft recipe

This locale adapter implements the shared `translate-edit` stage for the pinned
The Forest of Love 0.45 dialogue/menu family. It retains all 12,246 candidates and
both physical occurrences of each. It does not pass whole-game source, renderer,
special-scene, semantic, independent review, resource, runtime or delivery gates.
The technical lane owns shared integration and Git. Write only this locale's
assets and its permitted job evidence; no nested model jobs or other-locale writes.

Verify the actual process argv is `gpt-6.1-sol` / `high` / `openai` before linguistic
work. Use the approved complete zh glossary once per fresh context. Preserve earlier
authored wording; scripts only store, assemble and validate it.

Rebuild from the canonical project root:

```sh
PYTHONDONTWRITEBYTECODE=1 python3 localization/zh-assets/corpus.py build
```

`locale.json` binds exact locale `zh`. `input-pins.json` and the canonical source
manifest pin the glossary, candidate inventory and both serialized conversation
trees. Source pointer values must match in both trees. Original TSV files remain
the authored recovery source; do not edit or remove their historical `!HOLD` rows.

`display-spans.json` authorizes prose only in the two individually bound flower
occurrences, with stable ID, complete source hash, pointer, both occurrences,
bracket ordinal and offsets, span hash, and immutable own-lane evidence hashes.
`display_adapter.py` preserves each bracket delimiter and exact ordered nested
controls, quoted Lua and variable operands, rich text, placeholders, numbers and
LF/CR/pipe separators. Unknown and unapproved bracket spans stay opaque. Concrete
engine tag families cannot be approved as prose. Source-authored extra closing
brackets in 505:1165 and 512:938 remain exact protected tokens.

`hold-resolutions.json` consumes a historical hold only with an exact receipt:
original TSV file and line hashes/reason, source and occurrence bindings, evidence,
new target batch path and target hash. A missing, duplicate or stale receipt fails
before output replacement. Four phase0032 receipts retain the original held rows;
there are no retired targets. `0115-source-bound-hold-resolutions.tsv` contains two
reviewed flower translations and two exact original tutorial authoring questions.

`technical-preservations.json` and individual `unchanged-reasons.json` entries bind
458:340 and 458:346 to exact source preservation. The static loader/topology facts
support detached technical preservation only. They do not prove blanket runtime
nonvisibility or rule out an arbitrary external direct-node call. The records stay
in the denominator and are reported separately from translated wording. Earlier
tentative zh renderings remain preserved as proposals in phase0031 evidence.

Reproduce the phase0032 checks:

```sh
PYTHONDONTWRITEBYTECODE=1 python3 outputs/locale-assets-20261026/zh/0032-translation/test-adapter.py
PYTHONDONTWRITEBYTECODE=1 python3 outputs/locale-assets-20261026/zh/0032-translation/validate-phase.py
PYTHONDONTWRITEBYTECODE=1 python3 outputs/locale-assets-20261026/zh/0032-translation/validate-poetry.py
PYTHONDONTWRITEBYTECODE=1 python3 outputs/locale-assets-20261026/zh/0032-translation/test-rebuild-recovery.py
```

The validation baseline is the immutable pre-phase target/file map, not a prior
model history. It checks every saved target hash, all original TSV bytes, complete
TSV-overlay equality, both source pointers, pins and exact unchanged categories.
The parser checks pair real positive controls with isolated control/delimiter
mutations and clearly labeled synthetic nested/quoted Lua cases. A real flower
target must pass the bound adapter while the generic opaque-bracket comparison
rejects changed bracket wording. A changed picture operand, nested Lua/variable
operand, rich-text tag, placeholder, prose number or separator must fail at its
intended boundary. These checks do not replace engine execution or semantic review.

Output files are replaced atomically one at a time, not as a transaction. The
recovery test injects failure after the overlay replacement and before unresolved
replacement in a relocated own-phase fixture. It verifies the mixed partial state,
continues from that state to the exact final overlay and zero holds, then checks
idempotence only after the first successful application's postconditions. Rebuild
from the preserved TSV/config/receipts to recover an interrupted output set.

Final family counts: 12,246 retained candidates / 24,492 occurrences; 12,171
translated wording fields; 28 unchanged punctuation, 43 unchanged constructed-
language fields, 2 exact commands, and 2 detached technical records; zero held or
unvisited fields. `draft-complete` applies only to this provisional source family.
