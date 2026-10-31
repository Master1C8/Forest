# Cleanup and retained companions

Completed cleanup receipts live in dated directories. Preserve their plans,
deletion ledgers and retained companions. A partially pruned QA directory is
historical evidence, not a directly runnable game. Restore its missing members
before any separately authorized reuse.

Before future cleanup, inspect all previous retained/reconstruction maps as well
as `protected-owner-test-builds.json`. Preserve every referenced exact-byte
companion unless a verified replacement is recorded in every affected map.
Names, parent mtimes and an old cleanup receipt alone do not establish current
eligibility; inspect nested changes, current process ownership and saved state.

The latest cleanup is `20261031-verified-duplicates/README.md`. Its
`retained-files.json` lists 322 companions that must remain available. Current
packages and the accepted owner Russian game remain complete and protected.

Regression: a candidate is byte-identical to another file but is the retained
companion in an earlier cleanup map. Keep it or reconcile every dependent map
before deletion. On macOS Python without `os.listxattr`, use the checked native
attribute API; preserve quarantine/provenance in the restoration receipt and
skip unknown attributes. Verify actual byte and attribute restoration before
deletion, then exercise restoration at a selected original path.
