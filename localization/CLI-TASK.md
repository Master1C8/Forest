# Russian localization: sequential CLI continuation

The owner requested the complete Russian standard localization of The Forest of Love
0.45 and now explicitly authorizes **sequential CLI sessions with clean contexts,
strictly one at a time, without parallel tasks** (October 26, 2026). This supersedes
this file's former prohibition on fresh sessions. Do not ask for that permission again.

The parent-owned serial runner launches each fresh `codex exec` with gpt-6.1-sol/high/
OpenAI pinned explicitly and verifies the exact permitted registry slug before each
launch. NEVER use Astra, aliases/fallbacks, external translation engines, or inherited
conversation history. Each worker must not spawn other agents or CLI/model jobs;
it hands back a concise next-phase brief. All model work remains one serial stream.
Separate fresh review sessions can supply identifiable independent review; do not
retroactively relabel the prior author's self-review as independent.

## Scope and canonical files

Game checkout: `/Users/antonkrutov/Desktop/Forest`, canonical `main`. Initial accepted
technical work is at commits 303a697 and 89898ca. The parent may prepare the current
handoff before dispatch; the active CLI worker then has exclusive write/index ownership.
The parent only monitors and accounts for usage. No configured remote exists: do not
invent one, create a repository or stop ordinary local work solely for that reason.
Preserve the unrelated Helltaker ZIP and all existing valid evidence.

Read applicable AGENTS.md, `/Users/antonkrutov/.codex/instructions/sitefor-mods.md`,
the mandatory universal localization prompt/audit manuals, and the relevant skills.
Reuse the existing CHECKPOINT.json and README stage binding. Do not build a second
project, broad framework, game card, task or tracker. Full local translation/editing,
necessary assets/fonts/tools/packaging and isolated runtime verification are authorized.
Original install and owner saves must remain unchanged. No site publication, protected
source edit, deployment or server lifecycle action is authorized by this task.

Pinned install: `/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest`.
Unity player 2020.3.24f1; bundle 2020.3.22f1; version 0.45. Windows build via CrossOver;
this does not establish native macOS game support. Original exports and hashes are
`assets/source-v2/`; retain the generated-schema alignment repair in the existing tools.
Canonical master is `/Users/antonkrutov/Desktop/SiteForMods`; content access is only
through `./vnrevival`. Preserve its unrelated FTL files. Read relevant bounded files,
not the full prior glossary audit or old CLI conversation.

`localization/glossary/en.json` and `ru.json` are accepted 171-entry snapshots with
both glossary review layers and canonical hashes in CHECKPOINT.json. Reuse them.
All meaningful-name decisions were delegated by the owner, including Russian names.
Neutral agreement for unspecified mice, Fisher, Ashe, Ruby, Mia and Whiskers is approved;
preserve Sable's uncertainty. Do not edit or republish the canonical English source.

## Current evidence and remaining work

The first CLI session 01a175c3-4558-7883-8cb7-fa7f5d678bed ended normally with ZERO
translated game units. It completed useful technical preparation, not a localization.
Current source candidates are `localization/source/dialogue-manifest.json` and
`dialogue-candidates.jsonl`: 12,246 fields / 24,492 occurrences / 100,236 words, but
complete source/consumer/special-scene gates are still unaccepted. BGDatabase, UI,
code literals and baked images remain part of the agreed complete inventory.

Read `localization/feasibility.json` and the exact findings in
`localization/probes/ru-20261026-06/native-result-01.json`. No-op/reinsertion checks,
CRC-preserving Addressables catalog updates and ordinary synthetic dialogue progression
197 -> 199 -> 200 -> 202 -> unchanged 203 passed. TMP overflow was corrected. The
native visual pilot FAILED: Cyrillic in the legacy nameplate is taller/thinner than
adjacent original Latin/digits; decomposed-mark placement is uncertain. Preserve the
failure, repair the responsible shared resource, capture a new version and review it.
Other narrow UI/item/quest/menu, baked-texture and fictional-font paths are unverified.
Do not mark a whole renderer accepted from this ordinary dialogue test.

The current adapter/tooling is in `tools/build_renderer_probe.py`,
`tools/addressables_catalog.py`, `tools/probe/prepare_bridge.py`, ForestProbe.cs,
InjectProbe.cs, command.py and related receipts. Current test runs were restored and
stopped; verify process identity before starting or rewriting anything still live.
Use an isolated copy with VNRevivalQA/ForestRuRendererProbe identity, excluded tfol.*
files and background execution. Never ship the temporary inspection bridge.

## Context boundaries and continuation contract

Work phases are TEXT-ONLY contexts: investigate/repair/build/capture/restore, prepare
pinned native manifests/packets and the next review brief, but do not open images.
When pixels are needed, finish the work phase and request a `visual-review` phase.
Review phases inspect at most one or two originals under the visual skill's bounds,
write actual per-image findings/results and a short handoff, then immediately finish.
They must not run games, repair resources, package, commit, or poll after image input.
The runner uses the skill's external 180-second review wrapper. A failed/unknown
transport attempt holds new submissions; no automatic unchanged retries. Never edit
Codex history or force compaction to pretend an image context has been cleared.

Each phase brief specifies its scope, allowed paths and exact inputs. It is a fresh
session with no inherited parent/worker history. Supply only the next phase's necessary
facts and decisions; never paste the transcript or a bulk historical report.

Before ending, write the phase result to the path supplied by the runner:
`{"outcome":"continue|complete|needs-owner|blocked-transport", "summary":"...",
"evidence":["project-relative substantive evidence paths"],
"nextKind":"work|visual-review", "nextBrief":"absolute path to a concise new brief"}`.
For `continue`, evidence must identify material artifact, coverage or verified-knowledge
progress and nextBrief must exist (at most 16 KiB). Do not restart completed stages or
make another session just to repeat unchanged status. Write concrete findings/blockers.
A `needs-owner` result is for a genuine missing decision/authority, not the already
approved sequential sessions, names, type, ordinary repair, or lack of a remote.
An unavailable transport stays explicitly blocked rather than spawning a replacement.
A completed phase does not imply the complete localization is done.

After renderer/source acceptance, settle every discovered special-scene group's Russian
adaptation before ordinary translation. Then directly author coherent contextual batches,
edit immediately, preserve all controls, and complete the universal full semantic /
independent diff / dependency delta algorithm using sequential fresh reviewer contexts.
Use the fixed shared stage gates. Final fonts precede final texture production. Build,
resource readback, runtime/visual acceptance and canonical integration remain separate.
Commit verified phase work on main with exclusive index ownership; preserve unrelated
changes. Keep exact measured usage and provenance; cached input and reasoning are subsets.
Only report `complete` when the requested local localization is actually accepted and
its deliverable exists; source counts, a successful build or an evidence ZIP do not suffice.
