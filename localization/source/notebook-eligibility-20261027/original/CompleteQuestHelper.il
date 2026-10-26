TYPE TheForestOfLove.QuestTriggerHelper
METHOD System.Void TheForestOfLove.QuestTriggerHelper::CompleteQuest(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call TheForestOfLove.Narrative.Quest TheForestOfLove.Services.Persistence.DataService::GetQuestByDbName(System.String)
IL_0006: stloc.0
IL_0007: newobj System.Void TheForestOfLove.Narrative.DialogueTriggers.DialogueTriggerCompleteQuest::.ctor()
IL_000c: dup
IL_000d: ldloc.0
IL_000e: stfld TheForestOfLove.Narrative.Quest TheForestOfLove.Narrative.DialogueTriggers.DialogueTriggerCompleteQuest::targetQuest
IL_0013: callvirt System.Void TheForestOfLove.Narrative.DialogueTriggers.DialogueTrigger::Execute()
IL_0018: ret
