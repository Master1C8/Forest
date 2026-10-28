TYPE SickDev.DevConsole.DevConsole
METHOD System.Void SickDev.DevConsole.DevConsole::SubmitInputText() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call SickDev.DevConsole.ConsoleInput SickDev.DevConsole.DevConsole::get_input()
IL_0006: ldfld System.String SickDev.DevConsole.ConsoleInput::text
IL_000b: callvirt System.String System.String::Trim()
IL_0010: stloc.0
IL_0011: ldloc.0
IL_0012: ldsfld System.String System.String::Empty
IL_0017: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_001c: brfalse.s IL_001f
IL_001e: ret
IL_001f: ldarg.0
IL_0020: ldloca.s V_1
IL_0022: initobj SickDev.DevConsole.EntryData
IL_0028: ldloca.s V_1
IL_002a: ldstr "> "
IL_002f: ldloc.0
IL_0030: call System.String System.String::Concat(System.String,System.String)
IL_0035: stfld System.String SickDev.DevConsole.EntryData::text
IL_003a: ldloca.s V_1
IL_003c: ldstr "User input: no stack trace info available."
IL_0041: stfld System.String SickDev.DevConsole.EntryData::stackTrace
IL_0046: ldloc.1
IL_0047: call System.Void SickDev.DevConsole.DevConsole::Log(SickDev.DevConsole.EntryData)
IL_004c: ldarg.0
IL_004d: call SickDev.DevConsole.History SickDev.DevConsole.DevConsole::get_history()
IL_0052: ldloc.0
IL_0053: callvirt System.Boolean SickDev.DevConsole.History::CanEntryBeAdded(System.String)
IL_0058: brfalse.s IL_0076
IL_005a: ldarg.0
IL_005b: call SickDev.DevConsole.History SickDev.DevConsole.DevConsole::get_history()
IL_0060: ldloc.0
IL_0061: callvirt System.Void SickDev.DevConsole.History::UpdateLastEntry(System.String)
IL_0066: ldarg.0
IL_0067: call SickDev.DevConsole.History SickDev.DevConsole.DevConsole::get_history()
IL_006c: ldsfld System.String System.String::Empty
IL_0071: callvirt System.Void SickDev.DevConsole.Window`2<System.String,System.String>::Add(T)
IL_0076: ldarg.0
IL_0077: call SickDev.DevConsole.History SickDev.DevConsole.DevConsole::get_history()
IL_007c: callvirt System.Void SickDev.DevConsole.Window`2<System.String,System.String>::NavigateToLast()
IL_0081: ldarg.0
IL_0082: call SickDev.DevConsole.History SickDev.DevConsole.DevConsole::get_history()
IL_0087: callvirt System.Boolean SickDev.DevConsole.Window`2<System.String,System.String>::get_isOpen()
IL_008c: brfalse.s IL_009b
IL_008e: ldarg.0
IL_008f: call SickDev.DevConsole.History SickDev.DevConsole.DevConsole::get_history()
IL_0094: callvirt System.Void SickDev.DevConsole.Window`2<System.String,System.String>::Close()
IL_0099: br.s IL_00b3
IL_009b: ldarg.0
IL_009c: call SickDev.DevConsole.AutoComplete SickDev.DevConsole.DevConsole::get_autoComplete()
IL_00a1: callvirt System.Boolean SickDev.DevConsole.Window`2<System.Int32,SickDev.CommandSystem.Command>::get_isOpen()
IL_00a6: brfalse.s IL_00b3
IL_00a8: ldarg.0
IL_00a9: call SickDev.DevConsole.AutoComplete SickDev.DevConsole.DevConsole::get_autoComplete()
IL_00ae: callvirt System.Void SickDev.DevConsole.Window`2<System.Int32,SickDev.CommandSystem.Command>::Close()
IL_00b3: ldarg.0
IL_00b4: call SickDev.DevConsole.ConsoleInput SickDev.DevConsole.DevConsole::get_input()
IL_00b9: callvirt System.Void SickDev.DevConsole.ConsoleInput::Clear()
IL_00be: ldarg.0
IL_00bf: ldloc.0
IL_00c0: call System.Void SickDev.DevConsole.DevConsole::ExecuteIfCommand(System.String)
IL_00c5: ret
METHOD System.Void SickDev.DevConsole.DevConsole::Log(System.String) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldloca.s V_0
IL_0003: initobj SickDev.DevConsole.EntryData
IL_0009: ldloca.s V_0
IL_000b: ldarg.1
IL_000c: stfld System.String SickDev.DevConsole.EntryData::text
IL_0011: ldloc.0
IL_0012: call System.Void SickDev.DevConsole.DevConsole::Log(SickDev.DevConsole.EntryData)
IL_0017: ret
METHOD System.Void SickDev.DevConsole.DevConsole::Log(System.String,SickDev.DevConsole.EntryOptions) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldloca.s V_0
IL_0003: initobj SickDev.DevConsole.EntryData
IL_0009: ldloca.s V_0
IL_000b: ldarg.1
IL_000c: stfld System.String SickDev.DevConsole.EntryData::text
IL_0011: ldloca.s V_0
IL_0013: ldarg.2
IL_0014: stfld SickDev.DevConsole.EntryOptions SickDev.DevConsole.EntryData::options
IL_0019: ldloc.0
IL_001a: call System.Void SickDev.DevConsole.DevConsole::Log(SickDev.DevConsole.EntryData)
IL_001f: ret
METHOD System.Void SickDev.DevConsole.DevConsole::Log(SickDev.DevConsole.EntryData) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld SickDev.DevConsole.Logger SickDev.DevConsole.DevConsole::logger
IL_0006: ldarg.1
IL_0007: callvirt System.Void SickDev.DevConsole.Logger::AddEntry(SickDev.DevConsole.EntryData)
IL_000c: ret
METHOD System.Void SickDev.DevConsole.DevConsole::LogWarning(System.String) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldloca.s V_0
IL_0003: initobj SickDev.DevConsole.EntryData
IL_0009: ldloca.s V_0
IL_000b: ldarg.1
IL_000c: stfld System.String SickDev.DevConsole.EntryData::text
IL_0011: ldloc.0
IL_0012: call System.Void SickDev.DevConsole.DevConsole::LogWarning(SickDev.DevConsole.EntryData)
IL_0017: ret
METHOD System.Void SickDev.DevConsole.DevConsole::LogWarning(System.String,SickDev.DevConsole.EntryOptions) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldloca.s V_0
IL_0003: initobj SickDev.DevConsole.EntryData
IL_0009: ldloca.s V_0
IL_000b: ldarg.1
IL_000c: stfld System.String SickDev.DevConsole.EntryData::text
IL_0011: ldloca.s V_0
IL_0013: ldarg.2
IL_0014: stfld SickDev.DevConsole.EntryOptions SickDev.DevConsole.EntryData::options
IL_0019: ldloc.0
IL_001a: call System.Void SickDev.DevConsole.DevConsole::LogWarning(SickDev.DevConsole.EntryData)
IL_001f: ret
METHOD System.Void SickDev.DevConsole.DevConsole::LogWarning(SickDev.DevConsole.EntryData) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarga.s data
IL_0002: ldflda SickDev.DevConsole.EntryOptions SickDev.DevConsole.EntryData::options
IL_0007: call SickDev.DevConsole.Settings SickDev.DevConsole.DevConsole::get_settings()
IL_000c: ldfld UnityEngine.Color SickDev.DevConsole.Settings::warningColor
IL_0011: call System.Void SickDev.DevConsole.EntryOptions::set_color(UnityEngine.Color)
IL_0016: ldarga.s data
IL_0018: call SickDev.DevConsole.Settings SickDev.DevConsole.DevConsole::get_settings()
IL_001d: ldfld UnityEngine.Texture2D SickDev.DevConsole.Settings::warningIcon
IL_0022: stfld UnityEngine.Texture2D SickDev.DevConsole.EntryData::icon
IL_0027: ldarg.0
IL_0028: ldfld SickDev.DevConsole.Logger SickDev.DevConsole.DevConsole::logger
IL_002d: ldarg.1
IL_002e: callvirt System.Void SickDev.DevConsole.Logger::AddEntry(SickDev.DevConsole.EntryData)
IL_0033: ret
METHOD System.Void SickDev.DevConsole.DevConsole::LogError(System.String) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldloca.s V_0
IL_0003: initobj SickDev.DevConsole.EntryData
IL_0009: ldloca.s V_0
IL_000b: ldarg.1
IL_000c: stfld System.String SickDev.DevConsole.EntryData::text
IL_0011: ldloc.0
IL_0012: call System.Void SickDev.DevConsole.DevConsole::LogError(SickDev.DevConsole.EntryData)
IL_0017: ret
METHOD System.Void SickDev.DevConsole.DevConsole::LogError(System.String,SickDev.DevConsole.EntryOptions) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldloca.s V_0
IL_0003: initobj SickDev.DevConsole.EntryData
IL_0009: ldloca.s V_0
IL_000b: ldarg.1
IL_000c: stfld System.String SickDev.DevConsole.EntryData::text
IL_0011: ldloca.s V_0
IL_0013: ldarg.2
IL_0014: stfld SickDev.DevConsole.EntryOptions SickDev.DevConsole.EntryData::options
IL_0019: ldloc.0
IL_001a: call System.Void SickDev.DevConsole.DevConsole::LogError(SickDev.DevConsole.EntryData)
IL_001f: ret
METHOD System.Void SickDev.DevConsole.DevConsole::LogError(SickDev.DevConsole.EntryData) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarga.s data
IL_0002: ldflda SickDev.DevConsole.EntryOptions SickDev.DevConsole.EntryData::options
IL_0007: call SickDev.DevConsole.Settings SickDev.DevConsole.DevConsole::get_settings()
IL_000c: ldfld UnityEngine.Color SickDev.DevConsole.Settings::errorColor
IL_0011: call System.Void SickDev.DevConsole.EntryOptions::set_color(UnityEngine.Color)
IL_0016: ldarga.s data
IL_0018: call SickDev.DevConsole.Settings SickDev.DevConsole.DevConsole::get_settings()
IL_001d: ldfld UnityEngine.Texture2D SickDev.DevConsole.Settings::errorIcon
IL_0022: stfld UnityEngine.Texture2D SickDev.DevConsole.EntryData::icon
IL_0027: ldarg.0
IL_0028: ldfld SickDev.DevConsole.Logger SickDev.DevConsole.DevConsole::logger
IL_002d: ldarg.1
IL_002e: callvirt System.Void SickDev.DevConsole.Logger::AddEntry(SickDev.DevConsole.EntryData)
IL_0033: ret
METHOD System.Void SickDev.DevConsole.DevConsole::ExecuteIfCommand(System.String) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call SickDev.CommandSystem.CommandsManager SickDev.DevConsole.DevConsole::get_commandsManager()
IL_0006: ldarg.1
IL_0007: callvirt SickDev.CommandSystem.CommandExecuter SickDev.CommandSystem.CommandsManager::GetCommandExecuter(System.String)
IL_000c: stloc.0
IL_000d: ldloc.0
IL_000e: callvirt System.Boolean SickDev.CommandSystem.CommandExecuter::get_isValidCommand()
IL_0013: brfalse.s IL_003c
IL_0015: ldloc.0
IL_0016: callvirt System.Object SickDev.CommandSystem.CommandExecuter::Execute()
IL_001b: stloc.1
IL_001c: ldloc.0
IL_001d: callvirt System.Boolean SickDev.CommandSystem.CommandExecuter::get_hasReturnValue()
IL_0022: brfalse.s IL_0033
IL_0024: ldarg.0
IL_0025: ldloc.1
IL_0026: call System.String SickDev.DevConsole.DevConsole::ConvertCommandResultToString(System.Object)
IL_002b: stloc.2
IL_002c: ldarg.0
IL_002d: ldloc.2
IL_002e: call System.Void SickDev.DevConsole.DevConsole::Log(System.String)
IL_0033: leave.s IL_003c
IL_0035: call System.Void UnityEngine.Debug::LogException(System.Exception)
IL_003a: leave.s IL_003c
IL_003c: ret
METHOD System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call SickDev.CommandSystem.CommandsManager SickDev.DevConsole.DevConsole::get_commandsManager()
IL_0006: ldarg.1
IL_0007: callvirt System.Void SickDev.CommandSystem.CommandsManager::Add(SickDev.CommandSystem.Command)
IL_000c: ret
METHOD SickDev.CommandSystem.Command[] SickDev.DevConsole.DevConsole::GetCommands() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call SickDev.CommandSystem.CommandsManager SickDev.DevConsole.DevConsole::get_commandsManager()
IL_0006: callvirt SickDev.CommandSystem.Command[] SickDev.CommandSystem.CommandsManager::GetCommands()
IL_000b: ret
