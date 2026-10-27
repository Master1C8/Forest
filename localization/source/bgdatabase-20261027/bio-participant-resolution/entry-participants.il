TYPE PixelCrushers.DialogueSystem.DialogueEntry
METHOD System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::get_ActorID() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Field> PixelCrushers.DialogueSystem.DialogueEntry::fields
IL_0006: ldstr "Actor"
IL_000b: call System.Int32 PixelCrushers.DialogueSystem.Field::LookupInt(System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Field>,System.String)
IL_0010: ret
METHOD System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::get_ConversantID() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Field> PixelCrushers.DialogueSystem.DialogueEntry::fields
IL_0006: ldstr "Conversant"
IL_000b: call System.Int32 PixelCrushers.DialogueSystem.Field::LookupInt(System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Field>,System.String)
IL_0010: ret
