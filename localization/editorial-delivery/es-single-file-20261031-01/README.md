# Spanish single-file editorial acceptance

The Forest of Love 0.45, Spanish from Spain (`es`, `es-ES`). The final
[language file](../../languages/es.json) has SHA-256
`430891663f1010bad39151d62f2eedbf3f31e658c2995ae69ed4aac363dca03a`.
[Acceptance](acceptance.json) binds the complete catalog, actual reviews,
glossary snapshots, static checks and resource delivery.

The compiler's canonical JSON escaping was restored after semantic review.
[Serialization applicability](serialization-rebind.json) proves complete parsed
document equality (all 14,606 source/target values and metadata) and all sixteen
resource payloads byte-identical to the reviewed candidate. Original review hashes
and their archive remain unchanged. No further model request was needed.

All **12,825 semantic IDs** have matching independent pass judgments. The
remaining **1,781 entries** exactly preserve the accepted baseline's original
source policy and receive no linguistic pass. Together these account for all
14,606 entries, with no missing targets, unread semantic IDs, unresolved context
questions or objective wording findings on this version.

There are **67 corrected target records** compared with the imported Spanish
file: 39 owner-selected `top/bottom` usages, the shared mixed-group caption,
18 bell-title emphasis repairs, the coupled locative haiku ending, the Penny
business/cuddling/sexual rhyme, Bucky's context-resolved anal wording, habitual
excursion tense, the named spa objective and three grammatical gallery hints.
The gallery hints retain source comma-list ambiguity; no AND/OR or unlock
sequence was invented. Valid idiom variants remained unchanged.

One independent **OpenAI / gpt-6.1-sol / high** CLI reviewer was used. It started
without parent history, then continued only its own assignment. Its first
1,134-ID gap review is preserved. The owner's later terminology selection and
the applicable canonical glossary revision required a complete semantic restart:
12,825 IDs in 164 reading pages, followed by a clean final **254-ID** delta
(four corrected versions and 250 unchanged mandatory regressions). No old queue,
second reviewer or nested model was started.

The [full review](review-reports/full.md) records complete coverage and bounded
source-art adjudication. The [final delta](review-reports/delta.md) records the
clean exact-version corrections, complete mandatory catalog and repaired gallery
context selector. [Combined reviews](complete-reviews.jsonl) retain each actual
model verdict/rationale and point to the original immutable evidence; merging
matching rows adds no new semantic judgment.

Build and check both passed through the common compiler:

```sh
./forest-localize build localization/languages/es.json
./forest-localize build localization/languages/es.json \
  --output dist/Forest-es-430891663f10 --mode check
```

The saved delivery is `dist/Forest-es-430891663f10`, with 16 exact resource files.
[Static verification](static-verification.json) and [build manifest](build-manifest.json)
bind source-aware controls, complete saved resource/database readbacks, reversal,
the 1,781 exact preserved entries and unrelated-work preservation. Existing German
and Russian delivery bytes still match their own manifests. This does not claim a
new build of an unrelated newer Russian language-file revision.

Native gameplay, font allocation, layout/clipping, controller/save behavior and
release acceptance remain untested/unaccepted here. Editorial scope is this
complete single-file inventory; no additional credit-screen or image-text
inventory is claimed. No game, installer, external publication or deployment ran.

The [lossless evidence archive](evidence.tar.gz) preserves **1,520 exact files**:
original packets, context, glossary snapshots, immutable closure sets, raw
model decisions/revisions, execution snapshot, runtime attestations and CLI logs.
Every archived member was read back and SHA-256 checked against the
[member index](evidence-index.json). Uncompressed local originals remain preserved
but are ignored as redundant working representations. Archive paths are relative
to the canonical Forest checkout; restore into an empty task-owned directory and
verify indexed hashes before reusing evidence, rather than overwriting live work.

[Measured usage](usage.json) reports all three nonoverlapping CLI phases:
50,743,586 input tokens (49,225,728 cached), 116,696 output (31,500 reasoning subset),
50,860,282 total. The final reviewer cutoff is 2026-10-31 18:31:37 UTC.
Coordinator orchestration/authoring tokens and the later Git/reporting tail are
unavailable, not zero. Token counts are not monetary charges.
