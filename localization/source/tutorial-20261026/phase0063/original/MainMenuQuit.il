TYPE TheForestOfLove.MainMenuController
METHOD System.Void TheForestOfLove.MainMenuController::Quit() | attributes=Private, HideBySig | impl=IL
IL_0000: call System.Void TheForestOfLove.Services.Persistence.SaveManager::SilentSaveGlobalDataOnly()
IL_0005: call System.Void TheForestOfLove.QuitHelper::Quit()
IL_000a: ret
