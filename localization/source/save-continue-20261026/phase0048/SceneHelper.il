TYPE TheForestOfLove.Services.SceneManagement.SceneHelper
METHOD System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inGlitchRoom() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldstr "GlitchRoom"
IL_0005: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::InScene(System.String)
IL_000a: ret
METHOD System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inDustinMinigame() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldstr "DustinMinigame_Integrated"
IL_0005: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::InScene(System.String)
IL_000a: ret
METHOD System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inGameplayScene() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inAbbey()
IL_0005: brtrue.s IL_006f
IL_0007: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inBeaverHouse()
IL_000c: brtrue.s IL_006f
IL_000e: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inBunnyHouse()
IL_0013: brtrue.s IL_006f
IL_0015: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inCentralForest()
IL_001a: brtrue.s IL_006f
IL_001c: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inDeepWoods()
IL_0021: brtrue.s IL_006f
IL_0023: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inGlitchRoom()
IL_0028: brtrue.s IL_006f
IL_002a: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inIntroForest()
IL_002f: brtrue.s IL_006f
IL_0031: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inLake()
IL_0036: brtrue.s IL_006f
IL_0038: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inLakeRuins()
IL_003d: brtrue.s IL_006f
IL_003f: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inMountains()
IL_0044: brtrue.s IL_006f
IL_0046: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inMountainsBearCave()
IL_004b: brtrue.s IL_006f
IL_004d: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inOttershop()
IL_0052: brtrue.s IL_006f
IL_0054: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inOttershopBackRoom()
IL_0059: brtrue.s IL_006f
IL_005b: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inPlainsField()
IL_0060: brtrue.s IL_006f
IL_0062: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inPlainsEnd()
IL_0067: brtrue.s IL_006f
IL_0069: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inDustinMinigame()
IL_006e: ret
IL_006f: ldc.i4.1
IL_0070: ret
METHOD System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::InScene(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: call System.String TheForestOfLove.Services.SceneManagement.SceneHelper::get_CurrentSceneName()
IL_0005: brfalse.s IL_0013
IL_0007: call System.String TheForestOfLove.Services.SceneManagement.SceneHelper::get_CurrentSceneName()
IL_000c: ldarg.0
IL_000d: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0012: ret
IL_0013: ldc.i4.0
IL_0014: ret
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
