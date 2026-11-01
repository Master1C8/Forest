# Obsolete test payload cleanup

The owner authorized removal of unused old test game/build copies while preserving current tasks and completed localizations. This cleanup selects individual exact duplicate payload files, not whole directories by name or date.

Preserve all distributions, source assets, frameworks, source inventories, font data, the accepted owner test build, the five current locale runs, the recently delivered six-locale run, prior cleanup reconstruction anchors, files mentioned by current source/control inputs, tracked files and open-file trees. Also retain all saves, screenshots, authored wording, recipes, logs, metadata and unique binary versions. A historical directory modification time is never inactivity evidence.

`cleanup.py plan` records source and retained-copy signatures, SHA-256, modes and extended attributes in `plan.json.gz`. `cleanup.py apply` rechecks current protection, every retained anchor, every selected file and the complete final-distribution/framework/completed-language fingerprint before deletion. The deletion ledger is append-only gzip JSONL; interrupted work must be reconciled before any retry. A replacement task or disappearance from a process list alone is not deletion authority.

The apply phase exercises one actual exact-path restoration from retained bytes, checks its hash/attributes, then returns that selected duplicate to its pruned state. Any removed file can be reconstructed from its ledger row using the preserved prior helper's `restore_row` function; never use its old CLI `restore` action, which loads a different plan. Prior anchor paths remain intact so earlier cleanup restoration remains valid.

Regression: current Thai/Arabic tasks may read a historical source file later even when it is not open now. Current task pins and source/control path references protect that historical run before selection. A candidate with unique bytes, changed nested contents, unknown extended attributes, an owner-save name, a tracked path or no retained identical copy is kept. All five CLI processes continue running throughout this cleanup. No game, GUI, publication, deployment or process/server lifecycle action is performed.


Completed verification: 33046 duplicate files removed; 1022 final/framework/completed-language files verified unchanged; 3235 restoration anchors verified. Project du decreased from 77.31 GiB to 48.49 GiB. Observed filesystem free space increased by 10.65 GiB; this is distinct from summed duplicate sizes and concurrent filesystem accounting. All five original current CLI processes remained alive.
