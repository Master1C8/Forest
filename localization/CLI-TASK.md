# Russian localization: single CLI task

The owner requested the complete Russian standard localization of **The Forest of
Love 0.45**, then explicitly chose **one CLI task without parallel tasks**. Continue
this existing work; do not launch agents, another CLI/model job, a new user chat,
external translation engines, or a separate checkout. Model: **gpt-6.1-sol / high /
OpenAI**, explicitly pinned. Never use Astra, an alias, fallback or retry.

## Scope and authority

Canonical game checkout: `/Users/antonkrutov/Desktop/Forest`, branch `main`, initial
commit `57a65e9`. The current dirty changes were prepared by the parent for THIS task;
take exclusive ownership, preserve them and continue. No other game writer is active.
Do not reject this handoff merely because its own preparation is uncommitted. Preserve
the unrelated Helltaker ZIP. No Git remote is currently configured: do not invent a
remote or create a repository. Finish local work and report the missing push target.

Use the mandatory workstation instructions and relevant localization skills. Read
`/Users/antonkrutov/.codex/instructions/sitefor-mods.md`, both mandatory universal game
localization manuals, and the shared process references pinned in `CHECKPOINT.json`.
Use the existing checkpoint and README stage binding, not another tracking system.
Normal safe local technical repair, source preparation, direct translation/editing,
font/resource work, local packaging and isolated runtime checks are authorized.
Do not publish a mod, change site/game visibility, publish glossaries, deploy, or
perform any server lifecycle operation. Only the installed Windows build is pinned;
CrossOver execution does not prove native macOS game support.

The parent's mutable operational logs and job supervision live in
`outputs/ru-localization-cli-20261026/`. Do not edit that directory, its prompt or
launcher while this job is live. Parent will only monitor; it will not compete for Git.

## Existing accepted inputs

- Installation: `/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest`.
  Do not write to original installed assets or owner saves.
- Unity player 2020.3.24f1, Addressables bundle 2020.3.22f1, version 0.45.
- Original exports, hashes and metadata archive: `assets/source-v2/`; verified
  extraction is historical, not complete game-text source acceptance. Reuse it.
  See README for the generated-schema alignment correction and unresolved metadata.
- Dialogue source copies: `sharedassets0.assets:3336` and bundle
  `StreamingAssets/aa/StandaloneWindows64/defaultlocalgroup_assets_all_298c5a4d1d1846b1a8d2c7d5da3f319c.bundle`
  object `-9011735310751668748`. There are 627 conversations, 16,396 entries,
  about 100,236 dialogue/menu words, plus BGDatabase/UI/texture content.
  Complete visible-ID denominator is NOT yet established; translated game units = 0.
- BGDatabase v5 binary includes item, quest, bio, chapter and other visible fields.
  Existing read-only tooling/evidence is in
  `/Users/antonkrutov/Desktop/SiteForMods/data/games/the-forest-of-love/tools/` and
  `/Users/antonkrutov/Desktop/SiteForMods/outputs/the-forest-of-love/source/`.
  Inspect only relevant bounded files, not the entire prior glossary audit.
- Canonical master: `/Users/antonkrutov/Desktop/SiteForMods`; use only `./vnrevival`
  for site-content operations. Preserve unrelated untracked FTL files there.
- Accepted 171-entry English/Russian glossary snapshots are
  `localization/glossary/en.json` and `ru.json`, with canonical bindings in checkpoint.
  Source raw hash: `b99ff663f69ca19307691cee8f49b8d33d33f8130a6b51695fceff9449c3b5ab`.
  Canonical all-locale translation raw hash:
  `5690ff2b205a49df19a55643be62fa44175113ff9078e572a3a62e48922c244a`.
  Both complete glossary review layers were accepted and published already. Reuse
  unchanged evidence. The owner delegated all name-rendering decisions; do not ask
  for them again. Neutral wording for unspecified mice, Fisher, Ashe, Ruby, Mia and
  Whiskers is owner-approved. Preserve Sable's source uncertainty. Do not edit source.
- `special-scenes.json` is an earlier visual registry with pending textual discovery.
  The master's same-game registry contains later glossary research, not accepted full
  game adaptation. Complete source/consumer and special-scene gates before mass text.

## Current renderer probe

Read the compact receipts in `localization/probes/ru-20261026-03/` and latest logs.
`tools/build_renderer_probe.py` builds an isolated game copy, excludes `tfol.*`, sets
company/product to `VNRevivalQA / ForestRuRendererProbe`, enables background execution,
adds the existing dynamic Liberation Sans fallback to TMP Settings, and changes four
synthetic fields in the tutorial dialogue. This is not translated game text.

