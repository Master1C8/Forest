TYPE PixelCrushers.DialogueSystem.StandardDialogueUI
METHOD PixelCrushers.DialogueSystem.AbstractDialogueUIControls PixelCrushers.DialogueSystem.StandardDialogueUI::get_dialogueControls() | attributes=Public, Virtual, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld PixelCrushers.DialogueSystem.StandardUIDialogueControls PixelCrushers.DialogueSystem.StandardDialogueUI::conversationUIElements
IL_0006: ret
METHOD System.Void PixelCrushers.DialogueSystem.StandardDialogueUI::ShowSubtitle(PixelCrushers.DialogueSystem.Subtitle) | attributes=Public, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld PixelCrushers.DialogueSystem.StandardUIDialogueControls PixelCrushers.DialogueSystem.StandardDialogueUI::conversationUIElements
IL_0006: callvirt PixelCrushers.DialogueSystem.StandardUIResponseMenuControls PixelCrushers.DialogueSystem.StandardUIDialogueControls::get_standardMenuControls()
IL_000b: callvirt System.Void PixelCrushers.DialogueSystem.StandardUIResponseMenuControls::Close()
IL_0010: ldarg.0
IL_0011: ldfld PixelCrushers.DialogueSystem.StandardUIDialogueControls PixelCrushers.DialogueSystem.StandardDialogueUI::conversationUIElements
IL_0016: callvirt PixelCrushers.DialogueSystem.StandardUISubtitleControls PixelCrushers.DialogueSystem.StandardUIDialogueControls::get_standardSubtitleControls()
IL_001b: ldarg.1
IL_001c: callvirt System.Void PixelCrushers.DialogueSystem.AbstractUISubtitleControls::ShowSubtitle(PixelCrushers.DialogueSystem.Subtitle)
IL_0021: ret
METHOD System.Void PixelCrushers.DialogueSystem.StandardDialogueUI::HideSubtitle(PixelCrushers.DialogueSystem.Subtitle) | attributes=Public, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld PixelCrushers.DialogueSystem.StandardUIDialogueControls PixelCrushers.DialogueSystem.StandardDialogueUI::conversationUIElements
IL_0006: callvirt PixelCrushers.DialogueSystem.StandardUISubtitleControls PixelCrushers.DialogueSystem.StandardUIDialogueControls::get_standardSubtitleControls()
IL_000b: ldarg.1
IL_000c: callvirt System.Void PixelCrushers.DialogueSystem.StandardUISubtitleControls::HideSubtitle(PixelCrushers.DialogueSystem.Subtitle)
IL_0011: ret
