TYPE TheForestOfLove.UI.WindowController
METHOD System.Void TheForestOfLove.UI.WindowController::InitializeWindowSizeSettings()
IL_0000: ldarg.0
IL_0001: ldfld System.Collections.Generic.List`1<TheForestOfLove.UI.WindowController/WindowSizeSettings> TheForestOfLove.UI.WindowController::windowSizeSettings
IL_0006: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.UI.WindowController/WindowSizeSettings>::GetEnumerator()
IL_000b: stloc.0
IL_000c: br.s IL_0049
IL_000e: ldloca.s V_0
IL_0010: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.UI.WindowController/WindowSizeSettings>::get_Current()
IL_0015: stloc.1
IL_0016: ldloc.1
IL_0017: ldloc.1
IL_0018: ldfld System.Int32 TheForestOfLove.UI.WindowController/WindowSizeSettings::targetWidth
IL_001d: call UnityEngine.Resolution UnityEngine.Screen::get_currentResolution()
IL_0022: stloc.2
IL_0023: ldloca.s V_2
IL_0025: call System.Int32 UnityEngine.Resolution::get_width()
IL_002a: bge.s IL_0043
IL_002c: ldloc.1
IL_002d: ldfld System.Int32 TheForestOfLove.UI.WindowController/WindowSizeSettings::targetHeight
IL_0032: call UnityEngine.Resolution UnityEngine.Screen::get_currentResolution()
IL_0037: stloc.2
IL_0038: ldloca.s V_2
IL_003a: call System.Int32 UnityEngine.Resolution::get_height()
IL_003f: clt
IL_0041: br.s IL_0044
IL_0043: ldc.i4.0
IL_0044: stfld System.Boolean TheForestOfLove.UI.WindowController/WindowSizeSettings::eligible
IL_0049: ldloca.s V_0
IL_004b: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.UI.WindowController/WindowSizeSettings>::MoveNext()
IL_0050: brtrue.s IL_000e
IL_0052: leave.s IL_0062
IL_0054: ldloca.s V_0
IL_0056: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.UI.WindowController/WindowSizeSettings>
IL_005c: callvirt System.Void System.IDisposable::Dispose()
IL_0061: endfinally
IL_0062: ldarg.0
IL_0063: ldfld System.Collections.Generic.List`1<TheForestOfLove.UI.WindowController/WindowSizeSettings> TheForestOfLove.UI.WindowController::windowSizeSettings
IL_0068: ldc.i4.0
IL_0069: callvirt !0 System.Collections.Generic.List`1<TheForestOfLove.UI.WindowController/WindowSizeSettings>::get_Item(System.Int32)
IL_006e: ldc.i4.0
IL_006f: stfld System.Boolean TheForestOfLove.UI.WindowController/WindowSizeSettings::eligible
IL_0074: ldarg.0
IL_0075: ldfld System.Collections.Generic.List`1<TheForestOfLove.UI.WindowController/WindowSizeSettings> TheForestOfLove.UI.WindowController::windowSizeSettings
IL_007a: ldc.i4.1
IL_007b: callvirt !0 System.Collections.Generic.List`1<TheForestOfLove.UI.WindowController/WindowSizeSettings>::get_Item(System.Int32)
IL_0080: ldc.i4.1
IL_0081: stfld System.Boolean TheForestOfLove.UI.WindowController/WindowSizeSettings::eligible
IL_0086: ret
METHOD System.Void TheForestOfLove.UI.WindowController::UpdateWindowSize()
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
METHOD System.Boolean TheForestOfLove.UI.WindowController::CanScaleUp_Internal()
IL_0000: ldarg.0
IL_0001: ldfld System.Int32 TheForestOfLove.UI.WindowController::currentSizeSettingsIndex
IL_0006: ldarg.0
IL_0007: ldfld System.Collections.Generic.List`1<TheForestOfLove.UI.WindowController/WindowSizeSettings> TheForestOfLove.UI.WindowController::windowSizeSettings
IL_000c: callvirt System.Int32 System.Collections.Generic.List`1<TheForestOfLove.UI.WindowController/WindowSizeSettings>::get_Count()
IL_0011: ldc.i4.1
IL_0012: sub
IL_0013: bge.s IL_002e
IL_0015: ldarg.0
IL_0016: ldfld System.Collections.Generic.List`1<TheForestOfLove.UI.WindowController/WindowSizeSettings> TheForestOfLove.UI.WindowController::windowSizeSettings
IL_001b: ldarg.0
IL_001c: ldfld System.Int32 TheForestOfLove.UI.WindowController::currentSizeSettingsIndex
IL_0021: ldc.i4.1
IL_0022: add
IL_0023: callvirt !0 System.Collections.Generic.List`1<TheForestOfLove.UI.WindowController/WindowSizeSettings>::get_Item(System.Int32)
IL_0028: ldfld System.Boolean TheForestOfLove.UI.WindowController/WindowSizeSettings::eligible
IL_002d: ret
IL_002e: ldc.i4.0
IL_002f: ret
METHOD System.Void TheForestOfLove.UI.WindowController::ScaleUp_Internal()
IL_0000: ldarg.0
IL_0001: call System.Boolean TheForestOfLove.UI.WindowController::CanScaleUp_Internal()
IL_0006: brfalse.s IL_001c
IL_0008: ldarg.0
IL_0009: ldarg.0
IL_000a: ldfld System.Int32 TheForestOfLove.UI.WindowController::currentSizeSettingsIndex
IL_000f: ldc.i4.1
IL_0010: add
IL_0011: stfld System.Int32 TheForestOfLove.UI.WindowController::currentSizeSettingsIndex
IL_0016: ldarg.0
IL_0017: call System.Void TheForestOfLove.UI.WindowController::UpdateWindowSize()
IL_001c: ret
METHOD System.Boolean TheForestOfLove.UI.WindowController::CanScaleDown_Internal()
IL_0000: ldarg.0
IL_0001: ldfld System.Int32 TheForestOfLove.UI.WindowController::currentSizeSettingsIndex
IL_0006: ldc.i4.0
IL_0007: ble.s IL_0022
IL_0009: ldarg.0
IL_000a: ldfld System.Collections.Generic.List`1<TheForestOfLove.UI.WindowController/WindowSizeSettings> TheForestOfLove.UI.WindowController::windowSizeSettings
IL_000f: ldarg.0
IL_0010: ldfld System.Int32 TheForestOfLove.UI.WindowController::currentSizeSettingsIndex
IL_0015: ldc.i4.1
IL_0016: sub
IL_0017: callvirt !0 System.Collections.Generic.List`1<TheForestOfLove.UI.WindowController/WindowSizeSettings>::get_Item(System.Int32)
IL_001c: ldfld System.Boolean TheForestOfLove.UI.WindowController/WindowSizeSettings::eligible
IL_0021: ret
IL_0022: ldc.i4.0
IL_0023: ret
METHOD System.Void TheForestOfLove.UI.WindowController::ScaleDown_Internal()
IL_0000: ldarg.0
IL_0001: call System.Boolean TheForestOfLove.UI.WindowController::CanScaleDown_Internal()
IL_0006: brfalse.s IL_001c
IL_0008: ldarg.0
IL_0009: ldarg.0
IL_000a: ldfld System.Int32 TheForestOfLove.UI.WindowController::currentSizeSettingsIndex
IL_000f: ldc.i4.1
IL_0010: sub
IL_0011: stfld System.Int32 TheForestOfLove.UI.WindowController::currentSizeSettingsIndex
IL_0016: ldarg.0
IL_0017: call System.Void TheForestOfLove.UI.WindowController::UpdateWindowSize()
IL_001c: ret
METHOD System.Void TheForestOfLove.UI.WindowController::ScaleToDefault_Internal()
IL_0000: ldarg.0
IL_0001: ldfld System.Collections.Generic.List`1<TheForestOfLove.UI.WindowController/WindowSizeSettings> TheForestOfLove.UI.WindowController::windowSizeSettings
IL_0006: callvirt System.Int32 System.Collections.Generic.List`1<TheForestOfLove.UI.WindowController/WindowSizeSettings>::get_Count()
IL_000b: ldc.i4.1
IL_000c: sub
IL_000d: stloc.0
IL_000e: br.s IL_0035
IL_0010: ldarg.0
IL_0011: ldfld System.Collections.Generic.List`1<TheForestOfLove.UI.WindowController/WindowSizeSettings> TheForestOfLove.UI.WindowController::windowSizeSettings
IL_0016: ldloc.0
IL_0017: callvirt !0 System.Collections.Generic.List`1<TheForestOfLove.UI.WindowController/WindowSizeSettings>::get_Item(System.Int32)
IL_001c: ldfld System.Boolean TheForestOfLove.UI.WindowController/WindowSizeSettings::eligible
IL_0021: brfalse.s IL_0031
IL_0023: ldarg.0
IL_0024: ldloc.0
IL_0025: stfld System.Int32 TheForestOfLove.UI.WindowController::currentSizeSettingsIndex
IL_002a: ldarg.0
IL_002b: call System.Void TheForestOfLove.UI.WindowController::UpdateWindowSize()
IL_0030: ret
IL_0031: ldloc.0
IL_0032: ldc.i4.1
IL_0033: sub
IL_0034: stloc.0
IL_0035: ldloc.0
IL_0036: ldc.i4.0
IL_0037: bgt.s IL_0010
IL_0039: ret
METHOD System.Void TheForestOfLove.UI.WindowController::.ctor()
IL_0000: ldarg.0
IL_0001: newobj System.Void System.Collections.Generic.List`1<TheForestOfLove.UI.WindowController/WindowSizeSettings>::.ctor()
IL_0006: dup
IL_0007: newobj System.Void TheForestOfLove.UI.WindowController/WindowSizeSettings::.ctor()
IL_000c: dup
IL_000d: ldc.r4 1
IL_0012: stfld System.Single TheForestOfLove.UI.WindowController/WindowSizeSettings::scaleFactor
IL_0017: dup
IL_0018: ldc.i4 480
IL_001d: stfld System.Int32 TheForestOfLove.UI.WindowController/WindowSizeSettings::targetWidth
IL_0022: dup
IL_0023: ldc.i4 270
IL_0028: stfld System.Int32 TheForestOfLove.UI.WindowController/WindowSizeSettings::targetHeight
IL_002d: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.UI.WindowController/WindowSizeSettings>::Add(!0)
IL_0032: dup
IL_0033: newobj System.Void TheForestOfLove.UI.WindowController/WindowSizeSettings::.ctor()
IL_0038: dup
IL_0039: ldc.r4 2
IL_003e: stfld System.Single TheForestOfLove.UI.WindowController/WindowSizeSettings::scaleFactor
IL_0043: dup
IL_0044: ldc.i4 960
IL_0049: stfld System.Int32 TheForestOfLove.UI.WindowController/WindowSizeSettings::targetWidth
IL_004e: dup
IL_004f: ldc.i4 540
IL_0054: stfld System.Int32 TheForestOfLove.UI.WindowController/WindowSizeSettings::targetHeight
IL_0059: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.UI.WindowController/WindowSizeSettings>::Add(!0)
IL_005e: dup
IL_005f: newobj System.Void TheForestOfLove.UI.WindowController/WindowSizeSettings::.ctor()
IL_0064: dup
IL_0065: ldc.r4 3
IL_006a: stfld System.Single TheForestOfLove.UI.WindowController/WindowSizeSettings::scaleFactor
IL_006f: dup
IL_0070: ldc.i4 1440
IL_0075: stfld System.Int32 TheForestOfLove.UI.WindowController/WindowSizeSettings::targetWidth
IL_007a: dup
IL_007b: ldc.i4 810
IL_0080: stfld System.Int32 TheForestOfLove.UI.WindowController/WindowSizeSettings::targetHeight
IL_0085: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.UI.WindowController/WindowSizeSettings>::Add(!0)
IL_008a: dup
IL_008b: newobj System.Void TheForestOfLove.UI.WindowController/WindowSizeSettings::.ctor()
IL_0090: dup
IL_0091: ldc.r4 4
IL_0096: stfld System.Single TheForestOfLove.UI.WindowController/WindowSizeSettings::scaleFactor
IL_009b: dup
IL_009c: ldc.i4 1920
IL_00a1: stfld System.Int32 TheForestOfLove.UI.WindowController/WindowSizeSettings::targetWidth
IL_00a6: dup
IL_00a7: ldc.i4 1080
IL_00ac: stfld System.Int32 TheForestOfLove.UI.WindowController/WindowSizeSettings::targetHeight
IL_00b1: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.UI.WindowController/WindowSizeSettings>::Add(!0)
IL_00b6: dup
IL_00b7: newobj System.Void TheForestOfLove.UI.WindowController/WindowSizeSettings::.ctor()
IL_00bc: dup
IL_00bd: ldc.r4 5
IL_00c2: stfld System.Single TheForestOfLove.UI.WindowController/WindowSizeSettings::scaleFactor
IL_00c7: dup
IL_00c8: ldc.i4 2400
IL_00cd: stfld System.Int32 TheForestOfLove.UI.WindowController/WindowSizeSettings::targetWidth
IL_00d2: dup
IL_00d3: ldc.i4 1350
IL_00d8: stfld System.Int32 TheForestOfLove.UI.WindowController/WindowSizeSettings::targetHeight
IL_00dd: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.UI.WindowController/WindowSizeSettings>::Add(!0)
IL_00e2: dup
IL_00e3: newobj System.Void TheForestOfLove.UI.WindowController/WindowSizeSettings::.ctor()
IL_00e8: dup
IL_00e9: ldc.r4 6
IL_00ee: stfld System.Single TheForestOfLove.UI.WindowController/WindowSizeSettings::scaleFactor
IL_00f3: dup
IL_00f4: ldc.i4 2880
IL_00f9: stfld System.Int32 TheForestOfLove.UI.WindowController/WindowSizeSettings::targetWidth
IL_00fe: dup
IL_00ff: ldc.i4 1620
IL_0104: stfld System.Int32 TheForestOfLove.UI.WindowController/WindowSizeSettings::targetHeight
IL_0109: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.UI.WindowController/WindowSizeSettings>::Add(!0)
IL_010e: dup
IL_010f: newobj System.Void TheForestOfLove.UI.WindowController/WindowSizeSettings::.ctor()
IL_0114: dup
IL_0115: ldc.r4 7
IL_011a: stfld System.Single TheForestOfLove.UI.WindowController/WindowSizeSettings::scaleFactor
IL_011f: dup
IL_0120: ldc.i4 3360
IL_0125: stfld System.Int32 TheForestOfLove.UI.WindowController/WindowSizeSettings::targetWidth
IL_012a: dup
IL_012b: ldc.i4 1890
IL_0130: stfld System.Int32 TheForestOfLove.UI.WindowController/WindowSizeSettings::targetHeight
IL_0135: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.UI.WindowController/WindowSizeSettings>::Add(!0)
IL_013a: dup
IL_013b: newobj System.Void TheForestOfLove.UI.WindowController/WindowSizeSettings::.ctor()
IL_0140: dup
IL_0141: ldc.r4 8
IL_0146: stfld System.Single TheForestOfLove.UI.WindowController/WindowSizeSettings::scaleFactor
IL_014b: dup
IL_014c: ldc.i4 3840
IL_0151: stfld System.Int32 TheForestOfLove.UI.WindowController/WindowSizeSettings::targetWidth
IL_0156: dup
IL_0157: ldc.i4 2160
IL_015c: stfld System.Int32 TheForestOfLove.UI.WindowController/WindowSizeSettings::targetHeight
IL_0161: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.UI.WindowController/WindowSizeSettings>::Add(!0)
IL_0166: stfld System.Collections.Generic.List`1<TheForestOfLove.UI.WindowController/WindowSizeSettings> TheForestOfLove.UI.WindowController::windowSizeSettings
IL_016b: ldarg.0
IL_016c: call System.Void UnityEngine.MonoBehaviour::.ctor()
IL_0171: ret
