# Selected font roles and requirement applicability, phase0147

This append-only supplement reconciles all109 selected original Text/TMP identities
for The Forest of Love0.45. It is static metadata and requirement evidence. No
live target, original install/save, game, GUI or image was opened; no font payload,
texture or target wording was changed. Parent alone owns Git; the parallel asset/editorial/Japanese lanes and
actual Russian preview remain independent and untouched.

`reconciliation.json` contains every component, original resource identity, stored
selection, source selector and requirement profile. `validation.json` binds its
bytes to the recipe and input pins. `acceptance-checklist.json` extends the existing
finite font checklist without rewriting the accepted118/119 historical packets.

## Exact coverage and proved selections

| Physical selection | Count | Original binding |
| --- | ---: | --- |
| Shared ordinary dialogue | 1 | TMP4571 -> TMP_FontAsset3323 / material7 / atlas244 |
| Bundled subtitle copies | 75 | Bundled TMP_FontAsset-1127281652424575413 / material-6276354645929292820 / atlas6922140881799398726 |
| Three settings labels, six layers each | 18 | TMP3323 / material7, source-validated fileID5 |
| Inventory title/description pairs | 6 | Original17275 pair -> native Font367;17277/17282 pairs -> native Font369 |
| Quest title/description/current/four history slots | 7 | Native Font369 |
| Plugin portrait name | 1 | Native Text3695 / Font367, outside custom root |
| Custom nameplate | 1 | Controller4311 -> root2849 -> Text4545 / native Font369 |

The resource totals are75 bundled TMP,19 shared TMP3323,12 native Font369 and
3 native Font367 consumers. These109 are selected physical identities, not all
game components, visible source units or runtime instances. The10 requirement
profiles group the five quest-history slots only as a conservative source family;
they retain every component and its exact per-slot baseline role.

The two ordinary TMP assets each have168 original character-table entries,
static population0, null source Font PPtrs and empty local fallback arrays. Those
facts do not identify native Font369 or any global/dynamic fallback. Native Text
material PPtrs remain null; actual default materials and external Font367 face
coverage remain unknown. The saved bitmap table for Font367 is reported as a
table check, never a proved external-face cmap.

## Source and target applicability

All109 stored text selectors join the current admitted serialized inventory and
direct context with exact values.118 uses compact JSON plus LF for its component
value hashes; admission-v1 uses compact JSON without LF. Both representations are
validated explicitly, with no substitution of raw UTF-8 hashes.

Only the18 selected settings components directly join the old935-unit target
packets. Dynamic joins produce these finite conservative profiles:

| Profile | Dynamic source states | Existing935 target IDs | Nonempty dynamic inputs absent from935 |
| --- | ---: | ---: | ---: |
| Inventory title | 48 DB titles +2 empty-cell literals | 48 | 2 |
| Inventory description | 48 DB descriptions +2 empty-cell literals | 0 | 50 |
| Quest title | 38 DB states | 30 | 0;8 DB states absent |
| Quest description | 38 DB states | 28 | 0;10 DB states absent |
| Quest history | 119 DB logs +34 compiled wording inputs | 147 | 6 |
| Custom nameplate | 39 DB nameplate states +2 conditional overrides | 28 | 2;11 DB states absent |

The missing48 descriptions are all stored, nonempty original strings. The four
compiled inventory strings have exact argument positions: OnCellSelected IL010c /
011d go to UpdateItemInfoText arg1 / itemTitleText; IL0111 /0122 go to arg2 /
tickerText. Item400 instead clears both ordinary fields and uses a separate glitch
TMP; that output cannot be assigned to the six selected native Texts. Item405,
consumed/quantity and listener/layout conditions remain part of runtime acceptance.
No missing target is authored here and no live language overlay is read.

The quest-history allocation is a source-family superset for five slots, including
conditional assembly inputs and protected display comparisons. It is not a claim
that every row reaches every slot. The prior region/status/counter/prefix/null,
ordering/reflection/unlock and exact adapter dependencies remain open. Likewise,
Actor.nameplate_name is a candidate path for custom Text4545, not a complete final
NameplateName/custom-setter/parser/BioDetail override closure. Plugin3695 has no
invented equivalent binding.

