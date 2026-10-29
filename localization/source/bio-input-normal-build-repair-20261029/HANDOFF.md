# Bio185 normal-build admission repair v2

The finite boundary repair passes for The Forest of Love0.45, Russian. The canonical
branch is `main`; parent owns Git, root documentation, the next full build and runtime.
This lane stops at this handoff. Target wording changed0. Model selection was verified
from this worker's session metadata before localized content: `gpt-6.1-sol`, `high`,
`openai`. No nested agent/model requests were made.

The failed normal candidate `localization/previews/ru-20261029-bio-input-01/`, supported
prior `localization/previews/ru-20261029-display-completion-01/`, and original
`localization/source/bio-input-application-20261029/` remain unchanged. No retry used
either candidate. The v1 contract/receipts and all historical frozen versions remain
valid evidence of their own exact inputs; this is an explicit supplemental v2.

## First divergence and scope

All13 strict prior files were compared together. Eleven match v1 exactly. The inventory
and Quest layout helper assemblies alone differ, each only in the4-byte PE COFF
`TimeDateStamp` and16-byte CLI Module `Mvid`. Their raw sizes are unchanged. Inventory
uses offsets136/8584; Quest uses136/11948. Only2 timestamp bytes currently differ, but
the admitted timestamp field is precisely4 bytes. `helper-image-metadata-comparison.json`
records full old/new hashes, exact regions/values and nonvolatile-image hashes.

The responsible shared mechanism was exact whole-file admission of nondeterministic
Roslyn helper output. Both compiler commands omit deterministic compilation. Inventory
producer receipts match except helper output hash. Quest source/recipe inputs match.
The exact Quest intermediate `Assembly-CSharp.dll` compiler reference was reconstructed
at `e2ddc62db9c49e2be3800b9ba29c4fb486423e133feda1a3aca1127245ae8a74`
using pinned saved MenuPatch binaries and accepted targets. Both helpers were independently
compiled twice using the complete frozen compiler/host/runtime/reference-pack tree,
exact source and exact original/intermediate managed reference sets. All4 outputs match
the accepted helpers outside the same parsed20 bytes. This proves the concrete cause;
no arbitrary new helper digest was substituted for an accepted one.

A complete248-file fixture comparison finds244 exact files and4 classified differences:
the2 helpers plus QA `app.info` and `globalgamemanagers`. The latter identity files are
preserved and excluded from the185 stage's strict v1 contract by its existing design.
The Addressables catalog, bundle, all strict native containers and original stream files
are exact. QA differences are recorded, never used as new localization acceptance.

## Canonical recipe and adoption

Only `tools/russian_bio_input_case.py` changed. The builder, inventory compiler and Quest
compiler remain byte exact. The v2 helper admission parses PE32/CLI structure and permits
only the timestamp and the sole Module MVID. It compares every remaining image byte
against vendored, SHA-pinned v1 helper references. This is stricter than an IL-only
semantic comparison: fields, signatures, flags, methods, IL, locals, handlers, assembly
identity/references, resources, table order and padding must all remain exact. Cecil
metadata/body dumps independently match old/fresh images except MVID: inventory5 types,
9 methods,6 fields,5 references; Quest7 types,18 methods,23 fields,5 references; no
embedded resources in either image. No CLR/Unity semantic or rendering result is inferred.

The helper images are not rewritten or normalized on disk. Their actual freshly built
bytes remain wholly exact before/after185 application. `prior-admission-v2.json` records
both raw identity and bounded comparison; `Result.json` pins that receipt and its v2
adoption. All other11 strict hashes remain unchanged. A new helper image additionally
requires the real normal producer recipe and hash-bound output receipts. Producer source,
compiler receipt, original reference set and Quest intermediate identity are checked.
Before normal output/compilation, current source/recipe pins and all3948 compiler-tree
files plus original managed references are checked. New snapshots include the complete
supplement and its pinned accepted images, so later application reads frozen dependencies.
Intentional producer/compiler/reference changes require a reviewed new supplemental
contract; they are not silently accepted as new hashes.

`normal-build-contract.json` is pinned in code and includes source/compiler/reference
fingerprints. Its references and compiler manifest are pinned too. Old frozen helpers
continue their original v1 rules. New canonical snapshots adopt v2. The existing flags
and prerequisite order are unchanged. The no-flag builder is byte exact to the prior
185 recipe, and its existing AST comparison against the pre185 recipe passes after
removing only the original opt-in185 additions. Affected locale/check scope is Russian
`--bio-input-display-case` admission only. There is no wording, glossary, stable-ID,
parsing, binding, font, texture or other-locale change, so editorial evidence is retained
by exact source/target/artifact fingerprints.

