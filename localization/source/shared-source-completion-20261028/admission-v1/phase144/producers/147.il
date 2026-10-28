TYPE TheForestOfLove.Services.SceneManagement.SceneHelper
METHOD System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inAbbey() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldstr "abbey"
IL_0005: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::InScenePartialMatch(System.String)
IL_000a: ret
METHOD System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inDeepWoods() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldstr "deepwoods"
IL_0005: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::InScenePartialMatch(System.String)
IL_000a: ret
METHOD System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inIntroForest() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldstr "introforest"
IL_0005: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::InScenePartialMatch(System.String)
IL_000a: ret
METHOD System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inTestScene() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldstr "test"
IL_0005: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::InScenePartialMatchRaw(System.String)
IL_000a: ret
METHOD System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inLoadingScene() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldstr "loading"
IL_0005: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::InScenePartialMatch(System.String)
IL_000a: ret
