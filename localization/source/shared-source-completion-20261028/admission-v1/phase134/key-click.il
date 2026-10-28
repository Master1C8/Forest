TYPE viperOSK.OSK_Key
METHOD System.Void viperOSK.OSK_Key::Click() | attributes=Public, Virtual, HideBySig, VtableLayoutMask | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Boolean viperOSK.OSK_Key::isPressed
IL_0006: brtrue.s IL_001e
IL_0008: ldarg.0
IL_0009: callvirt System.Void viperOSK.OSK_Key::OnMouseDown()
IL_000e: ldarg.0
IL_000f: ldstr "OnMouseUp"
IL_0014: ldc.r4 0.15
IL_0019: call System.Void UnityEngine.MonoBehaviour::Invoke(System.String,System.Single)
IL_001e: ret
