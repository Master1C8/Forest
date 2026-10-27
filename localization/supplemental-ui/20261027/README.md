# Shared interface omission supplement

The canonical scope is30 target locales including Russian,derived from the pinned
locale catalog and approved glossary index in `locale-scope.json`.
Each file now contains935 source/target records,28,050 total. These are additive
translation inputs for reported omissions,not whole-game or release acceptance.
The original frozen12246-ID dialogue inventories and active jobs are unchanged.

The source catalog covers settings,bug reports,Actor display names,the original
six-cell tutorial quest repair,the complete reported menu/gallery inventory,
item acquisition text and five-page Notebook tutorial,plus the complete Quest
family. The Quest addition selects all177 nonempty title/description/log cells
and28 compiled display operands. Six previously selected cells are retained;
199 core units and24 approved journal-header TMP fields are appended to the old712 records in every locale. All26 new
glossary-backed titles reuse the approved terms. The157 other distinct phrases
are directly authored in `quest-wording/`;special38-key wording/decisions precede
ordinary119-key authoring. Scripts validate/preserve structure,never translate.

`source-catalog.json` pins selectors,consumers,application contracts and exact
protected values. `manifest.json` pins authored inputs and every output.
`history/before-quests/` retains the complete preceding712-record set byte-exact.
Earlier446,550 and556 prefixes are also checked against their existing histories.
The generator validates every locale/output in memory before writing;individual
file replacements are atomic,but the32-file product is not a transaction.
After interruption,regenerate and require a complete successful `--check`.

## Acceptance and next actions

| Predicate | Current evidence | Remaining boundary / exact next action |
| --- | --- | --- |
| Shared source/30 data files |935 common IDs each,28,050 nonempty targets;source/glossary/format/line-break/tag/URL checks;old712 prefixes exact | Independent semantic/diff review reads every assigned ID/context under the common editorial stages |
| Actor names | Only nameplate/full-name fields selected;nulls and technical fields protected | Apply guarded projection,compare all other cells/blobs and whole-payload restoration |
| Quest display and behavior | Complete195-state family;18 nulls and15 technical columns protected;28 display operands;identity-based photo counter replaces three wording tests | Preserve original ordering,AND region groups,quantity branches,keys,formats and save identities;see quest-family-ui-20261028 |
| Settings/menu/gallery | Six TMP layers,duplicate state Image and caption/layout bindings retained;exact gallery formatter operands selected | Apply guarded component/code changes and verify native target glyph bounds/counters |
| Item notifications |96 glossary/phrase cells,eight display operands,six glitch bypass fields;all16 other columns protected | Shared wrapping/child-height/icon placement retained;descriptions remain a separate scope |
| Notebook tutorial |156 TMP fields across five actual pages;complete-title variant,metric spacing and30 multiline children | Preserve mixed line endings,paired native action labels and all artwork;Russian evidence does not pass other scripts |
| Native journal/HUD | Full Russian source/runtime/visual evidence is maintained separately in quest-family-ui-20261028/validation.json | Other locale font/resource/RTL/runtime/visual acceptance remains pending |
| Owner progress | QA uses separate products/generated fixture;no owner files used | An owner-requested launch follows PLAYER-LAUNCH.md with exact compatible save backup/transfer |
| Release/publication | No whole-game acceptance claimed | No installer,upload,publication or deployment is authorized by this packet |

## Protected controls and artwork

Apply `applicationContract` and `preserveExactly` in the source catalog in full.
Keep Actor technical columns,item enum/ownership/save keys,website identifiers,
format operands,rich-text syntax,original quantities and branch/control literals.
Source `More critters .` when every region is complete but the quest remains active
is preserved as a known source anomaly,not silently changed game behavior.

Texture-only labels remain notify-only under the owner's instruction. This includes
the game title,Gallery heading,Notebook Continue/action/example artwork and the
journal headings Active,Completed. Exact journal Image/Sprite bindings
are in `localization/source/quest-family-ui-20261028/journal-label-classification-correction.json`.
TALK/GOSSIP in translated Notebook instructions identify unchanged source buttons.
These precise exceptions do not waive missing text,clipping,overlap or glyph defects.

Russian local repair evidence is distinct from authoring,independent editorial,
other-locale application,complex-script shaping,native input/progression,
owner-save continuation,whole-game and hosted/release gates.

The approved Quest Log/Critter Log headers are actual TMP text,not painted
headings. All24 layers/variants are appended after the exact911-record prefix
kept in `history/before-journal-headers/`. Their legacy Images remain disabled.
