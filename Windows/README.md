# Forest Windows language installer

This adapts the native Windows installer from StardewTranslationInstaller to
The Forest of Love 0.45. The original base is read-only; its revision and file
hashes are in `provenance.json`. The artifact is an offline Windows x64 folder
distribution, zipped for delivery. Keep `Resources` beside the executable.

## Adapter map

| Base behavior | Forest adapter |
| --- | --- |
| Win32 status/progress, background PowerShell, folder picker, launch action | Retained, with a language picker and an explicit apply button |
| Steam folder discovery | Forest executable/data names, multiple-copy ambiguity requires the folder picker |
| SMAPI/Content Patcher installation | Fourteen exact Unity resource replacements through `ForestInstaller.cs` |
| Owned folder staging and rollback | Original fingerprints, permanent backups, exclusive lock, durable journal and verified rollback |
| Payload integrity | Native pins for script/helper/core, payload SHA, per-chunk and full-resource SHA |
| Native PE/manifest/icon/ZIP packaging | Retained; Forest branding and icon extracted without executing the game |

No model, network service or key is used during installation. Built-in Windows
PowerShell 5.1 compiles the small C# resource adapter against .NET Framework.
The matching LZ4 helper is bundled; the player installs no development tools.

## Language and version binding

`installer-config.json` selects the eligible canonical language documents.
Russian deliberately maps to the owner's accepted `ru-baseline.json`, rather
than the later wording revision in `ru.json`. Hindi and Swahili retain their
unfinished editorial gates. Ukrainian is omitted because the available final
quantity-family review record does not establish acceptance. No wording is
modified by this app task. Most included locales still need full native layout,
font and image-text acceptance; installation does not confer those passes.

`locale-labels.generated.json` is a generated projection of the canonical
SiteForMods catalog, bound to its source SHA. It is not a separately authored
language catalog. Refresh it only after an eligibility/catalog change:

```sh
python3 -B tools/build_windows_installer.py catalog
```

## Resource and save protection

The exact supported data version is checked through original resource hashes
and `globalgamemanagers.assets`. Detection also requires the game executable.
Unknown manual patches and same-name extra DLLs reject before resource writes.
An installation owned by this app must match its last persisted resource set.
The app never terminates the game and refuses a matching running game process.

Only the fourteen resource paths compiled into the adapter may change.
`app.info`, `tfol.settings`, personal saves, streams and unrelated mods are
preserved. In particular, the compiler's QA identity and factory settings are
never installed. English restores the twelve original files and removes the
two added DLLs only when they match this app's owned version.

All original backups are verified before any resource replacement. Originals
and the complete offline language package are copied through verified temporary
files and then renamed. A killed initial copy cannot publish a partial backup.
The `.vnrevival-forest` folder holds ownership, backups, package cache and state.
Do not delete it to change language. Do not place unrelated files inside it.

The journal is durable before the first resource move. Replacements are
individual same-volume renames, **not** one atomic multi-file transaction.
On failure the adapter restores its before-images. After interruption, the next
apply reconciles the journal first. The atomic state replacement is the commit
point: a matching committed transaction is checked and cleaned, not rolled back.
Unknown intervening changes stop recovery and preserve the journal/backups.
An interrupted preparation may retain temporary files; it does not authorize
deleting unknown user changes to force a retry.

## Lossless bundle storage

Direct chunks and binary deltas of compressed UnityFS files were too large.
Their nearly 945 MB `.resS` member is unchanged, but text length shifts the LZ4
block boundaries. Shipping that changed compressed representation duplicates
data which is already present in the original game.

`tools/forest_bundle_storage.py` stores the changed serialized member, the exact
container prefix/suffix and a bounded block recipe. Other resources and the
serialized member use content-defined chunks with exact source-copy segments
and globally deduplicated literals. No game object is reserialized here.

