TYPE TheForestOfLove.Narrative.StoryManager
METHOD TheForestOfLove.Narrative.Dialogue TheForestOfLove.Narrative.StoryManager::HasNewMainQuest(System.String) | attributes=Public, HideBySig | impl=IL
IL_0000: call T TheForestOfLove.Services.ServiceLocator::Get<TheForestOfLove.Narrative.ActorTrackingService>()
IL_0005: stloc.0
IL_0006: ldarg.1
IL_0007: call TheForestOfLove.Narrative.ActorDialogueOracle TheForestOfLove.Services.Persistence.DataService::GetActorDialogueOracleByActorDbName(System.String)
IL_000c: stloc.1
IL_000d: ldloc.0
IL_000e: ldnull
IL_000f: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0014: brtrue.s IL_0019
IL_0016: ldloc.1
IL_0017: brtrue.s IL_001b
IL_0019: ldnull
IL_001a: ret
IL_001b: ldloc.0
IL_001c: ldarg.1
IL_001d: callvirt TheForestOfLove.Narrative.ActorTrackingSchema TheForestOfLove.Narrative.ActorTrackingService::GetTrackingDataForActor(System.String)
IL_0022: ldfld TheForestOfLove.Narrative.Actor TheForestOfLove.Narrative.ActorTrackingSchema::actor
IL_0027: ldfld System.Boolean TheForestOfLove.Narrative.Actor::isSelectedForDate
IL_002c: brfalse.s IL_0030
IL_002e: ldnull
IL_002f: ret
IL_0030: ldloc.1
IL_0031: callvirt TheForestOfLove.Narrative.Dialogue TheForestOfLove.Narrative.ActorDialogueOracle::GetFirstEncounteredNewMainQuest()
IL_0036: ret
METHOD TheForestOfLove.Narrative.Dialogue TheForestOfLove.Narrative.StoryManager::HasQuestToTurnIn(System.String) | attributes=Public, HideBySig | impl=IL
IL_0000: call T TheForestOfLove.Services.ServiceLocator::Get<TheForestOfLove.Narrative.ActorTrackingService>()
IL_0005: stloc.0
IL_0006: ldarg.1
IL_0007: call TheForestOfLove.Narrative.ActorDialogueOracle TheForestOfLove.Services.Persistence.DataService::GetActorDialogueOracleByActorDbName(System.String)
IL_000c: stloc.1
IL_000d: ldloc.0
IL_000e: ldnull
IL_000f: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0014: brtrue.s IL_0019
IL_0016: ldloc.1
IL_0017: brtrue.s IL_001b
IL_0019: ldnull
IL_001a: ret
IL_001b: ldloc.0
IL_001c: ldarg.1
IL_001d: callvirt TheForestOfLove.Narrative.ActorTrackingSchema TheForestOfLove.Narrative.ActorTrackingService::GetTrackingDataForActor(System.String)
IL_0022: ldfld TheForestOfLove.Narrative.Actor TheForestOfLove.Narrative.ActorTrackingSchema::actor
IL_0027: ldfld System.Boolean TheForestOfLove.Narrative.Actor::isSelectedForDate
IL_002c: brfalse.s IL_0030
IL_002e: ldnull
IL_002f: ret
IL_0030: ldloc.1
IL_0031: callvirt TheForestOfLove.Narrative.Dialogue TheForestOfLove.Narrative.ActorDialogueOracle::GetFirstEncounteredQuestToTurnIn()
IL_0036: ret
METHOD TheForestOfLove.Narrative.Dialogue TheForestOfLove.Narrative.StoryManager::HasAvailableMessages(System.String,TheForestOfLove.Narrative.QuestManagerInteractionMode,System.String,System.String) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: brtrue.s IL_0005
IL_0003: ldnull
IL_0004: ret
IL_0005: call T TheForestOfLove.Services.ServiceLocator::Get<TheForestOfLove.Narrative.ActorTrackingService>()
IL_000a: stloc.0
IL_000b: ldarg.1
IL_000c: call TheForestOfLove.Narrative.ActorDialogueOracle TheForestOfLove.Services.Persistence.DataService::GetActorDialogueOracleByActorDbName(System.String)
IL_0011: stloc.1
IL_0012: ldloc.0
IL_0013: ldnull
IL_0014: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0019: brtrue.s IL_001e
IL_001b: ldloc.1
IL_001c: brtrue.s IL_0020
IL_001e: ldnull
IL_001f: ret
IL_0020: ldloc.0
IL_0021: ldarg.1
IL_0022: callvirt TheForestOfLove.Narrative.ActorTrackingSchema TheForestOfLove.Narrative.ActorTrackingService::GetTrackingDataForActor(System.String)
IL_0027: stloc.2
IL_0028: ldarg.2
IL_0029: switch IL_003a,IL_00fc,IL_00b4
IL_003a: ldloc.2
IL_003b: ldfld TheForestOfLove.Narrative.Actor TheForestOfLove.Narrative.ActorTrackingSchema::actor
IL_0040: ldfld System.Boolean TheForestOfLove.Narrative.Actor::isSelectedForDate
IL_0045: brfalse.s IL_006f
IL_0047: ldloc.2
IL_0048: ldfld TheForestOfLove.Narrative.Actor TheForestOfLove.Narrative.ActorTrackingSchema::actor
IL_004d: ldfld System.Boolean TheForestOfLove.Narrative.Actor::hasStartedDate
IL_0052: brtrue.s IL_006d
IL_0054: ldsfld TheForestOfLove.Narrative.Dialogue TheForestOfLove.Narrative.StoryManager::selectedDateDialogue
IL_0059: brfalse.s IL_006d
IL_005b: ldsfld TheForestOfLove.Narrative.Dialogue TheForestOfLove.Narrative.StoryManager::selectedDateDialogue
IL_0060: callvirt System.Boolean TheForestOfLove.Narrative.Dialogue::get_isCompleted()
IL_0065: brtrue.s IL_006d
IL_0067: ldsfld TheForestOfLove.Narrative.Dialogue TheForestOfLove.Narrative.StoryManager::selectedDateDialogue
IL_006c: ret
IL_006d: ldnull
IL_006e: ret
IL_006f: ldarg.3
IL_0070: call System.Boolean TheForestOfLove.Narrative.StoryManager::IsInferredSchema(System.String)
IL_0075: brtrue.s IL_008b
IL_0077: ldloc.1
IL_0078: ldarg.3
IL_0079: ldarg.s arcDbName
IL_007b: callvirt System.Boolean TheForestOfLove.Narrative.ActorDialogueOracle::IsAvailableSingleDialogueWithUnplayedPrimaryArcs(System.String,System.String)
IL_0080: brfalse.s IL_0089
IL_0082: ldarg.3
IL_0083: call TheForestOfLove.Narrative.Dialogue TheForestOfLove.Services.Persistence.DataService::GetDialogueByDbName(System.String)
IL_0088: ret
IL_0089: ldnull
IL_008a: ret
IL_008b: ldloc.1
IL_008c: callvirt TheForestOfLove.Narrative.Dialogue TheForestOfLove.Narrative.ActorDialogueOracle::GetFirstEncounteredUnplayedPrimaryQuestDialogue()
IL_0091: stloc.3
IL_0092: ldloc.3
IL_0093: brfalse.s IL_0097
IL_0095: ldloc.3
IL_0096: ret
IL_0097: ldloc.1
IL_0098: callvirt TheForestOfLove.Narrative.Dialogue TheForestOfLove.Narrative.ActorDialogueOracle::GetFirstEncounteredUnplayedSupportingQuestDialogue()
IL_009d: stloc.3
IL_009e: ldloc.3
IL_009f: brfalse.s IL_00a3
IL_00a1: ldloc.3
IL_00a2: ret
IL_00a3: ldloc.1
IL_00a4: callvirt System.Boolean TheForestOfLove.Narrative.ActorDialogueOracle::HasAvailableDynamicQuestions()
IL_00a9: brfalse.s IL_00b2
IL_00ab: ldloc.1
IL_00ac: callvirt TheForestOfLove.Narrative.Dialogue TheForestOfLove.Narrative.ActorDialogueOracle::GetFirstEncounteredAvailableQuestionIdle()
IL_00b1: ret
IL_00b2: ldnull
IL_00b3: ret
IL_00b4: ldloc.2
IL_00b5: ldfld TheForestOfLove.Narrative.Actor TheForestOfLove.Narrative.ActorTrackingSchema::actor
IL_00ba: ldfld System.Boolean TheForestOfLove.Narrative.Actor::isSelectedForDate
IL_00bf: brtrue.s IL_00c8
IL_00c1: call System.Boolean TheForestOfLove.QuestTriggerHelper::PlayerLearnedNotebook()
IL_00c6: brtrue.s IL_00ca
IL_00c8: ldnull
IL_00c9: ret
IL_00ca: call System.Boolean TheForestOfLove.QuestTriggerHelper::InAnyInstancedStory()
IL_00cf: brfalse.s IL_00d3
IL_00d1: ldnull
IL_00d2: ret
IL_00d3: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsAct1CapstonePrebridgeOngoing()
IL_00d8: brtrue.s IL_00e1
IL_00da: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsAct1CapstonePostbridgeOngoing()
IL_00df: brfalse.s IL_00e3
IL_00e1: ldnull
IL_00e2: ret
IL_00e3: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsAct2CapstoneOngoing()
IL_00e8: brfalse.s IL_00ec
IL_00ea: ldnull
IL_00eb: ret
IL_00ec: call System.Boolean TheForestOfLove.QuestTriggerHelper::InAct3StormQuest()
IL_00f1: brfalse.s IL_00f5
IL_00f3: ldnull
IL_00f4: ret
IL_00f5: ldloc.1
IL_00f6: callvirt TheForestOfLove.Narrative.Dialogue TheForestOfLove.Narrative.ActorDialogueOracle::GetFirstAvailableGossip()
IL_00fb: ret
IL_00fc: ldloc.1
IL_00fd: callvirt System.Boolean TheForestOfLove.Narrative.ActorDialogueOracle::get_HasLatestDialogueSchema()
IL_0102: brfalse.s IL_012a
IL_0104: ldloc.1
IL_0105: callvirt TheForestOfLove.Narrative.DialogueTrackingSchema TheForestOfLove.Narrative.ActorDialogueOracle::get_LatestDialogueSchema()
IL_010a: callvirt System.Boolean TheForestOfLove.Narrative.DialogueTrackingSchema::get_hasUnplayedPrimaryArcs()
IL_010f: brtrue.s IL_012a
IL_0111: ldloc.1
IL_0112: callvirt TheForestOfLove.Narrative.DialogueTrackingSchema TheForestOfLove.Narrative.ActorDialogueOracle::get_LatestDialogueSchema()
IL_0117: callvirt System.Boolean TheForestOfLove.Narrative.DialogueTrackingSchema::get_hasUnplayedSecondaryArcs()
IL_011c: brfalse.s IL_012a
IL_011e: ldloc.1
IL_011f: callvirt TheForestOfLove.Narrative.DialogueTrackingSchema TheForestOfLove.Narrative.ActorDialogueOracle::get_LatestDialogueSchema()
IL_0124: callvirt TheForestOfLove.Narrative.Dialogue TheForestOfLove.Narrative.DialogueTrackingSchema::get_dialogue()
IL_0129: ret
IL_012a: ldnull
IL_012b: ret
