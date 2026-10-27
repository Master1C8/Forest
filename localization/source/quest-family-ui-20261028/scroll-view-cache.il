TYPE UnityEngine.UI.ScrollRect
METHOD System.Void UnityEngine.UI.ScrollRect::set_viewport(UnityEngine.RectTransform) | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: stfld UnityEngine.RectTransform UnityEngine.UI.ScrollRect::m_Viewport
IL_0007: ldarg.0
IL_0008: call System.Void UnityEngine.UI.ScrollRect::SetDirtyCaching()
IL_000d: ret
METHOD UnityEngine.RectTransform UnityEngine.UI.ScrollRect::get_viewRect() | attributes=Family, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld UnityEngine.RectTransform UnityEngine.UI.ScrollRect::m_ViewRect
IL_0006: ldnull
IL_0007: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_000c: brfalse.s IL_001a
IL_000e: ldarg.0
IL_000f: ldarg.0
IL_0010: ldfld UnityEngine.RectTransform UnityEngine.UI.ScrollRect::m_Viewport
IL_0015: stfld UnityEngine.RectTransform UnityEngine.UI.ScrollRect::m_ViewRect
IL_001a: ldarg.0
IL_001b: ldfld UnityEngine.RectTransform UnityEngine.UI.ScrollRect::m_ViewRect
IL_0020: ldnull
IL_0021: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0026: brfalse.s IL_0039
IL_0028: ldarg.0
IL_0029: ldarg.0
IL_002a: call UnityEngine.Transform UnityEngine.Component::get_transform()
IL_002f: castclass UnityEngine.RectTransform
IL_0034: stfld UnityEngine.RectTransform UnityEngine.UI.ScrollRect::m_ViewRect
IL_0039: ldarg.0
IL_003a: ldfld UnityEngine.RectTransform UnityEngine.UI.ScrollRect::m_ViewRect
IL_003f: ret
METHOD System.Void UnityEngine.UI.ScrollRect::SetDirtyCaching() | attributes=Family, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: callvirt System.Boolean UnityEngine.EventSystems.UIBehaviour::IsActive()
IL_0006: brtrue.s IL_0009
IL_0008: ret
IL_0009: ldarg.0
IL_000a: call System.Void UnityEngine.UI.CanvasUpdateRegistry::RegisterCanvasElementForLayoutRebuild(UnityEngine.UI.ICanvasElement)
IL_000f: ldarg.0
IL_0010: call UnityEngine.RectTransform UnityEngine.UI.ScrollRect::get_rectTransform()
IL_0015: call System.Void UnityEngine.UI.LayoutRebuilder::MarkLayoutForRebuild(UnityEngine.RectTransform)
IL_001a: ldarg.0
IL_001b: ldnull
IL_001c: stfld UnityEngine.RectTransform UnityEngine.UI.ScrollRect::m_ViewRect
IL_0021: ret
TYPE UnityEngine.UI.ScrollRect
METHOD System.Void UnityEngine.UI.ScrollRect::set_content(UnityEngine.RectTransform) | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: stfld UnityEngine.RectTransform UnityEngine.UI.ScrollRect::m_Content
IL_0007: ret
METHOD System.Boolean UnityEngine.UI.ScrollRect::IsActive() | attributes=Public, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Boolean UnityEngine.EventSystems.UIBehaviour::IsActive()
IL_0006: brfalse.s IL_0015
IL_0008: ldarg.0
IL_0009: ldfld UnityEngine.RectTransform UnityEngine.UI.ScrollRect::m_Content
IL_000e: ldnull
IL_000f: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0014: ret
IL_0015: ldc.i4.0
IL_0016: ret
