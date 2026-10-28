TYPE TheForestOfLove.Services.SceneManagement.DebugSceneService
METHOD System.Void TheForestOfLove.Services.SceneManagement.DebugSceneService::Update() | attributes=Private, HideBySig | impl=IL
IL_0000: ldc.i4.s 50
IL_0002: call System.Boolean UnityEngine.Input::GetKeyDown(UnityEngine.KeyCode)
IL_0007: brfalse.s IL_0013
IL_0009: ldstr "BeaverHouse"
IL_000e: call System.Void TheForestOfLove.Services.SceneManagement.SceneHelper::LoadSceneAdditive(System.String)
IL_0013: ldc.i4.s 51
IL_0015: call System.Boolean UnityEngine.Input::GetKeyDown(UnityEngine.KeyCode)
IL_001a: brfalse.s IL_0026
IL_001c: ldstr "BunnyHouse"
IL_0021: call System.Void TheForestOfLove.Services.SceneManagement.SceneHelper::LoadSceneAdditive(System.String)
IL_0026: ret
