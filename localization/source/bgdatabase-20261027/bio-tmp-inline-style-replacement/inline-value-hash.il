TYPE TMPro.TMP_Text
METHOD System.Int32 TMPro.TMP_Text::GetStyleHashCode(System.Int32[]&,System.Int32,System.Int32&) | attributes=Private, HideBySig | impl=IL
IL_0000: ldc.i4.0
IL_0001: stloc.0
IL_0002: ldarg.3
IL_0003: ldc.i4.0
IL_0004: stind.i4
IL_0005: ldarg.2
IL_0006: stloc.1
IL_0007: br.s IL_0033
IL_0009: ldarg.1
IL_000a: ldind.ref
IL_000b: ldloc.1
IL_000c: ldelem.i4
IL_000d: ldc.i4.s 34
IL_000f: beq.s IL_002f
IL_0011: ldarg.1
IL_0012: ldind.ref
IL_0013: ldloc.1
IL_0014: ldelem.i4
IL_0015: ldc.i4.s 62
IL_0017: bne.un.s IL_001e
IL_0019: ldarg.3
IL_001a: ldloc.1
IL_001b: stind.i4
IL_001c: br.s IL_003a
IL_001e: ldloc.0
IL_001f: ldc.i4.5
IL_0020: shl
IL_0021: ldloc.0
IL_0022: add
IL_0023: ldarg.1
IL_0024: ldind.ref
IL_0025: ldloc.1
IL_0026: ldelem.i4
IL_0027: conv.u2
IL_0028: call System.Char TMPro.TMP_TextParsingUtilities::ToUpperASCIIFast(System.Char)
IL_002d: xor
IL_002e: stloc.0
IL_002f: ldloc.1
IL_0030: ldc.i4.1
IL_0031: add
IL_0032: stloc.1
IL_0033: ldloc.1
IL_0034: ldarg.1
IL_0035: ldind.ref
IL_0036: ldlen
IL_0037: conv.i4
IL_0038: blt.s IL_0009
IL_003a: ldloc.0
IL_003b: ret
