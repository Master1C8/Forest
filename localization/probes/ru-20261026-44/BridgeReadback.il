TYPE ForestProbe
METHOD System.Boolean ForestProbe::GetKeyboardState(System.Byte[]) | attributes=Private, Static, HideBySig, PInvokeImpl | impl=PreserveSig
METHOD System.Int16 ForestProbe::GetAsyncKeyState(System.Int32) | attributes=Private, Static, HideBySig, PInvokeImpl | impl=PreserveSig
METHOD System.UInt32 ForestProbe::GetCurrentProcessId() | attributes=Private, Static, HideBySig, PInvokeImpl | impl=PreserveSig
METHOD System.Void ForestProbe::Install() | attributes=Public, Static, HideBySig | impl=IL
IL_0000: nop
IL_0001: ldstr "FOREST_STARTUP INSTALL_ENTER company="
IL_0006: call System.String UnityEngine.Application::get_companyName()
IL_000b: ldstr " product="
IL_0010: call System.String UnityEngine.Application::get_productName()
IL_0015: call System.String System.String::Concat(System.String,System.String,System.String,System.String)
IL_001a: call System.Void UnityEngine.Debug::Log(System.Object)
IL_001f: nop
IL_0020: call System.String UnityEngine.Application::get_companyName()
IL_0025: ldstr "VNRevivalQA"
IL_002a: call System.Boolean System.String::op_Inequality(System.String,System.String)
IL_002f: brtrue.s IL_0042
IL_0031: call System.String UnityEngine.Application::get_productName()
IL_0036: ldstr "ForestRuRendererProbe"
IL_003b: call System.Boolean System.String::op_Inequality(System.String,System.String)
IL_0040: br.s IL_0043
IL_0042: ldc.i4.1
IL_0043: stloc.1
IL_0044: ldloc.1
IL_0045: brfalse.s IL_0052
IL_0047: ldstr "QA bridge requires the isolated player identity."
IL_004c: newobj System.Void System.InvalidOperationException::.ctor(System.String)
IL_0051: throw
IL_0052: ldstr "FOREST_STARTUP IDENTITY_ACCEPTED"
IL_0057: call System.Void UnityEngine.Debug::Log(System.Object)
IL_005c: nop
IL_005d: ldstr "ForestRendererProbeBridge"
IL_0062: newobj System.Void UnityEngine.GameObject::.ctor(System.String)
IL_0067: stloc.0
IL_0068: ldloc.0
IL_0069: call System.Void UnityEngine.Object::DontDestroyOnLoad(UnityEngine.Object)
IL_006e: nop
IL_006f: ldstr "FOREST_STARTUP BEFORE_ADD_COMPONENT"
IL_0074: call System.Void UnityEngine.Debug::Log(System.Object)
IL_0079: nop
IL_007a: ldloc.0
IL_007b: callvirt !!0 UnityEngine.GameObject::AddComponent<ForestProbe>()
IL_0080: pop
IL_0081: ldstr "FOREST_STARTUP INSTALL_RETURN"
IL_0086: call System.Void UnityEngine.Debug::Log(System.Object)
IL_008b: nop
IL_008c: ret
METHOD System.Void ForestProbe::Awake() | attributes=Private, HideBySig | impl=IL
IL_0000: nop
IL_0001: ldstr "FOREST_STARTUP AWAKE_ENTER"
IL_0006: call System.Void UnityEngine.Debug::Log(System.Object)
IL_000b: nop
IL_000c: ldarg.0
IL_000d: call System.String UnityEngine.Application::get_dataPath()
IL_0012: ldstr "../.."
IL_0017: call System.String System.IO.Path::Combine(System.String,System.String)
IL_001c: call System.String System.IO.Path::GetFullPath(System.String)
IL_0021: stfld System.String ForestProbe::root
IL_0026: ldarg.0
IL_0027: call System.Single UnityEngine.Time::get_realtimeSinceStartup()
IL_002c: stfld System.Single ForestProbe::focusStarted
IL_0031: ldarg.0
IL_0032: ldftn System.Void ForestProbe::ObserveUnityFocusEvent(System.Boolean)
IL_0038: newobj System.Void System.Action`1<System.Boolean>::.ctor(System.Object,System.IntPtr)
IL_003d: call System.Void UnityEngine.Application::add_focusChanged(System.Action`1<System.Boolean>)
IL_0042: nop
IL_0043: ldarg.0
IL_0044: ldstr "awake"
IL_0049: ldstr "unknown"
IL_004e: call System.Void ForestProbe::ObserveFocus(System.String,System.String)
IL_0053: nop
IL_0054: ldstr "FOREST_PROBE_READY "
IL_0059: ldarg.0
IL_005a: ldfld System.String ForestProbe::root
IL_005f: ldstr " SAVES "
IL_0064: call System.String UnityEngine.Application::get_persistentDataPath()
IL_0069: call System.String System.String::Concat(System.String,System.String,System.String,System.String)
IL_006e: call System.Void UnityEngine.Debug::Log(System.Object)
IL_0073: nop
IL_0074: ret
METHOD System.String ForestProbe::Address(UnityEngine.Transform) | attributes=Private, Static, HideBySig | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: callvirt System.String UnityEngine.Object::get_name()
IL_0007: stloc.0
IL_0008: br.s IL_0026
IL_000a: nop
IL_000b: ldarg.0
IL_000c: callvirt UnityEngine.Transform UnityEngine.Transform::get_parent()
IL_0011: starg.s t
IL_0013: ldarg.0
IL_0014: callvirt System.String UnityEngine.Object::get_name()
IL_0019: ldstr "/"
IL_001e: ldloc.0
IL_001f: call System.String System.String::Concat(System.String,System.String,System.String)
IL_0024: stloc.0
IL_0025: nop
IL_0026: ldarg.0
IL_0027: callvirt UnityEngine.Transform UnityEngine.Transform::get_parent()
IL_002c: ldnull
IL_002d: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0032: stloc.1
IL_0033: ldloc.1
IL_0034: brtrue.s IL_000a
IL_0036: ldloc.0
IL_0037: stloc.2
IL_0038: br.s IL_003a
IL_003a: ldloc.2
IL_003b: ret
METHOD System.Void ForestProbe::Update() | attributes=Private, HideBySig | impl=IL
IL_0000: nop
IL_0001: call System.Single UnityEngine.Time::get_realtimeSinceStartup()
IL_0006: ldarg.0
IL_0007: ldfld System.Single ForestProbe::next
IL_000c: clt
IL_000e: stloc.2
IL_000f: ldloc.2
IL_0010: brfalse.s IL_0017
IL_0012: br IL_0e5f
IL_0017: ldarg.0
IL_0018: call System.Single UnityEngine.Time::get_realtimeSinceStartup()
IL_001d: ldc.r4 0.2
IL_0022: add
IL_0023: stfld System.Single ForestProbe::next
IL_0028: ldarg.0
IL_0029: ldfld System.String ForestProbe::root
IL_002e: ldstr "command.txt"
IL_0033: call System.String System.IO.Path::Combine(System.String,System.String)
IL_0038: stloc.0
IL_0039: ldloc.0
IL_003a: call System.Boolean System.IO.File::Exists(System.String)
IL_003f: ldc.i4.0
IL_0040: ceq
IL_0042: stloc.3
IL_0043: ldloc.3
IL_0044: brfalse.s IL_004b
IL_0046: br IL_0e5f
IL_004b: ldloc.0
IL_004c: call System.String System.IO.File::ReadAllText(System.String)
IL_0051: callvirt System.String System.String::Trim()
IL_0056: stloc.1
IL_0057: ldloc.0
IL_0058: call System.Void System.IO.File::Delete(System.String)
IL_005d: nop
IL_005e: nop
IL_005f: ldloc.1
IL_0060: ldstr "dump-focus"
IL_0065: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_006a: stloc.s V_4
IL_006c: ldloc.s V_4
IL_006e: brfalse.s IL_0086
IL_0070: ldarg.0
IL_0071: ldstr "snapshot"
IL_0076: ldstr "unknown"
IL_007b: call System.Void ForestProbe::ObserveFocus(System.String,System.String)
IL_0080: nop
IL_0081: br IL_0db1
IL_0086: ldloc.1
IL_0087: ldstr "dump"
IL_008c: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0091: stloc.s V_5
IL_0093: ldloc.s V_5
IL_0095: brfalse.s IL_00a3
IL_0097: ldarg.0
IL_0098: call System.Void ForestProbe::Dump()
IL_009d: nop
IL_009e: br IL_0db1
IL_00a3: ldloc.1
IL_00a4: ldstr "dump-save-continuation"
IL_00a9: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_00ae: stloc.s V_6
IL_00b0: ldloc.s V_6
IL_00b2: brfalse.s IL_00c0
IL_00b4: ldarg.0
IL_00b5: call System.Void ForestProbe::DumpSaveContinuation()
IL_00ba: nop
IL_00bb: br IL_0db1
IL_00c0: ldloc.1
IL_00c1: ldstr "dump-intro"
IL_00c6: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_00cb: stloc.s V_7
IL_00cd: ldloc.s V_7
IL_00cf: brfalse.s IL_00dd
IL_00d1: ldarg.0
IL_00d2: call System.Void ForestProbe::DumpIntro()
IL_00d7: nop
IL_00d8: br IL_0db1
IL_00dd: ldloc.1
IL_00de: ldstr "dump-notebook"
IL_00e3: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_00e8: stloc.s V_8
IL_00ea: ldloc.s V_8
IL_00ec: brfalse.s IL_0166
IL_00ee: nop
IL_00ef: newobj System.Void ForestProbe/NotebookRouteState::.ctor()
IL_00f4: dup
IL_00f5: call UnityEngine.SceneManagement.Scene UnityEngine.SceneManagement.SceneManager::GetActiveScene()
IL_00fa: stloc.s V_10
IL_00fc: ldloca.s V_10
IL_00fe: call System.String UnityEngine.SceneManagement.Scene::get_name()
IL_0103: stfld System.String ForestProbe/NotebookRouteState::scene
IL_0108: dup
IL_0109: call System.String UnityEngine.Application::get_companyName()
IL_010e: stfld System.String ForestProbe/NotebookRouteState::company
IL_0113: dup
IL_0114: call System.String UnityEngine.Application::get_productName()
IL_0119: stfld System.String ForestProbe/NotebookRouteState::product
IL_011e: dup
IL_011f: call System.String UnityEngine.Application::get_dataPath()
IL_0124: stfld System.String ForestProbe/NotebookRouteState::dataPath
IL_0129: dup
IL_012a: call System.String UnityEngine.Application::get_persistentDataPath()
IL_012f: stfld System.String ForestProbe/NotebookRouteState::persistentDataPath
IL_0134: dup
IL_0135: ldarg.0
IL_0136: call System.String[] ForestProbe::NotebookRouteDiagnostics()
IL_013b: stfld System.String[] ForestProbe/NotebookRouteState::diagnostics
IL_0140: stloc.s V_9
IL_0142: ldarg.0
IL_0143: ldfld System.String ForestProbe::root
IL_0148: ldstr "notebook-route.json"
IL_014d: call System.String System.IO.Path::Combine(System.String,System.String)
IL_0152: ldloc.s V_9
IL_0154: ldc.i4.1
IL_0155: call System.String UnityEngine.JsonUtility::ToJson(System.Object,System.Boolean)
IL_015a: call System.Void System.IO.File::WriteAllText(System.String,System.String)
IL_015f: nop
IL_0160: nop
IL_0161: br IL_0db1
IL_0166: ldloc.1
IL_0167: ldstr "dump-tutorial"
IL_016c: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0171: stloc.s V_11
IL_0173: ldloc.s V_11
IL_0175: brfalse.s IL_01ef
IL_0177: nop
IL_0178: newobj System.Void ForestProbe/NotebookRouteState::.ctor()
IL_017d: dup
IL_017e: call UnityEngine.SceneManagement.Scene UnityEngine.SceneManagement.SceneManager::GetActiveScene()
IL_0183: stloc.s V_10
IL_0185: ldloca.s V_10
IL_0187: call System.String UnityEngine.SceneManagement.Scene::get_name()
IL_018c: stfld System.String ForestProbe/NotebookRouteState::scene
IL_0191: dup
IL_0192: call System.String UnityEngine.Application::get_companyName()
IL_0197: stfld System.String ForestProbe/NotebookRouteState::company
IL_019c: dup
IL_019d: call System.String UnityEngine.Application::get_productName()
IL_01a2: stfld System.String ForestProbe/NotebookRouteState::product
IL_01a7: dup
IL_01a8: call System.String UnityEngine.Application::get_dataPath()
IL_01ad: stfld System.String ForestProbe/NotebookRouteState::dataPath
IL_01b2: dup
IL_01b3: call System.String UnityEngine.Application::get_persistentDataPath()
IL_01b8: stfld System.String ForestProbe/NotebookRouteState::persistentDataPath
IL_01bd: dup
IL_01be: ldarg.0
IL_01bf: call System.String[] ForestProbe::TutorialRouteDiagnostics()
IL_01c4: stfld System.String[] ForestProbe/NotebookRouteState::diagnostics
IL_01c9: stloc.s V_12
IL_01cb: ldarg.0
IL_01cc: ldfld System.String ForestProbe::root
IL_01d1: ldstr "tutorial-route.json"
IL_01d6: call System.String System.IO.Path::Combine(System.String,System.String)
IL_01db: ldloc.s V_12
IL_01dd: ldc.i4.1
IL_01de: call System.String UnityEngine.JsonUtility::ToJson(System.Object,System.Boolean)
IL_01e3: call System.Void System.IO.File::WriteAllText(System.String,System.String)
IL_01e8: nop
IL_01e9: nop
IL_01ea: br IL_0db1
IL_01ef: ldloc.1
IL_01f0: ldstr "dump-travel"
IL_01f5: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_01fa: stloc.s V_13
IL_01fc: ldloc.s V_13
IL_01fe: brfalse.s IL_0278
IL_0200: nop
IL_0201: newobj System.Void ForestProbe/NotebookRouteState::.ctor()
IL_0206: dup
IL_0207: call UnityEngine.SceneManagement.Scene UnityEngine.SceneManagement.SceneManager::GetActiveScene()
IL_020c: stloc.s V_10
IL_020e: ldloca.s V_10
IL_0210: call System.String UnityEngine.SceneManagement.Scene::get_name()
IL_0215: stfld System.String ForestProbe/NotebookRouteState::scene
IL_021a: dup
IL_021b: call System.String UnityEngine.Application::get_companyName()
IL_0220: stfld System.String ForestProbe/NotebookRouteState::company
IL_0225: dup
IL_0226: call System.String UnityEngine.Application::get_productName()
IL_022b: stfld System.String ForestProbe/NotebookRouteState::product
IL_0230: dup
IL_0231: call System.String UnityEngine.Application::get_dataPath()
IL_0236: stfld System.String ForestProbe/NotebookRouteState::dataPath
IL_023b: dup
IL_023c: call System.String UnityEngine.Application::get_persistentDataPath()
IL_0241: stfld System.String ForestProbe/NotebookRouteState::persistentDataPath
IL_0246: dup
IL_0247: ldarg.0
IL_0248: call System.String[] ForestProbe::TravelRouteDiagnostics()
IL_024d: stfld System.String[] ForestProbe/NotebookRouteState::diagnostics
IL_0252: stloc.s V_14
IL_0254: ldarg.0
IL_0255: ldfld System.String ForestProbe::root
IL_025a: ldstr "travel-route.json"
IL_025f: call System.String System.IO.Path::Combine(System.String,System.String)
IL_0264: ldloc.s V_14
IL_0266: ldc.i4.1
IL_0267: call System.String UnityEngine.JsonUtility::ToJson(System.Object,System.Boolean)
IL_026c: call System.Void System.IO.File::WriteAllText(System.String,System.String)
IL_0271: nop
IL_0272: nop
IL_0273: br IL_0db1
IL_0278: ldloc.1
IL_0279: ldstr "qa-background-input"
IL_027e: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0283: stloc.s V_15
IL_0285: ldloc.s V_15
IL_0287: brfalse.s IL_02f5
IL_0289: nop
IL_028a: ldarg.0
IL_028b: ldflda System.Nullable`1<System.Boolean> ForestProbe::originalIgnoreUnfocused
IL_0290: call System.Boolean System.Nullable`1<System.Boolean>::get_HasValue()
IL_0295: brtrue.s IL_02a1
IL_0297: call System.Boolean Rewired.ReInput::get_isReady()
IL_029c: ldc.i4.0
IL_029d: ceq
IL_029f: br.s IL_02a2
IL_02a1: ldc.i4.1
IL_02a2: stloc.s V_16
IL_02a4: ldloc.s V_16
IL_02a6: brfalse.s IL_02b3
IL_02a8: ldstr "Background policy already changed or input not ready"
IL_02ad: newobj System.Void System.Exception::.ctor(System.String)
IL_02b2: throw
IL_02b3: ldarg.0
IL_02b4: call Rewired.ReInput/ConfigHelper Rewired.ReInput::get_configuration()
IL_02b9: callvirt System.Boolean Rewired.ReInput/ConfigHelper::get_ignoreInputWhenAppNotInFocus()
IL_02be: newobj System.Void System.Nullable`1<System.Boolean>::.ctor(!0)
IL_02c3: stfld System.Nullable`1<System.Boolean> ForestProbe::originalIgnoreUnfocused
IL_02c8: call Rewired.ReInput/ConfigHelper Rewired.ReInput::get_configuration()
IL_02cd: ldc.i4.0
IL_02ce: callvirt System.Void Rewired.ReInput/ConfigHelper::set_ignoreInputWhenAppNotInFocus(System.Boolean)
IL_02d3: nop
IL_02d4: call Rewired.ReInput/ConfigHelper Rewired.ReInput::get_configuration()
IL_02d9: callvirt System.Boolean Rewired.ReInput/ConfigHelper::get_ignoreInputWhenAppNotInFocus()
IL_02de: stloc.s V_17
IL_02e0: ldloc.s V_17
IL_02e2: brfalse.s IL_02ef
IL_02e4: ldstr "Public Rewired background policy did not apply"
IL_02e9: newobj System.Void System.Exception::.ctor(System.String)
IL_02ee: throw
IL_02ef: nop
IL_02f0: br IL_0db1
IL_02f5: ldloc.1
IL_02f6: ldstr "restore-input-policy"
IL_02fb: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0300: stloc.s V_18
IL_0302: ldloc.s V_18
IL_0304: brfalse.s IL_0312
IL_0306: ldarg.0
IL_0307: call System.Void ForestProbe::RestoreInputPolicy()
IL_030c: nop
IL_030d: br IL_0db1
IL_0312: ldloc.1
IL_0313: ldstr "sample-keyboard-start"
IL_0318: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_031d: stloc.s V_19
IL_031f: ldloc.s V_19
IL_0321: brfalse.s IL_0354
IL_0323: nop
IL_0324: ldarg.0
IL_0325: ldfld System.Boolean ForestProbe::samplingKeyboard
IL_032a: stloc.s V_20
IL_032c: ldloc.s V_20
IL_032e: brfalse.s IL_033b
IL_0330: ldstr "Keyboard sample already active"
IL_0335: newobj System.Void System.Exception::.ctor(System.String)
IL_033a: throw
IL_033b: ldarg.0
IL_033c: ldfld System.Collections.Generic.List`1<System.String> ForestProbe::keyboardSamples
IL_0341: callvirt System.Void System.Collections.Generic.List`1<System.String>::Clear()
IL_0346: nop
IL_0347: ldarg.0
IL_0348: ldc.i4.1
IL_0349: stfld System.Boolean ForestProbe::samplingKeyboard
IL_034e: nop
IL_034f: br IL_0db1
IL_0354: ldloc.1
IL_0355: ldstr "sample-keyboard-stop"
IL_035a: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_035f: stloc.s V_21
IL_0361: ldloc.s V_21
IL_0363: brfalse.s IL_03ae
IL_0365: nop
IL_0366: ldarg.0
IL_0367: ldfld System.Boolean ForestProbe::samplingKeyboard
IL_036c: ldc.i4.0
IL_036d: ceq
IL_036f: stloc.s V_22
IL_0371: ldloc.s V_22
IL_0373: brfalse.s IL_0380
IL_0375: ldstr "No active keyboard sample"
IL_037a: newobj System.Void System.Exception::.ctor(System.String)
IL_037f: throw
IL_0380: ldarg.0
IL_0381: ldc.i4.0
IL_0382: stfld System.Boolean ForestProbe::samplingKeyboard
IL_0387: ldarg.0
IL_0388: ldfld System.String ForestProbe::root
IL_038d: ldstr "keyboard-samples.txt"
IL_0392: call System.String System.IO.Path::Combine(System.String,System.String)
IL_0397: ldarg.0
IL_0398: ldfld System.Collections.Generic.List`1<System.String> ForestProbe::keyboardSamples
IL_039d: callvirt !0[] System.Collections.Generic.List`1<System.String>::ToArray()
IL_03a2: call System.Void System.IO.File::WriteAllLines(System.String,System.String[])
IL_03a7: nop
IL_03a8: nop
IL_03a9: br IL_0db1
IL_03ae: ldloc.1
IL_03af: ldstr "sample-keyboard-snapshot"
IL_03b4: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_03b9: stloc.s V_23
IL_03bb: ldloc.s V_23
IL_03bd: brfalse.s IL_0401
IL_03bf: nop
IL_03c0: ldarg.0
IL_03c1: ldfld System.Boolean ForestProbe::samplingKeyboard
IL_03c6: ldc.i4.0
IL_03c7: ceq
IL_03c9: stloc.s V_24
IL_03cb: ldloc.s V_24
IL_03cd: brfalse.s IL_03da
IL_03cf: ldstr "No active keyboard sample"
IL_03d4: newobj System.Void System.Exception::.ctor(System.String)
IL_03d9: throw
IL_03da: ldarg.0
IL_03db: ldfld System.String ForestProbe::root
IL_03e0: ldstr "keyboard-samples.txt"
IL_03e5: call System.String System.IO.Path::Combine(System.String,System.String)
IL_03ea: ldarg.0
IL_03eb: ldfld System.Collections.Generic.List`1<System.String> ForestProbe::keyboardSamples
IL_03f0: callvirt !0[] System.Collections.Generic.List`1<System.String>::ToArray()
IL_03f5: call System.Void System.IO.File::WriteAllLines(System.String,System.String[])
IL_03fa: nop
IL_03fb: nop
IL_03fc: br IL_0db1
IL_0401: ldloc.1
IL_0402: ldstr "quit"
IL_0407: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_040c: stloc.s V_25
IL_040e: ldloc.s V_25
IL_0410: brfalse.s IL_0426
IL_0412: nop
IL_0413: ldarg.0
IL_0414: call System.Void ForestProbe::RestoreInputPolicy()
IL_0419: nop
IL_041a: call System.Void UnityEngine.Application::Quit()
IL_041f: nop
IL_0420: nop
IL_0421: br IL_0db1
IL_0426: ldloc.1
IL_0427: ldstr "show-menu"
IL_042c: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0431: stloc.s V_26
IL_0433: ldloc.s V_26
IL_0435: brfalse.s IL_047a
IL_0437: nop
IL_0438: call !!0 UnityEngine.Object::FindObjectOfType<TheForestOfLove.MainMenuController>()
IL_043d: stloc.s V_27
IL_043f: ldloc.s V_27
IL_0441: ldnull
IL_0442: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0447: stloc.s V_28
IL_0449: ldloc.s V_28
IL_044b: brfalse.s IL_0458
IL_044d: ldstr "Main menu controller not active"
IL_0452: newobj System.Void System.Exception::.ctor(System.String)
IL_0457: throw
IL_0458: ldloc.s V_27
IL_045a: callvirt System.Type System.Object::GetType()
IL_045f: ldstr "FinishShowingMenu"
IL_0464: ldc.i4.s 36
IL_0466: callvirt System.Reflection.MethodInfo System.Type::GetMethod(System.String,System.Reflection.BindingFlags)
IL_046b: ldloc.s V_27
IL_046d: ldnull
IL_046e: callvirt System.Object System.Reflection.MethodBase::Invoke(System.Object,System.Object[])
IL_0473: pop
IL_0474: nop
IL_0475: br IL_0db1
IL_047a: ldloc.1
IL_047b: ldstr "continue-bound "
IL_0480: callvirt System.Boolean System.String::StartsWith(System.String)
IL_0485: stloc.s V_29
IL_0487: ldloc.s V_29
IL_0489: brfalse IL_05b6
IL_048e: nop
IL_048f: ldloc.1
IL_0490: ldc.i4.s 15
IL_0492: callvirt System.String System.String::Substring(System.Int32)
IL_0497: ldc.i4.1
IL_0498: newarr System.Char
IL_049d: dup
IL_049e: ldc.i4.0
IL_049f: ldc.i4.s 32
IL_04a1: stelem.i2
IL_04a2: callvirt System.String[] System.String::Split(System.Char[])
IL_04a7: stloc.s V_30
IL_04a9: ldloc.s V_30
IL_04ab: ldlen
IL_04ac: conv.i4
IL_04ad: ldc.i4.2
IL_04ae: ceq
IL_04b0: ldc.i4.0
IL_04b1: ceq
IL_04b3: stloc.s V_37
IL_04b5: ldloc.s V_37
IL_04b7: brfalse.s IL_04c4
IL_04b9: ldstr "Expected conversation and source entry"
IL_04be: newobj System.Void System.Exception::.ctor(System.String)
IL_04c3: throw
IL_04c4: ldloc.s V_30
IL_04c6: ldc.i4.0
IL_04c7: ldelem.ref
IL_04c8: call System.Int32 System.Int32::Parse(System.String)
IL_04cd: stloc.s V_31
IL_04cf: ldloc.s V_30
IL_04d1: ldc.i4.1
IL_04d2: ldelem.ref
IL_04d3: call System.Int32 System.Int32::Parse(System.String)
IL_04d8: stloc.s V_32
IL_04da: call PixelCrushers.DialogueSystem.ConversationState PixelCrushers.DialogueSystem.DialogueManager::get_currentConversationState()
IL_04df: stloc.s V_33
IL_04e1: ldloc.s V_33
IL_04e3: brfalse.s IL_04fc
IL_04e5: ldloc.s V_33
IL_04e7: ldfld PixelCrushers.DialogueSystem.Subtitle PixelCrushers.DialogueSystem.ConversationState::subtitle
IL_04ec: brfalse.s IL_04fc
IL_04ee: ldloc.s V_33
IL_04f0: ldfld PixelCrushers.DialogueSystem.Subtitle PixelCrushers.DialogueSystem.ConversationState::subtitle
IL_04f5: ldfld PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Subtitle::dialogueEntry
IL_04fa: br.s IL_04fd
IL_04fc: ldnull
IL_04fd: stloc.s V_34
IL_04ff: newobj System.Void ForestProbe/ContinueReceipt::.ctor()
IL_0504: dup
IL_0505: call System.Boolean PixelCrushers.DialogueSystem.DialogueManager::get_isConversationActive()
IL_050a: stfld System.Boolean ForestProbe/ContinueReceipt::active
IL_050f: dup
IL_0510: ldloc.s V_31
IL_0512: stfld System.Int32 ForestProbe/ContinueReceipt::expectedConversationId
IL_0517: dup
IL_0518: ldloc.s V_32
IL_051a: stfld System.Int32 ForestProbe/ContinueReceipt::expectedEntryId
IL_051f: dup
IL_0520: ldloc.s V_34
IL_0522: brfalse.s IL_052d
IL_0524: ldloc.s V_34
IL_0526: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::conversationID
IL_052b: br.s IL_052e
IL_052d: ldc.i4.m1
IL_052e: stfld System.Int32 ForestProbe/ContinueReceipt::actualConversationId
IL_0533: dup
IL_0534: ldloc.s V_34
IL_0536: brfalse.s IL_0541
IL_0538: ldloc.s V_34
IL_053a: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_053f: br.s IL_0542
IL_0541: ldc.i4.m1
IL_0542: stfld System.Int32 ForestProbe/ContinueReceipt::actualEntryId
IL_0547: stloc.s V_35
IL_0549: ldloc.s V_35
IL_054b: ldfld System.Boolean ForestProbe/ContinueReceipt::active
IL_0550: brfalse.s IL_056a
IL_0552: ldloc.s V_35
IL_0554: ldfld System.Int32 ForestProbe/ContinueReceipt::actualConversationId
IL_0559: ldloc.s V_31
IL_055b: bne.un.s IL_056a
IL_055d: ldloc.s V_35
IL_055f: ldfld System.Int32 ForestProbe/ContinueReceipt::actualEntryId
IL_0564: ldloc.s V_32
IL_0566: ceq
IL_0568: br.s IL_056b
IL_056a: ldc.i4.0
IL_056b: stloc.s V_36
IL_056d: ldloc.s V_36
IL_056f: stloc.s V_38
IL_0571: ldloc.s V_38
IL_0573: brfalse.s IL_057b
IL_0575: call System.Void TheForestOfLove.CustomTypewriterEffectTextMeshPro::FastForwardTextOrAdvanceDialogue()
IL_057a: nop
IL_057b: ldloc.s V_35
IL_057d: ldloc.s V_36
IL_057f: brtrue.s IL_0588
IL_0581: ldstr "stale"
IL_0586: br.s IL_058d
IL_0588: ldstr "applied"
IL_058d: stfld System.String ForestProbe/ContinueReceipt::result
IL_0592: ldarg.0
IL_0593: ldfld System.String ForestProbe::root
IL_0598: ldstr "continue-receipt.json"
IL_059d: call System.String System.IO.Path::Combine(System.String,System.String)
IL_05a2: ldloc.s V_35
IL_05a4: ldc.i4.1
IL_05a5: call System.String UnityEngine.JsonUtility::ToJson(System.Object,System.Boolean)
IL_05aa: call System.Void System.IO.File::WriteAllText(System.String,System.String)
IL_05af: nop
IL_05b0: nop
IL_05b1: br IL_0db1
IL_05b6: ldloc.1
IL_05b7: ldstr "continue"
IL_05bc: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_05c1: stloc.s V_39
IL_05c3: ldloc.s V_39
IL_05c5: brfalse.s IL_05ed
IL_05c7: nop
IL_05c8: call System.Boolean PixelCrushers.DialogueSystem.DialogueManager::get_isConversationActive()
IL_05cd: ldc.i4.0
IL_05ce: ceq
IL_05d0: stloc.s V_40
IL_05d2: ldloc.s V_40
IL_05d4: brfalse.s IL_05e1
IL_05d6: ldstr "No active conversation"
IL_05db: newobj System.Void System.Exception::.ctor(System.String)
IL_05e0: throw
IL_05e1: call System.Void TheForestOfLove.CustomTypewriterEffectTextMeshPro::FastForwardTextOrAdvanceDialogue()
IL_05e6: nop
IL_05e7: nop
IL_05e8: br IL_0db1
IL_05ed: ldloc.1
IL_05ee: ldstr "response "
IL_05f3: callvirt System.Boolean System.String::StartsWith(System.String)
IL_05f8: stloc.s V_41
IL_05fa: ldloc.s V_41
IL_05fc: brfalse IL_07cd
IL_0601: nop
IL_0602: ldloc.1
IL_0603: ldc.i4.s 9
IL_0605: callvirt System.String System.String::Substring(System.Int32)
IL_060a: ldc.i4.1
IL_060b: newarr System.Char
IL_0610: dup
IL_0611: ldc.i4.0
IL_0612: ldc.i4.s 32
IL_0614: stelem.i2
IL_0615: callvirt System.String[] System.String::Split(System.Char[])
IL_061a: stloc.s V_42
IL_061c: ldloc.s V_42
IL_061e: ldlen
IL_061f: conv.i4
IL_0620: ldc.i4.3
IL_0621: ceq
IL_0623: ldc.i4.0
IL_0624: ceq
IL_0626: stloc.s V_48
IL_0628: ldloc.s V_48
IL_062a: brfalse.s IL_0637
IL_062c: ldstr "Expected source entry, conversation and destination entry"
IL_0631: newobj System.Void System.Exception::.ctor(System.String)
IL_0636: throw
IL_0637: ldloc.s V_42
IL_0639: ldc.i4.0
IL_063a: ldelem.ref
IL_063b: call System.Int32 System.Int32::Parse(System.String)
IL_0640: stloc.s V_43
IL_0642: ldloc.s V_42
IL_0644: ldc.i4.1
IL_0645: ldelem.ref
IL_0646: call System.Int32 System.Int32::Parse(System.String)
IL_064b: stloc.s V_44
IL_064d: ldloc.s V_42
IL_064f: ldc.i4.2
IL_0650: ldelem.ref
IL_0651: call System.Int32 System.Int32::Parse(System.String)
IL_0656: stloc.s V_45
IL_0658: call PixelCrushers.DialogueSystem.ConversationState PixelCrushers.DialogueSystem.DialogueManager::get_currentConversationState()
IL_065d: stloc.s V_46
IL_065f: call System.Boolean PixelCrushers.DialogueSystem.DialogueManager::get_isConversationActive()
IL_0664: brfalse.s IL_06b0
IL_0666: ldloc.s V_46
IL_0668: brfalse.s IL_06b0
IL_066a: ldloc.s V_46
IL_066c: ldfld PixelCrushers.DialogueSystem.Subtitle PixelCrushers.DialogueSystem.ConversationState::subtitle
IL_0671: brfalse.s IL_06b0
IL_0673: ldloc.s V_46
IL_0675: ldfld PixelCrushers.DialogueSystem.Subtitle PixelCrushers.DialogueSystem.ConversationState::subtitle
IL_067a: ldfld PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Subtitle::dialogueEntry
IL_067f: brfalse.s IL_06b0
IL_0681: ldloc.s V_46
IL_0683: ldfld PixelCrushers.DialogueSystem.Subtitle PixelCrushers.DialogueSystem.ConversationState::subtitle
IL_0688: ldfld PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Subtitle::dialogueEntry
IL_068d: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::conversationID
IL_0692: ldloc.s V_44
IL_0694: bne.un.s IL_06b0
IL_0696: ldloc.s V_46
IL_0698: ldfld PixelCrushers.DialogueSystem.Subtitle PixelCrushers.DialogueSystem.ConversationState::subtitle
IL_069d: ldfld PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Subtitle::dialogueEntry
IL_06a2: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_06a7: ldloc.s V_43
IL_06a9: ceq
IL_06ab: ldc.i4.0
IL_06ac: ceq
IL_06ae: br.s IL_06b1
IL_06b0: ldc.i4.1
IL_06b1: stloc.s V_49
IL_06b3: ldloc.s V_49
IL_06b5: brfalse.s IL_06c2
IL_06b7: ldstr "Response source changed"
IL_06bc: newobj System.Void System.Exception::.ctor(System.String)
IL_06c1: throw
IL_06c2: ldnull
IL_06c3: stloc.s V_47
IL_06c5: nop
IL_06c6: call !!0[] UnityEngine.Resources::FindObjectsOfTypeAll<PixelCrushers.DialogueSystem.StandardUIResponseButton>()
IL_06cb: stloc.s V_50
IL_06cd: ldc.i4.0
IL_06ce: stloc.s V_51
IL_06d0: br.s IL_073c
IL_06d2: ldloc.s V_50
IL_06d4: ldloc.s V_51
IL_06d6: ldelem.ref
IL_06d7: stloc.s V_52
IL_06d9: ldloc.s V_52
IL_06db: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_06e0: callvirt UnityEngine.SceneManagement.Scene UnityEngine.GameObject::get_scene()
IL_06e5: stloc.s V_10
IL_06e7: ldloca.s V_10
IL_06e9: call System.Boolean UnityEngine.SceneManagement.Scene::IsValid()
IL_06ee: brfalse.s IL_0710
IL_06f0: ldloc.s V_52
IL_06f2: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_06f7: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_06fc: brfalse.s IL_0710
IL_06fe: ldloc.s V_52
IL_0700: callvirt System.Boolean PixelCrushers.DialogueSystem.StandardUIResponseButton::get_isVisible()
IL_0705: brfalse.s IL_0710
IL_0707: ldloc.s V_52
IL_0709: callvirt System.Boolean PixelCrushers.DialogueSystem.StandardUIResponseButton::get_isClickable()
IL_070e: br.s IL_0711
IL_0710: ldc.i4.0
IL_0711: stloc.s V_53
IL_0713: ldloc.s V_53
IL_0715: brfalse.s IL_0736
IL_0717: nop
IL_0718: ldloc.s V_47
IL_071a: ldnull
IL_071b: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0720: stloc.s V_54
IL_0722: ldloc.s V_54
IL_0724: brfalse.s IL_0731
IL_0726: ldstr "More than one live response; hold for source review"
IL_072b: newobj System.Void System.Exception::.ctor(System.String)
IL_0730: throw
IL_0731: ldloc.s V_52
IL_0733: stloc.s V_47
IL_0735: nop
IL_0736: ldloc.s V_51
IL_0738: ldc.i4.1
IL_0739: add
IL_073a: stloc.s V_51
IL_073c: ldloc.s V_51
IL_073e: ldloc.s V_50
IL_0740: ldlen
IL_0741: conv.i4
IL_0742: blt.s IL_06d2
IL_0744: ldloc.s V_47
IL_0746: ldnull
IL_0747: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_074c: brtrue.s IL_07a3
IL_074e: ldloc.s V_47
IL_0750: callvirt PixelCrushers.DialogueSystem.Response PixelCrushers.DialogueSystem.StandardUIResponseButton::get_response()
IL_0755: brfalse.s IL_07a3
IL_0757: ldloc.s V_47
IL_0759: callvirt PixelCrushers.DialogueSystem.Response PixelCrushers.DialogueSystem.StandardUIResponseButton::get_response()
IL_075e: ldfld PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Response::destinationEntry
IL_0763: brfalse.s IL_07a3
IL_0765: ldloc.s V_47
IL_0767: callvirt UnityEngine.Transform PixelCrushers.DialogueSystem.StandardUIResponseButton::get_target()
IL_076c: ldnull
IL_076d: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0772: brtrue.s IL_07a3
IL_0774: ldloc.s V_47
IL_0776: callvirt PixelCrushers.DialogueSystem.Response PixelCrushers.DialogueSystem.StandardUIResponseButton::get_response()
IL_077b: ldfld PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Response::destinationEntry
IL_0780: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::conversationID
IL_0785: ldloc.s V_44
IL_0787: bne.un.s IL_07a3
IL_0789: ldloc.s V_47
IL_078b: callvirt PixelCrushers.DialogueSystem.Response PixelCrushers.DialogueSystem.StandardUIResponseButton::get_response()
IL_0790: ldfld PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Response::destinationEntry
IL_0795: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_079a: ldloc.s V_45
IL_079c: ceq
IL_079e: ldc.i4.0
IL_079f: ceq
IL_07a1: br.s IL_07a4
IL_07a3: ldc.i4.1
IL_07a4: stloc.s V_55
IL_07a6: ldloc.s V_55
IL_07a8: brfalse.s IL_07b5
IL_07aa: ldstr "Response does not match source-bound successor"
IL_07af: newobj System.Void System.Exception::.ctor(System.String)
IL_07b4: throw
IL_07b5: ldloc.s V_47
IL_07b7: ldfld UnityEngine.UI.Button PixelCrushers.DialogueSystem.StandardUIResponseButton::button
IL_07bc: callvirt UnityEngine.UI.Button/ButtonClickedEvent UnityEngine.UI.Button::get_onClick()
IL_07c1: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_07c6: nop
IL_07c7: nop
IL_07c8: br IL_0db1
IL_07cd: ldloc.1
IL_07ce: ldstr "probe-nameplate"
IL_07d3: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_07d8: stloc.s V_56
IL_07da: ldloc.s V_56
IL_07dc: brfalse.s IL_084c
IL_07de: nop
IL_07df: call System.Boolean PixelCrushers.DialogueSystem.DialogueManager::get_isConversationActive()
IL_07e4: ldc.i4.0
IL_07e5: ceq
IL_07e7: stloc.s V_58
IL_07e9: ldloc.s V_58
IL_07eb: brfalse.s IL_07f8
IL_07ed: ldstr "No active conversation"
IL_07f2: newobj System.Void System.Exception::.ctor(System.String)
IL_07f7: throw
IL_07f8: call !!0 UnityEngine.Object::FindObjectOfType<TheForestOfLove.DialogueNameplateController>()
IL_07fd: stloc.s V_57
IL_07ff: ldloc.s V_57
IL_0801: ldnull
IL_0802: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0807: stloc.s V_59
IL_0809: ldloc.s V_59
IL_080b: brfalse.s IL_0818
IL_080d: ldstr "No active nameplate controller"
IL_0812: newobj System.Void System.Exception::.ctor(System.String)
IL_0817: throw
IL_0818: ldloc.s V_57
IL_081a: ldstr "Ёж Йй 123"
IL_081f: callvirt System.Void TheForestOfLove.DialogueNameplateController::SetCustomNameplateUntilCleared(System.String)
IL_0824: nop
IL_0825: ldloc.s V_57
IL_0827: callvirt System.Type System.Object::GetType()
IL_082c: ldstr "UpdateNameplate"
IL_0831: ldc.i4.s 36
IL_0833: callvirt System.Reflection.MethodInfo System.Type::GetMethod(System.String,System.Reflection.BindingFlags)
IL_0838: ldloc.s V_57
IL_083a: ldc.i4.1
IL_083b: newarr System.Object
IL_0840: callvirt System.Object System.Reflection.MethodBase::Invoke(System.Object,System.Object[])
IL_0845: pop
IL_0846: nop
IL_0847: br IL_0db1
IL_084c: ldloc.1
IL_084d: ldstr "capture "
IL_0852: callvirt System.Boolean System.String::StartsWith(System.String)
IL_0857: stloc.s V_60
IL_0859: ldloc.s V_60
IL_085b: brfalse.s IL_08d6
IL_085d: nop
IL_085e: ldloc.1
IL_085f: ldc.i4.8
IL_0860: callvirt System.String System.String::Substring(System.Int32)
IL_0865: stloc.s V_61
IL_0867: ldloc.s V_61
IL_0869: call System.String System.IO.Path::GetFileName(System.String)
IL_086e: ldloc.s V_61
IL_0870: call System.Boolean System.String::op_Inequality(System.String,System.String)
IL_0875: brtrue.s IL_0888
IL_0877: ldloc.s V_61
IL_0879: ldstr ".png"
IL_087e: callvirt System.Boolean System.String::EndsWith(System.String)
IL_0883: ldc.i4.0
IL_0884: ceq
IL_0886: br.s IL_0889
IL_0888: ldc.i4.1
IL_0889: stloc.s V_63
IL_088b: ldloc.s V_63
IL_088d: brfalse.s IL_089a
IL_088f: ldstr "Invalid capture name"
IL_0894: newobj System.Void System.Exception::.ctor(System.String)
IL_0899: throw
IL_089a: ldarg.0
IL_089b: ldfld System.String ForestProbe::root
IL_08a0: ldloc.s V_61
IL_08a2: call System.String System.IO.Path::Combine(System.String,System.String)
IL_08a7: stloc.s V_62
IL_08a9: ldloc.s V_62
IL_08ab: call System.Boolean System.IO.File::Exists(System.String)
IL_08b0: stloc.s V_64
IL_08b2: ldloc.s V_64
IL_08b4: brfalse.s IL_08c1
IL_08b6: ldstr "Capture already exists"
IL_08bb: newobj System.Void System.Exception::.ctor(System.String)
IL_08c0: throw
IL_08c1: ldarg.0
IL_08c2: ldarg.0
IL_08c3: ldloc.s V_62
IL_08c5: call System.Collections.IEnumerator ForestProbe::Capture(System.String)
IL_08ca: call UnityEngine.Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)
IL_08cf: pop
IL_08d0: nop
IL_08d1: br IL_0db1
IL_08d6: ldloc.1
IL_08d7: ldstr "select "
IL_08dc: callvirt System.Boolean System.String::StartsWith(System.String)
IL_08e1: stloc.s V_65
IL_08e3: ldloc.s V_65
IL_08e5: brfalse IL_09ca
IL_08ea: nop
IL_08eb: ldloc.1
IL_08ec: ldc.i4.7
IL_08ed: callvirt System.String System.String::Substring(System.Int32)
IL_08f2: stloc.s V_66
IL_08f4: ldnull
IL_08f5: stloc.s V_67
IL_08f7: nop
IL_08f8: call !!0[] UnityEngine.Resources::FindObjectsOfTypeAll<UnityEngine.UI.Selectable>()
IL_08fd: stloc.s V_68
IL_08ff: ldc.i4.0
IL_0900: stloc.s V_69
IL_0902: br.s IL_097a
IL_0904: ldloc.s V_68
IL_0906: ldloc.s V_69
IL_0908: ldelem.ref
IL_0909: stloc.s V_70
IL_090b: ldloc.s V_70
IL_090d: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0912: callvirt UnityEngine.SceneManagement.Scene UnityEngine.GameObject::get_scene()
IL_0917: stloc.s V_10
IL_0919: ldloca.s V_10
IL_091b: call System.Boolean UnityEngine.SceneManagement.Scene::IsValid()
IL_0920: brfalse.s IL_094e
IL_0922: ldloc.s V_70
IL_0924: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0929: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_092e: brfalse.s IL_094e
IL_0930: ldloc.s V_70
IL_0932: callvirt System.Boolean UnityEngine.UI.Selectable::IsInteractable()
IL_0937: brfalse.s IL_094e
IL_0939: ldloc.s V_70
IL_093b: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0940: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_0945: ldloc.s V_66
IL_0947: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_094c: br.s IL_094f
IL_094e: ldc.i4.0
IL_094f: stloc.s V_71
IL_0951: ldloc.s V_71
IL_0953: brfalse.s IL_0974
IL_0955: nop
IL_0956: ldloc.s V_67
IL_0958: ldnull
IL_0959: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_095e: stloc.s V_72
IL_0960: ldloc.s V_72
IL_0962: brfalse.s IL_096f
IL_0964: ldstr "Duplicate active selectable"
IL_0969: newobj System.Void System.Exception::.ctor(System.String)
IL_096e: throw
IL_096f: ldloc.s V_70
IL_0971: stloc.s V_67
IL_0973: nop
IL_0974: ldloc.s V_69
IL_0976: ldc.i4.1
IL_0977: add
IL_0978: stloc.s V_69
IL_097a: ldloc.s V_69
IL_097c: ldloc.s V_68
IL_097e: ldlen
IL_097f: conv.i4
IL_0980: blt.s IL_0904
IL_0982: ldloc.s V_67
IL_0984: ldnull
IL_0985: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_098a: brtrue.s IL_0999
IL_098c: call UnityEngine.EventSystems.EventSystem UnityEngine.EventSystems.EventSystem::get_current()
IL_0991: ldnull
IL_0992: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0997: br.s IL_099a
IL_0999: ldc.i4.1
IL_099a: stloc.s V_73
IL_099c: ldloc.s V_73
IL_099e: brfalse.s IL_09b2
IL_09a0: ldstr "No selectable/event system: "
IL_09a5: ldloc.s V_66
IL_09a7: call System.String System.String::Concat(System.String,System.String)
IL_09ac: newobj System.Void System.Exception::.ctor(System.String)
IL_09b1: throw
IL_09b2: call UnityEngine.EventSystems.EventSystem UnityEngine.EventSystems.EventSystem::get_current()
IL_09b7: ldloc.s V_67
IL_09b9: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_09be: callvirt System.Void UnityEngine.EventSystems.EventSystem::SetSelectedGameObject(UnityEngine.GameObject)
IL_09c3: nop
IL_09c4: nop
IL_09c5: br IL_0db1
IL_09ca: ldloc.1
IL_09cb: ldstr "move-left"
IL_09d0: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_09d5: brtrue.s IL_09e4
IL_09d7: ldloc.1
IL_09d8: ldstr "move-right"
IL_09dd: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_09e2: br.s IL_09e5
IL_09e4: ldc.i4.1
IL_09e5: stloc.s V_74
IL_09e7: ldloc.s V_74
IL_09e9: brfalse IL_0a6f
IL_09ee: nop
IL_09ef: call UnityEngine.EventSystems.EventSystem UnityEngine.EventSystems.EventSystem::get_current()
IL_09f4: stloc.s V_75
IL_09f6: ldloc.s V_75
IL_09f8: ldnull
IL_09f9: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_09fe: brtrue.s IL_0a0f
IL_0a00: ldloc.s V_75
IL_0a02: callvirt UnityEngine.GameObject UnityEngine.EventSystems.EventSystem::get_currentSelectedGameObject()
IL_0a07: ldnull
IL_0a08: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0a0d: br.s IL_0a10
IL_0a0f: ldc.i4.1
IL_0a10: stloc.s V_77
IL_0a12: ldloc.s V_77
IL_0a14: brfalse.s IL_0a21
IL_0a16: ldstr "No selected control"
IL_0a1b: newobj System.Void System.Exception::.ctor(System.String)
IL_0a20: throw
IL_0a21: ldloc.s V_75
IL_0a23: newobj System.Void UnityEngine.EventSystems.AxisEventData::.ctor(UnityEngine.EventSystems.EventSystem)
IL_0a28: dup
IL_0a29: ldloc.1
IL_0a2a: ldstr "move-left"
IL_0a2f: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0a34: brtrue.s IL_0a39
IL_0a36: ldc.i4.2
IL_0a37: br.s IL_0a3a
IL_0a39: ldc.i4.0
IL_0a3a: callvirt System.Void UnityEngine.EventSystems.AxisEventData::set_moveDir(UnityEngine.EventSystems.MoveDirection)
IL_0a3f: nop
IL_0a40: stloc.s V_76
IL_0a42: ldloc.s V_75
IL_0a44: callvirt UnityEngine.GameObject UnityEngine.EventSystems.EventSystem::get_currentSelectedGameObject()
IL_0a49: ldloc.s V_76
IL_0a4b: call UnityEngine.EventSystems.ExecuteEvents/EventFunction`1<UnityEngine.EventSystems.IMoveHandler> UnityEngine.EventSystems.ExecuteEvents::get_moveHandler()
IL_0a50: call System.Boolean UnityEngine.EventSystems.ExecuteEvents::Execute<UnityEngine.EventSystems.IMoveHandler>(UnityEngine.GameObject,UnityEngine.EventSystems.BaseEventData,UnityEngine.EventSystems.ExecuteEvents/EventFunction`1<!!0>)
IL_0a55: ldc.i4.0
IL_0a56: ceq
IL_0a58: stloc.s V_78
IL_0a5a: ldloc.s V_78
IL_0a5c: brfalse.s IL_0a69
IL_0a5e: ldstr "No move handler"
IL_0a63: newobj System.Void System.Exception::.ctor(System.String)
IL_0a68: throw
IL_0a69: nop
IL_0a6a: br IL_0db1
IL_0a6f: ldloc.1
IL_0a70: ldstr "click "
IL_0a75: callvirt System.Boolean System.String::StartsWith(System.String)
IL_0a7a: stloc.s V_79
IL_0a7c: ldloc.s V_79
IL_0a7e: brfalse IL_0b37
IL_0a83: nop
IL_0a84: ldloc.1
IL_0a85: ldc.i4.6
IL_0a86: callvirt System.String System.String::Substring(System.Int32)
IL_0a8b: stloc.s V_80
IL_0a8d: ldnull
IL_0a8e: stloc.s V_81
IL_0a90: nop
IL_0a91: call !!0[] UnityEngine.Resources::FindObjectsOfTypeAll<UnityEngine.UI.Button>()
IL_0a96: stloc.s V_82
IL_0a98: ldc.i4.0
IL_0a99: stloc.s V_83
IL_0a9b: br.s IL_0afc
IL_0a9d: ldloc.s V_82
IL_0a9f: ldloc.s V_83
IL_0aa1: ldelem.ref
IL_0aa2: stloc.s V_84
IL_0aa4: ldloc.s V_84
IL_0aa6: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0aab: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_0ab0: brfalse.s IL_0ad0
IL_0ab2: ldloc.s V_84
IL_0ab4: callvirt System.Boolean UnityEngine.UI.Selectable::get_interactable()
IL_0ab9: brfalse.s IL_0ad0
IL_0abb: ldloc.s V_84
IL_0abd: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0ac2: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_0ac7: ldloc.s V_80
IL_0ac9: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0ace: br.s IL_0ad1
IL_0ad0: ldc.i4.0
IL_0ad1: stloc.s V_85
IL_0ad3: ldloc.s V_85
IL_0ad5: brfalse.s IL_0af6
IL_0ad7: nop
IL_0ad8: ldloc.s V_81
IL_0ada: ldnull
IL_0adb: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0ae0: stloc.s V_86
IL_0ae2: ldloc.s V_86
IL_0ae4: brfalse.s IL_0af1
IL_0ae6: ldstr "Duplicate active button"
IL_0aeb: newobj System.Void System.Exception::.ctor(System.String)
IL_0af0: throw
IL_0af1: ldloc.s V_84
IL_0af3: stloc.s V_81
IL_0af5: nop
IL_0af6: ldloc.s V_83
IL_0af8: ldc.i4.1
IL_0af9: add
IL_0afa: stloc.s V_83
IL_0afc: ldloc.s V_83
IL_0afe: ldloc.s V_82
IL_0b00: ldlen
IL_0b01: conv.i4
IL_0b02: blt.s IL_0a9d
IL_0b04: ldloc.s V_81
IL_0b06: ldnull
IL_0b07: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0b0c: stloc.s V_87
IL_0b0e: ldloc.s V_87
IL_0b10: brfalse.s IL_0b24
IL_0b12: ldstr "No matching active button: "
IL_0b17: ldloc.s V_80
IL_0b19: call System.String System.String::Concat(System.String,System.String)
IL_0b1e: newobj System.Void System.Exception::.ctor(System.String)
IL_0b23: throw
IL_0b24: ldloc.s V_81
IL_0b26: callvirt UnityEngine.UI.Button/ButtonClickedEvent UnityEngine.UI.Button::get_onClick()
IL_0b2b: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_0b30: nop
IL_0b31: nop
IL_0b32: br IL_0db1
IL_0b37: ldloc.1
IL_0b38: ldstr "menu "
IL_0b3d: callvirt System.Boolean System.String::StartsWith(System.String)
IL_0b42: stloc.s V_88
IL_0b44: ldloc.s V_88
IL_0b46: brfalse IL_0da6
IL_0b4b: nop
IL_0b4c: ldloc.1
IL_0b4d: ldc.i4.5
IL_0b4e: callvirt System.String System.String::Substring(System.Int32)
IL_0b53: ldc.i4.1
IL_0b54: newarr System.Char
IL_0b59: dup
IL_0b5a: ldc.i4.0
IL_0b5b: ldc.i4.s 32
IL_0b5d: stelem.i2
IL_0b5e: callvirt System.String[] System.String::Split(System.Char[])
IL_0b63: stloc.s V_89
IL_0b65: ldloc.s V_89
IL_0b67: ldlen
IL_0b68: conv.i4
IL_0b69: ldc.i4.2
IL_0b6a: bne.un.s IL_0b8c
IL_0b6c: ldloc.s V_89
IL_0b6e: ldc.i4.0
IL_0b6f: ldelem.ref
IL_0b70: ldstr "PlayMenu"
IL_0b75: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0b7a: brfalse.s IL_0b8c
IL_0b7c: ldloc.s V_89
IL_0b7e: ldc.i4.1
IL_0b7f: ldelem.ref
IL_0b80: ldstr "OnClickContinue"
IL_0b85: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0b8a: br.s IL_0b8d
IL_0b8c: ldc.i4.0
IL_0b8d: stloc.s V_90
IL_0b8f: ldloc.s V_89
IL_0b91: ldlen
IL_0b92: conv.i4
IL_0b93: ldc.i4.2
IL_0b94: bne.un.s IL_0bff
IL_0b96: ldloc.s V_89
IL_0b98: ldc.i4.0
IL_0b99: ldelem.ref
IL_0b9a: ldstr "StartScreenMainMenu"
IL_0b9f: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0ba4: brtrue.s IL_0bc6
IL_0ba6: ldloc.s V_89
IL_0ba8: ldc.i4.0
IL_0ba9: ldelem.ref
IL_0baa: ldstr "PlayMenu"
IL_0baf: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0bb4: brtrue.s IL_0bc6
IL_0bb6: ldloc.s V_89
IL_0bb8: ldc.i4.0
IL_0bb9: ldelem.ref
IL_0bba: ldstr "OptionsMenu"
IL_0bbf: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0bc4: brfalse.s IL_0bff
IL_0bc6: ldloc.s V_89
IL_0bc8: ldc.i4.1
IL_0bc9: ldelem.ref
IL_0bca: ldstr "OnClickStart"
IL_0bcf: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0bd4: brtrue.s IL_0bf6
IL_0bd6: ldloc.s V_89
IL_0bd8: ldc.i4.1
IL_0bd9: ldelem.ref
IL_0bda: ldstr "OnClickOptions"
IL_0bdf: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0be4: brtrue.s IL_0bf6
IL_0be6: ldloc.s V_89
IL_0be8: ldc.i4.1
IL_0be9: ldelem.ref
IL_0bea: ldstr "OnClickBack"
IL_0bef: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0bf4: br.s IL_0bf7
IL_0bf6: ldc.i4.1
IL_0bf7: ldloc.s V_90
IL_0bf9: or
IL_0bfa: ldc.i4.0
IL_0bfb: ceq
IL_0bfd: br.s IL_0c00
IL_0bff: ldc.i4.1
IL_0c00: stloc.s V_92
IL_0c02: ldloc.s V_92
IL_0c04: brfalse.s IL_0c11
IL_0c06: ldstr "Unsupported menu command"
IL_0c0b: newobj System.Void System.Exception::.ctor(System.String)
IL_0c10: throw
IL_0c11: ldloc.s V_90
IL_0c13: stloc.s V_93
IL_0c15: ldloc.s V_93
IL_0c17: brfalse IL_0cf7
IL_0c1c: nop
IL_0c1d: call System.Boolean TheForestOfLove.Services.Persistence.SaveManager::get_HasSavedPlaySession()
IL_0c22: brfalse.s IL_0c53
IL_0c24: call UnityEngine.SceneManagement.Scene UnityEngine.SceneManagement.SceneManager::GetActiveScene()
IL_0c29: stloc.s V_10
IL_0c2b: ldloca.s V_10
IL_0c2d: call System.String UnityEngine.SceneManagement.Scene::get_name()
IL_0c32: ldstr "StartMenu"
IL_0c37: call System.Boolean System.String::op_Inequality(System.String,System.String)
IL_0c3c: brtrue.s IL_0c53
IL_0c3e: ldsfld System.Boolean Globals::isChapterSelect
IL_0c43: brtrue.s IL_0c53
IL_0c45: ldsfld System.Boolean Globals::isCheatCode
IL_0c4a: brtrue.s IL_0c53
IL_0c4c: call System.Boolean PixelCrushers.DialogueSystem.DialogueManager::get_isConversationActive()
IL_0c51: br.s IL_0c54
IL_0c53: ldc.i4.1
IL_0c54: stloc.s V_95
IL_0c56: ldloc.s V_95
IL_0c58: brfalse.s IL_0c65
IL_0c5a: ldstr "Original saved Continue state unavailable"
IL_0c5f: newobj System.Void System.Exception::.ctor(System.String)
IL_0c64: throw
IL_0c65: ldc.i4.0
IL_0c66: stloc.s V_94
IL_0c68: nop
IL_0c69: call !!0[] UnityEngine.Resources::FindObjectsOfTypeAll<UnityEngine.UI.Button>()
IL_0c6e: stloc.s V_96
IL_0c70: ldc.i4.0
IL_0c71: stloc.s V_97
IL_0c73: br.s IL_0cd5
IL_0c75: ldloc.s V_96
IL_0c77: ldloc.s V_97
IL_0c79: ldelem.ref
IL_0c7a: stloc.s V_98
IL_0c7c: ldloc.s V_98
IL_0c7e: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0c83: callvirt UnityEngine.SceneManagement.Scene UnityEngine.GameObject::get_scene()
IL_0c88: stloc.s V_10
IL_0c8a: ldloca.s V_10
IL_0c8c: call System.Boolean UnityEngine.SceneManagement.Scene::IsValid()
IL_0c91: brfalse.s IL_0cc2
IL_0c93: ldloc.s V_98
IL_0c95: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0c9a: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_0c9f: brfalse.s IL_0cc2
IL_0ca1: ldloc.s V_98
IL_0ca3: callvirt System.Boolean UnityEngine.UI.Selectable::get_interactable()
IL_0ca8: brfalse.s IL_0cc2
IL_0caa: ldloc.s V_98
IL_0cac: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0cb1: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_0cb6: ldstr "Canvas/PlayMenu/Controls/Continue"
IL_0cbb: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0cc0: br.s IL_0cc3
IL_0cc2: ldc.i4.0
IL_0cc3: stloc.s V_99
IL_0cc5: ldloc.s V_99
IL_0cc7: brfalse.s IL_0ccf
IL_0cc9: ldloc.s V_94
IL_0ccb: ldc.i4.1
IL_0ccc: add
IL_0ccd: stloc.s V_94
IL_0ccf: ldloc.s V_97
IL_0cd1: ldc.i4.1
IL_0cd2: add
IL_0cd3: stloc.s V_97
IL_0cd5: ldloc.s V_97
IL_0cd7: ldloc.s V_96
IL_0cd9: ldlen
IL_0cda: conv.i4
IL_0cdb: blt.s IL_0c75
IL_0cdd: ldloc.s V_94
IL_0cdf: ldc.i4.1
IL_0ce0: ceq
IL_0ce2: ldc.i4.0
IL_0ce3: ceq
IL_0ce5: stloc.s V_100
IL_0ce7: ldloc.s V_100
IL_0ce9: brfalse.s IL_0cf6
IL_0ceb: ldstr "Exact original Continue control unavailable"
IL_0cf0: newobj System.Void System.Exception::.ctor(System.String)
IL_0cf5: throw
IL_0cf6: nop
IL_0cf7: ldnull
IL_0cf8: stloc.s V_91
IL_0cfa: nop
IL_0cfb: call !!0[] UnityEngine.Resources::FindObjectsOfTypeAll<UnityEngine.MonoBehaviour>()
IL_0d00: stloc.s V_101
IL_0d02: ldc.i4.0
IL_0d03: stloc.s V_102
IL_0d05: br.s IL_0d69
IL_0d07: ldloc.s V_101
IL_0d09: ldloc.s V_102
IL_0d0b: ldelem.ref
IL_0d0c: stloc.s V_103
IL_0d0e: ldloc.s V_103
IL_0d10: ldnull
IL_0d11: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0d16: brfalse.s IL_0d3d
IL_0d18: ldloc.s V_103
IL_0d1a: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0d1f: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_0d24: brfalse.s IL_0d3d
IL_0d26: ldloc.s V_103
IL_0d28: callvirt System.Type System.Object::GetType()
IL_0d2d: callvirt System.String System.Reflection.MemberInfo::get_Name()
IL_0d32: ldloc.s V_89
IL_0d34: ldc.i4.0
IL_0d35: ldelem.ref
IL_0d36: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0d3b: br.s IL_0d3e
IL_0d3d: ldc.i4.0
IL_0d3e: stloc.s V_104
IL_0d40: ldloc.s V_104
IL_0d42: brfalse.s IL_0d63
IL_0d44: nop
IL_0d45: ldloc.s V_91
IL_0d47: ldnull
IL_0d48: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0d4d: stloc.s V_105
IL_0d4f: ldloc.s V_105
IL_0d51: brfalse.s IL_0d5e
IL_0d53: ldstr "Duplicate active menu"
IL_0d58: newobj System.Void System.Exception::.ctor(System.String)
IL_0d5d: throw
IL_0d5e: ldloc.s V_103
IL_0d60: stloc.s V_91
IL_0d62: nop
IL_0d63: ldloc.s V_102
IL_0d65: ldc.i4.1
IL_0d66: add
IL_0d67: stloc.s V_102
IL_0d69: ldloc.s V_102
IL_0d6b: ldloc.s V_101
IL_0d6d: ldlen
IL_0d6e: conv.i4
IL_0d6f: blt.s IL_0d07
IL_0d71: ldloc.s V_91
IL_0d73: ldnull
IL_0d74: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0d79: stloc.s V_106
IL_0d7b: ldloc.s V_106
IL_0d7d: brfalse.s IL_0d8a
IL_0d7f: ldstr "Menu not active"
IL_0d84: newobj System.Void System.Exception::.ctor(System.String)
IL_0d89: throw
IL_0d8a: ldloc.s V_91
IL_0d8c: callvirt System.Type System.Object::GetType()
IL_0d91: ldloc.s V_89
IL_0d93: ldc.i4.1
IL_0d94: ldelem.ref
IL_0d95: callvirt System.Reflection.MethodInfo System.Type::GetMethod(System.String)
IL_0d9a: ldloc.s V_91
IL_0d9c: ldnull
IL_0d9d: callvirt System.Object System.Reflection.MethodBase::Invoke(System.Object,System.Object[])
IL_0da2: pop
IL_0da3: nop
IL_0da4: br.s IL_0db1
IL_0da6: ldstr "Unsupported command"
IL_0dab: newobj System.Void System.Exception::.ctor(System.String)
IL_0db0: throw
IL_0db1: ldarg.0
IL_0db2: ldfld System.String ForestProbe::root
IL_0db7: ldstr "actions.log"
IL_0dbc: call System.String System.IO.Path::Combine(System.String,System.String)
IL_0dc1: call System.DateTime System.DateTime::get_UtcNow()
IL_0dc6: stloc.s V_107
IL_0dc8: ldloca.s V_107
IL_0dca: ldstr "O"
IL_0dcf: call System.String System.DateTime::ToString(System.String)
IL_0dd4: ldstr " OK "
IL_0dd9: ldloc.1
IL_0dda: ldstr "
"
IL_0ddf: call System.String System.String::Concat(System.String,System.String,System.String,System.String)
IL_0de4: call System.Void System.IO.File::AppendAllText(System.String,System.String)
IL_0de9: nop
IL_0dea: nop
IL_0deb: leave.s IL_0e5f
IL_0ded: stloc.s V_108
IL_0def: nop
IL_0df0: ldarg.0
IL_0df1: ldfld System.String ForestProbe::root
IL_0df6: ldstr "actions.log"
IL_0dfb: call System.String System.IO.Path::Combine(System.String,System.String)
IL_0e00: ldc.i4.6
IL_0e01: newarr System.String
IL_0e06: dup
IL_0e07: ldc.i4.0
IL_0e08: call System.DateTime System.DateTime::get_UtcNow()
IL_0e0d: stloc.s V_107
IL_0e0f: ldloca.s V_107
IL_0e11: ldstr "O"
IL_0e16: call System.String System.DateTime::ToString(System.String)
IL_0e1b: stelem.ref
IL_0e1c: dup
IL_0e1d: ldc.i4.1
IL_0e1e: ldstr " FAIL "
IL_0e23: stelem.ref
IL_0e24: dup
IL_0e25: ldc.i4.2
IL_0e26: ldloc.1
IL_0e27: stelem.ref
IL_0e28: dup
IL_0e29: ldc.i4.3
IL_0e2a: ldstr " "
IL_0e2f: stelem.ref
IL_0e30: dup
IL_0e31: ldc.i4.4
IL_0e32: ldloc.s V_108
IL_0e34: dup
IL_0e35: brtrue.s IL_0e3b
IL_0e37: pop
IL_0e38: ldnull
IL_0e39: br.s IL_0e40
IL_0e3b: callvirt System.String System.Object::ToString()
IL_0e40: stelem.ref
IL_0e41: dup
IL_0e42: ldc.i4.5
IL_0e43: ldstr "
"
IL_0e48: stelem.ref
IL_0e49: call System.String System.String::Concat(System.String[])
IL_0e4e: call System.Void System.IO.File::AppendAllText(System.String,System.String)
IL_0e53: nop
IL_0e54: ldloc.s V_108
IL_0e56: call System.Void UnityEngine.Debug::LogException(System.Exception)
IL_0e5b: nop
IL_0e5c: nop
IL_0e5d: leave.s IL_0e5f
IL_0e5f: ret
METHOD System.Void ForestProbe::RestoreInputPolicy() | attributes=Private, HideBySig | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: ldflda System.Nullable`1<System.Boolean> ForestProbe::originalIgnoreUnfocused
IL_0007: call System.Boolean System.Nullable`1<System.Boolean>::get_HasValue()
IL_000c: ldc.i4.0
IL_000d: ceq
IL_000f: stloc.1
IL_0010: ldloc.1
IL_0011: brfalse.s IL_0015
IL_0013: br.s IL_0058
IL_0015: ldarg.0
IL_0016: ldflda System.Nullable`1<System.Boolean> ForestProbe::originalIgnoreUnfocused
IL_001b: call !0 System.Nullable`1<System.Boolean>::get_Value()
IL_0020: stloc.0
IL_0021: call Rewired.ReInput/ConfigHelper Rewired.ReInput::get_configuration()
IL_0026: ldloc.0
IL_0027: callvirt System.Void Rewired.ReInput/ConfigHelper::set_ignoreInputWhenAppNotInFocus(System.Boolean)
IL_002c: nop
IL_002d: call Rewired.ReInput/ConfigHelper Rewired.ReInput::get_configuration()
IL_0032: callvirt System.Boolean Rewired.ReInput/ConfigHelper::get_ignoreInputWhenAppNotInFocus()
IL_0037: ldloc.0
IL_0038: ceq
IL_003a: ldc.i4.0
IL_003b: ceq
IL_003d: stloc.2
IL_003e: ldloc.2
IL_003f: brfalse.s IL_004c
IL_0041: ldstr "Original input focus policy not restored"
IL_0046: newobj System.Void System.Exception::.ctor(System.String)
IL_004b: throw
IL_004c: ldarg.0
IL_004d: ldflda System.Nullable`1<System.Boolean> ForestProbe::originalIgnoreUnfocused
IL_0052: initobj System.Nullable`1<System.Boolean>
IL_0058: ret
METHOD System.Void ForestProbe::OnDestroy() | attributes=Private, HideBySig | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: ldftn System.Void ForestProbe::ObserveUnityFocusEvent(System.Boolean)
IL_0008: newobj System.Void System.Action`1<System.Boolean>::.ctor(System.Object,System.IntPtr)
IL_000d: call System.Void UnityEngine.Application::remove_focusChanged(System.Action`1<System.Boolean>)
IL_0012: nop
IL_0013: ldarg.0
IL_0014: call System.Void ForestProbe::RestoreInputPolicy()
IL_0019: nop
IL_001a: ret
METHOD System.Void ForestProbe::OnApplicationFocus(System.Boolean) | attributes=Private, HideBySig | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: ldstr "mono-focus"
IL_0007: ldarga.s value
IL_0009: call System.String System.Boolean::ToString()
IL_000e: call System.Void ForestProbe::ObserveFocus(System.String,System.String)
IL_0013: nop
IL_0014: ret
METHOD System.Void ForestProbe::OnApplicationPause(System.Boolean) | attributes=Private, HideBySig | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: ldstr "mono-pause"
IL_0007: ldarga.s value
IL_0009: call System.String System.Boolean::ToString()
IL_000e: call System.Void ForestProbe::ObserveFocus(System.String,System.String)
IL_0013: nop
IL_0014: ret
METHOD System.Void ForestProbe::ObserveUnityFocusEvent(System.Boolean) | attributes=Private, HideBySig | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: ldstr "unity-event"
IL_0007: ldarga.s value
IL_0009: call System.String System.Boolean::ToString()
IL_000e: call System.Void ForestProbe::ObserveFocus(System.String,System.String)
IL_0013: nop
IL_0014: ret
METHOD System.Void ForestProbe::ObserveFocus(System.String,System.String) | attributes=Private, HideBySig | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: ldfld System.String ForestProbe::root
IL_0007: brfalse.s IL_0011
IL_0009: ldarg.0
IL_000a: ldfld System.Boolean ForestProbe::focusLimited
IL_000f: br.s IL_0012
IL_0011: ldc.i4.1
IL_0012: stloc.2
IL_0013: ldloc.2
IL_0014: brfalse.s IL_001b
IL_0016: br IL_0330
IL_001b: ldc.i4.6
IL_001c: newarr System.String
IL_0021: dup
IL_0022: ldc.i4.0
IL_0023: ldstr " | focused="
IL_0028: stelem.ref
IL_0029: dup
IL_002a: ldc.i4.1
IL_002b: call System.Boolean UnityEngine.Application::get_isFocused()
IL_0030: stloc.3
IL_0031: ldloca.s V_3
IL_0033: call System.String System.Boolean::ToString()
IL_0038: stelem.ref
IL_0039: dup
IL_003a: ldc.i4.2
IL_003b: ldstr " | runInBackground="
IL_0040: stelem.ref
IL_0041: dup
IL_0042: ldc.i4.3
IL_0043: call System.Boolean UnityEngine.Application::get_runInBackground()
IL_0048: stloc.3
IL_0049: ldloca.s V_3
IL_004b: call System.String System.Boolean::ToString()
IL_0050: stelem.ref
IL_0051: dup
IL_0052: ldc.i4.4
IL_0053: ldstr " | scene="
IL_0058: stelem.ref
IL_0059: dup
IL_005a: ldc.i4.5
IL_005b: call UnityEngine.SceneManagement.Scene UnityEngine.SceneManagement.SceneManager::GetActiveScene()
IL_0060: stloc.s V_4
IL_0062: ldloca.s V_4
IL_0064: call System.String UnityEngine.SceneManagement.Scene::get_name()
IL_0069: stelem.ref
IL_006a: call System.String System.String::Concat(System.String[])
IL_006f: stloc.0
IL_0070: nop
IL_0071: ldc.i4.s 40
IL_0073: stloc.s V_5
IL_0075: ldloc.0
IL_0076: ldstr " | rewiredCallbackCache="
IL_007b: ldtoken Rewired.ReInput
IL_0080: call System.Type System.Type::GetTypeFromHandle(System.RuntimeTypeHandle)
IL_0085: ldstr "cbmmwJPDGUhXqzzdtJQPbNHADIB"
IL_008a: ldloc.s V_5
IL_008c: callvirt System.Reflection.FieldInfo System.Type::GetField(System.String,System.Reflection.BindingFlags)
IL_0091: ldnull
IL_0092: callvirt System.Object System.Reflection.FieldInfo::GetValue(System.Object)
IL_0097: dup
IL_0098: brtrue.s IL_009e
IL_009a: pop
IL_009b: ldnull
IL_009c: br.s IL_00a3
IL_009e: callvirt System.String System.Object::ToString()
IL_00a3: call System.String System.String::Concat(System.String,System.String,System.String)
IL_00a8: stloc.0
IL_00a9: ldloc.0
IL_00aa: call System.Boolean Rewired.ReInput::get_isReady()
IL_00af: brtrue.s IL_00b8
IL_00b1: ldstr " | rewiredReady=False"
IL_00b6: br.s IL_00d9
IL_00b8: ldstr " | ignoreUnfocused="
IL_00bd: call Rewired.ReInput/ConfigHelper Rewired.ReInput::get_configuration()
IL_00c2: callvirt System.Boolean Rewired.ReInput/ConfigHelper::get_ignoreInputWhenAppNotInFocus()
IL_00c7: stloc.3
IL_00c8: ldloca.s V_3
IL_00ca: call System.String System.Boolean::ToString()
IL_00cf: call System.String ForestProbe::KeyboardEligibility()
IL_00d4: call System.String System.String::Concat(System.String,System.String,System.String)
IL_00d9: call System.String System.String::Concat(System.String,System.String)
IL_00de: stloc.0
IL_00df: ldc.i4.7
IL_00e0: newarr System.String
IL_00e5: dup
IL_00e6: ldc.i4.0
IL_00e7: ldloc.0
IL_00e8: stelem.ref
IL_00e9: dup
IL_00ea: ldc.i4.1
IL_00eb: ldstr " | gameplay="
IL_00f0: stelem.ref
IL_00f1: dup
IL_00f2: ldc.i4.2
IL_00f3: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inGameplayScene()
IL_00f8: stloc.3
IL_00f9: ldloca.s V_3
IL_00fb: call System.String System.Boolean::ToString()
IL_0100: stelem.ref
IL_0101: dup
IL_0102: ldc.i4.3
IL_0103: ldstr " | anyEvent="
IL_0108: stelem.ref
IL_0109: dup
IL_010a: ldc.i4.4
IL_010b: call System.Boolean TheForestOfLove.Events.GameStateManager::get_isAnyEventActive()
IL_0110: stloc.3
IL_0111: ldloca.s V_3
IL_0113: call System.String System.Boolean::ToString()
IL_0118: stelem.ref
IL_0119: dup
IL_011a: ldc.i4.5
IL_011b: ldstr " | conversation="
IL_0120: stelem.ref
IL_0121: dup
IL_0122: ldc.i4.6
IL_0123: call System.Boolean PixelCrushers.DialogueSystem.DialogueManager::get_isConversationActive()
IL_0128: stloc.3
IL_0129: ldloca.s V_3
IL_012b: call System.String System.Boolean::ToString()
IL_0130: stelem.ref
IL_0131: call System.String System.String::Concat(System.String[])
IL_0136: stloc.0
IL_0137: nop
IL_0138: leave.s IL_0158
IL_013a: stloc.s V_6
IL_013c: nop
IL_013d: ldloc.0
IL_013e: ldstr " | errorType="
IL_0143: ldloc.s V_6
IL_0145: callvirt System.Type System.Exception::GetType()
IL_014a: callvirt System.String System.Reflection.MemberInfo::get_Name()
IL_014f: call System.String System.String::Concat(System.String,System.String,System.String)
IL_0154: stloc.0
IL_0155: nop
IL_0156: leave.s IL_0158
IL_0158: ldarg.0
IL_0159: ldfld System.Collections.Generic.List`1<System.String> ForestProbe::focusRecords
IL_015e: callvirt System.Int32 System.Collections.Generic.List`1<System.String>::get_Count()
IL_0163: ldc.i4 1023
IL_0168: bge.s IL_0182
IL_016a: call System.Single UnityEngine.Time::get_realtimeSinceStartup()
IL_016f: ldarg.0
IL_0170: ldfld System.Single ForestProbe::focusStarted
IL_0175: sub
IL_0176: ldc.r4 420
IL_017b: clt.un
IL_017d: ldc.i4.0
IL_017e: ceq
IL_0180: br.s IL_0183
IL_0182: ldc.i4.1
IL_0183: stloc.1
IL_0184: ldarg.1
IL_0185: ldstr "late"
IL_018a: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_018f: brfalse.s IL_01b2
IL_0191: ldloc.0
IL_0192: ldarg.0
IL_0193: ldfld System.String ForestProbe::lastFocusState
IL_0198: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_019d: brfalse.s IL_01b2
IL_019f: call System.Single UnityEngine.Time::get_realtimeSinceStartup()
IL_01a4: ldarg.0
IL_01a5: ldfld System.Single ForestProbe::nextFocusRecord
IL_01aa: bge.un.s IL_01b2
IL_01ac: ldloc.1
IL_01ad: ldc.i4.0
IL_01ae: ceq
IL_01b0: br.s IL_01b3
IL_01b2: ldc.i4.0
IL_01b3: stloc.s V_7
IL_01b5: ldloc.s V_7
IL_01b7: brfalse.s IL_01be
IL_01b9: br IL_0330
IL_01be: ldarg.0
IL_01bf: ldloc.1
IL_01c0: stfld System.Boolean ForestProbe::focusLimited
IL_01c5: ldarg.0
IL_01c6: ldloc.0
IL_01c7: stfld System.String ForestProbe::lastFocusState
IL_01cc: ldarg.0
IL_01cd: call System.Single UnityEngine.Time::get_realtimeSinceStartup()
IL_01d2: ldc.r4 1
IL_01d7: add
IL_01d8: stfld System.Single ForestProbe::nextFocusRecord
IL_01dd: ldarg.0
IL_01de: ldfld System.Collections.Generic.List`1<System.String> ForestProbe::focusRecords
IL_01e3: ldc.i4.s 19
IL_01e5: newarr System.String
IL_01ea: dup
IL_01eb: ldc.i4.0
IL_01ec: ldstr "focus | sequence="
IL_01f1: stelem.ref
IL_01f2: dup
IL_01f3: ldc.i4.1
IL_01f4: ldarg.0
IL_01f5: ldfld System.Collections.Generic.List`1<System.String> ForestProbe::focusRecords
IL_01fa: callvirt System.Int32 System.Collections.Generic.List`1<System.String>::get_Count()
IL_01ff: stloc.s V_8
IL_0201: ldloca.s V_8
IL_0203: call System.String System.Int32::ToString()
IL_0208: stelem.ref
IL_0209: dup
IL_020a: ldc.i4.2
IL_020b: ldstr " | kind="
IL_0210: stelem.ref
IL_0211: dup
IL_0212: ldc.i4.3
IL_0213: ldloc.1
IL_0214: brtrue.s IL_0219
IL_0216: ldarg.1
IL_0217: br.s IL_021e
IL_0219: ldstr "limit"
IL_021e: stelem.ref
IL_021f: dup
IL_0220: ldc.i4.4
IL_0221: ldstr " | callbackValue="
IL_0226: stelem.ref
IL_0227: dup
IL_0228: ldc.i4.5
IL_0229: ldarg.2
IL_022a: stelem.ref
IL_022b: dup
IL_022c: ldc.i4.6
IL_022d: ldstr " | frame="
IL_0232: stelem.ref
IL_0233: dup
IL_0234: ldc.i4.7
IL_0235: call System.Int32 UnityEngine.Time::get_frameCount()
IL_023a: stloc.s V_8
IL_023c: ldloca.s V_8
IL_023e: call System.String System.Int32::ToString()
IL_0243: stelem.ref
IL_0244: dup
IL_0245: ldc.i4.8
IL_0246: ldstr " | realtime="
IL_024b: stelem.ref
IL_024c: dup
IL_024d: ldc.i4.s 9
IL_024f: call System.Single UnityEngine.Time::get_realtimeSinceStartup()
IL_0254: stloc.s V_9
IL_0256: ldloca.s V_9
IL_0258: call System.String System.Single::ToString()
IL_025d: stelem.ref
IL_025e: dup
IL_025f: ldc.i4.s 10
IL_0261: ldstr " | scaledTime="
IL_0266: stelem.ref
IL_0267: dup
IL_0268: ldc.i4.s 11
IL_026a: call System.Single UnityEngine.Time::get_time()
IL_026f: stloc.s V_9
IL_0271: ldloca.s V_9
IL_0273: call System.String System.Single::ToString()
IL_0278: stelem.ref
IL_0279: dup
IL_027a: ldc.i4.s 12
IL_027c: ldstr " | timeScale="
IL_0281: stelem.ref
IL_0282: dup
IL_0283: ldc.i4.s 13
IL_0285: call System.Single UnityEngine.Time::get_timeScale()
IL_028a: stloc.s V_9
IL_028c: ldloca.s V_9
IL_028e: call System.String System.Single::ToString()
IL_0293: stelem.ref
IL_0294: dup
IL_0295: ldc.i4.s 14
IL_0297: ldstr " | utc="
IL_029c: stelem.ref
IL_029d: dup
IL_029e: ldc.i4.s 15
IL_02a0: call System.DateTime System.DateTime::get_UtcNow()
IL_02a5: stloc.s V_10
IL_02a7: ldloca.s V_10
IL_02a9: ldstr "O"
IL_02ae: call System.String System.DateTime::ToString(System.String)
IL_02b3: stelem.ref
IL_02b4: dup
IL_02b5: ldc.i4.s 16
IL_02b7: ldstr " | winPid="
IL_02bc: stelem.ref
IL_02bd: dup
IL_02be: ldc.i4.s 17
IL_02c0: call System.UInt32 ForestProbe::GetCurrentProcessId()
IL_02c5: stloc.s V_11
IL_02c7: ldloca.s V_11
IL_02c9: call System.String System.UInt32::ToString()
IL_02ce: stelem.ref
IL_02cf: dup
IL_02d0: ldc.i4.s 18
IL_02d2: ldloc.0
IL_02d3: stelem.ref
IL_02d4: call System.String System.String::Concat(System.String[])
IL_02d9: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_02de: nop
IL_02df: ldarg.1
IL_02e0: ldstr "snapshot"
IL_02e5: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_02ea: ldloc.1
IL_02eb: or
IL_02ec: stloc.s V_12
IL_02ee: ldloc.s V_12
IL_02f0: brfalse.s IL_0330
IL_02f2: ldarg.0
IL_02f3: ldfld System.String ForestProbe::root
IL_02f8: ldstr "focus-trace.json"
IL_02fd: call System.String System.IO.Path::Combine(System.String,System.String)
IL_0302: newobj System.Void ForestProbe/FocusTrace::.ctor()
IL_0307: dup
IL_0308: ldarg.0
IL_0309: ldfld System.Collections.Generic.List`1<System.String> ForestProbe::focusRecords
IL_030e: callvirt !0[] System.Collections.Generic.List`1<System.String>::ToArray()
IL_0313: stfld System.String[] ForestProbe/FocusTrace::records
IL_0318: dup
IL_0319: ldarg.0
IL_031a: ldfld System.Boolean ForestProbe::focusLimited
IL_031f: stfld System.Boolean ForestProbe/FocusTrace::limited
IL_0324: ldc.i4.1
IL_0325: call System.String UnityEngine.JsonUtility::ToJson(System.Object,System.Boolean)
IL_032a: call System.Void System.IO.File::WriteAllText(System.String,System.String)
IL_032f: nop
IL_0330: ret
METHOD System.String ForestProbe::KeyboardEligibility() | attributes=Private, Static, HideBySig | impl=IL
IL_0000: newobj System.Void ForestProbe/<>c__DisplayClass29_0::.ctor()
IL_0005: stloc.0
IL_0006: nop
IL_0007: ldtoken Rewired.ReInput
IL_000c: call System.Type System.Type::GetTypeFromHandle(System.RuntimeTypeHandle)
IL_0011: stloc.1
IL_0012: ldc.i4.s 56
IL_0014: stloc.2
IL_0015: ldloc.0
IL_0016: ldloc.1
IL_0017: ldstr "GGbNxxBRsPVtXooKvddzWaNspLr"
IL_001c: ldloc.2
IL_001d: callvirt System.Reflection.FieldInfo System.Type::GetField(System.String,System.Reflection.BindingFlags)
IL_0022: ldnull
IL_0023: callvirt System.Object System.Reflection.FieldInfo::GetValue(System.Object)
IL_0028: stfld System.Object ForestProbe/<>c__DisplayClass29_0::watchers
IL_002d: ldloc.0
IL_002e: ldftn System.Object ForestProbe/<>c__DisplayClass29_0::<KeyboardEligibility>b__0(System.String)
IL_0034: newobj System.Void System.Func`2<System.String,System.Object>::.ctor(System.Object,System.IntPtr)
IL_0039: stloc.3
IL_003a: ldc.i4.s 18
IL_003c: newarr System.String
IL_0041: dup
IL_0042: ldc.i4.0
IL_0043: ldstr " | rewiredReady="
IL_0048: stelem.ref
IL_0049: dup
IL_004a: ldc.i4.1
IL_004b: call System.Boolean Rewired.ReInput::get_isReady()
IL_0050: stloc.s V_4
IL_0052: ldloca.s V_4
IL_0054: call System.String System.Boolean::ToString()
IL_0059: stelem.ref
IL_005a: dup
IL_005b: ldc.i4.2
IL_005c: ldstr " | rewiredGlobalEnabled="
IL_0061: stelem.ref
IL_0062: dup
IL_0063: ldc.i4.3
IL_0064: ldloc.1
IL_0065: ldstr "aLzbAjHdyinuPAkYilYZkIGyBOc"
IL_006a: ldloc.2
IL_006b: callvirt System.Reflection.FieldInfo System.Type::GetField(System.String,System.Reflection.BindingFlags)
IL_0070: ldnull
IL_0071: callvirt System.Object System.Reflection.FieldInfo::GetValue(System.Object)
IL_0076: dup
IL_0077: brtrue.s IL_007d
IL_0079: pop
IL_007a: ldnull
IL_007b: br.s IL_0082
IL_007d: callvirt System.String System.Object::ToString()
IL_0082: stelem.ref
IL_0083: dup
IL_0084: ldc.i4.4
IL_0085: ldstr " | rewiredFilter="
IL_008a: stelem.ref
IL_008b: dup
IL_008c: ldc.i4.5
IL_008d: ldloc.1
IL_008e: ldstr "NPfefDCOwXSjdltUbdIpmiYqZmUC"
IL_0093: ldloc.2
IL_0094: callvirt System.Reflection.FieldInfo System.Type::GetField(System.String,System.Reflection.BindingFlags)
IL_0099: ldnull
IL_009a: callvirt System.Object System.Reflection.FieldInfo::GetValue(System.Object)
IL_009f: dup
IL_00a0: brtrue.s IL_00a6
IL_00a2: pop
IL_00a3: ldnull
IL_00a4: br.s IL_00ab
IL_00a6: callvirt System.String System.Object::ToString()
IL_00ab: stelem.ref
IL_00ac: dup
IL_00ad: ldc.i4.6
IL_00ae: ldstr " | rewiredFocusWatcher="
IL_00b3: stelem.ref
IL_00b4: dup
IL_00b5: ldc.i4.7
IL_00b6: ldloc.3
IL_00b7: ldstr "QBAmVSgbZBPmppTHWYNgMiDCmXg"
IL_00bc: callvirt !1 System.Func`2<System.String,System.Object>::Invoke(!0)
IL_00c1: dup
IL_00c2: brtrue.s IL_00c8
IL_00c4: pop
IL_00c5: ldnull
IL_00c6: br.s IL_00cd
IL_00c8: callvirt System.String System.Object::ToString()
IL_00cd: stelem.ref
IL_00ce: dup
IL_00cf: ldc.i4.8
IL_00d0: ldstr " | rewiredOtherWatcher="
IL_00d5: stelem.ref
IL_00d6: dup
IL_00d7: ldc.i4.s 9
IL_00d9: ldloc.3
IL_00da: ldstr "xIMFCrwXunWxoekBlleMmJYPdj"
IL_00df: callvirt !1 System.Func`2<System.String,System.Object>::Invoke(!0)
IL_00e4: dup
IL_00e5: brtrue.s IL_00eb
IL_00e7: pop
IL_00e8: ldnull
IL_00e9: br.s IL_00f0
IL_00eb: callvirt System.String System.Object::ToString()
IL_00f0: stelem.ref
IL_00f1: dup
IL_00f2: ldc.i4.s 10
IL_00f4: ldstr " | rewiredInputAllowed="
IL_00f9: stelem.ref
IL_00fa: dup
IL_00fb: ldc.i4.s 11
IL_00fd: ldloc.1
IL_00fe: ldstr "inputAllowed"
IL_0103: ldloc.2
IL_0104: callvirt System.Reflection.PropertyInfo System.Type::GetProperty(System.String,System.Reflection.BindingFlags)
IL_0109: ldnull
IL_010a: ldnull
IL_010b: callvirt System.Object System.Reflection.PropertyInfo::GetValue(System.Object,System.Object[])
IL_0110: dup
IL_0111: brtrue.s IL_0117
IL_0113: pop
IL_0114: ldnull
IL_0115: br.s IL_011c
IL_0117: callvirt System.String System.Object::ToString()
IL_011c: stelem.ref
IL_011d: dup
IL_011e: ldc.i4.s 12
IL_0120: ldstr " | rewiredKeyboardAllowed="
IL_0125: stelem.ref
IL_0126: dup
IL_0127: ldc.i4.s 13
IL_0129: ldloc.1
IL_012a: ldstr "IsInputAllowed"
IL_012f: ldloc.2
IL_0130: callvirt System.Reflection.MethodInfo System.Type::GetMethod(System.String,System.Reflection.BindingFlags)
IL_0135: ldnull
IL_0136: ldc.i4.1
IL_0137: newarr System.Object
IL_013c: dup
IL_013d: ldc.i4.0
IL_013e: ldc.i4.0
IL_013f: box Rewired.ControllerType
IL_0144: stelem.ref
IL_0145: callvirt System.Object System.Reflection.MethodBase::Invoke(System.Object,System.Object[])
IL_014a: dup
IL_014b: brtrue.s IL_0151
IL_014d: pop
IL_014e: ldnull
IL_014f: br.s IL_0156
IL_0151: callvirt System.String System.Object::ToString()
IL_0156: stelem.ref
IL_0157: dup
IL_0158: ldc.i4.s 14
IL_015a: ldstr " | nativeKeyboard="
IL_015f: stelem.ref
IL_0160: dup
IL_0161: ldc.i4.s 15
IL_0163: call Rewired.ReInput/ConfigHelper Rewired.ReInput::get_configuration()
IL_0168: callvirt System.Boolean Rewired.ReInput/ConfigHelper::get_nativeKeyboardSupport()
IL_016d: stloc.s V_4
IL_016f: ldloca.s V_4
IL_0171: call System.String System.Boolean::ToString()
IL_0176: stelem.ref
IL_0177: dup
IL_0178: ldc.i4.s 16
IL_017a: ldstr " | unityInput="
IL_017f: stelem.ref
IL_0180: dup
IL_0181: ldc.i4.s 17
IL_0183: call Rewired.ReInput/ConfigHelper Rewired.ReInput::get_configuration()
IL_0188: callvirt System.Boolean Rewired.ReInput/ConfigHelper::get_alwaysUseUnityInput()
IL_018d: stloc.s V_4
IL_018f: ldloca.s V_4
IL_0191: call System.String System.Boolean::ToString()
IL_0196: stelem.ref
IL_0197: call System.String System.String::Concat(System.String[])
IL_019c: stloc.s V_5
IL_019e: br.s IL_01a0
IL_01a0: ldloc.s V_5
IL_01a2: ret
METHOD System.String ForestProbe::KeyboardMaps(Rewired.Player) | attributes=Private, Static, HideBySig | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: ldnull
IL_0003: ceq
IL_0005: stloc.1
IL_0006: ldloc.1
IL_0007: brfalse.s IL_0014
IL_0009: ldstr "null"
IL_000e: stloc.2
IL_000f: br IL_02c3
IL_0014: newobj System.Void System.Collections.Generic.List`1<System.String>::.ctor()
IL_0019: stloc.0
IL_001a: nop
IL_001b: ldarg.0
IL_001c: ldfld Rewired.Player/ControllerHelper Rewired.Player::controllers
IL_0021: ldfld Rewired.Player/ControllerHelper/MapHelper Rewired.Player/ControllerHelper::maps
IL_0026: ldc.i4.0
IL_0027: callvirt System.Collections.Generic.IEnumerable`1<Rewired.ControllerMap> Rewired.Player/ControllerHelper/MapHelper::GetAllMaps(Rewired.ControllerType)
IL_002c: callvirt System.Collections.Generic.IEnumerator`1<!0> System.Collections.Generic.IEnumerable`1<Rewired.ControllerMap>::GetEnumerator()
IL_0031: stloc.3
IL_0032: br IL_0289
IL_0037: ldloc.3
IL_0038: callvirt !0 System.Collections.Generic.IEnumerator`1<Rewired.ControllerMap>::get_Current()
IL_003d: stloc.s V_4
IL_003f: nop
IL_0040: newobj System.Void System.Collections.Generic.List`1<System.String>::.ctor()
IL_0045: stloc.s V_5
IL_0047: nop
IL_0048: ldloc.s V_4
IL_004a: callvirt System.Collections.Generic.IList`1<Rewired.ActionElementMap> Rewired.ControllerMap::get_AllMaps()
IL_004f: callvirt System.Collections.Generic.IEnumerator`1<!0> System.Collections.Generic.IEnumerable`1<Rewired.ActionElementMap>::GetEnumerator()
IL_0054: stloc.s V_6
IL_0056: br IL_01c3
IL_005b: ldloc.s V_6
IL_005d: callvirt !0 System.Collections.Generic.IEnumerator`1<Rewired.ActionElementMap>::get_Current()
IL_0062: stloc.s V_7
IL_0064: ldloc.s V_7
IL_0066: callvirt System.Int32 Rewired.ActionElementMap::get_actionId()
IL_006b: brfalse.s IL_0079
IL_006d: ldloc.s V_7
IL_006f: callvirt System.Int32 Rewired.ActionElementMap::get_actionId()
IL_0074: ldc.i4.1
IL_0075: ceq
IL_0077: br.s IL_007a
IL_0079: ldc.i4.1
IL_007a: stloc.s V_8
IL_007c: ldloc.s V_8
IL_007e: brfalse IL_01c3
IL_0083: ldloc.s V_5
IL_0085: ldc.i4.s 21
IL_0087: newarr System.String
IL_008c: dup
IL_008d: ldc.i4.0
IL_008e: ldstr "{"action":"
IL_0093: stelem.ref
IL_0094: dup
IL_0095: ldc.i4.1
IL_0096: ldloc.s V_7
IL_0098: callvirt System.Int32 Rewired.ActionElementMap::get_actionId()
IL_009d: stloc.s V_9
IL_009f: ldloca.s V_9
IL_00a1: call System.String System.Int32::ToString()
IL_00a6: stelem.ref
IL_00a7: dup
IL_00a8: ldc.i4.2
IL_00a9: ldstr ","key":"
IL_00ae: stelem.ref
IL_00af: dup
IL_00b0: ldc.i4.3
IL_00b1: ldloc.s V_7
IL_00b3: callvirt UnityEngine.KeyCode Rewired.ActionElementMap::get_keyCode()
IL_00b8: stloc.s V_9
IL_00ba: ldloca.s V_9
IL_00bc: call System.String System.Int32::ToString()
IL_00c1: stelem.ref
IL_00c2: dup
IL_00c3: ldc.i4.4
IL_00c4: ldstr ","type":"
IL_00c9: stelem.ref
IL_00ca: dup
IL_00cb: ldc.i4.5
IL_00cc: ldloc.s V_7
IL_00ce: callvirt Rewired.ControllerElementType Rewired.ActionElementMap::get_elementType()
IL_00d3: stloc.s V_9
IL_00d5: ldloca.s V_9
IL_00d7: call System.String System.Int32::ToString()
IL_00dc: stelem.ref
IL_00dd: dup
IL_00de: ldc.i4.6
IL_00df: ldstr ","range":"
IL_00e4: stelem.ref
IL_00e5: dup
IL_00e6: ldc.i4.7
IL_00e7: ldloc.s V_7
IL_00e9: callvirt Rewired.AxisRange Rewired.ActionElementMap::get_axisRange()
IL_00ee: stloc.s V_9
IL_00f0: ldloca.s V_9
IL_00f2: call System.String System.Int32::ToString()
IL_00f7: stelem.ref
IL_00f8: dup
IL_00f9: ldc.i4.8
IL_00fa: ldstr ","pole":"
IL_00ff: stelem.ref
IL_0100: dup
IL_0101: ldc.i4.s 9
IL_0103: ldloc.s V_7
IL_0105: callvirt Rewired.Pole Rewired.ActionElementMap::get_axisContribution()
IL_010a: stloc.s V_9
IL_010c: ldloca.s V_9
IL_010e: call System.String System.Int32::ToString()
IL_0113: stelem.ref
IL_0114: dup
IL_0115: ldc.i4.s 10
IL_0117: ldstr ","invert":"
IL_011c: stelem.ref
IL_011d: dup
IL_011e: ldc.i4.s 11
IL_0120: ldloc.s V_7
IL_0122: callvirt System.Boolean Rewired.ActionElementMap::get_invert()
IL_0127: brtrue.s IL_0130
IL_0129: ldstr "false"
IL_012e: br.s IL_0135
IL_0130: ldstr "true"
IL_0135: stelem.ref
IL_0136: dup
IL_0137: ldc.i4.s 12
IL_0139: ldstr ","enabled":"
IL_013e: stelem.ref
IL_013f: dup
IL_0140: ldc.i4.s 13
IL_0142: ldloc.s V_7
IL_0144: callvirt System.Boolean Rewired.ActionElementMap::get_enabled()
IL_0149: brtrue.s IL_0152
IL_014b: ldstr "false"
IL_0150: br.s IL_0157
IL_0152: ldstr "true"
IL_0157: stelem.ref
IL_0158: dup
IL_0159: ldc.i4.s 14
IL_015b: ldstr ","modifier1":"
IL_0160: stelem.ref
IL_0161: dup
IL_0162: ldc.i4.s 15
IL_0164: ldloc.s V_7
IL_0166: callvirt Rewired.ModifierKey Rewired.ActionElementMap::get_modifierKey1()
IL_016b: stloc.s V_9
IL_016d: ldloca.s V_9
IL_016f: call System.String System.Int32::ToString()
IL_0174: stelem.ref
IL_0175: dup
IL_0176: ldc.i4.s 16
IL_0178: ldstr ","modifier2":"
IL_017d: stelem.ref
IL_017e: dup
IL_017f: ldc.i4.s 17
IL_0181: ldloc.s V_7
IL_0183: callvirt Rewired.ModifierKey Rewired.ActionElementMap::get_modifierKey2()
IL_0188: stloc.s V_9
IL_018a: ldloca.s V_9
IL_018c: call System.String System.Int32::ToString()
IL_0191: stelem.ref
IL_0192: dup
IL_0193: ldc.i4.s 18
IL_0195: ldstr ","modifier3":"
IL_019a: stelem.ref
IL_019b: dup
IL_019c: ldc.i4.s 19
IL_019e: ldloc.s V_7
IL_01a0: callvirt Rewired.ModifierKey Rewired.ActionElementMap::get_modifierKey3()
IL_01a5: stloc.s V_9
IL_01a7: ldloca.s V_9
IL_01a9: call System.String System.Int32::ToString()
IL_01ae: stelem.ref
IL_01af: dup
IL_01b0: ldc.i4.s 20
IL_01b2: ldstr "}"
IL_01b7: stelem.ref
IL_01b8: call System.String System.String::Concat(System.String[])
IL_01bd: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_01c2: nop
IL_01c3: ldloc.s V_6
IL_01c5: callvirt System.Boolean System.Collections.IEnumerator::MoveNext()
IL_01ca: brtrue IL_005b
IL_01cf: leave.s IL_01de
IL_01d1: ldloc.s V_6
IL_01d3: brfalse.s IL_01dd
IL_01d5: ldloc.s V_6
IL_01d7: callvirt System.Void System.IDisposable::Dispose()
IL_01dc: nop
IL_01dd: endfinally
IL_01de: ldloc.0
IL_01df: ldc.i4.s 11
IL_01e1: newarr System.String
IL_01e6: dup
IL_01e7: ldc.i4.0
IL_01e8: ldstr "{"source":"
IL_01ed: stelem.ref
IL_01ee: dup
IL_01ef: ldc.i4.1
IL_01f0: ldloc.s V_4
IL_01f2: callvirt System.Int32 Rewired.ControllerMap::get_sourceMapId()
IL_01f7: stloc.s V_9
IL_01f9: ldloca.s V_9
IL_01fb: call System.String System.Int32::ToString()
IL_0200: stelem.ref
IL_0201: dup
IL_0202: ldc.i4.2
IL_0203: ldstr ","category":"
IL_0208: stelem.ref
IL_0209: dup
IL_020a: ldc.i4.3
IL_020b: ldloc.s V_4
IL_020d: callvirt System.Int32 Rewired.ControllerMap::get_categoryId()
IL_0212: stloc.s V_9
IL_0214: ldloca.s V_9
IL_0216: call System.String System.Int32::ToString()
IL_021b: stelem.ref
IL_021c: dup
IL_021d: ldc.i4.4
IL_021e: ldstr ","layout":"
IL_0223: stelem.ref
IL_0224: dup
IL_0225: ldc.i4.5
IL_0226: ldloc.s V_4
IL_0228: callvirt System.Int32 Rewired.ControllerMap::get_layoutId()
IL_022d: stloc.s V_9
IL_022f: ldloca.s V_9
IL_0231: call System.String System.Int32::ToString()
IL_0236: stelem.ref
IL_0237: dup
IL_0238: ldc.i4.6
IL_0239: ldstr ","enabled":"
IL_023e: stelem.ref
IL_023f: dup
IL_0240: ldc.i4.7
IL_0241: ldloc.s V_4
IL_0243: callvirt System.Boolean Rewired.ControllerMap::get_enabled()
IL_0248: brtrue.s IL_0251
IL_024a: ldstr "false"
IL_024f: br.s IL_0256
IL_0251: ldstr "true"
IL_0256: stelem.ref
IL_0257: dup
IL_0258: ldc.i4.8
IL_0259: ldstr ","movement":["
IL_025e: stelem.ref
IL_025f: dup
IL_0260: ldc.i4.s 9
IL_0262: ldstr ","
IL_0267: ldloc.s V_5
IL_0269: callvirt !0[] System.Collections.Generic.List`1<System.String>::ToArray()
IL_026e: call System.String System.String::Join(System.String,System.String[])
IL_0273: stelem.ref
IL_0274: dup
IL_0275: ldc.i4.s 10
IL_0277: ldstr "]}"
IL_027c: stelem.ref
IL_027d: call System.String System.String::Concat(System.String[])
IL_0282: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0287: nop
IL_0288: nop
IL_0289: ldloc.3
IL_028a: callvirt System.Boolean System.Collections.IEnumerator::MoveNext()
IL_028f: brtrue IL_0037
IL_0294: leave.s IL_02a1
IL_0296: ldloc.3
IL_0297: brfalse.s IL_02a0
IL_0299: ldloc.3
IL_029a: callvirt System.Void System.IDisposable::Dispose()
IL_029f: nop
IL_02a0: endfinally
IL_02a1: ldstr "{"maps":["
IL_02a6: ldstr ","
IL_02ab: ldloc.0
IL_02ac: callvirt !0[] System.Collections.Generic.List`1<System.String>::ToArray()
IL_02b1: call System.String System.String::Join(System.String,System.String[])
IL_02b6: ldstr "]}"
IL_02bb: call System.String System.String::Concat(System.String,System.String,System.String)
IL_02c0: stloc.2
IL_02c1: br.s IL_02c3
IL_02c3: ldloc.2
IL_02c4: ret
METHOD System.String ForestProbe::NaturalDoorTransition() | attributes=Private, Static, HideBySig | impl=IL
IL_0000: nop
IL_0001: newobj System.Void System.Collections.Generic.List`1<TheForestOfLove.Doorway>::.ctor()
IL_0006: stloc.0
IL_0007: nop
IL_0008: call !!0[] UnityEngine.Resources::FindObjectsOfTypeAll<TheForestOfLove.Doorway>()
IL_000d: stloc.1
IL_000e: ldc.i4.0
IL_000f: stloc.2
IL_0010: br.s IL_007d
IL_0012: ldloc.1
IL_0013: ldloc.2
IL_0014: ldelem.ref
IL_0015: stloc.3
IL_0016: ldloc.3
IL_0017: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_001c: callvirt UnityEngine.SceneManagement.Scene UnityEngine.GameObject::get_scene()
IL_0021: stloc.s V_5
IL_0023: ldloca.s V_5
IL_0025: call System.String UnityEngine.SceneManagement.Scene::get_name()
IL_002a: ldstr "BunnyHouse"
IL_002f: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0034: brfalse.s IL_006a
IL_0036: ldloc.3
IL_0037: ldstr "sceneName"
IL_003c: call System.Object ForestProbe::ReadField(System.Object,System.String)
IL_0041: call System.String ForestProbe::DiagnosticValue(System.Object)
IL_0046: ldstr "CentralForest"
IL_004b: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0050: brfalse.s IL_006a
IL_0052: ldloc.3
IL_0053: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0058: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_005d: ldstr "/Doorways/DoorwayToCentralForest"
IL_0062: ldc.i4.4
IL_0063: callvirt System.Boolean System.String::EndsWith(System.String,System.StringComparison)
IL_0068: br.s IL_006b
IL_006a: ldc.i4.0
IL_006b: stloc.s V_4
IL_006d: ldloc.s V_4
IL_006f: brfalse.s IL_0079
IL_0071: ldloc.0
IL_0072: ldloc.3
IL_0073: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Doorway>::Add(!0)
IL_0078: nop
IL_0079: ldloc.2
IL_007a: ldc.i4.1
IL_007b: add
IL_007c: stloc.2
IL_007d: ldloc.2
IL_007e: ldloc.1
IL_007f: ldlen
IL_0080: conv.i4
IL_0081: blt.s IL_0012
IL_0083: ldloc.0
IL_0084: callvirt System.Int32 System.Collections.Generic.List`1<TheForestOfLove.Doorway>::get_Count()
IL_0089: ldc.i4.1
IL_008a: beq.s IL_00a2
IL_008c: ldloc.0
IL_008d: callvirt System.Int32 System.Collections.Generic.List`1<TheForestOfLove.Doorway>::get_Count()
IL_0092: brfalse.s IL_009b
IL_0094: ldstr "ambiguous"
IL_0099: br.s IL_00a0
IL_009b: ldstr "absent"
IL_00a0: br.s IL_00b8
IL_00a2: ldloc.0
IL_00a3: ldc.i4.0
IL_00a4: callvirt !0 System.Collections.Generic.List`1<TheForestOfLove.Doorway>::get_Item(System.Int32)
IL_00a9: ldstr "transitioning"
IL_00ae: call System.Object ForestProbe::ReadField(System.Object,System.String)
IL_00b3: call System.String ForestProbe::DiagnosticValue(System.Object)
IL_00b8: stloc.s V_6
IL_00ba: br.s IL_00bc
IL_00bc: ldloc.s V_6
IL_00be: ret
METHOD System.Void ForestProbe::LateUpdate() | attributes=Private, HideBySig | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: ldstr "late"
IL_0007: ldstr "unknown"
IL_000c: call System.Void ForestProbe::ObserveFocus(System.String,System.String)
IL_0011: nop
IL_0012: ldarg.0
IL_0013: ldfld System.Boolean ForestProbe::samplingKeyboard
IL_0018: ldc.i4.0
IL_0019: ceq
IL_001b: stloc.s V_21
IL_001d: ldloc.s V_21
IL_001f: brfalse.s IL_0026
IL_0021: br IL_0791
IL_0026: ldarg.0
IL_0027: ldfld System.Collections.Generic.List`1<System.String> ForestProbe::keyboardSamples
IL_002c: callvirt System.Int32 System.Collections.Generic.List`1<System.String>::get_Count()
IL_0031: ldc.i4 1200
IL_0036: clt
IL_0038: ldc.i4.0
IL_0039: ceq
IL_003b: stloc.s V_22
IL_003d: ldloc.s V_22
IL_003f: brfalse.s IL_0054
IL_0041: nop
IL_0042: ldarg.0
IL_0043: ldc.i4.0
IL_0044: stfld System.Boolean ForestProbe::samplingKeyboard
IL_0049: ldstr "Keyboard sample exceeded bound"
IL_004e: newobj System.Void System.Exception::.ctor(System.String)
IL_0053: throw
IL_0054: ldc.i4 256
IL_0059: newarr System.Byte
IL_005e: stloc.0
IL_005f: ldloc.0
IL_0060: call System.Boolean ForestProbe::GetKeyboardState(System.Byte[])
IL_0065: stloc.1
IL_0066: call Rewired.ReInput/ControllerHelper Rewired.ReInput::get_controllers()
IL_006b: callvirt Rewired.Keyboard Rewired.ReInput/ControllerHelper::get_Keyboard()
IL_0070: stloc.2
IL_0071: call !!0 UnityEngine.Object::FindObjectOfType<TheForestOfLove.InputHelper>()
IL_0076: stloc.3
IL_0077: ldloc.3
IL_0078: ldnull
IL_0079: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_007e: brtrue.s IL_0092
IL_0080: ldloc.3
IL_0081: ldstr "player"
IL_0086: call System.Object ForestProbe::ReadField(System.Object,System.String)
IL_008b: isinst Rewired.Player
IL_0090: br.s IL_0093
IL_0092: ldnull
IL_0093: stloc.s V_4
IL_0095: call !!0 UnityEngine.Object::FindObjectOfType<TheForestOfLove.Player>()
IL_009a: stloc.s V_5
IL_009c: ldloc.s V_5
IL_009e: ldnull
IL_009f: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_00a4: brtrue.s IL_00af
IL_00a6: ldloc.s V_5
IL_00a8: callvirt !!0 UnityEngine.Component::GetComponent<UnityEngine.Rigidbody2D>()
IL_00ad: br.s IL_00b0
IL_00af: ldnull
IL_00b0: stloc.s V_6
IL_00b2: ldloc.1
IL_00b3: stloc.s V_7
IL_00b5: ldc.i4.1
IL_00b6: stloc.s V_8
IL_00b8: ldc.i4.1
IL_00b9: stloc.s V_9
IL_00bb: ldc.i4.1
IL_00bc: stloc.s V_10
IL_00be: ldloc.1
IL_00bf: stloc.s V_11
IL_00c1: ldc.i4.1
IL_00c2: stloc.s V_12
IL_00c4: ldc.i4.1
IL_00c5: stloc.s V_13
IL_00c7: ldc.i4.1
IL_00c8: stloc.s V_14
IL_00ca: newobj System.Void System.Collections.Generic.List`1<System.String>::.ctor()
IL_00cf: stloc.s V_15
IL_00d1: newobj System.Void System.Collections.Generic.List`1<System.String>::.ctor()
IL_00d6: stloc.s V_16
IL_00d8: newobj System.Void System.Collections.Generic.List`1<System.String>::.ctor()
IL_00dd: stloc.s V_17
IL_00df: newobj System.Void System.Collections.Generic.List`1<System.String>::.ctor()
IL_00e4: stloc.s V_18
IL_00e6: ldc.i4.8
IL_00e7: newarr System.Int32
IL_00ec: dup
IL_00ed: ldtoken <PrivateImplementationDetails>/__StaticArrayInitTypeSize=32 <PrivateImplementationDetails>::FA9DA32EF86D16DF93F9B68A1A3F1B6CCDF0CC0AFE42E955879466B9A07FA39C
IL_00f2: call System.Void System.Runtime.CompilerServices.RuntimeHelpers::InitializeArray(System.Array,System.RuntimeFieldHandle)
IL_00f7: stloc.s V_19
IL_00f9: ldc.i4.8
IL_00fa: newarr UnityEngine.KeyCode
IL_00ff: dup
IL_0100: ldtoken <PrivateImplementationDetails>/__StaticArrayInitTypeSize=32 <PrivateImplementationDetails>::4FC069E5F273C875F43BF5FF04803EE4E98A9BB05490E5E1EA9139F51CBACE4A
IL_0105: call System.Void System.Runtime.CompilerServices.RuntimeHelpers::InitializeArray(System.Array,System.RuntimeFieldHandle)
IL_010a: stloc.s V_20
IL_010c: ldc.i4.0
IL_010d: stloc.s V_23
IL_010f: br IL_0217
IL_0114: nop
IL_0115: ldloc.0
IL_0116: ldloc.s V_19
IL_0118: ldloc.s V_23
IL_011a: ldelem.i4
IL_011b: ldelem.u1
IL_011c: ldc.i4 128
IL_0121: and
IL_0122: ldc.i4.0
IL_0123: cgt.un
IL_0125: stloc.s V_24
IL_0127: ldloc.s V_19
IL_0129: ldloc.s V_23
IL_012b: ldelem.i4
IL_012c: call System.Int16 ForestProbe::GetAsyncKeyState(System.Int32)
IL_0131: ldc.i4 32768
IL_0136: and
IL_0137: ldc.i4.0
IL_0138: cgt.un
IL_013a: stloc.s V_25
IL_013c: ldloc.2
IL_013d: ldloc.s V_20
IL_013f: ldloc.s V_23
IL_0141: ldelem.i4
IL_0142: callvirt System.Boolean Rewired.Keyboard::GetKey(UnityEngine.KeyCode)
IL_0147: stloc.s V_26
IL_0149: ldloc.s V_20
IL_014b: ldloc.s V_23
IL_014d: ldelem.i4
IL_014e: call System.Boolean UnityEngine.Input::GetKey(UnityEngine.KeyCode)
IL_0153: stloc.s V_27
IL_0155: ldloc.s V_20
IL_0157: ldloc.s V_23
IL_0159: ldelema UnityEngine.KeyCode
IL_015e: constrained. UnityEngine.KeyCode
IL_0164: callvirt System.String System.Object::ToString()
IL_0169: stloc.s V_28
IL_016b: ldloc.s V_24
IL_016d: stloc.s V_29
IL_016f: ldloc.s V_29
IL_0171: brfalse.s IL_017d
IL_0173: ldloc.s V_15
IL_0175: ldloc.s V_28
IL_0177: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_017c: nop
IL_017d: ldloc.s V_25
IL_017f: stloc.s V_30
IL_0181: ldloc.s V_30
IL_0183: brfalse.s IL_018f
IL_0185: ldloc.s V_16
IL_0187: ldloc.s V_28
IL_0189: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_018e: nop
IL_018f: ldloc.s V_26
IL_0191: stloc.s V_31
IL_0193: ldloc.s V_31
IL_0195: brfalse.s IL_01a1
IL_0197: ldloc.s V_17
IL_0199: ldloc.s V_28
IL_019b: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_01a0: nop
IL_01a1: ldloc.s V_27
IL_01a3: stloc.s V_32
IL_01a5: ldloc.s V_32
IL_01a7: brfalse.s IL_01b3
IL_01a9: ldloc.s V_18
IL_01ab: ldloc.s V_28
IL_01ad: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_01b2: nop
IL_01b3: ldloc.s V_11
IL_01b5: ldloc.s V_24
IL_01b7: ldc.i4.0
IL_01b8: ceq
IL_01ba: and
IL_01bb: stloc.s V_11
IL_01bd: ldloc.s V_12
IL_01bf: ldloc.s V_25
IL_01c1: ldc.i4.0
IL_01c2: ceq
IL_01c4: and
IL_01c5: stloc.s V_12
IL_01c7: ldloc.s V_13
IL_01c9: ldloc.s V_26
IL_01cb: ldc.i4.0
IL_01cc: ceq
IL_01ce: and
IL_01cf: stloc.s V_13
IL_01d1: ldloc.s V_14
IL_01d3: ldloc.s V_27
IL_01d5: ldc.i4.0
IL_01d6: ceq
IL_01d8: and
IL_01d9: stloc.s V_14
IL_01db: ldloc.s V_23
IL_01dd: ldc.i4.4
IL_01de: clt
IL_01e0: stloc.s V_33
IL_01e2: ldloc.s V_33
IL_01e4: brfalse.s IL_0210
IL_01e6: nop
IL_01e7: ldloc.s V_7
IL_01e9: ldloc.s V_24
IL_01eb: ldc.i4.0
IL_01ec: ceq
IL_01ee: and
IL_01ef: stloc.s V_7
IL_01f1: ldloc.s V_8
IL_01f3: ldloc.s V_25
IL_01f5: ldc.i4.0
IL_01f6: ceq
IL_01f8: and
IL_01f9: stloc.s V_8
IL_01fb: ldloc.s V_9
IL_01fd: ldloc.s V_26
IL_01ff: ldc.i4.0
IL_0200: ceq
IL_0202: and
IL_0203: stloc.s V_9
IL_0205: ldloc.s V_10
IL_0207: ldloc.s V_27
IL_0209: ldc.i4.0
IL_020a: ceq
IL_020c: and
IL_020d: stloc.s V_10
IL_020f: nop
IL_0210: nop
IL_0211: ldloc.s V_23
IL_0213: ldc.i4.1
IL_0214: add
IL_0215: stloc.s V_23
IL_0217: ldloc.s V_23
IL_0219: ldloc.s V_19
IL_021b: ldlen
IL_021c: conv.i4
IL_021d: clt
IL_021f: stloc.s V_34
IL_0221: ldloc.s V_34
IL_0223: brtrue IL_0114
IL_0228: ldarg.0
IL_0229: ldfld System.Collections.Generic.List`1<System.String> ForestProbe::keyboardSamples
IL_022e: ldc.i4.s 91
IL_0230: newarr System.String
IL_0235: dup
IL_0236: ldc.i4.0
IL_0237: ldstr "keyboard | frame="
IL_023c: stelem.ref
IL_023d: dup
IL_023e: ldc.i4.1
IL_023f: call System.Int32 UnityEngine.Time::get_frameCount()
IL_0244: stloc.s V_35
IL_0246: ldloca.s V_35
IL_0248: call System.String System.Int32::ToString()
IL_024d: stelem.ref
IL_024e: dup
IL_024f: ldc.i4.2
IL_0250: ldstr " | scaledTime="
IL_0255: stelem.ref
IL_0256: dup
IL_0257: ldc.i4.3
IL_0258: call System.Single UnityEngine.Time::get_time()
IL_025d: stloc.s V_36
IL_025f: ldloca.s V_36
IL_0261: call System.String System.Single::ToString()
IL_0266: stelem.ref
IL_0267: dup
IL_0268: ldc.i4.4
IL_0269: ldstr " | timeScale="
IL_026e: stelem.ref
IL_026f: dup
IL_0270: ldc.i4.5
IL_0271: call System.Single UnityEngine.Time::get_timeScale()
IL_0276: stloc.s V_36
IL_0278: ldloca.s V_36
IL_027a: call System.String System.Single::ToString()
IL_027f: stelem.ref
IL_0280: dup
IL_0281: ldc.i4.6
IL_0282: ldstr " | time="
IL_0287: stelem.ref
IL_0288: dup
IL_0289: ldc.i4.7
IL_028a: call System.Single UnityEngine.Time::get_realtimeSinceStartup()
IL_028f: stloc.s V_36
IL_0291: ldloca.s V_36
IL_0293: call System.String System.Single::ToString()
IL_0298: stelem.ref
IL_0299: dup
IL_029a: ldc.i4.8
IL_029b: ldstr " | winPid="
IL_02a0: stelem.ref
IL_02a1: dup
IL_02a2: ldc.i4.s 9
IL_02a4: call System.UInt32 ForestProbe::GetCurrentProcessId()
IL_02a9: stloc.s V_37
IL_02ab: ldloca.s V_37
IL_02ad: call System.String System.UInt32::ToString()
IL_02b2: stelem.ref
IL_02b3: dup
IL_02b4: ldc.i4.s 10
IL_02b6: ldstr " | focused="
IL_02bb: stelem.ref
IL_02bc: dup
IL_02bd: ldc.i4.s 11
IL_02bf: call System.Boolean UnityEngine.Application::get_isFocused()
IL_02c4: stloc.s V_38
IL_02c6: ldloca.s V_38
IL_02c8: call System.String System.Boolean::ToString()
IL_02cd: stelem.ref
IL_02ce: dup
IL_02cf: ldc.i4.s 12
IL_02d1: ldstr " | ignoreUnfocused="
IL_02d6: stelem.ref
IL_02d7: dup
IL_02d8: ldc.i4.s 13
IL_02da: call Rewired.ReInput/ConfigHelper Rewired.ReInput::get_configuration()
IL_02df: callvirt System.Boolean Rewired.ReInput/ConfigHelper::get_ignoreInputWhenAppNotInFocus()
IL_02e4: stloc.s V_38
IL_02e6: ldloca.s V_38
IL_02e8: call System.String System.Boolean::ToString()
IL_02ed: stelem.ref
IL_02ee: dup
IL_02ef: ldc.i4.s 14
IL_02f1: call System.String ForestProbe::KeyboardEligibility()
IL_02f6: stelem.ref
IL_02f7: dup
IL_02f8: ldc.i4.s 15
IL_02fa: ldstr " | nativeValid="
IL_02ff: stelem.ref
IL_0300: dup
IL_0301: ldc.i4.s 16
IL_0303: ldloca.s V_1
IL_0305: call System.String System.Boolean::ToString()
IL_030a: stelem.ref
IL_030b: dup
IL_030c: ldc.i4.s 17
IL_030e: ldstr " | nativeLeft="
IL_0313: stelem.ref
IL_0314: dup
IL_0315: ldc.i4.s 18
IL_0317: ldloc.0
IL_0318: ldc.i4.s 37
IL_031a: ldelem.u1
IL_031b: ldc.i4 128
IL_0320: and
IL_0321: ldc.i4.0
IL_0322: cgt.un
IL_0324: stloc.s V_38
IL_0326: ldloca.s V_38
IL_0328: call System.String System.Boolean::ToString()
IL_032d: stelem.ref
IL_032e: dup
IL_032f: ldc.i4.s 19
IL_0331: ldstr " | asyncLeft="
IL_0336: stelem.ref
IL_0337: dup
IL_0338: ldc.i4.s 20
IL_033a: ldc.i4.s 37
IL_033c: call System.Int16 ForestProbe::GetAsyncKeyState(System.Int32)
IL_0341: ldc.i4 32768
IL_0346: and
IL_0347: ldc.i4.0
IL_0348: cgt.un
IL_034a: stloc.s V_38
IL_034c: ldloca.s V_38
IL_034e: call System.String System.Boolean::ToString()
IL_0353: stelem.ref
IL_0354: dup
IL_0355: ldc.i4.s 21
IL_0357: ldstr " | rewiredLeft="
IL_035c: stelem.ref
IL_035d: dup
IL_035e: ldc.i4.s 22
IL_0360: ldloc.2
IL_0361: ldc.i4 276
IL_0366: callvirt System.Boolean Rewired.Keyboard::GetKey(UnityEngine.KeyCode)
IL_036b: stloc.s V_38
IL_036d: ldloca.s V_38
IL_036f: call System.String System.Boolean::ToString()
IL_0374: stelem.ref
IL_0375: dup
IL_0376: ldc.i4.s 23
IL_0378: ldstr " | keyboardEnabled="
IL_037d: stelem.ref
IL_037e: dup
IL_037f: ldc.i4.s 24
IL_0381: ldloc.2
IL_0382: callvirt System.Boolean Rewired.Controller::get_enabled()
IL_0387: stloc.s V_38
IL_0389: ldloca.s V_38
IL_038b: call System.String System.Boolean::ToString()
IL_0390: stelem.ref
IL_0391: dup
IL_0392: ldc.i4.s 25
IL_0394: ldstr " | unityLeft="
IL_0399: stelem.ref
IL_039a: dup
IL_039b: ldc.i4.s 26
IL_039d: ldc.i4 276
IL_03a2: call System.Boolean UnityEngine.Input::GetKey(UnityEngine.KeyCode)
IL_03a7: stloc.s V_38
IL_03a9: ldloca.s V_38
IL_03ab: call System.String System.Boolean::ToString()
IL_03b0: stelem.ref
IL_03b1: dup
IL_03b2: ldc.i4.s 27
IL_03b4: ldstr " | player="
IL_03b9: stelem.ref
IL_03ba: dup
IL_03bb: ldc.i4.s 28
IL_03bd: ldloc.s V_4
IL_03bf: brfalse.s IL_03e4
IL_03c1: ldloc.s V_4
IL_03c3: callvirt System.Int32 Rewired.Player::get_id()
IL_03c8: stloc.s V_35
IL_03ca: ldloca.s V_35
IL_03cc: call System.String System.Int32::ToString()
IL_03d1: ldstr ":"
IL_03d6: ldloc.s V_4
IL_03d8: callvirt System.String Rewired.Player::get_name()
IL_03dd: call System.String System.String::Concat(System.String,System.String,System.String)
IL_03e2: br.s IL_03e9
IL_03e4: ldstr "null"
IL_03e9: stelem.ref
IL_03ea: dup
IL_03eb: ldc.i4.s 29
IL_03ed: ldstr " | keyboardMaps="
IL_03f2: stelem.ref
IL_03f3: dup
IL_03f4: ldc.i4.s 30
IL_03f6: ldloc.s V_4
IL_03f8: call System.String ForestProbe::KeyboardMaps(Rewired.Player)
IL_03fd: stelem.ref
IL_03fe: dup
IL_03ff: ldc.i4.s 31
IL_0401: ldstr " | actionAxes="
IL_0406: stelem.ref
IL_0407: dup
IL_0408: ldc.i4.s 32
IL_040a: ldloc.s V_4
IL_040c: brfalse.s IL_0423
IL_040e: ldloc.s V_4
IL_0410: ldc.i4.0
IL_0411: ldc.i4.1
IL_0412: callvirt UnityEngine.Vector2 Rewired.Player::GetAxis2D(System.Int32,System.Int32)
IL_0417: call UnityEngine.Vector3 UnityEngine.Vector2::op_Implicit(UnityEngine.Vector2)
IL_041c: call System.String ForestProbe::Vector(UnityEngine.Vector3)
IL_0421: br.s IL_0428
IL_0423: ldstr "null"
IL_0428: stelem.ref
IL_0429: dup
IL_042a: ldc.i4.s 33
IL_042c: ldstr " | fullAxis="
IL_0431: stelem.ref
IL_0432: dup
IL_0433: ldc.i4.s 34
IL_0435: call UnityEngine.Vector3 TheForestOfLove.InputHelper::get_FullAxis()
IL_043a: call System.String ForestProbe::Vector(UnityEngine.Vector3)
IL_043f: stelem.ref
IL_0440: dup
IL_0441: ldc.i4.s 35
IL_0443: ldstr " | nativeArrowsUp="
IL_0448: stelem.ref
IL_0449: dup
IL_044a: ldc.i4.s 36
IL_044c: ldloca.s V_7
IL_044e: call System.String System.Boolean::ToString()
IL_0453: stelem.ref
IL_0454: dup
IL_0455: ldc.i4.s 37
IL_0457: ldstr " | asyncArrowsUp="
IL_045c: stelem.ref
IL_045d: dup
IL_045e: ldc.i4.s 38
IL_0460: ldloca.s V_8
IL_0462: call System.String System.Boolean::ToString()
IL_0467: stelem.ref
IL_0468: dup
IL_0469: ldc.i4.s 39
IL_046b: ldstr " | rewiredArrowsUp="
IL_0470: stelem.ref
IL_0471: dup
IL_0472: ldc.i4.s 40
IL_0474: ldloca.s V_9
IL_0476: call System.String System.Boolean::ToString()
IL_047b: stelem.ref
IL_047c: dup
IL_047d: ldc.i4.s 41
IL_047f: ldstr " | unityArrowsUp="
IL_0484: stelem.ref
IL_0485: dup
IL_0486: ldc.i4.s 42
IL_0488: ldloca.s V_10
IL_048a: call System.String System.Boolean::ToString()
IL_048f: stelem.ref
IL_0490: dup
IL_0491: ldc.i4.s 43
IL_0493: ldstr " | nativeMovementUp="
IL_0498: stelem.ref
IL_0499: dup
IL_049a: ldc.i4.s 44
IL_049c: ldloca.s V_11
IL_049e: call System.String System.Boolean::ToString()
IL_04a3: stelem.ref
IL_04a4: dup
IL_04a5: ldc.i4.s 45
IL_04a7: ldstr " | asyncMovementUp="
IL_04ac: stelem.ref
IL_04ad: dup
IL_04ae: ldc.i4.s 46
IL_04b0: ldloca.s V_12
IL_04b2: call System.String System.Boolean::ToString()
IL_04b7: stelem.ref
IL_04b8: dup
IL_04b9: ldc.i4.s 47
IL_04bb: ldstr " | rewiredMovementUp="
IL_04c0: stelem.ref
IL_04c1: dup
IL_04c2: ldc.i4.s 48
IL_04c4: ldloca.s V_13
IL_04c6: call System.String System.Boolean::ToString()
IL_04cb: stelem.ref
IL_04cc: dup
IL_04cd: ldc.i4.s 49
IL_04cf: ldstr " | unityMovementUp="
IL_04d4: stelem.ref
IL_04d5: dup
IL_04d6: ldc.i4.s 50
IL_04d8: ldloca.s V_14
IL_04da: call System.String System.Boolean::ToString()
IL_04df: stelem.ref
IL_04e0: dup
IL_04e1: ldc.i4.s 51
IL_04e3: ldstr " | nativeMovementDown="
IL_04e8: stelem.ref
IL_04e9: dup
IL_04ea: ldc.i4.s 52
IL_04ec: ldstr ","
IL_04f1: ldloc.s V_15
IL_04f3: callvirt !0[] System.Collections.Generic.List`1<System.String>::ToArray()
IL_04f8: call System.String System.String::Join(System.String,System.String[])
IL_04fd: stelem.ref
IL_04fe: dup
IL_04ff: ldc.i4.s 53
IL_0501: ldstr " | asyncMovementDown="
IL_0506: stelem.ref
IL_0507: dup
IL_0508: ldc.i4.s 54
IL_050a: ldstr ","
IL_050f: ldloc.s V_16
IL_0511: callvirt !0[] System.Collections.Generic.List`1<System.String>::ToArray()
IL_0516: call System.String System.String::Join(System.String,System.String[])
IL_051b: stelem.ref
IL_051c: dup
IL_051d: ldc.i4.s 55
IL_051f: ldstr " | rewiredMovementDown="
IL_0524: stelem.ref
IL_0525: dup
IL_0526: ldc.i4.s 56
IL_0528: ldstr ","
IL_052d: ldloc.s V_17
IL_052f: callvirt !0[] System.Collections.Generic.List`1<System.String>::ToArray()
IL_0534: call System.String System.String::Join(System.String,System.String[])
IL_0539: stelem.ref
IL_053a: dup
IL_053b: ldc.i4.s 57
IL_053d: ldstr " | unityMovementDown="
IL_0542: stelem.ref
IL_0543: dup
IL_0544: ldc.i4.s 58
IL_0546: ldstr ","
IL_054b: ldloc.s V_18
IL_054d: callvirt !0[] System.Collections.Generic.List`1<System.String>::ToArray()
IL_0552: call System.String System.String::Join(System.String,System.String[])
IL_0557: stelem.ref
IL_0558: dup
IL_0559: ldc.i4.s 59
IL_055b: ldstr " | scene="
IL_0560: stelem.ref
IL_0561: dup
IL_0562: ldc.i4.s 60
IL_0564: call UnityEngine.SceneManagement.Scene UnityEngine.SceneManagement.SceneManager::GetActiveScene()
IL_0569: stloc.s V_39
IL_056b: ldloca.s V_39
IL_056d: call System.String UnityEngine.SceneManagement.Scene::get_name()
IL_0572: stelem.ref
IL_0573: dup
IL_0574: ldc.i4.s 61
IL_0576: ldstr " | routeDoorTransition="
IL_057b: stelem.ref
IL_057c: dup
IL_057d: ldc.i4.s 62
IL_057f: call System.String ForestProbe::NaturalDoorTransition()
IL_0584: stelem.ref
IL_0585: dup
IL_0586: ldc.i4.s 63
IL_0588: ldstr " | gameplay="
IL_058d: stelem.ref
IL_058e: dup
IL_058f: ldc.i4.s 64
IL_0591: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inGameplayScene()
IL_0596: stloc.s V_38
IL_0598: ldloca.s V_38
IL_059a: call System.String System.Boolean::ToString()
IL_059f: stelem.ref
IL_05a0: dup
IL_05a1: ldc.i4.s 65
IL_05a3: ldstr " | anyEvent="
IL_05a8: stelem.ref
IL_05a9: dup
IL_05aa: ldc.i4.s 66
IL_05ac: call System.Boolean TheForestOfLove.Events.GameStateManager::get_isAnyEventActive()
IL_05b1: stloc.s V_38
IL_05b3: ldloca.s V_38
IL_05b5: call System.String System.Boolean::ToString()
IL_05ba: stelem.ref
IL_05bb: dup
IL_05bc: ldc.i4.s 67
IL_05be: ldstr " | conversation="
IL_05c3: stelem.ref
IL_05c4: dup
IL_05c5: ldc.i4.s 68
IL_05c7: call System.Boolean PixelCrushers.DialogueSystem.DialogueManager::get_isConversationActive()
IL_05cc: stloc.s V_38
IL_05ce: ldloca.s V_38
IL_05d0: call System.String System.Boolean::ToString()
IL_05d5: stelem.ref
IL_05d6: dup
IL_05d7: ldc.i4.s 69
IL_05d9: ldstr " | dustin="
IL_05de: stelem.ref
IL_05df: dup
IL_05e0: ldc.i4.s 70
IL_05e2: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inDustinMinigame()
IL_05e7: stloc.s V_38
IL_05e9: ldloca.s V_38
IL_05eb: call System.String System.Boolean::ToString()
IL_05f0: stelem.ref
IL_05f1: dup
IL_05f2: ldc.i4.s 71
IL_05f4: ldstr " | glitch="
IL_05f9: stelem.ref
IL_05fa: dup
IL_05fb: ldc.i4.s 72
IL_05fd: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inGlitchRoom()
IL_0602: stloc.s V_38
IL_0604: ldloca.s V_38
IL_0606: call System.String System.Boolean::ToString()
IL_060b: stelem.ref
IL_060c: dup
IL_060d: ldc.i4.s 73
IL_060f: ldstr " | actor="
IL_0614: stelem.ref
IL_0615: dup
IL_0616: ldc.i4.s 74
IL_0618: ldloc.s V_5
IL_061a: call System.String ForestProbe::ObjectAddress(System.Object)
IL_061f: stelem.ref
IL_0620: dup
IL_0621: ldc.i4.s 75
IL_0623: ldstr " | body="
IL_0628: stelem.ref
IL_0629: dup
IL_062a: ldc.i4.s 76
IL_062c: ldloc.s V_6
IL_062e: call System.String ForestProbe::ObjectAddress(System.Object)
IL_0633: stelem.ref
IL_0634: dup
IL_0635: ldc.i4.s 77
IL_0637: ldstr " | actorPosition="
IL_063c: stelem.ref
IL_063d: dup
IL_063e: ldc.i4.s 78
IL_0640: ldloc.s V_5
IL_0642: ldnull
IL_0643: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0648: brtrue.s IL_065d
IL_064a: ldloc.s V_5
IL_064c: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0651: callvirt UnityEngine.Vector3 UnityEngine.Transform::get_position()
IL_0656: call System.String ForestProbe::Vector(UnityEngine.Vector3)
IL_065b: br.s IL_0662
IL_065d: ldstr "null"
IL_0662: stelem.ref
IL_0663: dup
IL_0664: ldc.i4.s 79
IL_0666: ldstr " | bodyPosition="
IL_066b: stelem.ref
IL_066c: dup
IL_066d: ldc.i4.s 80
IL_066f: ldloc.s V_6
IL_0671: ldnull
IL_0672: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0677: brtrue.s IL_068c
IL_0679: ldloc.s V_6
IL_067b: callvirt UnityEngine.Vector2 UnityEngine.Rigidbody2D::get_position()
IL_0680: call UnityEngine.Vector3 UnityEngine.Vector2::op_Implicit(UnityEngine.Vector2)
IL_0685: call System.String ForestProbe::Vector(UnityEngine.Vector3)
IL_068a: br.s IL_0691
IL_068c: ldstr "null"
IL_0691: stelem.ref
IL_0692: dup
IL_0693: ldc.i4.s 81
IL_0695: ldstr " | bodyVelocity="
IL_069a: stelem.ref
IL_069b: dup
IL_069c: ldc.i4.s 82
IL_069e: ldloc.s V_6
IL_06a0: ldnull
IL_06a1: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_06a6: brtrue.s IL_06bb
IL_06a8: ldloc.s V_6
IL_06aa: callvirt UnityEngine.Vector2 UnityEngine.Rigidbody2D::get_velocity()
IL_06af: call UnityEngine.Vector3 UnityEngine.Vector2::op_Implicit(UnityEngine.Vector2)
IL_06b4: call System.String ForestProbe::Vector(UnityEngine.Vector3)
IL_06b9: br.s IL_06c0
IL_06bb: ldstr "null"
IL_06c0: stelem.ref
IL_06c1: dup
IL_06c2: ldc.i4.s 83
IL_06c4: ldstr " | movement="
IL_06c9: stelem.ref
IL_06ca: dup
IL_06cb: ldc.i4.s 84
IL_06cd: ldloc.s V_5
IL_06cf: ldnull
IL_06d0: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_06d5: brtrue.s IL_06ea
IL_06d7: ldloc.s V_5
IL_06d9: ldstr "enableMovement"
IL_06de: call System.Object ForestProbe::ReadField(System.Object,System.String)
IL_06e3: call System.String ForestProbe::DiagnosticValue(System.Object)
IL_06e8: br.s IL_06ef
IL_06ea: ldstr "null"
IL_06ef: stelem.ref
IL_06f0: dup
IL_06f1: ldc.i4.s 85
IL_06f3: ldstr " | lanternTransition="
IL_06f8: stelem.ref
IL_06f9: dup
IL_06fa: ldc.i4.s 86
IL_06fc: ldloc.s V_5
IL_06fe: ldnull
IL_06ff: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0704: brfalse.s IL_070f
IL_0706: ldloc.s V_5
IL_0708: callvirt System.Boolean TheForestOfLove.Player::get_lanternTransitioning()
IL_070d: br.s IL_0710
IL_070f: ldc.i4.0
IL_0710: stloc.s V_38
IL_0712: ldloca.s V_38
IL_0714: call System.String System.Boolean::ToString()
IL_0719: stelem.ref
IL_071a: dup
IL_071b: ldc.i4.s 87
IL_071d: ldstr " | sweaterTransition="
IL_0722: stelem.ref
IL_0723: dup
IL_0724: ldc.i4.s 88
IL_0726: ldloc.s V_5
IL_0728: ldnull
IL_0729: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_072e: brfalse.s IL_0739
IL_0730: ldloc.s V_5
IL_0732: callvirt System.Boolean TheForestOfLove.Player::get_sweaterTransitioning()
IL_0737: br.s IL_073a
IL_0739: ldc.i4.0
IL_073a: stloc.s V_38
IL_073c: ldloca.s V_38
IL_073e: call System.String System.Boolean::ToString()
IL_0743: stelem.ref
IL_0744: dup
IL_0745: ldc.i4.s 89
IL_0747: ldstr " | waypoints="
IL_074c: stelem.ref
IL_074d: dup
IL_074e: ldc.i4.s 90
IL_0750: ldloc.s V_5
IL_0752: ldnull
IL_0753: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0758: brtrue.s IL_0780
IL_075a: ldloc.s V_5
IL_075c: callvirt TheForestOfLove.WaypointController TheForestOfLove.Player::get_waypointController()
IL_0761: ldnull
IL_0762: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0767: brtrue.s IL_0780
IL_0769: ldloc.s V_5
IL_076b: callvirt TheForestOfLove.WaypointController TheForestOfLove.Player::get_waypointController()
IL_0770: callvirt System.Boolean TheForestOfLove.WaypointController::get_HasWaypoints()
IL_0775: stloc.s V_38
IL_0777: ldloca.s V_38
IL_0779: call System.String System.Boolean::ToString()
IL_077e: br.s IL_0785
IL_0780: ldstr "absent"
IL_0785: stelem.ref
IL_0786: call System.String System.String::Concat(System.String[])
IL_078b: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0790: nop
IL_0791: ret
METHOD System.Collections.IEnumerator ForestProbe::Capture(System.String) | attributes=Private, HideBySig | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.IteratorStateMachineAttribute
IL_0000: ldc.i4.0
IL_0001: newobj System.Void ForestProbe/<Capture>d__33::.ctor(System.Int32)
IL_0006: dup
IL_0007: ldarg.0
IL_0008: stfld ForestProbe ForestProbe/<Capture>d__33::<>4__this
IL_000d: dup
IL_000e: ldarg.1
IL_000f: stfld System.String ForestProbe/<Capture>d__33::path
IL_0014: ret
METHOD System.String ForestProbe::DiagnosticValue(System.Object) | attributes=Private, Static, HideBySig | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: ldnull
IL_0003: ceq
IL_0005: stloc.2
IL_0006: ldloc.2
IL_0007: brfalse.s IL_0014
IL_0009: ldstr "null"
IL_000e: stloc.3
IL_000f: br IL_0094
IL_0014: ldarg.0
IL_0015: callvirt System.Type System.Object::GetType()
IL_001a: stloc.0
IL_001b: ldloc.0
IL_001c: callvirt System.Boolean System.Type::get_IsPrimitive()
IL_0021: brtrue.s IL_0036
IL_0023: ldloc.0
IL_0024: callvirt System.Boolean System.Type::get_IsEnum()
IL_0029: brtrue.s IL_0036
IL_002b: ldarg.0
IL_002c: isinst System.String
IL_0031: ldnull
IL_0032: cgt.un
IL_0034: br.s IL_0037
IL_0036: ldc.i4.1
IL_0037: stloc.s V_4
IL_0039: ldloc.s V_4
IL_003b: brfalse.s IL_0046
IL_003d: ldarg.0
IL_003e: callvirt System.String System.Object::ToString()
IL_0043: stloc.3
IL_0044: br.s IL_0094
IL_0046: ldloc.0
IL_0047: ldstr "dbName"
IL_004c: ldc.i4.s 20
IL_004e: callvirt System.Reflection.FieldInfo System.Type::GetField(System.String,System.Reflection.BindingFlags)
IL_0053: stloc.1
IL_0054: ldloc.0
IL_0055: callvirt System.String System.Reflection.MemberInfo::get_Name()
IL_005a: ldloc.1
IL_005b: ldnull
IL_005c: call System.Boolean System.Reflection.FieldInfo::op_Equality(System.Reflection.FieldInfo,System.Reflection.FieldInfo)
IL_0061: brtrue.s IL_0087
IL_0063: ldstr "("
IL_0068: ldloc.1
IL_0069: ldarg.0
IL_006a: callvirt System.Object System.Reflection.FieldInfo::GetValue(System.Object)
IL_006f: dup
IL_0070: brtrue.s IL_0076
IL_0072: pop
IL_0073: ldnull
IL_0074: br.s IL_007b
IL_0076: callvirt System.String System.Object::ToString()
IL_007b: ldstr ")"
IL_0080: call System.String System.String::Concat(System.String,System.String,System.String)
IL_0085: br.s IL_008c
IL_0087: ldstr ""
IL_008c: call System.String System.String::Concat(System.String,System.String)
IL_0091: stloc.3
IL_0092: br.s IL_0094
IL_0094: ldloc.3
IL_0095: ret
METHOD System.Object ForestProbe::ReadField(System.Object,System.String) | attributes=Private, Static, HideBySig | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: ldnull
IL_0003: ceq
IL_0005: stloc.1
IL_0006: ldloc.1
IL_0007: brfalse.s IL_000d
IL_0009: ldnull
IL_000a: stloc.2
IL_000b: br.s IL_0052
IL_000d: ldarg.0
IL_000e: callvirt System.Type System.Object::GetType()
IL_0013: ldarg.1
IL_0014: ldc.i4.s 52
IL_0016: callvirt System.Reflection.FieldInfo System.Type::GetField(System.String,System.Reflection.BindingFlags)
IL_001b: stloc.0
IL_001c: ldloc.0
IL_001d: ldnull
IL_001e: call System.Boolean System.Reflection.FieldInfo::op_Equality(System.Reflection.FieldInfo,System.Reflection.FieldInfo)
IL_0023: stloc.3
IL_0024: ldloc.3
IL_0025: brfalse.s IL_0048
IL_0027: ldstr "Unknown diagnostic field: "
IL_002c: ldarg.0
IL_002d: callvirt System.Type System.Object::GetType()
IL_0032: callvirt System.String System.Reflection.MemberInfo::get_Name()
IL_0037: ldstr "."
IL_003c: ldarg.1
IL_003d: call System.String System.String::Concat(System.String,System.String,System.String,System.String)
IL_0042: newobj System.Void System.Exception::.ctor(System.String)
IL_0047: throw
IL_0048: ldloc.0
IL_0049: ldarg.0
IL_004a: callvirt System.Object System.Reflection.FieldInfo::GetValue(System.Object)
IL_004f: stloc.2
IL_0050: br.s IL_0052
IL_0052: ldloc.2
IL_0053: ret
METHOD System.String ForestProbe::ObjectAddress(System.Object) | attributes=Private, Static, HideBySig | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: isinst UnityEngine.Component
IL_0007: stloc.0
IL_0008: ldloc.0
IL_0009: ldnull
IL_000a: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_000f: brtrue.s IL_0036
IL_0011: ldloc.0
IL_0012: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0017: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_001c: ldstr "#"
IL_0021: ldloc.0
IL_0022: callvirt System.Int32 UnityEngine.Object::GetInstanceID()
IL_0027: stloc.1
IL_0028: ldloca.s V_1
IL_002a: call System.String System.Int32::ToString()
IL_002f: call System.String System.String::Concat(System.String,System.String,System.String)
IL_0034: br.s IL_003c
IL_0036: ldarg.0
IL_0037: call System.String ForestProbe::DiagnosticValue(System.Object)
IL_003c: stloc.2
IL_003d: br.s IL_003f
IL_003f: ldloc.2
IL_0040: ret
METHOD System.String ForestProbe::ListValues(System.Collections.IEnumerable) | attributes=Private, Static, HideBySig | impl=IL
IL_0000: nop
IL_0001: newobj System.Void System.Collections.Generic.List`1<System.String>::.ctor()
IL_0006: stloc.0
IL_0007: ldarg.0
IL_0008: ldnull
IL_0009: cgt.un
IL_000b: stloc.1
IL_000c: ldloc.1
IL_000d: brfalse.s IL_006f
IL_000f: nop
IL_0010: ldarg.0
IL_0011: callvirt System.Collections.IEnumerator System.Collections.IEnumerable::GetEnumerator()
IL_0016: stloc.2
IL_0017: br.s IL_0050
IL_0019: ldloc.2
IL_001a: callvirt System.Object System.Collections.IEnumerator::get_Current()
IL_001f: stloc.3
IL_0020: nop
IL_0021: ldloc.0
IL_0022: callvirt System.Int32 System.Collections.Generic.List`1<System.String>::get_Count()
IL_0027: ldc.i4 128
IL_002c: clt
IL_002e: ldc.i4.0
IL_002f: ceq
IL_0031: stloc.s V_4
IL_0033: ldloc.s V_4
IL_0035: brfalse.s IL_0042
IL_0037: ldstr "Unexpected diagnostic collection size"
IL_003c: newobj System.Void System.Exception::.ctor(System.String)
IL_0041: throw
IL_0042: ldloc.0
IL_0043: ldloc.3
IL_0044: call System.String ForestProbe::DiagnosticValue(System.Object)
IL_0049: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_004e: nop
IL_004f: nop
IL_0050: ldloc.2
IL_0051: callvirt System.Boolean System.Collections.IEnumerator::MoveNext()
IL_0056: brtrue.s IL_0019
IL_0058: leave.s IL_006f
IL_005a: ldloc.2
IL_005b: isinst System.IDisposable
IL_0060: stloc.s V_5
IL_0062: ldloc.s V_5
IL_0064: brfalse.s IL_006e
IL_0066: ldloc.s V_5
IL_0068: callvirt System.Void System.IDisposable::Dispose()
IL_006d: nop
IL_006e: endfinally
IL_006f: ldstr ","
IL_0074: ldloc.0
IL_0075: callvirt !0[] System.Collections.Generic.List`1<System.String>::ToArray()
IL_007a: call System.String System.String::Join(System.String,System.String[])
IL_007f: stloc.s V_6
IL_0081: br.s IL_0083
IL_0083: ldloc.s V_6
IL_0085: ret
METHOD System.String ForestProbe::Vector(UnityEngine.Vector3) | attributes=Private, Static, HideBySig | impl=IL
IL_0000: nop
IL_0001: call System.Globalization.CultureInfo System.Globalization.CultureInfo::get_InvariantCulture()
IL_0006: ldstr "{0:R},{1:R},{2:R}"
IL_000b: ldarg.0
IL_000c: ldfld System.Single UnityEngine.Vector3::x
IL_0011: box System.Single
IL_0016: ldarg.0
IL_0017: ldfld System.Single UnityEngine.Vector3::y
IL_001c: box System.Single
IL_0021: ldarg.0
IL_0022: ldfld System.Single UnityEngine.Vector3::z
IL_0027: box System.Single
IL_002c: call System.String System.String::Format(System.IFormatProvider,System.String,System.Object,System.Object,System.Object)
IL_0031: stloc.0
IL_0032: br.s IL_0034
IL_0034: ldloc.0
IL_0035: ret
METHOD System.Void ForestProbe::TravelColliders(System.Collections.Generic.List`1<System.String>,UnityEngine.Component) | attributes=Private, Static, HideBySig | impl=IL
IL_0000: nop
IL_0001: nop
IL_0002: ldarg.1
IL_0003: ldc.i4.1
IL_0004: callvirt !!0[] UnityEngine.Component::GetComponentsInChildren<UnityEngine.Collider2D>(System.Boolean)
IL_0009: stloc.0
IL_000a: ldc.i4.0
IL_000b: stloc.1
IL_000c: br IL_0202
IL_0011: ldloc.0
IL_0012: ldloc.1
IL_0013: ldelem.ref
IL_0014: stloc.2
IL_0015: nop
IL_0016: ldloc.2
IL_0017: callvirt UnityEngine.Rigidbody2D UnityEngine.Collider2D::get_attachedRigidbody()
IL_001c: stloc.3
IL_001d: ldarg.0
IL_001e: ldc.i4.s 32
IL_0020: newarr System.String
IL_0025: dup
IL_0026: ldc.i4.0
IL_0027: ldstr "travelCollider | owner="
IL_002c: stelem.ref
IL_002d: dup
IL_002e: ldc.i4.1
IL_002f: ldarg.1
IL_0030: callvirt System.Int32 UnityEngine.Object::GetInstanceID()
IL_0035: stloc.s V_4
IL_0037: ldloca.s V_4
IL_0039: call System.String System.Int32::ToString()
IL_003e: stelem.ref
IL_003f: dup
IL_0040: ldc.i4.2
IL_0041: ldstr " | id="
IL_0046: stelem.ref
IL_0047: dup
IL_0048: ldc.i4.3
IL_0049: ldloc.2
IL_004a: callvirt System.Int32 UnityEngine.Object::GetInstanceID()
IL_004f: stloc.s V_4
IL_0051: ldloca.s V_4
IL_0053: call System.String System.Int32::ToString()
IL_0058: stelem.ref
IL_0059: dup
IL_005a: ldc.i4.4
IL_005b: ldstr " | path="
IL_0060: stelem.ref
IL_0061: dup
IL_0062: ldc.i4.5
IL_0063: ldloc.2
IL_0064: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0069: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_006e: stelem.ref
IL_006f: dup
IL_0070: ldc.i4.6
IL_0071: ldstr " | type="
IL_0076: stelem.ref
IL_0077: dup
IL_0078: ldc.i4.7
IL_0079: ldloc.2
IL_007a: callvirt System.Type System.Object::GetType()
IL_007f: callvirt System.String System.Reflection.MemberInfo::get_Name()
IL_0084: stelem.ref
IL_0085: dup
IL_0086: ldc.i4.8
IL_0087: ldstr " | active="
IL_008c: stelem.ref
IL_008d: dup
IL_008e: ldc.i4.s 9
IL_0090: ldloc.2
IL_0091: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0096: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_009b: stloc.s V_5
IL_009d: ldloca.s V_5
IL_009f: call System.String System.Boolean::ToString()
IL_00a4: stelem.ref
IL_00a5: dup
IL_00a6: ldc.i4.s 10
IL_00a8: ldstr " | enabled="
IL_00ad: stelem.ref
IL_00ae: dup
IL_00af: ldc.i4.s 11
IL_00b1: ldloc.2
IL_00b2: callvirt System.Boolean UnityEngine.Behaviour::get_enabled()
IL_00b7: stloc.s V_5
IL_00b9: ldloca.s V_5
IL_00bb: call System.String System.Boolean::ToString()
IL_00c0: stelem.ref
IL_00c1: dup
IL_00c2: ldc.i4.s 12
IL_00c4: ldstr " | trigger="
IL_00c9: stelem.ref
IL_00ca: dup
IL_00cb: ldc.i4.s 13
IL_00cd: ldloc.2
IL_00ce: callvirt System.Boolean UnityEngine.Collider2D::get_isTrigger()
IL_00d3: stloc.s V_5
IL_00d5: ldloca.s V_5
IL_00d7: call System.String System.Boolean::ToString()
IL_00dc: stelem.ref
IL_00dd: dup
IL_00de: ldc.i4.s 14
IL_00e0: ldstr " | tag="
IL_00e5: stelem.ref
IL_00e6: dup
IL_00e7: ldc.i4.s 15
IL_00e9: ldloc.2
IL_00ea: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_00ef: callvirt System.String UnityEngine.GameObject::get_tag()
IL_00f4: stelem.ref
IL_00f5: dup
IL_00f6: ldc.i4.s 16
IL_00f8: ldstr " | layer="
IL_00fd: stelem.ref
IL_00fe: dup
IL_00ff: ldc.i4.s 17
IL_0101: ldloc.2
IL_0102: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0107: callvirt System.Int32 UnityEngine.GameObject::get_layer()
IL_010c: stloc.s V_4
IL_010e: ldloca.s V_4
IL_0110: call System.String System.Int32::ToString()
IL_0115: stelem.ref
IL_0116: dup
IL_0117: ldc.i4.s 18
IL_0119: ldstr " | offset="
IL_011e: stelem.ref
IL_011f: dup
IL_0120: ldc.i4.s 19
IL_0122: ldloc.2
IL_0123: callvirt UnityEngine.Vector2 UnityEngine.Collider2D::get_offset()
IL_0128: call UnityEngine.Vector3 UnityEngine.Vector2::op_Implicit(UnityEngine.Vector2)
IL_012d: call System.String ForestProbe::Vector(UnityEngine.Vector3)
IL_0132: stelem.ref
IL_0133: dup
IL_0134: ldc.i4.s 20
IL_0136: ldstr " | boundsCenter="
IL_013b: stelem.ref
IL_013c: dup
IL_013d: ldc.i4.s 21
IL_013f: ldloc.2
IL_0140: callvirt UnityEngine.Bounds UnityEngine.Collider2D::get_bounds()
IL_0145: stloc.s V_6
IL_0147: ldloca.s V_6
IL_0149: call UnityEngine.Vector3 UnityEngine.Bounds::get_center()
IL_014e: call System.String ForestProbe::Vector(UnityEngine.Vector3)
IL_0153: stelem.ref
IL_0154: dup
IL_0155: ldc.i4.s 22
IL_0157: ldstr " | boundsSize="
IL_015c: stelem.ref
IL_015d: dup
IL_015e: ldc.i4.s 23
IL_0160: ldloc.2
IL_0161: callvirt UnityEngine.Bounds UnityEngine.Collider2D::get_bounds()
IL_0166: stloc.s V_6
IL_0168: ldloca.s V_6
IL_016a: call UnityEngine.Vector3 UnityEngine.Bounds::get_size()
IL_016f: call System.String ForestProbe::Vector(UnityEngine.Vector3)
IL_0174: stelem.ref
IL_0175: dup
IL_0176: ldc.i4.s 24
IL_0178: ldstr " | boundsMin="
IL_017d: stelem.ref
IL_017e: dup
IL_017f: ldc.i4.s 25
IL_0181: ldloc.2
IL_0182: callvirt UnityEngine.Bounds UnityEngine.Collider2D::get_bounds()
IL_0187: stloc.s V_6
IL_0189: ldloca.s V_6
IL_018b: call UnityEngine.Vector3 UnityEngine.Bounds::get_min()
IL_0190: call System.String ForestProbe::Vector(UnityEngine.Vector3)
IL_0195: stelem.ref
IL_0196: dup
IL_0197: ldc.i4.s 26
IL_0199: ldstr " | boundsMax="
IL_019e: stelem.ref
IL_019f: dup
IL_01a0: ldc.i4.s 27
IL_01a2: ldloc.2
IL_01a3: callvirt UnityEngine.Bounds UnityEngine.Collider2D::get_bounds()
IL_01a8: stloc.s V_6
IL_01aa: ldloca.s V_6
IL_01ac: call UnityEngine.Vector3 UnityEngine.Bounds::get_max()
IL_01b1: call System.String ForestProbe::Vector(UnityEngine.Vector3)
IL_01b6: stelem.ref
IL_01b7: dup
IL_01b8: ldc.i4.s 28
IL_01ba: ldstr " | rigidbody="
IL_01bf: stelem.ref
IL_01c0: dup
IL_01c1: ldc.i4.s 29
IL_01c3: ldloc.3
IL_01c4: call System.String ForestProbe::ObjectAddress(System.Object)
IL_01c9: stelem.ref
IL_01ca: dup
IL_01cb: ldc.i4.s 30
IL_01cd: ldstr " | simulated="
IL_01d2: stelem.ref
IL_01d3: dup
IL_01d4: ldc.i4.s 31
IL_01d6: ldloc.3
IL_01d7: ldnull
IL_01d8: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_01dd: brfalse.s IL_01e7
IL_01df: ldloc.3
IL_01e0: callvirt System.Boolean UnityEngine.Rigidbody2D::get_simulated()
IL_01e5: br.s IL_01e8
IL_01e7: ldc.i4.0
IL_01e8: stloc.s V_5
IL_01ea: ldloca.s V_5
IL_01ec: call System.String System.Boolean::ToString()
IL_01f1: stelem.ref
IL_01f2: call System.String System.String::Concat(System.String[])
IL_01f7: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_01fc: nop
IL_01fd: nop
IL_01fe: ldloc.1
IL_01ff: ldc.i4.1
IL_0200: add
IL_0201: stloc.1
IL_0202: ldloc.1
IL_0203: ldloc.0
IL_0204: ldlen
IL_0205: conv.i4
IL_0206: blt IL_0011
IL_020b: nop
IL_020c: ldarg.1
IL_020d: ldc.i4.1
IL_020e: callvirt !!0[] UnityEngine.Component::GetComponentsInChildren<UnityEngine.Rigidbody2D>(System.Boolean)
IL_0213: stloc.s V_7
IL_0215: ldc.i4.0
IL_0216: stloc.s V_8
IL_0218: br IL_03c6
IL_021d: ldloc.s V_7
IL_021f: ldloc.s V_8
IL_0221: ldelem.ref
IL_0222: stloc.s V_9
IL_0224: ldarg.0
IL_0225: ldc.i4.s 26
IL_0227: newarr System.String
IL_022c: dup
IL_022d: ldc.i4.0
IL_022e: ldstr "travelBody | owner="
IL_0233: stelem.ref
IL_0234: dup
IL_0235: ldc.i4.1
IL_0236: ldarg.1
IL_0237: callvirt System.Int32 UnityEngine.Object::GetInstanceID()
IL_023c: stloc.s V_4
IL_023e: ldloca.s V_4
IL_0240: call System.String System.Int32::ToString()
IL_0245: stelem.ref
IL_0246: dup
IL_0247: ldc.i4.2
IL_0248: ldstr " | id="
IL_024d: stelem.ref
IL_024e: dup
IL_024f: ldc.i4.3
IL_0250: ldloc.s V_9
IL_0252: callvirt System.Int32 UnityEngine.Object::GetInstanceID()
IL_0257: stloc.s V_4
IL_0259: ldloca.s V_4
IL_025b: call System.String System.Int32::ToString()
IL_0260: stelem.ref
IL_0261: dup
IL_0262: ldc.i4.4
IL_0263: ldstr " | path="
IL_0268: stelem.ref
IL_0269: dup
IL_026a: ldc.i4.5
IL_026b: ldloc.s V_9
IL_026d: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0272: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_0277: stelem.ref
IL_0278: dup
IL_0279: ldc.i4.6
IL_027a: ldstr " | active="
IL_027f: stelem.ref
IL_0280: dup
IL_0281: ldc.i4.7
IL_0282: ldloc.s V_9
IL_0284: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0289: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_028e: stloc.s V_5
IL_0290: ldloca.s V_5
IL_0292: call System.String System.Boolean::ToString()
IL_0297: stelem.ref
IL_0298: dup
IL_0299: ldc.i4.8
IL_029a: ldstr " | layer="
IL_029f: stelem.ref
IL_02a0: dup
IL_02a1: ldc.i4.s 9
IL_02a3: ldloc.s V_9
IL_02a5: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_02aa: callvirt System.Int32 UnityEngine.GameObject::get_layer()
IL_02af: stloc.s V_4
IL_02b1: ldloca.s V_4
IL_02b3: call System.String System.Int32::ToString()
IL_02b8: stelem.ref
IL_02b9: dup
IL_02ba: ldc.i4.s 10
IL_02bc: ldstr " | type="
IL_02c1: stelem.ref
IL_02c2: dup
IL_02c3: ldc.i4.s 11
IL_02c5: ldloc.s V_9
IL_02c7: callvirt UnityEngine.RigidbodyType2D UnityEngine.Rigidbody2D::get_bodyType()
IL_02cc: stloc.s V_10
IL_02ce: ldloca.s V_10
IL_02d0: constrained. UnityEngine.RigidbodyType2D
IL_02d6: callvirt System.String System.Object::ToString()
IL_02db: stelem.ref
IL_02dc: dup
IL_02dd: ldc.i4.s 12
IL_02df: ldstr " | simulated="
IL_02e4: stelem.ref
IL_02e5: dup
IL_02e6: ldc.i4.s 13
IL_02e8: ldloc.s V_9
IL_02ea: callvirt System.Boolean UnityEngine.Rigidbody2D::get_simulated()
IL_02ef: stloc.s V_5
IL_02f1: ldloca.s V_5
IL_02f3: call System.String System.Boolean::ToString()
IL_02f8: stelem.ref
IL_02f9: dup
IL_02fa: ldc.i4.s 14
IL_02fc: ldstr " | position="
IL_0301: stelem.ref
IL_0302: dup
IL_0303: ldc.i4.s 15
IL_0305: ldloc.s V_9
IL_0307: callvirt UnityEngine.Vector2 UnityEngine.Rigidbody2D::get_position()
IL_030c: call UnityEngine.Vector3 UnityEngine.Vector2::op_Implicit(UnityEngine.Vector2)
IL_0311: call System.String ForestProbe::Vector(UnityEngine.Vector3)
IL_0316: stelem.ref
IL_0317: dup
IL_0318: ldc.i4.s 16
IL_031a: ldstr " | velocity="
IL_031f: stelem.ref
IL_0320: dup
IL_0321: ldc.i4.s 17
IL_0323: ldloc.s V_9
IL_0325: callvirt UnityEngine.Vector2 UnityEngine.Rigidbody2D::get_velocity()
IL_032a: call UnityEngine.Vector3 UnityEngine.Vector2::op_Implicit(UnityEngine.Vector2)
IL_032f: call System.String ForestProbe::Vector(UnityEngine.Vector3)
IL_0334: stelem.ref
IL_0335: dup
IL_0336: ldc.i4.s 18
IL_0338: ldstr " | constraints="
IL_033d: stelem.ref
IL_033e: dup
IL_033f: ldc.i4.s 19
IL_0341: ldloc.s V_9
IL_0343: callvirt UnityEngine.RigidbodyConstraints2D UnityEngine.Rigidbody2D::get_constraints()
IL_0348: stloc.s V_11
IL_034a: ldloca.s V_11
IL_034c: constrained. UnityEngine.RigidbodyConstraints2D
IL_0352: callvirt System.String System.Object::ToString()
IL_0357: stelem.ref
IL_0358: dup
IL_0359: ldc.i4.s 20
IL_035b: ldstr " | gravityScale="
IL_0360: stelem.ref
IL_0361: dup
IL_0362: ldc.i4.s 21
IL_0364: ldloc.s V_9
IL_0366: callvirt System.Single UnityEngine.Rigidbody2D::get_gravityScale()
IL_036b: stloc.s V_12
IL_036d: ldloca.s V_12
IL_036f: call System.String System.Single::ToString()
IL_0374: stelem.ref
IL_0375: dup
IL_0376: ldc.i4.s 22
IL_0378: ldstr " | collisionDetection="
IL_037d: stelem.ref
IL_037e: dup
IL_037f: ldc.i4.s 23
IL_0381: ldloc.s V_9
IL_0383: callvirt UnityEngine.CollisionDetectionMode2D UnityEngine.Rigidbody2D::get_collisionDetectionMode()
IL_0388: stloc.s V_13
IL_038a: ldloca.s V_13
IL_038c: constrained. UnityEngine.CollisionDetectionMode2D
IL_0392: callvirt System.String System.Object::ToString()
IL_0397: stelem.ref
IL_0398: dup
IL_0399: ldc.i4.s 24
IL_039b: ldstr " | fullKinematicContacts="
IL_03a0: stelem.ref
IL_03a1: dup
IL_03a2: ldc.i4.s 25
IL_03a4: ldloc.s V_9
IL_03a6: callvirt System.Boolean UnityEngine.Rigidbody2D::get_useFullKinematicContacts()
IL_03ab: stloc.s V_5
IL_03ad: ldloca.s V_5
IL_03af: call System.String System.Boolean::ToString()
IL_03b4: stelem.ref
IL_03b5: call System.String System.String::Concat(System.String[])
IL_03ba: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_03bf: nop
IL_03c0: ldloc.s V_8
IL_03c2: ldc.i4.1
IL_03c3: add
IL_03c4: stloc.s V_8
IL_03c6: ldloc.s V_8
IL_03c8: ldloc.s V_7
IL_03ca: ldlen
IL_03cb: conv.i4
IL_03cc: blt IL_021d
IL_03d1: ret
METHOD System.String[] ForestProbe::TravelRouteDiagnostics() | attributes=Private, HideBySig | impl=IL
IL_0000: nop
IL_0001: newobj System.Void System.Collections.Generic.List`1<System.String>::.ctor()
IL_0006: stloc.0
IL_0007: ldloc.0
IL_0008: ldc.i4.s 12
IL_000a: newarr System.String
IL_000f: dup
IL_0010: ldc.i4.0
IL_0011: ldstr "travelGuards | gameplay="
IL_0016: stelem.ref
IL_0017: dup
IL_0018: ldc.i4.1
IL_0019: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inGameplayScene()
IL_001e: stloc.2
IL_001f: ldloca.s V_2
IL_0021: call System.String System.Boolean::ToString()
IL_0026: stelem.ref
IL_0027: dup
IL_0028: ldc.i4.2
IL_0029: ldstr " | anyEvent="
IL_002e: stelem.ref
IL_002f: dup
IL_0030: ldc.i4.3
IL_0031: call System.Boolean TheForestOfLove.Events.GameStateManager::get_isAnyEventActive()
IL_0036: stloc.2
IL_0037: ldloca.s V_2
IL_0039: call System.String System.Boolean::ToString()
IL_003e: stelem.ref
IL_003f: dup
IL_0040: ldc.i4.4
IL_0041: ldstr " | conversation="
IL_0046: stelem.ref
IL_0047: dup
IL_0048: ldc.i4.5
IL_0049: call System.Boolean PixelCrushers.DialogueSystem.DialogueManager::get_isConversationActive()
IL_004e: stloc.2
IL_004f: ldloca.s V_2
IL_0051: call System.String System.Boolean::ToString()
IL_0056: stelem.ref
IL_0057: dup
IL_0058: ldc.i4.6
IL_0059: ldstr " | focused="
IL_005e: stelem.ref
IL_005f: dup
IL_0060: ldc.i4.7
IL_0061: call System.Boolean UnityEngine.Application::get_isFocused()
IL_0066: stloc.2
IL_0067: ldloca.s V_2
IL_0069: call System.String System.Boolean::ToString()
IL_006e: stelem.ref
IL_006f: dup
IL_0070: ldc.i4.8
IL_0071: ldstr " | runInBackground="
IL_0076: stelem.ref
IL_0077: dup
IL_0078: ldc.i4.s 9
IL_007a: call System.Boolean UnityEngine.Application::get_runInBackground()
IL_007f: stloc.2
IL_0080: ldloca.s V_2
IL_0082: call System.String System.Boolean::ToString()
IL_0087: stelem.ref
IL_0088: dup
IL_0089: ldc.i4.s 10
IL_008b: ldstr " | axis="
IL_0090: stelem.ref
IL_0091: dup
IL_0092: ldc.i4.s 11
IL_0094: call UnityEngine.Vector3 TheForestOfLove.InputHelper::get_FullAxis()
IL_0099: call System.String ForestProbe::Vector(UnityEngine.Vector3)
IL_009e: stelem.ref
IL_009f: call System.String System.String::Concat(System.String[])
IL_00a4: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_00a9: nop
IL_00aa: call System.Boolean Rewired.ReInput::get_isReady()
IL_00af: stloc.3
IL_00b0: ldloc.3
IL_00b1: brfalse.s IL_010c
IL_00b3: ldloc.0
IL_00b4: ldc.i4.5
IL_00b5: newarr System.String
IL_00ba: dup
IL_00bb: ldc.i4.0
IL_00bc: ldstr "travelRewired | ignoreUnfocused="
IL_00c1: stelem.ref
IL_00c2: dup
IL_00c3: ldc.i4.1
IL_00c4: call Rewired.ReInput/ConfigHelper Rewired.ReInput::get_configuration()
IL_00c9: callvirt System.Boolean Rewired.ReInput/ConfigHelper::get_ignoreInputWhenAppNotInFocus()
IL_00ce: stloc.2
IL_00cf: ldloca.s V_2
IL_00d1: call System.String System.Boolean::ToString()
IL_00d6: stelem.ref
IL_00d7: dup
IL_00d8: ldc.i4.2
IL_00d9: ldstr " | keyboardEnabled="
IL_00de: stelem.ref
IL_00df: dup
IL_00e0: ldc.i4.3
IL_00e1: call Rewired.ReInput/ControllerHelper Rewired.ReInput::get_controllers()
IL_00e6: callvirt Rewired.Keyboard Rewired.ReInput/ControllerHelper::get_Keyboard()
IL_00eb: callvirt System.Boolean Rewired.Controller::get_enabled()
IL_00f0: stloc.2
IL_00f1: ldloca.s V_2
IL_00f3: call System.String System.Boolean::ToString()
IL_00f8: stelem.ref
IL_00f9: dup
IL_00fa: ldc.i4.4
IL_00fb: call System.String ForestProbe::KeyboardEligibility()
IL_0100: stelem.ref
IL_0101: call System.String System.String::Concat(System.String[])
IL_0106: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_010b: nop
IL_010c: nop
IL_010d: call !!0[] UnityEngine.Resources::FindObjectsOfTypeAll<TheForestOfLove.Player>()
IL_0112: stloc.s V_4
IL_0114: ldc.i4.0
IL_0115: stloc.s V_5
IL_0117: br IL_058a
IL_011c: ldloc.s V_4
IL_011e: ldloc.s V_5
IL_0120: ldelem.ref
IL_0121: stloc.s V_6
IL_0123: ldloc.s V_6
IL_0125: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_012a: callvirt UnityEngine.SceneManagement.Scene UnityEngine.GameObject::get_scene()
IL_012f: stloc.s V_8
IL_0131: ldloca.s V_8
IL_0133: call System.Boolean UnityEngine.SceneManagement.Scene::IsValid()
IL_0138: stloc.s V_7
IL_013a: ldloc.s V_7
IL_013c: brfalse IL_0584
IL_0141: nop
IL_0142: ldloc.s V_6
IL_0144: callvirt TheForestOfLove.WaypointController TheForestOfLove.Player::get_waypointController()
IL_0149: stloc.s V_9
IL_014b: ldloc.s V_6
IL_014d: ldstr "playerSwimTransition"
IL_0152: call System.Object ForestProbe::ReadField(System.Object,System.String)
IL_0157: stloc.s V_10
IL_0159: ldloc.0
IL_015a: ldc.i4.s 26
IL_015c: newarr System.String
IL_0161: dup
IL_0162: ldc.i4.0
IL_0163: ldstr "travelPlayer | id="
IL_0168: stelem.ref
IL_0169: dup
IL_016a: ldc.i4.1
IL_016b: ldloc.s V_6
IL_016d: callvirt System.Int32 UnityEngine.Object::GetInstanceID()
IL_0172: stloc.s V_12
IL_0174: ldloca.s V_12
IL_0176: call System.String System.Int32::ToString()
IL_017b: stelem.ref
IL_017c: dup
IL_017d: ldc.i4.2
IL_017e: ldstr " | path="
IL_0183: stelem.ref
IL_0184: dup
IL_0185: ldc.i4.3
IL_0186: ldloc.s V_6
IL_0188: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_018d: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_0192: stelem.ref
IL_0193: dup
IL_0194: ldc.i4.4
IL_0195: ldstr " | active="
IL_019a: stelem.ref
IL_019b: dup
IL_019c: ldc.i4.5
IL_019d: ldloc.s V_6
IL_019f: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_01a4: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_01a9: stloc.2
IL_01aa: ldloca.s V_2
IL_01ac: call System.String System.Boolean::ToString()
IL_01b1: stelem.ref
IL_01b2: dup
IL_01b3: ldc.i4.6
IL_01b4: ldstr " | enabled="
IL_01b9: stelem.ref
IL_01ba: dup
IL_01bb: ldc.i4.7
IL_01bc: ldloc.s V_6
IL_01be: callvirt System.Boolean UnityEngine.Behaviour::get_enabled()
IL_01c3: stloc.2
IL_01c4: ldloca.s V_2
IL_01c6: call System.String System.Boolean::ToString()
IL_01cb: stelem.ref
IL_01cc: dup
IL_01cd: ldc.i4.8
IL_01ce: ldstr " | position="
IL_01d3: stelem.ref
IL_01d4: dup
IL_01d5: ldc.i4.s 9
IL_01d7: ldloc.s V_6
IL_01d9: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_01de: callvirt UnityEngine.Vector3 UnityEngine.Transform::get_position()
IL_01e3: call System.String ForestProbe::Vector(UnityEngine.Vector3)
IL_01e8: stelem.ref
IL_01e9: dup
IL_01ea: ldc.i4.s 10
IL_01ec: ldstr " | state="
IL_01f1: stelem.ref
IL_01f2: dup
IL_01f3: ldc.i4.s 11
IL_01f5: ldloc.s V_6
IL_01f7: callvirt TheForestOfLove.PlayerState TheForestOfLove.Player::get_playerState()
IL_01fc: stloc.s V_13
IL_01fe: ldloca.s V_13
IL_0200: constrained. TheForestOfLove.PlayerState
IL_0206: callvirt System.String System.Object::ToString()
IL_020b: stelem.ref
IL_020c: dup
IL_020d: ldc.i4.s 12
IL_020f: ldstr " | speed="
IL_0214: stelem.ref
IL_0215: dup
IL_0216: ldc.i4.s 13
IL_0218: ldloc.s V_6
IL_021a: ldstr "speed"
IL_021f: call System.Object ForestProbe::ReadField(System.Object,System.String)
IL_0224: unbox.any UnityEngine.Vector2
IL_0229: call UnityEngine.Vector3 UnityEngine.Vector2::op_Implicit(UnityEngine.Vector2)
IL_022e: call System.String ForestProbe::Vector(UnityEngine.Vector3)
IL_0233: stelem.ref
IL_0234: dup
IL_0235: ldc.i4.s 14
IL_0237: ldstr " | currentSpeed="
IL_023c: stelem.ref
IL_023d: dup
IL_023e: ldc.i4.s 15
IL_0240: ldloc.s V_6
IL_0242: ldstr "currentSpeed"
IL_0247: call System.Object ForestProbe::ReadField(System.Object,System.String)
IL_024c: unbox.any UnityEngine.Vector2
IL_0251: call UnityEngine.Vector3 UnityEngine.Vector2::op_Implicit(UnityEngine.Vector2)
IL_0256: call System.String ForestProbe::Vector(UnityEngine.Vector3)
IL_025b: stelem.ref
IL_025c: dup
IL_025d: ldc.i4.s 16
IL_025f: ldstr " | movement="
IL_0264: stelem.ref
IL_0265: dup
IL_0266: ldc.i4.s 17
IL_0268: ldloc.s V_6
IL_026a: ldstr "enableMovement"
IL_026f: call System.Object ForestProbe::ReadField(System.Object,System.String)
IL_0274: dup
IL_0275: brtrue.s IL_027b
IL_0277: pop
IL_0278: ldnull
IL_0279: br.s IL_0280
IL_027b: callvirt System.String System.Object::ToString()
IL_0280: stelem.ref
IL_0281: dup
IL_0282: ldc.i4.s 18
IL_0284: ldstr " | lanternTransition="
IL_0289: stelem.ref
IL_028a: dup
IL_028b: ldc.i4.s 19
IL_028d: ldloc.s V_6
IL_028f: callvirt System.Boolean TheForestOfLove.Player::get_lanternTransitioning()
IL_0294: stloc.2
IL_0295: ldloca.s V_2
IL_0297: call System.String System.Boolean::ToString()
IL_029c: stelem.ref
IL_029d: dup
IL_029e: ldc.i4.s 20
IL_02a0: ldstr " | sweaterTransition="
IL_02a5: stelem.ref
IL_02a6: dup
IL_02a7: ldc.i4.s 21
IL_02a9: ldloc.s V_6
IL_02ab: callvirt System.Boolean TheForestOfLove.Player::get_sweaterTransitioning()
IL_02b0: stloc.2
IL_02b1: ldloca.s V_2
IL_02b3: call System.String System.Boolean::ToString()
IL_02b8: stelem.ref
IL_02b9: dup
IL_02ba: ldc.i4.s 22
IL_02bc: ldstr " | swim="
IL_02c1: stelem.ref
IL_02c2: dup
IL_02c3: ldc.i4.s 23
IL_02c5: ldloc.s V_10
IL_02c7: call System.String ForestProbe::ObjectAddress(System.Object)
IL_02cc: stelem.ref
IL_02cd: dup
IL_02ce: ldc.i4.s 24
IL_02d0: ldstr " | waypoints="
IL_02d5: stelem.ref
IL_02d6: dup
IL_02d7: ldc.i4.s 25
IL_02d9: ldloc.s V_9
IL_02db: ldnull
IL_02dc: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_02e1: brtrue.s IL_02f4
IL_02e3: ldloc.s V_9
IL_02e5: callvirt System.Boolean TheForestOfLove.WaypointController::get_HasWaypoints()
IL_02ea: stloc.2
IL_02eb: ldloca.s V_2
IL_02ed: call System.String System.Boolean::ToString()
IL_02f2: br.s IL_02f9
IL_02f4: ldstr "absent"
IL_02f9: stelem.ref
IL_02fa: call System.String System.String::Concat(System.String[])
IL_02ff: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0304: nop
IL_0305: ldloc.0
IL_0306: ldloc.s V_6
IL_0308: call System.Void ForestProbe::TravelColliders(System.Collections.Generic.List`1<System.String>,UnityEngine.Component)
IL_030d: nop
IL_030e: ldloc.s V_6
IL_0310: callvirt !!0 UnityEngine.Component::GetComponent<UnityEngine.CircleCollider2D>()
IL_0315: stloc.s V_11
IL_0317: ldloc.s V_11
IL_0319: ldnull
IL_031a: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_031f: brfalse.s IL_0338
IL_0321: ldloc.s V_11
IL_0323: callvirt System.Boolean UnityEngine.Behaviour::get_enabled()
IL_0328: brfalse.s IL_0338
IL_032a: ldloc.s V_6
IL_032c: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0331: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_0336: br.s IL_0339
IL_0338: ldc.i4.0
IL_0339: stloc.s V_14
IL_033b: ldloc.s V_14
IL_033d: brfalse IL_0583
IL_0342: nop
IL_0343: ldloca.s V_15
IL_0345: initobj UnityEngine.ContactFilter2D
IL_034b: ldloca.s V_15
IL_034d: ldc.i4.0
IL_034e: stfld System.Boolean UnityEngine.ContactFilter2D::useTriggers
IL_0353: ldloca.s V_15
IL_0355: ldloc.s V_11
IL_0357: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_035c: callvirt System.Int32 UnityEngine.GameObject::get_layer()
IL_0361: call System.Int32 UnityEngine.Physics2D::GetLayerCollisionMask(System.Int32)
IL_0366: call UnityEngine.LayerMask UnityEngine.LayerMask::op_Implicit(System.Int32)
IL_036b: call System.Void UnityEngine.ContactFilter2D::SetLayerMask(UnityEngine.LayerMask)
IL_0370: nop
IL_0371: nop
IL_0372: ldc.i4.2
IL_0373: newarr UnityEngine.Vector2
IL_0378: dup
IL_0379: ldc.i4.0
IL_037a: call UnityEngine.Vector2 UnityEngine.Vector2::get_left()
IL_037f: stelem.any UnityEngine.Vector2
IL_0384: dup
IL_0385: ldc.i4.1
IL_0386: call UnityEngine.Vector2 UnityEngine.Vector2::get_down()
IL_038b: stelem.any UnityEngine.Vector2
IL_0390: stloc.s V_16
IL_0392: ldc.i4.0
IL_0393: stloc.s V_17
IL_0395: br IL_0577
IL_039a: ldloc.s V_16
IL_039c: ldloc.s V_17
IL_039e: ldelem.any UnityEngine.Vector2
IL_03a3: stloc.s V_18
IL_03a5: nop
IL_03a6: ldloc.s V_18
IL_03a8: ldfld System.Single UnityEngine.Vector2::x
IL_03ad: ldc.r4 0
IL_03b2: blt.s IL_03bb
IL_03b4: ldstr "down"
IL_03b9: br.s IL_03c0
IL_03bb: ldstr "left"
IL_03c0: stloc.s V_19
IL_03c2: ldc.i4 128
IL_03c7: newarr UnityEngine.RaycastHit2D
IL_03cc: stloc.s V_20
IL_03ce: ldloc.s V_11
IL_03d0: ldloc.s V_18
IL_03d2: ldloc.s V_15
IL_03d4: ldloc.s V_20
IL_03d6: ldc.r4 1.2
IL_03db: ldc.i4.1
IL_03dc: callvirt System.Int32 UnityEngine.Collider2D::Cast(UnityEngine.Vector2,UnityEngine.ContactFilter2D,UnityEngine.RaycastHit2D[],System.Single,System.Boolean)
IL_03e1: stloc.s V_21
IL_03e3: ldloc.0
IL_03e4: ldc.i4.8
IL_03e5: newarr System.String
IL_03ea: dup
IL_03eb: ldc.i4.0
IL_03ec: ldstr "travelSweep | direction="
IL_03f1: stelem.ref
IL_03f2: dup
IL_03f3: ldc.i4.1
IL_03f4: ldloc.s V_19
IL_03f6: stelem.ref
IL_03f7: dup
IL_03f8: ldc.i4.2
IL_03f9: ldstr " | root="
IL_03fe: stelem.ref
IL_03ff: dup
IL_0400: ldc.i4.3
IL_0401: ldloc.s V_11
IL_0403: callvirt System.Int32 UnityEngine.Object::GetInstanceID()
IL_0408: stloc.s V_12
IL_040a: ldloca.s V_12
IL_040c: call System.String System.Int32::ToString()
IL_0411: stelem.ref
IL_0412: dup
IL_0413: ldc.i4.4
IL_0414: ldstr " | distance=1.2 | count="
IL_0419: stelem.ref
IL_041a: dup
IL_041b: ldc.i4.5
IL_041c: ldloca.s V_21
IL_041e: call System.String System.Int32::ToString()
IL_0423: stelem.ref
IL_0424: dup
IL_0425: ldc.i4.6
IL_0426: ldstr " | capacity="
IL_042b: stelem.ref
IL_042c: dup
IL_042d: ldc.i4.7
IL_042e: ldloc.s V_20
IL_0430: ldlen
IL_0431: conv.i4
IL_0432: stloc.s V_12
IL_0434: ldloca.s V_12
IL_0436: call System.String System.Int32::ToString()
IL_043b: stelem.ref
IL_043c: call System.String System.String::Concat(System.String[])
IL_0441: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0446: nop
IL_0447: ldc.i4.0
IL_0448: stloc.s V_22
IL_044a: br IL_0561
IL_044f: nop
IL_0450: ldloc.s V_20
IL_0452: ldloc.s V_22
IL_0454: ldelema UnityEngine.RaycastHit2D
IL_0459: call UnityEngine.Collider2D UnityEngine.RaycastHit2D::get_collider()
IL_045e: stloc.s V_23
IL_0460: ldloc.0
IL_0461: ldc.i4.s 16
IL_0463: newarr System.String
IL_0468: dup
IL_0469: ldc.i4.0
IL_046a: ldstr "travelSweepHit | direction="
IL_046f: stelem.ref
IL_0470: dup
IL_0471: ldc.i4.1
IL_0472: ldloc.s V_19
IL_0474: stelem.ref
IL_0475: dup
IL_0476: ldc.i4.2
IL_0477: ldstr " | collider="
IL_047c: stelem.ref
IL_047d: dup
IL_047e: ldc.i4.3
IL_047f: ldloc.s V_23
IL_0481: callvirt System.Int32 UnityEngine.Object::GetInstanceID()
IL_0486: stloc.s V_12
IL_0488: ldloca.s V_12
IL_048a: call System.String System.Int32::ToString()
IL_048f: stelem.ref
IL_0490: dup
IL_0491: ldc.i4.4
IL_0492: ldstr " | path="
IL_0497: stelem.ref
IL_0498: dup
IL_0499: ldc.i4.5
IL_049a: ldloc.s V_23
IL_049c: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_04a1: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_04a6: stelem.ref
IL_04a7: dup
IL_04a8: ldc.i4.6
IL_04a9: ldstr " | distance="
IL_04ae: stelem.ref
IL_04af: dup
IL_04b0: ldc.i4.7
IL_04b1: ldloc.s V_20
IL_04b3: ldloc.s V_22
IL_04b5: ldelema UnityEngine.RaycastHit2D
IL_04ba: call System.Single UnityEngine.RaycastHit2D::get_distance()
IL_04bf: stloc.s V_24
IL_04c1: ldloca.s V_24
IL_04c3: call System.String System.Single::ToString()
IL_04c8: stelem.ref
IL_04c9: dup
IL_04ca: ldc.i4.8
IL_04cb: ldstr " | ownChild="
IL_04d0: stelem.ref
IL_04d1: dup
IL_04d2: ldc.i4.s 9
IL_04d4: ldloc.s V_23
IL_04d6: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_04db: ldloc.s V_6
IL_04dd: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_04e2: callvirt System.Boolean UnityEngine.Transform::IsChildOf(UnityEngine.Transform)
IL_04e7: stloc.2
IL_04e8: ldloca.s V_2
IL_04ea: call System.String System.Boolean::ToString()
IL_04ef: stelem.ref
IL_04f0: dup
IL_04f1: ldc.i4.s 10
IL_04f3: ldstr " | ignoredPair="
IL_04f8: stelem.ref
IL_04f9: dup
IL_04fa: ldc.i4.s 11
IL_04fc: ldloc.s V_11
IL_04fe: ldloc.s V_23
IL_0500: call System.Boolean UnityEngine.Physics2D::GetIgnoreCollision(UnityEngine.Collider2D,UnityEngine.Collider2D)
IL_0505: stloc.2
IL_0506: ldloca.s V_2
IL_0508: call System.String System.Boolean::ToString()
IL_050d: stelem.ref
IL_050e: dup
IL_050f: ldc.i4.s 12
IL_0511: ldstr " | trigger="
IL_0516: stelem.ref
IL_0517: dup
IL_0518: ldc.i4.s 13
IL_051a: ldloc.s V_23
IL_051c: callvirt System.Boolean UnityEngine.Collider2D::get_isTrigger()
IL_0521: stloc.2
IL_0522: ldloca.s V_2
IL_0524: call System.String System.Boolean::ToString()
IL_0529: stelem.ref
IL_052a: dup
IL_052b: ldc.i4.s 14
IL_052d: ldstr " | point="
IL_0532: stelem.ref
IL_0533: dup
IL_0534: ldc.i4.s 15
IL_0536: ldloc.s V_20
IL_0538: ldloc.s V_22
IL_053a: ldelema UnityEngine.RaycastHit2D
IL_053f: call UnityEngine.Vector2 UnityEngine.RaycastHit2D::get_point()
IL_0544: call UnityEngine.Vector3 UnityEngine.Vector2::op_Implicit(UnityEngine.Vector2)
IL_0549: call System.String ForestProbe::Vector(UnityEngine.Vector3)
IL_054e: stelem.ref
IL_054f: call System.String System.String::Concat(System.String[])
IL_0554: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0559: nop
IL_055a: nop
IL_055b: ldloc.s V_22
IL_055d: ldc.i4.1
IL_055e: add
IL_055f: stloc.s V_22
IL_0561: ldloc.s V_22
IL_0563: ldloc.s V_21
IL_0565: clt
IL_0567: stloc.s V_25
IL_0569: ldloc.s V_25
IL_056b: brtrue IL_044f
IL_0570: nop
IL_0571: ldloc.s V_17
IL_0573: ldc.i4.1
IL_0574: add
IL_0575: stloc.s V_17
IL_0577: ldloc.s V_17
IL_0579: ldloc.s V_16
IL_057b: ldlen
IL_057c: conv.i4
IL_057d: blt IL_039a
IL_0582: nop
IL_0583: nop
IL_0584: ldloc.s V_5
IL_0586: ldc.i4.1
IL_0587: add
IL_0588: stloc.s V_5
IL_058a: ldloc.s V_5
IL_058c: ldloc.s V_4
IL_058e: ldlen
IL_058f: conv.i4
IL_0590: blt IL_011c
IL_0595: nop
IL_0596: call !!0[] UnityEngine.Resources::FindObjectsOfTypeAll<TheForestOfLove.Doorway>()
IL_059b: stloc.s V_26
IL_059d: ldc.i4.0
IL_059e: stloc.s V_27
IL_05a0: br IL_09c9
IL_05a5: ldloc.s V_26
IL_05a7: ldloc.s V_27
IL_05a9: ldelem.ref
IL_05aa: stloc.s V_28
IL_05ac: ldloc.s V_28
IL_05ae: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_05b3: callvirt UnityEngine.SceneManagement.Scene UnityEngine.GameObject::get_scene()
IL_05b8: stloc.s V_8
IL_05ba: ldloca.s V_8
IL_05bc: call System.Boolean UnityEngine.SceneManagement.Scene::IsValid()
IL_05c1: stloc.s V_29
IL_05c3: ldloc.s V_29
IL_05c5: brfalse IL_09c3
IL_05ca: nop
IL_05cb: ldloc.0
IL_05cc: ldc.i4.s 18
IL_05ce: newarr System.String
IL_05d3: dup
IL_05d4: ldc.i4.0
IL_05d5: ldstr "travelDoor | id="
IL_05da: stelem.ref
IL_05db: dup
IL_05dc: ldc.i4.1
IL_05dd: ldloc.s V_28
IL_05df: callvirt System.Int32 UnityEngine.Object::GetInstanceID()
IL_05e4: stloc.s V_12
IL_05e6: ldloca.s V_12
IL_05e8: call System.String System.Int32::ToString()
IL_05ed: stelem.ref
IL_05ee: dup
IL_05ef: ldc.i4.2
IL_05f0: ldstr " | path="
IL_05f5: stelem.ref
IL_05f6: dup
IL_05f7: ldc.i4.3
IL_05f8: ldloc.s V_28
IL_05fa: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_05ff: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_0604: stelem.ref
IL_0605: dup
IL_0606: ldc.i4.4
IL_0607: ldstr " | scene="
IL_060c: stelem.ref
IL_060d: dup
IL_060e: ldc.i4.5
IL_060f: ldloc.s V_28
IL_0611: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0616: callvirt UnityEngine.SceneManagement.Scene UnityEngine.GameObject::get_scene()
IL_061b: stloc.s V_8
IL_061d: ldloca.s V_8
IL_061f: call System.String UnityEngine.SceneManagement.Scene::get_name()
IL_0624: stelem.ref
IL_0625: dup
IL_0626: ldc.i4.6
IL_0627: ldstr " | active="
IL_062c: stelem.ref
IL_062d: dup
IL_062e: ldc.i4.7
IL_062f: ldloc.s V_28
IL_0631: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0636: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_063b: stloc.2
IL_063c: ldloca.s V_2
IL_063e: call System.String System.Boolean::ToString()
IL_0643: stelem.ref
IL_0644: dup
IL_0645: ldc.i4.8
IL_0646: ldstr " | enabled="
IL_064b: stelem.ref
IL_064c: dup
IL_064d: ldc.i4.s 9
IL_064f: ldloc.s V_28
IL_0651: callvirt System.Boolean UnityEngine.Behaviour::get_enabled()
IL_0656: stloc.2
IL_0657: ldloca.s V_2
IL_0659: call System.String System.Boolean::ToString()
IL_065e: stelem.ref
IL_065f: dup
IL_0660: ldc.i4.s 10
IL_0662: ldstr " | destination="
IL_0667: stelem.ref
IL_0668: dup
IL_0669: ldc.i4.s 11
IL_066b: ldloc.s V_28
IL_066d: ldstr "sceneName"
IL_0672: call System.Object ForestProbe::ReadField(System.Object,System.String)
IL_0677: dup
IL_0678: brtrue.s IL_067e
IL_067a: pop
IL_067b: ldnull
IL_067c: br.s IL_0683
IL_067e: callvirt System.String System.Object::ToString()
IL_0683: stelem.ref
IL_0684: dup
IL_0685: ldc.i4.s 12
IL_0687: ldstr " | transitioning="
IL_068c: stelem.ref
IL_068d: dup
IL_068e: ldc.i4.s 13
IL_0690: ldloc.s V_28
IL_0692: ldstr "transitioning"
IL_0697: call System.Object ForestProbe::ReadField(System.Object,System.String)
IL_069c: dup
IL_069d: brtrue.s IL_06a3
IL_069f: pop
IL_06a0: ldnull
IL_06a1: br.s IL_06a8
IL_06a3: callvirt System.String System.Object::ToString()
IL_06a8: stelem.ref
IL_06a9: dup
IL_06aa: ldc.i4.s 14
IL_06ac: ldstr " | delay="
IL_06b1: stelem.ref
IL_06b2: dup
IL_06b3: ldc.i4.s 15
IL_06b5: ldloc.s V_28
IL_06b7: ldstr "secondsBeforeTravel"
IL_06bc: call System.Object ForestProbe::ReadField(System.Object,System.String)
IL_06c1: dup
IL_06c2: brtrue.s IL_06c8
IL_06c4: pop
IL_06c5: ldnull
IL_06c6: br.s IL_06cd
IL_06c8: callvirt System.String System.Object::ToString()
IL_06cd: stelem.ref
IL_06ce: dup
IL_06cf: ldc.i4.s 16
IL_06d1: ldstr " | position="
IL_06d6: stelem.ref
IL_06d7: dup
IL_06d8: ldc.i4.s 17
IL_06da: ldloc.s V_28
IL_06dc: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_06e1: callvirt UnityEngine.Vector3 UnityEngine.Transform::get_position()
IL_06e6: call System.String ForestProbe::Vector(UnityEngine.Vector3)
IL_06eb: stelem.ref
IL_06ec: call System.String System.String::Concat(System.String[])
IL_06f1: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_06f6: nop
IL_06f7: ldloc.0
IL_06f8: ldloc.s V_28
IL_06fa: call System.Void ForestProbe::TravelColliders(System.Collections.Generic.List`1<System.String>,UnityEngine.Component)
IL_06ff: nop
IL_0700: ldloc.s V_28
IL_0702: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0707: callvirt UnityEngine.SceneManagement.Scene UnityEngine.GameObject::get_scene()
IL_070c: stloc.s V_8
IL_070e: ldloca.s V_8
IL_0710: call System.String UnityEngine.SceneManagement.Scene::get_name()
IL_0715: ldstr "BunnyHouse"
IL_071a: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_071f: brfalse.s IL_0757
IL_0721: ldloc.s V_28
IL_0723: ldstr "sceneName"
IL_0728: call System.Object ForestProbe::ReadField(System.Object,System.String)
IL_072d: call System.String ForestProbe::DiagnosticValue(System.Object)
IL_0732: ldstr "CentralForest"
IL_0737: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_073c: brfalse.s IL_0757
IL_073e: ldloc.s V_28
IL_0740: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0745: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_074a: ldstr "/Doorways/DoorwayToCentralForest"
IL_074f: ldc.i4.4
IL_0750: callvirt System.Boolean System.String::EndsWith(System.String,System.StringComparison)
IL_0755: br.s IL_0758
IL_0757: ldc.i4.0
IL_0758: stloc.s V_30
IL_075a: ldloc.s V_30
IL_075c: brfalse IL_09c2
IL_0761: nop
IL_0762: call !!0[] UnityEngine.Resources::FindObjectsOfTypeAll<TheForestOfLove.Player>()
IL_0767: stloc.s V_31
IL_0769: ldc.i4.0
IL_076a: stloc.s V_32
IL_076c: br IL_09b7
IL_0771: ldloc.s V_31
IL_0773: ldloc.s V_32
IL_0775: ldelem.ref
IL_0776: stloc.s V_33
IL_0778: ldloc.s V_33
IL_077a: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_077f: callvirt UnityEngine.SceneManagement.Scene UnityEngine.GameObject::get_scene()
IL_0784: stloc.s V_8
IL_0786: ldloca.s V_8
IL_0788: call System.Boolean UnityEngine.SceneManagement.Scene::IsValid()
IL_078d: brfalse.s IL_079d
IL_078f: ldloc.s V_33
IL_0791: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0796: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_079b: br.s IL_079e
IL_079d: ldc.i4.0
IL_079e: stloc.s V_34
IL_07a0: ldloc.s V_34
IL_07a2: brfalse IL_09b1
IL_07a7: nop
IL_07a8: ldloc.s V_33
IL_07aa: ldc.i4.1
IL_07ab: callvirt !!0[] UnityEngine.Component::GetComponentsInChildren<UnityEngine.Collider2D>(System.Boolean)
IL_07b0: stloc.s V_35
IL_07b2: ldc.i4.0
IL_07b3: stloc.s V_36
IL_07b5: br IL_09a6
IL_07ba: ldloc.s V_35
IL_07bc: ldloc.s V_36
IL_07be: ldelem.ref
IL_07bf: stloc.s V_37
IL_07c1: nop
IL_07c2: ldloc.s V_28
IL_07c4: ldc.i4.1
IL_07c5: callvirt !!0[] UnityEngine.Component::GetComponentsInChildren<UnityEngine.Collider2D>(System.Boolean)
IL_07ca: stloc.s V_38
IL_07cc: ldc.i4.0
IL_07cd: stloc.s V_39
IL_07cf: br IL_0995
IL_07d4: ldloc.s V_38
IL_07d6: ldloc.s V_39
IL_07d8: ldelem.ref
IL_07d9: stloc.s V_40
IL_07db: ldloc.s V_37
IL_07dd: callvirt System.Boolean UnityEngine.Behaviour::get_enabled()
IL_07e2: brfalse.s IL_0809
IL_07e4: ldloc.s V_37
IL_07e6: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_07eb: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_07f0: brfalse.s IL_0809
IL_07f2: ldloc.s V_40
IL_07f4: callvirt System.Boolean UnityEngine.Behaviour::get_enabled()
IL_07f9: brfalse.s IL_0809
IL_07fb: ldloc.s V_40
IL_07fd: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0802: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_0807: br.s IL_080a
IL_0809: ldc.i4.0
IL_080a: stloc.s V_41
IL_080c: ldloc.s V_41
IL_080e: brfalse IL_098f
IL_0813: nop
IL_0814: ldloc.s V_37
IL_0816: ldloc.s V_40
IL_0818: callvirt UnityEngine.ColliderDistance2D UnityEngine.Collider2D::Distance(UnityEngine.Collider2D)
IL_081d: stloc.s V_42
IL_081f: ldloc.0
IL_0820: ldc.i4.s 22
IL_0822: newarr System.String
IL_0827: dup
IL_0828: ldc.i4.0
IL_0829: ldstr "travelPair | playerCollider="
IL_082e: stelem.ref
IL_082f: dup
IL_0830: ldc.i4.1
IL_0831: ldloc.s V_37
IL_0833: callvirt System.Int32 UnityEngine.Object::GetInstanceID()
IL_0838: stloc.s V_12
IL_083a: ldloca.s V_12
IL_083c: call System.String System.Int32::ToString()
IL_0841: stelem.ref
IL_0842: dup
IL_0843: ldc.i4.2
IL_0844: ldstr " | doorCollider="
IL_0849: stelem.ref
IL_084a: dup
IL_084b: ldc.i4.3
IL_084c: ldloc.s V_40
IL_084e: callvirt System.Int32 UnityEngine.Object::GetInstanceID()
IL_0853: stloc.s V_12
IL_0855: ldloca.s V_12
IL_0857: call System.String System.Int32::ToString()
IL_085c: stelem.ref
IL_085d: dup
IL_085e: ldc.i4.4
IL_085f: ldstr " | ignoredLayers="
IL_0864: stelem.ref
IL_0865: dup
IL_0866: ldc.i4.5
IL_0867: ldloc.s V_37
IL_0869: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_086e: callvirt System.Int32 UnityEngine.GameObject::get_layer()
IL_0873: ldloc.s V_40
IL_0875: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_087a: callvirt System.Int32 UnityEngine.GameObject::get_layer()
IL_087f: call System.Boolean UnityEngine.Physics2D::GetIgnoreLayerCollision(System.Int32,System.Int32)
IL_0884: stloc.2
IL_0885: ldloca.s V_2
IL_0887: call System.String System.Boolean::ToString()
IL_088c: stelem.ref
IL_088d: dup
IL_088e: ldc.i4.6
IL_088f: ldstr " | ignoredPair="
IL_0894: stelem.ref
IL_0895: dup
IL_0896: ldc.i4.7
IL_0897: ldloc.s V_37
IL_0899: ldloc.s V_40
IL_089b: call System.Boolean UnityEngine.Physics2D::GetIgnoreCollision(UnityEngine.Collider2D,UnityEngine.Collider2D)
IL_08a0: stloc.2
IL_08a1: ldloca.s V_2
IL_08a3: call System.String System.Boolean::ToString()
IL_08a8: stelem.ref
IL_08a9: dup
IL_08aa: ldc.i4.8
IL_08ab: ldstr " | touching="
IL_08b0: stelem.ref
IL_08b1: dup
IL_08b2: ldc.i4.s 9
IL_08b4: ldloc.s V_37
IL_08b6: ldloc.s V_40
IL_08b8: callvirt System.Boolean UnityEngine.Collider2D::IsTouching(UnityEngine.Collider2D)
IL_08bd: stloc.2
IL_08be: ldloca.s V_2
IL_08c0: call System.String System.Boolean::ToString()
IL_08c5: stelem.ref
IL_08c6: dup
IL_08c7: ldc.i4.s 10
IL_08c9: ldstr " | boundsIntersect="
IL_08ce: stelem.ref
IL_08cf: dup
IL_08d0: ldc.i4.s 11
IL_08d2: ldloc.s V_37
IL_08d4: callvirt UnityEngine.Bounds UnityEngine.Collider2D::get_bounds()
IL_08d9: stloc.s V_43
IL_08db: ldloca.s V_43
IL_08dd: ldloc.s V_40
IL_08df: callvirt UnityEngine.Bounds UnityEngine.Collider2D::get_bounds()
IL_08e4: call System.Boolean UnityEngine.Bounds::Intersects(UnityEngine.Bounds)
IL_08e9: stloc.2
IL_08ea: ldloca.s V_2
IL_08ec: call System.String System.Boolean::ToString()
IL_08f1: stelem.ref
IL_08f2: dup
IL_08f3: ldc.i4.s 12
IL_08f5: ldstr " | distanceValid="
IL_08fa: stelem.ref
IL_08fb: dup
IL_08fc: ldc.i4.s 13
IL_08fe: ldloca.s V_42
IL_0900: call System.Boolean UnityEngine.ColliderDistance2D::get_isValid()
IL_0905: stloc.2
IL_0906: ldloca.s V_2
IL_0908: call System.String System.Boolean::ToString()
IL_090d: stelem.ref
IL_090e: dup
IL_090f: ldc.i4.s 14
IL_0911: ldstr " | overlapped="
IL_0916: stelem.ref
IL_0917: dup
IL_0918: ldc.i4.s 15
IL_091a: ldloca.s V_42
IL_091c: call System.Boolean UnityEngine.ColliderDistance2D::get_isOverlapped()
IL_0921: stloc.2
IL_0922: ldloca.s V_2
IL_0924: call System.String System.Boolean::ToString()
IL_0929: stelem.ref
IL_092a: dup
IL_092b: ldc.i4.s 16
IL_092d: ldstr " | distance="
IL_0932: stelem.ref
IL_0933: dup
IL_0934: ldc.i4.s 17
IL_0936: ldloca.s V_42
IL_0938: call System.Single UnityEngine.ColliderDistance2D::get_distance()
IL_093d: stloc.s V_24
IL_093f: ldloca.s V_24
IL_0941: call System.String System.Single::ToString()
IL_0946: stelem.ref
IL_0947: dup
IL_0948: ldc.i4.s 18
IL_094a: ldstr " | playerPoint="
IL_094f: stelem.ref
IL_0950: dup
IL_0951: ldc.i4.s 19
IL_0953: ldloca.s V_42
IL_0955: call UnityEngine.Vector2 UnityEngine.ColliderDistance2D::get_pointA()
IL_095a: call UnityEngine.Vector3 UnityEngine.Vector2::op_Implicit(UnityEngine.Vector2)
IL_095f: call System.String ForestProbe::Vector(UnityEngine.Vector3)
IL_0964: stelem.ref
IL_0965: dup
IL_0966: ldc.i4.s 20
IL_0968: ldstr " | doorPoint="
IL_096d: stelem.ref
IL_096e: dup
IL_096f: ldc.i4.s 21
IL_0971: ldloca.s V_42
IL_0973: call UnityEngine.Vector2 UnityEngine.ColliderDistance2D::get_pointB()
IL_0978: call UnityEngine.Vector3 UnityEngine.Vector2::op_Implicit(UnityEngine.Vector2)
IL_097d: call System.String ForestProbe::Vector(UnityEngine.Vector3)
IL_0982: stelem.ref
IL_0983: call System.String System.String::Concat(System.String[])
IL_0988: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_098d: nop
IL_098e: nop
IL_098f: ldloc.s V_39
IL_0991: ldc.i4.1
IL_0992: add
IL_0993: stloc.s V_39
IL_0995: ldloc.s V_39
IL_0997: ldloc.s V_38
IL_0999: ldlen
IL_099a: conv.i4
IL_099b: blt IL_07d4
IL_09a0: ldloc.s V_36
IL_09a2: ldc.i4.1
IL_09a3: add
IL_09a4: stloc.s V_36
IL_09a6: ldloc.s V_36
IL_09a8: ldloc.s V_35
IL_09aa: ldlen
IL_09ab: conv.i4
IL_09ac: blt IL_07ba
IL_09b1: ldloc.s V_32
IL_09b3: ldc.i4.1
IL_09b4: add
IL_09b5: stloc.s V_32
IL_09b7: ldloc.s V_32
IL_09b9: ldloc.s V_31
IL_09bb: ldlen
IL_09bc: conv.i4
IL_09bd: blt IL_0771
IL_09c2: nop
IL_09c3: ldloc.s V_27
IL_09c5: ldc.i4.1
IL_09c6: add
IL_09c7: stloc.s V_27
IL_09c9: ldloc.s V_27
IL_09cb: ldloc.s V_26
IL_09cd: ldlen
IL_09ce: conv.i4
IL_09cf: blt IL_05a5
IL_09d4: nop
IL_09d5: call !!0[] UnityEngine.Resources::FindObjectsOfTypeAll<TheForestOfLove.InputHelper>()
IL_09da: stloc.s V_44
IL_09dc: ldc.i4.0
IL_09dd: stloc.s V_45
IL_09df: br IL_0b2b
IL_09e4: ldloc.s V_44
IL_09e6: ldloc.s V_45
IL_09e8: ldelem.ref
IL_09e9: stloc.s V_46
IL_09eb: ldloc.s V_46
IL_09ed: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_09f2: callvirt UnityEngine.SceneManagement.Scene UnityEngine.GameObject::get_scene()
IL_09f7: stloc.s V_8
IL_09f9: ldloca.s V_8
IL_09fb: call System.Boolean UnityEngine.SceneManagement.Scene::IsValid()
IL_0a00: stloc.s V_47
IL_0a02: ldloc.s V_47
IL_0a04: brfalse IL_0b25
IL_0a09: nop
IL_0a0a: ldloc.s V_46
IL_0a0c: ldstr "player"
IL_0a11: call System.Object ForestProbe::ReadField(System.Object,System.String)
IL_0a16: isinst Rewired.Player
IL_0a1b: stloc.s V_48
IL_0a1d: ldloc.0
IL_0a1e: ldc.i4.s 16
IL_0a20: newarr System.String
IL_0a25: dup
IL_0a26: ldc.i4.0
IL_0a27: ldstr "travelInput | path="
IL_0a2c: stelem.ref
IL_0a2d: dup
IL_0a2e: ldc.i4.1
IL_0a2f: ldloc.s V_46
IL_0a31: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0a36: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_0a3b: stelem.ref
IL_0a3c: dup
IL_0a3d: ldc.i4.2
IL_0a3e: ldstr " | active="
IL_0a43: stelem.ref
IL_0a44: dup
IL_0a45: ldc.i4.3
IL_0a46: ldloc.s V_46
IL_0a48: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0a4d: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_0a52: stloc.2
IL_0a53: ldloca.s V_2
IL_0a55: call System.String System.Boolean::ToString()
IL_0a5a: stelem.ref
IL_0a5b: dup
IL_0a5c: ldc.i4.4
IL_0a5d: ldstr " | enabled="
IL_0a62: stelem.ref
IL_0a63: dup
IL_0a64: ldc.i4.5
IL_0a65: ldloc.s V_46
IL_0a67: callvirt System.Boolean UnityEngine.Behaviour::get_enabled()
IL_0a6c: stloc.2
IL_0a6d: ldloca.s V_2
IL_0a6f: call System.String System.Boolean::ToString()
IL_0a74: stelem.ref
IL_0a75: dup
IL_0a76: ldc.i4.6
IL_0a77: ldstr " | player="
IL_0a7c: stelem.ref
IL_0a7d: dup
IL_0a7e: ldc.i4.7
IL_0a7f: ldloc.s V_48
IL_0a81: brfalse.s IL_0aa6
IL_0a83: ldloc.s V_48
IL_0a85: callvirt System.Int32 Rewired.Player::get_id()
IL_0a8a: stloc.s V_12
IL_0a8c: ldloca.s V_12
IL_0a8e: call System.String System.Int32::ToString()
IL_0a93: ldstr ":"
IL_0a98: ldloc.s V_48
IL_0a9a: callvirt System.String Rewired.Player::get_name()
IL_0a9f: call System.String System.String::Concat(System.String,System.String,System.String)
IL_0aa4: br.s IL_0aab
IL_0aa6: ldstr "null"
IL_0aab: stelem.ref
IL_0aac: dup
IL_0aad: ldc.i4.8
IL_0aae: ldstr " | keyboardMaps="
IL_0ab3: stelem.ref
IL_0ab4: dup
IL_0ab5: ldc.i4.s 9
IL_0ab7: ldloc.s V_48
IL_0ab9: call System.String ForestProbe::KeyboardMaps(Rewired.Player)
IL_0abe: stelem.ref
IL_0abf: dup
IL_0ac0: ldc.i4.s 10
IL_0ac2: ldstr " | joystick="
IL_0ac7: stelem.ref
IL_0ac8: dup
IL_0ac9: ldc.i4.s 11
IL_0acb: ldloc.s V_46
IL_0acd: ldstr "theKingOfJoysticks"
IL_0ad2: call System.Object ForestProbe::ReadField(System.Object,System.String)
IL_0ad7: call System.String ForestProbe::ObjectAddress(System.Object)
IL_0adc: stelem.ref
IL_0add: dup
IL_0ade: ldc.i4.s 12
IL_0ae0: ldstr " | customController="
IL_0ae5: stelem.ref
IL_0ae6: dup
IL_0ae7: ldc.i4.s 13
IL_0ae9: ldloc.s V_46
IL_0aeb: ldstr "kingOfJoysticksRewiredCustomController"
IL_0af0: call System.Object ForestProbe::ReadField(System.Object,System.String)
IL_0af5: call System.String ForestProbe::ObjectAddress(System.Object)
IL_0afa: stelem.ref
IL_0afb: dup
IL_0afc: ldc.i4.s 14
IL_0afe: ldstr " | touch="
IL_0b03: stelem.ref
IL_0b04: dup
IL_0b05: ldc.i4.s 15
IL_0b07: ldloc.s V_46
IL_0b09: ldstr "touchInputHelper"
IL_0b0e: call System.Object ForestProbe::ReadField(System.Object,System.String)
IL_0b13: call System.String ForestProbe::ObjectAddress(System.Object)
IL_0b18: stelem.ref
IL_0b19: call System.String System.String::Concat(System.String[])
IL_0b1e: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0b23: nop
IL_0b24: nop
IL_0b25: ldloc.s V_45
IL_0b27: ldc.i4.1
IL_0b28: add
IL_0b29: stloc.s V_45
IL_0b2b: ldloc.s V_45
IL_0b2d: ldloc.s V_44
IL_0b2f: ldlen
IL_0b30: conv.i4
IL_0b31: blt IL_09e4
IL_0b36: ldc.i4.0
IL_0b37: stloc.1
IL_0b38: nop
IL_0b39: call !!0[] UnityEngine.Resources::FindObjectsOfTypeAll<Itelisoft.KOF.TheKingOfJoysticks>()
IL_0b3e: stloc.s V_49
IL_0b40: ldc.i4.0
IL_0b41: stloc.s V_50
IL_0b43: br IL_0c3d
IL_0b48: ldloc.s V_49
IL_0b4a: ldloc.s V_50
IL_0b4c: ldelem.ref
IL_0b4d: stloc.s V_51
IL_0b4f: ldloc.s V_51
IL_0b51: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0b56: callvirt UnityEngine.SceneManagement.Scene UnityEngine.GameObject::get_scene()
IL_0b5b: stloc.s V_8
IL_0b5d: ldloca.s V_8
IL_0b5f: call System.Boolean UnityEngine.SceneManagement.Scene::IsValid()
IL_0b64: stloc.s V_52
IL_0b66: ldloc.s V_52
IL_0b68: brfalse IL_0c37
IL_0b6d: nop
IL_0b6e: ldloc.1
IL_0b6f: ldc.i4.1
IL_0b70: add
IL_0b71: stloc.1
IL_0b72: ldloc.0
IL_0b73: ldc.i4.s 12
IL_0b75: newarr System.String
IL_0b7a: dup
IL_0b7b: ldc.i4.0
IL_0b7c: ldstr "travelJoystick | path="
IL_0b81: stelem.ref
IL_0b82: dup
IL_0b83: ldc.i4.1
IL_0b84: ldloc.s V_51
IL_0b86: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0b8b: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_0b90: stelem.ref
IL_0b91: dup
IL_0b92: ldc.i4.2
IL_0b93: ldstr " | active="
IL_0b98: stelem.ref
IL_0b99: dup
IL_0b9a: ldc.i4.3
IL_0b9b: ldloc.s V_51
IL_0b9d: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0ba2: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_0ba7: stloc.2
IL_0ba8: ldloca.s V_2
IL_0baa: call System.String System.Boolean::ToString()
IL_0baf: stelem.ref
IL_0bb0: dup
IL_0bb1: ldc.i4.4
IL_0bb2: ldstr " | enabled="
IL_0bb7: stelem.ref
IL_0bb8: dup
IL_0bb9: ldc.i4.5
IL_0bba: ldloc.s V_51
IL_0bbc: callvirt System.Boolean UnityEngine.Behaviour::get_enabled()
IL_0bc1: stloc.2
IL_0bc2: ldloca.s V_2
IL_0bc4: call System.String System.Boolean::ToString()
IL_0bc9: stelem.ref
IL_0bca: dup
IL_0bcb: ldc.i4.6
IL_0bcc: ldstr " | inUse="
IL_0bd1: stelem.ref
IL_0bd2: dup
IL_0bd3: ldc.i4.7
IL_0bd4: ldloc.s V_51
IL_0bd6: ldstr "inUse"
IL_0bdb: call System.Object ForestProbe::ReadField(System.Object,System.String)
IL_0be0: dup
IL_0be1: brtrue.s IL_0be7
IL_0be3: pop
IL_0be4: ldnull
IL_0be5: br.s IL_0bec
IL_0be7: callvirt System.String System.Object::ToString()
IL_0bec: stelem.ref
IL_0bed: dup
IL_0bee: ldc.i4.8
IL_0bef: ldstr " | mouseMode="
IL_0bf4: stelem.ref
IL_0bf5: dup
IL_0bf6: ldc.i4.s 9
IL_0bf8: ldloc.s V_51
IL_0bfa: ldstr "mouseMode"
IL_0bff: call System.Object ForestProbe::ReadField(System.Object,System.String)
IL_0c04: dup
IL_0c05: brtrue.s IL_0c0b
IL_0c07: pop
IL_0c08: ldnull
IL_0c09: br.s IL_0c10
IL_0c0b: callvirt System.String System.Object::ToString()
IL_0c10: stelem.ref
IL_0c11: dup
IL_0c12: ldc.i4.s 10
IL_0c14: ldstr " | disabled="
IL_0c19: stelem.ref
IL_0c1a: dup
IL_0c1b: ldc.i4.s 11
IL_0c1d: call System.Boolean Itelisoft.KOF.TheKingOfJoysticks::get_DisableJoystickInput()
IL_0c22: stloc.2
IL_0c23: ldloca.s V_2
IL_0c25: call System.String System.Boolean::ToString()
IL_0c2a: stelem.ref
IL_0c2b: call System.String System.String::Concat(System.String[])
IL_0c30: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0c35: nop
IL_0c36: nop
IL_0c37: ldloc.s V_50
IL_0c39: ldc.i4.1
IL_0c3a: add
IL_0c3b: stloc.s V_50
IL_0c3d: ldloc.s V_50
IL_0c3f: ldloc.s V_49
IL_0c41: ldlen
IL_0c42: conv.i4
IL_0c43: blt IL_0b48
IL_0c48: ldloc.0
IL_0c49: ldstr "travelJoystickCount | loaded="
IL_0c4e: ldloca.s V_1
IL_0c50: call System.String System.Int32::ToString()
IL_0c55: call System.String System.String::Concat(System.String,System.String)
IL_0c5a: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0c5f: nop
IL_0c60: ldloc.0
IL_0c61: callvirt !0[] System.Collections.Generic.List`1<System.String>::ToArray()
IL_0c66: stloc.s V_53
IL_0c68: br.s IL_0c6a
IL_0c6a: ldloc.s V_53
IL_0c6c: ret
METHOD System.String[] ForestProbe::IntroCleanupDiagnostics() | attributes=Private, HideBySig | impl=IL
IL_0000: nop
IL_0001: newobj System.Void System.Collections.Generic.List`1<System.String>::.ctor()
IL_0006: stloc.0
IL_0007: ldc.i4.0
IL_0008: stloc.1
IL_0009: ldc.i4.0
IL_000a: stloc.2
IL_000b: ldc.i4.0
IL_000c: stloc.3
IL_000d: nop
IL_000e: call !!0[] UnityEngine.Resources::FindObjectsOfTypeAll<TheForestOfLove.IntroBunnyHouseCutscene>()
IL_0013: stloc.s V_5
IL_0015: ldc.i4.0
IL_0016: stloc.s V_6
IL_0018: br IL_0102
IL_001d: ldloc.s V_5
IL_001f: ldloc.s V_6
IL_0021: ldelem.ref
IL_0022: stloc.s V_7
IL_0024: ldloc.s V_7
IL_0026: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_002b: callvirt UnityEngine.SceneManagement.Scene UnityEngine.GameObject::get_scene()
IL_0030: stloc.s V_9
IL_0032: ldloca.s V_9
IL_0034: call System.Boolean UnityEngine.SceneManagement.Scene::IsValid()
IL_0039: stloc.s V_8
IL_003b: ldloc.s V_8
IL_003d: brfalse IL_00fc
IL_0042: nop
IL_0043: ldloc.1
IL_0044: ldc.i4.1
IL_0045: add
IL_0046: stloc.1
IL_0047: ldloc.0
IL_0048: ldc.i4.s 10
IL_004a: newarr System.String
IL_004f: dup
IL_0050: ldc.i4.0
IL_0051: ldstr "introCutscene | path="
IL_0056: stelem.ref
IL_0057: dup
IL_0058: ldc.i4.1
IL_0059: ldloc.s V_7
IL_005b: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0060: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_0065: stelem.ref
IL_0066: dup
IL_0067: ldc.i4.2
IL_0068: ldstr " | active="
IL_006d: stelem.ref
IL_006e: dup
IL_006f: ldc.i4.3
IL_0070: ldloc.s V_7
IL_0072: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0077: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_007c: stloc.s V_10
IL_007e: ldloca.s V_10
IL_0080: call System.String System.Boolean::ToString()
IL_0085: stelem.ref
IL_0086: dup
IL_0087: ldc.i4.4
IL_0088: ldstr " | stage="
IL_008d: stelem.ref
IL_008e: dup
IL_008f: ldc.i4.5
IL_0090: ldloc.s V_7
IL_0092: ldstr "currentStage"
IL_0097: call System.Object ForestProbe::ReadField(System.Object,System.String)
IL_009c: dup
IL_009d: brtrue.s IL_00a3
IL_009f: pop
IL_00a0: ldnull
IL_00a1: br.s IL_00a8
IL_00a3: callvirt System.String System.Object::ToString()
IL_00a8: stelem.ref
IL_00a9: dup
IL_00aa: ldc.i4.6
IL_00ab: ldstr " | timerSet="
IL_00b0: stelem.ref
IL_00b1: dup
IL_00b2: ldc.i4.7
IL_00b3: ldloc.s V_7
IL_00b5: ldstr "timerSet"
IL_00ba: call System.Object ForestProbe::ReadField(System.Object,System.String)
IL_00bf: dup
IL_00c0: brtrue.s IL_00c6
IL_00c2: pop
IL_00c3: ldnull
IL_00c4: br.s IL_00cb
IL_00c6: callvirt System.String System.Object::ToString()
IL_00cb: stelem.ref
IL_00cc: dup
IL_00cd: ldc.i4.8
IL_00ce: ldstr " | timerSeconds="
IL_00d3: stelem.ref
IL_00d4: dup
IL_00d5: ldc.i4.s 9
IL_00d7: ldloc.s V_7
IL_00d9: ldstr "timerSecondsRemaining"
IL_00de: call System.Object ForestProbe::ReadField(System.Object,System.String)
IL_00e3: dup
IL_00e4: brtrue.s IL_00ea
IL_00e6: pop
IL_00e7: ldnull
IL_00e8: br.s IL_00ef
IL_00ea: callvirt System.String System.Object::ToString()
IL_00ef: stelem.ref
IL_00f0: call System.String System.String::Concat(System.String[])
IL_00f5: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_00fa: nop
IL_00fb: nop
IL_00fc: ldloc.s V_6
IL_00fe: ldc.i4.1
IL_00ff: add
IL_0100: stloc.s V_6
IL_0102: ldloc.s V_6
IL_0104: ldloc.s V_5
IL_0106: ldlen
IL_0107: conv.i4
IL_0108: blt IL_001d
IL_010d: ldstr "Cutscene_IntroBunnyHouse"
IL_0112: call TheForestOfLove.Narrative.Trigger TheForestOfLove.Services.Persistence.DataService::GetTriggerByName(System.String)
IL_0117: stloc.s V_4
IL_0119: ldloc.0
IL_011a: ldstr "trigger | name=Cutscene_IntroBunnyHouse | count="
IL_011f: ldloc.s V_4
IL_0121: brfalse.s IL_0136
IL_0123: ldloc.s V_4
IL_0125: ldstr "<CountActivated>k__BackingField"
IL_012a: call System.Object ForestProbe::ReadField(System.Object,System.String)
IL_012f: call System.String ForestProbe::DiagnosticValue(System.Object)
IL_0134: br.s IL_013b
IL_0136: ldstr "absent"
IL_013b: call System.String System.String::Concat(System.String,System.String)
IL_0140: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0145: nop
IL_0146: nop
IL_0147: call !!0[] UnityEngine.Resources::FindObjectsOfTypeAll<TheForestOfLove.InteractionUiController>()
IL_014c: stloc.s V_11
IL_014e: ldc.i4.0
IL_014f: stloc.s V_12
IL_0151: br.s IL_01be
IL_0153: ldloc.s V_11
IL_0155: ldloc.s V_12
IL_0157: ldelem.ref
IL_0158: stloc.s V_13
IL_015a: ldloc.s V_13
IL_015c: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0161: callvirt UnityEngine.SceneManagement.Scene UnityEngine.GameObject::get_scene()
IL_0166: stloc.s V_9
IL_0168: ldloca.s V_9
IL_016a: call System.Boolean UnityEngine.SceneManagement.Scene::IsValid()
IL_016f: brfalse.s IL_0189
IL_0171: ldloc.s V_13
IL_0173: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0178: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_017d: ldstr "SpawnedContent/Elements/Bed/Content/Bed(Clone)/Interaction/InteractionIconInspect"
IL_0182: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0187: br.s IL_018a
IL_0189: ldc.i4.0
IL_018a: stloc.s V_14
IL_018c: ldloc.s V_14
IL_018e: brfalse.s IL_01b8
IL_0190: nop
IL_0191: ldloc.2
IL_0192: ldc.i4.1
IL_0193: add
IL_0194: stloc.2
IL_0195: ldloc.s V_13
IL_0197: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_019c: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_01a1: brfalse.s IL_01ac
IL_01a3: ldloc.s V_13
IL_01a5: callvirt System.Boolean UnityEngine.Behaviour::get_enabled()
IL_01aa: br.s IL_01ad
IL_01ac: ldc.i4.0
IL_01ad: stloc.s V_15
IL_01af: ldloc.s V_15
IL_01b1: brfalse.s IL_01b7
IL_01b3: ldloc.3
IL_01b4: ldc.i4.1
IL_01b5: add
IL_01b6: stloc.3
IL_01b7: nop
IL_01b8: ldloc.s V_12
IL_01ba: ldc.i4.1
IL_01bb: add
IL_01bc: stloc.s V_12
IL_01be: ldloc.s V_12
IL_01c0: ldloc.s V_11
IL_01c2: ldlen
IL_01c3: conv.i4
IL_01c4: blt.s IL_0153
IL_01c6: ldloc.0
IL_01c7: ldc.i4.6
IL_01c8: newarr System.String
IL_01cd: dup
IL_01ce: ldc.i4.0
IL_01cf: ldstr "introCleanup | remainingControllers="
IL_01d4: stelem.ref
IL_01d5: dup
IL_01d6: ldc.i4.1
IL_01d7: ldloca.s V_1
IL_01d9: call System.String System.Int32::ToString()
IL_01de: stelem.ref
IL_01df: dup
IL_01e0: ldc.i4.2
IL_01e1: ldstr " | bedControllers="
IL_01e6: stelem.ref
IL_01e7: dup
IL_01e8: ldc.i4.3
IL_01e9: ldloca.s V_2
IL_01eb: call System.String System.Int32::ToString()
IL_01f0: stelem.ref
IL_01f1: dup
IL_01f2: ldc.i4.4
IL_01f3: ldstr " | activeBedControllers="
IL_01f8: stelem.ref
IL_01f9: dup
IL_01fa: ldc.i4.5
IL_01fb: ldloca.s V_3
IL_01fd: call System.String System.Int32::ToString()
IL_0202: stelem.ref
IL_0203: call System.String System.String::Concat(System.String[])
IL_0208: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_020d: nop
IL_020e: ldloc.0
IL_020f: callvirt !0[] System.Collections.Generic.List`1<System.String>::ToArray()
IL_0214: stloc.s V_16
IL_0216: br.s IL_0218
IL_0218: ldloc.s V_16
IL_021a: ret
METHOD System.String[] ForestProbe::TutorialRouteDiagnostics() | attributes=Private, HideBySig | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: call System.String[] ForestProbe::IntroCleanupDiagnostics()
IL_0007: newobj System.Void System.Collections.Generic.List`1<System.String>::.ctor(System.Collections.Generic.IEnumerable`1<!0>)
IL_000c: stloc.0
IL_000d: ldloc.0
IL_000e: ldc.i4.6
IL_000f: newarr System.String
IL_0014: dup
IL_0015: ldc.i4.0
IL_0016: ldstr "guards | gameplay="
IL_001b: stelem.ref
IL_001c: dup
IL_001d: ldc.i4.1
IL_001e: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inGameplayScene()
IL_0023: stloc.1
IL_0024: ldloca.s V_1
IL_0026: call System.String System.Boolean::ToString()
IL_002b: stelem.ref
IL_002c: dup
IL_002d: ldc.i4.2
IL_002e: ldstr " | anyEvent="
IL_0033: stelem.ref
IL_0034: dup
IL_0035: ldc.i4.3
IL_0036: call System.Boolean TheForestOfLove.Events.GameStateManager::get_isAnyEventActive()
IL_003b: stloc.1
IL_003c: ldloca.s V_1
IL_003e: call System.String System.Boolean::ToString()
IL_0043: stelem.ref
IL_0044: dup
IL_0045: ldc.i4.4
IL_0046: ldstr " | conversation="
IL_004b: stelem.ref
IL_004c: dup
IL_004d: ldc.i4.5
IL_004e: call System.Boolean PixelCrushers.DialogueSystem.DialogueManager::get_isConversationActive()
IL_0053: stloc.1
IL_0054: ldloca.s V_1
IL_0056: call System.String System.Boolean::ToString()
IL_005b: stelem.ref
IL_005c: call System.String System.String::Concat(System.String[])
IL_0061: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0066: nop
IL_0067: ldloc.0
IL_0068: ldstr "activeTags | values="
IL_006d: call System.Collections.Generic.IEnumerable`1<TheForestOfLove.Narrative.Tag> TheForestOfLove.Services.Persistence.DataService::GetActiveTags()
IL_0072: call System.String ForestProbe::ListValues(System.Collections.IEnumerable)
IL_0077: call System.String System.String::Concat(System.String,System.String)
IL_007c: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0081: nop
IL_0082: nop
IL_0083: ldc.i4.2
IL_0084: newarr System.String
IL_0089: dup
IL_008a: ldc.i4.0
IL_008b: ldstr "Act1_TutorialQuest"
IL_0090: stelem.ref
IL_0091: dup
IL_0092: ldc.i4.1
IL_0093: ldstr "Act1_GossipQuest"
IL_0098: stelem.ref
IL_0099: stloc.2
IL_009a: ldc.i4.0
IL_009b: stloc.3
IL_009c: br IL_0314
IL_00a1: ldloc.2
IL_00a2: ldloc.3
IL_00a3: ldelem.ref
IL_00a4: stloc.s V_4
IL_00a6: nop
IL_00a7: ldloc.s V_4
IL_00a9: call TheForestOfLove.Narrative.Quest TheForestOfLove.Services.Persistence.DataService::GetQuestByDbName(System.String)
IL_00ae: stloc.s V_5
IL_00b0: ldloc.s V_5
IL_00b2: ldnull
IL_00b3: ceq
IL_00b5: stloc.s V_6
IL_00b7: ldloc.s V_6
IL_00b9: brfalse.s IL_00cd
IL_00bb: ldstr "Missing original quest: "
IL_00c0: ldloc.s V_4
IL_00c2: call System.String System.String::Concat(System.String,System.String)
IL_00c7: newobj System.Void System.Exception::.ctor(System.String)
IL_00cc: throw
IL_00cd: ldloc.0
IL_00ce: ldc.i4.8
IL_00cf: newarr System.String
IL_00d4: dup
IL_00d5: ldc.i4.0
IL_00d6: ldstr "quest | name="
IL_00db: stelem.ref
IL_00dc: dup
IL_00dd: ldc.i4.1
IL_00de: ldloc.s V_5
IL_00e0: ldfld System.String TheForestOfLove.Narrative.Quest::dbName
IL_00e5: stelem.ref
IL_00e6: dup
IL_00e7: ldc.i4.2
IL_00e8: ldstr " | status="
IL_00ed: stelem.ref
IL_00ee: dup
IL_00ef: ldc.i4.3
IL_00f0: ldloc.s V_5
IL_00f2: callvirt TheForestOfLove.Narrative.QuestStatus TheForestOfLove.Narrative.Quest::get_status()
IL_00f7: stloc.s V_7
IL_00f9: ldloca.s V_7
IL_00fb: call System.String System.Int32::ToString()
IL_0100: stelem.ref
IL_0101: dup
IL_0102: ldc.i4.4
IL_0103: ldstr " | enableWithTags="
IL_0108: stelem.ref
IL_0109: dup
IL_010a: ldc.i4.5
IL_010b: ldloc.s V_5
IL_010d: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag> TheForestOfLove.Narrative.Quest::enableWithTags
IL_0112: call System.String ForestProbe::ListValues(System.Collections.IEnumerable)
IL_0117: stelem.ref
IL_0118: dup
IL_0119: ldc.i4.6
IL_011a: ldstr " | disableWithTags="
IL_011f: stelem.ref
IL_0120: dup
IL_0121: ldc.i4.7
IL_0122: ldloc.s V_5
IL_0124: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag> TheForestOfLove.Narrative.Quest::disableWithTags
IL_0129: call System.String ForestProbe::ListValues(System.Collections.IEnumerable)
IL_012e: stelem.ref
IL_012f: call System.String System.String::Concat(System.String[])
IL_0134: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0139: nop
IL_013a: nop
IL_013b: ldloc.s V_5
IL_013d: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.Quest::dialogues
IL_0142: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>::GetEnumerator()
IL_0147: stloc.s V_8
IL_0149: br IL_02f2
IL_014e: ldloca.s V_8
IL_0150: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Dialogue>::get_Current()
IL_0155: stloc.s V_9
IL_0157: nop
IL_0158: ldloc.0
IL_0159: ldc.i4.s 16
IL_015b: newarr System.String
IL_0160: dup
IL_0161: ldc.i4.0
IL_0162: ldstr "questDialogue | name="
IL_0167: stelem.ref
IL_0168: dup
IL_0169: ldc.i4.1
IL_016a: ldloc.s V_9
IL_016c: ldfld System.String TheForestOfLove.Narrative.Dialogue::dbName
IL_0171: stelem.ref
IL_0172: dup
IL_0173: ldc.i4.2
IL_0174: ldstr " | actor="
IL_0179: stelem.ref
IL_017a: dup
IL_017b: ldc.i4.3
IL_017c: ldloc.s V_9
IL_017e: ldfld System.String TheForestOfLove.Narrative.Dialogue::primaryActorDbName
IL_0183: stelem.ref
IL_0184: dup
IL_0185: ldc.i4.4
IL_0186: ldstr " | initialActor="
IL_018b: stelem.ref
IL_018c: dup
IL_018d: ldc.i4.5
IL_018e: ldloc.s V_9
IL_0190: ldfld System.String TheForestOfLove.Narrative.Dialogue::initialActorDbName
IL_0195: stelem.ref
IL_0196: dup
IL_0197: ldc.i4.6
IL_0198: ldstr " | status="
IL_019d: stelem.ref
IL_019e: dup
IL_019f: ldc.i4.7
IL_01a0: ldloc.s V_9
IL_01a2: callvirt TheForestOfLove.Narrative.DialogueStatus TheForestOfLove.Narrative.Dialogue::get_status()
IL_01a7: stloc.s V_7
IL_01a9: ldloca.s V_7
IL_01ab: call System.String System.Int32::ToString()
IL_01b0: stelem.ref
IL_01b1: dup
IL_01b2: ldc.i4.8
IL_01b3: ldstr " | conversation="
IL_01b8: stelem.ref
IL_01b9: dup
IL_01ba: ldc.i4.s 9
IL_01bc: ldloc.s V_9
IL_01be: ldfld PixelCrushers.DialogueSystem.Conversation TheForestOfLove.Narrative.Dialogue::pluginDbConversation
IL_01c3: brfalse.s IL_01d3
IL_01c5: ldloc.s V_9
IL_01c7: ldfld PixelCrushers.DialogueSystem.Conversation TheForestOfLove.Narrative.Dialogue::pluginDbConversation
IL_01cc: ldfld System.Int32 PixelCrushers.DialogueSystem.Asset::id
IL_01d1: br.s IL_01d4
IL_01d3: ldc.i4.m1
IL_01d4: stloc.s V_7
IL_01d6: ldloca.s V_7
IL_01d8: call System.String System.Int32::ToString()
IL_01dd: stelem.ref
IL_01de: dup
IL_01df: ldc.i4.s 10
IL_01e1: ldstr " | type="
IL_01e6: stelem.ref
IL_01e7: dup
IL_01e8: ldc.i4.s 11
IL_01ea: ldloc.s V_9
IL_01ec: ldflda TheForestOfLove.Narrative.DialogueType TheForestOfLove.Narrative.Dialogue::dialogueType
IL_01f1: constrained. TheForestOfLove.Narrative.DialogueType
IL_01f7: callvirt System.String System.Object::ToString()
IL_01fc: stelem.ref
IL_01fd: dup
IL_01fe: ldc.i4.s 12
IL_0200: ldstr " | first="
IL_0205: stelem.ref
IL_0206: dup
IL_0207: ldc.i4.s 13
IL_0209: ldloc.s V_9
IL_020b: ldflda System.Boolean TheForestOfLove.Narrative.Dialogue::isFirstDialogueInQuest
IL_0210: call System.String System.Boolean::ToString()
IL_0215: stelem.ref
IL_0216: dup
IL_0217: ldc.i4.s 14
IL_0219: ldstr " | last="
IL_021e: stelem.ref
IL_021f: dup
IL_0220: ldc.i4.s 15
IL_0222: ldloc.s V_9
IL_0224: ldflda System.Boolean TheForestOfLove.Narrative.Dialogue::isLastDialogueInQuest
IL_0229: call System.String System.Boolean::ToString()
IL_022e: stelem.ref
IL_022f: call System.String System.String::Concat(System.String[])
IL_0234: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0239: nop
IL_023a: nop
IL_023b: ldloc.s V_9
IL_023d: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc> TheForestOfLove.Narrative.Dialogue::primaryArcs
IL_0242: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc>::GetEnumerator()
IL_0247: stloc.s V_10
IL_0249: br IL_02d4
IL_024e: ldloca.s V_10
IL_0250: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Arc>::get_Current()
IL_0255: stloc.s V_11
IL_0257: ldloc.0
IL_0258: ldc.i4.8
IL_0259: newarr System.String
IL_025e: dup
IL_025f: ldc.i4.0
IL_0260: ldstr "primaryArc | dialogue="
IL_0265: stelem.ref
IL_0266: dup
IL_0267: ldc.i4.1
IL_0268: ldloc.s V_9
IL_026a: ldfld System.String TheForestOfLove.Narrative.Dialogue::dbName
IL_026f: stelem.ref
IL_0270: dup
IL_0271: ldc.i4.2
IL_0272: ldstr " | suffix="
IL_0277: stelem.ref
IL_0278: dup
IL_0279: ldc.i4.3
IL_027a: ldloc.s V_11
IL_027c: ldfld System.String TheForestOfLove.Narrative.Arc::pluginDbSuffix
IL_0281: stelem.ref
IL_0282: dup
IL_0283: ldc.i4.4
IL_0284: ldstr " | status="
IL_0289: stelem.ref
IL_028a: dup
IL_028b: ldc.i4.5
IL_028c: ldloc.s V_11
IL_028e: callvirt TheForestOfLove.Narrative.ArcStatus TheForestOfLove.Narrative.Arc::get_status()
IL_0293: stloc.s V_7
IL_0295: ldloca.s V_7
IL_0297: call System.String System.Int32::ToString()
IL_029c: stelem.ref
IL_029d: dup
IL_029e: ldc.i4.6
IL_029f: ldstr " | entry="
IL_02a4: stelem.ref
IL_02a5: dup
IL_02a6: ldc.i4.7
IL_02a7: ldloc.s V_11
IL_02a9: ldfld PixelCrushers.DialogueSystem.DialogueEntry TheForestOfLove.Narrative.Arc::pluginDbFirstDialogueEntry
IL_02ae: brfalse.s IL_02be
IL_02b0: ldloc.s V_11
IL_02b2: ldfld PixelCrushers.DialogueSystem.DialogueEntry TheForestOfLove.Narrative.Arc::pluginDbFirstDialogueEntry
IL_02b7: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_02bc: br.s IL_02bf
IL_02be: ldc.i4.m1
IL_02bf: stloc.s V_7
IL_02c1: ldloca.s V_7
IL_02c3: call System.String System.Int32::ToString()
IL_02c8: stelem.ref
IL_02c9: call System.String System.String::Concat(System.String[])
IL_02ce: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_02d3: nop
IL_02d4: ldloca.s V_10
IL_02d6: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Arc>::MoveNext()
IL_02db: brtrue IL_024e
IL_02e0: leave.s IL_02f1
IL_02e2: ldloca.s V_10
IL_02e4: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Arc>
IL_02ea: callvirt System.Void System.IDisposable::Dispose()
IL_02ef: nop
IL_02f0: endfinally
IL_02f1: nop
IL_02f2: ldloca.s V_8
IL_02f4: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Dialogue>::MoveNext()
IL_02f9: brtrue IL_014e
IL_02fe: leave.s IL_030f
IL_0300: ldloca.s V_8
IL_0302: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Dialogue>
IL_0308: callvirt System.Void System.IDisposable::Dispose()
IL_030d: nop
IL_030e: endfinally
IL_030f: nop
IL_0310: ldloc.3
IL_0311: ldc.i4.1
IL_0312: add
IL_0313: stloc.3
IL_0314: ldloc.3
IL_0315: ldloc.2
IL_0316: ldlen
IL_0317: conv.i4
IL_0318: blt IL_00a1
IL_031d: nop
IL_031e: ldc.i4.5
IL_031f: newarr System.String
IL_0324: dup
IL_0325: ldc.i4.0
IL_0326: ldstr "Cutscene_IntroForest"
IL_032b: stelem.ref
IL_032c: dup
IL_032d: ldc.i4.1
IL_032e: ldstr "intro_from_beaver"
IL_0333: stelem.ref
IL_0334: dup
IL_0335: ldc.i4.2
IL_0336: ldstr "intro_from_mouse"
IL_033b: stelem.ref
IL_033c: dup
IL_033d: ldc.i4.3
IL_033e: ldstr "intro_from_otter"
IL_0343: stelem.ref
IL_0344: dup
IL_0345: ldc.i4.4
IL_0346: ldstr "give_sugar_to_bunny"
IL_034b: stelem.ref
IL_034c: stloc.s V_12
IL_034e: ldc.i4.0
IL_034f: stloc.s V_13
IL_0351: br.s IL_039f
IL_0353: ldloc.s V_12
IL_0355: ldloc.s V_13
IL_0357: ldelem.ref
IL_0358: stloc.s V_14
IL_035a: nop
IL_035b: ldloc.s V_14
IL_035d: call TheForestOfLove.Narrative.Trigger TheForestOfLove.Services.Persistence.DataService::GetTriggerByName(System.String)
IL_0362: stloc.s V_15
IL_0364: ldloc.0
IL_0365: ldstr "trigger | name="
IL_036a: ldloc.s V_14
IL_036c: ldstr " | count="
IL_0371: ldloc.s V_15
IL_0373: brfalse.s IL_0388
IL_0375: ldloc.s V_15
IL_0377: ldstr "<CountActivated>k__BackingField"
IL_037c: call System.Object ForestProbe::ReadField(System.Object,System.String)
IL_0381: call System.String ForestProbe::DiagnosticValue(System.Object)
IL_0386: br.s IL_038d
IL_0388: ldstr "absent"
IL_038d: call System.String System.String::Concat(System.String,System.String,System.String,System.String)
IL_0392: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0397: nop
IL_0398: nop
IL_0399: ldloc.s V_13
IL_039b: ldc.i4.1
IL_039c: add
IL_039d: stloc.s V_13
IL_039f: ldloc.s V_13
IL_03a1: ldloc.s V_12
IL_03a3: ldlen
IL_03a4: conv.i4
IL_03a5: blt.s IL_0353
IL_03a7: nop
IL_03a8: call !!0[] UnityEngine.Resources::FindObjectsOfTypeAll<TheForestOfLove.Gameplay.SpawnableActor>()
IL_03ad: stloc.s V_16
IL_03af: ldc.i4.0
IL_03b0: stloc.s V_17
IL_03b2: br IL_047f
IL_03b7: ldloc.s V_16
IL_03b9: ldloc.s V_17
IL_03bb: ldelem.ref
IL_03bc: stloc.s V_18
IL_03be: ldloc.s V_18
IL_03c0: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_03c5: callvirt UnityEngine.SceneManagement.Scene UnityEngine.GameObject::get_scene()
IL_03ca: stloc.s V_20
IL_03cc: ldloca.s V_20
IL_03ce: call System.Boolean UnityEngine.SceneManagement.Scene::IsValid()
IL_03d3: stloc.s V_19
IL_03d5: ldloc.s V_19
IL_03d7: brfalse IL_0479
IL_03dc: ldloc.0
IL_03dd: ldc.i4.s 10
IL_03df: newarr System.String
IL_03e4: dup
IL_03e5: ldc.i4.0
IL_03e6: ldstr "actor | path="
IL_03eb: stelem.ref
IL_03ec: dup
IL_03ed: ldc.i4.1
IL_03ee: ldloc.s V_18
IL_03f0: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_03f5: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_03fa: stelem.ref
IL_03fb: dup
IL_03fc: ldc.i4.2
IL_03fd: ldstr " | id="
IL_0402: stelem.ref
IL_0403: dup
IL_0404: ldc.i4.3
IL_0405: ldloc.s V_18
IL_0407: callvirt System.Int32 UnityEngine.Object::GetInstanceID()
IL_040c: stloc.s V_7
IL_040e: ldloca.s V_7
IL_0410: call System.String System.Int32::ToString()
IL_0415: stelem.ref
IL_0416: dup
IL_0417: ldc.i4.4
IL_0418: ldstr " | dbName="
IL_041d: stelem.ref
IL_041e: dup
IL_041f: ldc.i4.5
IL_0420: ldloc.s V_18
IL_0422: callvirt System.String TheForestOfLove.Gameplay.SpawnableActor::get_ActorDbName()
IL_0427: stelem.ref
IL_0428: dup
IL_0429: ldc.i4.6
IL_042a: ldstr " | active="
IL_042f: stelem.ref
IL_0430: dup
IL_0431: ldc.i4.7
IL_0432: ldloc.s V_18
IL_0434: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0439: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_043e: stloc.1
IL_043f: ldloca.s V_1
IL_0441: call System.String System.Boolean::ToString()
IL_0446: stelem.ref
IL_0447: dup
IL_0448: ldc.i4.8
IL_0449: ldstr " | position="
IL_044e: stelem.ref
IL_044f: dup
IL_0450: ldc.i4.s 9
IL_0452: ldloc.s V_18
IL_0454: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0459: callvirt UnityEngine.Vector3 UnityEngine.Transform::get_position()
IL_045e: stloc.s V_21
IL_0460: ldloca.s V_21
IL_0462: constrained. UnityEngine.Vector3
IL_0468: callvirt System.String System.Object::ToString()
IL_046d: stelem.ref
IL_046e: call System.String System.String::Concat(System.String[])
IL_0473: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0478: nop
IL_0479: ldloc.s V_17
IL_047b: ldc.i4.1
IL_047c: add
IL_047d: stloc.s V_17
IL_047f: ldloc.s V_17
IL_0481: ldloc.s V_16
IL_0483: ldlen
IL_0484: conv.i4
IL_0485: blt IL_03b7
IL_048a: nop
IL_048b: call !!0[] UnityEngine.Resources::FindObjectsOfTypeAll<TheForestOfLove.InteractionUiController>()
IL_0490: stloc.s V_22
IL_0492: ldc.i4.0
IL_0493: stloc.s V_23
IL_0495: br IL_0831
IL_049a: ldloc.s V_22
IL_049c: ldloc.s V_23
IL_049e: ldelem.ref
IL_049f: stloc.s V_24
IL_04a1: ldloc.s V_24
IL_04a3: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_04a8: callvirt UnityEngine.SceneManagement.Scene UnityEngine.GameObject::get_scene()
IL_04ad: stloc.s V_20
IL_04af: ldloca.s V_20
IL_04b1: call System.Boolean UnityEngine.SceneManagement.Scene::IsValid()
IL_04b6: stloc.s V_25
IL_04b8: ldloc.s V_25
IL_04ba: brfalse IL_082b
IL_04bf: nop
IL_04c0: ldloc.s V_24
IL_04c2: ldstr "character"
IL_04c7: call System.Object ForestProbe::ReadField(System.Object,System.String)
IL_04cc: isinst TheForestOfLove.Gameplay.SpawnableActor
IL_04d1: stloc.s V_26
IL_04d3: ldloc.s V_24
IL_04d5: ldstr "dialogueInteractionTrigger"
IL_04da: call System.Object ForestProbe::ReadField(System.Object,System.String)
IL_04df: isinst TheForestOfLove.Interaction.DialogueInteractionTrigger
IL_04e4: stloc.s V_27
IL_04e6: ldloc.0
IL_04e7: ldc.i4.s 24
IL_04e9: newarr System.String
IL_04ee: dup
IL_04ef: ldc.i4.0
IL_04f0: ldstr "interaction | path="
IL_04f5: stelem.ref
IL_04f6: dup
IL_04f7: ldc.i4.1
IL_04f8: ldloc.s V_24
IL_04fa: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_04ff: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_0504: stelem.ref
IL_0505: dup
IL_0506: ldc.i4.2
IL_0507: ldstr " | id="
IL_050c: stelem.ref
IL_050d: dup
IL_050e: ldc.i4.3
IL_050f: ldloc.s V_24
IL_0511: callvirt System.Int32 UnityEngine.Object::GetInstanceID()
IL_0516: stloc.s V_7
IL_0518: ldloca.s V_7
IL_051a: call System.String System.Int32::ToString()
IL_051f: stelem.ref
IL_0520: dup
IL_0521: ldc.i4.4
IL_0522: ldstr " | active="
IL_0527: stelem.ref
IL_0528: dup
IL_0529: ldc.i4.5
IL_052a: ldloc.s V_24
IL_052c: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0531: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_0536: stloc.1
IL_0537: ldloca.s V_1
IL_0539: call System.String System.Boolean::ToString()
IL_053e: stelem.ref
IL_053f: dup
IL_0540: ldc.i4.6
IL_0541: ldstr " | enabled="
IL_0546: stelem.ref
IL_0547: dup
IL_0548: ldc.i4.7
IL_0549: ldloc.s V_24
IL_054b: callvirt System.Boolean UnityEngine.Behaviour::get_enabled()
IL_0550: stloc.1
IL_0551: ldloca.s V_1
IL_0553: call System.String System.Boolean::ToString()
IL_0558: stelem.ref
IL_0559: dup
IL_055a: ldc.i4.8
IL_055b: ldstr " | authority="
IL_0560: stelem.ref
IL_0561: dup
IL_0562: ldc.i4.s 9
IL_0564: ldloc.s V_24
IL_0566: callvirt System.Boolean TheForestOfLove.InteractionUiController::get_isAuthority()
IL_056b: stloc.1
IL_056c: ldloca.s V_1
IL_056e: call System.String System.Boolean::ToString()
IL_0573: stelem.ref
IL_0574: dup
IL_0575: ldc.i4.s 10
IL_0577: ldstr " | playerTouching="
IL_057c: stelem.ref
IL_057d: dup
IL_057e: ldc.i4.s 11
IL_0580: ldloc.s V_24
IL_0582: ldstr "isPlayerTouching"
IL_0587: call System.Object ForestProbe::ReadField(System.Object,System.String)
IL_058c: dup
IL_058d: brtrue.s IL_0593
IL_058f: pop
IL_0590: ldnull
IL_0591: br.s IL_0598
IL_0593: callvirt System.String System.Object::ToString()
IL_0598: stelem.ref
IL_0599: dup
IL_059a: ldc.i4.s 12
IL_059c: ldstr " | actor="
IL_05a1: stelem.ref
IL_05a2: dup
IL_05a3: ldc.i4.s 13
IL_05a5: ldloc.s V_26
IL_05a7: ldnull
IL_05a8: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_05ad: brtrue.s IL_05b8
IL_05af: ldloc.s V_26
IL_05b1: callvirt System.String TheForestOfLove.Gameplay.SpawnableActor::get_ActorDbName()
IL_05b6: br.s IL_05bd
IL_05b8: ldstr "null"
IL_05bd: stelem.ref
IL_05be: dup
IL_05bf: ldc.i4.s 14
IL_05c1: ldstr " | actorObject="
IL_05c6: stelem.ref
IL_05c7: dup
IL_05c8: ldc.i4.s 15
IL_05ca: ldloc.s V_26
IL_05cc: call System.String ForestProbe::ObjectAddress(System.Object)
IL_05d1: stelem.ref
IL_05d2: dup
IL_05d3: ldc.i4.s 16
IL_05d5: ldstr " | ui="
IL_05da: stelem.ref
IL_05db: dup
IL_05dc: ldc.i4.s 17
IL_05de: ldloc.s V_24
IL_05e0: ldstr "interactionUi"
IL_05e5: call System.Object ForestProbe::ReadField(System.Object,System.String)
IL_05ea: call System.String ForestProbe::ObjectAddress(System.Object)
IL_05ef: stelem.ref
IL_05f0: dup
IL_05f1: ldc.i4.s 18
IL_05f3: ldstr " | trigger="
IL_05f8: stelem.ref
IL_05f9: dup
IL_05fa: ldc.i4.s 19
IL_05fc: ldloc.s V_27
IL_05fe: call System.String ForestProbe::ObjectAddress(System.Object)
IL_0603: stelem.ref
IL_0604: dup
IL_0605: ldc.i4.s 20
IL_0607: ldstr " | options="
IL_060c: stelem.ref
IL_060d: dup
IL_060e: ldc.i4.s 21
IL_0610: ldloc.s V_24
IL_0612: ldstr "availableOptions"
IL_0617: call System.Object ForestProbe::ReadField(System.Object,System.String)
IL_061c: isinst System.Collections.IEnumerable
IL_0621: call System.String ForestProbe::ListValues(System.Collections.IEnumerable)
IL_0626: stelem.ref
IL_0627: dup
IL_0628: ldc.i4.s 22
IL_062a: ldstr " | disallowed="
IL_062f: stelem.ref
IL_0630: dup
IL_0631: ldc.i4.s 23
IL_0633: ldloc.s V_24
IL_0635: ldstr "disallowedOptions"
IL_063a: call System.Object ForestProbe::ReadField(System.Object,System.String)
IL_063f: isinst System.Collections.IEnumerable
IL_0644: call System.String ForestProbe::ListValues(System.Collections.IEnumerable)
IL_0649: stelem.ref
IL_064a: call System.String System.String::Concat(System.String[])
IL_064f: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0654: nop
IL_0655: ldloc.s V_27
IL_0657: ldnull
IL_0658: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_065d: stloc.s V_28
IL_065f: ldloc.s V_28
IL_0661: brfalse IL_082a
IL_0666: nop
IL_0667: ldloc.s V_27
IL_0669: ldstr "settings"
IL_066e: call System.Object ForestProbe::ReadField(System.Object,System.String)
IL_0673: isinst TheForestOfLove.DialogueSettings
IL_0678: stloc.s V_29
IL_067a: ldloc.0
IL_067b: ldc.i4.s 22
IL_067d: newarr System.String
IL_0682: dup
IL_0683: ldc.i4.0
IL_0684: ldstr "interactionTrigger | owner="
IL_0689: stelem.ref
IL_068a: dup
IL_068b: ldc.i4.1
IL_068c: ldloc.s V_24
IL_068e: callvirt System.Int32 UnityEngine.Object::GetInstanceID()
IL_0693: stloc.s V_7
IL_0695: ldloca.s V_7
IL_0697: call System.String System.Int32::ToString()
IL_069c: stelem.ref
IL_069d: dup
IL_069e: ldc.i4.2
IL_069f: ldstr " | active="
IL_06a4: stelem.ref
IL_06a5: dup
IL_06a6: ldc.i4.3
IL_06a7: ldloc.s V_27
IL_06a9: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_06ae: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_06b3: stloc.1
IL_06b4: ldloca.s V_1
IL_06b6: call System.String System.Boolean::ToString()
IL_06bb: stelem.ref
IL_06bc: dup
IL_06bd: ldc.i4.4
IL_06be: ldstr " | authority="
IL_06c3: stelem.ref
IL_06c4: dup
IL_06c5: ldc.i4.5
IL_06c6: ldloc.s V_27
IL_06c8: callvirt System.Type System.Object::GetType()
IL_06cd: ldstr "authorityId"
IL_06d2: ldc.i4.s 56
IL_06d4: callvirt System.Reflection.FieldInfo System.Type::GetField(System.String,System.Reflection.BindingFlags)
IL_06d9: ldnull
IL_06da: callvirt System.Object System.Reflection.FieldInfo::GetValue(System.Object)
IL_06df: unbox.any System.Int32
IL_06e4: ldloc.s V_27
IL_06e6: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_06eb: callvirt System.Int32 UnityEngine.Object::GetInstanceID()
IL_06f0: ceq
IL_06f2: stloc.1
IL_06f3: ldloca.s V_1
IL_06f5: call System.String System.Boolean::ToString()
IL_06fa: stelem.ref
IL_06fb: dup
IL_06fc: ldc.i4.6
IL_06fd: ldstr " | mode="
IL_0702: stelem.ref
IL_0703: dup
IL_0704: ldc.i4.7
IL_0705: ldloc.s V_27
IL_0707: callvirt TheForestOfLove.Narrative.QuestManagerInteractionMode TheForestOfLove.Interaction.DialogueInteractionTrigger::get_interactionMode()
IL_070c: stloc.s V_30
IL_070e: ldloca.s V_30
IL_0710: constrained. TheForestOfLove.Narrative.QuestManagerInteractionMode
IL_0716: callvirt System.String System.Object::ToString()
IL_071b: stelem.ref
IL_071c: dup
IL_071d: ldc.i4.8
IL_071e: ldstr " | touching="
IL_0723: stelem.ref
IL_0724: dup
IL_0725: ldc.i4.s 9
IL_0727: ldloc.s V_27
IL_0729: ldstr "isPlayerTouching"
IL_072e: call System.Object ForestProbe::ReadField(System.Object,System.String)
IL_0733: dup
IL_0734: brtrue.s IL_073a
IL_0736: pop
IL_0737: ldnull
IL_0738: br.s IL_073f
IL_073a: callvirt System.String System.Object::ToString()
IL_073f: stelem.ref
IL_0740: dup
IL_0741: ldc.i4.s 10
IL_0743: ldstr " | triggered="
IL_0748: stelem.ref
IL_0749: dup
IL_074a: ldc.i4.s 11
IL_074c: ldloc.s V_27
IL_074e: ldstr "isTriggered"
IL_0753: call System.Object ForestProbe::ReadField(System.Object,System.String)
IL_0758: dup
IL_0759: brtrue.s IL_075f
IL_075b: pop
IL_075c: ldnull
IL_075d: br.s IL_0764
IL_075f: callvirt System.String System.Object::ToString()
IL_0764: stelem.ref
IL_0765: dup
IL_0766: ldc.i4.s 12
IL_0768: ldstr " | onCollision="
IL_076d: stelem.ref
IL_076e: dup
IL_076f: ldc.i4.s 13
IL_0771: ldloc.s V_27
IL_0773: ldstr "triggerOnCollision"
IL_0778: call System.Object ForestProbe::ReadField(System.Object,System.String)
IL_077d: dup
IL_077e: brtrue.s IL_0784
IL_0780: pop
IL_0781: ldnull
IL_0782: br.s IL_0789
IL_0784: callvirt System.String System.Object::ToString()
IL_0789: stelem.ref
IL_078a: dup
IL_078b: ldc.i4.s 14
IL_078d: ldstr " | cooldown="
IL_0792: stelem.ref
IL_0793: dup
IL_0794: ldc.i4.s 15
IL_0796: ldloc.s V_27
IL_0798: ldstr "cooldownLoopsRemaining"
IL_079d: call System.Object ForestProbe::ReadField(System.Object,System.String)
IL_07a2: dup
IL_07a3: brtrue.s IL_07a9
IL_07a5: pop
IL_07a6: ldnull
IL_07a7: br.s IL_07ae
IL_07a9: callvirt System.String System.Object::ToString()
IL_07ae: stelem.ref
IL_07af: dup
IL_07b0: ldc.i4.s 16
IL_07b2: ldstr " | actor="
IL_07b7: stelem.ref
IL_07b8: dup
IL_07b9: ldc.i4.s 17
IL_07bb: ldloc.s V_29
IL_07bd: ldnull
IL_07be: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_07c3: brtrue.s IL_07ce
IL_07c5: ldloc.s V_29
IL_07c7: callvirt System.String TheForestOfLove.DialogueSettings::get_ActorDbName()
IL_07cc: br.s IL_07d3
IL_07ce: ldstr "null"
IL_07d3: stelem.ref
IL_07d4: dup
IL_07d5: ldc.i4.s 18
IL_07d7: ldstr " | dialogue="
IL_07dc: stelem.ref
IL_07dd: dup
IL_07de: ldc.i4.s 19
IL_07e0: ldloc.s V_29
IL_07e2: ldnull
IL_07e3: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_07e8: brtrue.s IL_07f3
IL_07ea: ldloc.s V_29
IL_07ec: callvirt System.String TheForestOfLove.DialogueSettings::get_DialogueDbName()
IL_07f1: br.s IL_07f8
IL_07f3: ldstr "null"
IL_07f8: stelem.ref
IL_07f9: dup
IL_07fa: ldc.i4.s 20
IL_07fc: ldstr " | arc="
IL_0801: stelem.ref
IL_0802: dup
IL_0803: ldc.i4.s 21
IL_0805: ldloc.s V_29
IL_0807: ldnull
IL_0808: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_080d: brtrue.s IL_0818
IL_080f: ldloc.s V_29
IL_0811: callvirt System.String TheForestOfLove.DialogueSettings::get_ArcDbName()
IL_0816: br.s IL_081d
IL_0818: ldstr "null"
IL_081d: stelem.ref
IL_081e: call System.String System.String::Concat(System.String[])
IL_0823: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0828: nop
IL_0829: nop
IL_082a: nop
IL_082b: ldloc.s V_23
IL_082d: ldc.i4.1
IL_082e: add
IL_082f: stloc.s V_23
IL_0831: ldloc.s V_23
IL_0833: ldloc.s V_22
IL_0835: ldlen
IL_0836: conv.i4
IL_0837: blt IL_049a
IL_083c: nop
IL_083d: call !!0[] UnityEngine.Resources::FindObjectsOfTypeAll<TheForestOfLove.InteractionUi>()
IL_0842: stloc.s V_31
IL_0844: ldc.i4.0
IL_0845: stloc.s V_32
IL_0847: br IL_0937
IL_084c: ldloc.s V_31
IL_084e: ldloc.s V_32
IL_0850: ldelem.ref
IL_0851: stloc.s V_33
IL_0853: ldloc.s V_33
IL_0855: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_085a: callvirt UnityEngine.SceneManagement.Scene UnityEngine.GameObject::get_scene()
IL_085f: stloc.s V_20
IL_0861: ldloca.s V_20
IL_0863: call System.Boolean UnityEngine.SceneManagement.Scene::IsValid()
IL_0868: stloc.s V_34
IL_086a: ldloc.s V_34
IL_086c: brfalse IL_0931
IL_0871: ldloc.0
IL_0872: ldc.i4.s 12
IL_0874: newarr System.String
IL_0879: dup
IL_087a: ldc.i4.0
IL_087b: ldstr "interactionUi | path="
IL_0880: stelem.ref
IL_0881: dup
IL_0882: ldc.i4.1
IL_0883: ldloc.s V_33
IL_0885: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_088a: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_088f: stelem.ref
IL_0890: dup
IL_0891: ldc.i4.2
IL_0892: ldstr " | active="
IL_0897: stelem.ref
IL_0898: dup
IL_0899: ldc.i4.3
IL_089a: ldloc.s V_33
IL_089c: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_08a1: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_08a6: stloc.1
IL_08a7: ldloca.s V_1
IL_08a9: call System.String System.Boolean::ToString()
IL_08ae: stelem.ref
IL_08af: dup
IL_08b0: ldc.i4.4
IL_08b1: ldstr " | visible="
IL_08b6: stelem.ref
IL_08b7: dup
IL_08b8: ldc.i4.5
IL_08b9: call System.Boolean TheForestOfLove.InteractionUi::get_visible()
IL_08be: stloc.1
IL_08bf: ldloca.s V_1
IL_08c1: call System.String System.Boolean::ToString()
IL_08c6: stelem.ref
IL_08c7: dup
IL_08c8: ldc.i4.6
IL_08c9: ldstr " | locked="
IL_08ce: stelem.ref
IL_08cf: dup
IL_08d0: ldc.i4.7
IL_08d1: ldloc.s V_33
IL_08d3: callvirt System.Boolean TheForestOfLove.InteractionUi::get_locked()
IL_08d8: stloc.1
IL_08d9: ldloca.s V_1
IL_08db: call System.String System.Boolean::ToString()
IL_08e0: stelem.ref
IL_08e1: dup
IL_08e2: ldc.i4.8
IL_08e3: ldstr " | selected="
IL_08e8: stelem.ref
IL_08e9: dup
IL_08ea: ldc.i4.s 9
IL_08ec: ldloc.s V_33
IL_08ee: callvirt TheForestOfLove.InteractionUiOption TheForestOfLove.InteractionUi::get_currentSelectedOption()
IL_08f3: stloc.s V_35
IL_08f5: ldloca.s V_35
IL_08f7: constrained. TheForestOfLove.InteractionUiOption
IL_08fd: callvirt System.String System.Object::ToString()
IL_0902: stelem.ref
IL_0903: dup
IL_0904: ldc.i4.s 10
IL_0906: ldstr " | available="
IL_090b: stelem.ref
IL_090c: dup
IL_090d: ldc.i4.s 11
IL_090f: ldloc.s V_33
IL_0911: ldstr "availableOptions"
IL_0916: call System.Object ForestProbe::ReadField(System.Object,System.String)
IL_091b: isinst System.Collections.IEnumerable
IL_0920: call System.String ForestProbe::ListValues(System.Collections.IEnumerable)
IL_0925: stelem.ref
IL_0926: call System.String System.String::Concat(System.String[])
IL_092b: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0930: nop
IL_0931: ldloc.s V_32
IL_0933: ldc.i4.1
IL_0934: add
IL_0935: stloc.s V_32
IL_0937: ldloc.s V_32
IL_0939: ldloc.s V_31
IL_093b: ldlen
IL_093c: conv.i4
IL_093d: blt IL_084c
IL_0942: ldloc.0
IL_0943: callvirt !0[] System.Collections.Generic.List`1<System.String>::ToArray()
IL_0948: stloc.s V_36
IL_094a: br.s IL_094c
IL_094c: ldloc.s V_36
IL_094e: ret
METHOD System.Void ForestProbe::NotebookConditionFields(System.Collections.Generic.List`1<System.String>,System.Object,System.String,System.Int32) | attributes=Private, Static, HideBySig | impl=IL
IL_0000: nop
IL_0001: ldarg.1
IL_0002: ldnull
IL_0003: ceq
IL_0005: stloc.0
IL_0006: ldloc.0
IL_0007: brfalse.s IL_000e
IL_0009: br IL_016e
IL_000e: nop
IL_000f: ldarg.1
IL_0010: callvirt System.Type System.Object::GetType()
IL_0015: ldc.i4.s 52
IL_0017: callvirt System.Reflection.FieldInfo[] System.Type::GetFields(System.Reflection.BindingFlags)
IL_001c: stloc.1
IL_001d: ldc.i4.0
IL_001e: stloc.2
IL_001f: br IL_0165
IL_0024: ldloc.1
IL_0025: ldloc.2
IL_0026: ldelem.ref
IL_0027: stloc.3
IL_0028: nop
IL_0029: ldloc.3
IL_002a: ldarg.1
IL_002b: callvirt System.Object System.Reflection.FieldInfo::GetValue(System.Object)
IL_0030: stloc.s V_4
IL_0032: ldloc.s V_4
IL_0034: isinst System.Collections.IEnumerable
IL_0039: stloc.s V_5
IL_003b: ldarg.2
IL_003c: ldloc.3
IL_003d: callvirt System.String System.Reflection.MemberInfo::get_Name()
IL_0042: call System.String System.String::Concat(System.String,System.String)
IL_0047: stloc.s V_6
IL_0049: ldloc.s V_5
IL_004b: brfalse.s IL_005c
IL_004d: ldloc.s V_4
IL_004f: isinst System.String
IL_0054: ldnull
IL_0055: cgt.un
IL_0057: ldc.i4.0
IL_0058: ceq
IL_005a: br.s IL_005d
IL_005c: ldc.i4.0
IL_005d: stloc.s V_7
IL_005f: ldloc.s V_7
IL_0061: brfalse IL_0100
IL_0066: nop
IL_0067: newobj System.Void System.Collections.Generic.List`1<System.String>::.ctor()
IL_006c: stloc.s V_8
IL_006e: nop
IL_006f: ldloc.s V_5
IL_0071: callvirt System.Collections.IEnumerator System.Collections.IEnumerable::GetEnumerator()
IL_0076: stloc.s V_9
IL_0078: br.s IL_00b3
IL_007a: ldloc.s V_9
IL_007c: callvirt System.Object System.Collections.IEnumerator::get_Current()
IL_0081: stloc.s V_10
IL_0083: nop
IL_0084: ldloc.s V_8
IL_0086: callvirt System.Int32 System.Collections.Generic.List`1<System.String>::get_Count()
IL_008b: ldc.i4.s 64
IL_008d: clt
IL_008f: ldc.i4.0
IL_0090: ceq
IL_0092: stloc.s V_11
IL_0094: ldloc.s V_11
IL_0096: brfalse.s IL_00a3
IL_0098: ldstr "Unexpected notebook condition size"
IL_009d: newobj System.Void System.Exception::.ctor(System.String)
IL_00a2: throw
IL_00a3: ldloc.s V_8
IL_00a5: ldloc.s V_10
IL_00a7: call System.String ForestProbe::DiagnosticValue(System.Object)
IL_00ac: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_00b1: nop
IL_00b2: nop
IL_00b3: ldloc.s V_9
IL_00b5: callvirt System.Boolean System.Collections.IEnumerator::MoveNext()
IL_00ba: brtrue.s IL_007a
IL_00bc: leave.s IL_00d4
IL_00be: ldloc.s V_9
IL_00c0: isinst System.IDisposable
IL_00c5: stloc.s V_12
IL_00c7: ldloc.s V_12
IL_00c9: brfalse.s IL_00d3
IL_00cb: ldloc.s V_12
IL_00cd: callvirt System.Void System.IDisposable::Dispose()
IL_00d2: nop
IL_00d3: endfinally
IL_00d4: ldarg.0
IL_00d5: ldstr "notebookCondition | field="
IL_00da: ldloc.s V_6
IL_00dc: ldstr " | values="
IL_00e1: ldstr ","
IL_00e6: ldloc.s V_8
IL_00e8: callvirt !0[] System.Collections.Generic.List`1<System.String>::ToArray()
IL_00ed: call System.String System.String::Join(System.String,System.String[])
IL_00f2: call System.String System.String::Concat(System.String,System.String,System.String,System.String)
IL_00f7: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_00fc: nop
IL_00fd: nop
IL_00fe: br.s IL_0160
IL_0100: nop
IL_0101: ldarg.0
IL_0102: ldstr "notebookCondition | field="
IL_0107: ldloc.s V_6
IL_0109: ldstr " | value="
IL_010e: ldloc.s V_4
IL_0110: call System.String ForestProbe::DiagnosticValue(System.Object)
IL_0115: call System.String System.String::Concat(System.String,System.String,System.String,System.String)
IL_011a: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_011f: nop
IL_0120: ldarg.3
IL_0121: ldc.i4.0
IL_0122: ble.s IL_0140
IL_0124: ldloc.s V_4
IL_0126: brfalse.s IL_0140
IL_0128: ldloc.s V_4
IL_012a: callvirt System.Type System.Object::GetType()
IL_012f: callvirt System.String System.Type::get_Namespace()
IL_0134: ldstr "TheForestOfLove.Narrative.DialoguePreconditions"
IL_0139: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_013e: br.s IL_0141
IL_0140: ldc.i4.0
IL_0141: stloc.s V_13
IL_0143: ldloc.s V_13
IL_0145: brfalse.s IL_015f
IL_0147: ldarg.0
IL_0148: ldloc.s V_4
IL_014a: ldloc.s V_6
IL_014c: ldstr "."
IL_0151: call System.String System.String::Concat(System.String,System.String)
IL_0156: ldarg.3
IL_0157: ldc.i4.1
IL_0158: sub
IL_0159: call System.Void ForestProbe::NotebookConditionFields(System.Collections.Generic.List`1<System.String>,System.Object,System.String,System.Int32)
IL_015e: nop
IL_015f: nop
IL_0160: nop
IL_0161: ldloc.2
IL_0162: ldc.i4.1
IL_0163: add
IL_0164: stloc.2
IL_0165: ldloc.2
IL_0166: ldloc.1
IL_0167: ldlen
IL_0168: conv.i4
IL_0169: blt IL_0024
IL_016e: ret
METHOD System.String[] ForestProbe::NotebookRouteDiagnostics() | attributes=Private, HideBySig | impl=IL
IL_0000: nop
IL_0001: newobj System.Void System.Collections.Generic.List`1<System.String>::.ctor()
IL_0006: stloc.0
IL_0007: ldloc.0
IL_0008: ldc.i4.s 10
IL_000a: newarr System.String
IL_000f: dup
IL_0010: ldc.i4.0
IL_0011: ldstr "guards | gameplay="
IL_0016: stelem.ref
IL_0017: dup
IL_0018: ldc.i4.1
IL_0019: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inGameplayScene()
IL_001e: stloc.2
IL_001f: ldloca.s V_2
IL_0021: call System.String System.Boolean::ToString()
IL_0026: stelem.ref
IL_0027: dup
IL_0028: ldc.i4.2
IL_0029: ldstr " | dustin="
IL_002e: stelem.ref
IL_002f: dup
IL_0030: ldc.i4.3
IL_0031: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inDustinMinigame()
IL_0036: stloc.2
IL_0037: ldloca.s V_2
IL_0039: call System.String System.Boolean::ToString()
IL_003e: stelem.ref
IL_003f: dup
IL_0040: ldc.i4.4
IL_0041: ldstr " | glitch="
IL_0046: stelem.ref
IL_0047: dup
IL_0048: ldc.i4.5
IL_0049: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inGlitchRoom()
IL_004e: stloc.2
IL_004f: ldloca.s V_2
IL_0051: call System.String System.Boolean::ToString()
IL_0056: stelem.ref
IL_0057: dup
IL_0058: ldc.i4.6
IL_0059: ldstr " | anyEvent="
IL_005e: stelem.ref
IL_005f: dup
IL_0060: ldc.i4.7
IL_0061: call System.Boolean TheForestOfLove.Events.GameStateManager::get_isAnyEventActive()
IL_0066: stloc.2
IL_0067: ldloca.s V_2
IL_0069: call System.String System.Boolean::ToString()
IL_006e: stelem.ref
IL_006f: dup
IL_0070: ldc.i4.8
IL_0071: ldstr " | notebookLearned="
IL_0076: stelem.ref
IL_0077: dup
IL_0078: ldc.i4.s 9
IL_007a: call System.Boolean TheForestOfLove.QuestTriggerHelper::PlayerLearnedNotebook()
IL_007f: stloc.2
IL_0080: ldloca.s V_2
IL_0082: call System.String System.Boolean::ToString()
IL_0087: stelem.ref
IL_0088: call System.String System.String::Concat(System.String[])
IL_008d: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0092: nop
IL_0093: nop
IL_0094: call !!0[] UnityEngine.Resources::FindObjectsOfTypeAll<TheForestOfLove.MasterLog>()
IL_0099: stloc.3
IL_009a: ldc.i4.0
IL_009b: stloc.s V_4
IL_009d: br IL_0172
IL_00a2: ldloc.3
IL_00a3: ldloc.s V_4
IL_00a5: ldelem.ref
IL_00a6: stloc.s V_5
IL_00a8: ldloc.s V_5
IL_00aa: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_00af: callvirt UnityEngine.SceneManagement.Scene UnityEngine.GameObject::get_scene()
IL_00b4: stloc.s V_7
IL_00b6: ldloca.s V_7
IL_00b8: call System.Boolean UnityEngine.SceneManagement.Scene::IsValid()
IL_00bd: stloc.s V_6
IL_00bf: ldloc.s V_6
IL_00c1: brfalse IL_016c
IL_00c6: nop
IL_00c7: ldloc.s V_5
IL_00c9: callvirt System.Type System.Object::GetType()
IL_00ce: ldstr "masterLogUi"
IL_00d3: ldc.i4.s 52
IL_00d5: callvirt System.Reflection.FieldInfo System.Type::GetField(System.String,System.Reflection.BindingFlags)
IL_00da: ldloc.s V_5
IL_00dc: callvirt System.Object System.Reflection.FieldInfo::GetValue(System.Object)
IL_00e1: castclass PixelCrushers.UIPanel
IL_00e6: stloc.s V_8
IL_00e8: ldloc.0
IL_00e9: ldc.i4.8
IL_00ea: newarr System.String
IL_00ef: dup
IL_00f0: ldc.i4.0
IL_00f1: ldstr "masterLog | path="
IL_00f6: stelem.ref
IL_00f7: dup
IL_00f8: ldc.i4.1
IL_00f9: ldloc.s V_5
IL_00fb: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0100: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_0105: stelem.ref
IL_0106: dup
IL_0107: ldc.i4.2
IL_0108: ldstr " | active="
IL_010d: stelem.ref
IL_010e: dup
IL_010f: ldc.i4.3
IL_0110: ldloc.s V_5
IL_0112: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0117: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_011c: stloc.2
IL_011d: ldloca.s V_2
IL_011f: call System.String System.Boolean::ToString()
IL_0124: stelem.ref
IL_0125: dup
IL_0126: ldc.i4.4
IL_0127: ldstr " | open="
IL_012c: stelem.ref
IL_012d: dup
IL_012e: ldc.i4.5
IL_012f: ldloc.s V_8
IL_0131: callvirt System.Boolean PixelCrushers.UIPanel::get_isOpen()
IL_0136: stloc.2
IL_0137: ldloca.s V_2
IL_0139: call System.String System.Boolean::ToString()
IL_013e: stelem.ref
IL_013f: dup
IL_0140: ldc.i4.6
IL_0141: ldstr " | page="
IL_0146: stelem.ref
IL_0147: dup
IL_0148: ldc.i4.7
IL_0149: ldloc.s V_5
IL_014b: callvirt TheForestOfLove.MasterLogPage TheForestOfLove.MasterLog::get_currentPage()
IL_0150: stloc.s V_9
IL_0152: ldloca.s V_9
IL_0154: constrained. TheForestOfLove.MasterLogPage
IL_015a: callvirt System.String System.Object::ToString()
IL_015f: stelem.ref
IL_0160: call System.String System.String::Concat(System.String[])
IL_0165: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_016a: nop
IL_016b: nop
IL_016c: ldloc.s V_4
IL_016e: ldc.i4.1
IL_016f: add
IL_0170: stloc.s V_4
IL_0172: ldloc.s V_4
IL_0174: ldloc.3
IL_0175: ldlen
IL_0176: conv.i4
IL_0177: blt IL_00a2
IL_017c: nop
IL_017d: call !!0[] UnityEngine.Resources::FindObjectsOfTypeAll<TheForestOfLove.ChapterSelectUI>()
IL_0182: stloc.s V_10
IL_0184: ldc.i4.0
IL_0185: stloc.s V_11
IL_0187: br IL_0435
IL_018c: ldloc.s V_10
IL_018e: ldloc.s V_11
IL_0190: ldelem.ref
IL_0191: stloc.s V_12
IL_0193: ldloc.s V_12
IL_0195: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_019a: callvirt UnityEngine.SceneManagement.Scene UnityEngine.GameObject::get_scene()
IL_019f: stloc.s V_7
IL_01a1: ldloca.s V_7
IL_01a3: call System.Boolean UnityEngine.SceneManagement.Scene::IsValid()
IL_01a8: stloc.s V_13
IL_01aa: ldloc.s V_13
IL_01ac: brfalse IL_042f
IL_01b1: nop
IL_01b2: ldc.i4.s 52
IL_01b4: stloc.s V_14
IL_01b6: ldloc.s V_12
IL_01b8: callvirt System.Type System.Object::GetType()
IL_01bd: stloc.s V_15
IL_01bf: ldloc.s V_15
IL_01c1: ldstr "gossipUICanvasGroup"
IL_01c6: ldloc.s V_14
IL_01c8: callvirt System.Reflection.FieldInfo System.Type::GetField(System.String,System.Reflection.BindingFlags)
IL_01cd: ldloc.s V_12
IL_01cf: callvirt System.Object System.Reflection.FieldInfo::GetValue(System.Object)
IL_01d4: castclass UnityEngine.CanvasGroup
IL_01d9: stloc.s V_16
IL_01db: ldloc.0
IL_01dc: ldc.i4.s 16
IL_01de: newarr System.String
IL_01e3: dup
IL_01e4: ldc.i4.0
IL_01e5: ldstr "chapterUi | path="
IL_01ea: stelem.ref
IL_01eb: dup
IL_01ec: ldc.i4.1
IL_01ed: ldloc.s V_12
IL_01ef: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_01f4: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_01f9: stelem.ref
IL_01fa: dup
IL_01fb: ldc.i4.2
IL_01fc: ldstr " | active="
IL_0201: stelem.ref
IL_0202: dup
IL_0203: ldc.i4.3
IL_0204: ldloc.s V_12
IL_0206: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_020b: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_0210: stloc.2
IL_0211: ldloca.s V_2
IL_0213: call System.String System.Boolean::ToString()
IL_0218: stelem.ref
IL_0219: dup
IL_021a: ldc.i4.4
IL_021b: ldstr " | visible="
IL_0220: stelem.ref
IL_0221: dup
IL_0222: ldc.i4.5
IL_0223: call System.Boolean TheForestOfLove.ChapterSelectUI::get_visible()
IL_0228: stloc.2
IL_0229: ldloca.s V_2
IL_022b: call System.String System.Boolean::ToString()
IL_0230: stelem.ref
IL_0231: dup
IL_0232: ldc.i4.6
IL_0233: ldstr " | locked="
IL_0238: stelem.ref
IL_0239: dup
IL_023a: ldc.i4.7
IL_023b: ldloc.s V_12
IL_023d: callvirt System.Boolean TheForestOfLove.ChapterSelectUI::get_LockInteractions()
IL_0242: stloc.2
IL_0243: ldloca.s V_2
IL_0245: call System.String System.Boolean::ToString()
IL_024a: stelem.ref
IL_024b: dup
IL_024c: ldc.i4.8
IL_024d: ldstr " | alpha="
IL_0252: stelem.ref
IL_0253: dup
IL_0254: ldc.i4.s 9
IL_0256: ldloc.s V_16
IL_0258: ldnull
IL_0259: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_025e: brtrue.s IL_0272
IL_0260: ldloc.s V_16
IL_0262: callvirt System.Single UnityEngine.CanvasGroup::get_alpha()
IL_0267: stloc.s V_17
IL_0269: ldloca.s V_17
IL_026b: call System.String System.Single::ToString()
IL_0270: br.s IL_0277
IL_0272: ldstr "null"
IL_0277: stelem.ref
IL_0278: dup
IL_0279: ldc.i4.s 10
IL_027b: ldstr " | selectedLabel="
IL_0280: stelem.ref
IL_0281: dup
IL_0282: ldc.i4.s 11
IL_0284: ldloc.s V_15
IL_0286: ldstr "itemLabelSelectedIndex"
IL_028b: ldloc.s V_14
IL_028d: callvirt System.Reflection.FieldInfo System.Type::GetField(System.String,System.Reflection.BindingFlags)
IL_0292: ldloc.s V_12
IL_0294: callvirt System.Object System.Reflection.FieldInfo::GetValue(System.Object)
IL_0299: dup
IL_029a: brtrue.s IL_02a0
IL_029c: pop
IL_029d: ldnull
IL_029e: br.s IL_02a5
IL_02a0: callvirt System.String System.Object::ToString()
IL_02a5: stelem.ref
IL_02a6: dup
IL_02a7: ldc.i4.s 12
IL_02a9: ldstr " | selectedItem="
IL_02ae: stelem.ref
IL_02af: dup
IL_02b0: ldc.i4.s 13
IL_02b2: ldloc.s V_15
IL_02b4: ldstr "gossipItemSelectedIndex"
IL_02b9: ldloc.s V_14
IL_02bb: callvirt System.Reflection.FieldInfo System.Type::GetField(System.String,System.Reflection.BindingFlags)
IL_02c0: ldloc.s V_12
IL_02c2: callvirt System.Object System.Reflection.FieldInfo::GetValue(System.Object)
IL_02c7: dup
IL_02c8: brtrue.s IL_02ce
IL_02ca: pop
IL_02cb: ldnull
IL_02cc: br.s IL_02d3
IL_02ce: callvirt System.String System.Object::ToString()
IL_02d3: stelem.ref
IL_02d4: dup
IL_02d5: ldc.i4.s 14
IL_02d7: ldstr " | waitingForSubmitClear="
IL_02dc: stelem.ref
IL_02dd: dup
IL_02de: ldc.i4.s 15
IL_02e0: ldloc.s V_15
IL_02e2: ldstr "waitingForSubmitButtonToClear"
IL_02e7: ldloc.s V_14
IL_02e9: callvirt System.Reflection.FieldInfo System.Type::GetField(System.String,System.Reflection.BindingFlags)
IL_02ee: ldloc.s V_12
IL_02f0: callvirt System.Object System.Reflection.FieldInfo::GetValue(System.Object)
IL_02f5: dup
IL_02f6: brtrue.s IL_02fc
IL_02f8: pop
IL_02f9: ldnull
IL_02fa: br.s IL_0301
IL_02fc: callvirt System.String System.Object::ToString()
IL_0301: stelem.ref
IL_0302: call System.String System.String::Concat(System.String[])
IL_0307: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_030c: nop
IL_030d: nop
IL_030e: ldloc.s V_15
IL_0310: ldstr "gossipItems"
IL_0315: ldloc.s V_14
IL_0317: callvirt System.Reflection.FieldInfo System.Type::GetField(System.String,System.Reflection.BindingFlags)
IL_031c: ldloc.s V_12
IL_031e: callvirt System.Object System.Reflection.FieldInfo::GetValue(System.Object)
IL_0323: castclass System.Collections.IEnumerable
IL_0328: callvirt System.Collections.IEnumerator System.Collections.IEnumerable::GetEnumerator()
IL_032d: stloc.s V_18
IL_032f: br IL_040a
IL_0334: ldloc.s V_18
IL_0336: callvirt System.Object System.Collections.IEnumerator::get_Current()
IL_033b: stloc.s V_19
IL_033d: nop
IL_033e: ldloc.s V_19
IL_0340: callvirt System.Type System.Object::GetType()
IL_0345: stloc.s V_20
IL_0347: ldloc.0
IL_0348: ldc.i4.8
IL_0349: newarr System.String
IL_034e: dup
IL_034f: ldc.i4.0
IL_0350: ldstr "chapterUiItem | chapter="
IL_0355: stelem.ref
IL_0356: dup
IL_0357: ldc.i4.1
IL_0358: ldloc.s V_20
IL_035a: ldstr "unlockStopPoint"
IL_035f: ldloc.s V_14
IL_0361: callvirt System.Reflection.FieldInfo System.Type::GetField(System.String,System.Reflection.BindingFlags)
IL_0366: ldloc.s V_19
IL_0368: callvirt System.Object System.Reflection.FieldInfo::GetValue(System.Object)
IL_036d: dup
IL_036e: brtrue.s IL_0374
IL_0370: pop
IL_0371: ldnull
IL_0372: br.s IL_0379
IL_0374: callvirt System.String System.Object::ToString()
IL_0379: stelem.ref
IL_037a: dup
IL_037b: ldc.i4.2
IL_037c: ldstr " | text="
IL_0381: stelem.ref
IL_0382: dup
IL_0383: ldc.i4.3
IL_0384: ldloc.s V_20
IL_0386: ldstr "displayText"
IL_038b: ldloc.s V_14
IL_038d: callvirt System.Reflection.FieldInfo System.Type::GetField(System.String,System.Reflection.BindingFlags)
IL_0392: ldloc.s V_19
IL_0394: callvirt System.Object System.Reflection.FieldInfo::GetValue(System.Object)
IL_0399: dup
IL_039a: brtrue.s IL_03a0
IL_039c: pop
IL_039d: ldnull
IL_039e: br.s IL_03a5
IL_03a0: callvirt System.String System.Object::ToString()
IL_03a5: stelem.ref
IL_03a6: dup
IL_03a7: ldc.i4.4
IL_03a8: ldstr " | scene="
IL_03ad: stelem.ref
IL_03ae: dup
IL_03af: ldc.i4.5
IL_03b0: ldloc.s V_20
IL_03b2: ldstr "respawnInScene"
IL_03b7: ldloc.s V_14
IL_03b9: callvirt System.Reflection.FieldInfo System.Type::GetField(System.String,System.Reflection.BindingFlags)
IL_03be: ldloc.s V_19
IL_03c0: callvirt System.Object System.Reflection.FieldInfo::GetValue(System.Object)
IL_03c5: dup
IL_03c6: brtrue.s IL_03cc
IL_03c8: pop
IL_03c9: ldnull
IL_03ca: br.s IL_03d1
IL_03cc: callvirt System.String System.Object::ToString()
IL_03d1: stelem.ref
IL_03d2: dup
IL_03d3: ldc.i4.6
IL_03d4: ldstr " | spawn="
IL_03d9: stelem.ref
IL_03da: dup
IL_03db: ldc.i4.7
IL_03dc: ldloc.s V_20
IL_03de: ldstr "namedSpawnPoint"
IL_03e3: ldloc.s V_14
IL_03e5: callvirt System.Reflection.FieldInfo System.Type::GetField(System.String,System.Reflection.BindingFlags)
IL_03ea: ldloc.s V_19
IL_03ec: callvirt System.Object System.Reflection.FieldInfo::GetValue(System.Object)
IL_03f1: dup
IL_03f2: brtrue.s IL_03f8
IL_03f4: pop
IL_03f5: ldnull
IL_03f6: br.s IL_03fd
IL_03f8: callvirt System.String System.Object::ToString()
IL_03fd: stelem.ref
IL_03fe: call System.String System.String::Concat(System.String[])
IL_0403: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0408: nop
IL_0409: nop
IL_040a: ldloc.s V_18
IL_040c: callvirt System.Boolean System.Collections.IEnumerator::MoveNext()
IL_0411: brtrue IL_0334
IL_0416: leave.s IL_042e
IL_0418: ldloc.s V_18
IL_041a: isinst System.IDisposable
IL_041f: stloc.s V_21
IL_0421: ldloc.s V_21
IL_0423: brfalse.s IL_042d
IL_0425: ldloc.s V_21
IL_0427: callvirt System.Void System.IDisposable::Dispose()
IL_042c: nop
IL_042d: endfinally
IL_042e: nop
IL_042f: ldloc.s V_11
IL_0431: ldc.i4.1
IL_0432: add
IL_0433: stloc.s V_11
IL_0435: ldloc.s V_11
IL_0437: ldloc.s V_10
IL_0439: ldlen
IL_043a: conv.i4
IL_043b: blt IL_018c
IL_0440: nop
IL_0441: call System.Collections.Generic.IEnumerable`1<TheForestOfLove.Narrative.ChapterRecord> TheForestOfLove.Services.Persistence.DataService::GetChapterRecords()
IL_0446: callvirt System.Collections.Generic.IEnumerator`1<!0> System.Collections.Generic.IEnumerable`1<TheForestOfLove.Narrative.ChapterRecord>::GetEnumerator()
IL_044b: stloc.s V_22
IL_044d: br IL_0562
IL_0452: ldloc.s V_22
IL_0454: callvirt !0 System.Collections.Generic.IEnumerator`1<TheForestOfLove.Narrative.ChapterRecord>::get_Current()
IL_0459: stloc.s V_23
IL_045b: nop
IL_045c: newobj System.Void System.Collections.Generic.List`1<System.String>::.ctor()
IL_0461: stloc.s V_24
IL_0463: nop
IL_0464: ldloc.s V_23
IL_0466: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Trigger> TheForestOfLove.Narrative.ChapterRecord::unlockTriggers
IL_046b: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.Trigger>::GetEnumerator()
IL_0470: stloc.s V_25
IL_0472: br.s IL_048c
IL_0474: ldloca.s V_25
IL_0476: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Trigger>::get_Current()
IL_047b: stloc.s V_26
IL_047d: ldloc.s V_24
IL_047f: ldloc.s V_26
IL_0481: ldfld System.String TheForestOfLove.Narrative.Trigger::name
IL_0486: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_048b: nop
IL_048c: ldloca.s V_25
IL_048e: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Trigger>::MoveNext()
IL_0493: brtrue.s IL_0474
IL_0495: leave.s IL_04a6
IL_0497: ldloca.s V_25
IL_0499: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Trigger>
IL_049f: callvirt System.Void System.IDisposable::Dispose()
IL_04a4: nop
IL_04a5: endfinally
IL_04a6: ldloc.0
IL_04a7: ldc.i4.s 12
IL_04a9: newarr System.String
IL_04ae: dup
IL_04af: ldc.i4.0
IL_04b0: ldstr "chapter | id="
IL_04b5: stelem.ref
IL_04b6: dup
IL_04b7: ldc.i4.1
IL_04b8: ldloc.s V_23
IL_04ba: ldfld TheForestOfLove.Narrative.Chapter TheForestOfLove.Narrative.ChapterRecord::unlockStopPoint
IL_04bf: stloc.s V_27
IL_04c1: ldloca.s V_27
IL_04c3: call System.String System.Int32::ToString()
IL_04c8: stelem.ref
IL_04c9: dup
IL_04ca: ldc.i4.2
IL_04cb: ldstr " | title="
IL_04d0: stelem.ref
IL_04d1: dup
IL_04d2: ldc.i4.3
IL_04d3: ldloc.s V_23
IL_04d5: ldfld System.String TheForestOfLove.Narrative.ChapterRecord::title
IL_04da: stelem.ref
IL_04db: dup
IL_04dc: ldc.i4.4
IL_04dd: ldstr " | unlocked="
IL_04e2: stelem.ref
IL_04e3: dup
IL_04e4: ldc.i4.5
IL_04e5: ldloc.s V_23
IL_04e7: callvirt System.Boolean TheForestOfLove.Narrative.ChapterRecord::get_IsUnlocked()
IL_04ec: stloc.2
IL_04ed: ldloca.s V_2
IL_04ef: call System.String System.Boolean::ToString()
IL_04f4: stelem.ref
IL_04f5: dup
IL_04f6: ldc.i4.6
IL_04f7: ldstr " | parent="
IL_04fc: stelem.ref
IL_04fd: dup
IL_04fe: ldc.i4.7
IL_04ff: ldloc.s V_23
IL_0501: ldfld TheForestOfLove.Narrative.ChapterRecord TheForestOfLove.Narrative.ChapterRecord::parent
IL_0506: brfalse.s IL_051f
IL_0508: ldloc.s V_23
IL_050a: ldfld TheForestOfLove.Narrative.ChapterRecord TheForestOfLove.Narrative.ChapterRecord::parent
IL_050f: ldfld TheForestOfLove.Narrative.Chapter TheForestOfLove.Narrative.ChapterRecord::unlockStopPoint
IL_0514: stloc.s V_27
IL_0516: ldloca.s V_27
IL_0518: call System.String System.Int32::ToString()
IL_051d: br.s IL_0524
IL_051f: ldstr "null"
IL_0524: stelem.ref
IL_0525: dup
IL_0526: ldc.i4.8
IL_0527: ldstr " | scene="
IL_052c: stelem.ref
IL_052d: dup
IL_052e: ldc.i4.s 9
IL_0530: ldloc.s V_23
IL_0532: ldfld System.String TheForestOfLove.Narrative.ChapterRecord::respawnInScene
IL_0537: stelem.ref
IL_0538: dup
IL_0539: ldc.i4.s 10
IL_053b: ldstr " | unlockTriggers="
IL_0540: stelem.ref
IL_0541: dup
IL_0542: ldc.i4.s 11
IL_0544: ldstr ","
IL_0549: ldloc.s V_24
IL_054b: callvirt !0[] System.Collections.Generic.List`1<System.String>::ToArray()
IL_0550: call System.String System.String::Join(System.String,System.String[])
IL_0555: stelem.ref
IL_0556: call System.String System.String::Concat(System.String[])
IL_055b: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0560: nop
IL_0561: nop
IL_0562: ldloc.s V_22
IL_0564: callvirt System.Boolean System.Collections.IEnumerator::MoveNext()
IL_0569: brtrue IL_0452
IL_056e: leave.s IL_057d
IL_0570: ldloc.s V_22
IL_0572: brfalse.s IL_057c
IL_0574: ldloc.s V_22
IL_0576: callvirt System.Void System.IDisposable::Dispose()
IL_057b: nop
IL_057c: endfinally
IL_057d: nop
IL_057e: call System.Collections.Generic.IEnumerable`1<TheForestOfLove.Narrative.ChapterRecord> TheForestOfLove.Services.Persistence.DataService::GetGlobalChapterRecords()
IL_0583: callvirt System.Collections.Generic.IEnumerator`1<!0> System.Collections.Generic.IEnumerable`1<TheForestOfLove.Narrative.ChapterRecord>::GetEnumerator()
IL_0588: stloc.s V_28
IL_058a: br.s IL_05ca
IL_058c: ldloc.s V_28
IL_058e: callvirt !0 System.Collections.Generic.IEnumerator`1<TheForestOfLove.Narrative.ChapterRecord>::get_Current()
IL_0593: stloc.s V_29
IL_0595: ldloc.0
IL_0596: ldstr "globalChapter | id="
IL_059b: ldloc.s V_29
IL_059d: ldfld TheForestOfLove.Narrative.Chapter TheForestOfLove.Narrative.ChapterRecord::unlockStopPoint
IL_05a2: stloc.s V_27
IL_05a4: ldloca.s V_27
IL_05a6: call System.String System.Int32::ToString()
IL_05ab: ldstr " | unlocked="
IL_05b0: ldloc.s V_29
IL_05b2: callvirt System.Boolean TheForestOfLove.Narrative.ChapterRecord::get_IsUnlocked()
IL_05b7: stloc.2
IL_05b8: ldloca.s V_2
IL_05ba: call System.String System.Boolean::ToString()
IL_05bf: call System.String System.String::Concat(System.String,System.String,System.String,System.String)
IL_05c4: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_05c9: nop
IL_05ca: ldloc.s V_28
IL_05cc: callvirt System.Boolean System.Collections.IEnumerator::MoveNext()
IL_05d1: brtrue.s IL_058c
IL_05d3: leave.s IL_05e2
IL_05d5: ldloc.s V_28
IL_05d7: brfalse.s IL_05e1
IL_05d9: ldloc.s V_28
IL_05db: callvirt System.Void System.IDisposable::Dispose()
IL_05e0: nop
IL_05e1: endfinally
IL_05e2: ldc.i4 225
IL_05e7: call TheForestOfLove.Narrative.Dialogue TheForestOfLove.Services.Persistence.DataService::GetDialogueByPluginDbId(System.Int32)
IL_05ec: stloc.1
IL_05ed: ldloc.1
IL_05ee: ldnull
IL_05ef: cgt.un
IL_05f1: stloc.s V_30
IL_05f3: ldloc.s V_30
IL_05f5: brfalse IL_06c0
IL_05fa: nop
IL_05fb: ldloc.0
IL_05fc: ldc.i4.8
IL_05fd: newarr System.String
IL_0602: dup
IL_0603: ldc.i4.0
IL_0604: ldstr "notebookDialogue | dbName="
IL_0609: stelem.ref
IL_060a: dup
IL_060b: ldc.i4.1
IL_060c: ldloc.1
IL_060d: ldfld System.String TheForestOfLove.Narrative.Dialogue::dbName
IL_0612: stelem.ref
IL_0613: dup
IL_0614: ldc.i4.2
IL_0615: ldstr " | actor="
IL_061a: stelem.ref
IL_061b: dup
IL_061c: ldc.i4.3
IL_061d: ldloc.1
IL_061e: ldfld TheForestOfLove.Narrative.Actor TheForestOfLove.Narrative.Dialogue::primaryActor
IL_0623: call System.String ForestProbe::DiagnosticValue(System.Object)
IL_0628: stelem.ref
IL_0629: dup
IL_062a: ldc.i4.4
IL_062b: ldstr " | quest="
IL_0630: stelem.ref
IL_0631: dup
IL_0632: ldc.i4.5
IL_0633: ldloc.1
IL_0634: ldfld TheForestOfLove.Narrative.Quest TheForestOfLove.Narrative.Dialogue::quest
IL_0639: call System.String ForestProbe::DiagnosticValue(System.Object)
IL_063e: stelem.ref
IL_063f: dup
IL_0640: ldc.i4.6
IL_0641: ldstr " | status="
IL_0646: stelem.ref
IL_0647: dup
IL_0648: ldc.i4.7
IL_0649: ldloc.1
IL_064a: callvirt TheForestOfLove.Narrative.DialogueStatus TheForestOfLove.Narrative.Dialogue::get_status()
IL_064f: stloc.s V_31
IL_0651: ldloca.s V_31
IL_0653: constrained. TheForestOfLove.Narrative.DialogueStatus
IL_0659: callvirt System.String System.Object::ToString()
IL_065e: stelem.ref
IL_065f: call System.String System.String::Concat(System.String[])
IL_0664: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0669: nop
IL_066a: nop
IL_066b: ldloc.1
IL_066c: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.DialoguePreconditions.DialoguePrecondition> TheForestOfLove.Narrative.Dialogue::preconditions
IL_0671: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.DialoguePreconditions.DialoguePrecondition>::GetEnumerator()
IL_0676: stloc.s V_32
IL_0678: br.s IL_06a5
IL_067a: ldloca.s V_32
IL_067c: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.DialoguePreconditions.DialoguePrecondition>::get_Current()
IL_0681: stloc.s V_33
IL_0683: nop
IL_0684: ldloc.0
IL_0685: ldloc.s V_33
IL_0687: ldloc.s V_33
IL_0689: callvirt System.Type System.Object::GetType()
IL_068e: callvirt System.String System.Reflection.MemberInfo::get_Name()
IL_0693: ldstr "."
IL_0698: call System.String System.String::Concat(System.String,System.String)
IL_069d: ldc.i4.1
IL_069e: call System.Void ForestProbe::NotebookConditionFields(System.Collections.Generic.List`1<System.String>,System.Object,System.String,System.Int32)
IL_06a3: nop
IL_06a4: nop
IL_06a5: ldloca.s V_32
IL_06a7: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.DialoguePreconditions.DialoguePrecondition>::MoveNext()
IL_06ac: brtrue.s IL_067a
IL_06ae: leave.s IL_06bf
IL_06b0: ldloca.s V_32
IL_06b2: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.DialoguePreconditions.DialoguePrecondition>
IL_06b8: callvirt System.Void System.IDisposable::Dispose()
IL_06bd: nop
IL_06be: endfinally
IL_06bf: nop
IL_06c0: ldloc.1
IL_06c1: ldnull
IL_06c2: cgt.un
IL_06c4: stloc.s V_34
IL_06c6: ldloc.s V_34
IL_06c8: brfalse IL_07ab
IL_06cd: nop
IL_06ce: ldloc.1
IL_06cf: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.ArcTriggers.ArcTrigger> TheForestOfLove.Narrative.Dialogue::arcTriggers
IL_06d4: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.ArcTriggers.ArcTrigger>::GetEnumerator()
IL_06d9: stloc.s V_35
IL_06db: br IL_078e
IL_06e0: ldloca.s V_35
IL_06e2: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.ArcTriggers.ArcTrigger>::get_Current()
IL_06e7: stloc.s V_36
IL_06e9: nop
IL_06ea: ldloc.s V_36
IL_06ec: isinst TheForestOfLove.Narrative.ArcTriggers.ArcTriggerFireNamedTrigger
IL_06f1: stloc.s V_37
IL_06f3: ldloc.s V_37
IL_06f5: brfalse.s IL_070a
IL_06f7: ldloc.s V_37
IL_06f9: ldfld System.String TheForestOfLove.Narrative.ArcTriggers.ArcTriggerFireNamedTrigger::triggerPluginDbName
IL_06fe: ldstr "notebook_unlocked"
IL_0703: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0708: br.s IL_070b
IL_070a: ldc.i4.0
IL_070b: stloc.s V_38
IL_070d: ldloc.s V_38
IL_070f: brfalse.s IL_078d
IL_0711: ldloc.0
IL_0712: ldc.i4.8
IL_0713: newarr System.String
IL_0718: dup
IL_0719: ldc.i4.0
IL_071a: ldstr "notebookTrigger | conversation="
IL_071f: stelem.ref
IL_0720: dup
IL_0721: ldc.i4.1
IL_0722: ldloc.s V_37
IL_0724: callvirt System.Int32 TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::GetConversationId()
IL_0729: stloc.s V_27
IL_072b: ldloca.s V_27
IL_072d: call System.String System.Int32::ToString()
IL_0732: stelem.ref
IL_0733: dup
IL_0734: ldc.i4.2
IL_0735: ldstr " | entry="
IL_073a: stelem.ref
IL_073b: dup
IL_073c: ldc.i4.3
IL_073d: ldloc.s V_37
IL_073f: callvirt System.Int32 TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::GetDialogueEntryId()
IL_0744: stloc.s V_27
IL_0746: ldloca.s V_27
IL_0748: call System.String System.Int32::ToString()
IL_074d: stelem.ref
IL_074e: dup
IL_074f: ldc.i4.4
IL_0750: ldstr " | executed="
IL_0755: stelem.ref
IL_0756: dup
IL_0757: ldc.i4.5
IL_0758: ldloc.s V_37
IL_075a: callvirt System.Boolean TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::get_isExecuted()
IL_075f: stloc.2
IL_0760: ldloca.s V_2
IL_0762: call System.String System.Boolean::ToString()
IL_0767: stelem.ref
IL_0768: dup
IL_0769: ldc.i4.6
IL_076a: ldstr " | skipChapterSelect="
IL_076f: stelem.ref
IL_0770: dup
IL_0771: ldc.i4.7
IL_0772: ldloc.s V_37
IL_0774: callvirt System.Boolean TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::get_skipDuringChapterSelect()
IL_0779: stloc.2
IL_077a: ldloca.s V_2
IL_077c: call System.String System.Boolean::ToString()
IL_0781: stelem.ref
IL_0782: call System.String System.String::Concat(System.String[])
IL_0787: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_078c: nop
IL_078d: nop
IL_078e: ldloca.s V_35
IL_0790: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.ArcTriggers.ArcTrigger>::MoveNext()
IL_0795: brtrue IL_06e0
IL_079a: leave.s IL_07ab
IL_079c: ldloca.s V_35
IL_079e: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.ArcTriggers.ArcTrigger>
IL_07a4: callvirt System.Void System.IDisposable::Dispose()
IL_07a9: nop
IL_07aa: endfinally
IL_07ab: nop
IL_07ac: call !!0[] UnityEngine.Resources::FindObjectsOfTypeAll<TheForestOfLove.InventoryInfoTicker>()
IL_07b1: stloc.s V_39
IL_07b3: ldc.i4.0
IL_07b4: stloc.s V_40
IL_07b6: br IL_099b
IL_07bb: ldloc.s V_39
IL_07bd: ldloc.s V_40
IL_07bf: ldelem.ref
IL_07c0: stloc.s V_41
IL_07c2: ldloc.s V_41
IL_07c4: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_07c9: callvirt UnityEngine.SceneManagement.Scene UnityEngine.GameObject::get_scene()
IL_07ce: stloc.s V_7
IL_07d0: ldloca.s V_7
IL_07d2: call System.Boolean UnityEngine.SceneManagement.Scene::IsValid()
IL_07d7: stloc.s V_42
IL_07d9: ldloc.s V_42
IL_07db: brfalse IL_0995
IL_07e0: nop
IL_07e1: ldloc.0
IL_07e2: ldc.i4.s 12
IL_07e4: newarr System.String
IL_07e9: dup
IL_07ea: ldc.i4.0
IL_07eb: ldstr "ticker | instance="
IL_07f0: stelem.ref
IL_07f1: dup
IL_07f2: ldc.i4.1
IL_07f3: ldloc.s V_41
IL_07f5: callvirt System.Int32 UnityEngine.Object::GetInstanceID()
IL_07fa: stloc.s V_27
IL_07fc: ldloca.s V_27
IL_07fe: call System.String System.Int32::ToString()
IL_0803: stelem.ref
IL_0804: dup
IL_0805: ldc.i4.2
IL_0806: ldstr " | path="
IL_080b: stelem.ref
IL_080c: dup
IL_080d: ldc.i4.3
IL_080e: ldloc.s V_41
IL_0810: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0815: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_081a: stelem.ref
IL_081b: dup
IL_081c: ldc.i4.4
IL_081d: ldstr " | activeSelf="
IL_0822: stelem.ref
IL_0823: dup
IL_0824: ldc.i4.5
IL_0825: ldloc.s V_41
IL_0827: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_082c: callvirt System.Boolean UnityEngine.GameObject::get_activeSelf()
IL_0831: stloc.2
IL_0832: ldloca.s V_2
IL_0834: call System.String System.Boolean::ToString()
IL_0839: stelem.ref
IL_083a: dup
IL_083b: ldc.i4.6
IL_083c: ldstr " | activeInHierarchy="
IL_0841: stelem.ref
IL_0842: dup
IL_0843: ldc.i4.7
IL_0844: ldloc.s V_41
IL_0846: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_084b: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_0850: stloc.2
IL_0851: ldloca.s V_2
IL_0853: call System.String System.Boolean::ToString()
IL_0858: stelem.ref
IL_0859: dup
IL_085a: ldc.i4.8
IL_085b: ldstr " | enabled="
IL_0860: stelem.ref
IL_0861: dup
IL_0862: ldc.i4.s 9
IL_0864: ldloc.s V_41
IL_0866: callvirt System.Boolean UnityEngine.Behaviour::get_enabled()
IL_086b: stloc.2
IL_086c: ldloca.s V_2
IL_086e: call System.String System.Boolean::ToString()
IL_0873: stelem.ref
IL_0874: dup
IL_0875: ldc.i4.s 10
IL_0877: ldstr " | isActiveAndEnabled="
IL_087c: stelem.ref
IL_087d: dup
IL_087e: ldc.i4.s 11
IL_0880: ldloc.s V_41
IL_0882: callvirt System.Boolean UnityEngine.Behaviour::get_isActiveAndEnabled()
IL_0887: stloc.2
IL_0888: ldloca.s V_2
IL_088a: call System.String System.Boolean::ToString()
IL_088f: stelem.ref
IL_0890: call System.String System.String::Concat(System.String[])
IL_0895: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_089a: nop
IL_089b: nop
IL_089c: ldc.i4.2
IL_089d: newarr System.String
IL_08a2: dup
IL_08a3: ldc.i4.0
IL_08a4: ldstr "itemTitleText"
IL_08a9: stelem.ref
IL_08aa: dup
IL_08ab: ldc.i4.1
IL_08ac: ldstr "tickerText"
IL_08b1: stelem.ref
IL_08b2: stloc.s V_43
IL_08b4: ldc.i4.0
IL_08b5: stloc.s V_44
IL_08b7: br IL_0989
IL_08bc: ldloc.s V_43
IL_08be: ldloc.s V_44
IL_08c0: ldelem.ref
IL_08c1: stloc.s V_45
IL_08c3: nop
IL_08c4: ldloc.s V_41
IL_08c6: callvirt System.Type System.Object::GetType()
IL_08cb: ldloc.s V_45
IL_08cd: ldc.i4.s 52
IL_08cf: callvirt System.Reflection.FieldInfo System.Type::GetField(System.String,System.Reflection.BindingFlags)
IL_08d4: ldloc.s V_41
IL_08d6: callvirt System.Object System.Reflection.FieldInfo::GetValue(System.Object)
IL_08db: castclass UnityEngine.UI.Text
IL_08e0: stloc.s V_46
IL_08e2: ldloc.0
IL_08e3: ldc.i4.s 12
IL_08e5: newarr System.String
IL_08ea: dup
IL_08eb: ldc.i4.0
IL_08ec: ldstr "tickerText | controller="
IL_08f1: stelem.ref
IL_08f2: dup
IL_08f3: ldc.i4.1
IL_08f4: ldloc.s V_41
IL_08f6: callvirt System.Int32 UnityEngine.Object::GetInstanceID()
IL_08fb: stloc.s V_27
IL_08fd: ldloca.s V_27
IL_08ff: call System.String System.Int32::ToString()
IL_0904: stelem.ref
IL_0905: dup
IL_0906: ldc.i4.2
IL_0907: ldstr " | field="
IL_090c: stelem.ref
IL_090d: dup
IL_090e: ldc.i4.3
IL_090f: ldloc.s V_45
IL_0911: stelem.ref
IL_0912: dup
IL_0913: ldc.i4.4
IL_0914: ldstr " | path="
IL_0919: stelem.ref
IL_091a: dup
IL_091b: ldc.i4.5
IL_091c: ldloc.s V_46
IL_091e: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0923: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_0928: stelem.ref
IL_0929: dup
IL_092a: ldc.i4.6
IL_092b: ldstr " | active="
IL_0930: stelem.ref
IL_0931: dup
IL_0932: ldc.i4.7
IL_0933: ldloc.s V_46
IL_0935: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_093a: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_093f: stloc.2
IL_0940: ldloca.s V_2
IL_0942: call System.String System.Boolean::ToString()
IL_0947: stelem.ref
IL_0948: dup
IL_0949: ldc.i4.8
IL_094a: ldstr " | enabled="
IL_094f: stelem.ref
IL_0950: dup
IL_0951: ldc.i4.s 9
IL_0953: ldloc.s V_46
IL_0955: callvirt System.Boolean UnityEngine.Behaviour::get_enabled()
IL_095a: stloc.2
IL_095b: ldloca.s V_2
IL_095d: call System.String System.Boolean::ToString()
IL_0962: stelem.ref
IL_0963: dup
IL_0964: ldc.i4.s 10
IL_0966: ldstr " | text="
IL_096b: stelem.ref
IL_096c: dup
IL_096d: ldc.i4.s 11
IL_096f: ldloc.s V_46
IL_0971: callvirt System.String UnityEngine.UI.Text::get_text()
IL_0976: stelem.ref
IL_0977: call System.String System.String::Concat(System.String[])
IL_097c: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0981: nop
IL_0982: nop
IL_0983: ldloc.s V_44
IL_0985: ldc.i4.1
IL_0986: add
IL_0987: stloc.s V_44
IL_0989: ldloc.s V_44
IL_098b: ldloc.s V_43
IL_098d: ldlen
IL_098e: conv.i4
IL_098f: blt IL_08bc
IL_0994: nop
IL_0995: ldloc.s V_40
IL_0997: ldc.i4.1
IL_0998: add
IL_0999: stloc.s V_40
IL_099b: ldloc.s V_40
IL_099d: ldloc.s V_39
IL_099f: ldlen
IL_09a0: conv.i4
IL_09a1: blt IL_07bb
IL_09a6: ldloc.0
IL_09a7: callvirt !0[] System.Collections.Generic.List`1<System.String>::ToArray()
IL_09ac: stloc.s V_47
IL_09ae: br.s IL_09b0
IL_09b0: ldloc.s V_47
IL_09b2: ret
METHOD System.Collections.Generic.List`1<ForestProbe/ResponseRow> ForestProbe::ReadResponses() | attributes=Private, HideBySig | impl=IL
IL_0000: nop
IL_0001: newobj System.Void System.Collections.Generic.List`1<ForestProbe/ResponseRow>::.ctor()
IL_0006: stloc.0
IL_0007: nop
IL_0008: call !!0[] UnityEngine.Resources::FindObjectsOfTypeAll<PixelCrushers.DialogueSystem.StandardUIResponseButton>()
IL_000d: stloc.1
IL_000e: ldc.i4.0
IL_000f: stloc.2
IL_0010: br IL_00f5
IL_0015: ldloc.1
IL_0016: ldloc.2
IL_0017: ldelem.ref
IL_0018: stloc.3
IL_0019: ldloc.3
IL_001a: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_001f: callvirt UnityEngine.SceneManagement.Scene UnityEngine.GameObject::get_scene()
IL_0024: stloc.s V_5
IL_0026: ldloca.s V_5
IL_0028: call System.Boolean UnityEngine.SceneManagement.Scene::IsValid()
IL_002d: brfalse.s IL_0054
IL_002f: ldloc.3
IL_0030: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0035: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_003a: brfalse.s IL_0054
IL_003c: ldloc.3
IL_003d: callvirt PixelCrushers.DialogueSystem.Response PixelCrushers.DialogueSystem.StandardUIResponseButton::get_response()
IL_0042: brfalse.s IL_0054
IL_0044: ldloc.3
IL_0045: callvirt PixelCrushers.DialogueSystem.Response PixelCrushers.DialogueSystem.StandardUIResponseButton::get_response()
IL_004a: ldfld PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Response::destinationEntry
IL_004f: ldnull
IL_0050: cgt.un
IL_0052: br.s IL_0055
IL_0054: ldc.i4.0
IL_0055: stloc.s V_4
IL_0057: ldloc.s V_4
IL_0059: brfalse IL_00f1
IL_005e: ldloc.0
IL_005f: newobj System.Void ForestProbe/ResponseRow::.ctor()
IL_0064: dup
IL_0065: ldloc.3
IL_0066: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_006b: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_0070: stfld System.String ForestProbe/ResponseRow::path
IL_0075: dup
IL_0076: ldloc.3
IL_0077: callvirt System.String PixelCrushers.DialogueSystem.StandardUIResponseButton::get_text()
IL_007c: stfld System.String ForestProbe/ResponseRow::text
IL_0081: dup
IL_0082: ldloc.3
IL_0083: callvirt UnityEngine.Transform PixelCrushers.DialogueSystem.StandardUIResponseButton::get_target()
IL_0088: ldnull
IL_0089: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_008e: brtrue.s IL_009d
IL_0090: ldloc.3
IL_0091: callvirt UnityEngine.Transform PixelCrushers.DialogueSystem.StandardUIResponseButton::get_target()
IL_0096: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_009b: br.s IL_00a2
IL_009d: ldstr ""
IL_00a2: stfld System.String ForestProbe/ResponseRow::targetPath
IL_00a7: dup
IL_00a8: ldloc.3
IL_00a9: callvirt System.Boolean PixelCrushers.DialogueSystem.StandardUIResponseButton::get_isVisible()
IL_00ae: stfld System.Boolean ForestProbe/ResponseRow::visible
IL_00b3: dup
IL_00b4: ldloc.3
IL_00b5: callvirt System.Boolean PixelCrushers.DialogueSystem.StandardUIResponseButton::get_isClickable()
IL_00ba: stfld System.Boolean ForestProbe/ResponseRow::clickable
IL_00bf: dup
IL_00c0: ldloc.3
IL_00c1: callvirt PixelCrushers.DialogueSystem.Response PixelCrushers.DialogueSystem.StandardUIResponseButton::get_response()
IL_00c6: ldfld PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Response::destinationEntry
IL_00cb: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::conversationID
IL_00d0: stfld System.Int32 ForestProbe/ResponseRow::conversationId
IL_00d5: dup
IL_00d6: ldloc.3
IL_00d7: callvirt PixelCrushers.DialogueSystem.Response PixelCrushers.DialogueSystem.StandardUIResponseButton::get_response()
IL_00dc: ldfld PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Response::destinationEntry
IL_00e1: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_00e6: stfld System.Int32 ForestProbe/ResponseRow::entryId
IL_00eb: callvirt System.Void System.Collections.Generic.List`1<ForestProbe/ResponseRow>::Add(!0)
IL_00f0: nop
IL_00f1: ldloc.2
IL_00f2: ldc.i4.1
IL_00f3: add
IL_00f4: stloc.2
IL_00f5: ldloc.2
IL_00f6: ldloc.1
IL_00f7: ldlen
IL_00f8: conv.i4
IL_00f9: blt IL_0015
IL_00fe: ldloc.0
IL_00ff: stloc.s V_6
IL_0101: br.s IL_0103
IL_0103: ldloc.s V_6
IL_0105: ret
METHOD System.Void ForestProbe::ReadConversation(ForestProbe/State) | attributes=Private, HideBySig | impl=IL
IL_0000: nop
IL_0001: ldarg.1
IL_0002: call System.Boolean PixelCrushers.DialogueSystem.DialogueManager::get_isConversationActive()
IL_0007: stfld System.Boolean ForestProbe/State::conversationActive
IL_000c: ldarg.1
IL_000d: ldfld System.Boolean ForestProbe/State::conversationActive
IL_0012: brfalse.s IL_001e
IL_0014: call PixelCrushers.DialogueSystem.ConversationState PixelCrushers.DialogueSystem.DialogueManager::get_currentConversationState()
IL_0019: ldnull
IL_001a: cgt.un
IL_001c: br.s IL_001f
IL_001e: ldc.i4.0
IL_001f: stloc.0
IL_0020: ldloc.0
IL_0021: brfalse.s IL_008b
IL_0023: nop
IL_0024: call PixelCrushers.DialogueSystem.ConversationState PixelCrushers.DialogueSystem.DialogueManager::get_currentConversationState()
IL_0029: ldfld PixelCrushers.DialogueSystem.Subtitle PixelCrushers.DialogueSystem.ConversationState::subtitle
IL_002e: stloc.1
IL_002f: ldloc.1
IL_0030: ldnull
IL_0031: cgt.un
IL_0033: stloc.2
IL_0034: ldloc.2
IL_0035: brfalse.s IL_008a
IL_0037: nop
IL_0038: ldarg.1
IL_0039: ldloc.1
IL_003a: ldfld PixelCrushers.DialogueSystem.FormattedText PixelCrushers.DialogueSystem.Subtitle::formattedText
IL_003f: brfalse.s IL_004e
IL_0041: ldloc.1
IL_0042: ldfld PixelCrushers.DialogueSystem.FormattedText PixelCrushers.DialogueSystem.Subtitle::formattedText
IL_0047: callvirt System.String PixelCrushers.DialogueSystem.FormattedText::get_text()
IL_004c: br.s IL_0053
IL_004e: ldstr ""
IL_0053: stfld System.String ForestProbe/State::conversationState
IL_0058: ldloc.1
IL_0059: ldfld PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Subtitle::dialogueEntry
IL_005e: ldnull
IL_005f: cgt.un
IL_0061: stloc.3
IL_0062: ldloc.3
IL_0063: brfalse.s IL_0089
IL_0065: nop
IL_0066: ldarg.1
IL_0067: ldloc.1
IL_0068: ldfld PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Subtitle::dialogueEntry
IL_006d: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::conversationID
IL_0072: stfld System.Int32 ForestProbe/State::conversationId
IL_0077: ldarg.1
IL_0078: ldloc.1
IL_0079: ldfld PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Subtitle::dialogueEntry
IL_007e: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_0083: stfld System.Int32 ForestProbe/State::entryId
IL_0088: nop
IL_0089: nop
IL_008a: nop
IL_008b: ret
METHOD System.Void ForestProbe::DumpIntro() | attributes=Private, HideBySig | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: call System.Collections.Generic.List`1<ForestProbe/ResponseRow> ForestProbe::ReadResponses()
IL_0007: stloc.0
IL_0008: newobj System.Void System.Collections.Generic.List`1<System.String>::.ctor()
IL_000d: stloc.1
IL_000e: ldloc.1
IL_000f: ldc.i4.8
IL_0010: newarr System.String
IL_0015: dup
IL_0016: ldc.i4.0
IL_0017: ldstr "guards | gameplay="
IL_001c: stelem.ref
IL_001d: dup
IL_001e: ldc.i4.1
IL_001f: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inGameplayScene()
IL_0024: stloc.3
IL_0025: ldloca.s V_3
IL_0027: call System.String System.Boolean::ToString()
IL_002c: stelem.ref
IL_002d: dup
IL_002e: ldc.i4.2
IL_002f: ldstr " | dustin="
IL_0034: stelem.ref
IL_0035: dup
IL_0036: ldc.i4.3
IL_0037: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inDustinMinigame()
IL_003c: stloc.3
IL_003d: ldloca.s V_3
IL_003f: call System.String System.Boolean::ToString()
IL_0044: stelem.ref
IL_0045: dup
IL_0046: ldc.i4.4
IL_0047: ldstr " | glitch="
IL_004c: stelem.ref
IL_004d: dup
IL_004e: ldc.i4.5
IL_004f: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inGlitchRoom()
IL_0054: stloc.3
IL_0055: ldloca.s V_3
IL_0057: call System.String System.Boolean::ToString()
IL_005c: stelem.ref
IL_005d: dup
IL_005e: ldc.i4.6
IL_005f: ldstr " | anyEvent="
IL_0064: stelem.ref
IL_0065: dup
IL_0066: ldc.i4.7
IL_0067: call System.Boolean TheForestOfLove.Events.GameStateManager::get_isAnyEventActive()
IL_006c: stloc.3
IL_006d: ldloca.s V_3
IL_006f: call System.String System.Boolean::ToString()
IL_0074: stelem.ref
IL_0075: call System.String System.String::Concat(System.String[])
IL_007a: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_007f: nop
IL_0080: ldloc.1
IL_0081: ldarg.0
IL_0082: call System.String[] ForestProbe::IntroCleanupDiagnostics()
IL_0087: callvirt System.Void System.Collections.Generic.List`1<System.String>::AddRange(System.Collections.Generic.IEnumerable`1<!0>)
IL_008c: nop
IL_008d: newobj System.Void ForestProbe/State::.ctor()
IL_0092: dup
IL_0093: call UnityEngine.SceneManagement.Scene UnityEngine.SceneManagement.SceneManager::GetActiveScene()
IL_0098: stloc.s V_4
IL_009a: ldloca.s V_4
IL_009c: call System.String UnityEngine.SceneManagement.Scene::get_name()
IL_00a1: stfld System.String ForestProbe/State::scene
IL_00a6: dup
IL_00a7: call System.String UnityEngine.Application::get_dataPath()
IL_00ac: stfld System.String ForestProbe/State::dataPath
IL_00b1: dup
IL_00b2: call System.String UnityEngine.Application::get_persistentDataPath()
IL_00b7: stfld System.String ForestProbe/State::persistentDataPath
IL_00bc: dup
IL_00bd: call System.String UnityEngine.Application::get_companyName()
IL_00c2: stfld System.String ForestProbe/State::company
IL_00c7: dup
IL_00c8: call System.String UnityEngine.Application::get_productName()
IL_00cd: stfld System.String ForestProbe/State::product
IL_00d2: dup
IL_00d3: call System.Int32 UnityEngine.Time::get_frameCount()
IL_00d8: stfld System.Int32 ForestProbe/State::frame
IL_00dd: dup
IL_00de: call System.Single UnityEngine.Time::get_realtimeSinceStartup()
IL_00e3: stfld System.Single ForestProbe/State::realtime
IL_00e8: dup
IL_00e9: call System.Single UnityEngine.Time::get_time()
IL_00ee: stfld System.Single ForestProbe/State::scaledTime
IL_00f3: dup
IL_00f4: call System.Single UnityEngine.Time::get_timeScale()
IL_00f9: stfld System.Single ForestProbe/State::timeScale
IL_00fe: dup
IL_00ff: call System.String TheForestOfLove.Narrative.DialogueService::get_CurrentDialogueDbName()
IL_0104: stfld System.String ForestProbe/State::narrativeDbName
IL_0109: dup
IL_010a: call System.String TheForestOfLove.Narrative.DialogueService::get_CurrentArcName()
IL_010f: stfld System.String ForestProbe/State::narrativeArcName
IL_0114: dup
IL_0115: ldloc.0
IL_0116: callvirt System.Int32 System.Collections.Generic.List`1<ForestProbe/ResponseRow>::get_Count()
IL_011b: stfld System.Int32 ForestProbe/State::responseCount
IL_0120: dup
IL_0121: ldloc.0
IL_0122: ldsfld System.Converter`2<ForestProbe/ResponseRow,System.String> ForestProbe/<>c::<>9__47_0
IL_0127: dup
IL_0128: brtrue.s IL_0141
IL_012a: pop
IL_012b: ldsfld ForestProbe/<>c ForestProbe/<>c::<>9
IL_0130: ldftn System.String ForestProbe/<>c::<DumpIntro>b__47_0(ForestProbe/ResponseRow)
IL_0136: newobj System.Void System.Converter`2<ForestProbe/ResponseRow,System.String>::.ctor(System.Object,System.IntPtr)
IL_013b: dup
IL_013c: stsfld System.Converter`2<ForestProbe/ResponseRow,System.String> ForestProbe/<>c::<>9__47_0
IL_0141: callvirt System.Collections.Generic.List`1<!!0> System.Collections.Generic.List`1<ForestProbe/ResponseRow>::ConvertAll<System.String>(System.Converter`2<!0,!!0>)
IL_0146: callvirt !0[] System.Collections.Generic.List`1<System.String>::ToArray()
IL_014b: stfld System.String[] ForestProbe/State::responseRecords
IL_0150: dup
IL_0151: call System.Boolean TheForestOfLove.CustomTypewriterEffectTextMeshPro::IsTyping()
IL_0156: stfld System.Boolean ForestProbe/State::typing
IL_015b: dup
IL_015c: ldloc.1
IL_015d: callvirt !0[] System.Collections.Generic.List`1<System.String>::ToArray()
IL_0162: stfld System.String[] ForestProbe/State::introDiagnostics
IL_0167: stloc.2
IL_0168: ldarg.0
IL_0169: ldloc.2
IL_016a: call System.Void ForestProbe::ReadConversation(ForestProbe/State)
IL_016f: nop
IL_0170: ldarg.0
IL_0171: ldfld System.String ForestProbe::root
IL_0176: ldstr "intro-state.json"
IL_017b: call System.String System.IO.Path::Combine(System.String,System.String)
IL_0180: ldloc.2
IL_0181: ldc.i4.1
IL_0182: call System.String UnityEngine.JsonUtility::ToJson(System.Object,System.Boolean)
IL_0187: call System.Void System.IO.File::WriteAllText(System.String,System.String)
IL_018c: nop
IL_018d: ret
METHOD System.Void ForestProbe::Dump() | attributes=Private, HideBySig | impl=IL
IL_0000: nop
IL_0001: newobj System.Void System.Collections.Generic.List`1<ForestProbe/TextRow>::.ctor()
IL_0006: stloc.0
IL_0007: newobj System.Void System.Collections.Generic.List`1<System.String>::.ctor()
IL_000c: stloc.1
IL_000d: newobj System.Void System.Collections.Generic.List`1<System.String>::.ctor()
IL_0012: stloc.2
IL_0013: ldarg.0
IL_0014: call System.Collections.Generic.List`1<ForestProbe/ResponseRow> ForestProbe::ReadResponses()
IL_0019: stloc.3
IL_001a: call !!0[] UnityEngine.Resources::FindObjectsOfTypeAll<TMPro.TMP_Text>()
IL_001f: stloc.s V_4
IL_0021: newobj System.Void System.Collections.Generic.List`1<System.String>::.ctor()
IL_0026: stloc.s V_5
IL_0028: newobj System.Void System.Collections.Generic.List`1<System.String>::.ctor()
IL_002d: stloc.s V_6
IL_002f: newobj System.Void System.Collections.Generic.List`1<System.String>::.ctor()
IL_0034: stloc.s V_7
IL_0036: newobj System.Void System.Collections.Generic.List`1<System.String>::.ctor()
IL_003b: stloc.s V_8
IL_003d: newobj System.Void System.Collections.Generic.List`1<System.String>::.ctor()
IL_0042: stloc.s V_9
IL_0044: newobj System.Void System.Collections.Generic.List`1<System.String>::.ctor()
IL_0049: stloc.s V_10
IL_004b: newobj System.Void System.Collections.Generic.List`1<System.String>::.ctor()
IL_0050: stloc.s V_11
IL_0052: call !!0 UnityEngine.Object::FindObjectOfType<TheForestOfLove.UI.WindowController>()
IL_0057: stloc.s V_12
IL_0059: ldloc.s V_12
IL_005b: ldnull
IL_005c: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0061: stloc.s V_15
IL_0063: ldloc.s V_15
IL_0065: brfalse IL_0182
IL_006a: nop
IL_006b: ldc.i4.s 52
IL_006d: stloc.s V_16
IL_006f: ldloc.s V_12
IL_0071: callvirt System.Type System.Object::GetType()
IL_0076: ldstr "windowSizeSettings"
IL_007b: ldloc.s V_16
IL_007d: callvirt System.Reflection.FieldInfo System.Type::GetField(System.String,System.Reflection.BindingFlags)
IL_0082: ldloc.s V_12
IL_0084: callvirt System.Object System.Reflection.FieldInfo::GetValue(System.Object)
IL_0089: castclass System.Collections.IEnumerable
IL_008e: stloc.s V_17
IL_0090: ldc.i4.0
IL_0091: stloc.s V_18
IL_0093: nop
IL_0094: ldloc.s V_17
IL_0096: callvirt System.Collections.IEnumerator System.Collections.IEnumerable::GetEnumerator()
IL_009b: stloc.s V_19
IL_009d: br IL_015d
IL_00a2: ldloc.s V_19
IL_00a4: callvirt System.Object System.Collections.IEnumerator::get_Current()
IL_00a9: stloc.s V_20
IL_00ab: nop
IL_00ac: ldloc.s V_20
IL_00ae: callvirt System.Type System.Object::GetType()
IL_00b3: stloc.s V_21
IL_00b5: ldloc.s V_10
IL_00b7: ldc.i4.7
IL_00b8: newarr System.String
IL_00bd: dup
IL_00be: ldc.i4.0
IL_00bf: ldloca.s V_18
IL_00c1: call System.String System.Int32::ToString()
IL_00c6: stelem.ref
IL_00c7: dup
IL_00c8: ldc.i4.1
IL_00c9: ldstr " | width="
IL_00ce: stelem.ref
IL_00cf: dup
IL_00d0: ldc.i4.2
IL_00d1: ldloc.s V_21
IL_00d3: ldstr "targetWidth"
IL_00d8: ldloc.s V_16
IL_00da: callvirt System.Reflection.FieldInfo System.Type::GetField(System.String,System.Reflection.BindingFlags)
IL_00df: ldloc.s V_20
IL_00e1: callvirt System.Object System.Reflection.FieldInfo::GetValue(System.Object)
IL_00e6: dup
IL_00e7: brtrue.s IL_00ed
IL_00e9: pop
IL_00ea: ldnull
IL_00eb: br.s IL_00f2
IL_00ed: callvirt System.String System.Object::ToString()
IL_00f2: stelem.ref
IL_00f3: dup
IL_00f4: ldc.i4.3
IL_00f5: ldstr " | height="
IL_00fa: stelem.ref
IL_00fb: dup
IL_00fc: ldc.i4.4
IL_00fd: ldloc.s V_21
IL_00ff: ldstr "targetHeight"
IL_0104: ldloc.s V_16
IL_0106: callvirt System.Reflection.FieldInfo System.Type::GetField(System.String,System.Reflection.BindingFlags)
IL_010b: ldloc.s V_20
IL_010d: callvirt System.Object System.Reflection.FieldInfo::GetValue(System.Object)
IL_0112: dup
IL_0113: brtrue.s IL_0119
IL_0115: pop
IL_0116: ldnull
IL_0117: br.s IL_011e
IL_0119: callvirt System.String System.Object::ToString()
IL_011e: stelem.ref
IL_011f: dup
IL_0120: ldc.i4.5
IL_0121: ldstr " | eligible="
IL_0126: stelem.ref
IL_0127: dup
IL_0128: ldc.i4.6
IL_0129: ldloc.s V_21
IL_012b: ldstr "eligible"
IL_0130: ldloc.s V_16
IL_0132: callvirt System.Reflection.FieldInfo System.Type::GetField(System.String,System.Reflection.BindingFlags)
IL_0137: ldloc.s V_20
IL_0139: callvirt System.Object System.Reflection.FieldInfo::GetValue(System.Object)
IL_013e: dup
IL_013f: brtrue.s IL_0145
IL_0141: pop
IL_0142: ldnull
IL_0143: br.s IL_014a
IL_0145: callvirt System.String System.Object::ToString()
IL_014a: stelem.ref
IL_014b: call System.String System.String::Concat(System.String[])
IL_0150: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0155: nop
IL_0156: ldloc.s V_18
IL_0158: ldc.i4.1
IL_0159: add
IL_015a: stloc.s V_18
IL_015c: nop
IL_015d: ldloc.s V_19
IL_015f: callvirt System.Boolean System.Collections.IEnumerator::MoveNext()
IL_0164: brtrue IL_00a2
IL_0169: leave.s IL_0181
IL_016b: ldloc.s V_19
IL_016d: isinst System.IDisposable
IL_0172: stloc.s V_22
IL_0174: ldloc.s V_22
IL_0176: brfalse.s IL_0180
IL_0178: ldloc.s V_22
IL_017a: callvirt System.Void System.IDisposable::Dispose()
IL_017f: nop
IL_0180: endfinally
IL_0181: nop
IL_0182: nop
IL_0183: call !!0[] UnityEngine.Resources::FindObjectsOfTypeAll<UnityEngine.CanvasGroup>()
IL_0188: stloc.s V_23
IL_018a: ldc.i4.0
IL_018b: stloc.s V_24
IL_018d: br IL_0248
IL_0192: ldloc.s V_23
IL_0194: ldloc.s V_24
IL_0196: ldelem.ref
IL_0197: stloc.s V_25
IL_0199: ldloc.s V_25
IL_019b: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_01a0: callvirt UnityEngine.SceneManagement.Scene UnityEngine.GameObject::get_scene()
IL_01a5: stloc.s V_27
IL_01a7: ldloca.s V_27
IL_01a9: call System.Boolean UnityEngine.SceneManagement.Scene::IsValid()
IL_01ae: brfalse.s IL_01c8
IL_01b0: ldloc.s V_25
IL_01b2: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_01b7: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_01bc: ldstr "Canvas/OptionsMenu/Controls/ScaleFactor"
IL_01c1: callvirt System.Boolean System.String::StartsWith(System.String)
IL_01c6: br.s IL_01c9
IL_01c8: ldc.i4.0
IL_01c9: stloc.s V_26
IL_01cb: ldloc.s V_26
IL_01cd: brfalse.s IL_0242
IL_01cf: ldloc.s V_11
IL_01d1: ldc.i4.7
IL_01d2: newarr System.String
IL_01d7: dup
IL_01d8: ldc.i4.0
IL_01d9: ldloc.s V_25
IL_01db: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_01e0: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_01e5: stelem.ref
IL_01e6: dup
IL_01e7: ldc.i4.1
IL_01e8: ldstr " | alpha="
IL_01ed: stelem.ref
IL_01ee: dup
IL_01ef: ldc.i4.2
IL_01f0: ldloc.s V_25
IL_01f2: callvirt System.Single UnityEngine.CanvasGroup::get_alpha()
IL_01f7: stloc.s V_28
IL_01f9: ldloca.s V_28
IL_01fb: call System.String System.Single::ToString()
IL_0200: stelem.ref
IL_0201: dup
IL_0202: ldc.i4.3
IL_0203: ldstr " | interactable="
IL_0208: stelem.ref
IL_0209: dup
IL_020a: ldc.i4.4
IL_020b: ldloc.s V_25
IL_020d: callvirt System.Boolean UnityEngine.CanvasGroup::get_interactable()
IL_0212: stloc.s V_29
IL_0214: ldloca.s V_29
IL_0216: call System.String System.Boolean::ToString()
IL_021b: stelem.ref
IL_021c: dup
IL_021d: ldc.i4.5
IL_021e: ldstr " | blocksRaycasts="
IL_0223: stelem.ref
IL_0224: dup
IL_0225: ldc.i4.6
IL_0226: ldloc.s V_25
IL_0228: callvirt System.Boolean UnityEngine.CanvasGroup::get_blocksRaycasts()
IL_022d: stloc.s V_29
IL_022f: ldloca.s V_29
IL_0231: call System.String System.Boolean::ToString()
IL_0236: stelem.ref
IL_0237: call System.String System.String::Concat(System.String[])
IL_023c: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0241: nop
IL_0242: ldloc.s V_24
IL_0244: ldc.i4.1
IL_0245: add
IL_0246: stloc.s V_24
IL_0248: ldloc.s V_24
IL_024a: ldloc.s V_23
IL_024c: ldlen
IL_024d: conv.i4
IL_024e: blt IL_0192
IL_0253: nop
IL_0254: ldloc.s V_4
IL_0256: stloc.s V_30
IL_0258: ldc.i4.0
IL_0259: stloc.s V_31
IL_025b: br IL_0763
IL_0260: ldloc.s V_30
IL_0262: ldloc.s V_31
IL_0264: ldelem.ref
IL_0265: stloc.s V_32
IL_0267: ldloc.s V_32
IL_0269: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_026e: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_0273: stloc.s V_33
IL_0275: ldloc.s V_33
IL_0277: brfalse IL_075d
IL_027c: nop
IL_027d: ldloc.s V_32
IL_027f: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0284: callvirt UnityEngine.SceneManagement.Scene UnityEngine.GameObject::get_scene()
IL_0289: stloc.s V_27
IL_028b: ldloca.s V_27
IL_028d: call System.Boolean UnityEngine.SceneManagement.Scene::IsValid()
IL_0292: brfalse.s IL_02ac
IL_0294: ldloc.s V_32
IL_0296: callvirt UnityEngine.Transform TMPro.TMP_Text::get_transform()
IL_029b: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_02a0: ldstr "Canvas/OptionsMenu/"
IL_02a5: callvirt System.Boolean System.String::StartsWith(System.String)
IL_02aa: br.s IL_02ad
IL_02ac: ldc.i4.0
IL_02ad: stloc.s V_34
IL_02af: ldloc.s V_34
IL_02b1: stloc.s V_35
IL_02b3: ldloc.s V_35
IL_02b5: brfalse IL_03c6
IL_02ba: nop
IL_02bb: ldloc.s V_32
IL_02bd: callvirt UnityEngine.RectTransform TMPro.TMP_Text::get_rectTransform()
IL_02c2: stloc.s V_36
IL_02c4: ldloc.s V_36
IL_02c6: callvirt UnityEngine.Vector3 UnityEngine.Transform::get_position()
IL_02cb: stloc.s V_37
IL_02cd: ldloc.s V_36
IL_02cf: callvirt UnityEngine.Rect UnityEngine.RectTransform::get_rect()
IL_02d4: stloc.s V_38
IL_02d6: ldloc.s V_8
IL_02d8: call System.Globalization.CultureInfo System.Globalization.CultureInfo::get_InvariantCulture()
IL_02dd: ldstr "{0} | text={1} | fontSize={2:R} | alignment={3} | color={4} | world=({5:R},{6:R}) | rect=({7:R},{8:R}) | anchorY=({9:R},{10:R}) | sizeDeltaY={11:R} | preferredHeight={12:R}"
IL_02e2: ldc.i4.s 13
IL_02e4: newarr System.Object
IL_02e9: dup
IL_02ea: ldc.i4.0
IL_02eb: ldloc.s V_32
IL_02ed: callvirt UnityEngine.Transform TMPro.TMP_Text::get_transform()
IL_02f2: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_02f7: stelem.ref
IL_02f8: dup
IL_02f9: ldc.i4.1
IL_02fa: ldloc.s V_32
IL_02fc: callvirt System.String TMPro.TMP_Text::get_text()
IL_0301: stelem.ref
IL_0302: dup
IL_0303: ldc.i4.2
IL_0304: ldloc.s V_32
IL_0306: callvirt System.Single TMPro.TMP_Text::get_fontSize()
IL_030b: box System.Single
IL_0310: stelem.ref
IL_0311: dup
IL_0312: ldc.i4.3
IL_0313: ldloc.s V_32
IL_0315: callvirt TMPro.TextAlignmentOptions TMPro.TMP_Text::get_alignment()
IL_031a: box TMPro.TextAlignmentOptions
IL_031f: stelem.ref
IL_0320: dup
IL_0321: ldc.i4.4
IL_0322: ldloc.s V_32
IL_0324: callvirt UnityEngine.Color UnityEngine.UI.Graphic::get_color()
IL_0329: box UnityEngine.Color
IL_032e: stelem.ref
IL_032f: dup
IL_0330: ldc.i4.5
IL_0331: ldloc.s V_37
IL_0333: ldfld System.Single UnityEngine.Vector3::x
IL_0338: box System.Single
IL_033d: stelem.ref
IL_033e: dup
IL_033f: ldc.i4.6
IL_0340: ldloc.s V_37
IL_0342: ldfld System.Single UnityEngine.Vector3::y
IL_0347: box System.Single
IL_034c: stelem.ref
IL_034d: dup
IL_034e: ldc.i4.7
IL_034f: ldloca.s V_38
IL_0351: call System.Single UnityEngine.Rect::get_width()
IL_0356: box System.Single
IL_035b: stelem.ref
IL_035c: dup
IL_035d: ldc.i4.8
IL_035e: ldloca.s V_38
IL_0360: call System.Single UnityEngine.Rect::get_height()
IL_0365: box System.Single
IL_036a: stelem.ref
IL_036b: dup
IL_036c: ldc.i4.s 9
IL_036e: ldloc.s V_36
IL_0370: callvirt UnityEngine.Vector2 UnityEngine.RectTransform::get_anchorMin()
IL_0375: ldfld System.Single UnityEngine.Vector2::y
IL_037a: box System.Single
IL_037f: stelem.ref
IL_0380: dup
IL_0381: ldc.i4.s 10
IL_0383: ldloc.s V_36
IL_0385: callvirt UnityEngine.Vector2 UnityEngine.RectTransform::get_anchorMax()
IL_038a: ldfld System.Single UnityEngine.Vector2::y
IL_038f: box System.Single
IL_0394: stelem.ref
IL_0395: dup
IL_0396: ldc.i4.s 11
IL_0398: ldloc.s V_36
IL_039a: callvirt UnityEngine.Vector2 UnityEngine.RectTransform::get_sizeDelta()
IL_039f: ldfld System.Single UnityEngine.Vector2::y
IL_03a4: box System.Single
IL_03a9: stelem.ref
IL_03aa: dup
IL_03ab: ldc.i4.s 12
IL_03ad: ldloc.s V_32
IL_03af: callvirt System.Single TMPro.TMP_Text::get_preferredHeight()
IL_03b4: box System.Single
IL_03b9: stelem.ref
IL_03ba: call System.String System.String::Format(System.IFormatProvider,System.String,System.Object[])
IL_03bf: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_03c4: nop
IL_03c5: nop
IL_03c6: ldloc.s V_32
IL_03c8: callvirt System.String UnityEngine.Object::get_name()
IL_03cd: ldstr "Subtitle Text"
IL_03d2: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_03d7: brtrue.s IL_0409
IL_03d9: ldloc.s V_34
IL_03db: brfalse.s IL_0406
IL_03dd: ldloc.s V_32
IL_03df: callvirt System.String TMPro.TMP_Text::get_text()
IL_03e4: ldstr "Off"
IL_03e9: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_03ee: brtrue.s IL_0403
IL_03f0: ldloc.s V_32
IL_03f2: callvirt System.String TMPro.TMP_Text::get_text()
IL_03f7: ldstr "On"
IL_03fc: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0401: br.s IL_0404
IL_0403: ldc.i4.1
IL_0404: br.s IL_0407
IL_0406: ldc.i4.0
IL_0407: br.s IL_040a
IL_0409: ldc.i4.1
IL_040a: stloc.s V_39
IL_040c: ldloc.s V_39
IL_040e: brfalse IL_065b
IL_0413: nop
IL_0414: ldloc.s V_32
IL_0416: callvirt TMPro.TMP_TextInfo TMPro.TMP_Text::get_textInfo()
IL_041b: stloc.s V_40
IL_041d: ldc.i4.0
IL_041e: stloc.s V_41
IL_0420: br IL_0646
IL_0425: nop
IL_0426: ldloc.s V_40
IL_0428: ldfld TMPro.TMP_CharacterInfo[] TMPro.TMP_TextInfo::characterInfo
IL_042d: ldloc.s V_41
IL_042f: ldelem.any TMPro.TMP_CharacterInfo
IL_0434: stloc.s V_42
IL_0436: ldloc.s V_42
IL_0438: ldfld TMPro.TMP_TextElement TMPro.TMP_CharacterInfo::textElement
IL_043d: ldnull
IL_043e: ceq
IL_0440: stloc.s V_46
IL_0442: ldloc.s V_46
IL_0444: brfalse.s IL_044b
IL_0446: br IL_0640
IL_044b: ldloc.s V_42
IL_044d: ldfld TMPro.TMP_TextElement TMPro.TMP_CharacterInfo::textElement
IL_0452: callvirt UnityEngine.TextCore.Glyph TMPro.TMP_TextElement::get_glyph()
IL_0457: stloc.s V_43
IL_0459: ldloc.s V_43
IL_045b: callvirt UnityEngine.TextCore.GlyphMetrics UnityEngine.TextCore.Glyph::get_metrics()
IL_0460: stloc.s V_44
IL_0462: ldloc.s V_32
IL_0464: callvirt UnityEngine.Transform TMPro.TMP_Text::get_transform()
IL_0469: ldloc.s V_42
IL_046b: ldfld System.Single TMPro.TMP_CharacterInfo::origin
IL_0470: ldloc.s V_42
IL_0472: ldfld System.Single TMPro.TMP_CharacterInfo::baseLine
IL_0477: ldc.r4 0
IL_047c: newobj System.Void UnityEngine.Vector3::.ctor(System.Single,System.Single,System.Single)
IL_0481: callvirt UnityEngine.Vector3 UnityEngine.Transform::TransformPoint(UnityEngine.Vector3)
IL_0486: stloc.s V_45
IL_0488: ldloc.s V_34
IL_048a: brtrue.s IL_0490
IL_048c: ldloc.s V_6
IL_048e: br.s IL_0492
IL_0490: ldloc.s V_7
IL_0492: ldloc.s V_32
IL_0494: callvirt UnityEngine.Transform TMPro.TMP_Text::get_transform()
IL_0499: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_049e: ldstr " | "
IL_04a3: call System.Globalization.CultureInfo System.Globalization.CultureInfo::get_InvariantCulture()
IL_04a8: ldstr "{0} | U+{1:X4} | glyph={2} | font={3} | face={4} | origin={5:R} | advance={6:R} | baseline={7:R} | scale={8:R} | bearing=({9:R},{10:R}) | size=({11:R},{12:R}) | glyphAdvance={13:R} | topLeft=({14:R},{15:R}) | bottomRight=({16:R},{17:R}) | worldOriginBaseline=({18:R},{19:R})"
IL_04ad: ldc.i4.s 20
IL_04af: newarr System.Object
IL_04b4: dup
IL_04b5: ldc.i4.0
IL_04b6: ldloc.s V_41
IL_04b8: box System.Int32
IL_04bd: stelem.ref
IL_04be: dup
IL_04bf: ldc.i4.1
IL_04c0: ldloc.s V_42
IL_04c2: ldfld System.Char TMPro.TMP_CharacterInfo::character
IL_04c7: box System.Int32
IL_04cc: stelem.ref
IL_04cd: dup
IL_04ce: ldc.i4.2
IL_04cf: ldloc.s V_43
IL_04d1: callvirt System.UInt32 UnityEngine.TextCore.Glyph::get_index()
IL_04d6: box System.UInt32
IL_04db: stelem.ref
IL_04dc: dup
IL_04dd: ldc.i4.3
IL_04de: ldloc.s V_42
IL_04e0: ldfld TMPro.TMP_FontAsset TMPro.TMP_CharacterInfo::fontAsset
IL_04e5: ldnull
IL_04e6: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_04eb: brtrue.s IL_04fb
IL_04ed: ldloc.s V_42
IL_04ef: ldfld TMPro.TMP_FontAsset TMPro.TMP_CharacterInfo::fontAsset
IL_04f4: callvirt System.String UnityEngine.Object::get_name()
IL_04f9: br.s IL_0500
IL_04fb: ldstr ""
IL_0500: stelem.ref
IL_0501: dup
IL_0502: ldc.i4.4
IL_0503: ldloc.s V_42
IL_0505: ldfld TMPro.TMP_FontAsset TMPro.TMP_CharacterInfo::fontAsset
IL_050a: ldnull
IL_050b: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0510: brtrue.s IL_0529
IL_0512: ldloc.s V_42
IL_0514: ldfld TMPro.TMP_FontAsset TMPro.TMP_CharacterInfo::fontAsset
IL_0519: callvirt UnityEngine.TextCore.FaceInfo TMPro.TMP_FontAsset::get_faceInfo()
IL_051e: stloc.s V_47
IL_0520: ldloca.s V_47
IL_0522: call System.String UnityEngine.TextCore.FaceInfo::get_familyName()
IL_0527: br.s IL_052e
IL_0529: ldstr ""
IL_052e: stelem.ref
IL_052f: dup
IL_0530: ldc.i4.5
IL_0531: ldloc.s V_42
IL_0533: ldfld System.Single TMPro.TMP_CharacterInfo::origin
IL_0538: box System.Single
IL_053d: stelem.ref
IL_053e: dup
IL_053f: ldc.i4.6
IL_0540: ldloc.s V_42
IL_0542: ldfld System.Single TMPro.TMP_CharacterInfo::xAdvance
IL_0547: box System.Single
IL_054c: stelem.ref
IL_054d: dup
IL_054e: ldc.i4.7
IL_054f: ldloc.s V_42
IL_0551: ldfld System.Single TMPro.TMP_CharacterInfo::baseLine
IL_0556: box System.Single
IL_055b: stelem.ref
IL_055c: dup
IL_055d: ldc.i4.8
IL_055e: ldloc.s V_42
IL_0560: ldfld System.Single TMPro.TMP_CharacterInfo::scale
IL_0565: box System.Single
IL_056a: stelem.ref
IL_056b: dup
IL_056c: ldc.i4.s 9
IL_056e: ldloca.s V_44
IL_0570: call System.Single UnityEngine.TextCore.GlyphMetrics::get_horizontalBearingX()
IL_0575: box System.Single
IL_057a: stelem.ref
IL_057b: dup
IL_057c: ldc.i4.s 10
IL_057e: ldloca.s V_44
IL_0580: call System.Single UnityEngine.TextCore.GlyphMetrics::get_horizontalBearingY()
IL_0585: box System.Single
IL_058a: stelem.ref
IL_058b: dup
IL_058c: ldc.i4.s 11
IL_058e: ldloca.s V_44
IL_0590: call System.Single UnityEngine.TextCore.GlyphMetrics::get_width()
IL_0595: box System.Single
IL_059a: stelem.ref
IL_059b: dup
IL_059c: ldc.i4.s 12
IL_059e: ldloca.s V_44
IL_05a0: call System.Single UnityEngine.TextCore.GlyphMetrics::get_height()
IL_05a5: box System.Single
IL_05aa: stelem.ref
IL_05ab: dup
IL_05ac: ldc.i4.s 13
IL_05ae: ldloca.s V_44
IL_05b0: call System.Single UnityEngine.TextCore.GlyphMetrics::get_horizontalAdvance()
IL_05b5: box System.Single
IL_05ba: stelem.ref
IL_05bb: dup
IL_05bc: ldc.i4.s 14
IL_05be: ldloc.s V_42
IL_05c0: ldfld UnityEngine.Vector3 TMPro.TMP_CharacterInfo::topLeft
IL_05c5: ldfld System.Single UnityEngine.Vector3::x
IL_05ca: box System.Single
IL_05cf: stelem.ref
IL_05d0: dup
IL_05d1: ldc.i4.s 15
IL_05d3: ldloc.s V_42
IL_05d5: ldfld UnityEngine.Vector3 TMPro.TMP_CharacterInfo::topLeft
IL_05da: ldfld System.Single UnityEngine.Vector3::y
IL_05df: box System.Single
IL_05e4: stelem.ref
IL_05e5: dup
IL_05e6: ldc.i4.s 16
IL_05e8: ldloc.s V_42
IL_05ea: ldfld UnityEngine.Vector3 TMPro.TMP_CharacterInfo::bottomRight
IL_05ef: ldfld System.Single UnityEngine.Vector3::x
IL_05f4: box System.Single
IL_05f9: stelem.ref
IL_05fa: dup
IL_05fb: ldc.i4.s 17
IL_05fd: ldloc.s V_42
IL_05ff: ldfld UnityEngine.Vector3 TMPro.TMP_CharacterInfo::bottomRight
IL_0604: ldfld System.Single UnityEngine.Vector3::y
IL_0609: box System.Single
IL_060e: stelem.ref
IL_060f: dup
IL_0610: ldc.i4.s 18
IL_0612: ldloc.s V_45
IL_0614: ldfld System.Single UnityEngine.Vector3::x
IL_0619: box System.Single
IL_061e: stelem.ref
IL_061f: dup
IL_0620: ldc.i4.s 19
IL_0622: ldloc.s V_45
IL_0624: ldfld System.Single UnityEngine.Vector3::y
IL_0629: box System.Single
IL_062e: stelem.ref
IL_062f: call System.String System.String::Format(System.IFormatProvider,System.String,System.Object[])
IL_0634: call System.String System.String::Concat(System.String,System.String,System.String)
IL_0639: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_063e: nop
IL_063f: nop
IL_0640: ldloc.s V_41
IL_0642: ldc.i4.1
IL_0643: add
IL_0644: stloc.s V_41
IL_0646: ldloc.s V_41
IL_0648: ldloc.s V_40
IL_064a: ldfld System.Int32 TMPro.TMP_TextInfo::characterCount
IL_064f: clt
IL_0651: stloc.s V_48
IL_0653: ldloc.s V_48
IL_0655: brtrue IL_0425
IL_065a: nop
IL_065b: ldloc.0
IL_065c: newobj System.Void ForestProbe/TextRow::.ctor()
IL_0661: dup
IL_0662: ldloc.s V_32
IL_0664: callvirt UnityEngine.Transform TMPro.TMP_Text::get_transform()
IL_0669: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_066e: stfld System.String ForestProbe/TextRow::path
IL_0673: dup
IL_0674: ldloc.s V_32
IL_0676: callvirt System.String TMPro.TMP_Text::get_text()
IL_067b: stfld System.String ForestProbe/TextRow::text
IL_0680: dup
IL_0681: ldloc.s V_32
IL_0683: callvirt TMPro.TMP_FontAsset TMPro.TMP_Text::get_font()
IL_0688: ldnull
IL_0689: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_068e: brtrue.s IL_069e
IL_0690: ldloc.s V_32
IL_0692: callvirt TMPro.TMP_FontAsset TMPro.TMP_Text::get_font()
IL_0697: callvirt System.String UnityEngine.Object::get_name()
IL_069c: br.s IL_06a3
IL_069e: ldstr ""
IL_06a3: stfld System.String ForestProbe/TextRow::font
IL_06a8: dup
IL_06a9: ldloc.s V_32
IL_06ab: callvirt System.Single TMPro.TMP_Text::get_fontSize()
IL_06b0: stfld System.Single ForestProbe/TextRow::size
IL_06b5: dup
IL_06b6: ldloc.s V_32
IL_06b8: callvirt System.Boolean TMPro.TMP_Text::get_isTextOverflowing()
IL_06bd: stfld System.Boolean ForestProbe/TextRow::overflow
IL_06c2: callvirt System.Void System.Collections.Generic.List`1<ForestProbe/TextRow>::Add(!0)
IL_06c7: nop
IL_06c8: ldloc.s V_5
IL_06ca: ldc.i4.s 9
IL_06cc: newarr System.String
IL_06d1: dup
IL_06d2: ldc.i4.0
IL_06d3: ldloc.s V_32
IL_06d5: callvirt UnityEngine.Transform TMPro.TMP_Text::get_transform()
IL_06da: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_06df: stelem.ref
IL_06e0: dup
IL_06e1: ldc.i4.1
IL_06e2: ldstr " | "
IL_06e7: stelem.ref
IL_06e8: dup
IL_06e9: ldc.i4.2
IL_06ea: ldloc.s V_32
IL_06ec: callvirt System.Type System.Object::GetType()
IL_06f1: callvirt System.String System.Type::get_FullName()
IL_06f6: stelem.ref
IL_06f7: dup
IL_06f8: ldc.i4.3
IL_06f9: ldstr " | "
IL_06fe: stelem.ref
IL_06ff: dup
IL_0700: ldc.i4.4
IL_0701: ldloc.s V_32
IL_0703: callvirt System.String TMPro.TMP_Text::get_text()
IL_0708: stelem.ref
IL_0709: dup
IL_070a: ldc.i4.5
IL_070b: ldstr " | font="
IL_0710: stelem.ref
IL_0711: dup
IL_0712: ldc.i4.6
IL_0713: ldloc.s V_32
IL_0715: callvirt TMPro.TMP_FontAsset TMPro.TMP_Text::get_font()
IL_071a: ldnull
IL_071b: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0720: brtrue.s IL_0730
IL_0722: ldloc.s V_32
IL_0724: callvirt TMPro.TMP_FontAsset TMPro.TMP_Text::get_font()
IL_0729: callvirt System.String UnityEngine.Object::get_name()
IL_072e: br.s IL_0735
IL_0730: ldstr "null"
IL_0735: stelem.ref
IL_0736: dup
IL_0737: ldc.i4.7
IL_0738: ldstr " | overflow="
IL_073d: stelem.ref
IL_073e: dup
IL_073f: ldc.i4.8
IL_0740: ldloc.s V_32
IL_0742: callvirt System.Boolean TMPro.TMP_Text::get_isTextOverflowing()
IL_0747: stloc.s V_29
IL_0749: ldloca.s V_29
IL_074b: call System.String System.Boolean::ToString()
IL_0750: stelem.ref
IL_0751: call System.String System.String::Concat(System.String[])
IL_0756: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_075b: nop
IL_075c: nop
IL_075d: ldloc.s V_31
IL_075f: ldc.i4.1
IL_0760: add
IL_0761: stloc.s V_31
IL_0763: ldloc.s V_31
IL_0765: ldloc.s V_30
IL_0767: ldlen
IL_0768: conv.i4
IL_0769: blt IL_0260
IL_076e: nop
IL_076f: call !!0[] UnityEngine.Resources::FindObjectsOfTypeAll<UnityEngine.UI.Text>()
IL_0774: stloc.s V_49
IL_0776: ldc.i4.0
IL_0777: stloc.s V_50
IL_0779: br IL_0907
IL_077e: ldloc.s V_49
IL_0780: ldloc.s V_50
IL_0782: ldelem.ref
IL_0783: stloc.s V_51
IL_0785: ldloc.s V_51
IL_0787: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_078c: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_0791: stloc.s V_52
IL_0793: ldloc.s V_52
IL_0795: brfalse IL_0901
IL_079a: ldloc.s V_5
IL_079c: ldc.i4.s 15
IL_079e: newarr System.String
IL_07a3: dup
IL_07a4: ldc.i4.0
IL_07a5: ldloc.s V_51
IL_07a7: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_07ac: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_07b1: stelem.ref
IL_07b2: dup
IL_07b3: ldc.i4.1
IL_07b4: ldstr " | UnityEngine.UI.Text | "
IL_07b9: stelem.ref
IL_07ba: dup
IL_07bb: ldc.i4.2
IL_07bc: ldloc.s V_51
IL_07be: callvirt System.String UnityEngine.UI.Text::get_text()
IL_07c3: stelem.ref
IL_07c4: dup
IL_07c5: ldc.i4.3
IL_07c6: ldstr " | font="
IL_07cb: stelem.ref
IL_07cc: dup
IL_07cd: ldc.i4.4
IL_07ce: ldloc.s V_51
IL_07d0: callvirt UnityEngine.Font UnityEngine.UI.Text::get_font()
IL_07d5: ldnull
IL_07d6: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_07db: brtrue.s IL_07eb
IL_07dd: ldloc.s V_51
IL_07df: callvirt UnityEngine.Font UnityEngine.UI.Text::get_font()
IL_07e4: callvirt System.String UnityEngine.Object::get_name()
IL_07e9: br.s IL_07f0
IL_07eb: ldstr "null"
IL_07f0: stelem.ref
IL_07f1: dup
IL_07f2: ldc.i4.5
IL_07f3: ldstr " | size="
IL_07f8: stelem.ref
IL_07f9: dup
IL_07fa: ldc.i4.6
IL_07fb: ldloc.s V_51
IL_07fd: callvirt System.Int32 UnityEngine.UI.Text::get_fontSize()
IL_0802: stloc.s V_53
IL_0804: ldloca.s V_53
IL_0806: call System.String System.Int32::ToString()
IL_080b: stelem.ref
IL_080c: dup
IL_080d: ldc.i4.7
IL_080e: ldstr " | style="
IL_0813: stelem.ref
IL_0814: dup
IL_0815: ldc.i4.8
IL_0816: ldloc.s V_51
IL_0818: callvirt UnityEngine.FontStyle UnityEngine.UI.Text::get_fontStyle()
IL_081d: stloc.s V_54
IL_081f: ldloca.s V_54
IL_0821: constrained. UnityEngine.FontStyle
IL_0827: callvirt System.String System.Object::ToString()
IL_082c: stelem.ref
IL_082d: dup
IL_082e: ldc.i4.s 9
IL_0830: ldstr " | fontNames="
IL_0835: stelem.ref
IL_0836: dup
IL_0837: ldc.i4.s 10
IL_0839: ldloc.s V_51
IL_083b: callvirt UnityEngine.Font UnityEngine.UI.Text::get_font()
IL_0840: ldnull
IL_0841: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0846: brtrue.s IL_0860
IL_0848: ldstr ","
IL_084d: ldloc.s V_51
IL_084f: callvirt UnityEngine.Font UnityEngine.UI.Text::get_font()
IL_0854: callvirt System.String[] UnityEngine.Font::get_fontNames()
IL_0859: call System.String System.String::Join(System.String,System.String[])
IL_085e: br.s IL_0865
IL_0860: ldstr "null"
IL_0865: stelem.ref
IL_0866: dup
IL_0867: ldc.i4.s 11
IL_0869: ldstr " | dynamic="
IL_086e: stelem.ref
IL_086f: dup
IL_0870: ldc.i4.s 12
IL_0872: ldloc.s V_51
IL_0874: callvirt UnityEngine.Font UnityEngine.UI.Text::get_font()
IL_0879: ldnull
IL_087a: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_087f: brfalse.s IL_088f
IL_0881: ldloc.s V_51
IL_0883: callvirt UnityEngine.Font UnityEngine.UI.Text::get_font()
IL_0888: callvirt System.Boolean UnityEngine.Font::get_dynamic()
IL_088d: br.s IL_0890
IL_088f: ldc.i4.0
IL_0890: stloc.s V_29
IL_0892: ldloca.s V_29
IL_0894: call System.String System.Boolean::ToString()
IL_0899: stelem.ref
IL_089a: dup
IL_089b: ldc.i4.s 13
IL_089d: ldstr " | hasCyrillicAndDigits="
IL_08a2: stelem.ref
IL_08a3: dup
IL_08a4: ldc.i4.s 14
IL_08a6: ldloc.s V_51
IL_08a8: callvirt UnityEngine.Font UnityEngine.UI.Text::get_font()
IL_08ad: ldnull
IL_08ae: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_08b3: brfalse.s IL_08eb
IL_08b5: ldloc.s V_51
IL_08b7: callvirt UnityEngine.Font UnityEngine.UI.Text::get_font()
IL_08bc: ldc.i4 1025
IL_08c1: callvirt System.Boolean UnityEngine.Font::HasCharacter(System.Char)
IL_08c6: brfalse.s IL_08eb
IL_08c8: ldloc.s V_51
IL_08ca: callvirt UnityEngine.Font UnityEngine.UI.Text::get_font()
IL_08cf: ldc.i4 1049
IL_08d4: callvirt System.Boolean UnityEngine.Font::HasCharacter(System.Char)
IL_08d9: brfalse.s IL_08eb
IL_08db: ldloc.s V_51
IL_08dd: callvirt UnityEngine.Font UnityEngine.UI.Text::get_font()
IL_08e2: ldc.i4.s 49
IL_08e4: callvirt System.Boolean UnityEngine.Font::HasCharacter(System.Char)
IL_08e9: br.s IL_08ec
IL_08eb: ldc.i4.0
IL_08ec: stloc.s V_29
IL_08ee: ldloca.s V_29
IL_08f0: call System.String System.Boolean::ToString()
IL_08f5: stelem.ref
IL_08f6: call System.String System.String::Concat(System.String[])
IL_08fb: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0900: nop
IL_0901: ldloc.s V_50
IL_0903: ldc.i4.1
IL_0904: add
IL_0905: stloc.s V_50
IL_0907: ldloc.s V_50
IL_0909: ldloc.s V_49
IL_090b: ldlen
IL_090c: conv.i4
IL_090d: blt IL_077e
IL_0912: nop
IL_0913: call !!0[] UnityEngine.Resources::FindObjectsOfTypeAll<UnityEngine.UI.Button>()
IL_0918: stloc.s V_55
IL_091a: ldc.i4.0
IL_091b: stloc.s V_56
IL_091d: br.s IL_0974
IL_091f: ldloc.s V_55
IL_0921: ldloc.s V_56
IL_0923: ldelem.ref
IL_0924: stloc.s V_57
IL_0926: ldloc.s V_57
IL_0928: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_092d: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_0932: brfalse.s IL_0954
IL_0934: ldloc.s V_57
IL_0936: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_093b: callvirt UnityEngine.SceneManagement.Scene UnityEngine.GameObject::get_scene()
IL_0940: stloc.s V_27
IL_0942: ldloca.s V_27
IL_0944: call System.Boolean UnityEngine.SceneManagement.Scene::IsValid()
IL_0949: brfalse.s IL_0954
IL_094b: ldloc.s V_57
IL_094d: callvirt System.Boolean UnityEngine.UI.Selectable::get_interactable()
IL_0952: br.s IL_0955
IL_0954: ldc.i4.0
IL_0955: stloc.s V_58
IL_0957: ldloc.s V_58
IL_0959: brfalse.s IL_096e
IL_095b: ldloc.1
IL_095c: ldloc.s V_57
IL_095e: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0963: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_0968: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_096d: nop
IL_096e: ldloc.s V_56
IL_0970: ldc.i4.1
IL_0971: add
IL_0972: stloc.s V_56
IL_0974: ldloc.s V_56
IL_0976: ldloc.s V_55
IL_0978: ldlen
IL_0979: conv.i4
IL_097a: blt.s IL_091f
IL_097c: nop
IL_097d: call !!0[] UnityEngine.Resources::FindObjectsOfTypeAll<UnityEngine.MonoBehaviour>()
IL_0982: stloc.s V_59
IL_0984: ldc.i4.0
IL_0985: stloc.s V_60
IL_0987: br IL_0a10
IL_098c: ldloc.s V_59
IL_098e: ldloc.s V_60
IL_0990: ldelem.ref
IL_0991: stloc.s V_61
IL_0993: ldloc.s V_61
IL_0995: ldnull
IL_0996: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_099b: brfalse.s IL_09da
IL_099d: ldloc.s V_61
IL_099f: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_09a4: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_09a9: brfalse.s IL_09da
IL_09ab: ldloc.s V_61
IL_09ad: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_09b2: callvirt UnityEngine.SceneManagement.Scene UnityEngine.GameObject::get_scene()
IL_09b7: stloc.s V_27
IL_09b9: ldloca.s V_27
IL_09bb: call System.Boolean UnityEngine.SceneManagement.Scene::IsValid()
IL_09c0: brfalse.s IL_09da
IL_09c2: ldloc.s V_61
IL_09c4: callvirt System.Type System.Object::GetType()
IL_09c9: callvirt System.String System.Type::get_Namespace()
IL_09ce: ldstr "TheForestOfLove"
IL_09d3: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_09d8: br.s IL_09db
IL_09da: ldc.i4.0
IL_09db: stloc.s V_62
IL_09dd: ldloc.s V_62
IL_09df: brfalse.s IL_0a0a
IL_09e1: ldloc.2
IL_09e2: ldloc.s V_61
IL_09e4: callvirt System.Type System.Object::GetType()
IL_09e9: callvirt System.String System.Reflection.MemberInfo::get_Name()
IL_09ee: ldstr " "
IL_09f3: ldloc.s V_61
IL_09f5: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_09fa: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_09ff: call System.String System.String::Concat(System.String,System.String,System.String)
IL_0a04: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0a09: nop
IL_0a0a: ldloc.s V_60
IL_0a0c: ldc.i4.1
IL_0a0d: add
IL_0a0e: stloc.s V_60
IL_0a10: ldloc.s V_60
IL_0a12: ldloc.s V_59
IL_0a14: ldlen
IL_0a15: conv.i4
IL_0a16: blt IL_098c
IL_0a1b: nop
IL_0a1c: call !!0[] UnityEngine.Resources::FindObjectsOfTypeAll<UnityEngine.UI.Image>()
IL_0a21: stloc.s V_63
IL_0a23: ldc.i4.0
IL_0a24: stloc.s V_64
IL_0a26: br IL_0c26
IL_0a2b: ldloc.s V_63
IL_0a2d: ldloc.s V_64
IL_0a2f: ldelem.ref
IL_0a30: stloc.s V_65
IL_0a32: ldloc.s V_65
IL_0a34: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0a39: callvirt UnityEngine.SceneManagement.Scene UnityEngine.GameObject::get_scene()
IL_0a3e: stloc.s V_27
IL_0a40: ldloca.s V_27
IL_0a42: call System.Boolean UnityEngine.SceneManagement.Scene::IsValid()
IL_0a47: brfalse.s IL_0a61
IL_0a49: ldloc.s V_65
IL_0a4b: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0a50: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_0a55: ldstr "Canvas/OptionsMenu/"
IL_0a5a: callvirt System.Boolean System.String::StartsWith(System.String)
IL_0a5f: br.s IL_0a62
IL_0a61: ldc.i4.0
IL_0a62: stloc.s V_66
IL_0a64: ldloc.s V_66
IL_0a66: brfalse IL_0c20
IL_0a6b: nop
IL_0a6c: ldc.i4.4
IL_0a6d: newarr UnityEngine.Vector3
IL_0a72: stloc.s V_67
IL_0a74: ldloc.s V_65
IL_0a76: callvirt UnityEngine.RectTransform UnityEngine.UI.Graphic::get_rectTransform()
IL_0a7b: ldloc.s V_67
IL_0a7d: callvirt System.Void UnityEngine.RectTransform::GetWorldCorners(UnityEngine.Vector3[])
IL_0a82: nop
IL_0a83: ldloc.s V_9
IL_0a85: ldc.i4.s 23
IL_0a87: newarr System.String
IL_0a8c: dup
IL_0a8d: ldc.i4.0
IL_0a8e: ldloc.s V_65
IL_0a90: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0a95: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_0a9a: stelem.ref
IL_0a9b: dup
IL_0a9c: ldc.i4.1
IL_0a9d: ldstr " | activeSelf="
IL_0aa2: stelem.ref
IL_0aa3: dup
IL_0aa4: ldc.i4.2
IL_0aa5: ldloc.s V_65
IL_0aa7: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0aac: callvirt System.Boolean UnityEngine.GameObject::get_activeSelf()
IL_0ab1: stloc.s V_29
IL_0ab3: ldloca.s V_29
IL_0ab5: call System.String System.Boolean::ToString()
IL_0aba: stelem.ref
IL_0abb: dup
IL_0abc: ldc.i4.3
IL_0abd: ldstr " | activeInHierarchy="
IL_0ac2: stelem.ref
IL_0ac3: dup
IL_0ac4: ldc.i4.4
IL_0ac5: ldloc.s V_65
IL_0ac7: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0acc: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_0ad1: stloc.s V_29
IL_0ad3: ldloca.s V_29
IL_0ad5: call System.String System.Boolean::ToString()
IL_0ada: stelem.ref
IL_0adb: dup
IL_0adc: ldc.i4.5
IL_0add: ldstr " | sprite="
IL_0ae2: stelem.ref
IL_0ae3: dup
IL_0ae4: ldc.i4.6
IL_0ae5: ldloc.s V_65
IL_0ae7: callvirt UnityEngine.Sprite UnityEngine.UI.Image::get_sprite()
IL_0aec: ldnull
IL_0aed: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0af2: brtrue.s IL_0b02
IL_0af4: ldloc.s V_65
IL_0af6: callvirt UnityEngine.Sprite UnityEngine.UI.Image::get_sprite()
IL_0afb: callvirt System.String UnityEngine.Object::get_name()
IL_0b00: br.s IL_0b07
IL_0b02: ldstr "null"
IL_0b07: stelem.ref
IL_0b08: dup
IL_0b09: ldc.i4.7
IL_0b0a: ldstr " | enabled="
IL_0b0f: stelem.ref
IL_0b10: dup
IL_0b11: ldc.i4.8
IL_0b12: ldloc.s V_65
IL_0b14: callvirt System.Boolean UnityEngine.Behaviour::get_enabled()
IL_0b19: stloc.s V_29
IL_0b1b: ldloca.s V_29
IL_0b1d: call System.String System.Boolean::ToString()
IL_0b22: stelem.ref
IL_0b23: dup
IL_0b24: ldc.i4.s 9
IL_0b26: ldstr " | instance="
IL_0b2b: stelem.ref
IL_0b2c: dup
IL_0b2d: ldc.i4.s 10
IL_0b2f: ldloc.s V_65
IL_0b31: callvirt System.Int32 UnityEngine.Object::GetInstanceID()
IL_0b36: stloc.s V_53
IL_0b38: ldloca.s V_53
IL_0b3a: call System.String System.Int32::ToString()
IL_0b3f: stelem.ref
IL_0b40: dup
IL_0b41: ldc.i4.s 11
IL_0b43: ldstr " | color="
IL_0b48: stelem.ref
IL_0b49: dup
IL_0b4a: ldc.i4.s 12
IL_0b4c: ldloc.s V_65
IL_0b4e: callvirt UnityEngine.Color UnityEngine.UI.Graphic::get_color()
IL_0b53: stloc.s V_68
IL_0b55: ldloca.s V_68
IL_0b57: constrained. UnityEngine.Color
IL_0b5d: callvirt System.String System.Object::ToString()
IL_0b62: stelem.ref
IL_0b63: dup
IL_0b64: ldc.i4.s 13
IL_0b66: ldstr " | canvasAlpha="
IL_0b6b: stelem.ref
IL_0b6c: dup
IL_0b6d: ldc.i4.s 14
IL_0b6f: ldloc.s V_65
IL_0b71: callvirt UnityEngine.CanvasRenderer UnityEngine.UI.Graphic::get_canvasRenderer()
IL_0b76: callvirt System.Single UnityEngine.CanvasRenderer::GetAlpha()
IL_0b7b: stloc.s V_28
IL_0b7d: ldloca.s V_28
IL_0b7f: call System.String System.Single::ToString()
IL_0b84: stelem.ref
IL_0b85: dup
IL_0b86: ldc.i4.s 15
IL_0b88: ldstr " | culled="
IL_0b8d: stelem.ref
IL_0b8e: dup
IL_0b8f: ldc.i4.s 16
IL_0b91: ldloc.s V_65
IL_0b93: callvirt UnityEngine.CanvasRenderer UnityEngine.UI.Graphic::get_canvasRenderer()
IL_0b98: callvirt System.Boolean UnityEngine.CanvasRenderer::get_cull()
IL_0b9d: stloc.s V_29
IL_0b9f: ldloca.s V_29
IL_0ba1: call System.String System.Boolean::ToString()
IL_0ba6: stelem.ref
IL_0ba7: dup
IL_0ba8: ldc.i4.s 17
IL_0baa: ldstr " | material="
IL_0baf: stelem.ref
IL_0bb0: dup
IL_0bb1: ldc.i4.s 18
IL_0bb3: ldloc.s V_65
IL_0bb5: callvirt UnityEngine.Material UnityEngine.UI.Graphic::get_materialForRendering()
IL_0bba: ldnull
IL_0bbb: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0bc0: brtrue.s IL_0bd0
IL_0bc2: ldloc.s V_65
IL_0bc4: callvirt UnityEngine.Material UnityEngine.UI.Graphic::get_materialForRendering()
IL_0bc9: callvirt System.String UnityEngine.Object::get_name()
IL_0bce: br.s IL_0bd5
IL_0bd0: ldstr "null"
IL_0bd5: stelem.ref
IL_0bd6: dup
IL_0bd7: ldc.i4.s 19
IL_0bd9: ldstr " | worldBottomLeft="
IL_0bde: stelem.ref
IL_0bdf: dup
IL_0be0: ldc.i4.s 20
IL_0be2: ldloc.s V_67
IL_0be4: ldc.i4.0
IL_0be5: ldelema UnityEngine.Vector3
IL_0bea: ldstr "R"
IL_0bef: call System.String UnityEngine.Vector3::ToString(System.String)
IL_0bf4: stelem.ref
IL_0bf5: dup
IL_0bf6: ldc.i4.s 21
IL_0bf8: ldstr " | worldTopRight="
IL_0bfd: stelem.ref
IL_0bfe: dup
IL_0bff: ldc.i4.s 22
IL_0c01: ldloc.s V_67
IL_0c03: ldc.i4.2
IL_0c04: ldelema UnityEngine.Vector3
IL_0c09: ldstr "R"
IL_0c0e: call System.String UnityEngine.Vector3::ToString(System.String)
IL_0c13: stelem.ref
IL_0c14: call System.String System.String::Concat(System.String[])
IL_0c19: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0c1e: nop
IL_0c1f: nop
IL_0c20: ldloc.s V_64
IL_0c22: ldc.i4.1
IL_0c23: add
IL_0c24: stloc.s V_64
IL_0c26: ldloc.s V_64
IL_0c28: ldloc.s V_63
IL_0c2a: ldlen
IL_0c2b: conv.i4
IL_0c2c: blt IL_0a2b
IL_0c31: newobj System.Void ForestProbe/State::.ctor()
IL_0c36: dup
IL_0c37: call UnityEngine.SceneManagement.Scene UnityEngine.SceneManagement.SceneManager::GetActiveScene()
IL_0c3c: stloc.s V_27
IL_0c3e: ldloca.s V_27
IL_0c40: call System.String UnityEngine.SceneManagement.Scene::get_name()
IL_0c45: stfld System.String ForestProbe/State::scene
IL_0c4a: dup
IL_0c4b: call System.String TheForestOfLove.Narrative.DialogueService::get_CurrentDialogueDbName()
IL_0c50: stfld System.String ForestProbe/State::narrativeDbName
IL_0c55: dup
IL_0c56: call System.String TheForestOfLove.Narrative.DialogueService::get_CurrentArcName()
IL_0c5b: stfld System.String ForestProbe/State::narrativeArcName
IL_0c60: dup
IL_0c61: call System.String UnityEngine.Application::get_dataPath()
IL_0c66: stfld System.String ForestProbe/State::dataPath
IL_0c6b: dup
IL_0c6c: call System.String UnityEngine.Application::get_persistentDataPath()
IL_0c71: stfld System.String ForestProbe/State::persistentDataPath
IL_0c76: dup
IL_0c77: call System.String UnityEngine.Application::get_companyName()
IL_0c7c: stfld System.String ForestProbe/State::company
IL_0c81: dup
IL_0c82: call System.String UnityEngine.Application::get_productName()
IL_0c87: stfld System.String ForestProbe/State::product
IL_0c8c: dup
IL_0c8d: call System.Int32 UnityEngine.Screen::get_width()
IL_0c92: stfld System.Int32 ForestProbe/State::width
IL_0c97: dup
IL_0c98: call System.Int32 UnityEngine.Screen::get_height()
IL_0c9d: stfld System.Int32 ForestProbe/State::height
IL_0ca2: dup
IL_0ca3: ldloc.0
IL_0ca4: callvirt !0[] System.Collections.Generic.List`1<ForestProbe/TextRow>::ToArray()
IL_0ca9: stfld ForestProbe/TextRow[] ForestProbe/State::texts
IL_0cae: dup
IL_0caf: ldloc.1
IL_0cb0: callvirt !0[] System.Collections.Generic.List`1<System.String>::ToArray()
IL_0cb5: stfld System.String[] ForestProbe/State::buttons
IL_0cba: dup
IL_0cbb: ldloc.2
IL_0cbc: callvirt !0[] System.Collections.Generic.List`1<System.String>::ToArray()
IL_0cc1: stfld System.String[] ForestProbe/State::components
IL_0cc6: dup
IL_0cc7: ldloc.s V_4
IL_0cc9: ldlen
IL_0cca: conv.i4
IL_0ccb: stfld System.Int32 ForestProbe/State::tmpObjectCount
IL_0cd0: dup
IL_0cd1: ldloc.s V_5
IL_0cd3: callvirt !0[] System.Collections.Generic.List`1<System.String>::ToArray()
IL_0cd8: stfld System.String[] ForestProbe/State::rendererDiagnostics
IL_0cdd: dup
IL_0cde: ldloc.s V_6
IL_0ce0: callvirt !0[] System.Collections.Generic.List`1<System.String>::ToArray()
IL_0ce5: stfld System.String[] ForestProbe/State::subtitleGlyphDiagnostics
IL_0cea: dup
IL_0ceb: ldloc.s V_7
IL_0ced: callvirt !0[] System.Collections.Generic.List`1<System.String>::ToArray()
IL_0cf2: stfld System.String[] ForestProbe/State::settingsGlyphDiagnostics
IL_0cf7: dup
IL_0cf8: ldloc.s V_8
IL_0cfa: callvirt !0[] System.Collections.Generic.List`1<System.String>::ToArray()
IL_0cff: stfld System.String[] ForestProbe/State::settingsLayoutDiagnostics
IL_0d04: dup
IL_0d05: ldloc.s V_9
IL_0d07: callvirt !0[] System.Collections.Generic.List`1<System.String>::ToArray()
IL_0d0c: stfld System.String[] ForestProbe/State::settingsControlDiagnostics
IL_0d11: dup
IL_0d12: call System.Boolean TheForestOfLove.UI.WindowController::get_IsFullscreen()
IL_0d17: stfld System.Boolean ForestProbe/State::fullscreen
IL_0d1c: dup
IL_0d1d: call System.Boolean TheForestOfLove.UI.WindowController::get_EnableFullscreenStretch()
IL_0d22: stfld System.Boolean ForestProbe/State::stretch
IL_0d27: dup
IL_0d28: call System.Int32 TheForestOfLove.UI.WindowController::get_WindowScalingIndex()
IL_0d2d: stfld System.Int32 ForestProbe/State::scaleIndex
IL_0d32: dup
IL_0d33: call UnityEngine.Resolution UnityEngine.Screen::get_currentResolution()
IL_0d38: stloc.s V_69
IL_0d3a: ldloca.s V_69
IL_0d3c: call System.Int32 UnityEngine.Resolution::get_width()
IL_0d41: stfld System.Int32 ForestProbe/State::displayWidth
IL_0d46: dup
IL_0d47: call UnityEngine.Resolution UnityEngine.Screen::get_currentResolution()
IL_0d4c: stloc.s V_69
IL_0d4e: ldloca.s V_69
IL_0d50: call System.Int32 UnityEngine.Resolution::get_height()
IL_0d55: stfld System.Int32 ForestProbe/State::displayHeight
IL_0d5a: dup
IL_0d5b: call System.Boolean TheForestOfLove.UI.WindowController::CanScaleUp()
IL_0d60: stfld System.Boolean ForestProbe/State::canScaleUp
IL_0d65: dup
IL_0d66: call System.Boolean TheForestOfLove.UI.WindowController::CanScaleDown()
IL_0d6b: stfld System.Boolean ForestProbe/State::canScaleDown
IL_0d70: dup
IL_0d71: call UnityEngine.EventSystems.EventSystem UnityEngine.EventSystems.EventSystem::get_current()
IL_0d76: ldnull
IL_0d77: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0d7c: brtrue.s IL_0da6
IL_0d7e: call UnityEngine.EventSystems.EventSystem UnityEngine.EventSystems.EventSystem::get_current()
IL_0d83: callvirt UnityEngine.GameObject UnityEngine.EventSystems.EventSystem::get_currentSelectedGameObject()
IL_0d88: ldnull
IL_0d89: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0d8e: brtrue.s IL_0da6
IL_0d90: call UnityEngine.EventSystems.EventSystem UnityEngine.EventSystems.EventSystem::get_current()
IL_0d95: callvirt UnityEngine.GameObject UnityEngine.EventSystems.EventSystem::get_currentSelectedGameObject()
IL_0d9a: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_0d9f: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_0da4: br.s IL_0dab
IL_0da6: ldstr ""
IL_0dab: stfld System.String ForestProbe/State::selectedControl
IL_0db0: dup
IL_0db1: ldloc.s V_10
IL_0db3: callvirt !0[] System.Collections.Generic.List`1<System.String>::ToArray()
IL_0db8: stfld System.String[] ForestProbe/State::scaleEligibility
IL_0dbd: dup
IL_0dbe: ldloc.s V_11
IL_0dc0: callvirt !0[] System.Collections.Generic.List`1<System.String>::ToArray()
IL_0dc5: stfld System.String[] ForestProbe/State::scaleControlState
IL_0dca: dup
IL_0dcb: ldloc.3
IL_0dcc: callvirt System.Int32 System.Collections.Generic.List`1<ForestProbe/ResponseRow>::get_Count()
IL_0dd1: stfld System.Int32 ForestProbe/State::responseCount
IL_0dd6: dup
IL_0dd7: ldloc.3
IL_0dd8: ldsfld System.Converter`2<ForestProbe/ResponseRow,System.String> ForestProbe/<>c::<>9__48_0
IL_0ddd: dup
IL_0dde: brtrue.s IL_0df7
IL_0de0: pop
IL_0de1: ldsfld ForestProbe/<>c ForestProbe/<>c::<>9
IL_0de6: ldftn System.String ForestProbe/<>c::<Dump>b__48_0(ForestProbe/ResponseRow)
IL_0dec: newobj System.Void System.Converter`2<ForestProbe/ResponseRow,System.String>::.ctor(System.Object,System.IntPtr)
IL_0df1: dup
IL_0df2: stsfld System.Converter`2<ForestProbe/ResponseRow,System.String> ForestProbe/<>c::<>9__48_0
IL_0df7: callvirt System.Collections.Generic.List`1<!!0> System.Collections.Generic.List`1<ForestProbe/ResponseRow>::ConvertAll<System.String>(System.Converter`2<!0,!!0>)
IL_0dfc: callvirt !0[] System.Collections.Generic.List`1<System.String>::ToArray()
IL_0e01: stfld System.String[] ForestProbe/State::responseRecords
IL_0e06: dup
IL_0e07: call System.Boolean TheForestOfLove.CustomTypewriterEffectTextMeshPro::IsTyping()
IL_0e0c: stfld System.Boolean ForestProbe/State::typing
IL_0e11: stloc.s V_13
IL_0e13: call !!0 UnityEngine.Object::FindObjectOfType<TheForestOfLove.CustomTypewriterEffectTextMeshPro>()
IL_0e18: stloc.s V_14
IL_0e1a: ldloc.s V_13
IL_0e1c: ldloc.s V_14
IL_0e1e: ldnull
IL_0e1f: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0e24: brtrue.s IL_0e2f
IL_0e26: ldloc.s V_14
IL_0e28: callvirt System.String TheForestOfLove.CustomTypewriterEffectTextMeshPro::get_CurrentVisibleText()
IL_0e2d: br.s IL_0e34
IL_0e2f: ldstr ""
IL_0e34: stfld System.String ForestProbe/State::visibleTypewriterText
IL_0e39: ldarg.0
IL_0e3a: ldloc.s V_13
IL_0e3c: call System.Void ForestProbe::ReadConversation(ForestProbe/State)
IL_0e41: nop
IL_0e42: ldarg.0
IL_0e43: ldfld System.String ForestProbe::root
IL_0e48: ldstr "state.json"
IL_0e4d: call System.String System.IO.Path::Combine(System.String,System.String)
IL_0e52: ldloc.s V_13
IL_0e54: ldc.i4.1
IL_0e55: call System.String UnityEngine.JsonUtility::ToJson(System.Object,System.Boolean)
IL_0e5a: call System.Void System.IO.File::WriteAllText(System.String,System.String)
IL_0e5f: nop
IL_0e60: ret
METHOD System.Void ForestProbe::DumpSaveContinuation() | attributes=Private, HideBySig | impl=IL
IL_0000: nop
IL_0001: call TheForestOfLove.Services.Persistence.PlayerRespawnData TheForestOfLove.Services.Persistence.DataService::GetPlayerRespawnData()
IL_0006: stloc.0
IL_0007: call TheForestOfLove.Services.Persistence.GeneralData TheForestOfLove.Services.Persistence.DataService::GetGeneralData()
IL_000c: stloc.1
IL_000d: ldloc.0
IL_000e: brfalse.s IL_0016
IL_0010: ldloc.1
IL_0011: ldnull
IL_0012: ceq
IL_0014: br.s IL_0017
IL_0016: ldc.i4.1
IL_0017: stloc.s V_6
IL_0019: ldloc.s V_6
IL_001b: brfalse.s IL_0028
IL_001d: ldstr "Original save manifest not ready"
IL_0022: newobj System.Void System.Exception::.ctor(System.String)
IL_0027: throw
IL_0028: ldsfld TheForestOfLove.Player TheForestOfLove.Player::current
IL_002d: stloc.2
IL_002e: ldstr "NewGame_Intro"
IL_0033: call TheForestOfLove.Narrative.Dialogue TheForestOfLove.Services.Persistence.DataService::GetDialogueByDbName(System.String)
IL_0038: stloc.3
IL_0039: ldloc.3
IL_003a: ldnull
IL_003b: ceq
IL_003d: stloc.s V_7
IL_003f: ldloc.s V_7
IL_0041: brfalse.s IL_004e
IL_0043: ldstr "Missing original intro record"
IL_0048: newobj System.Void System.Exception::.ctor(System.String)
IL_004d: throw
IL_004e: ldc.i4.0
IL_004f: stloc.s V_4
IL_0051: nop
IL_0052: call !!0[] UnityEngine.Resources::FindObjectsOfTypeAll<TheForestOfLove.TutorialQuestBunnyIntroduction>()
IL_0057: stloc.s V_8
IL_0059: ldc.i4.0
IL_005a: stloc.s V_9
IL_005c: br.s IL_009d
IL_005e: ldloc.s V_8
IL_0060: ldloc.s V_9
IL_0062: ldelem.ref
IL_0063: stloc.s V_10
IL_0065: ldloc.s V_10
IL_0067: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_006c: callvirt UnityEngine.SceneManagement.Scene UnityEngine.GameObject::get_scene()
IL_0071: stloc.s V_12
IL_0073: ldloca.s V_12
IL_0075: call System.Boolean UnityEngine.SceneManagement.Scene::IsValid()
IL_007a: brfalse.s IL_008a
IL_007c: ldloc.s V_10
IL_007e: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0083: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_0088: br.s IL_008b
IL_008a: ldc.i4.0
IL_008b: stloc.s V_11
IL_008d: ldloc.s V_11
IL_008f: brfalse.s IL_0097
IL_0091: ldloc.s V_4
IL_0093: ldc.i4.1
IL_0094: add
IL_0095: stloc.s V_4
IL_0097: ldloc.s V_9
IL_0099: ldc.i4.1
IL_009a: add
IL_009b: stloc.s V_9
IL_009d: ldloc.s V_9
IL_009f: ldloc.s V_8
IL_00a1: ldlen
IL_00a2: conv.i4
IL_00a3: blt.s IL_005e
IL_00a5: newobj System.Void ForestProbe/SaveContinuationState::.ctor()
IL_00aa: dup
IL_00ab: call UnityEngine.SceneManagement.Scene UnityEngine.SceneManagement.SceneManager::GetActiveScene()
IL_00b0: stloc.s V_12
IL_00b2: ldloca.s V_12
IL_00b4: call System.String UnityEngine.SceneManagement.Scene::get_name()
IL_00b9: stfld System.String ForestProbe/SaveContinuationState::scene
IL_00be: dup
IL_00bf: call System.String UnityEngine.Application::get_companyName()
IL_00c4: stfld System.String ForestProbe/SaveContinuationState::company
IL_00c9: dup
IL_00ca: call System.String UnityEngine.Application::get_productName()
IL_00cf: stfld System.String ForestProbe/SaveContinuationState::product
IL_00d4: dup
IL_00d5: call System.String UnityEngine.Application::get_dataPath()
IL_00da: stfld System.String ForestProbe/SaveContinuationState::dataPath
IL_00df: dup
IL_00e0: call System.String UnityEngine.Application::get_persistentDataPath()
IL_00e5: stfld System.String ForestProbe/SaveContinuationState::persistentDataPath
IL_00ea: dup
IL_00eb: call System.Int32 UnityEngine.Time::get_frameCount()
IL_00f0: stfld System.Int32 ForestProbe/SaveContinuationState::frame
IL_00f5: dup
IL_00f6: call System.Single UnityEngine.Time::get_realtimeSinceStartup()
IL_00fb: stfld System.Single ForestProbe/SaveContinuationState::realtime
IL_0100: dup
IL_0101: call System.Boolean TheForestOfLove.Services.Persistence.SaveManager::get_HasSavedPlaySession()
IL_0106: stfld System.Boolean ForestProbe/SaveContinuationState::hasSavedPlaySession
IL_010b: dup
IL_010c: ldsfld System.Boolean Globals::isChapterSelect
IL_0111: stfld System.Boolean ForestProbe/SaveContinuationState::isChapterSelect
IL_0116: dup
IL_0117: ldsfld System.Boolean Globals::isCheatCode
IL_011c: stfld System.Boolean ForestProbe/SaveContinuationState::isCheatCode
IL_0121: dup
IL_0122: ldsfld System.Boolean Globals::isFinishingSoftReset
IL_0127: stfld System.Boolean ForestProbe/SaveContinuationState::isFinishingSoftReset
IL_012c: dup
IL_012d: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inGameplayScene()
IL_0132: stfld System.Boolean ForestProbe/SaveContinuationState::gameplay
IL_0137: dup
IL_0138: call System.Boolean TheForestOfLove.Events.GameStateManager::get_isAnyEventActive()
IL_013d: stfld System.Boolean ForestProbe/SaveContinuationState::anyEvent
IL_0142: dup
IL_0143: call System.Boolean PixelCrushers.DialogueSystem.DialogueManager::get_IsConversationActive()
IL_0148: stfld System.Boolean ForestProbe/SaveContinuationState::conversation
IL_014d: dup
IL_014e: ldloc.0
IL_014f: ldfld System.String TheForestOfLove.Services.Persistence.PlayerRespawnData::currentAreaUnitySceneName
IL_0154: stfld System.String ForestProbe/SaveContinuationState::currentArea
IL_0159: dup
IL_015a: ldloc.0
IL_015b: ldfld System.String TheForestOfLove.Services.Persistence.PlayerRespawnData::lastAreaUnitySceneName
IL_0160: stfld System.String ForestProbe/SaveContinuationState::lastArea
IL_0165: dup
IL_0166: ldloc.0
IL_0167: ldfld UnityEngine.Vector3 TheForestOfLove.Services.Persistence.PlayerRespawnData::lastPosition
IL_016c: stfld UnityEngine.Vector3 ForestProbe/SaveContinuationState::lastPosition
IL_0171: dup
IL_0172: ldloc.0
IL_0173: ldfld UnityEngine.Vector3 TheForestOfLove.Services.Persistence.PlayerRespawnData::lastSpawnPosition
IL_0178: stfld UnityEngine.Vector3 ForestProbe/SaveContinuationState::lastSpawnPosition
IL_017d: dup
IL_017e: ldloc.0
IL_017f: ldfld System.Boolean TheForestOfLove.Services.Persistence.PlayerRespawnData::lastPositionExact
IL_0184: stfld System.Boolean ForestProbe/SaveContinuationState::lastPositionExact
IL_0189: dup
IL_018a: ldloc.0
IL_018b: ldfld System.Boolean TheForestOfLove.Services.Persistence.PlayerRespawnData::isSwimming
IL_0190: stfld System.Boolean ForestProbe/SaveContinuationState::isSwimming
IL_0195: dup
IL_0196: ldloc.0
IL_0197: ldfld System.Boolean TheForestOfLove.Services.Persistence.PlayerRespawnData::isFastTraveling
IL_019c: stfld System.Boolean ForestProbe/SaveContinuationState::isFastTraveling
IL_01a1: dup
IL_01a2: ldloc.0
IL_01a3: ldfld System.String TheForestOfLove.Services.Persistence.PlayerRespawnData::cameraSettingsObjectName
IL_01a8: stfld System.String ForestProbe/SaveContinuationState::cameraSettingsObjectName
IL_01ad: dup
IL_01ae: ldloc.1
IL_01af: ldfld System.Single TheForestOfLove.Services.Persistence.GeneralData::storyClock
IL_01b4: stfld System.Single ForestProbe/SaveContinuationState::storyClock
IL_01b9: dup
IL_01ba: ldloc.1
IL_01bb: ldfld System.Boolean TheForestOfLove.Services.Persistence.GeneralData::finishedControlTutorial
IL_01c0: stfld System.Boolean ForestProbe/SaveContinuationState::finishedControlTutorial
IL_01c5: dup
IL_01c6: ldloc.1
IL_01c7: ldfld System.Boolean TheForestOfLove.Services.Persistence.GeneralData::finishedDialogueTutorial
IL_01cc: stfld System.Boolean ForestProbe/SaveContinuationState::finishedDialogueTutorial
IL_01d1: dup
IL_01d2: ldloc.1
IL_01d3: ldfld System.Boolean TheForestOfLove.Services.Persistence.GeneralData::finishedGossipTutorial
IL_01d8: stfld System.Boolean ForestProbe/SaveContinuationState::finishedGossipTutorial
IL_01dd: dup
IL_01de: ldloc.2
IL_01df: ldnull
IL_01e0: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_01e5: brfalse.s IL_01f4
IL_01e7: ldloc.2
IL_01e8: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_01ed: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_01f2: br.s IL_01f5
IL_01f4: ldc.i4.0
IL_01f5: stfld System.Boolean ForestProbe/SaveContinuationState::playerPresent
IL_01fa: dup
IL_01fb: ldloc.2
IL_01fc: ldnull
IL_01fd: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0202: brtrue.s IL_0211
IL_0204: ldloc.2
IL_0205: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_020a: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_020f: br.s IL_0212
IL_0211: ldnull
IL_0212: stfld System.String ForestProbe/SaveContinuationState::playerPath
IL_0217: dup
IL_0218: ldloc.2
IL_0219: ldnull
IL_021a: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_021f: brtrue.s IL_0229
IL_0221: ldloc.2
IL_0222: callvirt System.Int32 UnityEngine.Object::GetInstanceID()
IL_0227: br.s IL_022a
IL_0229: ldc.i4.0
IL_022a: stfld System.Int32 ForestProbe/SaveContinuationState::playerInstance
IL_022f: dup
IL_0230: ldloc.2
IL_0231: ldnull
IL_0232: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0237: brtrue.s IL_0246
IL_0239: ldloc.2
IL_023a: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_023f: callvirt UnityEngine.Vector3 UnityEngine.Transform::get_position()
IL_0244: br.s IL_024b
IL_0246: call UnityEngine.Vector3 UnityEngine.Vector3::get_zero()
IL_024b: stfld UnityEngine.Vector3 ForestProbe/SaveContinuationState::playerPosition
IL_0250: dup
IL_0251: ldloc.3
IL_0252: callvirt TheForestOfLove.Narrative.DialogueStatus TheForestOfLove.Narrative.Dialogue::get_status()
IL_0257: stfld System.Int32 ForestProbe/SaveContinuationState::introStatus
IL_025c: dup
IL_025d: ldloc.s V_4
IL_025f: stfld System.Int32 ForestProbe/SaveContinuationState::tutorialIntroControllers
IL_0264: dup
IL_0265: ldarg.0
IL_0266: call System.String[] ForestProbe::TutorialRouteDiagnostics()
IL_026b: stfld System.String[] ForestProbe/SaveContinuationState::diagnostics
IL_0270: stloc.s V_5
IL_0272: ldarg.0
IL_0273: ldfld System.String ForestProbe::root
IL_0278: ldstr "save-continuation.json"
IL_027d: call System.String System.IO.Path::Combine(System.String,System.String)
IL_0282: ldloc.s V_5
IL_0284: ldc.i4.1
IL_0285: call System.String UnityEngine.JsonUtility::ToJson(System.Object,System.Boolean)
IL_028a: call System.Void System.IO.File::WriteAllText(System.String,System.String)
IL_028f: nop
IL_0290: ret
METHOD System.Void ForestProbe::.ctor() | attributes=Public, HideBySig, SpecialName, RTSpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: newobj System.Void System.Collections.Generic.List`1<System.String>::.ctor()
IL_0006: stfld System.Collections.Generic.List`1<System.String> ForestProbe::focusRecords
IL_000b: ldarg.0
IL_000c: newobj System.Void System.Collections.Generic.List`1<System.String>::.ctor()
IL_0011: stfld System.Collections.Generic.List`1<System.String> ForestProbe::keyboardSamples
IL_0016: ldarg.0
IL_0017: call System.Void UnityEngine.MonoBehaviour::.ctor()
IL_001c: nop
IL_001d: ret
