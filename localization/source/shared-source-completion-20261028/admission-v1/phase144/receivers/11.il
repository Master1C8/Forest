TYPE TheForestOfLove.Services.Persistence.Savestate
METHOD System.Void TheForestOfLove.Services.Persistence.Savestate::SaveVariable(System.String,System.String) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Collections.Generic.Dictionary`2<System.String,System.String> TheForestOfLove.Services.Persistence.Savestate::variables
IL_0006: ldarg.1
IL_0007: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,System.String>::ContainsKey(!0)
IL_000c: brfalse.s IL_001c
IL_000e: ldarg.0
IL_000f: ldfld System.Collections.Generic.Dictionary`2<System.String,System.String> TheForestOfLove.Services.Persistence.Savestate::variables
IL_0014: ldarg.1
IL_0015: ldarg.2
IL_0016: callvirt System.Void System.Collections.Generic.Dictionary`2<System.String,System.String>::set_Item(!0,!1)
IL_001b: ret
IL_001c: ldarg.0
IL_001d: ldfld System.Collections.Generic.Dictionary`2<System.String,System.String> TheForestOfLove.Services.Persistence.Savestate::variables
IL_0022: ldarg.1
IL_0023: ldarg.2
IL_0024: callvirt System.Void System.Collections.Generic.Dictionary`2<System.String,System.String>::Add(!0,!1)
IL_0029: ret
METHOD System.Void TheForestOfLove.Services.Persistence.Savestate::SaveAddTag(System.String) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Collections.Generic.HashSet`1<System.String> TheForestOfLove.Services.Persistence.Savestate::tags
IL_0006: ldarg.1
IL_0007: callvirt System.Boolean System.Collections.Generic.HashSet`1<System.String>::Add(!0)
IL_000c: pop
IL_000d: ret
METHOD System.Collections.Generic.IEnumerable`1<TheForestOfLove.Services.Persistence.SavegameTriggerData> TheForestOfLove.Services.Persistence.Savestate::LoadTriggerData() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Services.Persistence.SavegameTriggerData> TheForestOfLove.Services.Persistence.Savestate::triggerData
IL_0006: callvirt System.Collections.Generic.Dictionary`2/ValueCollection<!0,!1> System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Services.Persistence.SavegameTriggerData>::get_Values()
IL_000b: ret
METHOD TheForestOfLove.Services.Persistence.SavegameTriggerData TheForestOfLove.Services.Persistence.Savestate::LoadTriggerData(System.String) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Services.Persistence.SavegameTriggerData> TheForestOfLove.Services.Persistence.Savestate::triggerData
IL_0006: ldarg.1
IL_0007: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Services.Persistence.SavegameTriggerData>::ContainsKey(!0)
IL_000c: brfalse.s IL_001b
IL_000e: ldarg.0
IL_000f: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Services.Persistence.SavegameTriggerData> TheForestOfLove.Services.Persistence.Savestate::triggerData
IL_0014: ldarg.1
IL_0015: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Services.Persistence.SavegameTriggerData>::get_Item(!0)
IL_001a: ret
IL_001b: ldnull
IL_001c: ret
