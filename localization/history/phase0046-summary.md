## Phase0046: original save/Continue consumers and fixture guards prepared

Nineteen bounded original IL groups now trace DataPath/PlayerPrefs loading,
version cleanup, original PlayMenu Continue, normal soft-reset dispatch and
exact-position Player restoration. The preserved43 QA save matches the required
schema versions and records its real CentralForest arrival from BunnyHouse,
completed NewGame_Intro, exact respawn position and unplayed tutorial state.
Static parsing does not establish successful restoration or continued execution.

Normal Continue passes through the original ChapterSelect soft-reset scene and
the original next-update BeginPlaySession callback. It does not need a direct
chapter selection. The alternate settings object named settingsPersistentData
uses PlayerPrefs: an empty QA persistence directory alone cannot establish that
no alternate state exists. The fixture admission helper requires the pinned
QA-only manifest, exact original file bytes and exactly two DataPath tfol.*
files, rejecting extra nested saves, changed bytes and symlinked candidates.

The additive dump-save-continuation diagnostic compiled against all150 original
managed assemblies. Exact IL comparison retained33 existing top-level methods;
only dispatch and the new read-only diagnostic differ. It observes loaded
manifest fields, original flags, real frame/time, Player identity/position and
existing tutorial diagnostics. Native serialization and runtime order remain
unverified. All79 focused tests passed (existing70 plus9 fixture-admission
checks);16 static checks passed, including19 lane pins,150 managed/262 other
original files,5 resource pairs, owner saves/identity/catalog and no QA runtime.

Candidate44 has NOT been created/prepared/launched. The existing New-only
observer still rejects every tfol.* and invokes New; its Continue control,
budget and restored-state branch must be implemented before freezing44. The
source-backed next recipe stops safely at120:158 before selecting159/181.
No game launch, image input, original-install write or asset-lane write occurred.
Accepted43 route/cleanup and10/15 visuals remain scoped and unchanged. Full
source/special-scene/renderer/editorial/resource/delivery gates remain pending.

Evidence and the next concrete recipe:
`localization/source/save-continue-20261026/source-trace.json`,
`CONTINUE-RECIPE.md`, `fixture-binding.json`, `bridge-verification.json`,
`tests.json` and `verification.json`. Continue with one new immutable44 only
once its repaired observer and full freeze/preflight pass; never replay43.
Previous summary: `localization/history/phase0045-summary.md`.
