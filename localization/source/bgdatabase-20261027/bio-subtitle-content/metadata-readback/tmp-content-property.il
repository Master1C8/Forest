TYPE TMPro.TMP_Text
METHOD System.String TMPro.TMP_Text::get_text() | attributes=Public, Virtual, HideBySig, VtableLayoutMask, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Boolean TMPro.TMP_Text::m_IsTextBackingStringDirty
IL_0006: brfalse.s IL_000f
IL_0008: ldarg.0
IL_0009: call System.String TMPro.TMP_Text::InternalTextBackingArrayToString()
IL_000e: ret
IL_000f: ldarg.0
IL_0010: ldfld System.String TMPro.TMP_Text::m_text
IL_0015: ret
METHOD System.Void TMPro.TMP_Text::set_text(System.String) | attributes=Public, Virtual, HideBySig, VtableLayoutMask, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Boolean TMPro.TMP_Text::m_IsTextBackingStringDirty
IL_0006: brtrue.s IL_0035
IL_0008: ldarg.0
IL_0009: ldfld System.String TMPro.TMP_Text::m_text
IL_000e: brfalse.s IL_0035
IL_0010: ldarg.1
IL_0011: brfalse.s IL_0035
IL_0013: ldarg.0
IL_0014: ldfld System.String TMPro.TMP_Text::m_text
IL_0019: callvirt System.Int32 System.String::get_Length()
IL_001e: ldarg.1
IL_001f: callvirt System.Int32 System.String::get_Length()
IL_0024: bne.un.s IL_0035
IL_0026: ldarg.0
IL_0027: ldfld System.String TMPro.TMP_Text::m_text
IL_002c: ldarg.1
IL_002d: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0032: brfalse.s IL_0035
IL_0034: ret
IL_0035: ldarg.0
IL_0036: ldc.i4.0
IL_0037: stfld System.Boolean TMPro.TMP_Text::m_IsTextBackingStringDirty
IL_003c: ldarg.0
IL_003d: ldarg.1
IL_003e: stfld System.String TMPro.TMP_Text::m_text
IL_0043: ldarg.0
IL_0044: ldc.i4.3
IL_0045: stfld TMPro.TMP_Text/TextInputSources TMPro.TMP_Text::m_inputSource
IL_004a: ldarg.0
IL_004b: ldc.i4.1
IL_004c: stfld System.Boolean TMPro.TMP_Text::m_havePropertiesChanged
IL_0051: ldarg.0
IL_0052: callvirt System.Void UnityEngine.UI.Graphic::SetVerticesDirty()
IL_0057: ldarg.0
IL_0058: callvirt System.Void UnityEngine.UI.Graphic::SetLayoutDirty()
IL_005d: ret
