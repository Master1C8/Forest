TYPE PixelCrushers.DialogueSystem.FormattedText
METHOD PixelCrushers.DialogueSystem.FormattedText PixelCrushers.DialogueSystem.FormattedText::Parse(System.String,PixelCrushers.DialogueSystem.EmphasisSetting[])
IL_0000: ldarg.1
IL_0001: brtrue.s IL_001c
IL_0003: call PixelCrushers.DialogueSystem.DialogueSystemController PixelCrushers.DialogueSystem.DialogueManager::get_instance()
IL_0008: ldnull
IL_0009: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_000e: brfalse.s IL_001c
IL_0010: call PixelCrushers.DialogueSystem.DialogueDatabase PixelCrushers.DialogueSystem.DialogueManager::get_masterDatabase()
IL_0015: ldfld PixelCrushers.DialogueSystem.EmphasisSetting[] PixelCrushers.DialogueSystem.DialogueDatabase::emphasisSettings
IL_001a: starg.s emphasisSettings
IL_001c: ldarg.0
IL_001d: dup
IL_001e: brtrue.s IL_0026
IL_0020: pop
IL_0021: ldsfld System.String System.String::Empty
IL_0026: stloc.0
IL_0027: ldloca.s V_0
IL_0029: call System.Void PixelCrushers.DialogueSystem.FormattedText::ReplaceLuaTags(System.String&)
IL_002e: ldloca.s V_0
IL_0030: call System.String PixelCrushers.DialogueSystem.FormattedText::ExtractVariableInputPrompt(System.String&)
IL_0035: stloc.1
IL_0036: ldloca.s V_0
IL_0038: call System.Void PixelCrushers.DialogueSystem.FormattedText::ReplaceVarTags(System.String&)
IL_003d: ldloca.s V_0
IL_003f: call System.Void PixelCrushers.DialogueSystem.FormattedText::ReplaceAutocaseTags(System.String&)
IL_0044: ldloca.s V_0
IL_0046: call System.Void PixelCrushers.DialogueSystem.FormattedText::ReplacePipes(System.String&)
IL_004b: ldc.i4.0
IL_004c: stloc.2
IL_004d: ldc.i4.0
IL_004e: stloc.3
IL_004f: ldc.i4.0
IL_0050: stloc.s V_4
IL_0052: ldloc.0
IL_0053: ldstr "[pic"
IL_0058: callvirt System.Boolean System.String::Contains(System.String)
IL_005d: brfalse.s IL_0087
IL_005f: ldstr "\[pic=[0-9a-zA-z_]+\]"
IL_0064: ldloca.s V_0
IL_0066: call System.Int32 PixelCrushers.DialogueSystem.FormattedText::ExtractPicTag(System.String,System.String&)
IL_006b: stloc.2
IL_006c: ldstr "\[pica=[0-9a-zA-z_]+\]"
IL_0071: ldloca.s V_0
IL_0073: call System.Int32 PixelCrushers.DialogueSystem.FormattedText::ExtractPicTag(System.String,System.String&)
IL_0078: stloc.3
IL_0079: ldstr "\[picc=[0-9a-zA-z_]+\]"
IL_007e: ldloca.s V_0
IL_0080: call System.Int32 PixelCrushers.DialogueSystem.FormattedText::ExtractPicTag(System.String,System.String&)
IL_0085: stloc.s V_4
IL_0087: ldstr "[a]"
IL_008c: ldloca.s V_0
IL_008e: call System.Boolean PixelCrushers.DialogueSystem.FormattedText::ExtractTag(System.String,System.String&)
IL_0093: stloc.s V_5
IL_0095: ldstr "[f]"
IL_009a: ldloca.s V_0
IL_009c: call System.Boolean PixelCrushers.DialogueSystem.FormattedText::ExtractTag(System.String,System.String&)
IL_00a1: stloc.s V_6
IL_00a3: ldstr "[auto]"
IL_00a8: ldloca.s V_0
IL_00aa: call System.Boolean PixelCrushers.DialogueSystem.FormattedText::ExtractTag(System.String,System.String&)
IL_00af: stloc.s V_7
IL_00b1: ldstr "[nosubtitle]"
IL_00b6: ldloca.s V_0
IL_00b8: call System.Boolean PixelCrushers.DialogueSystem.FormattedText::ExtractTag(System.String,System.String&)
IL_00bd: stloc.s V_8
IL_00bf: ldloca.s V_0
IL_00c1: call System.Int32 PixelCrushers.DialogueSystem.FormattedText::ExtractPositionTag(System.String&)
IL_00c6: stloc.s V_9
IL_00c8: ldloca.s V_0
IL_00ca: call System.Int32 PixelCrushers.DialogueSystem.FormattedText::ExtractPanelNumberTag(System.String&)
IL_00cf: stloc.s V_10
IL_00d1: call PixelCrushers.DialogueSystem.DialogueSystemController PixelCrushers.DialogueSystem.DialogueManager::get_instance()
IL_00d6: ldfld PixelCrushers.DialogueSystem.DisplaySettings PixelCrushers.DialogueSystem.DialogueSystemController::displaySettings
IL_00db: ldfld PixelCrushers.DialogueSystem.DisplaySettings/SubtitleSettings PixelCrushers.DialogueSystem.DisplaySettings::subtitleSettings
IL_00e0: ldfld System.Boolean PixelCrushers.DialogueSystem.DisplaySettings/SubtitleSettings::richTextEmphases
IL_00e5: brtrue.s IL_00f1
IL_00e7: ldloca.s V_0
IL_00e9: ldarg.1
IL_00ea: call PixelCrushers.DialogueSystem.Emphasis[] PixelCrushers.DialogueSystem.FormattedText::ExtractEmphasisTags(System.String&,PixelCrushers.DialogueSystem.EmphasisSetting[])
IL_00ef: br.s IL_00f9
IL_00f1: ldloca.s V_0
IL_00f3: ldarg.1
IL_00f4: call PixelCrushers.DialogueSystem.Emphasis[] PixelCrushers.DialogueSystem.FormattedText::ReplaceEmphasisTagsWithRichText(System.String&,PixelCrushers.DialogueSystem.EmphasisSetting[])
IL_00f9: stloc.s V_11
IL_00fb: ldloc.0
IL_00fc: ldloc.s V_11
IL_00fe: ldloc.s V_5
IL_0100: ldloc.s V_9
IL_0102: ldloc.s V_6
IL_0104: ldloc.s V_7
IL_0106: ldloc.2
IL_0107: ldloc.3
IL_0108: ldloc.s V_4
IL_010a: ldloc.1
IL_010b: ldloc.s V_10
IL_010d: ldloc.s V_8
IL_010f: newobj System.Void PixelCrushers.DialogueSystem.FormattedText::.ctor(System.String,PixelCrushers.DialogueSystem.Emphasis[],System.Boolean,System.Int32,System.Boolean,System.Boolean,System.Int32,System.Int32,System.Int32,System.String,System.Int32,System.Boolean)
IL_0114: ret
METHOD System.Void PixelCrushers.DialogueSystem.FormattedText::ReplaceLuaTags(System.String&)
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
METHOD System.Void PixelCrushers.DialogueSystem.FormattedText::ReplaceVarTags(System.String&)
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
METHOD System.Void PixelCrushers.DialogueSystem.FormattedText::ReplaceAutocaseTags(System.String&)
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
METHOD System.String PixelCrushers.DialogueSystem.FormattedText::ExtractVariableInputPrompt(System.String&)
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
METHOD System.Int32 PixelCrushers.DialogueSystem.FormattedText::ExtractPositionTag(System.String&)
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
METHOD System.Int32 PixelCrushers.DialogueSystem.FormattedText::ExtractPanelNumberTag(System.String&)
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
METHOD System.Int32 PixelCrushers.DialogueSystem.FormattedText::ExtractPicTag(System.String,System.String&)
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
METHOD PixelCrushers.DialogueSystem.Emphasis[] PixelCrushers.DialogueSystem.FormattedText::ExtractEmphasisTags(System.String&,PixelCrushers.DialogueSystem.EmphasisSetting[])
IL_0000: newobj System.Void PixelCrushers.DialogueSystem.FormattedText/<>c__DisplayClass70_0::.ctor()
IL_0005: stloc.0
IL_0006: ldloc.0
IL_0007: ldarg.1
IL_0008: stfld PixelCrushers.DialogueSystem.EmphasisSetting[] PixelCrushers.DialogueSystem.FormattedText/<>c__DisplayClass70_0::emphasisSettings
IL_000d: ldloc.0
IL_000e: newobj System.Void System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Emphasis>::.ctor()
IL_0013: stfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Emphasis> PixelCrushers.DialogueSystem.FormattedText/<>c__DisplayClass70_0::emphases
IL_0018: ldarg.0
IL_0019: ldind.ref
IL_001a: ldstr "[em"
IL_001f: callvirt System.Boolean System.String::Contains(System.String)
IL_0024: brfalse.s IL_0061
IL_0026: ldstr "\[\/?em[1-"
IL_002b: ldloc.0
IL_002c: ldfld PixelCrushers.DialogueSystem.EmphasisSetting[] PixelCrushers.DialogueSystem.FormattedText/<>c__DisplayClass70_0::emphasisSettings
IL_0031: ldlen
IL_0032: conv.i4
IL_0033: stloc.2
IL_0034: ldloca.s V_2
IL_0036: call System.String System.Int32::ToString()
IL_003b: ldstr "]\]"
IL_0040: call System.String System.String::Concat(System.String,System.String,System.String)
IL_0045: newobj System.Void System.Text.RegularExpressions.Regex::.ctor(System.String)
IL_004a: stloc.1
IL_004b: ldarg.0
IL_004c: ldloc.1
IL_004d: ldarg.0
IL_004e: ldind.ref
IL_004f: ldloc.0
IL_0050: ldftn System.String PixelCrushers.DialogueSystem.FormattedText/<>c__DisplayClass70_0::<ExtractEmphasisTags>b__0(System.Text.RegularExpressions.Match)
IL_0056: newobj System.Void System.Text.RegularExpressions.MatchEvaluator::.ctor(System.Object,System.IntPtr)
IL_005b: callvirt System.String System.Text.RegularExpressions.Regex::Replace(System.String,System.Text.RegularExpressions.MatchEvaluator)
IL_0060: stind.ref
IL_0061: ldloc.0
IL_0062: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Emphasis> PixelCrushers.DialogueSystem.FormattedText/<>c__DisplayClass70_0::emphases
IL_0067: callvirt !0[] System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Emphasis>::ToArray()
IL_006c: ret
METHOD PixelCrushers.DialogueSystem.Emphasis[] PixelCrushers.DialogueSystem.FormattedText::ReplaceEmphasisTagsWithRichText(System.String&,PixelCrushers.DialogueSystem.EmphasisSetting[])
IL_0000: ldarg.0
IL_0001: ldind.ref
IL_0002: ldstr "[em"
IL_0007: callvirt System.Boolean System.String::Contains(System.String)
IL_000c: brfalse IL_0114
IL_0011: ldc.i4.0
IL_0012: stloc.0
IL_0013: br IL_010b
IL_0018: ldstr "[em{0}]"
IL_001d: ldc.i4.1
IL_001e: newarr System.Object
IL_0023: dup
IL_0024: ldc.i4.0
IL_0025: ldloc.0
IL_0026: ldc.i4.1
IL_0027: add
IL_0028: box System.Int32
IL_002d: stelem.ref
IL_002e: call System.String System.String::Format(System.String,System.Object[])
IL_0033: stloc.1
IL_0034: ldstr "[/em{0}]"
IL_0039: ldc.i4.1
IL_003a: newarr System.Object
IL_003f: dup
IL_0040: ldc.i4.0
IL_0041: ldloc.0
IL_0042: ldc.i4.1
IL_0043: add
IL_0044: box System.Int32
IL_0049: stelem.ref
IL_004a: call System.String System.String::Format(System.String,System.Object[])
IL_004f: stloc.2
IL_0050: ldarg.0
IL_0051: ldind.ref
IL_0052: ldloc.1
IL_0053: callvirt System.Boolean System.String::Contains(System.String)
IL_0058: brfalse IL_0107
IL_005d: ldstr "{0}{1}<color={2}>"
IL_0062: ldc.i4.3
IL_0063: newarr System.Object
IL_0068: dup
IL_0069: ldc.i4.0
IL_006a: ldarg.1
IL_006b: ldloc.0
IL_006c: ldelem.ref
IL_006d: ldfld System.Boolean PixelCrushers.DialogueSystem.EmphasisSetting::bold
IL_0072: brtrue.s IL_007b
IL_0074: ldsfld System.String System.String::Empty
IL_0079: br.s IL_0080
IL_007b: ldstr "<b>"
IL_0080: stelem.ref
IL_0081: dup
IL_0082: ldc.i4.1
IL_0083: ldarg.1
IL_0084: ldloc.0
IL_0085: ldelem.ref
IL_0086: ldfld System.Boolean PixelCrushers.DialogueSystem.EmphasisSetting::italic
IL_008b: brtrue.s IL_0094
IL_008d: ldsfld System.String System.String::Empty
IL_0092: br.s IL_0099
IL_0094: ldstr "<i>"
IL_0099: stelem.ref
IL_009a: dup
IL_009b: ldc.i4.2
IL_009c: ldarg.1
IL_009d: ldloc.0
IL_009e: ldelem.ref
IL_009f: ldfld UnityEngine.Color PixelCrushers.DialogueSystem.EmphasisSetting::color
IL_00a4: call System.String PixelCrushers.DialogueSystem.Tools::ToWebColor(UnityEngine.Color)
IL_00a9: stelem.ref
IL_00aa: call System.String System.String::Format(System.String,System.Object[])
IL_00af: stloc.3
IL_00b0: ldstr "</color>{0}{1}"
IL_00b5: ldc.i4.2
IL_00b6: newarr System.Object
IL_00bb: dup
IL_00bc: ldc.i4.0
IL_00bd: ldarg.1
IL_00be: ldloc.0
IL_00bf: ldelem.ref
IL_00c0: ldfld System.Boolean PixelCrushers.DialogueSystem.EmphasisSetting::italic
IL_00c5: brtrue.s IL_00ce
IL_00c7: ldsfld System.String System.String::Empty
IL_00cc: br.s IL_00d3
IL_00ce: ldstr "</i>"
IL_00d3: stelem.ref
IL_00d4: dup
IL_00d5: ldc.i4.1
IL_00d6: ldarg.1
IL_00d7: ldloc.0
IL_00d8: ldelem.ref
IL_00d9: ldfld System.Boolean PixelCrushers.DialogueSystem.EmphasisSetting::bold
IL_00de: brtrue.s IL_00e7
IL_00e0: ldsfld System.String System.String::Empty
IL_00e5: br.s IL_00ec
IL_00e7: ldstr "</b>"
IL_00ec: stelem.ref
IL_00ed: call System.String System.String::Format(System.String,System.Object[])
IL_00f2: stloc.s V_4
IL_00f4: ldarg.0
IL_00f5: ldarg.0
IL_00f6: ldind.ref
IL_00f7: ldloc.1
IL_00f8: ldloc.3
IL_00f9: callvirt System.String System.String::Replace(System.String,System.String)
IL_00fe: ldloc.2
IL_00ff: ldloc.s V_4
IL_0101: callvirt System.String System.String::Replace(System.String,System.String)
IL_0106: stind.ref
IL_0107: ldloc.0
IL_0108: ldc.i4.1
IL_0109: add
IL_010a: stloc.0
IL_010b: ldloc.0
IL_010c: ldarg.1
IL_010d: ldlen
IL_010e: conv.i4
IL_010f: blt IL_0018
IL_0114: ldc.i4.0
IL_0115: newarr PixelCrushers.DialogueSystem.Emphasis
IL_011a: ret
