TYPE TheForestOfLove.QuestTriggerHelper
METHOD System.Boolean TheForestOfLove.QuestTriggerHelper::CanPlayMaverickRascalShopStory() | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldstr "Act3_LightQuest"
IL_0005: call TheForestOfLove.Narrative.QuestStatus TheForestOfLove.QuestTriggerHelper::LoadQuestStatus(System.String)
IL_000a: ldc.i4 200
IL_000f: bne.un.s IL_002d
IL_0011: call System.Boolean TheForestOfLove.QuestTriggerHelper::InBusyStoryMoment()
IL_0016: brtrue.s IL_002d
IL_0018: ldstr "SideQuest_MaverickRascalShopScene"
IL_001d: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_0022: brtrue.s IL_002d
IL_0024: call System.Boolean TheForestOfLove.QuestTriggerHelper::InAct3AfterstormQuest()
IL_0029: ldc.i4.0
IL_002a: ceq
IL_002c: ret
IL_002d: ldc.i4.0
IL_002e: ret
