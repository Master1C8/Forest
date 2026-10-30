# Shared locale resource preparation

The six `composed.<locale>.json` profiles bind preserved saved resource candidates
to the locale-owned process. Run `python3 -B tools/locale_build.py --profile
localization/resource-profiles/composed.<locale>.json --locale <locale> --output
outputs/locale-assets-20261026/<locale>/<candidate> --mode build|resume|check`.
This common procedure verifies the complete pinned recipe, actual serialized and
managed output hashes and saved readbacks, then materializes the exact candidate
in the locale's own directory. Completed output uses check. It calls no model,
installer or game, and leaves integration review/native/runtime acceptance pending.
Historical technical directories are immutable inputs; no technical worker or
inbox receipt is needed. The coordinator owns concrete common-code repairs once.

Use one entry point for new narrative-page and haiku identity resources:

```sh
.venv-assets314/bin/python -B tools/locale_resources.py \
  --profile localization/resource-profiles/narrative150.pt-BR.json \
  --locale pt-BR \
  --output outputs/locale-assets-20261026/shared-resource-factory/pt-BR/narrative150-new
```

Use a fresh output directory. `--mode check` verifies existing output against its
exact profile, code and pinned dependencies. Narrative `--mode resume` continues
the same incomplete directory, preserving matching files and rejecting conflicts.
Manifest publication is last; sequential file writes have no transaction or
rollback. Haiku has no partial-build continuation: reconcile a failed build before
repeating. Its backend manifest and final `factory-binding.json` are both required.

## Code, source and locale data

`tools/locale_resources.py` owns the common interface, receipt joins, accounting
and publication. It reuses the shared publisher and frozen haiku adapter named
and hashed in each profile. Existing legacy builders and their immutable runs
remain unchanged. Do not make another language-specific Python wrapper.

The source inventory, physical roles, source consumers, evaluation identities
and mechanism regressions are shared technical work. A locale profile supplies
only its own pinned packets, independent review receipts, model/runtime
provenance, resource candidate, culture and output namespace. New locales use
the same algorithm. Missing reviewed material stays missing; another locale's
translation or semantic judgment is never substituted.

These four profiles instantiate existing saved evidence, not a complete list of
ready locales. An unsupported family needs one coordinator-owned shared adapter repair
only when a named game predicate actually requires it; no technical stream is created. Source/target wording and
independent linguistic review remain language-specific.

## Narrative150 contract

The complete original inventory is 25 logical pages and 150 physical members:
25 layout providers, 25 faces and 100 glows. A reviewed logical-page packet may
bind its six identical-source members. A physical-member packet credits only
the members actually reviewed. A partial page does not become complete.

The profile `inputs` pins `sourcePages`, `sourceMembers` and optionally
`candidateResources`. Each wording packet requires `authorTask`, `reviewerTask`,
`authorResult`, `reviewerResult`, `authorRuntime`, `reviewerRuntime`, `packet`
and `reviews`, each with `path`, exact `sha256`, and optional `bytes`.

For one packet these pins can also be in `inputs`, as in the current profiles.
To accumulate separately reviewed batches, use `wordingPackets: [<pin group>, ...]`.
Each group keeps its own independent reviewer and exact receipt. All rows in each
packet must have matching accepted receipts; groups must be disjoint. Resolve an
overlap explicitly by selecting a nonoverlapping packet set with owning receipts;
the factory never silently chooses the newest target. Unchanged accepted groups
are reused without a fresh linguistic reread.

Each page stores its prose once; physical selectors reference the page and the
original receipt. `requirements.jsonl` records raw/NFC/NFD diagnostic codepoints
and optional candidate cmap gaps. Authored strings are never normalized. A cmap
check does not prove atlas allocation, layout, fallback or native rendering.

## Haiku27 contract

The profile pins the existing shared backend and the full saved snapshot manifest,
with explicit matching `locale` and `culture`. The adapter retains nine identities,
194 selector dispositions and all 27 ordered combinations. Only isolated extracted
CIL fixtures run in .NET; it neither loads the original game nor offers a game
patch command. `factory-binding.json` binds profile, factory code, input pins and
the backend manifest. Backend files are hash-checked during verification.

## Acceptance and regression

Source admission, application, font/native rendering, package and release gates
remain held. A successful resource preparation does not increase linguistic
coverage, accept a runtime route or make a localization ready. The new factory's
independent technical acceptance remains pending in its output manifests.

Run `python3 -B -m unittest discover -s tools -p test_locale_resources.py -q`.
The 11 tests use synthetic wording/reviews with the real common publisher:
all six locale configurations, partial coverage, stale/wrong-locale/unread receipts,
conflicting layers, accumulation of disjoint packets, overlap rejection and actual
interruption/continuation. They establish transport/accounting, not semantic QA.

`localization/completion/shared-resource-factory-20261030/verify.py` checks four
real v4 deliveries, legacy Portuguese page/selector parity, exact Portuguese and
Spanish haiku maps/generated source/fixtures, 27 outcomes under three cultures,
and wrong-locale/culture rejection. Its saved `verification.json` identifies the
tested code and output manifests. Prior v1/v2/v3 local verification outputs remain
historical evidence and are not the current code's delivery.
