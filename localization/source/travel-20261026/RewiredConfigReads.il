TYPE Rewired.ReInput/ConfigHelper
METHOD System.Boolean Rewired.ReInput/ConfigHelper::get_alwaysUseUnityInput()
IL_0000: call System.Boolean Rewired.ReInput::CheckInitialized()
IL_0005: brtrue.s IL_0009
IL_0007: ldc.i4.0
IL_0008: ret
IL_0009: ldsfld Rewired.Data.UserData Rewired.ReInput::wWsgFeuqSUsgwwBPjdjpjPGupZZ
IL_000e: callvirt Rewired.Data.ConfigVars Rewired.Data.UserData::get_ConfigVars()
IL_0013: ldfld System.Boolean Rewired.Data.ConfigVars::alwaysUseUnityInput
IL_0018: ret
METHOD System.Boolean Rewired.ReInput/ConfigHelper::get_nativeKeyboardSupport()
IL_0000: call System.Boolean Rewired.ReInput::CheckInitialized()
IL_0005: brtrue.s IL_0009
IL_0007: ldc.i4.0
IL_0008: ret
IL_0009: ldsfld Rewired.Data.UserData Rewired.ReInput::wWsgFeuqSUsgwwBPjdjpjPGupZZ
IL_000e: callvirt Rewired.Data.ConfigVars Rewired.Data.UserData::get_ConfigVars()
IL_0013: callvirt System.Boolean Rewired.Data.ConfigVars::GetPlatformVar_useNativeKeyboard()
IL_0018: ret
METHOD System.Boolean Rewired.ReInput/ConfigHelper::get_ignoreInputWhenAppNotInFocus()
IL_0000: call System.Boolean Rewired.ReInput::CheckInitialized()
IL_0005: brtrue.s IL_0009
IL_0007: ldc.i4.0
IL_0008: ret
IL_0009: ldsfld Rewired.Data.UserData Rewired.ReInput::wWsgFeuqSUsgwwBPjdjpjPGupZZ
IL_000e: callvirt Rewired.Data.ConfigVars Rewired.Data.UserData::get_ConfigVars()
IL_0013: callvirt System.Boolean Rewired.Data.ConfigVars::GetPlatformVar_ignoreInputWhenAppNotInFocus()
IL_0018: ret
