TYPE TheForestOfLove.Services.Persistence.DataService
METHOD System.Boolean TheForestOfLove.Services.Persistence.DataService::IsTagActive(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0005: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Tag> TheForestOfLove.Narrative.DataManifest::activeTagsByDbName
IL_000a: ldarg.0
IL_000b: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Tag>::ContainsKey(!0)
IL_0010: ret
METHOD TheForestOfLove.Narrative.Actor TheForestOfLove.Services.Persistence.DataService::GetActorByDbName(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0005: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Actor> TheForestOfLove.Narrative.DataManifest::actorsByDbName
IL_000a: ldarg.0
IL_000b: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Actor>::ContainsKey(!0)
IL_0010: brfalse.s IL_0023
IL_0012: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0017: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Actor> TheForestOfLove.Narrative.DataManifest::actorsByDbName
IL_001c: ldarg.0
IL_001d: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Actor>::get_Item(!0)
IL_0022: ret
IL_0023: ldstr "data service cannot find actor by name "
IL_0028: ldarg.0
IL_0029: call System.String System.String::Concat(System.String,System.String)
IL_002e: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_0033: ldnull
IL_0034: ret
METHOD TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Services.Persistence.DataService::GetBioKeywordByPluginDbTriggerName(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0005: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeyword> TheForestOfLove.Narrative.DataManifest::bioKeywordsByPluginDbTriggerName
IL_000a: ldarg.0
IL_000b: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeyword>::ContainsKey(!0)
IL_0010: brfalse.s IL_0023
IL_0012: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0017: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeyword> TheForestOfLove.Narrative.DataManifest::bioKeywordsByPluginDbTriggerName
IL_001c: ldarg.0
IL_001d: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeyword>::get_Item(!0)
IL_0022: ret
IL_0023: ldstr "data service cannot find bio keyword by plugin db trigger name "
IL_0028: ldarg.0
IL_0029: call System.String System.String::Concat(System.String,System.String)
IL_002e: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_0033: ldnull
IL_0034: ret
