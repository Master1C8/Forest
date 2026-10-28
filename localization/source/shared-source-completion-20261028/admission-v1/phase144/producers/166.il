TYPE viperOSK.OSK_Receiver
METHOD System.Void viperOSK.OSK_Receiver::Awake() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldstr ""
IL_0006: stfld System.String viperOSK.OSK_Receiver::text
IL_000b: ldarg.0
IL_000c: call UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0011: ldarg.0
IL_0012: ldflda TMPro.TMP_Text viperOSK.OSK_Receiver::textReceiver
IL_0017: callvirt System.Boolean UnityEngine.GameObject::TryGetComponent<TMPro.TMP_Text>(!!0&)
IL_001c: brfalse.s IL_005e
IL_001e: ldarg.0
IL_001f: ldfld TMPro.TMP_Text viperOSK.OSK_Receiver::textReceiver
IL_0024: ldarg.0
IL_0025: ldfld UnityEngine.Color32 viperOSK.OSK_Receiver::normalColor
IL_002a: call UnityEngine.Color UnityEngine.Color32::op_Implicit(UnityEngine.Color32)
IL_002f: callvirt System.Void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)
IL_0034: ldarg.0
IL_0035: ldarg.0
IL_0036: call UnityEngine.Transform UnityEngine.Component::get_transform()
IL_003b: callvirt !!0 UnityEngine.Component::GetComponentInChildren<viperOSK.I_OSK_Cursor>()
IL_0040: stfld viperOSK.I_OSK_Cursor viperOSK.OSK_Receiver::cursor
IL_0045: ldarg.0
IL_0046: ldfld viperOSK.I_OSK_Cursor viperOSK.OSK_Receiver::cursor
IL_004b: brtrue.s IL_0057
IL_004d: ldstr "This TMPro text object does not have a cursor. If you want full edit functionality add a OSK_Cursor prefab as a child"
IL_0052: call System.Void UnityEngine.Debug::LogWarning(System.Object)
IL_0057: ldarg.0
IL_0058: callvirt System.Void viperOSK.OSK_Receiver::OnFocusLost()
IL_005d: ret
IL_005e: ldstr "OSK_Receiver must be in the same gameobject as the TextMeshPro text object receiving text input"
IL_0063: call System.Void UnityEngine.Debug::LogWarning(System.Object)
IL_0068: ret
METHOD System.String viperOSK.OSK_Receiver::Text() | attributes=Public, Virtual, HideBySig, VtableLayoutMask | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.String viperOSK.OSK_Receiver::text
IL_0006: brfalse.s IL_000f
IL_0008: ldarg.0
IL_0009: ldfld System.String viperOSK.OSK_Receiver::text
IL_000e: ret
IL_000f: ldstr ""
IL_0014: ret
METHOD System.Void viperOSK.OSK_Receiver::ClearText() | attributes=Public, Virtual, HideBySig, VtableLayoutMask | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TMPro.TMP_Text viperOSK.OSK_Receiver::textReceiver
IL_0006: ldstr ""
IL_000b: callvirt System.Void TMPro.TMP_Text::set_text(System.String)
IL_0010: ldarg.0
IL_0011: ldstr ""
IL_0016: stfld System.String viperOSK.OSK_Receiver::text
IL_001b: ret
METHOD System.Void viperOSK.OSK_Receiver::.ctor() | attributes=Public, HideBySig, SpecialName, RTSpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldstr ""
IL_0006: stfld System.String viperOSK.OSK_Receiver::text
IL_000b: ldarg.0
IL_000c: ldc.i4.s 20
IL_000e: stfld System.Int32 viperOSK.OSK_Receiver::textLimit
IL_0013: ldarg.0
IL_0014: ldc.i4.m1
IL_0015: ldc.i4.m1
IL_0016: newobj System.Void UnityEngine.Vector2Int::.ctor(System.Int32,System.Int32)
IL_001b: stfld UnityEngine.Vector2Int viperOSK.OSK_Receiver::cursorSel
IL_0020: ldarg.0
IL_0021: ldstr ""
IL_0026: stfld System.String viperOSK.OSK_Receiver::charMask
IL_002b: ldarg.0
IL_002c: call System.Void UnityEngine.MonoBehaviour::.ctor()
IL_0031: ret
