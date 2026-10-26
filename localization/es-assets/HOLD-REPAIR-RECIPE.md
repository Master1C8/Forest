# Spanish source-bound hold repair

Scope: The Forest of Love 0.45, exact locale es, provisional translate-edit stage.
This recipe repairs only the Spanish adapter. It changes no shared source inventory,
approved glossary, other locale, runtime binding or final acceptance gate.

The failed boundary was corpus.controls treating all square brackets as opaque controls,
and saved !HOLD entries preventing a new source-backed target without changing old TSV.
The 11 original holds remain in their original 103 TSV byte streams. A new batch supplies
8 directly authored/edited Spanish targets and 3 byte-exact technical records.

Inputs and authority are the phase 0033 brief, original input-pins.json, source trees,
approved English/es glossaries, copied immutable consumer facts and original consumer IL.
Actual process arguments were verified as gpt-6.1-sol/high/OpenAI with defaults ignored.
No external model, nested job, subagent, other-locale target or validator was used.

## Reproduction

1. `python3 localization/es-assets/trace_hold_sources.py`
   validates both original trees, traces incoming edges and paths from every first,
   titled or keyed node with every condition allowed and cross-conversation links
   included. This overapproximates the loader. It also regenerates the explicit
   roommate concept/use/context closure. Consumer IL copies and the source facts are
   hashed in hold-evidence-0033/evidence-pins.json. No arbitrary direct-node invocation
   or runtime nonvisibility is claimed.
2. `python3 localization/es-assets/corpus.py build`
   verifies source/glossary/inventory pins and source pointers in both copies.
   source-dispositions.json allows ordinary bracket ordinal 0 only at 131:153 and
   540:232, bound to their exact source and topology/consumer evidence. Outer brackets
   stay exact; nested recognized/unknown controls, quoted Lua operands, markup,
   placeholders, numeric literals and LF/CR/pipe counts are still compared.
   All other bracket tokens retain the default opaque rule.
3. `python3 localization/es-assets/check_hold_repairs.py`
   runs meaningful positive/negative tests and an input-only normal rebuild.
   It requires exclusive local ownership of this es lane. It temporarily removes only
   generated overlay/unresolved outputs after keeping expected bytes in memory, then
   regenerates them from saved inputs. It asserts preservation of all 12,235 previous
   complete target records, every original TSV stream and unchanged-reasons bytes.
4. `python3 localization/es-assets/check_poetry.py`
   checks the unchanged nine Spanish poem groups, all 27 assembled combinations,
   authored scansion and callbacks, against the final overlay hash. This is deterministic
   poetry validation, not independent literary/editorial acceptance.

hold-resolutions.json binds each exact held occurrence to its original source hash,
original hold-reason hash, new batch identity, target hash and own-lane evidence hash.
A receipt can replace an actual old hold exactly once. Duplicate targets, unused receipts,
changed sources/evidence/targets and unapproved hold replacement fail. No previous target
is removed, so no retired-target receipt is needed.

458:340, 458:346 and 71:147 retain their entire source fields. They have no incoming
links and no path from the conservative roots. Original loader IL imports PRIMARY,
SECONDARY, IDLE and NAMED roots, follows linked entries and builds dynamic conversations
from imported arcs. These are provisional technical-preservation proposals, distinct
from both translated wording and intentionally unchanged visible wording. No candidate
is removed. Unknown external access and shared acceptance remain explicit.

The six Finley candidate drafts follow PRIMARY-SOURCE-RULING-0033.md. They preserve
Charlotte/Melody, the anonymous fox/bear description and Finley he/him; they do not change
tfol-010's protected bytes. The proposed canonical correction and source/glossary/editorial
acceptance remain OPEN. trace_hold_sources.py selects 18 explicit concept seeds and all
222 candidate/context fields in their nine scenes. This inventory preserves valid existing
targets and supports later review; it is not a completed full or independent semantic audit.

## Output boundary and regression limits

Each generated file is replaced atomically on its own. The overlay, unresolved file,
progress, root result and continuation are not a transaction. The focused test injects
failure after overlay replacement and before unresolved replacement, verifies the
checkpoint is untouched, and recovers through the normal build from saved authored inputs.
It claims neither rollback nor game-level crash recovery. An interrupted rebuild must be
reconciled before its mixed checkpoint/artifact versions are consumed.

The tests exercise Python parsing/storage/control rejection and exact source bindings.
They do not replace the original Unity consumer, prove actual rendering, close the
shared source/special-scene gates or provide full semantic/independent-diff acceptance.
Draft-complete means all 12,246 pinned family candidates have saved targets and no drafting
holds, including the separately counted technical records. Whole-game and release gates
remain open. Git belongs to the technical coordinator; this lane performs no Git writes.
