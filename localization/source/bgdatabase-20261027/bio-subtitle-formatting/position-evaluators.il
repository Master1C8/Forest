TYPE PixelCrushers.DialogueSystem.FormattedText/<>c__DisplayClass67_0
METHOD System.String PixelCrushers.DialogueSystem.FormattedText/<>c__DisplayClass67_0::<ExtractPositionTag>b__0(System.Text.RegularExpressions.Match) | attributes=Assembly, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: callvirt System.String System.Text.RegularExpressions.Capture::get_Value()
IL_0006: ldc.i4.s 10
IL_0008: ldarg.1
IL_0009: callvirt System.String System.Text.RegularExpressions.Capture::get_Value()
IL_000e: callvirt System.Int32 System.String::get_Length()
IL_0013: ldc.i4.s 11
IL_0015: sub
IL_0016: callvirt System.String System.String::Substring(System.Int32,System.Int32)
IL_001b: ldarg.0
IL_001c: ldflda System.Int32 PixelCrushers.DialogueSystem.FormattedText/<>c__DisplayClass67_0::position
IL_0021: call System.Boolean System.Int32::TryParse(System.String,System.Int32&)
IL_0026: pop
IL_0027: ldsfld System.String System.String::Empty
IL_002c: ret
METHOD System.String PixelCrushers.DialogueSystem.FormattedText/<>c__DisplayClass67_0::<ExtractPositionTag>b__1(System.Text.RegularExpressions.Match) | attributes=Assembly, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: callvirt System.String System.Text.RegularExpressions.Capture::get_Value()
IL_0006: ldc.i4.s 10
IL_0008: ldarg.1
IL_0009: callvirt System.String System.Text.RegularExpressions.Capture::get_Value()
IL_000e: callvirt System.Int32 System.String::get_Length()
IL_0013: ldc.i4.s 11
IL_0015: sub
IL_0016: callvirt System.String System.String::Substring(System.Int32,System.Int32)
IL_001b: ldarg.0
IL_001c: ldflda System.Int32 PixelCrushers.DialogueSystem.FormattedText/<>c__DisplayClass67_0::position
IL_0021: call System.Boolean System.Int32::TryParse(System.String,System.Int32&)
IL_0026: pop
IL_0027: ldsfld System.String System.String::Empty
IL_002c: ret
