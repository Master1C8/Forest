TYPE PixelCrushers.DialogueSystem.LocalizeUIText
METHOD System.Void PixelCrushers.DialogueSystem.LocalizeUIText::Awake() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldstr "Use LocalizeUI instead."
IL_0006: call System.Void PixelCrushers.DialogueSystem.Tools::DeprecationWarning(UnityEngine.MonoBehaviour,System.String)
IL_000b: ret
METHOD System.Void PixelCrushers.DialogueSystem.LocalizeUIText::LocalizeText() | attributes=Public, Virtual, HideBySig, VtableLayoutMask | impl=IL
IL_0000: ldarg.0
IL_0001: callvirt System.Void PixelCrushers.LocalizeUI::UpdateText()
IL_0006: ret
