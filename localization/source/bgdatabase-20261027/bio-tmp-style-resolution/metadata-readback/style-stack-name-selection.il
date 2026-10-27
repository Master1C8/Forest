TYPE TMPro.TMP_TextProcessingStack`1
METHOD System.Void TMPro.TMP_TextProcessingStack`1::SetDefault(TMPro.TMP_TextProcessingStack`1<T>[],T) | attributes=Assembly, Static, HideBySig | impl=IL
IL_0000: ldc.i4.0
IL_0001: stloc.0
IL_0002: br.s IL_0015
IL_0004: ldarg.0
IL_0005: ldloc.0
IL_0006: ldelema TMPro.TMP_TextProcessingStack`1<T>
IL_000b: ldarg.1
IL_000c: call System.Void TMPro.TMP_TextProcessingStack`1<T>::SetDefault(T)
IL_0011: ldloc.0
IL_0012: ldc.i4.1
IL_0013: add
IL_0014: stloc.0
IL_0015: ldloc.0
IL_0016: ldarg.0
IL_0017: ldlen
IL_0018: conv.i4
IL_0019: blt.s IL_0004
IL_001b: ret
METHOD System.Void TMPro.TMP_TextProcessingStack`1::SetDefault(T) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld T[] TMPro.TMP_TextProcessingStack`1<T>::itemStack
IL_0006: brtrue.s IL_002c
IL_0008: ldarg.0
IL_0009: ldc.i4.4
IL_000a: stfld System.Int32 TMPro.TMP_TextProcessingStack`1<T>::m_Capacity
IL_000f: ldarg.0
IL_0010: ldarg.0
IL_0011: ldfld System.Int32 TMPro.TMP_TextProcessingStack`1<T>::m_Capacity
IL_0016: newarr T
IL_001b: stfld T[] TMPro.TMP_TextProcessingStack`1<T>::itemStack
IL_0020: ldarg.0
IL_0021: ldflda T TMPro.TMP_TextProcessingStack`1<T>::m_DefaultItem
IL_0026: initobj T
IL_002c: ldarg.0
IL_002d: ldfld T[] TMPro.TMP_TextProcessingStack`1<T>::itemStack
IL_0032: ldc.i4.0
IL_0033: ldarg.1
IL_0034: stelem.any T
IL_0039: ldarg.0
IL_003a: ldc.i4.1
IL_003b: stfld System.Int32 TMPro.TMP_TextProcessingStack`1<T>::index
IL_0040: ret
