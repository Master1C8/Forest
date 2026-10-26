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
IL_0012: br IL_1109
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
IL_0046: br IL_1109
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
IL_0081: br IL_105b
IL_0086: ldloc.1
IL_0087: ldstr "dump"
IL_008c: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0091: stloc.s V_5
IL_0093: ldloc.s V_5
IL_0095: brfalse.s IL_00a3
IL_0097: ldarg.0
IL_0098: call System.Void ForestProbe::Dump()
IL_009d: nop
IL_009e: br IL_105b
IL_00a3: ldloc.1
IL_00a4: ldstr "dump-save-continuation"
IL_00a9: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_00ae: stloc.s V_6
IL_00b0: ldloc.s V_6
IL_00b2: brfalse.s IL_00c0
IL_00b4: ldarg.0
IL_00b5: call System.Void ForestProbe::DumpSaveContinuation()
IL_00ba: nop
IL_00bb: br IL_105b
IL_00c0: ldloc.1
IL_00c1: ldstr "dump-intro"
IL_00c6: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_00cb: stloc.s V_7
IL_00cd: ldloc.s V_7
IL_00cf: brfalse.s IL_00dd
IL_00d1: ldarg.0
IL_00d2: call System.Void ForestProbe::DumpIntro()
IL_00d7: nop
IL_00d8: br IL_105b
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
IL_0161: br IL_105b
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
IL_01ea: br IL_105b
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
IL_0273: br IL_105b
IL_0278: ldloc.1
IL_0279: ldstr "dump-bucky"
IL_027e: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0283: stloc.s V_15
IL_0285: ldloc.s V_15
IL_0287: brfalse IL_0325
IL_028c: nop
IL_028d: newobj System.Void ForestProbe/BuckyInteractionState::.ctor()
IL_0292: dup
IL_0293: call UnityEngine.SceneManagement.Scene UnityEngine.SceneManagement.SceneManager::GetActiveScene()
IL_0298: stloc.s V_10
IL_029a: ldloca.s V_10
IL_029c: call System.String UnityEngine.SceneManagement.Scene::get_name()
IL_02a1: stfld System.String ForestProbe/BuckyInteractionState::scene
IL_02a6: dup
IL_02a7: call System.String UnityEngine.Application::get_companyName()
IL_02ac: stfld System.String ForestProbe/BuckyInteractionState::company
IL_02b1: dup
IL_02b2: call System.String UnityEngine.Application::get_productName()
IL_02b7: stfld System.String ForestProbe/BuckyInteractionState::product
IL_02bc: dup
IL_02bd: call System.String UnityEngine.Application::get_dataPath()
IL_02c2: stfld System.String ForestProbe/BuckyInteractionState::dataPath
IL_02c7: dup
IL_02c8: call System.String UnityEngine.Application::get_persistentDataPath()
IL_02cd: stfld System.String ForestProbe/BuckyInteractionState::persistentDataPath
IL_02d2: dup
IL_02d3: ldstr "original"
IL_02d8: stfld System.String ForestProbe/BuckyInteractionState::choiceMode
IL_02dd: dup
IL_02de: call System.Int32 UnityEngine.Time::get_frameCount()
IL_02e3: stfld System.Int32 ForestProbe/BuckyInteractionState::frame
IL_02e8: dup
IL_02e9: call System.Single UnityEngine.Time::get_realtimeSinceStartup()
IL_02ee: stfld System.Single ForestProbe/BuckyInteractionState::realtime
IL_02f3: dup
IL_02f4: ldarg.0
IL_02f5: call System.String[] ForestProbe::BuckyInteractionDiagnostics()
IL_02fa: stfld System.String[] ForestProbe/BuckyInteractionState::diagnostics
IL_02ff: stloc.s V_16
IL_0301: ldarg.0
IL_0302: ldfld System.String ForestProbe::root
IL_0307: ldstr "bucky-interaction.json"
IL_030c: call System.String System.IO.Path::Combine(System.String,System.String)
IL_0311: ldloc.s V_16
IL_0313: ldc.i4.1
IL_0314: call System.String UnityEngine.JsonUtility::ToJson(System.Object,System.Boolean)
IL_0319: call System.Void System.IO.File::WriteAllText(System.String,System.String)
IL_031e: nop
IL_031f: nop
IL_0320: br IL_105b
IL_0325: ldloc.1
IL_0326: ldstr "qa-background-input"
IL_032b: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0330: stloc.s V_17
IL_0332: ldloc.s V_17
IL_0334: brfalse.s IL_03a2
IL_0336: nop
IL_0337: ldarg.0
IL_0338: ldflda System.Nullable`1<System.Boolean> ForestProbe::originalIgnoreUnfocused
IL_033d: call System.Boolean System.Nullable`1<System.Boolean>::get_HasValue()
IL_0342: brtrue.s IL_034e
IL_0344: call System.Boolean Rewired.ReInput::get_isReady()
IL_0349: ldc.i4.0
IL_034a: ceq
IL_034c: br.s IL_034f
IL_034e: ldc.i4.1
IL_034f: stloc.s V_18
IL_0351: ldloc.s V_18
IL_0353: brfalse.s IL_0360
IL_0355: ldstr "Background policy already changed or input not ready"
IL_035a: newobj System.Void System.Exception::.ctor(System.String)
IL_035f: throw
IL_0360: ldarg.0
IL_0361: call Rewired.ReInput/ConfigHelper Rewired.ReInput::get_configuration()
IL_0366: callvirt System.Boolean Rewired.ReInput/ConfigHelper::get_ignoreInputWhenAppNotInFocus()
IL_036b: newobj System.Void System.Nullable`1<System.Boolean>::.ctor(!0)
IL_0370: stfld System.Nullable`1<System.Boolean> ForestProbe::originalIgnoreUnfocused
IL_0375: call Rewired.ReInput/ConfigHelper Rewired.ReInput::get_configuration()
IL_037a: ldc.i4.0
IL_037b: callvirt System.Void Rewired.ReInput/ConfigHelper::set_ignoreInputWhenAppNotInFocus(System.Boolean)
IL_0380: nop
IL_0381: call Rewired.ReInput/ConfigHelper Rewired.ReInput::get_configuration()
IL_0386: callvirt System.Boolean Rewired.ReInput/ConfigHelper::get_ignoreInputWhenAppNotInFocus()
IL_038b: stloc.s V_19
IL_038d: ldloc.s V_19
IL_038f: brfalse.s IL_039c
IL_0391: ldstr "Public Rewired background policy did not apply"
IL_0396: newobj System.Void System.Exception::.ctor(System.String)
IL_039b: throw
IL_039c: nop
IL_039d: br IL_105b
IL_03a2: ldloc.1
IL_03a3: ldstr "restore-input-policy"
IL_03a8: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_03ad: stloc.s V_20
IL_03af: ldloc.s V_20
IL_03b1: brfalse.s IL_03bf
IL_03b3: ldarg.0
IL_03b4: call System.Void ForestProbe::RestoreInputPolicy()
IL_03b9: nop
IL_03ba: br IL_105b
IL_03bf: ldloc.1
IL_03c0: ldstr "sample-keyboard-start"
IL_03c5: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_03ca: stloc.s V_21
IL_03cc: ldloc.s V_21
IL_03ce: brfalse.s IL_0401
IL_03d0: nop
IL_03d1: ldarg.0
IL_03d2: ldfld System.Boolean ForestProbe::samplingKeyboard
IL_03d7: stloc.s V_22
IL_03d9: ldloc.s V_22
IL_03db: brfalse.s IL_03e8
IL_03dd: ldstr "Keyboard sample already active"
IL_03e2: newobj System.Void System.Exception::.ctor(System.String)
IL_03e7: throw
IL_03e8: ldarg.0
IL_03e9: ldfld System.Collections.Generic.List`1<System.String> ForestProbe::keyboardSamples
IL_03ee: callvirt System.Void System.Collections.Generic.List`1<System.String>::Clear()
IL_03f3: nop
IL_03f4: ldarg.0
IL_03f5: ldc.i4.1
IL_03f6: stfld System.Boolean ForestProbe::samplingKeyboard
IL_03fb: nop
IL_03fc: br IL_105b
IL_0401: ldloc.1
IL_0402: ldstr "sample-keyboard-stop"
IL_0407: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_040c: stloc.s V_23
IL_040e: ldloc.s V_23
IL_0410: brfalse.s IL_045b
IL_0412: nop
IL_0413: ldarg.0
IL_0414: ldfld System.Boolean ForestProbe::samplingKeyboard
IL_0419: ldc.i4.0
IL_041a: ceq
IL_041c: stloc.s V_24
IL_041e: ldloc.s V_24
IL_0420: brfalse.s IL_042d
IL_0422: ldstr "No active keyboard sample"
IL_0427: newobj System.Void System.Exception::.ctor(System.String)
IL_042c: throw
IL_042d: ldarg.0
IL_042e: ldc.i4.0
IL_042f: stfld System.Boolean ForestProbe::samplingKeyboard
IL_0434: ldarg.0
IL_0435: ldfld System.String ForestProbe::root
IL_043a: ldstr "keyboard-samples.txt"
IL_043f: call System.String System.IO.Path::Combine(System.String,System.String)
IL_0444: ldarg.0
IL_0445: ldfld System.Collections.Generic.List`1<System.String> ForestProbe::keyboardSamples
IL_044a: callvirt !0[] System.Collections.Generic.List`1<System.String>::ToArray()
IL_044f: call System.Void System.IO.File::WriteAllLines(System.String,System.String[])
IL_0454: nop
IL_0455: nop
IL_0456: br IL_105b
IL_045b: ldloc.1
IL_045c: ldstr "sample-keyboard-snapshot"
IL_0461: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0466: stloc.s V_25
IL_0468: ldloc.s V_25
IL_046a: brfalse.s IL_04ae
IL_046c: nop
IL_046d: ldarg.0
IL_046e: ldfld System.Boolean ForestProbe::samplingKeyboard
IL_0473: ldc.i4.0
IL_0474: ceq
IL_0476: stloc.s V_26
IL_0478: ldloc.s V_26
IL_047a: brfalse.s IL_0487
IL_047c: ldstr "No active keyboard sample"
IL_0481: newobj System.Void System.Exception::.ctor(System.String)
IL_0486: throw
IL_0487: ldarg.0
IL_0488: ldfld System.String ForestProbe::root
IL_048d: ldstr "keyboard-samples.txt"
IL_0492: call System.String System.IO.Path::Combine(System.String,System.String)
IL_0497: ldarg.0
IL_0498: ldfld System.Collections.Generic.List`1<System.String> ForestProbe::keyboardSamples
IL_049d: callvirt !0[] System.Collections.Generic.List`1<System.String>::ToArray()
IL_04a2: call System.Void System.IO.File::WriteAllLines(System.String,System.String[])
IL_04a7: nop
IL_04a8: nop
IL_04a9: br IL_105b
IL_04ae: ldloc.1
IL_04af: ldstr "quit"
IL_04b4: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_04b9: stloc.s V_27
IL_04bb: ldloc.s V_27
IL_04bd: brfalse.s IL_04d3
IL_04bf: nop
IL_04c0: ldarg.0
IL_04c1: call System.Void ForestProbe::RestoreInputPolicy()
IL_04c6: nop
IL_04c7: call System.Void UnityEngine.Application::Quit()
IL_04cc: nop
IL_04cd: nop
IL_04ce: br IL_105b
IL_04d3: ldloc.1
IL_04d4: ldstr "show-menu"
IL_04d9: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_04de: stloc.s V_28
IL_04e0: ldloc.s V_28
IL_04e2: brfalse.s IL_0527
IL_04e4: nop
IL_04e5: call !!0 UnityEngine.Object::FindObjectOfType<TheForestOfLove.MainMenuController>()
IL_04ea: stloc.s V_29
IL_04ec: ldloc.s V_29
IL_04ee: ldnull
IL_04ef: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_04f4: stloc.s V_30
IL_04f6: ldloc.s V_30
IL_04f8: brfalse.s IL_0505
IL_04fa: ldstr "Main menu controller not active"
IL_04ff: newobj System.Void System.Exception::.ctor(System.String)
IL_0504: throw
IL_0505: ldloc.s V_29
IL_0507: callvirt System.Type System.Object::GetType()
IL_050c: ldstr "FinishShowingMenu"
IL_0511: ldc.i4.s 36
IL_0513: callvirt System.Reflection.MethodInfo System.Type::GetMethod(System.String,System.Reflection.BindingFlags)
IL_0518: ldloc.s V_29
IL_051a: ldnull
IL_051b: callvirt System.Object System.Reflection.MethodBase::Invoke(System.Object,System.Object[])
IL_0520: pop
IL_0521: nop
IL_0522: br IL_105b
IL_0527: ldloc.1
IL_0528: ldstr "complete-tutorial158"
IL_052d: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0532: stloc.s V_31
IL_0534: ldloc.s V_31
IL_0536: brfalse IL_05d9
IL_053b: nop
IL_053c: ldarg.0
IL_053d: ldfld System.Boolean ForestProbe::tutorial158Completed
IL_0542: stloc.s V_34
IL_0544: ldloc.s V_34
IL_0546: brfalse.s IL_0553
IL_0548: ldstr "Tutorial158 completion already acknowledged; no replay"
IL_054d: newobj System.Void System.Exception::.ctor(System.String)
IL_0552: throw
IL_0553: ldarg.0
IL_0554: ldloca.s V_32
IL_0556: call ForestProbe/TutorialCompletion ForestProbe::ReadTutorialCompletion(UnityEngine.UI.Button&)
IL_055b: stloc.s V_33
IL_055d: ldloc.s V_33
IL_055f: ldfld System.Boolean ForestProbe/TutorialCompletion::typing
IL_0564: stloc.s V_35
IL_0566: ldloc.s V_35
IL_0568: brfalse.s IL_0575
IL_056a: ldstr "Tutorial158 still typing; no completion"
IL_056f: newobj System.Void System.Exception::.ctor(System.String)
IL_0574: throw
IL_0575: ldloc.s V_33
IL_0577: ldloc.s V_33
IL_0579: ldfld System.Boolean ForestProbe/TutorialCompletion::menuPresent
IL_057e: brtrue.s IL_0587
IL_0580: ldstr "applied"
IL_0585: br.s IL_058c
IL_0587: ldstr "menu-present"
IL_058c: stfld System.String ForestProbe/TutorialCompletion::result
IL_0591: ldloc.s V_33
IL_0593: ldfld System.Boolean ForestProbe/TutorialCompletion::menuPresent
IL_0598: ldc.i4.0
IL_0599: ceq
IL_059b: stloc.s V_36
IL_059d: ldloc.s V_36
IL_059f: brfalse.s IL_05ae
IL_05a1: ldloc.s V_32
IL_05a3: callvirt UnityEngine.UI.Button/ButtonClickedEvent UnityEngine.UI.Button::get_onClick()
IL_05a8: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_05ad: nop
IL_05ae: ldarg.0
IL_05af: ldc.i4.1
IL_05b0: stfld System.Boolean ForestProbe::tutorial158Completed
IL_05b5: ldarg.0
IL_05b6: ldfld System.String ForestProbe::root
IL_05bb: ldstr "completion158-receipt.json"
IL_05c0: call System.String System.IO.Path::Combine(System.String,System.String)
IL_05c5: ldloc.s V_33
IL_05c7: ldc.i4.1
IL_05c8: call System.String UnityEngine.JsonUtility::ToJson(System.Object,System.Boolean)
IL_05cd: call System.Void System.IO.File::WriteAllText(System.String,System.String)
IL_05d2: nop
IL_05d3: nop
IL_05d4: br IL_105b
IL_05d9: ldloc.1
IL_05da: ldstr "select-tutorial181 "
IL_05df: callvirt System.Boolean System.String::StartsWith(System.String)
IL_05e4: stloc.s V_37
IL_05e6: ldloc.s V_37
IL_05e8: brfalse IL_06de
IL_05ed: nop
IL_05ee: ldarg.0
IL_05ef: ldfld System.Boolean ForestProbe::tutorial181Selected
IL_05f4: stloc.s V_43
IL_05f6: ldloc.s V_43
IL_05f8: brfalse.s IL_0605
IL_05fa: ldstr "Tutorial181 already selected; no replay"
IL_05ff: newobj System.Void System.Exception::.ctor(System.String)
IL_0604: throw
IL_0605: ldloc.1
IL_0606: ldc.i4.s 19
IL_0608: callvirt System.String System.String::Substring(System.Int32)
IL_060d: ldc.i4.1
IL_060e: newarr System.Char
IL_0613: dup
IL_0614: ldc.i4.0
IL_0615: ldc.i4.s 32
IL_0617: stelem.i2
IL_0618: callvirt System.String[] System.String::Split(System.Char[])
IL_061d: stloc.s V_38
IL_061f: ldloc.s V_38
IL_0621: ldlen
IL_0622: conv.i4
IL_0623: ldc.i4.2
IL_0624: ceq
IL_0626: ldc.i4.0
IL_0627: ceq
IL_0629: stloc.s V_44
IL_062b: ldloc.s V_44
IL_062d: brfalse.s IL_063a
IL_062f: ldstr "Expected observed frame and original button identity"
IL_0634: newobj System.Void System.Exception::.ctor(System.String)
IL_0639: throw
IL_063a: ldloc.s V_38
IL_063c: ldc.i4.0
IL_063d: ldelem.ref
IL_063e: call System.Int32 System.Int32::Parse(System.String)
IL_0643: stloc.s V_39
IL_0645: ldloc.s V_38
IL_0647: ldc.i4.1
IL_0648: ldelem.ref
IL_0649: call System.Int32 System.Int32::Parse(System.String)
IL_064e: stloc.s V_40
IL_0650: ldarg.0
IL_0651: ldloca.s V_41
IL_0653: call ForestProbe/Tutorial181Selection ForestProbe::ReadTutorial181(UnityEngine.UI.Button&)
IL_0658: stloc.s V_42
IL_065a: ldloc.s V_39
IL_065c: ldc.i4.0
IL_065d: ble.s IL_0688
IL_065f: ldloc.s V_39
IL_0661: ldloc.s V_42
IL_0663: ldfld System.Int32 ForestProbe/Tutorial181Selection::frame
IL_0668: bgt.s IL_0688
IL_066a: ldloc.s V_42
IL_066c: ldfld System.Int32 ForestProbe/Tutorial181Selection::frame
IL_0671: ldloc.s V_39
IL_0673: sub
IL_0674: ldc.i4.s 120
IL_0676: bgt.s IL_0688
IL_0678: ldloc.s V_42
IL_067a: ldfld System.Int32 ForestProbe/Tutorial181Selection::buttonInstance
IL_067f: ldloc.s V_40
IL_0681: ceq
IL_0683: ldc.i4.0
IL_0684: ceq
IL_0686: br.s IL_0689
IL_0688: ldc.i4.1
IL_0689: stloc.s V_45
IL_068b: ldloc.s V_45
IL_068d: brfalse.s IL_069a
IL_068f: ldstr "Stale Tutorial181 menu/control"
IL_0694: newobj System.Void System.Exception::.ctor(System.String)
IL_0699: throw
IL_069a: ldarg.0
IL_069b: ldc.i4.1
IL_069c: stfld System.Boolean ForestProbe::tutorial181Selected
IL_06a1: ldloc.s V_42
IL_06a3: ldstr "submitted"
IL_06a8: stfld System.String ForestProbe/Tutorial181Selection::result
IL_06ad: ldarg.0
IL_06ae: ldfld System.String ForestProbe::root
IL_06b3: ldstr "selection181-receipt.json"
IL_06b8: call System.String System.IO.Path::Combine(System.String,System.String)
IL_06bd: ldloc.s V_42
IL_06bf: ldc.i4.1
IL_06c0: call System.String UnityEngine.JsonUtility::ToJson(System.Object,System.Boolean)
IL_06c5: call System.Void System.IO.File::WriteAllText(System.String,System.String)
IL_06ca: nop
IL_06cb: ldloc.s V_41
IL_06cd: callvirt UnityEngine.UI.Button/ButtonClickedEvent UnityEngine.UI.Button::get_onClick()
IL_06d2: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_06d7: nop
IL_06d8: nop
IL_06d9: br IL_105b
IL_06de: ldloc.1
IL_06df: ldstr "continue-bound "
IL_06e4: callvirt System.Boolean System.String::StartsWith(System.String)
IL_06e9: stloc.s V_46
IL_06eb: ldloc.s V_46
IL_06ed: brfalse IL_083d
IL_06f2: nop
IL_06f3: ldloc.1
IL_06f4: ldc.i4.s 15
IL_06f6: callvirt System.String System.String::Substring(System.Int32)
IL_06fb: ldc.i4.1
IL_06fc: newarr System.Char
IL_0701: dup
IL_0702: ldc.i4.0
IL_0703: ldc.i4.s 32
IL_0705: stelem.i2
IL_0706: callvirt System.String[] System.String::Split(System.Char[])
IL_070b: stloc.s V_47
IL_070d: ldloc.s V_47
IL_070f: ldlen
IL_0710: conv.i4
IL_0711: ldc.i4.2
IL_0712: ceq
IL_0714: ldc.i4.0
IL_0715: ceq
IL_0717: stloc.s V_54
IL_0719: ldloc.s V_54
IL_071b: brfalse.s IL_0728
IL_071d: ldstr "Expected conversation and source entry"
IL_0722: newobj System.Void System.Exception::.ctor(System.String)
IL_0727: throw
IL_0728: ldloc.s V_47
IL_072a: ldc.i4.0
IL_072b: ldelem.ref
IL_072c: call System.Int32 System.Int32::Parse(System.String)
IL_0731: stloc.s V_48
IL_0733: ldloc.s V_47
IL_0735: ldc.i4.1
IL_0736: ldelem.ref
IL_0737: call System.Int32 System.Int32::Parse(System.String)
IL_073c: stloc.s V_49
IL_073e: ldloc.s V_48
IL_0740: ldc.i4.s 120
IL_0742: bne.un.s IL_074f
IL_0744: ldloc.s V_49
IL_0746: ldc.i4 158
IL_074b: ceq
IL_074d: br.s IL_0750
IL_074f: ldc.i4.0
IL_0750: stloc.s V_55
IL_0752: ldloc.s V_55
IL_0754: brfalse.s IL_0761
IL_0756: ldstr "Tutorial158 requires guarded completion"
IL_075b: newobj System.Void System.Exception::.ctor(System.String)
IL_0760: throw
IL_0761: call PixelCrushers.DialogueSystem.ConversationState PixelCrushers.DialogueSystem.DialogueManager::get_currentConversationState()
IL_0766: stloc.s V_50
IL_0768: ldloc.s V_50
IL_076a: brfalse.s IL_0783
IL_076c: ldloc.s V_50
IL_076e: ldfld PixelCrushers.DialogueSystem.Subtitle PixelCrushers.DialogueSystem.ConversationState::subtitle
IL_0773: brfalse.s IL_0783
IL_0775: ldloc.s V_50
IL_0777: ldfld PixelCrushers.DialogueSystem.Subtitle PixelCrushers.DialogueSystem.ConversationState::subtitle
IL_077c: ldfld PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Subtitle::dialogueEntry
IL_0781: br.s IL_0784
IL_0783: ldnull
IL_0784: stloc.s V_51
IL_0786: newobj System.Void ForestProbe/ContinueReceipt::.ctor()
IL_078b: dup
IL_078c: call System.Boolean PixelCrushers.DialogueSystem.DialogueManager::get_isConversationActive()
IL_0791: stfld System.Boolean ForestProbe/ContinueReceipt::active
IL_0796: dup
IL_0797: ldloc.s V_48
IL_0799: stfld System.Int32 ForestProbe/ContinueReceipt::expectedConversationId
IL_079e: dup
IL_079f: ldloc.s V_49
IL_07a1: stfld System.Int32 ForestProbe/ContinueReceipt::expectedEntryId
IL_07a6: dup
IL_07a7: ldloc.s V_51
IL_07a9: brfalse.s IL_07b4
IL_07ab: ldloc.s V_51
IL_07ad: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::conversationID
IL_07b2: br.s IL_07b5
IL_07b4: ldc.i4.m1
IL_07b5: stfld System.Int32 ForestProbe/ContinueReceipt::actualConversationId
IL_07ba: dup
IL_07bb: ldloc.s V_51
IL_07bd: brfalse.s IL_07c8
IL_07bf: ldloc.s V_51
IL_07c1: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_07c6: br.s IL_07c9
IL_07c8: ldc.i4.m1
IL_07c9: stfld System.Int32 ForestProbe/ContinueReceipt::actualEntryId
IL_07ce: stloc.s V_52
IL_07d0: ldloc.s V_52
IL_07d2: ldfld System.Boolean ForestProbe/ContinueReceipt::active
IL_07d7: brfalse.s IL_07f1
IL_07d9: ldloc.s V_52
IL_07db: ldfld System.Int32 ForestProbe/ContinueReceipt::actualConversationId
IL_07e0: ldloc.s V_48
IL_07e2: bne.un.s IL_07f1
IL_07e4: ldloc.s V_52
IL_07e6: ldfld System.Int32 ForestProbe/ContinueReceipt::actualEntryId
IL_07eb: ldloc.s V_49
IL_07ed: ceq
IL_07ef: br.s IL_07f2
IL_07f1: ldc.i4.0
IL_07f2: stloc.s V_53
IL_07f4: ldloc.s V_53
IL_07f6: stloc.s V_56
IL_07f8: ldloc.s V_56
IL_07fa: brfalse.s IL_0802
IL_07fc: call System.Void TheForestOfLove.CustomTypewriterEffectTextMeshPro::FastForwardTextOrAdvanceDialogue()
IL_0801: nop
IL_0802: ldloc.s V_52
IL_0804: ldloc.s V_53
IL_0806: brtrue.s IL_080f
IL_0808: ldstr "stale"
IL_080d: br.s IL_0814
IL_080f: ldstr "applied"
IL_0814: stfld System.String ForestProbe/ContinueReceipt::result
IL_0819: ldarg.0
IL_081a: ldfld System.String ForestProbe::root
IL_081f: ldstr "continue-receipt.json"
IL_0824: call System.String System.IO.Path::Combine(System.String,System.String)
IL_0829: ldloc.s V_52
IL_082b: ldc.i4.1
IL_082c: call System.String UnityEngine.JsonUtility::ToJson(System.Object,System.Boolean)
IL_0831: call System.Void System.IO.File::WriteAllText(System.String,System.String)
IL_0836: nop
IL_0837: nop
IL_0838: br IL_105b
IL_083d: ldloc.1
IL_083e: ldstr "continue"
IL_0843: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0848: stloc.s V_57
IL_084a: ldloc.s V_57
IL_084c: brfalse.s IL_0874
IL_084e: nop
IL_084f: call System.Boolean PixelCrushers.DialogueSystem.DialogueManager::get_isConversationActive()
IL_0854: ldc.i4.0
IL_0855: ceq
IL_0857: stloc.s V_58
IL_0859: ldloc.s V_58
IL_085b: brfalse.s IL_0868
IL_085d: ldstr "No active conversation"
IL_0862: newobj System.Void System.Exception::.ctor(System.String)
IL_0867: throw
IL_0868: call System.Void TheForestOfLove.CustomTypewriterEffectTextMeshPro::FastForwardTextOrAdvanceDialogue()
IL_086d: nop
IL_086e: nop
IL_086f: br IL_105b
IL_0874: ldloc.1
IL_0875: ldstr "response "
IL_087a: callvirt System.Boolean System.String::StartsWith(System.String)
IL_087f: stloc.s V_59
IL_0881: ldloc.s V_59
IL_0883: brfalse IL_0a77
IL_0888: nop
IL_0889: ldloc.1
IL_088a: ldc.i4.s 9
IL_088c: callvirt System.String System.String::Substring(System.Int32)
IL_0891: ldc.i4.1
IL_0892: newarr System.Char
IL_0897: dup
IL_0898: ldc.i4.0
IL_0899: ldc.i4.s 32
IL_089b: stelem.i2
IL_089c: callvirt System.String[] System.String::Split(System.Char[])
IL_08a1: stloc.s V_60
IL_08a3: ldloc.s V_60
IL_08a5: ldlen
IL_08a6: conv.i4
IL_08a7: ldc.i4.3
IL_08a8: ceq
IL_08aa: ldc.i4.0
IL_08ab: ceq
IL_08ad: stloc.s V_66
IL_08af: ldloc.s V_66
IL_08b1: brfalse.s IL_08be
IL_08b3: ldstr "Expected source entry, conversation and destination entry"
IL_08b8: newobj System.Void System.Exception::.ctor(System.String)
IL_08bd: throw
IL_08be: ldloc.s V_60
IL_08c0: ldc.i4.0
IL_08c1: ldelem.ref
IL_08c2: call System.Int32 System.Int32::Parse(System.String)
IL_08c7: stloc.s V_61
IL_08c9: ldloc.s V_60
IL_08cb: ldc.i4.1
IL_08cc: ldelem.ref
IL_08cd: call System.Int32 System.Int32::Parse(System.String)
IL_08d2: stloc.s V_62
IL_08d4: ldloc.s V_60
IL_08d6: ldc.i4.2
IL_08d7: ldelem.ref
IL_08d8: call System.Int32 System.Int32::Parse(System.String)
IL_08dd: stloc.s V_63
IL_08df: ldloc.s V_62
IL_08e1: ldc.i4.s 120
IL_08e3: bne.un.s IL_08f0
IL_08e5: ldloc.s V_61
IL_08e7: ldc.i4 158
IL_08ec: ceq
IL_08ee: br.s IL_08f1
IL_08f0: ldc.i4.0
IL_08f1: stloc.s V_67
IL_08f3: ldloc.s V_67
IL_08f5: brfalse.s IL_0902
IL_08f7: ldstr "Tutorial159/181 choices forbidden"
IL_08fc: newobj System.Void System.Exception::.ctor(System.String)
IL_0901: throw
IL_0902: call PixelCrushers.DialogueSystem.ConversationState PixelCrushers.DialogueSystem.DialogueManager::get_currentConversationState()
IL_0907: stloc.s V_64
IL_0909: call System.Boolean PixelCrushers.DialogueSystem.DialogueManager::get_isConversationActive()
IL_090e: brfalse.s IL_095a
IL_0910: ldloc.s V_64
IL_0912: brfalse.s IL_095a
IL_0914: ldloc.s V_64
IL_0916: ldfld PixelCrushers.DialogueSystem.Subtitle PixelCrushers.DialogueSystem.ConversationState::subtitle
IL_091b: brfalse.s IL_095a
IL_091d: ldloc.s V_64
IL_091f: ldfld PixelCrushers.DialogueSystem.Subtitle PixelCrushers.DialogueSystem.ConversationState::subtitle
IL_0924: ldfld PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Subtitle::dialogueEntry
IL_0929: brfalse.s IL_095a
IL_092b: ldloc.s V_64
IL_092d: ldfld PixelCrushers.DialogueSystem.Subtitle PixelCrushers.DialogueSystem.ConversationState::subtitle
IL_0932: ldfld PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Subtitle::dialogueEntry
IL_0937: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::conversationID
IL_093c: ldloc.s V_62
IL_093e: bne.un.s IL_095a
IL_0940: ldloc.s V_64
IL_0942: ldfld PixelCrushers.DialogueSystem.Subtitle PixelCrushers.DialogueSystem.ConversationState::subtitle
IL_0947: ldfld PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Subtitle::dialogueEntry
IL_094c: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_0951: ldloc.s V_61
IL_0953: ceq
IL_0955: ldc.i4.0
IL_0956: ceq
IL_0958: br.s IL_095b
IL_095a: ldc.i4.1
IL_095b: stloc.s V_68
IL_095d: ldloc.s V_68
IL_095f: brfalse.s IL_096c
IL_0961: ldstr "Response source changed"
IL_0966: newobj System.Void System.Exception::.ctor(System.String)
IL_096b: throw
IL_096c: ldnull
IL_096d: stloc.s V_65
IL_096f: nop
IL_0970: call !!0[] UnityEngine.Resources::FindObjectsOfTypeAll<PixelCrushers.DialogueSystem.StandardUIResponseButton>()
IL_0975: stloc.s V_69
IL_0977: ldc.i4.0
IL_0978: stloc.s V_70
IL_097a: br.s IL_09e6
IL_097c: ldloc.s V_69
IL_097e: ldloc.s V_70
IL_0980: ldelem.ref
IL_0981: stloc.s V_71
IL_0983: ldloc.s V_71
IL_0985: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_098a: callvirt UnityEngine.SceneManagement.Scene UnityEngine.GameObject::get_scene()
IL_098f: stloc.s V_10
IL_0991: ldloca.s V_10
IL_0993: call System.Boolean UnityEngine.SceneManagement.Scene::IsValid()
IL_0998: brfalse.s IL_09ba
IL_099a: ldloc.s V_71
IL_099c: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_09a1: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_09a6: brfalse.s IL_09ba
IL_09a8: ldloc.s V_71
IL_09aa: callvirt System.Boolean PixelCrushers.DialogueSystem.StandardUIResponseButton::get_isVisible()
IL_09af: brfalse.s IL_09ba
IL_09b1: ldloc.s V_71
IL_09b3: callvirt System.Boolean PixelCrushers.DialogueSystem.StandardUIResponseButton::get_isClickable()
IL_09b8: br.s IL_09bb
IL_09ba: ldc.i4.0
IL_09bb: stloc.s V_72
IL_09bd: ldloc.s V_72
IL_09bf: brfalse.s IL_09e0
IL_09c1: nop
IL_09c2: ldloc.s V_65
IL_09c4: ldnull
IL_09c5: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_09ca: stloc.s V_73
IL_09cc: ldloc.s V_73
IL_09ce: brfalse.s IL_09db
IL_09d0: ldstr "More than one live response; hold for source review"
IL_09d5: newobj System.Void System.Exception::.ctor(System.String)
IL_09da: throw
IL_09db: ldloc.s V_71
IL_09dd: stloc.s V_65
IL_09df: nop
IL_09e0: ldloc.s V_70
IL_09e2: ldc.i4.1
IL_09e3: add
IL_09e4: stloc.s V_70
IL_09e6: ldloc.s V_70
IL_09e8: ldloc.s V_69
IL_09ea: ldlen
IL_09eb: conv.i4
IL_09ec: blt.s IL_097c
IL_09ee: ldloc.s V_65
IL_09f0: ldnull
IL_09f1: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_09f6: brtrue.s IL_0a4d
IL_09f8: ldloc.s V_65
IL_09fa: callvirt PixelCrushers.DialogueSystem.Response PixelCrushers.DialogueSystem.StandardUIResponseButton::get_response()
IL_09ff: brfalse.s IL_0a4d
IL_0a01: ldloc.s V_65
IL_0a03: callvirt PixelCrushers.DialogueSystem.Response PixelCrushers.DialogueSystem.StandardUIResponseButton::get_response()
IL_0a08: ldfld PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Response::destinationEntry
IL_0a0d: brfalse.s IL_0a4d
IL_0a0f: ldloc.s V_65
IL_0a11: callvirt UnityEngine.Transform PixelCrushers.DialogueSystem.StandardUIResponseButton::get_target()
IL_0a16: ldnull
IL_0a17: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0a1c: brtrue.s IL_0a4d
IL_0a1e: ldloc.s V_65
IL_0a20: callvirt PixelCrushers.DialogueSystem.Response PixelCrushers.DialogueSystem.StandardUIResponseButton::get_response()
IL_0a25: ldfld PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Response::destinationEntry
IL_0a2a: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::conversationID
IL_0a2f: ldloc.s V_62
IL_0a31: bne.un.s IL_0a4d
IL_0a33: ldloc.s V_65
IL_0a35: callvirt PixelCrushers.DialogueSystem.Response PixelCrushers.DialogueSystem.StandardUIResponseButton::get_response()
IL_0a3a: ldfld PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Response::destinationEntry
IL_0a3f: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_0a44: ldloc.s V_63
IL_0a46: ceq
IL_0a48: ldc.i4.0
IL_0a49: ceq
IL_0a4b: br.s IL_0a4e
IL_0a4d: ldc.i4.1
IL_0a4e: stloc.s V_74
IL_0a50: ldloc.s V_74
IL_0a52: brfalse.s IL_0a5f
IL_0a54: ldstr "Response does not match source-bound successor"
IL_0a59: newobj System.Void System.Exception::.ctor(System.String)
IL_0a5e: throw
IL_0a5f: ldloc.s V_65
IL_0a61: ldfld UnityEngine.UI.Button PixelCrushers.DialogueSystem.StandardUIResponseButton::button
IL_0a66: callvirt UnityEngine.UI.Button/ButtonClickedEvent UnityEngine.UI.Button::get_onClick()
IL_0a6b: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_0a70: nop
IL_0a71: nop
IL_0a72: br IL_105b
IL_0a77: ldloc.1
IL_0a78: ldstr "probe-nameplate"
IL_0a7d: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0a82: stloc.s V_75
IL_0a84: ldloc.s V_75
IL_0a86: brfalse.s IL_0af6
IL_0a88: nop
IL_0a89: call System.Boolean PixelCrushers.DialogueSystem.DialogueManager::get_isConversationActive()
IL_0a8e: ldc.i4.0
IL_0a8f: ceq
IL_0a91: stloc.s V_77
IL_0a93: ldloc.s V_77
IL_0a95: brfalse.s IL_0aa2
IL_0a97: ldstr "No active conversation"
IL_0a9c: newobj System.Void System.Exception::.ctor(System.String)
IL_0aa1: throw
IL_0aa2: call !!0 UnityEngine.Object::FindObjectOfType<TheForestOfLove.DialogueNameplateController>()
IL_0aa7: stloc.s V_76
IL_0aa9: ldloc.s V_76
IL_0aab: ldnull
IL_0aac: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0ab1: stloc.s V_78
IL_0ab3: ldloc.s V_78
IL_0ab5: brfalse.s IL_0ac2
IL_0ab7: ldstr "No active nameplate controller"
IL_0abc: newobj System.Void System.Exception::.ctor(System.String)
IL_0ac1: throw
IL_0ac2: ldloc.s V_76
IL_0ac4: ldstr "Ёж Йй 123"
IL_0ac9: callvirt System.Void TheForestOfLove.DialogueNameplateController::SetCustomNameplateUntilCleared(System.String)
IL_0ace: nop
IL_0acf: ldloc.s V_76
IL_0ad1: callvirt System.Type System.Object::GetType()
IL_0ad6: ldstr "UpdateNameplate"
IL_0adb: ldc.i4.s 36
IL_0add: callvirt System.Reflection.MethodInfo System.Type::GetMethod(System.String,System.Reflection.BindingFlags)
IL_0ae2: ldloc.s V_76
IL_0ae4: ldc.i4.1
IL_0ae5: newarr System.Object
IL_0aea: callvirt System.Object System.Reflection.MethodBase::Invoke(System.Object,System.Object[])
IL_0aef: pop
IL_0af0: nop
IL_0af1: br IL_105b
IL_0af6: ldloc.1
IL_0af7: ldstr "capture "
IL_0afc: callvirt System.Boolean System.String::StartsWith(System.String)
IL_0b01: stloc.s V_79
IL_0b03: ldloc.s V_79
IL_0b05: brfalse.s IL_0b80
IL_0b07: nop
IL_0b08: ldloc.1
IL_0b09: ldc.i4.8
IL_0b0a: callvirt System.String System.String::Substring(System.Int32)
IL_0b0f: stloc.s V_80
IL_0b11: ldloc.s V_80
IL_0b13: call System.String System.IO.Path::GetFileName(System.String)
IL_0b18: ldloc.s V_80
IL_0b1a: call System.Boolean System.String::op_Inequality(System.String,System.String)
IL_0b1f: brtrue.s IL_0b32
IL_0b21: ldloc.s V_80
IL_0b23: ldstr ".png"
IL_0b28: callvirt System.Boolean System.String::EndsWith(System.String)
IL_0b2d: ldc.i4.0
IL_0b2e: ceq
IL_0b30: br.s IL_0b33
IL_0b32: ldc.i4.1
IL_0b33: stloc.s V_82
IL_0b35: ldloc.s V_82
IL_0b37: brfalse.s IL_0b44
IL_0b39: ldstr "Invalid capture name"
IL_0b3e: newobj System.Void System.Exception::.ctor(System.String)
IL_0b43: throw
IL_0b44: ldarg.0
IL_0b45: ldfld System.String ForestProbe::root
IL_0b4a: ldloc.s V_80
IL_0b4c: call System.String System.IO.Path::Combine(System.String,System.String)
IL_0b51: stloc.s V_81
IL_0b53: ldloc.s V_81
IL_0b55: call System.Boolean System.IO.File::Exists(System.String)
IL_0b5a: stloc.s V_83
IL_0b5c: ldloc.s V_83
IL_0b5e: brfalse.s IL_0b6b
IL_0b60: ldstr "Capture already exists"
IL_0b65: newobj System.Void System.Exception::.ctor(System.String)
IL_0b6a: throw
IL_0b6b: ldarg.0
IL_0b6c: ldarg.0
IL_0b6d: ldloc.s V_81
IL_0b6f: call System.Collections.IEnumerator ForestProbe::Capture(System.String)
IL_0b74: call UnityEngine.Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)
IL_0b79: pop
IL_0b7a: nop
IL_0b7b: br IL_105b
IL_0b80: ldloc.1
IL_0b81: ldstr "select "
IL_0b86: callvirt System.Boolean System.String::StartsWith(System.String)
IL_0b8b: stloc.s V_84
IL_0b8d: ldloc.s V_84
IL_0b8f: brfalse IL_0c74
IL_0b94: nop
IL_0b95: ldloc.1
IL_0b96: ldc.i4.7
IL_0b97: callvirt System.String System.String::Substring(System.Int32)
IL_0b9c: stloc.s V_85
IL_0b9e: ldnull
IL_0b9f: stloc.s V_86
IL_0ba1: nop
IL_0ba2: call !!0[] UnityEngine.Resources::FindObjectsOfTypeAll<UnityEngine.UI.Selectable>()
IL_0ba7: stloc.s V_87
IL_0ba9: ldc.i4.0
IL_0baa: stloc.s V_88
IL_0bac: br.s IL_0c24
IL_0bae: ldloc.s V_87
IL_0bb0: ldloc.s V_88
IL_0bb2: ldelem.ref
IL_0bb3: stloc.s V_89
IL_0bb5: ldloc.s V_89
IL_0bb7: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0bbc: callvirt UnityEngine.SceneManagement.Scene UnityEngine.GameObject::get_scene()
IL_0bc1: stloc.s V_10
IL_0bc3: ldloca.s V_10
IL_0bc5: call System.Boolean UnityEngine.SceneManagement.Scene::IsValid()
IL_0bca: brfalse.s IL_0bf8
IL_0bcc: ldloc.s V_89
IL_0bce: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0bd3: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_0bd8: brfalse.s IL_0bf8
IL_0bda: ldloc.s V_89
IL_0bdc: callvirt System.Boolean UnityEngine.UI.Selectable::IsInteractable()
IL_0be1: brfalse.s IL_0bf8
IL_0be3: ldloc.s V_89
IL_0be5: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0bea: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_0bef: ldloc.s V_85
IL_0bf1: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0bf6: br.s IL_0bf9
IL_0bf8: ldc.i4.0
IL_0bf9: stloc.s V_90
IL_0bfb: ldloc.s V_90
IL_0bfd: brfalse.s IL_0c1e
IL_0bff: nop
IL_0c00: ldloc.s V_86
IL_0c02: ldnull
IL_0c03: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0c08: stloc.s V_91
IL_0c0a: ldloc.s V_91
IL_0c0c: brfalse.s IL_0c19
IL_0c0e: ldstr "Duplicate active selectable"
IL_0c13: newobj System.Void System.Exception::.ctor(System.String)
IL_0c18: throw
IL_0c19: ldloc.s V_89
IL_0c1b: stloc.s V_86
IL_0c1d: nop
IL_0c1e: ldloc.s V_88
IL_0c20: ldc.i4.1
IL_0c21: add
IL_0c22: stloc.s V_88
IL_0c24: ldloc.s V_88
IL_0c26: ldloc.s V_87
IL_0c28: ldlen
IL_0c29: conv.i4
IL_0c2a: blt.s IL_0bae
IL_0c2c: ldloc.s V_86
IL_0c2e: ldnull
IL_0c2f: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0c34: brtrue.s IL_0c43
IL_0c36: call UnityEngine.EventSystems.EventSystem UnityEngine.EventSystems.EventSystem::get_current()
IL_0c3b: ldnull
IL_0c3c: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0c41: br.s IL_0c44
IL_0c43: ldc.i4.1
IL_0c44: stloc.s V_92
IL_0c46: ldloc.s V_92
IL_0c48: brfalse.s IL_0c5c
IL_0c4a: ldstr "No selectable/event system: "
IL_0c4f: ldloc.s V_85
IL_0c51: call System.String System.String::Concat(System.String,System.String)
IL_0c56: newobj System.Void System.Exception::.ctor(System.String)
IL_0c5b: throw
IL_0c5c: call UnityEngine.EventSystems.EventSystem UnityEngine.EventSystems.EventSystem::get_current()
IL_0c61: ldloc.s V_86
IL_0c63: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0c68: callvirt System.Void UnityEngine.EventSystems.EventSystem::SetSelectedGameObject(UnityEngine.GameObject)
IL_0c6d: nop
IL_0c6e: nop
IL_0c6f: br IL_105b
IL_0c74: ldloc.1
IL_0c75: ldstr "move-left"
IL_0c7a: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0c7f: brtrue.s IL_0c8e
IL_0c81: ldloc.1
IL_0c82: ldstr "move-right"
IL_0c87: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0c8c: br.s IL_0c8f
IL_0c8e: ldc.i4.1
IL_0c8f: stloc.s V_93
IL_0c91: ldloc.s V_93
IL_0c93: brfalse IL_0d19
IL_0c98: nop
IL_0c99: call UnityEngine.EventSystems.EventSystem UnityEngine.EventSystems.EventSystem::get_current()
IL_0c9e: stloc.s V_94
IL_0ca0: ldloc.s V_94
IL_0ca2: ldnull
IL_0ca3: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0ca8: brtrue.s IL_0cb9
IL_0caa: ldloc.s V_94
IL_0cac: callvirt UnityEngine.GameObject UnityEngine.EventSystems.EventSystem::get_currentSelectedGameObject()
IL_0cb1: ldnull
IL_0cb2: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0cb7: br.s IL_0cba
IL_0cb9: ldc.i4.1
IL_0cba: stloc.s V_96
IL_0cbc: ldloc.s V_96
IL_0cbe: brfalse.s IL_0ccb
IL_0cc0: ldstr "No selected control"
IL_0cc5: newobj System.Void System.Exception::.ctor(System.String)
IL_0cca: throw
IL_0ccb: ldloc.s V_94
IL_0ccd: newobj System.Void UnityEngine.EventSystems.AxisEventData::.ctor(UnityEngine.EventSystems.EventSystem)
IL_0cd2: dup
IL_0cd3: ldloc.1
IL_0cd4: ldstr "move-left"
IL_0cd9: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0cde: brtrue.s IL_0ce3
IL_0ce0: ldc.i4.2
IL_0ce1: br.s IL_0ce4
IL_0ce3: ldc.i4.0
IL_0ce4: callvirt System.Void UnityEngine.EventSystems.AxisEventData::set_moveDir(UnityEngine.EventSystems.MoveDirection)
IL_0ce9: nop
IL_0cea: stloc.s V_95
IL_0cec: ldloc.s V_94
IL_0cee: callvirt UnityEngine.GameObject UnityEngine.EventSystems.EventSystem::get_currentSelectedGameObject()
IL_0cf3: ldloc.s V_95
IL_0cf5: call UnityEngine.EventSystems.ExecuteEvents/EventFunction`1<UnityEngine.EventSystems.IMoveHandler> UnityEngine.EventSystems.ExecuteEvents::get_moveHandler()
IL_0cfa: call System.Boolean UnityEngine.EventSystems.ExecuteEvents::Execute<UnityEngine.EventSystems.IMoveHandler>(UnityEngine.GameObject,UnityEngine.EventSystems.BaseEventData,UnityEngine.EventSystems.ExecuteEvents/EventFunction`1<!!0>)
IL_0cff: ldc.i4.0
IL_0d00: ceq
IL_0d02: stloc.s V_97
IL_0d04: ldloc.s V_97
IL_0d06: brfalse.s IL_0d13
IL_0d08: ldstr "No move handler"
IL_0d0d: newobj System.Void System.Exception::.ctor(System.String)
IL_0d12: throw
IL_0d13: nop
IL_0d14: br IL_105b
IL_0d19: ldloc.1
IL_0d1a: ldstr "click "
IL_0d1f: callvirt System.Boolean System.String::StartsWith(System.String)
IL_0d24: stloc.s V_98
IL_0d26: ldloc.s V_98
IL_0d28: brfalse IL_0de1
IL_0d2d: nop
IL_0d2e: ldloc.1
IL_0d2f: ldc.i4.6
IL_0d30: callvirt System.String System.String::Substring(System.Int32)
IL_0d35: stloc.s V_99
IL_0d37: ldnull
IL_0d38: stloc.s V_100
IL_0d3a: nop
IL_0d3b: call !!0[] UnityEngine.Resources::FindObjectsOfTypeAll<UnityEngine.UI.Button>()
IL_0d40: stloc.s V_101
IL_0d42: ldc.i4.0
IL_0d43: stloc.s V_102
IL_0d45: br.s IL_0da6
IL_0d47: ldloc.s V_101
IL_0d49: ldloc.s V_102
IL_0d4b: ldelem.ref
IL_0d4c: stloc.s V_103
IL_0d4e: ldloc.s V_103
IL_0d50: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0d55: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_0d5a: brfalse.s IL_0d7a
IL_0d5c: ldloc.s V_103
IL_0d5e: callvirt System.Boolean UnityEngine.UI.Selectable::get_interactable()
IL_0d63: brfalse.s IL_0d7a
IL_0d65: ldloc.s V_103
IL_0d67: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0d6c: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_0d71: ldloc.s V_99
IL_0d73: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0d78: br.s IL_0d7b
IL_0d7a: ldc.i4.0
IL_0d7b: stloc.s V_104
IL_0d7d: ldloc.s V_104
IL_0d7f: brfalse.s IL_0da0
IL_0d81: nop
IL_0d82: ldloc.s V_100
IL_0d84: ldnull
IL_0d85: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0d8a: stloc.s V_105
IL_0d8c: ldloc.s V_105
IL_0d8e: brfalse.s IL_0d9b
IL_0d90: ldstr "Duplicate active button"
IL_0d95: newobj System.Void System.Exception::.ctor(System.String)
IL_0d9a: throw
IL_0d9b: ldloc.s V_103
IL_0d9d: stloc.s V_100
IL_0d9f: nop
IL_0da0: ldloc.s V_102
IL_0da2: ldc.i4.1
IL_0da3: add
IL_0da4: stloc.s V_102
IL_0da6: ldloc.s V_102
IL_0da8: ldloc.s V_101
IL_0daa: ldlen
IL_0dab: conv.i4
IL_0dac: blt.s IL_0d47
IL_0dae: ldloc.s V_100
IL_0db0: ldnull
IL_0db1: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0db6: stloc.s V_106
IL_0db8: ldloc.s V_106
IL_0dba: brfalse.s IL_0dce
IL_0dbc: ldstr "No matching active button: "
IL_0dc1: ldloc.s V_99
IL_0dc3: call System.String System.String::Concat(System.String,System.String)
IL_0dc8: newobj System.Void System.Exception::.ctor(System.String)
IL_0dcd: throw
IL_0dce: ldloc.s V_100
IL_0dd0: callvirt UnityEngine.UI.Button/ButtonClickedEvent UnityEngine.UI.Button::get_onClick()
IL_0dd5: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_0dda: nop
IL_0ddb: nop
IL_0ddc: br IL_105b
IL_0de1: ldloc.1
IL_0de2: ldstr "menu "
IL_0de7: callvirt System.Boolean System.String::StartsWith(System.String)
IL_0dec: stloc.s V_107
IL_0dee: ldloc.s V_107
IL_0df0: brfalse IL_1050
IL_0df5: nop
IL_0df6: ldloc.1
IL_0df7: ldc.i4.5
IL_0df8: callvirt System.String System.String::Substring(System.Int32)
IL_0dfd: ldc.i4.1
IL_0dfe: newarr System.Char
IL_0e03: dup
IL_0e04: ldc.i4.0
IL_0e05: ldc.i4.s 32
IL_0e07: stelem.i2
IL_0e08: callvirt System.String[] System.String::Split(System.Char[])
IL_0e0d: stloc.s V_108
IL_0e0f: ldloc.s V_108
IL_0e11: ldlen
IL_0e12: conv.i4
IL_0e13: ldc.i4.2
IL_0e14: bne.un.s IL_0e36
IL_0e16: ldloc.s V_108
IL_0e18: ldc.i4.0
IL_0e19: ldelem.ref
IL_0e1a: ldstr "PlayMenu"
IL_0e1f: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0e24: brfalse.s IL_0e36
IL_0e26: ldloc.s V_108
IL_0e28: ldc.i4.1
IL_0e29: ldelem.ref
IL_0e2a: ldstr "OnClickContinue"
IL_0e2f: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0e34: br.s IL_0e37
IL_0e36: ldc.i4.0
IL_0e37: stloc.s V_109
IL_0e39: ldloc.s V_108
IL_0e3b: ldlen
IL_0e3c: conv.i4
IL_0e3d: ldc.i4.2
IL_0e3e: bne.un.s IL_0ea9
IL_0e40: ldloc.s V_108
IL_0e42: ldc.i4.0
IL_0e43: ldelem.ref
IL_0e44: ldstr "StartScreenMainMenu"
IL_0e49: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0e4e: brtrue.s IL_0e70
IL_0e50: ldloc.s V_108
IL_0e52: ldc.i4.0
IL_0e53: ldelem.ref
IL_0e54: ldstr "PlayMenu"
IL_0e59: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0e5e: brtrue.s IL_0e70
IL_0e60: ldloc.s V_108
IL_0e62: ldc.i4.0
IL_0e63: ldelem.ref
IL_0e64: ldstr "OptionsMenu"
IL_0e69: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0e6e: brfalse.s IL_0ea9
IL_0e70: ldloc.s V_108
IL_0e72: ldc.i4.1
IL_0e73: ldelem.ref
IL_0e74: ldstr "OnClickStart"
IL_0e79: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0e7e: brtrue.s IL_0ea0
IL_0e80: ldloc.s V_108
IL_0e82: ldc.i4.1
IL_0e83: ldelem.ref
IL_0e84: ldstr "OnClickOptions"
IL_0e89: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0e8e: brtrue.s IL_0ea0
IL_0e90: ldloc.s V_108
IL_0e92: ldc.i4.1
IL_0e93: ldelem.ref
IL_0e94: ldstr "OnClickBack"
IL_0e99: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0e9e: br.s IL_0ea1
IL_0ea0: ldc.i4.1
IL_0ea1: ldloc.s V_109
IL_0ea3: or
IL_0ea4: ldc.i4.0
IL_0ea5: ceq
IL_0ea7: br.s IL_0eaa
IL_0ea9: ldc.i4.1
IL_0eaa: stloc.s V_111
IL_0eac: ldloc.s V_111
IL_0eae: brfalse.s IL_0ebb
IL_0eb0: ldstr "Unsupported menu command"
IL_0eb5: newobj System.Void System.Exception::.ctor(System.String)
IL_0eba: throw
IL_0ebb: ldloc.s V_109
IL_0ebd: stloc.s V_112
IL_0ebf: ldloc.s V_112
IL_0ec1: brfalse IL_0fa1
IL_0ec6: nop
IL_0ec7: call System.Boolean TheForestOfLove.Services.Persistence.SaveManager::get_HasSavedPlaySession()
IL_0ecc: brfalse.s IL_0efd
IL_0ece: call UnityEngine.SceneManagement.Scene UnityEngine.SceneManagement.SceneManager::GetActiveScene()
IL_0ed3: stloc.s V_10
IL_0ed5: ldloca.s V_10
IL_0ed7: call System.String UnityEngine.SceneManagement.Scene::get_name()
IL_0edc: ldstr "StartMenu"
IL_0ee1: call System.Boolean System.String::op_Inequality(System.String,System.String)
IL_0ee6: brtrue.s IL_0efd
IL_0ee8: ldsfld System.Boolean Globals::isChapterSelect
IL_0eed: brtrue.s IL_0efd
IL_0eef: ldsfld System.Boolean Globals::isCheatCode
IL_0ef4: brtrue.s IL_0efd
IL_0ef6: call System.Boolean PixelCrushers.DialogueSystem.DialogueManager::get_isConversationActive()
IL_0efb: br.s IL_0efe
IL_0efd: ldc.i4.1
IL_0efe: stloc.s V_114
IL_0f00: ldloc.s V_114
IL_0f02: brfalse.s IL_0f0f
IL_0f04: ldstr "Original saved Continue state unavailable"
IL_0f09: newobj System.Void System.Exception::.ctor(System.String)
IL_0f0e: throw
IL_0f0f: ldc.i4.0
IL_0f10: stloc.s V_113
IL_0f12: nop
IL_0f13: call !!0[] UnityEngine.Resources::FindObjectsOfTypeAll<UnityEngine.UI.Button>()
IL_0f18: stloc.s V_115
IL_0f1a: ldc.i4.0
IL_0f1b: stloc.s V_116
IL_0f1d: br.s IL_0f7f
IL_0f1f: ldloc.s V_115
IL_0f21: ldloc.s V_116
IL_0f23: ldelem.ref
IL_0f24: stloc.s V_117
IL_0f26: ldloc.s V_117
IL_0f28: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0f2d: callvirt UnityEngine.SceneManagement.Scene UnityEngine.GameObject::get_scene()
IL_0f32: stloc.s V_10
IL_0f34: ldloca.s V_10
IL_0f36: call System.Boolean UnityEngine.SceneManagement.Scene::IsValid()
IL_0f3b: brfalse.s IL_0f6c
IL_0f3d: ldloc.s V_117
IL_0f3f: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0f44: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_0f49: brfalse.s IL_0f6c
IL_0f4b: ldloc.s V_117
IL_0f4d: callvirt System.Boolean UnityEngine.UI.Selectable::get_interactable()
IL_0f52: brfalse.s IL_0f6c
IL_0f54: ldloc.s V_117
IL_0f56: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0f5b: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_0f60: ldstr "Canvas/PlayMenu/Controls/Continue"
IL_0f65: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0f6a: br.s IL_0f6d
IL_0f6c: ldc.i4.0
IL_0f6d: stloc.s V_118
IL_0f6f: ldloc.s V_118
IL_0f71: brfalse.s IL_0f79
IL_0f73: ldloc.s V_113
IL_0f75: ldc.i4.1
IL_0f76: add
IL_0f77: stloc.s V_113
IL_0f79: ldloc.s V_116
IL_0f7b: ldc.i4.1
IL_0f7c: add
IL_0f7d: stloc.s V_116
IL_0f7f: ldloc.s V_116
IL_0f81: ldloc.s V_115
IL_0f83: ldlen
IL_0f84: conv.i4
IL_0f85: blt.s IL_0f1f
IL_0f87: ldloc.s V_113
IL_0f89: ldc.i4.1
IL_0f8a: ceq
IL_0f8c: ldc.i4.0
IL_0f8d: ceq
IL_0f8f: stloc.s V_119
IL_0f91: ldloc.s V_119
IL_0f93: brfalse.s IL_0fa0
IL_0f95: ldstr "Exact original Continue control unavailable"
IL_0f9a: newobj System.Void System.Exception::.ctor(System.String)
IL_0f9f: throw
IL_0fa0: nop
IL_0fa1: ldnull
IL_0fa2: stloc.s V_110
IL_0fa4: nop
IL_0fa5: call !!0[] UnityEngine.Resources::FindObjectsOfTypeAll<UnityEngine.MonoBehaviour>()
IL_0faa: stloc.s V_120
IL_0fac: ldc.i4.0
IL_0fad: stloc.s V_121
IL_0faf: br.s IL_1013
IL_0fb1: ldloc.s V_120
IL_0fb3: ldloc.s V_121
IL_0fb5: ldelem.ref
IL_0fb6: stloc.s V_122
IL_0fb8: ldloc.s V_122
IL_0fba: ldnull
IL_0fbb: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0fc0: brfalse.s IL_0fe7
IL_0fc2: ldloc.s V_122
IL_0fc4: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0fc9: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_0fce: brfalse.s IL_0fe7
IL_0fd0: ldloc.s V_122
IL_0fd2: callvirt System.Type System.Object::GetType()
IL_0fd7: callvirt System.String System.Reflection.MemberInfo::get_Name()
IL_0fdc: ldloc.s V_108
IL_0fde: ldc.i4.0
IL_0fdf: ldelem.ref
IL_0fe0: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0fe5: br.s IL_0fe8
IL_0fe7: ldc.i4.0
IL_0fe8: stloc.s V_123
IL_0fea: ldloc.s V_123
IL_0fec: brfalse.s IL_100d
IL_0fee: nop
IL_0fef: ldloc.s V_110
IL_0ff1: ldnull
IL_0ff2: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0ff7: stloc.s V_124
IL_0ff9: ldloc.s V_124
IL_0ffb: brfalse.s IL_1008
IL_0ffd: ldstr "Duplicate active menu"
IL_1002: newobj System.Void System.Exception::.ctor(System.String)
IL_1007: throw
IL_1008: ldloc.s V_122
IL_100a: stloc.s V_110
IL_100c: nop
IL_100d: ldloc.s V_121
IL_100f: ldc.i4.1
IL_1010: add
IL_1011: stloc.s V_121
IL_1013: ldloc.s V_121
IL_1015: ldloc.s V_120
IL_1017: ldlen
IL_1018: conv.i4
IL_1019: blt.s IL_0fb1
IL_101b: ldloc.s V_110
IL_101d: ldnull
IL_101e: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_1023: stloc.s V_125
IL_1025: ldloc.s V_125
IL_1027: brfalse.s IL_1034
IL_1029: ldstr "Menu not active"
IL_102e: newobj System.Void System.Exception::.ctor(System.String)
IL_1033: throw
IL_1034: ldloc.s V_110
IL_1036: callvirt System.Type System.Object::GetType()
IL_103b: ldloc.s V_108
IL_103d: ldc.i4.1
IL_103e: ldelem.ref
IL_103f: callvirt System.Reflection.MethodInfo System.Type::GetMethod(System.String)
IL_1044: ldloc.s V_110
IL_1046: ldnull
IL_1047: callvirt System.Object System.Reflection.MethodBase::Invoke(System.Object,System.Object[])
IL_104c: pop
IL_104d: nop
IL_104e: br.s IL_105b
IL_1050: ldstr "Unsupported command"
IL_1055: newobj System.Void System.Exception::.ctor(System.String)
IL_105a: throw
IL_105b: ldarg.0
IL_105c: ldfld System.String ForestProbe::root
IL_1061: ldstr "actions.log"
IL_1066: call System.String System.IO.Path::Combine(System.String,System.String)
IL_106b: call System.DateTime System.DateTime::get_UtcNow()
IL_1070: stloc.s V_126
IL_1072: ldloca.s V_126
IL_1074: ldstr "O"
IL_1079: call System.String System.DateTime::ToString(System.String)
IL_107e: ldstr " OK "
IL_1083: ldloc.1
IL_1084: ldstr "
"
IL_1089: call System.String System.String::Concat(System.String,System.String,System.String,System.String)
IL_108e: call System.Void System.IO.File::AppendAllText(System.String,System.String)
IL_1093: nop
IL_1094: nop
IL_1095: leave.s IL_1109
IL_1097: stloc.s V_127
IL_1099: nop
IL_109a: ldarg.0
IL_109b: ldfld System.String ForestProbe::root
IL_10a0: ldstr "actions.log"
IL_10a5: call System.String System.IO.Path::Combine(System.String,System.String)
IL_10aa: ldc.i4.6
IL_10ab: newarr System.String
IL_10b0: dup
IL_10b1: ldc.i4.0
IL_10b2: call System.DateTime System.DateTime::get_UtcNow()
IL_10b7: stloc.s V_126
IL_10b9: ldloca.s V_126
IL_10bb: ldstr "O"
IL_10c0: call System.String System.DateTime::ToString(System.String)
IL_10c5: stelem.ref
IL_10c6: dup
IL_10c7: ldc.i4.1
IL_10c8: ldstr " FAIL "
IL_10cd: stelem.ref
IL_10ce: dup
IL_10cf: ldc.i4.2
IL_10d0: ldloc.1
IL_10d1: stelem.ref
IL_10d2: dup
IL_10d3: ldc.i4.3
IL_10d4: ldstr " "
IL_10d9: stelem.ref
IL_10da: dup
IL_10db: ldc.i4.4
IL_10dc: ldloc.s V_127
IL_10de: dup
IL_10df: brtrue.s IL_10e5
IL_10e1: pop
IL_10e2: ldnull
IL_10e3: br.s IL_10ea
IL_10e5: callvirt System.String System.Object::ToString()
IL_10ea: stelem.ref
IL_10eb: dup
IL_10ec: ldc.i4.5
IL_10ed: ldstr "
"
IL_10f2: stelem.ref
IL_10f3: call System.String System.String::Concat(System.String[])
IL_10f8: call System.Void System.IO.File::AppendAllText(System.String,System.String)
IL_10fd: nop
IL_10fe: ldloc.s V_127
IL_1100: call System.Void UnityEngine.Debug::LogException(System.Exception)
IL_1105: nop
IL_1106: nop
IL_1107: leave.s IL_1109
IL_1109: ret
