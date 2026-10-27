TYPE TMPro.TMP_StyleSheet
METHOD System.Void TMPro.TMP_StyleSheet::LoadStyleDictionaryInternal() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Collections.Generic.Dictionary`2<System.Int32,TMPro.TMP_Style> TMPro.TMP_StyleSheet::m_StyleLookupDictionary
IL_0006: brtrue.s IL_0015
IL_0008: ldarg.0
IL_0009: newobj System.Void System.Collections.Generic.Dictionary`2<System.Int32,TMPro.TMP_Style>::.ctor()
IL_000e: stfld System.Collections.Generic.Dictionary`2<System.Int32,TMPro.TMP_Style> TMPro.TMP_StyleSheet::m_StyleLookupDictionary
IL_0013: br.s IL_0020
IL_0015: ldarg.0
IL_0016: ldfld System.Collections.Generic.Dictionary`2<System.Int32,TMPro.TMP_Style> TMPro.TMP_StyleSheet::m_StyleLookupDictionary
IL_001b: callvirt System.Void System.Collections.Generic.Dictionary`2<System.Int32,TMPro.TMP_Style>::Clear()
IL_0020: ldc.i4.0
IL_0021: stloc.1
IL_0022: br.s IL_007f
IL_0024: ldarg.0
IL_0025: ldfld System.Collections.Generic.List`1<TMPro.TMP_Style> TMPro.TMP_StyleSheet::m_StyleList
IL_002a: ldloc.1
IL_002b: callvirt !0 System.Collections.Generic.List`1<TMPro.TMP_Style>::get_Item(System.Int32)
IL_0030: callvirt System.Void TMPro.TMP_Style::RefreshStyle()
IL_0035: ldarg.0
IL_0036: ldfld System.Collections.Generic.Dictionary`2<System.Int32,TMPro.TMP_Style> TMPro.TMP_StyleSheet::m_StyleLookupDictionary
IL_003b: ldarg.0
IL_003c: ldfld System.Collections.Generic.List`1<TMPro.TMP_Style> TMPro.TMP_StyleSheet::m_StyleList
IL_0041: ldloc.1
IL_0042: callvirt !0 System.Collections.Generic.List`1<TMPro.TMP_Style>::get_Item(System.Int32)
IL_0047: callvirt System.Int32 TMPro.TMP_Style::get_hashCode()
IL_004c: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.Int32,TMPro.TMP_Style>::ContainsKey(!0)
IL_0051: brtrue.s IL_007b
IL_0053: ldarg.0
IL_0054: ldfld System.Collections.Generic.Dictionary`2<System.Int32,TMPro.TMP_Style> TMPro.TMP_StyleSheet::m_StyleLookupDictionary
IL_0059: ldarg.0
IL_005a: ldfld System.Collections.Generic.List`1<TMPro.TMP_Style> TMPro.TMP_StyleSheet::m_StyleList
IL_005f: ldloc.1
IL_0060: callvirt !0 System.Collections.Generic.List`1<TMPro.TMP_Style>::get_Item(System.Int32)
IL_0065: callvirt System.Int32 TMPro.TMP_Style::get_hashCode()
IL_006a: ldarg.0
IL_006b: ldfld System.Collections.Generic.List`1<TMPro.TMP_Style> TMPro.TMP_StyleSheet::m_StyleList
IL_0070: ldloc.1
IL_0071: callvirt !0 System.Collections.Generic.List`1<TMPro.TMP_Style>::get_Item(System.Int32)
IL_0076: callvirt System.Void System.Collections.Generic.Dictionary`2<System.Int32,TMPro.TMP_Style>::Add(!0,!1)
IL_007b: ldloc.1
IL_007c: ldc.i4.1
IL_007d: add
IL_007e: stloc.1
IL_007f: ldloc.1
IL_0080: ldarg.0
IL_0081: ldfld System.Collections.Generic.List`1<TMPro.TMP_Style> TMPro.TMP_StyleSheet::m_StyleList
IL_0086: callvirt System.Int32 System.Collections.Generic.List`1<TMPro.TMP_Style>::get_Count()
IL_008b: blt.s IL_0024
IL_008d: ldstr "Normal"
IL_0092: call System.Int32 TMPro.TMP_TextParsingUtilities::GetHashCode(System.String)
IL_0097: stloc.0
IL_0098: ldarg.0
IL_0099: ldfld System.Collections.Generic.Dictionary`2<System.Int32,TMPro.TMP_Style> TMPro.TMP_StyleSheet::m_StyleLookupDictionary
IL_009e: ldloc.0
IL_009f: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.Int32,TMPro.TMP_Style>::ContainsKey(!0)
IL_00a4: brtrue.s IL_00d4
IL_00a6: ldstr "Normal"
IL_00ab: ldsfld System.String System.String::Empty
IL_00b0: ldsfld System.String System.String::Empty
IL_00b5: newobj System.Void TMPro.TMP_Style::.ctor(System.String,System.String,System.String)
IL_00ba: stloc.2
IL_00bb: ldarg.0
IL_00bc: ldfld System.Collections.Generic.List`1<TMPro.TMP_Style> TMPro.TMP_StyleSheet::m_StyleList
IL_00c1: ldloc.2
IL_00c2: callvirt System.Void System.Collections.Generic.List`1<TMPro.TMP_Style>::Add(!0)
IL_00c7: ldarg.0
IL_00c8: ldfld System.Collections.Generic.Dictionary`2<System.Int32,TMPro.TMP_Style> TMPro.TMP_StyleSheet::m_StyleLookupDictionary
IL_00cd: ldloc.0
IL_00ce: ldloc.2
IL_00cf: callvirt System.Void System.Collections.Generic.Dictionary`2<System.Int32,TMPro.TMP_Style>::Add(!0,!1)
IL_00d4: ret
