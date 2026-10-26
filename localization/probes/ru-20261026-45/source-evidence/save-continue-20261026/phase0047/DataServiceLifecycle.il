TYPE TheForestOfLove.Services.Persistence.DataService
METHOD System.Void TheForestOfLove.Services.Persistence.DataService::Awake() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.Core.BaseBehavior::Awake()
IL_0006: ldarg.0
IL_0007: call System.Void TheForestOfLove.Services.Persistence.DataService::GenerateManifest()
IL_000c: ret
METHOD TheForestOfLove.Services.Persistence.GeneralData TheForestOfLove.Services.Persistence.DataService::GetGeneralData() | attributes=Public, Static, HideBySig | impl=IL
IL_0000: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0005: ldfld TheForestOfLove.Services.Persistence.GeneralData TheForestOfLove.Narrative.DataManifest::generalData
IL_000a: ret
METHOD TheForestOfLove.Services.Persistence.PlayerRespawnData TheForestOfLove.Services.Persistence.DataService::GetPlayerRespawnData() | attributes=Public, Static, HideBySig | impl=IL
IL_0000: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0005: ldfld TheForestOfLove.Services.Persistence.PlayerRespawnData TheForestOfLove.Narrative.DataManifest::playerRespawnData
IL_000a: ret