`forest_bundle.c` streams the unchanged member from the verified original,
recompresses with the normal compiler's exact LZ4 1.9.4/HC9 implementation and
retains exceptional encoded blocks when necessary. Each reconstructed bundle
must equal the **normal compiler's complete original SHA**. Thus the installed
catalog, compressed bundle and resource bytes remain exactly the normal build;
no alternate game format, CRC bypass or catalog substitution is introduced.
The native helper receives ASCII relative paths in a Unicode working directory.

The LZ4 source and license are vendored with immutable hashes. Font notices are
included in the distribution. Game assets remain the developer's property.

The final `.forestpack` is a solid LZMA envelope over a stored ZIP. The same
bundled helper includes the public-domain LZMA SDK decoder; players need no
external archiver. The outer SHA pins an inner length/SHA header. Decoding is
bounded, then the complete inner ZIP hash is checked before its manifest is read.
Only known files in a unique application temporary directory are removed; a
killed application can leave that temporary directory for later cleanup.

## Rebuild and verify

Use the canonical Forest checkout, the normal compiler prerequisites from
`LOCALIZATION.md`, the existing assets Python environment, .NET SDK and MinGW.
The assembler also needs a verified original Windows 0.45 game as read-only
input. Set `FOREST_ORIGINAL_GAME` to its root if the recorded owner path is
unavailable. Normal language/framework inputs recover through
`STORAGE_RECOVERY.md`; preserve the original game input when that recovery
archive does not contain a matching original binary.

The twelve exact original dictionary files are also preserved in the existing
private draft recovery Release (37,259,829 bytes). `original-inputs.json` pins
the asset and every input. A remote download was restored and verified, including
native extraction of its original serialized bundle member and preservation of
an intervening input edit. Recover these inputs without restoring a whole game:

```sh
gh auth status --hostname github.com
gh release download storage-recovery-20261103 --repo Master1C8/Forest \
  --pattern Forest-installer-inputs-20261104.zip --dir dist/recovery/windows
python3 -B tools/restore_windows_inputs.py \
  dist/recovery/windows/Forest-installer-inputs-20261104.zip
export FOREST_ORIGINAL_GAME="$PWD/dist/windows-installer-inputs"
```

This is read-only build data, without an executable, saves, identity file or
player settings. It is not a playable game installation.

```sh
.venv-assets314/bin/python -B tools/build_windows_installer.py compile
.venv-assets314/bin/python -B tools/build_windows_installer.py payload
.venv-assets314/bin/python -B tools/build_windows_installer.py solid
dotnet build Windows/compat/Compat.csproj -c Release
dotnet run --project Windows/tests/Tests.csproj -c Release -- dist/windows-installer-work/TEST-ID
.venv-assets314/bin/python -B tools/build_windows_installer.py package
```

`compile` uses the ordinary single-file compiler, warms its shared managed tool
and runs two bounded local deterministic workers. These are not model workers.
Never overwrite the helper binary while a materialization test is using it.
`payload` validates each input/output binding, protected stream content, exact
native bundle reconstruction and every archived storage recipe. `package`
pins the actual payload and companion files into the native launcher. Read the
resulting `build-receipt.json` and `validation.json` for the delivered version.
Test evidence applies only to its matching artifact and code/data hashes; a new
package build does not automatically accept a prior validation receipt.

The isolated C# tests use synthetic game folders and the actual transaction,
including modified-file rejection, source copies, Unicode paths, repeat apply,
English restoration, fresh-process persistence, initial-copy interruption,
every replacement boundary, state publication, recovery conflicts and rollback.
Optional real-payload tests use copied verified original resources with a dummy
executable: this does not install into or launch a real game.

Compilation, isolated installation and actual Windows UI/PowerShell/game runtime
are separate gates. The Windows VM was suspended and was not resumed for this
task. No installer was applied to the owner's game, no game was launched and no
release/site publication or deployment was performed. Whole-project archival
remains pending while localization work and target acceptance are unfinished.
