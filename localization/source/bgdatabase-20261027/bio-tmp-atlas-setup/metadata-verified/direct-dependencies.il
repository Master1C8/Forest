TYPE UnityEngine.Texture2D
METHOD System.Void UnityEngine.Texture2D::.ctor(System.Int32,System.Int32,UnityEngine.TextureFormat,System.Boolean) | attributes=Public, HideBySig, SpecialName, RTSpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: ldarg.2
IL_0003: ldarg.3
IL_0004: ldarg.s mipChain
IL_0006: brtrue.s IL_000b
IL_0008: ldc.i4.1
IL_0009: br.s IL_000c
IL_000b: ldc.i4.m1
IL_000c: ldc.i4.0
IL_000d: ldsfld System.IntPtr System.IntPtr::Zero
IL_0012: call System.Void UnityEngine.Texture2D::.ctor(System.Int32,System.Int32,UnityEngine.TextureFormat,System.Int32,System.Boolean,System.IntPtr)
IL_0017: nop
IL_0018: nop
IL_0019: ret
TYPE UnityEngine.TextCore.GlyphRect
METHOD System.Void UnityEngine.TextCore.GlyphRect::.ctor(System.Int32,System.Int32,System.Int32,System.Int32) | attributes=Public, HideBySig, SpecialName, RTSpecialName | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: ldarg.1
IL_0003: stfld System.Int32 UnityEngine.TextCore.GlyphRect::m_X
IL_0008: ldarg.0
IL_0009: ldarg.2
IL_000a: stfld System.Int32 UnityEngine.TextCore.GlyphRect::m_Y
IL_000f: ldarg.0
IL_0010: ldarg.3
IL_0011: stfld System.Int32 UnityEngine.TextCore.GlyphRect::m_Width
IL_0016: ldarg.0
IL_0017: ldarg.s height
IL_0019: stfld System.Int32 UnityEngine.TextCore.GlyphRect::m_Height
IL_001e: ret
