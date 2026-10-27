TYPE TMPro.TMP_Text/TextBackingContainer
METHOD System.Int32 TMPro.TMP_Text/TextBackingContainer::get_Capacity() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.UInt32[] TMPro.TMP_Text/TextBackingContainer::m_Array
IL_0006: ldlen
IL_0007: conv.i4
IL_0008: ret
METHOD System.Int32 TMPro.TMP_Text/TextBackingContainer::get_Count() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Int32 TMPro.TMP_Text/TextBackingContainer::m_Count
IL_0006: ret
METHOD System.Void TMPro.TMP_Text/TextBackingContainer::set_Count(System.Int32) | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: stfld System.Int32 TMPro.TMP_Text/TextBackingContainer::m_Count
IL_0007: ret
METHOD System.UInt32 TMPro.TMP_Text/TextBackingContainer::get_Item(System.Int32) | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.UInt32[] TMPro.TMP_Text/TextBackingContainer::m_Array
IL_0006: ldarg.1
IL_0007: ldelem.u4
IL_0008: ret
METHOD System.Void TMPro.TMP_Text/TextBackingContainer::set_Item(System.Int32,System.UInt32) | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.1
IL_0001: ldarg.0
IL_0002: ldfld System.UInt32[] TMPro.TMP_Text/TextBackingContainer::m_Array
IL_0007: ldlen
IL_0008: conv.i4
IL_0009: blt.s IL_0012
IL_000b: ldarg.0
IL_000c: ldarg.1
IL_000d: call System.Void TMPro.TMP_Text/TextBackingContainer::Resize(System.Int32)
IL_0012: ldarg.0
IL_0013: ldfld System.UInt32[] TMPro.TMP_Text/TextBackingContainer::m_Array
IL_0018: ldarg.1
IL_0019: ldarg.2
IL_001a: stelem.i4
IL_001b: ret
METHOD System.Void TMPro.TMP_Text/TextBackingContainer::Resize(System.Int32) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: ldc.i4.1
IL_0002: add
IL_0003: call System.Int32 UnityEngine.Mathf::NextPowerOfTwo(System.Int32)
IL_0008: starg.s size
IL_000a: ldarg.0
IL_000b: ldflda System.UInt32[] TMPro.TMP_Text/TextBackingContainer::m_Array
IL_0010: ldarg.1
IL_0011: call System.Void System.Array::Resize<System.UInt32>(!!0[]&,System.Int32)
IL_0016: ret
