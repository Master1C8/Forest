TYPE PixelCrushers.DialogueSystem.Localization
METHOD System.String PixelCrushers.DialogueSystem.Localization::get_language() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld System.String PixelCrushers.DialogueSystem.Localization::m_language
IL_0005: ret
METHOD System.Boolean PixelCrushers.DialogueSystem.Localization::get_isDefaultLanguage() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: call System.String PixelCrushers.DialogueSystem.Localization::get_language()
IL_0005: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_000a: ret
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
