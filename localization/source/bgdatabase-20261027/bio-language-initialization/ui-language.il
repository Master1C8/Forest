TYPE PixelCrushers.UILocalizationManager
METHOD System.String PixelCrushers.UILocalizationManager::get_currentLanguage() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: call PixelCrushers.UILocalizationManager PixelCrushers.UILocalizationManager::get_instance()
IL_0005: ldfld System.String PixelCrushers.UILocalizationManager::m_currentLanguage
IL_000a: ret
METHOD System.Void PixelCrushers.UILocalizationManager::set_currentLanguage(System.String) | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: call PixelCrushers.UILocalizationManager PixelCrushers.UILocalizationManager::get_instance()
IL_0005: ldarg.1
IL_0006: stfld System.String PixelCrushers.UILocalizationManager::m_currentLanguage
IL_000b: call PixelCrushers.UILocalizationManager PixelCrushers.UILocalizationManager::get_instance()
IL_0010: ldarg.1
IL_0011: callvirt System.Void PixelCrushers.UILocalizationManager::UpdateUIs(System.String)
IL_0016: ret
METHOD System.Void PixelCrushers.UILocalizationManager::Awake() | attributes=Private, HideBySig | impl=IL
IL_0000: ldsfld PixelCrushers.UILocalizationManager PixelCrushers.UILocalizationManager::m_instance
IL_0005: ldnull
IL_0006: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_000b: brfalse.s IL_0013
IL_000d: ldarg.0
IL_000e: stsfld PixelCrushers.UILocalizationManager PixelCrushers.UILocalizationManager::m_instance
IL_0013: ldarg.0
IL_0014: call System.Boolean PixelCrushers.UILocalizationManager::get_saveLanguageInPlayerPrefs()
IL_0019: brfalse.s IL_0046
IL_001b: ldarg.0
IL_001c: call System.String PixelCrushers.UILocalizationManager::get_currentLanguagePlayerPrefsKey()
IL_0021: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_0026: brtrue.s IL_0046
IL_0028: ldarg.0
IL_0029: call System.String PixelCrushers.UILocalizationManager::get_currentLanguagePlayerPrefsKey()
IL_002e: call System.Boolean UnityEngine.PlayerPrefs::HasKey(System.String)
IL_0033: brfalse.s IL_0046
IL_0035: ldarg.0
IL_0036: ldarg.0
IL_0037: call System.String PixelCrushers.UILocalizationManager::get_currentLanguagePlayerPrefsKey()
IL_003c: call System.String UnityEngine.PlayerPrefs::GetString(System.String)
IL_0041: stfld System.String PixelCrushers.UILocalizationManager::m_currentLanguage
IL_0046: ret
METHOD System.Collections.IEnumerator PixelCrushers.UILocalizationManager::Start() | attributes=Private, HideBySig | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.IteratorStateMachineAttribute
IL_0000: ldc.i4.0
IL_0001: newobj System.Void PixelCrushers.UILocalizationManager/<Start>d__22::.ctor(System.Int32)
IL_0006: dup
IL_0007: ldarg.0
IL_0008: stfld PixelCrushers.UILocalizationManager PixelCrushers.UILocalizationManager/<Start>d__22::<>4__this
IL_000d: ret
METHOD System.Void PixelCrushers.UILocalizationManager::UpdateUIs(System.String) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: stfld System.String PixelCrushers.UILocalizationManager::m_currentLanguage
IL_0007: ldarg.0
IL_0008: call System.Boolean PixelCrushers.UILocalizationManager::get_saveLanguageInPlayerPrefs()
IL_000d: brfalse.s IL_0028
IL_000f: ldarg.0
IL_0010: call System.String PixelCrushers.UILocalizationManager::get_currentLanguagePlayerPrefsKey()
IL_0015: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_001a: brtrue.s IL_0028
IL_001c: ldarg.0
IL_001d: call System.String PixelCrushers.UILocalizationManager::get_currentLanguagePlayerPrefsKey()
IL_0022: ldarg.1
IL_0023: call System.Void UnityEngine.PlayerPrefs::SetString(System.String,System.String)
IL_0028: ldarg.0
IL_0029: ldfld System.Boolean PixelCrushers.UILocalizationManager::m_alsoUpdateInactiveLocalizeUI
IL_002e: brtrue.s IL_0037
IL_0030: call !!0[] UnityEngine.Object::FindObjectsOfType<PixelCrushers.LocalizeUI>()
IL_0035: br.s IL_003d
IL_0037: ldc.i4.1
IL_0038: call T[] PixelCrushers.GameObjectUtility::FindObjectsOfTypeAlsoInactive<PixelCrushers.LocalizeUI>(System.Boolean)
IL_003d: stloc.0
IL_003e: ldc.i4.0
IL_003f: stloc.1
IL_0040: br.s IL_004e
IL_0042: ldloc.0
IL_0043: ldloc.1
IL_0044: ldelem.ref
IL_0045: callvirt System.Void PixelCrushers.LocalizeUI::UpdateText()
IL_004a: ldloc.1
IL_004b: ldc.i4.1
IL_004c: add
IL_004d: stloc.1
IL_004e: ldloc.1
IL_004f: ldloc.0
IL_0050: ldlen
IL_0051: conv.i4
IL_0052: blt.s IL_0042
IL_0054: ret
METHOD System.Void PixelCrushers.UILocalizationManager::.ctor() | attributes=Public, HideBySig, SpecialName, RTSpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldstr "Language"
IL_0006: stfld System.String PixelCrushers.UILocalizationManager::m_currentLanguagePlayerPrefsKey
IL_000b: ldarg.0
IL_000c: ldc.i4.1
IL_000d: stfld System.Boolean PixelCrushers.UILocalizationManager::m_saveLanguageInPlayerPrefs
IL_0012: ldarg.0
IL_0013: ldc.i4.1
IL_0014: stfld System.Boolean PixelCrushers.UILocalizationManager::m_alsoUpdateInactiveLocalizeUI
IL_0019: ldarg.0
IL_001a: ldsfld System.String System.String::Empty
IL_001f: stfld System.String PixelCrushers.UILocalizationManager::m_currentLanguage
IL_0024: ldarg.0
IL_0025: call System.Void UnityEngine.MonoBehaviour::.ctor()
IL_002a: ret
