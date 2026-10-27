TYPE UnityEngine.DebugLogHandler
METHOD System.Void UnityEngine.DebugLogHandler::.ctor() | attributes=Public, HideBySig, SpecialName, RTSpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void System.Object::.ctor()
IL_0006: nop
IL_0007: ret
TYPE UnityEngine.Logger
METHOD System.Void UnityEngine.Logger::.ctor(UnityEngine.ILogHandler) | attributes=Public, HideBySig, SpecialName, RTSpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void System.Object::.ctor()
IL_0006: nop
IL_0007: nop
IL_0008: ldarg.0
IL_0009: ldarg.1
IL_000a: call System.Void UnityEngine.Logger::set_logHandler(UnityEngine.ILogHandler)
IL_000f: nop
IL_0010: ldarg.0
IL_0011: ldc.i4.1
IL_0012: call System.Void UnityEngine.Logger::set_logEnabled(System.Boolean)
IL_0017: nop
IL_0018: ldarg.0
IL_0019: ldc.i4.3
IL_001a: call System.Void UnityEngine.Logger::set_filterLogType(UnityEngine.LogType)
IL_001f: nop
IL_0020: ret
TYPE UnityEngine.Logger
METHOD System.Void UnityEngine.Logger::Log(UnityEngine.LogType,System.Object) | attributes=Public, Final, Virtual, HideBySig, VtableLayoutMask | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: ldarg.1
IL_0003: call System.Boolean UnityEngine.Logger::IsLogTypeAllowed(UnityEngine.LogType)
IL_0008: stloc.0
IL_0009: ldloc.0
IL_000a: brfalse.s IL_002e
IL_000c: ldarg.0
IL_000d: call UnityEngine.ILogHandler UnityEngine.Logger::get_logHandler()
IL_0012: ldarg.1
IL_0013: ldnull
IL_0014: ldstr "{0}"
IL_0019: ldc.i4.1
IL_001a: newarr System.Object
IL_001f: dup
IL_0020: ldc.i4.0
IL_0021: ldarg.2
IL_0022: call System.String UnityEngine.Logger::GetString(System.Object)
IL_0027: stelem.ref
IL_0028: callvirt System.Void UnityEngine.ILogHandler::LogFormat(UnityEngine.LogType,UnityEngine.Object,System.String,System.Object[])
IL_002d: nop
IL_002e: ret
METHOD System.Void UnityEngine.Logger::Log(UnityEngine.LogType,System.Object,UnityEngine.Object) | attributes=Public, Final, Virtual, HideBySig, VtableLayoutMask | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: ldarg.1
IL_0003: call System.Boolean UnityEngine.Logger::IsLogTypeAllowed(UnityEngine.LogType)
IL_0008: stloc.0
IL_0009: ldloc.0
IL_000a: brfalse.s IL_002e
IL_000c: ldarg.0
IL_000d: call UnityEngine.ILogHandler UnityEngine.Logger::get_logHandler()
IL_0012: ldarg.1
IL_0013: ldarg.3
IL_0014: ldstr "{0}"
IL_0019: ldc.i4.1
IL_001a: newarr System.Object
IL_001f: dup
IL_0020: ldc.i4.0
IL_0021: ldarg.2
IL_0022: call System.String UnityEngine.Logger::GetString(System.Object)
IL_0027: stelem.ref
IL_0028: callvirt System.Void UnityEngine.ILogHandler::LogFormat(UnityEngine.LogType,UnityEngine.Object,System.String,System.Object[])
IL_002d: nop
IL_002e: ret
