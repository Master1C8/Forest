TYPE TheForestOfLove.Events.TriggerHandlers.TriggerHandlerDustinDashChallenge
METHOD System.Collections.Generic.HashSet`1<System.String> TheForestOfLove.Events.TriggerHandlers.TriggerHandlerDustinDashChallenge::get_triggerFilters() | attributes=Public, Virtual, HideBySig, SpecialName | impl=IL
IL_0000: newobj System.Void System.Collections.Generic.HashSet`1<System.String>::.ctor()
IL_0005: dup
IL_0006: ldstr "DustinBattleground"
IL_000b: callvirt System.Boolean System.Collections.Generic.HashSet`1<System.String>::Add(!0)
IL_0010: pop
IL_0011: ret
METHOD System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerDustinDashChallenge::ExecuteTrigger(System.String) | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: ldstr "dustin_minigame_unlocked"
IL_0006: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_000b: brfalse.s IL_0033
IL_000d: ldarg.0
IL_000e: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_0013: brtrue.s IL_001d
IL_0015: ldarg.0
IL_0016: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_001b: brfalse.s IL_001e
IL_001d: ret
IL_001e: call T TheForestOfLove.Services.ServiceLocator::Get<TheForestOfLove.ItemGetNotification>()
IL_0023: stloc.0
IL_0024: ldloc.0
IL_0025: ldnull
IL_0026: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_002b: brfalse.s IL_0033
IL_002d: ldloc.0
IL_002e: callvirt System.Void TheForestOfLove.ItemGetNotification::ShowDustinMinigameUnlockedNotification()
IL_0033: ldarg.1
IL_0034: ldstr "dustin_minigame_started"
IL_0039: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_003e: brfalse.s IL_008a
IL_0040: ldarg.0
IL_0041: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_0046: brtrue.s IL_0050
IL_0048: ldarg.0
IL_0049: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_004e: brfalse.s IL_0051
IL_0050: ret
IL_0051: ldc.i4.0
IL_0052: stsfld System.Boolean TheForestOfLove.DustinMinigameController::IsNoviceMode
IL_0057: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onCutsceneStart
IL_005c: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_0061: ldc.r4 2
IL_0066: ldsfld UnityEngine.Events.UnityAction TheForestOfLove.Events.TriggerHandlers.TriggerHandlerDustinDashChallenge/<>c::<>9__2_0
IL_006b: dup
IL_006c: brtrue.s IL_0085
IL_006e: pop
IL_006f: ldsfld TheForestOfLove.Events.TriggerHandlers.TriggerHandlerDustinDashChallenge/<>c TheForestOfLove.Events.TriggerHandlers.TriggerHandlerDustinDashChallenge/<>c::<>9
IL_0074: ldftn System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerDustinDashChallenge/<>c::<ExecuteTrigger>b__2_0()
IL_007a: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_007f: dup
IL_0080: stsfld UnityEngine.Events.UnityAction TheForestOfLove.Events.TriggerHandlers.TriggerHandlerDustinDashChallenge/<>c::<>9__2_0
IL_0085: call System.Void TheForestOfLove.CutsceneManager::FadeToBlack(System.Single,UnityEngine.Events.UnityAction)
IL_008a: ldarg.1
IL_008b: ldstr "check_dustin_minigame_novice"
IL_0090: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0095: brfalse.s IL_00b7
IL_0097: ldarg.0
IL_0098: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_009d: brtrue.s IL_00a7
IL_009f: ldarg.0
IL_00a0: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_00a5: brfalse.s IL_00a8
IL_00a7: ret
IL_00a8: ldstr "dustin_minigame_started_novice"
IL_00ad: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsTriggerSet(System.String)
IL_00b2: call System.Void TheForestOfLove.Narrative.DialogueService::SetDialogueSystemBoolCondition(System.Boolean)
IL_00b7: ldarg.1
IL_00b8: ldstr "dustin_minigame_started_novice"
IL_00bd: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_00c2: brfalse.s IL_010e
IL_00c4: ldarg.0
IL_00c5: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_00ca: brtrue.s IL_00d4
IL_00cc: ldarg.0
IL_00cd: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_00d2: brfalse.s IL_00d5
IL_00d4: ret
IL_00d5: ldc.i4.1
IL_00d6: stsfld System.Boolean TheForestOfLove.DustinMinigameController::IsNoviceMode
IL_00db: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onCutsceneStart
IL_00e0: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_00e5: ldc.r4 2
IL_00ea: ldsfld UnityEngine.Events.UnityAction TheForestOfLove.Events.TriggerHandlers.TriggerHandlerDustinDashChallenge/<>c::<>9__2_1
IL_00ef: dup
IL_00f0: brtrue.s IL_0109
IL_00f2: pop
IL_00f3: ldsfld TheForestOfLove.Events.TriggerHandlers.TriggerHandlerDustinDashChallenge/<>c TheForestOfLove.Events.TriggerHandlers.TriggerHandlerDustinDashChallenge/<>c::<>9
IL_00f8: ldftn System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerDustinDashChallenge/<>c::<ExecuteTrigger>b__2_1()
IL_00fe: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0103: dup
IL_0104: stsfld UnityEngine.Events.UnityAction TheForestOfLove.Events.TriggerHandlers.TriggerHandlerDustinDashChallenge/<>c::<>9__2_1
IL_0109: call System.Void TheForestOfLove.CutsceneManager::FadeToBlack(System.Single,UnityEngine.Events.UnityAction)
IL_010e: ldarg.1
IL_010f: ldstr "dustin_minigame_beat_training"
IL_0114: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0119: brfalse.s IL_0172
IL_011b: ldarg.0
IL_011c: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_0121: brtrue.s IL_012b
IL_0123: ldarg.0
IL_0124: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_0129: brfalse.s IL_012c
IL_012b: ret
IL_012c: ldstr "DeliveryQuest_DeliverShovel"
IL_0131: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_0136: brfalse.s IL_014b
IL_0138: ldstr "CoyoteQuest_FinishShearingFinley"
IL_013d: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_0142: brfalse.s IL_014b
IL_0144: call System.Boolean TheForestOfLove.QuestTriggerHelper::FinishedAct2()
IL_0149: br.s IL_014c
IL_014b: ldc.i4.0
IL_014c: stloc.1
IL_014d: ldsfld TheForestOfLove.Content.CentralForestSpawner TheForestOfLove.Content.CentralForestSpawner::instance
IL_0152: ldnull
IL_0153: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0158: ldloc.1
IL_0159: and
IL_015a: brfalse.s IL_0172
IL_015c: ldsfld TheForestOfLove.Content.CentralForestSpawner TheForestOfLove.Content.CentralForestSpawner::instance
IL_0161: callvirt AreaContent TheForestOfLove.Content.CentralForestSpawner::get_Dustin()
IL_0166: ldstr "DustinBattleground6"
IL_016b: ldnull
IL_016c: ldnull
IL_016d: call System.Void TheForestOfLove.Utility.ContentManagementExtensions::SetTargetDialogueInChildren(AreaContent,System.String,System.String,System.String)
IL_0172: ldarg.1
IL_0173: ldstr "show_dustin_minigame_novice_reward"
IL_0178: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_017d: brfalse.s IL_0187
IL_017f: ldc.i4.s 26
IL_0181: ldnull
IL_0182: call System.Void TheForestOfLove.QuestTriggerHandler::PlayMovie(TheForestOfLove.Narrative.Movie,UnityEngine.Events.UnityAction)
IL_0187: ldarg.1
IL_0188: ldstr "show_dustin_minigame_novice_reward_unlock"
IL_018d: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0192: brfalse.s IL_019c
IL_0194: ldc.i4.s 26
IL_0196: ldnull
IL_0197: call System.Void TheForestOfLove.QuestTriggerHandler::HandleMovieUnlock(TheForestOfLove.Narrative.Movie,UnityEngine.Events.UnityAction)
IL_019c: ret
