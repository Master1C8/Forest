TYPE PixelCrushers.DialogueSystem.StandardUISubtitlePanel
METHOD System.Void PixelCrushers.DialogueSystem.StandardUISubtitlePanel::ShowSubtitleNow(PixelCrushers.DialogueSystem.Subtitle) | attributes=Family, Virtual, HideBySig, VtableLayoutMask | impl=IL
IL_0000: ldarg.0
IL_0001: ldc.i4.1
IL_0002: callvirt System.Void PixelCrushers.DialogueSystem.StandardUISubtitlePanel::SetUIElementsActive(System.Boolean)
IL_0007: ldarg.0
IL_0008: call System.Boolean PixelCrushers.UIPanel::get_isOpen()
IL_000d: brtrue.s IL_0016
IL_000f: ldarg.0
IL_0010: ldc.i4.0
IL_0011: call System.Void PixelCrushers.DialogueSystem.StandardUISubtitlePanel::set_hasFocus(System.Boolean)
IL_0016: ldarg.0
IL_0017: callvirt System.Void PixelCrushers.UIPanel::Open()
IL_001c: ldarg.0
IL_001d: callvirt System.Void PixelCrushers.DialogueSystem.StandardUISubtitlePanel::Focus()
IL_0022: ldarg.0
IL_0023: ldarg.1
IL_0024: callvirt System.Void PixelCrushers.DialogueSystem.StandardUISubtitlePanel::SetContent(PixelCrushers.DialogueSystem.Subtitle)
IL_0029: ldarg.0
IL_002a: ldnull
IL_002b: call System.Void PixelCrushers.DialogueSystem.StandardUISubtitlePanel::set_actorOverridingPanel(UnityEngine.Transform)
IL_0030: ret
