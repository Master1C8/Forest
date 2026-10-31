# Verified duplicate cleanup, October 31, 2026

Owner request: remove unnecessary temporary files. Deleted 2,815 exact duplicate
files (9,974,478,362 logical bytes) from completed disposable QA games, superseded
compiler artifacts and three task-owned reconstruction/prototype snapshots.
Observed free space increased by 9,978,593,280 bytes, from 6,293,041,152 to
16,271,634,432 bytes. These are point-in-time filesystem measurements; other
applications can also change free space.

Every removed file had a retained counterpart with matching size and SHA-256.
The plan records original paths, modes, mtimes and extended attributes. All 86
unique resource files remain. Metadata, source/configuration snapshots, logs,
screenshots, translations, saves and tracked files were excluded. Only exact
duplicate pinned inspection JSON inside migration-work was eligible among JSON
files. No process, model, game, server or installer was started or stopped.

Current German `dist/Forest-de-25cfdea9b625`, current Russian
`dist/Forest-Universal-Russian`, shared framework and owner Russian builds remain
complete. Their 16, 16 and 171 manifest members respectively passed size/SHA-256
verification after cleanup. Twenty-two disposable QA games still matched their
recorded restored fixture state. Twenty-one previous cleanup maps/receipts
contained no references to these newly deleted paths.

Historical QA copies and superseded compiler directories are now sparse. Keep
their remaining unique bytes, manifests and evidence; restore missing members
before reusing a historical artifact. `retained-files.json` lists the 322 retained
companions. Do not delete or overwrite these without verified replacement and
updated dependent restoration maps.

From the canonical project root, restore one missing member using its exact
project-relative path from `plan.json.gz`:

```sh
python3 -B localization/cleanup/20261031-verified-duplicates/cleanup.py restore --path 'PROJECT_RELATIVE_PATH'
```

The restoration tool checks retained bytes and reconstructs mode, mtime and
quarantine/provenance attributes. Existing differing files are rejected. Actual
restoration was tested for both observed attribute combinations before deletion,
and for a 134,554,448-byte resource at its original selected path afterward;
the tested duplicate was then removed again. This verifies file restoration,
not gameplay continuation. No game was launched.

`plan.json.gz` and `deletions.jsonl.gz` match exactly. `result.json` records the
application boundary and filesystem measurements; `verification.json` records
postconditions. The initial unsupported-Python-API failure and zero-selection
attribute-exclusion plan are retained separately; neither deleted files. The
applied plan and receipt are immutable evidence, not a generic cleanup queue.
Application unlinks files individually, with a flushed ledger; it is not a
multi-file transaction. An interrupted apply must be reconciled against its
ledger and actual files before any further action, rather than blindly rerun.
