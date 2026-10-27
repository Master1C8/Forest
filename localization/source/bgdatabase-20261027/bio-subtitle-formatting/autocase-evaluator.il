TYPE PixelCrushers.DialogueSystem.FormattedText/<>c__DisplayClass60_0
METHOD System.String PixelCrushers.DialogueSystem.FormattedText/<>c__DisplayClass60_0::<ReplaceAutocaseTags>b__0(System.Text.RegularExpressions.Match) | attributes=Assembly, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: callvirt System.String System.Text.RegularExpressions.Capture::get_Value()
IL_0006: ldc.i4.s 10
IL_0008: ldarg.1
IL_0009: callvirt System.String System.Text.RegularExpressions.Capture::get_Value()
IL_000e: callvirt System.Int32 System.String::get_Length()
IL_0013: ldc.i4.s 11
IL_0015: sub
IL_0016: callvirt System.String System.String::Substring(System.Int32,System.Int32)
IL_001b: callvirt System.String System.String::Trim()
IL_0020: stloc.0
IL_0021: ldloc.0
IL_0022: call PixelCrushers.DialogueSystem.Lua/Result PixelCrushers.DialogueSystem.DialogueLua::GetVariable(System.String)
IL_0027: stloc.2
IL_0028: ldloca.s V_2
IL_002a: call System.String PixelCrushers.DialogueSystem.Lua/Result::get_asString()
IL_002f: stloc.1
IL_0030: ldloc.1
IL_0031: callvirt System.Int32 System.String::get_Length()
IL_0036: ldc.i4.0
IL_0037: ble.s IL_0046
IL_0039: ldarg.0
IL_003a: ldfld System.Boolean PixelCrushers.DialogueSystem.FormattedText/<>c__DisplayClass60_0::capitalize
IL_003f: ldloc.1
IL_0040: call System.String PixelCrushers.DialogueSystem.FormattedText::SetCapitalization(System.Boolean,System.String)
IL_0045: stloc.1
IL_0046: ldloc.1
IL_0047: stloc.3
IL_0048: leave.s IL_007b
IL_004a: pop
IL_004b: call System.Boolean PixelCrushers.DialogueSystem.DialogueDebug::get_logWarnings()
IL_0050: brfalse.s IL_0073
IL_0052: ldstr "{0}: Failed to get variable: '{1}'"
IL_0057: ldc.i4.2
IL_0058: newarr System.Object
IL_005d: dup
IL_005e: ldc.i4.0
IL_005f: ldstr "Dialogue System"
IL_0064: stelem.ref
IL_0065: dup
IL_0066: ldc.i4.1
IL_0067: ldloc.0
IL_0068: stelem.ref
IL_0069: call System.String System.String::Format(System.String,System.Object[])
IL_006e: call System.Void UnityEngine.Debug::LogWarning(System.Object)
IL_0073: ldsfld System.String System.String::Empty
IL_0078: stloc.3
IL_0079: leave.s IL_007b
IL_007b: ldloc.3
IL_007c: ret
