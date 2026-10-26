TYPE TheForestOfLove.MainMenuController
METHOD System.Void TheForestOfLove.MainMenuController::Start() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.0
IL_0002: call !!0 UnityEngine.Component::GetComponent<UnityEngine.Animator>()
IL_0007: stfld UnityEngine.Animator TheForestOfLove.MainMenuController::animator
IL_000c: ldarg.0
IL_000d: ldc.i4.1
IL_000e: call System.Void TheForestOfLove.MainMenuController::set_fadingIn(System.Boolean)
IL_0013: ldarg.0
IL_0014: ldfld TheForestOfLove.PlayMenu TheForestOfLove.MainMenuController::playMenu
IL_0019: call System.Boolean TheForestOfLove.Services.Persistence.SaveManager::get_HasSavedPlaySession()
IL_001e: callvirt System.Void TheForestOfLove.PlayMenu::set_showContinueButton(System.Boolean)
IL_0023: ldc.i4.1
IL_0024: call TheForestOfLove.Narrative.MovieRecord TheForestOfLove.Services.Persistence.DataService::GetMovieRecordByMovie(TheForestOfLove.Narrative.Movie)
IL_0029: stloc.0
IL_002a: ldloc.0
IL_002b: brfalse.s IL_005a
IL_002d: ldloc.0
IL_002e: callvirt System.Boolean TheForestOfLove.Narrative.MovieRecord::get_IsUnlocked()
IL_0033: brfalse.s IL_005a
IL_0035: ldarg.0
IL_0036: ldfld System.Boolean TheForestOfLove.MainMenuController::debugSuppressThankYouScreen
IL_003b: brtrue.s IL_005a
IL_003d: ldarg.0
IL_003e: ldc.i4.1
IL_003f: stfld System.Boolean TheForestOfLove.MainMenuController::showDemoThankYouScreen
IL_0044: ldarg.0
IL_0045: ldfld UnityEngine.Animator TheForestOfLove.MainMenuController::animator
IL_004a: ldstr "show_thank_you_screen"
IL_004f: ldarg.0
IL_0050: ldfld System.Boolean TheForestOfLove.MainMenuController::showDemoThankYouScreen
IL_0055: callvirt System.Void UnityEngine.Animator::SetBool(System.String,System.Boolean)
IL_005a: ldarg.0
IL_005b: ldfld TheForestOfLove.StartScreenMainMenu TheForestOfLove.MainMenuController::mainMenu
IL_0060: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.StartScreenMainMenu::onClickStart
IL_0065: ldarg.0
IL_0066: ldftn System.Void TheForestOfLove.MainMenuController::MainMenuPlay()
IL_006c: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0071: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_0076: ldarg.0
IL_0077: ldfld TheForestOfLove.StartScreenMainMenu TheForestOfLove.MainMenuController::mainMenu
IL_007c: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.StartScreenMainMenu::onClickGallery
IL_0081: ldarg.0
IL_0082: ldftn System.Void TheForestOfLove.MainMenuController::ShowGalleryTutorial()
IL_0088: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_008d: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_0092: ldarg.0
IL_0093: ldfld TheForestOfLove.StartScreenMainMenu TheForestOfLove.MainMenuController::mainMenu
IL_0098: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.StartScreenMainMenu::onClickGallery
IL_009d: ldarg.0
IL_009e: ldftn System.Void TheForestOfLove.MainMenuController::MainMenuGallery()
IL_00a4: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_00a9: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_00ae: ldarg.0
IL_00af: ldfld TheForestOfLove.StartScreenMainMenu TheForestOfLove.MainMenuController::mainMenu
IL_00b4: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.StartScreenMainMenu::onClickOptions
IL_00b9: ldarg.0
IL_00ba: ldftn System.Void TheForestOfLove.MainMenuController::MainMenuOptions()
IL_00c0: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_00c5: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_00ca: ldarg.0
IL_00cb: ldfld TheForestOfLove.StartScreenMainMenu TheForestOfLove.MainMenuController::mainMenu
IL_00d0: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.StartScreenMainMenu::onClickBugReport
IL_00d5: ldarg.0
IL_00d6: ldftn System.Void TheForestOfLove.MainMenuController::MainMenuBugReportMenu()
IL_00dc: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_00e1: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_00e6: ldarg.0
IL_00e7: ldfld TheForestOfLove.StartScreenMainMenu TheForestOfLove.MainMenuController::mainMenu
IL_00ec: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.StartScreenMainMenu::onClickControls
IL_00f1: ldarg.0
IL_00f2: ldftn System.Void TheForestOfLove.MainMenuController::MainMenuControls()
IL_00f8: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_00fd: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_0102: ldarg.0
IL_0103: ldfld TheForestOfLove.StartScreenMainMenu TheForestOfLove.MainMenuController::mainMenu
IL_0108: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.StartScreenMainMenu::onClickQuit
IL_010d: ldarg.0
IL_010e: ldftn System.Void TheForestOfLove.MainMenuController::MainMenuQuit()
IL_0114: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0119: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_011e: ldarg.0
IL_011f: ldfld TheForestOfLove.StartScreenMainMenu TheForestOfLove.MainMenuController::mainMenu
IL_0124: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.StartScreenMainMenu::onClickPatreon
IL_0129: ldarg.0
IL_012a: ldftn System.Void TheForestOfLove.MainMenuController::ShowPatreon()
IL_0130: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0135: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_013a: ldarg.0
IL_013b: ldfld TheForestOfLove.StartScreenMainMenu TheForestOfLove.MainMenuController::mainMenu
IL_0140: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.StartScreenMainMenu::onClickWebsite
IL_0145: ldarg.0
IL_0146: ldftn System.Void TheForestOfLove.MainMenuController::ShowWebsite()
IL_014c: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0151: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_0156: ldarg.0
IL_0157: ldfld TheForestOfLove.PlayMenu TheForestOfLove.MainMenuController::playMenu
IL_015c: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.PlayMenu::onClickStart
IL_0161: ldarg.0
IL_0162: ldftn System.Void TheForestOfLove.MainMenuController::PlayMenuStart()
IL_0168: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_016d: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_0172: ldarg.0
IL_0173: ldfld TheForestOfLove.PlayMenu TheForestOfLove.MainMenuController::playMenu
IL_0178: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.PlayMenu::onClickContinue
IL_017d: ldarg.0
IL_017e: ldftn System.Void TheForestOfLove.MainMenuController::PlayMenuContinue()
IL_0184: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0189: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_018e: ldarg.0
IL_018f: ldfld TheForestOfLove.PlayMenu TheForestOfLove.MainMenuController::playMenu
IL_0194: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.PlayMenu::onClickFastForward
IL_0199: ldarg.0
IL_019a: ldftn System.Void TheForestOfLove.MainMenuController::PlayMenuFastForward()
IL_01a0: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_01a5: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_01aa: ldarg.0
IL_01ab: ldfld TheForestOfLove.PlayMenu TheForestOfLove.MainMenuController::playMenu
IL_01b0: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.PlayMenu::onClickBack
IL_01b5: ldarg.0
IL_01b6: ldftn System.Void TheForestOfLove.MainMenuController::PlayMenuBack()
IL_01bc: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_01c1: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_01c6: ldarg.0
IL_01c7: ldfld TheForestOfLove.DelayedYesNoConfirmation TheForestOfLove.MainMenuController::newgameConfirmation
IL_01cc: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.DelayedYesNoConfirmation::onClickYes
IL_01d1: ldarg.0
IL_01d2: ldftn System.Void TheForestOfLove.MainMenuController::NewgameConfirmationYes()
IL_01d8: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_01dd: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_01e2: ldarg.0
IL_01e3: ldfld TheForestOfLove.DelayedYesNoConfirmation TheForestOfLove.MainMenuController::newgameConfirmation
IL_01e8: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.DelayedYesNoConfirmation::onClickNo
IL_01ed: ldarg.0
IL_01ee: ldftn System.Void TheForestOfLove.MainMenuController::NewgameConfirmationNo()
IL_01f4: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_01f9: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_01fe: ldarg.0
IL_01ff: ldfld TheForestOfLove.StartScreenGalleryMenu TheForestOfLove.MainMenuController::galleryMenu
IL_0204: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.StartScreenGalleryMenu::onExitGallery
IL_0209: ldarg.0
IL_020a: ldftn System.Void TheForestOfLove.MainMenuController::GalleryExit()
IL_0210: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0215: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_021a: ldarg.0
IL_021b: ldfld TheForestOfLove.StartScreenGalleryMenu TheForestOfLove.MainMenuController::galleryMenu
IL_0220: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.StartScreenGalleryMenu::onExitGalleryShowTutorial
IL_0225: ldarg.0
IL_0226: ldftn System.Void TheForestOfLove.MainMenuController::GalleryExitShowTutorial()
IL_022c: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0231: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_0236: ldarg.0
IL_0237: ldfld TheForestOfLove.StartScreenGalleryMenu TheForestOfLove.MainMenuController::galleryMenu
IL_023c: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.StartScreenGalleryMenu::onExitGalleryShowHint
IL_0241: ldarg.0
IL_0242: ldftn System.Void TheForestOfLove.MainMenuController::GalleryExitShowHint()
IL_0248: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_024d: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_0252: ldarg.0
IL_0253: ldfld TheForestOfLove.OptionsMenu TheForestOfLove.MainMenuController::optionsMenu
IL_0258: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.OptionsMenu::onClickBack
IL_025d: ldarg.0
IL_025e: ldftn System.Void TheForestOfLove.MainMenuController::OptionsMenuBack()
IL_0264: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0269: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_026e: ldarg.0
IL_026f: ldfld TheForestOfLove.OptionsMenu TheForestOfLove.MainMenuController::optionsMenu
IL_0274: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.OptionsMenu::onClickDeleteSavegame
IL_0279: ldarg.0
IL_027a: ldftn System.Void TheForestOfLove.MainMenuController::ConfirmDeleteSavegame()
IL_0280: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0285: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_028a: ldarg.0
IL_028b: ldfld TheForestOfLove.BugReportMenu TheForestOfLove.MainMenuController::bugReportMenu
IL_0290: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.BugReportMenu::onBack
IL_0295: ldarg.0
IL_0296: ldftn System.Void TheForestOfLove.MainMenuController::BugReportMenuBack()
IL_029c: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_02a1: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_02a6: ldarg.0
IL_02a7: ldfld TheForestOfLove.DelayedYesNoConfirmation TheForestOfLove.MainMenuController::quitConfirmation
IL_02ac: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.DelayedYesNoConfirmation::onClickYes
IL_02b1: ldarg.0
IL_02b2: ldftn System.Void TheForestOfLove.MainMenuController::QuitConfirmationYes()
IL_02b8: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_02bd: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_02c2: ldarg.0
IL_02c3: ldfld TheForestOfLove.DelayedYesNoConfirmation TheForestOfLove.MainMenuController::quitConfirmation
IL_02c8: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.DelayedYesNoConfirmation::onClickYesDelayed
IL_02cd: ldarg.0
IL_02ce: ldftn System.Void TheForestOfLove.MainMenuController::Quit()
IL_02d4: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_02d9: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_02de: ldarg.0
IL_02df: ldfld TheForestOfLove.DelayedYesNoConfirmation TheForestOfLove.MainMenuController::quitConfirmation
IL_02e4: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.DelayedYesNoConfirmation::onClickNo
IL_02e9: ldarg.0
IL_02ea: ldftn System.Void TheForestOfLove.MainMenuController::QuitConfirmationNo()
IL_02f0: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_02f5: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_02fa: ldarg.0
IL_02fb: ldfld TheForestOfLove.DelayedYesNoConfirmation TheForestOfLove.MainMenuController::deleteSavegameConfirmation
IL_0300: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.DelayedYesNoConfirmation::onClickYes
IL_0305: ldarg.0
IL_0306: ldftn System.Void TheForestOfLove.MainMenuController::DeleteSavegameConfirmationYes()
IL_030c: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0311: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_0316: ldarg.0
IL_0317: ldfld TheForestOfLove.DelayedYesNoConfirmation TheForestOfLove.MainMenuController::deleteSavegameConfirmation
IL_031c: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.DelayedYesNoConfirmation::onClickNo
IL_0321: ldarg.0
IL_0322: ldftn System.Void TheForestOfLove.MainMenuController::DeleteSavegameConfirmationNo()
IL_0328: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_032d: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_0332: ldarg.0
IL_0333: ldfld TheForestOfLove.StartScreenThankYouPage TheForestOfLove.MainMenuController::thankYouPage
IL_0338: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.StartScreenThankYouPage::onClickPatreon
IL_033d: ldarg.0
IL_033e: ldftn System.Void TheForestOfLove.MainMenuController::ShowPatreon()
IL_0344: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0349: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_034e: ldarg.0
IL_034f: ldfld TheForestOfLove.StartScreenThankYouPage TheForestOfLove.MainMenuController::thankYouPage
IL_0354: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.StartScreenThankYouPage::onClickWebsite
IL_0359: ldarg.0
IL_035a: ldftn System.Void TheForestOfLove.MainMenuController::ShowWebsite()
IL_0360: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0365: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_036a: ldarg.0
IL_036b: ldfld TheForestOfLove.StartScreenThankYouPage TheForestOfLove.MainMenuController::thankYouPage
IL_0370: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.StartScreenThankYouPage::onClickMenu
IL_0375: ldarg.0
IL_0376: ldftn System.Void TheForestOfLove.MainMenuController::ThankYouPageMenu()
IL_037c: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0381: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_0386: ldsfld System.Boolean TheForestOfLove.MainMenuController::gameJustStarted
IL_038b: brfalse.s IL_039b
IL_038d: ldc.i4.0
IL_038e: stsfld System.Boolean TheForestOfLove.MainMenuController::gameJustStarted
IL_0393: ldc.i4.1
IL_0394: call System.Void TheForestOfLove.MainMenuController::set_showingSplashScreens(System.Boolean)
IL_0399: br.s IL_03ab
IL_039b: ldarg.0
IL_039c: ldfld UnityEngine.Animator TheForestOfLove.MainMenuController::animator
IL_03a1: ldstr "skip_splash_screens"
IL_03a6: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_03ab: ldsfld System.Boolean Globals::isFinishingSoftReset
IL_03b0: brfalse.s IL_03b8
IL_03b2: ldc.i4.0
IL_03b3: stsfld System.Boolean Globals::isFinishingSoftReset
IL_03b8: ldarg.0
IL_03b9: ldfld TMPro.TMP_Text TheForestOfLove.MainMenuController::versionNumber
IL_03be: ldstr "v"
IL_03c3: call System.String UnityEngine.Application::get_version()
IL_03c8: ldstr ".1"
IL_03cd: call System.String System.String::Concat(System.String,System.String,System.String)
IL_03d2: callvirt System.Void TMPro.TMP_Text::set_text(System.String)
IL_03d7: ret
METHOD System.Void TheForestOfLove.MainMenuController::OnMainMenuFadedOut() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.MainMenuController::LoadOverworld()
IL_0006: ret
METHOD System.Void TheForestOfLove.MainMenuController::LoadOverworld() | attributes=Private, HideBySig | impl=IL
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
METHOD System.Void TheForestOfLove.MainMenuController::MainMenuPlay() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.StartScreenMainMenu TheForestOfLove.MainMenuController::mainMenu
IL_0006: callvirt System.Void TheForestOfLove.UIPanelMenu::Hide()
IL_000b: ldarg.0
IL_000c: ldfld TheForestOfLove.PlayMenu TheForestOfLove.MainMenuController::playMenu
IL_0011: callvirt System.Void TheForestOfLove.UIPanelMenu::Open()
IL_0016: ret
METHOD System.Void TheForestOfLove.MainMenuController::PlayMenuContinue() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.MainMenuController::ContinueSavedGame()
IL_0006: ret
METHOD System.Void TheForestOfLove.MainMenuController::ContinueSavedGame() | attributes=Private, HideBySig | impl=IL
IL_0000: call UnityEngine.EventSystems.EventSystem UnityEngine.EventSystems.EventSystem::get_current()
IL_0005: ldnull
IL_0006: callvirt System.Void UnityEngine.EventSystems.EventSystem::SetSelectedGameObject(UnityEngine.GameObject)
IL_000b: ldarg.0
IL_000c: ldfld UnityEngine.Animator TheForestOfLove.MainMenuController::animator
IL_0011: ldstr "fade_out"
IL_0016: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_001b: call !!0 UnityEngine.Object::FindObjectOfType<TheForestOfLove.TouchInputHelper>()
IL_0020: stloc.0
IL_0021: ldloc.0
IL_0022: ldnull
IL_0023: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0028: brfalse.s IL_0031
IL_002a: ldloc.0
IL_002b: ldc.i4.1
IL_002c: callvirt System.Void TheForestOfLove.TouchInputHelper::set_IsStartMenuLoadingGameHackPLZFIX(System.Boolean)
IL_0031: call System.Void TheForestOfLove.Audio.MusicManager::MuteMusic()
IL_0036: ret
