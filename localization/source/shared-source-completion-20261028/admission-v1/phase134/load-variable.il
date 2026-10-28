TYPE TheForestOfLove.Services.Persistence.Savestate
METHOD System.String TheForestOfLove.Services.Persistence.Savestate::LoadVariable(System.String) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Collections.Generic.Dictionary`2<System.String,System.String> TheForestOfLove.Services.Persistence.Savestate::variables
IL_0006: ldarg.1
IL_0007: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,System.String>::ContainsKey(!0)
IL_000c: brfalse.s IL_001b
IL_000e: ldarg.0
IL_000f: ldfld System.Collections.Generic.Dictionary`2<System.String,System.String> TheForestOfLove.Services.Persistence.Savestate::variables
IL_0014: ldarg.1
IL_0015: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,System.String>::get_Item(!0)
IL_001a: ret
IL_001b: ldnull
IL_001c: ret
