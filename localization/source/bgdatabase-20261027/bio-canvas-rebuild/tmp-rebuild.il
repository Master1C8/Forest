TYPE TMPro.TextMeshProUGUI
METHOD System.Void TMPro.TextMeshProUGUI::Rebuild(UnityEngine.UI.CanvasUpdate) | attributes=Public, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldnull
IL_0002: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0007: brfalse.s IL_000a
IL_0009: ret
IL_000a: ldarg.1
IL_000b: brtrue.s IL_0031
IL_000d: ldarg.0
IL_000e: ldfld System.Boolean TMPro.TMP_Text::m_autoSizeTextContainer
IL_0013: brfalse.s IL_0051
IL_0015: ldarg.0
IL_0016: ldfld UnityEngine.RectTransform TMPro.TMP_Text::m_rectTransform
IL_001b: ldarg.0
IL_001c: ldc.r4 Infinity
IL_0021: ldc.r4 Infinity
IL_0026: call UnityEngine.Vector2 TMPro.TMP_Text::GetPreferredValues(System.Single,System.Single)
IL_002b: callvirt System.Void UnityEngine.RectTransform::set_sizeDelta(UnityEngine.Vector2)
IL_0030: ret
IL_0031: ldarg.1
IL_0032: ldc.i4.3
IL_0033: bne.un.s IL_0051
IL_0035: ldarg.0
IL_0036: call System.Void TMPro.TextMeshProUGUI::OnPreRenderCanvas()
IL_003b: ldarg.0
IL_003c: ldfld System.Boolean TMPro.TMP_Text::m_isMaterialDirty
IL_0041: brtrue.s IL_0044
IL_0043: ret
IL_0044: ldarg.0
IL_0045: callvirt System.Void UnityEngine.UI.Graphic::UpdateMaterial()
IL_004a: ldarg.0
IL_004b: ldc.i4.0
IL_004c: stfld System.Boolean TMPro.TMP_Text::m_isMaterialDirty
IL_0051: ret
