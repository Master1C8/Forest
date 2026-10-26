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
