TYPE PixelCrushers.DialogueSystem.Field
METHOD System.String PixelCrushers.DialogueSystem.Field::LookupValue(System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Field>,System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: call PixelCrushers.DialogueSystem.Field PixelCrushers.DialogueSystem.Field::Lookup(System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Field>,System.String)
IL_0007: stloc.0
IL_0008: ldloc.0
IL_0009: brfalse.s IL_0012
IL_000b: ldloc.0
IL_000c: ldfld System.String PixelCrushers.DialogueSystem.Field::value
IL_0011: ret
IL_0012: ldnull
IL_0013: ret
