TYPE UnityEngine.SystemInfo
METHOD System.Boolean UnityEngine.SystemInfo::IsValidEnumValue(System.Enum) | attributes=Private, Static, HideBySig | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: callvirt System.Type System.Object::GetType()
IL_0007: ldarg.0
IL_0008: call System.Boolean System.Enum::IsDefined(System.Type,System.Object)
IL_000d: ldc.i4.0
IL_000e: ceq
IL_0010: stloc.0
IL_0011: ldloc.0
IL_0012: brfalse.s IL_0018
IL_0014: ldc.i4.0
IL_0015: stloc.1
IL_0016: br.s IL_001c
IL_0018: ldc.i4.1
IL_0019: stloc.1
IL_001a: br.s IL_001c
IL_001c: ldloc.1
IL_001d: ret
TYPE UnityEngine.SystemInfo
METHOD System.Boolean UnityEngine.SystemInfo::SupportsTextureFormatNative(UnityEngine.TextureFormat) | attributes=Private, Static, HideBySig | impl=InternalCall
ATTRIBUTE UnityEngine.Bindings.FreeFunctionAttribute
TYPE UnityEngine.Experimental.Rendering.GraphicsFormatUtility
METHOD System.Boolean UnityEngine.Experimental.Rendering.GraphicsFormatUtility::CanDecompressFormat(UnityEngine.Experimental.Rendering.GraphicsFormat,System.Boolean) | attributes=Private, Static, HideBySig | impl=InternalCall
ATTRIBUTE UnityEngine.Bindings.FreeFunctionAttribute
