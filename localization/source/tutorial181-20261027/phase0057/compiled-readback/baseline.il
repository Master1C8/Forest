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
IL_0012: br IL_105c
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
IL_0046: br IL_105c
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
IL_0081: br IL_0fae
IL_0086: ldloc.1
IL_0087: ldstr "dump"
IL_008c: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0091: stloc.s V_5
IL_0093: ldloc.s V_5
IL_0095: brfalse.s IL_00a3
IL_0097: ldarg.0
IL_0098: call System.Void ForestProbe::Dump()
IL_009d: nop
IL_009e: br IL_0fae
IL_00a3: ldloc.1
IL_00a4: ldstr "dump-save-continuation"
IL_00a9: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_00ae: stloc.s V_6
IL_00b0: ldloc.s V_6
IL_00b2: brfalse.s IL_00c0
IL_00b4: ldarg.0
IL_00b5: call System.Void ForestProbe::DumpSaveContinuation()
IL_00ba: nop
IL_00bb: br IL_0fae
IL_00c0: ldloc.1
IL_00c1: ldstr "dump-intro"
IL_00c6: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_00cb: stloc.s V_7
IL_00cd: ldloc.s V_7
IL_00cf: brfalse.s IL_00dd
IL_00d1: ldarg.0
IL_00d2: call System.Void ForestProbe::DumpIntro()
IL_00d7: nop
IL_00d8: br IL_0fae
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
IL_0161: br IL_0fae
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
IL_01ea: br IL_0fae
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
IL_0273: br IL_0fae
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
IL_02f0: br IL_0fae
IL_02f5: ldloc.1
IL_02f6: ldstr "restore-input-policy"
IL_02fb: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0300: stloc.s V_18
IL_0302: ldloc.s V_18
IL_0304: brfalse.s IL_0312
IL_0306: ldarg.0
IL_0307: call System.Void ForestProbe::RestoreInputPolicy()
IL_030c: nop
IL_030d: br IL_0fae
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
IL_034f: br IL_0fae
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
IL_03a9: br IL_0fae
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
IL_03fc: br IL_0fae
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
IL_0421: br IL_0fae
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
IL_0475: br IL_0fae
IL_047a: ldloc.1
IL_047b: ldstr "complete-tutorial158"
IL_0480: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0485: stloc.s V_29
IL_0487: ldloc.s V_29
IL_0489: brfalse IL_052c
IL_048e: nop
IL_048f: ldarg.0
IL_0490: ldfld System.Boolean ForestProbe::tutorial158Completed
IL_0495: stloc.s V_32
IL_0497: ldloc.s V_32
IL_0499: brfalse.s IL_04a6
IL_049b: ldstr "Tutorial158 completion already acknowledged; no replay"
IL_04a0: newobj System.Void System.Exception::.ctor(System.String)
IL_04a5: throw
IL_04a6: ldarg.0
IL_04a7: ldloca.s V_30
IL_04a9: call ForestProbe/TutorialCompletion ForestProbe::ReadTutorialCompletion(UnityEngine.UI.Button&)
IL_04ae: stloc.s V_31
IL_04b0: ldloc.s V_31
IL_04b2: ldfld System.Boolean ForestProbe/TutorialCompletion::typing
IL_04b7: stloc.s V_33
IL_04b9: ldloc.s V_33
IL_04bb: brfalse.s IL_04c8
IL_04bd: ldstr "Tutorial158 still typing; no completion"
IL_04c2: newobj System.Void System.Exception::.ctor(System.String)
IL_04c7: throw
IL_04c8: ldloc.s V_31
IL_04ca: ldloc.s V_31
IL_04cc: ldfld System.Boolean ForestProbe/TutorialCompletion::menuPresent
IL_04d1: brtrue.s IL_04da
IL_04d3: ldstr "applied"
IL_04d8: br.s IL_04df
IL_04da: ldstr "menu-present"
IL_04df: stfld System.String ForestProbe/TutorialCompletion::result
IL_04e4: ldloc.s V_31
IL_04e6: ldfld System.Boolean ForestProbe/TutorialCompletion::menuPresent
IL_04eb: ldc.i4.0
IL_04ec: ceq
IL_04ee: stloc.s V_34
IL_04f0: ldloc.s V_34
IL_04f2: brfalse.s IL_0501
IL_04f4: ldloc.s V_30
IL_04f6: callvirt UnityEngine.UI.Button/ButtonClickedEvent UnityEngine.UI.Button::get_onClick()
IL_04fb: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_0500: nop
IL_0501: ldarg.0
IL_0502: ldc.i4.1
IL_0503: stfld System.Boolean ForestProbe::tutorial158Completed
IL_0508: ldarg.0
IL_0509: ldfld System.String ForestProbe::root
IL_050e: ldstr "completion158-receipt.json"
IL_0513: call System.String System.IO.Path::Combine(System.String,System.String)
IL_0518: ldloc.s V_31
IL_051a: ldc.i4.1
IL_051b: call System.String UnityEngine.JsonUtility::ToJson(System.Object,System.Boolean)
IL_0520: call System.Void System.IO.File::WriteAllText(System.String,System.String)
IL_0525: nop
IL_0526: nop
IL_0527: br IL_0fae
IL_052c: ldloc.1
IL_052d: ldstr "select-tutorial181 "
IL_0532: callvirt System.Boolean System.String::StartsWith(System.String)
IL_0537: stloc.s V_35
IL_0539: ldloc.s V_35
IL_053b: brfalse IL_0631
IL_0540: nop
IL_0541: ldarg.0
IL_0542: ldfld System.Boolean ForestProbe::tutorial181Selected
IL_0547: stloc.s V_41
IL_0549: ldloc.s V_41
IL_054b: brfalse.s IL_0558
IL_054d: ldstr "Tutorial181 already selected; no replay"
IL_0552: newobj System.Void System.Exception::.ctor(System.String)
IL_0557: throw
IL_0558: ldloc.1
IL_0559: ldc.i4.s 19
IL_055b: callvirt System.String System.String::Substring(System.Int32)
IL_0560: ldc.i4.1
IL_0561: newarr System.Char
IL_0566: dup
IL_0567: ldc.i4.0
IL_0568: ldc.i4.s 32
IL_056a: stelem.i2
IL_056b: callvirt System.String[] System.String::Split(System.Char[])
IL_0570: stloc.s V_36
IL_0572: ldloc.s V_36
IL_0574: ldlen
IL_0575: conv.i4
IL_0576: ldc.i4.2
IL_0577: ceq
IL_0579: ldc.i4.0
IL_057a: ceq
IL_057c: stloc.s V_42
IL_057e: ldloc.s V_42
IL_0580: brfalse.s IL_058d
IL_0582: ldstr "Expected observed frame and original button identity"
IL_0587: newobj System.Void System.Exception::.ctor(System.String)
IL_058c: throw
IL_058d: ldloc.s V_36
IL_058f: ldc.i4.0
IL_0590: ldelem.ref
IL_0591: call System.Int32 System.Int32::Parse(System.String)
IL_0596: stloc.s V_37
IL_0598: ldloc.s V_36
IL_059a: ldc.i4.1
IL_059b: ldelem.ref
IL_059c: call System.Int32 System.Int32::Parse(System.String)
IL_05a1: stloc.s V_38
IL_05a3: ldarg.0
IL_05a4: ldloca.s V_39
IL_05a6: call ForestProbe/Tutorial181Selection ForestProbe::ReadTutorial181(UnityEngine.UI.Button&)
IL_05ab: stloc.s V_40
IL_05ad: ldloc.s V_37
IL_05af: ldc.i4.0
IL_05b0: ble.s IL_05db
IL_05b2: ldloc.s V_37
IL_05b4: ldloc.s V_40
IL_05b6: ldfld System.Int32 ForestProbe/Tutorial181Selection::frame
IL_05bb: bgt.s IL_05db
IL_05bd: ldloc.s V_40
IL_05bf: ldfld System.Int32 ForestProbe/Tutorial181Selection::frame
IL_05c4: ldloc.s V_37
IL_05c6: sub
IL_05c7: ldc.i4.s 120
IL_05c9: bgt.s IL_05db
IL_05cb: ldloc.s V_40
IL_05cd: ldfld System.Int32 ForestProbe/Tutorial181Selection::buttonInstance
IL_05d2: ldloc.s V_38
IL_05d4: ceq
IL_05d6: ldc.i4.0
IL_05d7: ceq
IL_05d9: br.s IL_05dc
IL_05db: ldc.i4.1
IL_05dc: stloc.s V_43
IL_05de: ldloc.s V_43
IL_05e0: brfalse.s IL_05ed
IL_05e2: ldstr "Stale Tutorial181 menu/control"
IL_05e7: newobj System.Void System.Exception::.ctor(System.String)
IL_05ec: throw
IL_05ed: ldarg.0
IL_05ee: ldc.i4.1
IL_05ef: stfld System.Boolean ForestProbe::tutorial181Selected
IL_05f4: ldloc.s V_40
IL_05f6: ldstr "submitted"
IL_05fb: stfld System.String ForestProbe/Tutorial181Selection::result
IL_0600: ldarg.0
IL_0601: ldfld System.String ForestProbe::root
IL_0606: ldstr "selection181-receipt.json"
IL_060b: call System.String System.IO.Path::Combine(System.String,System.String)
IL_0610: ldloc.s V_40
IL_0612: ldc.i4.1
IL_0613: call System.String UnityEngine.JsonUtility::ToJson(System.Object,System.Boolean)
IL_0618: call System.Void System.IO.File::WriteAllText(System.String,System.String)
IL_061d: nop
IL_061e: ldloc.s V_39
IL_0620: callvirt UnityEngine.UI.Button/ButtonClickedEvent UnityEngine.UI.Button::get_onClick()
IL_0625: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_062a: nop
IL_062b: nop
IL_062c: br IL_0fae
IL_0631: ldloc.1
IL_0632: ldstr "continue-bound "
IL_0637: callvirt System.Boolean System.String::StartsWith(System.String)
IL_063c: stloc.s V_44
IL_063e: ldloc.s V_44
IL_0640: brfalse IL_0790
IL_0645: nop
IL_0646: ldloc.1
IL_0647: ldc.i4.s 15
IL_0649: callvirt System.String System.String::Substring(System.Int32)
IL_064e: ldc.i4.1
IL_064f: newarr System.Char
IL_0654: dup
IL_0655: ldc.i4.0
IL_0656: ldc.i4.s 32
IL_0658: stelem.i2
IL_0659: callvirt System.String[] System.String::Split(System.Char[])
IL_065e: stloc.s V_45
IL_0660: ldloc.s V_45
IL_0662: ldlen
IL_0663: conv.i4
IL_0664: ldc.i4.2
IL_0665: ceq
IL_0667: ldc.i4.0
IL_0668: ceq
IL_066a: stloc.s V_52
IL_066c: ldloc.s V_52
IL_066e: brfalse.s IL_067b
IL_0670: ldstr "Expected conversation and source entry"
IL_0675: newobj System.Void System.Exception::.ctor(System.String)
IL_067a: throw
IL_067b: ldloc.s V_45
IL_067d: ldc.i4.0
IL_067e: ldelem.ref
IL_067f: call System.Int32 System.Int32::Parse(System.String)
IL_0684: stloc.s V_46
IL_0686: ldloc.s V_45
IL_0688: ldc.i4.1
IL_0689: ldelem.ref
IL_068a: call System.Int32 System.Int32::Parse(System.String)
IL_068f: stloc.s V_47
IL_0691: ldloc.s V_46
IL_0693: ldc.i4.s 120
IL_0695: bne.un.s IL_06a2
IL_0697: ldloc.s V_47
IL_0699: ldc.i4 158
IL_069e: ceq
IL_06a0: br.s IL_06a3
IL_06a2: ldc.i4.0
IL_06a3: stloc.s V_53
IL_06a5: ldloc.s V_53
IL_06a7: brfalse.s IL_06b4
IL_06a9: ldstr "Tutorial158 requires guarded completion"
IL_06ae: newobj System.Void System.Exception::.ctor(System.String)
IL_06b3: throw
IL_06b4: call PixelCrushers.DialogueSystem.ConversationState PixelCrushers.DialogueSystem.DialogueManager::get_currentConversationState()
IL_06b9: stloc.s V_48
IL_06bb: ldloc.s V_48
IL_06bd: brfalse.s IL_06d6
IL_06bf: ldloc.s V_48
IL_06c1: ldfld PixelCrushers.DialogueSystem.Subtitle PixelCrushers.DialogueSystem.ConversationState::subtitle
IL_06c6: brfalse.s IL_06d6
IL_06c8: ldloc.s V_48
IL_06ca: ldfld PixelCrushers.DialogueSystem.Subtitle PixelCrushers.DialogueSystem.ConversationState::subtitle
IL_06cf: ldfld PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Subtitle::dialogueEntry
IL_06d4: br.s IL_06d7
IL_06d6: ldnull
IL_06d7: stloc.s V_49
IL_06d9: newobj System.Void ForestProbe/ContinueReceipt::.ctor()
IL_06de: dup
IL_06df: call System.Boolean PixelCrushers.DialogueSystem.DialogueManager::get_isConversationActive()
IL_06e4: stfld System.Boolean ForestProbe/ContinueReceipt::active
IL_06e9: dup
IL_06ea: ldloc.s V_46
IL_06ec: stfld System.Int32 ForestProbe/ContinueReceipt::expectedConversationId
IL_06f1: dup
IL_06f2: ldloc.s V_47
IL_06f4: stfld System.Int32 ForestProbe/ContinueReceipt::expectedEntryId
IL_06f9: dup
IL_06fa: ldloc.s V_49
IL_06fc: brfalse.s IL_0707
IL_06fe: ldloc.s V_49
IL_0700: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::conversationID
IL_0705: br.s IL_0708
IL_0707: ldc.i4.m1
IL_0708: stfld System.Int32 ForestProbe/ContinueReceipt::actualConversationId
IL_070d: dup
IL_070e: ldloc.s V_49
IL_0710: brfalse.s IL_071b
IL_0712: ldloc.s V_49
IL_0714: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_0719: br.s IL_071c
IL_071b: ldc.i4.m1
IL_071c: stfld System.Int32 ForestProbe/ContinueReceipt::actualEntryId
IL_0721: stloc.s V_50
IL_0723: ldloc.s V_50
IL_0725: ldfld System.Boolean ForestProbe/ContinueReceipt::active
IL_072a: brfalse.s IL_0744
IL_072c: ldloc.s V_50
IL_072e: ldfld System.Int32 ForestProbe/ContinueReceipt::actualConversationId
IL_0733: ldloc.s V_46
IL_0735: bne.un.s IL_0744
IL_0737: ldloc.s V_50
IL_0739: ldfld System.Int32 ForestProbe/ContinueReceipt::actualEntryId
IL_073e: ldloc.s V_47
IL_0740: ceq
IL_0742: br.s IL_0745
IL_0744: ldc.i4.0
IL_0745: stloc.s V_51
IL_0747: ldloc.s V_51
IL_0749: stloc.s V_54
IL_074b: ldloc.s V_54
IL_074d: brfalse.s IL_0755
IL_074f: call System.Void TheForestOfLove.CustomTypewriterEffectTextMeshPro::FastForwardTextOrAdvanceDialogue()
IL_0754: nop
IL_0755: ldloc.s V_50
IL_0757: ldloc.s V_51
IL_0759: brtrue.s IL_0762
IL_075b: ldstr "stale"
IL_0760: br.s IL_0767
IL_0762: ldstr "applied"
IL_0767: stfld System.String ForestProbe/ContinueReceipt::result
IL_076c: ldarg.0
IL_076d: ldfld System.String ForestProbe::root
IL_0772: ldstr "continue-receipt.json"
IL_0777: call System.String System.IO.Path::Combine(System.String,System.String)
IL_077c: ldloc.s V_50
IL_077e: ldc.i4.1
IL_077f: call System.String UnityEngine.JsonUtility::ToJson(System.Object,System.Boolean)
IL_0784: call System.Void System.IO.File::WriteAllText(System.String,System.String)
IL_0789: nop
IL_078a: nop
IL_078b: br IL_0fae
IL_0790: ldloc.1
IL_0791: ldstr "continue"
IL_0796: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_079b: stloc.s V_55
IL_079d: ldloc.s V_55
IL_079f: brfalse.s IL_07c7
IL_07a1: nop
IL_07a2: call System.Boolean PixelCrushers.DialogueSystem.DialogueManager::get_isConversationActive()
IL_07a7: ldc.i4.0
IL_07a8: ceq
IL_07aa: stloc.s V_56
IL_07ac: ldloc.s V_56
IL_07ae: brfalse.s IL_07bb
IL_07b0: ldstr "No active conversation"
IL_07b5: newobj System.Void System.Exception::.ctor(System.String)
IL_07ba: throw
IL_07bb: call System.Void TheForestOfLove.CustomTypewriterEffectTextMeshPro::FastForwardTextOrAdvanceDialogue()
IL_07c0: nop
IL_07c1: nop
IL_07c2: br IL_0fae
IL_07c7: ldloc.1
IL_07c8: ldstr "response "
IL_07cd: callvirt System.Boolean System.String::StartsWith(System.String)
IL_07d2: stloc.s V_57
IL_07d4: ldloc.s V_57
IL_07d6: brfalse IL_09ca
IL_07db: nop
IL_07dc: ldloc.1
IL_07dd: ldc.i4.s 9
IL_07df: callvirt System.String System.String::Substring(System.Int32)
IL_07e4: ldc.i4.1
IL_07e5: newarr System.Char
IL_07ea: dup
IL_07eb: ldc.i4.0
IL_07ec: ldc.i4.s 32
IL_07ee: stelem.i2
IL_07ef: callvirt System.String[] System.String::Split(System.Char[])
IL_07f4: stloc.s V_58
IL_07f6: ldloc.s V_58
IL_07f8: ldlen
IL_07f9: conv.i4
IL_07fa: ldc.i4.3
IL_07fb: ceq
IL_07fd: ldc.i4.0
IL_07fe: ceq
IL_0800: stloc.s V_64
IL_0802: ldloc.s V_64
IL_0804: brfalse.s IL_0811
IL_0806: ldstr "Expected source entry, conversation and destination entry"
IL_080b: newobj System.Void System.Exception::.ctor(System.String)
IL_0810: throw
IL_0811: ldloc.s V_58
IL_0813: ldc.i4.0
IL_0814: ldelem.ref
IL_0815: call System.Int32 System.Int32::Parse(System.String)
IL_081a: stloc.s V_59
IL_081c: ldloc.s V_58
IL_081e: ldc.i4.1
IL_081f: ldelem.ref
IL_0820: call System.Int32 System.Int32::Parse(System.String)
IL_0825: stloc.s V_60
IL_0827: ldloc.s V_58
IL_0829: ldc.i4.2
IL_082a: ldelem.ref
IL_082b: call System.Int32 System.Int32::Parse(System.String)
IL_0830: stloc.s V_61
IL_0832: ldloc.s V_60
IL_0834: ldc.i4.s 120
IL_0836: bne.un.s IL_0843
IL_0838: ldloc.s V_59
IL_083a: ldc.i4 158
IL_083f: ceq
IL_0841: br.s IL_0844
IL_0843: ldc.i4.0
IL_0844: stloc.s V_65
IL_0846: ldloc.s V_65
IL_0848: brfalse.s IL_0855
IL_084a: ldstr "Tutorial159/181 choices forbidden"
IL_084f: newobj System.Void System.Exception::.ctor(System.String)
IL_0854: throw
IL_0855: call PixelCrushers.DialogueSystem.ConversationState PixelCrushers.DialogueSystem.DialogueManager::get_currentConversationState()
IL_085a: stloc.s V_62
IL_085c: call System.Boolean PixelCrushers.DialogueSystem.DialogueManager::get_isConversationActive()
IL_0861: brfalse.s IL_08ad
IL_0863: ldloc.s V_62
IL_0865: brfalse.s IL_08ad
IL_0867: ldloc.s V_62
IL_0869: ldfld PixelCrushers.DialogueSystem.Subtitle PixelCrushers.DialogueSystem.ConversationState::subtitle
IL_086e: brfalse.s IL_08ad
IL_0870: ldloc.s V_62
IL_0872: ldfld PixelCrushers.DialogueSystem.Subtitle PixelCrushers.DialogueSystem.ConversationState::subtitle
IL_0877: ldfld PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Subtitle::dialogueEntry
IL_087c: brfalse.s IL_08ad
IL_087e: ldloc.s V_62
IL_0880: ldfld PixelCrushers.DialogueSystem.Subtitle PixelCrushers.DialogueSystem.ConversationState::subtitle
IL_0885: ldfld PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Subtitle::dialogueEntry
IL_088a: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::conversationID
IL_088f: ldloc.s V_60
IL_0891: bne.un.s IL_08ad
IL_0893: ldloc.s V_62
IL_0895: ldfld PixelCrushers.DialogueSystem.Subtitle PixelCrushers.DialogueSystem.ConversationState::subtitle
IL_089a: ldfld PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Subtitle::dialogueEntry
IL_089f: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_08a4: ldloc.s V_59
IL_08a6: ceq
IL_08a8: ldc.i4.0
IL_08a9: ceq
IL_08ab: br.s IL_08ae
IL_08ad: ldc.i4.1
IL_08ae: stloc.s V_66
IL_08b0: ldloc.s V_66
IL_08b2: brfalse.s IL_08bf
IL_08b4: ldstr "Response source changed"
IL_08b9: newobj System.Void System.Exception::.ctor(System.String)
IL_08be: throw
IL_08bf: ldnull
IL_08c0: stloc.s V_63
IL_08c2: nop
IL_08c3: call !!0[] UnityEngine.Resources::FindObjectsOfTypeAll<PixelCrushers.DialogueSystem.StandardUIResponseButton>()
IL_08c8: stloc.s V_67
IL_08ca: ldc.i4.0
IL_08cb: stloc.s V_68
IL_08cd: br.s IL_0939
IL_08cf: ldloc.s V_67
IL_08d1: ldloc.s V_68
IL_08d3: ldelem.ref
IL_08d4: stloc.s V_69
IL_08d6: ldloc.s V_69
IL_08d8: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_08dd: callvirt UnityEngine.SceneManagement.Scene UnityEngine.GameObject::get_scene()
IL_08e2: stloc.s V_10
IL_08e4: ldloca.s V_10
IL_08e6: call System.Boolean UnityEngine.SceneManagement.Scene::IsValid()
IL_08eb: brfalse.s IL_090d
IL_08ed: ldloc.s V_69
IL_08ef: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_08f4: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_08f9: brfalse.s IL_090d
IL_08fb: ldloc.s V_69
IL_08fd: callvirt System.Boolean PixelCrushers.DialogueSystem.StandardUIResponseButton::get_isVisible()
IL_0902: brfalse.s IL_090d
IL_0904: ldloc.s V_69
IL_0906: callvirt System.Boolean PixelCrushers.DialogueSystem.StandardUIResponseButton::get_isClickable()
IL_090b: br.s IL_090e
IL_090d: ldc.i4.0
IL_090e: stloc.s V_70
IL_0910: ldloc.s V_70
IL_0912: brfalse.s IL_0933
IL_0914: nop
IL_0915: ldloc.s V_63
IL_0917: ldnull
IL_0918: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_091d: stloc.s V_71
IL_091f: ldloc.s V_71
IL_0921: brfalse.s IL_092e
IL_0923: ldstr "More than one live response; hold for source review"
IL_0928: newobj System.Void System.Exception::.ctor(System.String)
IL_092d: throw
IL_092e: ldloc.s V_69
IL_0930: stloc.s V_63
IL_0932: nop
IL_0933: ldloc.s V_68
IL_0935: ldc.i4.1
IL_0936: add
IL_0937: stloc.s V_68
IL_0939: ldloc.s V_68
IL_093b: ldloc.s V_67
IL_093d: ldlen
IL_093e: conv.i4
IL_093f: blt.s IL_08cf
IL_0941: ldloc.s V_63
IL_0943: ldnull
IL_0944: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0949: brtrue.s IL_09a0
IL_094b: ldloc.s V_63
IL_094d: callvirt PixelCrushers.DialogueSystem.Response PixelCrushers.DialogueSystem.StandardUIResponseButton::get_response()
IL_0952: brfalse.s IL_09a0
IL_0954: ldloc.s V_63
IL_0956: callvirt PixelCrushers.DialogueSystem.Response PixelCrushers.DialogueSystem.StandardUIResponseButton::get_response()
IL_095b: ldfld PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Response::destinationEntry
IL_0960: brfalse.s IL_09a0
IL_0962: ldloc.s V_63
IL_0964: callvirt UnityEngine.Transform PixelCrushers.DialogueSystem.StandardUIResponseButton::get_target()
IL_0969: ldnull
IL_096a: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_096f: brtrue.s IL_09a0
IL_0971: ldloc.s V_63
IL_0973: callvirt PixelCrushers.DialogueSystem.Response PixelCrushers.DialogueSystem.StandardUIResponseButton::get_response()
IL_0978: ldfld PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Response::destinationEntry
IL_097d: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::conversationID
IL_0982: ldloc.s V_60
IL_0984: bne.un.s IL_09a0
IL_0986: ldloc.s V_63
IL_0988: callvirt PixelCrushers.DialogueSystem.Response PixelCrushers.DialogueSystem.StandardUIResponseButton::get_response()
IL_098d: ldfld PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Response::destinationEntry
IL_0992: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_0997: ldloc.s V_61
IL_0999: ceq
IL_099b: ldc.i4.0
IL_099c: ceq
IL_099e: br.s IL_09a1
IL_09a0: ldc.i4.1
IL_09a1: stloc.s V_72
IL_09a3: ldloc.s V_72
IL_09a5: brfalse.s IL_09b2
IL_09a7: ldstr "Response does not match source-bound successor"
IL_09ac: newobj System.Void System.Exception::.ctor(System.String)
IL_09b1: throw
IL_09b2: ldloc.s V_63
IL_09b4: ldfld UnityEngine.UI.Button PixelCrushers.DialogueSystem.StandardUIResponseButton::button
IL_09b9: callvirt UnityEngine.UI.Button/ButtonClickedEvent UnityEngine.UI.Button::get_onClick()
IL_09be: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_09c3: nop
IL_09c4: nop
IL_09c5: br IL_0fae
IL_09ca: ldloc.1
IL_09cb: ldstr "probe-nameplate"
IL_09d0: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_09d5: stloc.s V_73
IL_09d7: ldloc.s V_73
IL_09d9: brfalse.s IL_0a49
IL_09db: nop
IL_09dc: call System.Boolean PixelCrushers.DialogueSystem.DialogueManager::get_isConversationActive()
IL_09e1: ldc.i4.0
IL_09e2: ceq
IL_09e4: stloc.s V_75
IL_09e6: ldloc.s V_75
IL_09e8: brfalse.s IL_09f5
IL_09ea: ldstr "No active conversation"
IL_09ef: newobj System.Void System.Exception::.ctor(System.String)
IL_09f4: throw
IL_09f5: call !!0 UnityEngine.Object::FindObjectOfType<TheForestOfLove.DialogueNameplateController>()
IL_09fa: stloc.s V_74
IL_09fc: ldloc.s V_74
IL_09fe: ldnull
IL_09ff: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0a04: stloc.s V_76
IL_0a06: ldloc.s V_76
IL_0a08: brfalse.s IL_0a15
IL_0a0a: ldstr "No active nameplate controller"
IL_0a0f: newobj System.Void System.Exception::.ctor(System.String)
IL_0a14: throw
IL_0a15: ldloc.s V_74
IL_0a17: ldstr "Ёж Йй 123"
IL_0a1c: callvirt System.Void TheForestOfLove.DialogueNameplateController::SetCustomNameplateUntilCleared(System.String)
IL_0a21: nop
IL_0a22: ldloc.s V_74
IL_0a24: callvirt System.Type System.Object::GetType()
IL_0a29: ldstr "UpdateNameplate"
IL_0a2e: ldc.i4.s 36
IL_0a30: callvirt System.Reflection.MethodInfo System.Type::GetMethod(System.String,System.Reflection.BindingFlags)
IL_0a35: ldloc.s V_74
IL_0a37: ldc.i4.1
IL_0a38: newarr System.Object
IL_0a3d: callvirt System.Object System.Reflection.MethodBase::Invoke(System.Object,System.Object[])
IL_0a42: pop
IL_0a43: nop
IL_0a44: br IL_0fae
IL_0a49: ldloc.1
IL_0a4a: ldstr "capture "
IL_0a4f: callvirt System.Boolean System.String::StartsWith(System.String)
IL_0a54: stloc.s V_77
IL_0a56: ldloc.s V_77
IL_0a58: brfalse.s IL_0ad3
IL_0a5a: nop
IL_0a5b: ldloc.1
IL_0a5c: ldc.i4.8
IL_0a5d: callvirt System.String System.String::Substring(System.Int32)
IL_0a62: stloc.s V_78
IL_0a64: ldloc.s V_78
IL_0a66: call System.String System.IO.Path::GetFileName(System.String)
IL_0a6b: ldloc.s V_78
IL_0a6d: call System.Boolean System.String::op_Inequality(System.String,System.String)
IL_0a72: brtrue.s IL_0a85
IL_0a74: ldloc.s V_78
IL_0a76: ldstr ".png"
IL_0a7b: callvirt System.Boolean System.String::EndsWith(System.String)
IL_0a80: ldc.i4.0
IL_0a81: ceq
IL_0a83: br.s IL_0a86
IL_0a85: ldc.i4.1
IL_0a86: stloc.s V_80
IL_0a88: ldloc.s V_80
IL_0a8a: brfalse.s IL_0a97
IL_0a8c: ldstr "Invalid capture name"
IL_0a91: newobj System.Void System.Exception::.ctor(System.String)
IL_0a96: throw
IL_0a97: ldarg.0
IL_0a98: ldfld System.String ForestProbe::root
IL_0a9d: ldloc.s V_78
IL_0a9f: call System.String System.IO.Path::Combine(System.String,System.String)
IL_0aa4: stloc.s V_79
IL_0aa6: ldloc.s V_79
IL_0aa8: call System.Boolean System.IO.File::Exists(System.String)
IL_0aad: stloc.s V_81
IL_0aaf: ldloc.s V_81
IL_0ab1: brfalse.s IL_0abe
IL_0ab3: ldstr "Capture already exists"
IL_0ab8: newobj System.Void System.Exception::.ctor(System.String)
IL_0abd: throw
IL_0abe: ldarg.0
IL_0abf: ldarg.0
IL_0ac0: ldloc.s V_79
IL_0ac2: call System.Collections.IEnumerator ForestProbe::Capture(System.String)
IL_0ac7: call UnityEngine.Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)
IL_0acc: pop
IL_0acd: nop
IL_0ace: br IL_0fae
IL_0ad3: ldloc.1
IL_0ad4: ldstr "select "
IL_0ad9: callvirt System.Boolean System.String::StartsWith(System.String)
IL_0ade: stloc.s V_82
IL_0ae0: ldloc.s V_82
IL_0ae2: brfalse IL_0bc7
IL_0ae7: nop
IL_0ae8: ldloc.1
IL_0ae9: ldc.i4.7
IL_0aea: callvirt System.String System.String::Substring(System.Int32)
IL_0aef: stloc.s V_83
IL_0af1: ldnull
IL_0af2: stloc.s V_84
IL_0af4: nop
IL_0af5: call !!0[] UnityEngine.Resources::FindObjectsOfTypeAll<UnityEngine.UI.Selectable>()
IL_0afa: stloc.s V_85
IL_0afc: ldc.i4.0
IL_0afd: stloc.s V_86
IL_0aff: br.s IL_0b77
IL_0b01: ldloc.s V_85
IL_0b03: ldloc.s V_86
IL_0b05: ldelem.ref
IL_0b06: stloc.s V_87
IL_0b08: ldloc.s V_87
IL_0b0a: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0b0f: callvirt UnityEngine.SceneManagement.Scene UnityEngine.GameObject::get_scene()
IL_0b14: stloc.s V_10
IL_0b16: ldloca.s V_10
IL_0b18: call System.Boolean UnityEngine.SceneManagement.Scene::IsValid()
IL_0b1d: brfalse.s IL_0b4b
IL_0b1f: ldloc.s V_87
IL_0b21: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0b26: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_0b2b: brfalse.s IL_0b4b
IL_0b2d: ldloc.s V_87
IL_0b2f: callvirt System.Boolean UnityEngine.UI.Selectable::IsInteractable()
IL_0b34: brfalse.s IL_0b4b
IL_0b36: ldloc.s V_87
IL_0b38: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0b3d: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_0b42: ldloc.s V_83
IL_0b44: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0b49: br.s IL_0b4c
IL_0b4b: ldc.i4.0
IL_0b4c: stloc.s V_88
IL_0b4e: ldloc.s V_88
IL_0b50: brfalse.s IL_0b71
IL_0b52: nop
IL_0b53: ldloc.s V_84
IL_0b55: ldnull
IL_0b56: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0b5b: stloc.s V_89
IL_0b5d: ldloc.s V_89
IL_0b5f: brfalse.s IL_0b6c
IL_0b61: ldstr "Duplicate active selectable"
IL_0b66: newobj System.Void System.Exception::.ctor(System.String)
IL_0b6b: throw
IL_0b6c: ldloc.s V_87
IL_0b6e: stloc.s V_84
IL_0b70: nop
IL_0b71: ldloc.s V_86
IL_0b73: ldc.i4.1
IL_0b74: add
IL_0b75: stloc.s V_86
IL_0b77: ldloc.s V_86
IL_0b79: ldloc.s V_85
IL_0b7b: ldlen
IL_0b7c: conv.i4
IL_0b7d: blt.s IL_0b01
IL_0b7f: ldloc.s V_84
IL_0b81: ldnull
IL_0b82: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0b87: brtrue.s IL_0b96
IL_0b89: call UnityEngine.EventSystems.EventSystem UnityEngine.EventSystems.EventSystem::get_current()
IL_0b8e: ldnull
IL_0b8f: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0b94: br.s IL_0b97
IL_0b96: ldc.i4.1
IL_0b97: stloc.s V_90
IL_0b99: ldloc.s V_90
IL_0b9b: brfalse.s IL_0baf
IL_0b9d: ldstr "No selectable/event system: "
IL_0ba2: ldloc.s V_83
IL_0ba4: call System.String System.String::Concat(System.String,System.String)
IL_0ba9: newobj System.Void System.Exception::.ctor(System.String)
IL_0bae: throw
IL_0baf: call UnityEngine.EventSystems.EventSystem UnityEngine.EventSystems.EventSystem::get_current()
IL_0bb4: ldloc.s V_84
IL_0bb6: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0bbb: callvirt System.Void UnityEngine.EventSystems.EventSystem::SetSelectedGameObject(UnityEngine.GameObject)
IL_0bc0: nop
IL_0bc1: nop
IL_0bc2: br IL_0fae
IL_0bc7: ldloc.1
IL_0bc8: ldstr "move-left"
IL_0bcd: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0bd2: brtrue.s IL_0be1
IL_0bd4: ldloc.1
IL_0bd5: ldstr "move-right"
IL_0bda: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0bdf: br.s IL_0be2
IL_0be1: ldc.i4.1
IL_0be2: stloc.s V_91
IL_0be4: ldloc.s V_91
IL_0be6: brfalse IL_0c6c
IL_0beb: nop
IL_0bec: call UnityEngine.EventSystems.EventSystem UnityEngine.EventSystems.EventSystem::get_current()
IL_0bf1: stloc.s V_92
IL_0bf3: ldloc.s V_92
IL_0bf5: ldnull
IL_0bf6: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0bfb: brtrue.s IL_0c0c
IL_0bfd: ldloc.s V_92
IL_0bff: callvirt UnityEngine.GameObject UnityEngine.EventSystems.EventSystem::get_currentSelectedGameObject()
IL_0c04: ldnull
IL_0c05: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0c0a: br.s IL_0c0d
IL_0c0c: ldc.i4.1
IL_0c0d: stloc.s V_94
IL_0c0f: ldloc.s V_94
IL_0c11: brfalse.s IL_0c1e
IL_0c13: ldstr "No selected control"
IL_0c18: newobj System.Void System.Exception::.ctor(System.String)
IL_0c1d: throw
IL_0c1e: ldloc.s V_92
IL_0c20: newobj System.Void UnityEngine.EventSystems.AxisEventData::.ctor(UnityEngine.EventSystems.EventSystem)
IL_0c25: dup
IL_0c26: ldloc.1
IL_0c27: ldstr "move-left"
IL_0c2c: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0c31: brtrue.s IL_0c36
IL_0c33: ldc.i4.2
IL_0c34: br.s IL_0c37
IL_0c36: ldc.i4.0
IL_0c37: callvirt System.Void UnityEngine.EventSystems.AxisEventData::set_moveDir(UnityEngine.EventSystems.MoveDirection)
IL_0c3c: nop
IL_0c3d: stloc.s V_93
IL_0c3f: ldloc.s V_92
IL_0c41: callvirt UnityEngine.GameObject UnityEngine.EventSystems.EventSystem::get_currentSelectedGameObject()
IL_0c46: ldloc.s V_93
IL_0c48: call UnityEngine.EventSystems.ExecuteEvents/EventFunction`1<UnityEngine.EventSystems.IMoveHandler> UnityEngine.EventSystems.ExecuteEvents::get_moveHandler()
IL_0c4d: call System.Boolean UnityEngine.EventSystems.ExecuteEvents::Execute<UnityEngine.EventSystems.IMoveHandler>(UnityEngine.GameObject,UnityEngine.EventSystems.BaseEventData,UnityEngine.EventSystems.ExecuteEvents/EventFunction`1<!!0>)
IL_0c52: ldc.i4.0
IL_0c53: ceq
IL_0c55: stloc.s V_95
IL_0c57: ldloc.s V_95
IL_0c59: brfalse.s IL_0c66
IL_0c5b: ldstr "No move handler"
IL_0c60: newobj System.Void System.Exception::.ctor(System.String)
IL_0c65: throw
IL_0c66: nop
IL_0c67: br IL_0fae
IL_0c6c: ldloc.1
IL_0c6d: ldstr "click "
IL_0c72: callvirt System.Boolean System.String::StartsWith(System.String)
IL_0c77: stloc.s V_96
IL_0c79: ldloc.s V_96
IL_0c7b: brfalse IL_0d34
IL_0c80: nop
IL_0c81: ldloc.1
IL_0c82: ldc.i4.6
IL_0c83: callvirt System.String System.String::Substring(System.Int32)
IL_0c88: stloc.s V_97
IL_0c8a: ldnull
IL_0c8b: stloc.s V_98
IL_0c8d: nop
IL_0c8e: call !!0[] UnityEngine.Resources::FindObjectsOfTypeAll<UnityEngine.UI.Button>()
IL_0c93: stloc.s V_99
IL_0c95: ldc.i4.0
IL_0c96: stloc.s V_100
IL_0c98: br.s IL_0cf9
IL_0c9a: ldloc.s V_99
IL_0c9c: ldloc.s V_100
IL_0c9e: ldelem.ref
IL_0c9f: stloc.s V_101
IL_0ca1: ldloc.s V_101
IL_0ca3: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0ca8: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_0cad: brfalse.s IL_0ccd
IL_0caf: ldloc.s V_101
IL_0cb1: callvirt System.Boolean UnityEngine.UI.Selectable::get_interactable()
IL_0cb6: brfalse.s IL_0ccd
IL_0cb8: ldloc.s V_101
IL_0cba: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0cbf: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_0cc4: ldloc.s V_97
IL_0cc6: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0ccb: br.s IL_0cce
IL_0ccd: ldc.i4.0
IL_0cce: stloc.s V_102
IL_0cd0: ldloc.s V_102
IL_0cd2: brfalse.s IL_0cf3
IL_0cd4: nop
IL_0cd5: ldloc.s V_98
IL_0cd7: ldnull
IL_0cd8: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0cdd: stloc.s V_103
IL_0cdf: ldloc.s V_103
IL_0ce1: brfalse.s IL_0cee
IL_0ce3: ldstr "Duplicate active button"
IL_0ce8: newobj System.Void System.Exception::.ctor(System.String)
IL_0ced: throw
IL_0cee: ldloc.s V_101
IL_0cf0: stloc.s V_98
IL_0cf2: nop
IL_0cf3: ldloc.s V_100
IL_0cf5: ldc.i4.1
IL_0cf6: add
IL_0cf7: stloc.s V_100
IL_0cf9: ldloc.s V_100
IL_0cfb: ldloc.s V_99
IL_0cfd: ldlen
IL_0cfe: conv.i4
IL_0cff: blt.s IL_0c9a
IL_0d01: ldloc.s V_98
IL_0d03: ldnull
IL_0d04: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0d09: stloc.s V_104
IL_0d0b: ldloc.s V_104
IL_0d0d: brfalse.s IL_0d21
IL_0d0f: ldstr "No matching active button: "
IL_0d14: ldloc.s V_97
IL_0d16: call System.String System.String::Concat(System.String,System.String)
IL_0d1b: newobj System.Void System.Exception::.ctor(System.String)
IL_0d20: throw
IL_0d21: ldloc.s V_98
IL_0d23: callvirt UnityEngine.UI.Button/ButtonClickedEvent UnityEngine.UI.Button::get_onClick()
IL_0d28: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_0d2d: nop
IL_0d2e: nop
IL_0d2f: br IL_0fae
IL_0d34: ldloc.1
IL_0d35: ldstr "menu "
IL_0d3a: callvirt System.Boolean System.String::StartsWith(System.String)
IL_0d3f: stloc.s V_105
IL_0d41: ldloc.s V_105
IL_0d43: brfalse IL_0fa3
IL_0d48: nop
IL_0d49: ldloc.1
IL_0d4a: ldc.i4.5
IL_0d4b: callvirt System.String System.String::Substring(System.Int32)
IL_0d50: ldc.i4.1
IL_0d51: newarr System.Char
IL_0d56: dup
IL_0d57: ldc.i4.0
IL_0d58: ldc.i4.s 32
IL_0d5a: stelem.i2
IL_0d5b: callvirt System.String[] System.String::Split(System.Char[])
IL_0d60: stloc.s V_106
IL_0d62: ldloc.s V_106
IL_0d64: ldlen
IL_0d65: conv.i4
IL_0d66: ldc.i4.2
IL_0d67: bne.un.s IL_0d89
IL_0d69: ldloc.s V_106
IL_0d6b: ldc.i4.0
IL_0d6c: ldelem.ref
IL_0d6d: ldstr "PlayMenu"
IL_0d72: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0d77: brfalse.s IL_0d89
IL_0d79: ldloc.s V_106
IL_0d7b: ldc.i4.1
IL_0d7c: ldelem.ref
IL_0d7d: ldstr "OnClickContinue"
IL_0d82: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0d87: br.s IL_0d8a
IL_0d89: ldc.i4.0
IL_0d8a: stloc.s V_107
IL_0d8c: ldloc.s V_106
IL_0d8e: ldlen
IL_0d8f: conv.i4
IL_0d90: ldc.i4.2
IL_0d91: bne.un.s IL_0dfc
IL_0d93: ldloc.s V_106
IL_0d95: ldc.i4.0
IL_0d96: ldelem.ref
IL_0d97: ldstr "StartScreenMainMenu"
IL_0d9c: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0da1: brtrue.s IL_0dc3
IL_0da3: ldloc.s V_106
IL_0da5: ldc.i4.0
IL_0da6: ldelem.ref
IL_0da7: ldstr "PlayMenu"
IL_0dac: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0db1: brtrue.s IL_0dc3
IL_0db3: ldloc.s V_106
IL_0db5: ldc.i4.0
IL_0db6: ldelem.ref
IL_0db7: ldstr "OptionsMenu"
IL_0dbc: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0dc1: brfalse.s IL_0dfc
IL_0dc3: ldloc.s V_106
IL_0dc5: ldc.i4.1
IL_0dc6: ldelem.ref
IL_0dc7: ldstr "OnClickStart"
IL_0dcc: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0dd1: brtrue.s IL_0df3
IL_0dd3: ldloc.s V_106
IL_0dd5: ldc.i4.1
IL_0dd6: ldelem.ref
IL_0dd7: ldstr "OnClickOptions"
IL_0ddc: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0de1: brtrue.s IL_0df3
IL_0de3: ldloc.s V_106
IL_0de5: ldc.i4.1
IL_0de6: ldelem.ref
IL_0de7: ldstr "OnClickBack"
IL_0dec: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0df1: br.s IL_0df4
IL_0df3: ldc.i4.1
IL_0df4: ldloc.s V_107
IL_0df6: or
IL_0df7: ldc.i4.0
IL_0df8: ceq
IL_0dfa: br.s IL_0dfd
IL_0dfc: ldc.i4.1
IL_0dfd: stloc.s V_109
IL_0dff: ldloc.s V_109
IL_0e01: brfalse.s IL_0e0e
IL_0e03: ldstr "Unsupported menu command"
IL_0e08: newobj System.Void System.Exception::.ctor(System.String)
IL_0e0d: throw
IL_0e0e: ldloc.s V_107
IL_0e10: stloc.s V_110
IL_0e12: ldloc.s V_110
IL_0e14: brfalse IL_0ef4
IL_0e19: nop
IL_0e1a: call System.Boolean TheForestOfLove.Services.Persistence.SaveManager::get_HasSavedPlaySession()
IL_0e1f: brfalse.s IL_0e50
IL_0e21: call UnityEngine.SceneManagement.Scene UnityEngine.SceneManagement.SceneManager::GetActiveScene()
IL_0e26: stloc.s V_10
IL_0e28: ldloca.s V_10
IL_0e2a: call System.String UnityEngine.SceneManagement.Scene::get_name()
IL_0e2f: ldstr "StartMenu"
IL_0e34: call System.Boolean System.String::op_Inequality(System.String,System.String)
IL_0e39: brtrue.s IL_0e50
IL_0e3b: ldsfld System.Boolean Globals::isChapterSelect
IL_0e40: brtrue.s IL_0e50
IL_0e42: ldsfld System.Boolean Globals::isCheatCode
IL_0e47: brtrue.s IL_0e50
IL_0e49: call System.Boolean PixelCrushers.DialogueSystem.DialogueManager::get_isConversationActive()
IL_0e4e: br.s IL_0e51
IL_0e50: ldc.i4.1
IL_0e51: stloc.s V_112
IL_0e53: ldloc.s V_112
IL_0e55: brfalse.s IL_0e62
IL_0e57: ldstr "Original saved Continue state unavailable"
IL_0e5c: newobj System.Void System.Exception::.ctor(System.String)
IL_0e61: throw
IL_0e62: ldc.i4.0
IL_0e63: stloc.s V_111
IL_0e65: nop
IL_0e66: call !!0[] UnityEngine.Resources::FindObjectsOfTypeAll<UnityEngine.UI.Button>()
IL_0e6b: stloc.s V_113
IL_0e6d: ldc.i4.0
IL_0e6e: stloc.s V_114
IL_0e70: br.s IL_0ed2
IL_0e72: ldloc.s V_113
IL_0e74: ldloc.s V_114
IL_0e76: ldelem.ref
IL_0e77: stloc.s V_115
IL_0e79: ldloc.s V_115
IL_0e7b: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0e80: callvirt UnityEngine.SceneManagement.Scene UnityEngine.GameObject::get_scene()
IL_0e85: stloc.s V_10
IL_0e87: ldloca.s V_10
IL_0e89: call System.Boolean UnityEngine.SceneManagement.Scene::IsValid()
IL_0e8e: brfalse.s IL_0ebf
IL_0e90: ldloc.s V_115
IL_0e92: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0e97: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_0e9c: brfalse.s IL_0ebf
IL_0e9e: ldloc.s V_115
IL_0ea0: callvirt System.Boolean UnityEngine.UI.Selectable::get_interactable()
IL_0ea5: brfalse.s IL_0ebf
IL_0ea7: ldloc.s V_115
IL_0ea9: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0eae: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_0eb3: ldstr "Canvas/PlayMenu/Controls/Continue"
IL_0eb8: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0ebd: br.s IL_0ec0
IL_0ebf: ldc.i4.0
IL_0ec0: stloc.s V_116
IL_0ec2: ldloc.s V_116
IL_0ec4: brfalse.s IL_0ecc
IL_0ec6: ldloc.s V_111
IL_0ec8: ldc.i4.1
IL_0ec9: add
IL_0eca: stloc.s V_111
IL_0ecc: ldloc.s V_114
IL_0ece: ldc.i4.1
IL_0ecf: add
IL_0ed0: stloc.s V_114
IL_0ed2: ldloc.s V_114
IL_0ed4: ldloc.s V_113
IL_0ed6: ldlen
IL_0ed7: conv.i4
IL_0ed8: blt.s IL_0e72
IL_0eda: ldloc.s V_111
IL_0edc: ldc.i4.1
IL_0edd: ceq
IL_0edf: ldc.i4.0
IL_0ee0: ceq
IL_0ee2: stloc.s V_117
IL_0ee4: ldloc.s V_117
IL_0ee6: brfalse.s IL_0ef3
IL_0ee8: ldstr "Exact original Continue control unavailable"
IL_0eed: newobj System.Void System.Exception::.ctor(System.String)
IL_0ef2: throw
IL_0ef3: nop
IL_0ef4: ldnull
IL_0ef5: stloc.s V_108
IL_0ef7: nop
IL_0ef8: call !!0[] UnityEngine.Resources::FindObjectsOfTypeAll<UnityEngine.MonoBehaviour>()
IL_0efd: stloc.s V_118
IL_0eff: ldc.i4.0
IL_0f00: stloc.s V_119
IL_0f02: br.s IL_0f66
IL_0f04: ldloc.s V_118
IL_0f06: ldloc.s V_119
IL_0f08: ldelem.ref
IL_0f09: stloc.s V_120
IL_0f0b: ldloc.s V_120
IL_0f0d: ldnull
IL_0f0e: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0f13: brfalse.s IL_0f3a
IL_0f15: ldloc.s V_120
IL_0f17: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0f1c: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_0f21: brfalse.s IL_0f3a
IL_0f23: ldloc.s V_120
IL_0f25: callvirt System.Type System.Object::GetType()
IL_0f2a: callvirt System.String System.Reflection.MemberInfo::get_Name()
IL_0f2f: ldloc.s V_106
IL_0f31: ldc.i4.0
IL_0f32: ldelem.ref
IL_0f33: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0f38: br.s IL_0f3b
IL_0f3a: ldc.i4.0
IL_0f3b: stloc.s V_121
IL_0f3d: ldloc.s V_121
IL_0f3f: brfalse.s IL_0f60
IL_0f41: nop
IL_0f42: ldloc.s V_108
IL_0f44: ldnull
IL_0f45: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0f4a: stloc.s V_122
IL_0f4c: ldloc.s V_122
IL_0f4e: brfalse.s IL_0f5b
IL_0f50: ldstr "Duplicate active menu"
IL_0f55: newobj System.Void System.Exception::.ctor(System.String)
IL_0f5a: throw
IL_0f5b: ldloc.s V_120
IL_0f5d: stloc.s V_108
IL_0f5f: nop
IL_0f60: ldloc.s V_119
IL_0f62: ldc.i4.1
IL_0f63: add
IL_0f64: stloc.s V_119
IL_0f66: ldloc.s V_119
IL_0f68: ldloc.s V_118
IL_0f6a: ldlen
IL_0f6b: conv.i4
IL_0f6c: blt.s IL_0f04
IL_0f6e: ldloc.s V_108
IL_0f70: ldnull
IL_0f71: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0f76: stloc.s V_123
IL_0f78: ldloc.s V_123
IL_0f7a: brfalse.s IL_0f87
IL_0f7c: ldstr "Menu not active"
IL_0f81: newobj System.Void System.Exception::.ctor(System.String)
IL_0f86: throw
IL_0f87: ldloc.s V_108
IL_0f89: callvirt System.Type System.Object::GetType()
IL_0f8e: ldloc.s V_106
IL_0f90: ldc.i4.1
IL_0f91: ldelem.ref
IL_0f92: callvirt System.Reflection.MethodInfo System.Type::GetMethod(System.String)
IL_0f97: ldloc.s V_108
IL_0f99: ldnull
IL_0f9a: callvirt System.Object System.Reflection.MethodBase::Invoke(System.Object,System.Object[])
IL_0f9f: pop
IL_0fa0: nop
IL_0fa1: br.s IL_0fae
IL_0fa3: ldstr "Unsupported command"
IL_0fa8: newobj System.Void System.Exception::.ctor(System.String)
IL_0fad: throw
IL_0fae: ldarg.0
IL_0faf: ldfld System.String ForestProbe::root
IL_0fb4: ldstr "actions.log"
IL_0fb9: call System.String System.IO.Path::Combine(System.String,System.String)
IL_0fbe: call System.DateTime System.DateTime::get_UtcNow()
IL_0fc3: stloc.s V_124
IL_0fc5: ldloca.s V_124
IL_0fc7: ldstr "O"
IL_0fcc: call System.String System.DateTime::ToString(System.String)
IL_0fd1: ldstr " OK "
IL_0fd6: ldloc.1
IL_0fd7: ldstr "
"
IL_0fdc: call System.String System.String::Concat(System.String,System.String,System.String,System.String)
IL_0fe1: call System.Void System.IO.File::AppendAllText(System.String,System.String)
IL_0fe6: nop
IL_0fe7: nop
IL_0fe8: leave.s IL_105c
IL_0fea: stloc.s V_125
IL_0fec: nop
IL_0fed: ldarg.0
IL_0fee: ldfld System.String ForestProbe::root
IL_0ff3: ldstr "actions.log"
IL_0ff8: call System.String System.IO.Path::Combine(System.String,System.String)
IL_0ffd: ldc.i4.6
IL_0ffe: newarr System.String
IL_1003: dup
IL_1004: ldc.i4.0
IL_1005: call System.DateTime System.DateTime::get_UtcNow()
IL_100a: stloc.s V_124
IL_100c: ldloca.s V_124
IL_100e: ldstr "O"
IL_1013: call System.String System.DateTime::ToString(System.String)
IL_1018: stelem.ref
IL_1019: dup
IL_101a: ldc.i4.1
IL_101b: ldstr " FAIL "
IL_1020: stelem.ref
IL_1021: dup
IL_1022: ldc.i4.2
IL_1023: ldloc.1
IL_1024: stelem.ref
IL_1025: dup
IL_1026: ldc.i4.3
IL_1027: ldstr " "
IL_102c: stelem.ref
IL_102d: dup
IL_102e: ldc.i4.4
IL_102f: ldloc.s V_125
IL_1031: dup
IL_1032: brtrue.s IL_1038
IL_1034: pop
IL_1035: ldnull
IL_1036: br.s IL_103d
IL_1038: callvirt System.String System.Object::ToString()
IL_103d: stelem.ref
IL_103e: dup
IL_103f: ldc.i4.5
IL_1040: ldstr "
"
IL_1045: stelem.ref
IL_1046: call System.String System.String::Concat(System.String[])
IL_104b: call System.Void System.IO.File::AppendAllText(System.String,System.String)
IL_1050: nop
IL_1051: ldloc.s V_125
IL_1053: call System.Void UnityEngine.Debug::LogException(System.Exception)
IL_1058: nop
IL_1059: nop
IL_105a: leave.s IL_105c
IL_105c: ret
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
IL_0000: newobj System.Void ForestProbe/<>c__DisplayClass35_0::.ctor()
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
IL_0028: stfld System.Object ForestProbe/<>c__DisplayClass35_0::watchers
IL_002d: ldloc.0
IL_002e: ldftn System.Object ForestProbe/<>c__DisplayClass35_0::<KeyboardEligibility>b__0(System.String)
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
IL_0001: newobj System.Void ForestProbe/<Capture>d__39::.ctor(System.Int32)
IL_0006: dup
IL_0007: ldarg.0
IL_0008: stfld ForestProbe ForestProbe/<Capture>d__39::<>4__this
IL_000d: dup
IL_000e: ldarg.1
IL_000f: stfld System.String ForestProbe/<Capture>d__39::path
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
METHOD System.String ForestProbe::TutorialChoiceText(System.Int32) | attributes=Private, Static, HideBySig | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: ldc.i4 159
IL_0007: beq.s IL_0016
IL_0009: ldarg.0
IL_000a: ldc.i4 181
IL_000f: ceq
IL_0011: ldc.i4.0
IL_0012: ceq
IL_0014: br.s IL_0017
IL_0016: ldc.i4.0
IL_0017: stloc.0
IL_0018: ldloc.0
IL_0019: brfalse.s IL_0026
IL_001b: ldstr "Unapproved Tutorial choice ID"
IL_0020: newobj System.Void System.Exception::.ctor(System.String)
IL_0025: throw
IL_0026: ldarg.0
IL_0027: ldc.i4 159
IL_002c: beq.s IL_0035
IL_002e: ldstr "The love. Definitely the love."
IL_0033: br.s IL_003a
IL_0035: ldstr "Well… uhh… You see…"
IL_003a: stloc.1
IL_003b: br.s IL_003d
IL_003d: ldloc.1
IL_003e: ret
METHOD ForestProbe/TutorialCompletion ForestProbe::ReadTutorialCompletion(UnityEngine.UI.Button&) | attributes=Private, HideBySig | impl=IL
IL_0000: nop
IL_0001: call PixelCrushers.DialogueSystem.ConversationState PixelCrushers.DialogueSystem.DialogueManager::get_currentConversationState()
IL_0006: stloc.0
IL_0007: ldloc.0
IL_0008: brfalse.s IL_0012
IL_000a: ldloc.0
IL_000b: ldfld PixelCrushers.DialogueSystem.Subtitle PixelCrushers.DialogueSystem.ConversationState::subtitle
IL_0010: br.s IL_0013
IL_0012: ldnull
IL_0013: stloc.1
IL_0014: ldloc.1
IL_0015: brfalse.s IL_001f
IL_0017: ldloc.1
IL_0018: ldfld PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Subtitle::dialogueEntry
IL_001d: br.s IL_0020
IL_001f: ldnull
IL_0020: stloc.2
IL_0021: call System.Boolean PixelCrushers.DialogueSystem.DialogueManager::get_isConversationActive()
IL_0026: brfalse IL_0116
IL_002b: ldloc.2
IL_002c: brfalse IL_0116
IL_0031: ldloc.2
IL_0032: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::conversationID
IL_0037: ldc.i4.s 120
IL_0039: bne.un IL_0116
IL_003e: ldloc.2
IL_003f: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_0044: ldc.i4 158
IL_0049: bne.un IL_0116
IL_004e: call System.String TheForestOfLove.Narrative.DialogueService::get_CurrentDialogueDbName()
IL_0053: ldstr "TutorialQuest_IntroFromBunny"
IL_0058: call System.Boolean System.String::op_Inequality(System.String,System.String)
IL_005d: brtrue IL_0116
IL_0062: call System.String TheForestOfLove.Narrative.DialogueService::get_CurrentArcName()
IL_0067: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_006c: brfalse IL_0116
IL_0071: ldloc.1
IL_0072: ldfld PixelCrushers.DialogueSystem.FormattedText PixelCrushers.DialogueSystem.Subtitle::formattedText
IL_0077: brfalse IL_0116
IL_007c: ldloc.1
IL_007d: ldfld PixelCrushers.DialogueSystem.FormattedText PixelCrushers.DialogueSystem.Subtitle::formattedText
IL_0082: callvirt System.String PixelCrushers.DialogueSystem.FormattedText::get_text()
IL_0087: ldstr "So tell me. What is it you’re here for?"
IL_008c: call System.Boolean System.String::op_Inequality(System.String,System.String)
IL_0091: brtrue IL_0116
IL_0096: ldloc.2
IL_0097: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_DialogueText()
IL_009c: ldstr "[pic=3]So tell me. What is it you’re here for?"
IL_00a1: call System.Boolean System.String::op_Inequality(System.String,System.String)
IL_00a6: brtrue.s IL_0116
IL_00a8: ldloc.2
IL_00a9: callvirt System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::get_ActorID()
IL_00ae: ldc.i4.2
IL_00af: bne.un.s IL_0116
IL_00b1: ldloc.2
IL_00b2: callvirt System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::get_ConversantID()
IL_00b7: ldc.i4.1
IL_00b8: bne.un.s IL_0116
IL_00ba: ldloc.2
IL_00bb: ldfld System.String PixelCrushers.DialogueSystem.DialogueEntry::conditionsString
IL_00c0: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_00c5: brfalse.s IL_0116
IL_00c7: ldloc.2
IL_00c8: ldfld System.String PixelCrushers.DialogueSystem.DialogueEntry::userScript
IL_00cd: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_00d2: brfalse.s IL_0116
IL_00d4: ldloc.2
IL_00d5: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_MenuText()
IL_00da: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_00df: brfalse.s IL_0116
IL_00e1: ldloc.2
IL_00e2: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_Sequence()
IL_00e7: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_00ec: brfalse.s IL_0116
IL_00ee: ldloc.2
IL_00ef: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_ResponseMenuSequence()
IL_00f4: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_00f9: brfalse.s IL_0116
IL_00fb: ldloc.2
IL_00fc: ldfld UnityEngine.Events.UnityEvent PixelCrushers.DialogueSystem.DialogueEntry::onExecute
IL_0101: brfalse.s IL_0113
IL_0103: ldloc.2
IL_0104: ldfld UnityEngine.Events.UnityEvent PixelCrushers.DialogueSystem.DialogueEntry::onExecute
IL_0109: callvirt System.Int32 UnityEngine.Events.UnityEventBase::GetPersistentEventCount()
IL_010e: ldc.i4.0
IL_010f: cgt.un
IL_0111: br.s IL_0114
IL_0113: ldc.i4.0
IL_0114: br.s IL_0117
IL_0116: ldc.i4.1
IL_0117: stloc.s V_9
IL_0119: ldloc.s V_9
IL_011b: brfalse.s IL_0128
IL_011d: ldstr "Tutorial158 exact source/binding differs"
IL_0122: newobj System.Void System.Exception::.ctor(System.String)
IL_0127: throw
IL_0128: ldloc.2
IL_0129: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link> PixelCrushers.DialogueSystem.DialogueEntry::outgoingLinks
IL_012e: brfalse.s IL_015e
IL_0130: ldloc.2
IL_0131: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link> PixelCrushers.DialogueSystem.DialogueEntry::outgoingLinks
IL_0136: callvirt System.Int32 System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link>::get_Count()
IL_013b: ldc.i4.2
IL_013c: bne.un.s IL_015e
IL_013e: ldloc.0
IL_013f: callvirt System.Boolean PixelCrushers.DialogueSystem.ConversationState::get_hasNPCResponse()
IL_0144: brtrue.s IL_015e
IL_0146: ldloc.0
IL_0147: ldfld PixelCrushers.DialogueSystem.Response[] PixelCrushers.DialogueSystem.ConversationState::pcResponses
IL_014c: brfalse.s IL_015e
IL_014e: ldloc.0
IL_014f: ldfld PixelCrushers.DialogueSystem.Response[] PixelCrushers.DialogueSystem.ConversationState::pcResponses
IL_0154: ldlen
IL_0155: conv.i4
IL_0156: ldc.i4.2
IL_0157: ceq
IL_0159: ldc.i4.0
IL_015a: ceq
IL_015c: br.s IL_015f
IL_015e: ldc.i4.1
IL_015f: stloc.s V_10
IL_0161: ldloc.s V_10
IL_0163: brfalse.s IL_0170
IL_0165: ldstr "Tutorial158 source/available destinations differ"
IL_016a: newobj System.Void System.Exception::.ctor(System.String)
IL_016f: throw
IL_0170: newobj System.Void System.Collections.Generic.HashSet`1<System.Int32>::.ctor()
IL_0175: stloc.3
IL_0176: nop
IL_0177: ldloc.2
IL_0178: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link> PixelCrushers.DialogueSystem.DialogueEntry::outgoingLinks
IL_017d: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link>::GetEnumerator()
IL_0182: stloc.s V_11
IL_0184: br IL_020b
IL_0189: ldloca.s V_11
IL_018b: call !0 System.Collections.Generic.List`1/Enumerator<PixelCrushers.DialogueSystem.Link>::get_Current()
IL_0190: stloc.s V_12
IL_0192: nop
IL_0193: ldloc.s V_12
IL_0195: ldfld System.Int32 PixelCrushers.DialogueSystem.Link::originConversationID
IL_019a: ldc.i4.s 120
IL_019c: bne.un.s IL_01f8
IL_019e: ldloc.s V_12
IL_01a0: ldfld System.Int32 PixelCrushers.DialogueSystem.Link::originDialogueID
IL_01a5: ldc.i4 158
IL_01aa: bne.un.s IL_01f8
IL_01ac: ldloc.s V_12
IL_01ae: ldfld System.Int32 PixelCrushers.DialogueSystem.Link::destinationConversationID
IL_01b3: ldc.i4.s 120
IL_01b5: bne.un.s IL_01f8
IL_01b7: ldloc.s V_12
IL_01b9: ldfld System.Int32 PixelCrushers.DialogueSystem.Link::destinationDialogueID
IL_01be: ldc.i4 159
IL_01c3: beq.s IL_01d3
IL_01c5: ldloc.s V_12
IL_01c7: ldfld System.Int32 PixelCrushers.DialogueSystem.Link::destinationDialogueID
IL_01cc: ldc.i4 181
IL_01d1: bne.un.s IL_01f8
IL_01d3: ldloc.s V_12
IL_01d5: ldfld System.Boolean PixelCrushers.DialogueSystem.Link::isConnector
IL_01da: brtrue.s IL_01f8
IL_01dc: ldloc.s V_12
IL_01de: ldfld PixelCrushers.DialogueSystem.ConditionPriority PixelCrushers.DialogueSystem.Link::priority
IL_01e3: ldc.i4.2
IL_01e4: bne.un.s IL_01f8
IL_01e6: ldloc.3
IL_01e7: ldloc.s V_12
IL_01e9: ldfld System.Int32 PixelCrushers.DialogueSystem.Link::destinationDialogueID
IL_01ee: callvirt System.Boolean System.Collections.Generic.HashSet`1<System.Int32>::Add(!0)
IL_01f3: ldc.i4.0
IL_01f4: ceq
IL_01f6: br.s IL_01f9
IL_01f8: ldc.i4.1
IL_01f9: stloc.s V_13
IL_01fb: ldloc.s V_13
IL_01fd: brfalse.s IL_020a
IL_01ff: ldstr "Tutorial158 source links differ"
IL_0204: newobj System.Void System.Exception::.ctor(System.String)
IL_0209: throw
IL_020a: nop
IL_020b: ldloca.s V_11
IL_020d: call System.Boolean System.Collections.Generic.List`1/Enumerator<PixelCrushers.DialogueSystem.Link>::MoveNext()
IL_0212: brtrue IL_0189
IL_0217: leave.s IL_0228
IL_0219: ldloca.s V_11
IL_021b: constrained. System.Collections.Generic.List`1/Enumerator<PixelCrushers.DialogueSystem.Link>
IL_0221: callvirt System.Void System.IDisposable::Dispose()
IL_0226: nop
IL_0227: endfinally
IL_0228: ldloc.3
IL_0229: callvirt System.Void System.Collections.Generic.HashSet`1<System.Int32>::Clear()
IL_022e: nop
IL_022f: nop
IL_0230: ldloc.0
IL_0231: ldfld PixelCrushers.DialogueSystem.Response[] PixelCrushers.DialogueSystem.ConversationState::pcResponses
IL_0236: stloc.s V_14
IL_0238: ldc.i4.0
IL_0239: stloc.s V_15
IL_023b: br IL_038e
IL_0240: ldloc.s V_14
IL_0242: ldloc.s V_15
IL_0244: ldelem.ref
IL_0245: stloc.s V_16
IL_0247: nop
IL_0248: ldloc.s V_16
IL_024a: brfalse.s IL_0255
IL_024c: ldloc.s V_16
IL_024e: ldfld PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Response::destinationEntry
IL_0253: br.s IL_0256
IL_0255: ldnull
IL_0256: stloc.s V_17
IL_0258: ldloc.s V_17
IL_025a: brfalse.s IL_026a
IL_025c: ldloc.s V_17
IL_025e: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_0263: call System.String ForestProbe::TutorialChoiceText(System.Int32)
IL_0268: br.s IL_026b
IL_026a: ldnull
IL_026b: stloc.s V_18
IL_026d: ldloc.s V_17
IL_026f: brfalse IL_0375
IL_0274: ldloc.s V_17
IL_0276: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::conversationID
IL_027b: ldc.i4.s 120
IL_027d: bne.un IL_0375
IL_0282: ldloc.s V_17
IL_0284: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_0289: ldc.i4 159
IL_028e: beq.s IL_02a1
IL_0290: ldloc.s V_17
IL_0292: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_0297: ldc.i4 181
IL_029c: bne.un IL_0375
IL_02a1: ldloc.3
IL_02a2: ldloc.s V_17
IL_02a4: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_02a9: callvirt System.Boolean System.Collections.Generic.HashSet`1<System.Int32>::Add(!0)
IL_02ae: brfalse IL_0375
IL_02b3: ldloc.s V_17
IL_02b5: callvirt System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::get_ActorID()
IL_02ba: ldc.i4.1
IL_02bb: bne.un IL_0375
IL_02c0: ldloc.s V_17
IL_02c2: callvirt System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::get_ConversantID()
IL_02c7: ldc.i4.2
IL_02c8: bne.un IL_0375
IL_02cd: ldloc.s V_17
IL_02cf: ldfld System.Boolean PixelCrushers.DialogueSystem.DialogueEntry::isGroup
IL_02d4: brtrue IL_0375
IL_02d9: ldloc.s V_17
IL_02db: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_DialogueText()
IL_02e0: ldloc.s V_18
IL_02e2: call System.Boolean System.String::op_Inequality(System.String,System.String)
IL_02e7: brtrue IL_0375
IL_02ec: ldloc.s V_17
IL_02ee: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_MenuText()
IL_02f3: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_02f8: brfalse.s IL_0375
IL_02fa: ldloc.s V_17
IL_02fc: ldfld System.String PixelCrushers.DialogueSystem.DialogueEntry::conditionsString
IL_0301: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_0306: brfalse.s IL_0375
IL_0308: ldloc.s V_17
IL_030a: ldfld System.String PixelCrushers.DialogueSystem.DialogueEntry::userScript
IL_030f: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_0314: brfalse.s IL_0375
IL_0316: ldloc.s V_17
IL_0318: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_Sequence()
IL_031d: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_0322: brfalse.s IL_0375
IL_0324: ldloc.s V_17
IL_0326: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_ResponseMenuSequence()
IL_032b: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_0330: brfalse.s IL_0375
IL_0332: ldloc.s V_17
IL_0334: ldfld UnityEngine.Events.UnityEvent PixelCrushers.DialogueSystem.DialogueEntry::onExecute
IL_0339: brfalse.s IL_0349
IL_033b: ldloc.s V_17
IL_033d: ldfld UnityEngine.Events.UnityEvent PixelCrushers.DialogueSystem.DialogueEntry::onExecute
IL_0342: callvirt System.Int32 UnityEngine.Events.UnityEventBase::GetPersistentEventCount()
IL_0347: brtrue.s IL_0375
IL_0349: ldloc.s V_16
IL_034b: ldfld PixelCrushers.DialogueSystem.FormattedText PixelCrushers.DialogueSystem.Response::formattedText
IL_0350: brfalse.s IL_0375
IL_0352: ldloc.s V_16
IL_0354: ldfld PixelCrushers.DialogueSystem.FormattedText PixelCrushers.DialogueSystem.Response::formattedText
IL_0359: callvirt System.String PixelCrushers.DialogueSystem.FormattedText::get_text()
IL_035e: ldloc.s V_18
IL_0360: call System.Boolean System.String::op_Inequality(System.String,System.String)
IL_0365: brtrue.s IL_0375
IL_0367: ldloc.s V_16
IL_0369: ldfld PixelCrushers.DialogueSystem.FormattedText PixelCrushers.DialogueSystem.Response::formattedText
IL_036e: callvirt System.Boolean PixelCrushers.DialogueSystem.FormattedText::get_forceAuto()
IL_0373: br.s IL_0376
IL_0375: ldc.i4.1
IL_0376: stloc.s V_19
IL_0378: ldloc.s V_19
IL_037a: brfalse.s IL_0387
IL_037c: ldstr "Tutorial158 PC destination/text/conditions differ"
IL_0381: newobj System.Void System.Exception::.ctor(System.String)
IL_0386: throw
IL_0387: nop
IL_0388: ldloc.s V_15
IL_038a: ldc.i4.1
IL_038b: add
IL_038c: stloc.s V_15
IL_038e: ldloc.s V_15
IL_0390: ldloc.s V_14
IL_0392: ldlen
IL_0393: conv.i4
IL_0394: blt IL_0240
IL_0399: ldarg.0
IL_039a: call System.Collections.Generic.List`1<ForestProbe/ResponseRow> ForestProbe::ReadResponses()
IL_039f: stloc.s V_4
IL_03a1: ldloc.s V_4
IL_03a3: callvirt System.Int32 System.Collections.Generic.List`1<ForestProbe/ResponseRow>::get_Count()
IL_03a8: ldc.i4.0
IL_03a9: cgt.un
IL_03ab: stloc.s V_5
IL_03ad: ldloc.s V_5
IL_03af: stloc.s V_20
IL_03b1: ldloc.s V_20
IL_03b3: brfalse IL_04aa
IL_03b8: nop
IL_03b9: ldloc.3
IL_03ba: callvirt System.Void System.Collections.Generic.HashSet`1<System.Int32>::Clear()
IL_03bf: nop
IL_03c0: nop
IL_03c1: ldloc.s V_4
IL_03c3: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<ForestProbe/ResponseRow>::GetEnumerator()
IL_03c8: stloc.s V_21
IL_03ca: br IL_048c
IL_03cf: ldloca.s V_21
IL_03d1: call !0 System.Collections.Generic.List`1/Enumerator<ForestProbe/ResponseRow>::get_Current()
IL_03d6: stloc.s V_22
IL_03d8: nop
IL_03d9: ldloc.s V_22
IL_03db: ldfld System.Int32 ForestProbe/ResponseRow::entryId
IL_03e0: call System.String ForestProbe::TutorialChoiceText(System.Int32)
IL_03e5: stloc.s V_23
IL_03e7: ldloc.s V_4
IL_03e9: callvirt System.Int32 System.Collections.Generic.List`1<ForestProbe/ResponseRow>::get_Count()
IL_03ee: ldc.i4.2
IL_03ef: bne.un IL_0479
IL_03f4: ldloc.s V_22
IL_03f6: ldfld System.Boolean ForestProbe/ResponseRow::visible
IL_03fb: brfalse.s IL_0479
IL_03fd: ldloc.s V_22
IL_03ff: ldfld System.Boolean ForestProbe/ResponseRow::clickable
IL_0404: brfalse.s IL_0479
IL_0406: ldloc.s V_22
IL_0408: ldfld System.Int32 ForestProbe/ResponseRow::conversationId
IL_040d: ldc.i4.s 120
IL_040f: bne.un.s IL_0479
IL_0411: ldloc.s V_22
IL_0413: ldfld System.Int32 ForestProbe/ResponseRow::entryId
IL_0418: ldc.i4 159
IL_041d: beq.s IL_042d
IL_041f: ldloc.s V_22
IL_0421: ldfld System.Int32 ForestProbe/ResponseRow::entryId
IL_0426: ldc.i4 181
IL_042b: bne.un.s IL_0479
IL_042d: ldloc.3
IL_042e: ldloc.s V_22
IL_0430: ldfld System.Int32 ForestProbe/ResponseRow::entryId
IL_0435: callvirt System.Boolean System.Collections.Generic.HashSet`1<System.Int32>::Add(!0)
IL_043a: brfalse.s IL_0479
IL_043c: ldloc.s V_22
IL_043e: ldfld System.String ForestProbe/ResponseRow::text
IL_0443: ldloc.s V_23
IL_0445: call System.Boolean System.String::op_Inequality(System.String,System.String)
IL_044a: brtrue.s IL_0479
IL_044c: ldloc.s V_22
IL_044e: ldfld System.String ForestProbe/ResponseRow::targetPath
IL_0453: ldstr "Singletons/GlobalSingletonsFirstpass(Clone)/DialogueManager/OverworldDialogueCanvas/VN Template Standard Dialogue UI"
IL_0458: call System.Boolean System.String::op_Inequality(System.String,System.String)
IL_045d: brtrue.s IL_0479
IL_045f: ldloc.s V_22
IL_0461: ldfld System.String ForestProbe/ResponseRow::path
IL_0466: ldstr "Singletons/GlobalSingletonsFirstpass(Clone)/DialogueManager/OverworldDialogueCanvas/VN Template Standard Dialogue UI/Dialogue Panel/Text Panel/Response Menu Panel/Viewport/Content/Response: "
IL_046b: ldloc.s V_23
IL_046d: call System.String System.String::Concat(System.String,System.String)
IL_0472: call System.Boolean System.String::op_Inequality(System.String,System.String)
IL_0477: br.s IL_047a
IL_0479: ldc.i4.1
IL_047a: stloc.s V_24
IL_047c: ldloc.s V_24
IL_047e: brfalse.s IL_048b
IL_0480: ldstr "Tutorial158 original response controls differ"
IL_0485: newobj System.Void System.Exception::.ctor(System.String)
IL_048a: throw
IL_048b: nop
IL_048c: ldloca.s V_21
IL_048e: call System.Boolean System.Collections.Generic.List`1/Enumerator<ForestProbe/ResponseRow>::MoveNext()
IL_0493: brtrue IL_03cf
IL_0498: leave.s IL_04a9
IL_049a: ldloca.s V_21
IL_049c: constrained. System.Collections.Generic.List`1/Enumerator<ForestProbe/ResponseRow>
IL_04a2: callvirt System.Void System.IDisposable::Dispose()
IL_04a7: nop
IL_04a8: endfinally
IL_04a9: nop
IL_04aa: ldnull
IL_04ab: stloc.s V_6
IL_04ad: nop
IL_04ae: call !!0[] UnityEngine.Resources::FindObjectsOfTypeAll<PixelCrushers.DialogueSystem.StandardUISubtitlePanel>()
IL_04b3: stloc.s V_25
IL_04b5: ldc.i4.0
IL_04b6: stloc.s V_26
IL_04b8: br.s IL_051c
IL_04ba: ldloc.s V_25
IL_04bc: ldloc.s V_26
IL_04be: ldelem.ref
IL_04bf: stloc.s V_27
IL_04c1: ldloc.s V_27
IL_04c3: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_04c8: callvirt UnityEngine.SceneManagement.Scene UnityEngine.GameObject::get_scene()
IL_04cd: stloc.s V_29
IL_04cf: ldloca.s V_29
IL_04d1: call System.Boolean UnityEngine.SceneManagement.Scene::IsValid()
IL_04d6: brfalse.s IL_04f0
IL_04d8: ldloc.s V_27
IL_04da: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_04df: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_04e4: ldstr "Singletons/GlobalSingletonsFirstpass(Clone)/DialogueManager/OverworldDialogueCanvas/VN Template Standard Dialogue UI/Dialogue Panel/Text Panel/Subtitle Panel 0"
IL_04e9: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_04ee: br.s IL_04f1
IL_04f0: ldc.i4.0
IL_04f1: stloc.s V_28
IL_04f3: ldloc.s V_28
IL_04f5: brfalse.s IL_0516
IL_04f7: nop
IL_04f8: ldloc.s V_6
IL_04fa: ldnull
IL_04fb: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0500: stloc.s V_30
IL_0502: ldloc.s V_30
IL_0504: brfalse.s IL_0511
IL_0506: ldstr "Ambiguous Tutorial158 subtitle panel"
IL_050b: newobj System.Void System.Exception::.ctor(System.String)
IL_0510: throw
IL_0511: ldloc.s V_27
IL_0513: stloc.s V_6
IL_0515: nop
IL_0516: ldloc.s V_26
IL_0518: ldc.i4.1
IL_0519: add
IL_051a: stloc.s V_26
IL_051c: ldloc.s V_26
IL_051e: ldloc.s V_25
IL_0520: ldlen
IL_0521: conv.i4
IL_0522: blt.s IL_04ba
IL_0524: ldloc.s V_6
IL_0526: ldnull
IL_0527: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_052c: brtrue.s IL_055a
IL_052e: ldloc.s V_6
IL_0530: ldfld UnityEngine.UI.Button PixelCrushers.DialogueSystem.StandardUISubtitlePanel::continueButton
IL_0535: ldnull
IL_0536: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_053b: brtrue.s IL_055a
IL_053d: ldloc.s V_6
IL_053f: ldfld PixelCrushers.UITextField PixelCrushers.DialogueSystem.StandardUISubtitlePanel::subtitleText
IL_0544: brfalse.s IL_055a
IL_0546: ldloc.s V_6
IL_0548: ldfld PixelCrushers.UITextField PixelCrushers.DialogueSystem.StandardUISubtitlePanel::subtitleText
IL_054d: callvirt TMPro.TextMeshProUGUI PixelCrushers.UITextField::get_textMeshProUGUI()
IL_0552: ldnull
IL_0553: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0558: br.s IL_055b
IL_055a: ldc.i4.1
IL_055b: stloc.s V_31
IL_055d: ldloc.s V_31
IL_055f: brfalse.s IL_056c
IL_0561: ldstr "Tutorial158 original subtitle control missing"
IL_0566: newobj System.Void System.Exception::.ctor(System.String)
IL_056b: throw
IL_056c: ldarg.1
IL_056d: ldloc.s V_6
IL_056f: ldfld UnityEngine.UI.Button PixelCrushers.DialogueSystem.StandardUISubtitlePanel::continueButton
IL_0574: stind.ref
IL_0575: ldloc.s V_6
IL_0577: ldfld PixelCrushers.UITextField PixelCrushers.DialogueSystem.StandardUISubtitlePanel::subtitleText
IL_057c: callvirt TMPro.TextMeshProUGUI PixelCrushers.UITextField::get_textMeshProUGUI()
IL_0581: stloc.s V_7
IL_0583: ldarg.1
IL_0584: ldind.ref
IL_0585: callvirt !!0 UnityEngine.Component::GetComponent<TheForestOfLove.TextMeshProUIContinueButtonFastForward>()
IL_058a: stloc.s V_8
IL_058c: ldarg.1
IL_058d: ldind.ref
IL_058e: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0593: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_0598: ldstr "Singletons/GlobalSingletonsFirstpass(Clone)/DialogueManager/OverworldDialogueCanvas/VN Template Standard Dialogue UI/Dialogue Panel/Text Panel/Continue Button"
IL_059d: call System.Boolean System.String::op_Inequality(System.String,System.String)
IL_05a2: brtrue IL_065d
IL_05a7: ldloc.s V_7
IL_05a9: callvirt UnityEngine.Transform TMPro.TMP_Text::get_transform()
IL_05ae: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_05b3: ldstr "Singletons/GlobalSingletonsFirstpass(Clone)/DialogueManager/OverworldDialogueCanvas/VN Template Standard Dialogue UI/Dialogue Panel/Text Panel/Subtitle Text"
IL_05b8: call System.Boolean System.String::op_Inequality(System.String,System.String)
IL_05bd: brtrue IL_065d
IL_05c2: ldloc.s V_8
IL_05c4: ldnull
IL_05c5: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_05ca: brtrue IL_065d
IL_05cf: ldloc.s V_8
IL_05d1: callvirt System.Boolean UnityEngine.Behaviour::get_enabled()
IL_05d6: brfalse IL_065d
IL_05db: ldloc.s V_8
IL_05dd: ldfld Febucci.UI.Core.TypewriterCore TheForestOfLove.TextMeshProUIContinueButtonFastForward::febucciTypewriterEffect
IL_05e2: ldnull
IL_05e3: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_05e8: brtrue.s IL_065d
IL_05ea: ldloc.s V_8
IL_05ec: ldfld Febucci.UI.Core.TypewriterCore TheForestOfLove.TextMeshProUIContinueButtonFastForward::febucciTypewriterEffect
IL_05f1: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_05f6: ldloc.s V_7
IL_05f8: callvirt UnityEngine.Transform TMPro.TMP_Text::get_transform()
IL_05fd: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0602: brtrue.s IL_065d
IL_0604: ldloc.s V_8
IL_0606: ldfld System.Boolean PixelCrushers.DialogueSystem.StandardUIContinueButtonFastForward::hideContinueButtonOnContinue
IL_060b: brtrue.s IL_065d
IL_060d: ldloc.s V_8
IL_060f: ldfld System.Boolean PixelCrushers.DialogueSystem.StandardUIContinueButtonFastForward::continueSubtitlePanel
IL_0614: brfalse.s IL_065d
IL_0616: ldloc.s V_8
IL_0618: ldfld System.Boolean PixelCrushers.DialogueSystem.StandardUIContinueButtonFastForward::continueAlertPanel
IL_061d: brfalse.s IL_065d
IL_061f: ldarg.1
IL_0620: ldind.ref
IL_0621: callvirt UnityEngine.UI.Button/ButtonClickedEvent UnityEngine.UI.Button::get_onClick()
IL_0626: callvirt System.Int32 UnityEngine.Events.UnityEventBase::GetPersistentEventCount()
IL_062b: ldc.i4.1
IL_062c: bne.un.s IL_065d
IL_062e: ldarg.1
IL_062f: ldind.ref
IL_0630: callvirt UnityEngine.UI.Button/ButtonClickedEvent UnityEngine.UI.Button::get_onClick()
IL_0635: ldc.i4.0
IL_0636: callvirt UnityEngine.Object UnityEngine.Events.UnityEventBase::GetPersistentTarget(System.Int32)
IL_063b: ldloc.s V_8
IL_063d: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0642: brtrue.s IL_065d
IL_0644: ldarg.1
IL_0645: ldind.ref
IL_0646: callvirt UnityEngine.UI.Button/ButtonClickedEvent UnityEngine.UI.Button::get_onClick()
IL_064b: ldc.i4.0
IL_064c: callvirt System.String UnityEngine.Events.UnityEventBase::GetPersistentMethodName(System.Int32)
IL_0651: ldstr "OnFastForward"
IL_0656: call System.Boolean System.String::op_Inequality(System.String,System.String)
IL_065b: br.s IL_065e
IL_065d: ldc.i4.1
IL_065e: stloc.s V_32
IL_0660: ldloc.s V_32
IL_0662: brfalse.s IL_066f
IL_0664: ldstr "Tutorial158 original Continue binding differs"
IL_0669: newobj System.Void System.Exception::.ctor(System.String)
IL_066e: throw
IL_066f: ldloc.s V_5
IL_0671: brtrue.s IL_06ba
IL_0673: ldloc.s V_6
IL_0675: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_067a: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_067f: brfalse.s IL_06b7
IL_0681: ldloc.s V_6
IL_0683: callvirt System.Boolean UnityEngine.Behaviour::get_enabled()
IL_0688: brfalse.s IL_06b7
IL_068a: ldloc.s V_6
IL_068c: callvirt PixelCrushers.DialogueSystem.Subtitle PixelCrushers.DialogueSystem.StandardUISubtitlePanel::get_currentSubtitle()
IL_0691: ldloc.1
IL_0692: bne.un.s IL_06b7
IL_0694: ldarg.1
IL_0695: ldind.ref
IL_0696: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_069b: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_06a0: brfalse.s IL_06b7
IL_06a2: ldarg.1
IL_06a3: ldind.ref
IL_06a4: callvirt System.Boolean UnityEngine.Behaviour::get_enabled()
IL_06a9: brfalse.s IL_06b7
IL_06ab: ldarg.1
IL_06ac: ldind.ref
IL_06ad: callvirt System.Boolean UnityEngine.UI.Selectable::IsInteractable()
IL_06b2: ldc.i4.0
IL_06b3: ceq
IL_06b5: br.s IL_06b8
IL_06b7: ldc.i4.1
IL_06b8: br.s IL_06bb
IL_06ba: ldc.i4.0
IL_06bb: stloc.s V_33
IL_06bd: ldloc.s V_33
IL_06bf: brfalse.s IL_06cc
IL_06c1: ldstr "Tutorial158 original Continue not active/bound/interactable"
IL_06c6: newobj System.Void System.Exception::.ctor(System.String)
IL_06cb: throw
IL_06cc: newobj System.Void ForestProbe/TutorialCompletion::.ctor()
IL_06d1: dup
IL_06d2: ldstr "original"
IL_06d7: stfld System.String ForestProbe/TutorialCompletion::choiceMode
IL_06dc: dup
IL_06dd: call System.Int32 UnityEngine.Time::get_frameCount()
IL_06e2: stfld System.Int32 ForestProbe/TutorialCompletion::frame
IL_06e7: dup
IL_06e8: ldc.i4.s 120
IL_06ea: stfld System.Int32 ForestProbe/TutorialCompletion::conversationId
IL_06ef: dup
IL_06f0: ldc.i4 158
IL_06f5: stfld System.Int32 ForestProbe/TutorialCompletion::entryId
IL_06fa: dup
IL_06fb: ldloc.1
IL_06fc: ldfld PixelCrushers.DialogueSystem.FormattedText PixelCrushers.DialogueSystem.Subtitle::formattedText
IL_0701: callvirt System.String PixelCrushers.DialogueSystem.FormattedText::get_text()
IL_0706: stfld System.String ForestProbe/TutorialCompletion::text
IL_070b: dup
IL_070c: ldloc.2
IL_070d: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_DialogueText()
IL_0712: stfld System.String ForestProbe/TutorialCompletion::sourceText
IL_0717: dup
IL_0718: ldloc.s V_6
IL_071a: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_071f: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_0724: stfld System.String ForestProbe/TutorialCompletion::panelPath
IL_0729: dup
IL_072a: ldarg.1
IL_072b: ldind.ref
IL_072c: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0731: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_0736: stfld System.String ForestProbe/TutorialCompletion::buttonPath
IL_073b: dup
IL_073c: ldloc.s V_7
IL_073e: callvirt UnityEngine.Transform TMPro.TMP_Text::get_transform()
IL_0743: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_0748: stfld System.String ForestProbe/TutorialCompletion::textPath
IL_074d: dup
IL_074e: ldstr "Singletons/GlobalSingletonsFirstpass(Clone)/DialogueManager/OverworldDialogueCanvas/VN Template Standard Dialogue UI"
IL_0753: stfld System.String ForestProbe/TutorialCompletion::targetPath
IL_0758: dup
IL_0759: ldstr "OnFastForward"
IL_075e: stfld System.String ForestProbe/TutorialCompletion::listenerMethod
IL_0763: dup
IL_0764: ldloc.s V_8
IL_0766: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_076b: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_0770: stfld System.String ForestProbe/TutorialCompletion::listenerTargetPath
IL_0775: dup
IL_0776: ldstr "120:159,120:181"
IL_077b: stfld System.String ForestProbe/TutorialCompletion::sourceDestinations
IL_0780: dup
IL_0781: ldstr "120:159,120:181"
IL_0786: stfld System.String ForestProbe/TutorialCompletion::pcDestinations
IL_078b: dup
IL_078c: ldc.i4.1
IL_078d: stfld System.Boolean ForestProbe/TutorialCompletion::graphVerified
IL_0792: dup
IL_0793: ldloc.s V_6
IL_0795: callvirt System.Int32 UnityEngine.Object::GetInstanceID()
IL_079a: stfld System.Int32 ForestProbe/TutorialCompletion::panelInstance
IL_079f: dup
IL_07a0: ldarg.1
IL_07a1: ldind.ref
IL_07a2: callvirt System.Int32 UnityEngine.Object::GetInstanceID()
IL_07a7: stfld System.Int32 ForestProbe/TutorialCompletion::buttonInstance
IL_07ac: dup
IL_07ad: ldloc.s V_7
IL_07af: callvirt System.Int32 UnityEngine.Object::GetInstanceID()
IL_07b4: stfld System.Int32 ForestProbe/TutorialCompletion::textInstance
IL_07b9: dup
IL_07ba: call System.Boolean TheForestOfLove.CustomTypewriterEffectTextMeshPro::IsTyping()
IL_07bf: stfld System.Boolean ForestProbe/TutorialCompletion::typing
IL_07c4: dup
IL_07c5: ldloc.s V_5
IL_07c7: stfld System.Boolean ForestProbe/TutorialCompletion::menuPresent
IL_07cc: dup
IL_07cd: ldarg.1
IL_07ce: ldind.ref
IL_07cf: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_07d4: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_07d9: stfld System.Boolean ForestProbe/TutorialCompletion::buttonActive
IL_07de: dup
IL_07df: ldarg.1
IL_07e0: ldind.ref
IL_07e1: callvirt System.Boolean UnityEngine.Behaviour::get_enabled()
IL_07e6: stfld System.Boolean ForestProbe/TutorialCompletion::buttonEnabled
IL_07eb: dup
IL_07ec: ldarg.1
IL_07ed: ldind.ref
IL_07ee: callvirt System.Boolean UnityEngine.UI.Selectable::IsInteractable()
IL_07f3: stfld System.Boolean ForestProbe/TutorialCompletion::buttonInteractable
IL_07f8: stloc.s V_34
IL_07fa: br.s IL_07fc
IL_07fc: ldloc.s V_34
IL_07fe: ret
METHOD System.Void ForestProbe::ReadTutorialCompletionRecord(ForestProbe/State) | attributes=Private, HideBySig | impl=IL
IL_0000: nop
IL_0001: ldarg.1
IL_0002: ldfld System.Boolean ForestProbe/State::conversationActive
IL_0007: brfalse.s IL_0022
IL_0009: ldarg.1
IL_000a: ldfld System.Int32 ForestProbe/State::conversationId
IL_000f: ldc.i4.s 120
IL_0011: bne.un.s IL_0022
IL_0013: ldarg.1
IL_0014: ldfld System.Int32 ForestProbe/State::entryId
IL_0019: ldc.i4 158
IL_001e: ceq
IL_0020: br.s IL_0023
IL_0022: ldc.i4.0
IL_0023: stloc.0
IL_0024: ldloc.0
IL_0025: brfalse.s IL_00a4
IL_0027: nop
IL_0028: ldarg.1
IL_0029: ldarg.0
IL_002a: ldloca.s V_1
IL_002c: call ForestProbe/TutorialCompletion ForestProbe::ReadTutorialCompletion(UnityEngine.UI.Button&)
IL_0031: call System.String UnityEngine.JsonUtility::ToJson(System.Object)
IL_0036: stfld System.String ForestProbe/State::tutorialCompletionRecord
IL_003b: ldarg.1
IL_003c: ldfld System.Boolean ForestProbe/State::typing
IL_0041: brtrue.s IL_0053
IL_0043: ldarg.0
IL_0044: call System.Collections.Generic.List`1<ForestProbe/ResponseRow> ForestProbe::ReadResponses()
IL_0049: callvirt System.Int32 System.Collections.Generic.List`1<ForestProbe/ResponseRow>::get_Count()
IL_004e: ldc.i4.2
IL_004f: ceq
IL_0051: br.s IL_0054
IL_0053: ldc.i4.0
IL_0054: stloc.2
IL_0055: ldloc.2
IL_0056: brfalse.s IL_00a3
IL_0058: nop
IL_0059: ldarg.1
IL_005a: ldarg.0
IL_005b: call ForestProbe/Tutorial181Control ForestProbe::ReadTutorial181Control()
IL_0060: call System.String UnityEngine.JsonUtility::ToJson(System.Object)
IL_0065: stfld System.String ForestProbe/State::tutorial181ControlRecord
IL_006a: nop
IL_006b: ldarg.1
IL_006c: ldarg.0
IL_006d: ldloca.s V_1
IL_006f: call ForestProbe/Tutorial181Selection ForestProbe::ReadTutorial181(UnityEngine.UI.Button&)
IL_0074: call System.String UnityEngine.JsonUtility::ToJson(System.Object)
IL_0079: stfld System.String ForestProbe/State::tutorial181Record
IL_007e: nop
IL_007f: leave.s IL_00a2
IL_0081: stloc.3
IL_0082: nop
IL_0083: ldarg.1
IL_0084: newobj System.Void ForestProbe/Tutorial181Rejection::.ctor()
IL_0089: dup
IL_008a: ldloc.3
IL_008b: callvirt System.String System.Exception::get_Message()
IL_0090: stfld System.String ForestProbe/Tutorial181Rejection::error
IL_0095: call System.String UnityEngine.JsonUtility::ToJson(System.Object)
IL_009a: stfld System.String ForestProbe/State::tutorial181Record
IL_009f: nop
IL_00a0: leave.s IL_00a2
IL_00a2: nop
IL_00a3: nop
IL_00a4: ret
METHOD ForestProbe/Tutorial181Control ForestProbe::ReadTutorial181Control() | attributes=Private, HideBySig | impl=IL
IL_0000: nop
IL_0001: newobj System.Void ForestProbe/Tutorial181Control::.ctor()
IL_0006: dup
IL_0007: ldc.i4.m1
IL_0008: stfld System.Int32 ForestProbe/Tutorial181Control::persistentListenerCount
IL_000d: stloc.0
IL_000e: nop
IL_000f: call !!0[] UnityEngine.Resources::FindObjectsOfTypeAll<PixelCrushers.DialogueSystem.StandardUIResponseButton>()
IL_0014: stloc.1
IL_0015: ldc.i4.0
IL_0016: stloc.2
IL_0017: br IL_018e
IL_001c: ldloc.1
IL_001d: ldloc.2
IL_001e: ldelem.ref
IL_001f: stloc.3
IL_0020: ldloc.3
IL_0021: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0026: callvirt UnityEngine.SceneManagement.Scene UnityEngine.GameObject::get_scene()
IL_002b: stloc.s V_5
IL_002d: ldloca.s V_5
IL_002f: call System.Boolean UnityEngine.SceneManagement.Scene::IsValid()
IL_0034: brfalse.s IL_0071
IL_0036: ldloc.3
IL_0037: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_003c: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_0041: brfalse.s IL_0071
IL_0043: ldloc.3
IL_0044: callvirt PixelCrushers.DialogueSystem.Response PixelCrushers.DialogueSystem.StandardUIResponseButton::get_response()
IL_0049: brfalse.s IL_0071
IL_004b: ldloc.3
IL_004c: callvirt PixelCrushers.DialogueSystem.Response PixelCrushers.DialogueSystem.StandardUIResponseButton::get_response()
IL_0051: ldfld PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Response::destinationEntry
IL_0056: brfalse.s IL_0071
IL_0058: ldloc.3
IL_0059: callvirt PixelCrushers.DialogueSystem.Response PixelCrushers.DialogueSystem.StandardUIResponseButton::get_response()
IL_005e: ldfld PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Response::destinationEntry
IL_0063: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_0068: ldc.i4 181
IL_006d: ceq
IL_006f: br.s IL_0072
IL_0071: ldc.i4.0
IL_0072: stloc.s V_4
IL_0074: ldloc.s V_4
IL_0076: brfalse IL_018a
IL_007b: nop
IL_007c: ldloc.0
IL_007d: dup
IL_007e: ldfld System.Int32 ForestProbe/Tutorial181Control::matches
IL_0083: ldc.i4.1
IL_0084: add
IL_0085: stfld System.Int32 ForestProbe/Tutorial181Control::matches
IL_008a: ldloc.0
IL_008b: ldloc.3
IL_008c: callvirt System.Type System.Object::GetType()
IL_0091: callvirt System.String System.Type::get_FullName()
IL_0096: stfld System.String ForestProbe/Tutorial181Control::controllerType
IL_009b: ldloc.0
IL_009c: ldloc.3
IL_009d: callvirt System.Boolean UnityEngine.Behaviour::get_enabled()
IL_00a2: stfld System.Boolean ForestProbe/Tutorial181Control::controllerEnabled
IL_00a7: ldloc.0
IL_00a8: ldloc.3
IL_00a9: callvirt System.Int32 UnityEngine.Object::GetInstanceID()
IL_00ae: stfld System.Int32 ForestProbe/Tutorial181Control::controllerInstance
IL_00b3: ldloc.0
IL_00b4: ldloc.3
IL_00b5: callvirt System.String PixelCrushers.DialogueSystem.StandardUIResponseButton::get_text()
IL_00ba: stfld System.String ForestProbe/Tutorial181Control::text
IL_00bf: ldloc.0
IL_00c0: ldloc.3
IL_00c1: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_00c6: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_00cb: stfld System.String ForestProbe/Tutorial181Control::path
IL_00d0: ldloc.0
IL_00d1: ldloc.3
IL_00d2: callvirt UnityEngine.Transform PixelCrushers.DialogueSystem.StandardUIResponseButton::get_target()
IL_00d7: ldnull
IL_00d8: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_00dd: brtrue.s IL_00ec
IL_00df: ldloc.3
IL_00e0: callvirt UnityEngine.Transform PixelCrushers.DialogueSystem.StandardUIResponseButton::get_target()
IL_00e5: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_00ea: br.s IL_00f1
IL_00ec: ldstr ""
IL_00f1: stfld System.String ForestProbe/Tutorial181Control::targetPath
IL_00f6: ldloc.0
IL_00f7: ldloc.3
IL_00f8: callvirt System.Boolean PixelCrushers.DialogueSystem.StandardUIResponseButton::get_isVisible()
IL_00fd: stfld System.Boolean ForestProbe/Tutorial181Control::visible
IL_0102: ldloc.0
IL_0103: ldloc.3
IL_0104: callvirt System.Boolean PixelCrushers.DialogueSystem.StandardUIResponseButton::get_isClickable()
IL_0109: stfld System.Boolean ForestProbe/Tutorial181Control::clickable
IL_010e: ldloc.3
IL_010f: ldfld UnityEngine.UI.Button PixelCrushers.DialogueSystem.StandardUIResponseButton::button
IL_0114: stloc.s V_6
IL_0116: ldloc.s V_6
IL_0118: ldnull
IL_0119: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_011e: stloc.s V_7
IL_0120: ldloc.s V_7
IL_0122: brfalse.s IL_0189
IL_0124: nop
IL_0125: ldloc.0
IL_0126: ldloc.s V_6
IL_0128: callvirt System.Int32 UnityEngine.Object::GetInstanceID()
IL_012d: stfld System.Int32 ForestProbe/Tutorial181Control::buttonInstance
IL_0132: ldloc.0
IL_0133: ldloc.s V_6
IL_0135: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_013a: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_013f: stfld System.String ForestProbe/Tutorial181Control::buttonPath
IL_0144: ldloc.0
IL_0145: ldloc.s V_6
IL_0147: callvirt System.Boolean UnityEngine.Behaviour::get_enabled()
IL_014c: stfld System.Boolean ForestProbe/Tutorial181Control::buttonEnabled
IL_0151: ldloc.0
IL_0152: ldloc.s V_6
IL_0154: callvirt System.Boolean UnityEngine.UI.Selectable::IsInteractable()
IL_0159: stfld System.Boolean ForestProbe/Tutorial181Control::buttonInteractable
IL_015e: ldloc.0
IL_015f: ldloc.s V_6
IL_0161: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0166: ldloc.3
IL_0167: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_016c: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0171: stfld System.Boolean ForestProbe/Tutorial181Control::sameTransform
IL_0176: ldloc.0
IL_0177: ldloc.s V_6
IL_0179: callvirt UnityEngine.UI.Button/ButtonClickedEvent UnityEngine.UI.Button::get_onClick()
IL_017e: callvirt System.Int32 UnityEngine.Events.UnityEventBase::GetPersistentEventCount()
IL_0183: stfld System.Int32 ForestProbe/Tutorial181Control::persistentListenerCount
IL_0188: nop
IL_0189: nop
IL_018a: ldloc.2
IL_018b: ldc.i4.1
IL_018c: add
IL_018d: stloc.2
IL_018e: ldloc.2
IL_018f: ldloc.1
IL_0190: ldlen
IL_0191: conv.i4
IL_0192: blt IL_001c
IL_0197: ldloc.0
IL_0198: stloc.s V_8
IL_019a: br.s IL_019c
IL_019c: ldloc.s V_8
IL_019e: ret
METHOD System.Void ForestProbe::Tutorial181Entry(PixelCrushers.DialogueSystem.DialogueEntry,System.Int32,System.String,System.Int32,System.Int32,System.Int32) | attributes=Private, Static, HideBySig | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: brfalse IL_00c0
IL_0007: ldarg.0
IL_0008: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::conversationID
IL_000d: ldc.i4.s 120
IL_000f: bne.un IL_00c0
IL_0014: ldarg.0
IL_0015: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_001a: ldarg.1
IL_001b: bne.un IL_00c0
IL_0020: ldarg.0
IL_0021: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_DialogueText()
IL_0026: ldarg.2
IL_0027: call System.Boolean System.String::op_Inequality(System.String,System.String)
IL_002c: brtrue IL_00c0
IL_0031: ldarg.0
IL_0032: callvirt System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::get_ActorID()
IL_0037: ldarg.3
IL_0038: bne.un IL_00c0
IL_003d: ldarg.0
IL_003e: callvirt System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::get_ConversantID()
IL_0043: ldarg.s conversant
IL_0045: bne.un.s IL_00c0
IL_0047: ldarg.0
IL_0048: ldfld System.Boolean PixelCrushers.DialogueSystem.DialogueEntry::isGroup
IL_004d: brtrue.s IL_00c0
IL_004f: ldarg.0
IL_0050: ldfld System.String PixelCrushers.DialogueSystem.DialogueEntry::conditionsString
IL_0055: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_005a: brfalse.s IL_00c0
IL_005c: ldarg.0
IL_005d: ldfld System.String PixelCrushers.DialogueSystem.DialogueEntry::userScript
IL_0062: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_0067: brfalse.s IL_00c0
IL_0069: ldarg.0
IL_006a: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_MenuText()
IL_006f: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_0074: brfalse.s IL_00c0
IL_0076: ldarg.0
IL_0077: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_Sequence()
IL_007c: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_0081: brfalse.s IL_00c0
IL_0083: ldarg.0
IL_0084: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_ResponseMenuSequence()
IL_0089: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_008e: brfalse.s IL_00c0
IL_0090: ldarg.0
IL_0091: ldfld UnityEngine.Events.UnityEvent PixelCrushers.DialogueSystem.DialogueEntry::onExecute
IL_0096: brfalse.s IL_00a5
IL_0098: ldarg.0
IL_0099: ldfld UnityEngine.Events.UnityEvent PixelCrushers.DialogueSystem.DialogueEntry::onExecute
IL_009e: callvirt System.Int32 UnityEngine.Events.UnityEventBase::GetPersistentEventCount()
IL_00a3: brtrue.s IL_00c0
IL_00a5: ldarg.0
IL_00a6: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link> PixelCrushers.DialogueSystem.DialogueEntry::outgoingLinks
IL_00ab: brfalse.s IL_00c0
IL_00ad: ldarg.0
IL_00ae: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link> PixelCrushers.DialogueSystem.DialogueEntry::outgoingLinks
IL_00b3: callvirt System.Int32 System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link>::get_Count()
IL_00b8: ldc.i4.1
IL_00b9: ceq
IL_00bb: ldc.i4.0
IL_00bc: ceq
IL_00be: br.s IL_00c1
IL_00c0: ldc.i4.1
IL_00c1: stloc.1
IL_00c2: ldloc.1
IL_00c3: brfalse.s IL_00d0
IL_00c5: ldstr "Tutorial181 exact destination source differs"
IL_00ca: newobj System.Void System.Exception::.ctor(System.String)
IL_00cf: throw
IL_00d0: ldarg.0
IL_00d1: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link> PixelCrushers.DialogueSystem.DialogueEntry::outgoingLinks
IL_00d6: ldc.i4.0
IL_00d7: callvirt !0 System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link>::get_Item(System.Int32)
IL_00dc: stloc.0
IL_00dd: ldloc.0
IL_00de: ldfld System.Int32 PixelCrushers.DialogueSystem.Link::originConversationID
IL_00e3: ldc.i4.s 120
IL_00e5: bne.un.s IL_011a
IL_00e7: ldloc.0
IL_00e8: ldfld System.Int32 PixelCrushers.DialogueSystem.Link::originDialogueID
IL_00ed: ldarg.1
IL_00ee: bne.un.s IL_011a
IL_00f0: ldloc.0
IL_00f1: ldfld System.Int32 PixelCrushers.DialogueSystem.Link::destinationConversationID
IL_00f6: ldc.i4.s 120
IL_00f8: bne.un.s IL_011a
IL_00fa: ldloc.0
IL_00fb: ldfld System.Int32 PixelCrushers.DialogueSystem.Link::destinationDialogueID
IL_0100: ldarg.s successor
IL_0102: bne.un.s IL_011a
IL_0104: ldloc.0
IL_0105: ldfld System.Boolean PixelCrushers.DialogueSystem.Link::isConnector
IL_010a: brtrue.s IL_011a
IL_010c: ldloc.0
IL_010d: ldfld PixelCrushers.DialogueSystem.ConditionPriority PixelCrushers.DialogueSystem.Link::priority
IL_0112: ldc.i4.2
IL_0113: ceq
IL_0115: ldc.i4.0
IL_0116: ceq
IL_0118: br.s IL_011b
IL_011a: ldc.i4.1
IL_011b: stloc.2
IL_011c: ldloc.2
IL_011d: brfalse.s IL_012a
IL_011f: ldstr "Tutorial181 exact destination link differs"
IL_0124: newobj System.Void System.Exception::.ctor(System.String)
IL_0129: throw
IL_012a: ret
METHOD ForestProbe/Tutorial181Selection ForestProbe::ReadTutorial181(UnityEngine.UI.Button&) | attributes=Private, HideBySig | impl=IL
IL_0000: nop
IL_0001: ldc.i4.0
IL_0002: stloc.s V_7
IL_0004: br.s IL_0006
IL_0006: ldarg.0
IL_0007: ldloca.s V_0
IL_0009: call ForestProbe/TutorialCompletion ForestProbe::ReadTutorialCompletion(UnityEngine.UI.Button&)
IL_000e: stloc.1
IL_000f: ldloc.1
IL_0010: ldfld System.Boolean ForestProbe/TutorialCompletion::typing
IL_0015: brtrue.s IL_0022
IL_0017: ldloc.1
IL_0018: ldfld System.Boolean ForestProbe/TutorialCompletion::menuPresent
IL_001d: ldc.i4.0
IL_001e: ceq
IL_0020: br.s IL_0023
IL_0022: ldc.i4.1
IL_0023: stloc.s V_8
IL_0025: ldloc.s V_8
IL_0027: brfalse.s IL_0034
IL_0029: ldstr "Tutorial181 requires fresh non-typing menu"
IL_002e: newobj System.Void System.Exception::.ctor(System.String)
IL_0033: throw
IL_0034: ldnull
IL_0035: stloc.2
IL_0036: nop
IL_0037: call !!0[] UnityEngine.Resources::FindObjectsOfTypeAll<PixelCrushers.DialogueSystem.StandardUIResponseButton>()
IL_003c: stloc.s V_9
IL_003e: ldc.i4.0
IL_003f: stloc.s V_10
IL_0041: br IL_00cd
IL_0046: ldloc.s V_9
IL_0048: ldloc.s V_10
IL_004a: ldelem.ref
IL_004b: stloc.s V_11
IL_004d: ldloc.s V_11
IL_004f: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0054: callvirt UnityEngine.SceneManagement.Scene UnityEngine.GameObject::get_scene()
IL_0059: stloc.s V_13
IL_005b: ldloca.s V_13
IL_005d: call System.Boolean UnityEngine.SceneManagement.Scene::IsValid()
IL_0062: brfalse.s IL_00a3
IL_0064: ldloc.s V_11
IL_0066: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_006b: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_0070: brfalse.s IL_00a3
IL_0072: ldloc.s V_11
IL_0074: callvirt PixelCrushers.DialogueSystem.Response PixelCrushers.DialogueSystem.StandardUIResponseButton::get_response()
IL_0079: brfalse.s IL_00a3
IL_007b: ldloc.s V_11
IL_007d: callvirt PixelCrushers.DialogueSystem.Response PixelCrushers.DialogueSystem.StandardUIResponseButton::get_response()
IL_0082: ldfld PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Response::destinationEntry
IL_0087: brfalse.s IL_00a3
IL_0089: ldloc.s V_11
IL_008b: callvirt PixelCrushers.DialogueSystem.Response PixelCrushers.DialogueSystem.StandardUIResponseButton::get_response()
IL_0090: ldfld PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Response::destinationEntry
IL_0095: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_009a: ldc.i4 181
IL_009f: ceq
IL_00a1: br.s IL_00a4
IL_00a3: ldc.i4.0
IL_00a4: stloc.s V_12
IL_00a6: ldloc.s V_12
IL_00a8: brfalse.s IL_00c7
IL_00aa: nop
IL_00ab: ldloc.2
IL_00ac: ldnull
IL_00ad: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_00b2: stloc.s V_14
IL_00b4: ldloc.s V_14
IL_00b6: brfalse.s IL_00c3
IL_00b8: ldstr "Ambiguous Tutorial181 button"
IL_00bd: newobj System.Void System.Exception::.ctor(System.String)
IL_00c2: throw
IL_00c3: ldloc.s V_11
IL_00c5: stloc.2
IL_00c6: nop
IL_00c7: ldloc.s V_10
IL_00c9: ldc.i4.1
IL_00ca: add
IL_00cb: stloc.s V_10
IL_00cd: ldloc.s V_10
IL_00cf: ldloc.s V_9
IL_00d1: ldlen
IL_00d2: conv.i4
IL_00d3: blt IL_0046
IL_00d8: ldstr "Singletons/GlobalSingletonsFirstpass(Clone)/DialogueManager/OverworldDialogueCanvas/VN Template Standard Dialogue UI/Dialogue Panel/Text Panel/Response Menu Panel/Viewport/Content/Response: The love. Definitely the love."
IL_00dd: stloc.3
IL_00de: ldloc.2
IL_00df: ldnull
IL_00e0: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_00e5: brtrue IL_01c7
IL_00ea: ldloc.2
IL_00eb: callvirt System.Type System.Object::GetType()
IL_00f0: ldtoken PixelCrushers.DialogueSystem.StandardUIResponseButton
IL_00f5: call System.Type System.Type::GetTypeFromHandle(System.RuntimeTypeHandle)
IL_00fa: call System.Boolean System.Type::op_Inequality(System.Type,System.Type)
IL_00ff: brtrue IL_01c7
IL_0104: ldloc.2
IL_0105: callvirt System.Boolean UnityEngine.Behaviour::get_enabled()
IL_010a: brfalse IL_01c7
IL_010f: ldloc.2
IL_0110: callvirt System.Boolean PixelCrushers.DialogueSystem.StandardUIResponseButton::get_isVisible()
IL_0115: brfalse IL_01c7
IL_011a: ldloc.2
IL_011b: callvirt System.Boolean PixelCrushers.DialogueSystem.StandardUIResponseButton::get_isClickable()
IL_0120: brfalse IL_01c7
IL_0125: ldloc.2
IL_0126: callvirt System.String PixelCrushers.DialogueSystem.StandardUIResponseButton::get_text()
IL_012b: ldstr "The love. Definitely the love."
IL_0130: call System.Boolean System.String::op_Inequality(System.String,System.String)
IL_0135: brtrue IL_01c7
IL_013a: ldloc.2
IL_013b: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0140: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_0145: ldloc.3
IL_0146: call System.Boolean System.String::op_Inequality(System.String,System.String)
IL_014b: brtrue.s IL_01c7
IL_014d: ldloc.2
IL_014e: callvirt UnityEngine.Transform PixelCrushers.DialogueSystem.StandardUIResponseButton::get_target()
IL_0153: ldnull
IL_0154: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0159: brtrue.s IL_01c7
IL_015b: ldloc.2
IL_015c: callvirt UnityEngine.Transform PixelCrushers.DialogueSystem.StandardUIResponseButton::get_target()
IL_0161: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_0166: ldstr "Singletons/GlobalSingletonsFirstpass(Clone)/DialogueManager/OverworldDialogueCanvas/VN Template Standard Dialogue UI"
IL_016b: call System.Boolean System.String::op_Inequality(System.String,System.String)
IL_0170: brtrue.s IL_01c7
IL_0172: ldloc.2
IL_0173: ldfld UnityEngine.UI.Button PixelCrushers.DialogueSystem.StandardUIResponseButton::button
IL_0178: ldnull
IL_0179: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_017e: brtrue.s IL_01c7
IL_0180: ldloc.2
IL_0181: ldfld UnityEngine.UI.Button PixelCrushers.DialogueSystem.StandardUIResponseButton::button
IL_0186: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_018b: ldloc.2
IL_018c: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0191: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0196: brtrue.s IL_01c7
IL_0198: ldloc.2
IL_0199: ldfld UnityEngine.UI.Button PixelCrushers.DialogueSystem.StandardUIResponseButton::button
IL_019e: callvirt System.Boolean UnityEngine.Behaviour::get_enabled()
IL_01a3: brfalse.s IL_01c7
IL_01a5: ldloc.2
IL_01a6: ldfld UnityEngine.UI.Button PixelCrushers.DialogueSystem.StandardUIResponseButton::button
IL_01ab: callvirt System.Boolean UnityEngine.UI.Selectable::IsInteractable()
IL_01b0: brfalse.s IL_01c7
IL_01b2: ldloc.2
IL_01b3: ldfld UnityEngine.UI.Button PixelCrushers.DialogueSystem.StandardUIResponseButton::button
IL_01b8: callvirt UnityEngine.UI.Button/ButtonClickedEvent UnityEngine.UI.Button::get_onClick()
IL_01bd: callvirt System.Int32 UnityEngine.Events.UnityEventBase::GetPersistentEventCount()
IL_01c2: ldc.i4.0
IL_01c3: cgt.un
IL_01c5: br.s IL_01c8
IL_01c7: ldc.i4.1
IL_01c8: stloc.s V_15
IL_01ca: ldloc.s V_15
IL_01cc: brfalse.s IL_01d9
IL_01ce: ldstr "Tutorial181 original response control differs"
IL_01d3: newobj System.Void System.Exception::.ctor(System.String)
IL_01d8: throw
IL_01d9: ldloc.2
IL_01da: callvirt PixelCrushers.DialogueSystem.Response PixelCrushers.DialogueSystem.StandardUIResponseButton::get_response()
IL_01df: ldfld PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Response::destinationEntry
IL_01e4: ldc.i4 181
IL_01e9: ldstr "The love. Definitely the love."
IL_01ee: ldc.i4.1
IL_01ef: ldc.i4.2
IL_01f0: ldc.i4 182
IL_01f5: call System.Void ForestProbe::Tutorial181Entry(PixelCrushers.DialogueSystem.DialogueEntry,System.Int32,System.String,System.Int32,System.Int32,System.Int32)
IL_01fa: nop
IL_01fb: call PixelCrushers.DialogueSystem.DialogueDatabase PixelCrushers.DialogueSystem.DialogueManager::get_masterDatabase()
IL_0200: ldc.i4.s 120
IL_0202: ldc.i4 182
IL_0207: callvirt PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.DialogueDatabase::GetDialogueEntry(System.Int32,System.Int32)
IL_020c: ldc.i4 182
IL_0211: ldstr "[pic=2]Hahaha!"
IL_0216: ldc.i4.2
IL_0217: ldc.i4.1
IL_0218: ldc.i4 183
IL_021d: call System.Void ForestProbe::Tutorial181Entry(PixelCrushers.DialogueSystem.DialogueEntry,System.Int32,System.String,System.Int32,System.Int32,System.Int32)
IL_0222: nop
IL_0223: ldtoken UnityEngine.Events.UnityEventBase
IL_0228: call System.Type System.Type::GetTypeFromHandle(System.RuntimeTypeHandle)
IL_022d: ldstr "m_Calls"
IL_0232: ldc.i4.s 36
IL_0234: callvirt System.Reflection.FieldInfo System.Type::GetField(System.String,System.Reflection.BindingFlags)
IL_0239: ldloc.2
IL_023a: ldfld UnityEngine.UI.Button PixelCrushers.DialogueSystem.StandardUIResponseButton::button
IL_023f: callvirt UnityEngine.UI.Button/ButtonClickedEvent UnityEngine.UI.Button::get_onClick()
IL_0244: callvirt System.Object System.Reflection.FieldInfo::GetValue(System.Object)
IL_0249: stloc.s V_4
IL_024b: ldloc.s V_4
IL_024d: ldstr "m_RuntimeCalls"
IL_0252: call System.Object ForestProbe::ReadField(System.Object,System.String)
IL_0257: isinst System.Collections.IList
IL_025c: stloc.s V_5
IL_025e: ldloc.s V_5
IL_0260: brfalse.s IL_0271
IL_0262: ldloc.s V_5
IL_0264: callvirt System.Int32 System.Collections.ICollection::get_Count()
IL_0269: ldc.i4.1
IL_026a: ceq
IL_026c: ldc.i4.0
IL_026d: ceq
IL_026f: br.s IL_0272
IL_0271: ldc.i4.1
IL_0272: stloc.s V_16
IL_0274: ldloc.s V_16
IL_0276: brfalse.s IL_0283
IL_0278: ldstr "Tutorial181 runtime listener count differs"
IL_027d: newobj System.Void System.Exception::.ctor(System.String)
IL_0282: throw
IL_0283: ldloc.s V_5
IL_0285: ldc.i4.0
IL_0286: callvirt System.Object System.Collections.IList::get_Item(System.Int32)
IL_028b: ldstr "Delegate"
IL_0290: call System.Object ForestProbe::ReadField(System.Object,System.String)
IL_0295: isinst System.Delegate
IL_029a: stloc.s V_6
IL_029c: ldloc.s V_6
IL_029e: brfalse.s IL_02eb
IL_02a0: ldloc.s V_6
IL_02a2: callvirt System.Delegate[] System.Delegate::GetInvocationList()
IL_02a7: ldlen
IL_02a8: conv.i4
IL_02a9: ldc.i4.1
IL_02aa: bne.un.s IL_02eb
IL_02ac: ldloc.s V_6
IL_02ae: callvirt System.Object System.Delegate::get_Target()
IL_02b3: ldloc.2
IL_02b4: bne.un.s IL_02eb
IL_02b6: ldloc.s V_6
IL_02b8: callvirt System.Reflection.MethodInfo System.Delegate::get_Method()
IL_02bd: callvirt System.String System.Reflection.MemberInfo::get_Name()
IL_02c2: ldstr "OnClick"
IL_02c7: call System.Boolean System.String::op_Inequality(System.String,System.String)
IL_02cc: brtrue.s IL_02eb
IL_02ce: ldloc.s V_6
IL_02d0: callvirt System.Reflection.MethodInfo System.Delegate::get_Method()
IL_02d5: callvirt System.Type System.Reflection.MemberInfo::get_DeclaringType()
IL_02da: ldtoken PixelCrushers.DialogueSystem.StandardUIResponseButton
IL_02df: call System.Type System.Type::GetTypeFromHandle(System.RuntimeTypeHandle)
IL_02e4: call System.Boolean System.Type::op_Inequality(System.Type,System.Type)
IL_02e9: br.s IL_02ec
IL_02eb: ldc.i4.1
IL_02ec: stloc.s V_17
IL_02ee: ldloc.s V_17
IL_02f0: brfalse.s IL_02fd
IL_02f2: ldstr "Tutorial181 runtime listener target differs"
IL_02f7: newobj System.Void System.Exception::.ctor(System.String)
IL_02fc: throw
IL_02fd: ldarg.1
IL_02fe: ldloc.2
IL_02ff: ldfld UnityEngine.UI.Button PixelCrushers.DialogueSystem.StandardUIResponseButton::button
IL_0304: stind.ref
IL_0305: newobj System.Void ForestProbe/Tutorial181Selection::.ctor()
IL_030a: dup
IL_030b: ldstr "original"
IL_0310: stfld System.String ForestProbe/Tutorial181Selection::choiceMode
IL_0315: dup
IL_0316: call System.Int32 UnityEngine.Time::get_frameCount()
IL_031b: stfld System.Int32 ForestProbe/Tutorial181Selection::frame
IL_0320: dup
IL_0321: ldc.i4.s 120
IL_0323: stfld System.Int32 ForestProbe/Tutorial181Selection::conversationId
IL_0328: dup
IL_0329: ldc.i4 158
IL_032e: stfld System.Int32 ForestProbe/Tutorial181Selection::sourceId
IL_0333: dup
IL_0334: ldc.i4 181
IL_0339: stfld System.Int32 ForestProbe/Tutorial181Selection::destinationId
IL_033e: dup
IL_033f: ldc.i4 182
IL_0344: stfld System.Int32 ForestProbe/Tutorial181Selection::successorId
IL_0349: dup
IL_034a: ldstr "The love. Definitely the love."
IL_034f: stfld System.String ForestProbe/Tutorial181Selection::text
IL_0354: dup
IL_0355: ldloc.3
IL_0356: stfld System.String ForestProbe/Tutorial181Selection::path
IL_035b: dup
IL_035c: ldstr "Singletons/GlobalSingletonsFirstpass(Clone)/DialogueManager/OverworldDialogueCanvas/VN Template Standard Dialogue UI"
IL_0361: stfld System.String ForestProbe/Tutorial181Selection::targetPath
IL_0366: dup
IL_0367: ldstr "OnClick"
IL_036c: stfld System.String ForestProbe/Tutorial181Selection::listenerMethod
IL_0371: dup
IL_0372: ldloc.3
IL_0373: stfld System.String ForestProbe/Tutorial181Selection::listenerTargetPath
IL_0378: dup
IL_0379: ldarg.1
IL_037a: ldind.ref
IL_037b: callvirt System.Int32 UnityEngine.Object::GetInstanceID()
IL_0380: stfld System.Int32 ForestProbe/Tutorial181Selection::buttonInstance
IL_0385: dup
IL_0386: ldloc.2
IL_0387: callvirt System.Int32 UnityEngine.Object::GetInstanceID()
IL_038c: stfld System.Int32 ForestProbe/Tutorial181Selection::controllerInstance
IL_0391: dup
IL_0392: ldc.i4.0
IL_0393: stfld System.Boolean ForestProbe/Tutorial181Selection::typing
IL_0398: dup
IL_0399: ldc.i4.1
IL_039a: stfld System.Boolean ForestProbe/Tutorial181Selection::graphVerified
IL_039f: dup
IL_03a0: ldc.i4.1
IL_03a1: stfld System.Boolean ForestProbe/Tutorial181Selection::listenerVerified
IL_03a6: stloc.s V_18
IL_03a8: br.s IL_03aa
IL_03aa: ldloc.s V_18
IL_03ac: ret
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
IL_0001: newobj System.Void ForestProbe/State::.ctor()
IL_0006: stloc.1
IL_0007: ldloc.1
IL_0008: call UnityEngine.SceneManagement.Scene UnityEngine.SceneManagement.SceneManager::GetActiveScene()
IL_000d: stloc.2
IL_000e: ldloca.s V_2
IL_0010: call System.String UnityEngine.SceneManagement.Scene::get_name()
IL_0015: stfld System.String ForestProbe/State::scene
IL_001a: ldloc.1
IL_001b: call System.String UnityEngine.Application::get_dataPath()
IL_0020: stfld System.String ForestProbe/State::dataPath
IL_0025: ldloc.1
IL_0026: call System.String UnityEngine.Application::get_persistentDataPath()
IL_002b: stfld System.String ForestProbe/State::persistentDataPath
IL_0030: ldloc.1
IL_0031: call System.String UnityEngine.Application::get_companyName()
IL_0036: stfld System.String ForestProbe/State::company
IL_003b: ldloc.1
IL_003c: call System.String UnityEngine.Application::get_productName()
IL_0041: stfld System.String ForestProbe/State::product
IL_0046: ldloc.1
IL_0047: call System.Int32 UnityEngine.Time::get_frameCount()
IL_004c: stfld System.Int32 ForestProbe/State::frame
IL_0051: ldloc.1
IL_0052: call System.Single UnityEngine.Time::get_realtimeSinceStartup()
IL_0057: stfld System.Single ForestProbe/State::realtime
IL_005c: ldloc.1
IL_005d: call System.Single UnityEngine.Time::get_time()
IL_0062: stfld System.Single ForestProbe/State::scaledTime
IL_0067: ldloc.1
IL_0068: call System.Single UnityEngine.Time::get_timeScale()
IL_006d: stfld System.Single ForestProbe/State::timeScale
IL_0072: ldloc.1
IL_0073: ldc.i4.0
IL_0074: newarr System.String
IL_0079: stfld System.String[] ForestProbe/State::responseRecords
IL_007e: ldloc.1
IL_007f: ldc.i4.0
IL_0080: newarr System.String
IL_0085: stfld System.String[] ForestProbe/State::introDiagnostics
IL_008a: ldloc.1
IL_008b: stloc.0
IL_008c: ldloc.0
IL_008d: ldarg.0
IL_008e: ldloc.0
IL_008f: ldflda System.Boolean ForestProbe/State::dataServicePresent
IL_0094: ldloc.0
IL_0095: ldflda System.Boolean ForestProbe/State::manifestPresent
IL_009a: ldloc.0
IL_009b: ldflda System.Int32 ForestProbe/State::dataServiceInstance
IL_00a0: call System.String[] ForestProbe::ContinuationReadiness(System.Boolean&,System.Boolean&,System.Int32&)
IL_00a5: stfld System.String[] ForestProbe/State::notReady
IL_00aa: ldloc.0
IL_00ab: ldloc.0
IL_00ac: ldfld System.String[] ForestProbe/State::notReady
IL_00b1: ldlen
IL_00b2: ldc.i4.0
IL_00b3: ceq
IL_00b5: stfld System.Boolean ForestProbe/State::diagnosticsReady
IL_00ba: ldloc.0
IL_00bb: ldfld System.Boolean ForestProbe/State::diagnosticsReady
IL_00c0: stloc.3
IL_00c1: ldloc.3
IL_00c2: brfalse IL_01d9
IL_00c7: nop
IL_00c8: ldarg.0
IL_00c9: call System.Collections.Generic.List`1<ForestProbe/ResponseRow> ForestProbe::ReadResponses()
IL_00ce: stloc.s V_4
IL_00d0: newobj System.Void System.Collections.Generic.List`1<System.String>::.ctor()
IL_00d5: stloc.s V_5
IL_00d7: ldloc.s V_5
IL_00d9: ldc.i4.8
IL_00da: newarr System.String
IL_00df: dup
IL_00e0: ldc.i4.0
IL_00e1: ldstr "guards | gameplay="
IL_00e6: stelem.ref
IL_00e7: dup
IL_00e8: ldc.i4.1
IL_00e9: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inGameplayScene()
IL_00ee: stloc.s V_6
IL_00f0: ldloca.s V_6
IL_00f2: call System.String System.Boolean::ToString()
IL_00f7: stelem.ref
IL_00f8: dup
IL_00f9: ldc.i4.2
IL_00fa: ldstr " | dustin="
IL_00ff: stelem.ref
IL_0100: dup
IL_0101: ldc.i4.3
IL_0102: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inDustinMinigame()
IL_0107: stloc.s V_6
IL_0109: ldloca.s V_6
IL_010b: call System.String System.Boolean::ToString()
IL_0110: stelem.ref
IL_0111: dup
IL_0112: ldc.i4.4
IL_0113: ldstr " | glitch="
IL_0118: stelem.ref
IL_0119: dup
IL_011a: ldc.i4.5
IL_011b: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inGlitchRoom()
IL_0120: stloc.s V_6
IL_0122: ldloca.s V_6
IL_0124: call System.String System.Boolean::ToString()
IL_0129: stelem.ref
IL_012a: dup
IL_012b: ldc.i4.6
IL_012c: ldstr " | anyEvent="
IL_0131: stelem.ref
IL_0132: dup
IL_0133: ldc.i4.7
IL_0134: call System.Boolean TheForestOfLove.Events.GameStateManager::get_isAnyEventActive()
IL_0139: stloc.s V_6
IL_013b: ldloca.s V_6
IL_013d: call System.String System.Boolean::ToString()
IL_0142: stelem.ref
IL_0143: call System.String System.String::Concat(System.String[])
IL_0148: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_014d: nop
IL_014e: ldloc.s V_5
IL_0150: ldarg.0
IL_0151: call System.String[] ForestProbe::IntroCleanupDiagnostics()
IL_0156: callvirt System.Void System.Collections.Generic.List`1<System.String>::AddRange(System.Collections.Generic.IEnumerable`1<!0>)
IL_015b: nop
IL_015c: ldloc.0
IL_015d: call System.String TheForestOfLove.Narrative.DialogueService::get_CurrentDialogueDbName()
IL_0162: stfld System.String ForestProbe/State::narrativeDbName
IL_0167: ldloc.0
IL_0168: call System.String TheForestOfLove.Narrative.DialogueService::get_CurrentArcName()
IL_016d: stfld System.String ForestProbe/State::narrativeArcName
IL_0172: ldloc.0
IL_0173: ldloc.s V_4
IL_0175: callvirt System.Int32 System.Collections.Generic.List`1<ForestProbe/ResponseRow>::get_Count()
IL_017a: stfld System.Int32 ForestProbe/State::responseCount
IL_017f: ldloc.0
IL_0180: ldloc.s V_4
IL_0182: ldsfld System.Converter`2<ForestProbe/ResponseRow,System.String> ForestProbe/<>c::<>9__63_0
IL_0187: dup
IL_0188: brtrue.s IL_01a1
IL_018a: pop
IL_018b: ldsfld ForestProbe/<>c ForestProbe/<>c::<>9
IL_0190: ldftn System.String ForestProbe/<>c::<DumpIntro>b__63_0(ForestProbe/ResponseRow)
IL_0196: newobj System.Void System.Converter`2<ForestProbe/ResponseRow,System.String>::.ctor(System.Object,System.IntPtr)
IL_019b: dup
IL_019c: stsfld System.Converter`2<ForestProbe/ResponseRow,System.String> ForestProbe/<>c::<>9__63_0
IL_01a1: callvirt System.Collections.Generic.List`1<!!0> System.Collections.Generic.List`1<ForestProbe/ResponseRow>::ConvertAll<System.String>(System.Converter`2<!0,!!0>)
IL_01a6: callvirt !0[] System.Collections.Generic.List`1<System.String>::ToArray()
IL_01ab: stfld System.String[] ForestProbe/State::responseRecords
IL_01b0: ldloc.0
IL_01b1: call System.Boolean TheForestOfLove.CustomTypewriterEffectTextMeshPro::IsTyping()
IL_01b6: stfld System.Boolean ForestProbe/State::typing
IL_01bb: ldloc.0
IL_01bc: ldloc.s V_5
IL_01be: callvirt !0[] System.Collections.Generic.List`1<System.String>::ToArray()
IL_01c3: stfld System.String[] ForestProbe/State::introDiagnostics
IL_01c8: ldarg.0
IL_01c9: ldloc.0
IL_01ca: call System.Void ForestProbe::ReadConversation(ForestProbe/State)
IL_01cf: nop
IL_01d0: ldarg.0
IL_01d1: ldloc.0
IL_01d2: call System.Void ForestProbe::ReadTutorialCompletionRecord(ForestProbe/State)
IL_01d7: nop
IL_01d8: nop
IL_01d9: ldarg.0
IL_01da: ldfld System.String ForestProbe::root
IL_01df: ldstr "intro-state.json"
IL_01e4: call System.String System.IO.Path::Combine(System.String,System.String)
IL_01e9: ldloc.0
IL_01ea: ldc.i4.1
IL_01eb: call System.String UnityEngine.JsonUtility::ToJson(System.Object,System.Boolean)
IL_01f0: call System.Void System.IO.File::WriteAllText(System.String,System.String)
IL_01f5: nop
IL_01f6: ret
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
IL_0779: br IL_0a57
IL_077e: ldloc.s V_49
IL_0780: ldloc.s V_50
IL_0782: ldelem.ref
IL_0783: stloc.s V_51
IL_0785: ldloc.s V_51
IL_0787: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_078c: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_0791: stloc.s V_52
IL_0793: ldloc.s V_52
IL_0795: brfalse IL_0a51
IL_079a: ldloc.s V_5
IL_079c: ldc.i4.s 27
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
IL_08f6: dup
IL_08f7: ldc.i4.s 15
IL_08f9: ldstr " | hasYo="
IL_08fe: stelem.ref
IL_08ff: dup
IL_0900: ldc.i4.s 16
IL_0902: ldloc.s V_51
IL_0904: callvirt UnityEngine.Font UnityEngine.UI.Text::get_font()
IL_0909: ldnull
IL_090a: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_090f: brfalse.s IL_0924
IL_0911: ldloc.s V_51
IL_0913: callvirt UnityEngine.Font UnityEngine.UI.Text::get_font()
IL_0918: ldc.i4 1025
IL_091d: callvirt System.Boolean UnityEngine.Font::HasCharacter(System.Char)
IL_0922: br.s IL_0925
IL_0924: ldc.i4.0
IL_0925: stloc.s V_29
IL_0927: ldloca.s V_29
IL_0929: call System.String System.Boolean::ToString()
IL_092e: stelem.ref
IL_092f: dup
IL_0930: ldc.i4.s 17
IL_0932: ldstr " | hasShortI="
IL_0937: stelem.ref
IL_0938: dup
IL_0939: ldc.i4.s 18
IL_093b: ldloc.s V_51
IL_093d: callvirt UnityEngine.Font UnityEngine.UI.Text::get_font()
IL_0942: ldnull
IL_0943: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0948: brfalse.s IL_095d
IL_094a: ldloc.s V_51
IL_094c: callvirt UnityEngine.Font UnityEngine.UI.Text::get_font()
IL_0951: ldc.i4 1049
IL_0956: callvirt System.Boolean UnityEngine.Font::HasCharacter(System.Char)
IL_095b: br.s IL_095e
IL_095d: ldc.i4.0
IL_095e: stloc.s V_29
IL_0960: ldloca.s V_29
IL_0962: call System.String System.Boolean::ToString()
IL_0967: stelem.ref
IL_0968: dup
IL_0969: ldc.i4.s 19
IL_096b: ldstr " | hasDigit1="
IL_0970: stelem.ref
IL_0971: dup
IL_0972: ldc.i4.s 20
IL_0974: ldloc.s V_51
IL_0976: callvirt UnityEngine.Font UnityEngine.UI.Text::get_font()
IL_097b: ldnull
IL_097c: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0981: brfalse.s IL_0993
IL_0983: ldloc.s V_51
IL_0985: callvirt UnityEngine.Font UnityEngine.UI.Text::get_font()
IL_098a: ldc.i4.s 49
IL_098c: callvirt System.Boolean UnityEngine.Font::HasCharacter(System.Char)
IL_0991: br.s IL_0994
IL_0993: ldc.i4.0
IL_0994: stloc.s V_29
IL_0996: ldloca.s V_29
IL_0998: call System.String System.Boolean::ToString()
IL_099d: stelem.ref
IL_099e: dup
IL_099f: ldc.i4.s 21
IL_09a1: ldstr " | hasSpace="
IL_09a6: stelem.ref
IL_09a7: dup
IL_09a8: ldc.i4.s 22
IL_09aa: ldloc.s V_51
IL_09ac: callvirt UnityEngine.Font UnityEngine.UI.Text::get_font()
IL_09b1: ldnull
IL_09b2: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_09b7: brfalse.s IL_09c9
IL_09b9: ldloc.s V_51
IL_09bb: callvirt UnityEngine.Font UnityEngine.UI.Text::get_font()
IL_09c0: ldc.i4.s 32
IL_09c2: callvirt System.Boolean UnityEngine.Font::HasCharacter(System.Char)
IL_09c7: br.s IL_09ca
IL_09c9: ldc.i4.0
IL_09ca: stloc.s V_29
IL_09cc: ldloca.s V_29
IL_09ce: call System.String System.Boolean::ToString()
IL_09d3: stelem.ref
IL_09d4: dup
IL_09d5: ldc.i4.s 23
IL_09d7: ldstr " | hasDiaeresis="
IL_09dc: stelem.ref
IL_09dd: dup
IL_09de: ldc.i4.s 24
IL_09e0: ldloc.s V_51
IL_09e2: callvirt UnityEngine.Font UnityEngine.UI.Text::get_font()
IL_09e7: ldnull
IL_09e8: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_09ed: brfalse.s IL_0a02
IL_09ef: ldloc.s V_51
IL_09f1: callvirt UnityEngine.Font UnityEngine.UI.Text::get_font()
IL_09f6: ldc.i4 776
IL_09fb: callvirt System.Boolean UnityEngine.Font::HasCharacter(System.Char)
IL_0a00: br.s IL_0a03
IL_0a02: ldc.i4.0
IL_0a03: stloc.s V_29
IL_0a05: ldloca.s V_29
IL_0a07: call System.String System.Boolean::ToString()
IL_0a0c: stelem.ref
IL_0a0d: dup
IL_0a0e: ldc.i4.s 25
IL_0a10: ldstr " | hasBreve="
IL_0a15: stelem.ref
IL_0a16: dup
IL_0a17: ldc.i4.s 26
IL_0a19: ldloc.s V_51
IL_0a1b: callvirt UnityEngine.Font UnityEngine.UI.Text::get_font()
IL_0a20: ldnull
IL_0a21: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0a26: brfalse.s IL_0a3b
IL_0a28: ldloc.s V_51
IL_0a2a: callvirt UnityEngine.Font UnityEngine.UI.Text::get_font()
IL_0a2f: ldc.i4 774
IL_0a34: callvirt System.Boolean UnityEngine.Font::HasCharacter(System.Char)
IL_0a39: br.s IL_0a3c
IL_0a3b: ldc.i4.0
IL_0a3c: stloc.s V_29
IL_0a3e: ldloca.s V_29
IL_0a40: call System.String System.Boolean::ToString()
IL_0a45: stelem.ref
IL_0a46: call System.String System.String::Concat(System.String[])
IL_0a4b: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0a50: nop
IL_0a51: ldloc.s V_50
IL_0a53: ldc.i4.1
IL_0a54: add
IL_0a55: stloc.s V_50
IL_0a57: ldloc.s V_50
IL_0a59: ldloc.s V_49
IL_0a5b: ldlen
IL_0a5c: conv.i4
IL_0a5d: blt IL_077e
IL_0a62: nop
IL_0a63: call !!0[] UnityEngine.Resources::FindObjectsOfTypeAll<UnityEngine.UI.Button>()
IL_0a68: stloc.s V_55
IL_0a6a: ldc.i4.0
IL_0a6b: stloc.s V_56
IL_0a6d: br.s IL_0ac4
IL_0a6f: ldloc.s V_55
IL_0a71: ldloc.s V_56
IL_0a73: ldelem.ref
IL_0a74: stloc.s V_57
IL_0a76: ldloc.s V_57
IL_0a78: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0a7d: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_0a82: brfalse.s IL_0aa4
IL_0a84: ldloc.s V_57
IL_0a86: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0a8b: callvirt UnityEngine.SceneManagement.Scene UnityEngine.GameObject::get_scene()
IL_0a90: stloc.s V_27
IL_0a92: ldloca.s V_27
IL_0a94: call System.Boolean UnityEngine.SceneManagement.Scene::IsValid()
IL_0a99: brfalse.s IL_0aa4
IL_0a9b: ldloc.s V_57
IL_0a9d: callvirt System.Boolean UnityEngine.UI.Selectable::get_interactable()
IL_0aa2: br.s IL_0aa5
IL_0aa4: ldc.i4.0
IL_0aa5: stloc.s V_58
IL_0aa7: ldloc.s V_58
IL_0aa9: brfalse.s IL_0abe
IL_0aab: ldloc.1
IL_0aac: ldloc.s V_57
IL_0aae: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0ab3: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_0ab8: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0abd: nop
IL_0abe: ldloc.s V_56
IL_0ac0: ldc.i4.1
IL_0ac1: add
IL_0ac2: stloc.s V_56
IL_0ac4: ldloc.s V_56
IL_0ac6: ldloc.s V_55
IL_0ac8: ldlen
IL_0ac9: conv.i4
IL_0aca: blt.s IL_0a6f
IL_0acc: nop
IL_0acd: call !!0[] UnityEngine.Resources::FindObjectsOfTypeAll<UnityEngine.MonoBehaviour>()
IL_0ad2: stloc.s V_59
IL_0ad4: ldc.i4.0
IL_0ad5: stloc.s V_60
IL_0ad7: br IL_0b60
IL_0adc: ldloc.s V_59
IL_0ade: ldloc.s V_60
IL_0ae0: ldelem.ref
IL_0ae1: stloc.s V_61
IL_0ae3: ldloc.s V_61
IL_0ae5: ldnull
IL_0ae6: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0aeb: brfalse.s IL_0b2a
IL_0aed: ldloc.s V_61
IL_0aef: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0af4: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_0af9: brfalse.s IL_0b2a
IL_0afb: ldloc.s V_61
IL_0afd: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0b02: callvirt UnityEngine.SceneManagement.Scene UnityEngine.GameObject::get_scene()
IL_0b07: stloc.s V_27
IL_0b09: ldloca.s V_27
IL_0b0b: call System.Boolean UnityEngine.SceneManagement.Scene::IsValid()
IL_0b10: brfalse.s IL_0b2a
IL_0b12: ldloc.s V_61
IL_0b14: callvirt System.Type System.Object::GetType()
IL_0b19: callvirt System.String System.Type::get_Namespace()
IL_0b1e: ldstr "TheForestOfLove"
IL_0b23: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0b28: br.s IL_0b2b
IL_0b2a: ldc.i4.0
IL_0b2b: stloc.s V_62
IL_0b2d: ldloc.s V_62
IL_0b2f: brfalse.s IL_0b5a
IL_0b31: ldloc.2
IL_0b32: ldloc.s V_61
IL_0b34: callvirt System.Type System.Object::GetType()
IL_0b39: callvirt System.String System.Reflection.MemberInfo::get_Name()
IL_0b3e: ldstr " "
IL_0b43: ldloc.s V_61
IL_0b45: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0b4a: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_0b4f: call System.String System.String::Concat(System.String,System.String,System.String)
IL_0b54: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0b59: nop
IL_0b5a: ldloc.s V_60
IL_0b5c: ldc.i4.1
IL_0b5d: add
IL_0b5e: stloc.s V_60
IL_0b60: ldloc.s V_60
IL_0b62: ldloc.s V_59
IL_0b64: ldlen
IL_0b65: conv.i4
IL_0b66: blt IL_0adc
IL_0b6b: nop
IL_0b6c: call !!0[] UnityEngine.Resources::FindObjectsOfTypeAll<UnityEngine.UI.Image>()
IL_0b71: stloc.s V_63
IL_0b73: ldc.i4.0
IL_0b74: stloc.s V_64
IL_0b76: br IL_0d76
IL_0b7b: ldloc.s V_63
IL_0b7d: ldloc.s V_64
IL_0b7f: ldelem.ref
IL_0b80: stloc.s V_65
IL_0b82: ldloc.s V_65
IL_0b84: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0b89: callvirt UnityEngine.SceneManagement.Scene UnityEngine.GameObject::get_scene()
IL_0b8e: stloc.s V_27
IL_0b90: ldloca.s V_27
IL_0b92: call System.Boolean UnityEngine.SceneManagement.Scene::IsValid()
IL_0b97: brfalse.s IL_0bb1
IL_0b99: ldloc.s V_65
IL_0b9b: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0ba0: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_0ba5: ldstr "Canvas/OptionsMenu/"
IL_0baa: callvirt System.Boolean System.String::StartsWith(System.String)
IL_0baf: br.s IL_0bb2
IL_0bb1: ldc.i4.0
IL_0bb2: stloc.s V_66
IL_0bb4: ldloc.s V_66
IL_0bb6: brfalse IL_0d70
IL_0bbb: nop
IL_0bbc: ldc.i4.4
IL_0bbd: newarr UnityEngine.Vector3
IL_0bc2: stloc.s V_67
IL_0bc4: ldloc.s V_65
IL_0bc6: callvirt UnityEngine.RectTransform UnityEngine.UI.Graphic::get_rectTransform()
IL_0bcb: ldloc.s V_67
IL_0bcd: callvirt System.Void UnityEngine.RectTransform::GetWorldCorners(UnityEngine.Vector3[])
IL_0bd2: nop
IL_0bd3: ldloc.s V_9
IL_0bd5: ldc.i4.s 23
IL_0bd7: newarr System.String
IL_0bdc: dup
IL_0bdd: ldc.i4.0
IL_0bde: ldloc.s V_65
IL_0be0: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0be5: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_0bea: stelem.ref
IL_0beb: dup
IL_0bec: ldc.i4.1
IL_0bed: ldstr " | activeSelf="
IL_0bf2: stelem.ref
IL_0bf3: dup
IL_0bf4: ldc.i4.2
IL_0bf5: ldloc.s V_65
IL_0bf7: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0bfc: callvirt System.Boolean UnityEngine.GameObject::get_activeSelf()
IL_0c01: stloc.s V_29
IL_0c03: ldloca.s V_29
IL_0c05: call System.String System.Boolean::ToString()
IL_0c0a: stelem.ref
IL_0c0b: dup
IL_0c0c: ldc.i4.3
IL_0c0d: ldstr " | activeInHierarchy="
IL_0c12: stelem.ref
IL_0c13: dup
IL_0c14: ldc.i4.4
IL_0c15: ldloc.s V_65
IL_0c17: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0c1c: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_0c21: stloc.s V_29
IL_0c23: ldloca.s V_29
IL_0c25: call System.String System.Boolean::ToString()
IL_0c2a: stelem.ref
IL_0c2b: dup
IL_0c2c: ldc.i4.5
IL_0c2d: ldstr " | sprite="
IL_0c32: stelem.ref
IL_0c33: dup
IL_0c34: ldc.i4.6
IL_0c35: ldloc.s V_65
IL_0c37: callvirt UnityEngine.Sprite UnityEngine.UI.Image::get_sprite()
IL_0c3c: ldnull
IL_0c3d: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0c42: brtrue.s IL_0c52
IL_0c44: ldloc.s V_65
IL_0c46: callvirt UnityEngine.Sprite UnityEngine.UI.Image::get_sprite()
IL_0c4b: callvirt System.String UnityEngine.Object::get_name()
IL_0c50: br.s IL_0c57
IL_0c52: ldstr "null"
IL_0c57: stelem.ref
IL_0c58: dup
IL_0c59: ldc.i4.7
IL_0c5a: ldstr " | enabled="
IL_0c5f: stelem.ref
IL_0c60: dup
IL_0c61: ldc.i4.8
IL_0c62: ldloc.s V_65
IL_0c64: callvirt System.Boolean UnityEngine.Behaviour::get_enabled()
IL_0c69: stloc.s V_29
IL_0c6b: ldloca.s V_29
IL_0c6d: call System.String System.Boolean::ToString()
IL_0c72: stelem.ref
IL_0c73: dup
IL_0c74: ldc.i4.s 9
IL_0c76: ldstr " | instance="
IL_0c7b: stelem.ref
IL_0c7c: dup
IL_0c7d: ldc.i4.s 10
IL_0c7f: ldloc.s V_65
IL_0c81: callvirt System.Int32 UnityEngine.Object::GetInstanceID()
IL_0c86: stloc.s V_53
IL_0c88: ldloca.s V_53
IL_0c8a: call System.String System.Int32::ToString()
IL_0c8f: stelem.ref
IL_0c90: dup
IL_0c91: ldc.i4.s 11
IL_0c93: ldstr " | color="
IL_0c98: stelem.ref
IL_0c99: dup
IL_0c9a: ldc.i4.s 12
IL_0c9c: ldloc.s V_65
IL_0c9e: callvirt UnityEngine.Color UnityEngine.UI.Graphic::get_color()
IL_0ca3: stloc.s V_68
IL_0ca5: ldloca.s V_68
IL_0ca7: constrained. UnityEngine.Color
IL_0cad: callvirt System.String System.Object::ToString()
IL_0cb2: stelem.ref
IL_0cb3: dup
IL_0cb4: ldc.i4.s 13
IL_0cb6: ldstr " | canvasAlpha="
IL_0cbb: stelem.ref
IL_0cbc: dup
IL_0cbd: ldc.i4.s 14
IL_0cbf: ldloc.s V_65
IL_0cc1: callvirt UnityEngine.CanvasRenderer UnityEngine.UI.Graphic::get_canvasRenderer()
IL_0cc6: callvirt System.Single UnityEngine.CanvasRenderer::GetAlpha()
IL_0ccb: stloc.s V_28
IL_0ccd: ldloca.s V_28
IL_0ccf: call System.String System.Single::ToString()
IL_0cd4: stelem.ref
IL_0cd5: dup
IL_0cd6: ldc.i4.s 15
IL_0cd8: ldstr " | culled="
IL_0cdd: stelem.ref
IL_0cde: dup
IL_0cdf: ldc.i4.s 16
IL_0ce1: ldloc.s V_65
IL_0ce3: callvirt UnityEngine.CanvasRenderer UnityEngine.UI.Graphic::get_canvasRenderer()
IL_0ce8: callvirt System.Boolean UnityEngine.CanvasRenderer::get_cull()
IL_0ced: stloc.s V_29
IL_0cef: ldloca.s V_29
IL_0cf1: call System.String System.Boolean::ToString()
IL_0cf6: stelem.ref
IL_0cf7: dup
IL_0cf8: ldc.i4.s 17
IL_0cfa: ldstr " | material="
IL_0cff: stelem.ref
IL_0d00: dup
IL_0d01: ldc.i4.s 18
IL_0d03: ldloc.s V_65
IL_0d05: callvirt UnityEngine.Material UnityEngine.UI.Graphic::get_materialForRendering()
IL_0d0a: ldnull
IL_0d0b: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0d10: brtrue.s IL_0d20
IL_0d12: ldloc.s V_65
IL_0d14: callvirt UnityEngine.Material UnityEngine.UI.Graphic::get_materialForRendering()
IL_0d19: callvirt System.String UnityEngine.Object::get_name()
IL_0d1e: br.s IL_0d25
IL_0d20: ldstr "null"
IL_0d25: stelem.ref
IL_0d26: dup
IL_0d27: ldc.i4.s 19
IL_0d29: ldstr " | worldBottomLeft="
IL_0d2e: stelem.ref
IL_0d2f: dup
IL_0d30: ldc.i4.s 20
IL_0d32: ldloc.s V_67
IL_0d34: ldc.i4.0
IL_0d35: ldelema UnityEngine.Vector3
IL_0d3a: ldstr "R"
IL_0d3f: call System.String UnityEngine.Vector3::ToString(System.String)
IL_0d44: stelem.ref
IL_0d45: dup
IL_0d46: ldc.i4.s 21
IL_0d48: ldstr " | worldTopRight="
IL_0d4d: stelem.ref
IL_0d4e: dup
IL_0d4f: ldc.i4.s 22
IL_0d51: ldloc.s V_67
IL_0d53: ldc.i4.2
IL_0d54: ldelema UnityEngine.Vector3
IL_0d59: ldstr "R"
IL_0d5e: call System.String UnityEngine.Vector3::ToString(System.String)
IL_0d63: stelem.ref
IL_0d64: call System.String System.String::Concat(System.String[])
IL_0d69: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0d6e: nop
IL_0d6f: nop
IL_0d70: ldloc.s V_64
IL_0d72: ldc.i4.1
IL_0d73: add
IL_0d74: stloc.s V_64
IL_0d76: ldloc.s V_64
IL_0d78: ldloc.s V_63
IL_0d7a: ldlen
IL_0d7b: conv.i4
IL_0d7c: blt IL_0b7b
IL_0d81: newobj System.Void ForestProbe/State::.ctor()
IL_0d86: dup
IL_0d87: call UnityEngine.SceneManagement.Scene UnityEngine.SceneManagement.SceneManager::GetActiveScene()
IL_0d8c: stloc.s V_27
IL_0d8e: ldloca.s V_27
IL_0d90: call System.String UnityEngine.SceneManagement.Scene::get_name()
IL_0d95: stfld System.String ForestProbe/State::scene
IL_0d9a: dup
IL_0d9b: call System.Int32 UnityEngine.Time::get_frameCount()
IL_0da0: stfld System.Int32 ForestProbe/State::frame
IL_0da5: dup
IL_0da6: call System.Single UnityEngine.Time::get_realtimeSinceStartup()
IL_0dab: stfld System.Single ForestProbe/State::realtime
IL_0db0: dup
IL_0db1: call System.Single UnityEngine.Time::get_time()
IL_0db6: stfld System.Single ForestProbe/State::scaledTime
IL_0dbb: dup
IL_0dbc: call System.Single UnityEngine.Time::get_timeScale()
IL_0dc1: stfld System.Single ForestProbe/State::timeScale
IL_0dc6: dup
IL_0dc7: call System.String TheForestOfLove.Narrative.DialogueService::get_CurrentDialogueDbName()
IL_0dcc: stfld System.String ForestProbe/State::narrativeDbName
IL_0dd1: dup
IL_0dd2: call System.String TheForestOfLove.Narrative.DialogueService::get_CurrentArcName()
IL_0dd7: stfld System.String ForestProbe/State::narrativeArcName
IL_0ddc: dup
IL_0ddd: call System.String UnityEngine.Application::get_dataPath()
IL_0de2: stfld System.String ForestProbe/State::dataPath
IL_0de7: dup
IL_0de8: call System.String UnityEngine.Application::get_persistentDataPath()
IL_0ded: stfld System.String ForestProbe/State::persistentDataPath
IL_0df2: dup
IL_0df3: call System.String UnityEngine.Application::get_companyName()
IL_0df8: stfld System.String ForestProbe/State::company
IL_0dfd: dup
IL_0dfe: call System.String UnityEngine.Application::get_productName()
IL_0e03: stfld System.String ForestProbe/State::product
IL_0e08: dup
IL_0e09: call System.Int32 UnityEngine.Screen::get_width()
IL_0e0e: stfld System.Int32 ForestProbe/State::width
IL_0e13: dup
IL_0e14: call System.Int32 UnityEngine.Screen::get_height()
IL_0e19: stfld System.Int32 ForestProbe/State::height
IL_0e1e: dup
IL_0e1f: ldloc.0
IL_0e20: callvirt !0[] System.Collections.Generic.List`1<ForestProbe/TextRow>::ToArray()
IL_0e25: stfld ForestProbe/TextRow[] ForestProbe/State::texts
IL_0e2a: dup
IL_0e2b: ldloc.1
IL_0e2c: callvirt !0[] System.Collections.Generic.List`1<System.String>::ToArray()
IL_0e31: stfld System.String[] ForestProbe/State::buttons
IL_0e36: dup
IL_0e37: ldloc.2
IL_0e38: callvirt !0[] System.Collections.Generic.List`1<System.String>::ToArray()
IL_0e3d: stfld System.String[] ForestProbe/State::components
IL_0e42: dup
IL_0e43: ldloc.s V_4
IL_0e45: ldlen
IL_0e46: conv.i4
IL_0e47: stfld System.Int32 ForestProbe/State::tmpObjectCount
IL_0e4c: dup
IL_0e4d: ldloc.s V_5
IL_0e4f: callvirt !0[] System.Collections.Generic.List`1<System.String>::ToArray()
IL_0e54: stfld System.String[] ForestProbe/State::rendererDiagnostics
IL_0e59: dup
IL_0e5a: ldloc.s V_6
IL_0e5c: callvirt !0[] System.Collections.Generic.List`1<System.String>::ToArray()
IL_0e61: stfld System.String[] ForestProbe/State::subtitleGlyphDiagnostics
IL_0e66: dup
IL_0e67: ldloc.s V_7
IL_0e69: callvirt !0[] System.Collections.Generic.List`1<System.String>::ToArray()
IL_0e6e: stfld System.String[] ForestProbe/State::settingsGlyphDiagnostics
IL_0e73: dup
IL_0e74: ldloc.s V_8
IL_0e76: callvirt !0[] System.Collections.Generic.List`1<System.String>::ToArray()
IL_0e7b: stfld System.String[] ForestProbe/State::settingsLayoutDiagnostics
IL_0e80: dup
IL_0e81: ldloc.s V_9
IL_0e83: callvirt !0[] System.Collections.Generic.List`1<System.String>::ToArray()
IL_0e88: stfld System.String[] ForestProbe/State::settingsControlDiagnostics
IL_0e8d: dup
IL_0e8e: call System.Boolean TheForestOfLove.UI.WindowController::get_IsFullscreen()
IL_0e93: stfld System.Boolean ForestProbe/State::fullscreen
IL_0e98: dup
IL_0e99: call System.Boolean TheForestOfLove.UI.WindowController::get_EnableFullscreenStretch()
IL_0e9e: stfld System.Boolean ForestProbe/State::stretch
IL_0ea3: dup
IL_0ea4: call System.Int32 TheForestOfLove.UI.WindowController::get_WindowScalingIndex()
IL_0ea9: stfld System.Int32 ForestProbe/State::scaleIndex
IL_0eae: dup
IL_0eaf: call UnityEngine.Resolution UnityEngine.Screen::get_currentResolution()
IL_0eb4: stloc.s V_69
IL_0eb6: ldloca.s V_69
IL_0eb8: call System.Int32 UnityEngine.Resolution::get_width()
IL_0ebd: stfld System.Int32 ForestProbe/State::displayWidth
IL_0ec2: dup
IL_0ec3: call UnityEngine.Resolution UnityEngine.Screen::get_currentResolution()
IL_0ec8: stloc.s V_69
IL_0eca: ldloca.s V_69
IL_0ecc: call System.Int32 UnityEngine.Resolution::get_height()
IL_0ed1: stfld System.Int32 ForestProbe/State::displayHeight
IL_0ed6: dup
IL_0ed7: call System.Boolean TheForestOfLove.UI.WindowController::CanScaleUp()
IL_0edc: stfld System.Boolean ForestProbe/State::canScaleUp
IL_0ee1: dup
IL_0ee2: call System.Boolean TheForestOfLove.UI.WindowController::CanScaleDown()
IL_0ee7: stfld System.Boolean ForestProbe/State::canScaleDown
IL_0eec: dup
IL_0eed: call UnityEngine.EventSystems.EventSystem UnityEngine.EventSystems.EventSystem::get_current()
IL_0ef2: ldnull
IL_0ef3: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0ef8: brtrue.s IL_0f22
IL_0efa: call UnityEngine.EventSystems.EventSystem UnityEngine.EventSystems.EventSystem::get_current()
IL_0eff: callvirt UnityEngine.GameObject UnityEngine.EventSystems.EventSystem::get_currentSelectedGameObject()
IL_0f04: ldnull
IL_0f05: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0f0a: brtrue.s IL_0f22
IL_0f0c: call UnityEngine.EventSystems.EventSystem UnityEngine.EventSystems.EventSystem::get_current()
IL_0f11: callvirt UnityEngine.GameObject UnityEngine.EventSystems.EventSystem::get_currentSelectedGameObject()
IL_0f16: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_0f1b: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_0f20: br.s IL_0f27
IL_0f22: ldstr ""
IL_0f27: stfld System.String ForestProbe/State::selectedControl
IL_0f2c: dup
IL_0f2d: ldloc.s V_10
IL_0f2f: callvirt !0[] System.Collections.Generic.List`1<System.String>::ToArray()
IL_0f34: stfld System.String[] ForestProbe/State::scaleEligibility
IL_0f39: dup
IL_0f3a: ldloc.s V_11
IL_0f3c: callvirt !0[] System.Collections.Generic.List`1<System.String>::ToArray()
IL_0f41: stfld System.String[] ForestProbe/State::scaleControlState
IL_0f46: dup
IL_0f47: ldloc.3
IL_0f48: callvirt System.Int32 System.Collections.Generic.List`1<ForestProbe/ResponseRow>::get_Count()
IL_0f4d: stfld System.Int32 ForestProbe/State::responseCount
IL_0f52: dup
IL_0f53: ldloc.3
IL_0f54: ldsfld System.Converter`2<ForestProbe/ResponseRow,System.String> ForestProbe/<>c::<>9__64_0
IL_0f59: dup
IL_0f5a: brtrue.s IL_0f73
IL_0f5c: pop
IL_0f5d: ldsfld ForestProbe/<>c ForestProbe/<>c::<>9
IL_0f62: ldftn System.String ForestProbe/<>c::<Dump>b__64_0(ForestProbe/ResponseRow)
IL_0f68: newobj System.Void System.Converter`2<ForestProbe/ResponseRow,System.String>::.ctor(System.Object,System.IntPtr)
IL_0f6d: dup
IL_0f6e: stsfld System.Converter`2<ForestProbe/ResponseRow,System.String> ForestProbe/<>c::<>9__64_0
IL_0f73: callvirt System.Collections.Generic.List`1<!!0> System.Collections.Generic.List`1<ForestProbe/ResponseRow>::ConvertAll<System.String>(System.Converter`2<!0,!!0>)
IL_0f78: callvirt !0[] System.Collections.Generic.List`1<System.String>::ToArray()
IL_0f7d: stfld System.String[] ForestProbe/State::responseRecords
IL_0f82: dup
IL_0f83: call System.Boolean TheForestOfLove.CustomTypewriterEffectTextMeshPro::IsTyping()
IL_0f88: stfld System.Boolean ForestProbe/State::typing
IL_0f8d: stloc.s V_13
IL_0f8f: call !!0 UnityEngine.Object::FindObjectOfType<TheForestOfLove.CustomTypewriterEffectTextMeshPro>()
IL_0f94: stloc.s V_14
IL_0f96: ldloc.s V_13
IL_0f98: ldloc.s V_14
IL_0f9a: ldnull
IL_0f9b: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0fa0: brtrue.s IL_0fab
IL_0fa2: ldloc.s V_14
IL_0fa4: callvirt System.String TheForestOfLove.CustomTypewriterEffectTextMeshPro::get_CurrentVisibleText()
IL_0fa9: br.s IL_0fb0
IL_0fab: ldstr ""
IL_0fb0: stfld System.String ForestProbe/State::visibleTypewriterText
IL_0fb5: ldarg.0
IL_0fb6: ldloc.s V_13
IL_0fb8: call System.Void ForestProbe::ReadConversation(ForestProbe/State)
IL_0fbd: nop
IL_0fbe: ldarg.0
IL_0fbf: ldloc.s V_13
IL_0fc1: call System.Void ForestProbe::ReadTutorialCompletionRecord(ForestProbe/State)
IL_0fc6: nop
IL_0fc7: ldarg.0
IL_0fc8: ldfld System.String ForestProbe::root
IL_0fcd: ldstr "state.json"
IL_0fd2: call System.String System.IO.Path::Combine(System.String,System.String)
IL_0fd7: ldloc.s V_13
IL_0fd9: ldc.i4.1
IL_0fda: call System.String UnityEngine.JsonUtility::ToJson(System.Object,System.Boolean)
IL_0fdf: call System.Void System.IO.File::WriteAllText(System.String,System.String)
IL_0fe4: nop
IL_0fe5: ret
METHOD System.String[] ForestProbe::ContinuationReadiness(System.Boolean&,System.Boolean&,System.Int32&) | attributes=Private, HideBySig | impl=IL
IL_0000: nop
IL_0001: ldarg.1
IL_0002: ldc.i4.0
IL_0003: stind.i1
IL_0004: ldarg.2
IL_0005: ldc.i4.0
IL_0006: stind.i1
IL_0007: ldarg.3
IL_0008: ldc.i4.0
IL_0009: stind.i4
IL_000a: ldtoken TheForestOfLove.Services.Persistence.DataService
IL_000f: call System.Type System.Type::GetTypeFromHandle(System.RuntimeTypeHandle)
IL_0014: ldstr "_instance"
IL_0019: ldc.i4.s 40
IL_001b: callvirt System.Reflection.FieldInfo System.Type::GetField(System.String,System.Reflection.BindingFlags)
IL_0020: stloc.0
IL_0021: ldloc.0
IL_0022: ldnull
IL_0023: call System.Boolean System.Reflection.FieldInfo::op_Equality(System.Reflection.FieldInfo,System.Reflection.FieldInfo)
IL_0028: stloc.s V_6
IL_002a: ldloc.s V_6
IL_002c: brfalse.s IL_0039
IL_002e: ldstr "Unknown original DataService singleton field"
IL_0033: newobj System.Void System.Exception::.ctor(System.String)
IL_0038: throw
IL_0039: ldloc.0
IL_003a: ldnull
IL_003b: callvirt System.Object System.Reflection.FieldInfo::GetValue(System.Object)
IL_0040: isinst TheForestOfLove.Services.Persistence.DataService
IL_0045: stloc.1
IL_0046: ldloc.1
IL_0047: ldnull
IL_0048: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_004d: stloc.s V_7
IL_004f: ldloc.s V_7
IL_0051: brfalse.s IL_0068
IL_0053: ldc.i4.1
IL_0054: newarr System.String
IL_0059: dup
IL_005a: ldc.i4.0
IL_005b: ldstr "DataService._instance"
IL_0060: stelem.ref
IL_0061: stloc.s V_8
IL_0063: br IL_0382
IL_0068: ldarg.1
IL_0069: ldc.i4.1
IL_006a: stind.i1
IL_006b: ldarg.3
IL_006c: ldloc.1
IL_006d: callvirt System.Int32 UnityEngine.Object::GetInstanceID()
IL_0072: stind.i4
IL_0073: ldloc.1
IL_0074: ldstr "_manifest"
IL_0079: call System.Object ForestProbe::ReadField(System.Object,System.String)
IL_007e: isinst TheForestOfLove.Narrative.DataManifest
IL_0083: stloc.2
IL_0084: ldloc.2
IL_0085: ldnull
IL_0086: ceq
IL_0088: stloc.s V_9
IL_008a: ldloc.s V_9
IL_008c: brfalse.s IL_00a3
IL_008e: ldc.i4.1
IL_008f: newarr System.String
IL_0094: dup
IL_0095: ldc.i4.0
IL_0096: ldstr "DataService._manifest"
IL_009b: stelem.ref
IL_009c: stloc.s V_8
IL_009e: br IL_0382
IL_00a3: ldarg.2
IL_00a4: ldc.i4.1
IL_00a5: stind.i1
IL_00a6: newobj System.Void System.Collections.Generic.List`1<System.String>::.ctor()
IL_00ab: stloc.3
IL_00ac: ldloc.2
IL_00ad: ldfld TheForestOfLove.Services.Persistence.PlayerRespawnData TheForestOfLove.Narrative.DataManifest::playerRespawnData
IL_00b2: ldnull
IL_00b3: ceq
IL_00b5: stloc.s V_10
IL_00b7: ldloc.s V_10
IL_00b9: brfalse.s IL_00c7
IL_00bb: ldloc.3
IL_00bc: ldstr "DataManifest.playerRespawnData"
IL_00c1: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_00c6: nop
IL_00c7: ldloc.2
IL_00c8: ldfld TheForestOfLove.Services.Persistence.GeneralData TheForestOfLove.Narrative.DataManifest::generalData
IL_00cd: ldnull
IL_00ce: ceq
IL_00d0: stloc.s V_11
IL_00d2: ldloc.s V_11
IL_00d4: brfalse.s IL_00e2
IL_00d6: ldloc.3
IL_00d7: ldstr "DataManifest.generalData"
IL_00dc: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_00e1: nop
IL_00e2: ldloc.2
IL_00e3: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Trigger> TheForestOfLove.Narrative.DataManifest::triggersByTriggerName
IL_00e8: ldnull
IL_00e9: ceq
IL_00eb: stloc.s V_12
IL_00ed: ldloc.s V_12
IL_00ef: brfalse.s IL_00fd
IL_00f1: ldloc.3
IL_00f2: ldstr "DataManifest.triggersByTriggerName"
IL_00f7: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_00fc: nop
IL_00fd: ldloc.2
IL_00fe: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Tag> TheForestOfLove.Narrative.DataManifest::activeTagsByDbName
IL_0103: ldnull
IL_0104: ceq
IL_0106: stloc.s V_13
IL_0108: ldloc.s V_13
IL_010a: brfalse.s IL_0118
IL_010c: ldloc.3
IL_010d: ldstr "DataManifest.activeTagsByDbName"
IL_0112: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0117: nop
IL_0118: ldloc.2
IL_0119: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DataManifest::dialoguesByDbName
IL_011e: ldnull
IL_011f: ceq
IL_0121: stloc.s V_14
IL_0123: ldloc.s V_14
IL_0125: brfalse.s IL_0135
IL_0127: ldloc.3
IL_0128: ldstr "DataManifest.dialoguesByDbName"
IL_012d: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0132: nop
IL_0133: br.s IL_0165
IL_0135: nop
IL_0136: ldloc.2
IL_0137: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DataManifest::dialoguesByDbName
IL_013c: ldstr "NewGame_Intro"
IL_0141: ldloca.s V_15
IL_0143: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Dialogue>::TryGetValue(!0,!1&)
IL_0148: brfalse.s IL_0151
IL_014a: ldloc.s V_15
IL_014c: ldnull
IL_014d: ceq
IL_014f: br.s IL_0152
IL_0151: ldc.i4.1
IL_0152: stloc.s V_16
IL_0154: ldloc.s V_16
IL_0156: brfalse.s IL_0164
IL_0158: ldloc.3
IL_0159: ldstr "dialogue.NewGame_Intro"
IL_015e: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0163: nop
IL_0164: nop
IL_0165: ldloc.2
IL_0166: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Quest> TheForestOfLove.Narrative.DataManifest::questsByDbName
IL_016b: ldnull
IL_016c: ceq
IL_016e: stloc.s V_17
IL_0170: ldloc.s V_17
IL_0172: brfalse.s IL_0185
IL_0174: ldloc.3
IL_0175: ldstr "DataManifest.questsByDbName"
IL_017a: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_017f: nop
IL_0180: br IL_030d
IL_0185: nop
IL_0186: ldc.i4.2
IL_0187: newarr System.String
IL_018c: dup
IL_018d: ldc.i4.0
IL_018e: ldstr "Act1_TutorialQuest"
IL_0193: stelem.ref
IL_0194: dup
IL_0195: ldc.i4.1
IL_0196: ldstr "Act1_GossipQuest"
IL_019b: stelem.ref
IL_019c: stloc.s V_18
IL_019e: ldc.i4.0
IL_019f: stloc.s V_19
IL_01a1: br IL_0302
IL_01a6: ldloc.s V_18
IL_01a8: ldloc.s V_19
IL_01aa: ldelem.ref
IL_01ab: stloc.s V_20
IL_01ad: nop
IL_01ae: ldloc.2
IL_01af: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Quest> TheForestOfLove.Narrative.DataManifest::questsByDbName
IL_01b4: ldloc.s V_20
IL_01b6: ldloca.s V_21
IL_01b8: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Quest>::TryGetValue(!0,!1&)
IL_01bd: brfalse.s IL_01c6
IL_01bf: ldloc.s V_21
IL_01c1: ldnull
IL_01c2: ceq
IL_01c4: br.s IL_01c7
IL_01c6: ldc.i4.1
IL_01c7: stloc.s V_22
IL_01c9: ldloc.s V_22
IL_01cb: brfalse.s IL_01e6
IL_01cd: nop
IL_01ce: ldloc.3
IL_01cf: ldstr "quest."
IL_01d4: ldloc.s V_20
IL_01d6: call System.String System.String::Concat(System.String,System.String)
IL_01db: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_01e0: nop
IL_01e1: br IL_02fc
IL_01e6: ldloc.s V_21
IL_01e8: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.Quest::dialogues
IL_01ed: ldnull
IL_01ee: ceq
IL_01f0: stloc.s V_23
IL_01f2: ldloc.s V_23
IL_01f4: brfalse.s IL_0214
IL_01f6: nop
IL_01f7: ldloc.3
IL_01f8: ldstr "quest."
IL_01fd: ldloc.s V_20
IL_01ff: ldstr ".dialogues"
IL_0204: call System.String System.String::Concat(System.String,System.String,System.String)
IL_0209: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_020e: nop
IL_020f: br IL_02fc
IL_0214: nop
IL_0215: ldloc.s V_21
IL_0217: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.Quest::dialogues
IL_021c: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>::GetEnumerator()
IL_0221: stloc.s V_24
IL_0223: br IL_02de
IL_0228: ldloca.s V_24
IL_022a: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Dialogue>::get_Current()
IL_022f: stloc.s V_25
IL_0231: nop
IL_0232: ldloc.s V_25
IL_0234: ldnull
IL_0235: ceq
IL_0237: stloc.s V_26
IL_0239: ldloc.s V_26
IL_023b: brfalse.s IL_025b
IL_023d: nop
IL_023e: ldloc.3
IL_023f: ldstr "quest."
IL_0244: ldloc.s V_20
IL_0246: ldstr ".dialogue"
IL_024b: call System.String System.String::Concat(System.String,System.String,System.String)
IL_0250: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0255: nop
IL_0256: br IL_02de
IL_025b: ldloc.s V_25
IL_025d: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc> TheForestOfLove.Narrative.Dialogue::primaryArcs
IL_0262: ldnull
IL_0263: ceq
IL_0265: stloc.s V_27
IL_0267: ldloc.s V_27
IL_0269: brfalse.s IL_0286
IL_026b: nop
IL_026c: ldloc.3
IL_026d: ldstr "quest."
IL_0272: ldloc.s V_20
IL_0274: ldstr ".primaryArcs"
IL_0279: call System.String System.String::Concat(System.String,System.String,System.String)
IL_027e: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0283: nop
IL_0284: br.s IL_02de
IL_0286: nop
IL_0287: ldloc.s V_25
IL_0289: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc> TheForestOfLove.Narrative.Dialogue::primaryArcs
IL_028e: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc>::GetEnumerator()
IL_0293: stloc.s V_28
IL_0295: br.s IL_02c3
IL_0297: ldloca.s V_28
IL_0299: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Arc>::get_Current()
IL_029e: stloc.s V_29
IL_02a0: ldloc.s V_29
IL_02a2: ldnull
IL_02a3: ceq
IL_02a5: stloc.s V_30
IL_02a7: ldloc.s V_30
IL_02a9: brfalse.s IL_02c3
IL_02ab: ldloc.3
IL_02ac: ldstr "quest."
IL_02b1: ldloc.s V_20
IL_02b3: ldstr ".primaryArc"
IL_02b8: call System.String System.String::Concat(System.String,System.String,System.String)
IL_02bd: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_02c2: nop
IL_02c3: ldloca.s V_28
IL_02c5: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Arc>::MoveNext()
IL_02ca: brtrue.s IL_0297
IL_02cc: leave.s IL_02dd
IL_02ce: ldloca.s V_28
IL_02d0: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Arc>
IL_02d6: callvirt System.Void System.IDisposable::Dispose()
IL_02db: nop
IL_02dc: endfinally
IL_02dd: nop
IL_02de: ldloca.s V_24
IL_02e0: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Dialogue>::MoveNext()
IL_02e5: brtrue IL_0228
IL_02ea: leave.s IL_02fb
IL_02ec: ldloca.s V_24
IL_02ee: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Dialogue>
IL_02f4: callvirt System.Void System.IDisposable::Dispose()
IL_02f9: nop
IL_02fa: endfinally
IL_02fb: nop
IL_02fc: ldloc.s V_19
IL_02fe: ldc.i4.1
IL_02ff: add
IL_0300: stloc.s V_19
IL_0302: ldloc.s V_19
IL_0304: ldloc.s V_18
IL_0306: ldlen
IL_0307: conv.i4
IL_0308: blt IL_01a6
IL_030d: ldtoken TheForestOfLove.Events.GameStateManager
IL_0312: call System.Type System.Type::GetTypeFromHandle(System.RuntimeTypeHandle)
IL_0317: ldstr "isEventActive"
IL_031c: ldc.i4.s 56
IL_031e: callvirt System.Reflection.FieldInfo System.Type::GetField(System.String,System.Reflection.BindingFlags)
IL_0323: stloc.s V_4
IL_0325: ldloc.s V_4
IL_0327: ldnull
IL_0328: call System.Boolean System.Reflection.FieldInfo::op_Equality(System.Reflection.FieldInfo,System.Reflection.FieldInfo)
IL_032d: stloc.s V_31
IL_032f: ldloc.s V_31
IL_0331: brfalse.s IL_033e
IL_0333: ldstr "Unknown original event array field"
IL_0338: newobj System.Void System.Exception::.ctor(System.String)
IL_033d: throw
IL_033e: ldloc.s V_4
IL_0340: ldnull
IL_0341: callvirt System.Object System.Reflection.FieldInfo::GetValue(System.Object)
IL_0346: isinst System.Boolean[]
IL_034b: stloc.s V_5
IL_034d: ldloc.s V_5
IL_034f: brfalse.s IL_035b
IL_0351: ldloc.s V_5
IL_0353: ldlen
IL_0354: conv.i4
IL_0355: ldc.i4.s 11
IL_0357: clt
IL_0359: br.s IL_035c
IL_035b: ldc.i4.1
IL_035c: stloc.s V_32
IL_035e: ldloc.s V_32
IL_0360: brfalse.s IL_036e
IL_0362: ldloc.3
IL_0363: ldstr "GameStateManager.isEventActive"
IL_0368: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_036d: nop
IL_036e: ldloc.3
IL_036f: newobj System.Void System.Collections.Generic.HashSet`1<System.String>::.ctor(System.Collections.Generic.IEnumerable`1<!0>)
IL_0374: newobj System.Void System.Collections.Generic.List`1<System.String>::.ctor(System.Collections.Generic.IEnumerable`1<!0>)
IL_0379: call !0[] System.Collections.Generic.List`1<System.String>::ToArray()
IL_037e: stloc.s V_8
IL_0380: br.s IL_0382
IL_0382: ldloc.s V_8
IL_0384: ret
METHOD System.Void ForestProbe::DumpSaveContinuation() | attributes=Private, HideBySig | impl=IL
IL_0000: nop
IL_0001: newobj System.Void ForestProbe/SaveContinuationState::.ctor()
IL_0006: stloc.s V_6
IL_0008: ldloc.s V_6
IL_000a: call UnityEngine.SceneManagement.Scene UnityEngine.SceneManagement.SceneManager::GetActiveScene()
IL_000f: stloc.s V_7
IL_0011: ldloca.s V_7
IL_0013: call System.String UnityEngine.SceneManagement.Scene::get_name()
IL_0018: stfld System.String ForestProbe/SaveContinuationState::scene
IL_001d: ldloc.s V_6
IL_001f: call System.String UnityEngine.Application::get_companyName()
IL_0024: stfld System.String ForestProbe/SaveContinuationState::company
IL_0029: ldloc.s V_6
IL_002b: call System.String UnityEngine.Application::get_productName()
IL_0030: stfld System.String ForestProbe/SaveContinuationState::product
IL_0035: ldloc.s V_6
IL_0037: call System.String UnityEngine.Application::get_dataPath()
IL_003c: stfld System.String ForestProbe/SaveContinuationState::dataPath
IL_0041: ldloc.s V_6
IL_0043: call System.String UnityEngine.Application::get_persistentDataPath()
IL_0048: stfld System.String ForestProbe/SaveContinuationState::persistentDataPath
IL_004d: ldloc.s V_6
IL_004f: call System.Int32 UnityEngine.Time::get_frameCount()
IL_0054: stfld System.Int32 ForestProbe/SaveContinuationState::frame
IL_0059: ldloc.s V_6
IL_005b: call System.Single UnityEngine.Time::get_realtimeSinceStartup()
IL_0060: stfld System.Single ForestProbe/SaveContinuationState::realtime
IL_0065: ldloc.s V_6
IL_0067: call System.Single UnityEngine.Time::get_time()
IL_006c: stfld System.Single ForestProbe/SaveContinuationState::scaledTime
IL_0071: ldloc.s V_6
IL_0073: call System.Single UnityEngine.Time::get_timeScale()
IL_0078: stfld System.Single ForestProbe/SaveContinuationState::timeScale
IL_007d: ldloc.s V_6
IL_007f: ldc.i4.0
IL_0080: newarr System.String
IL_0085: stfld System.String[] ForestProbe/SaveContinuationState::diagnostics
IL_008a: ldloc.s V_6
IL_008c: stloc.0
IL_008d: ldloc.0
IL_008e: ldarg.0
IL_008f: ldloc.0
IL_0090: ldflda System.Boolean ForestProbe/SaveContinuationState::dataServicePresent
IL_0095: ldloc.0
IL_0096: ldflda System.Boolean ForestProbe/SaveContinuationState::manifestPresent
IL_009b: ldloc.0
IL_009c: ldflda System.Int32 ForestProbe/SaveContinuationState::dataServiceInstance
IL_00a1: call System.String[] ForestProbe::ContinuationReadiness(System.Boolean&,System.Boolean&,System.Int32&)
IL_00a6: stfld System.String[] ForestProbe/SaveContinuationState::notReady
IL_00ab: ldloc.0
IL_00ac: ldloc.0
IL_00ad: ldfld System.String[] ForestProbe/SaveContinuationState::notReady
IL_00b2: ldlen
IL_00b3: ldc.i4.0
IL_00b4: ceq
IL_00b6: stfld System.Boolean ForestProbe/SaveContinuationState::diagnosticsReady
IL_00bb: ldloc.0
IL_00bc: ldfld System.Boolean ForestProbe/SaveContinuationState::diagnosticsReady
IL_00c1: ldc.i4.0
IL_00c2: ceq
IL_00c4: stloc.s V_8
IL_00c6: ldloc.s V_8
IL_00c8: brfalse.s IL_00ed
IL_00ca: nop
IL_00cb: ldarg.0
IL_00cc: ldfld System.String ForestProbe::root
IL_00d1: ldstr "save-continuation.json"
IL_00d6: call System.String System.IO.Path::Combine(System.String,System.String)
IL_00db: ldloc.0
IL_00dc: ldc.i4.1
IL_00dd: call System.String UnityEngine.JsonUtility::ToJson(System.Object,System.Boolean)
IL_00e2: call System.Void System.IO.File::WriteAllText(System.String,System.String)
IL_00e7: nop
IL_00e8: br IL_0306
IL_00ed: call TheForestOfLove.Services.Persistence.PlayerRespawnData TheForestOfLove.Services.Persistence.DataService::GetPlayerRespawnData()
IL_00f2: stloc.1
IL_00f3: call TheForestOfLove.Services.Persistence.GeneralData TheForestOfLove.Services.Persistence.DataService::GetGeneralData()
IL_00f8: stloc.2
IL_00f9: ldsfld TheForestOfLove.Player TheForestOfLove.Player::current
IL_00fe: stloc.3
IL_00ff: ldstr "NewGame_Intro"
IL_0104: call TheForestOfLove.Narrative.Dialogue TheForestOfLove.Services.Persistence.DataService::GetDialogueByDbName(System.String)
IL_0109: stloc.s V_4
IL_010b: ldloc.s V_4
IL_010d: ldnull
IL_010e: ceq
IL_0110: stloc.s V_9
IL_0112: ldloc.s V_9
IL_0114: brfalse.s IL_0121
IL_0116: ldstr "Missing original intro record"
IL_011b: newobj System.Void System.Exception::.ctor(System.String)
IL_0120: throw
IL_0121: ldc.i4.0
IL_0122: stloc.s V_5
IL_0124: nop
IL_0125: call !!0[] UnityEngine.Resources::FindObjectsOfTypeAll<TheForestOfLove.TutorialQuestBunnyIntroduction>()
IL_012a: stloc.s V_10
IL_012c: ldc.i4.0
IL_012d: stloc.s V_11
IL_012f: br.s IL_0170
IL_0131: ldloc.s V_10
IL_0133: ldloc.s V_11
IL_0135: ldelem.ref
IL_0136: stloc.s V_12
IL_0138: ldloc.s V_12
IL_013a: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_013f: callvirt UnityEngine.SceneManagement.Scene UnityEngine.GameObject::get_scene()
IL_0144: stloc.s V_7
IL_0146: ldloca.s V_7
IL_0148: call System.Boolean UnityEngine.SceneManagement.Scene::IsValid()
IL_014d: brfalse.s IL_015d
IL_014f: ldloc.s V_12
IL_0151: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0156: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_015b: br.s IL_015e
IL_015d: ldc.i4.0
IL_015e: stloc.s V_13
IL_0160: ldloc.s V_13
IL_0162: brfalse.s IL_016a
IL_0164: ldloc.s V_5
IL_0166: ldc.i4.1
IL_0167: add
IL_0168: stloc.s V_5
IL_016a: ldloc.s V_11
IL_016c: ldc.i4.1
IL_016d: add
IL_016e: stloc.s V_11
IL_0170: ldloc.s V_11
IL_0172: ldloc.s V_10
IL_0174: ldlen
IL_0175: conv.i4
IL_0176: blt.s IL_0131
IL_0178: ldloc.0
IL_0179: call System.Boolean TheForestOfLove.Services.Persistence.SaveManager::get_HasSavedPlaySession()
IL_017e: stfld System.Boolean ForestProbe/SaveContinuationState::hasSavedPlaySession
IL_0183: ldloc.0
IL_0184: ldsfld System.Boolean Globals::isChapterSelect
IL_0189: stfld System.Boolean ForestProbe/SaveContinuationState::isChapterSelect
IL_018e: ldloc.0
IL_018f: ldsfld System.Boolean Globals::isCheatCode
IL_0194: stfld System.Boolean ForestProbe/SaveContinuationState::isCheatCode
IL_0199: ldloc.0
IL_019a: ldsfld System.Boolean Globals::isFinishingSoftReset
IL_019f: stfld System.Boolean ForestProbe/SaveContinuationState::isFinishingSoftReset
IL_01a4: ldloc.0
IL_01a5: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inGameplayScene()
IL_01aa: stfld System.Boolean ForestProbe/SaveContinuationState::gameplay
IL_01af: ldloc.0
IL_01b0: call System.Boolean TheForestOfLove.Events.GameStateManager::get_isAnyEventActive()
IL_01b5: stfld System.Boolean ForestProbe/SaveContinuationState::anyEvent
IL_01ba: ldloc.0
IL_01bb: call System.Boolean PixelCrushers.DialogueSystem.DialogueManager::get_IsConversationActive()
IL_01c0: stfld System.Boolean ForestProbe/SaveContinuationState::conversation
IL_01c5: ldloc.0
IL_01c6: ldloc.1
IL_01c7: ldfld System.String TheForestOfLove.Services.Persistence.PlayerRespawnData::currentAreaUnitySceneName
IL_01cc: stfld System.String ForestProbe/SaveContinuationState::currentArea
IL_01d1: ldloc.0
IL_01d2: ldloc.1
IL_01d3: ldfld System.String TheForestOfLove.Services.Persistence.PlayerRespawnData::lastAreaUnitySceneName
IL_01d8: stfld System.String ForestProbe/SaveContinuationState::lastArea
IL_01dd: ldloc.0
IL_01de: ldloc.1
IL_01df: ldfld UnityEngine.Vector3 TheForestOfLove.Services.Persistence.PlayerRespawnData::lastPosition
IL_01e4: stfld UnityEngine.Vector3 ForestProbe/SaveContinuationState::lastPosition
IL_01e9: ldloc.0
IL_01ea: ldloc.1
IL_01eb: ldfld UnityEngine.Vector3 TheForestOfLove.Services.Persistence.PlayerRespawnData::lastSpawnPosition
IL_01f0: stfld UnityEngine.Vector3 ForestProbe/SaveContinuationState::lastSpawnPosition
IL_01f5: ldloc.0
IL_01f6: ldloc.1
IL_01f7: ldfld System.Boolean TheForestOfLove.Services.Persistence.PlayerRespawnData::lastPositionExact
IL_01fc: stfld System.Boolean ForestProbe/SaveContinuationState::lastPositionExact
IL_0201: ldloc.0
IL_0202: ldloc.1
IL_0203: ldfld System.Boolean TheForestOfLove.Services.Persistence.PlayerRespawnData::isSwimming
IL_0208: stfld System.Boolean ForestProbe/SaveContinuationState::isSwimming
IL_020d: ldloc.0
IL_020e: ldloc.1
IL_020f: ldfld System.Boolean TheForestOfLove.Services.Persistence.PlayerRespawnData::isFastTraveling
IL_0214: stfld System.Boolean ForestProbe/SaveContinuationState::isFastTraveling
IL_0219: ldloc.0
IL_021a: ldloc.1
IL_021b: ldfld System.String TheForestOfLove.Services.Persistence.PlayerRespawnData::cameraSettingsObjectName
IL_0220: stfld System.String ForestProbe/SaveContinuationState::cameraSettingsObjectName
IL_0225: ldloc.0
IL_0226: ldloc.2
IL_0227: ldfld System.Single TheForestOfLove.Services.Persistence.GeneralData::storyClock
IL_022c: stfld System.Single ForestProbe/SaveContinuationState::storyClock
IL_0231: ldloc.0
IL_0232: ldloc.2
IL_0233: ldfld System.Boolean TheForestOfLove.Services.Persistence.GeneralData::finishedControlTutorial
IL_0238: stfld System.Boolean ForestProbe/SaveContinuationState::finishedControlTutorial
IL_023d: ldloc.0
IL_023e: ldloc.2
IL_023f: ldfld System.Boolean TheForestOfLove.Services.Persistence.GeneralData::finishedDialogueTutorial
IL_0244: stfld System.Boolean ForestProbe/SaveContinuationState::finishedDialogueTutorial
IL_0249: ldloc.0
IL_024a: ldloc.2
IL_024b: ldfld System.Boolean TheForestOfLove.Services.Persistence.GeneralData::finishedGossipTutorial
IL_0250: stfld System.Boolean ForestProbe/SaveContinuationState::finishedGossipTutorial
IL_0255: ldloc.0
IL_0256: ldloc.3
IL_0257: ldnull
IL_0258: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_025d: brfalse.s IL_026c
IL_025f: ldloc.3
IL_0260: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0265: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_026a: br.s IL_026d
IL_026c: ldc.i4.0
IL_026d: stfld System.Boolean ForestProbe/SaveContinuationState::playerPresent
IL_0272: ldloc.0
IL_0273: ldloc.3
IL_0274: ldnull
IL_0275: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_027a: brtrue.s IL_0289
IL_027c: ldloc.3
IL_027d: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0282: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_0287: br.s IL_028a
IL_0289: ldnull
IL_028a: stfld System.String ForestProbe/SaveContinuationState::playerPath
IL_028f: ldloc.0
IL_0290: ldloc.3
IL_0291: ldnull
IL_0292: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0297: brtrue.s IL_02a1
IL_0299: ldloc.3
IL_029a: callvirt System.Int32 UnityEngine.Object::GetInstanceID()
IL_029f: br.s IL_02a2
IL_02a1: ldc.i4.0
IL_02a2: stfld System.Int32 ForestProbe/SaveContinuationState::playerInstance
IL_02a7: ldloc.0
IL_02a8: ldloc.3
IL_02a9: ldnull
IL_02aa: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_02af: brtrue.s IL_02be
IL_02b1: ldloc.3
IL_02b2: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_02b7: callvirt UnityEngine.Vector3 UnityEngine.Transform::get_position()
IL_02bc: br.s IL_02c3
IL_02be: call UnityEngine.Vector3 UnityEngine.Vector3::get_zero()
IL_02c3: stfld UnityEngine.Vector3 ForestProbe/SaveContinuationState::playerPosition
IL_02c8: ldloc.0
IL_02c9: ldloc.s V_4
IL_02cb: callvirt TheForestOfLove.Narrative.DialogueStatus TheForestOfLove.Narrative.Dialogue::get_status()
IL_02d0: stfld System.Int32 ForestProbe/SaveContinuationState::introStatus
IL_02d5: ldloc.0
IL_02d6: ldloc.s V_5
IL_02d8: stfld System.Int32 ForestProbe/SaveContinuationState::tutorialIntroControllers
IL_02dd: ldloc.0
IL_02de: ldarg.0
IL_02df: call System.String[] ForestProbe::TutorialRouteDiagnostics()
IL_02e4: stfld System.String[] ForestProbe/SaveContinuationState::diagnostics
IL_02e9: ldarg.0
IL_02ea: ldfld System.String ForestProbe::root
IL_02ef: ldstr "save-continuation.json"
IL_02f4: call System.String System.IO.Path::Combine(System.String,System.String)
IL_02f9: ldloc.0
IL_02fa: ldc.i4.1
IL_02fb: call System.String UnityEngine.JsonUtility::ToJson(System.Object,System.Boolean)
IL_0300: call System.Void System.IO.File::WriteAllText(System.String,System.String)
IL_0305: nop
IL_0306: ret
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
