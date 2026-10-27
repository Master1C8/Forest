TYPE PixelCrushers.DialogueSystem.Conversation
METHOD PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Conversation::GetDialogueEntry(System.String) | attributes=Public, HideBySig | impl=IL
IL_0000: newobj System.Void PixelCrushers.DialogueSystem.Conversation/<>c__DisplayClass20_0::.ctor()
IL_0005: stloc.0
IL_0006: ldloc.0
IL_0007: ldarg.1
IL_0008: stfld System.String PixelCrushers.DialogueSystem.Conversation/<>c__DisplayClass20_0::title
IL_000d: ldarg.0
IL_000e: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueEntry> PixelCrushers.DialogueSystem.Conversation::dialogueEntries
IL_0013: ldloc.0
IL_0014: ldftn System.Boolean PixelCrushers.DialogueSystem.Conversation/<>c__DisplayClass20_0::<GetDialogueEntry>b__0(PixelCrushers.DialogueSystem.DialogueEntry)
IL_001a: newobj System.Void System.Predicate`1<PixelCrushers.DialogueSystem.DialogueEntry>::.ctor(System.Object,System.IntPtr)
IL_001f: callvirt !0 System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueEntry>::Find(System.Predicate`1<!0>)
IL_0024: ret
METHOD PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Conversation::GetDialogueEntry(System.Int32) | attributes=Public, HideBySig | impl=IL
IL_0000: newobj System.Void PixelCrushers.DialogueSystem.Conversation/<>c__DisplayClass21_0::.ctor()
IL_0005: stloc.0
IL_0006: ldloc.0
IL_0007: ldarg.1
IL_0008: stfld System.Int32 PixelCrushers.DialogueSystem.Conversation/<>c__DisplayClass21_0::dialogueEntryID
IL_000d: ldarg.0
IL_000e: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueEntry> PixelCrushers.DialogueSystem.Conversation::dialogueEntries
IL_0013: ldloc.0
IL_0014: ldftn System.Boolean PixelCrushers.DialogueSystem.Conversation/<>c__DisplayClass21_0::<GetDialogueEntry>b__0(PixelCrushers.DialogueSystem.DialogueEntry)
IL_001a: newobj System.Void System.Predicate`1<PixelCrushers.DialogueSystem.DialogueEntry>::.ctor(System.Object,System.IntPtr)
IL_001f: callvirt !0 System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueEntry>::Find(System.Predicate`1<!0>)
IL_0024: ret
