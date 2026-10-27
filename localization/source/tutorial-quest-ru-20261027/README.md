# Tutorial objective repair

The owner's 16:55:59 screenshot shows the HUD notification
`Bring the 'sugar' back to Scarlett.` while dialogue is already Russian. This
text comes from `QuestProgressLogText.log_text`, not a texture or dialogue entry.
The complete linked tutorial scope is six display cells: title, description and
four objective steps. `plan.json` binds their original row/field identities,
English values, accepted glossary evidence and the prior Actor-complete payload.

The shared source/consumer evidence is reused from
`bgdatabase-20261027/quest-progress/` and `quest-consumers/`. The Quest and log
constructors copy these display columns; notification history writes the native
Text groups. All 16 old/new HUD layers use native Font369. Their deliberate
overflow layout is preserved. No font mapping, timing, quest IDs, priority,
unlock condition, save identity or texture pixels are changed.

`QuestLogDetailsPane.UpdateSelectedQuest` compares display text with the literal
`lost photos` to append a progress counter. The bounded tutorial repair leaves
that log and its comparison operands untouched. Full quest-family localization
requires an identity-based counter adapter across current/previous history slots;
blindly translating all log strings would break existing behavior.

The delivered isolated candidate is
`localization/previews/ru-20261027-quest-fix/game/`, based on `ru-20261027-names-fix`.
It retains the settings, report form and complete Actor-name repairs. The build
receipt verifies full selected-object readback, unselected object bytes and all
other game-file equality. Only TextAsset320, isolated QA identity and app.info
change. Owner player files are excluded and the baseline is unchanged.

All 11 `test_russian_preview_ui.py` tests passed, including the new regression:
exactly four of 119 log cells change, the six selected targets match, repeated
application is rejected at the expected boundary, and the lost-photo source stays
byte-identical. The projection also restores all three edited column blobs and
requires exact restoration of the complete original payload.

Independent diff review, runtime and visual acceptance of this particular repair
remain pending. Static resource readback is not a replay of the owner's gameplay
frame. All 29 other target locales receive the same finite source scope in the shared
supplemental packet; their runtime/font acceptance is separate.

Regression: translated dialogue must not imply that HUD objectives or Actor names
are translated. Enumerate their actual display consumers and all rendering copies,
and preserve display strings used by game logic until a safe adapter exists.
