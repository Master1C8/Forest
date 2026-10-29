TYPE TheForestOfLove.PauseScreenUiController
METHOD System.Void TheForestOfLove.PauseScreenUiController::Start() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.UIPanelController::Start()
IL_0006: ldarg.0
IL_0007: ldfld TheForestOfLove.PauseScreenMainMenu TheForestOfLove.PauseScreenUiController::mainMenu
IL_000c: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.PauseScreenMainMenu::onClickOptions
IL_0011: ldarg.0
IL_0012: ldftn System.Void TheForestOfLove.PauseScreenUiController::MainMenuOptions()
IL_0018: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_001d: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_0022: ldarg.0
IL_0023: ldfld TheForestOfLove.PauseScreenMainMenu TheForestOfLove.PauseScreenUiController::mainMenu
IL_0028: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.PauseScreenMainMenu::onClickCancelAdventure
IL_002d: ldarg.0
IL_002e: ldftn System.Void TheForestOfLove.PauseScreenUiController::MainMenuCancelAdventure()
IL_0034: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0039: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_003e: ldarg.0
IL_003f: ldfld TheForestOfLove.PauseScreenMainMenu TheForestOfLove.PauseScreenUiController::mainMenu
IL_0044: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.PauseScreenMainMenu::onClickReplayAdventure
IL_0049: ldarg.0
IL_004a: ldftn System.Void TheForestOfLove.PauseScreenUiController::MainMenuReplayAdventure()
IL_0050: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0055: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_005a: ldarg.0
IL_005b: ldfld TheForestOfLove.PauseScreenMainMenu TheForestOfLove.PauseScreenUiController::mainMenu
IL_0060: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.PauseScreenMainMenu::onClickBugReport
IL_0065: ldarg.0
IL_0066: ldftn System.Void TheForestOfLove.PauseScreenUiController::MainMenuBugReport()
IL_006c: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0071: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_0076: ldarg.0
IL_0077: ldfld TheForestOfLove.PauseScreenMainMenu TheForestOfLove.PauseScreenUiController::mainMenu
IL_007c: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.PauseScreenMainMenu::onClickCheats
IL_0081: ldarg.0
IL_0082: ldftn System.Void TheForestOfLove.PauseScreenUiController::MainMenuCheats()
IL_0088: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_008d: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_0092: ldarg.0
IL_0093: ldfld TheForestOfLove.PauseScreenMainMenu TheForestOfLove.PauseScreenUiController::mainMenu
IL_0098: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.PauseScreenMainMenu::onClickSave
IL_009d: ldarg.0
IL_009e: ldftn System.Void TheForestOfLove.PauseScreenUiController::MainMenuSave()
IL_00a4: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_00a9: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_00ae: ldarg.0
IL_00af: ldfld TheForestOfLove.PauseScreenMainMenu TheForestOfLove.PauseScreenUiController::mainMenu
IL_00b4: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.PauseScreenMainMenu::onClickMenu
IL_00b9: ldarg.0
IL_00ba: ldftn System.Void TheForestOfLove.PauseScreenUiController::MainMenuStartMenu()
IL_00c0: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_00c5: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_00ca: ldarg.0
IL_00cb: ldfld TheForestOfLove.PauseScreenMainMenu TheForestOfLove.PauseScreenUiController::mainMenu
IL_00d0: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.PauseScreenMainMenu::onClickQuit
IL_00d5: ldarg.0
IL_00d6: ldftn System.Void TheForestOfLove.PauseScreenUiController::MainMenuQuit()
IL_00dc: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_00e1: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_00e6: ldarg.0
IL_00e7: ldfld TheForestOfLove.PauseScreenMainMenu TheForestOfLove.PauseScreenUiController::mainMenu
IL_00ec: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.PauseScreenMainMenu::onClickChapterSelect
IL_00f1: ldarg.0
IL_00f2: ldftn System.Void TheForestOfLove.PauseScreenUiController::MainMenuChapterSelect()
IL_00f8: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_00fd: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_0102: ldarg.0
IL_0103: ldfld TheForestOfLove.OptionsMenu TheForestOfLove.PauseScreenUiController::optionsMenu
IL_0108: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.OptionsMenu::onClickBack
IL_010d: ldarg.0
IL_010e: ldftn System.Void TheForestOfLove.PauseScreenUiController::OptionsMenuBack()
IL_0114: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0119: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_011e: ldarg.0
IL_011f: ldfld TheForestOfLove.OptionsMenu TheForestOfLove.PauseScreenUiController::optionsMenu
IL_0124: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.OptionsMenu::onClickControls
IL_0129: ldarg.0
IL_012a: ldftn System.Void TheForestOfLove.PauseScreenUiController::OptionsMenuControls()
IL_0130: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0135: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_013a: ldarg.0
IL_013b: ldfld TheForestOfLove.BugReportMenu TheForestOfLove.PauseScreenUiController::bugReportMenu
IL_0140: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.BugReportMenu::onBack
IL_0145: ldarg.0
IL_0146: ldftn System.Void TheForestOfLove.PauseScreenUiController::BugReportMenuBack()
IL_014c: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0151: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_0156: ldarg.0
IL_0157: ldfld TheForestOfLove.CheatsMenu TheForestOfLove.PauseScreenUiController::cheatsMenu
IL_015c: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.CheatsMenu::onClickBack
IL_0161: ldarg.0
IL_0162: ldftn System.Void TheForestOfLove.PauseScreenUiController::CheatsMenuBack()
IL_0168: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_016d: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_0172: ldarg.0
IL_0173: ldfld TheForestOfLove.DelayedYesNoConfirmation TheForestOfLove.PauseScreenUiController::startMenuConfirmation
IL_0178: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.DelayedYesNoConfirmation::onClickYes
IL_017d: ldarg.0
IL_017e: ldftn System.Void TheForestOfLove.PauseScreenUiController::StartMenuConfirmationYes()
IL_0184: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0189: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_018e: ldarg.0
IL_018f: ldfld TheForestOfLove.DelayedYesNoConfirmation TheForestOfLove.PauseScreenUiController::startMenuConfirmation
IL_0194: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.DelayedYesNoConfirmation::onClickYesDelayed
IL_0199: ldarg.0
IL_019a: ldftn System.Void TheForestOfLove.PauseScreenUiController::StartMenuConfirmationYesDelayed()
IL_01a0: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_01a5: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_01aa: ldarg.0
IL_01ab: ldfld TheForestOfLove.DelayedYesNoConfirmation TheForestOfLove.PauseScreenUiController::startMenuConfirmation
IL_01b0: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.DelayedYesNoConfirmation::onClickNo
IL_01b5: ldarg.0
IL_01b6: ldftn System.Void TheForestOfLove.PauseScreenUiController::StartMenuConfirmationNo()
IL_01bc: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_01c1: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_01c6: ldarg.0
IL_01c7: ldfld TheForestOfLove.DelayedYesNoConfirmation TheForestOfLove.PauseScreenUiController::quitConfirmation
IL_01cc: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.DelayedYesNoConfirmation::onClickYes
IL_01d1: ldarg.0
IL_01d2: ldftn System.Void TheForestOfLove.PauseScreenUiController::QuitConfirmationYes()
IL_01d8: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_01dd: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_01e2: ldarg.0
IL_01e3: ldfld TheForestOfLove.DelayedYesNoConfirmation TheForestOfLove.PauseScreenUiController::quitConfirmation
IL_01e8: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.DelayedYesNoConfirmation::onClickYesDelayed
IL_01ed: ldarg.0
IL_01ee: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.PauseScreenUiController::onQuit
IL_01f3: ldftn System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_01f9: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_01fe: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_0203: ldarg.0
IL_0204: ldfld TheForestOfLove.DelayedYesNoConfirmation TheForestOfLove.PauseScreenUiController::quitConfirmation
IL_0209: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.DelayedYesNoConfirmation::onClickNo
IL_020e: ldarg.0
IL_020f: ldftn System.Void TheForestOfLove.PauseScreenUiController::QuitConfirmationNo()
IL_0215: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_021a: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_021f: ldarg.0
IL_0220: ldfld TheForestOfLove.DelayedYesNoConfirmation TheForestOfLove.PauseScreenUiController::cancelAdventureConfirmation
IL_0225: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.DelayedYesNoConfirmation::onClickYes
IL_022a: ldarg.0
IL_022b: ldftn System.Void TheForestOfLove.PauseScreenUiController::CancelAdventureConfirmationYes()
IL_0231: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0236: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_023b: ldarg.0
IL_023c: ldfld TheForestOfLove.DelayedYesNoConfirmation TheForestOfLove.PauseScreenUiController::cancelAdventureConfirmation
IL_0241: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.DelayedYesNoConfirmation::onClickYesDelayed
IL_0246: ldarg.0
IL_0247: ldftn System.Void TheForestOfLove.PauseScreenUiController::CancelAdventureConfirmationYesDelayed()
IL_024d: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0252: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_0257: ldarg.0
IL_0258: ldfld TheForestOfLove.DelayedYesNoConfirmation TheForestOfLove.PauseScreenUiController::cancelAdventureConfirmation
IL_025d: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.DelayedYesNoConfirmation::onClickNo
IL_0262: ldarg.0
IL_0263: ldftn System.Void TheForestOfLove.PauseScreenUiController::CancelAdventureConfirmationNo()
IL_0269: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_026e: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_0273: ldarg.0
IL_0274: ldfld TheForestOfLove.PauseScreenMainMenu TheForestOfLove.PauseScreenUiController::mainMenu
IL_0279: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.PauseScreenMainMenu::onClickRestart
IL_027e: ldarg.0
IL_027f: ldftn System.Void TheForestOfLove.PauseScreenUiController::MainMenuRestart()
IL_0285: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_028a: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_028f: ldarg.0
IL_0290: ldfld TheForestOfLove.PauseScreenMainMenu TheForestOfLove.PauseScreenUiController::mainMenu
IL_0295: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.PauseScreenMainMenu::onClickForfeit
IL_029a: ldarg.0
IL_029b: ldftn System.Void TheForestOfLove.PauseScreenUiController::MainMenuForfeit()
IL_02a1: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_02a6: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_02ab: ldarg.0
IL_02ac: ldfld TheForestOfLove.DelayedYesNoConfirmation TheForestOfLove.PauseScreenUiController::forfeitConfirmation
IL_02b1: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.DelayedYesNoConfirmation::onClickYes
IL_02b6: ldarg.0
IL_02b7: ldftn System.Void TheForestOfLove.PauseScreenUiController::ForfeitConfirmationYes()
IL_02bd: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_02c2: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_02c7: ldarg.0
IL_02c8: ldfld TheForestOfLove.DelayedYesNoConfirmation TheForestOfLove.PauseScreenUiController::forfeitConfirmation
IL_02cd: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.DelayedYesNoConfirmation::onClickYesDelayed
IL_02d2: ldarg.0
IL_02d3: ldftn System.Void TheForestOfLove.PauseScreenUiController::ForfeitConfirmationYesDelayed()
IL_02d9: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_02de: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_02e3: ldarg.0
IL_02e4: ldfld TheForestOfLove.DelayedYesNoConfirmation TheForestOfLove.PauseScreenUiController::forfeitConfirmation
IL_02e9: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.DelayedYesNoConfirmation::onClickNo
IL_02ee: ldarg.0
IL_02ef: ldftn System.Void TheForestOfLove.PauseScreenUiController::ForfeitConfirmationNo()
IL_02f5: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_02fa: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_02ff: ret
METHOD System.Void TheForestOfLove.PauseScreenUiController::MainMenuSave() | attributes=Private, HideBySig | impl=IL
IL_0000: call System.Void TheForestOfLove.Services.Persistence.SaveManager::ManualSave()
IL_0005: ret
METHOD System.Void TheForestOfLove.PauseScreenUiController::MainMenuChapterSelect() | attributes=Private, HideBySig | impl=IL
IL_0000: call System.Void TheForestOfLove.BugReportApiHelper::OnPauseMenuClosedForAnyReason()
IL_0005: ldarg.0
IL_0006: callvirt System.Void TheForestOfLove.UIPanelController::OnClose()
IL_000b: ldarg.0
IL_000c: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.PauseScreenUiController::onResume
IL_0011: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_0016: ldsfld TheForestOfLove.Player TheForestOfLove.Player::current
IL_001b: ldnull
IL_001c: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0021: brfalse.s IL_0046
IL_0023: ldsfld TheForestOfLove.Player TheForestOfLove.Player::current
IL_0028: callvirt TheForestOfLove.WaypointController TheForestOfLove.Player::get_waypointController()
IL_002d: ldnull
IL_002e: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0033: brfalse.s IL_0046
IL_0035: ldsfld TheForestOfLove.Player TheForestOfLove.Player::current
IL_003a: callvirt TheForestOfLove.WaypointController TheForestOfLove.Player::get_waypointController()
IL_003f: callvirt System.Boolean TheForestOfLove.WaypointController::get_HasWaypoints()
IL_0044: br.s IL_0047
IL_0046: ldc.i4.0
IL_0047: brtrue.s IL_004e
IL_0049: call System.Void TheForestOfLove.ChapterSelectUI::ShowUi()
IL_004e: ret
