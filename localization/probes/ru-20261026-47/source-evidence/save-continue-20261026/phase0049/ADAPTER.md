# Acknowledged tutorial response transitions

The original StandardUIResponseButton.OnClick sends its bound Response to the original
UI target. ConversationView.SelectResponse hides the menu and invokes the selected
response handler; ConversationController.OnSelectedResponse obtains the destination
state and calls GotoState. StartSubtitle separately applies ShouldShowSubtitle; PC
visibility depends on GetShowPCSubtitlesDuringLine/GetSkipPCSubtitleAfterResponseMenu,
and a hidden subtitle does not wait for Continue. This source path supports consumption
of the selected PC destination before a host subtitle sample. It does not establish
which active setting suppressed154, nor prove its subtitle was displayed in45.

The host command now returns the exact freshly acknowledged transport line, command,
PID/exit and submission/acknowledgement monotonic bounds after its existing guards.
TutorialTransitions binds that response to the latest exact observed source frame,
source text, unique visible/clickable original control and sole graph destination.
Only a successful fresh exact ACK permits observing that destination or its one exact
source-linked successor. No numeric skip range or special155 exception is introduced.
Stale/missing ACKs, wrong controls/text/destination, unrelated skips, regressions,
response replay and158 choice submission fail before another input. No ACK renews a
budget. Existing14 guard bodies/default New behavior and native bridge are unchanged.

Observed subtitle entries, source-selected responses and observed transitions have
separate receipts. In45 the host read153 and155 and selected154;154 is never credited
as observed. Regression controls replay those retained samples without launching45,
and exercise a full mocked command/file sequence through two real-frame-shaped158
states with no choice. Mocks prove only host behavior.109 focused tests pass.
The first mock lacked its required path field; the older transport mock needed its
existing monotonic scalar when returning the new receipt; both fixture repairs and
the initial wrong assembly lookups are recorded in development-attempts.json.

Use a new immutable46 exactly once after full preflight. Preserve the QA43 fixture,
loaded-menu guard, original startup300/hard360/bootstrap120 idle60/dialogue240 idle30/
cleanup60 idle15, all native producers and choice stop. No replay45/44/43, no live
asset-lane or frozen shared input writes. Real Unity acceptance remains separate.

## One-use46 result and next boundary

46 passed30 preflight checks/froze472 files; startup ready23.135s. Actual153 at551,
response154 selected/acknowledged at631, next observed155 at716, then156/157/158.
Observed subtitle coverage is exactly153/155/156/157/158;154 remains selection-only.
The response-transition repair therefore passed its real native consumer boundary.

The overall runtime failed at a different host stop-state boundary.32 observations
of exact158 at938..2616 were non-typing with no responses. tutorial_action returned
None throughout, so Continue158 was never submitted. Original Continue invokes the
original subtitle continueButton; HandleContinueButtonClick clears waitForContinue
and FinishSubtitle invokes the original finished handler; the controller reaches
StartResponses for PC choices. This supports a missing Continue-to-open-menu step,
not a proved active waitForContinue field or a typewriter hang. Guard the original
control/state and both exact source destinations before allowing that step in a new
candidate; do not call finished handlers, directly open the menu or select159/181.
The additional original IL/recipe was added after46 cleanup; frozen46 remains intact.

Original restore/Quit were acknowledged, all exact task processes are absent, QA DLL
restored/bridge removed, and15 postrun checks passed150/262 originals,5 resource pairs,
19 pins, both unchanged fixture files and empty QA persistence. Observer1/launcher0;
game numeric exit unknown. Initial spawn position remains unobserved/mismatched at
the first host sample. Zero captures/opened images; no visual review packet exists.
Never replay46/45/44/43. Keep original budgets and all pending acceptance gates.
