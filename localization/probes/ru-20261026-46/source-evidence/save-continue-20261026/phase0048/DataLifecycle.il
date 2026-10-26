TYPE TheForestOfLove.Services.Persistence.DataService
METHOD TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest() | attributes=Private, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld TheForestOfLove.Services.Persistence.DataService TheForestOfLove.Services.Persistence.DataService::_instance
IL_0005: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::_manifest
IL_000a: ret
METHOD System.Void TheForestOfLove.Services.Persistence.DataService::Awake() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.Core.BaseBehavior::Awake()
IL_0006: ldarg.0
IL_0007: call System.Void TheForestOfLove.Services.Persistence.DataService::GenerateManifest()
IL_000c: ret
METHOD System.Void TheForestOfLove.Services.Persistence.DataService::RegisterServices() | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.Core.BaseBehavior::RegisterServices()
IL_0006: ldarg.0
IL_0007: call System.Void TheForestOfLove.Services.ServiceLocator::Register<TheForestOfLove.Services.Persistence.DataService>(T)
IL_000c: ldarg.0
IL_000d: stsfld TheForestOfLove.Services.Persistence.DataService TheForestOfLove.Services.Persistence.DataService::_instance
IL_0012: ret
METHOD System.Void TheForestOfLove.Services.Persistence.DataService::UnregisterServices() | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.Core.BaseBehavior::UnregisterServices()
IL_0006: ldarg.0
IL_0007: call System.Void TheForestOfLove.Services.ServiceLocator::Unregister<TheForestOfLove.Services.Persistence.DataService>(T)
IL_000c: ldnull
IL_000d: stsfld TheForestOfLove.Services.Persistence.DataService TheForestOfLove.Services.Persistence.DataService::_instance
IL_0012: ret
METHOD System.Collections.Generic.IEnumerable`1<TheForestOfLove.Narrative.Tag> TheForestOfLove.Services.Persistence.DataService::GetActiveTags() | attributes=Public, Static, HideBySig | impl=IL
IL_0000: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0005: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Tag> TheForestOfLove.Narrative.DataManifest::activeTagsByDbName
IL_000a: callvirt System.Collections.Generic.Dictionary`2/ValueCollection<!0,!1> System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Tag>::get_Values()
IL_000f: ret
METHOD TheForestOfLove.Narrative.Trigger TheForestOfLove.Services.Persistence.DataService::GetTriggerByName(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0005: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Trigger> TheForestOfLove.Narrative.DataManifest::triggersByTriggerName
IL_000a: ldarg.0
IL_000b: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Trigger>::ContainsKey(!0)
IL_0010: brfalse.s IL_0023
IL_0012: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0017: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Trigger> TheForestOfLove.Narrative.DataManifest::triggersByTriggerName
IL_001c: ldarg.0
IL_001d: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Trigger>::get_Item(!0)
IL_0022: ret
IL_0023: ldnull
IL_0024: ret
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
METHOD TheForestOfLove.Narrative.Dialogue TheForestOfLove.Services.Persistence.DataService::GetDialogueByDbName(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0005: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DataManifest::dialoguesByDbName
IL_000a: ldarg.0
IL_000b: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Dialogue>::ContainsKey(!0)
IL_0010: brfalse.s IL_0023
IL_0012: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0017: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DataManifest::dialoguesByDbName
IL_001c: ldarg.0
IL_001d: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Dialogue>::get_Item(!0)
IL_0022: ret
IL_0023: ldstr "data service cannot find dialogue by name "
IL_0028: ldarg.0
IL_0029: call System.String System.String::Concat(System.String,System.String)
IL_002e: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_0033: ldnull
IL_0034: ret
METHOD TheForestOfLove.Services.Persistence.GeneralData TheForestOfLove.Services.Persistence.DataService::GetGeneralData() | attributes=Public, Static, HideBySig | impl=IL
IL_0000: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0005: ldfld TheForestOfLove.Services.Persistence.GeneralData TheForestOfLove.Narrative.DataManifest::generalData
IL_000a: ret
METHOD TheForestOfLove.Services.Persistence.PlayerRespawnData TheForestOfLove.Services.Persistence.DataService::GetPlayerRespawnData() | attributes=Public, Static, HideBySig | impl=IL
IL_0000: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0005: ldfld TheForestOfLove.Services.Persistence.PlayerRespawnData TheForestOfLove.Narrative.DataManifest::playerRespawnData
IL_000a: ret
