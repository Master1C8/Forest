TYPE PixelCrushers.StringField
METHOD System.String PixelCrushers.StringField::get_value() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: call PixelCrushers.TextTable PixelCrushers.StringField::get_textTable()
IL_0006: ldnull
IL_0007: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_000c: brfalse.s IL_002a
IL_000e: ldarg.0
IL_000f: call PixelCrushers.TextTable PixelCrushers.StringField::get_textTable()
IL_0014: ldarg.0
IL_0015: call System.Int32 PixelCrushers.StringField::get_textTableFieldID()
IL_001a: call PixelCrushers.UILocalizationManager PixelCrushers.UILocalizationManager::get_instance()
IL_001f: callvirt System.String PixelCrushers.UILocalizationManager::get_currentLanguage()
IL_0024: callvirt System.String PixelCrushers.TextTable::GetFieldTextForLanguage(System.Int32,System.String)
IL_0029: ret
IL_002a: ldarg.0
IL_002b: call PixelCrushers.StringAsset PixelCrushers.StringField::get_stringAsset()
IL_0030: ldnull
IL_0031: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0036: brfalse.s IL_0044
IL_0038: ldarg.0
IL_0039: call PixelCrushers.StringAsset PixelCrushers.StringField::get_stringAsset()
IL_003e: callvirt System.String PixelCrushers.StringAsset::get_text()
IL_0043: ret
IL_0044: ldarg.0
IL_0045: call System.String PixelCrushers.StringField::get_text()
IL_004a: ret
