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
For a known capacity failure, a later explicit owner instruction to repair/continue
allows one restart on the same pinned model after exact failed-request reconciliation,
confirmed process exit, pinned-input checks, rebuilding any completed authored TSV and
verifying that all earlier target hashes survive. The parent supplies a job/overlay-bound
receipt through `--reconcile-capacity`; old failure history is retained. Unknown transport
outcomes or a changed receipt must still reject before another model request. Capacity
does not authorize changing models or silently entering an automatic retry loop.

Regressions: a finished CLI turn at 3,540 saved IDs is an incomplete batch, not a
finished assignment; continuation must preserve those exact IDs and start at the
recorded next scene. Two successive saved batches must trigger two distinct fresh
requests, without inheriting history, duplicating IDs or resetting the authored TSVs.
No increase in targets/resolved or visited IDs must hold, not create a status loop.

A recovered reconnect diagnostic (including429) is not a failed turn when CLI exit0,
an actual turn.completed usage receipt, a valid continue result and verified artifact
growth all agree. Retain diagnostics but continue. A terminal turn.failed or nonzero
exit still holds. `--reconcile-completed` recovers already completed work mistakenly
held by older supervisors without rerunning it. Exact capacity failures may include
the known429 retry diagnostic; unknown transport errors remain ineligible.

An objectively unsupported old target may move to an explicit source hold only with
`retired-targets.json`: preserve its exact text, target/source hashes, objective reason
and pinned evidence in its own lane. The snapshot validates every receipt and the
progress comparison matches the old target hash. Historical receipts survive later
resolution. Unexplained deletion or a mismatching old hash still rejects. Retirement
alone is not new draft coverage. Regression: the unsupported male cousin at
ds:468:767 moves to an evidenced hold while its original wording survives; the same
missing ID without that receipt must fail. Self-correction is not independent audit.

Non-Russian configured jobs require a locale/write-scope/contract-hash binding before
the first model request. Binding verifies the exact locale-specific contract header;
a copied Russian or different-locale contract must reject before source reads. The
actual CLI prompt independently states the target and exact writable directories.
Preserve a non-Russian job's own contract during supervisor upgrades; the Russian
legacy contract is never a generic replacement. Regression: replacing the German
contract with the Russian one must fail both binding and subsequent validation.

For a parent-only disjoint supervisor repair, maintain one Git transaction owner.
A persistent idle codex-code-mode-host child is part of the technical client, not a
running game/tool action. A bounded handoff may quiesce the verified client, its idle
host and observer only after event/descendant/index checks; always resume the exact
same identities in finally. Never pause a native-input helper mid-pulse or another
job. Preserve any foreign staged work instead of resetting the shared index.

A source-held successful turn may resume with `--reconcile-repair` only when an
owner-authorized, changed technical assignment is bound to its exact job, overlay,
input pins, held phase/thread and bounded job-owned brief. Keep the old hold/result
and history. The first fresh phase receives the repair assignment; ordinary fresh
continuation follows only after verified saved progress. A plain retry of the same
translation-only brief, a live job, changed checkpoint or mutated repair brief must
reject before a model request. Repair actual consumer/adapter boundaries within the
lane's write scope; preserve shared source bytes, prior targets and other locales.
Source findings produced inside the lane are evidence/proposals for the shared source
stage, not a separate locale-specific inventory or final source acceptance.
Regression: Russian23 needs source classification at10453 targets; a bound repair
assignment can investigate consumers and fix the adapter in24 without rerunning23
or pretending that the1793 holds are completed translations.

Classify held fields through the original consumer, effective sequence, conditions
and source occurrence. Colon endings, uppercase wording and editor-like phrasing are
not proof of a service field. `tools/inspect_dialogue_consumers.py` preserves bounded
original IL evidence in a new immutable source directory. The dialogue getter and
subtitle/response visibility path must be considered together. Likewise only actual
engine tags are control syntax: ordinary square-bracketed narration can carry visible
words. Regression: the flower text at131:153/540:232 must not be rejected merely
because it is bracketed; changing a real `[pic]`, variable or nested Lua operand
must still reject. Runtime reachability and complete source acceptance remain separate.
