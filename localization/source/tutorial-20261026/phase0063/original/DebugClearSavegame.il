TYPE TheForestOfLove.DebugHelper
METHOD System.Void TheForestOfLove.DebugHelper::DebugClearSavegame() | attributes=Private, HideBySig | impl=IL
IL_0000: call System.Boolean TheForestOfLove.BugReportMenu::get_IsInKeyboardMode()
IL_0005: brtrue.s IL_0044
IL_0007: ldc.i4 279
IL_000c: call System.Boolean UnityEngine.Input::GetKeyDown(UnityEngine.KeyCode)
IL_0011: brfalse.s IL_0044
IL_0013: ldc.i4 304
IL_0018: call System.Boolean UnityEngine.Input::GetKey(UnityEngine.KeyCode)
IL_001d: brtrue.s IL_002b
IL_001f: ldc.i4 303
IL_0024: call System.Boolean UnityEngine.Input::GetKey(UnityEngine.KeyCode)
IL_0029: brfalse.s IL_0044
IL_002b: call System.Void TheForestOfLove.Services.Persistence.SaveManager::DeleteSavedPlaySession()
IL_0030: call System.Void TheForestOfLove.Services.Persistence.SaveManager::DeleteGlobalSettings()
IL_0035: ldstr "debug cleared savestate"
IL_003a: call System.Void UnityEngine.Debug::Log(System.Object)
IL_003f: call System.Void UnityEngine.Application::Quit()
IL_0044: ret
