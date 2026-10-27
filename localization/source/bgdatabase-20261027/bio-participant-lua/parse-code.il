TYPE PixelCrushers.DialogueSystem.FormattedText
METHOD System.String PixelCrushers.DialogueSystem.FormattedText::ParseCode(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: dup
IL_0002: brtrue.s IL_000a
IL_0004: pop
IL_0005: ldsfld System.String System.String::Empty
IL_000a: stloc.0
IL_000b: ldloc.0
IL_000c: ldstr "["
IL_0011: callvirt System.Boolean System.String::Contains(System.String)
IL_0016: brfalse.s IL_0026
IL_0018: ldloca.s V_0
IL_001a: call System.Void PixelCrushers.DialogueSystem.FormattedText::ReplaceLuaTags(System.String&)
IL_001f: ldloca.s V_0
IL_0021: call System.Void PixelCrushers.DialogueSystem.FormattedText::ReplaceVarTags(System.String&)
IL_0026: ldloc.0
IL_0027: ret
