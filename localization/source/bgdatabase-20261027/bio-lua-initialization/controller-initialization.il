TYPE PixelCrushers.DialogueSystem.DialogueSystemController
METHOD PixelCrushers.DialogueSystem.DatabaseManager PixelCrushers.DialogueSystem.DialogueSystemController::get_databaseManager() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld PixelCrushers.DialogueSystem.DatabaseManager PixelCrushers.DialogueSystem.DialogueSystemController::m_databaseManager
IL_0006: ret
METHOD System.Void PixelCrushers.DialogueSystem.DialogueSystemController::Start() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.0
IL_0002: call System.Collections.IEnumerator PixelCrushers.DialogueSystem.DialogueSystemController::MonitorAlerts()
IL_0007: call UnityEngine.Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)
IL_000c: pop
IL_000d: ldarg.0
IL_000e: ldc.i4.1
IL_000f: stfld System.Boolean PixelCrushers.DialogueSystem.DialogueSystemController::m_started
IL_0014: ldarg.0
IL_0015: ldfld System.Boolean PixelCrushers.DialogueSystem.DialogueSystemController::preloadResources
IL_001a: brfalse.s IL_0022
IL_001c: ldarg.0
IL_001d: call System.Void PixelCrushers.DialogueSystem.DialogueSystemController::PreloadResources()
IL_0022: ldarg.0
IL_0023: ldfld PixelCrushers.DialogueSystem.DialogueSystemController/WarmUpMode PixelCrushers.DialogueSystem.DialogueSystemController::warmUpConversationController
IL_0028: ldc.i4.2
IL_0029: beq.s IL_0031
IL_002b: ldarg.0
IL_002c: call System.Void PixelCrushers.DialogueSystem.DialogueSystemController::WarmUpConversationController()
IL_0031: call System.Void PixelCrushers.DialogueSystem.QuestLog::RegisterQuestLogFunctions()
IL_0036: ldarg.0
IL_0037: call System.Void PixelCrushers.DialogueSystem.DialogueSystemController::RegisterLuaFunctions()
IL_003c: ldarg.0
IL_003d: ldc.i4.1
IL_003e: stfld System.Boolean PixelCrushers.DialogueSystem.DialogueSystemController::m_isInitialized
IL_0043: ldarg.0
IL_0044: ldfld System.Action PixelCrushers.DialogueSystem.DialogueSystemController::initializationComplete
IL_0049: callvirt System.Void System.Action::Invoke()
IL_004e: ret
METHOD System.Void PixelCrushers.DialogueSystem.DialogueSystemController::InitializeLocalization() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld PixelCrushers.DialogueSystem.DisplaySettings PixelCrushers.DialogueSystem.DialogueSystemController::displaySettings
IL_0006: ldfld PixelCrushers.DialogueSystem.DisplaySettings/LocalizationSettings PixelCrushers.DialogueSystem.DisplaySettings::localizationSettings
IL_000b: ldfld System.Boolean PixelCrushers.DialogueSystem.DisplaySettings/LocalizationSettings::useSystemLanguage
IL_0010: brfalse.s IL_002c
IL_0012: ldarg.0
IL_0013: ldfld PixelCrushers.DialogueSystem.DisplaySettings PixelCrushers.DialogueSystem.DialogueSystemController::displaySettings
IL_0018: ldfld PixelCrushers.DialogueSystem.DisplaySettings/LocalizationSettings PixelCrushers.DialogueSystem.DisplaySettings::localizationSettings
IL_001d: call UnityEngine.SystemLanguage UnityEngine.Application::get_systemLanguage()
IL_0022: call System.String PixelCrushers.DialogueSystem.Localization::GetLanguage(UnityEngine.SystemLanguage)
IL_0027: stfld System.String PixelCrushers.DialogueSystem.DisplaySettings/LocalizationSettings::language
IL_002c: ldarg.0
IL_002d: call !!0 UnityEngine.Component::GetComponent<PixelCrushers.UILocalizationManager>()
IL_0032: stloc.0
IL_0033: ldarg.0
IL_0034: ldfld PixelCrushers.DialogueSystem.DisplaySettings PixelCrushers.DialogueSystem.DialogueSystemController::displaySettings
IL_0039: ldfld PixelCrushers.DialogueSystem.DisplaySettings/LocalizationSettings PixelCrushers.DialogueSystem.DisplaySettings::localizationSettings
IL_003e: ldfld System.String PixelCrushers.DialogueSystem.DisplaySettings/LocalizationSettings::language
IL_0043: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_0048: brfalse.s IL_0062
IL_004a: ldarg.0
IL_004b: ldfld PixelCrushers.DialogueSystem.DisplaySettings PixelCrushers.DialogueSystem.DialogueSystemController::displaySettings
IL_0050: ldfld PixelCrushers.DialogueSystem.DisplaySettings/LocalizationSettings PixelCrushers.DialogueSystem.DisplaySettings::localizationSettings
IL_0055: ldfld PixelCrushers.TextTable PixelCrushers.DialogueSystem.DisplaySettings/LocalizationSettings::textTable
IL_005a: ldnull
IL_005b: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0060: br.s IL_0063
IL_0062: ldc.i4.1
IL_0063: brfalse.s IL_007a
IL_0065: ldloc.0
IL_0066: ldnull
IL_0067: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_006c: brfalse.s IL_007a
IL_006e: ldarg.0
IL_006f: call UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0074: callvirt !!0 UnityEngine.GameObject::AddComponent<PixelCrushers.UILocalizationManager>()
IL_0079: stloc.0
IL_007a: ldloc.0
IL_007b: ldnull
IL_007c: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0081: brfalse.s IL_00a7
IL_0083: ldloc.0
IL_0084: callvirt PixelCrushers.TextTable PixelCrushers.UILocalizationManager::get_textTable()
IL_0089: ldnull
IL_008a: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_008f: brfalse.s IL_00a7
IL_0091: ldloc.0
IL_0092: ldarg.0
IL_0093: ldfld PixelCrushers.DialogueSystem.DisplaySettings PixelCrushers.DialogueSystem.DialogueSystemController::displaySettings
IL_0098: ldfld PixelCrushers.DialogueSystem.DisplaySettings/LocalizationSettings PixelCrushers.DialogueSystem.DisplaySettings::localizationSettings
IL_009d: ldfld PixelCrushers.TextTable PixelCrushers.DialogueSystem.DisplaySettings/LocalizationSettings::textTable
IL_00a2: callvirt System.Void PixelCrushers.UILocalizationManager::set_textTable(PixelCrushers.TextTable)
IL_00a7: ldloc.0
IL_00a8: ldnull
IL_00a9: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_00ae: brfalse.s IL_00ca
IL_00b0: ldloc.0
IL_00b1: callvirt System.String PixelCrushers.UILocalizationManager::get_currentLanguage()
IL_00b6: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_00bb: brtrue.s IL_00ca
IL_00bd: ldarg.0
IL_00be: ldloc.0
IL_00bf: callvirt System.String PixelCrushers.UILocalizationManager::get_currentLanguage()
IL_00c4: call System.Void PixelCrushers.DialogueSystem.DialogueSystemController::SetLanguage(System.String)
IL_00c9: ret
IL_00ca: ldarg.0
IL_00cb: ldarg.0
IL_00cc: ldfld PixelCrushers.DialogueSystem.DisplaySettings PixelCrushers.DialogueSystem.DialogueSystemController::displaySettings
IL_00d1: ldfld PixelCrushers.DialogueSystem.DisplaySettings/LocalizationSettings PixelCrushers.DialogueSystem.DisplaySettings::localizationSettings
IL_00d6: ldfld System.String PixelCrushers.DialogueSystem.DisplaySettings/LocalizationSettings::language
IL_00db: call System.Void PixelCrushers.DialogueSystem.DialogueSystemController::SetLanguage(System.String)
IL_00e0: ret
METHOD System.Void PixelCrushers.DialogueSystem.DialogueSystemController::InitializeDatabase() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.0
IL_0002: ldfld PixelCrushers.DialogueSystem.DialogueDatabase PixelCrushers.DialogueSystem.DialogueSystemController::initialDatabase
IL_0007: newobj System.Void PixelCrushers.DialogueSystem.DatabaseManager::.ctor(PixelCrushers.DialogueSystem.DialogueDatabase)
IL_000c: stfld PixelCrushers.DialogueSystem.DatabaseManager PixelCrushers.DialogueSystem.DialogueSystemController::m_databaseManager
IL_0011: ldarg.0
IL_0012: ldfld PixelCrushers.DialogueSystem.DialogueDatabase PixelCrushers.DialogueSystem.DialogueSystemController::initialDatabase
IL_0017: ldnull
IL_0018: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_001d: brfalse.s IL_0049
IL_001f: ldarg.0
IL_0020: ldfld PixelCrushers.DialogueSystem.DialogueDatabase PixelCrushers.DialogueSystem.DialogueSystemController::initialDatabase
IL_0025: callvirt System.String UnityEngine.Object::get_name()
IL_002a: ldsfld System.String PixelCrushers.DialogueSystem.DialogueSystemController::lastInitialDatabaseName
IL_002f: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0034: brfalse.s IL_0049
IL_0036: ldarg.0
IL_0037: ldfld PixelCrushers.DialogueSystem.DatabaseManager PixelCrushers.DialogueSystem.DialogueSystemController::m_databaseManager
IL_003c: ldarg.0
IL_003d: ldfld PixelCrushers.DialogueSystem.DialogueDatabase PixelCrushers.DialogueSystem.DialogueSystemController::initialDatabase
IL_0042: callvirt System.Void PixelCrushers.DialogueSystem.DatabaseManager::Add(PixelCrushers.DialogueSystem.DialogueDatabase)
IL_0047: br.s IL_0055
IL_0049: ldarg.0
IL_004a: ldfld PixelCrushers.DialogueSystem.DatabaseManager PixelCrushers.DialogueSystem.DialogueSystemController::m_databaseManager
IL_004f: ldc.i4.0
IL_0050: callvirt System.Void PixelCrushers.DialogueSystem.DatabaseManager::Reset(PixelCrushers.DialogueSystem.DatabaseResetOptions)
IL_0055: ldarg.0
IL_0056: ldfld PixelCrushers.DialogueSystem.DialogueDatabase PixelCrushers.DialogueSystem.DialogueSystemController::initialDatabase
IL_005b: ldnull
IL_005c: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0061: brfalse.s IL_0073
IL_0063: ldarg.0
IL_0064: ldfld PixelCrushers.DialogueSystem.DialogueDatabase PixelCrushers.DialogueSystem.DialogueSystemController::initialDatabase
IL_0069: callvirt System.String UnityEngine.Object::get_name()
IL_006e: stsfld System.String PixelCrushers.DialogueSystem.DialogueSystemController::lastInitialDatabaseName
IL_0073: call System.Boolean PixelCrushers.DialogueSystem.DialogueDebug::get_logWarnings()
IL_0078: brfalse.s IL_00a5
IL_007a: ldarg.0
IL_007b: ldfld PixelCrushers.DialogueSystem.DialogueDatabase PixelCrushers.DialogueSystem.DialogueSystemController::initialDatabase
IL_0080: ldnull
IL_0081: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0086: brfalse.s IL_00a5
IL_0088: ldstr "{0}: No dialogue database is assigned."
IL_008d: ldc.i4.1
IL_008e: newarr System.Object
IL_0093: dup
IL_0094: ldc.i4.0
IL_0095: ldstr "Dialogue System"
IL_009a: stelem.ref
IL_009b: call System.String System.String::Format(System.String,System.Object[])
IL_00a0: call System.Void UnityEngine.Debug::LogWarning(System.Object)
IL_00a5: ret
METHOD System.Void PixelCrushers.DialogueSystem.DialogueSystemController::AddDatabase(PixelCrushers.DialogueSystem.DialogueDatabase) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld PixelCrushers.DialogueSystem.DatabaseManager PixelCrushers.DialogueSystem.DialogueSystemController::m_databaseManager
IL_0006: brfalse.s IL_0014
IL_0008: ldarg.0
IL_0009: ldfld PixelCrushers.DialogueSystem.DatabaseManager PixelCrushers.DialogueSystem.DialogueSystemController::m_databaseManager
IL_000e: ldarg.1
IL_000f: callvirt System.Void PixelCrushers.DialogueSystem.DatabaseManager::Add(PixelCrushers.DialogueSystem.DialogueDatabase)
IL_0014: ret
METHOD System.Void PixelCrushers.DialogueSystem.DialogueSystemController::RemoveDatabase(PixelCrushers.DialogueSystem.DialogueDatabase) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld PixelCrushers.DialogueSystem.DatabaseManager PixelCrushers.DialogueSystem.DialogueSystemController::m_databaseManager
IL_0006: brfalse.s IL_0014
IL_0008: ldarg.0
IL_0009: ldfld PixelCrushers.DialogueSystem.DatabaseManager PixelCrushers.DialogueSystem.DialogueSystemController::m_databaseManager
IL_000e: ldarg.1
IL_000f: callvirt System.Void PixelCrushers.DialogueSystem.DatabaseManager::Remove(PixelCrushers.DialogueSystem.DialogueDatabase)
IL_0014: ret
METHOD System.Void PixelCrushers.DialogueSystem.DialogueSystemController::ResetDatabase(PixelCrushers.DialogueSystem.DatabaseResetOptions) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld PixelCrushers.DialogueSystem.DatabaseManager PixelCrushers.DialogueSystem.DialogueSystemController::m_databaseManager
IL_0006: brfalse.s IL_0014
IL_0008: ldarg.0
IL_0009: ldfld PixelCrushers.DialogueSystem.DatabaseManager PixelCrushers.DialogueSystem.DialogueSystemController::m_databaseManager
IL_000e: ldarg.1
IL_000f: callvirt System.Void PixelCrushers.DialogueSystem.DatabaseManager::Reset(PixelCrushers.DialogueSystem.DatabaseResetOptions)
IL_0014: ret
METHOD System.Void PixelCrushers.DialogueSystem.DialogueSystemController::ResetDatabase() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld PixelCrushers.DialogueSystem.DatabaseManager PixelCrushers.DialogueSystem.DialogueSystemController::m_databaseManager
IL_0006: brfalse.s IL_0014
IL_0008: ldarg.0
IL_0009: ldfld PixelCrushers.DialogueSystem.DatabaseManager PixelCrushers.DialogueSystem.DialogueSystemController::m_databaseManager
IL_000e: ldc.i4.0
IL_000f: callvirt System.Void PixelCrushers.DialogueSystem.DatabaseManager::Reset(PixelCrushers.DialogueSystem.DatabaseResetOptions)
IL_0014: ret
