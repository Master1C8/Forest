TYPE viperOSK_Examples.Example1
METHOD System.Void viperOSK_Examples.Example1::LoadEmailLayout() | attributes=Public, HideBySig | impl=IL
IL_0000: ldstr "1 2 3 4 5 6 7 8 9 0 
 Q W E R T Y U I O P 
 A S D F G H J K L " Skip.2 Backspace 
 CapsLock Z X C V B N M & 
 LeftShift # ' - _ @ . Skip.2 Return"
IL_0005: stloc.0
IL_0006: ldarg.0
IL_0007: ldfld System.Collections.Generic.List`1<viperOSK.OSK_Keyboard> viperOSK_Examples.Example1::keyboards
IL_000c: callvirt System.Int32 System.Collections.Generic.List`1<viperOSK.OSK_Keyboard>::get_Count()
IL_0011: ldc.i4.2
IL_0012: blt.s IL_0026
IL_0014: ldarg.0
IL_0015: ldfld System.Collections.Generic.List`1<viperOSK.OSK_Keyboard> viperOSK_Examples.Example1::keyboards
IL_001a: ldc.i4.1
IL_001b: callvirt !0 System.Collections.Generic.List`1<viperOSK.OSK_Keyboard>::get_Item(System.Int32)
IL_0020: ldloc.0
IL_0021: callvirt System.Void viperOSK.OSK_Keyboard::LoadLayout(System.String)
IL_0026: ret
METHOD System.Void viperOSK_Examples.Example1::SubmitText(System.String) | attributes=Public, HideBySig | impl=IL
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
IL_0036: ldstr "TEXT SUBMITTED: "
IL_003b: ldarg.1
IL_003c: call System.String System.String::Concat(System.String,System.String)
IL_0041: call System.Void UnityEngine.Debug::Log(System.Object)
IL_0046: ldarg.0
IL_0047: ldfld TMPro.TextMeshPro viperOSK_Examples.Example1::outputtext
IL_004c: ldarg.1
IL_004d: callvirt System.Void TMPro.TMP_Text::set_text(System.String)
IL_0052: ret
