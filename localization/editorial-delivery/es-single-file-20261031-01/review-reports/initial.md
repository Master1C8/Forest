# Spanish independent first review

The Forest of Love 0.45, Spanish from Spain (`es`, `es-ES`). All **1,134/1,134** assigned source/target IDs were read with their required wording and semantic context: 253 UI/narrative/managed IDs and dialogue partitions of 302, 212, 187 and 180 IDs. **1,111 pass; 21 finding; 2 needs-context.** There are no unread primary IDs. This is complete reading coverage with outstanding findings, not a clean editorial acceptance or runtime/release acceptance.

The actual fresh CLI session was verified before reading localized inputs: `01a192e3-b09b-7651-8430-373cdab347cb`, `gpt-6.1-sol`, high reasoning, OpenAI provider, null parent thread, no resume/fork. The attestation was checked against the session metadata, turn context and live PID 74018 arguments. No nested reviewer/model or translation service was used.

## Consolidated correction proposals

The exact stable IDs, original source/target hashes, complete proposals, explicit physical member sets and model rationales are in `judgments.jsonl` and `group-decisions.jsonl`. Grouping expanded actual model-written judgments after the complete wording and member contexts were read; the expander only resolved the explicit memberships. It supplied no default judgments.

| Issue | Exact group / primary ID | Rows | Proposed complete target and objective reason |
|---|---|---:|---|
| Shared group caption | UI061; managed CustomPortraitsUi::VNRevivalRussianSpeakerDisplay(System.String)@60 | 1 | `Todos`. Current `Todas` conflicts with approved `tfol-042` and does not serve the mixed bridge group. Pinned source scene 326 includes Bucky, Dustin, Augustus, Maverick, Penny, Mabel and Scarlett around the Everyone cue. |
| Missing locative link | UI075; managed TriggerHandlerDates::VNRevivalRuHaiku_Resolve(System.String,System.Int32,System.String)@92 | 1 | `donde nadie fue`. Current `nadie ha llegado` drops the source's “Where” and breaks the relationship between the request to fly above clouds and its destination. Keep the corresponding display/evaluation line coupled; source scene 303, entry 408 supplies that display choice. |
| Empty title emphasis | UI129 / UI130 / UI131 | 18 | Purple: `<size=22>L</size>A <size=22>C</size>AMPANA <size=22>M</size>ORADA`; Red: `<size=22>L</size>A <size=22>C</size>AMPANA <size=22>R</size>OJA`; Green: `<size=22>L</size>A <size=22>C</size>AMPANA <size=22>V</size>ERDE`. Each current title inserts an empty size span immediately after L, producing four spans instead of three visible initials. Correct colour follows the supplied Purple/Red/Green hierarchy, not the copied Blue source title. Apply to every explicitly listed physical copy. |
| Future tense in an established practice | `ds:422:756:Dialogue Text` | 1 | `[pic=3]¡También acompañamos a Melody en sus excursiones!` Current future `acompañaremos` presents a new plan, whereas linked entry 757 recalls where those excursions usually went. Melody's scene 452 also describes the existing practice. The source uses habitual “We'll”; preserve that reading. |

These are proposals for parent adjudication. No language file was changed.

## Explicit context questions

- `ds:176:154:Dialogue Text`: “going down on me” normally denotes oral sex, but its pinned scene is `gossip/beaver/anal` and the next line asks bigger boys to get in deep. Current `baje a darme placer` is vague/calqued. Establish the intended act before imposing an oral-only correction or accepting the broad euphemism. No unsupported resolution is proposed.
- `ds:941:726:Dialogue Text`: “fannys” can name bottoms or female genitals depending on dialect. Current `coño` narrows the anatomy for both women on a card featuring Melody and Penny. The approved glossary distinguishes Penny's cloaca, and the pinned textual card scene does not determine the depicted body region. Adjudicate from suitable source/card evidence before accepting this specificity. No image or game was opened.

Both rows were read and explicitly judged `needs-context`; neither is a pass. All supplied required textual contexts have been read. Additional source evidence is necessary to resolve these questions; no unread assigned wording is hidden by the complete-context checkpoint.

## Separate glossary/source conflict

Approved English `tfol-010` calls Finley the former roommate of Claire and Violet. Approved Spanish faithfully repeats that statement. The pinned game sources instead identify a fox and a bear in scene 199 entry 182, and Charlotte/Melody discuss their former household and apologize to Finley in scenes 409 and 428. This conflict exists in the canonical English source too; it is not a Spanish-only glossary mistranslation. Report it for protected-source adjudication, preserve both glossaries, and do not rewrite correct game wording to name the coyotes. The related reviewed target rows correctly retain male Finley and the women's feminine agreement; unchanged semantic evidence is not automatically invalidated by this note.

## Checks and review boundaries

- Input binding: packet `16387ffcee3e812291549ade52827670ef4261919846cf9c50512991166dfe91`; Spanish language `b419595e61ea7d99cabcb60019e5a8d8bef5cccc4e441ae946eb91dcb680dd14`; approved Spanish glossary `d6875d757ce39d0b35a5c3ee77b1d6987ed3dd49e8a4a84acca53eb2548fb767`. Framework/source glossary pins and all 141 supplied context hashes were verified. All 221 frozen execution-file pins matched.
- The five partitions are a disjoint exact union of the 1,134-ID packet. UI groups retain every physical member/context, including narrative faces, glows, layout providers and colour-specific bell hierarchies. Group expansion verifies exact source/target versions and complete explicit member coverage.
- The complete compact approved Spanish glossary and actor roster were read. Dialogue links were read with actor/conversant identities, surrounding source wording and relevant conditions. Pinned full source was consulted only for the concrete haiku, Everyone and holiday-card questions. Extra target context was limited to the excursion and coupled haiku dependencies; it does not receive new primary acceptance.
- Dynamic wording was checked for semantic roles and grammar: item/name prefixes retain their separators, objective location fragments retain placeholder order and comma-space joins, adventure headings retain title separators, and gallery counts retain argument identity and noun agreement. This static editorial check does not execute a renderer or consumer.
- Actual review groups include neutral personal references versus grammatical species/body-part gender, known male Finley and female Claire/Violet, apology direction, delayed character reveals, all sentences in replacement units, emphasis over corresponding concepts, and all physical copies.
- Valid variants were retained: singular Película versus category Vídeos, generic ratones/rata grammar, formal flight announcements, source-faithful silence/sounds, and complete proper-name speaker cues. No change is proposed solely for stylistic preference.
- The other 12,018 prior-review IDs and 1,454 original preservation states were not rereviewed or newly accepted. Constructed-language/source-preserved strings were not labelled missing Spanish.
- No game, GUI, screenshot, installer, publication, deployment, server, Git/index mutation or old-queue restart occurred. Only this phase directory was written. The frozen helper publishes local review evidence; it does not authorize external publication or launch another worker.

The next finite task is to adjudicate this entire set, make one consolidated language repair, generate the exact invalidated dependency closure and request this same reviewer's bounded correction delta. See `next-task.json` and `adjudicate-next.md`. Measured usage and its cutoff are recorded separately in `usage.json`; subsequent reporting overhead remains outside that measurement.
