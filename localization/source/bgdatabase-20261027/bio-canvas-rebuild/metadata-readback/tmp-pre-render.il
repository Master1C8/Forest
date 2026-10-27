TYPE TMPro.TextMeshProUGUI
METHOD System.Void TMPro.TextMeshProUGUI::OnPreRenderCanvas() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Boolean TMPro.TMP_Text::m_isAwake
IL_0006: brfalse.s IL_0018
IL_0008: ldarg.0
IL_0009: callvirt System.Boolean UnityEngine.EventSystems.UIBehaviour::IsActive()
IL_000e: brtrue.s IL_0019
IL_0010: ldarg.0
IL_0011: ldfld System.Boolean TMPro.TMP_Text::m_ignoreActiveState
IL_0016: brtrue.s IL_0019
IL_0018: ret
IL_0019: ldarg.0
IL_001a: ldfld UnityEngine.Canvas TMPro.TextMeshProUGUI::m_canvas
IL_001f: ldnull
IL_0020: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0025: brfalse.s IL_0042
IL_0027: ldarg.0
IL_0028: ldarg.0
IL_0029: call UnityEngine.Canvas UnityEngine.UI.Graphic::get_canvas()
IL_002e: stfld UnityEngine.Canvas TMPro.TextMeshProUGUI::m_canvas
IL_0033: ldarg.0
IL_0034: ldfld UnityEngine.Canvas TMPro.TextMeshProUGUI::m_canvas
IL_0039: ldnull
IL_003a: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_003f: brfalse.s IL_0042
IL_0041: ret
IL_0042: ldarg.0
IL_0043: ldfld TMPro.TMP_FontAsset TMPro.TMP_Text::m_fontAsset
IL_0048: ldnull
IL_0049: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_004e: brfalse.s IL_0071
IL_0050: ldstr "Please assign a Font Asset to this "
IL_0055: ldarg.0
IL_0056: call UnityEngine.Transform TMPro.TMP_Text::get_transform()
IL_005b: callvirt System.String UnityEngine.Object::get_name()
IL_0060: ldstr " gameobject."
IL_0065: call System.String System.String::Concat(System.String,System.String,System.String)
IL_006a: ldarg.0
IL_006b: call System.Void UnityEngine.Debug::LogWarning(System.Object,UnityEngine.Object)
IL_0070: ret
IL_0071: ldarg.0
IL_0072: ldfld System.Boolean TMPro.TMP_Text::m_havePropertiesChanged
IL_0077: brtrue.s IL_0084
IL_0079: ldarg.0
IL_007a: ldfld System.Boolean TMPro.TMP_Text::m_isLayoutDirty
IL_007f: brfalse IL_0138
IL_0084: ldarg.0
IL_0085: ldfld System.Boolean TMPro.TMP_Text::checkPaddingRequired
IL_008a: brfalse.s IL_0092
IL_008c: ldarg.0
IL_008d: callvirt System.Void TMPro.TMP_Text::UpdateMeshPadding()
IL_0092: ldarg.0
IL_0093: call System.Void TMPro.TMP_Text::ParseInputText()
IL_0098: call System.Void TMPro.TMP_FontAsset::UpdateFontFeaturesForFontAssetsInQueue()
IL_009d: ldarg.0
IL_009e: ldfld System.Boolean TMPro.TMP_Text::m_enableAutoSizing
IL_00a3: brfalse.s IL_00c2
IL_00a5: ldarg.0
IL_00a6: ldarg.0
IL_00a7: ldfld System.Single TMPro.TMP_Text::m_fontSizeBase
IL_00ac: ldarg.0
IL_00ad: ldfld System.Single TMPro.TMP_Text::m_fontSizeMin
IL_00b2: ldarg.0
IL_00b3: ldfld System.Single TMPro.TMP_Text::m_fontSizeMax
IL_00b8: call System.Single UnityEngine.Mathf::Clamp(System.Single,System.Single,System.Single)
IL_00bd: stfld System.Single TMPro.TMP_Text::m_fontSize
IL_00c2: ldarg.0
IL_00c3: ldarg.0
IL_00c4: ldfld System.Single TMPro.TMP_Text::m_fontSizeMax
IL_00c9: stfld System.Single TMPro.TMP_Text::m_maxFontSize
IL_00ce: ldarg.0
IL_00cf: ldarg.0
IL_00d0: ldfld System.Single TMPro.TMP_Text::m_fontSizeMin
IL_00d5: stfld System.Single TMPro.TMP_Text::m_minFontSize
IL_00da: ldarg.0
IL_00db: ldc.r4 0
IL_00e0: stfld System.Single TMPro.TMP_Text::m_lineSpacingDelta
IL_00e5: ldarg.0
IL_00e6: ldc.r4 0
IL_00eb: stfld System.Single TMPro.TMP_Text::m_charWidthAdjDelta
IL_00f0: ldarg.0
IL_00f1: ldc.i4.0
IL_00f2: stfld System.Boolean TMPro.TMP_Text::m_isTextTruncated
IL_00f7: ldarg.0
IL_00f8: ldc.i4.0
IL_00f9: stfld System.Boolean TMPro.TMP_Text::m_havePropertiesChanged
IL_00fe: ldarg.0
IL_00ff: ldc.i4.0
IL_0100: stfld System.Boolean TMPro.TMP_Text::m_isLayoutDirty
IL_0105: ldarg.0
IL_0106: ldc.i4.0
IL_0107: stfld System.Boolean TMPro.TMP_Text::m_ignoreActiveState
IL_010c: ldarg.0
IL_010d: ldc.i4.0
IL_010e: stfld System.Boolean TMPro.TMP_Text::m_IsAutoSizePointSizeSet
IL_0113: ldarg.0
IL_0114: ldc.i4.0
IL_0115: stfld System.Int32 TMPro.TMP_Text::m_AutoSizeIterationCount
IL_011a: br.s IL_0130
IL_011c: ldarg.0
IL_011d: callvirt System.Void TMPro.TextMeshProUGUI::GenerateTextMesh()
IL_0122: ldarg.0
IL_0123: ldarg.0
IL_0124: ldfld System.Int32 TMPro.TMP_Text::m_AutoSizeIterationCount
IL_0129: ldc.i4.1
IL_012a: add
IL_012b: stfld System.Int32 TMPro.TMP_Text::m_AutoSizeIterationCount
IL_0130: ldarg.0
IL_0131: ldfld System.Boolean TMPro.TMP_Text::m_IsAutoSizePointSizeSet
IL_0136: brfalse.s IL_011c
IL_0138: ret
