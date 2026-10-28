TYPE viperOSK_Examples.Example4
METHOD System.Void viperOSK_Examples.Example4::TabKey() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Int32 viperOSK_Examples.Example4::currentField
IL_0006: brtrue.s IL_0031
IL_0008: ldarg.0
IL_0009: ldfld System.String viperOSK_Examples.Example4::username
IL_000e: callvirt System.Int32 System.String::get_Length()
IL_0013: brtrue.s IL_0031
IL_0015: ldarg.0
IL_0016: ldarg.0
IL_0017: ldfld System.Collections.Generic.List`1<viperOSK.OSK_Receiver> viperOSK_Examples.Example4::inputFields
IL_001c: ldarg.0
IL_001d: ldfld System.Int32 viperOSK_Examples.Example4::currentField
IL_0022: callvirt !0 System.Collections.Generic.List`1<viperOSK.OSK_Receiver>::get_Item(System.Int32)
IL_0027: callvirt System.String viperOSK.OSK_Receiver::Text()
IL_002c: stfld System.String viperOSK_Examples.Example4::username
IL_0031: ldarg.0
IL_0032: ldarg.0
IL_0033: ldfld System.Int32 viperOSK_Examples.Example4::currentField
IL_0038: ldc.i4.1
IL_0039: add
IL_003a: stfld System.Int32 viperOSK_Examples.Example4::currentField
IL_003f: ldarg.0
IL_0040: ldarg.0
IL_0041: ldfld System.Int32 viperOSK_Examples.Example4::currentField
IL_0046: ldarg.0
IL_0047: ldfld System.Collections.Generic.List`1<viperOSK.OSK_Receiver> viperOSK_Examples.Example4::inputFields
IL_004c: callvirt System.Int32 System.Collections.Generic.List`1<viperOSK.OSK_Receiver>::get_Count()
IL_0051: rem
IL_0052: stfld System.Int32 viperOSK_Examples.Example4::currentField
IL_0057: ldarg.0
IL_0058: ldfld viperOSK.OSK_Keyboard viperOSK_Examples.Example4::keyboard
IL_005d: ldarg.0
IL_005e: ldfld System.Collections.Generic.List`1<viperOSK.OSK_Receiver> viperOSK_Examples.Example4::inputFields
IL_0063: ldarg.0
IL_0064: ldfld System.Int32 viperOSK_Examples.Example4::currentField
IL_0069: callvirt !0 System.Collections.Generic.List`1<viperOSK.OSK_Receiver>::get_Item(System.Int32)
IL_006e: callvirt System.Void viperOSK.OSK_Keyboard::SetOutput(viperOSK.OSK_Receiver)
IL_0073: ret
