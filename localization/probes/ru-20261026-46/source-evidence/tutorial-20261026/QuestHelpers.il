TYPE TheForestOfLove.QuestTriggerHelper
METHOD TheForestOfLove.Narrative.QuestStatus TheForestOfLove.QuestTriggerHelper::LoadQuestStatus(System.String)
IL_0000: ldarg.0
IL_0001: call TheForestOfLove.Narrative.Quest TheForestOfLove.Services.Persistence.DataService::GetQuestByDbName(System.String)
IL_0006: callvirt TheForestOfLove.Narrative.QuestStatus TheForestOfLove.Narrative.Quest::get_status()
IL_000b: ret
METHOD System.Boolean TheForestOfLove.QuestTriggerHelper::PlayerFinishedIntroTutorial()
IL_0000: ldstr "TutorialQuest_IntroFromBunny"
IL_0005: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_000a: ret
METHOD System.Boolean TheForestOfLove.QuestTriggerHelper::IsTriggerFired(System.String)
IL_0000: ldarg.0
IL_0001: call TheForestOfLove.Narrative.Trigger TheForestOfLove.Services.Persistence.DataService::GetTriggerByName(System.String)
IL_0006: stloc.0
IL_0007: ldloc.0
IL_0008: brfalse.s IL_0014
IL_000a: ldloc.0
IL_000b: callvirt System.Int32 TheForestOfLove.Narrative.Trigger::get_CountActivated()
IL_0010: ldc.i4.0
IL_0011: cgt
IL_0013: ret
IL_0014: ldc.i4.0
IL_0015: ret
