# Russian haiku option identity adapter

The finite static adapter is complete. It preserves the nine accepted Russian labels and all 27 complete poems while restoring the original three named endings and 24 mixed endings. It changes only nine evaluation reads in `TriggerHandlerDates.ExecuteTrigger`; the stored/displayed Russian lines remain intact. The protected English comparison literals remain unchanged and are never inserted into displayed Russian verse.

The actual text-only runtime uses an exact map bound to conversation 303, its three original slots, and the verified date2 haiku finish call sites. Four private static methods return the original full source line solely to the existing `ToLower().Contains()` evaluation. The first evaluation getter validates all three slots before short-circuiting can hide an absent line. No global mapping, normalization, trim or English display fallback is present. The call-site context is statically verified; native scene/trigger execution remains untested.

Read `source-adapter-contract.json`, `acceptance-checklist.json`, `mapping.json`, and `runtime27-fixtures.json`. Evidence is under `outputs/ru-haiku-identity-adapter-20261029/check/`:

| Evidence | Result |
| --- | --- |
| `runtime-check.json` | Actual fresh OpenAI `gpt-6.1-sol`, high reasoning, no inherited history verified before localized content |
| `delivery/patch-receipt.json` | 14,095 existing method definitions preserved; exactly one existing method body changed; four private methods added |
| `delivery/Assembly-CSharp.ru-haiku.dll.methods.jsonl` | All 14,095 before/after definition/body hashes |
| `delivery/haiku-patched-readback.il` | Actual serialized patched handler and helper bodies |
| `delivery/clr-tests.json` | All 27 tuples in en-US, ru-RU and tr-TR: 81 CLR executions; 7 runtime-map negatives and 6 structural negatives |
| `regression-final/validation.json` | 16 loader/version/build/snapshot/write-failure checks passed |
| `snapshot-build-verification.json` | A privately compiled frozen snapshot reproduces the exact delivered DLL |
| `delivery-compiler-pins.json`, `compiler-environment.json` | Final compiler/dependency/source and environment provenance |
| `attempts.json` | Earlier attempts retained separately; not final acceptance evidence |

Supported input is the complete Russian02 DLL SHA-256 `84f70452d94741489b37d97c8125bf107b4261d4a87e5a2ba294ebdf107dfacf`, or an exactly identical normal-builder stage after its existing patches. Delivered private DLL SHA-256 is `74a2f0e8a4851e128ba853837c31fc8d9c17fa7cdefae57505ae5c763ce0a9de`. The original DLL is a read-only source/evaluation baseline, not a supported patch input: an exploratory direct patch correctly rejected two unrelated Cecil stack-metadata normalizations. The preservation check was retained.

Exact reversal starts from the saved serialized patched readback, restores the nine field reads, and removes the four helpers. Its complete bytes match the prior Russian02 DLL. Both `delivery/Assembly-CSharp.ru-haiku.dll.before.dll` and `.reversed.dll` have the original Russian02 SHA-256. Existing candidate/game files were not overwritten.

Backend output files are separate writes, not a transaction. The failure-injection test blocked the method-ledger write after the three DLL writes: the source stayed exact, prior/reversed payloads stayed exact, no completion receipt appeared, and retrying occupied paths was rejected. Preserve/reconcile partial outputs and choose a new output path; never infer completion from a DLL alone. Repeat application is an explicit rejection, not a claim of idempotence. Actual full/partial patched instruction/helper states are checked by the backend.

These are the reproducible private build/patch commands for the parent. They create no game candidate and launch no game. Use a new `parent-next` path; reconcile an existing one before reuse.

```sh
cd /Users/antonkrutov/Desktop/Forest
python3 -B tools/russian_haiku_identity.py --locale ru preflight
python3 -B tools/russian_haiku_identity.py --locale ru snapshot \
  --output outputs/ru-haiku-identity-adapter-20261029/check/parent-next
dotnet build outputs/ru-haiku-identity-adapter-20261029/check/parent-next/haiku-identity/haiku_identity_patch/HaikuIdentityPatch.csproj \
  --nologo --verbosity quiet \
  -o outputs/ru-haiku-identity-adapter-20261029/check/parent-next/haiku-identity/compiled
python3 -B outputs/ru-haiku-identity-adapter-20261029/check/parent-next/haiku-identity/russian_haiku_identity.py \
  --locale ru patch \
  --input 'localization/previews/ru-20261029-chapter-gallery-02/game/The Forest of Love_Data/Managed/Assembly-CSharp.dll' \
  --output outputs/ru-haiku-identity-adapter-20261029/check/parent-next/Assembly-CSharp.haiku.dll \
  --receipt outputs/ru-haiku-identity-adapter-20261029/check/parent-next/patch-receipt.json \
  --backend outputs/ru-haiku-identity-adapter-20261029/check/parent-next/haiku-identity/compiled/HaikuIdentityPatch.dll
```

For a later separately authorized full preview build, the existing normal builder has the optional `--haiku-option-identity` flag. It requires `--chapter-gallery-case --inventory-display-completion` and the same prior history. It verifies acceptance before creating output, freezes all later-read adapter/code/data/peer/dependency files, applies the adapter after the chapter/gallery patch, then verifies the staged DLL before copying it into that new preview. It rejects any earlier stage whose bytes differ from supported Russian02. No full game build was run here; the parent must use its established build environment and fresh isolated product identity.

The real-game 27-fixture workflow remains with the parent. The exact plan can be regenerated into a new file:

```sh
python3 -B outputs/ru-haiku-identity-adapter-20261029/check/runtime27.py emit \
  --output outputs/ru-haiku-identity-adapter-20261029/check/parent-runtime27.json
```

Bind that plan to the parent's separately authorized isolated game harness. This lane neither accessed nor modified the live frozen harness, root probe, game processes, or its injection binaries. No unverified bridge API or game-launch command is invented here. For each tuple, restore a verified normal-mode scene start; reach the actual source conversation; select and confirm the three stable option entries through the real response UI; record the exact labels, selected text, producer triggers and callback destinations; verify all stored and displayed poem lines; then finish through the original trigger and record selected arc, the one-second timer request, and actual continuation/cutscene events. Do not substitute direct field injection or the extracted CLR predicate for those game checks.

After the parent captures all 27 actual-game receipts with the schema described in `check/runtime27.py`, validate them with:

```sh
python3 -B outputs/ru-haiku-identity-adapter-20261029/check/runtime27.py verify \
  --receipts /absolute/path/to/parent-captured-runtime27.jsonl \
  --output outputs/ru-haiku-identity-adapter-20261029/check/parent-runtime27-validation.json
```

The receipt checker validates supplied records and evidence hashes; the parent must still verify that their producer exercised the actual native paths. Runtime loading, live trigger/arc priority, normal UI selection/confirmation, the continuation timer, six template fields, fonts/layout and visual acceptance are not run. Other case/source/editorial gates remain open. `sourceGateAccepted`, `ordinaryTranslationEntryAllowed`, and `wholeGameAccepted` remain false. The parent owns Git integration and actual usage accounting; this lane made no Git/index or root README/CHECKPOINT changes and starts no next job.
