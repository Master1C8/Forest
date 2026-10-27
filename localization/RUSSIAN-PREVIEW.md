# Russian isolated preview repair

The current repair is a provisional runtime test for The Forest of Love0.45.
It does not accept the incomplete whole-game inventory or the locale's semantic,
independent-diff, resource, runtime or release gates. Six preliminary dialogue
audits keep their original source/target/glossary inputs unchanged.

`tools/build_russian_preview.py` takes an explicit unique `--qa-product`, such as
`ForestRuActual20261027_06`, and a new `--output` directory. It refuses an existing
output or a non-QA product. The original install and owner saves are read-only.
Every new run must verify the QA profile is unused before launch. The builder
preserves complete original no-op/readback equality and unselected object bytes.

`tools/russian_preview_ui.py` owns the display corrections. The existing TMP face
replacement changed the baseline contribution while authored `m_lineSpacing`
stayed unchanged, including the warning's negative32. The recipe compensates
each exact font binding using the shipped TMP formula, preserving the original
baseline distance across body, outline and glow layers. This is a shared metric
correction, not per-string whitespace/glyph repositioning. The warning's four
authored source/target variants bind12 actual Unity fields, with real newlines,
color and underline tags preserved. The baked WARNING heading is unchanged art.

The Actor projection changes exactly Scarlett's `nameplate_name` and `full_name`
cells to the approved Скарлетт and Скарлетт Нежнолапка. Actor/row/field identities,
plugin names, savekeys, schema and every other column remain exact. A repeated or
ambiguous old/new state rejects. The ordinary introduction mask and engine's
existing override behavior are preserved. Source actors are never globally renamed.

The owner's main-menu screenshot additionally identified five untranslated labels.
The builder now translates Gallery, Options, Controls, Quit and Report a Bug across
all36 actual level1 text/glow/container fields. Options retains its original terminal
newline. The official title and TFoL.info are retained names/domain labels. Artifact06
readback verifies the complete fields. Fresh native reviews passed all six Russian
menu controls, the selected New Game submenu, and its translated Назад control.

Eight focused tests exercise real original warning bindings, an unrelated-font
negative, real BGDatabase projection/preservation, overlapping old/new states,
the font equation and cache selection. They establish static boundaries, not
actual rendering or dialogue advance. Every repaired native frame still needs
fresh bounded original-resolution inspection; normal input progression needs
actual guarded before/after semantic states and delivered event edges.

Artifact04's native warning original has passed a fresh independent review for body
content, glyphs, spacing/underlines, layout and contamination. This scope explicitly
retains the baked English WARNING heading. The owner confirmed manually closing04;
its exit is not a demonstrated crash. No input edges or dialogue advance were credited.
Artifact06 retains this warning/name recipe and adds the owner's menu labels.
It translates all36 Back TMP fields and the two exact loading TMP bindings in
level5/level6. Original rich-text tags, including an unmatched source </size>,
remain unchanged. These two scene resources are explicit build inputs.

The clipped press-any-key prompt comes from the invisible NameContainer TMP
ILayoutElement and an existing ContentSizeFitter that fitted only height. It
has no legacy Text synchronization producer. The repair fits preferred width
and aligns each container to its actual outer root pivot, including parent-width
compensation. All18 TMP face/glow layers and three hidden native source fields
across the scene and two page prefabs stay coherent. Source font367 remains
unchanged; the three hidden fields bind the existing embedded font369. There
are no prompt copies in the selected bundle. The native artifact06 prompt was
reviewed at2880x1800: the complete Нажмите любую клавишу fits, with its final
character and descender visible. No font-width guess or string shortening is used.

The original controller-support raster artwork still contains English text,
including Supports Game Controllers and English only (for now). That artwork
and the baked WARNING heading are outside these serialized-text repairs; this
preview is not complete texture localization.

