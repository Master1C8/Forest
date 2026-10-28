TYPE viperOSK.OSK_Keyboard
METHOD System.Void viperOSK.OSK_Keyboard::LoadLayout(System.String) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: stfld System.String viperOSK.OSK_Keyboard::layout
IL_0007: ret
METHOD System.Void viperOSK.OSK_Keyboard::OutputTextUpdate(System.String) | attributes=Family, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0006: callvirt System.Boolean UnityEngine.GameObject::get_activeSelf()
IL_000b: brfalse.s IL_0019
IL_000d: ldarg.0
IL_000e: ldfld viperOSK.OSK_Receiver viperOSK.OSK_Keyboard::output
IL_0013: ldarg.1
IL_0014: callvirt System.Void viperOSK.OSK_Receiver::AddText(System.String)
IL_0019: ret
