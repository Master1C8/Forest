TYPE TheForestOfLove.Narrative.StoryManager
METHOD System.Boolean TheForestOfLove.Narrative.StoryManager::PlayDialogue(TheForestOfLove.Narrative.Dialogue,System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: call TheForestOfLove.DialogueSettings TheForestOfLove.Narrative.StoryManager::get_DialogueSettings()
IL_0005: ldarg.0
IL_0006: ldarg.1
IL_0007: callvirt System.Void TheForestOfLove.DialogueSettings::CopyFrom(TheForestOfLove.Narrative.Dialogue,System.String)
IL_000c: ldarg.0
IL_000d: ldfld TheForestOfLove.Narrative.DialogueType TheForestOfLove.Narrative.Dialogue::dialogueType
IL_0012: ldc.i4 400
IL_0017: beq.s IL_001c
IL_0019: ldc.i4.0
IL_001a: br.s IL_001d
IL_001c: ldc.i4.2
IL_001d: call TheForestOfLove.DialogueSettings TheForestOfLove.Narrative.StoryManager::get_DialogueSettings()
IL_0022: call System.Boolean TheForestOfLove.Narrative.StoryManager::PlayDialogue(TheForestOfLove.Narrative.QuestManagerInteractionMode,TheForestOfLove.DialogueSettings)
IL_0027: ret
METHOD System.Boolean TheForestOfLove.Narrative.StoryManager::PlayDialogue(TheForestOfLove.Narrative.QuestManagerInteractionMode,TheForestOfLove.Gameplay.ConversationSettings) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: call TheForestOfLove.DialogueSettings TheForestOfLove.Narrative.StoryManager::get_DialogueSettings()
IL_0005: ldarg.1
IL_0006: callvirt System.Void TheForestOfLove.DialogueSettings::CopyFrom(TheForestOfLove.Gameplay.ConversationSettings)
IL_000b: ldarg.0
IL_000c: call TheForestOfLove.DialogueSettings TheForestOfLove.Narrative.StoryManager::get_DialogueSettings()
IL_0011: call System.Boolean TheForestOfLove.Narrative.StoryManager::PlayDialogue(TheForestOfLove.Narrative.QuestManagerInteractionMode,TheForestOfLove.DialogueSettings)
IL_0016: ret
METHOD System.Boolean TheForestOfLove.Narrative.StoryManager::PlayDialogue(TheForestOfLove.Narrative.QuestManagerInteractionMode,TheForestOfLove.DialogueSettings) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: ldnull
IL_0002: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0007: brfalse.s IL_0015
IL_0009: ldstr "no dialogue settings available"
IL_000e: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_0013: ldc.i4.0
IL_0014: ret
IL_0015: ldarg.1
IL_0016: call TheForestOfLove.DialogueSettings TheForestOfLove.Narrative.StoryManager::get_DialogueSettings()
IL_001b: callvirt System.Void TheForestOfLove.DialogueSettings::CopyTo(TheForestOfLove.DialogueSettings)
IL_0020: ldarg.1
IL_0021: callvirt System.String TheForestOfLove.DialogueSettings::get_DialogueDbName()
IL_0026: call System.Boolean System.String::IsNullOrWhiteSpace(System.String)
IL_002b: brfalse.s IL_0046
IL_002d: ldarg.1
IL_002e: callvirt System.String TheForestOfLove.DialogueSettings::get_ArcDbName()
IL_0033: call System.Boolean System.String::IsNullOrWhiteSpace(System.String)
IL_0038: brtrue.s IL_0046
IL_003a: ldstr "conversation name is empty but dialogue arc is nonempty!"
IL_003f: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_0044: ldc.i4.0
IL_0045: ret
IL_0046: call T TheForestOfLove.Services.ServiceLocator::Get<TheForestOfLove.Narrative.DialogueService>()
IL_004b: stloc.0
IL_004c: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inStartMenu()
IL_0051: brfalse.s IL_006d
IL_0053: ldc.i4.2
IL_0054: call System.Void TheForestOfLove.Narrative.StoryManager::set_ConversationState(TheForestOfLove.Narrative.QuestManagerConversationState)
IL_0059: ldloc.0
IL_005a: ldarg.1
IL_005b: callvirt System.String TheForestOfLove.DialogueSettings::get_DialogueDbName()
IL_0060: ldarg.1
IL_0061: callvirt System.String TheForestOfLove.DialogueSettings::get_ArcDbName()
IL_0066: callvirt System.Void TheForestOfLove.Narrative.DialogueService::PlayDialogue(System.String,System.String)
IL_006b: ldc.i4.1
IL_006c: ret
IL_006d: call T TheForestOfLove.Services.ServiceLocator::Get<TheForestOfLove.Narrative.ActorTrackingService>()
IL_0072: ldarg.1
IL_0073: callvirt System.String TheForestOfLove.DialogueSettings::get_ActorDbName()
IL_0078: ldarg.1
IL_0079: callvirt System.String TheForestOfLove.DialogueSettings::get_DialogueDbName()
IL_007e: ldarg.1
IL_007f: callvirt System.String TheForestOfLove.DialogueSettings::get_ArcDbName()
IL_0084: ldarg.0
IL_0085: ldc.i4.1
IL_0086: ceq
IL_0088: callvirt System.Void TheForestOfLove.Narrative.ActorTrackingService::ForgetSecondaryConversations(System.String,System.String,System.String,System.Boolean)
IL_008d: ldarg.1
IL_008e: callvirt System.String TheForestOfLove.DialogueSettings::get_DialogueDbName()
IL_0093: ldstr "System_DynamicFastTravel"
IL_0098: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_009d: brfalse.s IL_00bf
IL_009f: call T TheForestOfLove.Services.ServiceLocator::Get<TheForestOfLove.Gameplay.FastTravelController>()
IL_00a4: dup
IL_00a5: callvirt System.String TheForestOfLove.Gameplay.FastTravelController::get_NextFastTravelCustomGreetingText()
IL_00aa: stloc.s V_4
IL_00ac: callvirt System.Collections.Generic.List`1<System.String> TheForestOfLove.Gameplay.FastTravelController::GetDynamicFastTravelDestinationSceneNames()
IL_00b1: stloc.s V_5
IL_00b3: ldloc.0
IL_00b4: ldloc.s V_5
IL_00b6: ldloc.s V_4
IL_00b8: callvirt System.Void TheForestOfLove.Narrative.DialogueService::PlayDynamicFastTravelDialogue(System.Collections.Generic.List`1<System.String>,System.String)
IL_00bd: ldc.i4.1
IL_00be: ret
IL_00bf: ldarg.1
IL_00c0: callvirt System.String TheForestOfLove.DialogueSettings::get_ActorDbName()
IL_00c5: call TheForestOfLove.Narrative.Actor TheForestOfLove.Services.Persistence.DataService::GetActorByDbName(System.String)
IL_00ca: stloc.1
IL_00cb: ldsfld TheForestOfLove.Narrative.Dialogue TheForestOfLove.Narrative.StoryManager::selectedDateDialogue
IL_00d0: brfalse.s IL_00f4
IL_00d2: ldsfld TheForestOfLove.Narrative.Dialogue TheForestOfLove.Narrative.StoryManager::selectedDateDialogue
IL_00d7: callvirt System.Boolean TheForestOfLove.Narrative.Dialogue::get_isCompleted()
IL_00dc: brfalse.s IL_00f4
IL_00de: ldarg.1
IL_00df: call System.Boolean TheForestOfLove.Narrative.StoryManager::IsInferredSchema(TheForestOfLove.DialogueSettings)
IL_00e4: brfalse.s IL_00f4
IL_00e6: ldloc.1
IL_00e7: ldfld System.Boolean TheForestOfLove.Narrative.Actor::hasStartedDate
IL_00ec: brfalse.s IL_00f4
IL_00ee: ldarg.0
IL_00ef: ldc.i4.1
IL_00f0: beq.s IL_00f4
IL_00f2: ldc.i4.0
IL_00f3: ret
IL_00f4: ldarg.0
IL_00f5: newobj System.Void System.Nullable`1<TheForestOfLove.Narrative.QuestManagerInteractionMode>::.ctor(!0)
IL_00fa: call System.Void TheForestOfLove.Narrative.StoryManager::set_InteractionModeTMP(System.Nullable`1<TheForestOfLove.Narrative.QuestManagerInteractionMode>)
IL_00ff: ldarg.1
IL_0100: callvirt System.String TheForestOfLove.DialogueSettings::get_ActorDbName()
IL_0105: call TheForestOfLove.Narrative.ActorDialogueOracle TheForestOfLove.Services.Persistence.DataService::GetActorDialogueOracleByActorDbName(System.String)
IL_010a: stloc.2
IL_010b: ldarg.0
IL_010c: ldarg.1
IL_010d: ldloc.1
IL_010e: ldloc.2
IL_010f: call TheForestOfLove.Narrative.DialogueTrackingSchema TheForestOfLove.Narrative.StoryManager::ChooseTargetStepAndArc(TheForestOfLove.Narrative.QuestManagerInteractionMode,TheForestOfLove.DialogueSettings,TheForestOfLove.Narrative.Actor,TheForestOfLove.Narrative.ActorDialogueOracle)
IL_0114: stloc.3
IL_0115: ldloca.s V_6
IL_0117: initobj System.Nullable`1<TheForestOfLove.Narrative.QuestManagerInteractionMode>
IL_011d: ldloc.s V_6
IL_011f: call System.Void TheForestOfLove.Narrative.StoryManager::set_InteractionModeTMP(System.Nullable`1<TheForestOfLove.Narrative.QuestManagerInteractionMode>)
IL_0124: ldloc.3
IL_0125: brtrue.s IL_018b
IL_0127: ldarg.1
IL_0128: call System.Boolean TheForestOfLove.Narrative.StoryManager::IsInferredSchema(TheForestOfLove.DialogueSettings)
IL_012d: brfalse.s IL_0146
IL_012f: ldstr "no dialogue available! dialogue: [autoselect] actor: "
IL_0134: ldarg.1
IL_0135: callvirt System.String TheForestOfLove.DialogueSettings::get_ActorDbName()
IL_013a: call System.String System.String::Concat(System.String,System.String)
IL_013f: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_0144: br.s IL_0189
IL_0146: ldc.i4.6
IL_0147: newarr System.String
IL_014c: dup
IL_014d: ldc.i4.0
IL_014e: ldstr "no dialogue available! dialogue: "
IL_0153: stelem.ref
IL_0154: dup
IL_0155: ldc.i4.1
IL_0156: ldarg.1
IL_0157: callvirt System.String TheForestOfLove.DialogueSettings::get_DialogueDbName()
IL_015c: stelem.ref
IL_015d: dup
IL_015e: ldc.i4.2
IL_015f: ldstr " arc: "
IL_0164: stelem.ref
IL_0165: dup
IL_0166: ldc.i4.3
IL_0167: ldarg.1
IL_0168: callvirt System.String TheForestOfLove.DialogueSettings::get_ArcDbName()
IL_016d: stelem.ref
IL_016e: dup
IL_016f: ldc.i4.4
IL_0170: ldstr " actor: "
IL_0175: stelem.ref
IL_0176: dup
IL_0177: ldc.i4.5
IL_0178: ldarg.1
IL_0179: callvirt System.String TheForestOfLove.DialogueSettings::get_ActorDbName()
IL_017e: stelem.ref
IL_017f: call System.String System.String::Concat(System.String[])
IL_0184: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_0189: ldc.i4.0
IL_018a: ret
IL_018b: ldarg.1
IL_018c: call System.Boolean TheForestOfLove.Narrative.StoryManager::IsInferredSchema(TheForestOfLove.DialogueSettings)
IL_0191: brfalse.s IL_01a8
IL_0193: call TheForestOfLove.DialogueSettings TheForestOfLove.Narrative.StoryManager::get_DialogueSettings()
IL_0198: ldloc.3
IL_0199: callvirt TheForestOfLove.Narrative.Dialogue TheForestOfLove.Narrative.DialogueTrackingSchema::get_dialogue()
IL_019e: ldfld System.String TheForestOfLove.Narrative.Dialogue::initialActorDbName
IL_01a3: callvirt System.Void TheForestOfLove.DialogueSettings::SetInitialConversant(System.String)
IL_01a8: ldloc.3
IL_01a9: callvirt System.Boolean TheForestOfLove.Narrative.DialogueTrackingSchema::get_isTrackingDynamicQuestions()
IL_01ae: brfalse.s IL_0207
IL_01b0: ldloc.2
IL_01b1: callvirt System.Collections.Generic.IEnumerable`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.ActorDialogueOracle::GetAvailableDynamicQuestions()
IL_01b6: callvirt System.Collections.Generic.IEnumerator`1<!0> System.Collections.Generic.IEnumerable`1<TheForestOfLove.Narrative.Dialogue>::GetEnumerator()
IL_01bb: stloc.s V_7
IL_01bd: br.s IL_01d7
IL_01bf: ldloc.s V_7
IL_01c1: callvirt !0 System.Collections.Generic.IEnumerator`1<TheForestOfLove.Narrative.Dialogue>::get_Current()
IL_01c6: stloc.s V_8
IL_01c8: ldloc.0
IL_01c9: ldloc.s V_8
IL_01cb: ldloc.s V_8
IL_01cd: ldfld TheForestOfLove.Narrative.Arc TheForestOfLove.Narrative.Dialogue::playerInitiatedQuestion
IL_01d2: callvirt System.Void TheForestOfLove.Narrative.DialogueService::AddPlayerQuestion(TheForestOfLove.Narrative.Dialogue,TheForestOfLove.Narrative.Arc)
IL_01d7: ldloc.s V_7
IL_01d9: callvirt System.Boolean System.Collections.IEnumerator::MoveNext()
IL_01de: brtrue.s IL_01bf
IL_01e0: leave.s IL_01ee
IL_01e2: ldloc.s V_7
IL_01e4: brfalse.s IL_01ed
IL_01e6: ldloc.s V_7
IL_01e8: callvirt System.Void System.IDisposable::Dispose()
IL_01ed: endfinally
IL_01ee: ldc.i4.1
IL_01ef: call System.Void TheForestOfLove.Narrative.StoryManager::set_ConversationState(TheForestOfLove.Narrative.QuestManagerConversationState)
IL_01f4: ldloc.0
IL_01f5: ldloc.3
IL_01f6: callvirt TheForestOfLove.Narrative.Dialogue TheForestOfLove.Narrative.DialogueTrackingSchema::get_dialogue()
IL_01fb: ldfld System.String TheForestOfLove.Narrative.Dialogue::dbName
IL_0200: callvirt System.Void TheForestOfLove.Narrative.DialogueService::PlayDialoguePlayerQuestion(System.String)
IL_0205: br.s IL_0251
IL_0207: ldloc.3
IL_0208: callvirt TheForestOfLove.Narrative.Arc TheForestOfLove.Narrative.DialogueTrackingSchema::get_currentArc()
IL_020d: brtrue.s IL_0220
IL_020f: ldstr "no dialogue arc selected!"
IL_0214: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_0219: call System.Void TheForestOfLove.Narrative.StoryManager::Initialize()
IL_021e: ldc.i4.0
IL_021f: ret
IL_0220: ldc.i4.2
IL_0221: call System.Void TheForestOfLove.Narrative.StoryManager::set_ConversationState(TheForestOfLove.Narrative.QuestManagerConversationState)
IL_0226: ldloc.0
IL_0227: ldloc.3
IL_0228: callvirt TheForestOfLove.Narrative.Dialogue TheForestOfLove.Narrative.DialogueTrackingSchema::get_dialogue()
IL_022d: ldfld System.String TheForestOfLove.Narrative.Dialogue::dbName
IL_0232: ldloc.3
IL_0233: callvirt TheForestOfLove.Narrative.Arc TheForestOfLove.Narrative.DialogueTrackingSchema::get_currentArc()
IL_0238: ldfld System.String TheForestOfLove.Narrative.Arc::customName
IL_023d: dup
IL_023e: brtrue.s IL_024c
IL_0240: pop
IL_0241: ldloc.3
IL_0242: callvirt TheForestOfLove.Narrative.Arc TheForestOfLove.Narrative.DialogueTrackingSchema::get_currentArc()
IL_0247: ldfld System.String TheForestOfLove.Narrative.Arc::generatedName
IL_024c: callvirt System.Void TheForestOfLove.Narrative.DialogueService::PlayDialogue(System.String,System.String)
IL_0251: ldc.i4.1
IL_0252: ret
