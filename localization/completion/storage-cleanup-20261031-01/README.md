# Verified Forest storage cleanup

Owner-authorized cleanup, October 31, 2026. All localization workers and automatic
continuation remain stopped. No game, model worker or server was started.

Observed free space increased from 4.23 GiB to 26.01 GiB, approximately 21.78 GiB.
This is a filesystem observation, including concurrent system activity and APFS
accounting; logical file sizes are reported separately in `receipt.json`.

- Deleted 77 disposable `noop-*` round-trip outputs whose hashes and successful
  tree/raw-byte checks matched their retained `build.json` receipts.
- Deleted four untracked, regenerable Python bytecode files under current tools.
  Total deleted logical data: 1.79 GiB. Two unverified no-op files were preserved.
- Compacted 2,776 byte-identical large copies through native APFS `clonefile`.
  Every path and byte remains available, with distinct inodes and independent
  copy-on-write behavior. Each replacement retained mode, mtime, ownership and
  matching extended attributes; differing attributes were held. SHA-256 checks
  ran before and after every replacement. Logical recloned bytes are not a
  separate claim of reclaimed physical space.

The entire accepted Russian build was excluded from deletion and replacement.
Its acceptance and delivery manifests, source manifest and stopped queue pointers
match `protected-pins.before.json`. Sources, translations, saves, unique outputs,
screenshots, receipts and frozen execution paths were retained. All 2,033
unrelated pre-existing Git status entries remained unchanged.

Current `tools/build_russian_preview.py` and `tools/build_renderer_probe.py` now
discard a no-op output only after successful readback and report persistence.
Failed checks or report writes retain it for diagnosis. Historical frozen recipe
copies were preserved. The regression in `builder-regression.json` executes the
actual receipt-write/unlink statements with asset processing replaced by a
successful fixture: successful persistence deletes only the temporary file;
an injected report-write failure preserves it. No full game build was run.

`cleanup.py` is the one-shot execution record, not a scheduled cleaner. Its
deletion selection is explicit in `deletion-plan.json` and `deletions.jsonl`;
`compaction.jsonl` binds every retained path to its hash and retained anchor.
The first compaction attempt stopped before any replacement because macOS Python
lacks `os.listxattr`; the corrected attempt used Darwin's native read-only API.
Do not rerun this record as a substitute for a fresh inventory and authorization.
