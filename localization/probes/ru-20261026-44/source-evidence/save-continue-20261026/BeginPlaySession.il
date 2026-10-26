TYPE TheForestOfLove.Events.GameStateManager
METHOD System.Void TheForestOfLove.Events.GameStateManager::Start() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.Core.BaseBehavior::Start()
IL_0006: ldsfld System.Boolean Globals::isFinishingSoftReset
IL_000b: brfalse.s IL_0037
IL_000d: ldc.i4.0
IL_000e: stsfld System.Boolean Globals::isFinishingSoftReset
IL_0013: ldsfld System.Action TheForestOfLove.Events.GameStateManager/<>c::<>9__34_0
IL_0018: dup
IL_0019: brtrue.s IL_0032
IL_001b: pop
IL_001c: ldsfld TheForestOfLove.Events.GameStateManager/<>c TheForestOfLove.Events.GameStateManager/<>c::<>9
IL_0021: ldftn System.Void TheForestOfLove.Events.GameStateManager/<>c::<Start>b__34_0()
IL_0027: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_002c: dup
IL_002d: stsfld System.Action TheForestOfLove.Events.GameStateManager/<>c::<>9__34_0
IL_0032: call System.Void TheForestOfLove.Core.Timing.TimerHelper::NextUpdate(System.Action)
IL_0037: ret
METHOD System.Void TheForestOfLove.Events.GameStateManager::BeginPlaySession() | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldc.i4.1
IL_0001: call System.Void Globals::set_IgnoreOriginDoorwayDuringRespawn(System.Boolean)
IL_0006: call System.Boolean TheForestOfLove.Services.Persistence.SaveManager::get_HasSavedPlaySession()
IL_000b: brfalse.s IL_0043
IL_000d: call TheForestOfLove.Services.Persistence.PlayerRespawnData TheForestOfLove.Services.Persistence.DataService::GetPlayerRespawnData()
IL_0012: dup
IL_0013: ldfld System.String TheForestOfLove.Services.Persistence.PlayerRespawnData::currentAreaUnitySceneName
IL_0018: dup
IL_0019: brtrue.s IL_0021
IL_001b: pop
IL_001c: ldstr "IntroForest"
IL_0021: stloc.0
IL_0022: ldfld System.String TheForestOfLove.Services.Persistence.PlayerRespawnData::currentAreaUnitySceneName
IL_0027: ldstr "DustinMinigame_Integrated"
IL_002c: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0031: brtrue.s IL_0036
IL_0033: ldloc.0
IL_0034: br.s IL_003b
IL_0036: ldstr "CentralForest"
IL_003b: stloc.0
IL_003c: ldloc.0
IL_003d: call System.Void UnityEngine.SceneManagement.SceneManager::LoadScene(System.String)
IL_0042: ret
IL_0043: call System.Void TheForestOfLove.Services.Persistence.SaveManager::SetupDefaultTags()
IL_0048: ldstr "IntroForest"
IL_004d: call System.Void TheForestOfLove.Services.SceneManagement.SceneHelper::LoadScene(System.String)
IL_0052: ret
