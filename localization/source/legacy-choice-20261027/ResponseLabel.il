TYPE PixelCrushers.DialogueSystem.StandardUIResponseButton
METHOD System.String PixelCrushers.DialogueSystem.StandardUIResponseButton::get_text() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld PixelCrushers.UITextField PixelCrushers.DialogueSystem.StandardUIResponseButton::label
IL_0006: callvirt System.String PixelCrushers.UITextField::get_text()
IL_000b: ret
METHOD System.Void PixelCrushers.DialogueSystem.StandardUIResponseButton::set_text(System.String) | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld PixelCrushers.UITextField PixelCrushers.DialogueSystem.StandardUIResponseButton::label
IL_0006: ldarg.1
IL_0007: call System.String PixelCrushers.DialogueSystem.UITools::StripRPGMakerCodes(System.String)
IL_000c: callvirt System.Void PixelCrushers.UITextField::set_text(System.String)
IL_0011: ldarg.0
IL_0012: ldfld PixelCrushers.UITextField PixelCrushers.DialogueSystem.StandardUIResponseButton::label
IL_0017: call System.Void PixelCrushers.DialogueSystem.UITools::SendTextChangeMessage(PixelCrushers.UITextField)
IL_001c: ret
METHOD System.Void PixelCrushers.DialogueSystem.StandardUIResponseButton::SetFormattedText(PixelCrushers.DialogueSystem.FormattedText) | attributes=Public, Virtual, HideBySig, VtableLayoutMask | impl=IL
IL_0000: ldarg.1
IL_0001: brtrue.s IL_0004
IL_0003: ret
IL_0004: ldarg.0
IL_0005: ldarg.1
IL_0006: call System.String PixelCrushers.DialogueSystem.UITools::GetUIFormattedText(PixelCrushers.DialogueSystem.FormattedText)
IL_000b: call System.Void PixelCrushers.DialogueSystem.StandardUIResponseButton::set_text(System.String)
IL_0010: ldarg.0
IL_0011: ldarg.1
IL_0012: callvirt PixelCrushers.DialogueSystem.Emphasis[] PixelCrushers.DialogueSystem.FormattedText::get_emphases()
IL_0017: ldlen
IL_0018: brtrue.s IL_0022
IL_001a: ldarg.0
IL_001b: ldfld UnityEngine.Color PixelCrushers.DialogueSystem.StandardUIResponseButton::defaultColor
IL_0020: br.s IL_0033
IL_0022: ldarg.1
IL_0023: callvirt PixelCrushers.DialogueSystem.Emphasis[] PixelCrushers.DialogueSystem.FormattedText::get_emphases()
IL_0028: ldc.i4.0
IL_0029: ldelema PixelCrushers.DialogueSystem.Emphasis
IL_002e: call UnityEngine.Color PixelCrushers.DialogueSystem.Emphasis::get_color()
IL_0033: callvirt System.Void PixelCrushers.DialogueSystem.StandardUIResponseButton::SetColor(UnityEngine.Color)
IL_0038: ret
METHOD System.Void PixelCrushers.DialogueSystem.StandardUIResponseButton::SetUnformattedText(System.String) | attributes=Public, Virtual, HideBySig, VtableLayoutMask | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: call System.Void PixelCrushers.DialogueSystem.StandardUIResponseButton::set_text(System.String)
IL_0007: ldarg.0
IL_0008: ldarg.0
IL_0009: ldfld UnityEngine.Color PixelCrushers.DialogueSystem.StandardUIResponseButton::defaultColor
IL_000e: callvirt System.Void PixelCrushers.DialogueSystem.StandardUIResponseButton::SetColor(UnityEngine.Color)
IL_0013: ret
