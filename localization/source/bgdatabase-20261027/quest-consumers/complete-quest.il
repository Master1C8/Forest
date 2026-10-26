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
