TYPE viperOSK_Examples.Example2
METHOD System.Void viperOSK_Examples.Example2::Submit(System.String) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: ldstr "switch"
IL_0006: ldc.i4.3
IL_0007: callvirt System.Boolean System.String::Equals(System.String,System.StringComparison)
IL_000c: brfalse.s IL_005e
IL_000e: call UnityEngine.SceneManagement.Scene UnityEngine.SceneManagement.SceneManager::GetActiveScene()
IL_0013: stloc.1
IL_0014: ldloca.s V_1
IL_0016: call System.Int32 UnityEngine.SceneManagement.Scene::get_buildIndex()
IL_001b: stloc.0
IL_001c: ldstr "current scene = "
IL_0021: ldloca.s V_0
IL_0023: call System.String System.Int32::ToString()
IL_0028: ldstr " / "
IL_002d: call System.Int32 UnityEngine.SceneManagement.SceneManager::get_sceneCountInBuildSettings()
IL_0032: stloc.2
IL_0033: ldloca.s V_2
IL_0035: call System.String System.Int32::ToString()
IL_003a: call System.String System.String::Concat(System.String,System.String,System.String,System.String)
IL_003f: call System.Void UnityEngine.Debug::Log(System.Object)
IL_0044: ldloc.0
IL_0045: call System.Int32 UnityEngine.SceneManagement.SceneManager::get_sceneCountInBuildSettings()
IL_004a: ldc.i4.1
IL_004b: sub
IL_004c: bge.s IL_0057
IL_004e: ldloc.0
IL_004f: ldc.i4.1
IL_0050: add
IL_0051: call System.Void UnityEngine.SceneManagement.SceneManager::LoadScene(System.Int32)
IL_0056: ret
IL_0057: ldc.i4.0
IL_0058: call System.Void UnityEngine.SceneManagement.SceneManager::LoadScene(System.Int32)
IL_005d: ret
IL_005e: ldarg.1
IL_005f: call System.Void UnityEngine.Debug::Log(System.Object)
IL_0064: ldarg.0
IL_0065: ldfld TMPro.TextMeshPro viperOSK_Examples.Example2::mySpeech
IL_006a: ldarg.1
IL_006b: ldstr "<-"
IL_0070: call System.String System.String::Concat(System.String,System.String)
IL_0075: callvirt System.Void TMPro.TMP_Text::set_text(System.String)
IL_007a: ldarg.0
IL_007b: ldfld UnityEngine.SpriteRenderer viperOSK_Examples.Example2::mySpeechBubble
IL_0080: call UnityEngine.Color UnityEngine.Color::get_cyan()
IL_0085: callvirt System.Void UnityEngine.SpriteRenderer::set_color(UnityEngine.Color)
IL_008a: ldarg.1
IL_008b: callvirt System.String System.String::ToLowerInvariant()
IL_0090: ldstr "hello"
IL_0095: callvirt System.Boolean System.String::Contains(System.String)
IL_009a: brtrue.s IL_00ae
IL_009c: ldarg.1
IL_009d: callvirt System.String System.String::ToLower()
IL_00a2: ldstr "hi"
IL_00a7: callvirt System.Boolean System.String::Contains(System.String)
IL_00ac: brfalse.s IL_00c0
IL_00ae: ldarg.0
IL_00af: ldfld TMPro.TextMeshPro viperOSK_Examples.Example2::NPCSpeech
IL_00b4: ldstr "Hi friend"
IL_00b9: callvirt System.Void TMPro.TMP_Text::set_text(System.String)
IL_00be: br.s IL_00d0
IL_00c0: ldarg.0
IL_00c1: ldfld TMPro.TextMeshPro viperOSK_Examples.Example2::NPCSpeech
IL_00c6: ldstr "Aha"
IL_00cb: callvirt System.Void TMPro.TMP_Text::set_text(System.String)
IL_00d0: ldarg.0
IL_00d1: ldfld viperOSK.OSK_Keyboard viperOSK_Examples.Example2::keyboard
IL_00d6: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_00db: ldc.i4.0
IL_00dc: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_00e1: ldarg.0
IL_00e2: ldstr "Clear"
IL_00e7: ldc.r4 5
IL_00ec: call System.Void UnityEngine.MonoBehaviour::Invoke(System.String,System.Single)
IL_00f1: ldarg.0
IL_00f2: call UnityEngine.Camera UnityEngine.Camera::get_main()
IL_00f7: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_00fc: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_0101: callvirt UnityEngine.Vector3 UnityEngine.Transform::get_position()
IL_0106: stfld UnityEngine.Vector3 viperOSK_Examples.Example2::current
IL_010b: ldarg.0
IL_010c: ldarg.0
IL_010d: ldfld UnityEngine.Vector3 viperOSK_Examples.Example2::current
IL_0112: ldc.r4 0
IL_0117: ldc.r4 3.5
IL_011c: ldc.r4 0
IL_0121: newobj System.Void UnityEngine.Vector3::.ctor(System.Single,System.Single,System.Single)
IL_0126: call UnityEngine.Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)
IL_012b: stfld UnityEngine.Vector3 viperOSK_Examples.Example2::target
IL_0130: ldarg.0
IL_0131: ldc.i4.1
IL_0132: stfld System.Boolean viperOSK_Examples.Example2::contextShift
IL_0137: ldarg.0
IL_0138: ldc.r4 0
IL_013d: stfld System.Single viperOSK_Examples.Example2::t
IL_0142: ret
