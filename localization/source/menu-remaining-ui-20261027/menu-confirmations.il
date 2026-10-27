TYPE TheForestOfLove.MainMenuController
METHOD System.Void TheForestOfLove.MainMenuController::PlayMenuStart() | attributes=Private, HideBySig | impl=IL
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
METHOD System.Void TheForestOfLove.MainMenuController::PlayMenuFastForward() | attributes=Private, HideBySig | impl=IL
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
METHOD System.Void TheForestOfLove.MainMenuController::ShowGalleryTutorial() | attributes=Private, HideBySig | impl=IL
IL_0000: ldc.i4.1
IL_0001: call System.Boolean TheForestOfLove.TutorialHelper::HasPlayedTutorial(TheForestOfLove.Tutorial)
IL_0006: brtrue.s IL_0031
IL_0008: ldarg.0
IL_0009: ldfld TheForestOfLove.StartScreenMainMenu TheForestOfLove.MainMenuController::mainMenu
IL_000e: callvirt System.Void TheForestOfLove.UIPanelMenu::Hide()
IL_0013: ldc.i4.1
IL_0014: ldarg.0
IL_0015: ldftn System.Void TheForestOfLove.MainMenuController::MainMenuGallery()
IL_001b: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0020: call System.Void TheForestOfLove.TutorialHelper::StartTutorial(TheForestOfLove.Tutorial,System.Action)
IL_0025: ldarg.0
IL_0026: ldfld UnityEngine.GameObject TheForestOfLove.MainMenuController::StartLogo
IL_002b: ldc.i4.0
IL_002c: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0031: ret
METHOD System.Void TheForestOfLove.MainMenuController::ConfirmDeleteSavegame() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.OptionsMenu TheForestOfLove.MainMenuController::optionsMenu
IL_0006: callvirt System.Void TheForestOfLove.UIPanelMenu::Hide()
IL_000b: ldarg.0
IL_000c: ldfld TheForestOfLove.DelayedYesNoConfirmation TheForestOfLove.MainMenuController::deleteSavegameConfirmation
IL_0011: callvirt System.Void TheForestOfLove.UIPanelMenu::Open()
IL_0016: ret
METHOD System.Void TheForestOfLove.MainMenuController::DeleteSavegameConfirmationYes() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.MainMenuController::DeleteLocalSavestate()
IL_0006: ldarg.0
IL_0007: call System.Void TheForestOfLove.MainMenuController::DeleteGlobalSavestate()
IL_000c: ldarg.0
IL_000d: ldfld TheForestOfLove.DelayedYesNoConfirmation TheForestOfLove.MainMenuController::deleteSavegameConfirmation
IL_0012: callvirt System.Void TheForestOfLove.UIPanelMenu::Close()
IL_0017: ldarg.0
IL_0018: ldfld TheForestOfLove.OptionsMenu TheForestOfLove.MainMenuController::optionsMenu
IL_001d: callvirt System.Void TheForestOfLove.UIPanelMenu::Close()
IL_0022: ldarg.0
IL_0023: ldfld TheForestOfLove.OptionsMenu TheForestOfLove.MainMenuController::optionsMenu
IL_0028: callvirt System.Void TheForestOfLove.UIPanelMenu::Open()
IL_002d: ldarg.0
IL_002e: ldfld TheForestOfLove.OptionsMenu TheForestOfLove.MainMenuController::optionsMenu
IL_0033: callvirt System.Void TheForestOfLove.OptionsMenu::OnSavegameDeletedCallback()
IL_0038: ldarg.0
IL_0039: ldfld TheForestOfLove.PlayMenu TheForestOfLove.MainMenuController::playMenu
IL_003e: ldc.i4.0
IL_003f: callvirt System.Void TheForestOfLove.PlayMenu::set_showContinueButton(System.Boolean)
IL_0044: ldarg.0
IL_0045: ldfld TheForestOfLove.PlayMenu TheForestOfLove.MainMenuController::playMenu
IL_004a: callvirt System.Void TheForestOfLove.PlayMenu::HideContinueButton()
IL_004f: ret
METHOD System.Void TheForestOfLove.MainMenuController::DeleteSavegameConfirmationNo() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.DelayedYesNoConfirmation TheForestOfLove.MainMenuController::deleteSavegameConfirmation
IL_0006: callvirt System.Void TheForestOfLove.UIPanelMenu::Close()
IL_000b: ldarg.0
IL_000c: ldfld TheForestOfLove.OptionsMenu TheForestOfLove.MainMenuController::optionsMenu
IL_0011: callvirt System.Void TheForestOfLove.UIPanelMenu::Open()
IL_0016: ret
