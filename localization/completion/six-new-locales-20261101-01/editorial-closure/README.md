# Exact independent editorial reconciliation

Each locale manifest binds all12825 actual independent pass judgments to current
source/target hashes, retaining original full review and exact correction evidence.
The1781 protected source values remain exact and separate. No script creates semantic
passes: reconciliation copies actual matching judgments with provenance. Native,
human NSFW, build and release gates remain separate.

Cache each ledger digest once before iterating IDs; reuse it for per-row provenance.
Reuse complete version-matching locale manifests after an observer interruption.
Regression:12825 rows from a large judgment ledger require one digest of that file,
not12825 whole-file reads. A changed source/target or non-pass cannot be carried into
clean combined coverage. Partial merges never produce a completion manifest.
