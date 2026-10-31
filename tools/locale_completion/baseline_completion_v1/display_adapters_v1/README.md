# Versioned deferred display adapters

`build.py` applies explicit reviewed locale data to the actual saved game assembly,
then publishes a complete candidate through `tools/locale_resource_publish.py`.
Its profile pins the candidate, selector inventory, owning wording/reviews,
compiler sources, Cecil dependency, shared publisher and retained integration
receipts. Set locale, culture, output prefix and work directory explicitly.
The source family has 28 exact quest selectors and six OSK caption selectors;
other source versions require an explicit new contract rather than loose matching.

The accepted Russian quest history selection/provenance algorithm is reused.
Each of the 28 original display literals remains present and calls an injected
method returning its exact reviewed target. Other comparison/data literals,
condition ordering, queue calls and numeric formats remain unchanged. The three
old English photo-text comparisons use the accepted identity-based counter
predicate and its completion-slot shift. Existing German managed/font edits are
the input, not rebuilt from a bare source assembly.

OSK Generate calls the original Assign with unchanged receiver, keycode, key type
and functional name. The display hook then updates only the selected caption and
its default cache. Awake maps its original initial text/cache at the existing
boundary. Functional names, layout, callbacks, emitted values, and Relabel itself
remain unchanged. No serialized keyboard object is edited.

Run the frozen recipe `build.py --root PROJECT --profile PROFILE --output OWN_OUTPUT
--mode build`, then the same command with `--mode check`. Build requires fresh
work and output paths. Failed builds and published candidates are retained;
changed execution sources use a new pinned recipe/profile/output version.
Publication is sequential, manifest last; it is not an installation transaction.
The saved-resource `locale_build.py` transport does not accept this new adapter
profile. This shared versioned helper supplies the missing implementation and
uses the same publisher directly; no per-phase publisher is introduced.

`Program.cs` is a Cecil-only inspector. `verify.py` reads that delivered assembly
inspection and actual saved Unity resources. Its interpreter covers only the
small pure injected helpers and the declared Awake cache tail; it is not CLR,
Unity, game, native input, layout, or package acceptance. The original Assign's
label assignment is an explicit modeled boundary, retained unchanged in the
actual assembly. Whole metadata/body readback and reversal prove preservation;
those tests do not establish runtime loading or semantic acceptance.

Regression: level1 initial ENTER/SHIFT labels remain source English while the
shared-assets labels are German. All six selectors must yield German caption
and cache in both Awake->Generate and Generate->Awake orders. Checking only the
three shared-assets labels would miss this defect. Exact caption/name+keycode
matching must preserve unrelated labels, nulls, raw LF and U+200B.

Regression: reversal must retain the delivered module's unchanged method/field/
type references. Re-importing them from the original module can add an unwanted
Assembly-CSharp self-reference and rewrite a generic return parameter's display
name. Reuse exact unchanged references; resolve the restored Contains call from
the existing member-reference table. The final complete semantic tree must match
the source no-op tree, including references and generic method signatures.

Regression: every literal adapter is bound to its original selector ordinal,
source operand and unique introduced call. Repeated DONE/completion strings do
not allow one surviving call to prove several selectors. The actual delivered
assembly, rather than a fixture substituted as a game DLL, is always checked.

The German phase0095 final candidate and its new independent integration packet
bind this implementation. Earlier diagnostic/scalar/cache-incomplete candidates
are historical only. No game/GUI/installer/publication, additional model, server,
Git, protected-source or glossary authority is conferred by these tools.
