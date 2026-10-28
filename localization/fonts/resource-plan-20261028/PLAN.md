# Exact resource binding plan, phase148

This is a static plan for The Forest of Love0.45 under the existing no-texture
constraint. No builder, font parser, original install, game, GUI or image was
opened. No font/resource/texture/target bytes changed. The parent owns Git.
This packet extends phase147 and its finite acceptance checklist; the original
118/119/147 packets remain unchanged. Candidate selection remains provisional.

`resource-plan.json` binds all109 original components, all10 requirement profiles
and all84 profile/resource/locale decisions to four resource families. Its140
resource identities and163 input fingerprints include the original index,
source-file hashes, exact exported trees, pinned faces, policy/recipes and four
already-read managed traces. `validation.json` records nine actual rejection
controls. `plan.py` derives only metadata; it cannot produce an asset package.

## Original fallback and source face

| Resource | Exact stored state | Normal builder action |
| --- | --- | --- |
| resources.assets:1020, TMP Settings | Empty global fallback list; default TMP1018; matchMaterialPreset1; runtime font features1 | Always set `/m_fallbackFontAssets` from `[]` to local PPtr `{0,1017}` |
| resources.assets:1017, LiberationSans SDF - Fallback | Source Font PPtr `{0,439}`; Dynamic1; face index0; point size86; scale1 | With `--repair-cyrillic-metrics`, change only face scale to float32 `(77/176)/(59/86)`; exact value in JSON |
| resources.assets:439, LiberationSans | Embedded350200-byte TrueType sfnt; payload SHA256 `e5b0af421ea2bfbc1ac8d251d647268087ae82786234c57f757d1f0b90fa8b49`; native material9/texture66 | Read as source for legacy field copies; original439 remains unchanged |
| resources.assets:10 | Fallback material; shader `{0,316}`; `_MainTex` `{0,74}`; stored texture size floats512; gradient scale10 | None |
| resources.assets:74 | Zero-size Alpha8/format1 original Texture2D; mipCount1;132 raw bytes; export status `empty-runtime-texture` | None in serialized package; native dynamic resize/reset/addition remains untested |
| resources.assets:1018 | Default static TMP;250 stored glyphs/characters; null source Font PPtr; material11/atlas75; local current fallback `{0,1017}` | None |

The actual1017 `m_GlyphTable`, `m_CharacterTable`, `m_glyphInfoList`, used-rect list,
both fallback arrays, kerning pairs and feature adjustment records are empty.
It has atlas array `[{0,74}]`, index0, legacy atlas PPtr `{0,0}`, width/height512,
padding9, renderMode4169, multi-atlas=false, clearDynamicDataOnBuild=true, and one
free rect `(0,0,511,511)`. The legacy `m_fontInfo.CharacterCount=250` and legacy
atlas dimensions1024 are stored metadata, not250 current dynamic cache entries.
`m_SourceFontFileGUID` and creation GUID are
`e3265ab4bf004d28a9537516768c1c75`; the creation sequence is preserved, not a
runtime character whitelist inferred from the editor settings.

The exact source FaceInfo names Liberation Sans/Regular, with lineHeight
98.8916015625, ascent77.853515625, descent-18.224609375, cap59, mean45 and baseline0.
These remain source-face metrics; only the scale changes in the normal recipe.
The already checked outline face has UPEM2048, ascent1854, descent-434, lineGap67,
U+0020 advance569. Font439 native16-point metadata has lineSpacing18.3984375,
ascent14.484375 and descent-3.390625, no bitmap character rects,266 kerning values,
empty fallback list and renderingMode0. Its native material9 uses built-in
shader reference `{2,10101}` and empty runtime texture66 (zero-size format4).
These are exact stored references, not proof of the resolved runtime material.

No shader body was recovered: shader316 is source-index pinned by raw hash.
Its missing exported tree does not justify a new framework/native audit.

## Shared TMP

