# Russian asset translation: automatic fresh continuation

Game: The Forest of Love 0.45; source English; target Russian `ru`; standard
localization. Canonical checkout: `/Users/antonkrutov/Desktop/Forest`, `main`.
The owner explicitly authorizes a translation CLI running alongside the technical
CLI, provisional drafting before remaining technical gates, and repairing/resuming
both jobs. Do not request that permission again or stop either approved lane.

Every model request must explicitly use `gpt-6.1-sol`, reasoning `high`, provider
`openai`, with user defaults ignored. Verify actual argv before localization input.
NEVER Astra, aliases/fallbacks, external translation engines, inherited model history,
agents or nested CLI/model jobs. The supervisor launches sequential fresh translation
phases; this lane has one worker at a time and may coexist with technical QA.

Write only `localization/ru-assets/` and your own progress, continuation and phase
result files under `outputs/ru-assets-parallel-20261026/`. Do not edit its supervisor,
support module, contract, request, input pins, locks, job state or event logs. Every
other project path is read-only. Never mutate Git/index/branches, run a game/installer,
publish, deploy, access servers or change installed assets/saves. The technical lane
alone owns Git transactions. Its live presence or commits are not translation blockers.

Read applicable AGENTS.md, `/Users/antonkrutov/.codex/instructions/sitefor-mods.md`,
the referenced universal localization prompt/audit manuals and vn-game-localize rules.
Use the existing README stage binding. Normal source, special-scene, renderer,
editorial and release gates remain honestly pending; the owner permits drafting now.
Do not replace the universal acceptance algorithm or claim a final localization.

Verify all seven hashes in this job's `input-pins.json` before work and at the end.
The accepted compact English/Russian glossaries are `localization/glossary/{en,ru}.json`,
171 IDs with two accepted glossary layers. Read the complete compact working glossary
once per fresh context. Preserve known gender/address strategies, Sable's uncertainty,
and approved neutral agreement for unspecified mice, Fisher, Ashe, Ruby, Mia and Whiskers.
No guessed identities or incidental glossary changes. Source findings record actor-ID
reuse in older scenes; an actor number alone does not establish identity.

Resume actual batches and `continuation.md`, not previous chat/model transcripts.
`localization/source/dialogue-candidates.jsonl` has 12,246 logical candidates and two
bound physical copies. It is only the dialogue source family, not whole-game coverage.
Use the exact serialized conversation trees named by dialogue-manifest.json for
actors, conditions, branch links and context; flattened adjacent rows need not be
consecutive dialogue. Prior authored TSV batches must survive continuation unchanged
unless concrete source evidence justifies correction. Never regenerate their wording
with scripts or retranslate valid batches for preference.

Author real Russian wording directly, immediately edit against the source and glossary,
save coherent batches frequently, then use existing `corpus.py build` to assemble and
validate bindings, controls, numbers and separators. Do not count copied English,
placeholders, technical keys or unjustified unchanged text as translated coverage.
Keep commands, IDs, placeholders, comparison operands, markup, conditions and other
non-display syntax exact. Record specific ambiguities; continue unaffected scenes.
Scripts may store/validate authored wording, never generate it. Re-run applicable poem
checks after overlay rebuilding; mechanical checks are not an independent semantic audit.

Each fresh phase handles a substantive bounded contextual batch and returns a result
before context exhaustion. The supervisor verifies saved target/visited-ID growth and
starts the next fresh phase automatically. A normal partial batch is `continue`, not
whole-job completion and not a reason to wait for another owner request. Update compact
root progress/continuation plus the phase result path supplied by the supervisor.
Preserve exact next ID/scene and real counts; don't copy a stale verified worker PID
into new evidence. A result file's status alone does not prove stored corpus progress.

Outcomes: `continue`, `draft-complete`, `needs-owner`, `blocked-transport`.
`draft-complete` requires all 12,246 candidates to have targets with no unresolved holds.
It covers this draft family only, not full source/editorial/font/resource/runtime or
release acceptance. After unvisited scenes, investigate held groups using source
evidence; report genuinely unresolved decisions precisely without guessing or looping.
Transport/unknown request failures stop for reconciliation rather than automatic retries.

Regressions: a finished CLI turn at 3,540 saved IDs is an incomplete batch, not a
finished assignment; continuation must preserve those exact IDs and start at the
recorded next scene. Two successive saved batches must trigger two distinct fresh
requests, without inheriting history, duplicating IDs or resetting the authored TSVs.
No increase in targets/resolved or visited IDs must hold, not create a status loop.
