TYPE UnityEngine.UI.CanvasUpdateRegistry
METHOD System.Void UnityEngine.UI.CanvasUpdateRegistry::PerformUpdate() | attributes=Private, HideBySig | impl=IL
IL_0000: ldc.i4.0
IL_0001: call System.Void UnityEngine.UISystemProfilerApi::BeginSample(UnityEngine.UISystemProfilerApi/SampleType)
IL_0006: ldarg.0
IL_0007: call System.Void UnityEngine.UI.CanvasUpdateRegistry::CleanInvalidItems()
IL_000c: ldarg.0
IL_000d: ldc.i4.1
IL_000e: stfld System.Boolean UnityEngine.UI.CanvasUpdateRegistry::m_PerformingLayoutUpdate
IL_0013: ldarg.0
IL_0014: ldfld UnityEngine.UI.Collections.IndexedSet`1<UnityEngine.UI.ICanvasElement> UnityEngine.UI.CanvasUpdateRegistry::m_LayoutRebuildQueue
IL_0019: ldsfld System.Comparison`1<UnityEngine.UI.ICanvasElement> UnityEngine.UI.CanvasUpdateRegistry::s_SortLayoutFunction
IL_001e: callvirt System.Void UnityEngine.UI.Collections.IndexedSet`1<UnityEngine.UI.ICanvasElement>::Sort(System.Comparison`1<T>)
IL_0023: ldc.i4.0
IL_0024: stloc.0
IL_0025: br.s IL_006d
IL_0027: ldc.i4.0
IL_0028: stloc.1
IL_0029: br.s IL_005b
IL_002b: ldarg.0
IL_002c: ldfld UnityEngine.UI.Collections.IndexedSet`1<UnityEngine.UI.ICanvasElement> UnityEngine.UI.CanvasUpdateRegistry::m_LayoutRebuildQueue
IL_0031: ldloc.1
IL_0032: callvirt T UnityEngine.UI.Collections.IndexedSet`1<UnityEngine.UI.ICanvasElement>::get_Item(System.Int32)
IL_0037: stloc.2
IL_0038: ldarg.0
IL_0039: ldloc.2
IL_003a: call System.Boolean UnityEngine.UI.CanvasUpdateRegistry::ObjectValidForUpdate(UnityEngine.UI.ICanvasElement)
IL_003f: brfalse.s IL_0048
IL_0041: ldloc.2
IL_0042: ldloc.0
IL_0043: callvirt System.Void UnityEngine.UI.ICanvasElement::Rebuild(UnityEngine.UI.CanvasUpdate)
IL_0048: leave.s IL_0057
IL_004a: ldloc.2
IL_004b: callvirt UnityEngine.Transform UnityEngine.UI.ICanvasElement::get_transform()
IL_0050: call System.Void UnityEngine.Debug::LogException(System.Exception,UnityEngine.Object)
IL_0055: leave.s IL_0057
IL_0057: ldloc.1
IL_0058: ldc.i4.1
IL_0059: add
IL_005a: stloc.1
IL_005b: ldloc.1
IL_005c: ldarg.0
IL_005d: ldfld UnityEngine.UI.Collections.IndexedSet`1<UnityEngine.UI.ICanvasElement> UnityEngine.UI.CanvasUpdateRegistry::m_LayoutRebuildQueue
IL_0062: callvirt System.Int32 UnityEngine.UI.Collections.IndexedSet`1<UnityEngine.UI.ICanvasElement>::get_Count()
IL_0067: blt.s IL_002b
IL_0069: ldloc.0
IL_006a: ldc.i4.1
IL_006b: add
IL_006c: stloc.0
IL_006d: ldloc.0
IL_006e: ldc.i4.2
IL_006f: ble.s IL_0027
IL_0071: ldc.i4.0
IL_0072: stloc.3
IL_0073: br.s IL_008a
IL_0075: ldarg.0
IL_0076: ldfld UnityEngine.UI.Collections.IndexedSet`1<UnityEngine.UI.ICanvasElement> UnityEngine.UI.CanvasUpdateRegistry::m_LayoutRebuildQueue
IL_007b: ldloc.3
IL_007c: callvirt T UnityEngine.UI.Collections.IndexedSet`1<UnityEngine.UI.ICanvasElement>::get_Item(System.Int32)
IL_0081: callvirt System.Void UnityEngine.UI.ICanvasElement::LayoutComplete()
IL_0086: ldloc.3
IL_0087: ldc.i4.1
IL_0088: add
IL_0089: stloc.3
IL_008a: ldloc.3
IL_008b: ldarg.0
IL_008c: ldfld UnityEngine.UI.Collections.IndexedSet`1<UnityEngine.UI.ICanvasElement> UnityEngine.UI.CanvasUpdateRegistry::m_LayoutRebuildQueue
IL_0091: callvirt System.Int32 UnityEngine.UI.Collections.IndexedSet`1<UnityEngine.UI.ICanvasElement>::get_Count()
IL_0096: blt.s IL_0075
IL_0098: ldarg.0
IL_0099: ldfld UnityEngine.UI.Collections.IndexedSet`1<UnityEngine.UI.ICanvasElement> UnityEngine.UI.CanvasUpdateRegistry::m_LayoutRebuildQueue
IL_009e: callvirt System.Void UnityEngine.UI.Collections.IndexedSet`1<UnityEngine.UI.ICanvasElement>::Clear()
IL_00a3: ldarg.0
IL_00a4: ldc.i4.0
IL_00a5: stfld System.Boolean UnityEngine.UI.CanvasUpdateRegistry::m_PerformingLayoutUpdate
IL_00aa: ldc.i4.0
IL_00ab: call System.Void UnityEngine.UISystemProfilerApi::EndSample(UnityEngine.UISystemProfilerApi/SampleType)
IL_00b0: ldc.i4.1
IL_00b1: call System.Void UnityEngine.UISystemProfilerApi::BeginSample(UnityEngine.UISystemProfilerApi/SampleType)
IL_00b6: call UnityEngine.UI.ClipperRegistry UnityEngine.UI.ClipperRegistry::get_instance()
IL_00bb: callvirt System.Void UnityEngine.UI.ClipperRegistry::Cull()
IL_00c0: ldarg.0
IL_00c1: ldc.i4.1
IL_00c2: stfld System.Boolean UnityEngine.UI.CanvasUpdateRegistry::m_PerformingGraphicUpdate
IL_00c7: ldc.i4.3
IL_00c8: stloc.s V_4
IL_00ca: br.s IL_012a
IL_00cc: ldc.i4.0
IL_00cd: stloc.s V_5
IL_00cf: br.s IL_0115
IL_00d1: nop
IL_00d2: ldarg.0
IL_00d3: ldfld UnityEngine.UI.Collections.IndexedSet`1<UnityEngine.UI.ICanvasElement> UnityEngine.UI.CanvasUpdateRegistry::m_GraphicRebuildQueue
IL_00d8: ldloc.s V_5
IL_00da: callvirt T UnityEngine.UI.Collections.IndexedSet`1<UnityEngine.UI.ICanvasElement>::get_Item(System.Int32)
IL_00df: stloc.s V_6
IL_00e1: ldarg.0
IL_00e2: ldloc.s V_6
IL_00e4: call System.Boolean UnityEngine.UI.CanvasUpdateRegistry::ObjectValidForUpdate(UnityEngine.UI.ICanvasElement)
IL_00e9: brfalse.s IL_00f4
IL_00eb: ldloc.s V_6
IL_00ed: ldloc.s V_4
IL_00ef: callvirt System.Void UnityEngine.UI.ICanvasElement::Rebuild(UnityEngine.UI.CanvasUpdate)
IL_00f4: leave.s IL_010f
IL_00f6: ldarg.0
IL_00f7: ldfld UnityEngine.UI.Collections.IndexedSet`1<UnityEngine.UI.ICanvasElement> UnityEngine.UI.CanvasUpdateRegistry::m_GraphicRebuildQueue
IL_00fc: ldloc.s V_5
IL_00fe: callvirt T UnityEngine.UI.Collections.IndexedSet`1<UnityEngine.UI.ICanvasElement>::get_Item(System.Int32)
IL_0103: callvirt UnityEngine.Transform UnityEngine.UI.ICanvasElement::get_transform()
IL_0108: call System.Void UnityEngine.Debug::LogException(System.Exception,UnityEngine.Object)
IL_010d: leave.s IL_010f
IL_010f: ldloc.s V_5
IL_0111: ldc.i4.1
IL_0112: add
IL_0113: stloc.s V_5
IL_0115: ldloc.s V_5
IL_0117: ldarg.0
IL_0118: ldfld UnityEngine.UI.Collections.IndexedSet`1<UnityEngine.UI.ICanvasElement> UnityEngine.UI.CanvasUpdateRegistry::m_GraphicRebuildQueue
IL_011d: callvirt System.Int32 UnityEngine.UI.Collections.IndexedSet`1<UnityEngine.UI.ICanvasElement>::get_Count()
IL_0122: blt.s IL_00d1
IL_0124: ldloc.s V_4
IL_0126: ldc.i4.1
IL_0127: add
IL_0128: stloc.s V_4
IL_012a: ldloc.s V_4
IL_012c: ldc.i4.5
IL_012d: blt.s IL_00cc
IL_012f: ldc.i4.0
IL_0130: stloc.s V_7
IL_0132: br.s IL_014c
IL_0134: ldarg.0
IL_0135: ldfld UnityEngine.UI.Collections.IndexedSet`1<UnityEngine.UI.ICanvasElement> UnityEngine.UI.CanvasUpdateRegistry::m_GraphicRebuildQueue
IL_013a: ldloc.s V_7
IL_013c: callvirt T UnityEngine.UI.Collections.IndexedSet`1<UnityEngine.UI.ICanvasElement>::get_Item(System.Int32)
IL_0141: callvirt System.Void UnityEngine.UI.ICanvasElement::GraphicUpdateComplete()
IL_0146: ldloc.s V_7
IL_0148: ldc.i4.1
IL_0149: add
IL_014a: stloc.s V_7
IL_014c: ldloc.s V_7
IL_014e: ldarg.0
IL_014f: ldfld UnityEngine.UI.Collections.IndexedSet`1<UnityEngine.UI.ICanvasElement> UnityEngine.UI.CanvasUpdateRegistry::m_GraphicRebuildQueue
IL_0154: callvirt System.Int32 UnityEngine.UI.Collections.IndexedSet`1<UnityEngine.UI.ICanvasElement>::get_Count()
IL_0159: blt.s IL_0134
IL_015b: ldarg.0
IL_015c: ldfld UnityEngine.UI.Collections.IndexedSet`1<UnityEngine.UI.ICanvasElement> UnityEngine.UI.CanvasUpdateRegistry::m_GraphicRebuildQueue
IL_0161: callvirt System.Void UnityEngine.UI.Collections.IndexedSet`1<UnityEngine.UI.ICanvasElement>::Clear()
IL_0166: ldarg.0
IL_0167: ldc.i4.0
IL_0168: stfld System.Boolean UnityEngine.UI.CanvasUpdateRegistry::m_PerformingGraphicUpdate
IL_016d: ldc.i4.1
IL_016e: call System.Void UnityEngine.UISystemProfilerApi::EndSample(UnityEngine.UISystemProfilerApi/SampleType)
IL_0173: ret
