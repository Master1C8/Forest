TYPE PixelCrushers.DialogueSystem.Field
METHOD System.Int32 PixelCrushers.DialogueSystem.Field::LookupInt(System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Field>,System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: call System.String PixelCrushers.DialogueSystem.Field::LookupValue(System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Field>,System.String)
IL_0007: call System.Int32 PixelCrushers.DialogueSystem.Tools::StringToInt(System.String)
IL_000c: ret
