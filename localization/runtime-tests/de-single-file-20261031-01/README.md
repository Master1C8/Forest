# German single-file build: in-game test, 2026-10-31

The exact package `dist/Forest-de-25cfdea9b625` was tested in two disposable
CrossOver game copies. Functional checks passed; visual acceptance remains open
for two concrete findings. No translation, font or shipped game resource was
edited. Both test games exited and restoration checks passed.

## Verified scope

- German main menu and settings loaded through original UI routes.
- Original Continue loaded a generated task-owned save. This does not establish
  new-save/reload continuity or compatibility with an owner's save.
- All48 item descriptions and four neighboring inventory branches matched
  loaded original consumers:52 unique cases,53 observations including a repeat
  for capture. Measured native glyphs stayed inside masks with original opacity.
- All195 selected quest fields matched runtime values; the Finley journal
  rendered the exact German objective.
- Actual New Game reached conversation145, entry205; original response206
  advanced naturally to NPC entry207. No conversation/narrative state was forced.
- All six native frames were reviewed in fresh pinned Sol/high/OpenAI contexts
  through WebP80 copies at1280×720. Four passed; two have open findings. The
  coordinator remained text-only.

## Findings

1. **DE-SF-001 — English inventory heading.** The actual frame displays
   `INVENTORY`. Twelve known heading layers contain
   `<size=22>I</size>NVENTORY`; existing German targets use
   `<size=22>I</size>NVENTAR`. Their IDs are absent from the new language catalog
   because migration selected native fields that differed in Russian. Repair
   shared selector/catalog coverage and exact binding. The source inventory
   and German target wording already exist.
2. **DE-SF-002 — compound split without a hyphen.** In the journal's left list,
   `Erinnerungsstücke` wraps as `Erinnerungs` / `stücke`. The shared display
   mechanism needs explicit word-boundary/fit data. Preserve canonical title,
   control identities and minimum readable size; reuse matching German policies.

The intro nameplate `???` is intentional before introduction. Initial review
retained it as unresolved context. The original nameplate branch and later
introduction node210 resolved it; the unchanged two frames passed a new review.
Both review cycles remain preserved.

## Reuse and regressions

A read-only manifest view maps the new package's `files` to the legacy runner's
`outputs`/`gameResources` without changing bytes. It pins the compiled manifest
and original companions. It is test metadata, not another localization builder.

The old bridge included an observer for a former candidate-specific heading
helper absent from the accepted Russian framework. For basic/intro scope omit
that unused observer and dispatch only in the new frozen probe snapshot. Never
add a dummy game helper or alter shipped resources to make a test compile.
Retain failed preparation and resume its unfinished boundary; do not replay a
successful compilation/launch. Pin later-read helpers and binaries before launch.

Regression: a source-equal Russian inventory caption can require German wording.
A complete target-selector inventory cannot be inferred from a Russian diff or
the number of filled JSON entries. Reconcile existing canonical selectors and
reuse valid target receipts. This gap does not reopen accepted Russian behavior
or require source extraction, a global framework audit or a technical model job.

## Evidence and limits

`report.json` binds exact inputs, runs, cleanup, reviews and findings.
`inventory-heading-diagnosis.json` has all12 actual/expected values.
`configs.json` preserves run inputs. `usage.json` accounts for all five fresh
review requests, including initial uncertainty, and a separate mixed coordinator
subtotal. Cached input/reasoning are subsets. Earlier context preparation,
final reporting/integration and platform overhead remain unmeasured.

Full story, later tutorial branches, actual new-save/reload continuity, real-game
haiku endings, dam minigame and complete pause/gallery/special-scene coverage
were not tested. No release, installer, publication or deployment is accepted.
Translation queues remain owner-stopped.
