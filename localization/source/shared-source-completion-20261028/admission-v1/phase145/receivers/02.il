TYPE viperOSK.OSK_Receiver
METHOD System.Void viperOSK.OSK_Receiver::SetText(System.String) | attributes=Public, Virtual, HideBySig, VtableLayoutMask | impl=IL
IL_0000: ldarg.1
IL_0001: ldc.i4.0
IL_0002: ldarg.0
IL_0003: ldfld System.Int32 viperOSK.OSK_Receiver::textLimit
IL_0008: ldarg.1
IL_0009: callvirt System.Int32 System.String::get_Length()
IL_000e: call System.Int32 UnityEngine.Mathf::Min(System.Int32,System.Int32)
IL_0013: callvirt System.String System.String::Substring(System.Int32,System.Int32)
IL_0018: starg.s newText
IL_001a: ldarg.0
IL_001b: ldarg.1
IL_001c: stfld System.String viperOSK.OSK_Receiver::text
IL_0021: ldarg.0
IL_0022: ldfld System.String viperOSK.OSK_Receiver::charMask
IL_0027: callvirt System.Int32 System.String::get_Length()
IL_002c: ldc.i4.0
IL_002d: ble.s IL_0058
IL_002f: ldarg.0
IL_0030: ldfld TMPro.TMP_Text viperOSK.OSK_Receiver::textReceiver
IL_0035: ldarg.0
IL_0036: ldfld System.String viperOSK.OSK_Receiver::charMask
IL_003b: ldc.i4.0
IL_003c: callvirt System.Char System.String::get_Chars(System.Int32)
IL_0041: ldarg.0
IL_0042: ldfld System.String viperOSK.OSK_Receiver::text
IL_0047: callvirt System.Int32 System.String::get_Length()
IL_004c: newobj System.Void System.String::.ctor(System.Char,System.Int32)
IL_0051: callvirt System.Void TMPro.TMP_Text::set_text(System.String)
IL_0056: br.s IL_0064
IL_0058: ldarg.0
IL_0059: ldfld TMPro.TMP_Text viperOSK.OSK_Receiver::textReceiver
IL_005e: ldarg.1
IL_005f: callvirt System.Void TMPro.TMP_Text::set_text(System.String)
IL_0064: ldarg.0
IL_0065: ldarg.0
IL_0066: ldfld System.String viperOSK.OSK_Receiver::text
IL_006b: callvirt System.Int32 System.String::get_Length()
IL_0070: stfld System.Int32 viperOSK.OSK_Receiver::cursorIndex
IL_0075: ret
METHOD System.Void viperOSK.OSK_Receiver::AddText(System.String) | attributes=Public, Virtual, HideBySig, VtableLayoutMask | impl=IL
IL_0000: ldarg.1
IL_0001: ldstr ""
IL_0006: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_000b: brfalse.s IL_0014
IL_000d: ldarg.0
IL_000e: callvirt System.Void viperOSK.OSK_Receiver::Backspace()
IL_0013: ret
IL_0014: ldarg.1
IL_0015: ldstr ""
IL_001a: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_001f: brfalse.s IL_0028
IL_0021: ldarg.0
IL_0022: callvirt System.Void viperOSK.OSK_Receiver::Del()
IL_0027: ret
IL_0028: ldarg.1
IL_0029: ldc.i4.0
IL_002a: ldc.i4.1
IL_002b: callvirt System.String System.String::Substring(System.Int32,System.Int32)
IL_0030: starg.s newchar
IL_0032: ldarg.0
IL_0033: ldfld System.String viperOSK.OSK_Receiver::charMask
IL_0038: callvirt System.Int32 System.String::get_Length()
IL_003d: ldc.i4.0
IL_003e: bgt.s IL_0043
IL_0040: ldarg.1
IL_0041: br.s IL_0050
IL_0043: ldarg.0
IL_0044: ldfld System.String viperOSK.OSK_Receiver::charMask
IL_0049: ldc.i4.0
IL_004a: ldc.i4.1
IL_004b: callvirt System.String System.String::Substring(System.Int32,System.Int32)
IL_0050: stloc.0
IL_0051: ldarg.0
IL_0052: callvirt System.Int32 viperOSK.OSK_Receiver::get_selection()
IL_0057: ldc.i4.0
IL_0058: ble IL_011f
IL_005d: ldarg.0
IL_005e: ldfld TMPro.TMP_Text viperOSK.OSK_Receiver::textReceiver
IL_0063: ldarg.0
IL_0064: ldfld TMPro.TMP_Text viperOSK.OSK_Receiver::textReceiver
IL_0069: callvirt System.String TMPro.TMP_Text::get_text()
IL_006e: ldarg.0
IL_006f: ldflda UnityEngine.Vector2Int viperOSK.OSK_Receiver::cursorSel
IL_0074: call System.Int32 UnityEngine.Vector2Int::get_x()
IL_0079: ldarg.0
IL_007a: callvirt System.Int32 viperOSK.OSK_Receiver::get_selection()
IL_007f: ldc.i4.1
IL_0080: add
IL_0081: callvirt System.String System.String::Remove(System.Int32,System.Int32)
IL_0086: callvirt System.Void TMPro.TMP_Text::set_text(System.String)
IL_008b: ldarg.0
IL_008c: ldfld TMPro.TMP_Text viperOSK.OSK_Receiver::textReceiver
IL_0091: ldarg.0
IL_0092: ldfld TMPro.TMP_Text viperOSK.OSK_Receiver::textReceiver
IL_0097: callvirt System.String TMPro.TMP_Text::get_text()
IL_009c: ldarg.0
IL_009d: ldflda UnityEngine.Vector2Int viperOSK.OSK_Receiver::cursorSel
IL_00a2: call System.Int32 UnityEngine.Vector2Int::get_x()
IL_00a7: ldloc.0
IL_00a8: callvirt System.String System.String::Insert(System.Int32,System.String)
IL_00ad: callvirt System.Void TMPro.TMP_Text::set_text(System.String)
IL_00b2: ldarg.0
IL_00b3: ldarg.0
IL_00b4: ldfld System.String viperOSK.OSK_Receiver::text
IL_00b9: ldarg.0
IL_00ba: ldflda UnityEngine.Vector2Int viperOSK.OSK_Receiver::cursorSel
IL_00bf: call System.Int32 UnityEngine.Vector2Int::get_x()
IL_00c4: ldarg.0
IL_00c5: callvirt System.Int32 viperOSK.OSK_Receiver::get_selection()
IL_00ca: callvirt System.String System.String::Remove(System.Int32,System.Int32)
IL_00cf: stfld System.String viperOSK.OSK_Receiver::text
IL_00d4: ldarg.0
IL_00d5: ldarg.0
IL_00d6: ldfld System.String viperOSK.OSK_Receiver::text
IL_00db: ldarg.0
IL_00dc: ldflda UnityEngine.Vector2Int viperOSK.OSK_Receiver::cursorSel
IL_00e1: call System.Int32 UnityEngine.Vector2Int::get_x()
IL_00e6: ldarg.1
IL_00e7: callvirt System.String System.String::Insert(System.Int32,System.String)
IL_00ec: stfld System.String viperOSK.OSK_Receiver::text
IL_00f1: ldarg.0
IL_00f2: ldarg.0
IL_00f3: ldflda UnityEngine.Vector2Int viperOSK.OSK_Receiver::cursorSel
IL_00f8: call System.Int32 UnityEngine.Vector2Int::get_x()
IL_00fd: ldc.i4.1
IL_00fe: add
IL_00ff: stfld System.Int32 viperOSK.OSK_Receiver::cursorIndex
IL_0104: ldarg.0
IL_0105: ldflda UnityEngine.Vector2Int viperOSK.OSK_Receiver::cursorSel
IL_010a: ldarg.0
IL_010b: ldflda UnityEngine.Vector2Int viperOSK.OSK_Receiver::cursorSel
IL_0110: ldc.i4.m1
IL_0111: dup
IL_0112: stloc.1
IL_0113: call System.Void UnityEngine.Vector2Int::set_y(System.Int32)
IL_0118: ldloc.1
IL_0119: call System.Void UnityEngine.Vector2Int::set_x(System.Int32)
IL_011e: ret
IL_011f: ldarg.0
IL_0120: ldfld System.String viperOSK.OSK_Receiver::text
IL_0125: callvirt System.Int32 System.String::get_Length()
IL_012a: brfalse.s IL_013f
IL_012c: ldarg.0
IL_012d: ldfld System.Int32 viperOSK.OSK_Receiver::cursorIndex
IL_0132: ldarg.0
IL_0133: ldfld System.String viperOSK.OSK_Receiver::text
IL_0138: callvirt System.Int32 System.String::get_Length()
IL_013d: blt.s IL_0177
IL_013f: ldarg.0
IL_0140: ldfld TMPro.TMP_Text viperOSK.OSK_Receiver::textReceiver
IL_0145: dup
IL_0146: callvirt System.String TMPro.TMP_Text::get_text()
IL_014b: ldloc.0
IL_014c: call System.String System.String::Concat(System.String,System.String)
IL_0151: callvirt System.Void TMPro.TMP_Text::set_text(System.String)
IL_0156: ldarg.0
IL_0157: ldarg.0
IL_0158: ldfld System.String viperOSK.OSK_Receiver::text
IL_015d: ldarg.1
IL_015e: call System.String System.String::Concat(System.String,System.String)
IL_0163: stfld System.String viperOSK.OSK_Receiver::text
IL_0168: ldarg.0
IL_0169: ldarg.0
IL_016a: ldfld System.Int32 viperOSK.OSK_Receiver::cursorIndex
IL_016f: ldc.i4.1
IL_0170: add
IL_0171: stfld System.Int32 viperOSK.OSK_Receiver::cursorIndex
IL_0176: ret
IL_0177: ldarg.0
IL_0178: ldfld TMPro.TMP_Text viperOSK.OSK_Receiver::textReceiver
IL_017d: callvirt System.String TMPro.TMP_Text::get_text()
IL_0182: callvirt System.Int32 System.String::get_Length()
IL_0187: ldarg.0
IL_0188: ldfld System.Int32 viperOSK.OSK_Receiver::textLimit
IL_018d: bge.s IL_01d7
IL_018f: ldarg.0
IL_0190: ldfld TMPro.TMP_Text viperOSK.OSK_Receiver::textReceiver
IL_0195: ldarg.0
IL_0196: ldfld TMPro.TMP_Text viperOSK.OSK_Receiver::textReceiver
IL_019b: callvirt System.String TMPro.TMP_Text::get_text()
IL_01a0: ldarg.0
IL_01a1: ldfld System.Int32 viperOSK.OSK_Receiver::cursorIndex
IL_01a6: ldloc.0
IL_01a7: callvirt System.String System.String::Insert(System.Int32,System.String)
IL_01ac: callvirt System.Void TMPro.TMP_Text::set_text(System.String)
IL_01b1: ldarg.0
IL_01b2: ldarg.0
IL_01b3: ldfld System.String viperOSK.OSK_Receiver::text
IL_01b8: ldarg.0
IL_01b9: ldfld System.Int32 viperOSK.OSK_Receiver::cursorIndex
IL_01be: ldarg.1
IL_01bf: callvirt System.String System.String::Insert(System.Int32,System.String)
IL_01c4: stfld System.String viperOSK.OSK_Receiver::text
IL_01c9: ldarg.0
IL_01ca: ldarg.0
IL_01cb: ldfld System.Int32 viperOSK.OSK_Receiver::cursorIndex
IL_01d0: ldc.i4.1
IL_01d1: add
IL_01d2: stfld System.Int32 viperOSK.OSK_Receiver::cursorIndex
IL_01d7: ret
METHOD System.String viperOSK.OSK_Receiver::ParsedText() | attributes=Public, Virtual, HideBySig, VtableLayoutMask | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TMPro.TMP_Text viperOSK.OSK_Receiver::textReceiver
IL_0006: callvirt System.String TMPro.TMP_Text::GetParsedText()
IL_000b: ret
