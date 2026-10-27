TYPE PixelCrushers.TextTable
METHOD System.Void PixelCrushers.TextTable::set_useDefaultLanguageForBlankTranslations(System.Boolean) | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: stsfld System.Boolean PixelCrushers.TextTable::m_useDefaultLanguageForBlankTranslations
IL_0006: ret
METHOD System.Collections.Generic.Dictionary`2<System.String,System.Int32> PixelCrushers.TextTable::get_languages() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Collections.Generic.Dictionary`2<System.String,System.Int32> PixelCrushers.TextTable::m_languages
IL_0006: ret
METHOD System.Collections.Generic.Dictionary`2<System.Int32,PixelCrushers.TextTableField> PixelCrushers.TextTable::get_fields() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Collections.Generic.Dictionary`2<System.Int32,PixelCrushers.TextTableField> PixelCrushers.TextTable::m_fields
IL_0006: ret
METHOD System.String PixelCrushers.TextTable::GetFieldName(System.Int32) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Collections.Generic.Dictionary`2<System.Int32,PixelCrushers.TextTableField> PixelCrushers.TextTable::get_fields()
IL_0006: ldarg.1
IL_0007: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.Int32,PixelCrushers.TextTableField>::ContainsKey(!0)
IL_000c: brtrue.s IL_0014
IL_000e: ldsfld System.String System.String::Empty
IL_0013: ret
IL_0014: ldarg.0
IL_0015: call System.Collections.Generic.Dictionary`2<System.Int32,PixelCrushers.TextTableField> PixelCrushers.TextTable::get_fields()
IL_001a: ldarg.1
IL_001b: callvirt !1 System.Collections.Generic.Dictionary`2<System.Int32,PixelCrushers.TextTableField>::get_Item(!0)
IL_0020: callvirt System.String PixelCrushers.TextTableField::get_fieldName()
IL_0025: ret
METHOD System.Void PixelCrushers.TextTable::.ctor() | attributes=Public, HideBySig, SpecialName, RTSpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: newobj System.Void System.Collections.Generic.Dictionary`2<System.String,System.Int32>::.ctor()
IL_0006: stfld System.Collections.Generic.Dictionary`2<System.String,System.Int32> PixelCrushers.TextTable::m_languages
IL_000b: ldarg.0
IL_000c: newobj System.Void System.Collections.Generic.Dictionary`2<System.Int32,PixelCrushers.TextTableField>::.ctor()
IL_0011: stfld System.Collections.Generic.Dictionary`2<System.Int32,PixelCrushers.TextTableField> PixelCrushers.TextTable::m_fields
IL_0016: ldarg.0
IL_0017: newobj System.Void System.Collections.Generic.List`1<System.String>::.ctor()
IL_001c: stfld System.Collections.Generic.List`1<System.String> PixelCrushers.TextTable::m_languageKeys
IL_0021: ldarg.0
IL_0022: newobj System.Void System.Collections.Generic.List`1<System.Int32>::.ctor()
IL_0027: stfld System.Collections.Generic.List`1<System.Int32> PixelCrushers.TextTable::m_languageValues
IL_002c: ldarg.0
IL_002d: newobj System.Void System.Collections.Generic.List`1<System.Int32>::.ctor()
IL_0032: stfld System.Collections.Generic.List`1<System.Int32> PixelCrushers.TextTable::m_fieldKeys
IL_0037: ldarg.0
IL_0038: newobj System.Void System.Collections.Generic.List`1<PixelCrushers.TextTableField>::.ctor()
IL_003d: stfld System.Collections.Generic.List`1<PixelCrushers.TextTableField> PixelCrushers.TextTable::m_fieldValues
IL_0042: ldarg.0
IL_0043: ldc.i4.1
IL_0044: stfld System.Int32 PixelCrushers.TextTable::m_nextFieldID
IL_0049: ldarg.0
IL_004a: call System.Void UnityEngine.ScriptableObject::.ctor()
IL_004f: ret
METHOD System.Void PixelCrushers.TextTable::.cctor() | attributes=Private, Static, HideBySig, SpecialName, RTSpecialName | impl=IL
IL_0000: ldc.i4.0
IL_0001: stsfld System.Int32 PixelCrushers.TextTable::s_currentLanguageID
IL_0006: ldc.i4.1
IL_0007: stsfld System.Boolean PixelCrushers.TextTable::m_useDefaultLanguageForBlankTranslations
IL_000c: ret
