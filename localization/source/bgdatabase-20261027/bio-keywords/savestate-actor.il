TYPE TheForestOfLove.Services.Persistence.Savestate
METHOD System.Void TheForestOfLove.Services.Persistence.Savestate::SaveActorData(TheForestOfLove.Services.Persistence.SavegameActorData) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Services.Persistence.SavegameActorData> TheForestOfLove.Services.Persistence.Savestate::actorData
IL_0006: ldarg.1
IL_0007: ldfld System.String TheForestOfLove.Services.Persistence.SavegameActorData::actorSavekey
IL_000c: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Services.Persistence.SavegameActorData>::ContainsKey(!0)
IL_0011: brfalse.s IL_0026
IL_0013: ldarg.0
IL_0014: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Services.Persistence.SavegameActorData> TheForestOfLove.Services.Persistence.Savestate::actorData
IL_0019: ldarg.1
IL_001a: ldfld System.String TheForestOfLove.Services.Persistence.SavegameActorData::actorSavekey
IL_001f: ldarg.1
IL_0020: callvirt System.Void System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Services.Persistence.SavegameActorData>::set_Item(!0,!1)
IL_0025: ret
IL_0026: ldarg.0
IL_0027: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Services.Persistence.SavegameActorData> TheForestOfLove.Services.Persistence.Savestate::actorData
IL_002c: ldarg.1
IL_002d: ldfld System.String TheForestOfLove.Services.Persistence.SavegameActorData::actorSavekey
IL_0032: ldarg.1
IL_0033: callvirt System.Void System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Services.Persistence.SavegameActorData>::Add(!0,!1)
IL_0038: ret
METHOD System.Collections.Generic.IEnumerable`1<TheForestOfLove.Services.Persistence.SavegameActorData> TheForestOfLove.Services.Persistence.Savestate::LoadActorData() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Services.Persistence.SavegameActorData> TheForestOfLove.Services.Persistence.Savestate::actorData
IL_0006: callvirt System.Collections.Generic.Dictionary`2/ValueCollection<!0,!1> System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Services.Persistence.SavegameActorData>::get_Values()
IL_000b: ret
METHOD TheForestOfLove.Services.Persistence.SavegameActorData TheForestOfLove.Services.Persistence.Savestate::LoadActorData(System.String) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Services.Persistence.SavegameActorData> TheForestOfLove.Services.Persistence.Savestate::actorData
IL_0006: ldarg.1
IL_0007: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Services.Persistence.SavegameActorData>::ContainsKey(!0)
IL_000c: brfalse.s IL_001b
IL_000e: ldarg.0
IL_000f: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Services.Persistence.SavegameActorData> TheForestOfLove.Services.Persistence.Savestate::actorData
IL_0014: ldarg.1
IL_0015: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Services.Persistence.SavegameActorData>::get_Item(!0)
IL_001a: ret
IL_001b: ldnull
IL_001c: ret
