# Bundle and whole-page recovery

`recover_extended.py` extends the immutable plain-selector recovery without
rewriting it. Explicit locale configuration selects original, accepted baseline
and candidate resources. Exact bundle/CAB identity and signed path IDs are
resolved before reading a field. All six page memberships may be read together,
while primary decisions and existing target context remain distinct.

The helper verifies the full frozen engine closure, actual executable, its
dependencies, inventories and resource hashes, then uses the shared manifest-last
publisher. It reads actual Unity fields, owners, scripts, active ancestry and
protected object hashes. It does not write resources or establish visibility.
Publication remains sequential with a final manifest, not a transaction; preserve
an existing published recovery and use a new version after an input change.

A sparse candidate can omit an unchanged resource. Pin an original-base snapshot,
verify it against the canonical source manifest and record that binding explicitly.
Do not call it a candidate override or a packaged target. Packaging must later
verify the same base plus override composition.

Regression: an actual narrative field with a negative path ID reads its exact
source from the named CAB. A wrong CAB with the same path ID fails at member
resolution; a wrong signed ID fails at object resolution. A plain legacy Text
field needs the pinned managed/external-asset resolution path as well as UnityPy.
The actual-boundary tests cover this dependency; selector-only mocks do not.
