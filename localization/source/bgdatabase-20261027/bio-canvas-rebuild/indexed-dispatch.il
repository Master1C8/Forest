TYPE UnityEngine.UI.Collections.IndexedSet`1
METHOD System.Void UnityEngine.UI.Collections.IndexedSet`1::Clear() | attributes=Public, Final, Virtual, HideBySig, VtableLayoutMask | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Collections.Generic.List`1<T> UnityEngine.UI.Collections.IndexedSet`1<T>::m_List
IL_0006: callvirt System.Void System.Collections.Generic.List`1<T>::Clear()
IL_000b: ldarg.0
IL_000c: ldfld System.Collections.Generic.Dictionary`2<T,System.Int32> UnityEngine.UI.Collections.IndexedSet`1<T>::m_Dictionary
IL_0011: callvirt System.Void System.Collections.Generic.Dictionary`2<T,System.Int32>::Clear()
IL_0016: ret
METHOD System.Int32 UnityEngine.UI.Collections.IndexedSet`1::get_Count() | attributes=Public, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Collections.Generic.List`1<T> UnityEngine.UI.Collections.IndexedSet`1<T>::m_List
IL_0006: callvirt System.Int32 System.Collections.Generic.List`1<T>::get_Count()
IL_000b: ret
METHOD T UnityEngine.UI.Collections.IndexedSet`1::get_Item(System.Int32) | attributes=Public, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Collections.Generic.List`1<T> UnityEngine.UI.Collections.IndexedSet`1<T>::m_List
IL_0006: ldarg.1
IL_0007: callvirt !0 System.Collections.Generic.List`1<T>::get_Item(System.Int32)
IL_000c: ret
METHOD System.Void UnityEngine.UI.Collections.IndexedSet`1::Sort(System.Comparison`1<T>) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Collections.Generic.List`1<T> UnityEngine.UI.Collections.IndexedSet`1<T>::m_List
IL_0006: ldarg.1
IL_0007: callvirt System.Void System.Collections.Generic.List`1<T>::Sort(System.Comparison`1<!0>)
IL_000c: ldc.i4.0
IL_000d: stloc.0
IL_000e: br.s IL_002e
IL_0010: ldarg.0
IL_0011: ldfld System.Collections.Generic.List`1<T> UnityEngine.UI.Collections.IndexedSet`1<T>::m_List
IL_0016: ldloc.0
IL_0017: callvirt !0 System.Collections.Generic.List`1<T>::get_Item(System.Int32)
IL_001c: stloc.1
IL_001d: ldarg.0
IL_001e: ldfld System.Collections.Generic.Dictionary`2<T,System.Int32> UnityEngine.UI.Collections.IndexedSet`1<T>::m_Dictionary
IL_0023: ldloc.1
IL_0024: ldloc.0
IL_0025: callvirt System.Void System.Collections.Generic.Dictionary`2<T,System.Int32>::set_Item(!0,!1)
IL_002a: ldloc.0
IL_002b: ldc.i4.1
IL_002c: add
IL_002d: stloc.0
IL_002e: ldloc.0
IL_002f: ldarg.0
IL_0030: ldfld System.Collections.Generic.List`1<T> UnityEngine.UI.Collections.IndexedSet`1<T>::m_List
IL_0035: callvirt System.Int32 System.Collections.Generic.List`1<T>::get_Count()
IL_003a: blt.s IL_0010
IL_003c: ret
