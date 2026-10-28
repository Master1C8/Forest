TYPE viperOSK_Examples.Example4
METHOD System.Void viperOSK_Examples.Example4::Start() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldstr ""
IL_0006: stfld System.String viperOSK_Examples.Example4::username
IL_000b: ldarg.0
IL_000c: ldstr ""
IL_0011: stfld System.String viperOSK_Examples.Example4::password
IL_0016: ret
METHOD System.Void viperOSK_Examples.Example4::UsernameSubmit(System.String) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: brfalse.s IL_000b
IL_0003: ldarg.1
IL_0004: callvirt System.Int32 System.String::get_Length()
IL_0009: brtrue.s IL_000c
IL_000b: ret
IL_000c: ldarg.0
IL_000d: ldarg.1
IL_000e: stfld System.String viperOSK_Examples.Example4::username
IL_0013: ldarg.1
IL_0014: ldstr "switch"
IL_0019: ldc.i4.3
IL_001a: callvirt System.Boolean System.String::Equals(System.String,System.StringComparison)
IL_001f: brfalse.s IL_0049
IL_0021: call UnityEngine.SceneManagement.Scene UnityEngine.SceneManagement.SceneManager::GetActiveScene()
IL_0026: stloc.1
IL_0027: ldloca.s V_1
IL_0029: call System.Int32 UnityEngine.SceneManagement.Scene::get_buildIndex()
IL_002e: stloc.0
IL_002f: ldloc.0
IL_0030: call System.Int32 UnityEngine.SceneManagement.SceneManager::get_sceneCountInBuildSettings()
IL_0035: ldc.i4.1
IL_0036: sub
IL_0037: bge.s IL_0042
IL_0039: ldloc.0
IL_003a: ldc.i4.1
IL_003b: add
IL_003c: call System.Void UnityEngine.SceneManagement.SceneManager::LoadScene(System.Int32)
IL_0041: ret
IL_0042: ldc.i4.0
IL_0043: call System.Void UnityEngine.SceneManagement.SceneManager::LoadScene(System.Int32)
IL_0048: ret
IL_0049: ldarg.0
IL_004a: call System.Void viperOSK_Examples.Example4::TabKey()
IL_004f: ret
METHOD System.Void viperOSK_Examples.Example4::PasswordSubmit(System.String) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: brfalse.s IL_000b
IL_0003: ldarg.1
IL_0004: callvirt System.Int32 System.String::get_Length()
IL_0009: brtrue.s IL_000c
IL_000b: ret
IL_000c: ldarg.0
IL_000d: ldarg.1
IL_000e: stfld System.String viperOSK_Examples.Example4::password
IL_0013: ldarg.0
IL_0014: ldfld System.Collections.Generic.List`1<viperOSK.OSK_Receiver> viperOSK_Examples.Example4::inputFields
IL_0019: ldc.i4.0
IL_001a: callvirt !0 System.Collections.Generic.List`1<viperOSK.OSK_Receiver>::get_Item(System.Int32)
IL_001f: callvirt System.String viperOSK.OSK_Receiver::Text()
IL_0024: callvirt System.Int32 System.String::get_Length()
IL_0029: brtrue.s IL_003c
IL_002b: ldarg.0
IL_002c: ldfld TMPro.TextMeshPro viperOSK_Examples.Example4::usernameTMP
IL_0031: ldstr "[missing username]"
IL_0036: callvirt System.Void TMPro.TMP_Text::set_text(System.String)
IL_003b: ret
IL_003c: ldarg.0
IL_003d: ldarg.0
IL_003e: ldfld System.Collections.Generic.List`1<viperOSK.OSK_Receiver> viperOSK_Examples.Example4::inputFields
IL_0043: ldc.i4.0
IL_0044: callvirt !0 System.Collections.Generic.List`1<viperOSK.OSK_Receiver>::get_Item(System.Int32)
IL_0049: callvirt System.String viperOSK.OSK_Receiver::Text()
IL_004e: stfld System.String viperOSK_Examples.Example4::username
IL_0053: ldarg.0
IL_0054: ldfld TMPro.TextMeshPro viperOSK_Examples.Example4::usernameTMP
IL_0059: ldarg.0
IL_005a: ldfld System.String viperOSK_Examples.Example4::username
IL_005f: callvirt System.Void TMPro.TMP_Text::set_text(System.String)
IL_0064: ldarg.0
IL_0065: ldfld TMPro.TextMeshPro viperOSK_Examples.Example4::pwdTMP
IL_006a: ldarg.0
IL_006b: ldfld System.String viperOSK_Examples.Example4::password
IL_0070: callvirt System.Void TMPro.TMP_Text::set_text(System.String)
IL_0075: ldarg.0
IL_0076: ldfld System.Collections.Generic.List`1<viperOSK.OSK_Receiver> viperOSK_Examples.Example4::inputFields
IL_007b: ldc.i4.0
IL_007c: callvirt !0 System.Collections.Generic.List`1<viperOSK.OSK_Receiver>::get_Item(System.Int32)
IL_0081: callvirt System.Void viperOSK.OSK_Receiver::ClearText()
IL_0086: ldarg.0
IL_0087: ldfld System.Collections.Generic.List`1<viperOSK.OSK_Receiver> viperOSK_Examples.Example4::inputFields
IL_008c: ldc.i4.1
IL_008d: callvirt !0 System.Collections.Generic.List`1<viperOSK.OSK_Receiver>::get_Item(System.Int32)
IL_0092: callvirt System.Void viperOSK.OSK_Receiver::ClearText()
IL_0097: ldarg.0
IL_0098: call System.Void viperOSK_Examples.Example4::TabKey()
IL_009d: ldarg.0
IL_009e: ldstr "Cleanup"
IL_00a3: ldc.r4 10
IL_00a8: call System.Void UnityEngine.MonoBehaviour::Invoke(System.String,System.Single)
IL_00ad: ret
