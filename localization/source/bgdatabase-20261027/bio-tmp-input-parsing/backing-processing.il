TYPE TMPro.TMP_Text
METHOD System.Void TMPro.TMP_Text::PopulateTextBackingArray(System.String) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: brfalse.s IL_000b
IL_0003: ldarg.1
IL_0004: callvirt System.Int32 System.String::get_Length()
IL_0009: br.s IL_000c
IL_000b: ldc.i4.0
IL_000c: stloc.0
IL_000d: ldarg.0
IL_000e: ldarg.1
IL_000f: ldc.i4.0
IL_0010: ldloc.0
IL_0011: call System.Void TMPro.TMP_Text::PopulateTextBackingArray(System.String,System.Int32,System.Int32)
IL_0016: ret
METHOD System.Void TMPro.TMP_Text::PopulateTextBackingArray(System.String,System.Int32,System.Int32) | attributes=Private, HideBySig | impl=IL
IL_0000: ldc.i4.0
IL_0001: stloc.1
IL_0002: ldarg.1
IL_0003: brtrue.s IL_000c
IL_0005: ldc.i4.0
IL_0006: stloc.0
IL_0007: ldc.i4.0
IL_0008: starg.s length
IL_000a: br.s IL_0039
IL_000c: ldarg.2
IL_000d: ldc.i4.0
IL_000e: ldarg.1
IL_000f: callvirt System.Int32 System.String::get_Length()
IL_0014: call System.Int32 UnityEngine.Mathf::Clamp(System.Int32,System.Int32,System.Int32)
IL_0019: stloc.0
IL_001a: ldarg.3
IL_001b: ldc.i4.0
IL_001c: ldarg.2
IL_001d: ldarg.3
IL_001e: add
IL_001f: ldarg.1
IL_0020: callvirt System.Int32 System.String::get_Length()
IL_0025: blt.s IL_0031
IL_0027: ldarg.1
IL_0028: callvirt System.Int32 System.String::get_Length()
IL_002d: ldarg.2
IL_002e: sub
IL_002f: br.s IL_0032
IL_0031: ldarg.3
IL_0032: call System.Int32 UnityEngine.Mathf::Clamp(System.Int32,System.Int32,System.Int32)
IL_0037: starg.s length
IL_0039: ldarg.3
IL_003a: ldarg.0
IL_003b: ldflda TMPro.TMP_Text/TextBackingContainer TMPro.TMP_Text::m_TextBackingArray
IL_0040: call System.Int32 TMPro.TMP_Text/TextBackingContainer::get_Capacity()
IL_0045: blt.s IL_0053
IL_0047: ldarg.0
IL_0048: ldflda TMPro.TMP_Text/TextBackingContainer TMPro.TMP_Text::m_TextBackingArray
IL_004d: ldarg.3
IL_004e: call System.Void TMPro.TMP_Text/TextBackingContainer::Resize(System.Int32)
IL_0053: ldloc.0
IL_0054: ldarg.3
IL_0055: add
IL_0056: stloc.2
IL_0057: br.s IL_0074
IL_0059: ldarg.0
IL_005a: ldflda TMPro.TMP_Text/TextBackingContainer TMPro.TMP_Text::m_TextBackingArray
IL_005f: ldloc.1
IL_0060: ldarg.1
IL_0061: ldloc.0
IL_0062: callvirt System.Char System.String::get_Chars(System.Int32)
IL_0067: call System.Void TMPro.TMP_Text/TextBackingContainer::set_Item(System.Int32,System.UInt32)
IL_006c: ldloc.1
IL_006d: ldc.i4.1
IL_006e: add
IL_006f: stloc.1
IL_0070: ldloc.0
IL_0071: ldc.i4.1
IL_0072: add
IL_0073: stloc.0
IL_0074: ldloc.0
IL_0075: ldloc.2
IL_0076: blt.s IL_0059
IL_0078: ldarg.0
IL_0079: ldflda TMPro.TMP_Text/TextBackingContainer TMPro.TMP_Text::m_TextBackingArray
IL_007e: ldloc.1
IL_007f: ldc.i4.0
IL_0080: call System.Void TMPro.TMP_Text/TextBackingContainer::set_Item(System.Int32,System.UInt32)
IL_0085: ldarg.0
IL_0086: ldflda TMPro.TMP_Text/TextBackingContainer TMPro.TMP_Text::m_TextBackingArray
IL_008b: ldloc.1
IL_008c: call System.Void TMPro.TMP_Text/TextBackingContainer::set_Count(System.Int32)
IL_0091: ret
METHOD System.Void TMPro.TMP_Text::PopulateTextProcessingArray() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldflda TMPro.TMP_Text/TextBackingContainer TMPro.TMP_Text::m_TextBackingArray
IL_0006: call System.Int32 TMPro.TMP_Text/TextBackingContainer::get_Count()
IL_000b: stloc.0
IL_000c: ldarg.0
IL_000d: ldfld TMPro.TMP_Text/UnicodeChar[] TMPro.TMP_Text::m_TextProcessingArray
IL_0012: ldlen
IL_0013: conv.i4
IL_0014: ldloc.0
IL_0015: bge.s IL_0024
IL_0017: ldarg.0
IL_0018: ldarg.0
IL_0019: ldflda TMPro.TMP_Text/UnicodeChar[] TMPro.TMP_Text::m_TextProcessingArray
IL_001e: ldloc.0
IL_001f: call System.Void TMPro.TMP_Text::ResizeInternalArray<TMPro.TMP_Text/UnicodeChar>(T[]&,System.Int32)
IL_0024: ldarg.0
IL_0025: ldfld TMPro.TMP_TextProcessingStack`1<System.Int32>[] TMPro.TMP_Text::m_TextStyleStacks
IL_002a: ldc.i4.0
IL_002b: call System.Void TMPro.TMP_TextProcessingStack`1<System.Int32>::SetDefault(TMPro.TMP_TextProcessingStack`1<T>[],T)
IL_0030: ldarg.0
IL_0031: ldc.i4.0
IL_0032: stfld System.Int32 TMPro.TMP_Text::m_TextStyleStackDepth
IL_0037: ldc.i4.0
IL_0038: stloc.1
IL_0039: ldarg.0
IL_003a: call TMPro.TMP_Style TMPro.TMP_Text::get_textStyle()
IL_003f: callvirt System.Int32 TMPro.TMP_Style::get_hashCode()
IL_0044: ldc.i4 -1183493901
IL_0049: beq.s IL_0061
IL_004b: ldarg.0
IL_004c: ldarg.0
IL_004d: ldfld TMPro.TMP_Style TMPro.TMP_Text::m_TextStyle
IL_0052: ldc.i4.0
IL_0053: ldarg.0
IL_0054: ldflda TMPro.TMP_Text/UnicodeChar[] TMPro.TMP_Text::m_TextProcessingArray
IL_0059: ldloca.s V_1
IL_005b: call System.Boolean TMPro.TMP_Text::InsertOpeningStyleTag(TMPro.TMP_Style,System.Int32,TMPro.TMP_Text/UnicodeChar[]&,System.Int32&)
IL_0060: pop
IL_0061: ldc.i4.0
IL_0062: stloc.2
IL_0063: br IL_076e
IL_0068: ldarg.0
IL_0069: ldflda TMPro.TMP_Text/TextBackingContainer TMPro.TMP_Text::m_TextBackingArray
IL_006e: ldloc.2
IL_006f: call System.UInt32 TMPro.TMP_Text/TextBackingContainer::get_Item(System.Int32)
IL_0074: stloc.3
IL_0075: ldloc.3
IL_0076: brfalse IL_0775
IL_007b: ldarg.0
IL_007c: ldfld TMPro.TMP_Text/TextInputSources TMPro.TMP_Text::m_inputSource
IL_0081: brtrue IL_0429
IL_0086: ldloc.3
IL_0087: ldc.i4.s 92
IL_0089: bne.un IL_0429
IL_008e: ldloc.2
IL_008f: ldloc.0
IL_0090: ldc.i4.1
IL_0091: sub
IL_0092: bge IL_0429
IL_0097: ldarg.0
IL_0098: ldflda TMPro.TMP_Text/TextBackingContainer TMPro.TMP_Text::m_TextBackingArray
IL_009d: ldloc.2
IL_009e: ldc.i4.1
IL_009f: add
IL_00a0: call System.UInt32 TMPro.TMP_Text/TextBackingContainer::get_Item(System.Int32)
IL_00a5: stloc.s V_4
IL_00a7: ldloc.s V_4
IL_00a9: ldc.i4.s 85
IL_00ab: beq IL_03b8
IL_00b0: ldloc.s V_4
IL_00b2: ldc.i4.s 92
IL_00b4: beq.s IL_00e9
IL_00b6: ldloc.s V_4
IL_00b8: ldc.i4.s 110
IL_00ba: sub
IL_00bb: switch IL_01af,IL_0429,IL_0429,IL_0429,IL_0215,IL_0429,IL_027b,IL_0347,IL_02e1
IL_00e4: br IL_0429
IL_00e9: ldarg.0
IL_00ea: ldfld System.Boolean TMPro.TMP_Text::m_parseCtrlCharacters
IL_00ef: brfalse IL_0429
IL_00f4: ldloc.0
IL_00f5: ldloc.2
IL_00f6: ldc.i4.2
IL_00f7: add
IL_00f8: ble IL_0429
IL_00fd: ldloc.1
IL_00fe: ldc.i4.2
IL_00ff: add
IL_0100: ldarg.0
IL_0101: ldfld TMPro.TMP_Text/UnicodeChar[] TMPro.TMP_Text::m_TextProcessingArray
IL_0106: ldlen
IL_0107: conv.i4
IL_0108: ble.s IL_0116
IL_010a: ldarg.0
IL_010b: ldarg.0
IL_010c: ldflda TMPro.TMP_Text/UnicodeChar[] TMPro.TMP_Text::m_TextProcessingArray
IL_0111: call System.Void TMPro.TMP_Text::ResizeInternalArray<TMPro.TMP_Text/UnicodeChar>(T[]&)
IL_0116: ldarg.0
IL_0117: ldfld TMPro.TMP_Text/UnicodeChar[] TMPro.TMP_Text::m_TextProcessingArray
IL_011c: ldloc.1
IL_011d: ldelema TMPro.TMP_Text/UnicodeChar
IL_0122: ldarg.0
IL_0123: ldflda TMPro.TMP_Text/TextBackingContainer TMPro.TMP_Text::m_TextBackingArray
IL_0128: ldloc.2
IL_0129: ldc.i4.1
IL_012a: add
IL_012b: call System.UInt32 TMPro.TMP_Text/TextBackingContainer::get_Item(System.Int32)
IL_0130: stfld System.Int32 TMPro.TMP_Text/UnicodeChar::unicode
IL_0135: ldarg.0
IL_0136: ldfld TMPro.TMP_Text/UnicodeChar[] TMPro.TMP_Text::m_TextProcessingArray
IL_013b: ldloc.1
IL_013c: ldelema TMPro.TMP_Text/UnicodeChar
IL_0141: ldloc.2
IL_0142: stfld System.Int32 TMPro.TMP_Text/UnicodeChar::stringIndex
IL_0147: ldarg.0
IL_0148: ldfld TMPro.TMP_Text/UnicodeChar[] TMPro.TMP_Text::m_TextProcessingArray
IL_014d: ldloc.1
IL_014e: ldelema TMPro.TMP_Text/UnicodeChar
IL_0153: ldc.i4.1
IL_0154: stfld System.Int32 TMPro.TMP_Text/UnicodeChar::length
IL_0159: ldarg.0
IL_015a: ldfld TMPro.TMP_Text/UnicodeChar[] TMPro.TMP_Text::m_TextProcessingArray
IL_015f: ldloc.1
IL_0160: ldc.i4.1
IL_0161: add
IL_0162: ldelema TMPro.TMP_Text/UnicodeChar
IL_0167: ldarg.0
IL_0168: ldflda TMPro.TMP_Text/TextBackingContainer TMPro.TMP_Text::m_TextBackingArray
IL_016d: ldloc.2
IL_016e: ldc.i4.2
IL_016f: add
IL_0170: call System.UInt32 TMPro.TMP_Text/TextBackingContainer::get_Item(System.Int32)
IL_0175: stfld System.Int32 TMPro.TMP_Text/UnicodeChar::unicode
IL_017a: ldarg.0
IL_017b: ldfld TMPro.TMP_Text/UnicodeChar[] TMPro.TMP_Text::m_TextProcessingArray
IL_0180: ldloc.1
IL_0181: ldc.i4.1
IL_0182: add
IL_0183: ldelema TMPro.TMP_Text/UnicodeChar
IL_0188: ldloc.2
IL_0189: stfld System.Int32 TMPro.TMP_Text/UnicodeChar::stringIndex
IL_018e: ldarg.0
IL_018f: ldfld TMPro.TMP_Text/UnicodeChar[] TMPro.TMP_Text::m_TextProcessingArray
IL_0194: ldloc.1
IL_0195: ldc.i4.1
IL_0196: add
IL_0197: ldelema TMPro.TMP_Text/UnicodeChar
IL_019c: ldc.i4.1
IL_019d: stfld System.Int32 TMPro.TMP_Text/UnicodeChar::length
IL_01a2: ldloc.2
IL_01a3: ldc.i4.2
IL_01a4: add
IL_01a5: stloc.2
IL_01a6: ldloc.1
IL_01a7: ldc.i4.2
IL_01a8: add
IL_01a9: stloc.1
IL_01aa: br IL_076a
IL_01af: ldarg.0
IL_01b0: ldfld System.Boolean TMPro.TMP_Text::m_parseCtrlCharacters
IL_01b5: brfalse IL_0429
IL_01ba: ldloc.1
IL_01bb: ldarg.0
IL_01bc: ldfld TMPro.TMP_Text/UnicodeChar[] TMPro.TMP_Text::m_TextProcessingArray
IL_01c1: ldlen
IL_01c2: conv.i4
IL_01c3: bne.un.s IL_01d1
IL_01c5: ldarg.0
IL_01c6: ldarg.0
IL_01c7: ldflda TMPro.TMP_Text/UnicodeChar[] TMPro.TMP_Text::m_TextProcessingArray
IL_01cc: call System.Void TMPro.TMP_Text::ResizeInternalArray<TMPro.TMP_Text/UnicodeChar>(T[]&)
IL_01d1: ldarg.0
IL_01d2: ldfld TMPro.TMP_Text/UnicodeChar[] TMPro.TMP_Text::m_TextProcessingArray
IL_01d7: ldloc.1
IL_01d8: ldelema TMPro.TMP_Text/UnicodeChar
IL_01dd: ldc.i4.s 10
IL_01df: stfld System.Int32 TMPro.TMP_Text/UnicodeChar::unicode
IL_01e4: ldarg.0
IL_01e5: ldfld TMPro.TMP_Text/UnicodeChar[] TMPro.TMP_Text::m_TextProcessingArray
IL_01ea: ldloc.1
IL_01eb: ldelema TMPro.TMP_Text/UnicodeChar
IL_01f0: ldloc.2
IL_01f1: stfld System.Int32 TMPro.TMP_Text/UnicodeChar::stringIndex
IL_01f6: ldarg.0
IL_01f7: ldfld TMPro.TMP_Text/UnicodeChar[] TMPro.TMP_Text::m_TextProcessingArray
IL_01fc: ldloc.1
IL_01fd: ldelema TMPro.TMP_Text/UnicodeChar
IL_0202: ldc.i4.1
IL_0203: stfld System.Int32 TMPro.TMP_Text/UnicodeChar::length
IL_0208: ldloc.2
IL_0209: ldc.i4.1
IL_020a: add
IL_020b: stloc.2
IL_020c: ldloc.1
IL_020d: ldc.i4.1
IL_020e: add
IL_020f: stloc.1
IL_0210: br IL_076a
IL_0215: ldarg.0
IL_0216: ldfld System.Boolean TMPro.TMP_Text::m_parseCtrlCharacters
IL_021b: brfalse IL_0429
IL_0220: ldloc.1
IL_0221: ldarg.0
IL_0222: ldfld TMPro.TMP_Text/UnicodeChar[] TMPro.TMP_Text::m_TextProcessingArray
IL_0227: ldlen
IL_0228: conv.i4
IL_0229: bne.un.s IL_0237
IL_022b: ldarg.0
IL_022c: ldarg.0
IL_022d: ldflda TMPro.TMP_Text/UnicodeChar[] TMPro.TMP_Text::m_TextProcessingArray
IL_0232: call System.Void TMPro.TMP_Text::ResizeInternalArray<TMPro.TMP_Text/UnicodeChar>(T[]&)
IL_0237: ldarg.0
IL_0238: ldfld TMPro.TMP_Text/UnicodeChar[] TMPro.TMP_Text::m_TextProcessingArray
IL_023d: ldloc.1
IL_023e: ldelema TMPro.TMP_Text/UnicodeChar
IL_0243: ldc.i4.s 13
IL_0245: stfld System.Int32 TMPro.TMP_Text/UnicodeChar::unicode
IL_024a: ldarg.0
IL_024b: ldfld TMPro.TMP_Text/UnicodeChar[] TMPro.TMP_Text::m_TextProcessingArray
IL_0250: ldloc.1
IL_0251: ldelema TMPro.TMP_Text/UnicodeChar
IL_0256: ldloc.2
IL_0257: stfld System.Int32 TMPro.TMP_Text/UnicodeChar::stringIndex
IL_025c: ldarg.0
IL_025d: ldfld TMPro.TMP_Text/UnicodeChar[] TMPro.TMP_Text::m_TextProcessingArray
IL_0262: ldloc.1
IL_0263: ldelema TMPro.TMP_Text/UnicodeChar
IL_0268: ldc.i4.1
IL_0269: stfld System.Int32 TMPro.TMP_Text/UnicodeChar::length
IL_026e: ldloc.2
IL_026f: ldc.i4.1
IL_0270: add
IL_0271: stloc.2
IL_0272: ldloc.1
IL_0273: ldc.i4.1
IL_0274: add
IL_0275: stloc.1
IL_0276: br IL_076a
IL_027b: ldarg.0
IL_027c: ldfld System.Boolean TMPro.TMP_Text::m_parseCtrlCharacters
IL_0281: brfalse IL_0429
IL_0286: ldloc.1
IL_0287: ldarg.0
IL_0288: ldfld TMPro.TMP_Text/UnicodeChar[] TMPro.TMP_Text::m_TextProcessingArray
IL_028d: ldlen
IL_028e: conv.i4
IL_028f: bne.un.s IL_029d
IL_0291: ldarg.0
IL_0292: ldarg.0
IL_0293: ldflda TMPro.TMP_Text/UnicodeChar[] TMPro.TMP_Text::m_TextProcessingArray
IL_0298: call System.Void TMPro.TMP_Text::ResizeInternalArray<TMPro.TMP_Text/UnicodeChar>(T[]&)
IL_029d: ldarg.0
IL_029e: ldfld TMPro.TMP_Text/UnicodeChar[] TMPro.TMP_Text::m_TextProcessingArray
IL_02a3: ldloc.1
IL_02a4: ldelema TMPro.TMP_Text/UnicodeChar
IL_02a9: ldc.i4.s 9
IL_02ab: stfld System.Int32 TMPro.TMP_Text/UnicodeChar::unicode
IL_02b0: ldarg.0
IL_02b1: ldfld TMPro.TMP_Text/UnicodeChar[] TMPro.TMP_Text::m_TextProcessingArray
IL_02b6: ldloc.1
IL_02b7: ldelema TMPro.TMP_Text/UnicodeChar
IL_02bc: ldloc.2
IL_02bd: stfld System.Int32 TMPro.TMP_Text/UnicodeChar::stringIndex
IL_02c2: ldarg.0
IL_02c3: ldfld TMPro.TMP_Text/UnicodeChar[] TMPro.TMP_Text::m_TextProcessingArray
IL_02c8: ldloc.1
IL_02c9: ldelema TMPro.TMP_Text/UnicodeChar
IL_02ce: ldc.i4.1
IL_02cf: stfld System.Int32 TMPro.TMP_Text/UnicodeChar::length
IL_02d4: ldloc.2
IL_02d5: ldc.i4.1
IL_02d6: add
IL_02d7: stloc.2
IL_02d8: ldloc.1
IL_02d9: ldc.i4.1
IL_02da: add
IL_02db: stloc.1
IL_02dc: br IL_076a
IL_02e1: ldarg.0
IL_02e2: ldfld System.Boolean TMPro.TMP_Text::m_parseCtrlCharacters
IL_02e7: brfalse IL_0429
IL_02ec: ldloc.1
IL_02ed: ldarg.0
IL_02ee: ldfld TMPro.TMP_Text/UnicodeChar[] TMPro.TMP_Text::m_TextProcessingArray
IL_02f3: ldlen
IL_02f4: conv.i4
IL_02f5: bne.un.s IL_0303
IL_02f7: ldarg.0
IL_02f8: ldarg.0
IL_02f9: ldflda TMPro.TMP_Text/UnicodeChar[] TMPro.TMP_Text::m_TextProcessingArray
IL_02fe: call System.Void TMPro.TMP_Text::ResizeInternalArray<TMPro.TMP_Text/UnicodeChar>(T[]&)
IL_0303: ldarg.0
IL_0304: ldfld TMPro.TMP_Text/UnicodeChar[] TMPro.TMP_Text::m_TextProcessingArray
IL_0309: ldloc.1
IL_030a: ldelema TMPro.TMP_Text/UnicodeChar
IL_030f: ldc.i4.s 11
IL_0311: stfld System.Int32 TMPro.TMP_Text/UnicodeChar::unicode
IL_0316: ldarg.0
IL_0317: ldfld TMPro.TMP_Text/UnicodeChar[] TMPro.TMP_Text::m_TextProcessingArray
IL_031c: ldloc.1
IL_031d: ldelema TMPro.TMP_Text/UnicodeChar
IL_0322: ldloc.2
IL_0323: stfld System.Int32 TMPro.TMP_Text/UnicodeChar::stringIndex
IL_0328: ldarg.0
IL_0329: ldfld TMPro.TMP_Text/UnicodeChar[] TMPro.TMP_Text::m_TextProcessingArray
IL_032e: ldloc.1
IL_032f: ldelema TMPro.TMP_Text/UnicodeChar
IL_0334: ldc.i4.1
IL_0335: stfld System.Int32 TMPro.TMP_Text/UnicodeChar::length
IL_033a: ldloc.2
IL_033b: ldc.i4.1
IL_033c: add
IL_033d: stloc.2
IL_033e: ldloc.1
IL_033f: ldc.i4.1
IL_0340: add
IL_0341: stloc.1
IL_0342: br IL_076a
IL_0347: ldloc.0
IL_0348: ldloc.2
IL_0349: ldc.i4.5
IL_034a: add
IL_034b: ble IL_0429
IL_0350: ldloc.1
IL_0351: ldarg.0
IL_0352: ldfld TMPro.TMP_Text/UnicodeChar[] TMPro.TMP_Text::m_TextProcessingArray
IL_0357: ldlen
IL_0358: conv.i4
IL_0359: bne.un.s IL_0367
IL_035b: ldarg.0
IL_035c: ldarg.0
IL_035d: ldflda TMPro.TMP_Text/UnicodeChar[] TMPro.TMP_Text::m_TextProcessingArray
IL_0362: call System.Void TMPro.TMP_Text::ResizeInternalArray<TMPro.TMP_Text/UnicodeChar>(T[]&)
IL_0367: ldarg.0
IL_0368: ldfld TMPro.TMP_Text/UnicodeChar[] TMPro.TMP_Text::m_TextProcessingArray
IL_036d: ldloc.1
IL_036e: ldelema TMPro.TMP_Text/UnicodeChar
IL_0373: ldarg.0
IL_0374: ldarg.0
IL_0375: ldfld TMPro.TMP_Text/TextBackingContainer TMPro.TMP_Text::m_TextBackingArray
IL_037a: ldloc.2
IL_037b: ldc.i4.2
IL_037c: add
IL_037d: call System.Int32 TMPro.TMP_Text::GetUTF16(TMPro.TMP_Text/TextBackingContainer,System.Int32)
IL_0382: stfld System.Int32 TMPro.TMP_Text/UnicodeChar::unicode
IL_0387: ldarg.0
IL_0388: ldfld TMPro.TMP_Text/UnicodeChar[] TMPro.TMP_Text::m_TextProcessingArray
IL_038d: ldloc.1
IL_038e: ldelema TMPro.TMP_Text/UnicodeChar
IL_0393: ldloc.2
IL_0394: stfld System.Int32 TMPro.TMP_Text/UnicodeChar::stringIndex
IL_0399: ldarg.0
IL_039a: ldfld TMPro.TMP_Text/UnicodeChar[] TMPro.TMP_Text::m_TextProcessingArray
IL_039f: ldloc.1
IL_03a0: ldelema TMPro.TMP_Text/UnicodeChar
IL_03a5: ldc.i4.6
IL_03a6: stfld System.Int32 TMPro.TMP_Text/UnicodeChar::length
IL_03ab: ldloc.2
IL_03ac: ldc.i4.5
IL_03ad: add
IL_03ae: stloc.2
IL_03af: ldloc.1
IL_03b0: ldc.i4.1
IL_03b1: add
IL_03b2: stloc.1
IL_03b3: br IL_076a
IL_03b8: ldloc.0
IL_03b9: ldloc.2
IL_03ba: ldc.i4.s 9
IL_03bc: add
IL_03bd: ble.s IL_0429
IL_03bf: ldloc.1
IL_03c0: ldarg.0
IL_03c1: ldfld TMPro.TMP_Text/UnicodeChar[] TMPro.TMP_Text::m_TextProcessingArray
IL_03c6: ldlen
IL_03c7: conv.i4
IL_03c8: bne.un.s IL_03d6
IL_03ca: ldarg.0
IL_03cb: ldarg.0
IL_03cc: ldflda TMPro.TMP_Text/UnicodeChar[] TMPro.TMP_Text::m_TextProcessingArray
IL_03d1: call System.Void TMPro.TMP_Text::ResizeInternalArray<TMPro.TMP_Text/UnicodeChar>(T[]&)
IL_03d6: ldarg.0
IL_03d7: ldfld TMPro.TMP_Text/UnicodeChar[] TMPro.TMP_Text::m_TextProcessingArray
IL_03dc: ldloc.1
IL_03dd: ldelema TMPro.TMP_Text/UnicodeChar
IL_03e2: ldarg.0
IL_03e3: ldarg.0
IL_03e4: ldfld TMPro.TMP_Text/TextBackingContainer TMPro.TMP_Text::m_TextBackingArray
IL_03e9: ldloc.2
IL_03ea: ldc.i4.2
IL_03eb: add
IL_03ec: call System.Int32 TMPro.TMP_Text::GetUTF32(TMPro.TMP_Text/TextBackingContainer,System.Int32)
IL_03f1: stfld System.Int32 TMPro.TMP_Text/UnicodeChar::unicode
IL_03f6: ldarg.0
IL_03f7: ldfld TMPro.TMP_Text/UnicodeChar[] TMPro.TMP_Text::m_TextProcessingArray
IL_03fc: ldloc.1
IL_03fd: ldelema TMPro.TMP_Text/UnicodeChar
IL_0402: ldloc.2
IL_0403: stfld System.Int32 TMPro.TMP_Text/UnicodeChar::stringIndex
IL_0408: ldarg.0
IL_0409: ldfld TMPro.TMP_Text/UnicodeChar[] TMPro.TMP_Text::m_TextProcessingArray
IL_040e: ldloc.1
IL_040f: ldelema TMPro.TMP_Text/UnicodeChar
IL_0414: ldc.i4.s 10
IL_0416: stfld System.Int32 TMPro.TMP_Text/UnicodeChar::length
IL_041b: ldloc.2
IL_041c: ldc.i4.s 9
IL_041e: add
IL_041f: stloc.2
IL_0420: ldloc.1
IL_0421: ldc.i4.1
IL_0422: add
IL_0423: stloc.1
IL_0424: br IL_076a
IL_0429: ldloc.3
IL_042a: ldc.i4 55296
IL_042f: blt.un IL_04e2
IL_0434: ldloc.3
IL_0435: ldc.i4 56319
IL_043a: bgt.un IL_04e2
IL_043f: ldloc.0
IL_0440: ldloc.2
IL_0441: ldc.i4.1
IL_0442: add
IL_0443: ble IL_04e2
IL_0448: ldarg.0
IL_0449: ldflda TMPro.TMP_Text/TextBackingContainer TMPro.TMP_Text::m_TextBackingArray
IL_044e: ldloc.2
IL_044f: ldc.i4.1
IL_0450: add
IL_0451: call System.UInt32 TMPro.TMP_Text/TextBackingContainer::get_Item(System.Int32)
IL_0456: ldc.i4 56320
IL_045b: blt.un IL_04e2
IL_0460: ldarg.0
IL_0461: ldflda TMPro.TMP_Text/TextBackingContainer TMPro.TMP_Text::m_TextBackingArray
IL_0466: ldloc.2
IL_0467: ldc.i4.1
IL_0468: add
IL_0469: call System.UInt32 TMPro.TMP_Text/TextBackingContainer::get_Item(System.Int32)
IL_046e: ldc.i4 57343
IL_0473: bgt.un.s IL_04e2
IL_0475: ldloc.1
IL_0476: ldarg.0
IL_0477: ldfld TMPro.TMP_Text/UnicodeChar[] TMPro.TMP_Text::m_TextProcessingArray
IL_047c: ldlen
IL_047d: conv.i4
IL_047e: bne.un.s IL_048c
IL_0480: ldarg.0
IL_0481: ldarg.0
IL_0482: ldflda TMPro.TMP_Text/UnicodeChar[] TMPro.TMP_Text::m_TextProcessingArray
IL_0487: call System.Void TMPro.TMP_Text::ResizeInternalArray<TMPro.TMP_Text/UnicodeChar>(T[]&)
IL_048c: ldarg.0
IL_048d: ldfld TMPro.TMP_Text/UnicodeChar[] TMPro.TMP_Text::m_TextProcessingArray
IL_0492: ldloc.1
IL_0493: ldelema TMPro.TMP_Text/UnicodeChar
IL_0498: ldloc.3
IL_0499: ldarg.0
IL_049a: ldflda TMPro.TMP_Text/TextBackingContainer TMPro.TMP_Text::m_TextBackingArray
IL_049f: ldloc.2
IL_04a0: ldc.i4.1
IL_04a1: add
IL_04a2: call System.UInt32 TMPro.TMP_Text/TextBackingContainer::get_Item(System.Int32)
IL_04a7: call System.UInt32 TMPro.TMP_TextParsingUtilities::ConvertToUTF32(System.UInt32,System.UInt32)
IL_04ac: stfld System.Int32 TMPro.TMP_Text/UnicodeChar::unicode
IL_04b1: ldarg.0
IL_04b2: ldfld TMPro.TMP_Text/UnicodeChar[] TMPro.TMP_Text::m_TextProcessingArray
IL_04b7: ldloc.1
IL_04b8: ldelema TMPro.TMP_Text/UnicodeChar
IL_04bd: ldloc.2
IL_04be: stfld System.Int32 TMPro.TMP_Text/UnicodeChar::stringIndex
IL_04c3: ldarg.0
IL_04c4: ldfld TMPro.TMP_Text/UnicodeChar[] TMPro.TMP_Text::m_TextProcessingArray
IL_04c9: ldloc.1
IL_04ca: ldelema TMPro.TMP_Text/UnicodeChar
IL_04cf: ldc.i4.2
IL_04d0: stfld System.Int32 TMPro.TMP_Text/UnicodeChar::length
IL_04d5: ldloc.2
IL_04d6: ldc.i4.1
IL_04d7: add
IL_04d8: stloc.2
IL_04d9: ldloc.1
IL_04da: ldc.i4.1
IL_04db: add
IL_04dc: stloc.1
IL_04dd: br IL_076a
IL_04e2: ldloc.3
IL_04e3: ldc.i4.s 60
IL_04e5: bne.un IL_0719
IL_04ea: ldarg.0
IL_04eb: ldfld System.Boolean TMPro.TMP_Text::m_isRichText
IL_04f0: brfalse IL_0719
IL_04f5: ldarg.0
IL_04f6: ldarg.0
IL_04f7: ldfld TMPro.TMP_Text/TextBackingContainer TMPro.TMP_Text::m_TextBackingArray
IL_04fc: ldloc.2
IL_04fd: ldc.i4.1
IL_04fe: add
IL_04ff: call System.Int32 TMPro.TMP_Text::GetMarkupTagHashCode(TMPro.TMP_Text/TextBackingContainer,System.Int32)
IL_0504: stloc.s V_8
IL_0506: ldloc.s V_8
IL_0508: ldc.i4 2869039
IL_050d: bgt.s IL_0529
IL_050f: ldloc.s V_8
IL_0511: ldc.i4 2256
IL_0516: beq.s IL_0552
IL_0518: ldloc.s V_8
IL_051a: ldc.i4 2869039
IL_051f: beq IL_05ad
IL_0524: br IL_0719
IL_0529: ldloc.s V_8
IL_052b: ldc.i4 3288238
IL_0530: beq IL_060b
IL_0535: ldloc.s V_8
IL_0537: ldc.i4 100252951
IL_053c: beq IL_0669
IL_0541: ldloc.s V_8
IL_0543: ldc.i4 1927738392
IL_0548: beq IL_06c8
IL_054d: br IL_0719
IL_0552: ldloc.1
IL_0553: ldarg.0
IL_0554: ldfld TMPro.TMP_Text/UnicodeChar[] TMPro.TMP_Text::m_TextProcessingArray
IL_0559: ldlen
IL_055a: conv.i4
IL_055b: bne.un.s IL_0569
IL_055d: ldarg.0
IL_055e: ldarg.0
IL_055f: ldflda TMPro.TMP_Text/UnicodeChar[] TMPro.TMP_Text::m_TextProcessingArray
IL_0564: call System.Void TMPro.TMP_Text::ResizeInternalArray<TMPro.TMP_Text/UnicodeChar>(T[]&)
IL_0569: ldarg.0
IL_056a: ldfld TMPro.TMP_Text/UnicodeChar[] TMPro.TMP_Text::m_TextProcessingArray
IL_056f: ldloc.1
IL_0570: ldelema TMPro.TMP_Text/UnicodeChar
IL_0575: ldc.i4.s 10
IL_0577: stfld System.Int32 TMPro.TMP_Text/UnicodeChar::unicode
IL_057c: ldarg.0
IL_057d: ldfld TMPro.TMP_Text/UnicodeChar[] TMPro.TMP_Text::m_TextProcessingArray
IL_0582: ldloc.1
IL_0583: ldelema TMPro.TMP_Text/UnicodeChar
IL_0588: ldloc.2
IL_0589: stfld System.Int32 TMPro.TMP_Text/UnicodeChar::stringIndex
IL_058e: ldarg.0
IL_058f: ldfld TMPro.TMP_Text/UnicodeChar[] TMPro.TMP_Text::m_TextProcessingArray
IL_0594: ldloc.1
IL_0595: ldelema TMPro.TMP_Text/UnicodeChar
IL_059a: ldc.i4.4
IL_059b: stfld System.Int32 TMPro.TMP_Text/UnicodeChar::length
IL_05a0: ldloc.1
IL_05a1: ldc.i4.1
IL_05a2: add
IL_05a3: stloc.1
IL_05a4: ldloc.2
IL_05a5: ldc.i4.3
IL_05a6: add
IL_05a7: stloc.2
IL_05a8: br IL_076a
IL_05ad: ldloc.1
IL_05ae: ldarg.0
IL_05af: ldfld TMPro.TMP_Text/UnicodeChar[] TMPro.TMP_Text::m_TextProcessingArray
IL_05b4: ldlen
IL_05b5: conv.i4
IL_05b6: bne.un.s IL_05c4
IL_05b8: ldarg.0
IL_05b9: ldarg.0
IL_05ba: ldflda TMPro.TMP_Text/UnicodeChar[] TMPro.TMP_Text::m_TextProcessingArray
IL_05bf: call System.Void TMPro.TMP_Text::ResizeInternalArray<TMPro.TMP_Text/UnicodeChar>(T[]&)
IL_05c4: ldarg.0
IL_05c5: ldfld TMPro.TMP_Text/UnicodeChar[] TMPro.TMP_Text::m_TextProcessingArray
IL_05ca: ldloc.1
IL_05cb: ldelema TMPro.TMP_Text/UnicodeChar
IL_05d0: ldc.i4 160
IL_05d5: stfld System.Int32 TMPro.TMP_Text/UnicodeChar::unicode
IL_05da: ldarg.0
IL_05db: ldfld TMPro.TMP_Text/UnicodeChar[] TMPro.TMP_Text::m_TextProcessingArray
IL_05e0: ldloc.1
IL_05e1: ldelema TMPro.TMP_Text/UnicodeChar
IL_05e6: ldloc.2
IL_05e7: stfld System.Int32 TMPro.TMP_Text/UnicodeChar::stringIndex
IL_05ec: ldarg.0
IL_05ed: ldfld TMPro.TMP_Text/UnicodeChar[] TMPro.TMP_Text::m_TextProcessingArray
IL_05f2: ldloc.1
IL_05f3: ldelema TMPro.TMP_Text/UnicodeChar
IL_05f8: ldc.i4.6
IL_05f9: stfld System.Int32 TMPro.TMP_Text/UnicodeChar::length
IL_05fe: ldloc.1
IL_05ff: ldc.i4.1
IL_0600: add
IL_0601: stloc.1
IL_0602: ldloc.2
IL_0603: ldc.i4.5
IL_0604: add
IL_0605: stloc.2
IL_0606: br IL_076a
IL_060b: ldloc.1
IL_060c: ldarg.0
IL_060d: ldfld TMPro.TMP_Text/UnicodeChar[] TMPro.TMP_Text::m_TextProcessingArray
IL_0612: ldlen
IL_0613: conv.i4
IL_0614: bne.un.s IL_0622
IL_0616: ldarg.0
IL_0617: ldarg.0
IL_0618: ldflda TMPro.TMP_Text/UnicodeChar[] TMPro.TMP_Text::m_TextProcessingArray
IL_061d: call System.Void TMPro.TMP_Text::ResizeInternalArray<TMPro.TMP_Text/UnicodeChar>(T[]&)
IL_0622: ldarg.0
IL_0623: ldfld TMPro.TMP_Text/UnicodeChar[] TMPro.TMP_Text::m_TextProcessingArray
IL_0628: ldloc.1
IL_0629: ldelema TMPro.TMP_Text/UnicodeChar
IL_062e: ldc.i4 8203
IL_0633: stfld System.Int32 TMPro.TMP_Text/UnicodeChar::unicode
IL_0638: ldarg.0
IL_0639: ldfld TMPro.TMP_Text/UnicodeChar[] TMPro.TMP_Text::m_TextProcessingArray
IL_063e: ldloc.1
IL_063f: ldelema TMPro.TMP_Text/UnicodeChar
IL_0644: ldloc.2
IL_0645: stfld System.Int32 TMPro.TMP_Text/UnicodeChar::stringIndex
IL_064a: ldarg.0
IL_064b: ldfld TMPro.TMP_Text/UnicodeChar[] TMPro.TMP_Text::m_TextProcessingArray
IL_0650: ldloc.1
IL_0651: ldelema TMPro.TMP_Text/UnicodeChar
IL_0656: ldc.i4.6
IL_0657: stfld System.Int32 TMPro.TMP_Text/UnicodeChar::length
IL_065c: ldloc.1
IL_065d: ldc.i4.1
IL_065e: add
IL_065f: stloc.1
IL_0660: ldloc.2
IL_0661: ldc.i4.5
IL_0662: add
IL_0663: stloc.2
IL_0664: br IL_076a
IL_0669: ldloc.1
IL_066a: stloc.s V_5
IL_066c: ldarg.0
IL_066d: ldarg.0
IL_066e: ldflda TMPro.TMP_Text/TextBackingContainer TMPro.TMP_Text::m_TextBackingArray
IL_0673: ldloc.2
IL_0674: ldloca.s V_6
IL_0676: ldarg.0
IL_0677: ldflda TMPro.TMP_Text/UnicodeChar[] TMPro.TMP_Text::m_TextProcessingArray
IL_067c: ldloca.s V_1
IL_067e: call System.Boolean TMPro.TMP_Text::ReplaceOpeningStyleTag(TMPro.TMP_Text/TextBackingContainer&,System.Int32,System.Int32&,TMPro.TMP_Text/UnicodeChar[]&,System.Int32&)
IL_0683: brfalse IL_0719
IL_0688: br.s IL_06bb
IL_068a: ldarg.0
IL_068b: ldfld TMPro.TMP_Text/UnicodeChar[] TMPro.TMP_Text::m_TextProcessingArray
IL_0690: ldloc.s V_5
IL_0692: ldelema TMPro.TMP_Text/UnicodeChar
IL_0697: ldloc.2
IL_0698: stfld System.Int32 TMPro.TMP_Text/UnicodeChar::stringIndex
IL_069d: ldarg.0
IL_069e: ldfld TMPro.TMP_Text/UnicodeChar[] TMPro.TMP_Text::m_TextProcessingArray
IL_06a3: ldloc.s V_5
IL_06a5: ldelema TMPro.TMP_Text/UnicodeChar
IL_06aa: ldloc.s V_6
IL_06ac: ldloc.2
IL_06ad: sub
IL_06ae: ldc.i4.1
IL_06af: add
IL_06b0: stfld System.Int32 TMPro.TMP_Text/UnicodeChar::length
IL_06b5: ldloc.s V_5
IL_06b7: ldc.i4.1
IL_06b8: add
IL_06b9: stloc.s V_5
IL_06bb: ldloc.s V_5
IL_06bd: ldloc.1
IL_06be: blt.s IL_068a
IL_06c0: ldloc.s V_6
IL_06c2: stloc.2
IL_06c3: br IL_076a
IL_06c8: ldloc.1
IL_06c9: stloc.s V_7
IL_06cb: ldarg.0
IL_06cc: ldarg.0
IL_06cd: ldflda TMPro.TMP_Text/TextBackingContainer TMPro.TMP_Text::m_TextBackingArray
IL_06d2: ldloc.2
IL_06d3: ldarg.0
IL_06d4: ldflda TMPro.TMP_Text/UnicodeChar[] TMPro.TMP_Text::m_TextProcessingArray
IL_06d9: ldloca.s V_1
IL_06db: call System.Void TMPro.TMP_Text::ReplaceClosingStyleTag(TMPro.TMP_Text/TextBackingContainer&,System.Int32,TMPro.TMP_Text/UnicodeChar[]&,System.Int32&)
IL_06e0: br.s IL_070e
IL_06e2: ldarg.0
IL_06e3: ldfld TMPro.TMP_Text/UnicodeChar[] TMPro.TMP_Text::m_TextProcessingArray
IL_06e8: ldloc.s V_7
IL_06ea: ldelema TMPro.TMP_Text/UnicodeChar
IL_06ef: ldloc.2
IL_06f0: stfld System.Int32 TMPro.TMP_Text/UnicodeChar::stringIndex
IL_06f5: ldarg.0
IL_06f6: ldfld TMPro.TMP_Text/UnicodeChar[] TMPro.TMP_Text::m_TextProcessingArray
IL_06fb: ldloc.s V_7
IL_06fd: ldelema TMPro.TMP_Text/UnicodeChar
IL_0702: ldc.i4.8
IL_0703: stfld System.Int32 TMPro.TMP_Text/UnicodeChar::length
IL_0708: ldloc.s V_7
IL_070a: ldc.i4.1
IL_070b: add
IL_070c: stloc.s V_7
IL_070e: ldloc.s V_7
IL_0710: ldloc.1
IL_0711: blt.s IL_06e2
IL_0713: ldloc.2
IL_0714: ldc.i4.7
IL_0715: add
IL_0716: stloc.2
IL_0717: br.s IL_076a
IL_0719: ldloc.1
IL_071a: ldarg.0
IL_071b: ldfld TMPro.TMP_Text/UnicodeChar[] TMPro.TMP_Text::m_TextProcessingArray
IL_0720: ldlen
IL_0721: conv.i4
IL_0722: bne.un.s IL_0730
IL_0724: ldarg.0
IL_0725: ldarg.0
IL_0726: ldflda TMPro.TMP_Text/UnicodeChar[] TMPro.TMP_Text::m_TextProcessingArray
IL_072b: call System.Void TMPro.TMP_Text::ResizeInternalArray<TMPro.TMP_Text/UnicodeChar>(T[]&)
IL_0730: ldarg.0
IL_0731: ldfld TMPro.TMP_Text/UnicodeChar[] TMPro.TMP_Text::m_TextProcessingArray
IL_0736: ldloc.1
IL_0737: ldelema TMPro.TMP_Text/UnicodeChar
IL_073c: ldloc.3
IL_073d: stfld System.Int32 TMPro.TMP_Text/UnicodeChar::unicode
IL_0742: ldarg.0
IL_0743: ldfld TMPro.TMP_Text/UnicodeChar[] TMPro.TMP_Text::m_TextProcessingArray
IL_0748: ldloc.1
IL_0749: ldelema TMPro.TMP_Text/UnicodeChar
IL_074e: ldloc.2
IL_074f: stfld System.Int32 TMPro.TMP_Text/UnicodeChar::stringIndex
IL_0754: ldarg.0
IL_0755: ldfld TMPro.TMP_Text/UnicodeChar[] TMPro.TMP_Text::m_TextProcessingArray
IL_075a: ldloc.1
IL_075b: ldelema TMPro.TMP_Text/UnicodeChar
IL_0760: ldc.i4.1
IL_0761: stfld System.Int32 TMPro.TMP_Text/UnicodeChar::length
IL_0766: ldloc.1
IL_0767: ldc.i4.1
IL_0768: add
IL_0769: stloc.1
IL_076a: ldloc.2
IL_076b: ldc.i4.1
IL_076c: add
IL_076d: stloc.2
IL_076e: ldloc.2
IL_076f: ldloc.0
IL_0770: blt IL_0068
IL_0775: ldarg.0
IL_0776: ldc.i4.0
IL_0777: stfld System.Int32 TMPro.TMP_Text::m_TextStyleStackDepth
IL_077c: ldarg.0
IL_077d: call TMPro.TMP_Style TMPro.TMP_Text::get_textStyle()
IL_0782: callvirt System.Int32 TMPro.TMP_Style::get_hashCode()
IL_0787: ldc.i4 -1183493901
IL_078c: beq.s IL_079c
IL_078e: ldarg.0
IL_078f: ldarg.0
IL_0790: ldflda TMPro.TMP_Text/UnicodeChar[] TMPro.TMP_Text::m_TextProcessingArray
IL_0795: ldloca.s V_1
IL_0797: call System.Void TMPro.TMP_Text::InsertClosingStyleTag(TMPro.TMP_Text/UnicodeChar[]&,System.Int32&)
IL_079c: ldloc.1
IL_079d: ldarg.0
IL_079e: ldfld TMPro.TMP_Text/UnicodeChar[] TMPro.TMP_Text::m_TextProcessingArray
IL_07a3: ldlen
IL_07a4: conv.i4
IL_07a5: bne.un.s IL_07b3
IL_07a7: ldarg.0
IL_07a8: ldarg.0
IL_07a9: ldflda TMPro.TMP_Text/UnicodeChar[] TMPro.TMP_Text::m_TextProcessingArray
IL_07ae: call System.Void TMPro.TMP_Text::ResizeInternalArray<TMPro.TMP_Text/UnicodeChar>(T[]&)
IL_07b3: ldarg.0
IL_07b4: ldfld TMPro.TMP_Text/UnicodeChar[] TMPro.TMP_Text::m_TextProcessingArray
IL_07b9: ldloc.1
IL_07ba: ldelema TMPro.TMP_Text/UnicodeChar
IL_07bf: ldc.i4.0
IL_07c0: stfld System.Int32 TMPro.TMP_Text/UnicodeChar::unicode
IL_07c5: ldarg.0
IL_07c6: ldloc.1
IL_07c7: stfld System.Int32 TMPro.TMP_Text::m_InternalTextProcessingArraySize
IL_07cc: ret