## Actual private output and verification

The final private resources-only output is:
`outputs/ru-bio185-build-boundary-20261029/delivery-final/`.
Execution uses `frozen-final/bio-input/`, including the complete Python3.14.6 runtime,
stdlib, site-packages, native libraries and type-tree generator. The separate full
compiler tree, actual resource fixture, patch reconstruction and references are pinned
before private execution. macOS system libraries remain OS dependencies.

All185 selectors pass:182 new semantic wordings,2 retained exact matches,1 preserved
symbol; exactly110BG cells and72 native fields in70 native objects change. Both BG
decoders compare all51,572 states. Actual save/reload accounts for all81,729 objects;
all7 whole containers reverse byte exactly. The7 final resource files and10 original
ledger/inventory/cache receipts match the accepted private delivery exactly. Original
443 protected native records are reused only after checking their immutable receipts
and exact referenced input/output containers. No default pass rows were generated.

Fresh independent raw readback verifies all1,385 original Texture2D objects in26
containers and31 external streams. Assembly-CSharp stays byte exact at
`6bb930ea1fa5befcd1f8a13f13d140347a7dc96419ce2c81aa95682c7625861d`.
The2 actual fresh helper files also stay wholly byte exact across this stage.

Validation includes32 original admission/control tests,16 new matched boundary tests,
2 real-byte producer source/compiler pin controls, and the original6 failure-boundary
tests. The new16 cover actual method body, field, assembly identity, assembly reference
and embedded-resource mutations in both helpers; producer source/fingerprint, compiler
receipt, real managed-reference and strict native-resource mutations; and a matching
positive changing only the admitted timestamp/MVID with exact output binding. The2
producer pin controls replace private path resolution only and exercise actual file
reads/hashes, with full positive controls. Reproduction compares18 files including
all7 resources, fullBG ledger, inventories, cache, v2 admission and Result byte exactly.

Writes remain independent exclusive files. Failure after resource2 leaves only `level1`
and `resources.assets`, correct hashes, no later files and no completion receipt. Retry
into that occupied output rejects. There is no rollback transaction. The extra final
prior-source reread can also fail after resource writes; such an output is incomplete
until a completion Result exists. Parent normal promotion remains sequential too.

One evidence-binding attempt incorrectly expected the unchanged catalog to differ;
it failed before producing acceptance. The complete248-file comparison proved catalog
identity. The old script/log are preserved as `verify_evidence_binding.attempt01.py` and
`evidence-binding.attempt01.log`; the corrected assertion passes. Earlier provisional
snapshot/application output remains immutable and is superseded by `frozen-final` and
`delivery-final`, whose Result includes the final v2 receipt binding.

## Exact next parent command

No full game build was run by this lane. Parent may use this new output and unique QA
identity under its existing authorization, after final commit/integration accounting:

```sh
cd /Users/antonkrutov/Desktop/Forest
.venv-assets314/bin/python -B tools/build_russian_preview.py \
  --output /Users/antonkrutov/Desktop/Forest/localization/previews/ru-20261029-bio-input-v2-01 \
  --qa-product ForestRuActual20261029_1852 \
  --sample-surface menu-settings \
  --repair-cyrillic-metrics --coherent-legacy-face --uniform-tmp-fallback \
  --coherent-choice-face --inventory-display-completion \
  --chapter-gallery-case --haiku-option-identity --remaining-display-case \
  --bio-input-display-case
```

The exact resources-only reproduction command needs a new empty output:

```sh
outputs/ru-bio185-build-boundary-20261029/frozen-final/bio-input/runtime/python/bin/python3.14 -B \
  outputs/ru-bio185-build-boundary-20261029/frozen-final/bio-input/russian_bio_input_case.py \
  --locale ru apply \
  --source 'outputs/ru-bio185-build-boundary-20261029/fixture-normal/game/The Forest of Love_Data' \
  --output outputs/ru-bio185-private-v2-future
```

The existing native acceptance predicates remain pending: real Bio visibility/masks,
headings/fonts/wrapping/clipping, keyboard Awake/Generate/cache/Relabel order, actual
physical/touch/gamepad/Return/Done dispatch and unresolved157 input seeds. See the
unchanged v1 `native-fixture-postconditions.json` and this supplement's finite checklist.
Actual game runtime is not-run. `ordinaryTranslationEntryAllowed=false`,
`sourceGateAccepted=false`, `wholeGameAccepted=false`. No game/GUI/capture/installer,
publication, deployment, server lifecycle or automatic next phase was performed.
