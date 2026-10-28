TYPE TheForestOfLove.Services.SceneManagement.SceneHelper
METHOD System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::InScenePartialMatch(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: call System.String TheForestOfLove.Services.SceneManagement.SceneHelper::get_CurrentSceneName()
IL_0005: brfalse.s IL_0020
IL_0007: ldarg.0
IL_0008: brfalse.s IL_0020
IL_000a: call System.String TheForestOfLove.Services.SceneManagement.SceneHelper::get_CurrentSceneName()
IL_000f: callvirt System.String System.String::ToLower()
IL_0014: ldarg.0
IL_0015: callvirt System.String System.String::ToLower()
IL_001a: callvirt System.Boolean System.String::Contains(System.String)
IL_001f: ret
IL_0020: ldc.i4.0
IL_0021: ret
METHOD System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::InScenePartialMatchRaw(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: call UnityEngine.SceneManagement.Scene UnityEngine.SceneManagement.SceneManager::GetActiveScene()
IL_0005: stloc.0
IL_0006: ldloca.s V_0
IL_0008: call System.String UnityEngine.SceneManagement.Scene::get_name()
IL_000d: callvirt System.String System.String::ToLower()
IL_0012: ldarg.0
IL_0013: callvirt System.String System.String::ToLower()
IL_0018: callvirt System.Boolean System.String::Contains(System.String)
IL_001d: ret
METHOD System.Void TheForestOfLove.Services.SceneManagement.SceneHelper::LoadSceneAdditive(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldsfld TheForestOfLove.Services.SceneManagement.SceneHelper TheForestOfLove.Services.SceneManagement.SceneHelper::current
IL_0005: ldarg.0
IL_0006: callvirt System.Void TheForestOfLove.Services.SceneManagement.SceneHelperBase::LoadSceneAdditive(System.String)
IL_000b: ret
