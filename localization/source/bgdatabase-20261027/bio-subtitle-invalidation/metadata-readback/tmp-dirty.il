TYPE TMPro.TextMeshProUGUI
METHOD System.Void TMPro.TextMeshProUGUI::SetVerticesDirty() | attributes=Public, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldnull
IL_0002: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0007: brtrue.s IL_0011
IL_0009: ldarg.0
IL_000a: callvirt System.Boolean UnityEngine.EventSystems.UIBehaviour::IsActive()
IL_000f: brtrue.s IL_0012
IL_0011: ret
IL_0012: call System.Boolean UnityEngine.UI.CanvasUpdateRegistry::IsRebuildingGraphics()
IL_0017: brfalse.s IL_001a
IL_0019: ret
IL_001a: ldarg.0
IL_001b: call System.Void UnityEngine.UI.CanvasUpdateRegistry::RegisterCanvasElementForGraphicRebuild(UnityEngine.UI.ICanvasElement)
IL_0020: ldarg.0
IL_0021: ldfld UnityEngine.Events.UnityAction UnityEngine.UI.Graphic::m_OnDirtyVertsCallback
IL_0026: brfalse.s IL_0033
IL_0028: ldarg.0
IL_0029: ldfld UnityEngine.Events.UnityAction UnityEngine.UI.Graphic::m_OnDirtyVertsCallback
IL_002e: callvirt System.Void UnityEngine.Events.UnityAction::Invoke()
IL_0033: ret
METHOD System.Void TMPro.TextMeshProUGUI::SetLayoutDirty() | attributes=Public, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldc.i4.1
IL_0002: stfld System.Boolean TMPro.TMP_Text::m_isPreferredWidthDirty
IL_0007: ldarg.0
IL_0008: ldc.i4.1
IL_0009: stfld System.Boolean TMPro.TMP_Text::m_isPreferredHeightDirty
IL_000e: ldarg.0
IL_000f: ldnull
IL_0010: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0015: brtrue.s IL_001f
IL_0017: ldarg.0
IL_0018: callvirt System.Boolean UnityEngine.EventSystems.UIBehaviour::IsActive()
IL_001d: brtrue.s IL_0020
IL_001f: ret
IL_0020: ldarg.0
IL_0021: call UnityEngine.RectTransform TMPro.TMP_Text::get_rectTransform()
IL_0026: call System.Void UnityEngine.UI.LayoutRebuilder::MarkLayoutForRebuild(UnityEngine.RectTransform)
IL_002b: ldarg.0
IL_002c: ldc.i4.1
IL_002d: stfld System.Boolean TMPro.TMP_Text::m_isLayoutDirty
IL_0032: ldarg.0
IL_0033: ldfld UnityEngine.Events.UnityAction UnityEngine.UI.Graphic::m_OnDirtyLayoutCallback
IL_0038: brfalse.s IL_0045
IL_003a: ldarg.0
IL_003b: ldfld UnityEngine.Events.UnityAction UnityEngine.UI.Graphic::m_OnDirtyLayoutCallback
IL_0040: callvirt System.Void UnityEngine.Events.UnityAction::Invoke()
IL_0045: ret
