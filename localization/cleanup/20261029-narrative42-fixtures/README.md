# Finished narrative fixture cleanup, October29

The owner explicitly requested cleanup. The technical worker confirmed that all
verification01/02 jobs had ended and that future checks would use the protected
private-source anchor and a new compressed execution snapshot. No active input,
current full candidate, execution snapshot, guard input, code, Result, validation
or object ledger was removed.

The first pass removed three actual SHA-identical 971,484,709-byte bundles against
the retained `verification-02/positive` anchor. `initial-three-duplicates.json`
preserves their exact paths, fingerprints and restoration source. This recovered
about2.7GiB before the main cleanup.

The main pass removed596 finished raw resource copies. Every duplicate was checked
against an actual retained raw file. Three unique superseded uncompressed bundle
versions were retained in separate lossless gzip archives, approximately34MiB each.
Every archive was fully decompressed into a SHA-256 check before raw removal and
again afterward. The original971MB variants remain byte-for-byte recoverable.
The truncated342MB failed archive prefix remains unchanged as separate evidence.

`plan.json` records every removed path, original fingerprint/hash, and retained
raw or compressed anchor. `Result.json` records measured free-space changes.
Together with the initial pass,599 files and about27.9GiB of logical duplicate/
superseded raw storage were removed. Measured disk free space increased from
roughly0.15GiB to19GiB;APFS sharing means logical size is not physical recovery.
The project measured approximately60GiB after cleanup,including current work.

The three archives remain locally in this canonical project folder and are
deliberately ignored by Git. Their exact compressed and original hashes are in
the committed manifest. Do not delete these unique retained bytes. To restore a
selected old fixture, copy its retained raw anchor or gzip-decompress its recorded
archive to the exact `plan.json` path, then require the original SHA-256. Superseded
verification01/02 directories are partial raw archives and must not be rerun until
their required paths have been restored.

The first main attempt stopped before any raw deletion because it encountered a
small original compressed bundle outside the four known uncompressed hash groups.
The corrected recipe separately admits only byte-identical canonical source copies
and preserves other unknown files. Existing archives were reverified before reuse.
`cleanup-attempt01.py` and its log preserve that boundary;it did not delete files.

The growth mechanism was UnityPy's default uncompressed outer-bundle serialization:
a41MB source became926MiB for each test. The active application recipe now explicitly
preserves source compression flags and uses small overlays/read-only links instead
of repeated full source copies. Regression: source flags194 must remain194;the
no-op and reversed container must restore original bytes,and test sources must not
duplicate an entire immutable input set for a one-file mutation. Subsequent writes
retain at least5GiB free reserve. Corrected application checks remain separate from
this cleanup receipt.
