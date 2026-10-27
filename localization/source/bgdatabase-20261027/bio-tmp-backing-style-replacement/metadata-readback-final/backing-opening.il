TYPE TMPro.TMP_Text
METHOD System.Boolean TMPro.TMP_Text::ReplaceOpeningStyleTag(TMPro.TMP_Text/TextBackingContainer&,System.Int32,System.Int32&,TMPro.TMP_Text/UnicodeChar[]&,System.Int32&) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: ldarg.2
IL_0003: ldc.i4.7
IL_0004: add
IL_0005: ldarg.3
IL_0006: call System.Int32 TMPro.TMP_Text::GetStyleHashCode(TMPro.TMP_Text/TextBackingContainer&,System.Int32,System.Int32&)
IL_000b: stloc.0
IL_000c: ldarg.0
IL_000d: ldloc.0
IL_000e: call TMPro.TMP_Style TMPro.TMP_Text::GetStyle(System.Int32)
IL_0013: stloc.1
IL_0014: ldloc.1
IL_0015: brfalse.s IL_001b
IL_0017: ldarg.3
IL_0018: ldind.i4
IL_0019: brtrue.s IL_001d
IL_001b: ldc.i4.0
IL_001c: ret
IL_001d: ldarg.0
IL_001e: ldarg.0
IL_001f: ldfld System.Int32 TMPro.TMP_Text::m_TextStyleStackDepth
IL_0024: ldc.i4.1
IL_0025: add
IL_0026: stfld System.Int32 TMPro.TMP_Text::m_TextStyleStackDepth
IL_002b: ldarg.0
IL_002c: ldfld TMPro.TMP_TextProcessingStack`1<System.Int32>[] TMPro.TMP_Text::m_TextStyleStacks
IL_0031: ldarg.0
IL_0032: ldfld System.Int32 TMPro.TMP_Text::m_TextStyleStackDepth
IL_0037: ldelema TMPro.TMP_TextProcessingStack`1<System.Int32>
IL_003c: ldloc.1
IL_003d: callvirt System.Int32 TMPro.TMP_Style::get_hashCode()
IL_0042: call System.Void TMPro.TMP_TextProcessingStack`1<System.Int32>::Push(T)
IL_0047: ldloc.1
IL_0048: callvirt System.Int32[] TMPro.TMP_Style::get_styleOpeningTagArray()
IL_004d: ldlen
IL_004e: conv.i4
IL_004f: stloc.2
IL_0050: ldloc.1
IL_0051: callvirt System.Int32[] TMPro.TMP_Style::get_styleOpeningTagArray()
IL_0056: stloc.3
IL_0057: ldc.i4.0
IL_0058: stloc.s V_4
IL_005a: br IL_0269
IL_005f: ldloc.3
IL_0060: ldloc.s V_4
IL_0062: ldelem.i4
IL_0063: stloc.s V_5
IL_0065: ldloc.s V_5
IL_0067: ldc.i4.s 92
IL_0069: bne.un IL_0102
IL_006e: ldloc.s V_4
IL_0070: ldc.i4.1
IL_0071: add
IL_0072: ldloc.2
IL_0073: bge IL_0102
IL_0078: ldloc.3
IL_0079: ldloc.s V_4
IL_007b: ldc.i4.1
IL_007c: add
IL_007d: ldelem.i4
IL_007e: stloc.s V_6
IL_0080: ldloc.s V_6
IL_0082: ldc.i4.s 92
IL_0084: bgt.s IL_0094
IL_0086: ldloc.s V_6
IL_0088: ldc.i4.s 85
IL_008a: beq.s IL_00e6
IL_008c: ldloc.s V_6
IL_008e: ldc.i4.s 92
IL_0090: beq.s IL_00b6
IL_0092: br.s IL_0102
IL_0094: ldloc.s V_6
IL_0096: ldc.i4.s 110
IL_0098: beq.s IL_00be
IL_009a: ldloc.s V_6
IL_009c: ldc.i4.s 114
IL_009e: sub
IL_009f: switch IL_0102,IL_0102,IL_0102,IL_00ca
IL_00b4: br.s IL_0102
IL_00b6: ldloc.s V_4
IL_00b8: ldc.i4.1
IL_00b9: add
IL_00ba: stloc.s V_4
IL_00bc: br.s IL_0102
IL_00be: ldc.i4.s 10
IL_00c0: stloc.s V_5
IL_00c2: ldloc.s V_4
IL_00c4: ldc.i4.1
IL_00c5: add
IL_00c6: stloc.s V_4
IL_00c8: br.s IL_0102
IL_00ca: ldloc.s V_4
IL_00cc: ldc.i4.5
IL_00cd: add
IL_00ce: ldloc.2
IL_00cf: bge.s IL_0102
IL_00d1: ldarg.0
IL_00d2: ldloc.3
IL_00d3: ldloc.s V_4
IL_00d5: ldc.i4.2
IL_00d6: add
IL_00d7: call System.Int32 TMPro.TMP_Text::GetUTF16(System.Int32[],System.Int32)
IL_00dc: stloc.s V_5
IL_00de: ldloc.s V_4
IL_00e0: ldc.i4.5
IL_00e1: add
IL_00e2: stloc.s V_4
IL_00e4: br.s IL_0102
IL_00e6: ldloc.s V_4
IL_00e8: ldc.i4.s 9
IL_00ea: add
IL_00eb: ldloc.2
IL_00ec: bge.s IL_0102
IL_00ee: ldarg.0
IL_00ef: ldloc.3
IL_00f0: ldloc.s V_4
IL_00f2: ldc.i4.2
IL_00f3: add
IL_00f4: call System.Int32 TMPro.TMP_Text::GetUTF32(System.Int32[],System.Int32)
IL_00f9: stloc.s V_5
IL_00fb: ldloc.s V_4
IL_00fd: ldc.i4.s 9
IL_00ff: add
IL_0100: stloc.s V_4
IL_0102: ldloc.s V_5
IL_0104: ldc.i4.s 60
IL_0106: bne.un IL_0237
IL_010b: ldarg.0
IL_010c: ldloc.3
IL_010d: ldloc.s V_4
IL_010f: ldc.i4.1
IL_0110: add
IL_0111: call System.Int32 TMPro.TMP_Text::GetMarkupTagHashCode(System.Int32[],System.Int32)
IL_0116: stloc.s V_8
IL_0118: ldloc.s V_8
IL_011a: ldc.i4 2869039
IL_011f: bgt.s IL_0138
IL_0121: ldloc.s V_8
IL_0123: ldc.i4 2256
IL_0128: beq.s IL_0161
IL_012a: ldloc.s V_8
IL_012c: ldc.i4 2869039
IL_0131: beq.s IL_0198
IL_0133: br IL_0237
IL_0138: ldloc.s V_8
IL_013a: ldc.i4 3288238
IL_013f: beq IL_01d2
IL_0144: ldloc.s V_8
IL_0146: ldc.i4 100252951
IL_014b: beq IL_0209
IL_0150: ldloc.s V_8
IL_0152: ldc.i4 1927738392
IL_0157: beq IL_0221
IL_015c: br IL_0237
IL_0161: ldarg.s writeIndex
IL_0163: ldind.i4
IL_0164: ldarg.s charBuffer
IL_0166: ldind.ref
IL_0167: ldlen
IL_0168: conv.i4
IL_0169: bne.un.s IL_0173
IL_016b: ldarg.0
IL_016c: ldarg.s charBuffer
IL_016e: call System.Void TMPro.TMP_Text::ResizeInternalArray<TMPro.TMP_Text/UnicodeChar>(T[]&)
IL_0173: ldarg.s charBuffer
IL_0175: ldind.ref
IL_0176: ldarg.s writeIndex
IL_0178: ldind.i4
IL_0179: ldelema TMPro.TMP_Text/UnicodeChar
IL_017e: ldc.i4.s 10
IL_0180: stfld System.Int32 TMPro.TMP_Text/UnicodeChar::unicode
IL_0185: ldarg.s writeIndex
IL_0187: ldarg.s writeIndex
IL_0189: ldind.i4
IL_018a: ldc.i4.1
IL_018b: add
IL_018c: stind.i4
IL_018d: ldloc.s V_4
IL_018f: ldc.i4.3
IL_0190: add
IL_0191: stloc.s V_4
IL_0193: br IL_0263
IL_0198: ldarg.s writeIndex
IL_019a: ldind.i4
IL_019b: ldarg.s charBuffer
IL_019d: ldind.ref
IL_019e: ldlen
IL_019f: conv.i4
IL_01a0: bne.un.s IL_01aa
IL_01a2: ldarg.0
IL_01a3: ldarg.s charBuffer
IL_01a5: call System.Void TMPro.TMP_Text::ResizeInternalArray<TMPro.TMP_Text/UnicodeChar>(T[]&)
IL_01aa: ldarg.s charBuffer
IL_01ac: ldind.ref
IL_01ad: ldarg.s writeIndex
IL_01af: ldind.i4
IL_01b0: ldelema TMPro.TMP_Text/UnicodeChar
IL_01b5: ldc.i4 160
IL_01ba: stfld System.Int32 TMPro.TMP_Text/UnicodeChar::unicode
IL_01bf: ldarg.s writeIndex
IL_01c1: ldarg.s writeIndex
IL_01c3: ldind.i4
IL_01c4: ldc.i4.1
IL_01c5: add
IL_01c6: stind.i4
IL_01c7: ldloc.s V_4
IL_01c9: ldc.i4.5
IL_01ca: add
IL_01cb: stloc.s V_4
IL_01cd: br IL_0263
IL_01d2: ldarg.s writeIndex
IL_01d4: ldind.i4
IL_01d5: ldarg.s charBuffer
IL_01d7: ldind.ref
IL_01d8: ldlen
IL_01d9: conv.i4
IL_01da: bne.un.s IL_01e4
IL_01dc: ldarg.0
IL_01dd: ldarg.s charBuffer
IL_01df: call System.Void TMPro.TMP_Text::ResizeInternalArray<TMPro.TMP_Text/UnicodeChar>(T[]&)
IL_01e4: ldarg.s charBuffer
IL_01e6: ldind.ref
IL_01e7: ldarg.s writeIndex
IL_01e9: ldind.i4
IL_01ea: ldelema TMPro.TMP_Text/UnicodeChar
IL_01ef: ldc.i4 8203
IL_01f4: stfld System.Int32 TMPro.TMP_Text/UnicodeChar::unicode
IL_01f9: ldarg.s writeIndex
IL_01fb: ldarg.s writeIndex
IL_01fd: ldind.i4
IL_01fe: ldc.i4.1
IL_01ff: add
IL_0200: stind.i4
IL_0201: ldloc.s V_4
IL_0203: ldc.i4.5
IL_0204: add
IL_0205: stloc.s V_4
IL_0207: br.s IL_0263
IL_0209: ldarg.0
IL_020a: ldloca.s V_3
IL_020c: ldloc.s V_4
IL_020e: ldloca.s V_7
IL_0210: ldarg.s charBuffer
IL_0212: ldarg.s writeIndex
IL_0214: call System.Boolean TMPro.TMP_Text::ReplaceOpeningStyleTag(System.Int32[]&,System.Int32,System.Int32&,TMPro.TMP_Text/UnicodeChar[]&,System.Int32&)
IL_0219: brfalse.s IL_0237
IL_021b: ldloc.s V_7
IL_021d: stloc.s V_4
IL_021f: br.s IL_0263
IL_0221: ldarg.0
IL_0222: ldloca.s V_3
IL_0224: ldloc.s V_4
IL_0226: ldarg.s charBuffer
IL_0228: ldarg.s writeIndex
IL_022a: call System.Void TMPro.TMP_Text::ReplaceClosingStyleTag(System.Int32[]&,System.Int32,TMPro.TMP_Text/UnicodeChar[]&,System.Int32&)
IL_022f: ldloc.s V_4
IL_0231: ldc.i4.7
IL_0232: add
IL_0233: stloc.s V_4
IL_0235: br.s IL_0263
IL_0237: ldarg.s writeIndex
IL_0239: ldind.i4
IL_023a: ldarg.s charBuffer
IL_023c: ldind.ref
IL_023d: ldlen
IL_023e: conv.i4
IL_023f: bne.un.s IL_0249
IL_0241: ldarg.0
IL_0242: ldarg.s charBuffer
IL_0244: call System.Void TMPro.TMP_Text::ResizeInternalArray<TMPro.TMP_Text/UnicodeChar>(T[]&)
IL_0249: ldarg.s charBuffer
IL_024b: ldind.ref
IL_024c: ldarg.s writeIndex
IL_024e: ldind.i4
IL_024f: ldelema TMPro.TMP_Text/UnicodeChar
IL_0254: ldloc.s V_5
IL_0256: stfld System.Int32 TMPro.TMP_Text/UnicodeChar::unicode
IL_025b: ldarg.s writeIndex
IL_025d: ldarg.s writeIndex
IL_025f: ldind.i4
IL_0260: ldc.i4.1
IL_0261: add
IL_0262: stind.i4
IL_0263: ldloc.s V_4
IL_0265: ldc.i4.1
IL_0266: add
IL_0267: stloc.s V_4
IL_0269: ldloc.s V_4
IL_026b: ldloc.2
IL_026c: blt IL_005f
IL_0271: ldarg.0
IL_0272: ldarg.0
IL_0273: ldfld System.Int32 TMPro.TMP_Text::m_TextStyleStackDepth
IL_0278: ldc.i4.1
IL_0279: sub
IL_027a: stfld System.Int32 TMPro.TMP_Text::m_TextStyleStackDepth
IL_027f: ldc.i4.1
IL_0280: ret
