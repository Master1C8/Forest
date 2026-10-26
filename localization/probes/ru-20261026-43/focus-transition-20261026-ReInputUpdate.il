TYPE Rewired.ReInput
METHOD System.Void Rewired.ReInput::HXpJWkBpkWGHVPusKmSTbEJtFhLg(Rewired.UpdateLoopType) | attributes=Assembly, Static, HideBySig | impl=IL
IL_0000: ldsfld System.Boolean Rewired.ReInput::aLzbAjHdyinuPAkYilYZkIGyBOc
IL_0005: brtrue.s IL_002a
IL_0007: ret
IL_0008: ldc.i4 -1353336777
IL_000d: ldc.i4 -1353336778
IL_0012: xor
IL_0013: switch IL_0039,IL_002a,IL_004f,IL_0008
IL_0028: br.s IL_004f
IL_002a: ldarg.0
IL_002b: call System.Void Rewired.ReInput::nlCAvFCuyFlAIRnTmvLKpOsouZf(Rewired.UpdateLoopType)
IL_0030: ldarg.0
IL_0031: stloc.0
IL_0032: ldc.i4 -1353336778
IL_0037: br.s IL_000d
IL_0039: ldloc.0
IL_003a: switch IL_004f,IL_004f
IL_0047: ret
IL_0048: ldc.i4 -1353336780
IL_004d: br.s IL_000d
IL_004f: call System.Void Rewired.ReInput::RAMFayRdZKehHlVCyOArgZfgEb()
IL_0054: ret
METHOD System.Void Rewired.ReInput::nlCAvFCuyFlAIRnTmvLKpOsouZf(Rewired.UpdateLoopType) | attributes=Private, Static, HideBySig | impl=IL
IL_0000: ldsfld Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT Rewired.ReInput::GGbNxxBRsPVtXooKvddzWaNspLr
IL_0005: brfalse.s IL_0011
IL_0007: ldsfld Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT Rewired.ReInput::GGbNxxBRsPVtXooKvddzWaNspLr
IL_000c: callvirt System.Void Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT::jSmUMfkZCZCZfiMnleEGJnwKIqT()
IL_0011: ldsfld System.Action`1<Rewired.UpdateLoopType> Rewired.ReInput::VLApZjoGpQIQlONUDdRToHrfBcO
IL_0016: stloc.0
IL_0017: ldloc.0
IL_0018: brfalse.s IL_0031
IL_001a: ldloc.0
IL_001b: ldarg.0
IL_001c: callvirt System.Void System.Action`1<Rewired.UpdateLoopType>::Invoke(!0)
IL_0021: leave.s IL_0031
IL_0023: stloc.1
IL_0024: ldstr "ReInput.BeforeTimeManagerUpdateEvent"
IL_0029: ldloc.1
IL_002a: call System.Void Rewired.ReInput::HandleCallbackException(System.String,System.Exception)
IL_002f: leave.s IL_0031
IL_0031: ldsfld Rewired.ReInput/boJgboDXhtOpkFRaIkAocTQCligw Rewired.ReInput::WCBgQMGSpRhxzDiVYlIVPBjukCy
IL_0036: ldarg.0
IL_0037: callvirt System.Void Rewired.ReInput/boJgboDXhtOpkFRaIkAocTQCligw::jSmUMfkZCZCZfiMnleEGJnwKIqT(Rewired.UpdateLoopType)
IL_003c: ret
METHOD System.Void Rewired.ReInput::jSmUMfkZCZCZfiMnleEGJnwKIqT(Rewired.UpdateLoopType) | attributes=Assembly, Static, HideBySig | impl=IL
IL_0000: ldsfld System.Boolean Rewired.ReInput::aLzbAjHdyinuPAkYilYZkIGyBOc
IL_0005: brtrue.s IL_0041
IL_0007: ret
IL_0008: ldc.i4 -53367496
IL_000d: ldc.i4 -53367492
IL_0012: xor
IL_0013: switch IL_0072,IL_0094,IL_005a,IL_00f3,IL_0041,IL_00c6,IL_00b2,IL_0084,IL_0008
IL_003c: br IL_00f3
IL_0041: ldsfld Rewired.UpdateLoopType Rewired.ReInput::JKYrFfHGvLiOGdRtMclqgSPBkyR
IL_0046: ldarg.0
IL_0047: bne.un.s IL_0051
IL_0049: ldc.i4 -53367490
IL_004e: dup
IL_004f: br.s IL_0057
IL_0051: ldc.i4 -53367493
IL_0056: dup
IL_0057: pop
IL_0058: br.s IL_000d
IL_005a: call Rewired.Platforms.EditorPlatform Rewired.ReInput::get_editorPlatform()
IL_005f: brfalse.s IL_0069
IL_0061: ldc.i4 -53367491
IL_0066: dup
IL_0067: br.s IL_006f
IL_0069: ldc.i4 -53367495
IL_006e: dup
IL_006f: pop
IL_0070: br.s IL_000d
IL_0072: call KcAdaEYPWlBKOkoSWkXvREtouzg Rewired.ReInput::get_unityInputBuffer()
IL_0077: ldarg.0
IL_0078: callvirt System.Void KcAdaEYPWlBKOkoSWkXvREtouzg::jSmUMfkZCZCZfiMnleEGJnwKIqT(Rewired.UpdateLoopType)
IL_007d: ldc.i4 -53367494
IL_0082: br.s IL_000d
IL_0084: ldarg.0
IL_0085: stsfld Rewired.UpdateLoopType Rewired.ReInput::JKYrFfHGvLiOGdRtMclqgSPBkyR
IL_008a: ldc.i4 -53367490
IL_008f: br IL_000d
IL_0094: ldsfld Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT Rewired.ReInput::GGbNxxBRsPVtXooKvddzWaNspLr
IL_0099: ldfld Rewired.Utils.Classes.Utility.ValueWatcher`1<System.String> Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT::MuuXaMIShRtUzBodRSnPbFwFHga
IL_009e: callvirt T Rewired.Utils.Classes.Utility.ValueWatcher`1<System.String>::get_value()
IL_00a3: stsfld System.String Rewired.ReInput::urYvVAJPxxgPDQTOjkiVXIhUHSbg
IL_00a8: ldc.i4 -53367495
IL_00ad: br IL_000d
IL_00b2: ldsfld Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT Rewired.ReInput::GGbNxxBRsPVtXooKvddzWaNspLr
IL_00b7: callvirt System.Void Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT::wweiCHaRbiDSHRzxofNoPRkDurZ()
IL_00bc: ldc.i4 -53367489
IL_00c1: br IL_000d
IL_00c6: ldsfld System.Boolean Rewired.ReInput::oLsXvjfMAfPpnNGCyUWjLoDyWRS
IL_00cb: brfalse.s IL_00b2
IL_00cd: ldsfld Rewired.Utils.Classes.Utility.TimerAbs Rewired.ReInput::JOBvZCwcejLmepHDIGBbiGtkzuC
IL_00d2: callvirt System.Boolean Rewired.Utils.Classes.Utility.TimerAbs::Update()
IL_00d7: brfalse.s IL_0072
IL_00d9: ldc.i4.0
IL_00da: stsfld System.Boolean Rewired.ReInput::oLsXvjfMAfPpnNGCyUWjLoDyWRS
IL_00df: ldsfld Rewired.Utils.Classes.Utility.TimerAbs Rewired.ReInput::JOBvZCwcejLmepHDIGBbiGtkzuC
IL_00e4: callvirt System.Void Rewired.Utils.Classes.Utility.TimerAbs::Clear()
IL_00e9: ldc.i4 -53367494
IL_00ee: br IL_000d
IL_00f3: ldsfld System.Action`1<Rewired.UpdateLoopType> Rewired.ReInput::VtKklTTGUHrZmJxRdvIOFWQEuxz
IL_00f8: stloc.0
IL_00f9: ldloc.0
IL_00fa: brfalse.s IL_0113
IL_00fc: ldloc.0
IL_00fd: ldarg.0
IL_00fe: callvirt System.Void System.Action`1<Rewired.UpdateLoopType>::Invoke(!0)
IL_0103: leave.s IL_0113
IL_0105: stloc.1
IL_0106: ldstr "ReInput.UpdateStartedEvent"
IL_010b: ldloc.1
IL_010c: call System.Void Rewired.ReInput::HandleCallbackException(System.String,System.Exception)
IL_0111: leave.s IL_0113
IL_0113: ldsfld Rewired.PlatformInputManager Rewired.ReInput::EipmgiMCREFLYqaOyKWtcpJhWRc
IL_0118: ldarg.0
IL_0119: callvirt System.Void Rewired.PlatformInputManager::Update(Rewired.UpdateLoopType)
IL_011e: ldc.i4 -53367491
IL_0123: ldc.i4 -53367492
IL_0128: xor
IL_0129: switch IL_011e,IL_013c,IL_0154
IL_013a: br.s IL_0154
IL_013c: ldsfld Rewired.Utils.SafeAction Rewired.ReInput::HAWepiJVuqsaIpfDnupuwRuyPcFD
IL_0141: brfalse.s IL_0154
IL_0143: ldsfld Rewired.Utils.SafeAction Rewired.ReInput::HAWepiJVuqsaIpfDnupuwRuyPcFD
IL_0148: callvirt System.Void Rewired.Utils.SafeAction::Invoke()
IL_014d: ldc.i4 -53367490
IL_0152: br.s IL_0123
IL_0154: ldsfld zMtJShWdNqreuDVsbowqVZNzwts Rewired.ReInput::BoiYVdWmWlQykdYqdqdvncsPfPC
IL_0159: ldarg.0
IL_015a: callvirt System.Void zMtJShWdNqreuDVsbowqVZNzwts::jSmUMfkZCZCZfiMnleEGJnwKIqT(Rewired.UpdateLoopType)
IL_015f: ldsfld System.Action`1<Rewired.UpdateLoopType> Rewired.ReInput::BnIRqUGHnrBPbnhMTkaoTXQKEAP
IL_0164: stloc.2
IL_0165: ldloc.2
IL_0166: brfalse.s IL_017f
IL_0168: ldloc.2
IL_0169: ldarg.0
IL_016a: callvirt System.Void System.Action`1<Rewired.UpdateLoopType>::Invoke(!0)
IL_016f: leave.s IL_017f
IL_0171: stloc.3
IL_0172: ldstr "ReInput.UpdateEndedEvent"
IL_0177: ldloc.3
IL_0178: call System.Void Rewired.ReInput::HandleCallbackException(System.String,System.Exception)
IL_017d: leave.s IL_017f
IL_017f: ret
