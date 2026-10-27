TYPE PixelCrushers.DialogueSystem.FormattedText
METHOD System.Void PixelCrushers.DialogueSystem.FormattedText::ReplaceLuaTags(System.String&) | attributes=Private, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldind.ref
IL_0002: ldstr "[lua("
IL_0007: callvirt System.Boolean System.String::Contains(System.String)
IL_000c: brfalse IL_0097
IL_0011: ldstr "\[lua\((?!lua).*\)\]"
IL_0016: newobj System.Void System.Text.RegularExpressions.Regex::.ctor(System.String)
IL_001b: stloc.0
IL_001c: ldarg.0
IL_001d: ldind.ref
IL_001e: callvirt System.Int32 System.String::get_Length()
IL_0023: ldc.i4.1
IL_0024: sub
IL_0025: stloc.1
IL_0026: ldc.i4.0
IL_0027: stloc.2
IL_0028: br.s IL_008e
IL_002a: ldloc.2
IL_002b: ldc.i4.1
IL_002c: add
IL_002d: stloc.2
IL_002e: ldarg.0
IL_002f: ldind.ref
IL_0030: ldstr "[lua("
IL_0035: ldloc.1
IL_0036: ldc.i4.5
IL_0037: callvirt System.Int32 System.String::LastIndexOf(System.String,System.Int32,System.StringComparison)
IL_003c: stloc.3
IL_003d: ldloc.3
IL_003e: ldc.i4.1
IL_003f: sub
IL_0040: stloc.1
IL_0041: ldloc.3
IL_0042: ldc.i4.0
IL_0043: blt.s IL_008e
IL_0045: ldarg.0
IL_0046: ldind.ref
IL_0047: ldc.i4.0
IL_0048: ldloc.3
IL_0049: callvirt System.String System.String::Substring(System.Int32,System.Int32)
IL_004e: stloc.s V_4
IL_0050: ldarg.0
IL_0051: ldind.ref
IL_0052: ldloc.3
IL_0053: callvirt System.String System.String::Substring(System.Int32)
IL_0058: stloc.s V_5
IL_005a: ldloc.0
IL_005b: ldloc.s V_5
IL_005d: ldsfld System.Text.RegularExpressions.MatchEvaluator PixelCrushers.DialogueSystem.FormattedText/<>c::<>9__58_0
IL_0062: dup
IL_0063: brtrue.s IL_007c
IL_0065: pop
IL_0066: ldsfld PixelCrushers.DialogueSystem.FormattedText/<>c PixelCrushers.DialogueSystem.FormattedText/<>c::<>9
IL_006b: ldftn System.String PixelCrushers.DialogueSystem.FormattedText/<>c::<ReplaceLuaTags>b__58_0(System.Text.RegularExpressions.Match)
IL_0071: newobj System.Void System.Text.RegularExpressions.MatchEvaluator::.ctor(System.Object,System.IntPtr)
IL_0076: dup
IL_0077: stsfld System.Text.RegularExpressions.MatchEvaluator PixelCrushers.DialogueSystem.FormattedText/<>c::<>9__58_0
IL_007c: callvirt System.String System.Text.RegularExpressions.Regex::Replace(System.String,System.Text.RegularExpressions.MatchEvaluator)
IL_0081: stloc.s V_6
IL_0083: ldarg.0
IL_0084: ldloc.s V_4
IL_0086: ldloc.s V_6
IL_0088: call System.String System.String::Concat(System.String,System.String)
IL_008d: stind.ref
IL_008e: ldloc.1
IL_008f: ldc.i4.0
IL_0090: blt.s IL_0097
IL_0092: ldloc.2
IL_0093: ldc.i4.s 100
IL_0095: blt.s IL_002a
IL_0097: ret
METHOD System.Void PixelCrushers.DialogueSystem.FormattedText::ReplaceVarTags(System.String&) | attributes=Private, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldind.ref
IL_0002: ldstr "[var="
IL_0007: callvirt System.Boolean System.String::Contains(System.String)
IL_000c: brfalse IL_0097
IL_0011: ldstr "\[var=[^\]]*\]"
IL_0016: newobj System.Void System.Text.RegularExpressions.Regex::.ctor(System.String)
IL_001b: stloc.0
IL_001c: ldarg.0
IL_001d: ldind.ref
IL_001e: callvirt System.Int32 System.String::get_Length()
IL_0023: ldc.i4.1
IL_0024: sub
IL_0025: stloc.1
IL_0026: ldc.i4.0
IL_0027: stloc.2
IL_0028: br.s IL_008e
IL_002a: ldloc.2
IL_002b: ldc.i4.1
IL_002c: add
IL_002d: stloc.2
IL_002e: ldarg.0
IL_002f: ldind.ref
IL_0030: ldstr "[var="
IL_0035: ldloc.1
IL_0036: ldc.i4.5
IL_0037: callvirt System.Int32 System.String::LastIndexOf(System.String,System.Int32,System.StringComparison)
IL_003c: stloc.3
IL_003d: ldloc.3
IL_003e: ldc.i4.1
IL_003f: sub
IL_0040: stloc.1
IL_0041: ldloc.3
IL_0042: ldc.i4.0
IL_0043: blt.s IL_008e
IL_0045: ldarg.0
IL_0046: ldind.ref
IL_0047: ldc.i4.0
IL_0048: ldloc.3
IL_0049: callvirt System.String System.String::Substring(System.Int32,System.Int32)
IL_004e: stloc.s V_4
IL_0050: ldarg.0
IL_0051: ldind.ref
IL_0052: ldloc.3
IL_0053: callvirt System.String System.String::Substring(System.Int32)
IL_0058: stloc.s V_5
IL_005a: ldloc.0
IL_005b: ldloc.s V_5
IL_005d: ldsfld System.Text.RegularExpressions.MatchEvaluator PixelCrushers.DialogueSystem.FormattedText/<>c::<>9__59_0
IL_0062: dup
IL_0063: brtrue.s IL_007c
IL_0065: pop
IL_0066: ldsfld PixelCrushers.DialogueSystem.FormattedText/<>c PixelCrushers.DialogueSystem.FormattedText/<>c::<>9
IL_006b: ldftn System.String PixelCrushers.DialogueSystem.FormattedText/<>c::<ReplaceVarTags>b__59_0(System.Text.RegularExpressions.Match)
IL_0071: newobj System.Void System.Text.RegularExpressions.MatchEvaluator::.ctor(System.Object,System.IntPtr)
IL_0076: dup
IL_0077: stsfld System.Text.RegularExpressions.MatchEvaluator PixelCrushers.DialogueSystem.FormattedText/<>c::<>9__59_0
IL_007c: callvirt System.String System.Text.RegularExpressions.Regex::Replace(System.String,System.Text.RegularExpressions.MatchEvaluator)
IL_0081: stloc.s V_6
IL_0083: ldarg.0
IL_0084: ldloc.s V_4
IL_0086: ldloc.s V_6
IL_0088: call System.String System.String::Concat(System.String,System.String)
IL_008d: stind.ref
IL_008e: ldloc.1
IL_008f: ldc.i4.0
IL_0090: blt.s IL_0097
IL_0092: ldloc.2
IL_0093: ldc.i4.s 100
IL_0095: blt.s IL_002a
IL_0097: ret
METHOD System.String PixelCrushers.DialogueSystem.FormattedText::ExtractVariableInputPrompt(System.String&) | attributes=Private, Static, HideBySig | impl=IL
IL_0000: newobj System.Void PixelCrushers.DialogueSystem.FormattedText/<>c__DisplayClass65_0::.ctor()
IL_0005: stloc.0
IL_0006: ldloc.0
IL_0007: ldsfld System.String System.String::Empty
IL_000c: stfld System.String PixelCrushers.DialogueSystem.FormattedText/<>c__DisplayClass65_0::varName
IL_0011: ldarg.0
IL_0012: ldind.ref
IL_0013: ldstr "[var=?"
IL_0018: callvirt System.Boolean System.String::Contains(System.String)
IL_001d: brfalse IL_00af
IL_0022: ldstr "\[var=\?.*\]"
IL_0027: newobj System.Void System.Text.RegularExpressions.Regex::.ctor(System.String)
IL_002c: stloc.1
IL_002d: ldarg.0
IL_002e: ldind.ref
IL_002f: callvirt System.Int32 System.String::get_Length()
IL_0034: ldc.i4.1
IL_0035: sub
IL_0036: stloc.2
IL_0037: ldc.i4.0
IL_0038: stloc.3
IL_0039: br.s IL_00a6
IL_003b: ldloc.3
IL_003c: ldc.i4.1
IL_003d: add
IL_003e: stloc.3
IL_003f: ldarg.0
IL_0040: ldind.ref
IL_0041: ldstr "[var=?"
IL_0046: ldloc.2
IL_0047: ldc.i4.5
IL_0048: callvirt System.Int32 System.String::LastIndexOf(System.String,System.Int32,System.StringComparison)
IL_004d: stloc.s V_4
IL_004f: ldloc.s V_4
IL_0051: ldc.i4.1
IL_0052: sub
IL_0053: stloc.2
IL_0054: ldloc.s V_4
IL_0056: ldc.i4.0
IL_0057: blt.s IL_00a6
IL_0059: ldarg.0
IL_005a: ldind.ref
IL_005b: ldc.i4.0
IL_005c: ldloc.s V_4
IL_005e: callvirt System.String System.String::Substring(System.Int32,System.Int32)
IL_0063: stloc.s V_5
IL_0065: ldarg.0
IL_0066: ldind.ref
IL_0067: ldloc.s V_4
IL_0069: callvirt System.String System.String::Substring(System.Int32)
IL_006e: stloc.s V_6
IL_0070: ldloc.1
IL_0071: ldloc.s V_6
IL_0073: ldloc.0
IL_0074: ldfld System.Text.RegularExpressions.MatchEvaluator PixelCrushers.DialogueSystem.FormattedText/<>c__DisplayClass65_0::<>9__0
IL_0079: dup
IL_007a: brtrue.s IL_0094
IL_007c: pop
IL_007d: ldloc.0
IL_007e: ldloc.0
IL_007f: ldftn System.String PixelCrushers.DialogueSystem.FormattedText/<>c__DisplayClass65_0::<ExtractVariableInputPrompt>b__0(System.Text.RegularExpressions.Match)
IL_0085: newobj System.Void System.Text.RegularExpressions.MatchEvaluator::.ctor(System.Object,System.IntPtr)
IL_008a: dup
IL_008b: stloc.s V_8
IL_008d: stfld System.Text.RegularExpressions.MatchEvaluator PixelCrushers.DialogueSystem.FormattedText/<>c__DisplayClass65_0::<>9__0
IL_0092: ldloc.s V_8
IL_0094: callvirt System.String System.Text.RegularExpressions.Regex::Replace(System.String,System.Text.RegularExpressions.MatchEvaluator)
IL_0099: stloc.s V_7
IL_009b: ldarg.0
IL_009c: ldloc.s V_5
IL_009e: ldloc.s V_7
IL_00a0: call System.String System.String::Concat(System.String,System.String)
IL_00a5: stind.ref
IL_00a6: ldloc.2
IL_00a7: ldc.i4.0
IL_00a8: blt.s IL_00af
IL_00aa: ldloc.3
IL_00ab: ldc.i4.s 100
IL_00ad: blt.s IL_003b
IL_00af: ldloc.0
IL_00b0: ldfld System.String PixelCrushers.DialogueSystem.FormattedText/<>c__DisplayClass65_0::varName
IL_00b5: ret
