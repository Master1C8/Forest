TYPE PixelCrushers.UITextField
METHOD UnityEngine.UI.Text PixelCrushers.UITextField::get_uiText() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld UnityEngine.UI.Text PixelCrushers.UITextField::m_uiText
IL_0006: ret
METHOD TMPro.TextMeshProUGUI PixelCrushers.UITextField::get_textMeshProUGUI() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TMPro.TextMeshProUGUI PixelCrushers.UITextField::m_textMeshProUGUI
IL_0006: ret
METHOD UnityEngine.GameObject PixelCrushers.UITextField::get_gameObject() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: call TMPro.TextMeshProUGUI PixelCrushers.UITextField::get_textMeshProUGUI()
IL_0006: ldnull
IL_0007: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_000c: brfalse.s IL_001a
IL_000e: ldarg.0
IL_000f: call TMPro.TextMeshProUGUI PixelCrushers.UITextField::get_textMeshProUGUI()
IL_0014: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0019: ret
IL_001a: ldarg.0
IL_001b: call UnityEngine.UI.Text PixelCrushers.UITextField::get_uiText()
IL_0020: ldnull
IL_0021: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0026: brtrue.s IL_002a
IL_0028: ldnull
IL_0029: ret
IL_002a: ldarg.0
IL_002b: call UnityEngine.UI.Text PixelCrushers.UITextField::get_uiText()
IL_0030: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0035: ret
