# Candidate44: normal QA save continuation

This is a preparation recipe, not a frozen run or a runtime result. Candidate44
has not been created or launched. Candidate43 remains consumed and read-only.
Use a new immutable44 once; never substitute another New/intro replay.

## Verified original consumers

`extraction.json` pins nineteen original IL groups from the installed assemblies.
Reproduce them with `.venv-assets314/bin/python tools/inspect_save_source.py
--output <new-project-evidence-directory>` and compare every declared file hash.

The original `SaveManager.Awake` reads disk before base initialization. A non-null
deserialized save sets `HasSavedPlaySession`. `MainMenuController.Start` assigns
that value to `PlayMenu.showContinueButton` and registers `PlayMenuContinue` on
the original Continue event. Its normal public callback only clears the fast
forward selection and invokes that event. The animator fades out, then
`LoadOverworld` uses the normal `ChapterSelect` soft-reset scene. The original
GameStateManager's next-update callback calls `BeginPlaySession`, which selects
the restored current area when a saved session exists. This normal intermediary
must not be mistaken for permission to invoke chapter selection directly.

The save reader prefers `Application.dataPath/tfol.savegame`. The alternate
settings object named `settingsPersistentData` actually has `location=PlayerPrefs`
and `directory=PersistentDataPath`; it is not a second ordinary save file under
the empty QA persistence directory. Both save/settings cleanup consumers delete
files with wrong schema versions. The pinned fixtures have the required save
version `231129` and config version `220308`. Do not alter their serialized bytes.

`PlayerRespawnData.Load` resolves area savekeys through original area records.
`SpawnManager.FinishSpawningPlayer` permits exact-position restoration when the
saved area matches and `lastPositionExact` is true; the original BeginPlaySession
sets the origin-doorway guard itself. Never set that guard from the bridge.

## Fixture and observation boundary

The exact QA-only source is
`localization/probes/ru-20261026-43/qa-generated/manifest.json`, SHA-256
`4ff9760850d3d2aa20ceae44a20696c4a5aab3daf59a3ba00fdd3ec4f72b2d36`.
`fixture-binding.json` preserves the selected values and original observed rows.
The last gameplay log is the real CentralForest arrival from BunnyHouse. The
save records central_forest/bunny_house, position (5.96399975,7.952,0), exact
position enabled, NewGame_Intro completed, BunnyHouse trigger count1, unplayed
tutorial dialogue/arc and default tutorial quest. These are static expectations,
not proof of restoration. The observed arrival already had an active original
event; requiring no event throughout bootstrap would incorrectly reject it.

Use `tools/probe/save_fixture.py` with the frozen manifest hash to validate the
source and the complete candidate tfol.* set. It performs no copy or runtime
operation. Introduce only the two exact fixture files at the original DataPath
destinations in44; exclude every owner file and every other nested tfol.*.
Pin the fixture manifest, both files and this admission helper before launch.

The new `dump-save-continuation` bridge command exposes existing manifest fields,
real frame/time, saved-session flag, chapter/cheat/reset flags, original event
guards, Player identity/position and the existing read-only tutorial diagnostics.
It never reloads, saves, selects a scene, evaluates eligibility or advances text.
`bridge-verification.json` records a compile against all150 original assemblies,
33 unchanged existing top-level methods and only the expected dispatch addition.
The native JsonUtility output and runtime callback order remain unverified.
Build a new bridge using the existing `prepare_bridge.py` and the same original
startup-marker configuration; do not label the old43 bridge as byte-identical.
Never install this diagnostic into the original game or a player delivery.

## Required adapter repair before freeze

The current `diagnose_newgame.py:main` admits no tfol.* and always invokes New.
It is unsafe for this fixture experiment as written. Add a guarded Continue
branch using the existing transport, lifetime/reap accounting, original-policy
menu observation and cleanup. Do not weaken its default New admission rule.
Use exact manifest admission for Continue only and source-bound original
`menu StartScreenMainMenu OnClickStart` -> active PlayMenu Continue ->
`menu PlayMenu OnClickContinue`. No direct scene, story, trigger, chapter or
eligibility writes. No fallback when Continue or its loaded state differs.

Before Continue, compare the new diagnostic at StartMenu with the fixture's
loaded respawn/general fields and HasSavedPlaySession. Bind tags/intro/tutorial
states with the existing tutorial rows. Check the exact active Continue control.
After Continue, allow the original soft reset and source-selected CentralForest;
observe increasing real frames, exact root Player identity/initial restored
position and the original pending tutorial controller. The controller may move
the Player normally; if initial position cannot be observed, report that boundary
unverified instead of treating a later moved position as exact restore proof.

The original `TutorialQuestBunnyIntroduction.Start` raises cutscene-start,
rests/turns the Player and fades from black for1s, then its own callback starts
TutorialQuest_IntroFromBunny with Scarlett. Wait for these original operations.
Do not invoke the callback. `tutorial-prefix.json` binds the linear120:153–158
prefix and exact choice alternatives159/181. A safe first target is settled158
with both original visible/clickable responses; stop before selecting either.
Any later choice requires independent meaning/binding guards, not a guessed ID.

Preserve the original startup timeout and observation budgets: hard360s,
bootstrap120s/idle60s, dialogue240s/idle30s, cleanup60s/idle15s. Start the
observation budget before Continue; never reset or increase it to pass a wait.
Preserve all14 original guards and route/input/policy constraints. New mocked
checks establish only adapter admission; the real44 runtime must prove restore
and continued execution separately. Keep the changed main/branch explicit.

Freeze all later-read helpers, compiled bridge/native helper, sources, fixture,
configuration, resources, interpreter and external startup dependencies. Check
the candidate name44 throughout the derived cleanup/preflight/launch recipes,
and distinguish zero preparation launches from actual launch receipts. Do not
copy the stale42 heading/counters from43. Reuse verified43 resource pairs and
unchanged original managed/game files; verify150/262 files,5 pairs,19 live-lane
pins, catalogs/identities and owner saves. Do not edit any consumed candidate.

Run exactly once only after prerequisites pass. Retain the actual observer exit
through the existing frozen parent. An unknown command holds new submissions;
reconcile exact ACK/exit/source receipts and verified surviving processes.
Normal restore/Quit and exact process absence precede QA DLL restoration/bridge
removal. Preserve any new QA-generated saves separately with explicit unverified
restore status. Capture only a proven actual native state; prepare a native
manifest and finish to a fresh visual-review phase without opening images.

All seven owner-authorized asset lanes remain independent and read-only to the
technical lane. Source inventories, glossary/config snapshots and their input
pins remain frozen. No publication/deployment, agents or nested model jobs.
