TYPE ForestProbe
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
