TYPE TMPro.TextMeshProUGUI
METHOD System.Void TMPro.TextMeshProUGUI::UpdateMaterial() | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld UnityEngine.Material TMPro.TMP_Text::m_sharedMaterial
IL_0006: ldnull
IL_0007: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_000c: brtrue.s IL_001c
IL_000e: ldarg.0
IL_000f: call UnityEngine.CanvasRenderer TMPro.TextMeshProUGUI::get_canvasRenderer()
IL_0014: ldnull
IL_0015: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_001a: brfalse.s IL_001d
IL_001c: ret
IL_001d: ldarg.0
IL_001e: ldfld UnityEngine.CanvasRenderer TMPro.TextMeshProUGUI::m_canvasRenderer
IL_0023: ldc.i4.1
IL_0024: callvirt System.Void UnityEngine.CanvasRenderer::set_materialCount(System.Int32)
IL_0029: ldarg.0
IL_002a: ldfld UnityEngine.CanvasRenderer TMPro.TextMeshProUGUI::m_canvasRenderer
IL_002f: ldarg.0
IL_0030: callvirt UnityEngine.Material UnityEngine.UI.Graphic::get_materialForRendering()
IL_0035: ldc.i4.0
IL_0036: callvirt System.Void UnityEngine.CanvasRenderer::SetMaterial(UnityEngine.Material,System.Int32)
IL_003b: ret
