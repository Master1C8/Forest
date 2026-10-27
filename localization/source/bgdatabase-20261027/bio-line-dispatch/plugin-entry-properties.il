TYPE PixelCrushers.DialogueSystem.DialogueEntry
METHOD System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::get_ActorID() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Field> PixelCrushers.DialogueSystem.DialogueEntry::fields
IL_0006: ldstr "Actor"
IL_000b: call System.Int32 PixelCrushers.DialogueSystem.Field::LookupInt(System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Field>,System.String)
IL_0010: ret
METHOD System.String PixelCrushers.DialogueSystem.DialogueEntry::get_subtitleText() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: call System.String PixelCrushers.DialogueSystem.DialogueEntry::get_currentDialogueText()
IL_0006: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_000b: brtrue.s IL_0014
IL_000d: ldarg.0
IL_000e: call System.String PixelCrushers.DialogueSystem.DialogueEntry::get_currentDialogueText()
IL_0013: ret
IL_0014: ldarg.0
IL_0015: call System.String PixelCrushers.DialogueSystem.DialogueEntry::get_currentMenuText()
IL_001a: ret
