TYPE PixelCrushers.UITextField
METHOD System.Void PixelCrushers.UITextField::set_text(System.String)
IL_0000: ldarg.0
IL_0001: call TMPro.TextMeshProUGUI PixelCrushers.UITextField::get_textMeshProUGUI()
IL_0006: ldnull
IL_0007: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_000c: brfalse.s IL_001a
IL_000e: ldarg.0
IL_000f: call TMPro.TextMeshProUGUI PixelCrushers.UITextField::get_textMeshProUGUI()
IL_0014: ldarg.1
IL_0015: callvirt System.Void TMPro.TMP_Text::set_text(System.String)
IL_001a: ldarg.0
IL_001b: call UnityEngine.UI.Text PixelCrushers.UITextField::get_uiText()
IL_0020: ldnull
IL_0021: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0026: brfalse.s IL_0034
IL_0028: ldarg.0
IL_0029: call UnityEngine.UI.Text PixelCrushers.UITextField::get_uiText()
IL_002e: ldarg.1
IL_002f: callvirt System.Void UnityEngine.UI.Text::set_text(System.String)
IL_0034: ret
