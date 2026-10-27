TYPE PixelCrushers.LocalizeUI
METHOD PixelCrushers.TextTable PixelCrushers.LocalizeUI::get_textTable() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld PixelCrushers.TextTable PixelCrushers.LocalizeUI::m_textTable
IL_0006: ldnull
IL_0007: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_000c: brtrue.s IL_0031
IL_000e: call PixelCrushers.UILocalizationManager PixelCrushers.UILocalizationManager::get_instance()
IL_0013: callvirt PixelCrushers.TextTable PixelCrushers.UILocalizationManager::get_textTable()
IL_0018: ldnull
IL_0019: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_001e: brtrue.s IL_0026
IL_0020: call PixelCrushers.TextTable PixelCrushers.GlobalTextTable::get_textTable()
IL_0025: ret
IL_0026: call PixelCrushers.UILocalizationManager PixelCrushers.UILocalizationManager::get_instance()
IL_002b: callvirt PixelCrushers.TextTable PixelCrushers.UILocalizationManager::get_textTable()
IL_0030: ret
IL_0031: ldarg.0
IL_0032: ldfld PixelCrushers.TextTable PixelCrushers.LocalizeUI::m_textTable
IL_0037: ret
METHOD System.Void PixelCrushers.LocalizeUI::set_textTable(PixelCrushers.TextTable) | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: stfld PixelCrushers.TextTable PixelCrushers.LocalizeUI::m_textTable
IL_0007: ret
METHOD System.String PixelCrushers.LocalizeUI::get_fieldName() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.String PixelCrushers.LocalizeUI::m_fieldName
IL_0006: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_000b: brtrue.s IL_0014
IL_000d: ldarg.0
IL_000e: ldfld System.String PixelCrushers.LocalizeUI::m_fieldName
IL_0013: ret
IL_0014: ldnull
IL_0015: ret
METHOD System.Void PixelCrushers.LocalizeUI::set_fieldName(System.String) | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: stfld System.String PixelCrushers.LocalizeUI::m_fieldName
IL_0007: ret
METHOD System.Boolean PixelCrushers.LocalizeUI::get_started() | attributes=Family, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Boolean PixelCrushers.LocalizeUI::m_started
IL_0006: ret
METHOD System.Void PixelCrushers.LocalizeUI::set_started(System.Boolean) | attributes=Private, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: stfld System.Boolean PixelCrushers.LocalizeUI::m_started
IL_0007: ret
METHOD System.Collections.Generic.List`1<System.String> PixelCrushers.LocalizeUI::get_fieldNames() | attributes=Family, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Collections.Generic.List`1<System.String> PixelCrushers.LocalizeUI::m_fieldNames
IL_0006: ret
METHOD System.Void PixelCrushers.LocalizeUI::set_fieldNames(System.Collections.Generic.List`1<System.String>) | attributes=Family, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: stfld System.Collections.Generic.List`1<System.String> PixelCrushers.LocalizeUI::m_fieldNames
IL_0007: ret
METHOD UnityEngine.UI.Text PixelCrushers.LocalizeUI::get_text() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld UnityEngine.UI.Text PixelCrushers.LocalizeUI::m_text
IL_0006: ret
METHOD System.Void PixelCrushers.LocalizeUI::set_text(UnityEngine.UI.Text) | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: stfld UnityEngine.UI.Text PixelCrushers.LocalizeUI::m_text
IL_0007: ret
METHOD UnityEngine.UI.Dropdown PixelCrushers.LocalizeUI::get_dropdown() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld UnityEngine.UI.Dropdown PixelCrushers.LocalizeUI::m_dropdown
IL_0006: ret
METHOD System.Void PixelCrushers.LocalizeUI::set_dropdown(UnityEngine.UI.Dropdown) | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: stfld UnityEngine.UI.Dropdown PixelCrushers.LocalizeUI::m_dropdown
IL_0007: ret
METHOD TMPro.TextMeshProUGUI PixelCrushers.LocalizeUI::get_textMeshProUGUI() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TMPro.TextMeshProUGUI PixelCrushers.LocalizeUI::m_textMeshProUGUI
IL_0006: ret
METHOD System.Void PixelCrushers.LocalizeUI::set_textMeshProUGUI(TMPro.TextMeshProUGUI) | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: stfld TMPro.TextMeshProUGUI PixelCrushers.LocalizeUI::m_textMeshProUGUI
IL_0007: ret
