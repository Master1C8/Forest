TYPE TheForestOfLove.PlantQuestMinigameController
METHOD System.Void TheForestOfLove.PlantQuestMinigameController::StartMinigame() | attributes=Public, HideBySig | impl=IL
IL_0000: ldstr "Act1_PlantQuest"
IL_0005: call TheForestOfLove.Narrative.QuestStatus TheForestOfLove.QuestTriggerHelper::LoadQuestStatus(System.String)
IL_000a: ldc.i4 200
IL_000f: bne.un.s IL_0012
IL_0011: ret
IL_0012: ldarg.0
IL_0013: ldc.i4.1
IL_0014: call System.Void TheForestOfLove.PlantQuestMinigameController::set_minigameActive(System.Boolean)
IL_0019: ldarg.0
IL_001a: ldarg.0
IL_001b: ldfld System.Single TheForestOfLove.PlantQuestMinigameController::totalSeconds
IL_0020: call System.Void TheForestOfLove.PlantQuestMinigameController::set_currentSeconds(System.Single)
IL_0025: ldarg.0
IL_0026: ldc.i4.0
IL_0027: call System.Void TheForestOfLove.PlantQuestMinigameController::set_pauseMinigame(System.Boolean)
IL_002c: ldarg.0
IL_002d: ldc.i4.1
IL_002e: call System.Void TheForestOfLove.PlantQuestMinigameController::set_showInstructions(System.Boolean)
IL_0033: ldarg.0
IL_0034: ldarg.0
IL_0035: ldfld System.Int32 TheForestOfLove.PlantQuestMinigameController::maxDashes
IL_003a: call System.Void TheForestOfLove.PlantQuestMinigameController::set_currentDashes(System.Int32)
IL_003f: ldarg.0
IL_0040: ldarg.0
IL_0041: ldfld System.Single TheForestOfLove.PlantQuestMinigameController::dashCooldownSeconds
IL_0046: stfld System.Single TheForestOfLove.PlantQuestMinigameController::currentDashCooldownSeconds
IL_004b: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onCutsceneStart
IL_0050: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_0055: ret
