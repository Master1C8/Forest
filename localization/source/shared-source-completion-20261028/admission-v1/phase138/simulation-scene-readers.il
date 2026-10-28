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
