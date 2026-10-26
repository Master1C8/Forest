# Russian isolated preview repair

The current repair is a provisional runtime test for The Forest of Love0.45.
It does not accept the incomplete whole-game inventory or the locale's semantic,
independent-diff, resource, runtime or release gates. Six preliminary dialogue
audits keep their original source/target/glossary inputs unchanged.

`tools/build_russian_preview.py` takes an explicit unique `--qa-product`, such as
`ForestRuActual20261027_04`, and a new `--output` directory. It refuses an existing
output or a non-QA product. The original install and owner saves are read-only.
Every new run must verify the QA profile is unused before launch. The builder
preserves complete original no-op/readback equality and unselected object bytes.

`tools/russian_preview_ui.py` owns the display corrections. The existing TMP face
replacement changed the baseline contribution while authored `m_lineSpacing`
stayed unchanged, including the warning's negative32. The recipe compensates
each exact font binding using the shipped TMP formula, preserving the original
baseline distance across body, outline and glow layers. This is a shared metric
correction, not per-string whitespace/glyph repositioning. The warning's four
authored source/target variants bind12 actual Unity fields, with real newlines,
color and underline tags preserved. The baked WARNING heading is unchanged art.

The Actor projection changes exactly Scarlett's `nameplate_name` and `full_name`
cells to the approved Скарлетт and Скарлетт Нежнолапка. Actor/row/field identities,
plugin names, savekeys, schema and every other column remain exact. A repeated or
ambiguous old/new state rejects. The ordinary introduction mask and engine's
existing override behavior are preserved. Source actors are never globally renamed.

Six focused tests exercise real original warning bindings, an unrelated-font
negative, real BGDatabase projection/preservation, overlapping old/new states,
the font equation and cache selection. They establish static boundaries, not
actual rendering or dialogue advance. Every repaired native frame still needs
fresh bounded original-resolution inspection; normal input progression needs
actual guarded before/after semantic states and delivered event edges.

## Storage and interrupted work

The earlier external-to-internal game copy exhausted local space and interrupted
eight CLI requests. Discarded unlaunched game clones02/03 were reconciled and
removed after exact task ownership/content/process checks. Their recipes and
failure evidence remain under outputs/ru-ui-repair-20261027/. Original game,
owner saves, accepted01 evidence and all translation batches were preserved.

Set `FOREST_RU_CLONE_CACHE` to an existing project preview's `game` directory to
reuse only files whose complete SHA-256 equals the original installed file.
`clone_file` uses APFS copy-on-write when available, keeps distinct inodes and
verifies the copied bytes against the original. Modified cache files fall back
to the original source. A clone receipt is saved before resource replacement.
Freeze the launcher, all helpers and inputs in an immutable run recipe; set
`FOREST_RU_INPUT_ROOT` to that recipe's pinned input snapshot. Do not change an
active run's version. The builder requires512MiB free before starting.

Editorial recovery uses `editorial_lane.py run --reconcile-interruption` with
the exact lane-owned storage receipt. Verify the old supervisor, worker and
children are absent, pins unchanged and space recovered first. A completed
contiguous batch prefix keeps its exact review hashes. Preserve an unfinished
batch and restart it in a new attempt directory/fresh context; do not credit
partial decisions as a complete batch. Before model dispatch retain256MiB free.
The regression uses a fake CLI/process guard and does not prove model semantics.

Technical static-source recovery uses a separate `storage-interruption` receipt
through `run_serial_ru.py --reconcile-interruption ... --git-coordinator parent`.
It requires original storage-error evidence, exact artifact/HEAD binding and no
surviving task processes. A static phase with no game launch does not invent
runtime quit/bridge-cleanup acknowledgements. Parent alone stages and commits.
Every interrupted request's exposed token subtotal is separate from successful
retries; missing final usage stays unknown. Never sum cumulative milestones.

Regression: with six active semantic streams and a static technical worker,
an unlaunched preview build hits ENOSPC after partial output. Preserve all source,
target and completed review hashes; reconcile all surviving children; restore
only interrupted attempts with explicitly pinned non-Astra models after space
recovers; create a new isolated clone-aware preview without overwriting partial
evidence or claiming a screenshot proves ordinary dialogue advance.
