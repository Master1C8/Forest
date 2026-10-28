TYPE TheForestOfLove.Interaction.ActorDialogueInteractionHelper
METHOD System.Void TheForestOfLove.Interaction.ActorDialogueInteractionHelper::OnConversationStart() | attributes=Private, HideBySig | impl=IL
IL_0000: ldc.r4 0.1
IL_0005: stloc.0
IL_0006: ldc.r4 0.1
IL_000b: stloc.1
IL_000c: ldstr "Player"
IL_0011: call TheForestOfLove.Gameplay.SpawnableActor TheForestOfLove.Gameplay.SpawnableActor::FindActorByName(System.String)
IL_0016: stloc.2
IL_0017: call System.String TheForestOfLove.Narrative.DialogueService::get_InitialActorDbName()
IL_001c: call TheForestOfLove.Gameplay.SpawnableActor TheForestOfLove.Gameplay.SpawnableActor::FindActorByName(System.String)
IL_0021: stloc.3
IL_0022: ldloc.3
IL_0023: ldnull
IL_0024: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0029: brfalse IL_01f3
IL_002e: ldloc.2
IL_002f: callvirt UnityEngine.Vector3 TheForestOfLove.Gameplay.SpawnableActor::get_TransformBasePosition()
IL_0034: ldloc.3
IL_0035: callvirt UnityEngine.Vector3 TheForestOfLove.Gameplay.SpawnableActor::get_TransformBasePosition()
IL_003a: call UnityEngine.Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)
IL_003f: stloc.s V_4
IL_0041: ldloc.3
IL_0042: callvirt System.Boolean TheForestOfLove.Gameplay.SpawnableActor::get_PreventDialogueFlip()
IL_0047: brtrue.s IL_00a1
IL_0049: ldloc.3
IL_004a: callvirt System.Boolean TheForestOfLove.Gameplay.SpawnableActor::get_IgnoreDialogueFlipDeadzone()
IL_004f: brtrue.s IL_0060
IL_0051: ldloc.s V_4
IL_0053: ldfld System.Single UnityEngine.Vector3::x
IL_0058: call System.Single UnityEngine.Mathf::Abs(System.Single)
IL_005d: ldloc.0
IL_005e: ble.un.s IL_00a1
IL_0060: ldloc.s V_4
IL_0062: ldfld System.Single UnityEngine.Vector3::x
IL_0067: ldc.r4 0
IL_006c: bge.un.s IL_007b
IL_006e: ldloc.3
IL_006f: callvirt TheForestOfLove.Gameplay.DirectionController TheForestOfLove.Gameplay.SpawnableActor::get_DirectionController()
IL_0074: callvirt System.Boolean TheForestOfLove.Gameplay.DirectionController::get_flipped()
IL_0079: brfalse.s IL_0096
IL_007b: ldloc.s V_4
IL_007d: ldfld System.Single UnityEngine.Vector3::x
IL_0082: ldc.r4 0
IL_0087: ble.un.s IL_00a1
IL_0089: ldloc.3
IL_008a: callvirt TheForestOfLove.Gameplay.DirectionController TheForestOfLove.Gameplay.SpawnableActor::get_DirectionController()
IL_008f: callvirt System.Boolean TheForestOfLove.Gameplay.DirectionController::get_flipped()
IL_0094: brfalse.s IL_00a1
IL_0096: ldloc.3
IL_0097: callvirt TheForestOfLove.Gameplay.DirectionController TheForestOfLove.Gameplay.SpawnableActor::get_DirectionController()
IL_009c: callvirt System.Void TheForestOfLove.Gameplay.DirectionController::Flip()
IL_00a1: call TheForestOfLove.DialogueSettings TheForestOfLove.Narrative.StoryManager::get_DialogueSettings()
IL_00a6: ldnull
IL_00a7: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_00ac: brfalse.s IL_0101
IL_00ae: call TheForestOfLove.DialogueSettings TheForestOfLove.Narrative.StoryManager::get_DialogueSettings()
IL_00b3: callvirt System.Boolean TheForestOfLove.DialogueSettings::get_HasPlayerDirection()
IL_00b8: brfalse.s IL_0101
IL_00ba: call TheForestOfLove.DialogueSettings TheForestOfLove.Narrative.StoryManager::get_DialogueSettings()
IL_00bf: callvirt TheForestOfLove.Direction TheForestOfLove.DialogueSettings::get_PlayerDirection()
IL_00c4: stloc.s V_5
IL_00c6: ldloc.2
IL_00c7: callvirt TheForestOfLove.Gameplay.DirectionController TheForestOfLove.Gameplay.SpawnableActor::get_DirectionController()
IL_00cc: ldloc.2
IL_00cd: callvirt TheForestOfLove.Gameplay.DirectionController TheForestOfLove.Gameplay.SpawnableActor::get_DirectionController()
IL_00d2: callvirt TheForestOfLove.Direction TheForestOfLove.Gameplay.DirectionController::get_direction()
IL_00d7: ldc.i4.1
IL_00d8: add
IL_00d9: ldtoken TheForestOfLove.Direction
IL_00de: call System.Type System.Type::GetTypeFromHandle(System.RuntimeTypeHandle)
IL_00e3: call System.Array System.Enum::GetValues(System.Type)
IL_00e8: callvirt System.Int32 System.Array::get_Length()
IL_00ed: rem
IL_00ee: callvirt System.Void TheForestOfLove.Gameplay.DirectionController::SetDirection(TheForestOfLove.Direction)
IL_00f3: ldloc.2
IL_00f4: callvirt TheForestOfLove.Gameplay.DirectionController TheForestOfLove.Gameplay.SpawnableActor::get_DirectionController()
IL_00f9: ldloc.s V_5
IL_00fb: callvirt System.Void TheForestOfLove.Gameplay.DirectionController::SetDirection(TheForestOfLove.Direction)
IL_0100: ret
IL_0101: ldloc.s V_4
IL_0103: ldfld System.Single UnityEngine.Vector3::x
IL_0108: call System.Single UnityEngine.Mathf::Abs(System.Single)
IL_010d: ldloc.s V_4
IL_010f: ldfld System.Single UnityEngine.Vector3::y
IL_0114: call System.Single UnityEngine.Mathf::Abs(System.Single)
IL_0119: ldloc.1
IL_011a: add
IL_011b: bge.un.s IL_016d
IL_011d: ldloc.2
IL_011e: callvirt TheForestOfLove.Gameplay.DirectionController TheForestOfLove.Gameplay.SpawnableActor::get_DirectionController()
IL_0123: callvirt TheForestOfLove.Direction TheForestOfLove.Gameplay.DirectionController::get_direction()
IL_0128: brtrue.s IL_0145
IL_012a: ldloc.s V_4
IL_012c: ldfld System.Single UnityEngine.Vector3::y
IL_0131: ldc.r4 0
IL_0136: bge.un.s IL_0145
IL_0138: ldloc.2
IL_0139: callvirt TheForestOfLove.Gameplay.DirectionController TheForestOfLove.Gameplay.SpawnableActor::get_DirectionController()
IL_013e: ldc.i4.2
IL_013f: callvirt System.Void TheForestOfLove.Gameplay.DirectionController::SetDirection(TheForestOfLove.Direction)
IL_0144: ret
IL_0145: ldloc.s V_4
IL_0147: ldfld System.Single UnityEngine.Vector3::y
IL_014c: ldc.r4 0
IL_0151: ble.un.s IL_0160
IL_0153: ldloc.2
IL_0154: callvirt TheForestOfLove.Gameplay.DirectionController TheForestOfLove.Gameplay.SpawnableActor::get_DirectionController()
IL_0159: ldc.i4.0
IL_015a: callvirt System.Void TheForestOfLove.Gameplay.DirectionController::SetDirection(TheForestOfLove.Direction)
IL_015f: ret
IL_0160: ldloc.2
IL_0161: callvirt TheForestOfLove.Gameplay.DirectionController TheForestOfLove.Gameplay.SpawnableActor::get_DirectionController()
IL_0166: ldc.i4.2
IL_0167: callvirt System.Void TheForestOfLove.Gameplay.DirectionController::SetDirection(TheForestOfLove.Direction)
IL_016c: ret
IL_016d: ldloc.2
IL_016e: callvirt TheForestOfLove.Gameplay.DirectionController TheForestOfLove.Gameplay.SpawnableActor::get_DirectionController()
IL_0173: callvirt TheForestOfLove.Direction TheForestOfLove.Gameplay.DirectionController::get_direction()
IL_0178: ldc.i4.3
IL_0179: beq.s IL_0189
IL_017b: ldloc.2
IL_017c: callvirt TheForestOfLove.Gameplay.DirectionController TheForestOfLove.Gameplay.SpawnableActor::get_DirectionController()
IL_0181: callvirt TheForestOfLove.Direction TheForestOfLove.Gameplay.DirectionController::get_direction()
IL_0186: ldc.i4.1
IL_0187: bne.un.s IL_01a4
IL_0189: ldloc.s V_4
IL_018b: ldfld System.Single UnityEngine.Vector3::x
IL_0190: ldc.r4 0
IL_0195: bge.un.s IL_01a4
IL_0197: ldloc.2
IL_0198: callvirt TheForestOfLove.Gameplay.DirectionController TheForestOfLove.Gameplay.SpawnableActor::get_DirectionController()
IL_019d: callvirt System.Boolean TheForestOfLove.Gameplay.DirectionController::get_flipped()
IL_01a2: brtrue.s IL_01bf
IL_01a4: ldloc.s V_4
IL_01a6: ldfld System.Single UnityEngine.Vector3::x
IL_01ab: ldc.r4 0
IL_01b0: ble.un.s IL_01cb
IL_01b2: ldloc.2
IL_01b3: callvirt TheForestOfLove.Gameplay.DirectionController TheForestOfLove.Gameplay.SpawnableActor::get_DirectionController()
IL_01b8: callvirt System.Boolean TheForestOfLove.Gameplay.DirectionController::get_flipped()
IL_01bd: brtrue.s IL_01cb
IL_01bf: ldloc.2
IL_01c0: callvirt TheForestOfLove.Gameplay.DirectionController TheForestOfLove.Gameplay.SpawnableActor::get_DirectionController()
IL_01c5: callvirt System.Void TheForestOfLove.Gameplay.DirectionController::Flip()
IL_01ca: ret
IL_01cb: ldloc.s V_4
IL_01cd: ldfld System.Single UnityEngine.Vector3::x
IL_01d2: ldc.r4 0
IL_01d7: bge.un.s IL_01e6
IL_01d9: ldloc.2
IL_01da: callvirt TheForestOfLove.Gameplay.DirectionController TheForestOfLove.Gameplay.SpawnableActor::get_DirectionController()
IL_01df: ldc.i4.1
IL_01e0: callvirt System.Void TheForestOfLove.Gameplay.DirectionController::SetDirection(TheForestOfLove.Direction)
IL_01e5: ret
IL_01e6: ldloc.2
IL_01e7: callvirt TheForestOfLove.Gameplay.DirectionController TheForestOfLove.Gameplay.SpawnableActor::get_DirectionController()
IL_01ec: ldc.i4.3
IL_01ed: callvirt System.Void TheForestOfLove.Gameplay.DirectionController::SetDirection(TheForestOfLove.Direction)
IL_01f2: ret
IL_01f3: ldloc.2
IL_01f4: ldnull
IL_01f5: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_01fa: brfalse.s IL_0268
IL_01fc: ldloc.2
IL_01fd: callvirt TheForestOfLove.Gameplay.DirectionController TheForestOfLove.Gameplay.SpawnableActor::get_DirectionController()
IL_0202: callvirt TheForestOfLove.Direction TheForestOfLove.Gameplay.DirectionController::get_direction()
IL_0207: stloc.s V_6
IL_0209: call TheForestOfLove.DialogueSettings TheForestOfLove.Narrative.StoryManager::get_DialogueSettings()
IL_020e: ldnull
IL_020f: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0214: brfalse.s IL_022e
IL_0216: call TheForestOfLove.DialogueSettings TheForestOfLove.Narrative.StoryManager::get_DialogueSettings()
IL_021b: callvirt System.Boolean TheForestOfLove.DialogueSettings::get_HasPlayerDirection()
IL_0220: brfalse.s IL_022e
IL_0222: call TheForestOfLove.DialogueSettings TheForestOfLove.Narrative.StoryManager::get_DialogueSettings()
IL_0227: callvirt TheForestOfLove.Direction TheForestOfLove.DialogueSettings::get_PlayerDirection()
IL_022c: stloc.s V_6
IL_022e: ldloc.2
IL_022f: callvirt TheForestOfLove.Gameplay.DirectionController TheForestOfLove.Gameplay.SpawnableActor::get_DirectionController()
IL_0234: ldloc.2
IL_0235: callvirt TheForestOfLove.Gameplay.DirectionController TheForestOfLove.Gameplay.SpawnableActor::get_DirectionController()
IL_023a: callvirt TheForestOfLove.Direction TheForestOfLove.Gameplay.DirectionController::get_direction()
IL_023f: ldc.i4.1
IL_0240: add
IL_0241: ldtoken TheForestOfLove.Direction
IL_0246: call System.Type System.Type::GetTypeFromHandle(System.RuntimeTypeHandle)
IL_024b: call System.Array System.Enum::GetValues(System.Type)
IL_0250: callvirt System.Int32 System.Array::get_Length()
IL_0255: rem
IL_0256: callvirt System.Void TheForestOfLove.Gameplay.DirectionController::SetDirection(TheForestOfLove.Direction)
IL_025b: ldloc.2
IL_025c: callvirt TheForestOfLove.Gameplay.DirectionController TheForestOfLove.Gameplay.SpawnableActor::get_DirectionController()
IL_0261: ldloc.s V_6
IL_0263: callvirt System.Void TheForestOfLove.Gameplay.DirectionController::SetDirection(TheForestOfLove.Direction)
IL_0268: ret
