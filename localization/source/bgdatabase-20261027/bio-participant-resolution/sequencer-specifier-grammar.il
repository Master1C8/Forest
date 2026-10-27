TYPE PixelCrushers.DialogueSystem.SequencerTools
METHOD System.Boolean PixelCrushers.DialogueSystem.SequencerTools::SpecifierSpecifiesTag(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_0006: brtrue.s IL_0015
IL_0008: ldarg.0
IL_0009: ldstr "tag="
IL_000e: ldc.i4.5
IL_000f: callvirt System.Boolean System.String::StartsWith(System.String,System.StringComparison)
IL_0014: ret
IL_0015: ldc.i4.0
IL_0016: ret
METHOD System.String PixelCrushers.DialogueSystem.SequencerTools::GetSpecifiedTag(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldstr "tag="
IL_0006: call System.Int32 System.String::get_Length()
IL_000b: callvirt System.String System.String::Substring(System.Int32)
IL_0010: ret
