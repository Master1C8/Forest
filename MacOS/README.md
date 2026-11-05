# Forest macOS language launcher

The native universal SwiftUI launcher supports macOS 14+, Apple Silicon and Intel.
It contains the same 30 locale versions as the Windows app, plus original English.
Hindi, Swahili and Ukrainian now have complete version-bound independent wording
review and exact correction closure. Target runtime/rendering acceptance is separate.
Russian is bound to the owner-accepted `localization/languages/ru.json` version.
The seven-scene native evidence for each delivered language is recorded under
`localization/screenshots/all30-owner-20261104-01`; wider game coverage is separate.

The proven UI/distribution base is `StardewTranslationInstaller`, revision
`68088632f217203f6c3532d2d6d38ad7ca49438d`. That checkout is read-only.
The compact SwiftUI progress/error presentation, native folder selection,
launch action, SHA checks, staged owned-folder replacement, universal build and
ad-hoc signing are retained. Forest adds a language picker and a game adapter:
its Unity resources replace Stardew's SMAPI/Content Patcher integration.
No API credentials, Python, .NET or developer tools are required on player machines.

## Installation boundary

The original `.app`, Info.plist, save identity and external saves remain unchanged.
`~/Library/Application Support/VN Revival/Forest/Current/The Forest of Love.app`
is the owned copy. The complete verified language package is cached alongside it.
Only 15 named data resource paths are owned. Switching starts from the current
copy and preserves its latest `Contents/tfol.settings` and unrelated mods.
Unknown edits to owned resources reject before staging. English restores the
13 original files and removes the two owned helper DLLs in the copy.
Legacy14 ownership upgrades only if the newly owned TMP renderer is still the
exact stock module. Arabic, Persian, Hebrew, Hindi and Thai select the shared
complex-script renderer; other languages and English restore the stock module.
External bundle symlinks reject before signing so recursive signing cannot modify
another application or an external mod. Internal framework symlinks remain valid.

An exclusive file lock protects concurrent installers. A GUID journal records
staging, prior-copy rename and commit. Recovery chooses the previous or committed
complete directory by ownership/transaction identity, never modification time.
No per-file rollback is presented as a multi-file transaction. The first rename
may briefly leave `Current` absent; the next Apply restores the previous directory
if the second rename did not commit. The app never terminates game processes.

Forest writes settings inside its application bundle. This invalidates a sealed
entry after normal play. After checking all owned localization bytes, the launcher
re-signs its copy before launch and verifies it with `codesign --deep --strict`.
It never signs the installed original or changes its bundle identifier. The
distribution is ad-hoc signed and is not Apple-notarized.

The Launch game action directly executes the verified owned copy's
`Contents/MacOS/<CFBundleExecutable>` with no arguments and with `Contents/MacOS`
as its working directory. It does not open the `.app` through LaunchServices.
The owner's working absolute command identifies this entry point; its historical
Downloads path is not hardcoded, so moving the original app does not break launch.
Each run captures stdout/stderr in a unique `Logs/game-<UUID>.log` beneath the
launcher support folder. Process exit errors include that log location. Closing
the launcher does not terminate the game. Running-process checks remain enabled.

## Native adapter

Mac and Windows 0.45 resources have different binary containers, shaders, textures,
catalog bundle identities and platform-specific managed methods. The adapter
transplants only exact selected raw objects whose original before-images match
both platforms. All other native objects, external references and platform fields
are retained and read back. Managed localization changes are merged into the Mac
assembly; unrelated Mac keyboard/window/platform methods and MVID are preserved.
An overlapping platform method permits only a proven exact literal-only edit.

The UnityFS codec replaces the serialized CAB and retains the complete native
`.resS`. It encodes the new CAB and first partial streaming block, then copies
remaining original compressed blocks. CRC covers the complete contiguous raw
stream. The native Addressables catalog changes only that bundle's CRC and size;
CRC checking stays enabled. `BundleVerify.c` independently compares the entire
serialized member and native streaming member and recalculates CRC.

## Rebuild