For each of30 immutable packets, each profile records the exact bound target IDs,
raw/NFC/NFD codepoints, source/hash gaps and per-face subset results. Empty target
projections are explicitly `no-bound-target-characters`, with unknown missing
count; they never become default coverage passes. These are existing target/source
joins, not independent semantic review or proof that the935 set is now complete.

The seven saved12246-ID dialogue corpora remain a separate versioned logical
superset in the saved reports. Ordinary/bundled TMP comparisons are new set
differences against their actual stored character tables. For shared TMP3323 the
logical superset misses84 characters in ru,2225 in zh and1533 in ja. These include
control/preserved/fictional operands; they are not observed missing glyphs or an
accepted final per-role display corpus. Other roles never inherit the dialogue
superset as their requirement set.

## Candidate and resource decisions

The84 decisions cover each profile's distinct stored resource across seven saved
locales. They retain the stored binding and name a candidate for a future bounded
trial only. The pinned unmodified Noto Sans CJK SC Regular2.004 is the zh candidate;
JP Regular2.004 is the ja candidate. Exact file/PostScript/face/metrics/provenance
and OFL notice hashes are reused. They are not a universal CJK locale-form choice.
For ru/es/es-419/pt-BR/de, embedded LiberationSans resource439 is a trial candidate
supported by the saved character checks; final resource selection, style/readability
and redistribution/notices remain unaccepted. No fallback cmaps are unioned.

The fictional `mouse` command remains controller4311.fontMouse -> TMP3324 /
material3 / atlas245, distinct from fontMain3323. All38 pinned phonetic rows are
retained exactly, and the12 missing SC/JP candidate codes are verified against
the100-entry original mouse table.38 is the candidate-missing subset, not the
complete fictional dialogue denominator. The native nameplate font is separate.

No atlas, font or resource is generated. The existing no-texture guard stays
active: `--coherent-tmp-face` is prohibited. A later permitted resource build must
compare every original Texture2D object and external texture stream byte-for-byte.
Runtime dynamic glyph-cache behavior is unverified; it is not equivalent to editing
texture-file assets. Required shaping, bidi, mark placement, baselines, line metrics,
narrow layout, actual loaded fallback and dynamic-input coverage remain unverified.

## Reproduction and controls

From canonical Forest:

```sh
python3 -B localization/fonts/role-requirements-20261028/reconcile.py --check
```

The recipe opens no images or live targets and runs no font parser. It verifies
36 direct pins,295 unchanged substantive original/readback input pins,46 current
source products, both original font/nameplate readback receipts, pinned candidate
files/notices and all30 immutable target packets. These overlapping counts are
categories, not a unique-file total. The prior original-install hash is reused
through its119 receipt without reopening the install. The old fonts README is
explicitly superseded documentation, while its current pre-phase bytes are saved.

Nine negative controls cover duplicate identities, out-of-universe character reuse,
live-target access, source-value mutation, wrong custom-label identity, omitted109th
component, shared/bundled material substitution, empty-projection passes and fictional
candidate substitution. Matching controls cover real109-component coverage,
unknown external-face preservation, missing/present subsets, raw/NFD differences,
separate367/369 bindings and hash representations. These checks exercise metadata
joins and subset reuse, not replaced font parsers, independent language judgment,
packaging or runtime. Multi-output writes are sequential and reject overwrites;
there is no transaction/rollback claim.

The finite role/source decision packet is complete within this scope. Final source
admission still holds at three compiled static seeds,1655 database values,1389
Rewired alias predicates, actual native overrides and complete special-scene/source
closure. Final target/editorial, resources, runtime/visual and release gates remain.
Repeated absence scans or font framework recursion cannot resolve those decisions.

The next useful static artifact is a concrete texture-preserving resource plan for
the existing dynamic fallback1017 and native roles, using exact original metadata
and current builder branches. It must state which source-Font/material/atlas/cache
bindings can actually be planned for the pinned candidates, and where application
or native runtime is required. It must not generate resources or reopen the game.

Root README/CHECKPOINT updates preserve all old sections. Writes to separate files
are guarded against their pre-phase bytes; they are not a multi-file transaction.
Usage is unavailable to this worker; parent owns measured request accounting.
