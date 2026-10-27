TYPE TMPro.TMP_Text
METHOD System.Void TMPro.TMP_Text::ReplaceClosingStyleTag(TMPro.TMP_Text/TextBackingContainer&,System.Int32,TMPro.TMP_Text/UnicodeChar[]&,System.Int32&) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TMPro.TMP_TextProcessingStack`1<System.Int32>[] TMPro.TMP_Text::m_TextStyleStacks
IL_0006: ldarg.0
IL_0007: ldfld System.Int32 TMPro.TMP_Text::m_TextStyleStackDepth
IL_000c: ldc.i4.1
IL_000d: add
IL_000e: ldelema TMPro.TMP_TextProcessingStack`1<System.Int32>
IL_0013: call T TMPro.TMP_TextProcessingStack`1<System.Int32>::Pop()
IL_0018: stloc.0
IL_0019: ldarg.0
IL_001a: ldloc.0
IL_001b: call TMPro.TMP_Style TMPro.TMP_Text::GetStyle(System.Int32)
IL_0020: stloc.1
IL_0021: ldloc.1
IL_0022: brtrue.s IL_0025
IL_0024: ret
IL_0025: ldarg.0
IL_0026: ldarg.0
IL_0027: ldfld System.Int32 TMPro.TMP_Text::m_TextStyleStackDepth
IL_002c: ldc.i4.1
IL_002d: add
IL_002e: stfld System.Int32 TMPro.TMP_Text::m_TextStyleStackDepth
IL_0033: ldloc.1
IL_0034: callvirt System.Int32[] TMPro.TMP_Style::get_styleClosingTagArray()
IL_0039: ldlen
IL_003a: conv.i4
IL_003b: stloc.2
IL_003c: ldloc.1
IL_003d: callvirt System.Int32[] TMPro.TMP_Style::get_styleClosingTagArray()
IL_0042: stloc.3
IL_0043: ldc.i4.0
IL_0044: stloc.s V_4
IL_0046: br IL_0247
IL_004b: ldloc.3
IL_004c: ldloc.s V_4
IL_004e: ldelem.i4
IL_004f: stloc.s V_5
IL_0051: ldloc.s V_5
IL_0053: ldc.i4.s 92
IL_0055: bne.un IL_00ee
IL_005a: ldloc.s V_4
IL_005c: ldc.i4.1
IL_005d: add
IL_005e: ldloc.2
IL_005f: bge IL_00ee
IL_0064: ldloc.3
IL_0065: ldloc.s V_4
IL_0067: ldc.i4.1
IL_0068: add
IL_0069: ldelem.i4
IL_006a: stloc.s V_6
IL_006c: ldloc.s V_6
IL_006e: ldc.i4.s 92
IL_0070: bgt.s IL_0080
IL_0072: ldloc.s V_6
IL_0074: ldc.i4.s 85
IL_0076: beq.s IL_00d2
IL_0078: ldloc.s V_6
IL_007a: ldc.i4.s 92
IL_007c: beq.s IL_00a2
IL_007e: br.s IL_00ee
IL_0080: ldloc.s V_6
IL_0082: ldc.i4.s 110
IL_0084: beq.s IL_00aa
IL_0086: ldloc.s V_6
IL_0088: ldc.i4.s 114
IL_008a: sub
IL_008b: switch IL_00ee,IL_00ee,IL_00ee,IL_00b6
IL_00a0: br.s IL_00ee
IL_00a2: ldloc.s V_4
IL_00a4: ldc.i4.1
IL_00a5: add
IL_00a6: stloc.s V_4
IL_00a8: br.s IL_00ee
IL_00aa: ldc.i4.s 10
IL_00ac: stloc.s V_5
IL_00ae: ldloc.s V_4
IL_00b0: ldc.i4.1
IL_00b1: add
IL_00b2: stloc.s V_4
IL_00b4: br.s IL_00ee
IL_00b6: ldloc.s V_4
IL_00b8: ldc.i4.5
IL_00b9: add
IL_00ba: ldloc.2
IL_00bb: bge.s IL_00ee
IL_00bd: ldarg.0
IL_00be: ldloc.3
IL_00bf: ldloc.s V_4
IL_00c1: ldc.i4.2
IL_00c2: add
IL_00c3: call System.Int32 TMPro.TMP_Text::GetUTF16(System.Int32[],System.Int32)
IL_00c8: stloc.s V_5
IL_00ca: ldloc.s V_4
IL_00cc: ldc.i4.5
IL_00cd: add
IL_00ce: stloc.s V_4
IL_00d0: br.s IL_00ee
IL_00d2: ldloc.s V_4
IL_00d4: ldc.i4.s 9
IL_00d6: add
IL_00d7: ldloc.2
IL_00d8: bge.s IL_00ee
IL_00da: ldarg.0
IL_00db: ldloc.3
IL_00dc: ldloc.s V_4
IL_00de: ldc.i4.2
IL_00df: add
IL_00e0: call System.Int32 TMPro.TMP_Text::GetUTF32(System.Int32[],System.Int32)
IL_00e5: stloc.s V_5
IL_00e7: ldloc.s V_4
IL_00e9: ldc.i4.s 9
IL_00eb: add
IL_00ec: stloc.s V_4
IL_00ee: ldloc.s V_5
IL_00f0: ldc.i4.s 60
IL_00f2: bne.un IL_0218
IL_00f7: ldarg.0
IL_00f8: ldloc.3
IL_00f9: ldloc.s V_4
IL_00fb: ldc.i4.1
IL_00fc: add
IL_00fd: call System.Int32 TMPro.TMP_Text::GetMarkupTagHashCode(System.Int32[],System.Int32)
IL_0102: stloc.s V_8
IL_0104: ldloc.s V_8
IL_0106: ldc.i4 2869039
IL_010b: bgt.s IL_0124
IL_010d: ldloc.s V_8
IL_010f: ldc.i4 2256
IL_0114: beq.s IL_014d
IL_0116: ldloc.s V_8
IL_0118: ldc.i4 2869039
IL_011d: beq.s IL_0181
IL_011f: br IL_0218
IL_0124: ldloc.s V_8
IL_0126: ldc.i4 3288238
IL_012b: beq IL_01b8
IL_0130: ldloc.s V_8
IL_0132: ldc.i4 100252951
IL_0137: beq IL_01ec
IL_013c: ldloc.s V_8
IL_013e: ldc.i4 1927738392
IL_0143: beq IL_0203
IL_0148: br IL_0218
IL_014d: ldarg.s writeIndex
IL_014f: ldind.i4
IL_0150: ldarg.3
IL_0151: ldind.ref
IL_0152: ldlen
IL_0153: conv.i4
IL_0154: bne.un.s IL_015d
IL_0156: ldarg.0
IL_0157: ldarg.3
IL_0158: call System.Void TMPro.TMP_Text::ResizeInternalArray<TMPro.TMP_Text/UnicodeChar>(T[]&)
IL_015d: ldarg.3
IL_015e: ldind.ref
IL_015f: ldarg.s writeIndex
IL_0161: ldind.i4
IL_0162: ldelema TMPro.TMP_Text/UnicodeChar
IL_0167: ldc.i4.s 10
IL_0169: stfld System.Int32 TMPro.TMP_Text/UnicodeChar::unicode
IL_016e: ldarg.s writeIndex
IL_0170: ldarg.s writeIndex
IL_0172: ldind.i4
IL_0173: ldc.i4.1
IL_0174: add
IL_0175: stind.i4
IL_0176: ldloc.s V_4
IL_0178: ldc.i4.3
IL_0179: add
IL_017a: stloc.s V_4
IL_017c: br IL_0241
IL_0181: ldarg.s writeIndex
IL_0183: ldind.i4
IL_0184: ldarg.3
IL_0185: ldind.ref
IL_0186: ldlen
IL_0187: conv.i4
IL_0188: bne.un.s IL_0191
IL_018a: ldarg.0
IL_018b: ldarg.3
IL_018c: call System.Void TMPro.TMP_Text::ResizeInternalArray<TMPro.TMP_Text/UnicodeChar>(T[]&)
IL_0191: ldarg.3
IL_0192: ldind.ref
IL_0193: ldarg.s writeIndex
IL_0195: ldind.i4
IL_0196: ldelema TMPro.TMP_Text/UnicodeChar
IL_019b: ldc.i4 160
IL_01a0: stfld System.Int32 TMPro.TMP_Text/UnicodeChar::unicode
IL_01a5: ldarg.s writeIndex
IL_01a7: ldarg.s writeIndex
IL_01a9: ldind.i4
IL_01aa: ldc.i4.1
IL_01ab: add
IL_01ac: stind.i4
IL_01ad: ldloc.s V_4
IL_01af: ldc.i4.5
IL_01b0: add
IL_01b1: stloc.s V_4
IL_01b3: br IL_0241
IL_01b8: ldarg.s writeIndex
IL_01ba: ldind.i4
IL_01bb: ldarg.3
IL_01bc: ldind.ref
IL_01bd: ldlen
IL_01be: conv.i4
IL_01bf: bne.un.s IL_01c8
IL_01c1: ldarg.0
IL_01c2: ldarg.3
IL_01c3: call System.Void TMPro.TMP_Text::ResizeInternalArray<TMPro.TMP_Text/UnicodeChar>(T[]&)
IL_01c8: ldarg.3
IL_01c9: ldind.ref
IL_01ca: ldarg.s writeIndex
IL_01cc: ldind.i4
IL_01cd: ldelema TMPro.TMP_Text/UnicodeChar
IL_01d2: ldc.i4 8203
IL_01d7: stfld System.Int32 TMPro.TMP_Text/UnicodeChar::unicode
IL_01dc: ldarg.s writeIndex
IL_01de: ldarg.s writeIndex
IL_01e0: ldind.i4
IL_01e1: ldc.i4.1
IL_01e2: add
IL_01e3: stind.i4
IL_01e4: ldloc.s V_4
IL_01e6: ldc.i4.5
IL_01e7: add
IL_01e8: stloc.s V_4
IL_01ea: br.s IL_0241
IL_01ec: ldarg.0
IL_01ed: ldloca.s V_3
IL_01ef: ldloc.s V_4
IL_01f1: ldloca.s V_7
IL_01f3: ldarg.3
IL_01f4: ldarg.s writeIndex
IL_01f6: call System.Boolean TMPro.TMP_Text::ReplaceOpeningStyleTag(System.Int32[]&,System.Int32,System.Int32&,TMPro.TMP_Text/UnicodeChar[]&,System.Int32&)
IL_01fb: brfalse.s IL_0218
IL_01fd: ldloc.s V_7
IL_01ff: stloc.s V_4
IL_0201: br.s IL_0241
IL_0203: ldarg.0
IL_0204: ldloca.s V_3
IL_0206: ldloc.s V_4
IL_0208: ldarg.3
IL_0209: ldarg.s writeIndex
IL_020b: call System.Void TMPro.TMP_Text::ReplaceClosingStyleTag(System.Int32[]&,System.Int32,TMPro.TMP_Text/UnicodeChar[]&,System.Int32&)
IL_0210: ldloc.s V_4
IL_0212: ldc.i4.7
IL_0213: add
IL_0214: stloc.s V_4
IL_0216: br.s IL_0241
IL_0218: ldarg.s writeIndex
IL_021a: ldind.i4
IL_021b: ldarg.3
IL_021c: ldind.ref
IL_021d: ldlen
IL_021e: conv.i4
IL_021f: bne.un.s IL_0228
IL_0221: ldarg.0
IL_0222: ldarg.3
IL_0223: call System.Void TMPro.TMP_Text::ResizeInternalArray<TMPro.TMP_Text/UnicodeChar>(T[]&)
IL_0228: ldarg.3
IL_0229: ldind.ref
IL_022a: ldarg.s writeIndex
IL_022c: ldind.i4
IL_022d: ldelema TMPro.TMP_Text/UnicodeChar
IL_0232: ldloc.s V_5
IL_0234: stfld System.Int32 TMPro.TMP_Text/UnicodeChar::unicode
IL_0239: ldarg.s writeIndex
IL_023b: ldarg.s writeIndex
IL_023d: ldind.i4
IL_023e: ldc.i4.1
IL_023f: add
IL_0240: stind.i4
IL_0241: ldloc.s V_4
IL_0243: ldc.i4.1
IL_0244: add
IL_0245: stloc.s V_4
IL_0247: ldloc.s V_4
IL_0249: ldloc.2
IL_024a: blt IL_004b
IL_024f: ldarg.0
IL_0250: ldarg.0
IL_0251: ldfld System.Int32 TMPro.TMP_Text::m_TextStyleStackDepth
IL_0256: ldc.i4.1
IL_0257: sub
IL_0258: stfld System.Int32 TMPro.TMP_Text::m_TextStyleStackDepth
IL_025d: ret
METHOD System.Void TMPro.TMP_Text::ReplaceClosingStyleTag(System.Int32[]&,System.Int32,TMPro.TMP_Text/UnicodeChar[]&,System.Int32&) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TMPro.TMP_TextProcessingStack`1<System.Int32>[] TMPro.TMP_Text::m_TextStyleStacks
IL_0006: ldarg.0
IL_0007: ldfld System.Int32 TMPro.TMP_Text::m_TextStyleStackDepth
IL_000c: ldc.i4.1
IL_000d: add
IL_000e: ldelema TMPro.TMP_TextProcessingStack`1<System.Int32>
IL_0013: call T TMPro.TMP_TextProcessingStack`1<System.Int32>::Pop()
IL_0018: stloc.0
IL_0019: ldarg.0
IL_001a: ldloc.0
IL_001b: call TMPro.TMP_Style TMPro.TMP_Text::GetStyle(System.Int32)
IL_0020: stloc.1
IL_0021: ldloc.1
IL_0022: brtrue.s IL_0025
IL_0024: ret
IL_0025: ldarg.0
IL_0026: ldarg.0
IL_0027: ldfld System.Int32 TMPro.TMP_Text::m_TextStyleStackDepth
IL_002c: ldc.i4.1
IL_002d: add
IL_002e: stfld System.Int32 TMPro.TMP_Text::m_TextStyleStackDepth
IL_0033: ldloc.1
IL_0034: callvirt System.Int32[] TMPro.TMP_Style::get_styleClosingTagArray()
IL_0039: ldlen
IL_003a: conv.i4
IL_003b: stloc.2
IL_003c: ldloc.1
IL_003d: callvirt System.Int32[] TMPro.TMP_Style::get_styleClosingTagArray()
IL_0042: stloc.3
IL_0043: ldc.i4.0
IL_0044: stloc.s V_4
IL_0046: br IL_0247
IL_004b: ldloc.3
IL_004c: ldloc.s V_4
IL_004e: ldelem.i4
IL_004f: stloc.s V_5
IL_0051: ldloc.s V_5
IL_0053: ldc.i4.s 92
IL_0055: bne.un IL_00ee
IL_005a: ldloc.s V_4
IL_005c: ldc.i4.1
IL_005d: add
IL_005e: ldloc.2
IL_005f: bge IL_00ee
IL_0064: ldloc.3
IL_0065: ldloc.s V_4
IL_0067: ldc.i4.1
IL_0068: add
IL_0069: ldelem.i4
IL_006a: stloc.s V_6
IL_006c: ldloc.s V_6
IL_006e: ldc.i4.s 92
IL_0070: bgt.s IL_0080
IL_0072: ldloc.s V_6
IL_0074: ldc.i4.s 85
IL_0076: beq.s IL_00d2
IL_0078: ldloc.s V_6
IL_007a: ldc.i4.s 92
IL_007c: beq.s IL_00a2
IL_007e: br.s IL_00ee
IL_0080: ldloc.s V_6
IL_0082: ldc.i4.s 110
IL_0084: beq.s IL_00aa
IL_0086: ldloc.s V_6
IL_0088: ldc.i4.s 114
IL_008a: sub
IL_008b: switch IL_00ee,IL_00ee,IL_00ee,IL_00b6
IL_00a0: br.s IL_00ee
IL_00a2: ldloc.s V_4
IL_00a4: ldc.i4.1
IL_00a5: add
IL_00a6: stloc.s V_4
IL_00a8: br.s IL_00ee
IL_00aa: ldc.i4.s 10
IL_00ac: stloc.s V_5
IL_00ae: ldloc.s V_4
IL_00b0: ldc.i4.1
IL_00b1: add
IL_00b2: stloc.s V_4
IL_00b4: br.s IL_00ee
IL_00b6: ldloc.s V_4
IL_00b8: ldc.i4.5
IL_00b9: add
IL_00ba: ldloc.2
IL_00bb: bge.s IL_00ee
IL_00bd: ldarg.0
IL_00be: ldloc.3
IL_00bf: ldloc.s V_4
IL_00c1: ldc.i4.2
IL_00c2: add
IL_00c3: call System.Int32 TMPro.TMP_Text::GetUTF16(System.Int32[],System.Int32)
IL_00c8: stloc.s V_5
IL_00ca: ldloc.s V_4
IL_00cc: ldc.i4.5
IL_00cd: add
IL_00ce: stloc.s V_4
IL_00d0: br.s IL_00ee
IL_00d2: ldloc.s V_4
IL_00d4: ldc.i4.s 9
IL_00d6: add
IL_00d7: ldloc.2
IL_00d8: bge.s IL_00ee
IL_00da: ldarg.0
IL_00db: ldloc.3
IL_00dc: ldloc.s V_4
IL_00de: ldc.i4.2
IL_00df: add
IL_00e0: call System.Int32 TMPro.TMP_Text::GetUTF32(System.Int32[],System.Int32)
IL_00e5: stloc.s V_5
IL_00e7: ldloc.s V_4
IL_00e9: ldc.i4.s 9
IL_00eb: add
IL_00ec: stloc.s V_4
IL_00ee: ldloc.s V_5
IL_00f0: ldc.i4.s 60
IL_00f2: bne.un IL_0218
IL_00f7: ldarg.0
IL_00f8: ldloc.3
IL_00f9: ldloc.s V_4
IL_00fb: ldc.i4.1
IL_00fc: add
IL_00fd: call System.Int32 TMPro.TMP_Text::GetMarkupTagHashCode(System.Int32[],System.Int32)
IL_0102: stloc.s V_8
IL_0104: ldloc.s V_8
IL_0106: ldc.i4 2869039
IL_010b: bgt.s IL_0124
IL_010d: ldloc.s V_8
IL_010f: ldc.i4 2256
IL_0114: beq.s IL_014d
IL_0116: ldloc.s V_8
IL_0118: ldc.i4 2869039
IL_011d: beq.s IL_0181
IL_011f: br IL_0218
IL_0124: ldloc.s V_8
IL_0126: ldc.i4 3288238
IL_012b: beq IL_01b8
IL_0130: ldloc.s V_8
IL_0132: ldc.i4 100252951
IL_0137: beq IL_01ec
IL_013c: ldloc.s V_8
IL_013e: ldc.i4 1927738392
IL_0143: beq IL_0203
IL_0148: br IL_0218
IL_014d: ldarg.s writeIndex
IL_014f: ldind.i4
IL_0150: ldarg.3
IL_0151: ldind.ref
IL_0152: ldlen
IL_0153: conv.i4
IL_0154: bne.un.s IL_015d
IL_0156: ldarg.0
IL_0157: ldarg.3
IL_0158: call System.Void TMPro.TMP_Text::ResizeInternalArray<TMPro.TMP_Text/UnicodeChar>(T[]&)
IL_015d: ldarg.3
IL_015e: ldind.ref
IL_015f: ldarg.s writeIndex
IL_0161: ldind.i4
IL_0162: ldelema TMPro.TMP_Text/UnicodeChar
IL_0167: ldc.i4.s 10
IL_0169: stfld System.Int32 TMPro.TMP_Text/UnicodeChar::unicode
IL_016e: ldarg.s writeIndex
IL_0170: ldarg.s writeIndex
IL_0172: ldind.i4
IL_0173: ldc.i4.1
IL_0174: add
IL_0175: stind.i4
IL_0176: ldloc.s V_4
IL_0178: ldc.i4.3
IL_0179: add
IL_017a: stloc.s V_4
IL_017c: br IL_0241
IL_0181: ldarg.s writeIndex
IL_0183: ldind.i4
IL_0184: ldarg.3
IL_0185: ldind.ref
IL_0186: ldlen
IL_0187: conv.i4
IL_0188: bne.un.s IL_0191
IL_018a: ldarg.0
IL_018b: ldarg.3
IL_018c: call System.Void TMPro.TMP_Text::ResizeInternalArray<TMPro.TMP_Text/UnicodeChar>(T[]&)
IL_0191: ldarg.3
IL_0192: ldind.ref
IL_0193: ldarg.s writeIndex
IL_0195: ldind.i4
IL_0196: ldelema TMPro.TMP_Text/UnicodeChar
IL_019b: ldc.i4 160
IL_01a0: stfld System.Int32 TMPro.TMP_Text/UnicodeChar::unicode
IL_01a5: ldarg.s writeIndex
IL_01a7: ldarg.s writeIndex
IL_01a9: ldind.i4
IL_01aa: ldc.i4.1
IL_01ab: add
IL_01ac: stind.i4
IL_01ad: ldloc.s V_4
IL_01af: ldc.i4.5
IL_01b0: add
IL_01b1: stloc.s V_4
IL_01b3: br IL_0241
IL_01b8: ldarg.s writeIndex
IL_01ba: ldind.i4
IL_01bb: ldarg.3
IL_01bc: ldind.ref
IL_01bd: ldlen
IL_01be: conv.i4
IL_01bf: bne.un.s IL_01c8
IL_01c1: ldarg.0
IL_01c2: ldarg.3
IL_01c3: call System.Void TMPro.TMP_Text::ResizeInternalArray<TMPro.TMP_Text/UnicodeChar>(T[]&)
IL_01c8: ldarg.3
IL_01c9: ldind.ref
IL_01ca: ldarg.s writeIndex
IL_01cc: ldind.i4
IL_01cd: ldelema TMPro.TMP_Text/UnicodeChar
IL_01d2: ldc.i4 8203
IL_01d7: stfld System.Int32 TMPro.TMP_Text/UnicodeChar::unicode
IL_01dc: ldarg.s writeIndex
IL_01de: ldarg.s writeIndex
IL_01e0: ldind.i4
IL_01e1: ldc.i4.1
IL_01e2: add
IL_01e3: stind.i4
IL_01e4: ldloc.s V_4
IL_01e6: ldc.i4.5
IL_01e7: add
IL_01e8: stloc.s V_4
IL_01ea: br.s IL_0241
IL_01ec: ldarg.0
IL_01ed: ldloca.s V_3
IL_01ef: ldloc.s V_4
IL_01f1: ldloca.s V_7
IL_01f3: ldarg.3
IL_01f4: ldarg.s writeIndex
IL_01f6: call System.Boolean TMPro.TMP_Text::ReplaceOpeningStyleTag(System.Int32[]&,System.Int32,System.Int32&,TMPro.TMP_Text/UnicodeChar[]&,System.Int32&)
IL_01fb: brfalse.s IL_0218
IL_01fd: ldloc.s V_7
IL_01ff: stloc.s V_4
IL_0201: br.s IL_0241
IL_0203: ldarg.0
IL_0204: ldloca.s V_3
IL_0206: ldloc.s V_4
IL_0208: ldarg.3
IL_0209: ldarg.s writeIndex
IL_020b: call System.Void TMPro.TMP_Text::ReplaceClosingStyleTag(System.Int32[]&,System.Int32,TMPro.TMP_Text/UnicodeChar[]&,System.Int32&)
IL_0210: ldloc.s V_4
IL_0212: ldc.i4.7
IL_0213: add
IL_0214: stloc.s V_4
IL_0216: br.s IL_0241
IL_0218: ldarg.s writeIndex
IL_021a: ldind.i4
IL_021b: ldarg.3
IL_021c: ldind.ref
IL_021d: ldlen
IL_021e: conv.i4
IL_021f: bne.un.s IL_0228
IL_0221: ldarg.0
IL_0222: ldarg.3
IL_0223: call System.Void TMPro.TMP_Text::ResizeInternalArray<TMPro.TMP_Text/UnicodeChar>(T[]&)
IL_0228: ldarg.3
IL_0229: ldind.ref
IL_022a: ldarg.s writeIndex
IL_022c: ldind.i4
IL_022d: ldelema TMPro.TMP_Text/UnicodeChar
IL_0232: ldloc.s V_5
IL_0234: stfld System.Int32 TMPro.TMP_Text/UnicodeChar::unicode
IL_0239: ldarg.s writeIndex
IL_023b: ldarg.s writeIndex
IL_023d: ldind.i4
IL_023e: ldc.i4.1
IL_023f: add
IL_0240: stind.i4
IL_0241: ldloc.s V_4
IL_0243: ldc.i4.1
IL_0244: add
IL_0245: stloc.s V_4
IL_0247: ldloc.s V_4
IL_0249: ldloc.2
IL_024a: blt IL_004b
IL_024f: ldarg.0
IL_0250: ldarg.0
IL_0251: ldfld System.Int32 TMPro.TMP_Text::m_TextStyleStackDepth
IL_0256: ldc.i4.1
IL_0257: sub
IL_0258: stfld System.Int32 TMPro.TMP_Text::m_TextStyleStackDepth
IL_025d: ret
