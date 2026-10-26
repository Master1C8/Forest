TYPE TheForestOfLove.Narrative.DialogueTriggers.DialogueTriggerCompleteQuest
METHOD System.Void TheForestOfLove.Narrative.DialogueTriggers.DialogueTriggerCompleteQuest::OnExecute() | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.Narrative.Quest TheForestOfLove.Narrative.DialogueTriggers.DialogueTriggerCompleteQuest::targetQuest
IL_0006: call System.Void TheForestOfLove.Narrative.NarrativeActions::CompleteQuest(TheForestOfLove.Narrative.Quest)
IL_000b: ret
