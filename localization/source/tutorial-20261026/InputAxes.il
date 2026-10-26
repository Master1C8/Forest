TYPE TheForestOfLove.InputHelper
METHOD System.Void TheForestOfLove.InputHelper::UpdateRewiredInputMaps()
IL_0000: ldarg.0
IL_0001: ldfld Rewired.Player TheForestOfLove.InputHelper::player
IL_0006: ldfld Rewired.Player/ControllerHelper Rewired.Player::controllers
IL_000b: ldfld Rewired.Player/ControllerHelper/MapHelper Rewired.Player/ControllerHelper::maps
IL_0010: ldarg.0
IL_0011: ldfld System.Boolean TheForestOfLove.InputHelper::uiInputsDisabled
IL_0016: ldc.i4.0
IL_0017: ceq
IL_0019: ldstr "Menus"
IL_001e: callvirt System.Int32 Rewired.Player/ControllerHelper/MapHelper::SetMapsEnabled(System.Boolean,System.String)
IL_0023: pop
IL_0024: ret
METHOD System.Boolean TheForestOfLove.InputHelper::UpdateAxisInputFromTouchJoystick()
IL_0000: ldarg.0
IL_0001: ldfld Itelisoft.KOF.TheKingOfJoysticks TheForestOfLove.InputHelper::theKingOfJoysticks
IL_0006: ldnull
IL_0007: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_000c: brtrue.s IL_001b
IL_000e: ldarg.0
IL_000f: ldfld Itelisoft.KOF.TheKingOfJoysticks TheForestOfLove.InputHelper::theKingOfJoysticks
IL_0014: ldfld System.Boolean Itelisoft.KOF.TheKingOfJoysticks::inUse
IL_0019: brtrue.s IL_001d
IL_001b: ldc.i4.0
IL_001c: ret
IL_001d: ldloca.s V_0
IL_001f: ldarg.0
IL_0020: ldfld Itelisoft.KOF.TheKingOfJoysticks TheForestOfLove.InputHelper::theKingOfJoysticks
IL_0025: callvirt System.Single Itelisoft.KOF.TheKingOfJoysticks::GetAxisX()
IL_002a: ldarg.0
IL_002b: ldfld Itelisoft.KOF.TheKingOfJoysticks TheForestOfLove.InputHelper::theKingOfJoysticks
IL_0030: callvirt System.Single Itelisoft.KOF.TheKingOfJoysticks::GetAxisY()
IL_0035: ldc.r4 0
IL_003a: call System.Void UnityEngine.Vector3::.ctor(System.Single,System.Single,System.Single)
IL_003f: ldloc.0
IL_0040: ldfld System.Single UnityEngine.Vector3::x
IL_0045: ldc.r4 0
IL_004a: bge.un.s IL_0059
IL_004c: ldloc.0
IL_004d: ldfld System.Single UnityEngine.Vector3::x
IL_0052: ldc.r4 -0.19
IL_0057: bgt.s IL_0073
IL_0059: ldloc.0
IL_005a: ldfld System.Single UnityEngine.Vector3::x
IL_005f: ldc.r4 0
IL_0064: ble.un.s IL_007f
IL_0066: ldloc.0
IL_0067: ldfld System.Single UnityEngine.Vector3::x
IL_006c: ldc.r4 0.19
IL_0071: bge.un.s IL_007f
IL_0073: ldloca.s V_0
IL_0075: ldc.r4 0
IL_007a: stfld System.Single UnityEngine.Vector3::x
IL_007f: ldloc.0
IL_0080: ldfld System.Single UnityEngine.Vector3::y
IL_0085: ldc.r4 0
IL_008a: bge.un.s IL_0099
IL_008c: ldloc.0
IL_008d: ldfld System.Single UnityEngine.Vector3::y
IL_0092: ldc.r4 -0.19
IL_0097: bgt.s IL_00b3
IL_0099: ldloc.0
IL_009a: ldfld System.Single UnityEngine.Vector3::y
IL_009f: ldc.r4 0
IL_00a4: ble.un.s IL_00bf
IL_00a6: ldloc.0
IL_00a7: ldfld System.Single UnityEngine.Vector3::y
IL_00ac: ldc.r4 0.19
IL_00b1: bge.un.s IL_00bf
IL_00b3: ldloca.s V_0
IL_00b5: ldc.r4 0
IL_00ba: stfld System.Single UnityEngine.Vector3::y
IL_00bf: ldloc.0
IL_00c0: call System.Boolean TheForestOfLove.InputHelper::TryUpdateAxisInput(UnityEngine.Vector3)
IL_00c5: ret
METHOD System.Boolean TheForestOfLove.InputHelper::UpdateAxisInputFromKeyboard()
IL_0000: ldarg.0
IL_0001: ldfld Rewired.Player TheForestOfLove.InputHelper::player
IL_0006: ldc.i4.0
IL_0007: ldc.i4.1
IL_0008: callvirt UnityEngine.Vector2 Rewired.Player::GetAxis2D(System.Int32,System.Int32)
IL_000d: call UnityEngine.Vector3 UnityEngine.Vector2::op_Implicit(UnityEngine.Vector2)
IL_0012: call System.Boolean TheForestOfLove.InputHelper::TryUpdateAxisInput(UnityEngine.Vector3)
IL_0017: ret
METHOD System.Boolean TheForestOfLove.InputHelper::TryUpdateAxisInput(UnityEngine.Vector3)
IL_0000: ldarga.s axisInput
IL_0002: call System.Single UnityEngine.Vector3::get_magnitude()
IL_0007: ldc.r4 0
IL_000c: ble.un.s IL_0016
IL_000e: ldarg.0
IL_000f: call System.Void TheForestOfLove.InputHelper::UpdateAxisInput(UnityEngine.Vector3)
IL_0014: ldc.i4.1
IL_0015: ret
IL_0016: ldc.i4.0
IL_0017: ret
METHOD System.Void TheForestOfLove.InputHelper::UpdateAxisInput(UnityEngine.Vector3)
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.InputHelper::set_FullAxis(UnityEngine.Vector3)
IL_0006: ldarg.0
IL_0007: ldfld System.Single UnityEngine.Vector3::x
IL_000c: call System.Void TheForestOfLove.InputHelper::set_HorizontalAxis(System.Single)
IL_0011: ldarg.0
IL_0012: ldfld System.Single UnityEngine.Vector3::y
IL_0017: call System.Void TheForestOfLove.InputHelper::set_VerticalAxis(System.Single)
IL_001c: ret
