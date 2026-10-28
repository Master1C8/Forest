TYPE viperOSK.OSK_UI_InputReceiver
METHOD System.String viperOSK.OSK_UI_InputReceiver::Text() | attributes=Public, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld viperOSK.OSK_UI_InputReceiver/OSK_RECEIVER viperOSK.OSK_UI_InputReceiver::receiver
IL_0006: stloc.0
IL_0007: ldloc.0
IL_0008: ldc.i4.1
IL_0009: beq.s IL_0011
IL_000b: ldloc.0
IL_000c: ldc.i4.2
IL_000d: beq.s IL_001d
IL_000f: br.s IL_0029
IL_0011: ldarg.0
IL_0012: ldfld UnityEngine.UI.InputField viperOSK.OSK_UI_InputReceiver::inputReceiver
IL_0017: callvirt System.String UnityEngine.UI.InputField::get_text()
IL_001c: ret
IL_001d: ldarg.0
IL_001e: ldfld TMPro.TMP_InputField viperOSK.OSK_UI_InputReceiver::inputTMPReceiver
IL_0023: callvirt System.String TMPro.TMP_InputField::get_text()
IL_0028: ret
IL_0029: ldstr ""
IL_002e: ret
METHOD System.String viperOSK.OSK_UI_InputReceiver::ParsedText() | attributes=Public, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld viperOSK.OSK_UI_InputReceiver/OSK_RECEIVER viperOSK.OSK_UI_InputReceiver::receiver
IL_0006: stloc.0
IL_0007: ldloc.0
IL_0008: ldc.i4.1
IL_0009: beq.s IL_0011
IL_000b: ldloc.0
IL_000c: ldc.i4.2
IL_000d: beq.s IL_001d
IL_000f: br.s IL_0029
IL_0011: ldarg.0
IL_0012: ldfld UnityEngine.UI.InputField viperOSK.OSK_UI_InputReceiver::inputReceiver
IL_0017: callvirt System.String UnityEngine.UI.InputField::get_text()
IL_001c: ret
IL_001d: ldarg.0
IL_001e: ldfld TMPro.TMP_InputField viperOSK.OSK_UI_InputReceiver::inputTMPReceiver
IL_0023: callvirt System.String TMPro.TMP_InputField::get_text()
IL_0028: ret
IL_0029: ldstr ""
IL_002e: ret
