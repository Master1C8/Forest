TYPE PixelCrushers.DialogueSystem.Localization
METHOD System.String PixelCrushers.DialogueSystem.Localization::get_language() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld System.String PixelCrushers.DialogueSystem.Localization::m_language
IL_0005: ret
METHOD System.Void PixelCrushers.DialogueSystem.Localization::set_language(System.String) | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: stsfld System.String PixelCrushers.DialogueSystem.Localization::m_language
IL_0006: ldc.i4.m1
IL_0007: stsfld System.Int32 PixelCrushers.DialogueSystem.Localization::m_currentLanguageID
IL_000c: call PixelCrushers.DialogueSystem.DialogueSystemController PixelCrushers.DialogueSystem.DialogueManager::get_instance()
IL_0011: ldnull
IL_0012: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0017: brfalse.s IL_005e
IL_0019: call PixelCrushers.DialogueSystem.DialogueSystemController PixelCrushers.DialogueSystem.DialogueManager::get_instance()
IL_001e: callvirt !!0 UnityEngine.Component::GetComponent<PixelCrushers.UILocalizationManager>()
IL_0023: stloc.0
IL_0024: ldloc.0
IL_0025: ldnull
IL_0026: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_002b: brfalse.s IL_0057
IL_002d: call PixelCrushers.DialogueSystem.DialogueSystemController PixelCrushers.DialogueSystem.DialogueManager::get_instance()
IL_0032: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0037: callvirt !!0 UnityEngine.GameObject::AddComponent<PixelCrushers.UILocalizationManager>()
IL_003c: stloc.0
IL_003d: ldloc.0
IL_003e: call PixelCrushers.DialogueSystem.DialogueSystemController PixelCrushers.DialogueSystem.DialogueManager::get_instance()
IL_0043: ldfld PixelCrushers.DialogueSystem.DisplaySettings PixelCrushers.DialogueSystem.DialogueSystemController::displaySettings
IL_0048: ldfld PixelCrushers.DialogueSystem.DisplaySettings/LocalizationSettings PixelCrushers.DialogueSystem.DisplaySettings::localizationSettings
IL_004d: ldfld PixelCrushers.TextTable PixelCrushers.DialogueSystem.DisplaySettings/LocalizationSettings::textTable
IL_0052: callvirt System.Void PixelCrushers.UILocalizationManager::set_textTable(PixelCrushers.TextTable)
IL_0057: ldloc.0
IL_0058: ldarg.0
IL_0059: callvirt System.Void PixelCrushers.UILocalizationManager::set_currentLanguage(System.String)
IL_005e: ret
METHOD System.Boolean PixelCrushers.DialogueSystem.Localization::get_isDefaultLanguage() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: call System.String PixelCrushers.DialogueSystem.Localization::get_language()
IL_0005: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_000a: ret
METHOD System.Boolean PixelCrushers.DialogueSystem.Localization::get_useDefaultIfUndefined() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld System.Boolean PixelCrushers.DialogueSystem.Localization::m_useDefaultIfUndefined
IL_0005: ret
METHOD System.Void PixelCrushers.DialogueSystem.Localization::set_useDefaultIfUndefined(System.Boolean) | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: stsfld System.Boolean PixelCrushers.DialogueSystem.Localization::m_useDefaultIfUndefined
IL_0006: ret
METHOD System.Void PixelCrushers.DialogueSystem.Localization::InitStaticVariables() | attributes=Private, Static, HideBySig | impl=IL
ATTRIBUTE UnityEngine.RuntimeInitializeOnLoadMethodAttribute
IL_0000: ldsfld System.String System.String::Empty
IL_0005: stsfld System.String PixelCrushers.DialogueSystem.Localization::m_language
IL_000a: ldc.i4.m1
IL_000b: stsfld System.Int32 PixelCrushers.DialogueSystem.Localization::m_currentLanguageID
IL_0010: ldc.i4.1
IL_0011: stsfld System.Boolean PixelCrushers.DialogueSystem.Localization::m_useDefaultIfUndefined
IL_0016: ret
METHOD System.Void PixelCrushers.DialogueSystem.Localization::.cctor() | attributes=Private, Static, HideBySig, SpecialName, RTSpecialName | impl=IL
IL_0000: ldsfld System.String System.String::Empty
IL_0005: stsfld System.String PixelCrushers.DialogueSystem.Localization::m_language
IL_000a: ldc.i4.m1
IL_000b: stsfld System.Int32 PixelCrushers.DialogueSystem.Localization::m_currentLanguageID
IL_0010: ldc.i4.1
IL_0011: stsfld System.Boolean PixelCrushers.DialogueSystem.Localization::m_useDefaultIfUndefined
IL_0016: ret
