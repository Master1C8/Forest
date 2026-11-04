# Russian caption repair and owner screenshots

The owner approved repairing the Gallery/Residents headings and quest screenshot
findings on2026-11-04. The final result contains seven independently reviewed
native Russian frames and offline macOS/Windows launchers1.1.3.

`localization/languages/ru.json` supplies `Gallery → Галерея` and
`Residents → Жители` through the registered `imageCaptions` compiler input.
The original English appears in `gallery_logo` and
`CritterLog_Residents_Label` sprites. Native Text replacements preserve their
texture bytes and parent transforms. The existing quest helper is reused;
the compiler verifies all old helper entries except the two named layout
bodies and reverses both new game-method prefixes to the complete original tree.

Quest history now measures the fixed portrait against an unscrolled content
origin and fills the available column beside it. Seven existing quest-list
templates use12 points, preserving all wording. Actual rendered history vertices
fit the viewport, including the completed row. A native reselection after bottom
scroll produces matching text bounds. The screenshot runner chooses an ordinary
list scroll position with complete visible glyph rows; it changes no quest data
or gameplay progress. Original intermediate frames and failed reviews remain.

Validation:15 compiler tests; normal final build/check;126 assertions against
the actual macOS payload;51 assertions against the shipping C# materializer on
macOS .NET8 with its host codec. Windows GUI/PowerShell5.1 were not run. All29
other locale compiler records and all30 bundle round trips are unchanged.
The historical accepted `ru-baseline.json` remains byte-exact.

Final screenshots: `localization/screenshots/ru-owner-20261104-final/upload/`.
The adjacent manifest, review and acceptance record bind the exact originals,
prepared review images and justified reuse of the four earlier passed frames.
Gallery and Scarlett use cycle02; the final quest uses cycle05. The Maverick
frame shows original current dialogue279:144, as explicitly requested after
the earlier conversation was found completed. No story flags were replayed.

Capture used disposable copies and the project's frozen native bridge, with
Unity framebuffer output and isolated application identities. Progress writes
were structurally disabled only in those copies; no write attempt was observed,
so dynamic save-suppression execution is not claimed. Every successful run's
cleanup verifies byte-exact saves/settings, closed process, removed bridge and
restored assembly/settings. The owner's licensed application was not modified.
The final Russian resources were subsequently applied through the normal1.1.3
launcher; all14 installed files match the delivered payload and the owner's save
and settings remain byte-exact. The game remains closed.

`verify_delivery.py` checks the actual ZIP contents, source pins,30 locale source
bindings, installed state and seven clean judgments. `usage-report.json` records
all six corrective CLI review processes and the measured mixed coordinator
interval; cached/reasoning subsets are not counted twice. Earlier capture work
and the reporting/delivery tail are outside that interval.

Private recovery uses the existing draft Release `storage-recovery-20261103`.
Keep the final launcher archives, screenshot ZIP and compact evidence ZIP there;
restore the evidence ZIP at the project root to recover original captures and
ledgers. Normal source/input restoration remains documented in
`STORAGE_RECOVERY.md`. No public mod/site publication or deployment occurred.
Whole-project source-only archival remains pending because multilingual native
acceptance is unfinished; this change does not close the project.
