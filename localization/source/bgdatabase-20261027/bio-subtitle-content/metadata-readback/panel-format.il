TYPE PixelCrushers.DialogueSystem.StandardUISubtitlePanel
METHOD System.Void PixelCrushers.DialogueSystem.StandardUISubtitlePanel::SetFormattedText(PixelCrushers.UITextField,System.String,PixelCrushers.DialogueSystem.FormattedText) | attributes=Family, Virtual, HideBySig, VtableLayoutMask | impl=IL
IL_0000: ldarg.1
IL_0001: ldarg.2
IL_0002: ldarg.3
IL_0003: call System.String PixelCrushers.DialogueSystem.UITools::GetUIFormattedText(PixelCrushers.DialogueSystem.FormattedText)
IL_0008: call System.String System.String::Concat(System.String,System.String)
IL_000d: callvirt System.Void PixelCrushers.UITextField::set_text(System.String)
IL_0012: ldarg.1
IL_0013: call System.Void PixelCrushers.DialogueSystem.UITools::SendTextChangeMessage(PixelCrushers.UITextField)
IL_0018: ldarg.0
IL_0019: call System.Boolean PixelCrushers.DialogueSystem.StandardUISubtitlePanel::get_haveSavedOriginalColor()
IL_001e: brtrue.s IL_0033
IL_0020: ldarg.0
IL_0021: ldarg.1
IL_0022: callvirt UnityEngine.Color PixelCrushers.UITextField::get_color()
IL_0027: call System.Void PixelCrushers.DialogueSystem.StandardUISubtitlePanel::set_originalColor(UnityEngine.Color)
IL_002c: ldarg.0
IL_002d: ldc.i4.1
IL_002e: call System.Void PixelCrushers.DialogueSystem.StandardUISubtitlePanel::set_haveSavedOriginalColor(System.Boolean)
IL_0033: ldarg.1
IL_0034: ldarg.3
IL_0035: callvirt PixelCrushers.DialogueSystem.Emphasis[] PixelCrushers.DialogueSystem.FormattedText::get_emphases()
IL_003a: brfalse.s IL_0045
IL_003c: ldarg.3
IL_003d: callvirt PixelCrushers.DialogueSystem.Emphasis[] PixelCrushers.DialogueSystem.FormattedText::get_emphases()
IL_0042: ldlen
IL_0043: brtrue.s IL_004d
IL_0045: ldarg.0
IL_0046: call UnityEngine.Color PixelCrushers.DialogueSystem.StandardUISubtitlePanel::get_originalColor()
IL_004b: br.s IL_005e
IL_004d: ldarg.3
IL_004e: callvirt PixelCrushers.DialogueSystem.Emphasis[] PixelCrushers.DialogueSystem.FormattedText::get_emphases()
IL_0053: ldc.i4.0
IL_0054: ldelema PixelCrushers.DialogueSystem.Emphasis
IL_0059: call UnityEngine.Color PixelCrushers.DialogueSystem.Emphasis::get_color()
IL_005e: callvirt System.Void PixelCrushers.UITextField::set_color(UnityEngine.Color)
IL_0063: ret
