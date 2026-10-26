TYPE TheForestOfLove.Narrative.NarrativeActions
METHOD System.Void TheForestOfLove.Narrative.NarrativeActions::CompleteQuest(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call TheForestOfLove.Narrative.Quest TheForestOfLove.Services.Persistence.DataService::GetQuestByDbName(System.String)
IL_0006: call System.Void TheForestOfLove.Narrative.NarrativeActions::CompleteQuest(TheForestOfLove.Narrative.Quest)
IL_000b: ret
METHOD System.Void TheForestOfLove.Narrative.NarrativeActions::CompleteQuest(TheForestOfLove.Narrative.Quest) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: callvirt System.Void TheForestOfLove.Narrative.Quest::SetStatusCompleted()
IL_0006: ldsfld TheForestOfLove.Events.QuestEvent TheForestOfLove.Events.GameEvents::onQuestLogUpdated
IL_000b: ldarg.0
IL_000c: callvirt System.Void UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Quest>::Invoke(!0)
IL_0011: ret
METHOD System.Void TheForestOfLove.Narrative.NarrativeActions::ActivateTrigger(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call TheForestOfLove.Narrative.Trigger TheForestOfLove.Services.Persistence.DataService::GetTriggerByName(System.String)
IL_0006: stloc.0
IL_0007: ldloc.0
IL_0008: brtrue.s IL_0011
IL_000a: ldarg.0
IL_000b: call TheForestOfLove.Narrative.Trigger TheForestOfLove.Services.Persistence.DataService::CreateTriggerOnTheFly(System.String)
IL_0010: stloc.0
IL_0011: ldloc.0
IL_0012: callvirt System.Void TheForestOfLove.Narrative.Trigger::ActivateTrigger()
IL_0017: ret
