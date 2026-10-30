# Queue repair and verified restart

The owner explicitly requested repair and execution of all stopped localizations.
The canonical run is selected by `outputs/locale-assets-20261026/launch-current.json`.
This repair uses the existing six linguistic streams and one technical stream;
it does not create another model lane, game process or server session.

## Corrected mechanism

- Capacity closeouts preserve the original role. An interrupted author/edit task
  finishes authoring/editing and hands new wording to a fresh independent reviewer;
  it is not mislabeled as an independent review. Check recorded application
  postconditions first, preserve already stored accepted text and do not replay
  side effects or overwrite old phase files. Interrupted judgments remain unaccepted.
- A live observer handoff can retain genuine blocked/complete lanes instead of
  rejecting the entire group. Their accepted result, checkpoint, old claim and
  process identity are verified; blocked lanes submit no model request while the
  predicate is unchanged. Claim lineage remains verifiable at a later handoff.
- Chinese and Portuguese quietly wait for a changed canonical source admission
  that actually accepts the complete source, translation entry and a complete
  visible denominator. Only that changed evidence starts a fresh finite language
  assignment from the saved checkpoint. They remain visibly blocked meanwhile.
  The observer never flips source acceptance or calls a new model merely because
  a file, phase count or report changed. Further real gates remain applicable.
- The explicit owner priority runs at the next technical work boundary. Required
  independent review and unread review debt are preserved; the deferred optional
  technical task stays in the checkpoint. Existing source proofs are inputs to
  the finite source-gate handoff, not permission for another framework audit.
- The shared technical inbox retains its exact original identity across handoff.
  An adopted request can close its original inbox item; the successor neither
  loses the request nor duplicates it in a new queue.
- The successor freezes its execution/helpers and assignment inputs. It announces
  readiness before the exactly verified old observer exits. Its live model children
  continue and are adopted. The old observer alone exits; no language request or
  server is stopped. Actual fresh runtime metadata gates localized input.

Use `tools/launch_locale_repair.py` only under an applicable direct owner repair/
restart instruction. A new launch needs a fresh run directory. It preserves the
preparer's preliminary plan before finalizing the plan once, before any observer
or model request starts. The failed first preparation refused replacement through
the immutable write helper; it made zero model requests and resumed the original
observer. Its directory and failure receipt remain evidence, not a failed request
to resubmit blindly.

## Verification boundary

Six new repair regressions and fourteen existing completion regressions passed.
They cover required review preservation, once-only owner priority, real source-gate
predicates, zero requests for an unchanged blocked lane, exact old inbox identity,
claim lineage and continuation from an actual saved blocked checkpoint. Fixture
model judgments replace the model/native dependency in tests; no fixture establishes
semantic quality or actual game rendering.

The real restart independently verified three fresh Sol/high/OpenAI runtimes with
no inherited parent, preserved both live children and their actual runtime IDs,
and observed the German closeout finish and launch its independent review. Source,
editorial, font, resource, native, packaging and release gates remain separate.
`receipt.json` records exact identities, current state, warnings and measured usage.
Active-request counters are partial; cached input/reasoning remain subsets and are
not added twice. Coordinator attribution is mixed after its captured baseline;
initial diagnosis, reporting tail and platform overhead are not fully measured.
