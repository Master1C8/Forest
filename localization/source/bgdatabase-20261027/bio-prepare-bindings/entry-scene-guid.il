TYPE PixelCrushers.DialogueSystem.DialogueEntry
METHOD System.String PixelCrushers.DialogueSystem.DialogueEntry::get_sceneEventGuid() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Field> PixelCrushers.DialogueSystem.DialogueEntry::fields
IL_0006: ldstr "EventGuid"
IL_000b: call System.String PixelCrushers.DialogueSystem.Field::LookupValue(System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Field>,System.String)
IL_0010: ret
METHOD System.Void PixelCrushers.DialogueSystem.DialogueEntry::set_sceneEventGuid(System.String) | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldstr "EventGuid"
IL_0006: ldarg.1
IL_0007: call System.Void PixelCrushers.DialogueSystem.DialogueEntry::SetTextField(System.String,System.String)
IL_000c: ret
