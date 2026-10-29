TYPE TheForestOfLove.PauseScreenUIManager
METHOD System.Void TheForestOfLove.PauseScreenUIManager::OnPause() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.PauseScreenUiController TheForestOfLove.PauseScreenUIManager::pauseScreenUi
IL_0006: callvirt System.Boolean TheForestOfLove.UIPanelController::get_isOpen()
IL_000b: brfalse.s IL_000e
IL_000d: ret
IL_000e: ldarg.0
IL_000f: ldfld TheForestOfLove.PauseScreenUiController TheForestOfLove.PauseScreenUIManager::pauseScreenUi
IL_0014: callvirt System.Void TheForestOfLove.UIPanelController::Open()
IL_0019: ret
METHOD System.Void TheForestOfLove.PauseScreenUIManager::OnResume() | attributes=Private, HideBySig | impl=IL
IL_0000: call System.Boolean TheForestOfLove.PauseHelper::get_isPaused()
IL_0005: brtrue.s IL_0008
IL_0007: ret
IL_0008: call System.Void TheForestOfLove.PauseHelper::Resume()
IL_000d: ldarg.0
IL_000e: ldfld TheForestOfLove.PauseScreenUiController TheForestOfLove.PauseScreenUIManager::pauseScreenUi
IL_0013: callvirt System.Void TheForestOfLove.UIPanelController::Close()
IL_0018: ret
