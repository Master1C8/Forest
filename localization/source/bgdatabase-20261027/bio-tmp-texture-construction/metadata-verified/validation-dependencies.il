TYPE UnityEngine.Object
METHOD System.Void UnityEngine.Object::.ctor() | attributes=Public, HideBySig, SpecialName, RTSpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void System.Object::.ctor()
IL_0006: nop
IL_0007: ret
TYPE UnityEngine.SystemInfo
METHOD System.Boolean UnityEngine.SystemInfo::SupportsTextureFormat(UnityEngine.TextureFormat) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: box UnityEngine.TextureFormat
IL_0007: call System.Boolean UnityEngine.SystemInfo::IsValidEnumValue(System.Enum)
IL_000c: ldc.i4.0
IL_000d: ceq
IL_000f: stloc.0
IL_0010: ldloc.0
IL_0011: brfalse.s IL_001e
IL_0013: ldstr "Failed SupportsTextureFormat; format is not a valid TextureFormat"
IL_0018: newobj System.Void System.ArgumentException::.ctor(System.String)
IL_001d: throw
IL_001e: ldarg.0
IL_001f: call System.Boolean UnityEngine.SystemInfo::SupportsTextureFormatNative(UnityEngine.TextureFormat)
IL_0024: stloc.1
IL_0025: br.s IL_0027
IL_0027: ldloc.1
IL_0028: ret
TYPE UnityEngine.Experimental.Rendering.GraphicsFormatUtility
METHOD System.Boolean UnityEngine.Experimental.Rendering.GraphicsFormatUtility::IsCompressedTextureFormat(UnityEngine.TextureFormat) | attributes=Assembly, Static, HideBySig | impl=InternalCall
ATTRIBUTE UnityEngine.Bindings.FreeFunctionAttribute
TYPE UnityEngine.Experimental.Rendering.GraphicsFormatUtility
METHOD System.Boolean UnityEngine.Experimental.Rendering.GraphicsFormatUtility::CanDecompressFormat(UnityEngine.Experimental.Rendering.GraphicsFormat) | attributes=Assembly, Static, HideBySig | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: ldc.i4.1
IL_0003: call System.Boolean UnityEngine.Experimental.Rendering.GraphicsFormatUtility::CanDecompressFormat(UnityEngine.Experimental.Rendering.GraphicsFormat,System.Boolean)
IL_0008: stloc.0
IL_0009: br.s IL_000b
IL_000b: ldloc.0
IL_000c: ret
TYPE UnityEngine.Debug
METHOD System.Void UnityEngine.Debug::LogError(System.Object,UnityEngine.Object) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: nop
IL_0001: call UnityEngine.ILogger UnityEngine.Debug::get_unityLogger()
IL_0006: ldc.i4.0
IL_0007: ldarg.0
IL_0008: ldarg.1
IL_0009: callvirt System.Void UnityEngine.ILogger::Log(UnityEngine.LogType,System.Object,UnityEngine.Object)
IL_000e: nop
IL_000f: ret
TYPE UnityEngine.Experimental.Rendering.GraphicsFormatUtility
METHOD UnityEngine.Experimental.Rendering.GraphicsFormat UnityEngine.Experimental.Rendering.GraphicsFormatUtility::GetGraphicsFormat_Native_TextureFormat(UnityEngine.TextureFormat,System.Boolean) | attributes=Private, Static, HideBySig | impl=InternalCall
ATTRIBUTE UnityEngine.Bindings.FreeFunctionAttribute
TYPE UnityEngine.Texture2D
METHOD System.Boolean UnityEngine.Texture2D::Internal_CreateImpl(UnityEngine.Texture2D,System.Int32,System.Int32,System.Int32,UnityEngine.Experimental.Rendering.GraphicsFormat,UnityEngine.Experimental.Rendering.TextureCreationFlags,System.IntPtr) | attributes=Private, Static, HideBySig | impl=InternalCall
ATTRIBUTE UnityEngine.Bindings.FreeFunctionAttribute
TYPE UnityEngine.UnityException
METHOD System.Void UnityEngine.UnityException::.ctor(System.String) | attributes=Public, HideBySig, SpecialName, RTSpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: call System.Void System.SystemException::.ctor(System.String)
IL_0007: nop
IL_0008: nop
IL_0009: ldarg.0
IL_000a: ldc.i4 -2147467261
IL_000f: call System.Void System.Exception::set_HResult(System.Int32)
IL_0014: nop
IL_0015: ret
