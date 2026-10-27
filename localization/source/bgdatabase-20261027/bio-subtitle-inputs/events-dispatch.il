TYPE PixelCrushers.DialogueSystem.DialogueSystemEvents
METHOD System.Void PixelCrushers.DialogueSystem.DialogueSystemEvents::OnConversationLine(PixelCrushers.DialogueSystem.Subtitle) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld PixelCrushers.DialogueSystem.DialogueSystemEvents/ConversationEvents PixelCrushers.DialogueSystem.DialogueSystemEvents::conversationEvents
IL_0006: ldfld PixelCrushers.DialogueSystem.DialogueSystemEvents/SubtitleEvent PixelCrushers.DialogueSystem.DialogueSystemEvents/ConversationEvents::onConversationLine
IL_000b: ldarg.1
IL_000c: callvirt System.Void UnityEngine.Events.UnityEvent`1<PixelCrushers.DialogueSystem.Subtitle>::Invoke(!0)
IL_0011: ret
METHOD System.Void PixelCrushers.DialogueSystem.DialogueSystemEvents::OnConversationLineEnd(PixelCrushers.DialogueSystem.Subtitle) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld PixelCrushers.DialogueSystem.DialogueSystemEvents/ConversationEvents PixelCrushers.DialogueSystem.DialogueSystemEvents::conversationEvents
IL_0006: ldfld PixelCrushers.DialogueSystem.DialogueSystemEvents/SubtitleEvent PixelCrushers.DialogueSystem.DialogueSystemEvents/ConversationEvents::onConversationLineEnd
IL_000b: ldarg.1
IL_000c: callvirt System.Void UnityEngine.Events.UnityEvent`1<PixelCrushers.DialogueSystem.Subtitle>::Invoke(!0)
IL_0011: ret
