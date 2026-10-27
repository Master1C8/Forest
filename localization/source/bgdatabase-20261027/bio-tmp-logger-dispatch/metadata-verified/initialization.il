TYPE UnityEngine.Debug
METHOD System.Void UnityEngine.Debug::.cctor() | attributes=Private, Static, HideBySig, SpecialName, RTSpecialName | impl=IL
IL_0000: newobj System.Void UnityEngine.DebugLogHandler::.ctor()
IL_0005: newobj System.Void UnityEngine.Logger::.ctor(UnityEngine.ILogHandler)
IL_000a: stsfld UnityEngine.ILogger UnityEngine.Debug::s_DefaultLogger
IL_000f: newobj System.Void UnityEngine.DebugLogHandler::.ctor()
IL_0014: newobj System.Void UnityEngine.Logger::.ctor(UnityEngine.ILogHandler)
IL_0019: stsfld UnityEngine.ILogger UnityEngine.Debug::s_Logger
IL_001e: ret
