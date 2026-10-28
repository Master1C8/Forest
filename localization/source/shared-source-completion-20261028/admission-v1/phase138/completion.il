TYPE SickDev.DevConsole.AutoComplete
METHOD System.Void SickDev.DevConsole.AutoComplete::ReloadCommands() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call SickDev.DevConsole.DevConsole SickDev.DevConsole.DevConsole::get_singleton()
IL_0006: callvirt SickDev.CommandSystem.Command[] SickDev.DevConsole.DevConsole::GetCommands()
IL_000b: stfld SickDev.CommandSystem.Command[] SickDev.DevConsole.AutoComplete::allCommands
IL_0010: ldarg.0
IL_0011: call System.Void SickDev.DevConsole.Window`2<System.Int32,SickDev.CommandSystem.Command>::Clear()
IL_0016: ldarg.0
IL_0017: ldc.i4.0
IL_0018: stfld System.Boolean SickDev.DevConsole.AutoComplete::needsCommandReload
IL_001d: ldarg.0
IL_001e: ldarg.0
IL_001f: ldfld SickDev.CommandSystem.Command[] SickDev.DevConsole.AutoComplete::allCommands
IL_0024: newobj System.Void SickDev.DevConsole.AutoComplete/Matcher::.ctor(SickDev.CommandSystem.Command[])
IL_0029: stfld SickDev.DevConsole.AutoComplete/Matcher SickDev.DevConsole.AutoComplete::matcher
IL_002e: ldarg.0
IL_002f: call System.Void SickDev.DevConsole.AutoComplete::RebuildCommandsToShow()
IL_0034: ret
METHOD System.Void SickDev.DevConsole.AutoComplete::RebuildCommandsToShow() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Object SickDev.DevConsole.AutoComplete::lockObject
IL_0006: stloc.1
IL_0007: ldc.i4.0
IL_0008: stloc.2
IL_0009: ldloc.1
IL_000a: ldloca.s V_2
IL_000c: call System.Void System.Threading.Monitor::Enter(System.Object,System.Boolean&)
IL_0011: ldarg.0
IL_0012: ldfld System.Collections.Generic.List`1<SickDev.DevConsole.AutoComplete/JobInfo> SickDev.DevConsole.AutoComplete::jobs
IL_0017: callvirt System.Int32 System.Collections.Generic.List`1<SickDev.DevConsole.AutoComplete/JobInfo>::get_Count()
IL_001c: ldc.i4.0
IL_001d: ble.s IL_003d
IL_001f: ldarg.0
IL_0020: ldfld System.Collections.Generic.List`1<SickDev.DevConsole.AutoComplete/JobInfo> SickDev.DevConsole.AutoComplete::jobs
IL_0025: ldarg.0
IL_0026: ldfld System.Collections.Generic.List`1<SickDev.DevConsole.AutoComplete/JobInfo> SickDev.DevConsole.AutoComplete::jobs
IL_002b: callvirt System.Int32 System.Collections.Generic.List`1<SickDev.DevConsole.AutoComplete/JobInfo>::get_Count()
IL_0030: ldc.i4.1
IL_0031: sub
IL_0032: callvirt !0 System.Collections.Generic.List`1<SickDev.DevConsole.AutoComplete/JobInfo>::get_Item(System.Int32)
IL_0037: ldc.i4.0
IL_0038: stfld System.Boolean SickDev.DevConsole.AutoComplete/JobInfo::needed
IL_003d: newobj System.Void SickDev.DevConsole.AutoComplete/JobInfo::.ctor()
IL_0042: stloc.0
IL_0043: ldarg.0
IL_0044: ldfld System.Collections.Generic.List`1<SickDev.DevConsole.AutoComplete/JobInfo> SickDev.DevConsole.AutoComplete::jobs
IL_0049: ldloc.0
IL_004a: callvirt System.Void System.Collections.Generic.List`1<SickDev.DevConsole.AutoComplete/JobInfo>::Add(!0)
IL_004f: leave.s IL_005b
IL_0051: ldloc.2
IL_0052: brfalse.s IL_005a
IL_0054: ldloc.1
IL_0055: call System.Void System.Threading.Monitor::Exit(System.Object)
IL_005a: endfinally
IL_005b: call UnityEngine.RuntimePlatform UnityEngine.Application::get_platform()
IL_0060: ldc.i4.s 17
IL_0062: ceq
IL_0064: ldc.i4.0
IL_0065: ceq
IL_0067: brfalse.s IL_0081
IL_0069: ldarg.0
IL_006a: ldftn System.Void SickDev.DevConsole.AutoComplete::RebuildCommandsToShowThreaded(System.Object)
IL_0070: newobj System.Void System.Threading.ParameterizedThreadStart::.ctor(System.Object,System.IntPtr)
IL_0075: newobj System.Void System.Threading.Thread::.ctor(System.Threading.ParameterizedThreadStart)
IL_007a: ldloc.0
IL_007b: callvirt System.Void System.Threading.Thread::Start(System.Object)
IL_0080: ret
IL_0081: ldarg.0
IL_0082: ldloc.0
IL_0083: call System.Void SickDev.DevConsole.AutoComplete::RebuildCommandsToShowThreaded(System.Object)
IL_0088: ret
METHOD System.Void SickDev.DevConsole.AutoComplete::DrawEntry(UnityEngine.Rect,System.Int32) | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: ldarg.0
IL_0002: ldfld SickDev.CommandSystem.Command[] SickDev.DevConsole.AutoComplete::allCommands
IL_0007: ldarg.2
IL_0008: ldelem.ref
IL_0009: ldfld SickDev.CommandSystem.Signature SickDev.CommandSystem.Command::signature
IL_000e: callvirt System.String SickDev.CommandSystem.Signature::get_raw()
IL_0013: call UnityEngine.GUIStyle SickDev.DevConsole.GUIUtils::get_textStyle()
IL_0018: call System.Void UnityEngine.GUI::Label(UnityEngine.Rect,System.String,UnityEngine.GUIStyle)
IL_001d: ret
METHOD System.Void SickDev.DevConsole.AutoComplete::Select(System.Int32) | attributes=Private, HideBySig | impl=IL
IL_0000: call SickDev.DevConsole.DevConsole SickDev.DevConsole.DevConsole::get_singleton()
IL_0005: callvirt SickDev.DevConsole.ConsoleInput SickDev.DevConsole.DevConsole::get_input()
IL_000a: ldarg.0
IL_000b: ldfld SickDev.CommandSystem.Command[] SickDev.DevConsole.AutoComplete::allCommands
IL_0010: ldarg.1
IL_0011: ldelem.ref
IL_0012: callvirt System.String SickDev.CommandSystem.Command::get_name()
IL_0017: ldstr " "
IL_001c: call System.String System.String::Concat(System.String,System.String)
IL_0021: stfld System.String SickDev.DevConsole.ConsoleInput::text
IL_0026: call SickDev.DevConsole.DevConsole SickDev.DevConsole.DevConsole::get_singleton()
IL_002b: callvirt SickDev.DevConsole.ConsoleInput SickDev.DevConsole.DevConsole::get_input()
IL_0030: callvirt System.Void SickDev.DevConsole.ConsoleInput::MoveCursorToEnd()
IL_0035: ldarg.0
IL_0036: call System.Void SickDev.DevConsole.Window`2<System.Int32,SickDev.CommandSystem.Command>::Close()
IL_003b: ret
