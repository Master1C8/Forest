TYPE TMPro.TMP_Text
METHOD TMPro.TMP_Style TMPro.TMP_Text::get_textStyle() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.0
IL_0002: ldarg.0
IL_0003: ldfld System.Int32 TMPro.TMP_Text::m_TextStyleHashCode
IL_0008: call TMPro.TMP_Style TMPro.TMP_Text::GetStyle(System.Int32)
IL_000d: stfld TMPro.TMP_Style TMPro.TMP_Text::m_TextStyle
IL_0012: ldarg.0
IL_0013: ldfld TMPro.TMP_Style TMPro.TMP_Text::m_TextStyle
IL_0018: brtrue.s IL_0036
IL_001a: ldarg.0
IL_001b: call TMPro.TMP_Style TMPro.TMP_Style::get_NormalStyle()
IL_0020: stfld TMPro.TMP_Style TMPro.TMP_Text::m_TextStyle
IL_0025: ldarg.0
IL_0026: ldarg.0
IL_0027: ldfld TMPro.TMP_Style TMPro.TMP_Text::m_TextStyle
IL_002c: callvirt System.Int32 TMPro.TMP_Style::get_hashCode()
IL_0031: stfld System.Int32 TMPro.TMP_Text::m_TextStyleHashCode
IL_0036: ldarg.0
IL_0037: ldfld TMPro.TMP_Style TMPro.TMP_Text::m_TextStyle
IL_003c: ret
METHOD System.Void TMPro.TMP_Text::ResizeInternalArray(T[]&) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: ldind.ref
IL_0002: ldlen
IL_0003: conv.i4
IL_0004: ldc.i4.1
IL_0005: add
IL_0006: call System.Int32 UnityEngine.Mathf::NextPowerOfTwo(System.Int32)
IL_000b: stloc.0
IL_000c: ldarg.1
IL_000d: ldloc.0
IL_000e: call System.Void System.Array::Resize<T>(!!0[]&,System.Int32)
IL_0013: ret
METHOD System.Void TMPro.TMP_Text::ResizeInternalArray(T[]&,System.Int32) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.2
IL_0001: ldc.i4.1
IL_0002: add
IL_0003: call System.Int32 UnityEngine.Mathf::NextPowerOfTwo(System.Int32)
IL_0008: starg.s size
IL_000a: ldarg.1
IL_000b: ldarg.2
IL_000c: call System.Void System.Array::Resize<T>(!!0[]&,System.Int32)
IL_0011: ret
