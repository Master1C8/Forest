TYPE PixelCrushers.DialogueSystem.FormattedText/<>c__DisplayClass65_0
METHOD System.String PixelCrushers.DialogueSystem.FormattedText/<>c__DisplayClass65_0::<ExtractVariableInputPrompt>b__0(System.Text.RegularExpressions.Match) | attributes=Assembly, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: callvirt System.String System.Text.RegularExpressions.Capture::get_Value()
IL_0007: ldc.i4.6
IL_0008: ldarg.1
IL_0009: callvirt System.String System.Text.RegularExpressions.Capture::get_Value()
IL_000e: callvirt System.Int32 System.String::get_Length()
IL_0013: ldc.i4.7
IL_0014: sub
IL_0015: callvirt System.String System.String::Substring(System.Int32,System.Int32)
IL_001a: callvirt System.String System.String::Trim()
IL_001f: stfld System.String PixelCrushers.DialogueSystem.FormattedText/<>c__DisplayClass65_0::varName
IL_0024: ldsfld System.String System.String::Empty
IL_0029: ret
