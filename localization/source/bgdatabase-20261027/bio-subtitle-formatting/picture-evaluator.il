TYPE PixelCrushers.DialogueSystem.FormattedText/<>c__DisplayClass69_0
METHOD System.String PixelCrushers.DialogueSystem.FormattedText/<>c__DisplayClass69_0::<ExtractPicTag>b__0(System.Text.RegularExpressions.Match) | attributes=Assembly, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: callvirt System.String System.Text.RegularExpressions.Capture::get_Value()
IL_0006: ldc.i4.s 61
IL_0008: callvirt System.Int32 System.String::IndexOf(System.Char)
IL_000d: ldc.i4.1
IL_000e: add
IL_000f: stloc.0
IL_0010: ldarg.1
IL_0011: callvirt System.String System.Text.RegularExpressions.Capture::get_Value()
IL_0016: ldloc.0
IL_0017: ldarg.1
IL_0018: callvirt System.String System.Text.RegularExpressions.Capture::get_Value()
IL_001d: callvirt System.Int32 System.String::get_Length()
IL_0022: ldloc.0
IL_0023: ldc.i4.1
IL_0024: add
IL_0025: sub
IL_0026: callvirt System.String System.String::Substring(System.Int32,System.Int32)
IL_002b: stloc.1
IL_002c: ldloc.1
IL_002d: ldarg.0
IL_002e: ldflda System.Int32 PixelCrushers.DialogueSystem.FormattedText/<>c__DisplayClass69_0::index
IL_0033: call System.Boolean System.Int32::TryParse(System.String,System.Int32&)
IL_0038: brtrue.s IL_004e
IL_003a: ldarg.0
IL_003b: ldloc.1
IL_003c: call PixelCrushers.DialogueSystem.Lua/Result PixelCrushers.DialogueSystem.DialogueLua::GetVariable(System.String)
IL_0041: stloc.2
IL_0042: ldloca.s V_2
IL_0044: call System.Int32 PixelCrushers.DialogueSystem.Lua/Result::get_asInt()
IL_0049: stfld System.Int32 PixelCrushers.DialogueSystem.FormattedText/<>c__DisplayClass69_0::index
IL_004e: ldsfld System.String System.String::Empty
IL_0053: ret
