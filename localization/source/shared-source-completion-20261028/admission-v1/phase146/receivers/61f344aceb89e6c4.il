TYPE TheForestOfLove.SmashableCrystalTest
METHOD System.Void TheForestOfLove.SmashableCrystalTest::Update() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Boolean TheForestOfLove.SmashableCrystalTest::debugReset
IL_0006: brfalse.s IL_0034
IL_0008: ldarg.0
IL_0009: ldc.i4.0
IL_000a: stfld System.Boolean TheForestOfLove.SmashableCrystalTest::debugReset
IL_000f: ldarg.0
IL_0010: ldc.i4.0
IL_0011: stfld System.Boolean TheForestOfLove.SmashableCrystalTest::smashed
IL_0016: ldarg.0
IL_0017: ldfld UnityEngine.Collider2D TheForestOfLove.SmashableCrystalTest::collider
IL_001c: ldc.i4.1
IL_001d: callvirt System.Void UnityEngine.Behaviour::set_enabled(System.Boolean)
IL_0022: ldarg.0
IL_0023: ldfld UnityEngine.Animator TheForestOfLove.SmashableCrystalTest::animator
IL_0028: ldarg.0
IL_0029: ldfld System.String TheForestOfLove.SmashableCrystalTest::ANIMATOR_TRIGGER_RESET
IL_002e: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0033: ret
IL_0034: ret
METHOD System.Void TheForestOfLove.SmashableCrystalTest::OnSlashImpact() | attributes=Private, HideBySig | impl=IL
IL_0000: ldsfld TheForestOfLove.Player TheForestOfLove.Player::current
IL_0005: ldnull
IL_0006: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_000b: brfalse.s IL_000e
IL_000d: ret
IL_000e: ldarg.0
IL_000f: ldfld System.Boolean TheForestOfLove.SmashableCrystalTest::smashed
IL_0014: brfalse.s IL_0017
IL_0016: ret
IL_0017: ldsfld TheForestOfLove.Player TheForestOfLove.Player::current
IL_001c: callvirt UnityEngine.Vector3 TheForestOfLove.Gameplay.SpawnableActor::get_TransformBasePosition()
IL_0021: ldarg.0
IL_0022: ldfld TheForestOfLove.TransformOffset TheForestOfLove.SmashableCrystalTest::transformOffset
IL_0027: callvirt UnityEngine.Vector3 TheForestOfLove.TransformOffset::get_position()
IL_002c: call UnityEngine.Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)
IL_0031: stloc.0
IL_0032: ldsfld TheForestOfLove.Player TheForestOfLove.Player::current
IL_0037: callvirt UnityEngine.Vector3 TheForestOfLove.Gameplay.SpawnableActor::get_TransformBasePosition()
IL_003c: ldfld System.Single UnityEngine.Vector3::x
IL_0041: ldarg.0
IL_0042: ldfld TheForestOfLove.TransformOffset TheForestOfLove.SmashableCrystalTest::transformOffset
IL_0047: callvirt UnityEngine.Vector3 TheForestOfLove.TransformOffset::get_position()
IL_004c: ldfld System.Single UnityEngine.Vector3::x
IL_0051: bge.un IL_00fb
IL_0056: ldsfld TheForestOfLove.Player TheForestOfLove.Player::current
IL_005b: callvirt TheForestOfLove.Gameplay.DirectionController TheForestOfLove.Gameplay.SpawnableActor::get_DirectionController()
IL_0060: callvirt System.Boolean TheForestOfLove.Gameplay.DirectionController::get_flipped()
IL_0065: brtrue IL_00fb
IL_006a: ldloc.0
IL_006b: ldfld System.Single UnityEngine.Vector3::x
IL_0070: call System.Single UnityEngine.Mathf::Abs(System.Single)
IL_0075: ldarg.0
IL_0076: ldflda UnityEngine.Vector2 TheForestOfLove.SmashableCrystalTest::proxXMinMax
IL_007b: ldfld System.Single UnityEngine.Vector2::x
IL_0080: blt.un IL_01b7
IL_0085: ldloc.0
IL_0086: ldfld System.Single UnityEngine.Vector3::x
IL_008b: call System.Single UnityEngine.Mathf::Abs(System.Single)
IL_0090: ldarg.0
IL_0091: ldflda UnityEngine.Vector2 TheForestOfLove.SmashableCrystalTest::proxXMinMax
IL_0096: ldfld System.Single UnityEngine.Vector2::y
IL_009b: bgt.un IL_01b7
IL_00a0: ldloc.0
IL_00a1: ldfld System.Single UnityEngine.Vector3::y
IL_00a6: call System.Single UnityEngine.Mathf::Abs(System.Single)
IL_00ab: ldarg.0
IL_00ac: ldflda UnityEngine.Vector2 TheForestOfLove.SmashableCrystalTest::proxYMinMax
IL_00b1: ldfld System.Single UnityEngine.Vector2::x
IL_00b6: blt.un IL_01b7
IL_00bb: ldloc.0
IL_00bc: ldfld System.Single UnityEngine.Vector3::y
IL_00c1: call System.Single UnityEngine.Mathf::Abs(System.Single)
IL_00c6: ldarg.0
IL_00c7: ldflda UnityEngine.Vector2 TheForestOfLove.SmashableCrystalTest::proxYMinMax
IL_00cc: ldfld System.Single UnityEngine.Vector2::y
IL_00d1: bgt.un IL_01b7
IL_00d6: ldarg.0
IL_00d7: ldfld UnityEngine.Animator TheForestOfLove.SmashableCrystalTest::animator
IL_00dc: ldarg.0
IL_00dd: ldfld System.String TheForestOfLove.SmashableCrystalTest::ANIMATOR_TRIGGER_SMASH
IL_00e2: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_00e7: ldarg.0
IL_00e8: ldfld UnityEngine.Collider2D TheForestOfLove.SmashableCrystalTest::collider
IL_00ed: ldc.i4.0
IL_00ee: callvirt System.Void UnityEngine.Behaviour::set_enabled(System.Boolean)
IL_00f3: ldarg.0
IL_00f4: ldc.i4.1
IL_00f5: stfld System.Boolean TheForestOfLove.SmashableCrystalTest::smashed
IL_00fa: ret
IL_00fb: ldsfld TheForestOfLove.Player TheForestOfLove.Player::current
IL_0100: callvirt UnityEngine.Vector3 TheForestOfLove.Gameplay.SpawnableActor::get_TransformBasePosition()
IL_0105: ldfld System.Single UnityEngine.Vector3::x
IL_010a: ldarg.0
IL_010b: ldfld TheForestOfLove.TransformOffset TheForestOfLove.SmashableCrystalTest::transformOffset
IL_0110: callvirt UnityEngine.Vector3 TheForestOfLove.TransformOffset::get_position()
IL_0115: ldfld System.Single UnityEngine.Vector3::x
IL_011a: ble.un IL_01b7
IL_011f: ldsfld TheForestOfLove.Player TheForestOfLove.Player::current
IL_0124: callvirt TheForestOfLove.Gameplay.DirectionController TheForestOfLove.Gameplay.SpawnableActor::get_DirectionController()
IL_0129: callvirt System.Boolean TheForestOfLove.Gameplay.DirectionController::get_flipped()
IL_012e: brfalse IL_01b7
IL_0133: ldloc.0
IL_0134: ldfld System.Single UnityEngine.Vector3::x
IL_0139: call System.Single UnityEngine.Mathf::Abs(System.Single)
IL_013e: ldarg.0
IL_013f: ldflda UnityEngine.Vector2 TheForestOfLove.SmashableCrystalTest::proxXMinMax
IL_0144: ldfld System.Single UnityEngine.Vector2::x
IL_0149: blt.un.s IL_01b7
IL_014b: ldloc.0
IL_014c: ldfld System.Single UnityEngine.Vector3::x
IL_0151: call System.Single UnityEngine.Mathf::Abs(System.Single)
IL_0156: ldarg.0
IL_0157: ldflda UnityEngine.Vector2 TheForestOfLove.SmashableCrystalTest::proxXMinMax
IL_015c: ldfld System.Single UnityEngine.Vector2::y
IL_0161: bgt.un.s IL_01b7
IL_0163: ldloc.0
IL_0164: ldfld System.Single UnityEngine.Vector3::y
IL_0169: call System.Single UnityEngine.Mathf::Abs(System.Single)
IL_016e: ldarg.0
IL_016f: ldflda UnityEngine.Vector2 TheForestOfLove.SmashableCrystalTest::proxYMinMax
IL_0174: ldfld System.Single UnityEngine.Vector2::x
IL_0179: blt.un.s IL_01b7
IL_017b: ldloc.0
IL_017c: ldfld System.Single UnityEngine.Vector3::y
IL_0181: call System.Single UnityEngine.Mathf::Abs(System.Single)
IL_0186: ldarg.0
IL_0187: ldflda UnityEngine.Vector2 TheForestOfLove.SmashableCrystalTest::proxYMinMax
IL_018c: ldfld System.Single UnityEngine.Vector2::y
IL_0191: bgt.un.s IL_01b7
IL_0193: ldarg.0
IL_0194: ldfld UnityEngine.Animator TheForestOfLove.SmashableCrystalTest::animator
IL_0199: ldarg.0
IL_019a: ldfld System.String TheForestOfLove.SmashableCrystalTest::ANIMATOR_TRIGGER_SMASH
IL_019f: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_01a4: ldarg.0
IL_01a5: ldfld UnityEngine.Collider2D TheForestOfLove.SmashableCrystalTest::collider
IL_01aa: ldc.i4.0
IL_01ab: callvirt System.Void UnityEngine.Behaviour::set_enabled(System.Boolean)
IL_01b0: ldarg.0
IL_01b1: ldc.i4.1
IL_01b2: stfld System.Boolean TheForestOfLove.SmashableCrystalTest::smashed
IL_01b7: ret
