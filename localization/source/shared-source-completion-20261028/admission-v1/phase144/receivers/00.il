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
METHOD System.Boolean TheForestOfLove.QuestTriggerHelper::IsActorOnScreen(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldsfld TheForestOfLove.Player TheForestOfLove.Player::current
IL_0005: ldnull
IL_0006: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_000b: brfalse.s IL_000f
IL_000d: ldc.i4.0
IL_000e: ret
IL_000f: ldarg.0
IL_0010: call System.Boolean TheForestOfLove.Content.ActorSpawnerService::IsActorSpawned(System.String)
IL_0015: brtrue.s IL_0019
IL_0017: ldc.i4.0
IL_0018: ret
IL_0019: ldarg.0
IL_001a: call TheForestOfLove.Gameplay.CritterActor TheForestOfLove.Gameplay.CritterActor::FindActorByName(System.String)
IL_001f: stloc.0
IL_0020: ldloc.0
IL_0021: ldnull
IL_0022: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0027: brfalse.s IL_002b
IL_0029: ldc.i4.0
IL_002a: ret
IL_002b: ldsfld TheForestOfLove.Player TheForestOfLove.Player::current
IL_0030: callvirt UnityEngine.Vector3 TheForestOfLove.Gameplay.SpawnableActor::get_TransformBasePosition()
IL_0035: ldloc.0
IL_0036: callvirt UnityEngine.Vector3 TheForestOfLove.Gameplay.SpawnableActor::get_TransformBasePosition()
IL_003b: call System.Boolean TheForestOfLove.Utility.PositionHelper::IsPositionOffscreen(UnityEngine.Vector3,UnityEngine.Vector3)
IL_0040: ldc.i4.0
IL_0041: ceq
IL_0043: ret
METHOD System.Boolean TheForestOfLove.QuestTriggerHelper::IsActorIntroduced(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call TheForestOfLove.Narrative.Actor TheForestOfLove.Services.Persistence.DataService::GetActorByDbName(System.String)
IL_0006: stloc.0
IL_0007: ldloc.0
IL_0008: brfalse.s IL_001b
IL_000a: ldloc.0
IL_000b: ldfld System.Boolean TheForestOfLove.Narrative.Actor::isPlayer
IL_0010: brtrue.s IL_0019
IL_0012: ldloc.0
IL_0013: callvirt System.Boolean TheForestOfLove.Narrative.Actor::get_IsIntroduced()
IL_0018: ret
IL_0019: ldc.i4.1
IL_001a: ret
IL_001b: ldc.i4.0
IL_001c: ret
METHOD System.Boolean TheForestOfLove.QuestTriggerHelper::IsActorEncountered(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call TheForestOfLove.Narrative.Actor TheForestOfLove.Services.Persistence.DataService::GetActorByDbName(System.String)
IL_0006: stloc.0
IL_0007: ldloc.0
IL_0008: brfalse.s IL_001b
IL_000a: ldloc.0
IL_000b: ldfld System.Boolean TheForestOfLove.Narrative.Actor::isPlayer
IL_0010: brtrue.s IL_0019
IL_0012: ldloc.0
IL_0013: callvirt System.Boolean TheForestOfLove.Narrative.Actor::get_IsEncounteredOnce()
IL_0018: ret
IL_0019: ldc.i4.1
IL_001a: ret
IL_001b: ldc.i4.0
IL_001c: ret
METHOD System.Boolean TheForestOfLove.QuestTriggerHelper::IsActorDespawnedOrOnDate(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsActorSpawned(System.String)
IL_0006: brfalse.s IL_000f
IL_0008: ldarg.0
IL_0009: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsActorOnDate(System.String)
IL_000e: ret
IL_000f: ldc.i4.1
IL_0010: ret
METHOD System.Boolean TheForestOfLove.QuestTriggerHelper::IsActorSpawned(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call TheForestOfLove.Narrative.Actor TheForestOfLove.Services.Persistence.DataService::GetActorByDbName(System.String)
IL_0006: stloc.0
IL_0007: ldloc.0
IL_0008: brfalse.s IL_0011
IL_000a: ldloc.0
IL_000b: ldfld System.Boolean TheForestOfLove.Narrative.Actor::hasSpawnedInActiveScene
IL_0010: ret
IL_0011: ldc.i4.0
IL_0012: ret
METHOD System.Boolean TheForestOfLove.QuestTriggerHelper::IsQuestUnstarted(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call TheForestOfLove.Narrative.Quest TheForestOfLove.Services.Persistence.DataService::GetQuestByDbName(System.String)
IL_0006: callvirt TheForestOfLove.Narrative.QuestStatus TheForestOfLove.Narrative.Quest::get_status()
IL_000b: ldc.i4.0
IL_000c: ceq
IL_000e: ret
METHOD System.Boolean TheForestOfLove.QuestTriggerHelper::IsQuestCompleted(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call TheForestOfLove.Narrative.Quest TheForestOfLove.Services.Persistence.DataService::GetQuestByDbName(System.String)
IL_0006: callvirt TheForestOfLove.Narrative.QuestStatus TheForestOfLove.Narrative.Quest::get_status()
IL_000b: ldc.i4 200
IL_0010: ceq
IL_0012: ret
