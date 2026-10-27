# Screenshot omission addendum

This additive packet covers every omission repaired in the Russian screenshot
sequence: settings captions, bug-report captions, Actor display names and the
complete four-step tutorial quest (including its title and description).
The report's six Back layers are included for cross-locale completeness.

The six locale files contain **212 concrete source/target records each**:
54 settings fields, 106 report fields, 46 nonempty Actor display cells and six
tutorial cells. They use one English catalog and the original asset/row/field IDs.
The 30 authored UI/tutorial phrases are expanded to every rendering occurrence;
full Actor names come directly from each locale's pinned approved glossary.
Short names retain the glossary's approved character identity. Proper names that
remain identical to English and Spanish `No` are explicitly classified.

`source-catalog.json` binds the source evidence, context, exact protected states
and the existing universal process stages. `manifest.json` binds every locale,
glossary, wording and generator fingerprint. `wording.json` is the authored input;
the locale JSONL files are generated translation inputs for subsequent integration.
They are separate from the frozen 12,246-ID dialogue corpus and from running
editorial jobs. Existing dialogue-only receipts retain their original scope.

Rebuild and check from the canonical checkout:

```sh
python3 -B tools/build_supplemental_ui.py
python3 -B tools/build_supplemental_ui.py --check
```

All products are validated before the first write. File replacements are atomic
individually; the output set is not a transaction. After interruption, regenerate
and require a successful complete `--check` before consuming the packet.

## Acceptance and next actions

| Artifact / predicate | Current evidence | Remaining uncertainty / next permitted action |
| --- | --- | --- |
| Shared source scope | All 212 IDs enumerated; exact group counts and duplicate rejection; original BGDatabase/source evidence pinned | This is the finite reported scope, not the full game inventory |
| Six locale data sets | 1,272 nonempty targets; author edit of all distinct phrases and aliases; full names bound to approved glossaries; every generated ID/source and required line break/URL checked | Independent semantic/diff review remains pending; use the same fixed editorial stages, reading every assigned ID and context |
| Actor safety | Only the two display fields selected; 32 null states and all five technical columns protected | During application, compare unselected cells/blobs and whole-payload restoration using the existing Actor projection method |
| Tutorial safety | Four linked objectives plus title/description selected; all other Quest display cells protected | The `lost photos` comparison needs an identity-based code adapter before translating the full quest family |
| Settings layer repair | All six TMP copies included; source-bound duplicate Image `level1:9708` requires `m_Enabled: 1 → 0` | Apply the existing guarded component repair with each locale; this does not require a replacement texture |
| Report form | Every caption and its repeat layers included; markers and blank sentinel preserved | Generated diagnostic payloads are outside this caption packet; no report is submitted |
| Fonts / resources | Actual native/TMP consumers and source font roles retained in the existing evidence | Resolve each locale's coverage, shaping and resource bindings before packaging; preserve the fictional-language font mapping |
| Runtime / visual / release | Not run for these six supplements | Integrate the packet only after the appropriate editorial and font gates; then perform authorized isolated runtime and screenshot checks. Do not mark whole-game or release acceptance |
| Texture-only findings | Owner's notify-only rule retained | Report them to the owner; do not generate or replace textures |

Future model-backed work must explicitly verify and select the owner-approved
Sol/high/OpenAI configuration; Astra is prohibited. This packet authorizes no new
worker, game launch, publication or deployment. Preserve running jobs and their
immutable inputs. Do not edit root README/CHECKPOINT while the technical lane owns
them. Newly captured review images must follow the workstation's separate WebP
preview policy; compression does not establish a visual pass.
