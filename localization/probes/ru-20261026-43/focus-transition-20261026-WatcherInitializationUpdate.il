TYPE Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT
METHOD System.Void Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT::.ctor() | attributes=Public, HideBySig, SpecialName, RTSpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void System.Object::.ctor()
IL_0006: ldc.i4 -1774815015
IL_000b: ldc.i4 -1774815014
IL_0010: xor
IL_0011: switch IL_0006,IL_01d9,IL_0137,IL_002f,IL_018a
IL_002a: br IL_01d9
IL_002f: newobj System.Void System.Collections.Generic.List`1<Rewired.Utils.Classes.Utility.ValueWatcher>::.ctor()
IL_0034: stloc.1
IL_0035: ldloc.1
IL_0036: ldarg.0
IL_0037: ldc.i4.1
IL_0038: ldc.i4.0
IL_0039: newobj System.Void Rewired.Utils.Classes.Utility.ValueWatcher`1<System.Boolean>::.ctor(T,System.Boolean)
IL_003e: dup
IL_003f: stloc.2
IL_0040: stfld Rewired.Utils.Classes.Utility.ValueWatcher`1<System.Boolean> Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT::QBAmVSgbZBPmppTHWYNgMiDCmXg
IL_0045: ldloc.2
IL_0046: callvirt System.Void System.Collections.Generic.List`1<Rewired.Utils.Classes.Utility.ValueWatcher>::Add(!0)
IL_004b: ldloc.1
IL_004c: ldarg.0
IL_004d: call System.Boolean UnityEngine.Screen::get_fullScreen()
IL_0052: ldsfld System.Func`1<System.Boolean> Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT::RYhKtvyBnbYwVqtdkWRUjdqhVFP
IL_0057: brtrue.s IL_006a
IL_0059: ldnull
IL_005a: ldftn System.Boolean Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT::mqtbQAlHGVgbHPAcYHiGGjHVpMl()
IL_0060: newobj System.Void System.Func`1<System.Boolean>::.ctor(System.Object,System.IntPtr)
IL_0065: stsfld System.Func`1<System.Boolean> Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT::RYhKtvyBnbYwVqtdkWRUjdqhVFP
IL_006a: ldsfld System.Func`1<System.Boolean> Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT::RYhKtvyBnbYwVqtdkWRUjdqhVFP
IL_006f: ldc.i4.0
IL_0070: newobj System.Void Rewired.Utils.Classes.Utility.ValueWatcher`1<System.Boolean>::.ctor(T,System.Func`1<T>,System.Boolean)
IL_0075: dup
IL_0076: stloc.3
IL_0077: stfld Rewired.Utils.Classes.Utility.ValueWatcher`1<System.Boolean> Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT::QkenjZZMPJJaNftxIrJnlwjEQPK
IL_007c: ldloc.3
IL_007d: callvirt System.Void System.Collections.Generic.List`1<Rewired.Utils.Classes.Utility.ValueWatcher>::Add(!0)
IL_0082: ldloc.1
IL_0083: ldarg.0
IL_0084: call System.Boolean UnityEngine.Application::get_runInBackground()
IL_0089: ldsfld System.Func`1<System.Boolean> Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT::EKJwBXoThEWpbsormcLTDoSDAqmF
IL_008e: brtrue.s IL_00a1
IL_0090: ldnull
IL_0091: ldftn System.Boolean Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT::kokFAeEvpzjEkqzOXVfsybUZexs()
IL_0097: newobj System.Void System.Func`1<System.Boolean>::.ctor(System.Object,System.IntPtr)
IL_009c: stsfld System.Func`1<System.Boolean> Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT::EKJwBXoThEWpbsormcLTDoSDAqmF
IL_00a1: ldsfld System.Func`1<System.Boolean> Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT::EKJwBXoThEWpbsormcLTDoSDAqmF
IL_00a6: ldc.i4.0
IL_00a7: newobj System.Void Rewired.Utils.Classes.Utility.ValueWatcher`1<System.Boolean>::.ctor(T,System.Func`1<T>,System.Boolean)
IL_00ac: dup
IL_00ad: stloc.s V_4
IL_00af: stfld Rewired.Utils.Classes.Utility.ValueWatcher`1<System.Boolean> Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT::xIMFCrwXunWxoekBlleMmJYPdj
IL_00b4: ldloc.s V_4
IL_00b6: callvirt System.Void System.Collections.Generic.List`1<Rewired.Utils.Classes.Utility.ValueWatcher>::Add(!0)
IL_00bb: ldloc.1
IL_00bc: ldarg.0
IL_00bd: call UnityEngine.FullScreenMode UnityEngine.Screen::get_fullScreenMode()
IL_00c2: ldsfld System.Func`1<System.Int32> Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT::sROWGMoZLJsnPzODwiJjSbSnzzN
IL_00c7: brtrue.s IL_00da
IL_00c9: ldnull
IL_00ca: ldftn System.Int32 Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT::hgLEuTjmVrGCLJIcVLpJoiLupIr()
IL_00d0: newobj System.Void System.Func`1<System.Int32>::.ctor(System.Object,System.IntPtr)
IL_00d5: stsfld System.Func`1<System.Int32> Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT::sROWGMoZLJsnPzODwiJjSbSnzzN
IL_00da: ldsfld System.Func`1<System.Int32> Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT::sROWGMoZLJsnPzODwiJjSbSnzzN
IL_00df: ldc.i4.0
IL_00e0: newobj System.Void Rewired.Utils.Classes.Utility.ValueWatcher`1<System.Int32>::.ctor(T,System.Func`1<T>,System.Boolean)
IL_00e5: dup
IL_00e6: stloc.s V_5
IL_00e8: stfld Rewired.Utils.Classes.Utility.ValueWatcher`1<System.Int32> Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT::lduifWWpoEYmbMjTJGxfiCrUaVbH
IL_00ed: ldloc.s V_5
IL_00ef: callvirt System.Void System.Collections.Generic.List`1<Rewired.Utils.Classes.Utility.ValueWatcher>::Add(!0)
IL_00f4: ldloc.1
IL_00f5: ldarg.0
IL_00f6: call System.Single UnityEngine.Time::get_unscaledDeltaTime()
IL_00fb: ldsfld System.Func`1<System.Single> Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT::huVIcABprVhwEKHKXYwVzdBUBaQ
IL_0100: brtrue.s IL_0113
IL_0102: ldnull
IL_0103: ldftn System.Single Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT::oAOEPIoALJaVjbqcHtZgTOxqxaab()
IL_0109: newobj System.Void System.Func`1<System.Single>::.ctor(System.Object,System.IntPtr)
IL_010e: stsfld System.Func`1<System.Single> Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT::huVIcABprVhwEKHKXYwVzdBUBaQ
IL_0113: ldsfld System.Func`1<System.Single> Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT::huVIcABprVhwEKHKXYwVzdBUBaQ
IL_0118: ldc.i4.0
IL_0119: newobj System.Void Rewired.Utils.Classes.Utility.ValueWatcher`1<System.Single>::.ctor(T,System.Func`1<T>,System.Boolean)
IL_011e: dup
IL_011f: stloc.s V_6
IL_0121: stfld Rewired.Utils.Classes.Utility.ValueWatcher`1<System.Single> Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT::yxIqFBiEJjHnMNaIKxInNWSBujA
IL_0126: ldloc.s V_6
IL_0128: callvirt System.Void System.Collections.Generic.List`1<Rewired.Utils.Classes.Utility.ValueWatcher>::Add(!0)
IL_012d: ldc.i4 -1774815016
IL_0132: br IL_000b
IL_0137: ldloc.1
IL_0138: ldarg.0
IL_0139: call System.Single UnityEngine.Time::get_timeScale()
IL_013e: call System.Boolean Rewired.Utils.MathTools::ApproximatelyZero(System.Single)
IL_0143: ldsfld System.Func`1<System.Boolean> Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT::IOMllVkCztGxgOhosVjDlpFlsPH
IL_0148: brtrue.s IL_015b
IL_014a: ldnull
IL_014b: ldftn System.Boolean Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT::OZhhHmRVLasGHppjEASiFgQqYXeS()
IL_0151: newobj System.Void System.Func`1<System.Boolean>::.ctor(System.Object,System.IntPtr)
IL_0156: stsfld System.Func`1<System.Boolean> Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT::IOMllVkCztGxgOhosVjDlpFlsPH
IL_015b: ldsfld System.Func`1<System.Boolean> Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT::IOMllVkCztGxgOhosVjDlpFlsPH
IL_0160: call System.Single UnityEngine.Time::get_timeScale()
IL_0165: call System.Boolean Rewired.Utils.MathTools::ApproximatelyZero(System.Single)
IL_016a: newobj System.Void Rewired.Utils.Classes.Utility.ValueWatcher`1<System.Boolean>::.ctor(T,System.Func`1<T>,System.Boolean)
IL_016f: dup
IL_0170: stloc.s V_7
IL_0172: stfld Rewired.Utils.Classes.Utility.ValueWatcher`1<System.Boolean> Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT::oDAHXPduaFEkAbKbGTChrxaQccTL
IL_0177: ldloc.s V_7
IL_0179: callvirt System.Void System.Collections.Generic.List`1<Rewired.Utils.Classes.Utility.ValueWatcher>::Add(!0)
IL_017e: ldloc.1
IL_017f: stloc.0
IL_0180: ldc.i4 -1774815010
IL_0185: br IL_000b
IL_018a: call Rewired.Platforms.EditorPlatform Rewired.ReInput::get_editorPlatform()
IL_018f: brfalse.s IL_01d9
IL_0191: ldloc.0
IL_0192: ldarg.0
IL_0193: call Rewired.Utils.Interfaces.IExternalTools Rewired.Utils.UnityTools::get_externalTools()
IL_0198: callvirt System.String Rewired.Utils.Interfaces.IExternalTools::GetFocusedEditorWindowTitle()
IL_019d: ldsfld System.Func`1<System.String> Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT::AEQDiSvRbjOTzdXLzdlWupxQSTh
IL_01a2: brtrue.s IL_01b5
IL_01a4: ldnull
IL_01a5: ldftn System.String Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT::MEpyafbrloCKhJvrGqkJjXbQCye()
IL_01ab: newobj System.Void System.Func`1<System.String>::.ctor(System.Object,System.IntPtr)
IL_01b0: stsfld System.Func`1<System.String> Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT::AEQDiSvRbjOTzdXLzdlWupxQSTh
IL_01b5: ldsfld System.Func`1<System.String> Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT::AEQDiSvRbjOTzdXLzdlWupxQSTh
IL_01ba: ldc.i4.0
IL_01bb: newobj System.Void Rewired.Utils.Classes.Utility.ValueWatcher`1<System.String>::.ctor(T,System.Func`1<T>,System.Boolean)
IL_01c0: dup
IL_01c1: stloc.s V_8
IL_01c3: stfld Rewired.Utils.Classes.Utility.ValueWatcher`1<System.String> Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT::MuuXaMIShRtUzBodRSnPbFwFHga
IL_01c8: ldloc.s V_8
IL_01ca: callvirt System.Void System.Collections.Generic.List`1<Rewired.Utils.Classes.Utility.ValueWatcher>::Add(!0)
IL_01cf: ldc.i4 -1774815013
IL_01d4: br IL_000b
IL_01d9: ldarg.0
IL_01da: ldloc.0
IL_01db: callvirt !0[] System.Collections.Generic.List`1<Rewired.Utils.Classes.Utility.ValueWatcher>::ToArray()
IL_01e0: stfld Rewired.Utils.Classes.Utility.ValueWatcher[] Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT::IHSQAfqlkLwfDRsVtRovlScYnqZ
IL_01e5: ldarg.0
IL_01e6: call System.Void Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT::jSmUMfkZCZCZfiMnleEGJnwKIqT()
IL_01eb: ret
METHOD System.Void Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT::jSmUMfkZCZCZfiMnleEGJnwKIqT() | attributes=Public, HideBySig | impl=IL
IL_0000: ldc.i4.0
IL_0001: stloc.0
IL_0002: br.s IL_003f
IL_0004: ldc.i4 975712357
IL_0009: ldc.i4 975712358
IL_000e: xor
IL_000f: switch IL_0004,IL_005b,IL_003f,IL_0026
IL_0024: br.s IL_005b
IL_0026: ldarg.0
IL_0027: ldfld Rewired.Utils.Classes.Utility.ValueWatcher[] Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT::IHSQAfqlkLwfDRsVtRovlScYnqZ
IL_002c: ldloc.0
IL_002d: ldelem.ref
IL_002e: callvirt System.Boolean Rewired.Utils.Classes.Utility.ValueWatcher::Update()
IL_0033: pop
IL_0034: ldloc.0
IL_0035: ldc.i4.1
IL_0036: add
IL_0037: stloc.0
IL_0038: ldc.i4 975712356
IL_003d: br.s IL_0009
IL_003f: ldloc.0
IL_0040: ldarg.0
IL_0041: ldfld Rewired.Utils.Classes.Utility.ValueWatcher[] Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT::IHSQAfqlkLwfDRsVtRovlScYnqZ
IL_0046: ldlen
IL_0047: conv.i4
IL_0048: blt.s IL_0052
IL_004a: ldc.i4 975712359
IL_004f: dup
IL_0050: br.s IL_0058
IL_0052: ldc.i4 975712357
IL_0057: dup
IL_0058: pop
IL_0059: br.s IL_0009
IL_005b: ldarg.0
IL_005c: call System.Int32 UnityEngine.Time::get_frameCount()
IL_0061: stfld System.Int32 Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT::BLqkOmpXFQrhUcUqcpMeIITXpcr
IL_0066: ret
METHOD System.Void Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT::wweiCHaRbiDSHRzxofNoPRkDurZ() | attributes=Public, HideBySig | impl=IL
IL_0000: ldc.i4.0
IL_0001: stloc.0
IL_0002: br.s IL_0046
IL_0004: ldc.i4 -1551016049
IL_0009: ldc.i4 -1551016051
IL_000e: xor
IL_000f: switch IL_0046,IL_003b,IL_0026,IL_0004
IL_0024: br.s IL_0046
IL_0026: ldarg.0
IL_0027: ldfld Rewired.Utils.Classes.Utility.ValueWatcher[] Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT::IHSQAfqlkLwfDRsVtRovlScYnqZ
IL_002c: ldloc.0
IL_002d: ldelem.ref
IL_002e: callvirt System.Boolean Rewired.Utils.Classes.Utility.ValueWatcher::TriggerEvent()
IL_0033: pop
IL_0034: ldc.i4 -1551016052
IL_0039: br.s IL_0009
IL_003b: ldloc.0
IL_003c: ldc.i4.1
IL_003d: add
IL_003e: stloc.0
IL_003f: ldc.i4 -1551016051
IL_0044: br.s IL_0009
IL_0046: ldloc.0
IL_0047: ldarg.0
IL_0048: ldfld Rewired.Utils.Classes.Utility.ValueWatcher[] Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT::IHSQAfqlkLwfDRsVtRovlScYnqZ
IL_004d: ldlen
IL_004e: conv.i4
IL_004f: blt.s IL_0026
IL_0051: ret
METHOD System.Boolean Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT::kokFAeEvpzjEkqzOXVfsybUZexs() | attributes=Private, Static, HideBySig | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: call System.Boolean UnityEngine.Application::get_runInBackground()
IL_0005: ret
