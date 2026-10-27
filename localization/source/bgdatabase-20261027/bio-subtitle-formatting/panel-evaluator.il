TYPE PixelCrushers.DialogueSystem.FormattedText/<>c__DisplayClass68_0
METHOD System.String PixelCrushers.DialogueSystem.FormattedText/<>c__DisplayClass68_0::<ExtractPanelNumberTag>b__0(System.Text.RegularExpressions.Match) | attributes=Assembly, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: callvirt System.String System.Text.RegularExpressions.Capture::get_Value()
IL_0006: ldc.i4.7
IL_0007: ldarg.1
IL_0008: callvirt System.String System.Text.RegularExpressions.Capture::get_Value()
IL_000d: callvirt System.Int32 System.String::get_Length()
IL_0012: ldc.i4.8
IL_0013: sub
IL_0014: callvirt System.String System.String::Substring(System.Int32,System.Int32)
IL_0019: ldarg.0
IL_001a: ldflda System.Int32 PixelCrushers.DialogueSystem.FormattedText/<>c__DisplayClass68_0::panelNumber
IL_001f: call System.Boolean System.Int32::TryParse(System.String,System.Int32&)
IL_0024: pop
IL_0025: ldsfld System.String System.String::Empty
IL_002a: ret
