TYPE TheForestOfLove.Services.SceneManagement.SceneHelper
METHOD System.Void TheForestOfLove.Services.SceneManagement.SceneHelper::UpdateCurrentSceneName(System.String) | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: ldstr "Test_AllCritters"
IL_0006: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_000b: brfalse.s IL_0014
IL_000d: ldsfld System.String TheForestOfLove.DevTools.SimulateGameplayVariables::currentSimScene
IL_0012: starg.s name
IL_0014: ldarg.0
IL_0015: ldarg.1
IL_0016: call System.Void TheForestOfLove.Services.SceneManagement.SceneHelperBase::UpdateCurrentSceneName(System.String)
IL_001b: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inGameplayScene()
IL_0020: brfalse.s IL_0043
IL_0022: call System.String TheForestOfLove.Services.SceneManagement.SceneHelper::get_CurrentGameplaySceneName()
IL_0027: call System.String TheForestOfLove.Services.SceneManagement.SceneHelper::get_CurrentSceneName()
IL_002c: call System.Boolean System.String::op_Inequality(System.String,System.String)
IL_0031: brfalse.s IL_0043
IL_0033: call System.String TheForestOfLove.Services.SceneManagement.SceneHelper::get_CurrentGameplaySceneName()
IL_0038: call System.Void TheForestOfLove.Services.SceneManagement.SceneHelper::set_LastGameplaySceneName(System.String)
IL_003d: ldarg.1
IL_003e: call System.Void TheForestOfLove.Services.SceneManagement.SceneHelper::set_CurrentGameplaySceneName(System.String)
IL_0043: ret
METHOD System.String TheForestOfLove.Services.SceneManagement.SceneHelper::GetCurrentSceneRealOrSimName() | attributes=Private, Static, HideBySig | impl=IL
IL_0000: call UnityEngine.SceneManagement.Scene UnityEngine.SceneManagement.SceneManager::GetActiveScene()
IL_0005: stloc.0
IL_0006: ldloca.s V_0
IL_0008: call System.String UnityEngine.SceneManagement.Scene::get_name()
IL_000d: ldstr "Test_AllCritters"
IL_0012: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0017: brfalse.s IL_001f
IL_0019: ldsfld System.String TheForestOfLove.DevTools.SimulateGameplayVariables::currentSimScene
IL_001e: ret
IL_001f: ldsfld TheForestOfLove.Services.SceneManagement.SceneHelper TheForestOfLove.Services.SceneManagement.SceneHelper::current
IL_0024: callvirt System.String TheForestOfLove.Services.SceneManagement.SceneHelperBase::get_currentSceneName()
IL_0029: ret
METHOD System.String TheForestOfLove.Services.SceneManagement.SceneHelper::GetLastSceneRealOrSimName() | attributes=Private, Static, HideBySig | impl=IL
IL_0000: call UnityEngine.SceneManagement.Scene UnityEngine.SceneManagement.SceneManager::GetActiveScene()
IL_0005: stloc.0
IL_0006: ldloca.s V_0
IL_0008: call System.String UnityEngine.SceneManagement.Scene::get_name()
IL_000d: ldstr "Test_AllCritters"
IL_0012: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0017: brfalse.s IL_001f
IL_0019: ldsfld System.String TheForestOfLove.DevTools.SimulateGameplayVariables::lastSimScene
IL_001e: ret
IL_001f: ldsfld TheForestOfLove.Services.SceneManagement.SceneHelper TheForestOfLove.Services.SceneManagement.SceneHelper::current
IL_0024: callvirt System.String TheForestOfLove.Services.SceneManagement.SceneHelperBase::get_lastSceneName()
IL_0029: ret
METHOD System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::InScene(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: call System.String TheForestOfLove.Services.SceneManagement.SceneHelper::get_CurrentSceneName()
IL_0005: brfalse.s IL_0013
IL_0007: call System.String TheForestOfLove.Services.SceneManagement.SceneHelper::get_CurrentSceneName()
IL_000c: ldarg.0
IL_000d: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0012: ret
IL_0013: ldc.i4.0
IL_0014: ret
METHOD System.Void TheForestOfLove.Services.SceneManagement.SceneHelper::LoadScene(System.String,UnityEngine.SceneManagement.LoadSceneMode) | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: call System.Int32 TheForestOfLove.Services.SceneManagement.SceneHelper::get_totalSceneLoads()
IL_0005: ldc.i4.1
IL_0006: add
IL_0007: call System.Void TheForestOfLove.Services.SceneManagement.SceneHelper::set_totalSceneLoads(System.Int32)
IL_000c: ldarg.0
IL_000d: ldc.i4.0
IL_000e: stfld System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelperBase::usingIntermediateLoadingScene
IL_0013: ldarg.0
IL_0014: ldnull
IL_0015: stfld System.String TheForestOfLove.Services.SceneManagement.SceneHelperBase::intermediateLoadingSceneName
IL_001a: ldarg.0
IL_001b: ldarg.1
IL_001c: ldarg.2
IL_001d: call System.Void TheForestOfLove.Services.SceneManagement.SceneHelperBase::LoadScene(System.String,UnityEngine.SceneManagement.LoadSceneMode)
IL_0022: ret
METHOD System.Void TheForestOfLove.Services.SceneManagement.SceneHelper::LoadScene(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldsfld TheForestOfLove.Services.SceneManagement.SceneHelper TheForestOfLove.Services.SceneManagement.SceneHelper::current
IL_0005: ldarg.0
IL_0006: callvirt System.Void TheForestOfLove.Services.SceneManagement.SceneHelperBase::LoadSceneSingle(System.String)
IL_000b: ret
