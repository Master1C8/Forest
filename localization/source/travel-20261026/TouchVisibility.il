TYPE TheForestOfLove.TouchInputHelper
METHOD System.Void TheForestOfLove.TouchInputHelper::ShowUi()
IL_0000: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inStartMenu()
IL_0005: brfalse.s IL_0016
IL_0007: ldsfld System.Boolean TheForestOfLove.MainMenuController::gameJustStarted
IL_000c: brtrue.s IL_0015
IL_000e: call System.Boolean TheForestOfLove.MainMenuController::get_showingSplashScreens()
IL_0013: brfalse.s IL_0016
IL_0015: ret
IL_0016: call System.Boolean TheForestOfLove.BugReportMenu::get_IsInKeyboardMode()
IL_001b: brfalse.s IL_001e
IL_001d: ret
IL_001e: ldarg.0
IL_001f: ldc.r4 0
IL_0024: stfld System.Single TheForestOfLove.TouchInputHelper::timeSinceLastClick
IL_0029: ldarg.0
IL_002a: ldfld UnityEngine.CanvasGroup TheForestOfLove.TouchInputHelper::canvasGroup
IL_002f: ldc.r4 1
IL_0034: callvirt System.Void UnityEngine.CanvasGroup::set_alpha(System.Single)
IL_0039: ret
METHOD System.Void TheForestOfLove.TouchInputHelper::HideUi()
IL_0000: ldarg.0
IL_0001: ldarg.0
IL_0002: ldfld System.Single TheForestOfLove.TouchInputHelper::idleDelayBeforeHide
IL_0007: stfld System.Single TheForestOfLove.TouchInputHelper::timeSinceLastClick
IL_000c: ldarg.0
IL_000d: ldfld UnityEngine.CanvasGroup TheForestOfLove.TouchInputHelper::canvasGroup
IL_0012: ldc.r4 0
IL_0017: callvirt System.Void UnityEngine.CanvasGroup::set_alpha(System.Single)
IL_001c: ldarg.0
IL_001d: call System.Void TheForestOfLove.TouchInputHelper::HideDetailedController()
IL_0022: ret
METHOD System.Void TheForestOfLove.TouchInputHelper::LateUpdate()
IL_0000: ldarg.0
IL_0001: ldc.i4.0
IL_0002: call System.Void TheForestOfLove.TouchInputHelper::set_IsPrimaryDown(System.Boolean)
IL_0007: ldarg.0
IL_0008: ldc.i4.0
IL_0009: call System.Void TheForestOfLove.TouchInputHelper::set_IsSecondaryDown(System.Boolean)
IL_000e: ldarg.0
IL_000f: ldc.i4.0
IL_0010: call System.Void TheForestOfLove.TouchInputHelper::set_IsMenuDown(System.Boolean)
IL_0015: ldarg.0
IL_0016: ldc.i4.0
IL_0017: call System.Void TheForestOfLove.TouchInputHelper::set_IsPauseDown(System.Boolean)
IL_001c: ldarg.0
IL_001d: ldc.i4.0
IL_001e: call System.Void TheForestOfLove.TouchInputHelper::set_IsBumperLDown(System.Boolean)
IL_0023: ldarg.0
IL_0024: ldc.i4.0
IL_0025: call System.Void TheForestOfLove.TouchInputHelper::set_IsBumperRDown(System.Boolean)
IL_002a: ret
METHOD System.Void TheForestOfLove.TouchInputHelper::Update()
IL_0000: ldarg.0
IL_0001: ldarg.0
IL_0002: ldfld System.Single TheForestOfLove.TouchInputHelper::timeSinceLastClick
IL_0007: call System.Single UnityEngine.Time::get_deltaTime()
IL_000c: add
IL_000d: stfld System.Single TheForestOfLove.TouchInputHelper::timeSinceLastClick
IL_0012: ldarg.0
IL_0013: ldfld System.Single TheForestOfLove.TouchInputHelper::idleDelayBeforeHide
IL_0018: ldc.r4 0
IL_001d: beq.s IL_0031
IL_001f: ldarg.0
IL_0020: ldfld UnityEngine.CanvasGroup TheForestOfLove.TouchInputHelper::canvasGroup
IL_0025: callvirt System.Single UnityEngine.CanvasGroup::get_alpha()
IL_002a: ldc.r4 0
IL_002f: bne.un.s IL_0032
IL_0031: ret
IL_0032: ldarg.0
IL_0033: ldfld System.Single TheForestOfLove.TouchInputHelper::timeSinceLastClick
IL_0038: ldarg.0
IL_0039: ldfld System.Single TheForestOfLove.TouchInputHelper::idleDelayBeforeHide
IL_003e: bge.s IL_0047
IL_0040: call System.Boolean TheForestOfLove.BugReportMenu::get_IsInKeyboardMode()
IL_0045: brfalse.s IL_004d
IL_0047: ldarg.0
IL_0048: call System.Void TheForestOfLove.TouchInputHelper::HideUi()
IL_004d: ldarg.0
IL_004e: call System.Boolean TheForestOfLove.TouchInputHelper::get_IsPlayingStartMenuMovieHackPLZFIX()
IL_0053: brfalse.s IL_0067
IL_0055: call System.Boolean MelodyPhotoFlipbookUI::get_IsAnyInstanceOpen()
IL_005a: brfalse.s IL_0067
IL_005c: ldarg.0
IL_005d: call System.Void TheForestOfLove.TouchInputHelper::ShowButtonsInventoryState()
IL_0062: br IL_011f
IL_0067: ldarg.0
IL_0068: call System.Boolean TheForestOfLove.TouchInputHelper::get_IsPlayingStartMenuMovieHackPLZFIX()
IL_006d: brfalse.s IL_007a
IL_006f: ldarg.0
IL_0070: call System.Void TheForestOfLove.TouchInputHelper::ShowButtonsStartMenuStatePlayingMovieHACKPLZFIX()
IL_0075: br IL_011f
IL_007a: ldarg.0
IL_007b: call System.Boolean TheForestOfLove.TouchInputHelper::get_IsStartMenuLoadingGameHackPLZFIX()
IL_0080: brfalse.s IL_008d
IL_0082: ldarg.0
IL_0083: call System.Void TheForestOfLove.TouchInputHelper::HideUiDuringLoad()
IL_0088: br IL_011f
IL_008d: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inStartMenu()
IL_0092: brtrue.s IL_009b
IL_0094: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inDustinMinigame()
IL_0099: brfalse.s IL_00a3
IL_009b: ldarg.0
IL_009c: call System.Void TheForestOfLove.TouchInputHelper::ShowButtonsStartMenuState()
IL_00a1: br.s IL_011f
IL_00a3: call System.Boolean TheForestOfLove.Events.GameStateManager::get_isItemGetAchievementOpen()
IL_00a8: brfalse.s IL_00b2
IL_00aa: ldarg.0
IL_00ab: call System.Void TheForestOfLove.TouchInputHelper::ShowButtonsPagedTutorialState()
IL_00b0: br.s IL_011f
IL_00b2: call System.Boolean TheForestOfLove.Narrative.DialogueService::get_IsDialoguePlaying()
IL_00b7: brtrue.s IL_00d5
IL_00b9: call System.Boolean TheForestOfLove.Events.GameStateManager::get_isCutscenePlaying()
IL_00be: brtrue.s IL_00d5
IL_00c0: call System.Boolean TheForestOfLove.Events.GameStateManager::get_isMoviePlaying()
IL_00c5: brtrue.s IL_00d5
IL_00c7: call System.Boolean TheForestOfLove.Events.GameStateManager::get_isPlayerEnteringDoorway()
IL_00cc: brtrue.s IL_00d5
IL_00ce: call System.Boolean TheForestOfLove.Events.GameStateManager::get_isPlayerFastTraveling()
IL_00d3: brfalse.s IL_00dd
IL_00d5: ldarg.0
IL_00d6: call System.Void TheForestOfLove.TouchInputHelper::ShowButtonsDialogueState()
IL_00db: br.s IL_011f
IL_00dd: call System.Boolean TheForestOfLove.Events.GameStateManager::get_isGossipUIActive()
IL_00e2: brfalse.s IL_00ec
IL_00e4: ldarg.0
IL_00e5: call System.Void TheForestOfLove.TouchInputHelper::ShowButtonsGamePaused()
IL_00ea: br.s IL_011f
IL_00ec: call System.Boolean TheForestOfLove.Events.GameStateManager::get_isGamePaused()
IL_00f1: brfalse.s IL_00fb
IL_00f3: ldarg.0
IL_00f4: call System.Void TheForestOfLove.TouchInputHelper::ShowButtonsGamePaused()
IL_00f9: br.s IL_011f
IL_00fb: call System.Boolean TheForestOfLove.Events.GameStateManager::get_isMasterLogOpen()
IL_0100: brfalse.s IL_010a
IL_0102: ldarg.0
IL_0103: call System.Void TheForestOfLove.TouchInputHelper::ShowButtonsInventoryState()
IL_0108: br.s IL_011f
IL_010a: call System.Boolean MelodyPhotoFlipbookUI::get_IsAnyInstanceOpen()
IL_010f: brfalse.s IL_0119
IL_0111: ldarg.0
IL_0112: call System.Void TheForestOfLove.TouchInputHelper::ShowButtonsInventoryState()
IL_0117: br.s IL_011f
IL_0119: ldarg.0
IL_011a: call System.Void TheForestOfLove.TouchInputHelper::ShowButtonsDefaultState()
IL_011f: ldarg.0
IL_0120: ldfld Suriyun.MCS.UniversalButton TheForestOfLove.TouchInputHelper::primary
IL_0125: callvirt System.Void Suriyun.MCS.UniversalButton::UpdateButtonState()
IL_012a: ldarg.0
IL_012b: ldfld Suriyun.MCS.UniversalButton TheForestOfLove.TouchInputHelper::secondary
IL_0130: callvirt System.Void Suriyun.MCS.UniversalButton::UpdateButtonState()
IL_0135: ldarg.0
IL_0136: ldfld Suriyun.MCS.UniversalButton TheForestOfLove.TouchInputHelper::bumperL
IL_013b: callvirt System.Void Suriyun.MCS.UniversalButton::UpdateButtonState()
IL_0140: ldarg.0
IL_0141: ldfld Suriyun.MCS.UniversalButton TheForestOfLove.TouchInputHelper::bumperR
IL_0146: callvirt System.Void Suriyun.MCS.UniversalButton::UpdateButtonState()
IL_014b: ldarg.0
IL_014c: ldfld Suriyun.MCS.UniversalButton TheForestOfLove.TouchInputHelper::menu
IL_0151: callvirt System.Void Suriyun.MCS.UniversalButton::UpdateButtonState()
IL_0156: ldarg.0
IL_0157: ldfld Suriyun.MCS.UniversalButton TheForestOfLove.TouchInputHelper::pause
IL_015c: callvirt System.Void Suriyun.MCS.UniversalButton::UpdateButtonState()
IL_0161: ldarg.0
IL_0162: call System.Void TheForestOfLove.TouchInputHelper::UnstickStuckButtons()
IL_0167: ret
METHOD System.Void TheForestOfLove.TouchInputHelper::ShowButtonsDefaultState()
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.TouchInputHelper/InputState TheForestOfLove.TouchInputHelper::currentState
IL_0006: brfalse.s IL_001f
IL_0008: ldarg.0
IL_0009: call System.Void TheForestOfLove.TouchInputHelper::HideDetailedController()
IL_000e: ldarg.0
IL_000f: ldc.r4 0
IL_0014: stfld System.Single TheForestOfLove.TouchInputHelper::timeSinceLastClick
IL_0019: ldarg.0
IL_001a: call System.Void TheForestOfLove.TouchInputHelper::ClearButtonInputs()
IL_001f: ldarg.0
IL_0020: ldc.i4.0
IL_0021: stfld TheForestOfLove.TouchInputHelper/InputState TheForestOfLove.TouchInputHelper::currentState
IL_0026: ldarg.0
IL_0027: ldfld Suriyun.MCS.UniversalButton TheForestOfLove.TouchInputHelper::primary
IL_002c: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0031: ldc.i4.1
IL_0032: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0037: ldarg.0
IL_0038: ldfld UnityEngine.CanvasGroup TheForestOfLove.TouchInputHelper::primaryCanvasGroup
IL_003d: ldc.r4 1
IL_0042: callvirt System.Void UnityEngine.CanvasGroup::set_alpha(System.Single)
IL_0047: ldarg.0
IL_0048: ldfld Suriyun.MCS.UniversalButton TheForestOfLove.TouchInputHelper::secondary
IL_004d: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0052: call System.Boolean TheForestOfLove.QuestTriggerHelper::PlayerLearnedDashroll()
IL_0057: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_005c: ldarg.0
IL_005d: ldfld UnityEngine.CanvasGroup TheForestOfLove.TouchInputHelper::secondaryCanvasGroup
IL_0062: ldc.r4 1
IL_0067: callvirt System.Void UnityEngine.CanvasGroup::set_alpha(System.Single)
IL_006c: ldarg.0
IL_006d: ldfld Suriyun.MCS.UniversalButton TheForestOfLove.TouchInputHelper::bumperL
IL_0072: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0077: call System.Boolean TheForestOfLove.QuestTriggerHelper::PlayerFinishedIntroTutorial()
IL_007c: brfalse.s IL_0085
IL_007e: call System.Boolean TheForestOfLove.InteractionUiController::get_isVisible()
IL_0083: br.s IL_0086
IL_0085: ldc.i4.0
IL_0086: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_008b: ldarg.0
IL_008c: ldfld Suriyun.MCS.UniversalButton TheForestOfLove.TouchInputHelper::bumperR
IL_0091: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0096: call System.Boolean TheForestOfLove.QuestTriggerHelper::PlayerFinishedIntroTutorial()
IL_009b: brfalse.s IL_00a4
IL_009d: call System.Boolean TheForestOfLove.InteractionUiController::get_isVisible()
IL_00a2: br.s IL_00a5
IL_00a4: ldc.i4.0
IL_00a5: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_00aa: ldarg.0
IL_00ab: ldfld Suriyun.MCS.UniversalButton TheForestOfLove.TouchInputHelper::menu
IL_00b0: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_00b5: ldarg.0
IL_00b6: ldfld System.Boolean TheForestOfLove.TouchInputHelper::detailedControllerVisible
IL_00bb: brfalse.s IL_00c4
IL_00bd: call System.Boolean TheForestOfLove.QuestTriggerHelper::PlayerLearnedNotebook()
IL_00c2: br.s IL_00c5
IL_00c4: ldc.i4.0
IL_00c5: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_00ca: ldarg.0
IL_00cb: ldfld Suriyun.MCS.UniversalButton TheForestOfLove.TouchInputHelper::pause
IL_00d0: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_00d5: ldarg.0
IL_00d6: ldfld System.Boolean TheForestOfLove.TouchInputHelper::detailedControllerVisible
IL_00db: brtrue.s IL_00e7
IL_00dd: call System.Boolean TheForestOfLove.QuestTriggerHelper::PlayerLearnedNotebook()
IL_00e2: ldc.i4.0
IL_00e3: ceq
IL_00e5: br.s IL_00e8
IL_00e7: ldc.i4.1
IL_00e8: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_00ed: ldarg.0
IL_00ee: ldfld UnityEngine.UI.Button TheForestOfLove.TouchInputHelper::showDetailedController
IL_00f3: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_00f8: ldarg.0
IL_00f9: ldfld System.Boolean TheForestOfLove.TouchInputHelper::detailedControllerVisible
IL_00fe: brtrue.s IL_0107
IL_0100: call System.Boolean TheForestOfLove.QuestTriggerHelper::PlayerLearnedNotebook()
IL_0105: br.s IL_0108
IL_0107: ldc.i4.0
IL_0108: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_010d: ret
