TYPE PixelCrushers.DialogueSystem.DialogueDatabase
METHOD PixelCrushers.DialogueSystem.Conversation PixelCrushers.DialogueSystem.DialogueDatabase::GetConversation(System.String) | attributes=Public, HideBySig | impl=IL
IL_0000: newobj System.Void PixelCrushers.DialogueSystem.DialogueDatabase/<>c__DisplayClass37_0::.ctor()
IL_0005: stloc.0
IL_0006: ldloc.0
IL_0007: ldarg.1
IL_0008: stfld System.String PixelCrushers.DialogueSystem.DialogueDatabase/<>c__DisplayClass37_0::conversationTitle
IL_000d: ldarg.0
IL_000e: call System.Void PixelCrushers.DialogueSystem.DialogueDatabase::SetupCaches()
IL_0013: ldarg.0
IL_0014: ldfld System.Collections.Generic.Dictionary`2<System.String,PixelCrushers.DialogueSystem.Conversation> PixelCrushers.DialogueSystem.DialogueDatabase::conversationTitleCache
IL_0019: ldloc.0
IL_001a: ldfld System.String PixelCrushers.DialogueSystem.DialogueDatabase/<>c__DisplayClass37_0::conversationTitle
IL_001f: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,PixelCrushers.DialogueSystem.Conversation>::ContainsKey(!0)
IL_0024: brtrue.s IL_003e
IL_0026: ldarg.0
IL_0027: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Conversation> PixelCrushers.DialogueSystem.DialogueDatabase::conversations
IL_002c: ldloc.0
IL_002d: ldftn System.Boolean PixelCrushers.DialogueSystem.DialogueDatabase/<>c__DisplayClass37_0::<GetConversation>b__0(PixelCrushers.DialogueSystem.Conversation)
IL_0033: newobj System.Void System.Predicate`1<PixelCrushers.DialogueSystem.Conversation>::.ctor(System.Object,System.IntPtr)
IL_0038: callvirt !0 System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Conversation>::Find(System.Predicate`1<!0>)
IL_003d: ret
IL_003e: ldarg.0
IL_003f: ldfld System.Collections.Generic.Dictionary`2<System.String,PixelCrushers.DialogueSystem.Conversation> PixelCrushers.DialogueSystem.DialogueDatabase::conversationTitleCache
IL_0044: ldloc.0
IL_0045: ldfld System.String PixelCrushers.DialogueSystem.DialogueDatabase/<>c__DisplayClass37_0::conversationTitle
IL_004a: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,PixelCrushers.DialogueSystem.Conversation>::get_Item(!0)
IL_004f: ret
METHOD PixelCrushers.DialogueSystem.Conversation PixelCrushers.DialogueSystem.DialogueDatabase::GetConversation(System.Int32) | attributes=Public, HideBySig | impl=IL
IL_0000: newobj System.Void PixelCrushers.DialogueSystem.DialogueDatabase/<>c__DisplayClass38_0::.ctor()
IL_0005: stloc.0
IL_0006: ldloc.0
IL_0007: ldarg.1
IL_0008: stfld System.Int32 PixelCrushers.DialogueSystem.DialogueDatabase/<>c__DisplayClass38_0::conversationID
IL_000d: ldarg.0
IL_000e: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Conversation> PixelCrushers.DialogueSystem.DialogueDatabase::conversations
IL_0013: ldloc.0
IL_0014: ldftn System.Boolean PixelCrushers.DialogueSystem.DialogueDatabase/<>c__DisplayClass38_0::<GetConversation>b__0(PixelCrushers.DialogueSystem.Conversation)
IL_001a: newobj System.Void System.Predicate`1<PixelCrushers.DialogueSystem.Conversation>::.ctor(System.Object,System.IntPtr)
IL_001f: callvirt !0 System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Conversation>::Find(System.Predicate`1<!0>)
IL_0024: ret
METHOD PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.DialogueDatabase::GetDialogueEntry(System.Int32,System.Int32) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: call PixelCrushers.DialogueSystem.Conversation PixelCrushers.DialogueSystem.DialogueDatabase::GetConversation(System.Int32)
IL_0007: stloc.0
IL_0008: ldloc.0
IL_0009: brtrue.s IL_000d
IL_000b: ldnull
IL_000c: ret
IL_000d: ldloc.0
IL_000e: ldarg.2
IL_000f: callvirt PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Conversation::GetDialogueEntry(System.Int32)
IL_0014: ret
METHOD PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.DialogueDatabase::GetDialogueEntry(PixelCrushers.DialogueSystem.Link) | attributes=Public, HideBySig | impl=IL
IL_0000: newobj System.Void PixelCrushers.DialogueSystem.DialogueDatabase/<>c__DisplayClass40_0::.ctor()
IL_0005: stloc.0
IL_0006: ldloc.0
IL_0007: ldarg.1
IL_0008: stfld PixelCrushers.DialogueSystem.Link PixelCrushers.DialogueSystem.DialogueDatabase/<>c__DisplayClass40_0::link
IL_000d: ldloc.0
IL_000e: ldfld PixelCrushers.DialogueSystem.Link PixelCrushers.DialogueSystem.DialogueDatabase/<>c__DisplayClass40_0::link
IL_0013: brfalse.s IL_004a
IL_0015: ldarg.0
IL_0016: ldloc.0
IL_0017: ldfld PixelCrushers.DialogueSystem.Link PixelCrushers.DialogueSystem.DialogueDatabase/<>c__DisplayClass40_0::link
IL_001c: ldfld System.Int32 PixelCrushers.DialogueSystem.Link::destinationConversationID
IL_0021: call PixelCrushers.DialogueSystem.Conversation PixelCrushers.DialogueSystem.DialogueDatabase::GetConversation(System.Int32)
IL_0026: stloc.1
IL_0027: ldloc.1
IL_0028: brfalse.s IL_004a
IL_002a: ldloc.1
IL_002b: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueEntry> PixelCrushers.DialogueSystem.Conversation::dialogueEntries
IL_0030: brfalse.s IL_004a
IL_0032: ldloc.1
IL_0033: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueEntry> PixelCrushers.DialogueSystem.Conversation::dialogueEntries
IL_0038: ldloc.0
IL_0039: ldftn System.Boolean PixelCrushers.DialogueSystem.DialogueDatabase/<>c__DisplayClass40_0::<GetDialogueEntry>b__0(PixelCrushers.DialogueSystem.DialogueEntry)
IL_003f: newobj System.Void System.Predicate`1<PixelCrushers.DialogueSystem.DialogueEntry>::.ctor(System.Object,System.IntPtr)
IL_0044: callvirt !0 System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueEntry>::Find(System.Predicate`1<!0>)
IL_0049: ret
IL_004a: ldnull
IL_004b: ret
