TYPE TMPro.TMP_Text
METHOD System.Void TMPro.TMP_Text::InsertClosingStyleTag(TMPro.TMP_Text/UnicodeChar[]&,System.Int32&) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TMPro.TMP_TextProcessingStack`1<System.Int32>[] TMPro.TMP_Text::m_TextStyleStacks
IL_0006: ldc.i4.0
IL_0007: ldelema TMPro.TMP_TextProcessingStack`1<System.Int32>
IL_000c: call T TMPro.TMP_TextProcessingStack`1<System.Int32>::Pop()
IL_0011: stloc.0
IL_0012: ldarg.0
IL_0013: ldloc.0
IL_0014: call TMPro.TMP_Style TMPro.TMP_Text::GetStyle(System.Int32)
IL_0019: dup
IL_001a: callvirt System.Int32[] TMPro.TMP_Style::get_styleClosingTagArray()
IL_001f: ldlen
IL_0020: conv.i4
IL_0021: stloc.1
IL_0022: callvirt System.Int32[] TMPro.TMP_Style::get_styleClosingTagArray()
IL_0027: stloc.2
IL_0028: ldc.i4.0
IL_0029: stloc.3
IL_002a: br IL_01f3
IL_002f: ldloc.2
IL_0030: ldloc.3
IL_0031: ldelem.i4
IL_0032: stloc.s V_4
IL_0034: ldloc.s V_4
IL_0036: ldc.i4.s 92
IL_0038: bne.un IL_00c0
IL_003d: ldloc.3
IL_003e: ldc.i4.1
IL_003f: add
IL_0040: ldloc.1
IL_0041: bge.s IL_00c0
IL_0043: ldloc.2
IL_0044: ldloc.3
IL_0045: ldc.i4.1
IL_0046: add
IL_0047: ldelem.i4
IL_0048: stloc.s V_5
IL_004a: ldloc.s V_5
IL_004c: ldc.i4.s 92
IL_004e: bgt.s IL_005e
IL_0050: ldloc.s V_5
IL_0052: ldc.i4.s 85
IL_0054: beq.s IL_00a8
IL_0056: ldloc.s V_5
IL_0058: ldc.i4.s 92
IL_005a: beq.s IL_0080
IL_005c: br.s IL_00c0
IL_005e: ldloc.s V_5
IL_0060: ldc.i4.s 110
IL_0062: beq.s IL_0086
IL_0064: ldloc.s V_5
IL_0066: ldc.i4.s 114
IL_0068: sub
IL_0069: switch IL_00c0,IL_00c0,IL_00c0,IL_0090
IL_007e: br.s IL_00c0
IL_0080: ldloc.3
IL_0081: ldc.i4.1
IL_0082: add
IL_0083: stloc.3
IL_0084: br.s IL_00c0
IL_0086: ldc.i4.s 10
IL_0088: stloc.s V_4
IL_008a: ldloc.3
IL_008b: ldc.i4.1
IL_008c: add
IL_008d: stloc.3
IL_008e: br.s IL_00c0
IL_0090: ldloc.3
IL_0091: ldc.i4.5
IL_0092: add
IL_0093: ldloc.1
IL_0094: bge.s IL_00c0
IL_0096: ldarg.0
IL_0097: ldloc.2
IL_0098: ldloc.3
IL_0099: ldc.i4.2
IL_009a: add
IL_009b: call System.Int32 TMPro.TMP_Text::GetUTF16(System.Int32[],System.Int32)
IL_00a0: stloc.s V_4
IL_00a2: ldloc.3
IL_00a3: ldc.i4.5
IL_00a4: add
IL_00a5: stloc.3
IL_00a6: br.s IL_00c0
IL_00a8: ldloc.3
IL_00a9: ldc.i4.s 9
IL_00ab: add
IL_00ac: ldloc.1
IL_00ad: bge.s IL_00c0
IL_00af: ldarg.0
IL_00b0: ldloc.2
IL_00b1: ldloc.3
IL_00b2: ldc.i4.2
IL_00b3: add
IL_00b4: call System.Int32 TMPro.TMP_Text::GetUTF32(System.Int32[],System.Int32)
IL_00b9: stloc.s V_4
IL_00bb: ldloc.3
IL_00bc: ldc.i4.s 9
IL_00be: add
IL_00bf: stloc.3
IL_00c0: ldloc.s V_4
IL_00c2: ldc.i4.s 60
IL_00c4: bne.un IL_01ca
IL_00c9: ldarg.0
IL_00ca: ldloc.2
IL_00cb: ldloc.3
IL_00cc: ldc.i4.1
IL_00cd: add
IL_00ce: call System.Int32 TMPro.TMP_Text::GetMarkupTagHashCode(System.Int32[],System.Int32)
IL_00d3: stloc.s V_7
IL_00d5: ldloc.s V_7
IL_00d7: ldc.i4 2869039
IL_00dc: bgt.s IL_00f5
IL_00de: ldloc.s V_7
IL_00e0: ldc.i4 2256
IL_00e5: beq.s IL_011b
IL_00e7: ldloc.s V_7
IL_00e9: ldc.i4 2869039
IL_00ee: beq.s IL_0149
IL_00f0: br IL_01ca
IL_00f5: ldloc.s V_7
IL_00f7: ldc.i4 3288238
IL_00fc: beq.s IL_0177
IL_00fe: ldloc.s V_7
IL_0100: ldc.i4 100252951
IL_0105: beq IL_01a5
IL_010a: ldloc.s V_7
IL_010c: ldc.i4 1927738392
IL_0111: beq IL_01b9
IL_0116: br IL_01ca
IL_011b: ldarg.2
IL_011c: ldind.i4
IL_011d: ldarg.1
IL_011e: ldind.ref
IL_011f: ldlen
IL_0120: conv.i4
IL_0121: bne.un.s IL_012a
IL_0123: ldarg.0
IL_0124: ldarg.1
IL_0125: call System.Void TMPro.TMP_Text::ResizeInternalArray<TMPro.TMP_Text/UnicodeChar>(T[]&)
IL_012a: ldarg.1
IL_012b: ldind.ref
IL_012c: ldarg.2
IL_012d: ldind.i4
IL_012e: ldelema TMPro.TMP_Text/UnicodeChar
IL_0133: ldc.i4.s 10
IL_0135: stfld System.Int32 TMPro.TMP_Text/UnicodeChar::unicode
IL_013a: ldarg.2
IL_013b: ldarg.2
IL_013c: ldind.i4
IL_013d: ldc.i4.1
IL_013e: add
IL_013f: stind.i4
IL_0140: ldloc.3
IL_0141: ldc.i4.3
IL_0142: add
IL_0143: stloc.3
IL_0144: br IL_01ef
IL_0149: ldarg.2
IL_014a: ldind.i4
IL_014b: ldarg.1
IL_014c: ldind.ref
IL_014d: ldlen
IL_014e: conv.i4
IL_014f: bne.un.s IL_0158
IL_0151: ldarg.0
IL_0152: ldarg.1
IL_0153: call System.Void TMPro.TMP_Text::ResizeInternalArray<TMPro.TMP_Text/UnicodeChar>(T[]&)
IL_0158: ldarg.1
IL_0159: ldind.ref
IL_015a: ldarg.2
IL_015b: ldind.i4
IL_015c: ldelema TMPro.TMP_Text/UnicodeChar
IL_0161: ldc.i4 160
IL_0166: stfld System.Int32 TMPro.TMP_Text/UnicodeChar::unicode
IL_016b: ldarg.2
IL_016c: ldarg.2
IL_016d: ldind.i4
IL_016e: ldc.i4.1
IL_016f: add
IL_0170: stind.i4
IL_0171: ldloc.3
IL_0172: ldc.i4.5
IL_0173: add
IL_0174: stloc.3
IL_0175: br.s IL_01ef
IL_0177: ldarg.2
IL_0178: ldind.i4
IL_0179: ldarg.1
IL_017a: ldind.ref
IL_017b: ldlen
IL_017c: conv.i4
IL_017d: bne.un.s IL_0186
IL_017f: ldarg.0
IL_0180: ldarg.1
IL_0181: call System.Void TMPro.TMP_Text::ResizeInternalArray<TMPro.TMP_Text/UnicodeChar>(T[]&)
IL_0186: ldarg.1
IL_0187: ldind.ref
IL_0188: ldarg.2
IL_0189: ldind.i4
IL_018a: ldelema TMPro.TMP_Text/UnicodeChar
IL_018f: ldc.i4 8203
IL_0194: stfld System.Int32 TMPro.TMP_Text/UnicodeChar::unicode
IL_0199: ldarg.2
IL_019a: ldarg.2
IL_019b: ldind.i4
IL_019c: ldc.i4.1
IL_019d: add
IL_019e: stind.i4
IL_019f: ldloc.3
IL_01a0: ldc.i4.5
IL_01a1: add
IL_01a2: stloc.3
IL_01a3: br.s IL_01ef
IL_01a5: ldarg.0
IL_01a6: ldloca.s V_2
IL_01a8: ldloc.3
IL_01a9: ldloca.s V_6
IL_01ab: ldarg.1
IL_01ac: ldarg.2
IL_01ad: call System.Boolean TMPro.TMP_Text::ReplaceOpeningStyleTag(System.Int32[]&,System.Int32,System.Int32&,TMPro.TMP_Text/UnicodeChar[]&,System.Int32&)
IL_01b2: brfalse.s IL_01ca
IL_01b4: ldloc.s V_6
IL_01b6: stloc.3
IL_01b7: br.s IL_01ef
IL_01b9: ldarg.0
IL_01ba: ldloca.s V_2
IL_01bc: ldloc.3
IL_01bd: ldarg.1
IL_01be: ldarg.2
IL_01bf: call System.Void TMPro.TMP_Text::ReplaceClosingStyleTag(System.Int32[]&,System.Int32,TMPro.TMP_Text/UnicodeChar[]&,System.Int32&)
IL_01c4: ldloc.3
IL_01c5: ldc.i4.7
IL_01c6: add
IL_01c7: stloc.3
IL_01c8: br.s IL_01ef
IL_01ca: ldarg.2
IL_01cb: ldind.i4
IL_01cc: ldarg.1
IL_01cd: ldind.ref
IL_01ce: ldlen
IL_01cf: conv.i4
IL_01d0: bne.un.s IL_01d9
IL_01d2: ldarg.0
IL_01d3: ldarg.1
IL_01d4: call System.Void TMPro.TMP_Text::ResizeInternalArray<TMPro.TMP_Text/UnicodeChar>(T[]&)
IL_01d9: ldarg.1
IL_01da: ldind.ref
IL_01db: ldarg.2
IL_01dc: ldind.i4
IL_01dd: ldelema TMPro.TMP_Text/UnicodeChar
IL_01e2: ldloc.s V_4
IL_01e4: stfld System.Int32 TMPro.TMP_Text/UnicodeChar::unicode
IL_01e9: ldarg.2
IL_01ea: ldarg.2
IL_01eb: ldind.i4
IL_01ec: ldc.i4.1
IL_01ed: add
IL_01ee: stind.i4
IL_01ef: ldloc.3
IL_01f0: ldc.i4.1
IL_01f1: add
IL_01f2: stloc.3
IL_01f3: ldloc.3
IL_01f4: ldloc.1
IL_01f5: blt IL_002f
IL_01fa: ldarg.0
IL_01fb: ldc.i4.0
IL_01fc: stfld System.Int32 TMPro.TMP_Text::m_TextStyleStackDepth
IL_0201: ret
