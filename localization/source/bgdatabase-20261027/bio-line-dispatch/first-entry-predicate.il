TYPE PixelCrushers.DialogueSystem.Conversation/<>c
METHOD System.Boolean PixelCrushers.DialogueSystem.Conversation/<>c::<GetFirstDialogueEntry>b__22_0(PixelCrushers.DialogueSystem.DialogueEntry) | attributes=Assembly, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_Title()
IL_0006: ldstr "START"
IL_000b: call System.Boolean System.String::Equals(System.String,System.String)
IL_0010: ret
