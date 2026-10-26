TYPE Rewired.ReInput
METHOD System.Boolean Rewired.ReInput::get_inputAllowed() | attributes=Private, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld System.Boolean Rewired.ReInput::aLzbAjHdyinuPAkYilYZkIGyBOc
IL_0005: brtrue.s IL_0009
IL_0007: ldc.i4.0
IL_0008: ret
IL_0009: ldsfld Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT Rewired.ReInput::GGbNxxBRsPVtXooKvddzWaNspLr
IL_000e: ldfld Rewired.Utils.Classes.Utility.ValueWatcher`1<System.Boolean> Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT::QBAmVSgbZBPmppTHWYNgMiDCmXg
IL_0013: callvirt T Rewired.Utils.Classes.Utility.ValueWatcher`1<System.Boolean>::get_value()
IL_0018: brtrue.s IL_0062
IL_001a: ldsfld System.Boolean Rewired.ReInput::NPfefDCOwXSjdltUbdIpmiYqZmUC
IL_001f: brfalse.s IL_0041
IL_0021: ldc.i4 746685501
IL_0026: ldc.i4 746685500
IL_002b: xor
IL_002c: switch IL_0021,IL_003f,IL_004f
IL_003d: br.s IL_004f
IL_003f: ldc.i4.0
IL_0040: ret
IL_0041: call System.Boolean Rewired.ReInput::get_isEditor()
IL_0046: brtrue.s IL_0062
IL_0048: ldc.i4 746685502
IL_004d: br.s IL_0026
IL_004f: ldsfld Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT Rewired.ReInput::GGbNxxBRsPVtXooKvddzWaNspLr
IL_0054: ldfld Rewired.Utils.Classes.Utility.ValueWatcher`1<System.Boolean> Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT::xIMFCrwXunWxoekBlleMmJYPdj
IL_0059: callvirt T Rewired.Utils.Classes.Utility.ValueWatcher`1<System.Boolean>::get_value()
IL_005e: brtrue.s IL_0062
IL_0060: ldc.i4.0
IL_0061: ret
IL_0062: ldc.i4.1
IL_0063: ret
METHOD System.Boolean Rewired.ReInput::IsInputAllowed(Rewired.ControllerType) | attributes=Assembly, Static, HideBySig | impl=IL
ATTRIBUTE Rewired.CustomObfuscation
IL_0000: call System.Boolean Rewired.ReInput::get_inputAllowed()
IL_0005: brtrue.s IL_0027
IL_0007: ldc.i4 -407708883
IL_000c: ldc.i4 -407708881
IL_0011: xor
IL_0012: switch IL_0007,IL_003c,IL_0025
IL_0023: br.s IL_003c
IL_0025: ldc.i4.0
IL_0026: ret
IL_0027: ldsfld Rewired.Platforms.EditorPlatform Rewired.ReInput::oPUAJMywrLEmBbqmOIkACwccdcP
IL_002c: brfalse.s IL_006c
IL_002e: ldarg.0
IL_002f: brfalse.s IL_003c
IL_0031: ldarg.0
IL_0032: ldc.i4.1
IL_0033: bne.un.s IL_006c
IL_0035: ldc.i4 -407708882
IL_003a: br.s IL_000c
IL_003c: ldsfld System.Boolean Rewired.ReInput::NPfefDCOwXSjdltUbdIpmiYqZmUC
IL_0041: brfalse.s IL_0056
IL_0043: ldsfld Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT Rewired.ReInput::GGbNxxBRsPVtXooKvddzWaNspLr
IL_0048: ldfld Rewired.Utils.Classes.Utility.ValueWatcher`1<System.Boolean> Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT::QBAmVSgbZBPmppTHWYNgMiDCmXg
IL_004d: callvirt T Rewired.Utils.Classes.Utility.ValueWatcher`1<System.Boolean>::get_value()
IL_0052: brtrue.s IL_006c
IL_0054: ldc.i4.0
IL_0055: ret
IL_0056: call System.Boolean Rewired.ReInput::get_isAllowedEditorWindowFocused()
IL_005b: brtrue.s IL_005f
IL_005d: ldc.i4.0
IL_005e: ret
IL_005f: ldarg.0
IL_0060: ldc.i4.1
IL_0061: bne.un.s IL_006c
IL_0063: call System.Boolean Rewired.ReInput::get_isUnityEditorFocused()
IL_0068: brtrue.s IL_006c
IL_006a: ldc.i4.0
IL_006b: ret
IL_006c: ldc.i4.1
IL_006d: ret
METHOD System.Boolean Rewired.ReInput::get_applicationIsFocused() | attributes=Assembly, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld System.Boolean Rewired.ReInput::aLzbAjHdyinuPAkYilYZkIGyBOc
IL_0005: brfalse.s IL_0017
IL_0007: ldsfld Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT Rewired.ReInput::GGbNxxBRsPVtXooKvddzWaNspLr
IL_000c: ldfld Rewired.Utils.Classes.Utility.ValueWatcher`1<System.Boolean> Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT::QBAmVSgbZBPmppTHWYNgMiDCmXg
IL_0011: callvirt T Rewired.Utils.Classes.Utility.ValueWatcher`1<System.Boolean>::get_value()
IL_0016: ret
IL_0017: ldc.i4.0
IL_0018: ret
METHOD System.Boolean Rewired.ReInput::get_applicationRunInBackground() | attributes=Assembly, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld System.Boolean Rewired.ReInput::aLzbAjHdyinuPAkYilYZkIGyBOc
IL_0005: brfalse.s IL_0017
IL_0007: ldsfld Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT Rewired.ReInput::GGbNxxBRsPVtXooKvddzWaNspLr
IL_000c: ldfld Rewired.Utils.Classes.Utility.ValueWatcher`1<System.Boolean> Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT::xIMFCrwXunWxoekBlleMmJYPdj
IL_0011: callvirt T Rewired.Utils.Classes.Utility.ValueWatcher`1<System.Boolean>::get_value()
IL_0016: ret
IL_0017: ldc.i4.0
IL_0018: ret
