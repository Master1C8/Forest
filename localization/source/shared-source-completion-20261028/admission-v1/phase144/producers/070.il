TYPE TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct3
METHOD System.Collections.Generic.HashSet`1<System.String> TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct3::get_triggerFilters() | attributes=Public, Virtual, HideBySig, SpecialName | impl=IL
IL_0000: newobj System.Void System.Collections.Generic.HashSet`1<System.String>::.ctor()
IL_0005: dup
IL_0006: ldstr "Act3_"
IL_000b: callvirt System.Boolean System.Collections.Generic.HashSet`1<System.String>::Add(!0)
IL_0010: pop
IL_0011: dup
IL_0012: ldstr "FinleyQuest_"
IL_0017: callvirt System.Boolean System.Collections.Generic.HashSet`1<System.String>::Add(!0)
IL_001c: pop
IL_001d: dup
IL_001e: ldstr "CookieQuest_"
IL_0023: callvirt System.Boolean System.Collections.Generic.HashSet`1<System.String>::Add(!0)
IL_0028: pop
IL_0029: dup
IL_002a: ldstr "MelodyQuest_"
IL_002f: callvirt System.Boolean System.Collections.Generic.HashSet`1<System.String>::Add(!0)
IL_0034: pop
IL_0035: dup
IL_0036: ldstr "CharlotteSocialQuest_"
IL_003b: callvirt System.Boolean System.Collections.Generic.HashSet`1<System.String>::Add(!0)
IL_0040: pop
IL_0041: dup
IL_0042: ldstr "StormQuest_"
IL_0047: callvirt System.Boolean System.Collections.Generic.HashSet`1<System.String>::Add(!0)
IL_004c: pop
IL_004d: dup
IL_004e: ldstr "Examinables_Ottershop_BackRoom"
IL_0053: callvirt System.Boolean System.Collections.Generic.HashSet`1<System.String>::Add(!0)
IL_0058: pop
IL_0059: dup
IL_005a: ldstr "Examinables_Centralforest_OtterShopBackDoor"
IL_005f: callvirt System.Boolean System.Collections.Generic.HashSet`1<System.String>::Add(!0)
IL_0064: pop
IL_0065: dup
IL_0066: ldstr "Movies_MabelRascalAfterTheStorm_Dialogue"
IL_006b: callvirt System.Boolean System.Collections.Generic.HashSet`1<System.String>::Add(!0)
IL_0070: pop
IL_0071: dup
IL_0072: ldstr "AfterstormQuest_"
IL_0077: callvirt System.Boolean System.Collections.Generic.HashSet`1<System.String>::Add(!0)
IL_007c: pop
IL_007d: dup
IL_007e: ldstr "LightQuest_"
IL_0083: callvirt System.Boolean System.Collections.Generic.HashSet`1<System.String>::Add(!0)
IL_0088: pop
IL_0089: dup
IL_008a: ldstr "MouseQuest_"
IL_008f: callvirt System.Boolean System.Collections.Generic.HashSet`1<System.String>::Add(!0)
IL_0094: pop
IL_0095: dup
IL_0096: ldstr "WolfQuest_"
IL_009b: callvirt System.Boolean System.Collections.Generic.HashSet`1<System.String>::Add(!0)
IL_00a0: pop
IL_00a1: dup
IL_00a2: ldstr "Movies_MouseOrgyMovie_Dialogue"
IL_00a7: callvirt System.Boolean System.Collections.Generic.HashSet`1<System.String>::Add(!0)
IL_00ac: pop
IL_00ad: ret
METHOD System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct3::OnExitingDoorway(System.String) | attributes=Private, HideBySig | impl=IL
IL_0000: ldsfld System.Boolean Globals::isChapterSelect
IL_0005: brtrue.s IL_000e
IL_0007: ldsfld System.Boolean Globals::isCheatCode
IL_000c: brfalse.s IL_000f
IL_000e: ret
IL_000f: ldstr "ForestMouse_Amorous"
IL_0014: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsActorIntroduced(System.String)
IL_0019: brtrue.s IL_002c
IL_001b: ldc.i4.1
IL_001c: stsfld System.Boolean Globals::isCheatCode
IL_0021: call System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct3::IntroduceForestMice()
IL_0026: ldc.i4.0
IL_0027: stsfld System.Boolean Globals::isCheatCode
IL_002c: ret
METHOD System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct3::StormQuest_OnFinishedMabelRascalMovie() | attributes=Private, Static, HideBySig | impl=IL
IL_0000: call System.Void TheForestOfLove.CutsceneManager::ConstantBlack()
IL_0005: ldstr "CentralForest"
IL_000a: ldstr "act3_stormquest_afterthestorm"
IL_000f: ldloca.s V_0
IL_0011: initobj System.Nullable`1<TheForestOfLove.Direction>
IL_0017: ldloc.0
IL_0018: call System.Void TheForestOfLove.SpawnManager::ReplaceSpawnData(System.String,System.String,System.Nullable`1<TheForestOfLove.Direction>)
IL_001d: ldstr "CentralForest"
IL_0022: call System.Void TheForestOfLove.Services.SceneManagement.SceneHelper::LoadScene(System.String)
IL_0027: ret
METHOD System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct3::SetTotalFirefliesCollected(System.Int32) | attributes=Private, Static, HideBySig | impl=IL
IL_0000: ldstr "act3_fireflies_total_collected"
IL_0005: ldarga.s number
IL_0007: call System.String System.Int32::ToString()
IL_000c: call System.Void TheForestOfLove.Services.Persistence.DataService::SetVariable(System.String,System.String)
IL_0011: ret
METHOD System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct3::OnCollectedFirefly() | attributes=Public, Static, HideBySig | impl=IL
IL_0000: call System.Int32 TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct3::GetTotalFirefliesCollected()
IL_0005: stloc.0
IL_0006: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onCutsceneStart
IL_000b: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_0010: ldloc.0
IL_0011: switch IL_0048,IL_008d,IL_00bf,IL_00f1,IL_0139,IL_0168
IL_002e: ldstr "unexpected number of fireflies collected! ({0}) please report a bug!"
IL_0033: ldloc.0
IL_0034: box System.Int32
IL_0039: call System.String System.String::Format(System.String,System.Object)
IL_003e: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_0043: br IL_01bc
IL_0048: ldc.i4.1
IL_0049: stsfld System.Boolean Globals::isCheatCode
IL_004e: ldc.i4.s 120
IL_0050: call System.Void TheForestOfLove.Narrative.NarrativeActions::ConsumeInventoryItem(TheForestOfLove.Inventory.InventoryItemType)
IL_0055: ldc.i4.0
IL_0056: stsfld System.Boolean Globals::isCheatCode
IL_005b: ldc.i4 430
IL_0060: call System.Void TheForestOfLove.Narrative.NarrativeActions::AddInventoryItem(TheForestOfLove.Inventory.InventoryItemType)
IL_0065: ldstr "LightQuest_CollectingFireflies"
IL_006a: stsfld System.String TheForestOfLove.QuestConversationHelper::targetConversationName
IL_006f: ldstr "Mabel"
IL_0074: stsfld System.String TheForestOfLove.QuestConversationHelper::targetActorName
IL_0079: ldstr "fireflies_collected_1"
IL_007e: stsfld System.String TheForestOfLove.QuestConversationHelper::targetDialogueArcName
IL_0083: call System.Void TheForestOfLove.QuestConversationHelper::StartConversation()
IL_0088: br IL_01bc
IL_008d: ldc.i4 430
IL_0092: call System.Void TheForestOfLove.Narrative.NarrativeActions::AddInventoryItem(TheForestOfLove.Inventory.InventoryItemType)
IL_0097: ldstr "LightQuest_CollectingFireflies"
IL_009c: stsfld System.String TheForestOfLove.QuestConversationHelper::targetConversationName
IL_00a1: ldstr "Mabel"
IL_00a6: stsfld System.String TheForestOfLove.QuestConversationHelper::targetActorName
IL_00ab: ldstr "fireflies_collected_2"
IL_00b0: stsfld System.String TheForestOfLove.QuestConversationHelper::targetDialogueArcName
IL_00b5: call System.Void TheForestOfLove.QuestConversationHelper::StartConversation()
IL_00ba: br IL_01bc
IL_00bf: ldc.i4 430
IL_00c4: call System.Void TheForestOfLove.Narrative.NarrativeActions::AddInventoryItem(TheForestOfLove.Inventory.InventoryItemType)
IL_00c9: ldstr "LightQuest_CollectingFireflies"
IL_00ce: stsfld System.String TheForestOfLove.QuestConversationHelper::targetConversationName
IL_00d3: ldstr "Mabel"
IL_00d8: stsfld System.String TheForestOfLove.QuestConversationHelper::targetActorName
IL_00dd: ldstr "fireflies_collected_3"
IL_00e2: stsfld System.String TheForestOfLove.QuestConversationHelper::targetDialogueArcName
IL_00e7: call System.Void TheForestOfLove.QuestConversationHelper::StartConversation()
IL_00ec: br IL_01bc
IL_00f1: ldc.i4.1
IL_00f2: stsfld System.Boolean Globals::isCheatCode
IL_00f7: ldc.i4 430
IL_00fc: call System.Void TheForestOfLove.Narrative.NarrativeActions::ConsumeInventoryItem(TheForestOfLove.Inventory.InventoryItemType)
IL_0101: ldc.i4.0
IL_0102: stsfld System.Boolean Globals::isCheatCode
IL_0107: ldc.i4 435
IL_010c: call System.Void TheForestOfLove.Narrative.NarrativeActions::AddInventoryItem(TheForestOfLove.Inventory.InventoryItemType)
IL_0111: ldstr "LightQuest_CollectingFireflies"
IL_0116: stsfld System.String TheForestOfLove.QuestConversationHelper::targetConversationName
IL_011b: ldstr "Mabel"
IL_0120: stsfld System.String TheForestOfLove.QuestConversationHelper::targetActorName
IL_0125: ldstr "fireflies_collected_4"
IL_012a: stsfld System.String TheForestOfLove.QuestConversationHelper::targetDialogueArcName
IL_012f: call System.Void TheForestOfLove.QuestConversationHelper::StartConversation()
IL_0134: br IL_01bc
IL_0139: ldc.i4 435
IL_013e: call System.Void TheForestOfLove.Narrative.NarrativeActions::AddInventoryItem(TheForestOfLove.Inventory.InventoryItemType)
IL_0143: ldstr "LightQuest_CollectingFireflies"
IL_0148: stsfld System.String TheForestOfLove.QuestConversationHelper::targetConversationName
IL_014d: ldstr "Mabel"
IL_0152: stsfld System.String TheForestOfLove.QuestConversationHelper::targetActorName
IL_0157: ldstr "fireflies_collected_5"
IL_015c: stsfld System.String TheForestOfLove.QuestConversationHelper::targetDialogueArcName
IL_0161: call System.Void TheForestOfLove.QuestConversationHelper::StartConversation()
IL_0166: br.s IL_01bc
IL_0168: ldc.i4.1
IL_0169: stsfld System.Boolean Globals::isCheatCode
IL_016e: ldc.i4 435
IL_0173: call System.Void TheForestOfLove.Narrative.NarrativeActions::ConsumeInventoryItem(TheForestOfLove.Inventory.InventoryItemType)
IL_0178: ldc.i4.0
IL_0179: stsfld System.Boolean Globals::isCheatCode
IL_017e: ldc.i4 440
IL_0183: call System.Void TheForestOfLove.Narrative.NarrativeActions::AddInventoryItem(TheForestOfLove.Inventory.InventoryItemType)
IL_0188: ldstr "LightQuest_CollectingFireflies"
IL_018d: stsfld System.String TheForestOfLove.QuestConversationHelper::targetConversationName
IL_0192: ldstr "Mabel"
IL_0197: stsfld System.String TheForestOfLove.QuestConversationHelper::targetActorName
IL_019c: ldstr "fireflies_collected_6"
IL_01a1: stsfld System.String TheForestOfLove.QuestConversationHelper::targetDialogueArcName
IL_01a6: ldnull
IL_01a7: ldftn System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct3::ShowLanternTutorial()
IL_01ad: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_01b2: stsfld System.Action TheForestOfLove.QuestConversationHelper::onConversationEnd
IL_01b7: call System.Void TheForestOfLove.QuestConversationHelper::StartConversation()
IL_01bc: ldloc.0
IL_01bd: ldc.i4.1
IL_01be: add
IL_01bf: call System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct3::SetTotalFirefliesCollected(System.Int32)
IL_01c4: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onCutsceneEnd
IL_01c9: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_01ce: ret
METHOD System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct3::WolfQuestSetTotalCrittersAsked(System.Int32) | attributes=Private, Static, HideBySig | impl=IL
IL_0000: ldstr "act3_wolfquest_total_critters_asked"
IL_0005: ldarga.s number
IL_0007: call System.String System.Int32::ToString()
IL_000c: call System.Void TheForestOfLove.Services.Persistence.DataService::SetVariable(System.String,System.String)
IL_0011: ret
