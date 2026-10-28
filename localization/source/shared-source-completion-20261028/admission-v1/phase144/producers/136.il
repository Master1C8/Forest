TYPE TheForestOfLove.QuestLog
METHOD System.Void TheForestOfLove.QuestLog::OnQuestLogUpdated(TheForestOfLove.Narrative.Quest) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: ldfld System.String TheForestOfLove.Narrative.Quest::dbName
IL_0006: ldstr "Act1_GreetingsQuest"
IL_000b: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0010: brfalse.s IL_001f
IL_0012: ldstr "Act1_GreetingsQuest"
IL_0017: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsQuestUnstarted(System.String)
IL_001c: brfalse.s IL_001f
IL_001e: ret
IL_001f: ldarg.1
IL_0020: ldfld System.String TheForestOfLove.Narrative.Quest::dbName
IL_0025: ldstr "Act1_GreetingsQuest"
IL_002a: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_002f: brfalse IL_013a
IL_0034: call System.Boolean TheForestOfLove.Narrative.DialogueService::get_IsDialoguePlaying()
IL_0039: brtrue.s IL_003e
IL_003b: ldnull
IL_003c: br.s IL_0048
IL_003e: call System.String TheForestOfLove.Narrative.DialogueService::get_CurrentDialogueDbName()
IL_0043: callvirt System.String System.String::ToLower()
IL_0048: stloc.s V_6
IL_004a: ldsfld System.Boolean Globals::isChapterSelect
IL_004f: brtrue.s IL_005c
IL_0051: ldsfld System.Boolean Globals::isCheatCode
IL_0056: brtrue.s IL_005c
IL_0058: ldloc.s V_6
IL_005a: br.s IL_0066
IL_005c: ldsfld System.String Globals::chapterSelectCurrentDialogueDbName
IL_0061: callvirt System.String System.String::ToLower()
IL_0066: stloc.s V_6
IL_0068: ldloc.s V_6
IL_006a: brtrue.s IL_006d
IL_006c: ret
IL_006d: call T TheForestOfLove.Services.ServiceLocator::Get<TheForestOfLove.QuestUpdatedUI>()
IL_0072: stloc.s V_7
IL_0074: ldstr "Penny"
IL_0079: call TheForestOfLove.Narrative.Actor TheForestOfLove.Services.Persistence.DataService::GetActorByDbName(System.String)
IL_007e: callvirt System.Boolean TheForestOfLove.Narrative.Actor::get_IsIntroduced()
IL_0083: brfalse.s IL_00b8
IL_0085: ldstr "Dustin"
IL_008a: call TheForestOfLove.Narrative.Actor TheForestOfLove.Services.Persistence.DataService::GetActorByDbName(System.String)
IL_008f: callvirt System.Boolean TheForestOfLove.Narrative.Actor::get_IsIntroduced()
IL_0094: brfalse.s IL_00b8
IL_0096: ldstr "Finley"
IL_009b: call TheForestOfLove.Narrative.Actor TheForestOfLove.Services.Persistence.DataService::GetActorByDbName(System.String)
IL_00a0: callvirt System.Boolean TheForestOfLove.Narrative.Actor::get_IsIntroduced()
IL_00a5: brfalse.s IL_00b8
IL_00a7: ldstr "Augustus"
IL_00ac: call TheForestOfLove.Narrative.Actor TheForestOfLove.Services.Persistence.DataService::GetActorByDbName(System.String)
IL_00b1: callvirt System.Boolean TheForestOfLove.Narrative.Actor::get_IsEncounteredOnce()
IL_00b6: br.s IL_00b9
IL_00b8: ldc.i4.0
IL_00b9: brtrue.s IL_00c2
IL_00bb: ldstr "Say hi to all four of the critters."
IL_00c0: br.s IL_00c7
IL_00c2: ldstr "[Quest Completed]"
IL_00c7: stloc.s V_8
IL_00c9: ldloc.s V_6
IL_00cb: ldstr "gator"
IL_00d0: callvirt System.Boolean System.String::Contains(System.String)
IL_00d5: brfalse.s IL_00e5
IL_00d7: ldloc.s V_7
IL_00d9: ldstr "Meet Augustus."
IL_00de: ldloc.s V_8
IL_00e0: callvirt System.Void TheForestOfLove.QuestUpdatedUI::ShowNotification(System.String,System.String)
IL_00e5: ldloc.s V_6
IL_00e7: ldstr "bird"
IL_00ec: callvirt System.Boolean System.String::Contains(System.String)
IL_00f1: brfalse.s IL_0101
IL_00f3: ldloc.s V_7
IL_00f5: ldstr "Meet Penny."
IL_00fa: ldloc.s V_8
IL_00fc: callvirt System.Void TheForestOfLove.QuestUpdatedUI::ShowNotification(System.String,System.String)
IL_0101: ldloc.s V_6
IL_0103: ldstr "dash"
IL_0108: callvirt System.Boolean System.String::Contains(System.String)
IL_010d: brfalse.s IL_011d
IL_010f: ldloc.s V_7
IL_0111: ldstr "Meet Dustin."
IL_0116: ldloc.s V_8
IL_0118: callvirt System.Void TheForestOfLove.QuestUpdatedUI::ShowNotification(System.String,System.String)
IL_011d: ldloc.s V_6
IL_011f: ldstr "introduction"
IL_0124: callvirt System.Boolean System.String::Contains(System.String)
IL_0129: brfalse.s IL_0139
IL_012b: ldloc.s V_7
IL_012d: ldstr "Meet Finley."
IL_0132: ldloc.s V_8
IL_0134: callvirt System.Void TheForestOfLove.QuestUpdatedUI::ShowNotification(System.String,System.String)
IL_0139: ret
IL_013a: ldarg.1
IL_013b: ldfld System.String TheForestOfLove.Narrative.Quest::dbName
IL_0140: ldstr "Act3_StormQuest"
IL_0145: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_014a: brfalse IL_030b
IL_014f: call System.Boolean TheForestOfLove.Narrative.DialogueService::get_IsDialoguePlaying()
IL_0154: brtrue.s IL_0159
IL_0156: ldnull
IL_0157: br.s IL_0163
IL_0159: call System.String TheForestOfLove.Narrative.DialogueService::get_CurrentDialogueDbName()
IL_015e: callvirt System.String System.String::ToLower()
IL_0163: stloc.s V_9
IL_0165: ldsfld System.Boolean Globals::isChapterSelect
IL_016a: brtrue.s IL_0177
IL_016c: ldsfld System.Boolean Globals::isCheatCode
IL_0171: brtrue.s IL_0177
IL_0173: ldloc.s V_9
IL_0175: br.s IL_0181
IL_0177: ldsfld System.String Globals::chapterSelectCurrentDialogueDbName
IL_017c: callvirt System.String System.String::ToLower()
IL_0181: stloc.s V_9
IL_0183: ldloc.s V_9
IL_0185: brtrue.s IL_0188
IL_0187: ret
IL_0188: call T TheForestOfLove.Services.ServiceLocator::Get<TheForestOfLove.QuestUpdatedUI>()
IL_018d: stloc.s V_10
IL_018f: ldstr "Act3_StormQuest"
IL_0194: call TheForestOfLove.Narrative.QuestStatus TheForestOfLove.QuestTriggerHelper::LoadQuestStatus(System.String)
IL_0199: ldc.i4 200
IL_019e: ceq
IL_01a0: stloc.s V_11
IL_01a2: ldloc.s V_11
IL_01a4: brfalse.s IL_01a7
IL_01a6: ret
IL_01a7: ldloc.s V_11
IL_01a9: brtrue.s IL_01bc
IL_01ab: ldstr "Act3_StormQuest_2"
IL_01b0: call TheForestOfLove.Narrative.QuestProgressLogEntry TheForestOfLove.Services.Persistence.DataService::GetQuestProgressLogByDbName(System.String)
IL_01b5: ldfld System.String TheForestOfLove.Narrative.QuestProgressLogEntry::text
IL_01ba: br.s IL_01c1
IL_01bc: ldstr "[Quest Completed]"
IL_01c1: stloc.s V_12
IL_01c3: ldstr "Act3_StormQuest_1"
IL_01c8: call TheForestOfLove.Narrative.QuestProgressLogEntry TheForestOfLove.Services.Persistence.DataService::GetQuestProgressLogByDbName(System.String)
IL_01cd: ldfld System.String TheForestOfLove.Narrative.QuestProgressLogEntry::text
IL_01d2: stloc.s V_13
IL_01d4: ldstr "Act3_StormQuest_3"
IL_01d9: call TheForestOfLove.Narrative.QuestProgressLogEntry TheForestOfLove.Services.Persistence.DataService::GetQuestProgressLogByDbName(System.String)
IL_01de: ldfld System.String TheForestOfLove.Narrative.QuestProgressLogEntry::text
IL_01e3: stloc.s V_14
IL_01e5: ldstr "Act3_StormQuest_4"
IL_01ea: call TheForestOfLove.Narrative.QuestProgressLogEntry TheForestOfLove.Services.Persistence.DataService::GetQuestProgressLogByDbName(System.String)
IL_01ef: ldfld System.String TheForestOfLove.Narrative.QuestProgressLogEntry::text
IL_01f4: stloc.s V_15
IL_01f6: ldstr "Act3_StormQuest_5"
IL_01fb: call TheForestOfLove.Narrative.QuestProgressLogEntry TheForestOfLove.Services.Persistence.DataService::GetQuestProgressLogByDbName(System.String)
IL_0200: ldfld System.String TheForestOfLove.Narrative.QuestProgressLogEntry::text
IL_0205: stloc.s V_16
IL_0207: ldc.i4 420
IL_020c: call System.Int32 TheForestOfLove.Narrative.NarrativeActions::GetItemQuantity(TheForestOfLove.Inventory.InventoryItemType)
IL_0211: ldc.i4.7
IL_0212: bne.un.s IL_0231
IL_0214: ldstr "StormQuest_DustinAndBucky"
IL_0219: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_021e: brfalse.s IL_0231
IL_0220: ldstr "Act3_StormQuest_5a"
IL_0225: call TheForestOfLove.Narrative.QuestProgressLogEntry TheForestOfLove.Services.Persistence.DataService::GetQuestProgressLogByDbName(System.String)
IL_022a: ldfld System.String TheForestOfLove.Narrative.QuestProgressLogEntry::text
IL_022f: stloc.s V_16
IL_0231: ldstr "StormQuest_DustinAndBucky"
IL_0236: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_023b: brtrue.s IL_024e
IL_023d: ldstr "Act3_StormQuest_4a"
IL_0242: call TheForestOfLove.Narrative.QuestProgressLogEntry TheForestOfLove.Services.Persistence.DataService::GetQuestProgressLogByDbName(System.String)
IL_0247: ldfld System.String TheForestOfLove.Narrative.QuestProgressLogEntry::text
IL_024c: stloc.s V_15
IL_024e: ldloc.s V_9
IL_0250: ldstr "maverickandmabel"
IL_0255: callvirt System.Boolean System.String::Contains(System.String)
IL_025a: brfalse.s IL_0267
IL_025c: ldloc.s V_10
IL_025e: ldloc.s V_13
IL_0260: ldloc.s V_12
IL_0262: callvirt System.Void TheForestOfLove.QuestUpdatedUI::ShowNotification(System.String,System.String)
IL_0267: ldloc.s V_9
IL_0269: ldstr "intothestorm"
IL_026e: callvirt System.Boolean System.String::Contains(System.String)
IL_0273: brfalse.s IL_0280
IL_0275: ldloc.s V_10
IL_0277: ldloc.s V_13
IL_0279: ldloc.s V_16
IL_027b: callvirt System.Void TheForestOfLove.QuestUpdatedUI::ShowNotification(System.String,System.String)
IL_0280: ldloc.s V_9
IL_0282: ldstr "scarlettandpeter"
IL_0287: callvirt System.Boolean System.String::Contains(System.String)
IL_028c: brfalse.s IL_0299
IL_028e: ldloc.s V_10
IL_0290: ldloc.s V_14
IL_0292: ldloc.s V_12
IL_0294: callvirt System.Void TheForestOfLove.QuestUpdatedUI::ShowNotification(System.String,System.String)
IL_0299: ldloc.s V_9
IL_029b: ldstr "buckyminigame"
IL_02a0: callvirt System.Boolean System.String::Contains(System.String)
IL_02a5: brfalse.s IL_02ee
IL_02a7: ldc.i4 420
IL_02ac: call System.Int32 TheForestOfLove.Narrative.NarrativeActions::GetItemQuantity(TheForestOfLove.Inventory.InventoryItemType)
IL_02b1: ldc.i4.7
IL_02b2: bge.s IL_02c5
IL_02b4: ldstr "Act3_StormQuest_5"
IL_02b9: call TheForestOfLove.Narrative.QuestProgressLogEntry TheForestOfLove.Services.Persistence.DataService::GetQuestProgressLogByDbName(System.String)
IL_02be: ldfld System.String TheForestOfLove.Narrative.QuestProgressLogEntry::text
IL_02c3: stloc.s V_12
IL_02c5: ldc.i4 420
IL_02ca: call System.Int32 TheForestOfLove.Narrative.NarrativeActions::GetItemQuantity(TheForestOfLove.Inventory.InventoryItemType)
IL_02cf: ldc.i4.7
IL_02d0: blt.s IL_02e3
IL_02d2: ldstr "Act3_StormQuest_5a"
IL_02d7: call TheForestOfLove.Narrative.QuestProgressLogEntry TheForestOfLove.Services.Persistence.DataService::GetQuestProgressLogByDbName(System.String)
IL_02dc: ldfld System.String TheForestOfLove.Narrative.QuestProgressLogEntry::text
IL_02e1: stloc.s V_12
IL_02e3: ldloc.s V_10
IL_02e5: ldloc.s V_15
IL_02e7: ldloc.s V_12
IL_02e9: callvirt System.Void TheForestOfLove.QuestUpdatedUI::ShowNotification(System.String,System.String)
IL_02ee: ldloc.s V_9
IL_02f0: ldstr "lastpage"
IL_02f5: callvirt System.Boolean System.String::Contains(System.String)
IL_02fa: brfalse.s IL_030a
IL_02fc: ldloc.s V_10
IL_02fe: ldloc.s V_16
IL_0300: ldstr "Quest Completed!"
IL_0305: callvirt System.Void TheForestOfLove.QuestUpdatedUI::ShowNotification(System.String,System.String)
IL_030a: ret
IL_030b: ldarg.1
IL_030c: brfalse.s IL_0316
IL_030e: ldarg.1
IL_030f: ldfld System.Boolean TheForestOfLove.Narrative.Quest::isHiddenInQuestLog
IL_0314: brfalse.s IL_0317
IL_0316: ret
IL_0317: ldnull
IL_0318: stloc.0
IL_0319: ldnull
IL_031a: stloc.1
IL_031b: ldnull
IL_031c: stloc.2
IL_031d: ldarg.1
IL_031e: ldloca.s V_2
IL_0320: ldloca.s V_1
IL_0322: ldloca.s V_0
IL_0324: call System.Void TheForestOfLove.QuestLog::GenerateLogTextHistory(TheForestOfLove.Narrative.Quest,System.String&,System.String&,System.String&)
IL_0329: ldarg.1
IL_032a: callvirt TheForestOfLove.Narrative.QuestStatus TheForestOfLove.Narrative.Quest::get_status()
IL_032f: ldc.i4 200
IL_0334: bne.un.s IL_0340
IL_0336: ldloc.1
IL_0337: stloc.0
IL_0338: ldloc.2
IL_0339: stloc.1
IL_033a: ldstr "Quest Completed!"
IL_033f: stloc.2
IL_0340: ldsfld System.String System.String::Empty
IL_0345: stloc.3
IL_0346: ldloc.2
IL_0347: dup
IL_0348: brtrue.s IL_0350
IL_034a: pop
IL_034b: ldsfld System.String System.String::Empty
IL_0350: stloc.s V_4
IL_0352: ldloc.1
IL_0353: dup
IL_0354: brtrue.s IL_0358
IL_0356: pop
IL_0357: ldloc.3
IL_0358: stloc.s V_5
IL_035a: ldloc.0
IL_035b: pop
IL_035c: ldsfld System.Boolean Globals::isChapterSelect
IL_0361: brtrue.s IL_0378
IL_0363: ldsfld System.Boolean Globals::isCheatCode
IL_0368: brtrue.s IL_0378
IL_036a: call !!0 UnityEngine.Object::FindObjectOfType<TheForestOfLove.QuestUpdatedUI>()
IL_036f: ldloc.s V_5
IL_0371: ldloc.s V_4
IL_0373: callvirt System.Void TheForestOfLove.QuestUpdatedUI::ShowNotification(System.String,System.String)
IL_0378: ret
