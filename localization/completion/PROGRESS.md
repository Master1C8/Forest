# Evidence-derived completion index, revision 2

Run `python3 -B tools/locale_queue.py progress` for the six current locale jobs.
`--json` includes counts, pins, gates and warnings. `--locale CODE` is read-only;
`--locale ru` verifies the owner-accepted 100-point reference. A full six-locale
report saves an immutable snapshot and then replaces `progress/current.json`.
No model, game, installer, source edit or workflow restart is invoked.

## Reference and meaning

The exact owner acceptance in `russian-owner-baseline-20261030-01/acceptance.json`
binds the Russian artifact, source and effective installed behavior. It is the
100-point reference control. Historical unrun flags do not revoke it. Its shared
mechanisms/selection policy are reusable, while target wording, fonts, native
output and release acceptance still require their own evidence. The historical
expanded global-source audit remains visible; it does not reopen accepted
unchanged Russian behavior or independently block this reference-scope index.

This is a confirmed completion index, not remaining hours, token cost or a
probability of release. Weights are declared planning policy, not measured labor.
Revision 2 retains the same stage totals and the same 28 content families:

| Work | Points | Evidence |
| --- | ---: | --- |
| Scope | 2 | Exact source and corpus identities |
| Renderer feasibility | 3 | Actual applicable target feasibility |
| Shared baseline/source selection | 3 | Exact owner-accepted Russian reference reuse |
| Glossary | 4 | Actual complete target glossary acceptance |
| Translation/editing | 38 | Dialogue28, other families8, final acceptance2 |
| Editorial | 25 | Dialogue17, other families5, final universal acceptance3 |
| Resources/fonts | 10 | Matching reviewed/preserved units in saved resources6; actual saved candidate2; final target acceptance2 |
| Package | 5 | Actual complete packaged locale acceptance |
| Native gameplay/saves | 6 | Actual target runtime acceptance |
| Screenshot upload | 1 | Complete delivered inventory |
| Screenshot review | 1 | Actual complete review |
| Canonical delivery | 2 | Accepted integrated delivery |

The 27 supplemental families split their allocated share equally. Memberships
can overlap; these are work packages, not a sum of unique visible strings.
Unknown adapters retain their full unverified share. No denominator is silently
reduced. Haiku wording counts nine fragments; its27 outcomes remain separate.

## Wording and preservation

`drafted` and `reviewed` remain linguistic counts. `preserved` is separate.
`resolved = drafted + preserved`; `reviewResolved = reviewed + preserved`.
Only these explicit disposition-aware numerators contribute wording-work points.
A preserved original is never reported as a translated phrase or semantic pass.

Baseline whole-field preservation requires the exact source hash and unchanged
target. The mask must match the hash in the accepted Russian build's overlay
binding; its source, artifact and build metadata are pinned. A status label or
source equality alone is insufficient. Unmatched held rows stay unresolved.
An assigned primary independent judgment may also affirm exact preservation with
reviewed:true, notLinguisticCoverage:true, targetEdited:false, exact equal source/
target hashes and an explicit preserved-detached-source, preserve-as-baseline or
accepted-baseline-preservation disposition. Context extras and unread rows do not
qualify. Later changed versions invalidate the old disposition.

Actual pass/clean wording receipts must match current source/target hashes.
Follow the explicitly pinned owning editorial manifest even when its filename is
`de-current.json` or another locale's equivalent rather than `manifest.json`.
Verify its locale, source and glossary dependencies before consuming its hashed
per-ID reviews. An old whole-corpus target hash does not invalidate an unchanged
per-ID version; changed target versions and later real findings still reject it.
Completed producer outcomes include continue, blocked and static-complete.
Technical/context judgments never add linguistic coverage or erase an unchanged
linguistic pass; genuine wording findings still invalidate it. Absolute and
project-relative paths resolve to the same declared pinned review file. Appended
JSONL evidence can retain only its exact entire old byte prefix at a line boundary.

## Saved resources and final gates

`locale_progress_evidence.py` reads known saved candidate manifests from the
existing version-bound initial candidates and completed owning-phase evidence.
It verifies actual output bytes, recipe/config/plan versions, own-locale identity,
managed readbacks and current reviewed/preserved target versions. Both physical
dialogue bindings must exist together. Missing, changed, foreign or unbound bytes
earn no resource credit. Binary files are hash-checked without retaining them in
RAM. Separate candidate fragments do not become one completed game package.

Resource progress is incremental and is not final integration, font or native
acceptance. A real final resources acceptance covers the earlier partial resource
milestones and completes their10 points. Partial saved bytes never supply native,
package or release passes. Unchanged accepted implementation and wording evidence
is reused by fingerprint, without model receipt-only phases.

Actual final stage attestations can be in a completed owning result's
`stageAcceptance`, `localization/LOCALE-assets/completion/acceptance.json`, or the
legacy `localization/completion/acceptance/LOCALE.json`. All use locale,
policyRevision, sourceScopeSha256, wordingVersionSha256 and stages. Each passed
stage must name its exact policy proofKind and nonempty evidence pins. All current
versions are checked. These are attestations of actual owning-stage work, not
self-generated pass certificates. No final acceptance file is manufactured by the
calculator. Missing acceptance remains not-accepted, not an inferred pass.

## History, consistency and activity

Revision 2 is an explicit rebase. An increase caused by the changed policy or
calculator is not new localization work. History compares point deltas only when
policy revision, source scope and calculation fingerprint match. The fingerprint
includes both calculation modules. Workflow concurrency/settings are recorded as
process context, not treated as changed game source; editing them cannot silently
invalidate all content or acceptance evidence.

Snapshot and pointer writes are individually atomic, not one transaction. Failure
between them preserves the old pointer and may leave a complete extra snapshot.
Inputs are rehashed before publication; concurrent changes reject the capture.
Warnings retain stale proof details. Activity/liveness is separate from completion;
a stopped worker or unchanged index alone is not a new quality judgment.

## Regression verification

`python3 -B -m unittest discover -s tools -p test_locale_progress.py -v` covers
exact receipt versions/prefixes, duplicate credit, static-complete, nonlinguistic
review isolation, affirmative preservation, the accepted Russian100 control,
actual saved bytes and both dialogue copies, partial/final resource milestones,
unknown denominators, strict native proof typing, input drift, rebase history and
failure between snapshot/pointer writes. Synthetic fixture judgments replace
semantic/native judgments; tests establish accounting and transport only.
