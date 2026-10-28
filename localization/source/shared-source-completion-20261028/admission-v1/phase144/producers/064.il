TYPE TheForestOfLove.DustinMinigameController
METHOD System.Void TheForestOfLove.DustinMinigameController::FinishAbortMinigame() | attributes=Public, HideBySig | impl=IL
IL_0000: ldc.i4.1
IL_0001: stsfld System.Boolean TheForestOfLove.DustinMinigameController::ForfeitedLastRound
IL_0006: call T TheForestOfLove.Services.ServiceLocator::Get<TheForestOfLove.Audio.DustinMinigameSoundManagerBridge>()
IL_000b: stloc.0
IL_000c: ldloc.0
IL_000d: ldnull
IL_000e: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0013: brfalse.s IL_001b
IL_0015: ldloc.0
IL_0016: callvirt System.Void TheForestOfLove.Audio.DustinMinigameSoundManagerBridge::ResetVolume()
IL_001b: ldstr "CentralForest"
IL_0020: ldstr "dustin_minigame_spawn_point"
IL_0025: ldc.i4.3
IL_0026: newobj System.Void System.Nullable`1<TheForestOfLove.Direction>::.ctor(!0)
IL_002b: call System.Void TheForestOfLove.SpawnManager::ReplaceSpawnData(System.String,System.String,System.Nullable`1<TheForestOfLove.Direction>)
IL_0030: ret
