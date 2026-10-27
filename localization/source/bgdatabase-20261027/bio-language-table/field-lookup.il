TYPE PixelCrushers.TextTableField
METHOD System.String PixelCrushers.TextTableField::get_fieldName() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.String PixelCrushers.TextTableField::m_fieldName
IL_0006: ret
METHOD System.Collections.Generic.Dictionary`2<System.Int32,System.String> PixelCrushers.TextTableField::get_texts() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Collections.Generic.Dictionary`2<System.Int32,System.String> PixelCrushers.TextTableField::m_texts
IL_0006: ret
METHOD System.Boolean PixelCrushers.TextTableField::HasTextForLanguage(System.Int32) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Collections.Generic.Dictionary`2<System.Int32,System.String> PixelCrushers.TextTableField::get_texts()
IL_0006: ldarg.1
IL_0007: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.Int32,System.String>::ContainsKey(!0)
IL_000c: brfalse.s IL_0023
IL_000e: ldarg.0
IL_000f: call System.Collections.Generic.Dictionary`2<System.Int32,System.String> PixelCrushers.TextTableField::get_texts()
IL_0014: ldarg.1
IL_0015: callvirt !1 System.Collections.Generic.Dictionary`2<System.Int32,System.String>::get_Item(!0)
IL_001a: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_001f: ldc.i4.0
IL_0020: ceq
IL_0022: ret
IL_0023: ldc.i4.0
IL_0024: ret
METHOD System.String PixelCrushers.TextTableField::GetTextForLanguage(System.Int32) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Collections.Generic.Dictionary`2<System.Int32,System.String> PixelCrushers.TextTableField::get_texts()
IL_0006: ldarg.1
IL_0007: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.Int32,System.String>::ContainsKey(!0)
IL_000c: brtrue.s IL_0014
IL_000e: ldsfld System.String System.String::Empty
IL_0013: ret
IL_0014: ldarg.0
IL_0015: call System.Collections.Generic.Dictionary`2<System.Int32,System.String> PixelCrushers.TextTableField::get_texts()
IL_001a: ldarg.1
IL_001b: callvirt !1 System.Collections.Generic.Dictionary`2<System.Int32,System.String>::get_Item(!0)
IL_0020: ret
