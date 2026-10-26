# Ordinary Continue adapter and candidate44

`tools/probe/diagnose_newgame.py --continue-fixture` is a separate admission path.
Without that flag New still rejects every existing tfol.*. Continue requires the
fixed QA43 manifest SHA-256 and exactly its two original DataPath files, including
schema versions, local regular files and a complete recursive save-file check.
There is no fixture substitution, owner-save import, New fallback or direct scene,
chapter, trigger, eligibility or narrative-state call.

Before Continue, compare the native read-only diagnostic with the exact fixture:
HasSavedPlaySession, resolved areas, both positions, respawn flags/camera, story
clock, tutorial completion flags, completed intro, tags and pending tutorial
quest/dialogue/arc/intro-trigger. Bind the active PlayMenu Continue control both
in the Python observer and again on the game thread immediately before invoking
the original public callback. The original StartScreenMainMenu OnClickStart still
opens PlayMenu. Preserve all14 original guards and startup/observation budgets.

Native bridge menu admission previously supported only Start/Options/Back. Adding
Continue solely in Python would have failed its first real submission. The final
bridge permits OnClickContinue only for PlayMenu, with saved-session, original
StartMenu, nonchapter/noncheat/nonconversation and exact unique active/interactable
Continue-button guards. Existing33 top-level bridge methods retain exact IL;
Update dispatch and the new read-only diagnostic are the only changed/new methods.
The first compile without this whitelist repair is preserved as build evidence,
not a consumed runtime. No game ran during either compile.

The primary tutorial arc's serialized key is p1, but CurrentArcName reads its
customName. ArcLoader assigns customName only for NAMED roots; PRIMARY129 points
directly to153 and Arc's constructor leaves customName null. JsonUtility may emit
that as null or an empty string. Accept those two serialized representations only,
not the pluginDbSuffix as a guessed custom name. Original IL and exact source root
are in this supplement. Existing frozen inventories/glossaries are unchanged.

The Continue budget inherits the original hard360s and stage/idle caps. Its source
milestones and monotone real frames are separate from New's original cutscene
stages. It permits the normal original ChapterSelect soft reset and source-selected
CentralForest. An active original tutorial event is expected during bootstrap;
free-event gameplay guards would reject it for the wrong reason. Read the actual
root Player/controller and preserve the first observed position separately from
initial spawn proof. Host polling cannot establish an unobserved spawn frame.

Only exact original120:153–158 subtitles and linear successor controls may advance.
The existing game-thread continue-bound receipt rejects stale source identities.
At158 wait naturally for typing to finish and two exact visible/clickable original
choices159/181, in two real frames. Neither choice is selected. Native framebuffer
capture then requires a fresh visual review; no pixels enter this work context.

Regression: exact QA43 fixture admits Continue while default New rejects it; one
changed/extra/nested/symlinked file fails its intended admission guard. Matching
synthetic loaded/menu controls pass; wrong areas/flags/clock/intro/tags/tutorial,
missing/duplicate Continue, wrong subtitle/response/arc and stale real frames fail
their own guards. Repeated clock ticks never extend idle/hard limits. These tests
replace native state production and do not prove Unity restoration or progression.
Runtime receipts and any first failure remain separate; never replay consumed44.

The472-file frozen candidate includes later-read helpers, exact fixture originals,
compiled bridge/native helper, original/resource files, source/config snapshots,
external startup and interpreter pins. Original Quit may rewrite the two game
DataPath fixtures; preserve those actual output hashes separately. QA-fixture
originals remain frozen. Original install/saves and all19 lane pins stay unchanged.
