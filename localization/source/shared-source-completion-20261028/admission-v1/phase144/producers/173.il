TYPE viperOSK_Examples.Example3UI
METHOD System.Void viperOSK_Examples.Example3UI::OnSubmit(System.String) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: ldstr "switch"
IL_0006: ldc.i4.3
IL_0007: callvirt System.Boolean System.String::Equals(System.String,System.StringComparison)
IL_000c: brfalse.s IL_0036
IL_000e: call UnityEngine.SceneManagement.Scene UnityEngine.SceneManagement.SceneManager::GetActiveScene()
IL_0013: stloc.1
IL_0014: ldloca.s V_1
IL_0016: call System.Int32 UnityEngine.SceneManagement.Scene::get_buildIndex()
IL_001b: stloc.0
IL_001c: ldloc.0
IL_001d: call System.Int32 UnityEngine.SceneManagement.SceneManager::get_sceneCountInBuildSettings()
IL_0022: ldc.i4.1
IL_0023: sub
IL_0024: bge.s IL_002f
IL_0026: ldloc.0
IL_0027: ldc.i4.1
IL_0028: add
IL_0029: call System.Void UnityEngine.SceneManagement.SceneManager::LoadScene(System.Int32)
IL_002e: ret
IL_002f: ldc.i4.0
IL_0030: call System.Void UnityEngine.SceneManagement.SceneManager::LoadScene(System.Int32)
IL_0035: ret
IL_0036: ldarg.0
IL_0037: ldfld viperOSK.OSK_UI_Keyboard viperOSK_Examples.Example3UI::keyboard
IL_003c: ldfld viperOSK.OSK_Receiver viperOSK.OSK_UI_Keyboard::output
IL_0041: callvirt System.String UnityEngine.Object::get_name()
IL_0046: ldstr "UI_Input_Text"
IL_004b: callvirt System.Boolean System.String::Equals(System.String)
IL_0050: brfalse.s IL_005e
IL_0052: ldarg.0
IL_0053: ldfld TMPro.TMP_Text viperOSK_Examples.Example3UI::output1
IL_0058: ldarg.1
IL_0059: callvirt System.Void TMPro.TMP_Text::set_text(System.String)
IL_005e: ldarg.0
IL_005f: ldfld viperOSK.OSK_UI_Keyboard viperOSK_Examples.Example3UI::keyboard
IL_0064: ldfld viperOSK.OSK_Receiver viperOSK.OSK_UI_Keyboard::output
IL_0069: callvirt System.String UnityEngine.Object::get_name()
IL_006e: ldstr "OSK_InputField (TMP)"
IL_0073: callvirt System.Boolean System.String::Equals(System.String)
IL_0078: brfalse.s IL_0086
IL_007a: ldarg.0
IL_007b: ldfld TMPro.TMP_Text viperOSK_Examples.Example3UI::output2
IL_0080: ldarg.1
IL_0081: callvirt System.Void TMPro.TMP_Text::set_text(System.String)
IL_0086: ldarg.0
IL_0087: ldfld viperOSK.OSK_UI_Keyboard viperOSK_Examples.Example3UI::keyboard
IL_008c: ldfld viperOSK.OSK_Receiver viperOSK.OSK_UI_Keyboard::output
IL_0091: callvirt System.String UnityEngine.Object::get_name()
IL_0096: ldstr "OSK_InputField"
IL_009b: callvirt System.Boolean System.String::Equals(System.String)
IL_00a0: brfalse.s IL_00ae
IL_00a2: ldarg.0
IL_00a3: ldfld TMPro.TMP_Text viperOSK_Examples.Example3UI::output3
IL_00a8: ldarg.1
IL_00a9: callvirt System.Void TMPro.TMP_Text::set_text(System.String)
IL_00ae: ldarg.0
IL_00af: call System.Void viperOSK_Examples.Example3UI::RandomizeCubeRotation()
IL_00b4: ret
METHOD System.Void viperOSK_Examples.Example3UI::Hello() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld viperOSK.OSK_Receiver viperOSK_Examples.Example3UI::field
IL_0006: ldstr "HELLO123"
IL_000b: callvirt System.Void viperOSK.OSK_Receiver::SetText(System.String)
IL_0010: ldstr "HELLO"
IL_0015: call System.Void UnityEngine.Debug::Log(System.Object)
IL_001a: ret
