# Three parallel single-file locale tasks

Owner request: create three parallel tasks for the next three languages after
the completed German and Spain-Spanish single-file work. The tasks are running
in the canonical Forest checkout, with separate data/output ownership:

| Locale | Task | Authoritative target |
| --- | --- | --- |
| es-419 | Latin American Spanish migration, primary proofreading and static build | `localization/languages/es-419.json` |
| pt-BR | Brazilian Portuguese migration, primary proofreading and static build | `localization/languages/pt-BR.json` |
| zh | Simplified Chinese migration, primary proofreading and static resources | `localization/languages/zh.json` |

[Manifest](manifest.json), [shared assignment](TASK.md), per-locale configurations
and [launch receipt](launch-receipt.json) record the exact scope, source references,
current glossary snapshots, protected values and process identities. All three
fresh runtime attestations verify **OpenAI / gpt-6.1-sol / high**, null parent and
no inherited conversation. No Astra model or nested model is authorized.

Live status is `outputs/single-file-parallel-20261101-01/status.json`; each lane's
phase contains events, current work/checkpoints, eventual result and terminal
usage receipt. The detached supervisor records exits and actual fresh-session
usage. It does not start another model or restart an old queue after a result.
Do not relaunch an unknown or still-live submission.

Workers own only their locale JSON and new locale artifacts. The coordinator
owns shared code, root documentation, the Git index and canonical commits. Shared
helpers remain unchanged while these jobs can read them; any concrete shared
repair requires preserving the live execution version. The common compiler cache
was verified before launch; resource builds use separate locale outputs and
locale-prefixed temporary directories.

These are active author/editorial tasks, not completed localizations. New wording
needs actual independent review; self-editing and compile success do not provide
that acceptance. Each author produces an exact immutable review-ready handoff
for coordinator review orchestration. Missing glossary/source/editorial/font or
native predicates remain explicit. Existing saved drafts and stopped queues stay
preserved. No game, GUI, screenshot, installer, external publication, deployment
or server lifecycle action is authorized by this run.

The source inventory and accepted Russian mechanisms are reused. Target wording
comes from each locale's own saved authors/current glossary and direct editing.
The Spain-Spanish top/bottom choice is not silently imposed on another glossary.
CJK font/data work is limited to concrete registered roles and corpus checks;
actual Chinese rendering remains a separate untested gate.
