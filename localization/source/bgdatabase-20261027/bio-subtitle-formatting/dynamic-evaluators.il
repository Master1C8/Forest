TYPE PixelCrushers.DialogueSystem.FormattedText/<>c
METHOD System.String PixelCrushers.DialogueSystem.FormattedText/<>c::<ReplaceLuaTags>b__58_0(System.Text.RegularExpressions.Match) | attributes=Assembly, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: callvirt System.String System.Text.RegularExpressions.Capture::get_Value()
IL_0006: ldc.i4.5
IL_0007: ldarg.1
IL_0008: callvirt System.String System.Text.RegularExpressions.Capture::get_Value()
IL_000d: callvirt System.Int32 System.String::get_Length()
IL_0012: ldc.i4.7
IL_0013: sub
IL_0014: callvirt System.String System.String::Substring(System.Int32,System.Int32)
IL_0019: callvirt System.String System.String::Trim()
IL_001e: stloc.0
IL_001f: ldloc.0
IL_0020: ldstr "return "
IL_0025: callvirt System.Boolean System.String::StartsWith(System.String)
IL_002a: brtrue.s IL_0038
IL_002c: ldstr "return "
IL_0031: ldloc.0
IL_0032: call System.String System.String::Concat(System.String,System.String)
IL_0037: stloc.0
IL_0038: nop
IL_0039: ldloc.0
IL_003a: call System.Boolean PixelCrushers.DialogueSystem.DialogueDebug::get_logInfo()
IL_003f: call PixelCrushers.DialogueSystem.Lua/Result PixelCrushers.DialogueSystem.Lua::Run(System.String,System.Boolean)
IL_0044: stloc.1
IL_0045: ldloca.s V_1
IL_0047: call System.String PixelCrushers.DialogueSystem.Lua/Result::get_asString()
IL_004c: stloc.2
IL_004d: leave.s IL_0080
IL_004f: pop
IL_0050: call System.Boolean PixelCrushers.DialogueSystem.DialogueDebug::get_logWarnings()
IL_0055: brfalse.s IL_0078
IL_0057: ldstr "{0}: Lua failed: '{1}'"
IL_005c: ldc.i4.2
IL_005d: newarr System.Object
IL_0062: dup
IL_0063: ldc.i4.0
IL_0064: ldstr "Dialogue System"
IL_0069: stelem.ref
IL_006a: dup
IL_006b: ldc.i4.1
IL_006c: ldloc.0
IL_006d: stelem.ref
IL_006e: call System.String System.String::Format(System.String,System.Object[])
IL_0073: call System.Void UnityEngine.Debug::LogWarning(System.Object)
IL_0078: ldsfld System.String System.String::Empty
IL_007d: stloc.2
IL_007e: leave.s IL_0080
IL_0080: ldloc.2
IL_0081: ret
METHOD System.String PixelCrushers.DialogueSystem.FormattedText/<>c::<ReplaceVarTags>b__59_0(System.Text.RegularExpressions.Match) | attributes=Assembly, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: callvirt System.String System.Text.RegularExpressions.Capture::get_Value()
IL_0006: ldc.i4.5
IL_0007: ldarg.1
IL_0008: callvirt System.String System.Text.RegularExpressions.Capture::get_Value()
IL_000d: callvirt System.Int32 System.String::get_Length()
IL_0012: ldc.i4.6
IL_0013: sub
IL_0014: callvirt System.String System.String::Substring(System.Int32,System.Int32)
IL_0019: callvirt System.String System.String::Trim()
IL_001e: stloc.0
IL_001f: ldloc.0
IL_0020: call PixelCrushers.DialogueSystem.Lua/Result PixelCrushers.DialogueSystem.DialogueLua::GetVariable(System.String)
IL_0025: stloc.1
IL_0026: ldloca.s V_1
IL_0028: call System.String PixelCrushers.DialogueSystem.Lua/Result::get_asString()
IL_002d: stloc.2
IL_002e: leave.s IL_0061
IL_0030: pop
IL_0031: call System.Boolean PixelCrushers.DialogueSystem.DialogueDebug::get_logWarnings()
IL_0036: brfalse.s IL_0059
IL_0038: ldstr "{0}: Failed to get variable: '{1}'"
IL_003d: ldc.i4.2
IL_003e: newarr System.Object
IL_0043: dup
IL_0044: ldc.i4.0
IL_0045: ldstr "Dialogue System"
IL_004a: stelem.ref
IL_004b: dup
IL_004c: ldc.i4.1
IL_004d: ldloc.0
IL_004e: stelem.ref
IL_004f: call System.String System.String::Format(System.String,System.Object[])
IL_0054: call System.Void UnityEngine.Debug::LogWarning(System.Object)
IL_0059: ldsfld System.String System.String::Empty
IL_005e: stloc.2
IL_005f: leave.s IL_0061
IL_0061: ldloc.2
IL_0062: ret
