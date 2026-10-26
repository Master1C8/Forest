TYPE TheForestOfLove.Narrative.DialogueTriggers.DialogueTriggerStartQuest
METHOD System.Void TheForestOfLove.Narrative.DialogueTriggers.DialogueTriggerStartQuest::OnExecute() | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.Narrative.Quest TheForestOfLove.Narrative.DialogueTriggers.DialogueTriggerStartQuest::targetQuest
IL_0006: call System.Void TheForestOfLove.Narrative.NarrativeActions::StartQuest(TheForestOfLove.Narrative.Quest)
IL_000b: ret
