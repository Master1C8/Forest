TYPE UnityEngine.Texture2D
METHOD System.Void UnityEngine.Texture2D::.ctor(System.Int32,System.Int32,UnityEngine.TextureFormat,System.Int32,System.Boolean,System.IntPtr) | attributes=Assembly, HideBySig, SpecialName, RTSpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void UnityEngine.Texture::.ctor()
IL_0006: nop
IL_0007: nop
IL_0008: ldarg.0
IL_0009: ldarg.3
IL_000a: call System.Boolean UnityEngine.Texture::ValidateFormat(UnityEngine.TextureFormat)
IL_000f: ldc.i4.0
IL_0010: ceq
IL_0012: stloc.2
IL_0013: ldloc.2
IL_0014: brfalse.s IL_0018
IL_0016: br.s IL_004c
IL_0018: ldarg.3
IL_0019: ldarg.s linear
IL_001b: ldc.i4.0
IL_001c: ceq
IL_001e: call UnityEngine.Experimental.Rendering.GraphicsFormat UnityEngine.Experimental.Rendering.GraphicsFormatUtility::GetGraphicsFormat(UnityEngine.TextureFormat,System.Boolean)
IL_0023: stloc.0
IL_0024: ldarg.s mipCount
IL_0026: ldc.i4.1
IL_0027: bne.un.s IL_002c
IL_0029: ldc.i4.0
IL_002a: br.s IL_002d
IL_002c: ldc.i4.1
IL_002d: stloc.1
IL_002e: ldarg.3
IL_002f: call System.Boolean UnityEngine.Experimental.Rendering.GraphicsFormatUtility::IsCrunchFormat(UnityEngine.TextureFormat)
IL_0034: stloc.3
IL_0035: ldloc.3
IL_0036: brfalse.s IL_003d
IL_0038: ldloc.1
IL_0039: ldc.i4.s 64
IL_003b: or
IL_003c: stloc.1
IL_003d: ldarg.0
IL_003e: ldarg.1
IL_003f: ldarg.2
IL_0040: ldarg.s mipCount
IL_0042: ldloc.0
IL_0043: ldloc.1
IL_0044: ldarg.s nativeTex
IL_0046: call System.Void UnityEngine.Texture2D::Internal_Create(UnityEngine.Texture2D,System.Int32,System.Int32,System.Int32,UnityEngine.Experimental.Rendering.GraphicsFormat,UnityEngine.Experimental.Rendering.TextureCreationFlags,System.IntPtr)
IL_004b: nop
IL_004c: ret
