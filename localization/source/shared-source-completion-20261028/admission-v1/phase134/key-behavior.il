TYPE viperOSK.OSK_Key_TFOL
METHOD System.Void viperOSK.OSK_Key_TFOL::Awake() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.0
IL_0002: ldfld TMPro.TextMeshPro viperOSK.OSK_Key::keyName
IL_0007: callvirt UnityEngine.Color UnityEngine.UI.Graphic::get_color()
IL_000c: call System.Void viperOSK.OSK_Key_TFOL::set_textColor(UnityEngine.Color)
IL_0011: ldarg.0
IL_0012: ldarg.0
IL_0013: ldfld TMPro.TextMeshPro viperOSK.OSK_Key::keyName
IL_0018: callvirt UnityEngine.Color UnityEngine.UI.Graphic::get_color()
IL_001d: call System.Void viperOSK.OSK_Key_TFOL::set_textColorSelected(UnityEngine.Color)
IL_0022: ldarg.0
IL_0023: ldarg.0
IL_0024: ldfld UnityEngine.SpriteRenderer viperOSK.OSK_Key::bk
IL_0029: callvirt UnityEngine.Color UnityEngine.SpriteRenderer::get_color()
IL_002e: call System.Void viperOSK.OSK_Key_TFOL::set_bgColor(UnityEngine.Color)
IL_0033: ldarg.0
IL_0034: call UnityEngine.Color UnityEngine.Color::get_white()
IL_0039: call System.Void viperOSK.OSK_Key_TFOL::set_bgColorSelected(UnityEngine.Color)
IL_003e: ldarg.0
IL_003f: ldarg.0
IL_0040: ldfld TMPro.TextMeshPro viperOSK.OSK_Key::keyName
IL_0045: callvirt System.String TMPro.TMP_Text::get_text()
IL_004a: stfld System.String viperOSK.OSK_Key_TFOL::defaultLabelText
IL_004f: ret
METHOD System.Boolean viperOSK.OSK_Key_TFOL::IsShiftKey() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld UnityEngine.KeyCode viperOSK.OSK_Key::key
IL_0006: ldc.i4 304
IL_000b: beq.s IL_001b
IL_000d: ldarg.0
IL_000e: ldfld UnityEngine.KeyCode viperOSK.OSK_Key::key
IL_0013: ldc.i4 303
IL_0018: ceq
IL_001a: ret
IL_001b: ldc.i4.1
IL_001c: ret
METHOD System.Void viperOSK.OSK_Key_TFOL::.ctor() | attributes=Public, HideBySig, SpecialName, RTSpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: newobj System.Void UnityEngine.Events.UnityEvent::.ctor()
IL_0006: stfld UnityEngine.Events.UnityEvent viperOSK.OSK_Key_TFOL::onClickShiftKey
IL_000b: ldarg.0
IL_000c: call System.Void viperOSK.OSK_Key::.ctor()
IL_0011: ret
