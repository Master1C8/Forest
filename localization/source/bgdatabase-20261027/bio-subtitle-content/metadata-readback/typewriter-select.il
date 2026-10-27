TYPE PixelCrushers.DialogueSystem.TypewriterUtility
METHOD PixelCrushers.DialogueSystem.AbstractTypewriterEffect PixelCrushers.DialogueSystem.TypewriterUtility::GetTypewriter(PixelCrushers.UITextField) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldnull
IL_0001: stloc.0
IL_0002: ldarg.0
IL_0003: callvirt TMPro.TextMeshProUGUI PixelCrushers.UITextField::get_textMeshProUGUI()
IL_0008: ldnull
IL_0009: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_000e: brfalse.s IL_001c
IL_0010: ldarg.0
IL_0011: callvirt TMPro.TextMeshProUGUI PixelCrushers.UITextField::get_textMeshProUGUI()
IL_0016: callvirt !!0 UnityEngine.Component::GetComponent<PixelCrushers.DialogueSystem.AbstractTypewriterEffect>()
IL_001b: stloc.0
IL_001c: ldloc.0
IL_001d: ldnull
IL_001e: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0023: brfalse.s IL_003f
IL_0025: ldarg.0
IL_0026: callvirt UnityEngine.UI.Text PixelCrushers.UITextField::get_uiText()
IL_002b: ldnull
IL_002c: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0031: brfalse.s IL_003f
IL_0033: ldarg.0
IL_0034: callvirt UnityEngine.UI.Text PixelCrushers.UITextField::get_uiText()
IL_0039: callvirt !!0 UnityEngine.Component::GetComponent<PixelCrushers.DialogueSystem.AbstractTypewriterEffect>()
IL_003e: stloc.0
IL_003f: ldloc.0
IL_0040: ret
