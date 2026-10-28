TYPE viperOSK.OSK_UI_Keyboard
METHOD System.Void viperOSK.OSK_UI_Keyboard::OutputTextUpdate(System.String) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0006: callvirt System.Boolean UnityEngine.GameObject::get_activeSelf()
IL_000b: brfalse.s IL_0062
IL_000d: ldarg.0
IL_000e: ldfld viperOSK.OSK_Receiver viperOSK.OSK_UI_Keyboard::output
IL_0013: ldnull
IL_0014: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0019: brfalse.s IL_0062
IL_001b: ldarg.1
IL_001c: ldstr ""
IL_0021: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0026: brfalse.s IL_0034
IL_0028: ldarg.0
IL_0029: ldfld viperOSK.OSK_Receiver viperOSK.OSK_UI_Keyboard::output
IL_002e: callvirt System.Void viperOSK.OSK_Receiver::Backspace()
IL_0033: ret
IL_0034: ldarg.1
IL_0035: ldstr ""
IL_003a: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_003f: brfalse.s IL_004d
IL_0041: ldarg.0
IL_0042: ldfld viperOSK.OSK_Receiver viperOSK.OSK_UI_Keyboard::output
IL_0047: callvirt System.Void viperOSK.OSK_Receiver::Del()
IL_004c: ret
IL_004d: ldarg.1
IL_004e: callvirt System.Int32 System.String::get_Length()
IL_0053: ldc.i4.0
IL_0054: ble.s IL_0062
IL_0056: ldarg.0
IL_0057: ldfld viperOSK.OSK_Receiver viperOSK.OSK_UI_Keyboard::output
IL_005c: ldarg.1
IL_005d: callvirt System.Void viperOSK.OSK_Receiver::AddText(System.String)
IL_0062: ret
