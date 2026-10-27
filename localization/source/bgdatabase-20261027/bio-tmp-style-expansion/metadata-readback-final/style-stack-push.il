TYPE TMPro.TMP_TextProcessingStack`1
METHOD System.Void TMPro.TMP_TextProcessingStack`1::Push(T) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Int32 TMPro.TMP_TextProcessingStack`1<T>::index
IL_0006: ldarg.0
IL_0007: ldfld System.Int32 TMPro.TMP_TextProcessingStack`1<T>::m_Capacity
IL_000c: bne.un.s IL_003c
IL_000e: ldarg.0
IL_000f: ldarg.0
IL_0010: ldfld System.Int32 TMPro.TMP_TextProcessingStack`1<T>::m_Capacity
IL_0015: ldc.i4.2
IL_0016: mul
IL_0017: stfld System.Int32 TMPro.TMP_TextProcessingStack`1<T>::m_Capacity
IL_001c: ldarg.0
IL_001d: ldfld System.Int32 TMPro.TMP_TextProcessingStack`1<T>::m_Capacity
IL_0022: brtrue.s IL_002b
IL_0024: ldarg.0
IL_0025: ldc.i4.4
IL_0026: stfld System.Int32 TMPro.TMP_TextProcessingStack`1<T>::m_Capacity
IL_002b: ldarg.0
IL_002c: ldflda T[] TMPro.TMP_TextProcessingStack`1<T>::itemStack
IL_0031: ldarg.0
IL_0032: ldfld System.Int32 TMPro.TMP_TextProcessingStack`1<T>::m_Capacity
IL_0037: call System.Void System.Array::Resize<T>(!!0[]&,System.Int32)
IL_003c: ldarg.0
IL_003d: ldfld T[] TMPro.TMP_TextProcessingStack`1<T>::itemStack
IL_0042: ldarg.0
IL_0043: ldfld System.Int32 TMPro.TMP_TextProcessingStack`1<T>::index
IL_0048: ldarg.1
IL_0049: stelem.any T
IL_004e: ldarg.0
IL_004f: ldfld System.Int32 TMPro.TMP_TextProcessingStack`1<T>::m_RolloverSize
IL_0054: brtrue.s IL_0073
IL_0056: ldarg.0
IL_0057: ldarg.0
IL_0058: ldfld System.Int32 TMPro.TMP_TextProcessingStack`1<T>::index
IL_005d: ldc.i4.1
IL_005e: add
IL_005f: stfld System.Int32 TMPro.TMP_TextProcessingStack`1<T>::index
IL_0064: ldarg.0
IL_0065: ldarg.0
IL_0066: ldfld System.Int32 TMPro.TMP_TextProcessingStack`1<T>::m_Count
IL_006b: ldc.i4.1
IL_006c: add
IL_006d: stfld System.Int32 TMPro.TMP_TextProcessingStack`1<T>::m_Count
IL_0072: ret
IL_0073: ldarg.0
IL_0074: ldarg.0
IL_0075: ldfld System.Int32 TMPro.TMP_TextProcessingStack`1<T>::index
IL_007a: ldc.i4.1
IL_007b: add
IL_007c: ldarg.0
IL_007d: ldfld System.Int32 TMPro.TMP_TextProcessingStack`1<T>::m_RolloverSize
IL_0082: rem
IL_0083: stfld System.Int32 TMPro.TMP_TextProcessingStack`1<T>::index
IL_0088: ldarg.0
IL_0089: ldarg.0
IL_008a: ldfld System.Int32 TMPro.TMP_TextProcessingStack`1<T>::m_Count
IL_008f: ldarg.0
IL_0090: ldfld System.Int32 TMPro.TMP_TextProcessingStack`1<T>::m_RolloverSize
IL_0095: blt.s IL_009f
IL_0097: ldarg.0
IL_0098: ldfld System.Int32 TMPro.TMP_TextProcessingStack`1<T>::m_RolloverSize
IL_009d: br.s IL_00a7
IL_009f: ldarg.0
IL_00a0: ldfld System.Int32 TMPro.TMP_TextProcessingStack`1<T>::m_Count
IL_00a5: ldc.i4.1
IL_00a6: add
IL_00a7: stfld System.Int32 TMPro.TMP_TextProcessingStack`1<T>::m_Count
IL_00ac: ret
