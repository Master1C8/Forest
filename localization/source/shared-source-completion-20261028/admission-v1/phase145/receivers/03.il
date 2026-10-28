TYPE viperOSK.OSK_Key_TFOL
METHOD System.Void viperOSK.OSK_Key_TFOL::Relabel(System.String) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Boolean viperOSK.OSK_Key_TFOL::IsShiftKey()
IL_0006: brtrue.s IL_0016
IL_0008: ldarg.0
IL_0009: ldfld UnityEngine.KeyCode viperOSK.OSK_Key::key
IL_000e: ldc.i4 302
IL_0013: beq.s IL_0016
IL_0015: ret
IL_0016: ldarg.0
IL_0017: ldfld TMPro.TextMeshPro viperOSK.OSK_Key::keyName
IL_001c: ldarg.1
IL_001d: brtrue.s IL_0027
IL_001f: ldarg.0
IL_0020: ldfld System.String viperOSK.OSK_Key_TFOL::defaultLabelText
IL_0025: br.s IL_0028
IL_0027: ldarg.1
IL_0028: callvirt System.Void TMPro.TMP_Text::set_text(System.String)
IL_002d: ret
