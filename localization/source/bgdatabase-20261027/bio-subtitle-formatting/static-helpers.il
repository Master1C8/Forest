TYPE PixelCrushers.DialogueSystem.FormattedText
METHOD System.Void PixelCrushers.DialogueSystem.FormattedText::ReplacePipes(System.String&) | attributes=Private, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldind.ref
IL_0002: ldstr "|"
IL_0007: callvirt System.Boolean System.String::Contains(System.String)
IL_000c: brfalse.s IL_0021
IL_000e: ldarg.0
IL_000f: ldarg.0
IL_0010: ldind.ref
IL_0011: ldstr "|"
IL_0016: ldstr "
"
IL_001b: callvirt System.String System.String::Replace(System.String,System.String)
IL_0020: stind.ref
IL_0021: ret
METHOD System.Void PixelCrushers.DialogueSystem.FormattedText::ReplaceAutocaseTags(System.String&) | attributes=Private, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldind.ref
IL_0002: ldstr "[autocase="
IL_0007: callvirt System.Boolean System.String::Contains(System.String)
IL_000c: brfalse IL_009a
IL_0011: ldstr "\[autocase=[^\]]*\]"
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
IL_0028: br.s IL_0091
IL_002a: ldloc.2
IL_002b: ldc.i4.1
IL_002c: add
IL_002d: stloc.2
IL_002e: ldarg.0
IL_002f: ldind.ref
IL_0030: ldstr "[autocase="
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
IL_0043: blt.s IL_0091
IL_0045: newobj System.Void PixelCrushers.DialogueSystem.FormattedText/<>c__DisplayClass60_0::.ctor()
IL_004a: stloc.s V_4
IL_004c: ldarg.0
IL_004d: ldind.ref
IL_004e: ldc.i4.0
IL_004f: ldloc.3
IL_0050: callvirt System.String System.String::Substring(System.Int32,System.Int32)
IL_0055: stloc.s V_5
IL_0057: ldloc.s V_4
IL_0059: ldloc.s V_5
IL_005b: call System.Boolean PixelCrushers.DialogueSystem.FormattedText::ShouldCapitalizeNextChar(System.String)
IL_0060: stfld System.Boolean PixelCrushers.DialogueSystem.FormattedText/<>c__DisplayClass60_0::capitalize
IL_0065: ldarg.0
IL_0066: ldind.ref
IL_0067: ldloc.3
IL_0068: callvirt System.String System.String::Substring(System.Int32)
IL_006d: stloc.s V_6
IL_006f: ldloc.0
IL_0070: ldloc.s V_6
IL_0072: ldloc.s V_4
IL_0074: ldftn System.String PixelCrushers.DialogueSystem.FormattedText/<>c__DisplayClass60_0::<ReplaceAutocaseTags>b__0(System.Text.RegularExpressions.Match)
IL_007a: newobj System.Void System.Text.RegularExpressions.MatchEvaluator::.ctor(System.Object,System.IntPtr)
IL_007f: callvirt System.String System.Text.RegularExpressions.Regex::Replace(System.String,System.Text.RegularExpressions.MatchEvaluator)
IL_0084: stloc.s V_7
IL_0086: ldarg.0
IL_0087: ldloc.s V_5
IL_0089: ldloc.s V_7
IL_008b: call System.String System.String::Concat(System.String,System.String)
IL_0090: stind.ref
IL_0091: ldloc.1
IL_0092: ldc.i4.0
IL_0093: blt.s IL_009a
IL_0095: ldloc.2
IL_0096: ldc.i4.s 100
IL_0098: blt.s IL_002a
IL_009a: ret
METHOD System.Boolean PixelCrushers.DialogueSystem.FormattedText::ExtractTag(System.String,System.String&) | attributes=Private, Static, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: ldind.ref
IL_0002: ldarg.0
IL_0003: callvirt System.Boolean System.String::Contains(System.String)
IL_0008: dup
IL_0009: brfalse.s IL_001a
IL_000b: ldarg.1
IL_000c: ldarg.1
IL_000d: ldind.ref
IL_000e: ldarg.0
IL_000f: ldsfld System.String System.String::Empty
IL_0014: callvirt System.String System.String::Replace(System.String,System.String)
IL_0019: stind.ref
IL_001a: ret
