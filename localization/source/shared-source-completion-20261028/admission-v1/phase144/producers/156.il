TYPE TheForestOfLove.UI.WindowController
METHOD System.Void TheForestOfLove.UI.WindowController::UpdateWindowSize() | attributes=Private, HideBySig | impl=IL
IL_0000: ldc.i4.0
IL_0001: call System.Void TheForestOfLove.UI.WindowController::set_IsFullscreen(System.Boolean)
IL_0006: ldarg.0
IL_0007: ldfld System.Collections.Generic.List`1<TheForestOfLove.UI.WindowController/WindowSizeSettings> TheForestOfLove.UI.WindowController::windowSizeSettings
IL_000c: ldarg.0
IL_000d: ldfld System.Int32 TheForestOfLove.UI.WindowController::currentSizeSettingsIndex
IL_0012: callvirt !0 System.Collections.Generic.List`1<TheForestOfLove.UI.WindowController/WindowSizeSettings>::get_Item(System.Int32)
IL_0017: stloc.0
IL_0018: ldloc.0
IL_0019: ldfld System.Int32 TheForestOfLove.UI.WindowController/WindowSizeSettings::targetWidth
IL_001e: ldloc.0
IL_001f: ldfld System.Int32 TheForestOfLove.UI.WindowController/WindowSizeSettings::targetHeight
IL_0024: ldc.i4.0
IL_0025: ldc.i4.s 60
IL_0027: call System.Void UnityEngine.Screen::SetResolution(System.Int32,System.Int32,System.Boolean,System.Int32)
IL_002c: call TheForestOfLove.Services.Persistence.GlobalGeneralData TheForestOfLove.Services.Persistence.DataService::GetGlobalGeneralData()
IL_0031: dup
IL_0032: call System.Boolean TheForestOfLove.UI.WindowController::get_IsFullscreen()
IL_0037: stfld System.Boolean TheForestOfLove.Services.Persistence.GlobalGeneralData::isFullscreen
IL_003c: dup
IL_003d: call System.Boolean TheForestOfLove.UI.WindowController::get_EnableFullscreenStretch()
IL_0042: stfld System.Boolean TheForestOfLove.Services.Persistence.GlobalGeneralData::enableFullscreenStretch
IL_0047: call System.Int32 TheForestOfLove.UI.WindowController::get_WindowScalingIndex()
IL_004c: stfld System.Int32 TheForestOfLove.Services.Persistence.GlobalGeneralData::windowScalingIndex
IL_0051: call System.Void TheForestOfLove.Services.Persistence.SaveManager::SilentSaveGlobalDataOnly()
IL_0056: call !!0 UnityEngine.Object::FindObjectOfType<TheForestOfLove.PixelPerfectCameraController>()
IL_005b: stloc.1
IL_005c: ldloc.1
IL_005d: ldnull
IL_005e: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0063: brfalse.s IL_006c
IL_0065: ldloc.1
IL_0066: ldc.i4.0
IL_0067: callvirt System.Void TheForestOfLove.PixelPerfectCameraController::SetFullscreenStretch(System.Boolean)
IL_006c: ldc.i4.6
IL_006d: newarr System.String
IL_0072: dup
IL_0073: ldc.i4.0
IL_0074: ldstr "Window set to "
IL_0079: stelem.ref
IL_007a: dup
IL_007b: ldc.i4.1
IL_007c: ldloc.0
IL_007d: ldflda System.Int32 TheForestOfLove.UI.WindowController/WindowSizeSettings::targetWidth
IL_0082: call System.String System.Int32::ToString()
IL_0087: stelem.ref
IL_0088: dup
IL_0089: ldc.i4.2
IL_008a: ldstr "x"
IL_008f: stelem.ref
IL_0090: dup
IL_0091: ldc.i4.3
IL_0092: ldloc.0
IL_0093: ldflda System.Int32 TheForestOfLove.UI.WindowController/WindowSizeSettings::targetHeight
IL_0098: call System.String System.Int32::ToString()
IL_009d: stelem.ref
IL_009e: dup
IL_009f: ldc.i4.4
IL_00a0: ldstr " at index "
IL_00a5: stelem.ref
IL_00a6: dup
IL_00a7: ldc.i4.5
IL_00a8: ldarg.0
IL_00a9: ldflda System.Int32 TheForestOfLove.UI.WindowController::currentSizeSettingsIndex
IL_00ae: call System.String System.Int32::ToString()
IL_00b3: stelem.ref
IL_00b4: call System.String System.String::Concat(System.String[])
IL_00b9: call System.Void UnityEngine.Debug::Log(System.Object)
IL_00be: ret
