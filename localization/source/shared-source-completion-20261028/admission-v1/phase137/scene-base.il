TYPE TheForestOfLove.Services.SceneManagement.SceneHelperBase
METHOD System.Void TheForestOfLove.Services.SceneManagement.SceneHelperBase::LoadSceneSingle(System.String) | attributes=Public, Virtual, HideBySig, VtableLayoutMask | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: ldc.i4.0
IL_0003: call System.Void TheForestOfLove.Services.SceneManagement.SceneHelperBase::InitiateSceneLoad(System.String,UnityEngine.SceneManagement.LoadSceneMode)
IL_0008: ret
METHOD System.Void TheForestOfLove.Services.SceneManagement.SceneHelperBase::LoadScene(System.String,UnityEngine.SceneManagement.LoadSceneMode) | attributes=Family, Virtual, HideBySig, VtableLayoutMask | impl=IL
IL_0000: ldarg.1
IL_0001: ldarg.2
IL_0002: call System.Void UnityEngine.SceneManagement.SceneManager::LoadScene(System.String,UnityEngine.SceneManagement.LoadSceneMode)
IL_0007: ret
TYPE TheForestOfLove.Services.SceneManagement.SceneHelperBase
METHOD System.Void TheForestOfLove.Services.SceneManagement.SceneHelperBase::InitiateSceneLoad(System.String,UnityEngine.SceneManagement.LoadSceneMode) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: stfld System.String TheForestOfLove.Services.SceneManagement.SceneHelperBase::sceneToLoadName
IL_0007: ldarg.0
IL_0008: ldarg.0
IL_0009: call System.String TheForestOfLove.Services.SceneManagement.SceneHelperBase::get_currentSceneName()
IL_000e: stfld System.String TheForestOfLove.Services.SceneManagement.SceneHelperBase::sceneToUnloadName
IL_0013: ldarg.0
IL_0014: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.Services.SceneManagement.SceneHelperBase::onSceneLoadRequested
IL_0019: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_001e: ldarg.2
IL_001f: ldc.i4.1
IL_0020: bne.un.s IL_002f
IL_0022: ldarg.0
IL_0023: ldc.i4.1
IL_0024: stfld System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelperBase::loadingSceneAdditive
IL_0029: ldarg.0
IL_002a: callvirt System.Void TheForestOfLove.Services.SceneManagement.SceneHelperBase::DestroyGameObjectsDuringAdditiveLoad()
IL_002f: ldarg.0
IL_0030: ldfld System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelperBase::usingIntermediateLoadingScene
IL_0035: brfalse.s IL_004f
IL_0037: ldarg.0
IL_0038: ldarg.0
IL_0039: ldfld System.String TheForestOfLove.Services.SceneManagement.SceneHelperBase::intermediateLoadingSceneName
IL_003e: dup
IL_003f: brtrue.s IL_0048
IL_0041: pop
IL_0042: ldarg.0
IL_0043: ldfld System.String TheForestOfLove.Services.SceneManagement.SceneHelperBase::sceneToLoadName
IL_0048: callvirt System.Void TheForestOfLove.Services.SceneManagement.SceneHelperBase::UpdateCurrentSceneName(System.String)
IL_004d: br.s IL_005b
IL_004f: ldarg.0
IL_0050: ldarg.0
IL_0051: ldfld System.String TheForestOfLove.Services.SceneManagement.SceneHelperBase::sceneToLoadName
IL_0056: callvirt System.Void TheForestOfLove.Services.SceneManagement.SceneHelperBase::UpdateCurrentSceneName(System.String)
IL_005b: ldarg.0
IL_005c: ldarg.1
IL_005d: ldarg.2
IL_005e: callvirt System.Void TheForestOfLove.Services.SceneManagement.SceneHelperBase::LoadScene(System.String,UnityEngine.SceneManagement.LoadSceneMode)
IL_0063: ret
