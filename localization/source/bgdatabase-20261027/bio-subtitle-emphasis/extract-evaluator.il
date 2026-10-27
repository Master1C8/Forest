TYPE PixelCrushers.DialogueSystem.FormattedText/<>c__DisplayClass70_0
METHOD System.String PixelCrushers.DialogueSystem.FormattedText/<>c__DisplayClass70_0::<ExtractEmphasisTags>b__0(System.Text.RegularExpressions.Match) | attributes=Assembly, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: callvirt System.String System.Text.RegularExpressions.Capture::get_Value()
IL_0006: ldarg.1
IL_0007: callvirt System.String System.Text.RegularExpressions.Capture::get_Value()
IL_000c: callvirt System.Int32 System.String::get_Length()
IL_0011: ldc.i4.2
IL_0012: sub
IL_0013: ldc.i4.1
IL_0014: callvirt System.String System.String::Substring(System.Int32,System.Int32)
IL_0019: ldc.i4.1
IL_001a: stloc.0
IL_001b: ldloca.s V_0
IL_001d: call System.Boolean System.Int32::TryParse(System.String,System.Int32&)
IL_0022: pop
IL_0023: ldloc.0
IL_0024: ldc.i4.1
IL_0025: sub
IL_0026: stloc.0
IL_0027: ldarg.0
IL_0028: ldfld PixelCrushers.DialogueSystem.EmphasisSetting[] PixelCrushers.DialogueSystem.FormattedText/<>c__DisplayClass70_0::emphasisSettings
IL_002d: brfalse.s IL_0096
IL_002f: ldc.i4.0
IL_0030: ldloc.0
IL_0031: bgt.s IL_0096
IL_0033: ldloc.0
IL_0034: ldarg.0
IL_0035: ldfld PixelCrushers.DialogueSystem.EmphasisSetting[] PixelCrushers.DialogueSystem.FormattedText/<>c__DisplayClass70_0::emphasisSettings
IL_003a: ldlen
IL_003b: conv.i4
IL_003c: bge.s IL_0096
IL_003e: ldloca.s V_1
IL_0040: ldc.i4.0
IL_0041: ldc.i4 2147483647
IL_0046: ldarg.0
IL_0047: ldfld PixelCrushers.DialogueSystem.EmphasisSetting[] PixelCrushers.DialogueSystem.FormattedText/<>c__DisplayClass70_0::emphasisSettings
IL_004c: ldloc.0
IL_004d: ldelem.ref
IL_004e: ldfld UnityEngine.Color PixelCrushers.DialogueSystem.EmphasisSetting::color
IL_0053: ldarg.0
IL_0054: ldfld PixelCrushers.DialogueSystem.EmphasisSetting[] PixelCrushers.DialogueSystem.FormattedText/<>c__DisplayClass70_0::emphasisSettings
IL_0059: ldloc.0
IL_005a: ldelem.ref
IL_005b: ldfld System.Boolean PixelCrushers.DialogueSystem.EmphasisSetting::bold
IL_0060: ldarg.0
IL_0061: ldfld PixelCrushers.DialogueSystem.EmphasisSetting[] PixelCrushers.DialogueSystem.FormattedText/<>c__DisplayClass70_0::emphasisSettings
IL_0066: ldloc.0
IL_0067: ldelem.ref
IL_0068: ldfld System.Boolean PixelCrushers.DialogueSystem.EmphasisSetting::italic
IL_006d: ldarg.0
IL_006e: ldfld PixelCrushers.DialogueSystem.EmphasisSetting[] PixelCrushers.DialogueSystem.FormattedText/<>c__DisplayClass70_0::emphasisSettings
IL_0073: ldloc.0
IL_0074: ldelem.ref
IL_0075: ldfld System.Boolean PixelCrushers.DialogueSystem.EmphasisSetting::underline
IL_007a: call System.Void PixelCrushers.DialogueSystem.Emphasis::.ctor(System.Int32,System.Int32,UnityEngine.Color,System.Boolean,System.Boolean,System.Boolean)
IL_007f: ldarg.0
IL_0080: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Emphasis> PixelCrushers.DialogueSystem.FormattedText/<>c__DisplayClass70_0::emphases
IL_0085: callvirt System.Void System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Emphasis>::Clear()
IL_008a: ldarg.0
IL_008b: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Emphasis> PixelCrushers.DialogueSystem.FormattedText/<>c__DisplayClass70_0::emphases
IL_0090: ldloc.1
IL_0091: callvirt System.Void System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Emphasis>::Add(!0)
IL_0096: ldsfld System.String System.String::Empty
IL_009b: ret
