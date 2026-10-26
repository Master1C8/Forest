METHOD System.Void ForestProbe::Awake() | attributes=Private, HideBySig | impl=IL
IL_0000: nop
IL_0001: ldstr "FOREST_STARTUP AWAKE_ENTER"
IL_0006: call System.Void UnityEngine.Debug::Log(System.Object)
IL_000b: nop
IL_000c: ldarg.0
IL_000d: call System.String UnityEngine.Application::get_dataPath()
IL_0012: ldstr "../.."
IL_0017: call System.String System.IO.Path::Combine(System.String,System.String)
IL_001c: call System.String System.IO.Path::GetFullPath(System.String)
IL_0021: stfld System.String ForestProbe::root
IL_0026: ldarg.0
IL_0027: call System.Single UnityEngine.Time::get_realtimeSinceStartup()
IL_002c: stfld System.Single ForestProbe::focusStarted
IL_0031: ldarg.0
IL_0032: ldftn System.Void ForestProbe::ObserveUnityFocusEvent(System.Boolean)
IL_0038: newobj System.Void System.Action`1<System.Boolean>::.ctor(System.Object,System.IntPtr)
IL_003d: call System.Void UnityEngine.Application::add_focusChanged(System.Action`1<System.Boolean>)
IL_0042: nop
IL_0043: ldarg.0
IL_0044: ldstr "awake"
IL_0049: ldstr "unknown"
IL_004e: call System.Void ForestProbe::ObserveFocus(System.String,System.String)
IL_0053: nop
IL_0054: ldstr "FOREST_PROBE_READY "
IL_0059: ldarg.0
IL_005a: ldfld System.String ForestProbe::root
IL_005f: ldstr " SAVES "
IL_0064: call System.String UnityEngine.Application::get_persistentDataPath()
IL_0069: call System.String System.String::Concat(System.String,System.String,System.String,System.String)
IL_006e: call System.Void UnityEngine.Debug::Log(System.Object)
IL_0073: nop
IL_0074: ret
