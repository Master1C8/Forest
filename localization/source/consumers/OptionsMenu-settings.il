TYPE TheForestOfLove.OptionsMenu
METHOD System.Boolean TheForestOfLove.OptionsMenu::get_IsFullscreen()
IL_0000: ldarg.0
IL_0001: ldfld System.Boolean TheForestOfLove.OptionsMenu::enableDebugMode
IL_0006: brtrue.s IL_000e
IL_0008: call System.Boolean TheForestOfLove.UI.WindowController::get_IsFullscreen()
IL_000d: ret
IL_000e: ldarg.0
IL_000f: ldfld System.Int32 TheForestOfLove.OptionsMenu::debugFullscreenState
IL_0014: ldc.i4.0
IL_0015: cgt
IL_0017: ret
METHOD System.Void TheForestOfLove.OptionsMenu::ConfigureForEverythingElse()
IL_0000: ldarg.0
IL_0001: ldfld UnityEngine.GameObject TheForestOfLove.OptionsMenu::optionsFullscreenControls
IL_0006: callvirt UnityEngine.GameObject UnityEngine.GameObject::get_gameObject()
IL_000b: ldc.i4.1
IL_000c: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0011: ldarg.0
IL_0012: ldfld UnityEngine.GameObject TheForestOfLove.OptionsMenu::optionsFullscreenYes
IL_0017: ldarg.0
IL_0018: call System.Boolean TheForestOfLove.OptionsMenu::get_IsFullscreen()
IL_001d: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0022: ldarg.0
IL_0023: ldfld UnityEngine.GameObject TheForestOfLove.OptionsMenu::optionsFullscreenNo
IL_0028: ldarg.0
IL_0029: call System.Boolean TheForestOfLove.OptionsMenu::get_IsFullscreen()
IL_002e: ldc.i4.0
IL_002f: ceq
IL_0031: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0036: ldarg.0
IL_0037: ldfld UnityEngine.GameObject TheForestOfLove.OptionsMenu::optionsFullscreenStretchControls
IL_003c: callvirt UnityEngine.GameObject UnityEngine.GameObject::get_gameObject()
IL_0041: ldarg.0
IL_0042: call System.Boolean TheForestOfLove.OptionsMenu::get_IsFullscreen()
IL_0047: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_004c: ldarg.0
IL_004d: ldfld UnityEngine.GameObject TheForestOfLove.OptionsMenu::optionsFullscreenStretchYes
IL_0052: call System.Boolean TheForestOfLove.UI.WindowController::get_EnableFullscreenStretch()
IL_0057: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_005c: ldarg.0
IL_005d: ldfld UnityEngine.GameObject TheForestOfLove.OptionsMenu::optionsFullscreenStretchNo
IL_0062: call System.Boolean TheForestOfLove.UI.WindowController::get_EnableFullscreenStretch()
IL_0067: ldc.i4.0
IL_0068: ceq
IL_006a: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_006f: ldarg.0
IL_0070: ldfld UnityEngine.GameObject TheForestOfLove.OptionsMenu::optionsScaleFactor
IL_0075: callvirt UnityEngine.GameObject UnityEngine.GameObject::get_gameObject()
IL_007a: ldarg.0
IL_007b: call System.Boolean TheForestOfLove.OptionsMenu::get_IsFullscreen()
IL_0080: ldc.i4.0
IL_0081: ceq
IL_0083: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0088: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inStartMenu()
IL_008d: brtrue.s IL_00a0
IL_008f: ldarg.0
IL_0090: ldfld UnityEngine.UI.Button TheForestOfLove.OptionsMenu::optionsControlsButton
IL_0095: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_009a: ldc.i4.1
IL_009b: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_00a0: ldarg.0
IL_00a1: call System.Void TheForestOfLove.OptionsMenu::UpdateWindowScaleFactorUI()
IL_00a6: ldarg.0
IL_00a7: call System.Void TheForestOfLove.OptionsMenu::RewireButtonNavigationAroundFullscreenOption()
IL_00ac: ldarg.0
IL_00ad: ldfld UnityEngine.GameObject TheForestOfLove.OptionsMenu::optionsDeleteSavegameControl
IL_00b2: ldnull
IL_00b3: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_00b8: brfalse.s IL_00ca
IL_00ba: ldarg.0
IL_00bb: ldfld UnityEngine.GameObject TheForestOfLove.OptionsMenu::optionsDeleteSavegameControl
IL_00c0: call System.Boolean TheForestOfLove.Services.Persistence.SaveManager::get_HasSavedPlaySession()
IL_00c5: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_00ca: ret
METHOD System.Void TheForestOfLove.OptionsMenu::UpdateWindowScaleFactorUI()
IL_0000: ldarg.0
IL_0001: ldfld UnityEngine.UI.Image[] TheForestOfLove.OptionsMenu::optionsScaleFactors
IL_0006: stloc.0
IL_0007: ldc.i4.0
IL_0008: stloc.1
IL_0009: br.s IL_001d
IL_000b: ldloc.0
IL_000c: ldloc.1
IL_000d: ldelem.ref
IL_000e: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0013: ldc.i4.0
IL_0014: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0019: ldloc.1
IL_001a: ldc.i4.1
IL_001b: add
IL_001c: stloc.1
IL_001d: ldloc.1
IL_001e: ldloc.0
IL_001f: ldlen
IL_0020: conv.i4
IL_0021: blt.s IL_000b
IL_0023: ldarg.0
IL_0024: ldfld UnityEngine.UI.Image[] TheForestOfLove.OptionsMenu::optionsScaleFactors
IL_0029: call System.Int32 TheForestOfLove.UI.WindowController::get_WindowScalingIndex()
IL_002e: ldc.i4.0
IL_002f: ldarg.0
IL_0030: ldfld UnityEngine.UI.Image[] TheForestOfLove.OptionsMenu::optionsScaleFactors
IL_0035: ldlen
IL_0036: conv.i4
IL_0037: ldc.i4.1
IL_0038: sub
IL_0039: call System.Int32 UnityEngine.Mathf::Clamp(System.Int32,System.Int32,System.Int32)
IL_003e: ldelem.ref
IL_003f: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0044: ldc.i4.1
IL_0045: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_004a: ldarg.0
IL_004b: ldfld UnityEngine.CanvasGroup TheForestOfLove.OptionsMenu::optionsScaleFactorMoreOptionsAbove
IL_0050: ldarg.0
IL_0051: ldfld System.Boolean TheForestOfLove.OptionsMenu::selectedScaleFactorControls
IL_0056: brfalse.s IL_005f
IL_0058: call System.Boolean TheForestOfLove.UI.WindowController::CanScaleUp()
IL_005d: brtrue.s IL_0062
IL_005f: ldc.i4.0
IL_0060: br.s IL_0063
IL_0062: ldc.i4.1
IL_0063: conv.r4
IL_0064: callvirt System.Void UnityEngine.CanvasGroup::set_alpha(System.Single)
IL_0069: ldarg.0
IL_006a: ldfld UnityEngine.CanvasGroup TheForestOfLove.OptionsMenu::optionsScaleFactorMoreOptionsBelow
IL_006f: ldarg.0
IL_0070: ldfld System.Boolean TheForestOfLove.OptionsMenu::selectedScaleFactorControls
IL_0075: brfalse.s IL_007e
IL_0077: call System.Boolean TheForestOfLove.UI.WindowController::CanScaleDown()
IL_007c: brtrue.s IL_0081
IL_007e: ldc.i4.0
IL_007f: br.s IL_0082
IL_0081: ldc.i4.1
IL_0082: conv.r4
IL_0083: callvirt System.Void UnityEngine.CanvasGroup::set_alpha(System.Single)
IL_0088: ret
METHOD System.Void TheForestOfLove.OptionsMenu::OnClickFullscreen()
IL_0000: ldarg.0
IL_0001: ldfld System.Int32 TheForestOfLove.OptionsMenu::waitFramesToClearInput
IL_0006: ldc.i4.0
IL_0007: ble.s IL_000a
IL_0009: ret
IL_000a: ldarg.0
IL_000b: ldc.i4.2
IL_000c: stfld System.Int32 TheForestOfLove.OptionsMenu::waitFramesToClearInput
IL_0011: call System.Void TheForestOfLove.UI.WindowController::ToggleFullscreen()
IL_0016: ldarg.0
IL_0017: ldfld UnityEngine.GameObject TheForestOfLove.OptionsMenu::optionsFullscreenYes
IL_001c: ldarg.0
IL_001d: call System.Boolean TheForestOfLove.OptionsMenu::get_IsFullscreen()
IL_0022: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0027: ldarg.0
IL_0028: ldfld UnityEngine.GameObject TheForestOfLove.OptionsMenu::optionsFullscreenNo
IL_002d: ldarg.0
IL_002e: call System.Boolean TheForestOfLove.OptionsMenu::get_IsFullscreen()
IL_0033: ldc.i4.0
IL_0034: ceq
IL_0036: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_003b: ldarg.0
IL_003c: ldfld UnityEngine.GameObject TheForestOfLove.OptionsMenu::optionsFullscreenStretchControls
IL_0041: callvirt UnityEngine.GameObject UnityEngine.GameObject::get_gameObject()
IL_0046: ldarg.0
IL_0047: call System.Boolean TheForestOfLove.OptionsMenu::get_IsFullscreen()
IL_004c: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0051: ldarg.0
IL_0052: ldfld UnityEngine.GameObject TheForestOfLove.OptionsMenu::optionsScaleFactor
IL_0057: callvirt UnityEngine.GameObject UnityEngine.GameObject::get_gameObject()
IL_005c: ldarg.0
IL_005d: call System.Boolean TheForestOfLove.OptionsMenu::get_IsFullscreen()
IL_0062: ldc.i4.0
IL_0063: ceq
IL_0065: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_006a: ldarg.0
IL_006b: call System.Void TheForestOfLove.OptionsMenu::RewireButtonNavigationAroundFullscreenOption()
IL_0070: ldarg.0
IL_0071: call System.Void TheForestOfLove.OptionsMenu::UpdateWindowScaleFactorUI()
IL_0076: ldc.i4.s 100
IL_0078: call System.Void TheForestOfLove.Audio.SoundManager::Play(TheForestOfLove.Audio.SoundEffect)
IL_007d: ret
