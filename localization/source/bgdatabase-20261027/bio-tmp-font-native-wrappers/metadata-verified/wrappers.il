TYPE UnityEngine.Material
METHOD System.Single UnityEngine.Material::GetFloat(System.Int32) | attributes=Public, HideBySig | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: ldarg.1
IL_0003: call System.Single UnityEngine.Material::GetFloatImpl(System.Int32)
IL_0008: stloc.0
IL_0009: br.s IL_000b
IL_000b: ldloc.0
IL_000c: ret
TYPE UnityEngine.Object
METHOD System.String UnityEngine.Object::get_name() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: call System.String UnityEngine.Object::GetName(UnityEngine.Object)
IL_0007: stloc.0
IL_0008: br.s IL_000a
IL_000a: ldloc.0
IL_000b: ret
TYPE UnityEngine.Debug
METHOD System.Void UnityEngine.Debug::Log(System.Object,UnityEngine.Object) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: nop
IL_0001: call UnityEngine.ILogger UnityEngine.Debug::get_unityLogger()
IL_0006: ldc.i4.3
IL_0007: ldarg.0
IL_0008: ldarg.1
IL_0009: callvirt System.Void UnityEngine.ILogger::Log(UnityEngine.LogType,System.Object,UnityEngine.Object)
IL_000e: nop
IL_000f: ret
TYPE UnityEngine.Debug
METHOD System.Void UnityEngine.Debug::Log(System.Object) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: nop
IL_0001: call UnityEngine.ILogger UnityEngine.Debug::get_unityLogger()
IL_0006: ldc.i4.3
IL_0007: ldarg.0
IL_0008: callvirt System.Void UnityEngine.ILogger::Log(UnityEngine.LogType,System.Object)
IL_000d: nop
IL_000e: ret
TYPE UnityEngine.Debug
METHOD System.Void UnityEngine.Debug::LogWarning(System.Object,UnityEngine.Object) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: nop
IL_0001: call UnityEngine.ILogger UnityEngine.Debug::get_unityLogger()
IL_0006: ldc.i4.2
IL_0007: ldarg.0
IL_0008: ldarg.1
IL_0009: callvirt System.Void UnityEngine.ILogger::Log(UnityEngine.LogType,System.Object,UnityEngine.Object)
IL_000e: nop
IL_000f: ret
