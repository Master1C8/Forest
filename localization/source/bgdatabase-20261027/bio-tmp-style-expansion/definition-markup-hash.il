TYPE TMPro.TMP_Text
METHOD System.Int32 TMPro.TMP_Text::GetMarkupTagHashCode(System.Int32[],System.Int32) | attributes=Private, HideBySig | impl=IL
IL_0000: ldc.i4.0
IL_0001: stloc.0
IL_0002: ldarg.2
IL_0003: ldc.i4.s 16
IL_0005: add
IL_0006: stloc.1
IL_0007: ldarg.1
IL_0008: ldlen
IL_0009: conv.i4
IL_000a: stloc.2
IL_000b: br.s IL_0034
IL_000d: ldarg.1
IL_000e: ldarg.2
IL_000f: ldelem.i4
IL_0010: stloc.3
IL_0011: ldloc.3
IL_0012: ldc.i4.s 62
IL_0014: beq.s IL_0020
IL_0016: ldloc.3
IL_0017: ldc.i4.s 61
IL_0019: beq.s IL_0020
IL_001b: ldloc.3
IL_001c: ldc.i4.s 32
IL_001e: bne.un.s IL_0022
IL_0020: ldloc.0
IL_0021: ret
IL_0022: ldloc.0
IL_0023: ldc.i4.5
IL_0024: shl
IL_0025: ldloc.0
IL_0026: add
IL_0027: ldloc.3
IL_0028: call System.UInt32 TMPro.TMP_TextUtilities::ToUpperASCIIFast(System.UInt32)
IL_002d: xor
IL_002e: stloc.0
IL_002f: ldarg.2
IL_0030: ldc.i4.1
IL_0031: add
IL_0032: starg.s readIndex
IL_0034: ldarg.2
IL_0035: ldloc.1
IL_0036: bge.s IL_003c
IL_0038: ldarg.2
IL_0039: ldloc.2
IL_003a: blt.s IL_000d
IL_003c: ldloc.0
IL_003d: ret
