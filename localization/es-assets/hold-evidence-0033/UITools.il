TYPE PixelCrushers.DialogueSystem.UITools
METHOD System.String PixelCrushers.DialogueSystem.UITools::GetUIFormattedText(PixelCrushers.DialogueSystem.FormattedText)
IL_0000: ldarg.0
IL_0001: brtrue.s IL_0009
IL_0003: ldsfld System.String System.String::Empty
IL_0008: ret
IL_0009: ldarg.0
IL_000a: callvirt System.Boolean PixelCrushers.DialogueSystem.FormattedText::get_italic()
IL_000f: brfalse.s IL_0027
IL_0011: ldstr "<i>"
IL_0016: ldarg.0
IL_0017: callvirt System.String PixelCrushers.DialogueSystem.FormattedText::get_text()
IL_001c: ldstr "</i>"
IL_0021: call System.String System.String::Concat(System.String,System.String,System.String)
IL_0026: ret
IL_0027: ldarg.0
IL_0028: callvirt System.String PixelCrushers.DialogueSystem.FormattedText::get_text()
IL_002d: ret
