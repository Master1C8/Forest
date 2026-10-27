TYPE PixelCrushers.DialogueSystem.Tools
METHOD System.String PixelCrushers.DialogueSystem.Tools::ToWebColor(UnityEngine.Color) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldstr "#{0:x2}{1:x2}{2:x2}{3:x2}"
IL_0005: ldc.i4.4
IL_0006: newarr System.Object
IL_000b: dup
IL_000c: ldc.i4.0
IL_000d: ldc.r4 255
IL_0012: ldarg.0
IL_0013: ldfld System.Single UnityEngine.Color::r
IL_0018: mul
IL_0019: conv.i4
IL_001a: box System.Int32
IL_001f: stelem.ref
IL_0020: dup
IL_0021: ldc.i4.1
IL_0022: ldc.r4 255
IL_0027: ldarg.0
IL_0028: ldfld System.Single UnityEngine.Color::g
IL_002d: mul
IL_002e: conv.i4
IL_002f: box System.Int32
IL_0034: stelem.ref
IL_0035: dup
IL_0036: ldc.i4.2
IL_0037: ldc.r4 255
IL_003c: ldarg.0
IL_003d: ldfld System.Single UnityEngine.Color::b
IL_0042: mul
IL_0043: conv.i4
IL_0044: box System.Int32
IL_0049: stelem.ref
IL_004a: dup
IL_004b: ldc.i4.3
IL_004c: ldc.r4 255
IL_0051: ldarg.0
IL_0052: ldfld System.Single UnityEngine.Color::a
IL_0057: mul
IL_0058: conv.i4
IL_0059: box System.Int32
IL_005e: stelem.ref
IL_005f: call System.String System.String::Format(System.String,System.Object[])
IL_0064: ret
