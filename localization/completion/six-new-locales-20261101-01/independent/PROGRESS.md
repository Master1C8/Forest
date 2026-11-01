# Independent review progress accounting

Use the registry in `status-index.json` and each registered phase's actual process,
runtime verification, status and terminal receipt. A submitted launch is not proof
of a live worker. Preserve active pinned helpers; this recipe changes no live code.

For editorial progress, read each phase's pinned review packet and all of that
phase's `*judgments.jsonl` files. Count unique assigned IDs with exact matching
sourceSha256 and targetSha256. A final combined ledger can duplicate entries in
family journals: count each ID once. Reject conflicting verdicts or version hashes;
do not silently prefer a file. A partially written final line remains uncounted.
Do not count preparatory batches, read-file creation, packet lengths or authored
translation completeness as explicit independent judgments. Separately describe
ongoing reading when its judgments have not yet been materialized.

These counters measure recorded reviewer output, not a new semantic acceptance.
They cannot establish complete required context, correct judgments, published
review closure, correction acceptance, font/runtime/build or release acceptance.
Keep findings, unread IDs, context debt and completion receipts separate. Show a
snapshot timestamp; moving workers can advance after the snapshot.

Regression: an Italian phase has no combined judgments.jsonl yet, but version-bound
BG, native, managed and dialogue journals already exist. Report their unique valid
IDs rather than zero. After the combined file appears, its duplicated IDs do not
increase coverage. A same-ID changed target or conflicting verdict rejects the
count instead of silently becoming an accepted second judgment. An unwritten
remaining dialogue batch never receives default passes.
