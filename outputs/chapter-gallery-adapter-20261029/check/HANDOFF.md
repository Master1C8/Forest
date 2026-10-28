# Finite chapter/gallery adapter handoff

Implemented only `tools/russian_chapter_gallery_case.py` and the new
`tools/chapter_gallery_patch/` backend. Parent owns integration, target edits and
Git. No builder integration, root README/CHECKPOINT edits or Git/index commands
were performed. No child jobs, model calls, GUI/game, browser, image, installer,
server, publication or deployment work was started.

## Tested execution and evidence

Final execution is `execution-v3/`, with its complete input/dependency hashes in
`execution-v3/chapter-gallery-inputs.json`. Delivered source files match those
frozen execution bytes. Cecil is pinned to Mono.Cecil 0.11.6 / net8.0; the local
compiler used was dotnet SDK 8.0.131 (see `toolchain.json` for actual inventory).
Final test harness: `preflight-run-v6.py`; outputs: `preflight-v6/`.

- `preflight-v6/preflight.json`: 47 passing static checks on actual readonly
  candidate17 inputs. It includes explicit wrong/unknown/missing locales,
  missing/duplicate/wrong-source/extra IDs, stale target hashes, empty targets,
  protected templates, absent-cell materialization, already-applied rejection,
  changed selected cells with matching current payload hashes, real native
  changed-source assets, incompatible managed versions, overlap in both
  directions and a real DLL-to-receipt write failure.
- `delivery-verification.json`: separate verification of saved bytes without
  calling the adapter's application functions. All113 BG targets and16 absent
  states match; all286 unselected column blobs and whole immediate-prior
  restoration pass. All3 column offsets differ from the original by11,646
  bytes. All18 native object raw differences equal exactly the selected
  m_text string-length/content/alignment span, preserving every other byte.
- `preflight-v6/managed-readback.json`: inventory of all14,095 methods with
  source/target body and definition hashes. Exactly3 operands in2 methods
  change;10 protected operands remain exact. The backend reads back the entire
  staged module, restores original operands, serializes the reversal and reads
  it back again. Branch targets use instruction identities; locals,
  initialization, handlers and method definitions are compared. This proves
  method equivalence, not byte-identical PE rewriting or runtime execution.
- `runtime-check.json`: actual fresh Sol/high/OpenAI session and process check
  before localized content. `runtime-publication-check.json` binds its initial
  verification time to runtime-verification publication (under30 seconds).
- `source-check-receipt.json`: observed source helper `--check` success; no
  unchanged extraction or framework audit was repeated.

Readonly candidate17 resources and the managed DLL have identical hashes after
all tests. Already localized Actor, Quest, InventoryItem and QuestProgressLogText
columns survive exactly; all other managed methods include the existing
localized52/2 inventory code and remain equivalent to the immediate input.

## Interface and future parent integration

All entry points require explicit `locale='ru'`; unknown, missing and alternate
locale values fail. Normal entry points obtain a plan from
`load_inputs(locale='ru')`. That loader currently rejects with
`bounded-editorial-acceptance-required` before writes. No acceptance was created.
Passing or relabeling a draft InputPlan cannot bypass normal acceptance loading.

Normal acceptance must be supplied by the owning parent in
`localization/supplemental-ui/20261029-chapter-gallery-case/ru.acceptance.json`.
The implemented contract requires:

- status `bounded-russian-editorial-accepted`, caseId
  `chapter-titles-and-gallery-hints`, locale `ru`, wordingOccurrences134,
  targetEditorialAccepted true;
- exact `sourcePins` and `dependencyPins` dictionaries exported by the adapter;
- basename-only `targetFile` and its exact `targetSha256`;
- `evidence.fullSemantic`, `evidence.independentCleanDelta` and
  `evidence.finalDeterministic`, each with basename-only `file` and exact
  `sha256`; each referenced JSON receipt must contain status `passed`, the
  same caseId/locale/targetSha256 and the pinned source.jsonl `sourceSha256`.

These are version/binding checks; scripts do not author editorial judgment.
The parent must reconcile real editorial receipts with this bounded contract.
The positive accepted-input/snapshot path remains unrun until genuine matching
acceptance exists. No fake accepted fixture was generated to test it.

