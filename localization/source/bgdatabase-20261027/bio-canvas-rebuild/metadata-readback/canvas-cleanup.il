TYPE UnityEngine.UI.CanvasUpdateRegistry
METHOD System.Boolean UnityEngine.UI.CanvasUpdateRegistry::ObjectValidForUpdate(UnityEngine.UI.ICanvasElement) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: ldnull
IL_0002: cgt.un
IL_0004: stloc.0
IL_0005: ldarg.1
IL_0006: isinst UnityEngine.Object
IL_000b: ldnull
IL_000c: cgt.un
IL_000e: brfalse.s IL_001d
IL_0010: ldarg.1
IL_0011: isinst UnityEngine.Object
IL_0016: ldnull
IL_0017: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_001c: stloc.0
IL_001d: ldloc.0
IL_001e: ret
METHOD System.Void UnityEngine.UI.CanvasUpdateRegistry::CleanInvalidItems() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld UnityEngine.UI.Collections.IndexedSet`1<UnityEngine.UI.ICanvasElement> UnityEngine.UI.CanvasUpdateRegistry::m_LayoutRebuildQueue
IL_0006: callvirt System.Int32 UnityEngine.UI.Collections.IndexedSet`1<UnityEngine.UI.ICanvasElement>::get_Count()
IL_000b: ldc.i4.1
IL_000c: sub
IL_000d: stloc.0
IL_000e: br.s IL_004c
IL_0010: ldarg.0
IL_0011: ldfld UnityEngine.UI.Collections.IndexedSet`1<UnityEngine.UI.ICanvasElement> UnityEngine.UI.CanvasUpdateRegistry::m_LayoutRebuildQueue
IL_0016: ldloc.0
IL_0017: callvirt T UnityEngine.UI.Collections.IndexedSet`1<UnityEngine.UI.ICanvasElement>::get_Item(System.Int32)
IL_001c: stloc.1
IL_001d: ldloc.1
IL_001e: brtrue.s IL_002e
IL_0020: ldarg.0
IL_0021: ldfld UnityEngine.UI.Collections.IndexedSet`1<UnityEngine.UI.ICanvasElement> UnityEngine.UI.CanvasUpdateRegistry::m_LayoutRebuildQueue
IL_0026: ldloc.0
IL_0027: callvirt System.Void UnityEngine.UI.Collections.IndexedSet`1<UnityEngine.UI.ICanvasElement>::RemoveAt(System.Int32)
IL_002c: br.s IL_0048
IL_002e: ldloc.1
IL_002f: callvirt System.Boolean UnityEngine.UI.ICanvasElement::IsDestroyed()
IL_0034: brfalse.s IL_0048
IL_0036: ldarg.0
IL_0037: ldfld UnityEngine.UI.Collections.IndexedSet`1<UnityEngine.UI.ICanvasElement> UnityEngine.UI.CanvasUpdateRegistry::m_LayoutRebuildQueue
IL_003c: ldloc.0
IL_003d: callvirt System.Void UnityEngine.UI.Collections.IndexedSet`1<UnityEngine.UI.ICanvasElement>::RemoveAt(System.Int32)
IL_0042: ldloc.1
IL_0043: callvirt System.Void UnityEngine.UI.ICanvasElement::LayoutComplete()
IL_0048: ldloc.0
IL_0049: ldc.i4.1
IL_004a: sub
IL_004b: stloc.0
IL_004c: ldloc.0
IL_004d: ldc.i4.0
IL_004e: bge.s IL_0010
IL_0050: ldarg.0
IL_0051: ldfld UnityEngine.UI.Collections.IndexedSet`1<UnityEngine.UI.ICanvasElement> UnityEngine.UI.CanvasUpdateRegistry::m_GraphicRebuildQueue
IL_0056: callvirt System.Int32 UnityEngine.UI.Collections.IndexedSet`1<UnityEngine.UI.ICanvasElement>::get_Count()
IL_005b: ldc.i4.1
IL_005c: sub
IL_005d: stloc.2
IL_005e: br.s IL_009c
IL_0060: ldarg.0
IL_0061: ldfld UnityEngine.UI.Collections.IndexedSet`1<UnityEngine.UI.ICanvasElement> UnityEngine.UI.CanvasUpdateRegistry::m_GraphicRebuildQueue
IL_0066: ldloc.2
IL_0067: callvirt T UnityEngine.UI.Collections.IndexedSet`1<UnityEngine.UI.ICanvasElement>::get_Item(System.Int32)
IL_006c: stloc.3
IL_006d: ldloc.3
IL_006e: brtrue.s IL_007e
IL_0070: ldarg.0
IL_0071: ldfld UnityEngine.UI.Collections.IndexedSet`1<UnityEngine.UI.ICanvasElement> UnityEngine.UI.CanvasUpdateRegistry::m_GraphicRebuildQueue
IL_0076: ldloc.2
IL_0077: callvirt System.Void UnityEngine.UI.Collections.IndexedSet`1<UnityEngine.UI.ICanvasElement>::RemoveAt(System.Int32)
IL_007c: br.s IL_0098
IL_007e: ldloc.3
IL_007f: callvirt System.Boolean UnityEngine.UI.ICanvasElement::IsDestroyed()
IL_0084: brfalse.s IL_0098
IL_0086: ldarg.0
IL_0087: ldfld UnityEngine.UI.Collections.IndexedSet`1<UnityEngine.UI.ICanvasElement> UnityEngine.UI.CanvasUpdateRegistry::m_GraphicRebuildQueue
IL_008c: ldloc.2
IL_008d: callvirt System.Void UnityEngine.UI.Collections.IndexedSet`1<UnityEngine.UI.ICanvasElement>::RemoveAt(System.Int32)
IL_0092: ldloc.3
IL_0093: callvirt System.Void UnityEngine.UI.ICanvasElement::GraphicUpdateComplete()
IL_0098: ldloc.2
IL_0099: ldc.i4.1
IL_009a: sub
IL_009b: stloc.2
IL_009c: ldloc.2
IL_009d: ldc.i4.0
IL_009e: bge.s IL_0060
IL_00a0: ret
