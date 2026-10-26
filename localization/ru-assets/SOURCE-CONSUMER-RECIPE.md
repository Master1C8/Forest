# Bounded source-consumer repair

This is the Russian draft adapter within the existing README `translate-edit`
stage. The 12,246 source candidates and seven input pins remain canonical and
unchanged. `source-dispositions.json` is an own-lane integration proposal, not a
replacement inventory or complete source acceptance. No runtime was launched.

The first divergence was `corpus.controls()`: it protected all square-bracketed
prose as an engine command. `FormattedText.Parse` recognizes specific families.
The two flower descriptions use ordinary brackets and flow through
`StandardUISubtitlePanel`, `UITools`, `UITextField` and the inspected typewriters.
`inline_guard.py` permits their prose only with exact ID/source/evidence hashes.
It retains bracket delimiters and recursively protects nested controls. Every
other unknown bracket remains opaque. Lua indexes/quoted arguments, variable
names, tag arguments, nested brace placeholders, numeric literals, line/pipe
separators and typewriter escapes remain exact.

Do not infer visibility from a colon, uppercase, actor presence or stored field.
`DialogueEntry` selects nonempty Dialogue Text for subtitles; response buttons
prefer Menu Text. Group links recurse without displaying the group label;
`ConversationController` has a separate group-state branch. Subtitle visibility
then checks `noSubtitle`, exact `None()` / `Continue()` variants and speaker/display
settings. Empty actor IDs do not establish nonvisibility. Full source, external
callbacks and runtime acceptance remain pending.

The game loader starts dynamic arcs via `PRIMARY`, `SECONDARY`, `IDLE` and
`NAMED`, then follows actual links. The 0024 topology evidence deliberately
overapproximates this: every titled or keyed node and the first node of every
conversation is a root; every condition is allowed; cross-conversation links
are followed too. The reviewed 86 coyote/sweater authoring records plus two
tutorial-splash questions are detached even under that overapproximation. They
are preserved in full, separately counted as technical proposals, never deleted
or counted as Russian wording. This does not exclude arbitrary external direct
entry selection and does not classify all remaining labels. Never overwrite the
pinned 0024 topology or selection: use `trace_held_source.trace(new_ids)` to write
new immutable evidence for another group.

The two `inventory.Add(ItemNumber.621)` records are terminal input explicitly
requested at 466:759/820. Their full fields remain exact, including portrait tags.
No Russian suffix is allowed. The five missing-dialogue placeholders and all 52
mouse-language holds remain unresolved. Font switching alone does not establish
symbol mapping, decoding or reveal timing. The two legacy ADVICE questions keep
their exact service-looking prefix while translating only the question; actual
manifest use and prefix classification remain provisional.

Historical TSV and hold-group bytes remain intact. `resolved-holds.json` binds
each old hold path/hash/location/reason to the source, per-record disposition,
new batch and target hash. The build must consume exactly one old hold and find
exactly its expected new target. An unaccounted missing hold or changed target
must fail. No prior target was retired in 0024.

Verification commands (from the canonical project directory):

```text
PYTHONDONTWRITEBYTECODE=1 python3 localization/ru-assets/test_inline_guard.py
PYTHONDONTWRITEBYTECODE=1 python3 localization/ru-assets/corpus.py build
PYTHONDONTWRITEBYTECODE=1 python3 localization/ru-assets/check_poetry.py
```

Regression fixtures exercise ordinary bracket acceptance, changed engine command
and nested Lua rejection, unknown bracket preservation, placeholders, prefix,
number/separator/typewriter checks, exact terminal inputs, detached records,
evidence/hash tampering, immutable old-hold/new-target receipts and import without
building. Source pointers still compare with both pinned physical trees in every
real build.

The build replaces individual JSON artifacts atomically but its overlay,
unresolved list, progress/result and continuation are not one transaction. The
injected failure after overlay/unresolved and before progress proves that partial
state can exist. Recovery rebuilds from authored inputs, verifies the first
successful target/hash, then checks a repeat. It does not prove game continuation
or package rollback. Final receipts bind all delivered files independently.

Keep `savedTargetIds` and the legacy supervisor `authoredIds` distinct from
`translatedWordingIds`. Technical preservation, punctuation and exact nonprose
must never inflate linguistic coverage or reduce the candidate denominator.
