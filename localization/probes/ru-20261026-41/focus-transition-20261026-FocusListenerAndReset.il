TYPE Rewired.ReInput
METHOD System.Void Rewired.ReInput::OCqSJvbpclWclSkjYkLsBbHdJUx() | attributes=Private, Static, HideBySig | impl=IL
IL_0000: ldsfld Rewired.InputManager_Base Rewired.ReInput::XetmRAGybyGoHEAxhcHUKeAQrjaF
IL_0005: ldnull
IL_0006: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_000b: brfalse IL_027f
IL_0010: ldc.i4 575646144
IL_0015: ldc.i4 575646149
IL_001a: xor
IL_001b: switch IL_0249,IL_01ff,IL_01ad,IL_008e,IL_027f,IL_02c4,IL_026f,IL_013e,IL_02db,IL_0081,IL_0259,IL_0106,IL_0190,IL_0229,IL_00cc,IL_02af,IL_01d7,IL_0116,IL_028f,IL_00bc,IL_0010,IL_0170,IL_0219
IL_007c: br IL_02db
IL_0081: ldc.i4.0
IL_0082: stsfld Rewired.Platforms.EditorPlatform Rewired.ReInput::oPUAJMywrLEmBbqmOIkACwccdcP
IL_0087: ldc.i4 575646155
IL_008c: br.s IL_0015
IL_008e: ldnull
IL_008f: stsfld Rewired.Data.UserData Rewired.ReInput::wWsgFeuqSUsgwwBPjdjpjPGupZZ
IL_0094: ldnull
IL_0095: stsfld Rewired.Interfaces.IControllerAssigner Rewired.ReInput::EygjZGXvKnQQadVtLiiHOaCOYPE
IL_009a: ldc.i4.0
IL_009b: stsfld System.Boolean Rewired.ReInput::aLzbAjHdyinuPAkYilYZkIGyBOc
IL_00a0: ldnull
IL_00a1: stsfld Rewired.Data.ConfigVars Rewired.ReInput::OJxXokxjIIFupQczlCnOgNGVMwNT
IL_00a6: ldc.i4.0
IL_00a7: stsfld Rewired.UpdateLoopType Rewired.ReInput::JKYrFfHGvLiOGdRtMclqgSPBkyR
IL_00ac: ldc.i4.0
IL_00ad: stsfld System.Boolean Rewired.ReInput::qJyeNPhAvKIykYBEREMfiKFZqNP
IL_00b2: ldc.i4 575646163
IL_00b7: br IL_0015
IL_00bc: ldnull
IL_00bd: stsfld System.Action`1<System.Boolean> Rewired.ReInput::NRtErjbMSszqqfolgfvaPPNVvjA
IL_00c2: ldc.i4 575646154
IL_00c7: br IL_0015
IL_00cc: ldc.i4.0
IL_00cd: stsfld System.Boolean Rewired.ReInput::oLsXvjfMAfPpnNGCyUWjLoDyWRS
IL_00d2: ldnull
IL_00d3: stsfld Rewired.Utils.Classes.Utility.TimerAbs Rewired.ReInput::JOBvZCwcejLmepHDIGBbiGtkzuC
IL_00d8: ldnull
IL_00d9: stsfld Rewired.ReInput/boJgboDXhtOpkFRaIkAocTQCligw Rewired.ReInput::WCBgQMGSpRhxzDiVYlIVPBjukCy
IL_00de: ldnull
IL_00df: stsfld System.String Rewired.ReInput::urYvVAJPxxgPDQTOjkiVXIhUHSbg
IL_00e4: ldc.i4.0
IL_00e5: stsfld System.Boolean Rewired.ReInput::NPfefDCOwXSjdltUbdIpmiYqZmUC
IL_00ea: ldc.i4.0
IL_00eb: stsfld System.Boolean Rewired.ReInput::URciBBfYPOJNzFhzOemZncBVJYB
IL_00f0: ldc.i4.1
IL_00f1: stsfld System.Boolean Rewired.ReInput::cbmmwJPDGUhXqzzdtJQPbNHADIB
IL_00f6: ldc.i4.m1
IL_00f7: stsfld System.Int32 Rewired.ReInput::IULVvTEZtEGfACvHIlbEfPpuRll
IL_00fc: ldc.i4 575646160
IL_0101: br IL_0015
IL_0106: ldc.i4.0
IL_0107: stsfld Rewired.Platforms.WebplayerPlatform Rewired.ReInput::IGPMXAYNVLCwoLQnyhpjGNBMIbR
IL_010c: ldc.i4 575646156
IL_0111: br IL_0015
IL_0116: ldnull
IL_0117: stsfld System.Action`1<Rewired.UpdateLoopType> Rewired.ReInput::VtKklTTGUHrZmJxRdvIOFWQEuxz
IL_011c: ldnull
IL_011d: stsfld System.Action`1<Rewired.UpdateLoopType> Rewired.ReInput::BnIRqUGHnrBPbnhMTkaoTXQKEAP
IL_0122: ldnull
IL_0123: stsfld System.Action Rewired.ReInput::lycUhvtUnuUkdUEfCWBcwhKTcmb
IL_0128: ldnull
IL_0129: stsfld Rewired.Utils.SafeAction Rewired.ReInput::ZEXwQPtNcWgzPLnikmVqKLbKUBm
IL_012e: ldnull
IL_012f: stsfld System.Action Rewired.ReInput::ikHxmghZXdNsIJvkwwyccBXRpPd
IL_0134: ldc.i4 575646166
IL_0139: br IL_0015
IL_013e: ldsfld Rewired.Utils.SafeAction`1<Rewired.ControllerStatusChangedEventArgs> Rewired.ReInput::NSYdMiVHXsNQtJggYdsYAPBrcFR
IL_0143: callvirt System.Void Rewired.Utils.SafeDelegate::Clear()
IL_0148: ldsfld Rewired.Utils.SafeAction`1<Rewired.ControllerStatusChangedEventArgs> Rewired.ReInput::HcHfBSwchsarKVWgLOZzZnKKbxT
IL_014d: callvirt System.Void Rewired.Utils.SafeDelegate::Clear()
IL_0152: ldsfld Rewired.Utils.SafeAction Rewired.ReInput::HAWepiJVuqsaIpfDnupuwRuyPcFD
IL_0157: callvirt System.Void Rewired.Utils.SafeDelegate::Clear()
IL_015c: ldsfld Rewired.Utils.SafeAction Rewired.ReInput::VOGFthigxNlNBnSCxjUbeJeiQCB
IL_0161: callvirt System.Void Rewired.Utils.SafeDelegate::Clear()
IL_0166: ldc.i4 575646149
IL_016b: br IL_0015
IL_0170: ldc.i4.m1
IL_0171: stsfld System.Int32 Rewired.ReInput::_id
IL_0176: ldc.i4.0
IL_0177: stsfld System.Int32 Rewired.ReInput::OFTJeyVHtVdCEdWDNDgOcYLhKjFS
IL_017c: ldsfld Rewired.Utils.SafeAction`1<Rewired.ControllerStatusChangedEventArgs> Rewired.ReInput::qVIupAHADLzyPlQDDIMXlzuYyxz
IL_0181: callvirt System.Void Rewired.Utils.SafeDelegate::Clear()
IL_0186: ldc.i4 575646146
IL_018b: br IL_0015
IL_0190: ldloc.1
IL_0191: ldloc.0
IL_0192: callvirt System.Int32 System.Collections.Generic.List`1<Rewired.Utils.Interfaces.IExternalInputManager>::get_Count()
IL_0197: blt.s IL_01a1
IL_0199: ldc.i4 575646145
IL_019e: dup
IL_019f: br.s IL_01a7
IL_01a1: ldc.i4 575646148
IL_01a6: dup
IL_01a7: pop
IL_01a8: br IL_0015
IL_01ad: ldnull
IL_01ae: stsfld Rewired.PlatformInputManager Rewired.ReInput::EipmgiMCREFLYqaOyKWtcpJhWRc
IL_01b3: ldnull
IL_01b4: stsfld tmYKYJtivFZNMMdFSwUqjsavhHY Rewired.ReInput::UmkZRVIxxOokFtVtbGnILukIJar
IL_01b9: ldsfld zMtJShWdNqreuDVsbowqVZNzwts Rewired.ReInput::BoiYVdWmWlQykdYqdqdvncsPfPC
IL_01be: brfalse IL_0259
IL_01c3: ldsfld zMtJShWdNqreuDVsbowqVZNzwts Rewired.ReInput::BoiYVdWmWlQykdYqdqdvncsPfPC
IL_01c8: callvirt System.Void zMtJShWdNqreuDVsbowqVZNzwts::Dispose()
IL_01cd: ldc.i4 575646159
IL_01d2: br IL_0015
IL_01d7: ldnull
IL_01d8: stsfld System.Action`1<System.Boolean> Rewired.ReInput::eLheOuFKGZiNoQaeoIBRwiEtCOpz
IL_01dd: ldnull
IL_01de: stsfld System.Action`1<System.Boolean> Rewired.ReInput::BJREyForPSaUMKoPJevvMffZvTi
IL_01e3: ldnull
IL_01e4: stsfld System.Action`1<UnityEngine.FullScreenMode> Rewired.ReInput::KvBtZsdOwITuELMXRZUohBVogoA
IL_01e9: ldnull
IL_01ea: stsfld System.Action`1<System.Boolean> Rewired.ReInput::MENhzmbGCcnQFRgdbdFEnaXXmEqT
IL_01ef: ldnull
IL_01f0: stsfld System.Action Rewired.ReInput::CBNgnuladoahIaBrvcmDTvQgpMV
IL_01f5: ldc.i4 575646164
IL_01fa: br IL_0015
IL_01ff: ldloc.0
IL_0200: ldloc.1
IL_0201: callvirt !0 System.Collections.Generic.List`1<Rewired.Utils.Interfaces.IExternalInputManager>::get_Item(System.Int32)
IL_0206: callvirt System.Void Rewired.Utils.Interfaces.IExternalInputManager::Deinitialize()
IL_020b: ldloc.1
IL_020c: ldc.i4.1
IL_020d: add
IL_020e: stloc.1
IL_020f: ldc.i4 575646153
IL_0214: br IL_0015
IL_0219: ldc.i4.1
IL_021a: stsfld Rewired.Platforms.Platform Rewired.ReInput::eWhZzsSgwWjRIKLlVSaybvDfHuf
IL_021f: ldc.i4 575646158
IL_0224: br IL_0015
IL_0229: call Rewired.Utils.Interfaces.IExternalTools Rewired.Utils.UnityTools::get_externalTools()
IL_022e: ldnull
IL_022f: ldftn System.Void Rewired.ReInput::esyGTdijJGjaJEUlApXivBSuPVG(System.Boolean)
IL_0235: newobj System.Void System.Action`1<System.Boolean>::.ctor(System.Object,System.IntPtr)
IL_023a: callvirt System.Void Rewired.Utils.Interfaces.IExternalTools::remove_EditorPausedStateChangedEvent(System.Action`1<System.Boolean>)
IL_023f: ldc.i4 575646157
IL_0244: br IL_0015
IL_0249: ldnull
IL_024a: stsfld System.Action`1<System.Boolean> Rewired.ReInput::_ApplicationFocusChangedEvent
IL_024f: ldc.i4 575646165
IL_0254: br IL_0015
IL_0259: ldnull
IL_025a: stsfld zMtJShWdNqreuDVsbowqVZNzwts Rewired.ReInput::BoiYVdWmWlQykdYqdqdvncsPfPC
IL_025f: ldnull
IL_0260: stsfld TkcjGAMrGlZBptIAfinKwqiqWse Rewired.ReInput::rMKNQgWzfWednDCMGpAIuspSVKN
IL_0265: ldc.i4 575646147
IL_026a: br IL_0015
IL_026f: ldnull
IL_0270: stsfld Rewired.Data.ControllerDataFiles Rewired.ReInput::zRlWjsiurHfMmGqfsMcLRjaJiumc
IL_0275: ldc.i4 575646150
IL_027a: br IL_0015
IL_027f: ldnull
IL_0280: stsfld Rewired.InputManager_Base Rewired.ReInput::XetmRAGybyGoHEAxhcHUKeAQrjaF
IL_0285: ldc.i4 575646151
IL_028a: br IL_0015
IL_028f: call System.Void Rewired.ThreadSafeUnityInput::Deinitialize()
IL_0294: call Rewired.Utils.Interfaces.IExternalTools Rewired.Utils.UnityTools::get_externalTools()
IL_0299: brtrue.s IL_02a3
IL_029b: ldc.i4 575646157
IL_02a0: dup
IL_02a1: br.s IL_02a9
IL_02a3: ldc.i4 575646152
IL_02a8: dup
IL_02a9: pop
IL_02aa: br IL_0015
IL_02af: call System.Void Rewired.ReInput::MkbhfLFUcsGsRzkXpoCFDbyKRux()
IL_02b4: ldnull
IL_02b5: stsfld Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT Rewired.ReInput::GGbNxxBRsPVtXooKvddzWaNspLr
IL_02ba: ldc.i4 575646167
IL_02bf: br IL_0015
IL_02c4: ldsfld Rewired.InputManager_Base Rewired.ReInput::XetmRAGybyGoHEAxhcHUKeAQrjaF
IL_02c9: call System.Collections.Generic.List`1<T> Rewired.Utils.UnityTools::GetComponentsInSelfAndChildren<Rewired.Utils.Interfaces.IExternalInputManager>(UnityEngine.Component)
IL_02ce: stloc.0
IL_02cf: ldc.i4.0
IL_02d0: stloc.1
IL_02d1: ldc.i4 575646153
IL_02d6: br IL_0015
IL_02db: ret
METHOD System.Void Rewired.ReInput::NavijpmlHmAjhDisfzPPUTADGLlI() | attributes=Private, Static, HideBySig | impl=IL
IL_0000: ldsfld Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT Rewired.ReInput::GGbNxxBRsPVtXooKvddzWaNspLr
IL_0005: brtrue.s IL_0035
IL_0007: ret
IL_0008: ldc.i4 -436809215
IL_000d: ldc.i4 -436809216
IL_0012: xor
IL_0013: switch IL_0008,IL_0035,IL_0085,IL_00e0,IL_0041,IL_0063
IL_0030: br IL_00e0
IL_0035: call System.Void Rewired.ReInput::MkbhfLFUcsGsRzkXpoCFDbyKRux()
IL_003a: ldc.i4 -436809211
IL_003f: br.s IL_000d
IL_0041: ldsfld Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT Rewired.ReInput::GGbNxxBRsPVtXooKvddzWaNspLr
IL_0046: ldfld Rewired.Utils.Classes.Utility.ValueWatcher`1<System.Boolean> Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT::oDAHXPduaFEkAbKbGTChrxaQccTL
IL_004b: ldnull
IL_004c: ldftn System.Void Rewired.ReInput::ItlbQczDKGVecohZzRGNikVWczr(System.Boolean)
IL_0052: newobj System.Void System.Action`1<System.Boolean>::.ctor(System.Object,System.IntPtr)
IL_0057: callvirt System.Void Rewired.Utils.Classes.Utility.ValueWatcher`1<System.Boolean>::add_ChangedEvent(System.Action`1<T>)
IL_005c: ldc.i4 -436809213
IL_0061: br.s IL_000d
IL_0063: ldsfld Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT Rewired.ReInput::GGbNxxBRsPVtXooKvddzWaNspLr
IL_0068: ldfld Rewired.Utils.Classes.Utility.ValueWatcher`1<System.Boolean> Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT::QBAmVSgbZBPmppTHWYNgMiDCmXg
IL_006d: ldnull
IL_006e: ldftn System.Void Rewired.ReInput::rRujWYRgwEnOOYvDVNSFbReupcp(System.Boolean)
IL_0074: newobj System.Void System.Action`1<System.Boolean>::.ctor(System.Object,System.IntPtr)
IL_0079: callvirt System.Void Rewired.Utils.Classes.Utility.ValueWatcher`1<System.Boolean>::add_ChangedEvent(System.Action`1<T>)
IL_007e: ldc.i4 -436809214
IL_0083: br.s IL_000d
IL_0085: ldsfld Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT Rewired.ReInput::GGbNxxBRsPVtXooKvddzWaNspLr
IL_008a: ldfld Rewired.Utils.Classes.Utility.ValueWatcher`1<System.Boolean> Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT::QkenjZZMPJJaNftxIrJnlwjEQPK
IL_008f: ldnull
IL_0090: ldftn System.Void Rewired.ReInput::onhJtZBTAqastjBkTAkMSmXLkbp(System.Boolean)
IL_0096: newobj System.Void System.Action`1<System.Boolean>::.ctor(System.Object,System.IntPtr)
IL_009b: callvirt System.Void Rewired.Utils.Classes.Utility.ValueWatcher`1<System.Boolean>::add_ChangedEvent(System.Action`1<T>)
IL_00a0: ldsfld Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT Rewired.ReInput::GGbNxxBRsPVtXooKvddzWaNspLr
IL_00a5: ldfld Rewired.Utils.Classes.Utility.ValueWatcher`1<System.Boolean> Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT::xIMFCrwXunWxoekBlleMmJYPdj
IL_00aa: ldnull
IL_00ab: ldftn System.Void Rewired.ReInput::mCsQpvsMrGzXKVUkcGCTkimAjyGC(System.Boolean)
IL_00b1: newobj System.Void System.Action`1<System.Boolean>::.ctor(System.Object,System.IntPtr)
IL_00b6: callvirt System.Void Rewired.Utils.Classes.Utility.ValueWatcher`1<System.Boolean>::add_ChangedEvent(System.Action`1<T>)
IL_00bb: ldsfld Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT Rewired.ReInput::GGbNxxBRsPVtXooKvddzWaNspLr
IL_00c0: ldfld Rewired.Utils.Classes.Utility.ValueWatcher`1<System.Int32> Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT::lduifWWpoEYmbMjTJGxfiCrUaVbH
IL_00c5: ldnull
IL_00c6: ldftn System.Void Rewired.ReInput::mNqvYoJhIIPBgDCfcDtlVXIIyeO(System.Int32)
IL_00cc: newobj System.Void System.Action`1<System.Int32>::.ctor(System.Object,System.IntPtr)
IL_00d1: callvirt System.Void Rewired.Utils.Classes.Utility.ValueWatcher`1<System.Int32>::add_ChangedEvent(System.Action`1<T>)
IL_00d6: ldc.i4 -436809212
IL_00db: br IL_000d
IL_00e0: ret
METHOD System.Void Rewired.ReInput::MkbhfLFUcsGsRzkXpoCFDbyKRux() | attributes=Private, Static, HideBySig | impl=IL
IL_0000: ldsfld Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT Rewired.ReInput::GGbNxxBRsPVtXooKvddzWaNspLr
IL_0005: brtrue.s IL_0026
IL_0007: ret
IL_0008: ldc.i4 -2134006412
IL_000d: ldc.i4 -2134006411
IL_0012: xor
IL_0013: switch IL_0008,IL_0026,IL_009c
IL_0024: br.s IL_009c
IL_0026: ldsfld Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT Rewired.ReInput::GGbNxxBRsPVtXooKvddzWaNspLr
IL_002b: ldfld Rewired.Utils.Classes.Utility.ValueWatcher`1<System.Boolean> Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT::QBAmVSgbZBPmppTHWYNgMiDCmXg
IL_0030: ldnull
IL_0031: ldftn System.Void Rewired.ReInput::rRujWYRgwEnOOYvDVNSFbReupcp(System.Boolean)
IL_0037: newobj System.Void System.Action`1<System.Boolean>::.ctor(System.Object,System.IntPtr)
IL_003c: callvirt System.Void Rewired.Utils.Classes.Utility.ValueWatcher`1<System.Boolean>::remove_ChangedEvent(System.Action`1<T>)
IL_0041: ldsfld Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT Rewired.ReInput::GGbNxxBRsPVtXooKvddzWaNspLr
IL_0046: ldfld Rewired.Utils.Classes.Utility.ValueWatcher`1<System.Boolean> Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT::QkenjZZMPJJaNftxIrJnlwjEQPK
IL_004b: ldnull
IL_004c: ldftn System.Void Rewired.ReInput::onhJtZBTAqastjBkTAkMSmXLkbp(System.Boolean)
IL_0052: newobj System.Void System.Action`1<System.Boolean>::.ctor(System.Object,System.IntPtr)
IL_0057: callvirt System.Void Rewired.Utils.Classes.Utility.ValueWatcher`1<System.Boolean>::remove_ChangedEvent(System.Action`1<T>)
IL_005c: ldsfld Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT Rewired.ReInput::GGbNxxBRsPVtXooKvddzWaNspLr
IL_0061: ldfld Rewired.Utils.Classes.Utility.ValueWatcher`1<System.Boolean> Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT::xIMFCrwXunWxoekBlleMmJYPdj
IL_0066: ldnull
IL_0067: ldftn System.Void Rewired.ReInput::mCsQpvsMrGzXKVUkcGCTkimAjyGC(System.Boolean)
IL_006d: newobj System.Void System.Action`1<System.Boolean>::.ctor(System.Object,System.IntPtr)
IL_0072: callvirt System.Void Rewired.Utils.Classes.Utility.ValueWatcher`1<System.Boolean>::remove_ChangedEvent(System.Action`1<T>)
IL_0077: ldsfld Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT Rewired.ReInput::GGbNxxBRsPVtXooKvddzWaNspLr
IL_007c: ldfld Rewired.Utils.Classes.Utility.ValueWatcher`1<System.Int32> Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT::lduifWWpoEYmbMjTJGxfiCrUaVbH
IL_0081: ldnull
IL_0082: ldftn System.Void Rewired.ReInput::mNqvYoJhIIPBgDCfcDtlVXIIyeO(System.Int32)
IL_0088: newobj System.Void System.Action`1<System.Int32>::.ctor(System.Object,System.IntPtr)
IL_008d: callvirt System.Void Rewired.Utils.Classes.Utility.ValueWatcher`1<System.Int32>::remove_ChangedEvent(System.Action`1<T>)
IL_0092: ldc.i4 -2134006409
IL_0097: br IL_000d
IL_009c: ldsfld Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT Rewired.ReInput::GGbNxxBRsPVtXooKvddzWaNspLr
IL_00a1: ldfld Rewired.Utils.Classes.Utility.ValueWatcher`1<System.Boolean> Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT::oDAHXPduaFEkAbKbGTChrxaQccTL
IL_00a6: ldnull
IL_00a7: ldftn System.Void Rewired.ReInput::ItlbQczDKGVecohZzRGNikVWczr(System.Boolean)
IL_00ad: newobj System.Void System.Action`1<System.Boolean>::.ctor(System.Object,System.IntPtr)
IL_00b2: callvirt System.Void Rewired.Utils.Classes.Utility.ValueWatcher`1<System.Boolean>::remove_ChangedEvent(System.Action`1<T>)
IL_00b7: ret
