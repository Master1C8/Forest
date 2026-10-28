TYPE PixelCrushers.DialogueSystem.DialogueDatabase/<>c__DisplayClass37_0
METHOD System.Boolean PixelCrushers.DialogueSystem.DialogueDatabase/<>c__DisplayClass37_0::<GetConversation>b__0(PixelCrushers.DialogueSystem.Conversation) | attributes=Assembly, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: callvirt System.String PixelCrushers.DialogueSystem.Conversation::get_Title()
IL_0006: ldarg.0
IL_0007: ldfld System.String PixelCrushers.DialogueSystem.DialogueDatabase/<>c__DisplayClass37_0::conversationTitle
IL_000c: call System.Boolean System.String::Equals(System.String,System.String)
IL_0011: ret
