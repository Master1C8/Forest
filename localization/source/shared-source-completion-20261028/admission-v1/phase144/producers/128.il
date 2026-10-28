TYPE TheForestOfLove.PauseScreenUiController
METHOD System.Void TheForestOfLove.PauseScreenUiController::CheatsMenuBack() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.CheatsMenu TheForestOfLove.PauseScreenUiController::cheatsMenu
IL_0006: callvirt System.Void TheForestOfLove.UIPanelMenu::Close()
IL_000b: ldarg.0
IL_000c: ldfld TheForestOfLove.CheatsMenu TheForestOfLove.PauseScreenUiController::cheatsMenu
IL_0011: callvirt System.Boolean TheForestOfLove.CheatsMenu::get_unlockAllStoryChapters()
IL_0016: brfalse.s IL_0038
IL_0018: ldstr "cheats_unlock_all_story_chapters"
IL_001d: call System.String TheForestOfLove.Services.Persistence.DataService::GetVariable(System.String)
IL_0022: brtrue.s IL_0029
IL_0024: call System.Void TheForestOfLove.PauseScreenMainMenu::UnlockAllStoryChapters()
IL_0029: ldstr "cheats_unlock_all_story_chapters"
IL_002e: ldstr "true"
IL_0033: call System.Void TheForestOfLove.Services.Persistence.DataService::SetVariable(System.String,System.String)
IL_0038: ldarg.0
IL_0039: ldfld TheForestOfLove.CheatsMenu TheForestOfLove.PauseScreenUiController::cheatsMenu
IL_003e: callvirt System.Boolean TheForestOfLove.CheatsMenu::get_completeAllDates()
IL_0043: brfalse.s IL_0065
IL_0045: ldstr "cheats_complete_all_dates"
IL_004a: call System.String TheForestOfLove.Services.Persistence.DataService::GetVariable(System.String)
IL_004f: brtrue.s IL_0056
IL_0051: call System.Void TheForestOfLove.PauseScreenMainMenu::CompleteAllDates()
IL_0056: ldstr "cheats_complete_all_dates"
IL_005b: ldstr "true"
IL_0060: call System.Void TheForestOfLove.Services.Persistence.DataService::SetVariable(System.String,System.String)
IL_0065: ldarg.0
IL_0066: ldfld TheForestOfLove.CheatsMenu TheForestOfLove.PauseScreenUiController::cheatsMenu
IL_006b: callvirt System.Boolean TheForestOfLove.CheatsMenu::get_completeAllGossips()
IL_0070: brfalse.s IL_0092
IL_0072: ldstr "cheats_complete_all_gossips"
IL_0077: call System.String TheForestOfLove.Services.Persistence.DataService::GetVariable(System.String)
IL_007c: brtrue.s IL_0083
IL_007e: call System.Void TheForestOfLove.PauseScreenMainMenu::CompleteAllGossips()
IL_0083: ldstr "cheats_complete_all_gossips"
IL_0088: ldstr "true"
IL_008d: call System.Void TheForestOfLove.Services.Persistence.DataService::SetVariable(System.String,System.String)
IL_0092: ldarg.0
IL_0093: ldfld TheForestOfLove.CheatsMenu TheForestOfLove.PauseScreenUiController::cheatsMenu
IL_0098: callvirt System.Boolean TheForestOfLove.CheatsMenu::get_dustinMinigameInvincible()
IL_009d: brfalse.s IL_00b0
IL_009f: ldstr "cheats_dustin_minigame_invincible"
IL_00a4: ldstr "true"
IL_00a9: call System.Void TheForestOfLove.Services.Persistence.DataService::SetVariable(System.String,System.String)
IL_00ae: br.s IL_00bb
IL_00b0: ldstr "cheats_dustin_minigame_invincible"
IL_00b5: ldnull
IL_00b6: call System.Void TheForestOfLove.Services.Persistence.DataService::SetVariable(System.String,System.String)
IL_00bb: ldarg.0
IL_00bc: ldfld TheForestOfLove.CheatsMenu TheForestOfLove.PauseScreenUiController::cheatsMenu
IL_00c1: callvirt System.Boolean TheForestOfLove.CheatsMenu::get_plantMinigameHandsfree()
IL_00c6: brfalse.s IL_00d9
IL_00c8: ldstr "cheats_plant_minigame_handsfree"
IL_00cd: ldstr "true"
IL_00d2: call System.Void TheForestOfLove.Services.Persistence.DataService::SetVariable(System.String,System.String)
IL_00d7: br.s IL_00e4
IL_00d9: ldstr "cheats_plant_minigame_handsfree"
IL_00de: ldnull
IL_00df: call System.Void TheForestOfLove.Services.Persistence.DataService::SetVariable(System.String,System.String)
IL_00e4: ldarg.0
IL_00e5: call System.Void TheForestOfLove.PauseScreenUiController::MainMenuSave()
IL_00ea: ldarg.0
IL_00eb: ldfld TheForestOfLove.PauseScreenMainMenu TheForestOfLove.PauseScreenUiController::mainMenu
IL_00f0: callvirt System.Void TheForestOfLove.UIPanelMenu::Open()
IL_00f5: ret
