TYPE TMPro.TMP_Text
METHOD System.Int32 TMPro.TMP_Text::GetUTF16(System.String,System.Int32) | attributes=Family, HideBySig | impl=IL
IL_0000: ldc.i4.0
IL_0001: ldarg.0
IL_0002: ldarg.1
IL_0003: ldarg.2
IL_0004: callvirt System.Char System.String::get_Chars(System.Int32)
IL_0009: call System.Int32 TMPro.TMP_Text::HexToInt(System.Char)
IL_000e: ldc.i4.s 12
IL_0010: shl
IL_0011: add
IL_0012: ldarg.0
IL_0013: ldarg.1
IL_0014: ldarg.2
IL_0015: ldc.i4.1
IL_0016: add
IL_0017: callvirt System.Char System.String::get_Chars(System.Int32)
IL_001c: call System.Int32 TMPro.TMP_Text::HexToInt(System.Char)
IL_0021: ldc.i4.8
IL_0022: shl
IL_0023: add
IL_0024: ldarg.0
IL_0025: ldarg.1
IL_0026: ldarg.2
IL_0027: ldc.i4.2
IL_0028: add
IL_0029: callvirt System.Char System.String::get_Chars(System.Int32)
IL_002e: call System.Int32 TMPro.TMP_Text::HexToInt(System.Char)
IL_0033: ldc.i4.4
IL_0034: shl
IL_0035: add
IL_0036: ldarg.0
IL_0037: ldarg.1
IL_0038: ldarg.2
IL_0039: ldc.i4.3
IL_003a: add
IL_003b: callvirt System.Char System.String::get_Chars(System.Int32)
IL_0040: call System.Int32 TMPro.TMP_Text::HexToInt(System.Char)
IL_0045: add
IL_0046: ret
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
METHOD System.Int32 TMPro.TMP_Text::GetUTF16(System.UInt32[],System.Int32) | attributes=Assembly, HideBySig | impl=IL
IL_0000: ldc.i4.0
IL_0001: ldarg.0
IL_0002: ldarg.1
IL_0003: ldarg.2
IL_0004: ldelem.u4
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
IL_0014: ldelem.u4
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
IL_0023: ldelem.u4
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
IL_0032: ldelem.u4
IL_0033: conv.u2
IL_0034: call System.Int32 TMPro.TMP_Text::HexToInt(System.Char)
IL_0039: add
IL_003a: ret
METHOD System.Int32 TMPro.TMP_Text::GetUTF16(System.Text.StringBuilder,System.Int32) | attributes=Family, HideBySig | impl=IL
IL_0000: ldc.i4.0
IL_0001: ldarg.0
IL_0002: ldarg.1
IL_0003: ldarg.2
IL_0004: callvirt System.Char System.Text.StringBuilder::get_Chars(System.Int32)
IL_0009: call System.Int32 TMPro.TMP_Text::HexToInt(System.Char)
IL_000e: ldc.i4.s 12
IL_0010: shl
IL_0011: add
IL_0012: ldarg.0
IL_0013: ldarg.1
IL_0014: ldarg.2
IL_0015: ldc.i4.1
IL_0016: add
IL_0017: callvirt System.Char System.Text.StringBuilder::get_Chars(System.Int32)
IL_001c: call System.Int32 TMPro.TMP_Text::HexToInt(System.Char)
IL_0021: ldc.i4.8
IL_0022: shl
IL_0023: add
IL_0024: ldarg.0
IL_0025: ldarg.1
IL_0026: ldarg.2
IL_0027: ldc.i4.2
IL_0028: add
IL_0029: callvirt System.Char System.Text.StringBuilder::get_Chars(System.Int32)
IL_002e: call System.Int32 TMPro.TMP_Text::HexToInt(System.Char)
IL_0033: ldc.i4.4
IL_0034: shl
IL_0035: add
IL_0036: ldarg.0
IL_0037: ldarg.1
IL_0038: ldarg.2
IL_0039: ldc.i4.3
IL_003a: add
IL_003b: callvirt System.Char System.Text.StringBuilder::get_Chars(System.Int32)
IL_0040: call System.Int32 TMPro.TMP_Text::HexToInt(System.Char)
IL_0045: add
IL_0046: ret
METHOD System.Int32 TMPro.TMP_Text::GetUTF16(TMPro.TMP_Text/TextBackingContainer,System.Int32) | attributes=Private, HideBySig | impl=IL
IL_0000: ldc.i4.0
IL_0001: ldarg.0
IL_0002: ldarga.s text
IL_0004: ldarg.2
IL_0005: call System.UInt32 TMPro.TMP_Text/TextBackingContainer::get_Item(System.Int32)
IL_000a: conv.u2
IL_000b: call System.Int32 TMPro.TMP_Text::HexToInt(System.Char)
IL_0010: ldc.i4.s 12
IL_0012: shl
IL_0013: add
IL_0014: ldarg.0
IL_0015: ldarga.s text
IL_0017: ldarg.2
IL_0018: ldc.i4.1
IL_0019: add
IL_001a: call System.UInt32 TMPro.TMP_Text/TextBackingContainer::get_Item(System.Int32)
IL_001f: conv.u2
IL_0020: call System.Int32 TMPro.TMP_Text::HexToInt(System.Char)
IL_0025: ldc.i4.8
IL_0026: shl
IL_0027: add
IL_0028: ldarg.0
IL_0029: ldarga.s text
IL_002b: ldarg.2
IL_002c: ldc.i4.2
IL_002d: add
IL_002e: call System.UInt32 TMPro.TMP_Text/TextBackingContainer::get_Item(System.Int32)
IL_0033: conv.u2
IL_0034: call System.Int32 TMPro.TMP_Text::HexToInt(System.Char)
IL_0039: ldc.i4.4
IL_003a: shl
IL_003b: add
IL_003c: ldarg.0
IL_003d: ldarga.s text
IL_003f: ldarg.2
IL_0040: ldc.i4.3
IL_0041: add
IL_0042: call System.UInt32 TMPro.TMP_Text/TextBackingContainer::get_Item(System.Int32)
IL_0047: conv.u2
IL_0048: call System.Int32 TMPro.TMP_Text::HexToInt(System.Char)
IL_004d: add
IL_004e: ret
METHOD System.Int32 TMPro.TMP_Text::GetUTF32(System.String,System.Int32) | attributes=Family, HideBySig | impl=IL
IL_0000: ldc.i4.0
IL_0001: ldarg.0
IL_0002: ldarg.1
IL_0003: ldarg.2
IL_0004: callvirt System.Char System.String::get_Chars(System.Int32)
IL_0009: call System.Int32 TMPro.TMP_Text::HexToInt(System.Char)
IL_000e: ldc.i4.s 28
IL_0010: shl
IL_0011: add
IL_0012: ldarg.0
IL_0013: ldarg.1
IL_0014: ldarg.2
IL_0015: ldc.i4.1
IL_0016: add
IL_0017: callvirt System.Char System.String::get_Chars(System.Int32)
IL_001c: call System.Int32 TMPro.TMP_Text::HexToInt(System.Char)
IL_0021: ldc.i4.s 24
IL_0023: shl
IL_0024: add
IL_0025: ldarg.0
IL_0026: ldarg.1
IL_0027: ldarg.2
IL_0028: ldc.i4.2
IL_0029: add
IL_002a: callvirt System.Char System.String::get_Chars(System.Int32)
IL_002f: call System.Int32 TMPro.TMP_Text::HexToInt(System.Char)
IL_0034: ldc.i4.s 20
IL_0036: shl
IL_0037: add
IL_0038: ldarg.0
IL_0039: ldarg.1
IL_003a: ldarg.2
IL_003b: ldc.i4.3
IL_003c: add
IL_003d: callvirt System.Char System.String::get_Chars(System.Int32)
IL_0042: call System.Int32 TMPro.TMP_Text::HexToInt(System.Char)
IL_0047: ldc.i4.s 16
IL_0049: shl
IL_004a: add
IL_004b: ldarg.0
IL_004c: ldarg.1
IL_004d: ldarg.2
IL_004e: ldc.i4.4
IL_004f: add
IL_0050: callvirt System.Char System.String::get_Chars(System.Int32)
IL_0055: call System.Int32 TMPro.TMP_Text::HexToInt(System.Char)
IL_005a: ldc.i4.s 12
IL_005c: shl
IL_005d: add
IL_005e: ldarg.0
IL_005f: ldarg.1
IL_0060: ldarg.2
IL_0061: ldc.i4.5
IL_0062: add
IL_0063: callvirt System.Char System.String::get_Chars(System.Int32)
IL_0068: call System.Int32 TMPro.TMP_Text::HexToInt(System.Char)
IL_006d: ldc.i4.8
IL_006e: shl
IL_006f: add
IL_0070: ldarg.0
IL_0071: ldarg.1
IL_0072: ldarg.2
IL_0073: ldc.i4.6
IL_0074: add
IL_0075: callvirt System.Char System.String::get_Chars(System.Int32)
IL_007a: call System.Int32 TMPro.TMP_Text::HexToInt(System.Char)
IL_007f: ldc.i4.4
IL_0080: shl
IL_0081: add
IL_0082: ldarg.0
IL_0083: ldarg.1
IL_0084: ldarg.2
IL_0085: ldc.i4.7
IL_0086: add
IL_0087: callvirt System.Char System.String::get_Chars(System.Int32)
IL_008c: call System.Int32 TMPro.TMP_Text::HexToInt(System.Char)
IL_0091: add
IL_0092: ret
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
METHOD System.Int32 TMPro.TMP_Text::GetUTF32(System.UInt32[],System.Int32) | attributes=Assembly, HideBySig | impl=IL
IL_0000: ldc.i4.0
IL_0001: ldarg.0
IL_0002: ldarg.1
IL_0003: ldarg.2
IL_0004: ldelem.u4
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
IL_0014: ldelem.u4
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
IL_0024: ldelem.u4
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
IL_0034: ldelem.u4
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
IL_0044: ldelem.u4
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
IL_0054: ldelem.u4
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
IL_0063: ldelem.u4
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
IL_0072: ldelem.u4
IL_0073: conv.u2
IL_0074: call System.Int32 TMPro.TMP_Text::HexToInt(System.Char)
IL_0079: add
IL_007a: ret
METHOD System.Int32 TMPro.TMP_Text::GetUTF32(System.Text.StringBuilder,System.Int32) | attributes=Family, HideBySig | impl=IL
IL_0000: ldc.i4.0
IL_0001: ldarg.0
IL_0002: ldarg.1
IL_0003: ldarg.2
IL_0004: callvirt System.Char System.Text.StringBuilder::get_Chars(System.Int32)
IL_0009: call System.Int32 TMPro.TMP_Text::HexToInt(System.Char)
IL_000e: ldc.i4.s 28
IL_0010: shl
IL_0011: add
IL_0012: ldarg.0
IL_0013: ldarg.1
IL_0014: ldarg.2
IL_0015: ldc.i4.1
IL_0016: add
IL_0017: callvirt System.Char System.Text.StringBuilder::get_Chars(System.Int32)
IL_001c: call System.Int32 TMPro.TMP_Text::HexToInt(System.Char)
IL_0021: ldc.i4.s 24
IL_0023: shl
IL_0024: add
IL_0025: ldarg.0
IL_0026: ldarg.1
IL_0027: ldarg.2
IL_0028: ldc.i4.2
IL_0029: add
IL_002a: callvirt System.Char System.Text.StringBuilder::get_Chars(System.Int32)
IL_002f: call System.Int32 TMPro.TMP_Text::HexToInt(System.Char)
IL_0034: ldc.i4.s 20
IL_0036: shl
IL_0037: add
IL_0038: ldarg.0
IL_0039: ldarg.1
IL_003a: ldarg.2
IL_003b: ldc.i4.3
IL_003c: add
IL_003d: callvirt System.Char System.Text.StringBuilder::get_Chars(System.Int32)
IL_0042: call System.Int32 TMPro.TMP_Text::HexToInt(System.Char)
IL_0047: ldc.i4.s 16
IL_0049: shl
IL_004a: add
IL_004b: ldarg.0
IL_004c: ldarg.1
IL_004d: ldarg.2
IL_004e: ldc.i4.4
IL_004f: add
IL_0050: callvirt System.Char System.Text.StringBuilder::get_Chars(System.Int32)
IL_0055: call System.Int32 TMPro.TMP_Text::HexToInt(System.Char)
IL_005a: ldc.i4.s 12
IL_005c: shl
IL_005d: add
IL_005e: ldarg.0
IL_005f: ldarg.1
IL_0060: ldarg.2
IL_0061: ldc.i4.5
IL_0062: add
IL_0063: callvirt System.Char System.Text.StringBuilder::get_Chars(System.Int32)
IL_0068: call System.Int32 TMPro.TMP_Text::HexToInt(System.Char)
IL_006d: ldc.i4.8
IL_006e: shl
IL_006f: add
IL_0070: ldarg.0
IL_0071: ldarg.1
IL_0072: ldarg.2
IL_0073: ldc.i4.6
IL_0074: add
IL_0075: callvirt System.Char System.Text.StringBuilder::get_Chars(System.Int32)
IL_007a: call System.Int32 TMPro.TMP_Text::HexToInt(System.Char)
IL_007f: ldc.i4.4
IL_0080: shl
IL_0081: add
IL_0082: ldarg.0
IL_0083: ldarg.1
IL_0084: ldarg.2
IL_0085: ldc.i4.7
IL_0086: add
IL_0087: callvirt System.Char System.Text.StringBuilder::get_Chars(System.Int32)
IL_008c: call System.Int32 TMPro.TMP_Text::HexToInt(System.Char)
IL_0091: add
IL_0092: ret
METHOD System.Int32 TMPro.TMP_Text::GetUTF32(TMPro.TMP_Text/TextBackingContainer,System.Int32) | attributes=Private, HideBySig | impl=IL
IL_0000: ldc.i4.0
IL_0001: ldarg.0
IL_0002: ldarga.s text
IL_0004: ldarg.2
IL_0005: call System.UInt32 TMPro.TMP_Text/TextBackingContainer::get_Item(System.Int32)
IL_000a: conv.u2
IL_000b: call System.Int32 TMPro.TMP_Text::HexToInt(System.Char)
IL_0010: ldc.i4.s 28
IL_0012: shl
IL_0013: add
IL_0014: ldarg.0
IL_0015: ldarga.s text
IL_0017: ldarg.2
IL_0018: ldc.i4.1
IL_0019: add
IL_001a: call System.UInt32 TMPro.TMP_Text/TextBackingContainer::get_Item(System.Int32)
IL_001f: conv.u2
IL_0020: call System.Int32 TMPro.TMP_Text::HexToInt(System.Char)
IL_0025: ldc.i4.s 24
IL_0027: shl
IL_0028: add
IL_0029: ldarg.0
IL_002a: ldarga.s text
IL_002c: ldarg.2
IL_002d: ldc.i4.2
IL_002e: add
IL_002f: call System.UInt32 TMPro.TMP_Text/TextBackingContainer::get_Item(System.Int32)
IL_0034: conv.u2
IL_0035: call System.Int32 TMPro.TMP_Text::HexToInt(System.Char)
IL_003a: ldc.i4.s 20
IL_003c: shl
IL_003d: add
IL_003e: ldarg.0
IL_003f: ldarga.s text
IL_0041: ldarg.2
IL_0042: ldc.i4.3
IL_0043: add
IL_0044: call System.UInt32 TMPro.TMP_Text/TextBackingContainer::get_Item(System.Int32)
IL_0049: conv.u2
IL_004a: call System.Int32 TMPro.TMP_Text::HexToInt(System.Char)
IL_004f: ldc.i4.s 16
IL_0051: shl
IL_0052: add
IL_0053: ldarg.0
IL_0054: ldarga.s text
IL_0056: ldarg.2
IL_0057: ldc.i4.4
IL_0058: add
IL_0059: call System.UInt32 TMPro.TMP_Text/TextBackingContainer::get_Item(System.Int32)
IL_005e: conv.u2
IL_005f: call System.Int32 TMPro.TMP_Text::HexToInt(System.Char)
IL_0064: ldc.i4.s 12
IL_0066: shl
IL_0067: add
IL_0068: ldarg.0
IL_0069: ldarga.s text
IL_006b: ldarg.2
IL_006c: ldc.i4.5
IL_006d: add
IL_006e: call System.UInt32 TMPro.TMP_Text/TextBackingContainer::get_Item(System.Int32)
IL_0073: conv.u2
IL_0074: call System.Int32 TMPro.TMP_Text::HexToInt(System.Char)
IL_0079: ldc.i4.8
IL_007a: shl
IL_007b: add
IL_007c: ldarg.0
IL_007d: ldarga.s text
IL_007f: ldarg.2
IL_0080: ldc.i4.6
IL_0081: add
IL_0082: call System.UInt32 TMPro.TMP_Text/TextBackingContainer::get_Item(System.Int32)
IL_0087: conv.u2
IL_0088: call System.Int32 TMPro.TMP_Text::HexToInt(System.Char)
IL_008d: ldc.i4.4
IL_008e: shl
IL_008f: add
IL_0090: ldarg.0
IL_0091: ldarga.s text
IL_0093: ldarg.2
IL_0094: ldc.i4.7
IL_0095: add
IL_0096: call System.UInt32 TMPro.TMP_Text/TextBackingContainer::get_Item(System.Int32)
IL_009b: conv.u2
IL_009c: call System.Int32 TMPro.TMP_Text::HexToInt(System.Char)
IL_00a1: add
IL_00a2: ret
