TYPE TMPro.TMP_Text
METHOD System.Int32 TMPro.TMP_Text::GetUTF16(System.Int32[],System.Int32) | attributes=Family, HideBySig | impl=IL
IL_0000: ldc.i4.0
IL_0001: ldarg.0
IL_0002: ldarg.1
IL_0003: ldarg.2
IL_0004: ldelem.i4
IL_0005: conv.u2
IL_0006: call System.Int32 TMPro.TMP_Text::HexToInt(System.Char)
IL_000b: ldc.i4.s 12
IL_000d: shl
IL_000e: add
IL_000f: ldarg.0
IL_0010: ldarg.1
IL_0011: ldarg.2
IL_0012: ldc.i4.1
IL_0013: add
IL_0014: ldelem.i4
IL_0015: conv.u2
IL_0016: call System.Int32 TMPro.TMP_Text::HexToInt(System.Char)
IL_001b: ldc.i4.8
IL_001c: shl
IL_001d: add
IL_001e: ldarg.0
IL_001f: ldarg.1
IL_0020: ldarg.2
IL_0021: ldc.i4.2
IL_0022: add
IL_0023: ldelem.i4
IL_0024: conv.u2
IL_0025: call System.Int32 TMPro.TMP_Text::HexToInt(System.Char)
IL_002a: ldc.i4.4
IL_002b: shl
IL_002c: add
IL_002d: ldarg.0
IL_002e: ldarg.1
IL_002f: ldarg.2
IL_0030: ldc.i4.3
IL_0031: add
IL_0032: ldelem.i4
IL_0033: conv.u2
IL_0034: call System.Int32 TMPro.TMP_Text::HexToInt(System.Char)
IL_0039: add
IL_003a: ret
METHOD System.Int32 TMPro.TMP_Text::GetUTF32(System.Int32[],System.Int32) | attributes=Family, HideBySig | impl=IL
IL_0000: ldc.i4.0
IL_0001: ldarg.0
IL_0002: ldarg.1
IL_0003: ldarg.2
IL_0004: ldelem.i4
IL_0005: conv.u2
IL_0006: call System.Int32 TMPro.TMP_Text::HexToInt(System.Char)
IL_000b: ldc.i4.s 28
IL_000d: shl
IL_000e: add
IL_000f: ldarg.0
IL_0010: ldarg.1
IL_0011: ldarg.2
IL_0012: ldc.i4.1
IL_0013: add
IL_0014: ldelem.i4
IL_0015: conv.u2
IL_0016: call System.Int32 TMPro.TMP_Text::HexToInt(System.Char)
IL_001b: ldc.i4.s 24
IL_001d: shl
IL_001e: add
IL_001f: ldarg.0
IL_0020: ldarg.1
IL_0021: ldarg.2
IL_0022: ldc.i4.2
IL_0023: add
IL_0024: ldelem.i4
IL_0025: conv.u2
IL_0026: call System.Int32 TMPro.TMP_Text::HexToInt(System.Char)
IL_002b: ldc.i4.s 20
IL_002d: shl
IL_002e: add
IL_002f: ldarg.0
IL_0030: ldarg.1
IL_0031: ldarg.2
IL_0032: ldc.i4.3
IL_0033: add
IL_0034: ldelem.i4
IL_0035: conv.u2
IL_0036: call System.Int32 TMPro.TMP_Text::HexToInt(System.Char)
IL_003b: ldc.i4.s 16
IL_003d: shl
IL_003e: add
IL_003f: ldarg.0
IL_0040: ldarg.1
IL_0041: ldarg.2
IL_0042: ldc.i4.4
IL_0043: add
IL_0044: ldelem.i4
IL_0045: conv.u2
IL_0046: call System.Int32 TMPro.TMP_Text::HexToInt(System.Char)
IL_004b: ldc.i4.s 12
IL_004d: shl
IL_004e: add
IL_004f: ldarg.0
IL_0050: ldarg.1
IL_0051: ldarg.2
IL_0052: ldc.i4.5
IL_0053: add
IL_0054: ldelem.i4
IL_0055: conv.u2
IL_0056: call System.Int32 TMPro.TMP_Text::HexToInt(System.Char)
IL_005b: ldc.i4.8
IL_005c: shl
IL_005d: add
IL_005e: ldarg.0
IL_005f: ldarg.1
IL_0060: ldarg.2
IL_0061: ldc.i4.6
IL_0062: add
IL_0063: ldelem.i4
IL_0064: conv.u2
IL_0065: call System.Int32 TMPro.TMP_Text::HexToInt(System.Char)
IL_006a: ldc.i4.4
IL_006b: shl
IL_006c: add
IL_006d: ldarg.0
IL_006e: ldarg.1
IL_006f: ldarg.2
IL_0070: ldc.i4.7
IL_0071: add
IL_0072: ldelem.i4
IL_0073: conv.u2
IL_0074: call System.Int32 TMPro.TMP_Text::HexToInt(System.Char)
IL_0079: add
IL_007a: ret
