TYPE PixelCrushers.DialogueSystem.AbstractUISubtitleControls
METHOD System.Void PixelCrushers.DialogueSystem.AbstractUISubtitleControls::ShowSubtitle(PixelCrushers.DialogueSystem.Subtitle) | attributes=Public, Virtual, HideBySig, VtableLayoutMask | impl=IL
IL_0000: ldarg.1
IL_0001: brfalse.s IL_002a
IL_0003: ldarg.1
IL_0004: ldfld PixelCrushers.DialogueSystem.FormattedText PixelCrushers.DialogueSystem.Subtitle::formattedText
IL_0009: callvirt System.String PixelCrushers.DialogueSystem.FormattedText::get_text()
IL_000e: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_0013: brtrue.s IL_002a
IL_0015: ldarg.0
IL_0016: ldarg.1
IL_0017: stfld PixelCrushers.DialogueSystem.Subtitle PixelCrushers.DialogueSystem.AbstractUISubtitleControls::currentSubtitle
IL_001c: ldarg.0
IL_001d: ldarg.1
IL_001e: callvirt System.Void PixelCrushers.DialogueSystem.AbstractUISubtitleControls::SetSubtitle(PixelCrushers.DialogueSystem.Subtitle)
IL_0023: ldarg.0
IL_0024: call System.Void PixelCrushers.DialogueSystem.AbstractUIControls::Show()
IL_0029: ret
IL_002a: ldarg.0
IL_002b: ldnull
IL_002c: stfld PixelCrushers.DialogueSystem.Subtitle PixelCrushers.DialogueSystem.AbstractUISubtitleControls::currentSubtitle
IL_0031: ldarg.0
IL_0032: callvirt System.Void PixelCrushers.DialogueSystem.AbstractUISubtitleControls::ClearSubtitle()
IL_0037: ldarg.0
IL_0038: call System.Void PixelCrushers.DialogueSystem.AbstractUIControls::Hide()
IL_003d: ret
