TYPE TheForestOfLove.MainMenuController
METHOD System.Void TheForestOfLove.MainMenuController::DeleteLocalSavestate()
IL_0000: call System.Boolean TheForestOfLove.Services.Persistence.SaveManager::get_HasSavedPlaySession()
IL_0005: brfalse.s IL_001c
IL_0007: call System.Void TheForestOfLove.Services.Persistence.SaveManager::DeleteSavedPlaySession()
IL_000c: ldarg.0
IL_000d: ldfld TheForestOfLove.PlayMenu TheForestOfLove.MainMenuController::playMenu
IL_0012: callvirt System.Void TheForestOfLove.PlayMenu::HideContinueButton()
IL_0017: call System.Void TheForestOfLove.Core.SceneSetup.DbAddressableAssetsPreloader::LoadGameplayAddressableAssets()
IL_001c: ret
METHOD System.Void TheForestOfLove.MainMenuController::LoadOverworld()
IL_0000: ldarg.0
IL_0001: ldfld System.String TheForestOfLove.MainMenuController::targetSceneName
IL_0006: ldstr "fastforward_magic_string"
IL_000b: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0010: brfalse.s IL_003a
IL_0012: ldarg.0
IL_0013: ldfld TheForestOfLove.Narrative.Chapter TheForestOfLove.MainMenuController::fastforward_unlockStopPoint
IL_0018: call TheForestOfLove.Narrative.ChapterRecord TheForestOfLove.Services.Persistence.DataService::GetChapterRecordByChapter(TheForestOfLove.Narrative.Chapter)
IL_001d: stloc.0
IL_001e: ldarg.0
IL_001f: ldfld TheForestOfLove.Narrative.Chapter TheForestOfLove.MainMenuController::fastforward_unlockStopPoint
IL_0024: ldloc.0
IL_0025: ldfld System.String TheForestOfLove.Narrative.ChapterRecord::respawnInScene
IL_002a: ldnull
IL_002b: ldloca.s V_1
IL_002d: initobj System.Nullable`1<TheForestOfLove.Direction>
IL_0033: ldloc.1
IL_0034: call System.Void TheForestOfLove.ChapterSelectUI::DoChapterSelect(TheForestOfLove.Narrative.Chapter,System.String,System.String,System.Nullable`1<TheForestOfLove.Direction>)
IL_0039: ret
IL_003a: ldstr "ChapterSelect"
IL_003f: call System.Void TheForestOfLove.Services.SceneManagement.SceneHelper::LoadSoftResetScene(System.String)
IL_0044: ret
METHOD System.Void TheForestOfLove.MainMenuController::PlayMenuStart()
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.PlayMenu TheForestOfLove.MainMenuController::playMenu
IL_0006: callvirt System.Boolean TheForestOfLove.PlayMenu::get_showContinueButton()
IL_000b: brfalse.s IL_0024
IL_000d: ldarg.0
IL_000e: ldfld TheForestOfLove.PlayMenu TheForestOfLove.MainMenuController::playMenu
IL_0013: callvirt System.Void TheForestOfLove.UIPanelMenu::Hide()
IL_0018: ldarg.0
IL_0019: ldfld TheForestOfLove.DelayedYesNoConfirmation TheForestOfLove.MainMenuController::newgameConfirmation
IL_001e: callvirt System.Void TheForestOfLove.UIPanelMenu::Open()
IL_0023: ret
IL_0024: ldarg.0
IL_0025: call System.Void TheForestOfLove.MainMenuController::DeleteLocalSavestate()
IL_002a: ldarg.0
IL_002b: call System.Void TheForestOfLove.MainMenuController::DeleteGlobalSavestate()
IL_0030: ldarg.0
IL_0031: call System.Void TheForestOfLove.MainMenuController::StartNewGame()
IL_0036: ret
METHOD System.Void TheForestOfLove.MainMenuController::StartNewGame()
IL_0000: call UnityEngine.EventSystems.EventSystem UnityEngine.EventSystems.EventSystem::get_current()
IL_0005: ldnull
IL_0006: callvirt System.Void UnityEngine.EventSystems.EventSystem::SetSelectedGameObject(UnityEngine.GameObject)
IL_000b: ldarg.0
IL_000c: ldfld UnityEngine.Animator TheForestOfLove.MainMenuController::animator
IL_0011: ldstr "fade_out"
IL_0016: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_001b: call System.Void TheForestOfLove.Audio.MusicManager::MuteMusic()
IL_0020: ldarg.0
IL_0021: ldnull
IL_0022: stfld System.String TheForestOfLove.MainMenuController::targetSceneName
IL_0027: ldstr "act2_newgame_skip"
IL_002c: call System.Void TheForestOfLove.QuestTriggerHelper::SetTrigger(System.String)
IL_0031: ret
METHOD System.Void TheForestOfLove.MainMenuController::DeleteGlobalSavestate()
IL_0000: call System.Void TheForestOfLove.Services.Persistence.DataService::ForgetGlobalMovieUnlocks()
IL_0005: call System.Void TheForestOfLove.Services.Persistence.DataService::ForgetGlobalChapterUnlocks()
IL_000a: call System.Void TheForestOfLove.Services.Persistence.DataService::RegenerateManifest()
IL_000f: call System.Void TheForestOfLove.Services.Persistence.SaveManager::SilentSaveGlobalDataOnly()
IL_0014: ldc.i4.0
IL_0015: stsfld System.Boolean Globals::enableAllChapters
IL_001a: ret
