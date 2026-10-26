## Phase0048: native Continue readiness repaired; response-transition guard is next

Both save and intro diagnostics now read scalar Unity scene/frame/clocks/QA identity
before checking the existing DataService singleton, manifest and nested diagnostic
records. Missing dependencies return an explicit bounded not-ready sample without
calling manifest consumers; dump-intro rechecks on its own game-thread command.
No service initialization, story/scene callbacks, save writes or arbitrary exception
suppression were added. Readiness/clock ticks do not renew hard/idle budgets. All102
focused tests pass; all14 original guard bodies and33 other bridge methods are unchanged.

One new candidate45 passed30 preflight checks and froze458 dependencies. Its actual
startup was ready in22.112s; the complete native loaded-menu fixture guard passed.
Original Continue then crossed the previously failing boundary: frame401 in
SoftResetLoadingScene serialized DataService._instance absent, with dump-intro
correctly skipped. A new service was ready in ChapterSelect at402, followed by
CentralForest. The first observed root Player at476 had an original tutorial controller;
actual position(5.960000,7.950000,0) differs from fixture(5.964000,7.952000,0).
The initial spawn frame is unobserved, so exact initial restoration remains unverified.

Actual tutorial binding is TutorialQuest_IntroFromBunny with the source-backed unnamed
arc. Exact120:153 appeared at570. Original fast-forward153 and the sole visible/clickable
response153->154 (Much better.) were acknowledged. The next real subtitle sample at702
was exact120:155. The host guard still compared against previous153 plus1 and failed
before submitting the proposed155 action. Source has153->154->155;154 subtitle itself
was not observed. Trace original response consumption, then bind the acknowledged
response destination/successor in the host guard without accepting arbitrary skips or
crediting unobserved content.45/44/43 are consumed; never replay them.

Observer exit1 and the failed runtime are preserved. Original policy restore/Quit
were acknowledged, launcher exit0 retained, numeric game exit unknown. All15 postrun
checks passed: exact processes absent, QA DLL restored/bridge removed,150 managed and
262 other originals,5 resource pairs,19 lane pins and both fixture bytes unchanged.
Zero images were captured/opened, and120:158/choices159/181 remain unverified.

Evidence: `localization/source/save-continue-20261026/phase0048/ADAPTER.md`,
`extraction.json`, `BridgeReadiness.il`, `bridge-verification.json`, `tests.json`,
`runtime-finding.json`, `verification.json`, and
`localization/probes/ru-20261026-45/runtime-diagnosis.json`,
`continue-observations.json`, `continue-actions.json`, `final-verification.json`.
Accepted43 route and10/15 visuals remain unchanged. All seven asset lanes continue
in their read-only technical scopes. Full source/special-scene/renderer/editorial/
resource/delivery gates are pending. Previous summary:
`localization/history/phase0047-summary.md`.
