TYPE Rewired.ReInput/ConfigHelper
METHOD System.Boolean Rewired.ReInput/ConfigHelper::get_ignoreInputWhenAppNotInFocus()
IL_0000: call System.Boolean Rewired.ReInput::CheckInitialized()
IL_0005: brtrue.s IL_0009
IL_0007: ldc.i4.0
IL_0008: ret
IL_0009: ldsfld Rewired.Data.UserData Rewired.ReInput::wWsgFeuqSUsgwwBPjdjpjPGupZZ
IL_000e: callvirt Rewired.Data.ConfigVars Rewired.Data.UserData::get_ConfigVars()
IL_0013: callvirt System.Boolean Rewired.Data.ConfigVars::GetPlatformVar_ignoreInputWhenAppNotInFocus()
IL_0018: ret
METHOD System.Void Rewired.ReInput/ConfigHelper::set_ignoreInputWhenAppNotInFocus(System.Boolean)
IL_0000: call System.Boolean Rewired.ReInput::CheckInitialized()
IL_0005: brtrue.s IL_0031
IL_0007: ldc.i4 -1746433697
IL_000c: ldc.i4 -1746433699
IL_0011: xor
IL_0012: switch IL_004b,IL_0031,IL_0029,IL_0007
IL_0027: br.s IL_004b
IL_0029: ret
IL_002a: ldc.i4 -1746433700
IL_002f: br.s IL_000c
IL_0031: ldsfld Rewired.Data.UserData Rewired.ReInput::wWsgFeuqSUsgwwBPjdjpjPGupZZ
IL_0036: callvirt Rewired.Data.ConfigVars Rewired.Data.UserData::get_ConfigVars()
IL_003b: ldarg.1
IL_003c: callvirt System.Boolean Rewired.Data.ConfigVars::SetPlatformVar_ignoreInputWhenAppNotInFocus(System.Boolean)
IL_0041: brtrue.s IL_004b
IL_0043: ret
IL_0044: ldc.i4 -1746433699
IL_0049: br.s IL_000c
IL_004b: call System.Void Rewired.ReInput::qlBFRJWraZKrzfOnAGXcGDaGoOh()
IL_0050: ret