The19 selected consumers are ordinary TMP4571 and18 settings layers. They retain
TMP3323, material7 and atlas244, including settings' external fileID5 PPtrs.
The original face is static0 with168 character entries, null source Font PPtr
and empty local fallback lists. Material7 uses its own bitmap shader246 and
`_MainTex`244. Its stored source GUID/name does not bind native Font369.

For ru/es/es-419/pt-BR/de, the concrete existing trial is the1020/1017 change
above. Keep TMP3323's entire raw object,168-entry glyph/character tables, face
metrics and material7/atlas244 exact. Package readback must resolve1020->{0,1017}
->source{0,439}, verify439's actual embedded payload hash,1017's float32 scale,
and the unchanged complete primary/material/atlas objects. Read back the actual
package, including its dependency table, rather than matching a font name.

This is missing-character fallback: existing primary characters still select the
original face. It cannot promise that an entire role uses Liberation Sans, or
that primary/fallback baselines, weights, marks and wrapping match. Global TMP
Settings affects consumers outside these19 and outside the whole109 selection.
Default1018 already has a local1017 route, so an empty original global list does
not prove fallback1017 was previously unreachable.

For zh/ja, the existing builder is incompatible with the requested Noto trial:
there is no candidate-source import or PPtr/metrics branch. Passing its normal
flags still loads439, which lacks the required CJK characters. A future importer
must first establish a valid embedded native Font for the exact SC/JP face and
coherent source metrics, then bind1017 to that actual source. No new object ID,
cross-file dependency or imported Unity metrics is invented here. Replacing439
globally would also alter its other native/TMP consumers and needs an explicit
expanded readback scope; it is not a safe hidden substitution. Until that
mechanism and native font loading are verified, the correct result is
`incompatible-existing-builder;application-not-run`, not a new atlas build.

## Bundled TMP

All75 selected bundled subtitle consumers retain the exact CAB-local font
`-1127281652424575413`, material`-6276354645929292820`, atlas`6922140881799398726`
and shader`-8207601126587615057`. These are distinct from shared3323/7/244/246.
The bundled font is also static0,168 characters, null source PPtr and empty local
fallbacks. The same Liberation1017 global-fallback trial applies conditionally
to these consumers; it does not rewrite their primary face or identify the
actual live copy. Each of75 IDs and its original PPtrs is listed in JSON.

Future readback must inspect the rebuilt CAB and external dependencies as well
as resources.assets: no local `{0,1017}` pointer may be inserted into the CAB as
though1017 lived there. Verify its unchanged primary/material/atlas hashes,
the actual loaded global Settings identity and dynamic fallback's source439.
The two bundled native Font copies below are separate objects; rewriting one
does not repair this null-source static TMP font. CJK has the same documented
import/metrics incompatibility as shared TMP, not an inferred CAB-local face.

## Native369

These12 selected Texts retain their Font369 PPtrs: four inventory labels, seven
quest fields/history slots and custom Text4545. Custom4545 is separate from
plugin3695. Phase147's exact component metadata retains sizes12/14/18, alignment,
line spacing, overflow, rich text, best fit and null material PPtrs individually.

The existing `--repair-cyrillic-metrics --coherent-legacy-face` trial copies every
Font439 field into shared369 EXCEPT `m_Name`, `m_DefaultMaterial`, `m_Texture` and
`m_FallbackFonts`. The complete copied field list is in JSON, including payload,
fontNames, metric/kerning/character tables, renderingMode and advance flags.
Shared369 therefore retains identity/name MatchupPro_TFOL, material6/texture243
and fallback{0,368}, while its outline face becomes the exact439 payload.
The equivalent bundled primary is525290011395715274. This changes a native role,
not the TMP3323 or bundled TMP source PPtr.

With repair alone, shared368 and bundled2133516458142313129 receive only the
eight fields listed in JSON: fontData,fontNames,lineSpacing,fontSize,ascent,
descent,kerningValues,renderingMode. Other metrics/flags and their material/texture
links remain original. Thus repair alone cannot be described as a complete
primary-face replacement. Both helpers retain broader consumers of these Font
objects;109 selected identities are not their complete impact denominator.

