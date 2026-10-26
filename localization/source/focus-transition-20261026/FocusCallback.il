TYPE Rewired.ReInput
METHOD System.Void Rewired.ReInput::add_ApplicationFocusChangedEvent(System.Action`1<System.Boolean>) | attributes=Assembly, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld System.Action`1<System.Boolean> Rewired.ReInput::_ApplicationFocusChangedEvent
IL_0005: ldarg.0
IL_0006: call System.Delegate System.Delegate::Combine(System.Delegate,System.Delegate)
IL_000b: castclass System.Action`1<System.Boolean>
IL_0010: stsfld System.Action`1<System.Boolean> Rewired.ReInput::_ApplicationFocusChangedEvent
IL_0015: ret
METHOD System.Void Rewired.ReInput::remove_ApplicationFocusChangedEvent(System.Action`1<System.Boolean>) | attributes=Assembly, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld System.Action`1<System.Boolean> Rewired.ReInput::_ApplicationFocusChangedEvent
IL_0005: ldarg.0
IL_0006: call System.Delegate System.Delegate::Remove(System.Delegate,System.Delegate)
IL_000b: castclass System.Action`1<System.Boolean>
IL_0010: stsfld System.Action`1<System.Boolean> Rewired.ReInput::_ApplicationFocusChangedEvent
IL_0015: ret
METHOD System.Void Rewired.ReInput::bznJUoHKVApHghlqpCKYJLbDytar(System.Boolean) | attributes=Assembly, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: stsfld System.Boolean Rewired.ReInput::cbmmwJPDGUhXqzzdtJQPbNHADIB
IL_0006: ldc.i4 -934604734
IL_000b: ldc.i4 -934604733
IL_0010: xor
IL_0011: switch IL_0006,IL_005c,IL_0054,IL_0034,IL_008f,IL_0074,IL_004c
IL_0032: br.s IL_008f
IL_0034: ldsfld Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT Rewired.ReInput::GGbNxxBRsPVtXooKvddzWaNspLr
IL_0039: ldfld Rewired.Utils.Classes.Utility.ValueWatcher`1<System.Boolean> Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT::QBAmVSgbZBPmppTHWYNgMiDCmXg
IL_003e: ldarg.0
IL_003f: callvirt System.Boolean Rewired.Utils.Classes.Utility.ValueWatcher`1<System.Boolean>::Set(T)
IL_0044: pop
IL_0045: ldc.i4 -934604729
IL_004a: br.s IL_000b
IL_004c: ret
IL_004d: ldc.i4 -934604730
IL_0052: br.s IL_000b
IL_0054: ret
IL_0055: ldc.i4 -934604736
IL_005a: br.s IL_000b
IL_005c: ldsfld Rewired.Platforms.EditorPlatform Rewired.ReInput::oPUAJMywrLEmBbqmOIkACwccdcP
IL_0061: brtrue.s IL_006b
IL_0063: ldc.i4 -934604730
IL_0068: dup
IL_0069: br.s IL_0071
IL_006b: ldc.i4 -934604731
IL_0070: dup
IL_0071: pop
IL_0072: br.s IL_000b
IL_0074: ldsfld System.Boolean Rewired.ReInput::aLzbAjHdyinuPAkYilYZkIGyBOc
IL_0079: brfalse.s IL_0083
IL_007b: ldc.i4 -934604736
IL_0080: dup
IL_0081: br.s IL_0089
IL_0083: ldc.i4 -934604735
IL_0088: dup
IL_0089: pop
IL_008a: br IL_000b
IL_008f: ldsfld Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT Rewired.ReInput::GGbNxxBRsPVtXooKvddzWaNspLr
IL_0094: ldfld Rewired.Utils.Classes.Utility.ValueWatcher`1<System.Boolean> Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT::QBAmVSgbZBPmppTHWYNgMiDCmXg
IL_0099: callvirt System.Boolean Rewired.Utils.Classes.Utility.ValueWatcher::TriggerEvent()
IL_009e: pop
IL_009f: ret
METHOD System.Void Rewired.ReInput::rRujWYRgwEnOOYvDVNSFbReupcp(System.Boolean) | attributes=Private, Static, HideBySig | impl=IL
IL_0000: ldsfld System.Boolean Rewired.ReInput::aLzbAjHdyinuPAkYilYZkIGyBOc
IL_0005: brtrue.s IL_0008
IL_0007: ret
IL_0008: ldsfld System.Action`1<System.Boolean> Rewired.ReInput::_ApplicationFocusChangedEvent
IL_000d: stloc.0
IL_000e: ldloc.0
IL_000f: brfalse.s IL_0028
IL_0011: ldloc.0
IL_0012: ldarg.0
IL_0013: callvirt System.Void System.Action`1<System.Boolean>::Invoke(!0)
IL_0018: leave.s IL_0028
IL_001a: stloc.1
IL_001b: ldstr "ReInput.ApplicationFocusChangedEvent"
IL_0020: ldloc.1
IL_0021: call System.Void Rewired.ReInput::HandleCallbackException(System.String,System.Exception)
IL_0026: leave.s IL_0028
IL_0028: ret
METHOD System.Boolean Rewired.ReInput::ZKumZMMwjLdcKigSxyxILFzYDuE() | attributes=Private, Static, HideBySig | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: call System.Boolean Rewired.ReInput::get_isUnityEditorFocused()
IL_0005: brfalse.s IL_000d
IL_0007: call System.Boolean Rewired.ReInput::get_isAllowedEditorWindowFocused()
IL_000c: ret
IL_000d: ldc.i4.0
IL_000e: ret
