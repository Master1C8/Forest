TYPE TMPro.TMP_StyleSheet
METHOD TMPro.TMP_Style TMPro.TMP_StyleSheet::GetStyle(System.Int32) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Collections.Generic.Dictionary`2<System.Int32,TMPro.TMP_Style> TMPro.TMP_StyleSheet::m_StyleLookupDictionary
IL_0006: brtrue.s IL_000e
IL_0008: ldarg.0
IL_0009: call System.Void TMPro.TMP_StyleSheet::LoadStyleDictionaryInternal()
IL_000e: ldarg.0
IL_000f: ldfld System.Collections.Generic.Dictionary`2<System.Int32,TMPro.TMP_Style> TMPro.TMP_StyleSheet::m_StyleLookupDictionary
IL_0014: ldarg.1
IL_0015: ldloca.s V_0
IL_0017: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.Int32,TMPro.TMP_Style>::TryGetValue(!0,!1&)
IL_001c: brfalse.s IL_0020
IL_001e: ldloc.0
IL_001f: ret
IL_0020: ldnull
IL_0021: ret
