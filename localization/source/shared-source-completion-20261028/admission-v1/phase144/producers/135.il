TYPE TheForestOfLove.QuestConversationHelper
METHOD System.Void TheForestOfLove.QuestConversationHelper::UpdateDynamicTags() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Boolean TheForestOfLove.QuestConversationHelper::UpdateDynamicTags_IsBusyStoryMoment()
IL_0006: brfalse.s IL_0013
IL_0008: ldstr "Busy Story Moment"
IL_000d: call System.Void TheForestOfLove.Services.Persistence.DataService::AddTagToActive(System.String)
IL_0012: ret
IL_0013: ldstr "Busy Story Moment"
IL_0018: call System.Void TheForestOfLove.Services.Persistence.DataService::RemoveTagFromActive(System.String)
IL_001d: ret
METHOD System.Boolean TheForestOfLove.QuestConversationHelper::UpdateDynamicTags_IsBusyStoryMoment() | attributes=Private, HideBySig | impl=IL
IL_0000: ldstr "MouseQuest_MeetMabelsMom"
IL_0005: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_000a: brfalse.s IL_001a
IL_000c: ldstr "MouseQuest_ReturnToMouseTribe"
IL_0011: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_0016: brtrue.s IL_001a
IL_0018: ldc.i4.1
IL_0019: ret
IL_001a: ldstr "CharlotteSocialQuest_RoommatesLeaveTheCave"
IL_001f: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_0024: brfalse.s IL_0040
IL_0026: ldstr "LightQuest_CollectingFireflies"
IL_002b: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_0030: brfalse.s IL_003e
IL_0032: ldstr "Act3_AfterstormQuest"
IL_0037: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsQuestCompleted(System.String)
IL_003c: brtrue.s IL_0040
IL_003e: ldc.i4.1
IL_003f: ret
IL_0040: ldstr "CookieQuest_CookiesAreReady"
IL_0045: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_004a: brfalse.s IL_005a
IL_004c: ldstr "CookieQuest_ReturnToCharlotte"
IL_0051: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_0056: brtrue.s IL_005a
IL_0058: ldc.i4.1
IL_0059: ret
IL_005a: ldstr "CoyoteQuest_ReturnToCoyotes"
IL_005f: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_0064: brfalse.s IL_0074
IL_0066: ldstr "Act2Capstone_ReturnToCoyotes"
IL_006b: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_0070: brtrue.s IL_0074
IL_0072: ldc.i4.1
IL_0073: ret
IL_0074: ldstr "DeliveryQuest_OttershopIntro"
IL_0079: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_007e: brfalse.s IL_008e
IL_0080: ldstr "DeliveryQuest_ReturnToOtter3"
IL_0085: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_008a: brtrue.s IL_008e
IL_008c: ldc.i4.1
IL_008d: ret
IL_008e: ldstr "Act1Capstone_BeaverCongrats"
IL_0093: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_0098: brfalse.s IL_00a8
IL_009a: ldstr "Act1Capstone_ScarlettNewDay"
IL_009f: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_00a4: brtrue.s IL_00a8
IL_00a6: ldc.i4.1
IL_00a7: ret
IL_00a8: ldc.i4.0
IL_00a9: ret
