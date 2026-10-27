TYPE PixelCrushers.DialogueSystem.DialogueEntry
METHOD System.String PixelCrushers.DialogueSystem.DialogueEntry::get_currentMenuText() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: call PixelCrushers.DialogueSystem.Field PixelCrushers.DialogueSystem.DialogueEntry::GetCurrentMenuTextField()
IL_0006: call System.String PixelCrushers.DialogueSystem.Field::FieldValue(PixelCrushers.DialogueSystem.Field)
IL_000b: ret
METHOD System.String PixelCrushers.DialogueSystem.DialogueEntry::get_currentDialogueText() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: call PixelCrushers.DialogueSystem.Field PixelCrushers.DialogueSystem.DialogueEntry::GetCurrentDialogueTextField()
IL_0006: call System.String PixelCrushers.DialogueSystem.Field::FieldValue(PixelCrushers.DialogueSystem.Field)
IL_000b: ret
