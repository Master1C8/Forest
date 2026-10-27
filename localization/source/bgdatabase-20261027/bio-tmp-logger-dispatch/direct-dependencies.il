TYPE UnityEngine.Logger
METHOD System.Void UnityEngine.Logger::set_logHandler(UnityEngine.ILogHandler) | attributes=Public, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: stfld UnityEngine.ILogHandler UnityEngine.Logger::<logHandler>k__BackingField
IL_0007: ret
TYPE UnityEngine.Logger
METHOD System.Void UnityEngine.Logger::set_logEnabled(System.Boolean) | attributes=Public, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: stfld System.Boolean UnityEngine.Logger::<logEnabled>k__BackingField
IL_0007: ret
TYPE UnityEngine.Logger
METHOD System.Void UnityEngine.Logger::set_filterLogType(UnityEngine.LogType) | attributes=Public, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: stfld UnityEngine.LogType UnityEngine.Logger::<filterLogType>k__BackingField
IL_0007: ret
TYPE UnityEngine.Logger
METHOD System.Boolean UnityEngine.Logger::IsLogTypeAllowed(UnityEngine.LogType) | attributes=Public, Final, Virtual, HideBySig, VtableLayoutMask | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: call System.Boolean UnityEngine.Logger::get_logEnabled()
IL_0007: stloc.0
IL_0008: ldloc.0
IL_0009: brfalse.s IL_0038
IL_000b: nop
IL_000c: ldarg.1
IL_000d: ldc.i4.4
IL_000e: ceq
IL_0010: stloc.1
IL_0011: ldloc.1
IL_0012: brfalse.s IL_0018
IL_0014: ldc.i4.1
IL_0015: stloc.2
IL_0016: br.s IL_003c
IL_0018: ldarg.0
IL_0019: call UnityEngine.LogType UnityEngine.Logger::get_filterLogType()
IL_001e: ldc.i4.4
IL_001f: ceq
IL_0021: ldc.i4.0
IL_0022: ceq
IL_0024: stloc.3
IL_0025: ldloc.3
IL_0026: brfalse.s IL_0037
IL_0028: ldarg.1
IL_0029: ldarg.0
IL_002a: call UnityEngine.LogType UnityEngine.Logger::get_filterLogType()
IL_002f: cgt
IL_0031: ldc.i4.0
IL_0032: ceq
IL_0034: stloc.2
IL_0035: br.s IL_003c
IL_0037: nop
IL_0038: ldc.i4.0
IL_0039: stloc.2
IL_003a: br.s IL_003c
IL_003c: ldloc.2
IL_003d: ret
TYPE UnityEngine.Logger
METHOD UnityEngine.ILogHandler UnityEngine.Logger::get_logHandler() | attributes=Public, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldarg.0
IL_0001: ldfld UnityEngine.ILogHandler UnityEngine.Logger::<logHandler>k__BackingField
IL_0006: ret
TYPE UnityEngine.Logger
METHOD System.String UnityEngine.Logger::GetString(System.Object) | attributes=Private, Static, HideBySig | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: ldnull
IL_0003: ceq
IL_0005: stloc.1
IL_0006: ldloc.1
IL_0007: brfalse.s IL_0012
IL_0009: nop
IL_000a: ldstr "Null"
IL_000f: stloc.2
IL_0010: br.s IL_003b
IL_0012: ldarg.0
IL_0013: isinst System.IFormattable
IL_0018: stloc.0
IL_0019: ldloc.0
IL_001a: ldnull
IL_001b: cgt.un
IL_001d: stloc.3
IL_001e: ldloc.3
IL_001f: brfalse.s IL_0031
IL_0021: nop
IL_0022: ldloc.0
IL_0023: ldnull
IL_0024: call System.Globalization.CultureInfo System.Globalization.CultureInfo::get_InvariantCulture()
IL_0029: callvirt System.String System.IFormattable::ToString(System.String,System.IFormatProvider)
IL_002e: stloc.2
IL_002f: br.s IL_003b
IL_0031: nop
IL_0032: ldarg.0
IL_0033: callvirt System.String System.Object::ToString()
IL_0038: stloc.2
IL_0039: br.s IL_003b
IL_003b: ldloc.2
IL_003c: ret
TYPE UnityEngine.ILogHandler
METHOD System.Void UnityEngine.ILogHandler::LogFormat(UnityEngine.LogType,UnityEngine.Object,System.String,System.Object[]) | attributes=Public, Virtual, HideBySig, VtableLayoutMask, Abstract | impl=IL
TYPE UnityEngine.DebugLogHandler
METHOD System.Void UnityEngine.DebugLogHandler::LogFormat(UnityEngine.LogType,UnityEngine.Object,System.String,System.Object[]) | attributes=Public, Final, Virtual, HideBySig, VtableLayoutMask | impl=IL
IL_0000: nop
IL_0001: ldarg.1
IL_0002: ldc.i4.0
IL_0003: ldarg.3
IL_0004: ldarg.s args
IL_0006: call System.String System.String::Format(System.String,System.Object[])
IL_000b: ldarg.2
IL_000c: call System.Void UnityEngine.DebugLogHandler::Internal_Log(UnityEngine.LogType,UnityEngine.LogOption,System.String,UnityEngine.Object)
IL_0011: nop
IL_0012: ret
