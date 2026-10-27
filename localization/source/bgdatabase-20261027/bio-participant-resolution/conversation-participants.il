TYPE PixelCrushers.DialogueSystem.Conversation
METHOD System.Int32 PixelCrushers.DialogueSystem.Conversation::get_ActorID() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldstr "Actor"
IL_0006: call System.Int32 PixelCrushers.DialogueSystem.Asset::LookupInt(System.String)
IL_000b: ret
METHOD System.Int32 PixelCrushers.DialogueSystem.Conversation::get_ConversantID() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldstr "Conversant"
IL_0006: call System.Int32 PixelCrushers.DialogueSystem.Asset::LookupInt(System.String)
IL_000b: ret
