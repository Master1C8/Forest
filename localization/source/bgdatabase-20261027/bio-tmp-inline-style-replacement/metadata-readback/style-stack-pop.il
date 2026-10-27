TYPE TMPro.TMP_TextProcessingStack`1
METHOD T TMPro.TMP_TextProcessingStack`1::Pop() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Int32 TMPro.TMP_TextProcessingStack`1<T>::index
IL_0006: brtrue.s IL_001a
IL_0008: ldarg.0
IL_0009: ldfld System.Int32 TMPro.TMP_TextProcessingStack`1<T>::m_RolloverSize
IL_000e: brtrue.s IL_001a
IL_0010: ldloca.s V_0
IL_0012: initobj T
IL_0018: ldloc.0
IL_0019: ret
IL_001a: ldarg.0
IL_001b: ldfld System.Int32 TMPro.TMP_TextProcessingStack`1<T>::m_RolloverSize
IL_0020: brtrue.s IL_0032
IL_0022: ldarg.0
IL_0023: ldarg.0
IL_0024: ldfld System.Int32 TMPro.TMP_TextProcessingStack`1<T>::index
IL_0029: ldc.i4.1
IL_002a: sub
IL_002b: stfld System.Int32 TMPro.TMP_TextProcessingStack`1<T>::index
IL_0030: br.s IL_006b
IL_0032: ldarg.0
IL_0033: ldarg.0
IL_0034: ldfld System.Int32 TMPro.TMP_TextProcessingStack`1<T>::index
IL_0039: ldc.i4.1
IL_003a: sub
IL_003b: ldarg.0
IL_003c: ldfld System.Int32 TMPro.TMP_TextProcessingStack`1<T>::m_RolloverSize
IL_0041: rem
IL_0042: stfld System.Int32 TMPro.TMP_TextProcessingStack`1<T>::index
IL_0047: ldarg.0
IL_0048: ldarg.0
IL_0049: ldfld System.Int32 TMPro.TMP_TextProcessingStack`1<T>::index
IL_004e: ldc.i4.0
IL_004f: blt.s IL_0059
IL_0051: ldarg.0
IL_0052: ldfld System.Int32 TMPro.TMP_TextProcessingStack`1<T>::index
IL_0057: br.s IL_0066
IL_0059: ldarg.0
IL_005a: ldfld System.Int32 TMPro.TMP_TextProcessingStack`1<T>::index
IL_005f: ldarg.0
IL_0060: ldfld System.Int32 TMPro.TMP_TextProcessingStack`1<T>::m_RolloverSize
IL_0065: add
IL_0066: stfld System.Int32 TMPro.TMP_TextProcessingStack`1<T>::index
IL_006b: ldarg.0
IL_006c: ldfld T[] TMPro.TMP_TextProcessingStack`1<T>::itemStack
IL_0071: ldarg.0
IL_0072: ldfld System.Int32 TMPro.TMP_TextProcessingStack`1<T>::index
IL_0077: ldelem.any T
IL_007c: ldarg.0
IL_007d: ldfld T[] TMPro.TMP_TextProcessingStack`1<T>::itemStack
IL_0082: ldarg.0
IL_0083: ldfld System.Int32 TMPro.TMP_TextProcessingStack`1<T>::index
IL_0088: ldarg.0
IL_0089: ldfld T TMPro.TMP_TextProcessingStack`1<T>::m_DefaultItem
IL_008e: stelem.any T
IL_0093: ldarg.0
IL_0094: ldarg.0
IL_0095: ldfld System.Int32 TMPro.TMP_TextProcessingStack`1<T>::m_Count
IL_009a: ldc.i4.0
IL_009b: bgt.s IL_00a0
IL_009d: ldc.i4.0
IL_009e: br.s IL_00a8
IL_00a0: ldarg.0
IL_00a1: ldfld System.Int32 TMPro.TMP_TextProcessingStack`1<T>::m_Count
IL_00a6: ldc.i4.1
IL_00a7: sub
IL_00a8: stfld System.Int32 TMPro.TMP_TextProcessingStack`1<T>::m_Count
IL_00ad: ret
