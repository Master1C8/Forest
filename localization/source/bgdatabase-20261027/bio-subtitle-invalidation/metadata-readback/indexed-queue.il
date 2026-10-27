TYPE UnityEngine.UI.Collections.IndexedSet`1
METHOD System.Boolean UnityEngine.UI.Collections.IndexedSet`1::AddUnique(T) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Collections.Generic.Dictionary`2<T,System.Int32> UnityEngine.UI.Collections.IndexedSet`1<T>::m_Dictionary
IL_0006: ldarg.1
IL_0007: callvirt System.Boolean System.Collections.Generic.Dictionary`2<T,System.Int32>::ContainsKey(!0)
IL_000c: brfalse.s IL_0010
IL_000e: ldc.i4.0
IL_000f: ret
IL_0010: ldarg.0
IL_0011: ldfld System.Collections.Generic.List`1<T> UnityEngine.UI.Collections.IndexedSet`1<T>::m_List
IL_0016: ldarg.1
IL_0017: callvirt System.Void System.Collections.Generic.List`1<T>::Add(!0)
IL_001c: ldarg.0
IL_001d: ldfld System.Collections.Generic.Dictionary`2<T,System.Int32> UnityEngine.UI.Collections.IndexedSet`1<T>::m_Dictionary
IL_0022: ldarg.1
IL_0023: ldarg.0
IL_0024: ldfld System.Collections.Generic.List`1<T> UnityEngine.UI.Collections.IndexedSet`1<T>::m_List
IL_0029: callvirt System.Int32 System.Collections.Generic.List`1<T>::get_Count()
IL_002e: ldc.i4.1
IL_002f: sub
IL_0030: callvirt System.Void System.Collections.Generic.Dictionary`2<T,System.Int32>::Add(!0,!1)
IL_0035: ldc.i4.1
IL_0036: ret
