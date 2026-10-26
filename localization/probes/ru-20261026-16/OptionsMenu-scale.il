TYPE TheForestOfLove.OptionsMenu
METHOD System.Void TheForestOfLove.OptionsMenu::Update()
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.UIPanelMenu::Update()
IL_0006: ldarg.0
IL_0007: ldarg.0
IL_0008: ldfld System.Int32 TheForestOfLove.OptionsMenu::waitFramesToClearInput
IL_000d: ldc.i4.1
IL_000e: sub
IL_000f: stfld System.Int32 TheForestOfLove.OptionsMenu::waitFramesToClearInput
IL_0014: ldarg.0
IL_0015: ldfld System.Int32 TheForestOfLove.OptionsMenu::waitFramesToClearInput
IL_001a: brtrue.s IL_003b
IL_001c: ldarg.0
IL_001d: ldfld System.Boolean TheForestOfLove.OptionsMenu::needToReselectScaleFactorBaseOption
IL_0022: brfalse.s IL_003b
IL_0024: ldarg.0
IL_0025: ldc.i4.0
IL_0026: stfld System.Boolean TheForestOfLove.OptionsMenu::needToReselectScaleFactorBaseOption
IL_002b: call UnityEngine.EventSystems.EventSystem UnityEngine.EventSystems.EventSystem::get_current()
IL_0030: ldarg.0
IL_0031: ldfld UnityEngine.GameObject TheForestOfLove.OptionsMenu::optionsScaleFactor
IL_0036: callvirt System.Void UnityEngine.EventSystems.EventSystem::SetSelectedGameObject(UnityEngine.GameObject)
IL_003b: ret
METHOD System.Void TheForestOfLove.OptionsMenu::OnSelectScaleFactorControls()
IL_0000: ldarg.0
IL_0001: ldc.i4.1
IL_0002: stfld System.Boolean TheForestOfLove.OptionsMenu::selectedScaleFactorControls
IL_0007: ldarg.0
IL_0008: call System.Void TheForestOfLove.OptionsMenu::UpdateWindowScaleFactorUI()
IL_000d: ret
METHOD System.Void TheForestOfLove.OptionsMenu::OnDeselectScaleFactorControls()
IL_0000: ldarg.0
IL_0001: ldc.i4.0
IL_0002: stfld System.Boolean TheForestOfLove.OptionsMenu::selectedScaleFactorControls
IL_0007: ldarg.0
IL_0008: call System.Void TheForestOfLove.OptionsMenu::UpdateWindowScaleFactorUI()
IL_000d: ret
METHOD System.Void TheForestOfLove.OptionsMenu::OnClickScaleFactorUp()
IL_0000: ldarg.0
IL_0001: ldfld System.Int32 TheForestOfLove.OptionsMenu::waitFramesToClearInput
IL_0006: ldc.i4.0
IL_0007: ble.s IL_000a
IL_0009: ret
IL_000a: ldarg.0
IL_000b: ldc.i4.2
IL_000c: stfld System.Int32 TheForestOfLove.OptionsMenu::waitFramesToClearInput
IL_0011: call System.Void TheForestOfLove.UI.WindowController::ScaleUp()
IL_0016: ldarg.0
IL_0017: call System.Void TheForestOfLove.OptionsMenu::UpdateWindowScaleFactorUI()
IL_001c: ldarg.0
IL_001d: ldc.i4.1
IL_001e: stfld System.Boolean TheForestOfLove.OptionsMenu::needToReselectScaleFactorBaseOption
IL_0023: ldc.i4.s 100
IL_0025: call System.Void TheForestOfLove.Audio.SoundManager::Play(TheForestOfLove.Audio.SoundEffect)
IL_002a: ret
METHOD System.Void TheForestOfLove.OptionsMenu::OnClickScaleFactorDown()
IL_0000: ldarg.0
IL_0001: ldfld System.Int32 TheForestOfLove.OptionsMenu::waitFramesToClearInput
IL_0006: ldc.i4.0
IL_0007: ble.s IL_000a
IL_0009: ret
IL_000a: ldarg.0
IL_000b: ldc.i4.2
IL_000c: stfld System.Int32 TheForestOfLove.OptionsMenu::waitFramesToClearInput
IL_0011: call System.Void TheForestOfLove.UI.WindowController::ScaleDown()
IL_0016: ldarg.0
IL_0017: call System.Void TheForestOfLove.OptionsMenu::UpdateWindowScaleFactorUI()
IL_001c: ldarg.0
IL_001d: ldc.i4.1
IL_001e: stfld System.Boolean TheForestOfLove.OptionsMenu::needToReselectScaleFactorBaseOption
IL_0023: ldc.i4.s 100
IL_0025: call System.Void TheForestOfLove.Audio.SoundManager::Play(TheForestOfLove.Audio.SoundEffect)
IL_002a: ret
