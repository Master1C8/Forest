TYPE TheForestOfLove.Services.SceneManagement.SceneHelper
METHOD System.Void TheForestOfLove.Services.SceneManagement.SceneHelper::LoadSoftResetScene(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: stsfld System.String Globals::softResetFollowupScene
IL_0006: ldstr "SoftResetLoadingScene"
IL_000b: call System.Void TheForestOfLove.Services.SceneManagement.SceneHelper::LoadScene(System.String)
IL_0010: ret
