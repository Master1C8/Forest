# Russian temporary speaker labels

The owner’s transition frame shows `Bear 1` above the already translated line `ds:455:660:Dialogue Text`. The owner confirmed that the black background is a normal transition. The source command `ds:455:573:Title` sets `PORTRAITS(rename[actor_a,Bear 1,-0.7])`. The current consumer parses and stores the English display label, then `CustomPortraitsUi.UpdateChildLabels` passes it directly to TMP. Existing localized BG Actor defaults cannot affect this override; the generic actor defaults correctly remain null. Detached `Bear 1:` dialogue records are bypassed by the actual source route and are preserved.

The source inventory contains29 rename commands with22 labels and2 forced-name commands with2 more labels:24 exact display values across31 memberships and8 conversations. All commands retain their protected dispatch role. `source-labels.json`, the reproducible enumeration script, current method IL and source/code fingerprints bind this finite scope. They do not waive the complete-source or ordinary-translation gate.

All24 authored Russian targets and all31 memberships pass an independent full semantic/Russian read. Names and designations reuse the approved glossary, including `Bear 1`→`Медведь 1`, `Bear 2`→`Медведь 2`; generic species remain generic. No dialogue, command title, actor identity, source prefix, voice pitch, dictionary state or glossary is rewritten.

The patch adds one pure exact-value string mapper and a three-instruction prefix to the shared display method. All14,099 original method bodies are read back; only the display method changes and one helper is added. Removing that prefix/helper restores every original method body and the checked metadata projection. This is an IL/metadata comparison, not byte-exact reversal of the serialized DLL. The exact saved helper IL is copied into a Unity-free assembly and executed on CLR:24 mappings,24 already-localized controls and12 null/empty/unknown/key/near-match controls pass. This exercises actual helper instructions, while replacing Unity and the actual TMP renderer.

The builder freezes reviewed inputs, source code, compiled patcher/Cecil dependencies and the Python wrapper before applying the final code stage after Dates/titleflow resources. The same supported source DLL produces the same final hash in independent and frozen runs. Font439 covers the complete target character set; actual font selection and visible fit remain unverified.

The launcher uses one preparation entry point. With an earlier supported DLL it runs the existing quest/resource installers first, verifies their postconditions and applies the new DLL. With the final DLL it validates the required resources and skips older installers that accept only the previous DLL. The final DLL SHA is `656d111de59ecff5ccc3548c91c0269f187384eca436e45e10147b0effc2e2dd`, in `dist/Forest-Russian-Test-20261029/speaker-display-hotfix/Assembly-CSharp.dll`. Its required sharedassets2 payload is the previously staged Dates/titleflow `e6221f2a…` resource.

Eight private data-only installation scenarios use the actual quest/date/speaker writers and final payloads: before/final states, interruption after resources and after DLL, running process, unknown code, incompatible final companion and invalid payload. Process observations are replaced by explicit fixtures; there is no game executable. Saves/settings sentinels survive, final repeats preserve game-file bytes/inode/mtime, and both interruption states roll forward. Each resource/DLL replacement is individually atomic with separate receipts; there is no multi-file transaction.

The actual owner game remains running. Its real guard rejected preparation before writes; code/resources retained bytes/inode/mtime. `owner-delivery.json` records staged status. After normal closure, the same owner launcher applies both pending repair groups. No game was started, stopped or probed and no owner progress was edited.

The supplied original screenshot is unchanged. A fresh independent process reviewed its1280×1132 WebP80 copy. The English label fails historical content acceptance; an unidentified edge fragment and missing exact frame/binary receipt leave visual uncertainty. The normal black transition is accepted as context, not treated as an art defect. No corrected native frame or whole-game/release acceptance is claimed.

| Predicate | Current evidence | Next action |
| --- | --- | --- |
| Actual source-to-display failure | Exact ds455573→575→660 route; current method IL | Source-bound repair admitted for24 values only |
| Complete finite wording |24 targets/31 memberships, clean independent receipt | Reuse unchanged reviewed bytes |
| Protected state preserved | All other method bodies, checked metadata and untouched source/resource fields | Retain exact readback receipts |
| Helper correctness | Actual saved mapper IL executes all positive and negative controls | Native method integration still needs owner playthrough |
| Safe pending delivery | Eight real-writer fixture cases; owner running-game guard | Normal close, then same launcher |
| Visible result | Only pre-fix frame reviewed; font cmap covers all labels | Owner checks translated labels after next launch |
| Whole-game completeness | Existing global gates remain false | Not established by this bounded repair |
