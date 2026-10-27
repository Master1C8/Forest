TYPE PixelCrushers.LocalizeUI
METHOD System.Void PixelCrushers.LocalizeUI::UpdateText() | attributes=Public, Virtual, HideBySig, VtableLayoutMask | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Boolean PixelCrushers.LocalizeUI::get_started()
IL_0006: brtrue.s IL_0009
IL_0008: ret
IL_0009: ldarg.0
IL_000a: call PixelCrushers.TextTable PixelCrushers.LocalizeUI::get_textTable()
IL_000f: stloc.0
IL_0010: call PixelCrushers.UILocalizationManager PixelCrushers.UILocalizationManager::get_instance()
IL_0015: callvirt System.String PixelCrushers.UILocalizationManager::get_currentLanguage()
IL_001a: stloc.1
IL_001b: ldloc.0
IL_001c: ldnull
IL_001d: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0022: brfalse.s IL_0040
IL_0024: ldstr "No localized text table is assigned to "
IL_0029: ldarg.0
IL_002a: call System.String UnityEngine.Object::get_name()
IL_002f: ldstr " or a UI Localized Manager component."
IL_0034: call System.String System.String::Concat(System.String,System.String,System.String)
IL_0039: ldarg.0
IL_003a: call System.Void UnityEngine.Debug::LogWarning(System.Object,UnityEngine.Object)
IL_003f: ret
IL_0040: ldloc.0
IL_0041: ldloc.1
IL_0042: callvirt System.Boolean PixelCrushers.TextTable::HasLanguage(System.String)
IL_0047: brtrue.s IL_0080
IL_0049: ldc.i4.5
IL_004a: newarr System.String
IL_004f: dup
IL_0050: ldc.i4.0
IL_0051: ldstr "Text table "
IL_0056: stelem.ref
IL_0057: dup
IL_0058: ldc.i4.1
IL_0059: ldloc.0
IL_005a: callvirt System.String UnityEngine.Object::get_name()
IL_005f: stelem.ref
IL_0060: dup
IL_0061: ldc.i4.2
IL_0062: ldstr " does not have a language '"
IL_0067: stelem.ref
IL_0068: dup
IL_0069: ldc.i4.3
IL_006a: ldloc.1
IL_006b: stelem.ref
IL_006c: dup
IL_006d: ldc.i4.4
IL_006e: ldstr "'."
IL_0073: stelem.ref
IL_0074: call System.String System.String::Concat(System.String[])
IL_0079: ldloc.0
IL_007a: call System.Void UnityEngine.Debug::LogWarning(System.Object,UnityEngine.Object)
IL_007f: ret
IL_0080: ldarg.0
IL_0081: call UnityEngine.UI.Text PixelCrushers.LocalizeUI::get_text()
IL_0086: ldnull
IL_0087: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_008c: brfalse.s IL_00b4
IL_008e: ldarg.0
IL_008f: call UnityEngine.UI.Dropdown PixelCrushers.LocalizeUI::get_dropdown()
IL_0094: ldnull
IL_0095: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_009a: brfalse.s IL_00b4
IL_009c: ldarg.0
IL_009d: ldarg.0
IL_009e: call !!0 UnityEngine.Component::GetComponent<UnityEngine.UI.Text>()
IL_00a3: call System.Void PixelCrushers.LocalizeUI::set_text(UnityEngine.UI.Text)
IL_00a8: ldarg.0
IL_00a9: ldarg.0
IL_00aa: call !!0 UnityEngine.Component::GetComponent<UnityEngine.UI.Dropdown>()
IL_00af: call System.Void PixelCrushers.LocalizeUI::set_dropdown(UnityEngine.UI.Dropdown)
IL_00b4: ldarg.0
IL_00b5: call UnityEngine.UI.Text PixelCrushers.LocalizeUI::get_text()
IL_00ba: ldnull
IL_00bb: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_00c0: brtrue.s IL_00d0
IL_00c2: ldarg.0
IL_00c3: call UnityEngine.UI.Dropdown PixelCrushers.LocalizeUI::get_dropdown()
IL_00c8: ldnull
IL_00c9: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_00ce: br.s IL_00d1
IL_00d0: ldc.i4.1
IL_00d1: ldarg.0
IL_00d2: ldfld System.Boolean PixelCrushers.LocalizeUI::m_lookedForTMP
IL_00d7: brtrue.s IL_00ec
IL_00d9: ldarg.0
IL_00da: ldc.i4.1
IL_00db: stfld System.Boolean PixelCrushers.LocalizeUI::m_lookedForTMP
IL_00e0: ldarg.0
IL_00e1: ldarg.0
IL_00e2: call !!0 UnityEngine.Component::GetComponent<TMPro.TextMeshProUGUI>()
IL_00e7: call System.Void PixelCrushers.LocalizeUI::set_textMeshProUGUI(TMPro.TextMeshProUGUI)
IL_00ec: brtrue.s IL_00fc
IL_00ee: ldarg.0
IL_00ef: call TMPro.TextMeshProUGUI PixelCrushers.LocalizeUI::get_textMeshProUGUI()
IL_00f4: ldnull
IL_00f5: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_00fa: br.s IL_00fd
IL_00fc: ldc.i4.1
IL_00fd: brtrue.s IL_011b
IL_00ff: ldstr "Localize UI didn't find a localizable UI component on "
IL_0104: ldarg.0
IL_0105: call System.String UnityEngine.Object::get_name()
IL_010a: ldstr "."
IL_010f: call System.String System.String::Concat(System.String,System.String,System.String)
IL_0114: ldarg.0
IL_0115: call System.Void UnityEngine.Debug::LogWarning(System.Object,UnityEngine.Object)
IL_011a: ret
IL_011b: ldarg.0
IL_011c: call System.String PixelCrushers.LocalizeUI::get_fieldName()
IL_0121: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_0126: brfalse.s IL_014e
IL_0128: ldarg.0
IL_0129: ldarg.0
IL_012a: call UnityEngine.UI.Text PixelCrushers.LocalizeUI::get_text()
IL_012f: ldnull
IL_0130: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0135: brtrue.s IL_013e
IL_0137: ldsfld System.String System.String::Empty
IL_013c: br.s IL_0149
IL_013e: ldarg.0
IL_013f: call UnityEngine.UI.Text PixelCrushers.LocalizeUI::get_text()
IL_0144: callvirt System.String UnityEngine.UI.Text::get_text()
IL_0149: call System.Void PixelCrushers.LocalizeUI::set_fieldName(System.String)
IL_014e: ldarg.0
IL_014f: call System.Collections.Generic.List`1<System.String> PixelCrushers.LocalizeUI::get_fieldNames()
IL_0154: callvirt System.Int32 System.Collections.Generic.List`1<System.String>::get_Count()
IL_0159: brtrue.s IL_0185
IL_015b: ldarg.0
IL_015c: call UnityEngine.UI.Dropdown PixelCrushers.LocalizeUI::get_dropdown()
IL_0161: ldnull
IL_0162: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0167: brfalse.s IL_0185
IL_0169: ldarg.0
IL_016a: call UnityEngine.UI.Dropdown PixelCrushers.LocalizeUI::get_dropdown()
IL_016f: callvirt System.Collections.Generic.List`1<UnityEngine.UI.Dropdown/OptionData> UnityEngine.UI.Dropdown::get_options()
IL_0174: ldarg.0
IL_0175: ldftn System.Void PixelCrushers.LocalizeUI::<UpdateText>b__31_0(UnityEngine.UI.Dropdown/OptionData)
IL_017b: newobj System.Void System.Action`1<UnityEngine.UI.Dropdown/OptionData>::.ctor(System.Object,System.IntPtr)
IL_0180: callvirt System.Void System.Collections.Generic.List`1<UnityEngine.UI.Dropdown/OptionData>::ForEach(System.Action`1<!0>)
IL_0185: ldarg.0
IL_0186: call UnityEngine.UI.Text PixelCrushers.LocalizeUI::get_text()
IL_018b: ldnull
IL_018c: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0191: brfalse.s IL_01f5
IL_0193: ldloc.0
IL_0194: ldarg.0
IL_0195: call System.String PixelCrushers.LocalizeUI::get_fieldName()
IL_019a: callvirt System.Boolean PixelCrushers.TextTable::HasField(System.String)
IL_019f: brtrue.s IL_01de
IL_01a1: ldc.i4.5
IL_01a2: newarr System.String
IL_01a7: dup
IL_01a8: ldc.i4.0
IL_01a9: ldstr "Text table "
IL_01ae: stelem.ref
IL_01af: dup
IL_01b0: ldc.i4.1
IL_01b1: ldloc.0
IL_01b2: callvirt System.String UnityEngine.Object::get_name()
IL_01b7: stelem.ref
IL_01b8: dup
IL_01b9: ldc.i4.2
IL_01ba: ldstr " does not have a field '"
IL_01bf: stelem.ref
IL_01c0: dup
IL_01c1: ldc.i4.3
IL_01c2: ldarg.0
IL_01c3: call System.String PixelCrushers.LocalizeUI::get_fieldName()
IL_01c8: stelem.ref
IL_01c9: dup
IL_01ca: ldc.i4.4
IL_01cb: ldstr "'."
IL_01d0: stelem.ref
IL_01d1: call System.String System.String::Concat(System.String[])
IL_01d6: ldloc.0
IL_01d7: call System.Void UnityEngine.Debug::LogWarning(System.Object,UnityEngine.Object)
IL_01dc: br.s IL_01f5
IL_01de: ldarg.0
IL_01df: call UnityEngine.UI.Text PixelCrushers.LocalizeUI::get_text()
IL_01e4: ldarg.0
IL_01e5: ldarg.0
IL_01e6: call System.String PixelCrushers.LocalizeUI::get_fieldName()
IL_01eb: callvirt System.String PixelCrushers.LocalizeUI::GetLocalizedText(System.String)
IL_01f0: callvirt System.Void UnityEngine.UI.Text::set_text(System.String)
IL_01f5: ldarg.0
IL_01f6: call UnityEngine.UI.Dropdown PixelCrushers.LocalizeUI::get_dropdown()
IL_01fb: ldnull
IL_01fc: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0201: brfalse.s IL_0280
IL_0203: ldc.i4.0
IL_0204: stloc.2
IL_0205: br.s IL_0241
IL_0207: ldloc.2
IL_0208: ldarg.0
IL_0209: call System.Collections.Generic.List`1<System.String> PixelCrushers.LocalizeUI::get_fieldNames()
IL_020e: callvirt System.Int32 System.Collections.Generic.List`1<System.String>::get_Count()
IL_0213: bge.s IL_023d
IL_0215: ldarg.0
IL_0216: call UnityEngine.UI.Dropdown PixelCrushers.LocalizeUI::get_dropdown()
IL_021b: callvirt System.Collections.Generic.List`1<UnityEngine.UI.Dropdown/OptionData> UnityEngine.UI.Dropdown::get_options()
IL_0220: ldloc.2
IL_0221: callvirt !0 System.Collections.Generic.List`1<UnityEngine.UI.Dropdown/OptionData>::get_Item(System.Int32)
IL_0226: ldarg.0
IL_0227: ldarg.0
IL_0228: call System.Collections.Generic.List`1<System.String> PixelCrushers.LocalizeUI::get_fieldNames()
IL_022d: ldloc.2
IL_022e: callvirt !0 System.Collections.Generic.List`1<System.String>::get_Item(System.Int32)
IL_0233: callvirt System.String PixelCrushers.LocalizeUI::GetLocalizedText(System.String)
IL_0238: callvirt System.Void UnityEngine.UI.Dropdown/OptionData::set_text(System.String)
IL_023d: ldloc.2
IL_023e: ldc.i4.1
IL_023f: add
IL_0240: stloc.2
IL_0241: ldloc.2
IL_0242: ldarg.0
IL_0243: call UnityEngine.UI.Dropdown PixelCrushers.LocalizeUI::get_dropdown()
IL_0248: callvirt System.Collections.Generic.List`1<UnityEngine.UI.Dropdown/OptionData> UnityEngine.UI.Dropdown::get_options()
IL_024d: callvirt System.Int32 System.Collections.Generic.List`1<UnityEngine.UI.Dropdown/OptionData>::get_Count()
IL_0252: blt.s IL_0207
IL_0254: ldarg.0
IL_0255: call UnityEngine.UI.Dropdown PixelCrushers.LocalizeUI::get_dropdown()
IL_025a: callvirt UnityEngine.UI.Text UnityEngine.UI.Dropdown::get_captionText()
IL_025f: ldarg.0
IL_0260: ldarg.0
IL_0261: call System.Collections.Generic.List`1<System.String> PixelCrushers.LocalizeUI::get_fieldNames()
IL_0266: ldarg.0
IL_0267: call UnityEngine.UI.Dropdown PixelCrushers.LocalizeUI::get_dropdown()
IL_026c: callvirt System.Int32 UnityEngine.UI.Dropdown::get_value()
IL_0271: callvirt !0 System.Collections.Generic.List`1<System.String>::get_Item(System.Int32)
IL_0276: callvirt System.String PixelCrushers.LocalizeUI::GetLocalizedText(System.String)
IL_027b: callvirt System.Void UnityEngine.UI.Text::set_text(System.String)
IL_0280: ldarg.0
IL_0281: ldfld System.Boolean PixelCrushers.LocalizeUI::m_lookedForTMP
IL_0286: brtrue.s IL_029b
IL_0288: ldarg.0
IL_0289: ldc.i4.1
IL_028a: stfld System.Boolean PixelCrushers.LocalizeUI::m_lookedForTMP
IL_028f: ldarg.0
IL_0290: ldarg.0
IL_0291: call !!0 UnityEngine.Component::GetComponent<TMPro.TextMeshProUGUI>()
IL_0296: call System.Void PixelCrushers.LocalizeUI::set_textMeshProUGUI(TMPro.TextMeshProUGUI)
IL_029b: ldarg.0
IL_029c: call TMPro.TextMeshProUGUI PixelCrushers.LocalizeUI::get_textMeshProUGUI()
IL_02a1: ldnull
IL_02a2: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_02a7: brfalse IL_0340
IL_02ac: ldarg.0
IL_02ad: call System.String PixelCrushers.LocalizeUI::get_fieldName()
IL_02b2: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_02b7: brfalse.s IL_02df
IL_02b9: ldarg.0
IL_02ba: ldarg.0
IL_02bb: call TMPro.TextMeshProUGUI PixelCrushers.LocalizeUI::get_textMeshProUGUI()
IL_02c0: ldnull
IL_02c1: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_02c6: brtrue.s IL_02cf
IL_02c8: ldsfld System.String System.String::Empty
IL_02cd: br.s IL_02da
IL_02cf: ldarg.0
IL_02d0: call TMPro.TextMeshProUGUI PixelCrushers.LocalizeUI::get_textMeshProUGUI()
IL_02d5: callvirt System.String TMPro.TMP_Text::get_text()
IL_02da: call System.Void PixelCrushers.LocalizeUI::set_fieldName(System.String)
IL_02df: ldloc.0
IL_02e0: ldarg.0
IL_02e1: call System.String PixelCrushers.LocalizeUI::get_fieldName()
IL_02e6: callvirt System.Boolean PixelCrushers.TextTable::HasField(System.String)
IL_02eb: brtrue.s IL_0329
IL_02ed: ldc.i4.5
IL_02ee: newarr System.String
IL_02f3: dup
IL_02f4: ldc.i4.0
IL_02f5: ldstr "Text table "
IL_02fa: stelem.ref
IL_02fb: dup
IL_02fc: ldc.i4.1
IL_02fd: ldloc.0
IL_02fe: callvirt System.String UnityEngine.Object::get_name()
IL_0303: stelem.ref
IL_0304: dup
IL_0305: ldc.i4.2
IL_0306: ldstr " does not have a field '"
IL_030b: stelem.ref
IL_030c: dup
IL_030d: ldc.i4.3
IL_030e: ldarg.0
IL_030f: call System.String PixelCrushers.LocalizeUI::get_fieldName()
IL_0314: stelem.ref
IL_0315: dup
IL_0316: ldc.i4.4
IL_0317: ldstr "'."
IL_031c: stelem.ref
IL_031d: call System.String System.String::Concat(System.String[])
IL_0322: ldloc.0
IL_0323: call System.Void UnityEngine.Debug::LogWarning(System.Object,UnityEngine.Object)
IL_0328: ret
IL_0329: ldarg.0
IL_032a: call TMPro.TextMeshProUGUI PixelCrushers.LocalizeUI::get_textMeshProUGUI()
IL_032f: ldarg.0
IL_0330: ldarg.0
IL_0331: call System.String PixelCrushers.LocalizeUI::get_fieldName()
IL_0336: callvirt System.String PixelCrushers.LocalizeUI::GetLocalizedText(System.String)
IL_033b: callvirt System.Void TMPro.TMP_Text::set_text(System.String)
IL_0340: ret
METHOD System.String PixelCrushers.LocalizeUI::GetLocalizedText(System.String) | attributes=Family, Virtual, HideBySig, VtableLayoutMask | impl=IL
IL_0000: ldarg.0
IL_0001: call PixelCrushers.TextTable PixelCrushers.LocalizeUI::get_textTable()
IL_0006: ldnull
IL_0007: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_000c: brfalse.s IL_001c
IL_000e: ldarg.0
IL_000f: call PixelCrushers.TextTable PixelCrushers.LocalizeUI::get_textTable()
IL_0014: ldarg.1
IL_0015: callvirt System.Boolean PixelCrushers.TextTable::HasField(System.String)
IL_001a: brtrue.s IL_0023
IL_001c: ldarg.1
IL_001d: call System.String PixelCrushers.GlobalTextTable::Lookup(System.String)
IL_0022: ret
IL_0023: ldarg.0
IL_0024: call PixelCrushers.TextTable PixelCrushers.LocalizeUI::get_textTable()
IL_0029: ldarg.1
IL_002a: call System.String PixelCrushers.GlobalTextTable::get_currentLanguage()
IL_002f: callvirt System.String PixelCrushers.TextTable::GetFieldTextForLanguage(System.String,System.String)
IL_0034: ret
