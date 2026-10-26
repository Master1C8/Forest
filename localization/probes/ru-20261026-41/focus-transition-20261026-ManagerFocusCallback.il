TYPE Rewired.InputManager_Base
METHOD System.Void Rewired.InputManager_Base::OnApplicationFocus(System.Boolean) | attributes=Private, HideBySig | impl=IL
ATTRIBUTE Rewired.CustomObfuscation
IL_0000: ldarg.0
IL_0001: ldfld System.Boolean Rewired.InputManager_Base::_duplicateRIMError
IL_0006: brfalse.s IL_0027
IL_0008: ret
IL_0009: ldc.i4 -46142340
IL_000e: ldc.i4 -46142339
IL_0013: xor
IL_0014: switch IL_0009,IL_0027,IL_0034
IL_0025: br.s IL_0034
IL_0027: ldarg.1
IL_0028: call System.Void Rewired.ReInput::bznJUoHKVApHghlqpCKYJLbDytar(System.Boolean)
IL_002d: ldc.i4 -46142337
IL_0032: br.s IL_000e
IL_0034: ldarg.0
IL_0035: ldfld System.Boolean Rewired.InputManager_Base::initialized
IL_003a: pop
IL_003b: ret
METHOD System.Void Rewired.InputManager_Base::Update() | attributes=Private, HideBySig | impl=IL
ATTRIBUTE Rewired.CustomObfuscation
IL_0000: ldarg.0
IL_0001: ldfld System.Boolean Rewired.InputManager_Base::initialized
IL_0006: brfalse.s IL_005d
IL_0008: ldarg.0
IL_0009: ldfld System.Boolean Rewired.InputManager_Base::criticalError
IL_000e: brfalse.s IL_003e
IL_0010: ldc.i4 -1915232114
IL_0015: ldc.i4 -1915232115
IL_001a: xor
IL_001b: switch IL_003e,IL_0036,IL_0010,IL_005d,IL_0065
IL_0034: br.s IL_0065
IL_0036: ret
IL_0037: ldc.i4 -1915232119
IL_003c: br.s IL_0015
IL_003e: call System.Boolean Rewired.Utils.UnityTools::get_isEditor()
IL_0043: brfalse.s IL_0065
IL_0045: call System.Boolean UnityEngine.Application::get_isPlaying()
IL_004a: brtrue.s IL_0054
IL_004c: ldc.i4 -1915232116
IL_0051: dup
IL_0052: br.s IL_005a
IL_0054: ldc.i4 -1915232119
IL_0059: dup
IL_005a: pop
IL_005b: br.s IL_0015
IL_005d: ret
IL_005e: ldc.i4 -1915232115
IL_0063: br.s IL_0015
IL_0065: ldarg.0
IL_0066: ldc.i4.0
IL_0067: ldc.i4.1
IL_0068: call System.Void Rewired.InputManager_Base::DoUpdate(Rewired.UpdateLoopType,Rewired.Config.UpdateLoopSetting)
IL_006d: ret
METHOD System.Void Rewired.InputManager_Base::FixedUpdate() | attributes=Private, HideBySig | impl=IL
ATTRIBUTE Rewired.CustomObfuscation
IL_0000: ldarg.0
IL_0001: ldfld System.Boolean Rewired.InputManager_Base::initialized
IL_0006: brfalse.s IL_0036
IL_0008: ldarg.0
IL_0009: ldfld System.Boolean Rewired.InputManager_Base::criticalError
IL_000e: brfalse.s IL_003e
IL_0010: ldc.i4 -740182616
IL_0015: ldc.i4 -740182614
IL_001a: xor
IL_001b: switch IL_0065,IL_003e,IL_0036,IL_0010,IL_005d
IL_0034: br.s IL_0065
IL_0036: ret
IL_0037: ldc.i4 -740182613
IL_003c: br.s IL_0015
IL_003e: call System.Boolean Rewired.Utils.UnityTools::get_isEditor()
IL_0043: brfalse.s IL_0065
IL_0045: call System.Boolean UnityEngine.Application::get_isPlaying()
IL_004a: brtrue.s IL_0054
IL_004c: ldc.i4 -740182610
IL_0051: dup
IL_0052: br.s IL_005a
IL_0054: ldc.i4 -740182614
IL_0059: dup
IL_005a: pop
IL_005b: br.s IL_0015
IL_005d: ret
IL_005e: ldc.i4 -740182614
IL_0063: br.s IL_0015
IL_0065: ldarg.0
IL_0066: ldc.i4.1
IL_0067: ldc.i4.2
IL_0068: call System.Void Rewired.InputManager_Base::DoUpdate(Rewired.UpdateLoopType,Rewired.Config.UpdateLoopSetting)
IL_006d: ret
METHOD System.Void Rewired.InputManager_Base::LateUpdate() | attributes=Private, HideBySig | impl=IL
ATTRIBUTE Rewired.CustomObfuscation
IL_0000: ldarg.0
IL_0001: ldfld System.Boolean Rewired.InputManager_Base::initialized
IL_0006: brfalse.s IL_0043
IL_0008: ldc.i4 -1937245716
IL_000d: ldc.i4 -1937245715
IL_0012: xor
IL_0013: switch IL_0043,IL_004b,IL_0008,IL_002e,IL_0064
IL_002c: br.s IL_0064
IL_002e: call System.Boolean Rewired.Utils.UnityTools::get_isEditor()
IL_0033: brfalse.s IL_0065
IL_0035: call System.Boolean UnityEngine.Application::get_isPlaying()
IL_003a: brtrue.s IL_0065
IL_003c: ldc.i4 -1937245719
IL_0041: br.s IL_000d
IL_0043: ret
IL_0044: ldc.i4 -1937245714
IL_0049: br.s IL_000d
IL_004b: ldarg.0
IL_004c: ldfld System.Boolean Rewired.InputManager_Base::criticalError
IL_0051: brfalse.s IL_005b
IL_0053: ldc.i4 -1937245715
IL_0058: dup
IL_0059: br.s IL_0061
IL_005b: ldc.i4 -1937245714
IL_0060: dup
IL_0061: pop
IL_0062: br.s IL_000d
IL_0064: ret
IL_0065: call System.Void Rewired.ReInput::pPuAMWhRUfpgiCAKVHsYUVbvEgb()
IL_006a: leave.s IL_007c
IL_006c: stloc.0
IL_006d: ldarg.0
IL_006e: ldc.i4.1
IL_006f: ldstr "update (Late Update)"
IL_0074: ldloc.0
IL_0075: call System.Void Rewired.InputManager_Base::HandleException(Rewired.InputManager_Base/ExceptionPoint,System.String,System.Exception)
IL_007a: leave.s IL_007c
IL_007c: ret
METHOD System.Void Rewired.InputManager_Base::DoUpdate(Rewired.UpdateLoopType,Rewired.Config.UpdateLoopSetting) | attributes=Assembly, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Boolean Rewired.InputManager_Base::initialized
IL_0006: brfalse.s IL_0010
IL_0008: ldarg.0
IL_0009: ldfld System.Boolean Rewired.InputManager_Base::criticalError
IL_000e: brfalse.s IL_0011
IL_0010: ret
IL_0011: ldarg.0
IL_0012: callvirt System.Void Rewired.InputManager_Base::CheckRecompile()
IL_0017: ldc.i4 -853772332
IL_001c: ldc.i4 -853772331
IL_0021: xor
IL_0022: switch IL_0017,IL_0035,IL_0058
IL_0033: br.s IL_0058
IL_0035: ldarg.1
IL_0036: call System.Void Rewired.ReInput::HXpJWkBpkWGHVPusKmSTbEJtFhLg(Rewired.UpdateLoopType)
IL_003b: ldarg.0
IL_003c: ldfld Rewired.Data.UserData Rewired.InputManager_Base::_userData
IL_0041: callvirt Rewired.Data.ConfigVars Rewired.Data.UserData::get_ConfigVars()
IL_0046: ldfld Rewired.Config.UpdateLoopSetting Rewired.Data.ConfigVars::updateLoop
IL_004b: ldarg.2
IL_004c: and
IL_004d: brtrue.s IL_0058
IL_004f: leave.s IL_0085
IL_0051: ldc.i4 -853772329
IL_0056: br.s IL_001c
IL_0058: ldarg.1
IL_0059: call System.Void Rewired.ReInput::jSmUMfkZCZCZfiMnleEGJnwKIqT(Rewired.UpdateLoopType)
IL_005e: leave.s IL_0085
IL_0060: stloc.0
IL_0061: ldarg.0
IL_0062: ldc.i4.1
IL_0063: ldstr "update ("
IL_0068: ldarg.1
IL_0069: box Rewired.UpdateLoopType
IL_006e: callvirt System.String System.Object::ToString()
IL_0073: ldstr ")"
IL_0078: call System.String System.String::Concat(System.String,System.String,System.String)
IL_007d: ldloc.0
IL_007e: call System.Void Rewired.InputManager_Base::HandleException(Rewired.InputManager_Base/ExceptionPoint,System.String,System.Exception)
IL_0083: leave.s IL_0085
IL_0085: ret
