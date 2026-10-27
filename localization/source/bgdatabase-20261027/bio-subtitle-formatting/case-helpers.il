TYPE PixelCrushers.DialogueSystem.FormattedText
METHOD System.Boolean PixelCrushers.DialogueSystem.FormattedText::ShouldCapitalizeNextChar(System.String) | attributes=Private, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_0006: brfalse.s IL_000a
IL_0008: ldc.i4.1
IL_0009: ret
IL_000a: ldarg.0
IL_000b: callvirt System.Int32 System.String::get_Length()
IL_0010: ldc.i4.1
IL_0011: sub
IL_0012: stloc.0
IL_0013: br.s IL_003d
IL_0015: ldarg.0
IL_0016: ldloc.0
IL_0017: callvirt System.Char System.String::get_Chars(System.Int32)
IL_001c: stloc.1
IL_001d: ldloc.1
IL_001e: ldc.i4.s 32
IL_0020: beq.s IL_0039
IL_0022: ldloc.1
IL_0023: ldc.i4.s 10
IL_0025: beq.s IL_0039
IL_0027: ldloc.1
IL_0028: ldc.i4.s 46
IL_002a: beq.s IL_0037
IL_002c: ldloc.1
IL_002d: ldc.i4.s 33
IL_002f: beq.s IL_0037
IL_0031: ldloc.1
IL_0032: ldc.i4.s 63
IL_0034: ceq
IL_0036: ret
IL_0037: ldc.i4.1
IL_0038: ret
IL_0039: ldloc.0
IL_003a: ldc.i4.1
IL_003b: sub
IL_003c: stloc.0
IL_003d: ldloc.0
IL_003e: ldc.i4.0
IL_003f: bge.s IL_0015
IL_0041: ldc.i4.1
IL_0042: ret
METHOD System.String PixelCrushers.DialogueSystem.FormattedText::SetCapitalization(System.Boolean,System.String) | attributes=Private, Static, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_0006: brfalse.s IL_000a
IL_0008: ldarg.1
IL_0009: ret
IL_000a: ldarg.0
IL_000b: brfalse.s IL_0014
IL_000d: ldarg.1
IL_000e: call System.String PixelCrushers.DialogueSystem.FormattedText::FirstLetterToUpper(System.String)
IL_0013: ret
IL_0014: ldarg.1
IL_0015: call System.String PixelCrushers.DialogueSystem.FormattedText::FirstLetterToLower(System.String)
IL_001a: ret
METHOD System.String PixelCrushers.DialogueSystem.FormattedText::FirstLetterToUpper(System.String) | attributes=Private, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_0006: brfalse.s IL_000a
IL_0008: ldarg.0
IL_0009: ret
IL_000a: ldarg.0
IL_000b: callvirt System.Int32 System.String::get_Length()
IL_0010: ldc.i4.1
IL_0011: bne.un.s IL_001a
IL_0013: ldarg.0
IL_0014: callvirt System.String System.String::ToUpper()
IL_0019: ret
IL_001a: ldarg.0
IL_001b: ldc.i4.0
IL_001c: callvirt System.Char System.String::get_Chars(System.Int32)
IL_0021: call System.Char System.Char::ToUpper(System.Char)
IL_0026: stloc.0
IL_0027: ldloca.s V_0
IL_0029: call System.String System.Char::ToString()
IL_002e: ldarg.0
IL_002f: ldc.i4.1
IL_0030: callvirt System.String System.String::Substring(System.Int32)
IL_0035: call System.String System.String::Concat(System.String,System.String)
IL_003a: ret
METHOD System.String PixelCrushers.DialogueSystem.FormattedText::FirstLetterToLower(System.String) | attributes=Private, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_0006: brfalse.s IL_000a
IL_0008: ldarg.0
IL_0009: ret
IL_000a: ldarg.0
IL_000b: callvirt System.Int32 System.String::get_Length()
IL_0010: ldc.i4.1
IL_0011: bne.un.s IL_001a
IL_0013: ldarg.0
IL_0014: callvirt System.String System.String::ToUpper()
IL_0019: ret
IL_001a: ldarg.0
IL_001b: ldc.i4.0
IL_001c: callvirt System.Char System.String::get_Chars(System.Int32)
IL_0021: call System.Char System.Char::ToLower(System.Char)
IL_0026: stloc.0
IL_0027: ldloca.s V_0
IL_0029: call System.String System.Char::ToString()
IL_002e: ldarg.0
IL_002f: ldc.i4.1
IL_0030: callvirt System.String System.String::Substring(System.Int32)
IL_0035: call System.String System.String::Concat(System.String,System.String)
IL_003a: ret
