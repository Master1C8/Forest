TYPE TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct3
METHOD System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct3::OnCollectedAllTheFlyingPages_StormQuest() | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldsfld System.Boolean Globals::isChapterSelect
IL_0005: brtrue.s IL_000e
IL_0007: ldsfld System.Boolean Globals::isCheatCode
IL_000c: brfalse.s IL_000f
IL_000e: ret
IL_000f: ldstr "StormQuest_BuckyMinigame"
IL_0014: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_0019: brfalse.s IL_0068
IL_001b: ldstr "StormQuest_MabelIntoTheStorm"
IL_0020: stsfld System.String TheForestOfLove.QuestConversationHelper::targetConversationName
IL_0025: ldstr "Mabel"
IL_002a: stsfld System.String TheForestOfLove.QuestConversationHelper::targetActorName
IL_002f: ldstr "stormquest_page_minigame_none_left"
IL_0034: stsfld System.String TheForestOfLove.QuestConversationHelper::targetDialogueArcName
IL_0039: call System.Void TheForestOfLove.QuestConversationHelper::StartConversation()
IL_003e: ldsfld System.Action TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct3/<>c::<>9__16_0
IL_0043: dup
IL_0044: brtrue.s IL_005d
IL_0046: pop
IL_0047: ldsfld TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct3/<>c TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct3/<>c::<>9
IL_004c: ldftn System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct3/<>c::<OnCollectedAllTheFlyingPages_StormQuest>b__16_0()
IL_0052: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0057: dup
IL_0058: stsfld System.Action TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct3/<>c::<>9__16_0
IL_005d: stsfld System.Action TheForestOfLove.QuestConversationHelper::onConversationEnd
IL_0062: call System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct3::StormQuest_SpawnStuckPage()
IL_0067: ret
IL_0068: ldstr "Act3_StormQuest_5"
IL_006d: call TheForestOfLove.Narrative.QuestProgressLogEntry TheForestOfLove.Services.Persistence.DataService::GetQuestProgressLogByDbName(System.String)
IL_0072: ldfld System.String TheForestOfLove.Narrative.QuestProgressLogEntry::text
IL_0077: stloc.0
IL_0078: ldstr "Act3_StormQuest_2"
IL_007d: call TheForestOfLove.Narrative.QuestProgressLogEntry TheForestOfLove.Services.Persistence.DataService::GetQuestProgressLogByDbName(System.String)
IL_0082: ldfld System.String TheForestOfLove.Narrative.QuestProgressLogEntry::text
IL_0087: stloc.1
IL_0088: call T TheForestOfLove.Services.ServiceLocator::Get<TheForestOfLove.QuestUpdatedUI>()
IL_008d: ldloc.0
IL_008e: ldloc.1
IL_008f: callvirt System.Void TheForestOfLove.QuestUpdatedUI::ShowNotification(System.String,System.String)
IL_0094: ret
