# Forest source and resource recovery

Canonical repository: <https://github.com/Master1C8/Forest> (private).
The repository remains writable. Storage cleanup does not close the unfinished
Hindi independent review or the Swahili editorial/source holds.

## Editable source

`localization/languages/*.json` contains all 31 language files (30 locales plus
the separate Russian baseline). All files were compared byte-for-byte with the
pre-cleanup inventory and with commit
`2d5f36f97120de83b7856ab4367794f322d086db` on remote `main`.
Keep normal Git metadata. No history rewriting is part of this procedure.

Use `LOCALIZATION.md` and the normal `./forest-localize build` interface for
edits and compilation. Existing source, glossary and font acceptance boundaries
still apply; storage verification is not an editorial or runtime pass.

## Recover indispensable build inputs

The private draft Release `storage-recovery-20261103` contains selected,
content-addressed recovery archives, rather than copies of working folders.
Archive manifests preserve original relative paths, SHA256, size, mode,
nanosecond modification time and macOS extended attributes. Identical contents
are stored once. Entries with `gitBlob` reuse raw objects in the recorded
ancestor of `main`; entries with `fromArchive` reuse a sibling archive.

From the canonical checkout, authenticate as Master1C8, then:

```sh
gh auth status --hostname github.com
git fetch origin main
mkdir -p dist/recovery/20261103
gh release download storage-recovery-20261103 --repo Master1C8/Forest \
  --pattern 'Forest-inputs-recovery-20261103-v2.zip' \
  --dir dist/recovery/20261103
python3 -B tools/forest_storage.py verify \
  dist/recovery/20261103/Forest-inputs-recovery-20261103-v2.zip
python3 -B tools/forest_storage.py restore \
  dist/recovery/20261103/Forest-inputs-recovery-20261103-v2.zip --missing-only
```

`--missing-only` preserves any existing changed source instead of overwriting
it. Review its `preservedChangedExisting` count: an edited file is not proof of
restoring the archived version. Without that option, differing existing bytes
reject. The tool restores files independently; an interruption may leave a
verified partial restore, and a repeat continues missing paths.

Python and the external .NET SDK remain environment prerequisites, as described
in `LOCALIZATION.md` and `requirements-assets.lock`. This procedure does not
install SDKs, start games or start translation workers.

## Optional owner game and evidence recovery

- `inputs`: the 454 files exercised by the normal compiler with undeclared
  project data reads denied by an OS sandbox.
- `owner-game`: the exact Russian Windows game approved for removal, excluding
  personal saves/settings. Requires the sibling `inputs` archive.
- `companions`: original content still required by earlier duplicate-cleanup
  restoration maps. Requires the preceding archives; these are explicit old
  restoration dependencies, not alternate supported releases.
- `evidence`: original version-bound wording/review/source evidence.
- `workspace`: nonprivate editable/current continuation material outside the
  normal build-input closure.
- `visual`: actual recorded screenshot-review packets and their original bytes.
  Recovery grants no fresh visual review or game-launch authority.

For optional recovery, download the required sibling archives using the same
Release command with `--pattern 'Forest-*-recovery-20261103-v2.zip'`.
Recover one exact archived path without recreating a whole historical run:

```sh
python3 -B tools/forest_storage.py restore-path 'project/relative/path' \
  --archives dist/recovery/20261103 --sha256 EXPECTED_SHA256
```

Old cleanup plans and deletion receipts stay immutable. Their additive
`source-only-anchor-replacements-20261103.json` annotations identify archived
anchor content. Restore a missing anchor first using its exact digest, then
use the original cleanup restore recipe. Do not rerun historical launchers.

All owner and QA save/settings files remain local at their original paths.
An additional local owner-save copy is under `localization/owner-saves/20261103`.
Personal save bytes and private key/cache files are excluded from the private
Release. Restoring game resources does not reset or overwrite saves.

## Verification records and limitations

`localization/cleanup/20261103-source-retention-01` holds authorization,
selection inventories, archive hashes, deletion receipts and restore/build
checks. `minimal-attempt-03/minimal-build-result.json` records actual normal
Dutch and Japanese build/check runs, all 16 output hashes each, with the old
managed compiler cache held and undeclared project reads denied. Positive and
negative file-read controls exercised the sandbox boundary.

`owner-game-v2-restore-verification.json` records an actual 271-file restoration
with bytes, modes, timestamps and extended attributes checked, followed by
removal of the task-owned test tree. It was a file restoration, with no game
launch. Remote-download and final cleanup receipts must also pass before
storage cleanup is reported complete. Project archival remains pending while
unfinished localization work remains.
