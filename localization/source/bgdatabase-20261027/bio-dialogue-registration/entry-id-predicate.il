TYPE PixelCrushers.DialogueSystem.Conversation/<>c__DisplayClass21_0
METHOD System.Boolean PixelCrushers.DialogueSystem.Conversation/<>c__DisplayClass21_0::<GetDialogueEntry>b__0(PixelCrushers.DialogueSystem.DialogueEntry) | attributes=Assembly, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_0006: box System.Int32
IL_000b: ldarg.0
IL_000c: ldfld System.Int32 PixelCrushers.DialogueSystem.Conversation/<>c__DisplayClass21_0::dialogueEntryID
IL_0011: box System.Int32
IL_0016: call System.Boolean System.Object::Equals(System.Object,System.Object)
IL_001b: ret
