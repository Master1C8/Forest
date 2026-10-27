TYPE PixelCrushers.DialogueSystem.DialogueDatabase/<>c__DisplayClass40_0
METHOD System.Boolean PixelCrushers.DialogueSystem.DialogueDatabase/<>c__DisplayClass40_0::<GetDialogueEntry>b__0(PixelCrushers.DialogueSystem.DialogueEntry) | attributes=Assembly, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_0006: ldarg.0
IL_0007: ldfld PixelCrushers.DialogueSystem.Link PixelCrushers.DialogueSystem.DialogueDatabase/<>c__DisplayClass40_0::link
IL_000c: ldfld System.Int32 PixelCrushers.DialogueSystem.Link::destinationDialogueID
IL_0011: ceq
IL_0013: ret
