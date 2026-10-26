TYPE TheForestOfLove.QuestTriggerHelper
METHOD System.Boolean TheForestOfLove.QuestTriggerHelper::PlayerLearnedNotebook() | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldstr "notebook_unlocked"
IL_0005: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsTriggerSet(System.String)
IL_000a: ret
