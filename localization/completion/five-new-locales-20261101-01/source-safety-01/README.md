# Source-only special-case input repair

The complete source inventory and approved glossaries are unchanged. Two technical
reference files mixed original English/control data with Russian candidate prose.
These projections retain exact source/consumer identities and source values, while
excluding candidate target values, target hashes and old locale semantic/meter claims.
Use index.json instead of loading those two raw reference files into a new semantic
context. No new extraction, translated wording or semantic acceptance is generated.

Known input exposure is recorded per owning phase. Preserve all drafts and original
frozen briefs; a new fresh phase explicitly names its source projections and correct
own-locale paths. Other unexposed live jobs keep their immutable execution. No queue
message or concurrent resume is a safe substitute for a verified active steering API.

Regression: selectors150 record0 contains sourceValue and acceptedWholePageTarget.
A schema inspection emits keys/types only. The source-only view retains the exact
sourceValue, sourceSpan, sourceNontext and selectors, including zero/null. Neither
candidateValue nor acceptedWholePageTarget is emitted. A haiku record's source and
branch IDs survive, but its Russian target, prior pass and target syllables do not.
Task paths are parameterized as complete path components, including terminal /ko;
forms, rather than only /ko/ occurrences. task.json remains the write authority.


## Exact-path font lookup regression

The first source-only recovery still exposed another locale when an Arabic lookup used `--glob '*ar*.json'`: the pattern also matched `ordinary-dialogue.json`. Preserve that interrupted phase and give it no semantic coverage. Future phases enumerate exact permitted paths before reading content, search named Python mechanism files separately, and use the font README plus explicitly selected metadata. Never recursively content-search character corpora or infer a locale from a filename substring. Regression: looking up Arabic shaping must not emit German ordinary dialogue.
