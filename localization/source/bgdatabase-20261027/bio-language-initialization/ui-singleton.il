TYPE PixelCrushers.UILocalizationManager
METHOD PixelCrushers.UILocalizationManager PixelCrushers.UILocalizationManager::get_instance() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld PixelCrushers.UILocalizationManager PixelCrushers.UILocalizationManager::m_instance
IL_0005: ldnull
IL_0006: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_000b: brfalse.s IL_0054
IL_000d: call !!0 UnityEngine.Object::FindObjectOfType<PixelCrushers.UILocalizationManager>()
IL_0012: stsfld PixelCrushers.UILocalizationManager PixelCrushers.UILocalizationManager::m_instance
IL_0017: ldsfld PixelCrushers.UILocalizationManager PixelCrushers.UILocalizationManager::m_instance
IL_001c: ldnull
IL_001d: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0022: brfalse.s IL_0054
IL_0024: call !!0 UnityEngine.Object::FindObjectOfType<PixelCrushers.GlobalTextTable>()
IL_0029: stloc.0
IL_002a: ldloc.0
IL_002b: ldnull
IL_002c: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0031: brtrue.s IL_0044
IL_0033: ldstr "UILocalizationManager"
IL_0038: newobj System.Void UnityEngine.GameObject::.ctor(System.String)
IL_003d: call !!0 UnityEngine.GameObject::AddComponent<PixelCrushers.UILocalizationManager>()
IL_0042: br.s IL_004f
IL_0044: ldloc.0
IL_0045: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_004a: callvirt !!0 UnityEngine.GameObject::AddComponent<PixelCrushers.UILocalizationManager>()
IL_004f: stsfld PixelCrushers.UILocalizationManager PixelCrushers.UILocalizationManager::m_instance
IL_0054: ldsfld PixelCrushers.UILocalizationManager PixelCrushers.UILocalizationManager::m_instance
IL_0059: ret
METHOD PixelCrushers.TextTable PixelCrushers.UILocalizationManager::get_textTable() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: call PixelCrushers.UILocalizationManager PixelCrushers.UILocalizationManager::get_instance()
IL_0005: ldfld PixelCrushers.TextTable PixelCrushers.UILocalizationManager::m_textTable
IL_000a: ldnull
IL_000b: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0010: brtrue.s IL_0018
IL_0012: call PixelCrushers.TextTable PixelCrushers.GlobalTextTable::get_textTable()
IL_0017: ret
IL_0018: call PixelCrushers.UILocalizationManager PixelCrushers.UILocalizationManager::get_instance()
IL_001d: ldfld PixelCrushers.TextTable PixelCrushers.UILocalizationManager::m_textTable
IL_0022: ret
METHOD System.Void PixelCrushers.UILocalizationManager::set_textTable(PixelCrushers.TextTable) | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: call PixelCrushers.UILocalizationManager PixelCrushers.UILocalizationManager::get_instance()
IL_0005: ldarg.1
IL_0006: stfld PixelCrushers.TextTable PixelCrushers.UILocalizationManager::m_textTable
IL_000b: ret
METHOD System.String PixelCrushers.UILocalizationManager::get_currentLanguagePlayerPrefsKey() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.String PixelCrushers.UILocalizationManager::m_currentLanguagePlayerPrefsKey
IL_0006: ret
METHOD System.Boolean PixelCrushers.UILocalizationManager::get_saveLanguageInPlayerPrefs() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Boolean PixelCrushers.UILocalizationManager::m_saveLanguageInPlayerPrefs
IL_0006: ret
