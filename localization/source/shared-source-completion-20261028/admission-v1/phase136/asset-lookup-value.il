TYPE PixelCrushers.DialogueSystem.Asset
METHOD System.String PixelCrushers.DialogueSystem.Asset::LookupValue(System.String) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Field> PixelCrushers.DialogueSystem.Asset::fields
IL_0006: ldarg.1
IL_0007: call System.String PixelCrushers.DialogueSystem.Field::LookupValue(System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Field>,System.String)
IL_000c: ret
