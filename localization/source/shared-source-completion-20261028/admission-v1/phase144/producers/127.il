TYPE TheForestOfLove.PauseScreenUIManager
METHOD System.Void TheForestOfLove.PauseScreenUIManager::LoadStartMenu() | attributes=Private, HideBySig | impl=IL
IL_0000: ldstr "loaded start menu"
IL_0005: call System.Void TheForestOfLove.GameplayLogManager::AddEventLog(System.String)
IL_000a: call System.Void TheForestOfLove.Services.Persistence.SaveManager::SilentSave()
IL_000f: ldarg.0
IL_0010: call System.Void TheForestOfLove.PauseScreenUIManager::OnResume()
IL_0015: ldstr "StartMenu"
IL_001a: call System.Void TheForestOfLove.Services.SceneManagement.SceneHelper::LoadSoftResetScene(System.String)
IL_001f: ret
METHOD System.Void TheForestOfLove.PauseScreenUIManager::LoadCentralForest() | attributes=Private, HideBySig | impl=IL
IL_0000: ldstr "loaded central forest"
IL_0005: call System.Void TheForestOfLove.GameplayLogManager::AddEventLog(System.String)
IL_000a: ldarg.0
IL_000b: call System.Void TheForestOfLove.PauseScreenUIManager::OnResume()
IL_0010: ldstr "CentralForest"
IL_0015: call System.Void TheForestOfLove.Services.SceneManagement.SceneHelper::LoadScene(System.String)
IL_001a: ret
METHOD System.Void TheForestOfLove.PauseScreenUIManager::LoadDustinMinigame() | attributes=Private, HideBySig | impl=IL
IL_0000: ldstr "loaded dustin minigame"
IL_0005: call System.Void TheForestOfLove.GameplayLogManager::AddEventLog(System.String)
IL_000a: ldarg.0
IL_000b: call System.Void TheForestOfLove.PauseScreenUIManager::OnResume()
IL_0010: ldstr "DustinMinigame_Integrated"
IL_0015: call System.Void TheForestOfLove.Services.SceneManagement.SceneHelper::LoadScene(System.String)
IL_001a: ret
METHOD System.Void TheForestOfLove.PauseScreenUIManager::Quit() | attributes=Private, HideBySig | impl=IL
IL_0000: ldstr "exited game"
IL_0005: call System.Void TheForestOfLove.GameplayLogManager::AddEventLog(System.String)
IL_000a: call System.Void TheForestOfLove.Services.Persistence.SaveManager::SilentSave()
IL_000f: call System.Void TheForestOfLove.QuitHelper::Quit()
IL_0014: ret
