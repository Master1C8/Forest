# Finished temporary fixture cleanup, October 29

The owner requested removal of unnecessary temporary files. This pass removes
only native resource files from nine explicitly enumerated, completed Bio/input
and Pause test fixture directories. No worker had these fixtures open at either
preflight. The owning Bio/input job reports completion; the later completed
boundary and Pause validations remain preserved. Source, code, reviews, logs,
screenshots, unique negative-test mutations, frozen execution snapshots, compiler
dependencies, final deliverables and earlier cleanup reconstruction sources stay.

193 ignored files, totaling 4,001,756,073 logical bytes (3.73 GiB), were removed.
Every selected file was matched by complete SHA-256 and length to an actual
retained resource outside the deletion scope, then rehashed immediately before
removal. Seven unique resource files were deliberately preserved. All 44 retained
sources were rehashed after cleanup. A real copy-and-hash reconstruction of one
removed resource passed, and the temporary reconstruction copy was removed.

The full protected owner-build tree (15,112 regular files), launcher and delivery
manifest retained their exact device/inode/size/mtime/ctime fingerprints. No game
was launched or stopped. No owner saves or settings were selected for deletion.

Measured available disk space rose from 14,243,733,504 to 14,425,509,888 bytes:
181,776,384 bytes, approximately 173 MiB. Logical removal is larger because of
APFS shared storage; this is not a claim of 3.73 GiB physical recovery.

`plan.json.gz` contains each exact removed path, hash, size, retained source and
original file fingerprints, plus the protected tree snapshot. `deletions.jsonl`
records verified intent before each unlink; `Result.json` records completed
verification. `compressed-records.json` records lossless plan compression.
`attempts.json` preserves the initial Python-compatibility failure before any
plan or deletion. `cleanup.py` retains the corrected bounded procedure; the
completion receipt and ledger prevent an unchanged apply from running again.

These historical fixture directories are now partial evidence archives. Before
reusing one, read the compressed plan with Python `gzip.open`, select its exact
missing paths, verify the retained source SHA-256 and byte length, copy to the
recorded original path only if absent, and verify the restored bytes. Do not
overwrite existing destinations or run old tests against an unrestored fixture.
Existing earlier cleanup anchors and unique compressed archives remain intact.
