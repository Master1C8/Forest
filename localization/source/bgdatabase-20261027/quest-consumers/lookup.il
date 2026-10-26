TYPE TheForestOfLove.Services.Persistence.DataService
METHOD TheForestOfLove.Narrative.Quest TheForestOfLove.Services.Persistence.DataService::GetQuestByDbName(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0005: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Quest> TheForestOfLove.Narrative.DataManifest::questsByDbName
IL_000a: ldarg.0
IL_000b: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Quest>::ContainsKey(!0)
IL_0010: brfalse.s IL_0023
IL_0012: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0017: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Quest> TheForestOfLove.Narrative.DataManifest::questsByDbName
IL_001c: ldarg.0
IL_001d: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Quest>::get_Item(!0)
IL_0022: ret
IL_0023: ldstr "data service cannot find quest by name "
IL_0028: ldarg.0
IL_0029: call System.String System.String::Concat(System.String,System.String)
IL_002e: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_0033: ldnull
IL_0034: ret
METHOD TheForestOfLove.Narrative.QuestProgressLogEntry TheForestOfLove.Services.Persistence.DataService::GetQuestProgressLogByDbName(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0005: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.QuestProgressLogEntry> TheForestOfLove.Narrative.DataManifest::questProgressLogEntriesByDbName
IL_000a: ldarg.0
IL_000b: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.QuestProgressLogEntry>::ContainsKey(!0)
IL_0010: brfalse.s IL_0023
IL_0012: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0017: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.QuestProgressLogEntry> TheForestOfLove.Narrative.DataManifest::questProgressLogEntriesByDbName
IL_001c: ldarg.0
IL_001d: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.QuestProgressLogEntry>::get_Item(!0)
IL_0022: ret
IL_0023: ldstr "data service cannot find quest progress log by name "
IL_0028: ldarg.0
IL_0029: call System.String System.String::Concat(System.String,System.String)
IL_002e: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_0033: ldnull
IL_0034: ret
