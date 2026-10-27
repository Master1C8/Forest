TYPE UnityEngine.Texture
METHOD System.Void UnityEngine.Texture::.ctor() | attributes=Family, HideBySig, SpecialName, RTSpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void UnityEngine.Object::.ctor()
IL_0006: nop
IL_0007: nop
IL_0008: ret
TYPE UnityEngine.Texture
METHOD System.Boolean UnityEngine.Texture::ValidateFormat(UnityEngine.TextureFormat) | attributes=Assembly, HideBySig | impl=IL
IL_0000: nop
IL_0001: ldarg.1
IL_0002: call System.Boolean UnityEngine.SystemInfo::SupportsTextureFormat(UnityEngine.TextureFormat)
IL_0007: stloc.0
IL_0008: ldloc.0
IL_0009: brfalse.s IL_0010
IL_000b: nop
IL_000c: ldc.i4.1
IL_000d: stloc.1
IL_000e: br.s IL_0053
IL_0010: ldarg.1
IL_0011: call System.Boolean UnityEngine.Experimental.Rendering.GraphicsFormatUtility::IsCompressedTextureFormat(UnityEngine.TextureFormat)
IL_0016: brfalse.s IL_0026
IL_0018: ldarg.1
IL_0019: ldc.i4.0
IL_001a: call UnityEngine.Experimental.Rendering.GraphicsFormat UnityEngine.Experimental.Rendering.GraphicsFormatUtility::GetGraphicsFormat(UnityEngine.TextureFormat,System.Boolean)
IL_001f: call System.Boolean UnityEngine.Experimental.Rendering.GraphicsFormatUtility::CanDecompressFormat(UnityEngine.Experimental.Rendering.GraphicsFormat)
IL_0024: br.s IL_0027
IL_0026: ldc.i4.0
IL_0027: stloc.2
IL_0028: ldloc.2
IL_0029: brfalse.s IL_0030
IL_002b: nop
IL_002c: ldc.i4.1
IL_002d: stloc.1
IL_002e: br.s IL_0053
IL_0030: nop
IL_0031: ldstr "Texture creation failed. '{0}' is not supported on this platform. Use 'SystemInfo.SupportsTextureFormat' C# API to check format support."
IL_0036: ldarga.s format
IL_0038: constrained. UnityEngine.TextureFormat
IL_003e: callvirt System.String System.Object::ToString()
IL_0043: call System.String System.String::Format(System.String,System.Object)
IL_0048: ldarg.0
IL_0049: call System.Void UnityEngine.Debug::LogError(System.Object,UnityEngine.Object)
IL_004e: nop
IL_004f: ldc.i4.0
IL_0050: stloc.1
IL_0051: br.s IL_0053
IL_0053: ldloc.1
IL_0054: ret
TYPE UnityEngine.Experimental.Rendering.GraphicsFormatUtility
METHOD UnityEngine.Experimental.Rendering.GraphicsFormat UnityEngine.Experimental.Rendering.GraphicsFormatUtility::GetGraphicsFormat(UnityEngine.TextureFormat,System.Boolean) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: ldarg.1
IL_0003: call UnityEngine.Experimental.Rendering.GraphicsFormat UnityEngine.Experimental.Rendering.GraphicsFormatUtility::GetGraphicsFormat_Native_TextureFormat(UnityEngine.TextureFormat,System.Boolean)
IL_0008: stloc.0
IL_0009: br.s IL_000b
IL_000b: ldloc.0
IL_000c: ret
TYPE UnityEngine.Experimental.Rendering.GraphicsFormatUtility
METHOD System.Boolean UnityEngine.Experimental.Rendering.GraphicsFormatUtility::IsCrunchFormat(UnityEngine.TextureFormat) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: ldc.i4.s 28
IL_0004: beq.s IL_0017
IL_0006: ldarg.0
IL_0007: ldc.i4.s 29
IL_0009: beq.s IL_0017
IL_000b: ldarg.0
IL_000c: ldc.i4.s 64
IL_000e: beq.s IL_0017
IL_0010: ldarg.0
IL_0011: ldc.i4.s 65
IL_0013: ceq
IL_0015: br.s IL_0018
IL_0017: ldc.i4.1
IL_0018: stloc.0
IL_0019: br.s IL_001b
IL_001b: ldloc.0
IL_001c: ret
TYPE UnityEngine.Texture2D
METHOD System.Void UnityEngine.Texture2D::Internal_Create(UnityEngine.Texture2D,System.Int32,System.Int32,System.Int32,UnityEngine.Experimental.Rendering.GraphicsFormat,UnityEngine.Experimental.Rendering.TextureCreationFlags,System.IntPtr) | attributes=Private, Static, HideBySig | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: ldarg.1
IL_0003: ldarg.2
IL_0004: ldarg.3
IL_0005: ldarg.s format
IL_0007: ldarg.s flags
IL_0009: ldarg.s nativeTex
IL_000b: call System.Boolean UnityEngine.Texture2D::Internal_CreateImpl(UnityEngine.Texture2D,System.Int32,System.Int32,System.Int32,UnityEngine.Experimental.Rendering.GraphicsFormat,UnityEngine.Experimental.Rendering.TextureCreationFlags,System.IntPtr)
IL_0010: ldc.i4.0
IL_0011: ceq
IL_0013: stloc.0
IL_0014: ldloc.0
IL_0015: brfalse.s IL_0022
IL_0017: ldstr "Failed to create texture because of invalid parameters."
IL_001c: newobj System.Void UnityEngine.UnityException::.ctor(System.String)
IL_0021: throw
IL_0022: ret
