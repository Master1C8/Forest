TYPE TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct3/<>c
METHOD System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct3/<>c::<OnCollectedAllTheFlyingPages_StormQuest>b__16_0() | attributes=Assembly, HideBySig | impl=IL
IL_0000: ldstr "Act3_StormQuest_5"
IL_0005: call TheForestOfLove.Narrative.QuestProgressLogEntry TheForestOfLove.Services.Persistence.DataService::GetQuestProgressLogByDbName(System.String)
IL_000a: ldfld System.String TheForestOfLove.Narrative.QuestProgressLogEntry::text
IL_000f: stloc.0
IL_0010: ldstr "Act3_StormQuest_5a"
IL_0015: call TheForestOfLove.Narrative.QuestProgressLogEntry TheForestOfLove.Services.Persistence.DataService::GetQuestProgressLogByDbName(System.String)
IL_001a: ldfld System.String TheForestOfLove.Narrative.QuestProgressLogEntry::text
IL_001f: stloc.1
IL_0020: call T TheForestOfLove.Services.ServiceLocator::Get<TheForestOfLove.QuestUpdatedUI>()
IL_0025: ldloc.0
IL_0026: ldloc.1
IL_0027: callvirt System.Void TheForestOfLove.QuestUpdatedUI::ShowNotification(System.String,System.String)
IL_002c: ret
