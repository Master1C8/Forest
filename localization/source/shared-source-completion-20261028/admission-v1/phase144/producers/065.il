TYPE TheForestOfLove.DustinMinigameController/<>c
METHOD System.Void TheForestOfLove.DustinMinigameController/<>c::<OnMinigameEnd>b__24_0() | attributes=Assembly, HideBySig | impl=IL
IL_0000: call System.Void TheForestOfLove.CutsceneManager::ConstantBlack()
IL_0005: call T TheForestOfLove.Services.ServiceLocator::Get<TheForestOfLove.Audio.DustinMinigameSoundManagerBridge>()
IL_000a: stloc.0
IL_000b: ldloc.0
IL_000c: ldnull
IL_000d: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0012: brfalse.s IL_001a
IL_0014: ldloc.0
IL_0015: callvirt System.Void TheForestOfLove.Audio.DustinMinigameSoundManagerBridge::ResetVolume()
IL_001a: ldstr "CentralForest"
IL_001f: ldstr "dustin_minigame_spawn_point"
IL_0024: ldc.i4.3
IL_0025: newobj System.Void System.Nullable`1<TheForestOfLove.Direction>::.ctor(!0)
IL_002a: call System.Void TheForestOfLove.SpawnManager::ReplaceSpawnData(System.String,System.String,System.Nullable`1<TheForestOfLove.Direction>)
IL_002f: ldstr "CentralForest"
IL_0034: call System.Void TheForestOfLove.Services.SceneManagement.SceneHelper::LoadScene(System.String)
IL_0039: ret
METHOD System.Void TheForestOfLove.DustinMinigameController/<>c::<CheckGameOverStuff>b__26_1() | attributes=Assembly, HideBySig | impl=IL
IL_0000: call T TheForestOfLove.Services.ServiceLocator::Get<TheForestOfLove.Audio.DustinMinigameSoundManagerBridge>()
IL_0005: stloc.0
IL_0006: ldloc.0
IL_0007: ldnull
IL_0008: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_000d: brfalse.s IL_0015
IL_000f: ldloc.0
IL_0010: callvirt System.Void TheForestOfLove.Audio.DustinMinigameSoundManagerBridge::ResetVolume()
IL_0015: ldstr "CentralForest"
IL_001a: ldstr "dustin_minigame_spawn_point"
IL_001f: ldc.i4.3
IL_0020: newobj System.Void System.Nullable`1<TheForestOfLove.Direction>::.ctor(!0)
IL_0025: call System.Void TheForestOfLove.SpawnManager::ReplaceSpawnData(System.String,System.String,System.Nullable`1<TheForestOfLove.Direction>)
IL_002a: ldstr "CentralForest"
IL_002f: call System.Void TheForestOfLove.Services.SceneManagement.SceneHelper::LoadScene(System.String)
IL_0034: ret
