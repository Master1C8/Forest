TYPE TheForestOfLove.PlayerSwimTransition
METHOD System.Void TheForestOfLove.PlayerSwimTransition::Update() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Boolean TheForestOfLove.PlayerSwimTransition::isAirborne
IL_0006: brfalse IL_023a
IL_000b: ldarg.0
IL_000c: ldfld UnityEngine.Vector3 TheForestOfLove.PlayerSwimTransition::jumpDestination
IL_0011: ldarg.0
IL_0012: call UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0017: callvirt UnityEngine.Vector3 UnityEngine.Transform::get_position()
IL_001c: call UnityEngine.Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)
IL_0021: stloc.0
IL_0022: ldarg.0
IL_0023: call UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0028: callvirt UnityEngine.Vector3 UnityEngine.Transform::get_position()
IL_002d: ldloca.s V_0
IL_002f: call UnityEngine.Vector3 UnityEngine.Vector3::get_normalized()
IL_0034: call System.Single UnityEngine.Time::get_deltaTime()
IL_0039: call UnityEngine.Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,System.Single)
IL_003e: ldarg.0
IL_003f: ldfld System.Single TheForestOfLove.PlayerSwimTransition::jumpSpeed
IL_0044: call UnityEngine.Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,System.Single)
IL_0049: call UnityEngine.Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)
IL_004e: stloc.1
IL_004f: ldarg.0
IL_0050: ldarg.0
IL_0051: ldfld System.Single TheForestOfLove.PlayerSwimTransition::timeAirborne
IL_0056: call System.Single UnityEngine.Time::get_deltaTime()
IL_005b: add
IL_005c: stfld System.Single TheForestOfLove.PlayerSwimTransition::timeAirborne
IL_0061: ldarg.0
IL_0062: call UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0067: callvirt UnityEngine.Vector3 UnityEngine.Transform::get_position()
IL_006c: ldarg.0
IL_006d: ldfld UnityEngine.Vector3 TheForestOfLove.PlayerSwimTransition::jumpDestination
IL_0072: call UnityEngine.Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)
IL_0077: stloc.3
IL_0078: ldloca.s V_3
IL_007a: call System.Single UnityEngine.Vector3::get_magnitude()
IL_007f: ldarg.0
IL_0080: ldfld System.Single TheForestOfLove.PlayerSwimTransition::pointArrivalDelta
IL_0085: blt.s IL_0097
IL_0087: ldarg.0
IL_0088: ldfld System.Single TheForestOfLove.PlayerSwimTransition::timeAirborne
IL_008d: ldc.r4 1
IL_0092: ble.un IL_01e8
IL_0097: ldarg.0
IL_0098: ldfld UnityEngine.Vector3 TheForestOfLove.PlayerSwimTransition::jumpDestination
IL_009d: stloc.1
IL_009e: ldarg.0
IL_009f: ldc.i4.0
IL_00a0: stfld System.Boolean TheForestOfLove.PlayerSwimTransition::isAirborne
IL_00a5: ldarg.0
IL_00a6: ldfld UnityEngine.Animator TheForestOfLove.PlayerSwimTransition::animator
IL_00ab: ldarg.0
IL_00ac: ldfld System.Boolean TheForestOfLove.PlayerSwimTransition::isEntry
IL_00b1: brtrue.s IL_00ba
IL_00b3: ldstr "exit_landing"
IL_00b8: br.s IL_00bf
IL_00ba: ldstr "enter_landing"
IL_00bf: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_00c4: ldarg.0
IL_00c5: ldfld UnityEngine.Animator TheForestOfLove.PlayerSwimTransition::shadowAnimator
IL_00ca: ldarg.0
IL_00cb: ldfld System.Boolean TheForestOfLove.PlayerSwimTransition::isEntry
IL_00d0: brtrue.s IL_00d9
IL_00d2: ldstr "exit_landing"
IL_00d7: br.s IL_00de
IL_00d9: ldstr "enter_landing"
IL_00de: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_00e3: ldarg.0
IL_00e4: ldfld System.Boolean TheForestOfLove.PlayerSwimTransition::isEntry
IL_00e9: brfalse IL_0174
IL_00ee: ldarg.0
IL_00ef: call UnityEngine.Transform UnityEngine.Component::get_transform()
IL_00f4: callvirt UnityEngine.Vector3 UnityEngine.Transform::get_localScale()
IL_00f9: ldfld System.Single UnityEngine.Vector3::x
IL_00fe: stloc.s V_4
IL_0100: ldsfld TheForestOfLove.Player TheForestOfLove.Player::current
IL_0105: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_010a: ldarg.0
IL_010b: call UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0110: callvirt UnityEngine.Vector3 UnityEngine.Transform::get_position()
IL_0115: ldarg.0
IL_0116: ldfld TheForestOfLove.TransformOffset TheForestOfLove.PlayerSwimTransition::swimEntryWater
IL_011b: ldflda UnityEngine.Vector3 TheForestOfLove.TransformOffset::offset
IL_0120: ldfld System.Single UnityEngine.Vector3::x
IL_0125: ldloc.s V_4
IL_0127: mul
IL_0128: ldarg.0
IL_0129: ldfld TheForestOfLove.TransformOffset TheForestOfLove.PlayerSwimTransition::swimEntryWater
IL_012e: ldflda UnityEngine.Vector3 TheForestOfLove.TransformOffset::offset
IL_0133: ldfld System.Single UnityEngine.Vector3::y
IL_0138: ldarg.0
IL_0139: ldfld TheForestOfLove.TransformOffset TheForestOfLove.PlayerSwimTransition::swimEntryWater
IL_013e: ldflda UnityEngine.Vector3 TheForestOfLove.TransformOffset::offset
IL_0143: ldfld System.Single UnityEngine.Vector3::z
IL_0148: newobj System.Void UnityEngine.Vector3::.ctor(System.Single,System.Single,System.Single)
IL_014d: call UnityEngine.Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)
IL_0152: callvirt System.Void UnityEngine.Transform::set_position(UnityEngine.Vector3)
IL_0157: ldsfld TheForestOfLove.Player TheForestOfLove.Player::current
IL_015c: callvirt System.Void TheForestOfLove.Player::Swim()
IL_0161: ldarg.0
IL_0162: ldfld TheForestOfLove.PlayerSwimTransitionWaterEffects TheForestOfLove.PlayerSwimTransition::waterEffects
IL_0167: ldarg.0
IL_0168: call UnityEngine.Transform UnityEngine.Component::get_transform()
IL_016d: callvirt System.Void TheForestOfLove.PlayerSwimTransitionWaterEffects::BeginEntrySplash(UnityEngine.Transform)
IL_0172: br.s IL_01e8
IL_0174: ldarg.0
IL_0175: call UnityEngine.Transform UnityEngine.Component::get_transform()
IL_017a: callvirt UnityEngine.Vector3 UnityEngine.Transform::get_localScale()
IL_017f: ldfld System.Single UnityEngine.Vector3::x
IL_0184: stloc.s V_5
IL_0186: ldsfld TheForestOfLove.Player TheForestOfLove.Player::current
IL_018b: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0190: ldarg.0
IL_0191: call UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0196: callvirt UnityEngine.Vector3 UnityEngine.Transform::get_position()
IL_019b: ldarg.0
IL_019c: ldfld TheForestOfLove.TransformOffset TheForestOfLove.PlayerSwimTransition::swimExitLand
IL_01a1: ldflda UnityEngine.Vector3 TheForestOfLove.TransformOffset::offset
IL_01a6: ldfld System.Single UnityEngine.Vector3::x
IL_01ab: ldloc.s V_5
IL_01ad: mul
IL_01ae: ldarg.0
IL_01af: ldfld TheForestOfLove.TransformOffset TheForestOfLove.PlayerSwimTransition::swimExitLand
IL_01b4: ldflda UnityEngine.Vector3 TheForestOfLove.TransformOffset::offset
IL_01b9: ldfld System.Single UnityEngine.Vector3::y
IL_01be: ldarg.0
IL_01bf: ldfld TheForestOfLove.TransformOffset TheForestOfLove.PlayerSwimTransition::swimExitLand
IL_01c4: ldflda UnityEngine.Vector3 TheForestOfLove.TransformOffset::offset
IL_01c9: ldfld System.Single UnityEngine.Vector3::z
IL_01ce: newobj System.Void UnityEngine.Vector3::.ctor(System.Single,System.Single,System.Single)
IL_01d3: call UnityEngine.Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)
IL_01d8: callvirt System.Void UnityEngine.Transform::set_position(UnityEngine.Vector3)
IL_01dd: ldsfld TheForestOfLove.Player TheForestOfLove.Player::current
IL_01e2: ldc.i4.1
IL_01e3: callvirt System.Void TheForestOfLove.Player::Idle(System.Boolean)
IL_01e8: ldarg.0
IL_01e9: call UnityEngine.Transform UnityEngine.Component::get_transform()
IL_01ee: ldloc.1
IL_01ef: callvirt System.Void UnityEngine.Transform::set_position(UnityEngine.Vector3)
IL_01f4: ldarg.0
IL_01f5: ldfld UnityEngine.Vector3 TheForestOfLove.PlayerSwimTransition::finalCameraOffset
IL_01fa: ldarg.0
IL_01fb: ldfld TheForestOfLove.TransformOffset TheForestOfLove.PlayerSwimTransition::cameraTarget
IL_0200: ldfld UnityEngine.Vector3 TheForestOfLove.TransformOffset::offset
IL_0205: call UnityEngine.Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)
IL_020a: pop
IL_020b: ldarg.0
IL_020c: ldfld TheForestOfLove.TransformOffset TheForestOfLove.PlayerSwimTransition::cameraTarget
IL_0211: ldfld UnityEngine.Vector3 TheForestOfLove.TransformOffset::offset
IL_0216: ldarg.0
IL_0217: ldfld UnityEngine.Vector3 TheForestOfLove.PlayerSwimTransition::finalCameraOffset
IL_021c: call System.Single UnityEngine.Time::get_deltaTime()
IL_0221: ldarg.0
IL_0222: ldfld System.Single TheForestOfLove.PlayerSwimTransition::jumpSpeed
IL_0227: mul
IL_0228: call UnityEngine.Vector3 UnityEngine.Vector3::Lerp(UnityEngine.Vector3,UnityEngine.Vector3,System.Single)
IL_022d: stloc.2
IL_022e: ldarg.0
IL_022f: ldfld TheForestOfLove.TransformOffset TheForestOfLove.PlayerSwimTransition::cameraTarget
IL_0234: ldloc.2
IL_0235: stfld UnityEngine.Vector3 TheForestOfLove.TransformOffset::offset
IL_023a: ret
