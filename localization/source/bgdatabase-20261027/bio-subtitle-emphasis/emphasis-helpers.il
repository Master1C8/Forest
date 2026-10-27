TYPE PixelCrushers.DialogueSystem.FormattedText
METHOD System.Void PixelCrushers.DialogueSystem.FormattedText::.ctor(System.String,PixelCrushers.DialogueSystem.Emphasis[],System.Boolean,System.Int32,System.Boolean,System.Boolean,System.Int32,System.Int32,System.Int32,System.String,System.Int32,System.Boolean) | attributes=Public, HideBySig, SpecialName, RTSpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void System.Object::.ctor()
IL_0006: ldarg.0
IL_0007: ldarg.1
IL_0008: dup
IL_0009: brtrue.s IL_0011
IL_000b: pop
IL_000c: ldsfld System.String System.String::Empty
IL_0011: call System.Void PixelCrushers.DialogueSystem.FormattedText::set_text(System.String)
IL_0016: ldarg.0
IL_0017: ldarg.2
IL_0018: dup
IL_0019: brtrue.s IL_0021
IL_001b: pop
IL_001c: ldsfld PixelCrushers.DialogueSystem.Emphasis[] PixelCrushers.DialogueSystem.FormattedText::noEmphases
IL_0021: call System.Void PixelCrushers.DialogueSystem.FormattedText::set_emphases(PixelCrushers.DialogueSystem.Emphasis[])
IL_0026: ldarg.0
IL_0027: ldarg.3
IL_0028: call System.Void PixelCrushers.DialogueSystem.FormattedText::set_italic(System.Boolean)
IL_002d: ldarg.0
IL_002e: ldarg.s position
IL_0030: call System.Void PixelCrushers.DialogueSystem.FormattedText::set_position(System.Int32)
IL_0035: ldarg.0
IL_0036: ldarg.s forceMenu
IL_0038: call System.Void PixelCrushers.DialogueSystem.FormattedText::set_forceMenu(System.Boolean)
IL_003d: ldarg.0
IL_003e: ldarg.s forceAuto
IL_0040: call System.Void PixelCrushers.DialogueSystem.FormattedText::set_forceAuto(System.Boolean)
IL_0045: ldarg.0
IL_0046: ldarg.s pic
IL_0048: call System.Void PixelCrushers.DialogueSystem.FormattedText::set_pic(System.Int32)
IL_004d: ldarg.0
IL_004e: ldarg.s picActor
IL_0050: call System.Void PixelCrushers.DialogueSystem.FormattedText::set_picActor(System.Int32)
IL_0055: ldarg.0
IL_0056: ldarg.s picConversant
IL_0058: call System.Void PixelCrushers.DialogueSystem.FormattedText::set_picConversant(System.Int32)
IL_005d: ldarg.0
IL_005e: ldarg.s variableInputPrompt
IL_0060: call System.Void PixelCrushers.DialogueSystem.FormattedText::set_variableInputPrompt(System.String)
IL_0065: ldarg.0
IL_0066: ldarg.s subtitlePanelNumber
IL_0068: call System.Void PixelCrushers.DialogueSystem.FormattedText::set_subtitlePanelNumber(System.Int32)
IL_006d: ldarg.0
IL_006e: ldarg.s noSubtitle
IL_0070: call System.Void PixelCrushers.DialogueSystem.FormattedText::set_noSubtitle(System.Boolean)
IL_0075: ret
METHOD PixelCrushers.DialogueSystem.Emphasis[] PixelCrushers.DialogueSystem.FormattedText::ExtractEmphasisTags(System.String&,PixelCrushers.DialogueSystem.EmphasisSetting[]) | attributes=Private, Static, HideBySig | impl=IL
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
METHOD PixelCrushers.DialogueSystem.Emphasis[] PixelCrushers.DialogueSystem.FormattedText::ReplaceEmphasisTagsWithRichText(System.String&,PixelCrushers.DialogueSystem.EmphasisSetting[]) | attributes=Private, Static, HideBySig | impl=IL
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
