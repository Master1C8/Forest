TYPE TheForestOfLove.PauseScreenUIManager
METHOD System.Void TheForestOfLove.PauseScreenUIManager::Quit() | attributes=Private, HideBySig | impl=IL
IL_0000: ldstr "exited game"
IL_0005: call System.Void TheForestOfLove.GameplayLogManager::AddEventLog(System.String)
IL_000a: call System.Void TheForestOfLove.Services.Persistence.SaveManager::SilentSave()
IL_000f: call System.Void TheForestOfLove.QuitHelper::Quit()
IL_0014: ret
