TYPE TheForestOfLove.MainMenuController
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
METHOD System.Void TheForestOfLove.MainMenuController::PlayMenuFastForward()
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
IL_0025: call System.Void TheForestOfLove.MainMenuController::FastForwardGame()
IL_002a: ret
METHOD System.Void TheForestOfLove.MainMenuController::FastForwardGame()
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.PlayMenu TheForestOfLove.MainMenuController::playMenu
IL_0006: callvirt System.Int32 TheForestOfLove.PlayMenu::get_currentFastForwardDestinationIndex()
IL_000b: stloc.0
IL_000c: ldloc.0
IL_000d: switch IL_0032,IL_0049,IL_0056
IL_001e: ldarg.0
IL_001f: ldc.i4.s 10
IL_0021: stfld TheForestOfLove.Narrative.Chapter TheForestOfLove.MainMenuController::fastforward_unlockStopPoint
IL_0026: ldstr "act2_newgame_skip"
IL_002b: call System.Void TheForestOfLove.QuestTriggerHelper::SetTrigger(System.String)
IL_0030: br.s IL_0061
IL_0032: ldarg.0
IL_0033: ldc.i4 200
IL_0038: stfld TheForestOfLove.Narrative.Chapter TheForestOfLove.MainMenuController::fastforward_unlockStopPoint
IL_003d: ldstr "act2_newgame_skip"
IL_0042: call System.Void TheForestOfLove.QuestTriggerHelper::SetTrigger(System.String)
IL_0047: br.s IL_0061
IL_0049: ldarg.0
IL_004a: ldc.i4 1000
IL_004f: stfld TheForestOfLove.Narrative.Chapter TheForestOfLove.MainMenuController::fastforward_unlockStopPoint
IL_0054: br.s IL_0061
IL_0056: ldarg.0
IL_0057: ldc.i4 2100
IL_005c: stfld TheForestOfLove.Narrative.Chapter TheForestOfLove.MainMenuController::fastforward_unlockStopPoint
IL_0061: ldarg.0
IL_0062: ldstr "fastforward_magic_string"
IL_0067: stfld System.String TheForestOfLove.MainMenuController::targetSceneName
IL_006c: call UnityEngine.EventSystems.EventSystem UnityEngine.EventSystems.EventSystem::get_current()
IL_0071: ldnull
IL_0072: callvirt System.Void UnityEngine.EventSystems.EventSystem::SetSelectedGameObject(UnityEngine.GameObject)
IL_0077: ldarg.0
IL_0078: ldfld UnityEngine.Animator TheForestOfLove.MainMenuController::animator
IL_007d: ldstr "fade_out"
IL_0082: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0087: call System.Void TheForestOfLove.Audio.MusicManager::MuteMusic()
IL_008c: ret
