TYPE PixelCrushers.DialogueSystem.TextMeshProTypewriterEffect
METHOD System.Void PixelCrushers.DialogueSystem.TextMeshProTypewriterEffect::StartTyping(System.String,System.Int32)
IL_0000: ldarg.0
IL_0001: call System.Void PixelCrushers.DialogueSystem.TextMeshProTypewriterEffect::StopTypewriterCoroutine()
IL_0006: ldarg.0
IL_0007: call TMPro.TMP_Text PixelCrushers.DialogueSystem.TextMeshProTypewriterEffect::get_textComponent()
IL_000c: ldarg.1
IL_000d: callvirt System.Void TMPro.TMP_Text::set_text(System.String)
IL_0012: ldarg.0
IL_0013: ldarg.2
IL_0014: callvirt System.Void PixelCrushers.DialogueSystem.TextMeshProTypewriterEffect::StartTypewriterCoroutine(System.Int32)
IL_0019: ret
METHOD System.Void PixelCrushers.DialogueSystem.TextMeshProTypewriterEffect::PlayText(System.String,System.Int32)
IL_0000: ldarg.0
IL_0001: call System.Void PixelCrushers.DialogueSystem.TextMeshProTypewriterEffect::StopTypewriterCoroutine()
IL_0006: ldarg.0
IL_0007: call TMPro.TMP_Text PixelCrushers.DialogueSystem.TextMeshProTypewriterEffect::get_textComponent()
IL_000c: ldarg.1
IL_000d: callvirt System.Void TMPro.TMP_Text::set_text(System.String)
IL_0012: ldarg.0
IL_0013: ldarg.2
IL_0014: callvirt System.Void PixelCrushers.DialogueSystem.TextMeshProTypewriterEffect::StartTypewriterCoroutine(System.Int32)
IL_0019: ret
METHOD System.Void PixelCrushers.DialogueSystem.TextMeshProTypewriterEffect::ProcessRPGMakerCodes()
IL_0000: ldarg.0
IL_0001: ldfld System.Collections.Generic.Dictionary`2<System.Int32,System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.TextMeshProTypewriterEffect/RPGMakerTokenType>> PixelCrushers.DialogueSystem.TextMeshProTypewriterEffect::rpgMakerTokens
IL_0006: callvirt System.Void System.Collections.Generic.Dictionary`2<System.Int32,System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.TextMeshProTypewriterEffect/RPGMakerTokenType>>::Clear()
IL_000b: ldarg.0
IL_000c: call TMPro.TMP_Text PixelCrushers.DialogueSystem.TextMeshProTypewriterEffect::get_textComponent()
IL_0011: callvirt System.String TMPro.TMP_Text::get_text()
IL_0016: stloc.0
IL_0017: ldsfld System.String System.String::Empty
IL_001c: stloc.1
IL_001d: ldloc.0
IL_001e: ldstr "\"
IL_0023: callvirt System.Boolean System.String::Contains(System.String)
IL_0028: brtrue.s IL_002b
IL_002a: ret
IL_002b: ldloc.0
IL_002c: call System.String PixelCrushers.DialogueSystem.Tools::StripTextMeshProTags(System.String)
IL_0031: stloc.0
IL_0032: ldc.i4.0
IL_0033: stloc.2
IL_0034: br.s IL_00a4
IL_0036: ldloc.2
IL_0037: ldc.i4.1
IL_0038: add
IL_0039: stloc.2
IL_003a: ldarg.0
IL_003b: ldloca.s V_0
IL_003d: ldloca.s V_3
IL_003f: call System.Boolean PixelCrushers.DialogueSystem.TextMeshProTypewriterEffect::PeelRPGMakerTokenFromFront(System.String&,PixelCrushers.DialogueSystem.TextMeshProTypewriterEffect/RPGMakerTokenType&)
IL_0044: brfalse.s IL_0084
IL_0046: ldloc.1
IL_0047: callvirt System.Int32 System.String::get_Length()
IL_004c: stloc.s V_4
IL_004e: ldarg.0
IL_004f: ldfld System.Collections.Generic.Dictionary`2<System.Int32,System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.TextMeshProTypewriterEffect/RPGMakerTokenType>> PixelCrushers.DialogueSystem.TextMeshProTypewriterEffect::rpgMakerTokens
IL_0054: ldloc.s V_4
IL_0056: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.Int32,System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.TextMeshProTypewriterEffect/RPGMakerTokenType>>::ContainsKey(!0)
IL_005b: brtrue.s IL_006f
IL_005d: ldarg.0
IL_005e: ldfld System.Collections.Generic.Dictionary`2<System.Int32,System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.TextMeshProTypewriterEffect/RPGMakerTokenType>> PixelCrushers.DialogueSystem.TextMeshProTypewriterEffect::rpgMakerTokens
IL_0063: ldloc.s V_4
IL_0065: newobj System.Void System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.TextMeshProTypewriterEffect/RPGMakerTokenType>::.ctor()
IL_006a: callvirt System.Void System.Collections.Generic.Dictionary`2<System.Int32,System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.TextMeshProTypewriterEffect/RPGMakerTokenType>>::Add(!0,!1)
IL_006f: ldarg.0
IL_0070: ldfld System.Collections.Generic.Dictionary`2<System.Int32,System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.TextMeshProTypewriterEffect/RPGMakerTokenType>> PixelCrushers.DialogueSystem.TextMeshProTypewriterEffect::rpgMakerTokens
IL_0075: ldloc.s V_4
IL_0077: callvirt !1 System.Collections.Generic.Dictionary`2<System.Int32,System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.TextMeshProTypewriterEffect/RPGMakerTokenType>>::get_Item(!0)
IL_007c: ldloc.3
IL_007d: callvirt System.Void System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.TextMeshProTypewriterEffect/RPGMakerTokenType>::Add(!0)
IL_0082: br.s IL_00a4
IL_0084: ldloc.1
IL_0085: ldloc.0
IL_0086: ldc.i4.0
IL_0087: callvirt System.Char System.String::get_Chars(System.Int32)
IL_008c: stloc.s V_5
IL_008e: ldloca.s V_5
IL_0090: call System.String System.Char::ToString()
IL_0095: call System.String System.String::Concat(System.String,System.String)
IL_009a: stloc.1
IL_009b: ldloc.0
IL_009c: ldc.i4.0
IL_009d: ldc.i4.1
IL_009e: callvirt System.String System.String::Remove(System.Int32,System.Int32)
IL_00a3: stloc.0
IL_00a4: ldloc.0
IL_00a5: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_00aa: brtrue.s IL_00b4
IL_00ac: ldloc.2
IL_00ad: ldc.i4 9999
IL_00b2: blt.s IL_0036
IL_00b4: ldarg.0
IL_00b5: call TMPro.TMP_Text PixelCrushers.DialogueSystem.TextMeshProTypewriterEffect::get_textComponent()
IL_00ba: ldarg.0
IL_00bb: call TMPro.TMP_Text PixelCrushers.DialogueSystem.TextMeshProTypewriterEffect::get_textComponent()
IL_00c0: callvirt System.String TMPro.TMP_Text::get_text()
IL_00c5: ldstr "\\[\.\,\^\<\>]"
IL_00ca: ldsfld System.String System.String::Empty
IL_00cf: call System.String System.Text.RegularExpressions.Regex::Replace(System.String,System.String,System.String)
IL_00d4: callvirt System.Void TMPro.TMP_Text::set_text(System.String)
IL_00d9: ret
METHOD System.Boolean PixelCrushers.DialogueSystem.TextMeshProTypewriterEffect::PeelRPGMakerTokenFromFront(System.String&,PixelCrushers.DialogueSystem.TextMeshProTypewriterEffect/RPGMakerTokenType&)
IL_0000: ldarg.2
IL_0001: ldc.i4.0
IL_0002: stind.i4
IL_0003: ldarg.1
IL_0004: ldind.ref
IL_0005: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_000a: brtrue.s IL_0022
IL_000c: ldarg.1
IL_000d: ldind.ref
IL_000e: callvirt System.Int32 System.String::get_Length()
IL_0013: ldc.i4.2
IL_0014: blt.s IL_0022
IL_0016: ldarg.1
IL_0017: ldind.ref
IL_0018: ldc.i4.0
IL_0019: callvirt System.Char System.String::get_Chars(System.Int32)
IL_001e: ldc.i4.s 92
IL_0020: beq.s IL_0024
IL_0022: ldc.i4.0
IL_0023: ret
IL_0024: ldarg.1
IL_0025: ldind.ref
IL_0026: ldc.i4.0
IL_0027: ldc.i4.2
IL_0028: callvirt System.String System.String::Substring(System.Int32,System.Int32)
IL_002d: stloc.0
IL_002e: ldloc.0
IL_002f: ldstr "\,"
IL_0034: call System.Boolean System.String::Equals(System.String,System.String)
IL_0039: brfalse.s IL_0040
IL_003b: ldarg.2
IL_003c: ldc.i4.1
IL_003d: stind.i4
IL_003e: br.s IL_008a
IL_0040: ldloc.0
IL_0041: ldstr "\."
IL_0046: call System.Boolean System.String::Equals(System.String,System.String)
IL_004b: brfalse.s IL_0052
IL_004d: ldarg.2
IL_004e: ldc.i4.2
IL_004f: stind.i4
IL_0050: br.s IL_008a
IL_0052: ldloc.0
IL_0053: ldstr "\^"
IL_0058: call System.Boolean System.String::Equals(System.String,System.String)
IL_005d: brfalse.s IL_0064
IL_005f: ldarg.2
IL_0060: ldc.i4.3
IL_0061: stind.i4
IL_0062: br.s IL_008a
IL_0064: ldloc.0
IL_0065: ldstr "\>"
IL_006a: call System.Boolean System.String::Equals(System.String,System.String)
IL_006f: brfalse.s IL_0076
IL_0071: ldarg.2
IL_0072: ldc.i4.4
IL_0073: stind.i4
IL_0074: br.s IL_008a
IL_0076: ldloc.0
IL_0077: ldstr "\<"
IL_007c: call System.Boolean System.String::Equals(System.String,System.String)
IL_0081: brfalse.s IL_0088
IL_0083: ldarg.2
IL_0084: ldc.i4.5
IL_0085: stind.i4
IL_0086: br.s IL_008a
IL_0088: ldc.i4.0
IL_0089: ret
IL_008a: ldarg.1
IL_008b: ldarg.1
IL_008c: ldind.ref
IL_008d: ldc.i4.0
IL_008e: ldc.i4.2
IL_008f: callvirt System.String System.String::Remove(System.Int32,System.Int32)
IL_0094: stind.ref
IL_0095: ldc.i4.1
IL_0096: ret
