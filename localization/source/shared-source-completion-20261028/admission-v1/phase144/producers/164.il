TYPE viperOSK.OSK_Keyboard_TFOL
METHOD System.Void viperOSK.OSK_Keyboard_TFOL::PressShiftKeys() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void viperOSK.OSK_Keyboard_TFOL::ShiftUp()
IL_0006: ldarg.0
IL_0007: ldfld System.Collections.Generic.Dictionary`2<UnityEngine.KeyCode,viperOSK.OSK_Key_TFOL> viperOSK.OSK_Keyboard_TFOL::keyDictTfolMirror
IL_000c: ldc.i4 304
IL_0011: callvirt System.Boolean System.Collections.Generic.Dictionary`2<UnityEngine.KeyCode,viperOSK.OSK_Key_TFOL>::ContainsKey(!0)
IL_0016: brfalse.s IL_0051
IL_0018: ldarg.0
IL_0019: ldfld System.Collections.Generic.Dictionary`2<UnityEngine.KeyCode,viperOSK.OSK_Key_TFOL> viperOSK.OSK_Keyboard_TFOL::keyDictTfolMirror
IL_001e: ldc.i4 304
IL_0023: callvirt !1 System.Collections.Generic.Dictionary`2<UnityEngine.KeyCode,viperOSK.OSK_Key_TFOL>::get_Item(!0)
IL_0028: callvirt System.Void viperOSK.OSK_Key_TFOL::Press()
IL_002d: ldarg.0
IL_002e: ldfld System.Collections.Generic.Dictionary`2<UnityEngine.KeyCode,viperOSK.OSK_Key_TFOL> viperOSK.OSK_Keyboard_TFOL::keyDictTfolMirror
IL_0033: ldc.i4 304
IL_0038: callvirt !1 System.Collections.Generic.Dictionary`2<UnityEngine.KeyCode,viperOSK.OSK_Key_TFOL>::get_Item(!0)
IL_003d: ldsfld System.Boolean viperOSK.OSK_Keyboard_TFOL::caps
IL_0042: brtrue.s IL_0047
IL_0044: ldnull
IL_0045: br.s IL_004c
IL_0047: ldstr "CAPS"
IL_004c: callvirt System.Void viperOSK.OSK_Key_TFOL::Relabel(System.String)
IL_0051: ldarg.0
IL_0052: ldfld System.Collections.Generic.Dictionary`2<UnityEngine.KeyCode,viperOSK.OSK_Key_TFOL> viperOSK.OSK_Keyboard_TFOL::keyDictTfolMirror
IL_0057: ldc.i4 303
IL_005c: callvirt System.Boolean System.Collections.Generic.Dictionary`2<UnityEngine.KeyCode,viperOSK.OSK_Key_TFOL>::ContainsKey(!0)
IL_0061: brfalse.s IL_009c
IL_0063: ldarg.0
IL_0064: ldfld System.Collections.Generic.Dictionary`2<UnityEngine.KeyCode,viperOSK.OSK_Key_TFOL> viperOSK.OSK_Keyboard_TFOL::keyDictTfolMirror
IL_0069: ldc.i4 303
IL_006e: callvirt !1 System.Collections.Generic.Dictionary`2<UnityEngine.KeyCode,viperOSK.OSK_Key_TFOL>::get_Item(!0)
IL_0073: callvirt System.Void viperOSK.OSK_Key_TFOL::Press()
IL_0078: ldarg.0
IL_0079: ldfld System.Collections.Generic.Dictionary`2<UnityEngine.KeyCode,viperOSK.OSK_Key_TFOL> viperOSK.OSK_Keyboard_TFOL::keyDictTfolMirror
IL_007e: ldc.i4 303
IL_0083: callvirt !1 System.Collections.Generic.Dictionary`2<UnityEngine.KeyCode,viperOSK.OSK_Key_TFOL>::get_Item(!0)
IL_0088: ldsfld System.Boolean viperOSK.OSK_Keyboard_TFOL::caps
IL_008d: brtrue.s IL_0092
IL_008f: ldnull
IL_0090: br.s IL_0097
IL_0092: ldstr "CAPS"
IL_0097: callvirt System.Void viperOSK.OSK_Key_TFOL::Relabel(System.String)
IL_009c: ret
METHOD System.Void viperOSK.OSK_Keyboard_TFOL::KeyNewline() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldstr "
"
IL_0006: call System.Void viperOSK.OSK_Keyboard::OutputTextUpdate(System.String)
IL_000b: ret
