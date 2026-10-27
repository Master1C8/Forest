TYPE PixelCrushers.DialogueSystem.Conversation
METHOD PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Conversation::GetFirstDialogueEntry() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueEntry> PixelCrushers.DialogueSystem.Conversation::dialogueEntries
IL_0006: ldsfld System.Predicate`1<PixelCrushers.DialogueSystem.DialogueEntry> PixelCrushers.DialogueSystem.Conversation/<>c::<>9__22_0
IL_000b: dup
IL_000c: brtrue.s IL_0025
IL_000e: pop
IL_000f: ldsfld PixelCrushers.DialogueSystem.Conversation/<>c PixelCrushers.DialogueSystem.Conversation/<>c::<>9
IL_0014: ldftn System.Boolean PixelCrushers.DialogueSystem.Conversation/<>c::<GetFirstDialogueEntry>b__22_0(PixelCrushers.DialogueSystem.DialogueEntry)
IL_001a: newobj System.Void System.Predicate`1<PixelCrushers.DialogueSystem.DialogueEntry>::.ctor(System.Object,System.IntPtr)
IL_001f: dup
IL_0020: stsfld System.Predicate`1<PixelCrushers.DialogueSystem.DialogueEntry> PixelCrushers.DialogueSystem.Conversation/<>c::<>9__22_0
IL_0025: callvirt !0 System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueEntry>::Find(System.Predicate`1<!0>)
IL_002a: ret
