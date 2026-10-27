# Portuguese (Brazil) provisional dialogue recipe

Exact locale: `pt-BR`. Reuse the approved glossary and pinned shared source from
`outputs/locale-assets-20261026/pt-BR/input-pins.json`. This is the existing
`translate-edit` stage, covering 12,246 dialogue/menu candidates and 24,492
physical occurrences. It is not the whole-game source denominator.

Run from `/Users/antonkrutov/Desktop/Forest`:

```sh
PYTHONDONTWRITEBYTECODE=1 python3 localization/pt-BR-assets/test_adapter.py outputs/locale-assets-20261026/pt-BR/0031-translation/adapter-regressions.json
PYTHONDONTWRITEBYTECODE=1 python3 localization/pt-BR-assets/corpus.py build
PYTHONDONTWRITEBYTECODE=1 python3 localization/pt-BR-assets/check_poetry.py
```

The builder checks input pins and both complete source trees. `display-spans.json`
permits only the two exact flower-narration occurrences, binding source hashes,
field pointers, physical occurrences, bracket ordinals/spans and immutable
consumer evidence. Unknown brackets remain opaque. Recognized engine syntax,
nested/quoted Lua, variable operands, rich text, placeholders, numeric literals
and LF/CR/pipe counts remain exact. Both original bracket delimiters stay intact.
The two pre-existing unmatched closing brackets elsewhere in the source are exact
protected tokens, not source repairs.

`hold-resolutions.json` binds the two historical holds to their original TSV bytes,
previous reasons, source hashes, authored proposal hashes, accepted targets and
new target batch. The old TSV files and hold lines are retained byte-exact.
Only batch `0124-flower-hold-resolution.tsv` supplies the resolved targets. No
source/glossary changes, retired targets, detached technical records or other
locale records are introduced.

After rebuilding, verify the poetry report binds the current overlay hash. A
build resets poetry status to pending; never credit a stale poetry receipt. Phase
0031's `validation.json` records preservation of all 12,244 previous targets and
all 123 previous TSV files, plus the full candidate/source-pointer comparison.

Regression tests use actual pinned flower records and source trees for the
occurrence-bound path; synthetic scanner pairs separately test nested Lua,
quotes, tags, placeholders, numbers, separators and unknown brackets. Changed
source/evidence/occurrences and changed controls must fail at the named boundary.
The normal flower targets must pass with their approved bindings and fail as
opaque prose without approval. Two real anomalous closing-bracket records must
pass unchanged and reject removal of that delimiter.

Writes use individual atomic file replacement, not a multi-file transaction.
An interruption may leave generated outputs at different versions. Preserve the
authored TSV, manifests and receipts; rerun the normal build and poetry check,
then reconcile progress against the resulting hashes. Do not infer rollback
from a failed command.

Counts distinguish translated wording, individually reviewed unchanged visible
targets, technical preservation records and holds. The legacy
`reviewedUnchangedPunctuationIds` field aliases all reviewed unchanged targets,
including proper names and encoded speech; it is not a punctuation-only count.

Zero holds permits `draft-complete` for this provisional dialogue family only.
Shared source/renderer/special-scene acceptance, complete semantic and independent
diff audits, resources, runtime, packaging and canonical integration remain pending.
This lane does not mutate Git, shared files, other locales or supervisor files.