Five bounded assets passed no-op full-tree and unselected-object raw-byte equality,
then exact authored-versus-reopened readback. `tools/addressables_catalog.py` preserves
catalog extra-data offsets, updates CRC/size, retains CRC checks and proves the original
CRC (`48adedf7`) against the original bundle; rebuilt CRC is `41b686d6`. This repaired a
real Addressables load rejection. The player then reached version 0.45 and the main menu.

The primary MatchupPro/Anton static atlases have no Cyrillic. OokLanguage_TMP is a
fictional writing font: preserve its mapping and source controls. The existing dynamic
Liberation fallback is only an early technical candidate, not final font acceptance.
Settings/menu labels proved to be baked textures, with no active TMP text in that
screen; modified legacy TMP duplicates are NOT proof of Cyrillic menu rendering.

Temporary QA bridge sources are `tools/probe/ForestProbe.cs` and `InjectProbe.cs`.
The bridge is loaded by a single verified `MainMenuController.Start` call insertion;
all other methods are bytecode-equivalent. Newly added RuntimeInitializeOnLoadMethod
attributes did not provide a verified initialization path in the built player.
Never ship the inspection bridge. Compile against the original managed references;
the direct C# compiler also needs `netstandard.dll` for the dialogue subtitle type.
Compiler: dotnet SDK 8.0.131, csc under its Roslyn/bincore. Mono.Cecil 0.11.6 is cached.

The bridge supports guarded `show-menu`, `menu <type> <method>`, exact `click <path>`,
`dump`, `continue`, `capture <new-name>.png`, and `quit` commands through a signal file.
`tools/probe/command.py` records fresh acknowledgements and refuses an existing command.
It invokes actual game-thread menu/continue paths and captures the native backbuffer;
this avoids owner-browser input/focus and is more deterministic than mouse automation.
No Chrome operation is authorized. Capture should use native game frames, no overlays.

Latest launch was `launch-4.json` (wrapper PID 72443, now exited). It reached main menu,
options, play menu, then **IntroForest** through normal menu callbacks. Save isolation
was confirmed from the actual runtime persistentDataPath. The only captured image so
far is `diagnostic-intro.png` (unreviewed); no Cyrillic rendering or dialogue progression
has passed. `first-gameplay-state.json` has no active conversation yet.

The next `dump` timed out; `intro-progress-state.json` was NOT created. The signal file
`command.txt` still contains `dump`, with no corresponding new acknowledgement. A fresh
process listing at handoff showed no remaining task-owned game/wrapper process. Its exit
cause is unknown; reconcile the logs/capture before restarting, and preserve this outcome.
Do not blindly resend a timed-out command or claim the observer timeout proved the exit.
Earlier failed/partial runs are diagnostic evidence, not successful runtime checks.

The actual `IntroForestCutscene` consumer was decompiled into the probe folder. It walks
waypoints and launches `NewGame_Intro` arcs before BunnyHouse; the synthetic tutorial
sample is later. Trace the current scene rather than clicking blindly or assuming its
absence is a renderer failure. The helper's subtitle dump uses JsonUtility and still
needs validation on an active conversation. Keep capture, input/state progress, font
loading and visual acceptance separate. Do not mass-translate before feasibility passes
or an actual required owner risk decision is obtained.

## Execution and finish

Continue autonomously through the authorized stages, directly authoring every Russian
phrase from the pinned English source/glossary. Use coherent batches with immediate
editing and exact preservation of technical controls. Follow the universal semantic /
dependency closure / diff-delta protocol. Under the owner's single-task restriction,
do not invent an independent reviewer or count self-review as independence; record an
unavailable criterion honestly and finish all independent work. Apply bounded native
image review rules without starting another agent. Keep concrete blockers precise.

Maintain measured exposed CLI usage and exact model provenance. Do not estimate tokens
from text size, invent prices, or add cached/reasoning subsets twice. Reuse unchanged
checks; don't build a new framework or repeat expensive full exports without cause.
Never turn an unverified source/renderer gate into a passed claim. Check project-owned
process identity before retrying or rewriting helpers a live job may still read.

Complete necessary local tools, resources, packaging and verification; preserve owner
data. Commit verified work on canonical `main` with exclusive index ownership. There
is no configured origin; do not create one. At completion write a concise final report
with exact coverage, acceptance and runtime results, artifact/checkpoint paths, commits,
measured usage and any remaining constraints. A started task is not a finished localization.
