TYPE UnityEngine.UI.Collections.IndexedSet`1
METHOD System.Void UnityEngine.UI.Collections.IndexedSet`1::RemoveAt(System.Int32) | attributes=Public, Final, Virtual, HideBySig, VtableLayoutMask | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Collections.Generic.List`1<T> UnityEngine.UI.Collections.IndexedSet`1<T>::m_List
IL_0006: ldarg.1
IL_0007: callvirt !0 System.Collections.Generic.List`1<T>::get_Item(System.Int32)
IL_000c: stloc.0
IL_000d: ldarg.0
IL_000e: ldfld System.Collections.Generic.Dictionary`2<T,System.Int32> UnityEngine.UI.Collections.IndexedSet`1<T>::m_Dictionary
IL_0013: ldloc.0
IL_0014: callvirt System.Boolean System.Collections.Generic.Dictionary`2<T,System.Int32>::Remove(!0)
IL_0019: pop
IL_001a: ldarg.1
IL_001b: ldarg.0
IL_001c: ldfld System.Collections.Generic.List`1<T> UnityEngine.UI.Collections.IndexedSet`1<T>::m_List
IL_0021: callvirt System.Int32 System.Collections.Generic.List`1<T>::get_Count()
IL_0026: ldc.i4.1
IL_0027: sub
IL_0028: bne.un.s IL_0037
IL_002a: ldarg.0
IL_002b: ldfld System.Collections.Generic.List`1<T> UnityEngine.UI.Collections.IndexedSet`1<T>::m_List
IL_0030: ldarg.1
IL_0031: callvirt System.Void System.Collections.Generic.List`1<T>::RemoveAt(System.Int32)
IL_0036: ret
IL_0037: ldarg.0
IL_0038: ldfld System.Collections.Generic.List`1<T> UnityEngine.UI.Collections.IndexedSet`1<T>::m_List
IL_003d: callvirt System.Int32 System.Collections.Generic.List`1<T>::get_Count()
IL_0042: ldc.i4.1
IL_0043: sub
IL_0044: stloc.1
IL_0045: ldarg.0
IL_0046: ldfld System.Collections.Generic.List`1<T> UnityEngine.UI.Collections.IndexedSet`1<T>::m_List
IL_004b: ldloc.1
IL_004c: callvirt !0 System.Collections.Generic.List`1<T>::get_Item(System.Int32)
IL_0051: stloc.2
IL_0052: ldarg.0
IL_0053: ldfld System.Collections.Generic.List`1<T> UnityEngine.UI.Collections.IndexedSet`1<T>::m_List
IL_0058: ldarg.1
IL_0059: ldloc.2
IL_005a: callvirt System.Void System.Collections.Generic.List`1<T>::set_Item(System.Int32,!0)
IL_005f: ldarg.0
IL_0060: ldfld System.Collections.Generic.Dictionary`2<T,System.Int32> UnityEngine.UI.Collections.IndexedSet`1<T>::m_Dictionary
IL_0065: ldloc.2
IL_0066: ldarg.1
IL_0067: callvirt System.Void System.Collections.Generic.Dictionary`2<T,System.Int32>::set_Item(!0,!1)
IL_006c: ldarg.0
IL_006d: ldfld System.Collections.Generic.List`1<T> UnityEngine.UI.Collections.IndexedSet`1<T>::m_List
IL_0072: ldloc.1
IL_0073: callvirt System.Void System.Collections.Generic.List`1<T>::RemoveAt(System.Int32)
IL_0078: ret
