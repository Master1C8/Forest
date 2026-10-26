TYPE PixelCrushers.DialogueSystem.UnityUITypewriterEffect
METHOD System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.UnityUITypewriterEffect/Token> PixelCrushers.DialogueSystem.UnityUITypewriterEffect::Tokenize(System.String)
IL_0000: newobj System.Void System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.UnityUITypewriterEffect/Token>::.ctor()
IL_0005: stloc.0
IL_0006: ldarg.1
IL_0007: stloc.1
IL_0008: ldc.i4.0
IL_0009: stloc.2
IL_000a: br IL_0195
IL_000f: ldloc.2
IL_0010: ldc.i4.1
IL_0011: add
IL_0012: stloc.2
IL_0013: ldnull
IL_0014: stloc.3
IL_0015: ldloc.1
IL_0016: ldc.i4.0
IL_0017: callvirt System.Char System.String::get_Chars(System.Int32)
IL_001c: stloc.s V_4
IL_001e: ldloca.s V_4
IL_0020: ldc.i4.s 60
IL_0022: call System.Boolean System.Char::Equals(System.Char)
IL_0027: brfalse IL_00df
IL_002c: ldarg.0
IL_002d: ldstr "<b>"
IL_0032: ldc.i4.1
IL_0033: ldc.r4 0
IL_0038: ldloca.s V_1
IL_003a: call PixelCrushers.DialogueSystem.UnityUITypewriterEffect/Token PixelCrushers.DialogueSystem.UnityUITypewriterEffect::TryTokenize(System.String,PixelCrushers.DialogueSystem.UnityUITypewriterEffect/TokenType,System.Single,System.String&)
IL_003f: stloc.3
IL_0040: ldloc.3
IL_0041: brtrue.s IL_0057
IL_0043: ldarg.0
IL_0044: ldstr "</b>"
IL_0049: ldc.i4.2
IL_004a: ldc.r4 0
IL_004f: ldloca.s V_1
IL_0051: call PixelCrushers.DialogueSystem.UnityUITypewriterEffect/Token PixelCrushers.DialogueSystem.UnityUITypewriterEffect::TryTokenize(System.String,PixelCrushers.DialogueSystem.UnityUITypewriterEffect/TokenType,System.Single,System.String&)
IL_0056: stloc.3
IL_0057: ldloc.3
IL_0058: brtrue.s IL_006e
IL_005a: ldarg.0
IL_005b: ldstr "<i>"
IL_0060: ldc.i4.3
IL_0061: ldc.r4 0
IL_0066: ldloca.s V_1
IL_0068: call PixelCrushers.DialogueSystem.UnityUITypewriterEffect/Token PixelCrushers.DialogueSystem.UnityUITypewriterEffect::TryTokenize(System.String,PixelCrushers.DialogueSystem.UnityUITypewriterEffect/TokenType,System.Single,System.String&)
IL_006d: stloc.3
IL_006e: ldloc.3
IL_006f: brtrue.s IL_0085
IL_0071: ldarg.0
IL_0072: ldstr "</i>"
IL_0077: ldc.i4.4
IL_0078: ldc.r4 0
IL_007d: ldloca.s V_1
IL_007f: call PixelCrushers.DialogueSystem.UnityUITypewriterEffect/Token PixelCrushers.DialogueSystem.UnityUITypewriterEffect::TryTokenize(System.String,PixelCrushers.DialogueSystem.UnityUITypewriterEffect/TokenType,System.Single,System.String&)
IL_0084: stloc.3
IL_0085: ldloc.3
IL_0086: brtrue.s IL_009c
IL_0088: ldarg.0
IL_0089: ldstr "</color>"
IL_008e: ldc.i4.6
IL_008f: ldc.r4 0
IL_0094: ldloca.s V_1
IL_0096: call PixelCrushers.DialogueSystem.UnityUITypewriterEffect/Token PixelCrushers.DialogueSystem.UnityUITypewriterEffect::TryTokenize(System.String,PixelCrushers.DialogueSystem.UnityUITypewriterEffect/TokenType,System.Single,System.String&)
IL_009b: stloc.3
IL_009c: ldloc.3
IL_009d: brtrue.s IL_00b3
IL_009f: ldarg.0
IL_00a0: ldstr "</size>"
IL_00a5: ldc.i4.8
IL_00a6: ldc.r4 0
IL_00ab: ldloca.s V_1
IL_00ad: call PixelCrushers.DialogueSystem.UnityUITypewriterEffect/Token PixelCrushers.DialogueSystem.UnityUITypewriterEffect::TryTokenize(System.String,PixelCrushers.DialogueSystem.UnityUITypewriterEffect/TokenType,System.Single,System.String&)
IL_00b2: stloc.3
IL_00b3: ldloc.3
IL_00b4: brtrue.s IL_00bf
IL_00b6: ldarg.0
IL_00b7: ldloca.s V_1
IL_00b9: call PixelCrushers.DialogueSystem.UnityUITypewriterEffect/Token PixelCrushers.DialogueSystem.UnityUITypewriterEffect::TryTokenizeColorOpen(System.String&)
IL_00be: stloc.3
IL_00bf: ldloc.3
IL_00c0: brtrue.s IL_00cb
IL_00c2: ldarg.0
IL_00c3: ldloca.s V_1
IL_00c5: call PixelCrushers.DialogueSystem.UnityUITypewriterEffect/Token PixelCrushers.DialogueSystem.UnityUITypewriterEffect::TryTokenizeSizeOpen(System.String&)
IL_00ca: stloc.3
IL_00cb: ldloc.3
IL_00cc: brtrue IL_016a
IL_00d1: ldarg.0
IL_00d2: ldloca.s V_1
IL_00d4: call PixelCrushers.DialogueSystem.UnityUITypewriterEffect/Token PixelCrushers.DialogueSystem.UnityUITypewriterEffect::TryTokenizeQuad(System.String&)
IL_00d9: stloc.3
IL_00da: br IL_016a
IL_00df: ldloc.1
IL_00e0: ldc.i4.0
IL_00e1: callvirt System.Char System.String::get_Chars(System.Int32)
IL_00e6: stloc.s V_4
IL_00e8: ldloca.s V_4
IL_00ea: ldc.i4.s 92
IL_00ec: call System.Boolean System.Char::Equals(System.Char)
IL_00f1: brfalse.s IL_016a
IL_00f3: ldarg.0
IL_00f4: ldstr "\."
IL_00f9: ldc.i4.s 10
IL_00fb: ldarg.0
IL_00fc: ldfld System.Single PixelCrushers.DialogueSystem.AbstractTypewriterEffect::fullPauseDuration
IL_0101: ldloca.s V_1
IL_0103: call PixelCrushers.DialogueSystem.UnityUITypewriterEffect/Token PixelCrushers.DialogueSystem.UnityUITypewriterEffect::TryTokenize(System.String,PixelCrushers.DialogueSystem.UnityUITypewriterEffect/TokenType,System.Single,System.String&)
IL_0108: stloc.3
IL_0109: ldloc.3
IL_010a: brtrue.s IL_0122
IL_010c: ldarg.0
IL_010d: ldstr "\,"
IL_0112: ldc.i4.s 10
IL_0114: ldarg.0
IL_0115: ldfld System.Single PixelCrushers.DialogueSystem.AbstractTypewriterEffect::quarterPauseDuration
IL_011a: ldloca.s V_1
IL_011c: call PixelCrushers.DialogueSystem.UnityUITypewriterEffect/Token PixelCrushers.DialogueSystem.UnityUITypewriterEffect::TryTokenize(System.String,PixelCrushers.DialogueSystem.UnityUITypewriterEffect/TokenType,System.Single,System.String&)
IL_0121: stloc.3
IL_0122: ldloc.3
IL_0123: brtrue.s IL_013a
IL_0125: ldarg.0
IL_0126: ldstr "\>"
IL_012b: ldc.i4.s 11
IL_012d: ldc.r4 0
IL_0132: ldloca.s V_1
IL_0134: call PixelCrushers.DialogueSystem.UnityUITypewriterEffect/Token PixelCrushers.DialogueSystem.UnityUITypewriterEffect::TryTokenize(System.String,PixelCrushers.DialogueSystem.UnityUITypewriterEffect/TokenType,System.Single,System.String&)
IL_0139: stloc.3
IL_013a: ldloc.3
IL_013b: brtrue.s IL_0152
IL_013d: ldarg.0
IL_013e: ldstr "\<"
IL_0143: ldc.i4.s 12
IL_0145: ldc.r4 0
IL_014a: ldloca.s V_1
IL_014c: call PixelCrushers.DialogueSystem.UnityUITypewriterEffect/Token PixelCrushers.DialogueSystem.UnityUITypewriterEffect::TryTokenize(System.String,PixelCrushers.DialogueSystem.UnityUITypewriterEffect/TokenType,System.Single,System.String&)
IL_0151: stloc.3
IL_0152: ldloc.3
IL_0153: brtrue.s IL_016a
IL_0155: ldarg.0
IL_0156: ldstr "\^"
IL_015b: ldc.i4.s 11
IL_015d: ldc.r4 0
IL_0162: ldloca.s V_1
IL_0164: call PixelCrushers.DialogueSystem.UnityUITypewriterEffect/Token PixelCrushers.DialogueSystem.UnityUITypewriterEffect::TryTokenize(System.String,PixelCrushers.DialogueSystem.UnityUITypewriterEffect/TokenType,System.Single,System.String&)
IL_0169: stloc.3
IL_016a: ldloc.3
IL_016b: brtrue.s IL_018e
IL_016d: ldc.i4.0
IL_016e: ldloc.1
IL_016f: ldc.i4.0
IL_0170: callvirt System.Char System.String::get_Chars(System.Int32)
IL_0175: ldsfld System.String System.String::Empty
IL_017a: ldc.r4 0
IL_017f: newobj System.Void PixelCrushers.DialogueSystem.UnityUITypewriterEffect/Token::.ctor(PixelCrushers.DialogueSystem.UnityUITypewriterEffect/TokenType,System.Char,System.String,System.Single)
IL_0184: stloc.3
IL_0185: ldloc.1
IL_0186: ldc.i4.0
IL_0187: ldc.i4.1
IL_0188: callvirt System.String System.String::Remove(System.Int32,System.Int32)
IL_018d: stloc.1
IL_018e: ldloc.0
IL_018f: ldloc.3
IL_0190: callvirt System.Void System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.UnityUITypewriterEffect/Token>::Add(!0)
IL_0195: ldloc.1
IL_0196: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_019b: brtrue.s IL_01a9
IL_019d: ldloc.2
IL_019e: ldarg.0
IL_019f: ldfld System.Int32 PixelCrushers.DialogueSystem.UnityUITypewriterEffect::MaxSafeguard
IL_01a4: blt IL_000f
IL_01a9: ldloc.0
IL_01aa: ret
