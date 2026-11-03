# Compiled-language native QA

The existing isolated game adapter accepts the common compiler's delivered
`forest-compiled-language-v1` resources through explicit configuration. This is
one shared test adapter; language wording remains in `localization/languages/`.
Historical German configurations and frozen executions retain their original route.

Additional configuration fields are `compiledLanguage`, `textAcceptance`,
`framework` (each an exact path/SHA-256 pin), `entryPins`, `questBodyId` and
`menuGuards`. Culture comes from the exact language file. Use a unique
`localization/probes/<locale>-...` run and a `ForestQA<LOCALE>...Probe...` product.
The source game, candidate and owner save files stay unchanged. All later-read
helpers/configuration are copied into the immutable execution snapshot.

`compiled_contract.py` checks the complete 14,606-state inventory, all 1,781
protected states, actual current-version independent passes for all 12,825
ordinary states, independent identities, required-context evidence and glossary
pins before copying or launching. A compiler manifest alone is insufficient.
The actual source members must match the compiler framework before cloning.

The compiled route defaults to five useful screen types: menu, settings, original
dialogue when present, the inventory item with greatest measured text height,
and the original Finley quest pane. It also checks all 48 inventory items and
four empty/consumed branches through the original consumer, plus saved-resource
readback. Missing original dialogue or progression remains an explicit pending
scenario. Additional menu panels require an explicit `extraMenuPanels` list.
Native capture uses the existing project game-thread bridge and original
ScreenCapture, not desktop clicks. All frames require separate bounded visual
review under `SCREENSHOT_REVIEW.md`.

Preparation: `.venv-assets314/bin/python -B
tools/probe/locale_runtime_v1/prepare.py --config <pinned-config.json>`. Launch with
`python3 -B tools/probe/locale_runtime_v1/launch.py --config <pinned-config.json>`;
it executes only the resulting frozen `execution/runner.py` and probes Pillow
before starting a game. Keep the lexical `.venv-assets314/bin/python` path:
resolving its symlink chooses the base interpreter and loses the environment.
Restoration runs unconditionally;
unknown outcomes require exact process/action-log reconciliation before retrying.
No publisher, installer, server lifecycle or owner-session operation is included.

The four original empty-inventory branches use their exact compiler managed IDs
and original source strings. Legacy per-language IL-offset IDs are not used as
language keys. Optional notebook-heading metrics compile only with the explicit
`FOREST_NOTEBOOK_HEADINGS` resource/configuration contract; other batches reject
that command rather than inventing a measurement pass.

Regression checks: `python -B -m unittest discover -s
tools/probe/locale_runtime_v1 -p 'test_*.py' -q`. These exercise actual input hashes,
versions, preservation, editorial coverage, reviewer identity and exact resource
bindings with synthetic fixtures; they do not establish game loading or rendering.
