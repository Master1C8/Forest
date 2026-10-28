TYPE viperOSK.OSK_Key_TFOL
METHOD System.Void viperOSK.OSK_Key_TFOL::Click() | attributes=Public, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Boolean viperOSK.OSK_Key::isPressed
IL_0006: brtrue.s IL_001e
IL_0008: ldarg.0
IL_0009: call System.Void viperOSK.OSK_Key_TFOL::OnMouseDown_Handle()
IL_000e: ldarg.0
IL_000f: ldstr "OnMouseUp_Handle"
IL_0014: ldc.r4 0.01
IL_0019: call System.Void viperOSK.OSK_Key_TFOL::InvokeRealTime(System.String,System.Single)
IL_001e: ret
