TYPE Rewired.ReInput
METHOD System.Boolean Rewired.ReInput::get_inputAllowed()
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
METHOD System.Void Rewired.ReInput::sXSmojTfsGWqzEIEtxKcdoWFQcy()
IL_0000: ldsfld System.Boolean Rewired.ReInput::NPfefDCOwXSjdltUbdIpmiYqZmUC
IL_0005: ldsfld Rewired.Data.ConfigVars Rewired.ReInput::OJxXokxjIIFupQczlCnOgNGVMwNT
IL_000a: callvirt System.Boolean Rewired.Data.ConfigVars::GetPlatformVar_ignoreInputWhenAppNotInFocus()
IL_000f: beq.s IL_0043
IL_0011: ldc.i4 -1803604971
IL_0016: ldc.i4 -1803604972
IL_001b: xor
IL_001c: switch IL_0043,IL_002f,IL_0011
IL_002d: br.s IL_0043
IL_002f: ldsfld System.Boolean Rewired.ReInput::NPfefDCOwXSjdltUbdIpmiYqZmUC
IL_0034: ldc.i4.0
IL_0035: ceq
IL_0037: stsfld System.Boolean Rewired.ReInput::NPfefDCOwXSjdltUbdIpmiYqZmUC
IL_003c: ldc.i4 -1803604972
IL_0041: br.s IL_0016
IL_0043: ret
