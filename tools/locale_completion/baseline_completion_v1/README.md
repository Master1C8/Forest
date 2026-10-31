# Exact accepted-baseline selector recovery

`recover.py` reads explicit pinned locale configuration and compares each selected
physical string with its canonical inventory, original serialized resource,
accepted baseline resource and actual target resource. It retains every distinct
`(family, id)` membership. Duplicate memberships and conflicting same-ID source
inventories reject; overlaps never discard family context.

This repairs recovery from receipt indexes with null versions: a missing authored
translation is not a fabricated target. The output records actual resource values,
their hashes, physical component owners and script/font/material pointers. It
adds no linguistic judgment, translation or display-exclusion claim. Preservation
decisions require the author and normal distinct independent review.

Run with the exact Python executable identified in the request environment:

```text
python -B tools/locale_completion/baseline_completion_v1/recover.py --root PROJECT --config REQUEST --output OWN_LANE_OUTPUT
```

Requests must pin the actual engine manifest and all selected resources. Verify
the engine's complete `files` closure against that manifest before crediting the
readback; the helper pins the manifest but does not itself traverse that closure.
The shared manifest-last publisher preserves existing outputs. Interruption is
partial publication, not a multi-file transaction; reconcile partial bytes before
using a fresh output. Do not overwrite a published readback or its pinned helper.

Regression: 125 pause/ornamental memberships must produce 119 physical selectors
with all six overlaps and distinct family context intact. Original keyboard
`ABC\n`, spaces, input U+200B, plus-state strings and sprite-tagged template seeds
must survive byte-exact. Source-equal and baseline-equal values alone never prove
that a field is invisible or that German wording is accepted. Actual serialized
readback exercises UnityPy and the original managed type trees; the focused
`tools/test_baseline_completion.py` tests cover selector/pin guards only.