Future package readback for the coherent trial must hash extracted Font369
payload against439, compare every copied field with the439 tree, compare all
four preserved fields with the original369, then resolve every12 component's
unchanged PPtr against the actual dependency table. Material6 remains built-in
shader{3,10101}/texture243; preserving those bytes does not prove native dynamic
material generation or actual loaded font. Read native Font.name/fontNames,
loaded glyph source and actual component material in the authorized runtime.
Verify the fallback368 copy and its retained material5/texture214 separately.

SC/JP cannot use this existing coherent branch to obtain Noto: it hardcodes
Liberation439 and has no OTF import or metrics adapter. FontData byte replacement
alone is not an accepted native Font import. CJK UPEM1000/ascent1160/descent-288/
lineGap0/space224 are already checked source-face evidence, not Unity's imported
16-point metrics. No Liberation kerning/glyph indices or four Russian composite
pairs may be relabeled as CJK. Native format support and coherent metrics remain
the exact required implementation/runtime decisions.

## Native367

Font367 is ManaSpaceKerned8pixelperfect: zero embedded bytes,101 bitmap rects,
size12,lineSpacing12,ascent9,descent-3,renderingMode2,material4/atlas135 and no
fallbacks. Its material points to built-in shader{3,10101}; native face/OS fallback
coverage remains unknown. Merely keeping its bitmap atlas cannot add new glyphs.
Do not mutate367 or invent coverage from its family name.

A concrete future Liberation trial can rebind ONLY these three selected Texts
to the already coherent shared369; preserve all other fields and367's raw bytes:

| Text | Exact `/m_FontData/m_Font` before | Exact after | Other guards |
| --- | --- | --- | --- |
| sharedassets2.assets:17286, inventory title | `{m_FileID:5,m_PathID:367}` | `{m_FileID:5,m_PathID:369}` | size12, null material; preserve full original FontData/layout |
| sharedassets2.assets:17264, inventory description | `{m_FileID:5,m_PathID:367}` | `{m_FileID:5,m_PathID:369}` | size12, null material; preserve full original FontData/layout |
| sharedassets0.assets:3695, plugin portrait name | `{m_FileID:0,m_PathID:367}` | `{m_FileID:0,m_PathID:369}` | size12, null material; preserve full original FontData/layout |

This selector is NOT IMPLEMENTED by `legacy_choice_font.choice_font_plan`, which
enumerates only StandardUIResponseButton.label.m_uiText, requires a local font
reference and Response Text object. The two inventory fields use external fileID5.
It must not be called on these examples or credited as coverage. Existing custom
nameplate4545 already uses369 and is not a substitute for plugin3695.

Future readback must compare each full Text against the original allowing only
that pathId change, resolve retained fileID5 using actual sharedassets2 externals,
verify all three point to the same checked coherent369 payload, and verify367/
material4/atlas135 exact. A no-op replay or matching target substring is not a
postcondition. Reject ambiguous old/new pointers, wrong fileID, omitted label,
non-null material or changed layout. Runtime must show each actual selected role
at its original size and current input/state. The CJK version additionally lacks
the checked native Noto Font import described above; rebind-to-original369 does
not select Noto and is incompatible with that candidate.

## Cache, mark and texture boundaries

Preserved phase102/103 traces establish the relevant managed lookup order:
supplied font and local fallbacks, base-font routes, sprite, global fallback,
default font/default sprite. Style/weight alternate lookup and Dynamic1 glyph
addition are separate. These traces are reused by fingerprint, not rerun.
Actual settings singleton, active role, requested character, source loaded face,
fallback material and native glyph success remain runtime predicates.

Phase104 establishes that dynamic addition loads the actual source Font at the
stored point size; on a new glyph it checks texture readability and can resize a
zero-size texture to stored dimensions then reset/add glyphs. Glyph/character/
rect caches mutate in memory. Phase105 establishes that extra-atlas setup mutates
index/arrays before completion; false does not prove unchanged cache state.
Original1017 disables multi-atlas; its512x512 atlas capacity for the CJK workload
is unverified. Do not enable it speculatively or clear an original atlas. None of
these managed traces executes the native font/texture operations.

