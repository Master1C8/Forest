TYPE TheForestOfLove.SpawnManager
METHOD System.Void TheForestOfLove.SpawnManager::ReplaceSpawnData(System.String,System.String,System.Nullable`1<TheForestOfLove.Direction>) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: call TheForestOfLove.Services.Persistence.PlayerRespawnData TheForestOfLove.Services.Persistence.DataService::GetPlayerRespawnData()
IL_0005: dup
IL_0006: ldarg.0
IL_0007: stfld System.String TheForestOfLove.Services.Persistence.PlayerRespawnData::currentAreaUnitySceneName
IL_000c: dup
IL_000d: ldarg.1
IL_000e: stfld System.String TheForestOfLove.Services.Persistence.PlayerRespawnData::namedSpawnPoint
IL_0013: dup
IL_0014: ldarga.s playerDirection
IL_0016: call System.Boolean System.Nullable`1<TheForestOfLove.Direction>::get_HasValue()
IL_001b: stfld System.Boolean TheForestOfLove.Services.Persistence.PlayerRespawnData::hasPlayerDirection
IL_0020: dup
IL_0021: ldarga.s playerDirection
IL_0023: call System.Boolean System.Nullable`1<TheForestOfLove.Direction>::get_HasValue()
IL_0028: brtrue.s IL_002d
IL_002a: ldc.i4.0
IL_002b: br.s IL_0034
IL_002d: ldarga.s playerDirection
IL_002f: call !0 System.Nullable`1<TheForestOfLove.Direction>::get_Value()
IL_0034: stfld TheForestOfLove.Direction TheForestOfLove.Services.Persistence.PlayerRespawnData::playerDirection
IL_0039: dup
IL_003a: ldnull
IL_003b: stfld System.String TheForestOfLove.Services.Persistence.PlayerRespawnData::lastAreaUnitySceneName
IL_0040: dup
IL_0041: ldnull
IL_0042: stfld System.String TheForestOfLove.Services.Persistence.PlayerRespawnData::cameraSettingsObjectName
IL_0047: dup
IL_0048: ldflda UnityEngine.Vector3 TheForestOfLove.Services.Persistence.PlayerRespawnData::lastPosition
IL_004d: initobj UnityEngine.Vector3
IL_0053: dup
IL_0054: ldc.i4.0
IL_0055: stfld System.Boolean TheForestOfLove.Services.Persistence.PlayerRespawnData::lastPositionExact
IL_005a: dup
IL_005b: ldflda UnityEngine.Vector3 TheForestOfLove.Services.Persistence.PlayerRespawnData::lastSpawnPosition
IL_0060: initobj UnityEngine.Vector3
IL_0066: ldc.i4.0
IL_0067: stfld System.Boolean TheForestOfLove.Services.Persistence.PlayerRespawnData::isSwimming
IL_006c: ret
