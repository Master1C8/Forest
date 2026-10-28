TYPE SickDev.DevConsole.DevConsole
METHOD System.Void SickDev.DevConsole.DevConsole::OnEnable() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldftn System.Void SickDev.DevConsole.DevConsole::OnLogMessageReceived(System.String,System.String,UnityEngine.LogType)
IL_0007: newobj System.Void UnityEngine.Application/LogCallback::.ctor(System.Object,System.IntPtr)
IL_000c: call System.Void UnityEngine.Application::add_logMessageReceived(UnityEngine.Application/LogCallback)
IL_0011: ret
METHOD System.Void SickDev.DevConsole.DevConsole::OnDisable() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldftn System.Void SickDev.DevConsole.DevConsole::OnLogMessageReceived(System.String,System.String,UnityEngine.LogType)
IL_0007: newobj System.Void UnityEngine.Application/LogCallback::.ctor(System.Object,System.IntPtr)
IL_000c: call System.Void UnityEngine.Application::remove_logMessageReceived(UnityEngine.Application/LogCallback)
IL_0011: ret
METHOD System.Void SickDev.DevConsole.DevConsole::OnLogMessageReceived(System.String,System.String,UnityEngine.LogType) | attributes=Private, HideBySig | impl=IL
IL_0000: ldtoken SickDev.DevConsole.LogLevel
IL_0005: call System.Type System.Type::GetTypeFromHandle(System.RuntimeTypeHandle)
IL_000a: ldarga.s type
IL_000c: constrained. UnityEngine.LogType
IL_0012: callvirt System.String System.Object::ToString()
IL_0017: call System.Object System.Enum::Parse(System.Type,System.String)
IL_001c: unbox.any SickDev.DevConsole.LogLevel
IL_0021: stloc.0
IL_0022: call SickDev.DevConsole.Settings SickDev.DevConsole.DevConsole::get_settings()
IL_0027: ldfld SickDev.DevConsole.LogLevel SickDev.DevConsole.Settings::attachedLogLevel
IL_002c: ldloc.0
IL_002d: and
IL_002e: ldloc.0
IL_002f: bne.un.s IL_007a
IL_0031: ldloca.s V_1
IL_0033: ldarg.1
IL_0034: ldc.i4.1
IL_0035: newarr System.String
IL_003a: dup
IL_003b: ldc.i4.0
IL_003c: ldloca.s V_0
IL_003e: constrained. SickDev.DevConsole.LogLevel
IL_0044: callvirt System.String System.Object::ToString()
IL_0049: stelem.ref
IL_004a: call System.Void SickDev.DevConsole.EntryData::.ctor(System.String,System.String[])
IL_004f: ldloca.s V_1
IL_0051: ldarg.2
IL_0052: stfld System.String SickDev.DevConsole.EntryData::stackTrace
IL_0057: ldloc.0
IL_0058: ldc.i4.8
IL_0059: beq.s IL_005f
IL_005b: ldloc.0
IL_005c: ldc.i4.4
IL_005d: bne.un.s IL_0067
IL_005f: ldarg.0
IL_0060: ldloc.1
IL_0061: call System.Void SickDev.DevConsole.DevConsole::LogError(SickDev.DevConsole.EntryData)
IL_0066: ret
IL_0067: ldloc.0
IL_0068: ldc.i4.2
IL_0069: bne.un.s IL_0073
IL_006b: ldarg.0
IL_006c: ldloc.1
IL_006d: call System.Void SickDev.DevConsole.DevConsole::LogWarning(SickDev.DevConsole.EntryData)
IL_0072: ret
IL_0073: ldarg.0
IL_0074: ldloc.1
IL_0075: call System.Void SickDev.DevConsole.DevConsole::Log(SickDev.DevConsole.EntryData)
IL_007a: ret
