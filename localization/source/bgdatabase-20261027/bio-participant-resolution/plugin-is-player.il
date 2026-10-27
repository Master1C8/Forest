TYPE PixelCrushers.DialogueSystem.Actor
METHOD System.Boolean PixelCrushers.DialogueSystem.Actor::get_IsPlayer() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldstr "IsPlayer"
IL_0006: call System.Boolean PixelCrushers.DialogueSystem.Asset::LookupBool(System.String)
IL_000b: ret
