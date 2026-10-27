TYPE PixelCrushers.DialogueSystem.FormattedText
METHOD System.Int32 PixelCrushers.DialogueSystem.FormattedText::ExtractPositionTag(System.String&) | attributes=Private, Static, HideBySig | impl=IL
IL_0000: newobj System.Void PixelCrushers.DialogueSystem.FormattedText/<>c__DisplayClass67_0::.ctor()
IL_0005: stloc.0
IL_0006: ldloc.0
IL_0007: ldc.i4.m1
IL_0008: stfld System.Int32 PixelCrushers.DialogueSystem.FormattedText/<>c__DisplayClass67_0::position
IL_000d: ldarg.0
IL_000e: ldind.ref
IL_000f: ldstr "[position "
IL_0014: callvirt System.Boolean System.String::Contains(System.String)
IL_0019: brfalse.s IL_003c
IL_001b: ldstr "\[position\s+[0-9]+\]"
IL_0020: newobj System.Void System.Text.RegularExpressions.Regex::.ctor(System.String)
IL_0025: stloc.1
IL_0026: ldarg.0
IL_0027: ldloc.1
IL_0028: ldarg.0
IL_0029: ldind.ref
IL_002a: ldloc.0
IL_002b: ldftn System.String PixelCrushers.DialogueSystem.FormattedText/<>c__DisplayClass67_0::<ExtractPositionTag>b__0(System.Text.RegularExpressions.Match)
IL_0031: newobj System.Void System.Text.RegularExpressions.MatchEvaluator::.ctor(System.Object,System.IntPtr)
IL_0036: callvirt System.String System.Text.RegularExpressions.Regex::Replace(System.String,System.Text.RegularExpressions.MatchEvaluator)
IL_003b: stind.ref
IL_003c: ldarg.0
IL_003d: ldind.ref
IL_003e: ldstr "[position="
IL_0043: callvirt System.Boolean System.String::Contains(System.String)
IL_0048: brfalse.s IL_006b
IL_004a: ldstr "\[position=[0-9]+\]"
IL_004f: newobj System.Void System.Text.RegularExpressions.Regex::.ctor(System.String)
IL_0054: stloc.2
IL_0055: ldarg.0
IL_0056: ldloc.2
IL_0057: ldarg.0
IL_0058: ldind.ref
IL_0059: ldloc.0
IL_005a: ldftn System.String PixelCrushers.DialogueSystem.FormattedText/<>c__DisplayClass67_0::<ExtractPositionTag>b__1(System.Text.RegularExpressions.Match)
IL_0060: newobj System.Void System.Text.RegularExpressions.MatchEvaluator::.ctor(System.Object,System.IntPtr)
IL_0065: callvirt System.String System.Text.RegularExpressions.Regex::Replace(System.String,System.Text.RegularExpressions.MatchEvaluator)
IL_006a: stind.ref
IL_006b: ldloc.0
IL_006c: ldfld System.Int32 PixelCrushers.DialogueSystem.FormattedText/<>c__DisplayClass67_0::position
IL_0071: ret
METHOD System.Int32 PixelCrushers.DialogueSystem.FormattedText::ExtractPanelNumberTag(System.String&) | attributes=Private, Static, HideBySig | impl=IL
IL_0000: newobj System.Void PixelCrushers.DialogueSystem.FormattedText/<>c__DisplayClass68_0::.ctor()
IL_0005: stloc.0
IL_0006: ldloc.0
IL_0007: ldc.i4.m1
IL_0008: stfld System.Int32 PixelCrushers.DialogueSystem.FormattedText/<>c__DisplayClass68_0::panelNumber
IL_000d: ldarg.0
IL_000e: ldind.ref
IL_000f: ldstr "[panel="
IL_0014: callvirt System.Boolean System.String::Contains(System.String)
IL_0019: brfalse.s IL_003c
IL_001b: ldstr "\[panel=[0-9]+\]"
IL_0020: newobj System.Void System.Text.RegularExpressions.Regex::.ctor(System.String)
IL_0025: stloc.1
IL_0026: ldarg.0
IL_0027: ldloc.1
IL_0028: ldarg.0
IL_0029: ldind.ref
IL_002a: ldloc.0
IL_002b: ldftn System.String PixelCrushers.DialogueSystem.FormattedText/<>c__DisplayClass68_0::<ExtractPanelNumberTag>b__0(System.Text.RegularExpressions.Match)
IL_0031: newobj System.Void System.Text.RegularExpressions.MatchEvaluator::.ctor(System.Object,System.IntPtr)
IL_0036: callvirt System.String System.Text.RegularExpressions.Regex::Replace(System.String,System.Text.RegularExpressions.MatchEvaluator)
IL_003b: stind.ref
IL_003c: ldloc.0
IL_003d: ldfld System.Int32 PixelCrushers.DialogueSystem.FormattedText/<>c__DisplayClass68_0::panelNumber
IL_0042: ret
METHOD System.Int32 PixelCrushers.DialogueSystem.FormattedText::ExtractPicTag(System.String,System.String&) | attributes=Private, Static, HideBySig | impl=IL
IL_0000: newobj System.Void PixelCrushers.DialogueSystem.FormattedText/<>c__DisplayClass69_0::.ctor()
IL_0005: stloc.0
IL_0006: ldloc.0
IL_0007: ldc.i4.0
IL_0008: stfld System.Int32 PixelCrushers.DialogueSystem.FormattedText/<>c__DisplayClass69_0::index
IL_000d: ldarg.0
IL_000e: newobj System.Void System.Text.RegularExpressions.Regex::.ctor(System.String)
IL_0013: stloc.1
IL_0014: ldarg.1
IL_0015: ldloc.1
IL_0016: ldarg.1
IL_0017: ldind.ref
IL_0018: ldloc.0
IL_0019: ldftn System.String PixelCrushers.DialogueSystem.FormattedText/<>c__DisplayClass69_0::<ExtractPicTag>b__0(System.Text.RegularExpressions.Match)
IL_001f: newobj System.Void System.Text.RegularExpressions.MatchEvaluator::.ctor(System.Object,System.IntPtr)
IL_0024: callvirt System.String System.Text.RegularExpressions.Regex::Replace(System.String,System.Text.RegularExpressions.MatchEvaluator)
IL_0029: stind.ref
IL_002a: ldloc.0
IL_002b: ldfld System.Int32 PixelCrushers.DialogueSystem.FormattedText/<>c__DisplayClass69_0::index
IL_0030: ret
METHOD System.Void PixelCrushers.DialogueSystem.FormattedText::.cctor() | attributes=Private, Static, HideBySig, SpecialName, RTSpecialName | impl=IL
IL_0000: ldnull
IL_0001: ldnull
IL_0002: ldc.i4.0
IL_0003: ldc.i4.m1
IL_0004: ldc.i4.1
IL_0005: ldc.i4.0
IL_0006: ldc.i4.0
IL_0007: ldc.i4.0
IL_0008: ldc.i4.0
IL_0009: ldnull
IL_000a: ldc.i4.m1
IL_000b: ldc.i4.0
IL_000c: newobj System.Void PixelCrushers.DialogueSystem.FormattedText::.ctor(System.String,PixelCrushers.DialogueSystem.Emphasis[],System.Boolean,System.Int32,System.Boolean,System.Boolean,System.Int32,System.Int32,System.Int32,System.String,System.Int32,System.Boolean)
IL_0011: stsfld PixelCrushers.DialogueSystem.FormattedText PixelCrushers.DialogueSystem.FormattedText::empty
IL_0016: ldc.i4.0
IL_0017: newarr PixelCrushers.DialogueSystem.Emphasis
IL_001c: stsfld PixelCrushers.DialogueSystem.Emphasis[] PixelCrushers.DialogueSystem.FormattedText::noEmphases
IL_0021: ret
