TYPE TheForestOfLove.Services.SceneManagement.SoftResetLoadingFinisher
METHOD System.Void TheForestOfLove.Services.SceneManagement.SoftResetLoadingFinisher::Start() | attributes=Private, HideBySig | impl=IL
IL_0000: ldc.i4.1
IL_0001: stsfld System.Boolean Globals::isFinishingSoftReset
IL_0006: ldsfld System.String Globals::softResetFollowupScene
IL_000b: ldnull
IL_000c: stsfld System.String Globals::softResetFollowupScene
IL_0011: call System.Void UnityEngine.SceneManagement.SceneManager::LoadScene(System.String)
IL_0016: ret
