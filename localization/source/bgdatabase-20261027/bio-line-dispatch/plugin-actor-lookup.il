TYPE TheForestOfLove.Services.Persistence.DataService
METHOD TheForestOfLove.Narrative.Actor TheForestOfLove.Services.Persistence.DataService::GetActorByPluginDbId(System.Int32) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0005: ldfld System.Collections.Generic.Dictionary`2<System.Int32,TheForestOfLove.Narrative.Actor> TheForestOfLove.Narrative.DataManifest::actorsByPluginDbId
IL_000a: ldarg.0
IL_000b: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.Int32,TheForestOfLove.Narrative.Actor>::ContainsKey(!0)
IL_0010: brfalse.s IL_0023
IL_0012: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0017: ldfld System.Collections.Generic.Dictionary`2<System.Int32,TheForestOfLove.Narrative.Actor> TheForestOfLove.Narrative.DataManifest::actorsByPluginDbId
IL_001c: ldarg.0
IL_001d: callvirt !1 System.Collections.Generic.Dictionary`2<System.Int32,TheForestOfLove.Narrative.Actor>::get_Item(!0)
IL_0022: ret
IL_0023: ldstr "data service cannot find actor by plugin db id {0}"
IL_0028: ldarg.0
IL_0029: box System.Int32
IL_002e: call System.String System.String::Format(System.String,System.Object)
IL_0033: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_0038: ldnull
IL_0039: ret
