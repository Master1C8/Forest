METHOD System.Void ForestProbe::Update() | attributes=Private, HideBySig | impl=IL
IL_0000: nop
IL_0001: call System.Single UnityEngine.Time::get_realtimeSinceStartup()
IL_0006: ldarg.0
IL_0007: ldfld System.Single ForestProbe::next
IL_000c: clt
IL_000e: stloc.2
IL_000f: ldloc.2
IL_0010: brfalse.s IL_0017
IL_0012: br IL_12f8
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
IL_0046: br IL_12f8
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
IL_0081: br IL_124a
IL_0086: ldloc.1
IL_0087: ldstr "dump"
IL_008c: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0091: stloc.s V_5
IL_0093: ldloc.s V_5
IL_0095: brfalse.s IL_00a3
IL_0097: ldarg.0
IL_0098: call System.Void ForestProbe::Dump()
IL_009d: nop
IL_009e: br IL_124a
IL_00a3: ldloc.1
IL_00a4: ldstr "dump-save-continuation"
IL_00a9: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_00ae: stloc.s V_6
IL_00b0: ldloc.s V_6
IL_00b2: brfalse.s IL_00c0
IL_00b4: ldarg.0
IL_00b5: call System.Void ForestProbe::DumpSaveContinuation()
IL_00ba: nop
IL_00bb: br IL_124a
IL_00c0: ldloc.1
IL_00c1: ldstr "dump-intro"
IL_00c6: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_00cb: stloc.s V_7
IL_00cd: ldloc.s V_7
IL_00cf: brfalse.s IL_00dd
IL_00d1: ldarg.0
IL_00d2: call System.Void ForestProbe::DumpIntro()
IL_00d7: nop
IL_00d8: br IL_124a
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
IL_0161: br IL_124a
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
IL_01ea: br IL_124a
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
IL_0273: br IL_124a
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
IL_02f5: call System.String[] ForestProbe::BuckyApproachDiagnostics()
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
IL_0320: br IL_124a
IL_0325: ldloc.1
IL_0326: ldstr "dump-bucky-completion"
IL_032b: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0330: stloc.s V_17
IL_0332: ldloc.s V_17
IL_0334: brfalse IL_03d2
IL_0339: nop
IL_033a: newobj System.Void ForestProbe/BuckyInteractionState::.ctor()
IL_033f: dup
IL_0340: call UnityEngine.SceneManagement.Scene UnityEngine.SceneManagement.SceneManager::GetActiveScene()
IL_0345: stloc.s V_10
IL_0347: ldloca.s V_10
IL_0349: call System.String UnityEngine.SceneManagement.Scene::get_name()
IL_034e: stfld System.String ForestProbe/BuckyInteractionState::scene
IL_0353: dup
IL_0354: call System.String UnityEngine.Application::get_companyName()
IL_0359: stfld System.String ForestProbe/BuckyInteractionState::company
IL_035e: dup
IL_035f: call System.String UnityEngine.Application::get_productName()
IL_0364: stfld System.String ForestProbe/BuckyInteractionState::product
IL_0369: dup
IL_036a: call System.String UnityEngine.Application::get_dataPath()
IL_036f: stfld System.String ForestProbe/BuckyInteractionState::dataPath
IL_0374: dup
IL_0375: call System.String UnityEngine.Application::get_persistentDataPath()
IL_037a: stfld System.String ForestProbe/BuckyInteractionState::persistentDataPath
IL_037f: dup
IL_0380: ldstr "original"
IL_0385: stfld System.String ForestProbe/BuckyInteractionState::choiceMode
IL_038a: dup
IL_038b: call System.Int32 UnityEngine.Time::get_frameCount()
IL_0390: stfld System.Int32 ForestProbe/BuckyInteractionState::frame
IL_0395: dup
IL_0396: call System.Single UnityEngine.Time::get_realtimeSinceStartup()
IL_039b: stfld System.Single ForestProbe/BuckyInteractionState::realtime
IL_03a0: dup
IL_03a1: ldarg.0
IL_03a2: call System.String[] ForestProbe::BuckyCompletionDiagnostics()
IL_03a7: stfld System.String[] ForestProbe/BuckyInteractionState::diagnostics
IL_03ac: stloc.s V_18
IL_03ae: ldarg.0
IL_03af: ldfld System.String ForestProbe::root
IL_03b4: ldstr "bucky-completion.json"
IL_03b9: call System.String System.IO.Path::Combine(System.String,System.String)
IL_03be: ldloc.s V_18
IL_03c0: ldc.i4.1
IL_03c1: call System.String UnityEngine.JsonUtility::ToJson(System.Object,System.Boolean)
IL_03c6: call System.Void System.IO.File::WriteAllText(System.String,System.String)
IL_03cb: nop
IL_03cc: nop
IL_03cd: br IL_124a
IL_03d2: ldloc.1
IL_03d3: ldstr "qa-background-input"
IL_03d8: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_03dd: stloc.s V_19
IL_03df: ldloc.s V_19
IL_03e1: brfalse.s IL_044f
IL_03e3: nop
IL_03e4: ldarg.0
IL_03e5: ldflda System.Nullable`1<System.Boolean> ForestProbe::originalIgnoreUnfocused
IL_03ea: call System.Boolean System.Nullable`1<System.Boolean>::get_HasValue()
IL_03ef: brtrue.s IL_03fb
IL_03f1: call System.Boolean Rewired.ReInput::get_isReady()
IL_03f6: ldc.i4.0
IL_03f7: ceq
IL_03f9: br.s IL_03fc
IL_03fb: ldc.i4.1
IL_03fc: stloc.s V_20
IL_03fe: ldloc.s V_20
IL_0400: brfalse.s IL_040d
IL_0402: ldstr "Background policy already changed or input not ready"
IL_0407: newobj System.Void System.Exception::.ctor(System.String)
IL_040c: throw
IL_040d: ldarg.0
IL_040e: call Rewired.ReInput/ConfigHelper Rewired.ReInput::get_configuration()
IL_0413: callvirt System.Boolean Rewired.ReInput/ConfigHelper::get_ignoreInputWhenAppNotInFocus()
IL_0418: newobj System.Void System.Nullable`1<System.Boolean>::.ctor(!0)
IL_041d: stfld System.Nullable`1<System.Boolean> ForestProbe::originalIgnoreUnfocused
IL_0422: call Rewired.ReInput/ConfigHelper Rewired.ReInput::get_configuration()
IL_0427: ldc.i4.0
IL_0428: callvirt System.Void Rewired.ReInput/ConfigHelper::set_ignoreInputWhenAppNotInFocus(System.Boolean)
IL_042d: nop
IL_042e: call Rewired.ReInput/ConfigHelper Rewired.ReInput::get_configuration()
IL_0433: callvirt System.Boolean Rewired.ReInput/ConfigHelper::get_ignoreInputWhenAppNotInFocus()
IL_0438: stloc.s V_21
IL_043a: ldloc.s V_21
IL_043c: brfalse.s IL_0449
IL_043e: ldstr "Public Rewired background policy did not apply"
IL_0443: newobj System.Void System.Exception::.ctor(System.String)
IL_0448: throw
IL_0449: nop
IL_044a: br IL_124a
IL_044f: ldloc.1
IL_0450: ldstr "restore-input-policy"
IL_0455: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_045a: stloc.s V_22
IL_045c: ldloc.s V_22
IL_045e: brfalse.s IL_046c
IL_0460: ldarg.0
IL_0461: call System.Void ForestProbe::RestoreInputPolicy()
IL_0466: nop
IL_0467: br IL_124a
IL_046c: ldloc.1
IL_046d: ldstr "sample-keyboard-start"
IL_0472: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0477: stloc.s V_23
IL_0479: ldloc.s V_23
IL_047b: brfalse.s IL_04ae
IL_047d: nop
IL_047e: ldarg.0
IL_047f: ldfld System.Boolean ForestProbe::samplingKeyboard
IL_0484: stloc.s V_24
IL_0486: ldloc.s V_24
IL_0488: brfalse.s IL_0495
IL_048a: ldstr "Keyboard sample already active"
IL_048f: newobj System.Void System.Exception::.ctor(System.String)
IL_0494: throw
IL_0495: ldarg.0
IL_0496: ldfld System.Collections.Generic.List`1<System.String> ForestProbe::keyboardSamples
IL_049b: callvirt System.Void System.Collections.Generic.List`1<System.String>::Clear()
IL_04a0: nop
IL_04a1: ldarg.0
IL_04a2: ldc.i4.1
IL_04a3: stfld System.Boolean ForestProbe::samplingKeyboard
IL_04a8: nop
IL_04a9: br IL_124a
IL_04ae: ldloc.1
IL_04af: ldstr "sample-keyboard-stop"
IL_04b4: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_04b9: stloc.s V_25
IL_04bb: ldloc.s V_25
IL_04bd: brfalse.s IL_0508
IL_04bf: nop
IL_04c0: ldarg.0
IL_04c1: ldfld System.Boolean ForestProbe::samplingKeyboard
IL_04c6: ldc.i4.0
IL_04c7: ceq
IL_04c9: stloc.s V_26
IL_04cb: ldloc.s V_26
IL_04cd: brfalse.s IL_04da
IL_04cf: ldstr "No active keyboard sample"
IL_04d4: newobj System.Void System.Exception::.ctor(System.String)
IL_04d9: throw
IL_04da: ldarg.0
IL_04db: ldc.i4.0
IL_04dc: stfld System.Boolean ForestProbe::samplingKeyboard
IL_04e1: ldarg.0
IL_04e2: ldfld System.String ForestProbe::root
IL_04e7: ldstr "keyboard-samples.txt"
IL_04ec: call System.String System.IO.Path::Combine(System.String,System.String)
IL_04f1: ldarg.0
IL_04f2: ldfld System.Collections.Generic.List`1<System.String> ForestProbe::keyboardSamples
IL_04f7: callvirt !0[] System.Collections.Generic.List`1<System.String>::ToArray()
IL_04fc: call System.Void System.IO.File::WriteAllLines(System.String,System.String[])
IL_0501: nop
IL_0502: nop
IL_0503: br IL_124a
IL_0508: ldloc.1
IL_0509: ldstr "sample-keyboard-snapshot"
IL_050e: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0513: stloc.s V_27
IL_0515: ldloc.s V_27
IL_0517: brfalse.s IL_055b
IL_0519: nop
IL_051a: ldarg.0
IL_051b: ldfld System.Boolean ForestProbe::samplingKeyboard
IL_0520: ldc.i4.0
IL_0521: ceq
IL_0523: stloc.s V_28
IL_0525: ldloc.s V_28
IL_0527: brfalse.s IL_0534
IL_0529: ldstr "No active keyboard sample"
IL_052e: newobj System.Void System.Exception::.ctor(System.String)
IL_0533: throw
IL_0534: ldarg.0
IL_0535: ldfld System.String ForestProbe::root
IL_053a: ldstr "keyboard-samples.txt"
IL_053f: call System.String System.IO.Path::Combine(System.String,System.String)
IL_0544: ldarg.0
IL_0545: ldfld System.Collections.Generic.List`1<System.String> ForestProbe::keyboardSamples
IL_054a: callvirt !0[] System.Collections.Generic.List`1<System.String>::ToArray()
IL_054f: call System.Void System.IO.File::WriteAllLines(System.String,System.String[])
IL_0554: nop
IL_0555: nop
IL_0556: br IL_124a
IL_055b: ldloc.1
IL_055c: ldstr "quit"
IL_0561: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0566: stloc.s V_29
IL_0568: ldloc.s V_29
IL_056a: brfalse.s IL_0580
IL_056c: nop
IL_056d: ldarg.0
IL_056e: call System.Void ForestProbe::RestoreInputPolicy()
IL_0573: nop
IL_0574: call System.Void UnityEngine.Application::Quit()
IL_0579: nop
IL_057a: nop
IL_057b: br IL_124a
IL_0580: ldloc.1
IL_0581: ldstr "show-menu"
IL_0586: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_058b: stloc.s V_30
IL_058d: ldloc.s V_30
IL_058f: brfalse.s IL_05d4
IL_0591: nop
IL_0592: call !!0 UnityEngine.Object::FindObjectOfType<TheForestOfLove.MainMenuController>()
IL_0597: stloc.s V_31
IL_0599: ldloc.s V_31
IL_059b: ldnull
IL_059c: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_05a1: stloc.s V_32
IL_05a3: ldloc.s V_32
IL_05a5: brfalse.s IL_05b2
IL_05a7: ldstr "Main menu controller not active"
IL_05ac: newobj System.Void System.Exception::.ctor(System.String)
IL_05b1: throw
IL_05b2: ldloc.s V_31
IL_05b4: callvirt System.Type System.Object::GetType()
IL_05b9: ldstr "FinishShowingMenu"
IL_05be: ldc.i4.s 36
IL_05c0: callvirt System.Reflection.MethodInfo System.Type::GetMethod(System.String,System.Reflection.BindingFlags)
IL_05c5: ldloc.s V_31
IL_05c7: ldnull
IL_05c8: callvirt System.Object System.Reflection.MethodBase::Invoke(System.Object,System.Object[])
IL_05cd: pop
IL_05ce: nop
IL_05cf: br IL_124a
IL_05d4: ldloc.1
IL_05d5: ldstr "complete-tutorial158"
IL_05da: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_05df: stloc.s V_33
IL_05e1: ldloc.s V_33
IL_05e3: brfalse IL_0686
IL_05e8: nop
IL_05e9: ldarg.0
IL_05ea: ldfld System.Boolean ForestProbe::tutorial158Completed
IL_05ef: stloc.s V_36
IL_05f1: ldloc.s V_36
IL_05f3: brfalse.s IL_0600
IL_05f5: ldstr "Tutorial158 completion already acknowledged; no replay"
IL_05fa: newobj System.Void System.Exception::.ctor(System.String)
IL_05ff: throw
IL_0600: ldarg.0
IL_0601: ldloca.s V_34
IL_0603: call ForestProbe/TutorialCompletion ForestProbe::ReadTutorialCompletion(UnityEngine.UI.Button&)
IL_0608: stloc.s V_35
IL_060a: ldloc.s V_35
IL_060c: ldfld System.Boolean ForestProbe/TutorialCompletion::typing
IL_0611: stloc.s V_37
IL_0613: ldloc.s V_37
IL_0615: brfalse.s IL_0622
IL_0617: ldstr "Tutorial158 still typing; no completion"
IL_061c: newobj System.Void System.Exception::.ctor(System.String)
IL_0621: throw
IL_0622: ldloc.s V_35
IL_0624: ldloc.s V_35
IL_0626: ldfld System.Boolean ForestProbe/TutorialCompletion::menuPresent
IL_062b: brtrue.s IL_0634
IL_062d: ldstr "applied"
IL_0632: br.s IL_0639
IL_0634: ldstr "menu-present"
IL_0639: stfld System.String ForestProbe/TutorialCompletion::result
IL_063e: ldloc.s V_35
IL_0640: ldfld System.Boolean ForestProbe/TutorialCompletion::menuPresent
IL_0645: ldc.i4.0
IL_0646: ceq
IL_0648: stloc.s V_38
IL_064a: ldloc.s V_38
IL_064c: brfalse.s IL_065b
IL_064e: ldloc.s V_34
IL_0650: callvirt UnityEngine.UI.Button/ButtonClickedEvent UnityEngine.UI.Button::get_onClick()
IL_0655: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_065a: nop
IL_065b: ldarg.0
IL_065c: ldc.i4.1
IL_065d: stfld System.Boolean ForestProbe::tutorial158Completed
IL_0662: ldarg.0
IL_0663: ldfld System.String ForestProbe::root
IL_0668: ldstr "completion158-receipt.json"
IL_066d: call System.String System.IO.Path::Combine(System.String,System.String)
IL_0672: ldloc.s V_35
IL_0674: ldc.i4.1
IL_0675: call System.String UnityEngine.JsonUtility::ToJson(System.Object,System.Boolean)
IL_067a: call System.Void System.IO.File::WriteAllText(System.String,System.String)
IL_067f: nop
IL_0680: nop
IL_0681: br IL_124a
IL_0686: ldloc.1
IL_0687: ldstr "select-tutorial181 "
IL_068c: callvirt System.Boolean System.String::StartsWith(System.String)
IL_0691: stloc.s V_39
IL_0693: ldloc.s V_39
IL_0695: brfalse IL_078b
IL_069a: nop
IL_069b: ldarg.0
IL_069c: ldfld System.Boolean ForestProbe::tutorial181Selected
IL_06a1: stloc.s V_45
IL_06a3: ldloc.s V_45
IL_06a5: brfalse.s IL_06b2
IL_06a7: ldstr "Tutorial181 already selected; no replay"
IL_06ac: newobj System.Void System.Exception::.ctor(System.String)
IL_06b1: throw
IL_06b2: ldloc.1
IL_06b3: ldc.i4.s 19
IL_06b5: callvirt System.String System.String::Substring(System.Int32)
IL_06ba: ldc.i4.1
IL_06bb: newarr System.Char
IL_06c0: dup
IL_06c1: ldc.i4.0
IL_06c2: ldc.i4.s 32
IL_06c4: stelem.i2
IL_06c5: callvirt System.String[] System.String::Split(System.Char[])
IL_06ca: stloc.s V_40
IL_06cc: ldloc.s V_40
IL_06ce: ldlen
IL_06cf: conv.i4
IL_06d0: ldc.i4.2
IL_06d1: ceq
IL_06d3: ldc.i4.0
IL_06d4: ceq
IL_06d6: stloc.s V_46
IL_06d8: ldloc.s V_46
IL_06da: brfalse.s IL_06e7
IL_06dc: ldstr "Expected observed frame and original button identity"
IL_06e1: newobj System.Void System.Exception::.ctor(System.String)
IL_06e6: throw
IL_06e7: ldloc.s V_40
IL_06e9: ldc.i4.0
IL_06ea: ldelem.ref
IL_06eb: call System.Int32 System.Int32::Parse(System.String)
IL_06f0: stloc.s V_41
IL_06f2: ldloc.s V_40
IL_06f4: ldc.i4.1
IL_06f5: ldelem.ref
IL_06f6: call System.Int32 System.Int32::Parse(System.String)
IL_06fb: stloc.s V_42
IL_06fd: ldarg.0
IL_06fe: ldloca.s V_43
IL_0700: call ForestProbe/Tutorial181Selection ForestProbe::ReadTutorial181(UnityEngine.UI.Button&)
IL_0705: stloc.s V_44
IL_0707: ldloc.s V_41
IL_0709: ldc.i4.0
IL_070a: ble.s IL_0735
IL_070c: ldloc.s V_41
IL_070e: ldloc.s V_44
IL_0710: ldfld System.Int32 ForestProbe/Tutorial181Selection::frame
IL_0715: bgt.s IL_0735
IL_0717: ldloc.s V_44
IL_0719: ldfld System.Int32 ForestProbe/Tutorial181Selection::frame
IL_071e: ldloc.s V_41
IL_0720: sub
IL_0721: ldc.i4.s 120
IL_0723: bgt.s IL_0735
IL_0725: ldloc.s V_44
IL_0727: ldfld System.Int32 ForestProbe/Tutorial181Selection::buttonInstance
IL_072c: ldloc.s V_42
IL_072e: ceq
IL_0730: ldc.i4.0
IL_0731: ceq
IL_0733: br.s IL_0736
IL_0735: ldc.i4.1
IL_0736: stloc.s V_47
IL_0738: ldloc.s V_47
IL_073a: brfalse.s IL_0747
IL_073c: ldstr "Stale Tutorial181 menu/control"
IL_0741: newobj System.Void System.Exception::.ctor(System.String)
IL_0746: throw
IL_0747: ldarg.0
IL_0748: ldc.i4.1
IL_0749: stfld System.Boolean ForestProbe::tutorial181Selected
IL_074e: ldloc.s V_44
IL_0750: ldstr "submitted"
IL_0755: stfld System.String ForestProbe/Tutorial181Selection::result
IL_075a: ldarg.0
IL_075b: ldfld System.String ForestProbe::root
IL_0760: ldstr "selection181-receipt.json"
IL_0765: call System.String System.IO.Path::Combine(System.String,System.String)
IL_076a: ldloc.s V_44
IL_076c: ldc.i4.1
IL_076d: call System.String UnityEngine.JsonUtility::ToJson(System.Object,System.Boolean)
IL_0772: call System.Void System.IO.File::WriteAllText(System.String,System.String)
IL_0777: nop
IL_0778: ldloc.s V_43
IL_077a: callvirt UnityEngine.UI.Button/ButtonClickedEvent UnityEngine.UI.Button::get_onClick()
IL_077f: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_0784: nop
IL_0785: nop
IL_0786: br IL_124a
IL_078b: ldloc.1
IL_078c: ldstr "select-bucky217 "
IL_0791: callvirt System.Boolean System.String::StartsWith(System.String)
IL_0796: stloc.s V_48
IL_0798: ldloc.s V_48
IL_079a: brfalse IL_08cd
IL_079f: nop
IL_07a0: ldarg.0
IL_07a1: ldfld System.Boolean ForestProbe::bucky217Selected
IL_07a6: stloc.s V_54
IL_07a8: ldloc.s V_54
IL_07aa: brfalse.s IL_07b7
IL_07ac: ldstr "Bucky217 already selected; no replay"
IL_07b1: newobj System.Void System.Exception::.ctor(System.String)
IL_07b6: throw
IL_07b7: ldloc.1
IL_07b8: ldc.i4.s 16
IL_07ba: callvirt System.String System.String::Substring(System.Int32)
IL_07bf: ldc.i4.1
IL_07c0: newarr System.Char
IL_07c5: dup
IL_07c6: ldc.i4.0
IL_07c7: ldc.i4.s 32
IL_07c9: stelem.i2
IL_07ca: callvirt System.String[] System.String::Split(System.Char[])
IL_07cf: stloc.s V_49
IL_07d1: ldloc.s V_49
IL_07d3: ldlen
IL_07d4: conv.i4
IL_07d5: ldc.i4.2
IL_07d6: ceq
IL_07d8: ldc.i4.0
IL_07d9: ceq
IL_07db: stloc.s V_55
IL_07dd: ldloc.s V_55
IL_07df: brfalse.s IL_07ec
IL_07e1: ldstr "Expected observed frame and original button identity"
IL_07e6: newobj System.Void System.Exception::.ctor(System.String)
IL_07eb: throw
IL_07ec: ldloc.s V_49
IL_07ee: ldc.i4.0
IL_07ef: ldelem.ref
IL_07f0: call System.Int32 System.Int32::Parse(System.String)
IL_07f5: stloc.s V_50
IL_07f7: ldloc.s V_49
IL_07f9: ldc.i4.1
IL_07fa: ldelem.ref
IL_07fb: call System.Int32 System.Int32::Parse(System.String)
IL_0800: stloc.s V_51
IL_0802: ldarg.0
IL_0803: ldloca.s V_52
IL_0805: call ForestProbe/Bucky217Selection ForestProbe::ReadBucky217(UnityEngine.UI.Button&)
IL_080a: stloc.s V_53
IL_080c: ldloc.s V_50
IL_080e: ldc.i4.0
IL_080f: ble.s IL_083a
IL_0811: ldloc.s V_50
IL_0813: ldloc.s V_53
IL_0815: ldfld System.Int32 ForestProbe/Bucky217Selection::frame
IL_081a: bgt.s IL_083a
IL_081c: ldloc.s V_53
IL_081e: ldfld System.Int32 ForestProbe/Bucky217Selection::frame
IL_0823: ldloc.s V_50
IL_0825: sub
IL_0826: ldc.i4.s 120
IL_0828: bgt.s IL_083a
IL_082a: ldloc.s V_53
IL_082c: ldfld System.Int32 ForestProbe/Bucky217Selection::buttonInstance
IL_0831: ldloc.s V_51
IL_0833: ceq
IL_0835: ldc.i4.0
IL_0836: ceq
IL_0838: br.s IL_083b
IL_083a: ldc.i4.1
IL_083b: stloc.s V_56
IL_083d: ldloc.s V_56
IL_083f: brfalse.s IL_084c
IL_0841: ldstr "Stale Bucky217 menu/control"
IL_0846: newobj System.Void System.Exception::.ctor(System.String)
IL_084b: throw
IL_084c: ldarg.0
IL_084d: ldc.i4.1
IL_084e: stfld System.Boolean ForestProbe::bucky217Selected
IL_0853: ldarg.0
IL_0854: ldsfld UnityEngine.Events.UnityEvent`4<TheForestOfLove.Narrative.Dialogue,TheForestOfLove.Narrative.Arc,System.Int32,System.Int32> TheForestOfLove.Narrative.DialogueService::onDialogueLineArcTriggerCheck
IL_0859: stfld UnityEngine.Events.UnityEvent`4<TheForestOfLove.Narrative.Dialogue,TheForestOfLove.Narrative.Arc,System.Int32,System.Int32> ForestProbe::buckyLineEndSource
IL_085e: ldarg.0
IL_085f: ldfld UnityEngine.Events.UnityEvent`4<TheForestOfLove.Narrative.Dialogue,TheForestOfLove.Narrative.Arc,System.Int32,System.Int32> ForestProbe::buckyLineEndSource
IL_0864: ldnull
IL_0865: ceq
IL_0867: stloc.s V_57
IL_0869: ldloc.s V_57
IL_086b: brfalse.s IL_0878
IL_086d: ldstr "Bucky original line-end event absent"
IL_0872: newobj System.Void System.Exception::.ctor(System.String)
IL_0877: throw
IL_0878: ldarg.0
IL_0879: ldfld UnityEngine.Events.UnityEvent`4<TheForestOfLove.Narrative.Dialogue,TheForestOfLove.Narrative.Arc,System.Int32,System.Int32> ForestProbe::buckyLineEndSource
IL_087e: ldarg.0
IL_087f: ldftn System.Void ForestProbe::ObserveBucky212End(TheForestOfLove.Narrative.Dialogue,TheForestOfLove.Narrative.Arc,System.Int32,System.Int32)
IL_0885: newobj System.Void UnityEngine.Events.UnityAction`4<TheForestOfLove.Narrative.Dialogue,TheForestOfLove.Narrative.Arc,System.Int32,System.Int32>::.ctor(System.Object,System.IntPtr)
IL_088a: callvirt System.Void UnityEngine.Events.UnityEvent`4<TheForestOfLove.Narrative.Dialogue,TheForestOfLove.Narrative.Arc,System.Int32,System.Int32>::AddListener(UnityEngine.Events.UnityAction`4<!0,!1,!2,!3>)
IL_088f: nop
IL_0890: ldloc.s V_53
IL_0892: ldstr "submitted"
IL_0897: stfld System.String ForestProbe/Bucky217Selection::result
IL_089c: ldarg.0
IL_089d: ldfld System.String ForestProbe::root
IL_08a2: ldstr "selection217-receipt.json"
IL_08a7: call System.String System.IO.Path::Combine(System.String,System.String)
IL_08ac: ldloc.s V_53
IL_08ae: ldc.i4.1
IL_08af: call System.String UnityEngine.JsonUtility::ToJson(System.Object,System.Boolean)
IL_08b4: call System.Void System.IO.File::WriteAllText(System.String,System.String)
IL_08b9: nop
IL_08ba: ldloc.s V_52
IL_08bc: callvirt UnityEngine.UI.Button/ButtonClickedEvent UnityEngine.UI.Button::get_onClick()
IL_08c1: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_08c6: nop
IL_08c7: nop
IL_08c8: br IL_124a
IL_08cd: ldloc.1
IL_08ce: ldstr "continue-bound "
IL_08d3: callvirt System.Boolean System.String::StartsWith(System.String)
IL_08d8: stloc.s V_58
IL_08da: ldloc.s V_58
IL_08dc: brfalse IL_0a2c
IL_08e1: nop
IL_08e2: ldloc.1
IL_08e3: ldc.i4.s 15
IL_08e5: callvirt System.String System.String::Substring(System.Int32)
IL_08ea: ldc.i4.1
IL_08eb: newarr System.Char
IL_08f0: dup
IL_08f1: ldc.i4.0
IL_08f2: ldc.i4.s 32
IL_08f4: stelem.i2
IL_08f5: callvirt System.String[] System.String::Split(System.Char[])
IL_08fa: stloc.s V_59
IL_08fc: ldloc.s V_59
IL_08fe: ldlen
IL_08ff: conv.i4
IL_0900: ldc.i4.2
IL_0901: ceq
IL_0903: ldc.i4.0
IL_0904: ceq
IL_0906: stloc.s V_66
IL_0908: ldloc.s V_66
IL_090a: brfalse.s IL_0917
IL_090c: ldstr "Expected conversation and source entry"
IL_0911: newobj System.Void System.Exception::.ctor(System.String)
IL_0916: throw
IL_0917: ldloc.s V_59
IL_0919: ldc.i4.0
IL_091a: ldelem.ref
IL_091b: call System.Int32 System.Int32::Parse(System.String)
IL_0920: stloc.s V_60
IL_0922: ldloc.s V_59
IL_0924: ldc.i4.1
IL_0925: ldelem.ref
IL_0926: call System.Int32 System.Int32::Parse(System.String)
IL_092b: stloc.s V_61
IL_092d: ldloc.s V_60
IL_092f: ldc.i4.s 120
IL_0931: bne.un.s IL_093e
IL_0933: ldloc.s V_61
IL_0935: ldc.i4 158
IL_093a: ceq
IL_093c: br.s IL_093f
IL_093e: ldc.i4.0
IL_093f: stloc.s V_67
IL_0941: ldloc.s V_67
IL_0943: brfalse.s IL_0950
IL_0945: ldstr "Tutorial158 requires guarded completion"
IL_094a: newobj System.Void System.Exception::.ctor(System.String)
IL_094f: throw
IL_0950: call PixelCrushers.DialogueSystem.ConversationState PixelCrushers.DialogueSystem.DialogueManager::get_currentConversationState()
IL_0955: stloc.s V_62
IL_0957: ldloc.s V_62
IL_0959: brfalse.s IL_0972
IL_095b: ldloc.s V_62
IL_095d: ldfld PixelCrushers.DialogueSystem.Subtitle PixelCrushers.DialogueSystem.ConversationState::subtitle
IL_0962: brfalse.s IL_0972
IL_0964: ldloc.s V_62
IL_0966: ldfld PixelCrushers.DialogueSystem.Subtitle PixelCrushers.DialogueSystem.ConversationState::subtitle
IL_096b: ldfld PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Subtitle::dialogueEntry
IL_0970: br.s IL_0973
IL_0972: ldnull
IL_0973: stloc.s V_63
IL_0975: newobj System.Void ForestProbe/ContinueReceipt::.ctor()
IL_097a: dup
IL_097b: call System.Boolean PixelCrushers.DialogueSystem.DialogueManager::get_isConversationActive()
IL_0980: stfld System.Boolean ForestProbe/ContinueReceipt::active
IL_0985: dup
IL_0986: ldloc.s V_60
IL_0988: stfld System.Int32 ForestProbe/ContinueReceipt::expectedConversationId
IL_098d: dup
IL_098e: ldloc.s V_61
IL_0990: stfld System.Int32 ForestProbe/ContinueReceipt::expectedEntryId
IL_0995: dup
IL_0996: ldloc.s V_63
IL_0998: brfalse.s IL_09a3
IL_099a: ldloc.s V_63
IL_099c: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::conversationID
IL_09a1: br.s IL_09a4
IL_09a3: ldc.i4.m1
IL_09a4: stfld System.Int32 ForestProbe/ContinueReceipt::actualConversationId
IL_09a9: dup
IL_09aa: ldloc.s V_63
IL_09ac: brfalse.s IL_09b7
IL_09ae: ldloc.s V_63
IL_09b0: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_09b5: br.s IL_09b8
IL_09b7: ldc.i4.m1
IL_09b8: stfld System.Int32 ForestProbe/ContinueReceipt::actualEntryId
IL_09bd: stloc.s V_64
IL_09bf: ldloc.s V_64
IL_09c1: ldfld System.Boolean ForestProbe/ContinueReceipt::active
IL_09c6: brfalse.s IL_09e0
IL_09c8: ldloc.s V_64
IL_09ca: ldfld System.Int32 ForestProbe/ContinueReceipt::actualConversationId
IL_09cf: ldloc.s V_60
IL_09d1: bne.un.s IL_09e0
IL_09d3: ldloc.s V_64
IL_09d5: ldfld System.Int32 ForestProbe/ContinueReceipt::actualEntryId
IL_09da: ldloc.s V_61
IL_09dc: ceq
IL_09de: br.s IL_09e1
IL_09e0: ldc.i4.0
IL_09e1: stloc.s V_65
IL_09e3: ldloc.s V_65
IL_09e5: stloc.s V_68
IL_09e7: ldloc.s V_68
IL_09e9: brfalse.s IL_09f1
IL_09eb: call System.Void TheForestOfLove.CustomTypewriterEffectTextMeshPro::FastForwardTextOrAdvanceDialogue()
IL_09f0: nop
IL_09f1: ldloc.s V_64
IL_09f3: ldloc.s V_65
IL_09f5: brtrue.s IL_09fe
IL_09f7: ldstr "stale"
IL_09fc: br.s IL_0a03
IL_09fe: ldstr "applied"
IL_0a03: stfld System.String ForestProbe/ContinueReceipt::result
IL_0a08: ldarg.0
IL_0a09: ldfld System.String ForestProbe::root
IL_0a0e: ldstr "continue-receipt.json"
IL_0a13: call System.String System.IO.Path::Combine(System.String,System.String)
IL_0a18: ldloc.s V_64
IL_0a1a: ldc.i4.1
IL_0a1b: call System.String UnityEngine.JsonUtility::ToJson(System.Object,System.Boolean)
IL_0a20: call System.Void System.IO.File::WriteAllText(System.String,System.String)
IL_0a25: nop
IL_0a26: nop
IL_0a27: br IL_124a
IL_0a2c: ldloc.1
IL_0a2d: ldstr "continue"
IL_0a32: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0a37: stloc.s V_69
IL_0a39: ldloc.s V_69
IL_0a3b: brfalse.s IL_0a63
IL_0a3d: nop
IL_0a3e: call System.Boolean PixelCrushers.DialogueSystem.DialogueManager::get_isConversationActive()
IL_0a43: ldc.i4.0
IL_0a44: ceq
IL_0a46: stloc.s V_70
IL_0a48: ldloc.s V_70
IL_0a4a: brfalse.s IL_0a57
IL_0a4c: ldstr "No active conversation"
IL_0a51: newobj System.Void System.Exception::.ctor(System.String)
IL_0a56: throw
IL_0a57: call System.Void TheForestOfLove.CustomTypewriterEffectTextMeshPro::FastForwardTextOrAdvanceDialogue()
IL_0a5c: nop
IL_0a5d: nop
IL_0a5e: br IL_124a
IL_0a63: ldloc.1
IL_0a64: ldstr "response "
IL_0a69: callvirt System.Boolean System.String::StartsWith(System.String)
IL_0a6e: stloc.s V_71
IL_0a70: ldloc.s V_71
IL_0a72: brfalse IL_0c66
IL_0a77: nop
IL_0a78: ldloc.1
IL_0a79: ldc.i4.s 9
IL_0a7b: callvirt System.String System.String::Substring(System.Int32)
IL_0a80: ldc.i4.1
IL_0a81: newarr System.Char
IL_0a86: dup
IL_0a87: ldc.i4.0
IL_0a88: ldc.i4.s 32
IL_0a8a: stelem.i2
IL_0a8b: callvirt System.String[] System.String::Split(System.Char[])
IL_0a90: stloc.s V_72
IL_0a92: ldloc.s V_72
IL_0a94: ldlen
IL_0a95: conv.i4
IL_0a96: ldc.i4.3
IL_0a97: ceq
IL_0a99: ldc.i4.0
IL_0a9a: ceq
IL_0a9c: stloc.s V_78
IL_0a9e: ldloc.s V_78
IL_0aa0: brfalse.s IL_0aad
IL_0aa2: ldstr "Expected source entry, conversation and destination entry"
IL_0aa7: newobj System.Void System.Exception::.ctor(System.String)
IL_0aac: throw
IL_0aad: ldloc.s V_72
IL_0aaf: ldc.i4.0
IL_0ab0: ldelem.ref
IL_0ab1: call System.Int32 System.Int32::Parse(System.String)
IL_0ab6: stloc.s V_73
IL_0ab8: ldloc.s V_72
IL_0aba: ldc.i4.1
IL_0abb: ldelem.ref
IL_0abc: call System.Int32 System.Int32::Parse(System.String)
IL_0ac1: stloc.s V_74
IL_0ac3: ldloc.s V_72
IL_0ac5: ldc.i4.2
IL_0ac6: ldelem.ref
IL_0ac7: call System.Int32 System.Int32::Parse(System.String)
IL_0acc: stloc.s V_75
IL_0ace: ldloc.s V_74
IL_0ad0: ldc.i4.s 120
IL_0ad2: bne.un.s IL_0adf
IL_0ad4: ldloc.s V_73
IL_0ad6: ldc.i4 158
IL_0adb: ceq
IL_0add: br.s IL_0ae0
IL_0adf: ldc.i4.0
IL_0ae0: stloc.s V_79
IL_0ae2: ldloc.s V_79
IL_0ae4: brfalse.s IL_0af1
IL_0ae6: ldstr "Tutorial159/181 choices forbidden"
IL_0aeb: newobj System.Void System.Exception::.ctor(System.String)
IL_0af0: throw
IL_0af1: call PixelCrushers.DialogueSystem.ConversationState PixelCrushers.DialogueSystem.DialogueManager::get_currentConversationState()
IL_0af6: stloc.s V_76
IL_0af8: call System.Boolean PixelCrushers.DialogueSystem.DialogueManager::get_isConversationActive()
IL_0afd: brfalse.s IL_0b49
IL_0aff: ldloc.s V_76
IL_0b01: brfalse.s IL_0b49
IL_0b03: ldloc.s V_76
IL_0b05: ldfld PixelCrushers.DialogueSystem.Subtitle PixelCrushers.DialogueSystem.ConversationState::subtitle
IL_0b0a: brfalse.s IL_0b49
IL_0b0c: ldloc.s V_76
IL_0b0e: ldfld PixelCrushers.DialogueSystem.Subtitle PixelCrushers.DialogueSystem.ConversationState::subtitle
IL_0b13: ldfld PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Subtitle::dialogueEntry
IL_0b18: brfalse.s IL_0b49
IL_0b1a: ldloc.s V_76
IL_0b1c: ldfld PixelCrushers.DialogueSystem.Subtitle PixelCrushers.DialogueSystem.ConversationState::subtitle
IL_0b21: ldfld PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Subtitle::dialogueEntry
IL_0b26: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::conversationID
IL_0b2b: ldloc.s V_74
IL_0b2d: bne.un.s IL_0b49
IL_0b2f: ldloc.s V_76
IL_0b31: ldfld PixelCrushers.DialogueSystem.Subtitle PixelCrushers.DialogueSystem.ConversationState::subtitle
IL_0b36: ldfld PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Subtitle::dialogueEntry
IL_0b3b: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_0b40: ldloc.s V_73
IL_0b42: ceq
IL_0b44: ldc.i4.0
IL_0b45: ceq
IL_0b47: br.s IL_0b4a
IL_0b49: ldc.i4.1
IL_0b4a: stloc.s V_80
IL_0b4c: ldloc.s V_80
IL_0b4e: brfalse.s IL_0b5b
IL_0b50: ldstr "Response source changed"
IL_0b55: newobj System.Void System.Exception::.ctor(System.String)
IL_0b5a: throw
IL_0b5b: ldnull
IL_0b5c: stloc.s V_77
IL_0b5e: nop
IL_0b5f: call !!0[] UnityEngine.Resources::FindObjectsOfTypeAll<PixelCrushers.DialogueSystem.StandardUIResponseButton>()
IL_0b64: stloc.s V_81
IL_0b66: ldc.i4.0
IL_0b67: stloc.s V_82
IL_0b69: br.s IL_0bd5
IL_0b6b: ldloc.s V_81
IL_0b6d: ldloc.s V_82
IL_0b6f: ldelem.ref
IL_0b70: stloc.s V_83
IL_0b72: ldloc.s V_83
IL_0b74: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0b79: callvirt UnityEngine.SceneManagement.Scene UnityEngine.GameObject::get_scene()
IL_0b7e: stloc.s V_10
IL_0b80: ldloca.s V_10
IL_0b82: call System.Boolean UnityEngine.SceneManagement.Scene::IsValid()
IL_0b87: brfalse.s IL_0ba9
IL_0b89: ldloc.s V_83
IL_0b8b: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0b90: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_0b95: brfalse.s IL_0ba9
IL_0b97: ldloc.s V_83
IL_0b99: callvirt System.Boolean PixelCrushers.DialogueSystem.StandardUIResponseButton::get_isVisible()
IL_0b9e: brfalse.s IL_0ba9
IL_0ba0: ldloc.s V_83
IL_0ba2: callvirt System.Boolean PixelCrushers.DialogueSystem.StandardUIResponseButton::get_isClickable()
IL_0ba7: br.s IL_0baa
IL_0ba9: ldc.i4.0
IL_0baa: stloc.s V_84
IL_0bac: ldloc.s V_84
IL_0bae: brfalse.s IL_0bcf
IL_0bb0: nop
IL_0bb1: ldloc.s V_77
IL_0bb3: ldnull
IL_0bb4: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0bb9: stloc.s V_85
IL_0bbb: ldloc.s V_85
IL_0bbd: brfalse.s IL_0bca
IL_0bbf: ldstr "More than one live response; hold for source review"
IL_0bc4: newobj System.Void System.Exception::.ctor(System.String)
IL_0bc9: throw
IL_0bca: ldloc.s V_83
IL_0bcc: stloc.s V_77
IL_0bce: nop
IL_0bcf: ldloc.s V_82
IL_0bd1: ldc.i4.1
IL_0bd2: add
IL_0bd3: stloc.s V_82
IL_0bd5: ldloc.s V_82
IL_0bd7: ldloc.s V_81
IL_0bd9: ldlen
IL_0bda: conv.i4
IL_0bdb: blt.s IL_0b6b
IL_0bdd: ldloc.s V_77
IL_0bdf: ldnull
IL_0be0: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0be5: brtrue.s IL_0c3c
IL_0be7: ldloc.s V_77
IL_0be9: callvirt PixelCrushers.DialogueSystem.Response PixelCrushers.DialogueSystem.StandardUIResponseButton::get_response()
IL_0bee: brfalse.s IL_0c3c
IL_0bf0: ldloc.s V_77
IL_0bf2: callvirt PixelCrushers.DialogueSystem.Response PixelCrushers.DialogueSystem.StandardUIResponseButton::get_response()
IL_0bf7: ldfld PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Response::destinationEntry
IL_0bfc: brfalse.s IL_0c3c
IL_0bfe: ldloc.s V_77
IL_0c00: callvirt UnityEngine.Transform PixelCrushers.DialogueSystem.StandardUIResponseButton::get_target()
IL_0c05: ldnull
IL_0c06: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0c0b: brtrue.s IL_0c3c
IL_0c0d: ldloc.s V_77
IL_0c0f: callvirt PixelCrushers.DialogueSystem.Response PixelCrushers.DialogueSystem.StandardUIResponseButton::get_response()
IL_0c14: ldfld PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Response::destinationEntry
IL_0c19: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::conversationID
IL_0c1e: ldloc.s V_74
IL_0c20: bne.un.s IL_0c3c
IL_0c22: ldloc.s V_77
IL_0c24: callvirt PixelCrushers.DialogueSystem.Response PixelCrushers.DialogueSystem.StandardUIResponseButton::get_response()
IL_0c29: ldfld PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Response::destinationEntry
IL_0c2e: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_0c33: ldloc.s V_75
IL_0c35: ceq
IL_0c37: ldc.i4.0
IL_0c38: ceq
IL_0c3a: br.s IL_0c3d
IL_0c3c: ldc.i4.1
IL_0c3d: stloc.s V_86
IL_0c3f: ldloc.s V_86
IL_0c41: brfalse.s IL_0c4e
IL_0c43: ldstr "Response does not match source-bound successor"
IL_0c48: newobj System.Void System.Exception::.ctor(System.String)
IL_0c4d: throw
IL_0c4e: ldloc.s V_77
IL_0c50: ldfld UnityEngine.UI.Button PixelCrushers.DialogueSystem.StandardUIResponseButton::button
IL_0c55: callvirt UnityEngine.UI.Button/ButtonClickedEvent UnityEngine.UI.Button::get_onClick()
IL_0c5a: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_0c5f: nop
IL_0c60: nop
IL_0c61: br IL_124a
IL_0c66: ldloc.1
IL_0c67: ldstr "probe-nameplate"
IL_0c6c: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0c71: stloc.s V_87
IL_0c73: ldloc.s V_87
IL_0c75: brfalse.s IL_0ce5
IL_0c77: nop
IL_0c78: call System.Boolean PixelCrushers.DialogueSystem.DialogueManager::get_isConversationActive()
IL_0c7d: ldc.i4.0
IL_0c7e: ceq
IL_0c80: stloc.s V_89
IL_0c82: ldloc.s V_89
IL_0c84: brfalse.s IL_0c91
IL_0c86: ldstr "No active conversation"
IL_0c8b: newobj System.Void System.Exception::.ctor(System.String)
IL_0c90: throw
IL_0c91: call !!0 UnityEngine.Object::FindObjectOfType<TheForestOfLove.DialogueNameplateController>()
IL_0c96: stloc.s V_88
IL_0c98: ldloc.s V_88
IL_0c9a: ldnull
IL_0c9b: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0ca0: stloc.s V_90
IL_0ca2: ldloc.s V_90
IL_0ca4: brfalse.s IL_0cb1
IL_0ca6: ldstr "No active nameplate controller"
IL_0cab: newobj System.Void System.Exception::.ctor(System.String)
IL_0cb0: throw
IL_0cb1: ldloc.s V_88
IL_0cb3: ldstr "Ёж Йй 123"
IL_0cb8: callvirt System.Void TheForestOfLove.DialogueNameplateController::SetCustomNameplateUntilCleared(System.String)
IL_0cbd: nop
IL_0cbe: ldloc.s V_88
IL_0cc0: callvirt System.Type System.Object::GetType()
IL_0cc5: ldstr "UpdateNameplate"
IL_0cca: ldc.i4.s 36
IL_0ccc: callvirt System.Reflection.MethodInfo System.Type::GetMethod(System.String,System.Reflection.BindingFlags)
IL_0cd1: ldloc.s V_88
IL_0cd3: ldc.i4.1
IL_0cd4: newarr System.Object
IL_0cd9: callvirt System.Object System.Reflection.MethodBase::Invoke(System.Object,System.Object[])
IL_0cde: pop
IL_0cdf: nop
IL_0ce0: br IL_124a
IL_0ce5: ldloc.1
IL_0ce6: ldstr "capture "
IL_0ceb: callvirt System.Boolean System.String::StartsWith(System.String)
IL_0cf0: stloc.s V_91
IL_0cf2: ldloc.s V_91
IL_0cf4: brfalse.s IL_0d6f
IL_0cf6: nop
IL_0cf7: ldloc.1
IL_0cf8: ldc.i4.8
IL_0cf9: callvirt System.String System.String::Substring(System.Int32)
IL_0cfe: stloc.s V_92
IL_0d00: ldloc.s V_92
IL_0d02: call System.String System.IO.Path::GetFileName(System.String)
IL_0d07: ldloc.s V_92
IL_0d09: call System.Boolean System.String::op_Inequality(System.String,System.String)
IL_0d0e: brtrue.s IL_0d21
IL_0d10: ldloc.s V_92
IL_0d12: ldstr ".png"
IL_0d17: callvirt System.Boolean System.String::EndsWith(System.String)
IL_0d1c: ldc.i4.0
IL_0d1d: ceq
IL_0d1f: br.s IL_0d22
IL_0d21: ldc.i4.1
IL_0d22: stloc.s V_94
IL_0d24: ldloc.s V_94
IL_0d26: brfalse.s IL_0d33
IL_0d28: ldstr "Invalid capture name"
IL_0d2d: newobj System.Void System.Exception::.ctor(System.String)
IL_0d32: throw
IL_0d33: ldarg.0
IL_0d34: ldfld System.String ForestProbe::root
IL_0d39: ldloc.s V_92
IL_0d3b: call System.String System.IO.Path::Combine(System.String,System.String)
IL_0d40: stloc.s V_93
IL_0d42: ldloc.s V_93
IL_0d44: call System.Boolean System.IO.File::Exists(System.String)
IL_0d49: stloc.s V_95
IL_0d4b: ldloc.s V_95
IL_0d4d: brfalse.s IL_0d5a
IL_0d4f: ldstr "Capture already exists"
IL_0d54: newobj System.Void System.Exception::.ctor(System.String)
IL_0d59: throw
IL_0d5a: ldarg.0
IL_0d5b: ldarg.0
IL_0d5c: ldloc.s V_93
IL_0d5e: call System.Collections.IEnumerator ForestProbe::Capture(System.String)
IL_0d63: call UnityEngine.Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)
IL_0d68: pop
IL_0d69: nop
IL_0d6a: br IL_124a
IL_0d6f: ldloc.1
IL_0d70: ldstr "select "
IL_0d75: callvirt System.Boolean System.String::StartsWith(System.String)
IL_0d7a: stloc.s V_96
IL_0d7c: ldloc.s V_96
IL_0d7e: brfalse IL_0e63
IL_0d83: nop
IL_0d84: ldloc.1
IL_0d85: ldc.i4.7
IL_0d86: callvirt System.String System.String::Substring(System.Int32)
IL_0d8b: stloc.s V_97
IL_0d8d: ldnull
IL_0d8e: stloc.s V_98
IL_0d90: nop
IL_0d91: call !!0[] UnityEngine.Resources::FindObjectsOfTypeAll<UnityEngine.UI.Selectable>()
IL_0d96: stloc.s V_99
IL_0d98: ldc.i4.0
IL_0d99: stloc.s V_100
IL_0d9b: br.s IL_0e13
IL_0d9d: ldloc.s V_99
IL_0d9f: ldloc.s V_100
IL_0da1: ldelem.ref
IL_0da2: stloc.s V_101
IL_0da4: ldloc.s V_101
IL_0da6: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0dab: callvirt UnityEngine.SceneManagement.Scene UnityEngine.GameObject::get_scene()
IL_0db0: stloc.s V_10
IL_0db2: ldloca.s V_10
IL_0db4: call System.Boolean UnityEngine.SceneManagement.Scene::IsValid()
IL_0db9: brfalse.s IL_0de7
IL_0dbb: ldloc.s V_101
IL_0dbd: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0dc2: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_0dc7: brfalse.s IL_0de7
IL_0dc9: ldloc.s V_101
IL_0dcb: callvirt System.Boolean UnityEngine.UI.Selectable::IsInteractable()
IL_0dd0: brfalse.s IL_0de7
IL_0dd2: ldloc.s V_101
IL_0dd4: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0dd9: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_0dde: ldloc.s V_97
IL_0de0: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0de5: br.s IL_0de8
IL_0de7: ldc.i4.0
IL_0de8: stloc.s V_102
IL_0dea: ldloc.s V_102
IL_0dec: brfalse.s IL_0e0d
IL_0dee: nop
IL_0def: ldloc.s V_98
IL_0df1: ldnull
IL_0df2: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0df7: stloc.s V_103
IL_0df9: ldloc.s V_103
IL_0dfb: brfalse.s IL_0e08
IL_0dfd: ldstr "Duplicate active selectable"
IL_0e02: newobj System.Void System.Exception::.ctor(System.String)
IL_0e07: throw
IL_0e08: ldloc.s V_101
IL_0e0a: stloc.s V_98
IL_0e0c: nop
IL_0e0d: ldloc.s V_100
IL_0e0f: ldc.i4.1
IL_0e10: add
IL_0e11: stloc.s V_100
IL_0e13: ldloc.s V_100
IL_0e15: ldloc.s V_99
IL_0e17: ldlen
IL_0e18: conv.i4
IL_0e19: blt.s IL_0d9d
IL_0e1b: ldloc.s V_98
IL_0e1d: ldnull
IL_0e1e: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0e23: brtrue.s IL_0e32
IL_0e25: call UnityEngine.EventSystems.EventSystem UnityEngine.EventSystems.EventSystem::get_current()
IL_0e2a: ldnull
IL_0e2b: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0e30: br.s IL_0e33
IL_0e32: ldc.i4.1
IL_0e33: stloc.s V_104
IL_0e35: ldloc.s V_104
IL_0e37: brfalse.s IL_0e4b
IL_0e39: ldstr "No selectable/event system: "
IL_0e3e: ldloc.s V_97
IL_0e40: call System.String System.String::Concat(System.String,System.String)
IL_0e45: newobj System.Void System.Exception::.ctor(System.String)
IL_0e4a: throw
IL_0e4b: call UnityEngine.EventSystems.EventSystem UnityEngine.EventSystems.EventSystem::get_current()
IL_0e50: ldloc.s V_98
IL_0e52: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0e57: callvirt System.Void UnityEngine.EventSystems.EventSystem::SetSelectedGameObject(UnityEngine.GameObject)
IL_0e5c: nop
IL_0e5d: nop
IL_0e5e: br IL_124a
IL_0e63: ldloc.1
IL_0e64: ldstr "move-left"
IL_0e69: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0e6e: brtrue.s IL_0e7d
IL_0e70: ldloc.1
IL_0e71: ldstr "move-right"
IL_0e76: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0e7b: br.s IL_0e7e
IL_0e7d: ldc.i4.1
IL_0e7e: stloc.s V_105
IL_0e80: ldloc.s V_105
IL_0e82: brfalse IL_0f08
IL_0e87: nop
IL_0e88: call UnityEngine.EventSystems.EventSystem UnityEngine.EventSystems.EventSystem::get_current()
IL_0e8d: stloc.s V_106
IL_0e8f: ldloc.s V_106
IL_0e91: ldnull
IL_0e92: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0e97: brtrue.s IL_0ea8
IL_0e99: ldloc.s V_106
IL_0e9b: callvirt UnityEngine.GameObject UnityEngine.EventSystems.EventSystem::get_currentSelectedGameObject()
IL_0ea0: ldnull
IL_0ea1: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0ea6: br.s IL_0ea9
IL_0ea8: ldc.i4.1
IL_0ea9: stloc.s V_108
IL_0eab: ldloc.s V_108
IL_0ead: brfalse.s IL_0eba
IL_0eaf: ldstr "No selected control"
IL_0eb4: newobj System.Void System.Exception::.ctor(System.String)
IL_0eb9: throw
IL_0eba: ldloc.s V_106
IL_0ebc: newobj System.Void UnityEngine.EventSystems.AxisEventData::.ctor(UnityEngine.EventSystems.EventSystem)
IL_0ec1: dup
IL_0ec2: ldloc.1
IL_0ec3: ldstr "move-left"
IL_0ec8: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0ecd: brtrue.s IL_0ed2
IL_0ecf: ldc.i4.2
IL_0ed0: br.s IL_0ed3
IL_0ed2: ldc.i4.0
IL_0ed3: callvirt System.Void UnityEngine.EventSystems.AxisEventData::set_moveDir(UnityEngine.EventSystems.MoveDirection)
IL_0ed8: nop
IL_0ed9: stloc.s V_107
IL_0edb: ldloc.s V_106
IL_0edd: callvirt UnityEngine.GameObject UnityEngine.EventSystems.EventSystem::get_currentSelectedGameObject()
IL_0ee2: ldloc.s V_107
IL_0ee4: call UnityEngine.EventSystems.ExecuteEvents/EventFunction`1<UnityEngine.EventSystems.IMoveHandler> UnityEngine.EventSystems.ExecuteEvents::get_moveHandler()
IL_0ee9: call System.Boolean UnityEngine.EventSystems.ExecuteEvents::Execute<UnityEngine.EventSystems.IMoveHandler>(UnityEngine.GameObject,UnityEngine.EventSystems.BaseEventData,UnityEngine.EventSystems.ExecuteEvents/EventFunction`1<!!0>)
IL_0eee: ldc.i4.0
IL_0eef: ceq
IL_0ef1: stloc.s V_109
IL_0ef3: ldloc.s V_109
IL_0ef5: brfalse.s IL_0f02
IL_0ef7: ldstr "No move handler"
IL_0efc: newobj System.Void System.Exception::.ctor(System.String)
IL_0f01: throw
IL_0f02: nop
IL_0f03: br IL_124a
IL_0f08: ldloc.1
IL_0f09: ldstr "click "
IL_0f0e: callvirt System.Boolean System.String::StartsWith(System.String)
IL_0f13: stloc.s V_110
IL_0f15: ldloc.s V_110
IL_0f17: brfalse IL_0fd0
IL_0f1c: nop
IL_0f1d: ldloc.1
IL_0f1e: ldc.i4.6
IL_0f1f: callvirt System.String System.String::Substring(System.Int32)
IL_0f24: stloc.s V_111
IL_0f26: ldnull
IL_0f27: stloc.s V_112
IL_0f29: nop
IL_0f2a: call !!0[] UnityEngine.Resources::FindObjectsOfTypeAll<UnityEngine.UI.Button>()
IL_0f2f: stloc.s V_113
IL_0f31: ldc.i4.0
IL_0f32: stloc.s V_114
IL_0f34: br.s IL_0f95
IL_0f36: ldloc.s V_113
IL_0f38: ldloc.s V_114
IL_0f3a: ldelem.ref
IL_0f3b: stloc.s V_115
IL_0f3d: ldloc.s V_115
IL_0f3f: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0f44: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_0f49: brfalse.s IL_0f69
IL_0f4b: ldloc.s V_115
IL_0f4d: callvirt System.Boolean UnityEngine.UI.Selectable::get_interactable()
IL_0f52: brfalse.s IL_0f69
IL_0f54: ldloc.s V_115
IL_0f56: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0f5b: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_0f60: ldloc.s V_111
IL_0f62: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0f67: br.s IL_0f6a
IL_0f69: ldc.i4.0
IL_0f6a: stloc.s V_116
IL_0f6c: ldloc.s V_116
IL_0f6e: brfalse.s IL_0f8f
IL_0f70: nop
IL_0f71: ldloc.s V_112
IL_0f73: ldnull
IL_0f74: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0f79: stloc.s V_117
IL_0f7b: ldloc.s V_117
IL_0f7d: brfalse.s IL_0f8a
IL_0f7f: ldstr "Duplicate active button"
IL_0f84: newobj System.Void System.Exception::.ctor(System.String)
IL_0f89: throw
IL_0f8a: ldloc.s V_115
IL_0f8c: stloc.s V_112
IL_0f8e: nop
IL_0f8f: ldloc.s V_114
IL_0f91: ldc.i4.1
IL_0f92: add
IL_0f93: stloc.s V_114
IL_0f95: ldloc.s V_114
IL_0f97: ldloc.s V_113
IL_0f99: ldlen
IL_0f9a: conv.i4
IL_0f9b: blt.s IL_0f36
IL_0f9d: ldloc.s V_112
IL_0f9f: ldnull
IL_0fa0: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0fa5: stloc.s V_118
IL_0fa7: ldloc.s V_118
IL_0fa9: brfalse.s IL_0fbd
IL_0fab: ldstr "No matching active button: "
IL_0fb0: ldloc.s V_111
IL_0fb2: call System.String System.String::Concat(System.String,System.String)
IL_0fb7: newobj System.Void System.Exception::.ctor(System.String)
IL_0fbc: throw
IL_0fbd: ldloc.s V_112
IL_0fbf: callvirt UnityEngine.UI.Button/ButtonClickedEvent UnityEngine.UI.Button::get_onClick()
IL_0fc4: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_0fc9: nop
IL_0fca: nop
IL_0fcb: br IL_124a
IL_0fd0: ldloc.1
IL_0fd1: ldstr "menu "
IL_0fd6: callvirt System.Boolean System.String::StartsWith(System.String)
IL_0fdb: stloc.s V_119
IL_0fdd: ldloc.s V_119
IL_0fdf: brfalse IL_123f
IL_0fe4: nop
IL_0fe5: ldloc.1
IL_0fe6: ldc.i4.5
IL_0fe7: callvirt System.String System.String::Substring(System.Int32)
IL_0fec: ldc.i4.1
IL_0fed: newarr System.Char
IL_0ff2: dup
IL_0ff3: ldc.i4.0
IL_0ff4: ldc.i4.s 32
IL_0ff6: stelem.i2
IL_0ff7: callvirt System.String[] System.String::Split(System.Char[])
IL_0ffc: stloc.s V_120
IL_0ffe: ldloc.s V_120
IL_1000: ldlen
IL_1001: conv.i4
IL_1002: ldc.i4.2
IL_1003: bne.un.s IL_1025
IL_1005: ldloc.s V_120
IL_1007: ldc.i4.0
IL_1008: ldelem.ref
IL_1009: ldstr "PlayMenu"
IL_100e: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_1013: brfalse.s IL_1025
IL_1015: ldloc.s V_120
IL_1017: ldc.i4.1
IL_1018: ldelem.ref
IL_1019: ldstr "OnClickContinue"
IL_101e: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_1023: br.s IL_1026
IL_1025: ldc.i4.0
IL_1026: stloc.s V_121
IL_1028: ldloc.s V_120
IL_102a: ldlen
IL_102b: conv.i4
IL_102c: ldc.i4.2
IL_102d: bne.un.s IL_1098
IL_102f: ldloc.s V_120
IL_1031: ldc.i4.0
IL_1032: ldelem.ref
IL_1033: ldstr "StartScreenMainMenu"
IL_1038: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_103d: brtrue.s IL_105f
IL_103f: ldloc.s V_120
IL_1041: ldc.i4.0
IL_1042: ldelem.ref
IL_1043: ldstr "PlayMenu"
IL_1048: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_104d: brtrue.s IL_105f
IL_104f: ldloc.s V_120
IL_1051: ldc.i4.0
IL_1052: ldelem.ref
IL_1053: ldstr "OptionsMenu"
IL_1058: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_105d: brfalse.s IL_1098
IL_105f: ldloc.s V_120
IL_1061: ldc.i4.1
IL_1062: ldelem.ref
IL_1063: ldstr "OnClickStart"
IL_1068: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_106d: brtrue.s IL_108f
IL_106f: ldloc.s V_120
IL_1071: ldc.i4.1
IL_1072: ldelem.ref
IL_1073: ldstr "OnClickOptions"
IL_1078: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_107d: brtrue.s IL_108f
IL_107f: ldloc.s V_120
IL_1081: ldc.i4.1
IL_1082: ldelem.ref
IL_1083: ldstr "OnClickBack"
IL_1088: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_108d: br.s IL_1090
IL_108f: ldc.i4.1
IL_1090: ldloc.s V_121
IL_1092: or
IL_1093: ldc.i4.0
IL_1094: ceq
IL_1096: br.s IL_1099
IL_1098: ldc.i4.1
IL_1099: stloc.s V_123
IL_109b: ldloc.s V_123
IL_109d: brfalse.s IL_10aa
IL_109f: ldstr "Unsupported menu command"
IL_10a4: newobj System.Void System.Exception::.ctor(System.String)
IL_10a9: throw
IL_10aa: ldloc.s V_121
IL_10ac: stloc.s V_124
IL_10ae: ldloc.s V_124
IL_10b0: brfalse IL_1190
IL_10b5: nop
IL_10b6: call System.Boolean TheForestOfLove.Services.Persistence.SaveManager::get_HasSavedPlaySession()
IL_10bb: brfalse.s IL_10ec
IL_10bd: call UnityEngine.SceneManagement.Scene UnityEngine.SceneManagement.SceneManager::GetActiveScene()
IL_10c2: stloc.s V_10
IL_10c4: ldloca.s V_10
IL_10c6: call System.String UnityEngine.SceneManagement.Scene::get_name()
IL_10cb: ldstr "StartMenu"
IL_10d0: call System.Boolean System.String::op_Inequality(System.String,System.String)
IL_10d5: brtrue.s IL_10ec
IL_10d7: ldsfld System.Boolean Globals::isChapterSelect
IL_10dc: brtrue.s IL_10ec
IL_10de: ldsfld System.Boolean Globals::isCheatCode
IL_10e3: brtrue.s IL_10ec
IL_10e5: call System.Boolean PixelCrushers.DialogueSystem.DialogueManager::get_isConversationActive()
IL_10ea: br.s IL_10ed
IL_10ec: ldc.i4.1
IL_10ed: stloc.s V_126
IL_10ef: ldloc.s V_126
IL_10f1: brfalse.s IL_10fe
IL_10f3: ldstr "Original saved Continue state unavailable"
IL_10f8: newobj System.Void System.Exception::.ctor(System.String)
IL_10fd: throw
IL_10fe: ldc.i4.0
IL_10ff: stloc.s V_125
IL_1101: nop
IL_1102: call !!0[] UnityEngine.Resources::FindObjectsOfTypeAll<UnityEngine.UI.Button>()
IL_1107: stloc.s V_127
IL_1109: ldc.i4.0
IL_110a: stloc.s V_128
IL_110c: br.s IL_116e
IL_110e: ldloc.s V_127
IL_1110: ldloc.s V_128
IL_1112: ldelem.ref
IL_1113: stloc.s V_129
IL_1115: ldloc.s V_129
IL_1117: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_111c: callvirt UnityEngine.SceneManagement.Scene UnityEngine.GameObject::get_scene()
IL_1121: stloc.s V_10
IL_1123: ldloca.s V_10
IL_1125: call System.Boolean UnityEngine.SceneManagement.Scene::IsValid()
IL_112a: brfalse.s IL_115b
IL_112c: ldloc.s V_129
IL_112e: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_1133: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_1138: brfalse.s IL_115b
IL_113a: ldloc.s V_129
IL_113c: callvirt System.Boolean UnityEngine.UI.Selectable::get_interactable()
IL_1141: brfalse.s IL_115b
IL_1143: ldloc.s V_129
IL_1145: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_114a: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_114f: ldstr "Canvas/PlayMenu/Controls/Continue"
IL_1154: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_1159: br.s IL_115c
IL_115b: ldc.i4.0
IL_115c: stloc.s V_130
IL_115e: ldloc.s V_130
IL_1160: brfalse.s IL_1168
IL_1162: ldloc.s V_125
IL_1164: ldc.i4.1
IL_1165: add
IL_1166: stloc.s V_125
IL_1168: ldloc.s V_128
IL_116a: ldc.i4.1
IL_116b: add
IL_116c: stloc.s V_128
IL_116e: ldloc.s V_128
IL_1170: ldloc.s V_127
IL_1172: ldlen
IL_1173: conv.i4
IL_1174: blt.s IL_110e
IL_1176: ldloc.s V_125
IL_1178: ldc.i4.1
IL_1179: ceq
IL_117b: ldc.i4.0
IL_117c: ceq
IL_117e: stloc.s V_131
IL_1180: ldloc.s V_131
IL_1182: brfalse.s IL_118f
IL_1184: ldstr "Exact original Continue control unavailable"
IL_1189: newobj System.Void System.Exception::.ctor(System.String)
IL_118e: throw
IL_118f: nop
IL_1190: ldnull
IL_1191: stloc.s V_122
IL_1193: nop
IL_1194: call !!0[] UnityEngine.Resources::FindObjectsOfTypeAll<UnityEngine.MonoBehaviour>()
IL_1199: stloc.s V_132
IL_119b: ldc.i4.0
IL_119c: stloc.s V_133
IL_119e: br.s IL_1202
IL_11a0: ldloc.s V_132
IL_11a2: ldloc.s V_133
IL_11a4: ldelem.ref
IL_11a5: stloc.s V_134
IL_11a7: ldloc.s V_134
IL_11a9: ldnull
IL_11aa: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_11af: brfalse.s IL_11d6
IL_11b1: ldloc.s V_134
IL_11b3: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_11b8: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_11bd: brfalse.s IL_11d6
IL_11bf: ldloc.s V_134
IL_11c1: callvirt System.Type System.Object::GetType()
IL_11c6: callvirt System.String System.Reflection.MemberInfo::get_Name()
IL_11cb: ldloc.s V_120
IL_11cd: ldc.i4.0
IL_11ce: ldelem.ref
IL_11cf: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_11d4: br.s IL_11d7
IL_11d6: ldc.i4.0
IL_11d7: stloc.s V_135
IL_11d9: ldloc.s V_135
IL_11db: brfalse.s IL_11fc
IL_11dd: nop
IL_11de: ldloc.s V_122
IL_11e0: ldnull
IL_11e1: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_11e6: stloc.s V_136
IL_11e8: ldloc.s V_136
IL_11ea: brfalse.s IL_11f7
IL_11ec: ldstr "Duplicate active menu"
IL_11f1: newobj System.Void System.Exception::.ctor(System.String)
IL_11f6: throw
IL_11f7: ldloc.s V_134
IL_11f9: stloc.s V_122
IL_11fb: nop
IL_11fc: ldloc.s V_133
IL_11fe: ldc.i4.1
IL_11ff: add
IL_1200: stloc.s V_133
IL_1202: ldloc.s V_133
IL_1204: ldloc.s V_132
IL_1206: ldlen
IL_1207: conv.i4
IL_1208: blt.s IL_11a0
IL_120a: ldloc.s V_122
IL_120c: ldnull
IL_120d: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_1212: stloc.s V_137
IL_1214: ldloc.s V_137
IL_1216: brfalse.s IL_1223
IL_1218: ldstr "Menu not active"
IL_121d: newobj System.Void System.Exception::.ctor(System.String)
IL_1222: throw
IL_1223: ldloc.s V_122
IL_1225: callvirt System.Type System.Object::GetType()
IL_122a: ldloc.s V_120
IL_122c: ldc.i4.1
IL_122d: ldelem.ref
IL_122e: callvirt System.Reflection.MethodInfo System.Type::GetMethod(System.String)
IL_1233: ldloc.s V_122
IL_1235: ldnull
IL_1236: callvirt System.Object System.Reflection.MethodBase::Invoke(System.Object,System.Object[])
IL_123b: pop
IL_123c: nop
IL_123d: br.s IL_124a
IL_123f: ldstr "Unsupported command"
IL_1244: newobj System.Void System.Exception::.ctor(System.String)
IL_1249: throw
IL_124a: ldarg.0
IL_124b: ldfld System.String ForestProbe::root
IL_1250: ldstr "actions.log"
IL_1255: call System.String System.IO.Path::Combine(System.String,System.String)
IL_125a: call System.DateTime System.DateTime::get_UtcNow()
IL_125f: stloc.s V_138
IL_1261: ldloca.s V_138
IL_1263: ldstr "O"
IL_1268: call System.String System.DateTime::ToString(System.String)
IL_126d: ldstr " OK "
IL_1272: ldloc.1
IL_1273: ldstr "
"
IL_1278: call System.String System.String::Concat(System.String,System.String,System.String,System.String)
IL_127d: call System.Void System.IO.File::AppendAllText(System.String,System.String)
IL_1282: nop
IL_1283: nop
IL_1284: leave.s IL_12f8
IL_1286: stloc.s V_139
IL_1288: nop
IL_1289: ldarg.0
IL_128a: ldfld System.String ForestProbe::root
IL_128f: ldstr "actions.log"
IL_1294: call System.String System.IO.Path::Combine(System.String,System.String)
IL_1299: ldc.i4.6
IL_129a: newarr System.String
IL_129f: dup
IL_12a0: ldc.i4.0
IL_12a1: call System.DateTime System.DateTime::get_UtcNow()
IL_12a6: stloc.s V_138
IL_12a8: ldloca.s V_138
IL_12aa: ldstr "O"
IL_12af: call System.String System.DateTime::ToString(System.String)
IL_12b4: stelem.ref
IL_12b5: dup
IL_12b6: ldc.i4.1
IL_12b7: ldstr " FAIL "
IL_12bc: stelem.ref
IL_12bd: dup
IL_12be: ldc.i4.2
IL_12bf: ldloc.1
IL_12c0: stelem.ref
IL_12c1: dup
IL_12c2: ldc.i4.3
IL_12c3: ldstr " "
IL_12c8: stelem.ref
IL_12c9: dup
IL_12ca: ldc.i4.4
IL_12cb: ldloc.s V_139
IL_12cd: dup
IL_12ce: brtrue.s IL_12d4
IL_12d0: pop
IL_12d1: ldnull
IL_12d2: br.s IL_12d9
IL_12d4: callvirt System.String System.Object::ToString()
IL_12d9: stelem.ref
IL_12da: dup
IL_12db: ldc.i4.5
IL_12dc: ldstr "
"
IL_12e1: stelem.ref
IL_12e2: call System.String System.String::Concat(System.String[])
IL_12e7: call System.Void System.IO.File::AppendAllText(System.String,System.String)
IL_12ec: nop
IL_12ed: ldloc.s V_139
IL_12ef: call System.Void UnityEngine.Debug::LogException(System.Exception)
IL_12f4: nop
IL_12f5: nop
IL_12f6: leave.s IL_12f8
IL_12f8: ret
