TYPE PixelCrushers.SafeConvert
METHOD System.Int32 PixelCrushers.SafeConvert::ToInt(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldloca.s V_0
IL_0003: call System.Boolean System.Int32::TryParse(System.String,System.Int32&)
IL_0008: brtrue.s IL_000c
IL_000a: ldc.i4.0
IL_000b: ret
IL_000c: ldloc.0
IL_000d: ret
