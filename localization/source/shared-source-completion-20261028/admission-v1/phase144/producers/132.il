TYPE TheForestOfLove.PlantQuestMinigameControllerRedux
METHOD System.Void TheForestOfLove.PlantQuestMinigameControllerRedux::StartMinigame() | attributes=Public, HideBySig | impl=IL
IL_0000: ldstr "Act1_PlantQuest"
IL_0005: call TheForestOfLove.Narrative.QuestStatus TheForestOfLove.QuestTriggerHelper::LoadQuestStatus(System.String)
IL_000a: ldc.i4 200
IL_000f: bne.un.s IL_0012
IL_0011: ret
IL_0012: ldarg.0
IL_0013: ldc.r4 1
IL_0018: call System.Void TheForestOfLove.PlantQuestMinigameControllerRedux::UpdateClenchPercent(System.Single)
IL_001d: ldarg.0
IL_001e: ldc.r4 1
IL_0023: call System.Void TheForestOfLove.PlantQuestMinigameControllerRedux::UpdateCumPercent(System.Single)
IL_0028: ldc.i4.1
IL_0029: call System.Void TheForestOfLove.PlantQuestMinigameControllerRedux::set_minigameActive(System.Boolean)
IL_002e: ldarg.0
IL_002f: ldc.i4.0
IL_0030: call System.Void TheForestOfLove.PlantQuestMinigameControllerRedux::set_pauseMinigame(System.Boolean)
IL_0035: ldarg.0
IL_0036: ldc.i4.1
IL_0037: call System.Void TheForestOfLove.PlantQuestMinigameControllerRedux::set_showInstructions(System.Boolean)
IL_003c: ldc.i4.0
IL_003d: stsfld System.Boolean TheForestOfLove.PlantQuestMinigameControllerRedux::playedMouseConvoOnceThisSession
IL_0042: ldarg.0
IL_0043: call System.Void TheForestOfLove.PlantQuestMinigameControllerRedux::CheckHandsFreeCheat()
IL_0048: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onCutsceneStart
IL_004d: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_0052: call System.Void TheForestOfLove.Content.DeepWoodsLongPathSpawner::OnPlantQuestMinigameStarted()
IL_0057: ret
