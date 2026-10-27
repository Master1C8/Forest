TYPE TMPro.TMP_Text
METHOD TMPro.TMP_Style TMPro.TMP_Text::GetStyle(System.Int32) | attributes=Private, HideBySig | impl=IL
IL_0000: ldnull
IL_0001: stloc.0
IL_0002: ldarg.0
IL_0003: ldfld TMPro.TMP_StyleSheet TMPro.TMP_Text::m_StyleSheet
IL_0008: ldnull
IL_0009: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_000e: brfalse.s IL_0022
IL_0010: ldarg.0
IL_0011: ldfld TMPro.TMP_StyleSheet TMPro.TMP_Text::m_StyleSheet
IL_0016: ldarg.1
IL_0017: callvirt TMPro.TMP_Style TMPro.TMP_StyleSheet::GetStyle(System.Int32)
IL_001c: stloc.0
IL_001d: ldloc.0
IL_001e: brfalse.s IL_0022
IL_0020: ldloc.0
IL_0021: ret
IL_0022: call TMPro.TMP_StyleSheet TMPro.TMP_Settings::get_defaultStyleSheet()
IL_0027: ldnull
IL_0028: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_002d: brfalse.s IL_003b
IL_002f: call TMPro.TMP_StyleSheet TMPro.TMP_Settings::get_defaultStyleSheet()
IL_0034: ldarg.1
IL_0035: callvirt TMPro.TMP_Style TMPro.TMP_StyleSheet::GetStyle(System.Int32)
IL_003a: stloc.0
IL_003b: ldloc.0
IL_003c: ret
