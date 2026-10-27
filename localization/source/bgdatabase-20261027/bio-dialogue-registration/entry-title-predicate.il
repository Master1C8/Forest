TYPE PixelCrushers.DialogueSystem.Conversation/<>c__DisplayClass20_0
METHOD System.Boolean PixelCrushers.DialogueSystem.Conversation/<>c__DisplayClass20_0::<GetDialogueEntry>b__0(PixelCrushers.DialogueSystem.DialogueEntry) | attributes=Assembly, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_Title()
IL_0006: ldarg.0
IL_0007: ldfld System.String PixelCrushers.DialogueSystem.Conversation/<>c__DisplayClass20_0::title
IL_000c: call System.Boolean System.String::Equals(System.String,System.String)
IL_0011: ret
