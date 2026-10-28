# Original title-event serialization boundary

All 39 exported `GeneralStoryUIController` instances omit both
`onDialogueEmptyWithTitledLine` and `onDialogueLine`. These are absent fields,
not null fields or empty listener arrays. The same trees contain the ordinary
`onAdvanceMoment.m_PersistentCalls.m_Calls` event table, which is the matching
positive control. There are no derived story-controller types in the original
game assembly.

Original metadata proves that `StringPrimitiveEvent` extends `UnityEvent<string>`
but lacks the Serializable type flag/attribute. The service-level
`DialogueService.onDialogueLineBegin_AnyPassthruTitledLine` field is static.
The [Unity 2020.3 serialization contract](https://docs.unity3d.com/2020.3/Documentation/Manual/script-Serialization.html)
requires eligible custom classes and excludes static fields. Together with the
actual exported trees, this closes the proposed serialized-persistent-listener
search for these fields in this supported source version. `HideInInspector`
alone is not the reason: the positive-control field carries it too.

The prior complete game field-use index and Rascal listener/handler proofs remain
in `admission-v1/phase136/`. Their exact results are reused, not broadened into
an absence claim about arbitrary reflection, native code, or external programs.
This supplement does not itself adjudicate all 934 residual entry Titles, the
721 custom-field values, or common-source/translation/runtime acceptance. The
owning source recipe must replace the inaccurate persistent-listener predicate
with the actual remaining consumer decision, retaining every original value.

Reproduce after building the narrow read-only metadata tool:

```sh
dotnet build localization/source/shared-source-completion-20261028/serialized-title-events/FieldMetadata.csproj --nologo --verbosity quiet --ignore-failed-sources
python3 -B localization/source/shared-source-completion-20261028/serialized-title-events/verify.py
```

No game assembly is executed or modified. The metadata utility reads exactly
three types, four selected fields, and the local type hierarchy. `--write` is
first-creation-only; its two exclusive writes are sequential, not transactional.
The validator compares all original tree hashes and every emitted roster row,
and checks distinct absent/null and missing-positive-control failure reasons.
No translation, font, texture, installation, save, screenshot, or runtime changes
are made.

Regression: a future tree containing the custom event key with a null value must
fail this version-bound absence decision. A missing `onAdvanceMoment` table must
fail the positive-control boundary, rather than passing as another empty event.
