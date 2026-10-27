# TMP inline style replacement

The Forest of Love0.45 Russian standard localization; technical phase0099.
Static original metadata/IL only. Actual codex ancestor options were verified:
gpt-6.1-sol/high/OpenAI, --ignore-user-config; no Astra/aliases/fallback. Prefix was
isolated before --output-last-message; no following prompt/history was read/emitted.
No nested model/CLI jobs or agents. Parent alone owns Git/index/HEAD; worker has no
Git mutations. All parallel asset/editorial/Japanese lanes and actual preview remain
independently authorized and read-only. No game/GUI/images/native/original assembly
execution, authored translation, competing overlay or source/glossary changes.

Original Unity.TextMeshPro.dll SHA256:
775eab21aef1558df02968234ce1e506c2685c95813ba7cbb89e8f3e9102c483.
InspectMethods and the new InlineScopes snapshot use frozen Mono.Cecil to read
metadata. They never load or invoke original assemblies. Resources are hashed only.
The helper recipe excludes live Git source revision from informational version;
expected disjoint parent commits do not change this input or block no-Git work.

## Exact findings

ReplaceOpeningStyleTag(Int32[]&,Int32,Int32&,UnicodeChar[]&,Int32&) hashes the source
starting at srcIndex+7 (unchecked), writing the caller's srcOffset through the hash
helper. It calls retained GetStyle(Int32) BEFORE rejecting a null style or zero
srcOffset. A false result therefore does not mean no mutation: the offset has been
reset/possibly updated and lookup/resource/cache effects may already have occurred.
No prefix/full-name/equals/quote grammar is validated in this wrapper.

The exact Int32[]& value hash resets closeIndex0, scans to array Length or the first
'>', skips EVERY double quote, and hashes all other elements after conv.u2 with the
retained Char uppercase helper. It has no quote state, sixteen-element limit, space,
equals or NUL delimiter. '>' ends even inside quotes; missing '>' leaves closeIndex0
but returns accumulated hash. Hash equality does not establish name identity. Start
range/storage validity is not guarded; negative/overflowed indices can fail. This is
distinct from the phase98 UInt32 markup hash; do not substitute its rules.

Only after successful style/nonzero-offset tests does opening increment the field
m_TextStyleStackDepth, then index m_TextStyleStacks[newDepth] and Push the style hash.
It calls the opening-array getter twice (length then reference), loops the definition,
and normally decrements CURRENT depth and returns true. It does not pop the pushed
hash. Empty definitions still push and return true. No local depth/cycle guard, stack
array growth or finally/rollback appears. Self/mutual style references can route back
to the same opening helper; installed graph termination is unknown. Finite storage
and failure are not a validated recursion bound.

ReplaceClosingStyleTag(Int32[]&,Int32,UnicodeChar[]&,Int32&) never reads its first two
explicit arguments. It first Pop()s m_TextStyleStacks[depth+1], then GetStyle(hash).
Managed-null style returns AFTER the pop, without incrementing depth. Otherwise it
increments depth, reads closing-array length/reference through two getter calls,
expands, then normally decrements current depth. No source closing-tag parsing or
name matching occurs in this exact helper. Callers' prior hash/fixed skips remain
separate evidence. InsertClosingStyleTag is a distinct unread boundary.

Pop with index0 AND rollover0 returns default(T) without touching stack fields/items.
Otherwise it decrements index; nonzero rollover uses signed remainder then adds
rollover for a negative result. It loads the selected item, replaces its slot with
m_DefaultItem, then decrements positive count or stores0. Thus an intervening failure
can leave index changed before item access, or slot changed before count storage.
The actual initialized state/default/hash0/rollover is unknown. The closing-array
getter simply returns m_ClosingTagArray; it supplies no null/validity guarantee.

Both replacement loops retain their own backslash-backslash/n/u/U branches and the
same five markup-hash dispatch constants as phase98. UTF16/UTF32 helpers are reused
by hash: permissive invalid hex->15, no scalar validation. br/nbsp/zwsp constants emit
10/160/8203 with local+3/+5/+5 then the common+1 tail. Nested opening true uses its
returned index; false falls through to ordinary copying. Nested closing is void,
followed by local+7 then tail+1. No final-name equality validates collision-selected
fixed skips. At each of four sites per loop, equality-only resize precedes writing
ONLY UnicodeChar.unicode, then writeIndex++. No stringIndex/length/terminator write.
No glyph/layout/rendering acceptance follows from this static expansion.

## Reproduce

```text
python3 -B localization/source/bgdatabase-20261027/bio-tmp-inline-style-replacement/verify_inline.py --output localization/source/bgdatabase-20261027/bio-tmp-inline-style-replacement/<new-output-directory>
```

Accepted result: metadata-readback-final/verification.json. Five exact managed bodies,
29 resolved method operands,42 field operands,0 selected opaque method operands and
0 local handlers;9 exact direct dependency bodies reused by hash/identity. Three
raw/exact positive controls exclude the backing alternatives for opening, closing and
value hash. Five unread declarations remain pinned (the backing trio, exact
InsertClosingStyleTag and concrete TextMeshProUGUI.SetArraySizes). No original method
was executed and no mock establishes any replaced mechanism.

767 retained unique files include150 original DLLs and67 phase98 files. Frozen
sources/helpers/process references/resource hashes and old summaries verify. The first
successful readback is retained separately; final verification adds all actual new
helper bin files and explicitly checks the locally loaded Cecil matches the frozen
InspectMethods dependency. Both runs and initial dependency-scope projection survive.
The corrected initial process-option assertion is recorded in execution-model.json;
shlex removes quote delimiters, so parsed options must compare key=value tokens.

README/CHECKPOINT previous bytes are archived exactly. Existing checkpoint sections
are unchanged except nextAction/updatedAt; one new evidence section is added. README's
current summary changes with its following bytes preserved. Separate guarded writes
are not a transaction. Parent integrates the exact phase manifest; usage is unknown
to this worker and measured by parent. No Git/index/branch operation was performed.

Next read the backing trio and exact InsertClosingStyleTag, reuse unchanged helpers,
then pin concrete SetArraySizes without substituting base/dumping GenerateTextMesh.
Retain all phase79–98 source/cache/Lua/language/serialized-state/conditional UI/
notification/coroutine/queue/pre-render/parser/style/resource/native limits. Actual
controller/DB/Lua/metatables/language/loading/save/global scripts/callbacks/BIO/
reachability, complete source/special-scene/runtime manifest, serializer/nonlinear
restore, Quest ordering/reflection/initial-unlock/counter, semantic/independent-diff/
delta, final fonts/licenses/resources/runtime/visual/delivery remain pending.
Accepted10/15/47/48 visuals/50 route unchanged; spawn/other3 intros/notebook/Bucky open.
No53 replay/no54, publication/deployment or server action. Static phase success is
not complete localization and does not gate the independently authorized draft lanes.
