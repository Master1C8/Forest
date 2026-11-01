# Continue the six existing author assignments

Initial finite CLI processes returned incomplete partial drafts. Queued follow-ups
were accepted, then aborted when codex exec exited. A queue acknowledgement was
not successful continued execution. Exact pending coordinator messages were
removed through the supported CLI stdio protocol; consumed/aborted ones remain
in history. No chat database was edited.

The parent supervisor continues the SAME six thread IDs using codex exec resume,
pinned Sol/high/OpenAI, without parent conversation or fork. It preserves every
original phase, draft, ledger and receipt. Each new phase snapshots starting data
and counters. NEW turn metadata after the journal offset must be verified before
localized work. Nonoverlapping usage deltas exclude inherited pre-phase totals.

Resume only a verified exited zero-exit incomplete phase with actual added
wording/coverage or a newly delivered owner decision. Live PIDs, owner-interrupted
processes and unchanged no-progress blockers do not relaunch. No nested model,
technical stream or more than six locale streams. Independent/native gates remain.

Regression:351 real targets continue from exact saved bytes; live PID, nonzero
exit and unchanged no-progress results do not relaunch. Accepted-but-aborted
queued turns are reconciled before direct continuation, whose prompt delivers
the owner decision instead of leaving it in a queue consumed during shutdown.

A resumed thread can publish `thread_settings_applied` followed by `task_started`
before `turn_context` is available. That current-epoch record, exact live argv,
provider and reasoning must agree before releasing the input gate. Missing timing
alone is not a different-model finding. Regression: applied Sol/high/OpenAI settings
at the NEW offset permit startup; an unapproved model/provider rejects. Existing
turn-context evidence takes precedence and must match too.

The first observer timed out on that boundary while preserving three live workers.
Its exact source is retained as execution-v1.py. The current supervisor adopts the
known PIDs and counters, publishes the missing verified gate and continues untouched
lanes. It never launches a second actor for a live thread. If an adopted process
later exits, its OS exit code is unavailable: require an actual completed model turn,
valid result and absent PID, retain exitCode=null, and classify unknown/aborted
outcomes as needs-attention. Ten scheduling/runtime controls cover these boundaries.
