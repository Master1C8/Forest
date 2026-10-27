# Owner gameplay and progress continuity

For an owner-requested Russian game launch, use the repaired player preview and
preserve the owner's last actual progress across preview updates. The currently
selected updated preview is `ru-20261028-notebook-final/game/`.
The last owner-played preview remains `ru-20261027-quest-fix/game/`; while it is
running, preserve that session and do not copy its live save or launch a replacement.
After it exits normally, use its then-current progress for the updated preview.

The shipped save helper first reads `The Forest of Love_Data/tfol.savegame` next
to the game, then falls back to the Unity persistent-data location. It writes to
both locations. Existing IL evidence is in
`localization/source/save-continue-20261026/SaveFileRead.il` and
`SaveFileWrite.il`. A different preview directory plus a different QA product
identity can therefore appear to lose progress even though the previous files
still exist. A build's `copiedPlayerFiles: false` is an isolation property, not
an instruction to discard progress for owner gameplay.

Before launching an updated player preview:

1. Check for the actual running game. Do not copy or overwrite live save files,
   close an owner session or launch a duplicate.
2. Locate the last owner-played preview and inspect the actual save. Do not select
   QA-generated fixtures, a directory timestamp or a larger file as proof of the
   desired progression. Reconcile ambiguous competing saves with the owner.
3. Verify the supported save/config formats and original uninstrumented assembly.
   Save version `231129` and config version `220308` are required by this game.
   An older version can be deleted by the game's own legacy-file cleanup.
4. Keep a byte-exact backup of both `tfol.savegame` and `tfol.settings` and record
   source, destination and fingerprints. Preserve the source files. Copy into an
   empty destination with exclusive creation; do not silently overwrite a
   destination with different progress. Verify both files before starting the
   game. Two file writes are not a transaction: an interrupted transfer needs
   reconciliation before another launch.
5. Start the requested player preview with its working directory set to `game/`.
   Verify its actual process/log. Leave gameplay choices to the owner. File
   transfer or reaching the menu does not prove restored in-game continuation.
6. On the next update, read progress from the last owner-played preview, including
   new saves written after launch. Do not reuse a stale backup as the new source.

The 2026-10-27 repair copied the owner's 16:56:31 (Asia/Ho_Chi_Minh) save and its
settings from `ru-20261027-editorial-final/game/The Forest of Love_Data/` into
the previously empty `ru-20261027-quest-fix/game/The Forest of Love_Data/`.
Both source files and a separate backup remain intact. The private transfer and
launch receipts are in `outputs/manual-play-20261027/launch-01/`. Subsequent owner
progress belongs to `ru-20261027-quest-fix` until another player launch is verified.

Automated QA retains its separate immutable inputs and no-owner-save rules.
Owner gameplay files must never be admitted as synthetic QA fixtures or included
in distributable archives. Do not alter active QA builders or source snapshots
to retrofit player progress into them.

Regression: the owner plays the tutorial in one Russian preview, receives a
corrected preview in a new directory, and expects Continue to retain that progress.
The player launch must transfer and verify the existing compatible save while
preserving both originals and rejecting conflicting destination saves; the
automated QA preview must remain isolated.
