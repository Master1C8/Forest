# Obsolete preview payload cleanup, October 30

The owner requested removal of unnecessary files after the preview directory
measured 21.1 GB. This pass removed 3,570 exact redundant game/no-op resource
copies, totaling 12,080,464,244 logical bytes. Full SHA-256 and byte length matched
an actual retained raw copy before each removal. All 295 reconstruction sources
were verified before and after deletion. Unique bytes were retained in place.

Available disk space increased from 3,749,941,248 to 8,584,232,960 bytes during
the measured operation: 4,834,291,712 bytes (4.83 GB). This is an observed free-space
change, not a claim that every logical byte occupied exclusive physical blocks.
APFS sharing and concurrent activity affect the physical result.

The complete owner manual-test build retained its exact file fingerprints.
Current lane task/contract references and open preview roots were excluded.
All 455 previously recorded reconstruction anchors remained protected. No source,
translation, review, screenshot, save, frozen worker execution, or final deliverable
was selected. No game or worker was launched or stopped.

Historical preview directories affected by cleanup are partial evidence archives.
Their game/no-op payloads must be restored before a test or builder requires them;
the retained code and build receipts alone do not make those directories runnable.
The previous cleanup's historical list of complete game copies did not establish
a permanent requirement to keep every redundant raw file. Its reconstruction
sources remain intact, and the owner's `neverCleanup` build remains complete.

`plan.json.gz` records each removed path, original fingerprint, byte length,
SHA-256, and retained source. `deletions.jsonl.gz` records verified intent before
unlink; `Result.json` records completed deletion and verification. The ledger was
losslessly compressed after completion, with full decompression equality checked
before removing the redundant plaintext (546,721 bytes reduced to 26,935 bytes).
Its original SHA-256 is
`d48cfdc3667889a2f9e97c9c52bb742ef9b6282ff938f4043a70bc5d8a01ce94`.
A real restore
to one exact removed path passed byte-length and SHA-256 checks before that
temporary restoration was removed. A completed cleanup must not be rerun.

To restore a historical file, select its exact row from the gzip plan, verify the
retained source against the recorded length and SHA-256, create only missing
parent directories, copy with exclusive destination creation, and verify the
result. Refuse existing destinations and symlinked parents. Do not launch a game
as part of restoration. All `retainedCopy.path` entries in this plan are mandatory
anchors for future cleanup; never delete them without separately reconciling
every dependent reconstruction map.

Regression: an old preview may contain 200 unchanged resource files and one unique
patched asset. Cleanup may remove only proven redundant files, preserving the
unique patch and a verified reconstruction source for every removed path. An open
preview, a current task reference, an owner-protected build, a tracked file, a
changed candidate or an earlier reconstruction anchor must remain untouched.
