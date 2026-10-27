TYPE PixelCrushers.DialogueSystem.DialogueSystemController
METHOD PixelCrushers.DialogueSystem.DialogueDatabase PixelCrushers.DialogueSystem.DialogueSystemController::get_masterDatabase() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld PixelCrushers.DialogueSystem.DatabaseManager PixelCrushers.DialogueSystem.DialogueSystemController::m_databaseManager
IL_0006: callvirt PixelCrushers.DialogueSystem.DialogueDatabase PixelCrushers.DialogueSystem.DatabaseManager::get_masterDatabase()
IL_000b: ret
METHOD System.Void PixelCrushers.DialogueSystem.DialogueSystemController::SetLanguage(System.String) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld PixelCrushers.UILocalizationManager PixelCrushers.DialogueSystem.DialogueSystemController::m_uiLocalizationManager
IL_0006: ldnull
IL_0007: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_000c: brfalse.s IL_0067
IL_000e: ldarg.0
IL_000f: ldarg.0
IL_0010: call !!0 UnityEngine.Component::GetComponent<PixelCrushers.UILocalizationManager>()
IL_0015: stfld PixelCrushers.UILocalizationManager PixelCrushers.DialogueSystem.DialogueSystemController::m_uiLocalizationManager
IL_001a: ldarg.0
IL_001b: ldfld PixelCrushers.UILocalizationManager PixelCrushers.DialogueSystem.DialogueSystemController::m_uiLocalizationManager
IL_0020: ldnull
IL_0021: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0026: brfalse.s IL_0039
IL_0028: ldarg.0
IL_0029: ldarg.0
IL_002a: call UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_002f: callvirt !!0 UnityEngine.GameObject::AddComponent<PixelCrushers.UILocalizationManager>()
IL_0034: stfld PixelCrushers.UILocalizationManager PixelCrushers.DialogueSystem.DialogueSystemController::m_uiLocalizationManager
IL_0039: ldarg.0
IL_003a: ldfld PixelCrushers.UILocalizationManager PixelCrushers.DialogueSystem.DialogueSystemController::m_uiLocalizationManager
IL_003f: callvirt PixelCrushers.TextTable PixelCrushers.UILocalizationManager::get_textTable()
IL_0044: ldnull
IL_0045: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_004a: brfalse.s IL_0067
IL_004c: ldarg.0
IL_004d: ldfld PixelCrushers.UILocalizationManager PixelCrushers.DialogueSystem.DialogueSystemController::m_uiLocalizationManager
IL_0052: ldarg.0
IL_0053: ldfld PixelCrushers.DialogueSystem.DisplaySettings PixelCrushers.DialogueSystem.DialogueSystemController::displaySettings
IL_0058: ldfld PixelCrushers.DialogueSystem.DisplaySettings/LocalizationSettings PixelCrushers.DialogueSystem.DisplaySettings::localizationSettings
IL_005d: ldfld PixelCrushers.TextTable PixelCrushers.DialogueSystem.DisplaySettings/LocalizationSettings::textTable
IL_0062: callvirt System.Void PixelCrushers.UILocalizationManager::set_textTable(PixelCrushers.TextTable)
IL_0067: ldarg.0
IL_0068: ldfld PixelCrushers.UILocalizationManager PixelCrushers.DialogueSystem.DialogueSystemController::m_uiLocalizationManager
IL_006d: ldarg.1
IL_006e: callvirt System.Void PixelCrushers.UILocalizationManager::set_currentLanguage(System.String)
IL_0073: ldarg.0
IL_0074: ldfld PixelCrushers.DialogueSystem.DisplaySettings PixelCrushers.DialogueSystem.DialogueSystemController::displaySettings
IL_0079: ldfld PixelCrushers.DialogueSystem.DisplaySettings/LocalizationSettings PixelCrushers.DialogueSystem.DisplaySettings::localizationSettings
IL_007e: ldarg.1
IL_007f: stfld System.String PixelCrushers.DialogueSystem.DisplaySettings/LocalizationSettings::language
IL_0084: ldarg.1
IL_0085: call System.Void PixelCrushers.DialogueSystem.Localization::set_language(System.String)
IL_008a: ret
