# Russian quest notification hotfix

The owner reported English quest instructions such as “say hi to more critters” in the Russian manual test copy. The exact source is `Say hi to four more critters.` in `TriggerHandlerAct1.ExecuteTrigger`. Two literal arguments bypass the already translated Quest database and QuestLog wording. `QuestUpdatedUI.ShowNotification` queues argument 1 as `previousStepText` and argument 2 as `currentStepText` unchanged.

| Existing common source ID suffix | Source | Accepted Russian |
| --- | --- | --- |
| `TriggerHandlerAct1::ExecuteTrigger(System.String)/IL_0646` | Check in with Scarlett. | Загляни к Скарлетт. |
| `TriggerHandlerAct1::ExecuteTrigger(System.String)/IL_064b` | Say hi to four more critters. | Поздоровайся ещё с четырьмя зверушками. |

These IDs were already present in `localization/source/shared-source-completion-20261028/admission-v1/compiled-wording-source.jsonl`; its SHA256 is pinned in `review-packet.json`. No new source extraction or frozen dialogue mutation occurred. This additive bounded repair admits these two evidenced display operands for Russian only. Other locale application holds, whole-source acceptance, special-case gates and release acceptance remain unchanged. This is not a claim that all quest-related surfaces have been accepted.

`review-packet.json` records the full two-ID author semantic pass and Russian read. `independent-review.json` is a version-matching fresh Sol/high/OpenAI review of both IDs and required context, with no findings. `targets.json` is the authored build input. Scarlett and critter terminology match the approved glossary. All target characters already occur in accepted Russian Quest wording.

`code-readback.json` inventories all 13 calls to `QuestUpdatedUI.ShowNotification` in the delivered DLL. The 10 QuestLog calls retain existing accepted literals and database-backed values; the two Act3 calls retain QuestProgressLogEntry database fields; the remaining Act1 call owns these two literal arguments. Technical quest/trigger/comparison IDs remain exact. No hypothetical additional text or renderer tracing was introduced.

The Cecil patch changes two `ldstr` operands in one method. All 14,099 method bodies pass exact readback; reversing the two operands restores the complete original instruction inventory, including branch targets, locals and exception handlers. Recorded type/field/method/resource metadata and all notification call sites are preserved. This is semantic instruction/metadata restoration, not whole-PE byte restoration.

The normal Russian builder applies this final managed stage after the supported narrative stage. It freezes targets, review, patch source and hashes. `build-validation.json` verifies the same frozen final stage against the delivered baseline, identical repeat output, rejection at the intended wrong-source operand boundary and existing character coverage. A full multi-gigabyte build was not repeated because its prior stages and resource bytes are unchanged.

The small payload is `dist/Forest-Russian-Test-20261029/quest-notification-hotfix/Assembly-CSharp.dll`. `tools/apply_quest_notification_hotfix.py` checks the exact baseline manifest, old/new DLL hashes, payload hash and Wine wrapper/native process absence. It replaces only this DLL while offline. The original build manifest stays immutable; the additive application receipt records the effective assembly. New saves/settings/progress are never restored or copied. The one-DLL replacement is atomic; the separate receipt is recovered on retry after an interruption. `installer-validation.json` verifies seven actual file-operation scenarios on isolated code-only fixtures, including failures before/after replacement, unknown bytes, bad payload, running game, a game starting during preparation and unchanged retry.

`owner-application.json` records actual offline installation, DLL readback and unchanged hashes of the two `tfol*` files already created by the owner. The assistant neither stopped nor launched the game. The existing `Играть по-русски.command` verifies the overlay before future launches and refuses installation while the same game is running.

| Acceptance predicate | Evidence | Remaining uncertainty / next action |
| --- | --- | --- |
| Two correct source/display bindings | Existing source IDs, complete receiver, current 13 call sites | Accepted for this finite repair |
| Both complete Russian strings reviewed | Author passes and independent review, pinned hashes | Accepted for these two strings |
| Only permitted instructions change | Complete body readback/restoration and metadata checks | Static accepted; native execution is separate |
| Correct payload delivered offline | Owner application receipt; effective SHA `94b5d36e5e6f8a1a0a12280754ae5c87c3f13338f40b085864d32df13c0ce750` | Installed; launcher reconciles unchanged repeats |
| Owner progress preserved | Installer writes only code; two existing save-pattern hashes unchanged | Continue the same save; no reset required |
| Actual notification renders correctly | No new native/visual claim | Owner launches the same copy and checks the notification when its event next occurs; an already completed one-shot event need not repeat |
| Whole-game release acceptance | Existing gates retained | Still false; this patch does not waive them |
