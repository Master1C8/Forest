TYPE TheForestOfLove.Services.Persistence.PlayerRespawnData
METHOD System.Void TheForestOfLove.Services.Persistence.PlayerRespawnData::Load(TheForestOfLove.Services.Persistence.SavegamePlayerRespawnData) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: brtrue.s IL_0004
IL_0003: ret
IL_0004: ldarg.0
IL_0005: ldarg.1
IL_0006: ldfld System.String TheForestOfLove.Services.Persistence.SavegamePlayerRespawnData::currentAreaSavekey
IL_000b: brtrue.s IL_0015
IL_000d: ldarg.0
IL_000e: ldfld System.String TheForestOfLove.Services.Persistence.PlayerRespawnData::currentAreaUnitySceneName
IL_0013: br.s IL_0025
IL_0015: ldarg.1
IL_0016: ldfld System.String TheForestOfLove.Services.Persistence.SavegamePlayerRespawnData::currentAreaSavekey
IL_001b: call TheForestOfLove.Narrative.AreaRecord TheForestOfLove.Services.Persistence.DataService::GetAreaRecordBySavekey(System.String)
IL_0020: ldfld System.String TheForestOfLove.Narrative.AreaRecord::unitySceneName
IL_0025: stfld System.String TheForestOfLove.Services.Persistence.PlayerRespawnData::currentAreaUnitySceneName
IL_002a: ldarg.0
IL_002b: ldarg.1
IL_002c: ldfld System.String TheForestOfLove.Services.Persistence.SavegamePlayerRespawnData::lastAreaSavekey
IL_0031: brtrue.s IL_003b
IL_0033: ldarg.0
IL_0034: ldfld System.String TheForestOfLove.Services.Persistence.PlayerRespawnData::lastAreaUnitySceneName
IL_0039: br.s IL_004b
IL_003b: ldarg.1
IL_003c: ldfld System.String TheForestOfLove.Services.Persistence.SavegamePlayerRespawnData::lastAreaSavekey
IL_0041: call TheForestOfLove.Narrative.AreaRecord TheForestOfLove.Services.Persistence.DataService::GetAreaRecordBySavekey(System.String)
IL_0046: ldfld System.String TheForestOfLove.Narrative.AreaRecord::unitySceneName
IL_004b: stfld System.String TheForestOfLove.Services.Persistence.PlayerRespawnData::lastAreaUnitySceneName
IL_0050: ldarg.0
IL_0051: ldarg.1
IL_0052: ldfld UnityEngine.Vector3 TheForestOfLove.Services.Persistence.SavegamePlayerRespawnData::lastPosition
IL_0057: stfld UnityEngine.Vector3 TheForestOfLove.Services.Persistence.PlayerRespawnData::lastPosition
IL_005c: ldarg.0
IL_005d: ldarg.1
IL_005e: ldfld UnityEngine.Vector3 TheForestOfLove.Services.Persistence.SavegamePlayerRespawnData::lastSpawnPosition
IL_0063: stfld UnityEngine.Vector3 TheForestOfLove.Services.Persistence.PlayerRespawnData::lastSpawnPosition
IL_0068: ldarg.0
IL_0069: ldarg.1
IL_006a: ldfld System.Boolean TheForestOfLove.Services.Persistence.SavegamePlayerRespawnData::lastPositionExact
IL_006f: stfld System.Boolean TheForestOfLove.Services.Persistence.PlayerRespawnData::lastPositionExact
IL_0074: ldarg.0
IL_0075: ldarg.1
IL_0076: ldfld System.Boolean TheForestOfLove.Services.Persistence.SavegamePlayerRespawnData::isSwimming
IL_007b: stfld System.Boolean TheForestOfLove.Services.Persistence.PlayerRespawnData::isSwimming
IL_0080: ldarg.0
IL_0081: ldarg.1
IL_0082: ldfld System.String TheForestOfLove.Services.Persistence.SavegamePlayerRespawnData::cameraSettingsObjectName
IL_0087: stfld System.String TheForestOfLove.Services.Persistence.PlayerRespawnData::cameraSettingsObjectName
IL_008c: ldarg.0
IL_008d: ldarg.1
IL_008e: ldfld System.Boolean TheForestOfLove.Services.Persistence.SavegamePlayerRespawnData::isFastTraveling
IL_0093: stfld System.Boolean TheForestOfLove.Services.Persistence.PlayerRespawnData::isFastTraveling
IL_0098: ldarg.1
IL_0099: ldfld System.String TheForestOfLove.Services.Persistence.SavegamePlayerRespawnData::fastTravelingFromAreaSavekey
IL_009e: brfalse.s IL_00c4
IL_00a0: ldarg.1
IL_00a1: ldfld System.String TheForestOfLove.Services.Persistence.SavegamePlayerRespawnData::fastTravelingFromAreaSavekey
IL_00a6: call TheForestOfLove.Narrative.AreaRecord TheForestOfLove.Services.Persistence.DataService::GetAreaRecordBySavekey(System.String)
IL_00ab: stloc.0
IL_00ac: ldarg.0
IL_00ad: ldloc.0
IL_00ae: ldfld System.String TheForestOfLove.Narrative.AreaRecord::unitySceneName
IL_00b3: stfld System.String TheForestOfLove.Services.Persistence.PlayerRespawnData::fastTravelingFromUnitySceneName
IL_00b8: ldarg.0
IL_00b9: ldloc.0
IL_00ba: ldfld System.String TheForestOfLove.Narrative.AreaRecord::savekey
IL_00bf: stfld System.String TheForestOfLove.Services.Persistence.PlayerRespawnData::fastTravelingFromAreaSavekey
IL_00c4: ldarg.1
IL_00c5: ldfld System.String TheForestOfLove.Services.Persistence.SavegamePlayerRespawnData::fastTravelingToAreaSavekey
IL_00ca: brfalse.s IL_00f0
IL_00cc: ldarg.1
IL_00cd: ldfld System.String TheForestOfLove.Services.Persistence.SavegamePlayerRespawnData::fastTravelingToAreaSavekey
IL_00d2: call TheForestOfLove.Narrative.AreaRecord TheForestOfLove.Services.Persistence.DataService::GetAreaRecordBySavekey(System.String)
IL_00d7: stloc.1
IL_00d8: ldarg.0
IL_00d9: ldloc.1
IL_00da: ldfld System.String TheForestOfLove.Narrative.AreaRecord::unitySceneName
IL_00df: stfld System.String TheForestOfLove.Services.Persistence.PlayerRespawnData::fastTravelingToUnitySceneName
IL_00e4: ldarg.0
IL_00e5: ldloc.1
IL_00e6: ldfld System.String TheForestOfLove.Narrative.AreaRecord::savekey
IL_00eb: stfld System.String TheForestOfLove.Services.Persistence.PlayerRespawnData::fastTravelingToAreaSavekey
IL_00f0: ret