`snapshot(folder, locale='ru')` gates acceptance first, reads the complete input
set, rejects existing destination files and exclusively writes accepted raw
JSONL, evidence, pinned source/dependencies and backend source. Its final pin
manifest is the completion boundary. Partial writes are not a transaction.
Build the frozen backend explicitly with the existing pinned recipe:

```sh
dotnet build <snapshot>/chapter_gallery_patch/ChapterGalleryPatch.csproj -o <recipe>
```

`project_bg(data, parse, variable_cells, locale='ru',
expected_before_sha256=<exact immediate input>, plan=<accepted>)` runs after
existing Actor/Quest/Inventory descriptions. It reparses current offsets,
validates all129 states, replaces only3 sparse blobs and verifies complete
restoration. It returns bytes and a receipt; it does not write resources.

`native_plan(asset_name, objects, generator, locale='ru',
expected_asset_sha256=<pinned input>, actual_asset_sha256=<computed input>,
plan=<accepted>, prior=<pending typography/layout plan>)` selects exact asset,
pathId and `/m_text` fields. It returns the merged plan and a receipt. The parent
must compute the actual asset hash from the loaded resource, then save/reopen
and verify all object bytes as exercised here. Existing non-text edits in the
prior plan are preserved; conflicting pending text is rejected.

`patch_managed(source, output, receipt, recipe, locale='ru',
expected_before_sha256=<exact immediate DLL>, plan=<accepted>)` never overwrites
the input or existing outputs. The current backend admits only candidate17's
pre-stage DLL hash13f1febb9cc2adb45ebed2227efbd6eb41f82632d5e199502df96c997fff348d.
A different upstream build requires parent reconciliation and an explicit new
verified compatibility pin, not a caller-supplied hash bypass. Source selectors,
offsets and values come from hash-verified source packet bytes.

Draft preflight requires BOTH `prepare_static_preflight(rows, locale='ru')` and
`static_preflight=True` at every application boundary. It never calls normal
accepted loading and cannot enter a normal build. Candidate17 copies in this
check directory are labeled unaccepted static output, not deliverables to install.

## Acceptance checklist and remaining work

The machine-readable checklist is `acceptance-checklist.json`. Finite adapter
implementation and static checks are complete. Target editorial acceptance,
parent integration and runtime remain pending.

Native confirmation examples are initial-only conservative selectors. They do
not cover the separate Adventure.Title runtime root. Gallery live fallback is
covered independently by its exact managed operand; OOS live titles use the BG
Chapter.title plus the unchanged two-apostrophe wrapper. Identifier bool/index,
numbering, two-LF join, fallback predicate, selection/callback/enum/resource and
animation identities are preserved. The59 saved selection controls and all
other native objects remain byte-exact. Runtime selection of GO2510 is unknown.

A real injected receipt-parent-directory failure leaves a written DLL and no
receipt in `preflight-v6/failure-between-writes/`. It is intentionally retained
as an incomplete test artifact. No completion or package acceptance applies to
it. The multi-resource handoff is not a transaction; a completion manifest must
be written last after all required artifacts are validated.

## Retained attempts and technical corrections

Earlier incomplete attempts are retained, with no completion claims:

- execution-v1/preflight-v1: BG schema guard assumed all three fields were
  BGFieldString. Chapter.description is BGFieldText. The adapter now checks the
  exact field-specific type; v2 and v3 preserve this correction.
- preflight-v2: harness named Actor.display_name; actual field is nameplate_name.
- preflight-v3: UnityPy get_raw_data reads original reader bytes after a pending
  save_typetree; staged serialized bytes are in `.data`. Restoration now checks
  staged bytes; delivered saved resources are independently reopened/read.
- preflight-v4: isolated native copies require the existing MonoScript dependency
  globalgamemanagers.assets. The harness explicitly loads that readonly asset.
- preflight-v5:46 checks passed on execution-v2. Final execution-v3 adds a guard
  against relabeling draft plans and exclusive accepted snapshot writes;
  preflight-v6 passes47 checks on that final code.

All changes stayed within the authorized files/check directory. Stop after this
handoff; there are no automatic follow-up jobs.
