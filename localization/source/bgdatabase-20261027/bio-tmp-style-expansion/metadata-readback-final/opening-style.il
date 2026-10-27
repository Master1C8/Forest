TYPE TMPro.TMP_Text
METHOD System.Boolean TMPro.TMP_Text::InsertOpeningStyleTag(TMPro.TMP_Style,System.Int32,TMPro.TMP_Text/UnicodeChar[]&,System.Int32&) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: brtrue.s IL_0005
IL_0003: ldc.i4.0
IL_0004: ret
IL_0005: ldarg.0
IL_0006: ldfld TMPro.TMP_TextProcessingStack`1<System.Int32>[] TMPro.TMP_Text::m_TextStyleStacks
IL_000b: ldc.i4.0
IL_000c: ldelema TMPro.TMP_TextProcessingStack`1<System.Int32>
IL_0011: ldarg.1
IL_0012: callvirt System.Int32 TMPro.TMP_Style::get_hashCode()
IL_0017: call System.Void TMPro.TMP_TextProcessingStack`1<System.Int32>::Push(T)
IL_001c: ldarg.1
IL_001d: callvirt System.Int32[] TMPro.TMP_Style::get_styleOpeningTagArray()
IL_0022: ldlen
IL_0023: conv.i4
IL_0024: stloc.0
IL_0025: ldarg.1
IL_0026: callvirt System.Int32[] TMPro.TMP_Style::get_styleOpeningTagArray()
IL_002b: stloc.1
IL_002c: ldc.i4.0
IL_002d: stloc.2
IL_002e: br IL_0208
IL_0033: ldloc.1
IL_0034: ldloc.2
IL_0035: ldelem.i4
IL_0036: stloc.3
IL_0037: ldloc.3
IL_0038: ldc.i4.s 92
IL_003a: bne.un IL_00bf
IL_003f: ldloc.2
IL_0040: ldc.i4.1
IL_0041: add
IL_0042: ldloc.0
IL_0043: bge.s IL_00bf
IL_0045: ldloc.1
IL_0046: ldloc.2
IL_0047: ldc.i4.1
IL_0048: add
IL_0049: ldelem.i4
IL_004a: stloc.s V_4
IL_004c: ldloc.s V_4
IL_004e: ldc.i4.s 92
IL_0050: bgt.s IL_0060
IL_0052: ldloc.s V_4
IL_0054: ldc.i4.s 85
IL_0056: beq.s IL_00a8
IL_0058: ldloc.s V_4
IL_005a: ldc.i4.s 92
IL_005c: beq.s IL_0082
IL_005e: br.s IL_00bf
IL_0060: ldloc.s V_4
IL_0062: ldc.i4.s 110
IL_0064: beq.s IL_0088
IL_0066: ldloc.s V_4
IL_0068: ldc.i4.s 114
IL_006a: sub
IL_006b: switch IL_00bf,IL_00bf,IL_00bf,IL_0091
IL_0080: br.s IL_00bf
IL_0082: ldloc.2
IL_0083: ldc.i4.1
IL_0084: add
IL_0085: stloc.2
IL_0086: br.s IL_00bf
IL_0088: ldc.i4.s 10
IL_008a: stloc.3
IL_008b: ldloc.2
IL_008c: ldc.i4.1
IL_008d: add
IL_008e: stloc.2
IL_008f: br.s IL_00bf
IL_0091: ldloc.2
IL_0092: ldc.i4.5
IL_0093: add
IL_0094: ldloc.0
IL_0095: bge.s IL_00bf
IL_0097: ldarg.0
IL_0098: ldloc.1
IL_0099: ldloc.2
IL_009a: ldc.i4.2
IL_009b: add
IL_009c: call System.Int32 TMPro.TMP_Text::GetUTF16(System.Int32[],System.Int32)
IL_00a1: stloc.3
IL_00a2: ldloc.2
IL_00a3: ldc.i4.5
IL_00a4: add
IL_00a5: stloc.2
IL_00a6: br.s IL_00bf
IL_00a8: ldloc.2
IL_00a9: ldc.i4.s 9
IL_00ab: add
IL_00ac: ldloc.0
IL_00ad: bge.s IL_00bf
IL_00af: ldarg.0
IL_00b0: ldloc.1
IL_00b1: ldloc.2
IL_00b2: ldc.i4.2
IL_00b3: add
IL_00b4: call System.Int32 TMPro.TMP_Text::GetUTF32(System.Int32[],System.Int32)
IL_00b9: stloc.3
IL_00ba: ldloc.2
IL_00bb: ldc.i4.s 9
IL_00bd: add
IL_00be: stloc.2
IL_00bf: ldloc.3
IL_00c0: ldc.i4.s 60
IL_00c2: bne.un IL_01dc
IL_00c7: ldarg.0
IL_00c8: ldloc.1
IL_00c9: ldloc.2
IL_00ca: ldc.i4.1
IL_00cb: add
IL_00cc: call System.Int32 TMPro.TMP_Text::GetMarkupTagHashCode(System.Int32[],System.Int32)
IL_00d1: stloc.s V_6
IL_00d3: ldloc.s V_6
IL_00d5: ldc.i4 2869039
IL_00da: bgt.s IL_00f3
IL_00dc: ldloc.s V_6
IL_00de: ldc.i4 2256
IL_00e3: beq.s IL_011c
IL_00e5: ldloc.s V_6
IL_00e7: ldc.i4 2869039
IL_00ec: beq.s IL_014e
IL_00ee: br IL_01dc
IL_00f3: ldloc.s V_6
IL_00f5: ldc.i4 3288238
IL_00fa: beq IL_0183
IL_00ff: ldloc.s V_6
IL_0101: ldc.i4 100252951
IL_0106: beq IL_01b5
IL_010b: ldloc.s V_6
IL_010d: ldc.i4 1927738392
IL_0112: beq IL_01ca
IL_0117: br IL_01dc
IL_011c: ldarg.s writeIndex
IL_011e: ldind.i4
IL_011f: ldarg.3
IL_0120: ldind.ref
IL_0121: ldlen
IL_0122: conv.i4
IL_0123: bne.un.s IL_012c
IL_0125: ldarg.0
IL_0126: ldarg.3
IL_0127: call System.Void TMPro.TMP_Text::ResizeInternalArray<TMPro.TMP_Text/UnicodeChar>(T[]&)
IL_012c: ldarg.3
IL_012d: ldind.ref
IL_012e: ldarg.s writeIndex
IL_0130: ldind.i4
IL_0131: ldelema TMPro.TMP_Text/UnicodeChar
IL_0136: ldc.i4.s 10
IL_0138: stfld System.Int32 TMPro.TMP_Text/UnicodeChar::unicode
IL_013d: ldarg.s writeIndex
IL_013f: ldarg.s writeIndex
IL_0141: ldind.i4
IL_0142: ldc.i4.1
IL_0143: add
IL_0144: stind.i4
IL_0145: ldloc.2
IL_0146: ldc.i4.3
IL_0147: add
IL_0148: stloc.2
IL_0149: br IL_0204
IL_014e: ldarg.s writeIndex
IL_0150: ldind.i4
IL_0151: ldarg.3
IL_0152: ldind.ref
IL_0153: ldlen
IL_0154: conv.i4
IL_0155: bne.un.s IL_015e
IL_0157: ldarg.0
IL_0158: ldarg.3
IL_0159: call System.Void TMPro.TMP_Text::ResizeInternalArray<TMPro.TMP_Text/UnicodeChar>(T[]&)
IL_015e: ldarg.3
IL_015f: ldind.ref
IL_0160: ldarg.s writeIndex
IL_0162: ldind.i4
IL_0163: ldelema TMPro.TMP_Text/UnicodeChar
IL_0168: ldc.i4 160
IL_016d: stfld System.Int32 TMPro.TMP_Text/UnicodeChar::unicode
IL_0172: ldarg.s writeIndex
IL_0174: ldarg.s writeIndex
IL_0176: ldind.i4
IL_0177: ldc.i4.1
IL_0178: add
IL_0179: stind.i4
IL_017a: ldloc.2
IL_017b: ldc.i4.5
IL_017c: add
IL_017d: stloc.2
IL_017e: br IL_0204
IL_0183: ldarg.s writeIndex
IL_0185: ldind.i4
IL_0186: ldarg.3
IL_0187: ldind.ref
IL_0188: ldlen
IL_0189: conv.i4
IL_018a: bne.un.s IL_0193
IL_018c: ldarg.0
IL_018d: ldarg.3
IL_018e: call System.Void TMPro.TMP_Text::ResizeInternalArray<TMPro.TMP_Text/UnicodeChar>(T[]&)
IL_0193: ldarg.3
IL_0194: ldind.ref
IL_0195: ldarg.s writeIndex
IL_0197: ldind.i4
IL_0198: ldelema TMPro.TMP_Text/UnicodeChar
IL_019d: ldc.i4 8203
IL_01a2: stfld System.Int32 TMPro.TMP_Text/UnicodeChar::unicode
IL_01a7: ldarg.s writeIndex
IL_01a9: ldarg.s writeIndex
IL_01ab: ldind.i4
IL_01ac: ldc.i4.1
IL_01ad: add
IL_01ae: stind.i4
IL_01af: ldloc.2
IL_01b0: ldc.i4.5
IL_01b1: add
IL_01b2: stloc.2
IL_01b3: br.s IL_0204
IL_01b5: ldarg.0
IL_01b6: ldloca.s V_1
IL_01b8: ldloc.2
IL_01b9: ldloca.s V_5
IL_01bb: ldarg.3
IL_01bc: ldarg.s writeIndex
IL_01be: call System.Boolean TMPro.TMP_Text::ReplaceOpeningStyleTag(System.Int32[]&,System.Int32,System.Int32&,TMPro.TMP_Text/UnicodeChar[]&,System.Int32&)
IL_01c3: brfalse.s IL_01dc
IL_01c5: ldloc.s V_5
IL_01c7: stloc.2
IL_01c8: br.s IL_0204
IL_01ca: ldarg.0
IL_01cb: ldloca.s V_1
IL_01cd: ldloc.2
IL_01ce: ldarg.3
IL_01cf: ldarg.s writeIndex
IL_01d1: call System.Void TMPro.TMP_Text::ReplaceClosingStyleTag(System.Int32[]&,System.Int32,TMPro.TMP_Text/UnicodeChar[]&,System.Int32&)
IL_01d6: ldloc.2
IL_01d7: ldc.i4.7
IL_01d8: add
IL_01d9: stloc.2
IL_01da: br.s IL_0204
IL_01dc: ldarg.s writeIndex
IL_01de: ldind.i4
IL_01df: ldarg.3
IL_01e0: ldind.ref
IL_01e1: ldlen
IL_01e2: conv.i4
IL_01e3: bne.un.s IL_01ec
IL_01e5: ldarg.0
IL_01e6: ldarg.3
IL_01e7: call System.Void TMPro.TMP_Text::ResizeInternalArray<TMPro.TMP_Text/UnicodeChar>(T[]&)
IL_01ec: ldarg.3
IL_01ed: ldind.ref
IL_01ee: ldarg.s writeIndex
IL_01f0: ldind.i4
IL_01f1: ldelema TMPro.TMP_Text/UnicodeChar
IL_01f6: ldloc.3
IL_01f7: stfld System.Int32 TMPro.TMP_Text/UnicodeChar::unicode
IL_01fc: ldarg.s writeIndex
IL_01fe: ldarg.s writeIndex
IL_0200: ldind.i4
IL_0201: ldc.i4.1
IL_0202: add
IL_0203: stind.i4
IL_0204: ldloc.2
IL_0205: ldc.i4.1
IL_0206: add
IL_0207: stloc.2
IL_0208: ldloc.2
IL_0209: ldloc.0
IL_020a: blt IL_0033
IL_020f: ldarg.0
IL_0210: ldc.i4.0
IL_0211: stfld System.Int32 TMPro.TMP_Text::m_TextStyleStackDepth
IL_0216: ldc.i4.1
IL_0217: ret