`tmp_dialogue_font.coherent_tmp_face` copies source face/weight/style metadata,
switches source to a local native Font, enables Dynamic1/multi-atlas, uses render
mode4121/padding5, clears glyph/character/rect caches and adds exactly four
TrueType glyf-derived Russian pairs ЁёЙй. Its builder branch also zeros the
original1024x1024 atlas and clears its stream. Both canonical builders still
reject `--coherent-tmp-face` BEFORE output creation. The guard and these helpers
were not modified or executed. Noto is OTTO/CFF and this glyf derivation is not
a CJK or general shaping implementation. The normal dynamic fallback does not
install those four pairs; decomposed marks need their own native proof.

Before any future package is accepted, compare all1385 original Texture2D raw
objects from objects.json using complete sourceFile/internalAsset/pathId identity,
including the zero-size native/dynamic placeholders. Compare the entire original
external stream files from source-files.json plus every bundle-contained texture
stream: exact file/member/path set, full bytes/length/hash, and stream offsets/
size/path retained in each object. Preserving only image spans or selected atlas
counts is insufficient. No new serialized texture/atlas object is planned.
Container recompression alone need not retain bundle bytes, but every original
uncompressed texture object and stream must remain exact. Verify unselected
resource objects and catalog/dependency updates at their owning package boundary.

Use a matching no-op package as the serialization control. Then the changed
positive control must use the SAME package, actual role and pinned corpus, show
the intended embedded face/source and correctly resolved fallback/material, and
render a required glyph absent in the original primary while ALL texture/stream
equality checks pass. Record in-memory runtime atlas allocation separately;
never serialize it into the preserved source. A no-op package alone cannot pass
the new-face predicate. Negative controls must alter one original texture raw
metadata byte, one external stream byte, candidate hash/source PPtr, material
binding, or omit one367 rebind, with all unrelated prerequisites satisfied and
the exact rejection reason checked. These package/native tests are NOT RUN.

## Remaining finite decisions

This assignment's static binding plan is complete. The next independent permitted
static deliverable is final-corpus applicability: join each of phase147's10
profiles with the owning immutable editorial-delivery manifests, preserve exact
saved hash applicability, and enumerate absent source/target IDs. No live overlay,
new translation, font parser, package or semantic-review request is needed for
that join. Missing/active locale manifests must remain explicit rather than
waiting for or stopping their owners. This does not accept source/editorial gates.

After those immutable inputs are bound, actual native trial authorization and a
concrete import/metrics implementation are required for the blocked font paths.
No further font-framework recursion or unchanged candidate scan resolves them.
Final redistribution/notices, style/readability and final-role corpus remain
open. Native shaping,bidi,marks,baselines,line metrics,narrow layout,input and
loaded fallback remain untested. Three compiled static-field holds (331,332,4948),
1655 database policy/external holds,1389 Rewired aliases,935/all30/frozen12246/
24492,haiku194-ID/27-outcome and fast-travel/seven-ID dependencies remain intact.
No complete source,special-scene,editorial,font,resource,runtime,visual or delivery
acceptance is inferred.

## Reproduction

Run `python3 -B localization/fonts/resource-plan-20261028/plan.py --check`.
It verifies163 input pins and regenerates exact metadata without opening live
targets or parsing font tables. Nine negatives cover missing109th component,
duplicate84th decision, wrong source439, atlas-rewrite permission, JP/SC swap,
invented CJK recipe support, shared/bundled material substitution, fictional
replacement and promoting an unrun texture check. The positive plan uses the
same inputs and guards. These validate metadata assertions, not independent
semantics, actual package texture equality or a native renderer.

All output writes are sequential, reject existing paths, and make no transaction
or rollback claim. Root README/CHECKPOINT updates preserve their prior bytes and
sections. The optional phase147 read-only reproduction observer lost its session
handle; its process was later absent, exit/result unknown. No pass is credited
and it was not rerun; phase148 directly verifies the pinned phase147 output and
recipe hashes. Usage is unavailable to this worker; the parent measures requests.
