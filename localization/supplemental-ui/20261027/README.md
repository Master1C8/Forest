# Screenshot omission addendum

This additive packet covers every omission repaired in the Russian screenshot
sequence: settings captions, bug-report captions, Actor display names and the
complete four-step tutorial quest (including its title and description).
The report's six Back layers are included for cross-locale completeness.

The 30 locale files contain **556 concrete source/target records each**:
54 settings fields, 106 report fields, 46 nonempty Actor display cells, six
tutorial cells, 228 further menu/confirmation fields and six gallery formatter
instructions, 96 item display cells and eight item notification instructions and six directly displayed glitch-prefab labels. They use one English catalog and the original asset/row/field IDs.
The 59 authored UI/tutorial/item phrase groups are expanded to every rendering occurrence;
full Actor names come directly from each locale's pinned approved glossary.
Short names retain the glossary's approved character identity. Proper names that
remain identical to English and Spanish `No` are explicitly classified.

`source-catalog.json` binds the source evidence, context, exact protected states
and the existing universal process stages. `manifest.json` binds every locale,
glossary, wording and generator fingerprint. `wording.json`, `wording/<locale>.json` and `item-wording.json` are authored inputs;
the locale JSONL files are generated translation inputs for subsequent integration.
They are separate from the frozen 12,246-ID dialogue corpus and from running
editorial jobs. Existing dialogue-only receipts retain their original scope.

`locale-scope.json` binds all 30 non-English targets to the canonical site catalog
and the accepted 30-locale glossary index. Russian is included. The seven locales
in the existing dialogue checkpoint describe the earlier execution subset; they
do not limit the owner's requested scope. The generator rejects that subset as
incomplete, checks exact canonical locale coverage and verifies every approved
glossary fingerprint. Newly imported glossary layers are byte-identical to their
accepted canonical layers. Their content has not been retranslated or edited.

The original six-locale manifest and validation receipt are retained verbatim in
`history/`. The complete earlier 30-locale packet is retained in
`history/thirty-locales-before-menu/`. Its first 212 source/target records remain
unchanged in every current locale. The subsequent 446-record packet is retained in
`history/thirty-locales-before-items/`; all 446 records remain byte-exact prefixes
of the current locale files. The 110 item fields are appended. The earlier104-item-unit stage is retained in
`history/items-before-glitch/`; all550 of its records also remain exact prefixes. Additional authored wording is keyed by phrase ID in
`wording/<locale>.json`; it uses the same generator and acceptance stages.

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
| Shared source scope | All 556 IDs enumerated; original BGDatabase, complete six-panel menu inventory and the six actual gallery ldstr consumers pinned | This is the finite reported scope, not the full game inventory |
| 30 locale data sets | 16,680 nonempty targets; author edit of all distinct phrases and aliases; full names bound to approved glossaries; every generated ID/source, required line break, number, placeholder, size tag and URL checked | Independent semantic/diff review remains pending; use the same fixed editorial stages, reading every assigned ID and context |
| Actor safety | Only the two display fields selected; 32 null states and all five technical columns protected | During application, compare unselected cells/blobs and whole-payload restoration using the existing Actor projection method |
| Tutorial safety | Four linked objectives plus title/description selected; all other Quest display cells protected | The `lost photos` comparison needs an identity-based code adapter before translating the full quest family |
| Settings layer repair | All six TMP copies included; source-bound duplicate Image `level1:9708` requires `m_Enabled: 1 → 0` | Apply the existing guarded component repair with each locale; this does not require a replacement texture |
| Caption/value separation | Both caption containers use their actual TMP preferred-width provider, existing ContentSizeFitter and a right pivot; state-value origins are preserved | Verify actual glyph separation and viewport bounds for the target locale, not just the caption RectTransform |
| Gallery counters | Six display-only string operands in four methods; all original method bodies/branches/locals/handlers restore exactly after reversing those operands | Preserve actual unlocked/total values, secret-story exclusions, format parameters and size markup; replacing only serialized placeholder labels cannot localize these runtime writes |
| Item notifications | All 48 titles and 48 notification phrases use approved glossary terms or explicit placeholder/holiday-card wording; eight display literals cover legacy, dialogue and overworld methods; six glitch-prefab fields bypass those methods | Preserve all 16 other InventoryItem columns and three `show` animator triggers. Both shared item prefabs wrap all six face/glow layers: constrain two fields to210 units inside320-unit right-anchored groups with eight units of right padding, reserve icon space, and inherit the field width in ten child rects. Capture requires actual UI Camera glyph bounds inside the viewport after FadeIn completes. Compare every other database column and reverse to the complete prior payload; no ownership/save key is localized. Descriptions are a separate untranslated scope. Russian artifact/runtime evidence is in `item-notifications-20261027/validation.json` |
| Report form | Every caption and its repeat layers included; markers and blank sentinel preserved | Generated diagnostic payloads are outside this caption packet; no report is submitted |
| Fonts / resources | Actual native/TMP consumers and source font roles retained in the existing evidence | Resolve each locale's coverage, shaping and resource bindings before packaging; preserve the fictional-language font mapping |
| Runtime / visual / release | Not run for this 30-locale supplemental packet | Integrate the packet only after the appropriate editorial and font gates; then perform authorized isolated runtime and screenshot checks. Arabic, Persian and Hebrew require explicit RTL/bidi/shaping and mixed URL/punctuation checks; Hindi and Thai also require their actual shaping/layout checks. Do not mark whole-game or release acceptance |
| Texture-only findings | Owner's notify-only rule retained | Report them to the owner; do not generate or replace textures |

Future model-backed work must explicitly verify and select the owner-approved
Sol/high/OpenAI configuration; Astra is prohibited. This packet authorizes no new
worker, game launch, publication or deployment. Preserve running jobs and their
immutable inputs. Do not edit root README/CHECKPOINT while the technical lane owns
them. Newly captured review images must follow the workstation's separate WebP
preview policy; compression does not establish a visual pass.

Regression: a completed six-language UI packet alongside seven active dialogue
locales cannot claim coverage of all 30 requested localizations. Count the actual
canonical targets, preserve `es` and `es-419` separately, exclude source `en`,
include Russian, and reject missing or unknown target bindings before any output
write. `test_supplemental_ui_scope.py` checks these scope boundaries.
