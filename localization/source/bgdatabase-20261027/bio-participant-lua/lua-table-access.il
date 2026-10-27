TYPE Language.Lua.LuaTable
METHOD System.Void Language.Lua.LuaTable::AddRaw(System.String,Language.Lua.LuaValue) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Collections.Generic.Dictionary`2<System.String,Language.Lua.LuaValue> Language.Lua.LuaTable::m_stringKeyCache
IL_0006: ldarg.1
IL_0007: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,Language.Lua.LuaValue>::ContainsKey(!0)
IL_000c: brfalse.s IL_0029
IL_000e: ldarg.0
IL_000f: ldfld System.Collections.Generic.Dictionary`2<System.String,Language.Lua.LuaValue> Language.Lua.LuaTable::m_stringKeyCache
IL_0014: ldarg.1
IL_0015: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,Language.Lua.LuaValue>::get_Item(!0)
IL_001a: stloc.0
IL_001b: ldarg.0
IL_001c: call System.Collections.Generic.Dictionary`2<Language.Lua.LuaValue,Language.Lua.LuaValue> Language.Lua.LuaTable::get_Dict()
IL_0021: ldloc.0
IL_0022: ldarg.2
IL_0023: callvirt System.Void System.Collections.Generic.Dictionary`2<Language.Lua.LuaValue,Language.Lua.LuaValue>::set_Item(!0,!1)
IL_0028: ret
IL_0029: ldarg.1
IL_002a: newobj System.Void Language.Lua.LuaString::.ctor(System.String)
IL_002f: stloc.1
IL_0030: ldarg.0
IL_0031: call System.Collections.Generic.Dictionary`2<Language.Lua.LuaValue,Language.Lua.LuaValue> Language.Lua.LuaTable::get_Dict()
IL_0036: ldloc.1
IL_0037: ldarg.2
IL_0038: callvirt System.Void System.Collections.Generic.Dictionary`2<Language.Lua.LuaValue,Language.Lua.LuaValue>::set_Item(!0,!1)
IL_003d: ldarg.0
IL_003e: ldfld System.Collections.Generic.Dictionary`2<System.String,Language.Lua.LuaValue> Language.Lua.LuaTable::m_stringKeyCache
IL_0043: ldarg.1
IL_0044: ldloc.1
IL_0045: callvirt System.Void System.Collections.Generic.Dictionary`2<System.String,Language.Lua.LuaValue>::set_Item(!0,!1)
IL_004a: ret
METHOD System.Void Language.Lua.LuaTable::AddRaw(System.Int32,Language.Lua.LuaValue) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Collections.Generic.Dictionary`2<System.Int32,Language.Lua.LuaValue> Language.Lua.LuaTable::m_intKeyCache
IL_0006: ldarg.1
IL_0007: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.Int32,Language.Lua.LuaValue>::ContainsKey(!0)
IL_000c: brfalse.s IL_0029
IL_000e: ldarg.0
IL_000f: ldfld System.Collections.Generic.Dictionary`2<System.Int32,Language.Lua.LuaValue> Language.Lua.LuaTable::m_intKeyCache
IL_0014: ldarg.1
IL_0015: callvirt !1 System.Collections.Generic.Dictionary`2<System.Int32,Language.Lua.LuaValue>::get_Item(!0)
IL_001a: stloc.0
IL_001b: ldarg.0
IL_001c: call System.Collections.Generic.Dictionary`2<Language.Lua.LuaValue,Language.Lua.LuaValue> Language.Lua.LuaTable::get_Dict()
IL_0021: ldloc.0
IL_0022: ldarg.2
IL_0023: callvirt System.Void System.Collections.Generic.Dictionary`2<Language.Lua.LuaValue,Language.Lua.LuaValue>::set_Item(!0,!1)
IL_0028: ret
IL_0029: ldarg.1
IL_002a: ldarg.0
IL_002b: call System.Int32 Language.Lua.LuaTable::get_Length()
IL_0030: ldc.i4.1
IL_0031: add
IL_0032: bne.un.s IL_003c
IL_0034: ldarg.0
IL_0035: ldarg.2
IL_0036: call System.Void Language.Lua.LuaTable::AddValue(Language.Lua.LuaValue)
IL_003b: ret
IL_003c: ldarg.1
IL_003d: ldc.i4.0
IL_003e: ble.s IL_0059
IL_0040: ldarg.1
IL_0041: ldarg.0
IL_0042: call System.Int32 Language.Lua.LuaTable::get_Length()
IL_0047: bgt.s IL_0059
IL_0049: ldarg.0
IL_004a: ldfld System.Collections.Generic.List`1<Language.Lua.LuaValue> Language.Lua.LuaTable::list
IL_004f: ldarg.1
IL_0050: ldc.i4.1
IL_0051: sub
IL_0052: ldarg.2
IL_0053: callvirt System.Void System.Collections.Generic.List`1<Language.Lua.LuaValue>::set_Item(System.Int32,!0)
IL_0058: ret
IL_0059: ldarg.1
IL_005a: conv.r8
IL_005b: newobj System.Void Language.Lua.LuaNumber::.ctor(System.Double)
IL_0060: stloc.1
IL_0061: ldarg.0
IL_0062: call System.Collections.Generic.Dictionary`2<Language.Lua.LuaValue,Language.Lua.LuaValue> Language.Lua.LuaTable::get_Dict()
IL_0067: ldloc.1
IL_0068: ldarg.2
IL_0069: callvirt System.Void System.Collections.Generic.Dictionary`2<Language.Lua.LuaValue,Language.Lua.LuaValue>::set_Item(!0,!1)
IL_006e: ldarg.0
IL_006f: ldfld System.Collections.Generic.Dictionary`2<System.Int32,Language.Lua.LuaValue> Language.Lua.LuaTable::m_intKeyCache
IL_0074: ldarg.1
IL_0075: ldloc.1
IL_0076: callvirt System.Void System.Collections.Generic.Dictionary`2<System.Int32,Language.Lua.LuaValue>::set_Item(!0,!1)
IL_007b: ret
METHOD Language.Lua.LuaValue Language.Lua.LuaTable::GetValue(System.Int32) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: ldc.i4.0
IL_0002: ble.s IL_001c
IL_0004: ldarg.1
IL_0005: ldarg.0
IL_0006: call System.Int32 Language.Lua.LuaTable::get_Length()
IL_000b: bgt.s IL_001c
IL_000d: ldarg.0
IL_000e: ldfld System.Collections.Generic.List`1<Language.Lua.LuaValue> Language.Lua.LuaTable::list
IL_0013: ldarg.1
IL_0014: ldc.i4.1
IL_0015: sub
IL_0016: callvirt !0 System.Collections.Generic.List`1<Language.Lua.LuaValue>::get_Item(System.Int32)
IL_001b: ret
IL_001c: ldarg.0
IL_001d: ldfld System.Collections.Generic.Dictionary`2<Language.Lua.LuaValue,Language.Lua.LuaValue> Language.Lua.LuaTable::dict
IL_0022: brfalse.s IL_0071
IL_0024: ldarg.0
IL_0025: ldfld System.Collections.Generic.Dictionary`2<System.Int32,Language.Lua.LuaValue> Language.Lua.LuaTable::m_intKeyCache
IL_002a: ldarg.1
IL_002b: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.Int32,Language.Lua.LuaValue>::ContainsKey(!0)
IL_0030: brfalse.s IL_0063
IL_0032: ldarg.0
IL_0033: ldfld System.Collections.Generic.Dictionary`2<Language.Lua.LuaValue,Language.Lua.LuaValue> Language.Lua.LuaTable::dict
IL_0038: ldarg.0
IL_0039: ldfld System.Collections.Generic.Dictionary`2<System.Int32,Language.Lua.LuaValue> Language.Lua.LuaTable::m_intKeyCache
IL_003e: ldarg.1
IL_003f: callvirt !1 System.Collections.Generic.Dictionary`2<System.Int32,Language.Lua.LuaValue>::get_Item(!0)
IL_0044: callvirt System.Boolean System.Collections.Generic.Dictionary`2<Language.Lua.LuaValue,Language.Lua.LuaValue>::ContainsKey(!0)
IL_0049: brfalse.s IL_0063
IL_004b: ldarg.0
IL_004c: ldfld System.Collections.Generic.Dictionary`2<Language.Lua.LuaValue,Language.Lua.LuaValue> Language.Lua.LuaTable::dict
IL_0051: ldarg.0
IL_0052: ldfld System.Collections.Generic.Dictionary`2<System.Int32,Language.Lua.LuaValue> Language.Lua.LuaTable::m_intKeyCache
IL_0057: ldarg.1
IL_0058: callvirt !1 System.Collections.Generic.Dictionary`2<System.Int32,Language.Lua.LuaValue>::get_Item(!0)
IL_005d: callvirt !1 System.Collections.Generic.Dictionary`2<Language.Lua.LuaValue,Language.Lua.LuaValue>::get_Item(!0)
IL_0062: ret
IL_0063: ldarg.0
IL_0064: ldarga.s index
IL_0066: call System.String System.Int32::ToString()
IL_006b: call Language.Lua.LuaValue Language.Lua.LuaTable::GetValue(System.String)
IL_0070: ret
IL_0071: ldsfld Language.Lua.LuaNil Language.Lua.LuaNil::Nil
IL_0076: ret
METHOD Language.Lua.LuaValue Language.Lua.LuaTable::GetValue(System.String) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: call Language.Lua.LuaValue Language.Lua.LuaTable::GetKey(System.String)
IL_0007: stloc.0
IL_0008: ldloc.0
IL_0009: ldsfld Language.Lua.LuaNil Language.Lua.LuaNil::Nil
IL_000e: bne.un.s IL_0026
IL_0010: ldarg.0
IL_0011: call Language.Lua.LuaTable Language.Lua.LuaTable::get_MetaTable()
IL_0016: brfalse.s IL_0020
IL_0018: ldarg.0
IL_0019: ldarg.1
IL_001a: call Language.Lua.LuaValue Language.Lua.LuaTable::GetValueFromMetaTable(System.String)
IL_001f: ret
IL_0020: ldsfld Language.Lua.LuaNil Language.Lua.LuaNil::Nil
IL_0025: ret
IL_0026: ldarg.0
IL_0027: ldfld System.Collections.Generic.Dictionary`2<Language.Lua.LuaValue,Language.Lua.LuaValue> Language.Lua.LuaTable::dict
IL_002c: ldloc.0
IL_002d: callvirt !1 System.Collections.Generic.Dictionary`2<Language.Lua.LuaValue,Language.Lua.LuaValue>::get_Item(!0)
IL_0032: ret
METHOD System.Void Language.Lua.LuaTable::SetKeyValue(Language.Lua.LuaValue,Language.Lua.LuaValue) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: isinst Language.Lua.LuaNumber
IL_0006: stloc.0
IL_0007: ldloc.0
IL_0008: brfalse IL_0095
IL_000d: ldloc.0
IL_000e: callvirt System.Double Language.Lua.LuaNumber::get_Number()
IL_0013: ldloc.0
IL_0014: callvirt System.Double Language.Lua.LuaNumber::get_Number()
IL_0019: conv.i4
IL_001a: conv.r8
IL_001b: bne.un.s IL_0095
IL_001d: ldloc.0
IL_001e: callvirt System.Double Language.Lua.LuaNumber::get_Number()
IL_0023: conv.i4
IL_0024: stloc.2
IL_0025: ldarg.0
IL_0026: ldfld System.Collections.Generic.Dictionary`2<System.Int32,Language.Lua.LuaValue> Language.Lua.LuaTable::m_intKeyCache
IL_002b: ldloc.2
IL_002c: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.Int32,Language.Lua.LuaValue>::ContainsKey(!0)
IL_0031: brfalse.s IL_0065
IL_0033: ldarg.0
IL_0034: call System.Collections.Generic.Dictionary`2<Language.Lua.LuaValue,Language.Lua.LuaValue> Language.Lua.LuaTable::get_Dict()
IL_0039: ldarg.0
IL_003a: ldfld System.Collections.Generic.Dictionary`2<System.Int32,Language.Lua.LuaValue> Language.Lua.LuaTable::m_intKeyCache
IL_003f: ldloc.2
IL_0040: callvirt !1 System.Collections.Generic.Dictionary`2<System.Int32,Language.Lua.LuaValue>::get_Item(!0)
IL_0045: callvirt System.Boolean System.Collections.Generic.Dictionary`2<Language.Lua.LuaValue,Language.Lua.LuaValue>::ContainsKey(!0)
IL_004a: brfalse.s IL_0065
IL_004c: ldarg.0
IL_004d: call System.Collections.Generic.Dictionary`2<Language.Lua.LuaValue,Language.Lua.LuaValue> Language.Lua.LuaTable::get_Dict()
IL_0052: ldarg.0
IL_0053: ldfld System.Collections.Generic.Dictionary`2<System.Int32,Language.Lua.LuaValue> Language.Lua.LuaTable::m_intKeyCache
IL_0058: ldloc.2
IL_0059: callvirt !1 System.Collections.Generic.Dictionary`2<System.Int32,Language.Lua.LuaValue>::get_Item(!0)
IL_005e: ldarg.2
IL_005f: callvirt System.Void System.Collections.Generic.Dictionary`2<Language.Lua.LuaValue,Language.Lua.LuaValue>::set_Item(!0,!1)
IL_0064: ret
IL_0065: ldloc.2
IL_0066: ldarg.0
IL_0067: call System.Int32 Language.Lua.LuaTable::get_Length()
IL_006c: ldc.i4.1
IL_006d: add
IL_006e: bne.un.s IL_0078
IL_0070: ldarg.0
IL_0071: ldarg.2
IL_0072: call System.Void Language.Lua.LuaTable::AddValue(Language.Lua.LuaValue)
IL_0077: ret
IL_0078: ldloc.2
IL_0079: ldc.i4.0
IL_007a: ble.s IL_0095
IL_007c: ldloc.2
IL_007d: ldarg.0
IL_007e: call System.Int32 Language.Lua.LuaTable::get_Length()
IL_0083: bgt.s IL_0095
IL_0085: ldarg.0
IL_0086: ldfld System.Collections.Generic.List`1<Language.Lua.LuaValue> Language.Lua.LuaTable::list
IL_008b: ldloc.2
IL_008c: ldc.i4.1
IL_008d: sub
IL_008e: ldarg.2
IL_008f: callvirt System.Void System.Collections.Generic.List`1<Language.Lua.LuaValue>::set_Item(System.Int32,!0)
IL_0094: ret
IL_0095: ldarg.2
IL_0096: ldsfld Language.Lua.LuaNil Language.Lua.LuaNil::Nil
IL_009b: bne.un.s IL_00a5
IL_009d: ldarg.0
IL_009e: ldarg.1
IL_009f: call System.Void Language.Lua.LuaTable::RemoveKey(Language.Lua.LuaValue)
IL_00a4: ret
IL_00a5: ldarg.0
IL_00a6: ldfld System.Collections.Generic.Dictionary`2<Language.Lua.LuaValue,Language.Lua.LuaValue> Language.Lua.LuaTable::dict
IL_00ab: brtrue.s IL_00b8
IL_00ad: ldarg.0
IL_00ae: newobj System.Void System.Collections.Generic.Dictionary`2<Language.Lua.LuaValue,Language.Lua.LuaValue>::.ctor()
IL_00b3: stfld System.Collections.Generic.Dictionary`2<Language.Lua.LuaValue,Language.Lua.LuaValue> Language.Lua.LuaTable::dict
IL_00b8: ldarg.0
IL_00b9: ldfld System.Collections.Generic.Dictionary`2<Language.Lua.LuaValue,Language.Lua.LuaValue> Language.Lua.LuaTable::dict
IL_00be: ldarg.1
IL_00bf: ldarg.2
IL_00c0: callvirt System.Void System.Collections.Generic.Dictionary`2<Language.Lua.LuaValue,Language.Lua.LuaValue>::set_Item(!0,!1)
IL_00c5: ldarg.0
IL_00c6: ldarg.1
IL_00c7: ldloca.s V_1
IL_00c9: call System.Boolean Language.Lua.LuaTable::GetIntValue(Language.Lua.LuaValue,System.Int32&)
IL_00ce: brfalse.s IL_00de
IL_00d0: ldarg.0
IL_00d1: ldfld System.Collections.Generic.Dictionary`2<System.Int32,Language.Lua.LuaValue> Language.Lua.LuaTable::m_intKeyCache
IL_00d6: ldloc.1
IL_00d7: ldarg.1
IL_00d8: callvirt System.Void System.Collections.Generic.Dictionary`2<System.Int32,Language.Lua.LuaValue>::set_Item(!0,!1)
IL_00dd: ret
IL_00de: ldarg.1
IL_00df: isinst Language.Lua.LuaString
IL_00e4: brfalse.s IL_00fd
IL_00e6: ldarg.0
IL_00e7: ldfld System.Collections.Generic.Dictionary`2<System.String,Language.Lua.LuaValue> Language.Lua.LuaTable::m_stringKeyCache
IL_00ec: ldarg.1
IL_00ed: isinst Language.Lua.LuaString
IL_00f2: callvirt System.String Language.Lua.LuaString::get_Text()
IL_00f7: ldarg.1
IL_00f8: callvirt System.Void System.Collections.Generic.Dictionary`2<System.String,Language.Lua.LuaValue>::set_Item(!0,!1)
IL_00fd: ret
METHOD Language.Lua.LuaValue Language.Lua.LuaTable::GetValue(Language.Lua.LuaValue) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: ldsfld Language.Lua.LuaNil Language.Lua.LuaNil::Nil
IL_0006: bne.un.s IL_000e
IL_0008: ldsfld Language.Lua.LuaNil Language.Lua.LuaNil::Nil
IL_000d: ret
IL_000e: ldarg.1
IL_000f: isinst Language.Lua.LuaNumber
IL_0014: stloc.0
IL_0015: ldloc.0
IL_0016: brfalse.s IL_004c
IL_0018: ldloc.0
IL_0019: callvirt System.Double Language.Lua.LuaNumber::get_Number()
IL_001e: ldloc.0
IL_001f: callvirt System.Double Language.Lua.LuaNumber::get_Number()
IL_0024: conv.i4
IL_0025: conv.r8
IL_0026: bne.un.s IL_004c
IL_0028: ldloc.0
IL_0029: callvirt System.Double Language.Lua.LuaNumber::get_Number()
IL_002e: conv.i4
IL_002f: stloc.1
IL_0030: ldloc.1
IL_0031: ldc.i4.0
IL_0032: ble.s IL_004c
IL_0034: ldloc.1
IL_0035: ldarg.0
IL_0036: call System.Int32 Language.Lua.LuaTable::get_Length()
IL_003b: bgt.s IL_004c
IL_003d: ldarg.0
IL_003e: ldfld System.Collections.Generic.List`1<Language.Lua.LuaValue> Language.Lua.LuaTable::list
IL_0043: ldloc.1
IL_0044: ldc.i4.1
IL_0045: sub
IL_0046: callvirt !0 System.Collections.Generic.List`1<Language.Lua.LuaValue>::get_Item(System.Int32)
IL_004b: ret
IL_004c: ldarg.0
IL_004d: ldfld System.Collections.Generic.Dictionary`2<Language.Lua.LuaValue,Language.Lua.LuaValue> Language.Lua.LuaTable::dict
IL_0052: brfalse.s IL_006f
IL_0054: ldarg.0
IL_0055: ldfld System.Collections.Generic.Dictionary`2<Language.Lua.LuaValue,Language.Lua.LuaValue> Language.Lua.LuaTable::dict
IL_005a: ldarg.1
IL_005b: callvirt System.Boolean System.Collections.Generic.Dictionary`2<Language.Lua.LuaValue,Language.Lua.LuaValue>::ContainsKey(!0)
IL_0060: brfalse.s IL_006f
IL_0062: ldarg.0
IL_0063: ldfld System.Collections.Generic.Dictionary`2<Language.Lua.LuaValue,Language.Lua.LuaValue> Language.Lua.LuaTable::dict
IL_0068: ldarg.1
IL_0069: callvirt !1 System.Collections.Generic.Dictionary`2<Language.Lua.LuaValue,Language.Lua.LuaValue>::get_Item(!0)
IL_006e: ret
IL_006f: ldarg.0
IL_0070: call Language.Lua.LuaTable Language.Lua.LuaTable::get_MetaTable()
IL_0075: brfalse.s IL_007f
IL_0077: ldarg.0
IL_0078: ldarg.1
IL_0079: call Language.Lua.LuaValue Language.Lua.LuaTable::GetValueFromMetaTable(Language.Lua.LuaValue)
IL_007e: ret
IL_007f: ldsfld Language.Lua.LuaNil Language.Lua.LuaNil::Nil
IL_0084: ret
METHOD Language.Lua.LuaValue Language.Lua.LuaTable::GetValueFromMetaTable(System.String) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call Language.Lua.LuaTable Language.Lua.LuaTable::get_MetaTable()
IL_0006: ldstr "__index"
IL_000b: callvirt Language.Lua.LuaValue Language.Lua.LuaTable::GetValue(System.String)
IL_0010: stloc.0
IL_0011: ldloc.0
IL_0012: isinst Language.Lua.LuaTable
IL_0017: stloc.1
IL_0018: ldloc.1
IL_0019: brfalse.s IL_0023
IL_001b: ldloc.1
IL_001c: ldarg.1
IL_001d: callvirt Language.Lua.LuaValue Language.Lua.LuaTable::GetValue(System.String)
IL_0022: ret
IL_0023: ldloc.0
IL_0024: isinst Language.Lua.LuaFunction
IL_0029: stloc.2
IL_002a: ldloc.2
IL_002b: brfalse.s IL_0048
IL_002d: ldloc.2
IL_002e: callvirt Language.Lua.LuaFunc Language.Lua.LuaFunction::get_Function()
IL_0033: ldc.i4.1
IL_0034: newarr Language.Lua.LuaValue
IL_0039: dup
IL_003a: ldc.i4.0
IL_003b: ldarg.1
IL_003c: newobj System.Void Language.Lua.LuaString::.ctor(System.String)
IL_0041: stelem.ref
IL_0042: callvirt Language.Lua.LuaValue Language.Lua.LuaFunc::Invoke(Language.Lua.LuaValue[])
IL_0047: ret
IL_0048: ldsfld Language.Lua.LuaNil Language.Lua.LuaNil::Nil
IL_004d: ret
METHOD Language.Lua.LuaValue Language.Lua.LuaTable::GetValueFromMetaTable(Language.Lua.LuaValue) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call Language.Lua.LuaTable Language.Lua.LuaTable::get_MetaTable()
IL_0006: ldstr "__index"
IL_000b: callvirt Language.Lua.LuaValue Language.Lua.LuaTable::GetValue(System.String)
IL_0010: stloc.0
IL_0011: ldloc.0
IL_0012: isinst Language.Lua.LuaTable
IL_0017: stloc.1
IL_0018: ldloc.1
IL_0019: brfalse.s IL_0023
IL_001b: ldloc.1
IL_001c: ldarg.1
IL_001d: callvirt Language.Lua.LuaValue Language.Lua.LuaTable::GetValue(Language.Lua.LuaValue)
IL_0022: ret
IL_0023: ldloc.0
IL_0024: isinst Language.Lua.LuaFunction
IL_0029: stloc.2
IL_002a: ldloc.2
IL_002b: brfalse.s IL_0043
IL_002d: ldloc.2
IL_002e: callvirt Language.Lua.LuaFunc Language.Lua.LuaFunction::get_Function()
IL_0033: ldc.i4.1
IL_0034: newarr Language.Lua.LuaValue
IL_0039: dup
IL_003a: ldc.i4.0
IL_003b: ldarg.1
IL_003c: stelem.ref
IL_003d: callvirt Language.Lua.LuaValue Language.Lua.LuaFunc::Invoke(Language.Lua.LuaValue[])
IL_0042: ret
IL_0043: ldsfld Language.Lua.LuaNil Language.Lua.LuaNil::Nil
IL_0048: ret
