TYPE PixelCrushers.DialogueSystem.ConversationLogger
METHOD System.Void PixelCrushers.DialogueSystem.ConversationLogger::OnPrepareConversationLine(PixelCrushers.DialogueSystem.DialogueEntry) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: brtrue.s IL_0004
IL_0003: ret
IL_0004: ldstr "Preparing line {0}"
IL_0009: ldarg.1
IL_000a: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_currentDialogueText()
IL_000f: call System.String System.String::Format(System.String,System.Object)
IL_0014: call System.Void UnityEngine.Debug::Log(System.Object)
IL_0019: ret
