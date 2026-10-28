TYPE TheForestOfLove.QuestTriggerHelper
METHOD System.Boolean TheForestOfLove.QuestTriggerHelper::IsTriggerSet(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsTriggerFired(System.String)
IL_0006: ret
METHOD System.Void TheForestOfLove.QuestTriggerHelper::SetTrigger(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.Narrative.NarrativeActions::ActivateTrigger(System.String)
IL_0006: ret
METHOD System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call TheForestOfLove.Narrative.Dialogue TheForestOfLove.Services.Persistence.DataService::GetDialogueByDbName(System.String)
IL_0006: stloc.0
IL_0007: ldloc.0
IL_0008: brtrue.s IL_000c
IL_000a: ldc.i4.0
IL_000b: ret
IL_000c: ldloc.0
IL_000d: callvirt System.Boolean TheForestOfLove.Narrative.Dialogue::get_isCompleted()
IL_0012: ret
METHOD System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String,System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call TheForestOfLove.Narrative.Dialogue TheForestOfLove.Services.Persistence.DataService::GetDialogueByDbName(System.String)
IL_0006: stloc.0
IL_0007: ldloc.0
IL_0008: brtrue.s IL_000d
IL_000a: ldnull
IL_000b: br.s IL_0014
IL_000d: ldloc.0
IL_000e: ldarg.1
IL_000f: callvirt TheForestOfLove.Narrative.Arc TheForestOfLove.Narrative.Dialogue::GetArcByName(System.String)
IL_0014: stloc.1
IL_0015: ldloc.1
IL_0016: brtrue.s IL_001a
IL_0018: ldc.i4.0
IL_0019: ret
IL_001a: ldloc.1
IL_001b: callvirt System.Boolean TheForestOfLove.Narrative.Arc::get_isPlayed()
IL_0020: ret
METHOD TheForestOfLove.Narrative.QuestStatus TheForestOfLove.QuestTriggerHelper::LoadQuestStatus(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call TheForestOfLove.Narrative.Quest TheForestOfLove.Services.Persistence.DataService::GetQuestByDbName(System.String)
IL_0006: callvirt TheForestOfLove.Narrative.QuestStatus TheForestOfLove.Narrative.Quest::get_status()
IL_000b: ret
METHOD System.Boolean TheForestOfLove.QuestTriggerHelper::IsActorSpawnedOrOnDate(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsActorSpawned(System.String)
IL_0006: brtrue.s IL_000f
IL_0008: ldarg.0
IL_0009: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsActorOnDate(System.String)
IL_000e: ret
IL_000f: ldc.i4.1
IL_0010: ret
METHOD System.Boolean TheForestOfLove.QuestTriggerHelper::IsTriggerFired(System.String) | attributes=Public, Static, HideBySig | impl=IL
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