Prerequisites: the original native macOS game 0.45 installed at
`/Applications/TheForestOfLove.app`, the original Windows 0.45 data at the documented
Windows recovery location, a rebuilt Windows `.forestpack`, the restored shared
compiler inputs, UnityPy in `.venv-assets314`, .NET 8, Mono.Cecil from the shared
compiler recovery inputs, and Apple Command Line Tools with Swift 6.
Restore the canonical checkout and compiler inputs using `STORAGE_RECOVERY.md`
and `Windows/original-inputs.json`. Rebuild the Windows payload using
`tools/build_windows_installer.py` if its delivered package is absent.

```sh
python3 -B tools/build_macos_installer.py codecs
# The resource adapter uses this host helper path.
cp dist/macos-installer-work/forest-codec-universal dist/macos-installer-work/forest-codec
.venv-assets314/bin/python -B tools/forest_macos.py resources
python3 -B tools/verify_macos_resources.py
python3 -B tools/build_macos_installer.py payload
python3 -B tools/test_macos_installer.py --run 01
python3 -B tools/test_macos_launch.py --run 01
python3 -B tools/build_macos_installer.py app
python3 -B tools/test_macos_installer.py --real --run 01
```

Keep task-owned scratch paths under `dist/macos-installer-work`. Existing test run
IDs are preserved; choose a new ID for a materially changed test. Do not overwrite
a helper being used by a live resource build. Resource receipts allow verified
completed locales to be reused after an interrupted finite build.

Already compiled locales can also use the normal compiler's overlay directly,
before the complete Windows distribution is repacked:

```sh
.venv-assets314/bin/python -B tools/forest_macos.py resources \
  --windows-overlays dist/windows-installer-work/overlays --locale sw
python3 -B tools/verify_macos_resources.py --locale sw \
  --output localization/completion/RUN/sw-native-resource-validation.json
```

Choose an existing task-owned `RUN` directory. Repeat `--locale` for additional
ready locales. This route checks the full normal compiler output and original
platform inputs, then uses the same object/assembly/catalog port operation as the
payload route. A subset validation requires a separate receipt and does not
replace the complete distribution validation. Neither route starts the game.
`FOREST_WINDOWS_PAYLOAD` selects a separately built Windows package for the
payload route; decoded ZIP caches are keyed to that package's exact hash.
`FOREST_MAC_APP_NAME` selects a direct `.app` destination beneath `dist/`, allowing
a new version to be built while the previous launcher's resources remain intact.

## Regression recipes and evidence limits

- Bind a cached original serialized member to the full source bundle and decoder
  hashes, then check its actual body hash on reuse. Establish that binding by a
  fresh extraction when adopting an older cache. A changed cache must reject
  before object selection; it must never make changed target objects appear
  unchanged. The source-cache unit tests mock extraction, while the Swahili
  verification uses the actual native decoder and original game inputs.
- Snapshot expected Unity object bytes before save. `set_raw_data` stores pending
  bytes separately; `get_raw_data` still reads the original reader. Compare saved
  bytes against explicit selected targets and original unselected snapshots.
- Resolve every existing resource path component before writing. Foundation's
  whole-path symlink resolution may leave a non-existing final leaf unresolved.
- A changed `Contents/tfol.settings` must survive switching and prelaunch signing.
- Inject failure before swap, after backup rename and after commit; verify an
  exact complete old/new game and finalized journal, not just a retry from scratch.
- Reject corrupted payload/cache, incorrect build identity, foreign owned-path
  mods, unowned state, unclaimed backup folders, traversal and concurrent writers.
- Exercise direct executable launch using a disposable stub at an owned path with
  spaces and shell metacharacters. Verify the exact executable, empty arguments,
  working directory, per-run stdout/stderr logs, observable nonzero exits and
  rejection of missing/non-executable/traversing/external-symlink entry points.

`native-resources.json`, `validation.json` and `build-receipt.json` bind actual
checks and artifacts. Synthetic tests replace game data and signing; real-resource
tests exercise exact resource switching and signatures in isolated copies.
Neither starts Unity or establishes in-game font/layout/runtime acceptance.
No screenshots, installed-game modifications, site publication or deployment
are performed by this build workflow. The Forest project remains unfinished
under its existing editorial/runtime gates; whole-project archival is pending.
