TYPE TheForestOfLove.Narrative.NarrativeActions
METHOD System.Void TheForestOfLove.Narrative.NarrativeActions::LogNewlyEnteredStep(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call TheForestOfLove.Narrative.QuestProgressLogEntry TheForestOfLove.Services.Persistence.DataService::GetQuestProgressLogByDbName(System.String)
IL_0006: call System.Void TheForestOfLove.Narrative.NarrativeActions::LogNewlyEnteredStep(TheForestOfLove.Narrative.QuestProgressLogEntry)
IL_000b: ret
METHOD System.Void TheForestOfLove.Narrative.NarrativeActions::LogNewlyEnteredStep(TheForestOfLove.Narrative.QuestProgressLogEntry) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldc.i4.0
IL_0002: callvirt System.Void TheForestOfLove.Narrative.QuestProgressLogEntry::Unlock(System.Boolean)
IL_0007: ldsfld TheForestOfLove.Events.QuestEvent TheForestOfLove.Events.GameEvents::onQuestLogUpdated
IL_000c: ldarg.0
IL_000d: ldfld TheForestOfLove.Narrative.Quest TheForestOfLove.Narrative.QuestProgressLogEntry::quest
IL_0012: callvirt System.Void UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Quest>::Invoke(!0)
IL_0017: ret
METHOD System.Void TheForestOfLove.Narrative.NarrativeActions::StartQuest(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call TheForestOfLove.Narrative.Quest TheForestOfLove.Services.Persistence.DataService::GetQuestByDbName(System.String)
IL_0006: call System.Void TheForestOfLove.Narrative.NarrativeActions::StartQuest(TheForestOfLove.Narrative.Quest)
IL_000b: ret
METHOD System.Void TheForestOfLove.Narrative.NarrativeActions::StartQuest(TheForestOfLove.Narrative.Quest) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: callvirt System.Void TheForestOfLove.Narrative.Quest::SetStatusStarted()
IL_0006: ldarg.0
IL_0007: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.QuestProgressLogEntry> TheForestOfLove.Narrative.Quest::progressLogEntries
IL_000c: callvirt System.Int32 System.Collections.Generic.List`1<TheForestOfLove.Narrative.QuestProgressLogEntry>::get_Count()
IL_0011: ldc.i4.0
IL_0012: ble.s IL_0026
IL_0014: ldarg.0
IL_0015: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.QuestProgressLogEntry> TheForestOfLove.Narrative.Quest::progressLogEntries
IL_001a: ldc.i4.0
IL_001b: callvirt !0 System.Collections.Generic.List`1<TheForestOfLove.Narrative.QuestProgressLogEntry>::get_Item(System.Int32)
IL_0020: ldc.i4.1
IL_0021: callvirt System.Void TheForestOfLove.Narrative.QuestProgressLogEntry::Unlock(System.Boolean)
IL_0026: ret
