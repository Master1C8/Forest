TYPE TheForestOfLove.MainMenuController
METHOD System.Void TheForestOfLove.MainMenuController::Start()
IL_0000: ldstr "FOREST_STARTUP MENU_START_ENTER"
IL_0005: call System.Void UnityEngine.Debug::Log(System.Object)
IL_000a: call System.Void ForestProbe::Install()
IL_000f: ldarg.0
IL_0010: ldarg.0
IL_0011: call !!0 UnityEngine.Component::GetComponent<UnityEngine.Animator>()
IL_0016: stfld UnityEngine.Animator TheForestOfLove.MainMenuController::animator
IL_001b: ldarg.0
IL_001c: ldc.i4.1
IL_001d: call System.Void TheForestOfLove.MainMenuController::set_fadingIn(System.Boolean)
IL_0022: ldarg.0
IL_0023: ldfld TheForestOfLove.PlayMenu TheForestOfLove.MainMenuController::playMenu
IL_0028: call System.Boolean TheForestOfLove.Services.Persistence.SaveManager::get_HasSavedPlaySession()
IL_002d: callvirt System.Void TheForestOfLove.PlayMenu::set_showContinueButton(System.Boolean)
IL_0032: ldc.i4.1
IL_0033: call TheForestOfLove.Narrative.MovieRecord TheForestOfLove.Services.Persistence.DataService::GetMovieRecordByMovie(TheForestOfLove.Narrative.Movie)
IL_0038: stloc.0
IL_0039: ldloc.0
IL_003a: brfalse.s IL_0069
IL_003c: ldloc.0
IL_003d: callvirt System.Boolean TheForestOfLove.Narrative.MovieRecord::get_IsUnlocked()
IL_0042: brfalse.s IL_0069
IL_0044: ldarg.0
IL_0045: ldfld System.Boolean TheForestOfLove.MainMenuController::debugSuppressThankYouScreen
IL_004a: brtrue.s IL_0069
IL_004c: ldarg.0
IL_004d: ldc.i4.1
IL_004e: stfld System.Boolean TheForestOfLove.MainMenuController::showDemoThankYouScreen
IL_0053: ldarg.0
IL_0054: ldfld UnityEngine.Animator TheForestOfLove.MainMenuController::animator
IL_0059: ldstr "show_thank_you_screen"
IL_005e: ldarg.0
IL_005f: ldfld System.Boolean TheForestOfLove.MainMenuController::showDemoThankYouScreen
IL_0064: callvirt System.Void UnityEngine.Animator::SetBool(System.String,System.Boolean)
IL_0069: ldarg.0
IL_006a: ldfld TheForestOfLove.StartScreenMainMenu TheForestOfLove.MainMenuController::mainMenu
IL_006f: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.StartScreenMainMenu::onClickStart
IL_0074: ldarg.0
IL_0075: ldftn System.Void TheForestOfLove.MainMenuController::MainMenuPlay()
IL_007b: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0080: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_0085: ldarg.0
IL_0086: ldfld TheForestOfLove.StartScreenMainMenu TheForestOfLove.MainMenuController::mainMenu
IL_008b: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.StartScreenMainMenu::onClickGallery
IL_0090: ldarg.0
IL_0091: ldftn System.Void TheForestOfLove.MainMenuController::ShowGalleryTutorial()
IL_0097: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_009c: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_00a1: ldarg.0
IL_00a2: ldfld TheForestOfLove.StartScreenMainMenu TheForestOfLove.MainMenuController::mainMenu
IL_00a7: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.StartScreenMainMenu::onClickGallery
IL_00ac: ldarg.0
IL_00ad: ldftn System.Void TheForestOfLove.MainMenuController::MainMenuGallery()
IL_00b3: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_00b8: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_00bd: ldarg.0
IL_00be: ldfld TheForestOfLove.StartScreenMainMenu TheForestOfLove.MainMenuController::mainMenu
IL_00c3: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.StartScreenMainMenu::onClickOptions
IL_00c8: ldarg.0
IL_00c9: ldftn System.Void TheForestOfLove.MainMenuController::MainMenuOptions()
IL_00cf: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_00d4: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_00d9: ldarg.0
IL_00da: ldfld TheForestOfLove.StartScreenMainMenu TheForestOfLove.MainMenuController::mainMenu
IL_00df: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.StartScreenMainMenu::onClickBugReport
IL_00e4: ldarg.0
IL_00e5: ldftn System.Void TheForestOfLove.MainMenuController::MainMenuBugReportMenu()
IL_00eb: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_00f0: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_00f5: ldarg.0
IL_00f6: ldfld TheForestOfLove.StartScreenMainMenu TheForestOfLove.MainMenuController::mainMenu
IL_00fb: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.StartScreenMainMenu::onClickControls
IL_0100: ldarg.0
IL_0101: ldftn System.Void TheForestOfLove.MainMenuController::MainMenuControls()
IL_0107: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_010c: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_0111: ldarg.0
IL_0112: ldfld TheForestOfLove.StartScreenMainMenu TheForestOfLove.MainMenuController::mainMenu
IL_0117: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.StartScreenMainMenu::onClickQuit
IL_011c: ldarg.0
IL_011d: ldftn System.Void TheForestOfLove.MainMenuController::MainMenuQuit()
IL_0123: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0128: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_012d: ldarg.0
IL_012e: ldfld TheForestOfLove.StartScreenMainMenu TheForestOfLove.MainMenuController::mainMenu
IL_0133: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.StartScreenMainMenu::onClickPatreon
IL_0138: ldarg.0
IL_0139: ldftn System.Void TheForestOfLove.MainMenuController::ShowPatreon()
IL_013f: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0144: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_0149: ldarg.0
IL_014a: ldfld TheForestOfLove.StartScreenMainMenu TheForestOfLove.MainMenuController::mainMenu
IL_014f: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.StartScreenMainMenu::onClickWebsite
IL_0154: ldarg.0
IL_0155: ldftn System.Void TheForestOfLove.MainMenuController::ShowWebsite()
IL_015b: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0160: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_0165: ldarg.0
IL_0166: ldfld TheForestOfLove.PlayMenu TheForestOfLove.MainMenuController::playMenu
IL_016b: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.PlayMenu::onClickStart
IL_0170: ldarg.0
IL_0171: ldftn System.Void TheForestOfLove.MainMenuController::PlayMenuStart()
IL_0177: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_017c: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_0181: ldarg.0
IL_0182: ldfld TheForestOfLove.PlayMenu TheForestOfLove.MainMenuController::playMenu
IL_0187: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.PlayMenu::onClickContinue
IL_018c: ldarg.0
IL_018d: ldftn System.Void TheForestOfLove.MainMenuController::PlayMenuContinue()
IL_0193: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0198: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_019d: ldarg.0
IL_019e: ldfld TheForestOfLove.PlayMenu TheForestOfLove.MainMenuController::playMenu
IL_01a3: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.PlayMenu::onClickFastForward
IL_01a8: ldarg.0
IL_01a9: ldftn System.Void TheForestOfLove.MainMenuController::PlayMenuFastForward()
IL_01af: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_01b4: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_01b9: ldarg.0
IL_01ba: ldfld TheForestOfLove.PlayMenu TheForestOfLove.MainMenuController::playMenu
IL_01bf: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.PlayMenu::onClickBack
IL_01c4: ldarg.0
IL_01c5: ldftn System.Void TheForestOfLove.MainMenuController::PlayMenuBack()
IL_01cb: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_01d0: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_01d5: ldarg.0
IL_01d6: ldfld TheForestOfLove.DelayedYesNoConfirmation TheForestOfLove.MainMenuController::newgameConfirmation
IL_01db: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.DelayedYesNoConfirmation::onClickYes
IL_01e0: ldarg.0
IL_01e1: ldftn System.Void TheForestOfLove.MainMenuController::NewgameConfirmationYes()
IL_01e7: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_01ec: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_01f1: ldarg.0
IL_01f2: ldfld TheForestOfLove.DelayedYesNoConfirmation TheForestOfLove.MainMenuController::newgameConfirmation
IL_01f7: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.DelayedYesNoConfirmation::onClickNo
IL_01fc: ldarg.0
IL_01fd: ldftn System.Void TheForestOfLove.MainMenuController::NewgameConfirmationNo()
IL_0203: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0208: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_020d: ldarg.0
IL_020e: ldfld TheForestOfLove.StartScreenGalleryMenu TheForestOfLove.MainMenuController::galleryMenu
IL_0213: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.StartScreenGalleryMenu::onExitGallery
IL_0218: ldarg.0
IL_0219: ldftn System.Void TheForestOfLove.MainMenuController::GalleryExit()
IL_021f: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0224: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_0229: ldarg.0
IL_022a: ldfld TheForestOfLove.StartScreenGalleryMenu TheForestOfLove.MainMenuController::galleryMenu
IL_022f: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.StartScreenGalleryMenu::onExitGalleryShowTutorial
IL_0234: ldarg.0
IL_0235: ldftn System.Void TheForestOfLove.MainMenuController::GalleryExitShowTutorial()
IL_023b: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0240: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_0245: ldarg.0
IL_0246: ldfld TheForestOfLove.StartScreenGalleryMenu TheForestOfLove.MainMenuController::galleryMenu
IL_024b: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.StartScreenGalleryMenu::onExitGalleryShowHint
IL_0250: ldarg.0
IL_0251: ldftn System.Void TheForestOfLove.MainMenuController::GalleryExitShowHint()
IL_0257: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_025c: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_0261: ldarg.0
IL_0262: ldfld TheForestOfLove.OptionsMenu TheForestOfLove.MainMenuController::optionsMenu
IL_0267: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.OptionsMenu::onClickBack
IL_026c: ldarg.0
IL_026d: ldftn System.Void TheForestOfLove.MainMenuController::OptionsMenuBack()
IL_0273: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0278: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_027d: ldarg.0
IL_027e: ldfld TheForestOfLove.OptionsMenu TheForestOfLove.MainMenuController::optionsMenu
IL_0283: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.OptionsMenu::onClickDeleteSavegame
IL_0288: ldarg.0
IL_0289: ldftn System.Void TheForestOfLove.MainMenuController::ConfirmDeleteSavegame()
IL_028f: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0294: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_0299: ldarg.0
IL_029a: ldfld TheForestOfLove.BugReportMenu TheForestOfLove.MainMenuController::bugReportMenu
IL_029f: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.BugReportMenu::onBack
IL_02a4: ldarg.0
IL_02a5: ldftn System.Void TheForestOfLove.MainMenuController::BugReportMenuBack()
IL_02ab: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_02b0: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_02b5: ldarg.0
IL_02b6: ldfld TheForestOfLove.DelayedYesNoConfirmation TheForestOfLove.MainMenuController::quitConfirmation
IL_02bb: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.DelayedYesNoConfirmation::onClickYes
IL_02c0: ldarg.0
IL_02c1: ldftn System.Void TheForestOfLove.MainMenuController::QuitConfirmationYes()
IL_02c7: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_02cc: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_02d1: ldarg.0
IL_02d2: ldfld TheForestOfLove.DelayedYesNoConfirmation TheForestOfLove.MainMenuController::quitConfirmation
IL_02d7: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.DelayedYesNoConfirmation::onClickYesDelayed
IL_02dc: ldarg.0
IL_02dd: ldftn System.Void TheForestOfLove.MainMenuController::Quit()
IL_02e3: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_02e8: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_02ed: ldarg.0
IL_02ee: ldfld TheForestOfLove.DelayedYesNoConfirmation TheForestOfLove.MainMenuController::quitConfirmation
IL_02f3: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.DelayedYesNoConfirmation::onClickNo
IL_02f8: ldarg.0
IL_02f9: ldftn System.Void TheForestOfLove.MainMenuController::QuitConfirmationNo()
IL_02ff: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0304: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_0309: ldarg.0
IL_030a: ldfld TheForestOfLove.DelayedYesNoConfirmation TheForestOfLove.MainMenuController::deleteSavegameConfirmation
IL_030f: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.DelayedYesNoConfirmation::onClickYes
IL_0314: ldarg.0
IL_0315: ldftn System.Void TheForestOfLove.MainMenuController::DeleteSavegameConfirmationYes()
IL_031b: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0320: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_0325: ldarg.0
IL_0326: ldfld TheForestOfLove.DelayedYesNoConfirmation TheForestOfLove.MainMenuController::deleteSavegameConfirmation
IL_032b: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.DelayedYesNoConfirmation::onClickNo
IL_0330: ldarg.0
IL_0331: ldftn System.Void TheForestOfLove.MainMenuController::DeleteSavegameConfirmationNo()
IL_0337: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_033c: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_0341: ldarg.0
IL_0342: ldfld TheForestOfLove.StartScreenThankYouPage TheForestOfLove.MainMenuController::thankYouPage
IL_0347: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.StartScreenThankYouPage::onClickPatreon
IL_034c: ldarg.0
IL_034d: ldftn System.Void TheForestOfLove.MainMenuController::ShowPatreon()
IL_0353: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0358: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_035d: ldarg.0
IL_035e: ldfld TheForestOfLove.StartScreenThankYouPage TheForestOfLove.MainMenuController::thankYouPage
IL_0363: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.StartScreenThankYouPage::onClickWebsite
IL_0368: ldarg.0
IL_0369: ldftn System.Void TheForestOfLove.MainMenuController::ShowWebsite()
IL_036f: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0374: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_0379: ldarg.0
IL_037a: ldfld TheForestOfLove.StartScreenThankYouPage TheForestOfLove.MainMenuController::thankYouPage
IL_037f: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.StartScreenThankYouPage::onClickMenu
IL_0384: ldarg.0
IL_0385: ldftn System.Void TheForestOfLove.MainMenuController::ThankYouPageMenu()
IL_038b: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0390: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_0395: ldsfld System.Boolean TheForestOfLove.MainMenuController::gameJustStarted
IL_039a: brfalse.s IL_03aa
IL_039c: ldc.i4.0
IL_039d: stsfld System.Boolean TheForestOfLove.MainMenuController::gameJustStarted
IL_03a2: ldc.i4.1
IL_03a3: call System.Void TheForestOfLove.MainMenuController::set_showingSplashScreens(System.Boolean)
IL_03a8: br.s IL_03ba
IL_03aa: ldarg.0
IL_03ab: ldfld UnityEngine.Animator TheForestOfLove.MainMenuController::animator
IL_03b0: ldstr "skip_splash_screens"
IL_03b5: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_03ba: ldsfld System.Boolean Globals::isFinishingSoftReset
IL_03bf: brfalse.s IL_03c7
IL_03c1: ldc.i4.0
IL_03c2: stsfld System.Boolean Globals::isFinishingSoftReset
IL_03c7: ldarg.0
IL_03c8: ldfld TMPro.TMP_Text TheForestOfLove.MainMenuController::versionNumber
IL_03cd: ldstr "v"
IL_03d2: call System.String UnityEngine.Application::get_version()
IL_03d7: ldstr ".1"
IL_03dc: call System.String System.String::Concat(System.String,System.String,System.String)
IL_03e1: callvirt System.Void TMPro.TMP_Text::set_text(System.String)
IL_03e6: ret
METHOD System.Void TheForestOfLove.MainMenuController::.cctor()
IL_0000: ldc.i4.1
IL_0001: stsfld System.Boolean TheForestOfLove.MainMenuController::gameJustStarted
IL_0006: ret
