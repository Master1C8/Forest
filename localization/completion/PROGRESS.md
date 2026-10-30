# Evidence-derived completion index

Run `python3 -B tools/locale_queue.py progress` for the six current language lanes.
Add `--json` for the underlying counts, exact proof/input hashes, individual stage
gates and warnings. `--locale CODE` is a read-only individual view. `--output PATH`
writes an additional exclusively created snapshot; an existing path is refused.
This command does not invoke the historical v2 queue check, change a job, start a
model or operate a game. The existing queue remains authoritative.

The percentage is a **confirmed completion index on a fixed work breakdown**,
not a measured fraction of elapsed labor, remaining hours, token cost, or chance
of release. The 28 existing content families and Russian owner-test artifact
define the common reference scope. Russian wording, review verdicts, rendering
and runtime acceptance never become another locale's proof. The Russian artifact
is a working reference; any unrun whole-game/release checks remain unaccepted.

The point allocation is an explicit planning policy, not an empirically measured
cost model. Every locale uses this same versioned allocation, totaling 100 points:

| Work | Points | Proof/partial-credit boundary |
| --- | ---: | --- |
| Scope | 2 | Exact common source IDs/values and locale corpus identity |
| Renderer feasibility | 3 | Applicable native feasibility acceptance |
| Complete shared source | 3 | Owning shared admission gate passes |
| Glossary | 4 | Complete source/locale editorial acceptance |
| Translation and immediate editing | 38 | 28 dialogue coverage, 8 additional-family coverage, 2 final stage acceptance |
| Editorial | 25 | 17 dialogue matched-version review coverage, 5 additional-family coverage, 3 final universal audit/closure/delta acceptance |
| Final fonts/resources | 10 | Final-corpus resource acceptance |
| Actual package | 5 | Verified packaged locale |
| Native gameplay/save checks | 6 | Actual applicable runtime acceptance |
| Screenshot upload | 1 | Complete delivered inventory |
| Screenshot review | 1 | All delivered frames reviewed |
| Canonical delivery | 2 | Accepted integrated delivery |

Coverage credit is `allocated points × confirmed units / fixed expected units`.
The 27 additional families split their allocated share equally as work packages.
Their memberships overlap; the index never sums them into a unique word/string
count or treats a family as a labor estimate. Haiku wording counts nine distinct
fragments. Its 27 assembled outcomes remain separate acceptance obligations.

Draft credit requires a saved exact source/target version in the canonical corpus
or a completed author's/reviewer's primary packet. Unapplied supplemental wording
may earn draft/review coverage points, while resource application stays unaccepted.
Preserved detached/source-warning/constructed-language dialogue rows do not turn
into translated wording merely because their target cells are nonempty.

Review credit requires actual pass/clean rows against the same source/target
hashes in an owning completed job. Direct and explicitly hash-bound nested review
manifests are supported, including archived receipts. Matching-version preliminary
reading is partial progress, not final editorial acceptance. Complete dependency,
source/context, independent-closure and delta requirements retain their final
stage gate. No default passes, phase counters, model tokens, duplicate receipts,
context-only decisions or technical-preservation rows supply linguistic credit.
When an authoring JSONL has only grown by appending records, the reader can retain
an old packet only by matching its **entire original SHA-256 byte stream** at a
line boundary. It records both fingerprints and the exact byte length. Appended
rows receive no historical review credit; edits within the old prefix reject.
This avoids discarding 31 verified inventory records merely because 18 new ones
were appended, while never guessing a previous packet from matching individual IDs.

Each source adapter is explicit in `progress-policy.json`; technical operands are
excluded by their recorded roles. A missing adapter reserves its full point share
as unverified, without silently shrinking the denominator. Remaining unaccepted
stages earn no confirmed credit. 100 points requires every mandatory stage gate;
a synthetic renderer/build validator cannot supply a native runtime proof.

Final stage owners can supply
`localization/completion/acceptance/LOCALE.json`. It must bind `locale`,
`policyRevision`, `sourceScopeSha256`, `wordingVersionSha256` (the SHA-256 of the
JSON list of family ID/version-digest pairs), and `stages`. Each passed stage has
the exact `proofKind` from the policy and a nonempty `evidence` array of project
paths and SHA-256 values. These are owning-stage attestations of real work, never
self-generated pass certificates. The reader checks their type, current versions
and file bindings; it does not recreate semantic judgment, native execution or
visual inspection. No such final certificate is fabricated by this implementation.
The global source gate is read from the actual owning admission manifest.

Source/reference fingerprints and calculation code are bound to every report.
Inventory expansion/reclassification requires an explicit policy/scope revision.
History labels a changed calculation/scope as a rebase, not new localization work.
Target edits can reduce credit until matching review evidence exists. Retained
receipts survive unrelated edits; old targets cannot validate a changed wording.

The full command saves a complete immutable snapshot under the existing queue's
`outputs/locale-assets-20261026/progress/`, then atomically replaces `current.json`.
This two-file publication is not a transaction: failure before pointer replacement
leaves the old current view and possibly an extra complete history snapshot.
The next comparable report includes the point delta. History is a derived view,
not a second acceptance checkpoint. A report refuses input changes during capture;
unavailable/stale proof stays visible in warnings and receives no new credit.

Lane activity is reported independently. Capacity-held/blocked states are stopped
work; an unchanged index alone does not establish that a live task stalled.
The process liveness check is bounded and is not itself evidence of useful work.

## Regression verification

`python3 -B -m unittest discover -s tools -p test_locale_progress.py -v` tests
real receipt collection, duplicate credit, changed targets, stale proofs, exact
wording hashes, context/technical exclusion, relative manifest paths (including
macOS path aliases), fixed unknown shares, 100-point gates, typed runtime proof,
input changes, history rebasing and failure between snapshot and pointer writes.
Fixture judgments replace semantic/native judgments: these tests establish the
accounting/transport boundary and never establish localization quality themselves.
