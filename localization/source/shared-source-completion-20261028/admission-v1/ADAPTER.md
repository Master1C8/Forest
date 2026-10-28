# Common nontexture source admission, phase134

This is the versioned source-admission supplement for The Forest of Love0.45 and the owner's30-locale omission repair. `manifest.json` remains **partial**: common source admission and new translation entry are false. Textures, frozen dialogue/glossaries, existing locale packets and all localization/*-assets/ remain unchanged.

The preserved phase133 products and completed parent readback are in `phase134/baseline/`, pinned by `phase134/baseline-output-pins.json`. The original `readback-validation.json` describes the archived manifest, not the changed role decisions. Current evidence is `continuation-validation.json`: it reuses that full tree/span readback only after checking unchanged source fingerprints, every source ID/value/order, frozen occurrences and untouched context. The full original extraction/tree readback was not rerun. Deterministic checks do not constitute semantic/editorial review.

## Material source findings

The existing36107-state serialized,51572-state BG,8576-literal and12246-ID/24492-occurrence frozen-dialogue inventories retain exact source values and multiplicity. The original1653 NodeCanvas leaves and124 animator/TMP pairs remain byte-identical. All29 parent-authored BG column decisions remain source-role evidence; earlier isolated-column counters do not supersede that handoff.

`continuation-decisions.json` appends authored phase134 judgments without rewriting phase133 `source-decisions.json`. It partitions all1782 formerly mixed OSK/Rewired states:4 protected keyboard layouts,6 action captions,14 exact symbols,369 resource/editor identities,1344 potential resource labels and45 possible display/control identities. The1389 potential Rewired labels remain in source scope with **unknown display-alias binding**; no game-only getter match is not proof that vendor/external/dynamic UI is absent. Their lookup values stay exact. This partition does not approve an application selector or waive remaining source joins.

The keyboard's actual Generate -> numeric keycode match -> Assign -> TMP path separates action captions from dispatch. KeyCall emits characters/dispatches Return, Shift, Backspace and other numeric key codes. Awake caches defaultLabelText and Relabel(null) restores it: a final caption recipe must keep that cached source coherent. No keyboard runtime repair was performed.

Complete selected original game bodies and12 exact immediate argument rules resolve1166 previously unknown compiled literal roles;3460 remain across917 methods. Four QuestConversationHelper string stores are database/control identities through ConversationSettings -> DialogueSettings -> StoryManager/DialogueService. Generic String.Contains/equality calls are not blanket exclusions: the haiku is a concrete counterexample. Source equality, dictionary/API identity and diagnostic sinks are classified for their exact arguments only.

All935 prior supplemental units have exact source bindings:911 direct IDs plus24 historical `sharedassets2:` aliases to exact `sharedassets2.assets:` objects. Full hierarchy, numeric object/pointer, complete value and one-to-one multiplicity match; equal wording never merges occurrences. The aliases are explicit authored rows, not a global rename. Those24 physical selectors are removed from the additions list to avoid translating the same old units twice. All30 prior935-unit packet hashes remain unchanged. The8896 additional candidates include potential/dormant/protected display material and are **not** a final visible translation denominator.

## Haiku dependency and actual branch risk

`phase134/haiku-source-dependencies.json` binds194 frozen source IDs,259 complete semantic/control node records from conversations302/303, all9 comparison literals, five trigger/successor relationships and all4 ending arcs. Both original database exports agree. The full group includes explanations, choices, poems and feedback; source labels/control fields remain separate from translation IDs.

The loader registers a TRIGGER node on its first outgoing successor. ResponseOptionsUI.SelectResponseOption records the selected display text; Dates.ExecuteTrigger lowercases three selected lines and tests English keyword triples. Original `(325,326,327)` selects bridge_ending; `(406,407,408)` selects penny_ending; `(410,411,412)` selects bug_ending; the other24 combinations select mixed_ending. All27 source combinations were checked without pruning. Replacing display text with synthetic labels while retaining those comparisons loses all3 named outcomes. These are deterministic predicate replays, **not actual game/loader/renderer execution**.

The adapter contract must carry original option/entry identity independently of localized display wording and retain all27 original outcomes. Translating keyword literals alone is insufficient. No adapter or target literary wording was implemented, and runtime trigger priority/arc selection remain untested. The shared registry now includes the exact group; complete textual special-scene discovery is still pending.

## Commands and boundaries

Run from the canonical checkout:

```
python3 -B localization/source/shared-source-completion-20261028/admission-v1/build_inventory.py --check
python3 -B localization/source/shared-source-completion-20261028/admission-v1/validate_continuation.py
```

`build_inventory.py` normally rebuilds the12 current products from frozen inventories and explicit authored rules. `phase134/build_dependencies.py` reproduces the finite haiku context/replay artifacts and explicit method-literal decisions, preserving authored rule/alias fields in continuation-decisions.json. It reads only existing project exports/indexes. `validate.py` remains the original full-tree/span validator; its archived receipt is reusable as specified above, not an instruction to repeat unchanged extraction. New validation checks source mutation rejection with a matching positive control, equal-wording occurrence loss, all935 alias identities, all30 packet hashes, rule expansion, complete27-case enumeration and byte-exact reproduction of all12 products.

Additional CIL came only from the unchanged project-local `localization/probes/ru-20261026-11/game/The Forest of Love_Data/Managed/Assembly-CSharp.dll`, SHA256 `46f43b212709b96ac51f2484d1564f863346fed8dc70f532860046226a020acf`, through the existing read-only InspectMethods tool. No original-install/save access, game/GUI/image input, runtime change, texture edit, nested CLI/model job, agent, Git/index/HEAD mutation, publication or deployment occurred. Actual current CLI ancestry verified gpt-6.1-sol/high/OpenAI/ignore-user-config; usage telemetry is unavailable to this worker and remains parent-owned.

`acceptance-checklist.json` names the finite remaining source artifacts/predicates/actions. Source-role classification, complete source admission, option-identity adaptation, independent editorial review, renderer feasibility and final delivery are separate gates. Multi-file generation uses sequential writes; there is no transaction/rollback claim.
