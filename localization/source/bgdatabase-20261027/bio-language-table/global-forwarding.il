TYPE PixelCrushers.GlobalTextTable
METHOD System.Void PixelCrushers.GlobalTextTable::InitStaticVariables() | attributes=Private, Static, HideBySig | impl=IL
ATTRIBUTE UnityEngine.RuntimeInitializeOnLoadMethodAttribute
IL_0000: ldnull
IL_0001: stsfld PixelCrushers.GlobalTextTable PixelCrushers.GlobalTextTable::s_instance
IL_0006: ret
METHOD System.Void PixelCrushers.GlobalTextTable::Awake() | attributes=Family, Virtual, HideBySig, VtableLayoutMask | impl=IL
IL_0000: ldsfld PixelCrushers.GlobalTextTable PixelCrushers.GlobalTextTable::s_instance
IL_0005: ldnull
IL_0006: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_000b: brfalse.s IL_0013
IL_000d: ldarg.0
IL_000e: stsfld PixelCrushers.GlobalTextTable PixelCrushers.GlobalTextTable::s_instance
IL_0013: ret
METHOD System.Void PixelCrushers.GlobalTextTable::OnDestroy() | attributes=Family, Virtual, HideBySig, VtableLayoutMask | impl=IL
IL_0000: ldsfld PixelCrushers.GlobalTextTable PixelCrushers.GlobalTextTable::s_instance
IL_0005: ldarg.0
IL_0006: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_000b: brfalse.s IL_0013
IL_000d: ldnull
IL_000e: stsfld PixelCrushers.GlobalTextTable PixelCrushers.GlobalTextTable::s_instance
IL_0013: ret
METHOD PixelCrushers.GlobalTextTable PixelCrushers.GlobalTextTable::get_instance() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld PixelCrushers.GlobalTextTable PixelCrushers.GlobalTextTable::s_instance
IL_0005: ret
METHOD PixelCrushers.TextTable PixelCrushers.GlobalTextTable::get_textTable() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: call PixelCrushers.GlobalTextTable PixelCrushers.GlobalTextTable::get_instance()
IL_0005: ldnull
IL_0006: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_000b: brtrue.s IL_000f
IL_000d: ldnull
IL_000e: ret
IL_000f: call PixelCrushers.GlobalTextTable PixelCrushers.GlobalTextTable::get_instance()
IL_0014: ldfld PixelCrushers.TextTable PixelCrushers.GlobalTextTable::m_textTable
IL_0019: ret
METHOD System.Void PixelCrushers.GlobalTextTable::set_textTable(PixelCrushers.TextTable) | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: call PixelCrushers.GlobalTextTable PixelCrushers.GlobalTextTable::get_instance()
IL_0005: ldnull
IL_0006: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_000b: brfalse.s IL_0034
IL_000d: call PixelCrushers.GlobalTextTable PixelCrushers.GlobalTextTable::get_instance()
IL_0012: ldarg.0
IL_0013: stfld PixelCrushers.TextTable PixelCrushers.GlobalTextTable::m_textTable
IL_0018: call PixelCrushers.UILocalizationManager PixelCrushers.UILocalizationManager::get_instance()
IL_001d: ldnull
IL_001e: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0023: brfalse.s IL_0034
IL_0025: call PixelCrushers.UILocalizationManager PixelCrushers.UILocalizationManager::get_instance()
IL_002a: call System.String PixelCrushers.GlobalTextTable::get_currentLanguage()
IL_002f: callvirt System.Void PixelCrushers.UILocalizationManager::UpdateUIs(System.String)
IL_0034: ret
METHOD System.String PixelCrushers.GlobalTextTable::get_currentLanguage() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: call PixelCrushers.UILocalizationManager PixelCrushers.UILocalizationManager::get_instance()
IL_0005: callvirt System.String PixelCrushers.UILocalizationManager::get_currentLanguage()
IL_000a: ret
METHOD System.Void PixelCrushers.GlobalTextTable::set_currentLanguage(System.String) | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: call PixelCrushers.UILocalizationManager PixelCrushers.UILocalizationManager::get_instance()
IL_0005: ldarg.0
IL_0006: callvirt System.Void PixelCrushers.UILocalizationManager::set_currentLanguage(System.String)
IL_000b: ret
METHOD System.String PixelCrushers.GlobalTextTable::Lookup(PixelCrushers.StringField) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: brtrue.s IL_0009
IL_0003: ldsfld System.String System.String::Empty
IL_0008: ret
IL_0009: ldarg.0
IL_000a: callvirt System.String PixelCrushers.StringField::get_value()
IL_000f: call System.String PixelCrushers.GlobalTextTable::Lookup(System.String)
IL_0014: ret
METHOD System.String PixelCrushers.GlobalTextTable::Lookup(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_0006: brfalse.s IL_000e
IL_0008: ldsfld System.String System.String::Empty
IL_000d: ret
IL_000e: call PixelCrushers.TextTable PixelCrushers.GlobalTextTable::get_textTable()
IL_0013: ldnull
IL_0014: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0019: brfalse.s IL_001d
IL_001b: ldarg.0
IL_001c: ret
IL_001d: call PixelCrushers.TextTable PixelCrushers.GlobalTextTable::get_textTable()
IL_0022: ldarg.0
IL_0023: call System.String PixelCrushers.GlobalTextTable::get_currentLanguage()
IL_0028: callvirt System.String PixelCrushers.TextTable::GetFieldTextForLanguage(System.String,System.String)
IL_002d: ret
METHOD System.Void PixelCrushers.GlobalTextTable::.ctor() | attributes=Public, HideBySig, SpecialName, RTSpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void UnityEngine.MonoBehaviour::.ctor()
IL_0006: ret
METHOD System.Void PixelCrushers.GlobalTextTable::.cctor() | attributes=Private, Static, HideBySig, SpecialName, RTSpecialName | impl=IL
IL_0000: ret
