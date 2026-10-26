TYPE TheForestOfLove.Services.ServiceLocator
METHOD T TheForestOfLove.Services.ServiceLocator::Get() | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldsfld System.Collections.Generic.Dictionary`2<System.Type,System.Object> TheForestOfLove.Services.ServiceLocator::services
IL_0005: ldtoken T
IL_000a: call System.Type System.Type::GetTypeFromHandle(System.RuntimeTypeHandle)
IL_000f: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.Type,System.Object>::ContainsKey(!0)
IL_0014: brfalse.s IL_0030
IL_0016: ldsfld System.Collections.Generic.Dictionary`2<System.Type,System.Object> TheForestOfLove.Services.ServiceLocator::services
IL_001b: ldtoken T
IL_0020: call System.Type System.Type::GetTypeFromHandle(System.RuntimeTypeHandle)
IL_0025: callvirt !1 System.Collections.Generic.Dictionary`2<System.Type,System.Object>::get_Item(!0)
IL_002a: unbox.any T
IL_002f: ret
IL_0030: ldloca.s V_0
IL_0032: initobj T
IL_0038: ldloc.0
IL_0039: ret
