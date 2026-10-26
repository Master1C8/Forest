# Continue transition readiness

Original BaseBehavior.OnDestroy unregisters services; DataService.UnregisterServices
clears _instance. Awake registers the new instance before GenerateManifest. Manifest
getters dereference _instance._manifest without guards. Original Continue requests
SoftResetLoadingScene with ChapterSelect as its followup; GameStateManager.Start's
original next-update callback still owns BeginPlaySession. These are source-backed
lifecycle boundaries, not proof of the exact missing field in failed44.

Both dump-save-continuation and dump-intro now collect Unity scene/frame/realtime/
scaledTime/timeScale and QA identity first. ContinuationReadiness reads the existing
private singleton/manifest fields without invoking a manifest getter. Unity's null
comparison covers destroyed service objects. It checks respawn/general records,
trigger/tag/dialogue/quest dictionaries, the intro record, both quest dialogue lists
and primary-arc elements, plus the11-entry event array used by isAnyEventActive.
The existing status getters tolerate null status records. Current dialogue/arc names
are static field reads; IsTyping tolerates an absent typewriter service. The existing
read-only tutorial/intro diagnostics run only after all dependencies are present in
that same game-thread command. No service initialization, reload, eligibility/chance,
scene/chapter/trigger callback, save write or arbitrary exception suppression is added.
Unknown reflection fields and unrelated native exceptions remain exact FAILs.

A not-ready sample has an explicit dependency list and singleton/manifest presence,
service instance ID and scalar clocks/identity. Other default fields are unavailable,
not evidence of false gameplay/session flags. The observer skips dump-intro after a
not-ready save sample. Dump-intro rechecks readiness itself to cover the next command's
lifecycle boundary. Neither scalar path submits narrative input or credits readiness,
clock ticks, repeated states or scalar scene changes as progress. Hard360, bootstrap120/
idle60, dialogue240/idle30 and cleanup60/idle15 remain unchanged, as do startup300 and
all14 original guard bodies. Readiness loss after dialogue begins is a failure.

Tests use synthetic producer/file/command transport with matching ready controls and
intended rejection reasons. They establish adapter routing and budgets, not Unity
lifecycle or restoration. Compiled IL preserves33 other top-level bridge methods;
only DumpIntro/DumpSaveContinuation changed and ContinuationReadiness was added. The
injector separately checks original hook bodies/branches/locals/exception handlers.
A single fresh immutable45 is required to observe the real native transition. Never
replay consumed44/43 or modify their snapshots. Accepted10/15 visuals remain unchanged.