Artifact06 build SHA-256 is
7b8c18868f1a7538ff33f35e0a232bf67aa974e2a45103f511c8bd437624765a.
The source Assembly-CSharp.dll is unchanged. Same-instance ordinary Return
input passed the original post-credits handler, opened the actual main menu,
opened the New Game submenu and reached the Russian loading screen. No callback,
scene jump or game-state injection was used. The same instance also passed
ordinary dialogue transitions from145:265 (А?)
to145:259 (the familiar rock), then145:260 (the familiar tree). The full route,
choice-to-next-state transition and unmasked Скарлетт nameplate remain pending.
Both actual259/260 native originals passed fresh full-resolution visual review
for complete Russian text, wrapping, glyphs and contamination. No single rendered
frame is credited as full dialogue progression.
Source, renderer, viewport and frame bindings must be verified for reused evidence.

## Native input and focus

The current QA instance is parent-owned. Keep one operator and bind its exact
PID lifetime, command line, window ID, dimensions and native source state before
input. NSRunningApplication activation returning true does not establish actual
focus; on this macOS SDK activateIgnoringOtherApps is deprecated and has no effect.
System Events activation of the exact existing process can establish focus, but
must still be followed by exact AX owner/geometry and top-window verification at
the event boundary. Wait for the compositor rather than weakening those checks.
If another app takes focus after an earlier observation, reject before key-down.
Never release physical owner input or send a global event to make the test pass.

The source Continue Button is sharedassets0.assets4572, first-selected GameObject944,
bound to the unchanged OnFastForward component4633. The source handler completes
typing first or calls normal OnContinue. Use ordinary input, never invoke that
callback directly. A documented CGEventPostToPid background-only probe delivered
one DOWN/UP pair while the145:259 subtitle remained unchanged. It established
only OS event delivery; it did not establish game input acceptance or advancement.
Preserve it separately from successful focused inputs.

Regression: the game is recognized at145:260, exact AX/top-window focus is observed,
then Codex or another app becomes foreground before the native event check. The
attempt must emit no DOWN edge, retain the native frame and stop; do not call this
a localization/typewriter hang, relaunch, or repeatedly steal focus. Resume the
remaining route only when the desktop is available or a proven scoped backend
can accept the original input. Original install and owner saves remain unchanged.

## Storage and interrupted work

The earlier external-to-internal game copy exhausted local space and interrupted
eight CLI requests. Discarded unlaunched game clones02/03 were reconciled and
removed after exact task ownership/content/process checks. Their recipes and
failure evidence remain under outputs/ru-ui-repair-20261027/. Original game,
owner saves, accepted01 evidence and all translation batches were preserved.

Set `FOREST_RU_CLONE_CACHE` to an existing project preview's `game` directory to
reuse only files whose complete SHA-256 equals the original installed file.
`clone_file` uses APFS copy-on-write when available, keeps distinct inodes and
verifies the copied bytes against the original. Modified cache files fall back
to the original source. A clone receipt is saved before resource replacement.
Freeze the launcher, all helpers and inputs in an immutable run recipe; set
`FOREST_RU_INPUT_ROOT` to that recipe's pinned input snapshot. Do not change an
active run's version. The builder requires512MiB free before starting.

Editorial recovery uses `editorial_lane.py run --reconcile-interruption` with
the exact lane-owned storage receipt. Verify the old supervisor, worker and
children are absent, pins unchanged and space recovered first. A completed
contiguous batch prefix keeps its exact review hashes. Preserve an unfinished
batch and restart it in a new attempt directory/fresh context; do not credit
partial decisions as a complete batch. Before model dispatch retain256MiB free.
The regression uses a fake CLI/process guard and does not prove model semantics.

Technical static-source recovery uses a separate `storage-interruption` receipt
through `run_serial_ru.py --reconcile-interruption ... --git-coordinator parent`.
It requires original storage-error evidence, exact artifact/HEAD binding and no
surviving task processes. A static phase with no game launch does not invent
runtime quit/bridge-cleanup acknowledgements. Parent alone stages and commits.
Every interrupted request's exposed token subtotal is separate from successful
retries; missing final usage stays unknown. Never sum cumulative milestones.

Regression: with six active semantic streams and a static technical worker,
an unlaunched preview build hits ENOSPC after partial output. Preserve all source,
target and completed review hashes; reconcile all surviving children; restore
only interrupted attempts with explicitly pinned non-Astra models after space
recovers; create a new isolated clone-aware preview without overwriting partial
evidence or claiming a screenshot proves ordinary dialogue advance.
