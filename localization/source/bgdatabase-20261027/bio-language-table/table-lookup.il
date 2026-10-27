TYPE PixelCrushers.TextTable
METHOD System.Boolean PixelCrushers.TextTable::get_useDefaultLanguageForBlankTranslations() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld System.Boolean PixelCrushers.TextTable::m_useDefaultLanguageForBlankTranslations
IL_0005: ret
METHOD System.Int32 PixelCrushers.TextTable::get_currentLanguageID() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld System.Int32 PixelCrushers.TextTable::s_currentLanguageID
IL_0005: ret
METHOD System.Void PixelCrushers.TextTable::set_currentLanguageID(System.Int32) | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: stsfld System.Int32 PixelCrushers.TextTable::s_currentLanguageID
IL_0006: ret
METHOD System.Boolean PixelCrushers.TextTable::HasLanguage(System.String) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_0006: brtrue.s IL_0015
IL_0008: ldarg.0
IL_0009: call System.Collections.Generic.Dictionary`2<System.String,System.Int32> PixelCrushers.TextTable::get_languages()
IL_000e: ldarg.1
IL_000f: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,System.Int32>::ContainsKey(!0)
IL_0014: ret
IL_0015: ldc.i4.1
IL_0016: ret
METHOD System.Boolean PixelCrushers.TextTable::HasLanguage(System.Int32) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: brfalse.s IL_0010
IL_0003: ldarg.0
IL_0004: call System.Collections.Generic.Dictionary`2<System.String,System.Int32> PixelCrushers.TextTable::get_languages()
IL_0009: ldarg.1
IL_000a: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,System.Int32>::ContainsValue(!1)
IL_000f: ret
IL_0010: ldc.i4.1
IL_0011: ret
METHOD System.Int32 PixelCrushers.TextTable::GetLanguageID(System.String) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Collections.Generic.Dictionary`2<System.String,System.Int32> PixelCrushers.TextTable::get_languages()
IL_0006: ldarg.1
IL_0007: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,System.Int32>::ContainsKey(!0)
IL_000c: brtrue.s IL_0010
IL_000e: ldc.i4.0
IL_000f: ret
IL_0010: ldarg.0
IL_0011: call System.Collections.Generic.Dictionary`2<System.String,System.Int32> PixelCrushers.TextTable::get_languages()
IL_0016: ldarg.1
IL_0017: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,System.Int32>::get_Item(!0)
IL_001c: ret
METHOD System.Boolean PixelCrushers.TextTable::HasField(System.Int32) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Collections.Generic.Dictionary`2<System.Int32,PixelCrushers.TextTableField> PixelCrushers.TextTable::get_fields()
IL_0006: ldarg.1
IL_0007: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.Int32,PixelCrushers.TextTableField>::ContainsKey(!0)
IL_000c: ret
METHOD System.Boolean PixelCrushers.TextTable::HasField(System.String) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: call PixelCrushers.TextTableField PixelCrushers.TextTable::GetField(System.String)
IL_0007: ldnull
IL_0008: cgt.un
IL_000a: ret
METHOD PixelCrushers.TextTableField PixelCrushers.TextTable::GetField(System.Int32) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Collections.Generic.Dictionary`2<System.Int32,PixelCrushers.TextTableField> PixelCrushers.TextTable::get_fields()
IL_0006: ldarg.1
IL_0007: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.Int32,PixelCrushers.TextTableField>::ContainsKey(!0)
IL_000c: brtrue.s IL_0010
IL_000e: ldnull
IL_000f: ret
IL_0010: ldarg.0
IL_0011: call System.Collections.Generic.Dictionary`2<System.Int32,PixelCrushers.TextTableField> PixelCrushers.TextTable::get_fields()
IL_0016: ldarg.1
IL_0017: callvirt !1 System.Collections.Generic.Dictionary`2<System.Int32,PixelCrushers.TextTableField>::get_Item(!0)
IL_001c: ret
METHOD PixelCrushers.TextTableField PixelCrushers.TextTable::GetField(System.String) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.0
IL_0002: ldarg.1
IL_0003: call System.Int32 PixelCrushers.TextTable::GetFieldID(System.String)
IL_0008: call PixelCrushers.TextTableField PixelCrushers.TextTable::GetField(System.Int32)
IL_000d: ret
METHOD System.Int32 PixelCrushers.TextTable::GetFieldID(System.String) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Collections.Generic.Dictionary`2<System.Int32,PixelCrushers.TextTableField> PixelCrushers.TextTable::get_fields()
IL_0006: callvirt System.Collections.Generic.Dictionary`2/Enumerator<!0,!1> System.Collections.Generic.Dictionary`2<System.Int32,PixelCrushers.TextTableField>::GetEnumerator()
IL_000b: stloc.0
IL_000c: br.s IL_004b
IL_000e: ldloca.s V_0
IL_0010: call System.Collections.Generic.KeyValuePair`2<!0,!1> System.Collections.Generic.Dictionary`2/Enumerator<System.Int32,PixelCrushers.TextTableField>::get_Current()
IL_0015: stloc.1
IL_0016: ldloca.s V_1
IL_0018: call !1 System.Collections.Generic.KeyValuePair`2<System.Int32,PixelCrushers.TextTableField>::get_Value()
IL_001d: brfalse.s IL_004b
IL_001f: ldloca.s V_0
IL_0021: call System.Collections.Generic.KeyValuePair`2<!0,!1> System.Collections.Generic.Dictionary`2/Enumerator<System.Int32,PixelCrushers.TextTableField>::get_Current()
IL_0026: stloc.1
IL_0027: ldloca.s V_1
IL_0029: call !1 System.Collections.Generic.KeyValuePair`2<System.Int32,PixelCrushers.TextTableField>::get_Value()
IL_002e: callvirt System.String PixelCrushers.TextTableField::get_fieldName()
IL_0033: ldarg.1
IL_0034: call System.Boolean System.String::Equals(System.String,System.String)
IL_0039: brfalse.s IL_004b
IL_003b: ldloca.s V_0
IL_003d: call System.Collections.Generic.KeyValuePair`2<!0,!1> System.Collections.Generic.Dictionary`2/Enumerator<System.Int32,PixelCrushers.TextTableField>::get_Current()
IL_0042: stloc.1
IL_0043: ldloca.s V_1
IL_0045: call !0 System.Collections.Generic.KeyValuePair`2<System.Int32,PixelCrushers.TextTableField>::get_Key()
IL_004a: ret
IL_004b: ldloca.s V_0
IL_004d: call System.Boolean System.Collections.Generic.Dictionary`2/Enumerator<System.Int32,PixelCrushers.TextTableField>::MoveNext()
IL_0052: brtrue.s IL_000e
IL_0054: ldc.i4.0
IL_0055: ret
METHOD System.String PixelCrushers.TextTable::GetFieldTextForLanguage(System.Int32,System.Int32) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: call PixelCrushers.TextTableField PixelCrushers.TextTable::GetField(System.Int32)
IL_0007: stloc.0
IL_0008: ldloc.0
IL_0009: brtrue.s IL_0013
IL_000b: ldarg.0
IL_000c: ldarg.1
IL_000d: call System.String PixelCrushers.TextTable::GetFieldName(System.Int32)
IL_0012: ret
IL_0013: ldloc.0
IL_0014: ldarg.2
IL_0015: callvirt System.Boolean PixelCrushers.TextTableField::HasTextForLanguage(System.Int32)
IL_001a: brfalse.s IL_003d
IL_001c: ldloc.0
IL_001d: ldarg.2
IL_001e: callvirt System.String PixelCrushers.TextTableField::GetTextForLanguage(System.Int32)
IL_0023: ldstr "\n"
IL_0028: ldstr "
"
IL_002d: callvirt System.String System.String::Replace(System.String,System.String)
IL_0032: stloc.1
IL_0033: ldloc.1
IL_0034: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_0039: brtrue.s IL_003d
IL_003b: ldloc.1
IL_003c: ret
IL_003d: ldloc.0
IL_003e: ldc.i4.0
IL_003f: callvirt System.String PixelCrushers.TextTableField::GetTextForLanguage(System.Int32)
IL_0044: stloc.2
IL_0045: ldloc.2
IL_0046: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_004b: brtrue.s IL_0054
IL_004d: call System.Boolean PixelCrushers.TextTable::get_useDefaultLanguageForBlankTranslations()
IL_0052: brtrue.s IL_005d
IL_0054: ldarg.0
IL_0055: ldarg.1
IL_0056: call System.String PixelCrushers.TextTable::GetFieldName(System.Int32)
IL_005b: br.s IL_005e
IL_005d: ldloc.2
IL_005e: stloc.1
IL_005f: ldloc.1
IL_0060: ldstr "\n"
IL_0065: ldstr "
"
IL_006a: callvirt System.String System.String::Replace(System.String,System.String)
IL_006f: ret
METHOD System.String PixelCrushers.TextTable::GetFieldTextForLanguage(System.Int32,System.String) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: ldarg.0
IL_0003: ldarg.2
IL_0004: call System.Int32 PixelCrushers.TextTable::GetLanguageID(System.String)
IL_0009: call System.String PixelCrushers.TextTable::GetFieldTextForLanguage(System.Int32,System.Int32)
IL_000e: ret
METHOD System.String PixelCrushers.TextTable::GetFieldTextForLanguage(System.String,System.Int32) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: call PixelCrushers.TextTableField PixelCrushers.TextTable::GetField(System.String)
IL_0007: stloc.0
IL_0008: ldloc.0
IL_0009: brtrue.s IL_000d
IL_000b: ldarg.1
IL_000c: ret
IL_000d: ldloc.0
IL_000e: ldarg.2
IL_000f: callvirt System.Boolean PixelCrushers.TextTableField::HasTextForLanguage(System.Int32)
IL_0014: brfalse.s IL_0037
IL_0016: ldloc.0
IL_0017: ldarg.2
IL_0018: callvirt System.String PixelCrushers.TextTableField::GetTextForLanguage(System.Int32)
IL_001d: ldstr "\n"
IL_0022: ldstr "
"
IL_0027: callvirt System.String System.String::Replace(System.String,System.String)
IL_002c: stloc.1
IL_002d: ldloc.1
IL_002e: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_0033: brtrue.s IL_0037
IL_0035: ldloc.1
IL_0036: ret
IL_0037: ldloc.0
IL_0038: ldc.i4.0
IL_0039: callvirt System.String PixelCrushers.TextTableField::GetTextForLanguage(System.Int32)
IL_003e: stloc.2
IL_003f: ldloc.2
IL_0040: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_0045: brtrue.s IL_004e
IL_0047: call System.Boolean PixelCrushers.TextTable::get_useDefaultLanguageForBlankTranslations()
IL_004c: brtrue.s IL_0051
IL_004e: ldarg.1
IL_004f: br.s IL_0052
IL_0051: ldloc.2
IL_0052: stloc.1
IL_0053: ldloc.1
IL_0054: ldstr "\n"
IL_0059: ldstr "
"
IL_005e: callvirt System.String System.String::Replace(System.String,System.String)
IL_0063: ret
METHOD System.String PixelCrushers.TextTable::GetFieldTextForLanguage(System.String,System.String) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: ldarg.0
IL_0003: ldarg.2
IL_0004: call System.Int32 PixelCrushers.TextTable::GetLanguageID(System.String)
IL_0009: call System.String PixelCrushers.TextTable::GetFieldTextForLanguage(System.String,System.Int32)
IL_000e: ret
METHOD System.String PixelCrushers.TextTable::GetFieldText(System.Int32) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: call System.Int32 PixelCrushers.TextTable::get_currentLanguageID()
IL_0007: call System.String PixelCrushers.TextTable::GetFieldTextForLanguage(System.Int32,System.Int32)
IL_000c: ret
METHOD System.String PixelCrushers.TextTable::GetFieldText(System.String) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: call System.Int32 PixelCrushers.TextTable::get_currentLanguageID()
IL_0007: call System.String PixelCrushers.TextTable::GetFieldTextForLanguage(System.String,System.Int32)
IL_000c: ret
