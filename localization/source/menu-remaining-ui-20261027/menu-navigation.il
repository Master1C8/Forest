TYPE TheForestOfLove.MainMenuController
METHOD System.Void TheForestOfLove.MainMenuController::MainMenuGallery() | attributes=Private, HideBySig | impl=IL
IL_0000: ldc.i4.1
IL_0001: call System.Boolean TheForestOfLove.TutorialHelper::HasPlayedTutorial(TheForestOfLove.Tutorial)
IL_0006: brfalse.s IL_003c
IL_0008: ldarg.0
IL_0009: ldfld TheForestOfLove.StartScreenMainMenu TheForestOfLove.MainMenuController::mainMenu
IL_000e: callvirt System.Void TheForestOfLove.UIPanelMenu::Hide()
IL_0013: ldarg.0
IL_0014: ldfld TheForestOfLove.StartScreenGalleryMenu TheForestOfLove.MainMenuController::galleryMenu
IL_0019: callvirt System.Void TheForestOfLove.UIPanelMenu::Open()
IL_001e: ldc.i4.1
IL_001f: call System.Void TheForestOfLove.MainMenuController::set_galleryMenuOpen(System.Boolean)
IL_0024: ldarg.0
IL_0025: ldfld UnityEngine.GameObject TheForestOfLove.MainMenuController::StartLogo
IL_002a: ldc.i4.0
IL_002b: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0030: ldarg.0
IL_0031: ldfld UnityEngine.GameObject TheForestOfLove.MainMenuController::MainMenuBackground
IL_0036: ldc.i4.0
IL_0037: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_003c: ret
METHOD System.Void TheForestOfLove.MainMenuController::MainMenuOptions() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.StartScreenMainMenu TheForestOfLove.MainMenuController::mainMenu
IL_0006: callvirt System.Void TheForestOfLove.UIPanelMenu::Hide()
IL_000b: ldarg.0
IL_000c: ldfld TheForestOfLove.OptionsMenu TheForestOfLove.MainMenuController::optionsMenu
IL_0011: callvirt System.Void TheForestOfLove.UIPanelMenu::Open()
IL_0016: ret
METHOD System.Void TheForestOfLove.MainMenuController::OptionsMenuBack() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.OptionsMenu TheForestOfLove.MainMenuController::optionsMenu
IL_0006: callvirt System.Void TheForestOfLove.UIPanelMenu::Close()
IL_000b: call TheForestOfLove.Services.Persistence.GlobalGeneralData TheForestOfLove.Services.Persistence.DataService::GetGlobalGeneralData()
IL_0010: dup
IL_0011: ldarg.0
IL_0012: ldfld TheForestOfLove.OptionsMenu TheForestOfLove.MainMenuController::optionsMenu
IL_0017: callvirt TheForestOfLove.Audio.VolumeController TheForestOfLove.OptionsMenu::get_volumeController()
IL_001c: callvirt System.Single TheForestOfLove.Audio.VolumeController::get_EffectsVolumeValue()
IL_0021: stfld System.Single TheForestOfLove.Services.Persistence.GlobalGeneralData::effectsVolumeValue
IL_0026: dup
IL_0027: ldarg.0
IL_0028: ldfld TheForestOfLove.OptionsMenu TheForestOfLove.MainMenuController::optionsMenu
IL_002d: callvirt TheForestOfLove.Audio.VolumeController TheForestOfLove.OptionsMenu::get_volumeController()
IL_0032: callvirt System.Single TheForestOfLove.Audio.VolumeController::get_MusicVolumeValue()
IL_0037: stfld System.Single TheForestOfLove.Services.Persistence.GlobalGeneralData::musicVolumeValue
IL_003c: dup
IL_003d: call System.Boolean TheForestOfLove.UI.WindowController::get_IsFullscreen()
IL_0042: stfld System.Boolean TheForestOfLove.Services.Persistence.GlobalGeneralData::isFullscreen
IL_0047: dup
IL_0048: call System.Boolean TheForestOfLove.UI.WindowController::get_EnableFullscreenStretch()
IL_004d: stfld System.Boolean TheForestOfLove.Services.Persistence.GlobalGeneralData::enableFullscreenStretch
IL_0052: call System.Int32 TheForestOfLove.UI.WindowController::get_WindowScalingIndex()
IL_0057: stfld System.Int32 TheForestOfLove.Services.Persistence.GlobalGeneralData::windowScalingIndex
IL_005c: call System.Void TheForestOfLove.Services.Persistence.SaveManager::SilentSaveGlobalDataOnly()
IL_0061: ldarg.0
IL_0062: ldfld TheForestOfLove.StartScreenMainMenu TheForestOfLove.MainMenuController::mainMenu
IL_0067: callvirt System.Void TheForestOfLove.UIPanelMenu::Open()
IL_006c: ret
