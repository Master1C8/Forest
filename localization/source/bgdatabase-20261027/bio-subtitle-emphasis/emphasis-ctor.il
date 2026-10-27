TYPE PixelCrushers.DialogueSystem.Emphasis
METHOD System.Int32 PixelCrushers.DialogueSystem.Emphasis::get_startIndex() | attributes=Public, HideBySig, SpecialName | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.IsReadOnlyAttribute
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldarg.0
IL_0001: ldfld System.Int32 PixelCrushers.DialogueSystem.Emphasis::<startIndex>k__BackingField
IL_0006: ret
METHOD System.Void PixelCrushers.DialogueSystem.Emphasis::set_startIndex(System.Int32) | attributes=Public, HideBySig, SpecialName | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: stfld System.Int32 PixelCrushers.DialogueSystem.Emphasis::<startIndex>k__BackingField
IL_0007: ret
METHOD System.Int32 PixelCrushers.DialogueSystem.Emphasis::get_length() | attributes=Public, HideBySig, SpecialName | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.IsReadOnlyAttribute
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldarg.0
IL_0001: ldfld System.Int32 PixelCrushers.DialogueSystem.Emphasis::<length>k__BackingField
IL_0006: ret
METHOD System.Void PixelCrushers.DialogueSystem.Emphasis::set_length(System.Int32) | attributes=Public, HideBySig, SpecialName | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: stfld System.Int32 PixelCrushers.DialogueSystem.Emphasis::<length>k__BackingField
IL_0007: ret
METHOD UnityEngine.Color PixelCrushers.DialogueSystem.Emphasis::get_color() | attributes=Public, HideBySig, SpecialName | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.IsReadOnlyAttribute
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldarg.0
IL_0001: ldfld UnityEngine.Color PixelCrushers.DialogueSystem.Emphasis::<color>k__BackingField
IL_0006: ret
METHOD System.Void PixelCrushers.DialogueSystem.Emphasis::set_color(UnityEngine.Color) | attributes=Public, HideBySig, SpecialName | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: stfld UnityEngine.Color PixelCrushers.DialogueSystem.Emphasis::<color>k__BackingField
IL_0007: ret
METHOD System.Boolean PixelCrushers.DialogueSystem.Emphasis::get_bold() | attributes=Public, HideBySig, SpecialName | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.IsReadOnlyAttribute
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldarg.0
IL_0001: ldfld System.Boolean PixelCrushers.DialogueSystem.Emphasis::<bold>k__BackingField
IL_0006: ret
METHOD System.Void PixelCrushers.DialogueSystem.Emphasis::set_bold(System.Boolean) | attributes=Public, HideBySig, SpecialName | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: stfld System.Boolean PixelCrushers.DialogueSystem.Emphasis::<bold>k__BackingField
IL_0007: ret
METHOD System.Boolean PixelCrushers.DialogueSystem.Emphasis::get_italic() | attributes=Public, HideBySig, SpecialName | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.IsReadOnlyAttribute
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldarg.0
IL_0001: ldfld System.Boolean PixelCrushers.DialogueSystem.Emphasis::<italic>k__BackingField
IL_0006: ret
METHOD System.Void PixelCrushers.DialogueSystem.Emphasis::set_italic(System.Boolean) | attributes=Public, HideBySig, SpecialName | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: stfld System.Boolean PixelCrushers.DialogueSystem.Emphasis::<italic>k__BackingField
IL_0007: ret
METHOD System.Boolean PixelCrushers.DialogueSystem.Emphasis::get_underline() | attributes=Public, HideBySig, SpecialName | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.IsReadOnlyAttribute
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldarg.0
IL_0001: ldfld System.Boolean PixelCrushers.DialogueSystem.Emphasis::<underline>k__BackingField
IL_0006: ret
METHOD System.Void PixelCrushers.DialogueSystem.Emphasis::set_underline(System.Boolean) | attributes=Public, HideBySig, SpecialName | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: stfld System.Boolean PixelCrushers.DialogueSystem.Emphasis::<underline>k__BackingField
IL_0007: ret
METHOD System.Void PixelCrushers.DialogueSystem.Emphasis::.ctor(System.Int32,System.Int32,UnityEngine.Color,System.Boolean,System.Boolean,System.Boolean) | attributes=Public, HideBySig, SpecialName, RTSpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: initobj PixelCrushers.DialogueSystem.Emphasis
IL_0007: ldarg.0
IL_0008: ldarg.1
IL_0009: call System.Void PixelCrushers.DialogueSystem.Emphasis::set_startIndex(System.Int32)
IL_000e: ldarg.0
IL_000f: ldarg.2
IL_0010: call System.Void PixelCrushers.DialogueSystem.Emphasis::set_length(System.Int32)
IL_0015: ldarg.0
IL_0016: ldarg.3
IL_0017: call System.Void PixelCrushers.DialogueSystem.Emphasis::set_color(UnityEngine.Color)
IL_001c: ldarg.0
IL_001d: ldarg.s bold
IL_001f: call System.Void PixelCrushers.DialogueSystem.Emphasis::set_bold(System.Boolean)
IL_0024: ldarg.0
IL_0025: ldarg.s italic
IL_0027: call System.Void PixelCrushers.DialogueSystem.Emphasis::set_italic(System.Boolean)
IL_002c: ldarg.0
IL_002d: ldarg.s underline
IL_002f: call System.Void PixelCrushers.DialogueSystem.Emphasis::set_underline(System.Boolean)
IL_0034: ret
