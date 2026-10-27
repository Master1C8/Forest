TYPE TMPro.TMP_Settings
METHOD TMPro.TMP_StyleSheet TMPro.TMP_Settings::get_defaultStyleSheet() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: call TMPro.TMP_Settings TMPro.TMP_Settings::get_instance()
IL_0005: ldfld TMPro.TMP_StyleSheet TMPro.TMP_Settings::m_defaultStyleSheet
IL_000a: ret
METHOD TMPro.TMP_Settings TMPro.TMP_Settings::get_instance() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld TMPro.TMP_Settings TMPro.TMP_Settings::s_Instance
IL_0005: ldnull
IL_0006: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_000b: brfalse.s IL_001c
IL_000d: ldstr "TMP Settings"
IL_0012: call !!0 UnityEngine.Resources::Load<TMPro.TMP_Settings>(System.String)
IL_0017: stsfld TMPro.TMP_Settings TMPro.TMP_Settings::s_Instance
IL_001c: ldsfld TMPro.TMP_Settings TMPro.TMP_Settings::s_Instance
IL_0021: ret
