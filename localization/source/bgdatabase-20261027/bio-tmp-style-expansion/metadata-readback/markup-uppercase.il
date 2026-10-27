TYPE TMPro.TMP_TextUtilities
METHOD System.UInt32 TMPro.TMP_TextUtilities::ToUpperASCIIFast(System.UInt32) | attributes=Assembly, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: conv.u8
IL_0002: ldstr "-------------------------------- !-#$%&-()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[-]^_`ABCDEFGHIJKLMNOPQRSTUVWXYZ{|}~-"
IL_0007: call System.Int32 System.String::get_Length()
IL_000c: ldc.i4.1
IL_000d: sub
IL_000e: conv.i8
IL_000f: ble.s IL_0013
IL_0011: ldarg.0
IL_0012: ret
IL_0013: ldstr "-------------------------------- !-#$%&-()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[-]^_`ABCDEFGHIJKLMNOPQRSTUVWXYZ{|}~-"
IL_0018: ldarg.0
IL_0019: call System.Char System.String::get_Chars(System.Int32)
IL_001e: ret
