TYPE viperOSK.OSK_Key
METHOD System.Void viperOSK.OSK_Key::Assign(UnityEngine.KeyCode,viperOSK.OSK_KEY_TYPES,System.String) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: stfld UnityEngine.KeyCode viperOSK.OSK_Key::key
IL_0007: ldarg.3
IL_0008: callvirt System.Int32 System.String::get_Length()
IL_000d: brtrue.s IL_002b
IL_000f: ldarg.0
IL_0010: ldfld TMPro.TextMeshPro viperOSK.OSK_Key::keyName
IL_0015: ldarg.0
IL_0016: ldfld UnityEngine.KeyCode viperOSK.OSK_Key::key
IL_001b: conv.u2
IL_001c: stloc.0
IL_001d: ldloca.s V_0
IL_001f: call System.String System.Char::ToString()
IL_0024: callvirt System.Void TMPro.TMP_Text::set_text(System.String)
IL_0029: br.s IL_0078
IL_002b: ldarg.0
IL_002c: ldfld TMPro.TextMeshPro viperOSK.OSK_Key::keyName
IL_0031: ldarg.3
IL_0032: callvirt System.Void TMPro.TMP_Text::set_text(System.String)
IL_0037: ldarg.0
IL_0038: call UnityEngine.Transform UnityEngine.Component::get_transform()
IL_003d: callvirt UnityEngine.Transform UnityEngine.Transform::get_parent()
IL_0042: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0047: callvirt System.String UnityEngine.Object::get_name()
IL_004c: ldstr "KeyBoard (2.1)"
IL_0051: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0056: brfalse.s IL_0078
IL_0058: ldstr "assignspecial key "
IL_005d: ldarg.0
IL_005e: ldfld TMPro.TextMeshPro viperOSK.OSK_Key::keyName
IL_0063: callvirt System.String TMPro.TMP_Text::get_text()
IL_0068: ldstr " from "
IL_006d: ldarg.3
IL_006e: call System.String System.String::Concat(System.String,System.String,System.String,System.String)
IL_0073: call System.Void UnityEngine.Debug::Log(System.Object)
IL_0078: ldarg.0
IL_0079: ldarg.2
IL_007a: stfld viperOSK.OSK_KEY_TYPES viperOSK.OSK_Key::keyType
IL_007f: ret
