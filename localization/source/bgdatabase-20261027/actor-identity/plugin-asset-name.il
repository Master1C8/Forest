TYPE PixelCrushers.DialogueSystem.Asset
METHOD System.String PixelCrushers.DialogueSystem.Asset::get_Name() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Field> PixelCrushers.DialogueSystem.Asset::fields
IL_0006: ldstr "Name"
IL_000b: call System.String PixelCrushers.DialogueSystem.Field::LookupValue(System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Field>,System.String)
IL_0010: ret
