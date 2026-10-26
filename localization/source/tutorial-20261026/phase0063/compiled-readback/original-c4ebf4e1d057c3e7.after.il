METHOD System.Void ForestProbe::Update() | attributes=Private, HideBySig | impl=IL
IL_0000: nop
IL_0001: call System.Single UnityEngine.Time::get_realtimeSinceStartup()
IL_0006: ldarg.0
IL_0007: ldfld System.Single ForestProbe::next
IL_000c: clt
IL_000e: stloc.2
IL_000f: ldloc.2
IL_0010: brfalse.s IL_0017
IL_0012: br IL_132f
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
IL_0046: br IL_132f
IL_004b: ldloc.0
IL_004c: call System.String System.IO.File::ReadAllText(System.String)
IL_0051: callvirt System.String System.String::Trim()
IL_0056: stloc.1
IL_0057: ldarg.0
IL_0058: ldloc.1
IL_0059: stfld System.String ForestProbe::lifecycleCommand
IL_005e: ldarg.0
IL_005f: ldstr "command-read"
IL_0064: call System.Void ForestProbe::ObserveLifecycle(System.String)
IL_0069: nop
IL_006a: ldloc.0
IL_006b: call System.Void System.IO.File::Delete(System.String)
IL_0070: nop
IL_0071: nop
IL_0072: ldloc.1
IL_0073: ldstr "dump-focus"
IL_0078: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_007d: stloc.s V_4
IL_007f: ldloc.s V_4
IL_0081: brfalse.s IL_0099
IL_0083: ldarg.0
IL_0084: ldstr "snapshot"
IL_0089: ldstr "unknown"
IL_008e: call System.Void ForestProbe::ObserveFocus(System.String,System.String)
IL_0093: nop
IL_0094: br IL_125d
IL_0099: ldloc.1
IL_009a: ldstr "dump"
IL_009f: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_00a4: stloc.s V_5
IL_00a6: ldloc.s V_5
IL_00a8: brfalse.s IL_00b6
IL_00aa: ldarg.0
IL_00ab: call System.Void ForestProbe::Dump()
IL_00b0: nop
IL_00b1: br IL_125d
IL_00b6: ldloc.1
IL_00b7: ldstr "dump-save-continuation"
IL_00bc: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_00c1: stloc.s V_6
IL_00c3: ldloc.s V_6
IL_00c5: brfalse.s IL_00d3
IL_00c7: ldarg.0
IL_00c8: call System.Void ForestProbe::DumpSaveContinuation()
IL_00cd: nop
IL_00ce: br IL_125d
IL_00d3: ldloc.1
IL_00d4: ldstr "dump-intro"
IL_00d9: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_00de: stloc.s V_7
IL_00e0: ldloc.s V_7
IL_00e2: brfalse.s IL_00f0
IL_00e4: ldarg.0
IL_00e5: call System.Void ForestProbe::DumpIntro()
IL_00ea: nop
IL_00eb: br IL_125d
IL_00f0: ldloc.1
IL_00f1: ldstr "dump-notebook"
IL_00f6: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_00fb: stloc.s V_8
IL_00fd: ldloc.s V_8
IL_00ff: brfalse.s IL_0179
IL_0101: nop
IL_0102: newobj System.Void ForestProbe/NotebookRouteState::.ctor()
IL_0107: dup
IL_0108: call UnityEngine.SceneManagement.Scene UnityEngine.SceneManagement.SceneManager::GetActiveScene()
IL_010d: stloc.s V_10
IL_010f: ldloca.s V_10
IL_0111: call System.String UnityEngine.SceneManagement.Scene::get_name()
IL_0116: stfld System.String ForestProbe/NotebookRouteState::scene
IL_011b: dup
IL_011c: call System.String UnityEngine.Application::get_companyName()
IL_0121: stfld System.String ForestProbe/NotebookRouteState::company
IL_0126: dup
IL_0127: call System.String UnityEngine.Application::get_productName()
IL_012c: stfld System.String ForestProbe/NotebookRouteState::product
IL_0131: dup
IL_0132: call System.String UnityEngine.Application::get_dataPath()
IL_0137: stfld System.String ForestProbe/NotebookRouteState::dataPath
IL_013c: dup
IL_013d: call System.String UnityEngine.Application::get_persistentDataPath()
IL_0142: stfld System.String ForestProbe/NotebookRouteState::persistentDataPath
IL_0147: dup
IL_0148: ldarg.0
IL_0149: call System.String[] ForestProbe::NotebookRouteDiagnostics()
IL_014e: stfld System.String[] ForestProbe/NotebookRouteState::diagnostics
IL_0153: stloc.s V_9
IL_0155: ldarg.0
IL_0156: ldfld System.String ForestProbe::root
IL_015b: ldstr "notebook-route.json"
IL_0160: call System.String System.IO.Path::Combine(System.String,System.String)
IL_0165: ldloc.s V_9
IL_0167: ldc.i4.1
IL_0168: call System.String UnityEngine.JsonUtility::ToJson(System.Object,System.Boolean)
IL_016d: call System.Void System.IO.File::WriteAllText(System.String,System.String)
IL_0172: nop
IL_0173: nop
IL_0174: br IL_125d
IL_0179: ldloc.1
IL_017a: ldstr "dump-tutorial"
IL_017f: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0184: stloc.s V_11
IL_0186: ldloc.s V_11
IL_0188: brfalse.s IL_0202
IL_018a: nop
IL_018b: newobj System.Void ForestProbe/NotebookRouteState::.ctor()
IL_0190: dup
IL_0191: call UnityEngine.SceneManagement.Scene UnityEngine.SceneManagement.SceneManager::GetActiveScene()
IL_0196: stloc.s V_10
IL_0198: ldloca.s V_10
IL_019a: call System.String UnityEngine.SceneManagement.Scene::get_name()
IL_019f: stfld System.String ForestProbe/NotebookRouteState::scene
IL_01a4: dup
IL_01a5: call System.String UnityEngine.Application::get_companyName()
IL_01aa: stfld System.String ForestProbe/NotebookRouteState::company
IL_01af: dup
IL_01b0: call System.String UnityEngine.Application::get_productName()
IL_01b5: stfld System.String ForestProbe/NotebookRouteState::product
IL_01ba: dup
IL_01bb: call System.String UnityEngine.Application::get_dataPath()
IL_01c0: stfld System.String ForestProbe/NotebookRouteState::dataPath
IL_01c5: dup
IL_01c6: call System.String UnityEngine.Application::get_persistentDataPath()
IL_01cb: stfld System.String ForestProbe/NotebookRouteState::persistentDataPath
IL_01d0: dup
IL_01d1: ldarg.0
IL_01d2: call System.String[] ForestProbe::TutorialRouteDiagnostics()
IL_01d7: stfld System.String[] ForestProbe/NotebookRouteState::diagnostics
IL_01dc: stloc.s V_12
IL_01de: ldarg.0
IL_01df: ldfld System.String ForestProbe::root
IL_01e4: ldstr "tutorial-route.json"
IL_01e9: call System.String System.IO.Path::Combine(System.String,System.String)
IL_01ee: ldloc.s V_12
IL_01f0: ldc.i4.1
IL_01f1: call System.String UnityEngine.JsonUtility::ToJson(System.Object,System.Boolean)
IL_01f6: call System.Void System.IO.File::WriteAllText(System.String,System.String)
IL_01fb: nop
IL_01fc: nop
IL_01fd: br IL_125d
IL_0202: ldloc.1
IL_0203: ldstr "dump-travel"
IL_0208: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_020d: stloc.s V_13
IL_020f: ldloc.s V_13
IL_0211: brfalse.s IL_028b
IL_0213: nop
IL_0214: newobj System.Void ForestProbe/NotebookRouteState::.ctor()
IL_0219: dup
IL_021a: call UnityEngine.SceneManagement.Scene UnityEngine.SceneManagement.SceneManager::GetActiveScene()
IL_021f: stloc.s V_10
IL_0221: ldloca.s V_10
IL_0223: call System.String UnityEngine.SceneManagement.Scene::get_name()
IL_0228: stfld System.String ForestProbe/NotebookRouteState::scene
IL_022d: dup
IL_022e: call System.String UnityEngine.Application::get_companyName()
IL_0233: stfld System.String ForestProbe/NotebookRouteState::company
IL_0238: dup
IL_0239: call System.String UnityEngine.Application::get_productName()
IL_023e: stfld System.String ForestProbe/NotebookRouteState::product
IL_0243: dup
IL_0244: call System.String UnityEngine.Application::get_dataPath()
IL_0249: stfld System.String ForestProbe/NotebookRouteState::dataPath
IL_024e: dup
IL_024f: call System.String UnityEngine.Application::get_persistentDataPath()
IL_0254: stfld System.String ForestProbe/NotebookRouteState::persistentDataPath
IL_0259: dup
IL_025a: ldarg.0
IL_025b: call System.String[] ForestProbe::TravelRouteDiagnostics()
IL_0260: stfld System.String[] ForestProbe/NotebookRouteState::diagnostics
IL_0265: stloc.s V_14
IL_0267: ldarg.0
IL_0268: ldfld System.String ForestProbe::root
IL_026d: ldstr "travel-route.json"
IL_0272: call System.String System.IO.Path::Combine(System.String,System.String)
IL_0277: ldloc.s V_14
IL_0279: ldc.i4.1
IL_027a: call System.String UnityEngine.JsonUtility::ToJson(System.Object,System.Boolean)
IL_027f: call System.Void System.IO.File::WriteAllText(System.String,System.String)
IL_0284: nop
IL_0285: nop
IL_0286: br IL_125d
IL_028b: ldloc.1
IL_028c: ldstr "dump-bucky"
IL_0291: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0296: stloc.s V_15
IL_0298: ldloc.s V_15
IL_029a: brfalse IL_0338
IL_029f: nop
IL_02a0: newobj System.Void ForestProbe/BuckyInteractionState::.ctor()
IL_02a5: dup
IL_02a6: call UnityEngine.SceneManagement.Scene UnityEngine.SceneManagement.SceneManager::GetActiveScene()
IL_02ab: stloc.s V_10
IL_02ad: ldloca.s V_10
IL_02af: call System.String UnityEngine.SceneManagement.Scene::get_name()
IL_02b4: stfld System.String ForestProbe/BuckyInteractionState::scene
IL_02b9: dup
IL_02ba: call System.String UnityEngine.Application::get_companyName()
IL_02bf: stfld System.String ForestProbe/BuckyInteractionState::company
IL_02c4: dup
IL_02c5: call System.String UnityEngine.Application::get_productName()
IL_02ca: stfld System.String ForestProbe/BuckyInteractionState::product
IL_02cf: dup
IL_02d0: call System.String UnityEngine.Application::get_dataPath()
IL_02d5: stfld System.String ForestProbe/BuckyInteractionState::dataPath
IL_02da: dup
IL_02db: call System.String UnityEngine.Application::get_persistentDataPath()
IL_02e0: stfld System.String ForestProbe/BuckyInteractionState::persistentDataPath
IL_02e5: dup
IL_02e6: ldstr "original"
IL_02eb: stfld System.String ForestProbe/BuckyInteractionState::choiceMode
IL_02f0: dup
IL_02f1: call System.Int32 UnityEngine.Time::get_frameCount()
IL_02f6: stfld System.Int32 ForestProbe/BuckyInteractionState::frame
IL_02fb: dup
IL_02fc: call System.Single UnityEngine.Time::get_realtimeSinceStartup()
IL_0301: stfld System.Single ForestProbe/BuckyInteractionState::realtime
IL_0306: dup
IL_0307: ldarg.0
IL_0308: call System.String[] ForestProbe::BuckyApproachDiagnostics()
IL_030d: stfld System.String[] ForestProbe/BuckyInteractionState::diagnostics
IL_0312: stloc.s V_16
IL_0314: ldarg.0
IL_0315: ldfld System.String ForestProbe::root
IL_031a: ldstr "bucky-interaction.json"
IL_031f: call System.String System.IO.Path::Combine(System.String,System.String)
IL_0324: ldloc.s V_16
IL_0326: ldc.i4.1
IL_0327: call System.String UnityEngine.JsonUtility::ToJson(System.Object,System.Boolean)
IL_032c: call System.Void System.IO.File::WriteAllText(System.String,System.String)
IL_0331: nop
IL_0332: nop
IL_0333: br IL_125d
IL_0338: ldloc.1
IL_0339: ldstr "dump-bucky-completion"
IL_033e: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0343: stloc.s V_17
IL_0345: ldloc.s V_17
IL_0347: brfalse IL_03e5
IL_034c: nop
IL_034d: newobj System.Void ForestProbe/BuckyInteractionState::.ctor()
IL_0352: dup
IL_0353: call UnityEngine.SceneManagement.Scene UnityEngine.SceneManagement.SceneManager::GetActiveScene()
IL_0358: stloc.s V_10
IL_035a: ldloca.s V_10
IL_035c: call System.String UnityEngine.SceneManagement.Scene::get_name()
IL_0361: stfld System.String ForestProbe/BuckyInteractionState::scene
IL_0366: dup
IL_0367: call System.String UnityEngine.Application::get_companyName()
IL_036c: stfld System.String ForestProbe/BuckyInteractionState::company
IL_0371: dup
IL_0372: call System.String UnityEngine.Application::get_productName()
IL_0377: stfld System.String ForestProbe/BuckyInteractionState::product
IL_037c: dup
IL_037d: call System.String UnityEngine.Application::get_dataPath()
IL_0382: stfld System.String ForestProbe/BuckyInteractionState::dataPath
IL_0387: dup
IL_0388: call System.String UnityEngine.Application::get_persistentDataPath()
IL_038d: stfld System.String ForestProbe/BuckyInteractionState::persistentDataPath
IL_0392: dup
IL_0393: ldstr "original"
IL_0398: stfld System.String ForestProbe/BuckyInteractionState::choiceMode
IL_039d: dup
IL_039e: call System.Int32 UnityEngine.Time::get_frameCount()
IL_03a3: stfld System.Int32 ForestProbe/BuckyInteractionState::frame
IL_03a8: dup
IL_03a9: call System.Single UnityEngine.Time::get_realtimeSinceStartup()
IL_03ae: stfld System.Single ForestProbe/BuckyInteractionState::realtime
IL_03b3: dup
IL_03b4: ldarg.0
IL_03b5: call System.String[] ForestProbe::BuckyCompletionDiagnostics()
IL_03ba: stfld System.String[] ForestProbe/BuckyInteractionState::diagnostics
IL_03bf: stloc.s V_18
IL_03c1: ldarg.0
IL_03c2: ldfld System.String ForestProbe::root
IL_03c7: ldstr "bucky-completion.json"
IL_03cc: call System.String System.IO.Path::Combine(System.String,System.String)
IL_03d1: ldloc.s V_18
IL_03d3: ldc.i4.1
IL_03d4: call System.String UnityEngine.JsonUtility::ToJson(System.Object,System.Boolean)
IL_03d9: call System.Void System.IO.File::WriteAllText(System.String,System.String)
IL_03de: nop
IL_03df: nop
IL_03e0: br IL_125d
IL_03e5: ldloc.1
IL_03e6: ldstr "qa-background-input"
IL_03eb: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_03f0: stloc.s V_19
IL_03f2: ldloc.s V_19
IL_03f4: brfalse.s IL_0462
IL_03f6: nop
IL_03f7: ldarg.0
IL_03f8: ldflda System.Nullable`1<System.Boolean> ForestProbe::originalIgnoreUnfocused
IL_03fd: call System.Boolean System.Nullable`1<System.Boolean>::get_HasValue()
IL_0402: brtrue.s IL_040e
IL_0404: call System.Boolean Rewired.ReInput::get_isReady()
IL_0409: ldc.i4.0
IL_040a: ceq
IL_040c: br.s IL_040f
IL_040e: ldc.i4.1
IL_040f: stloc.s V_20
IL_0411: ldloc.s V_20
IL_0413: brfalse.s IL_0420
IL_0415: ldstr "Background policy already changed or input not ready"
IL_041a: newobj System.Void System.Exception::.ctor(System.String)
IL_041f: throw
IL_0420: ldarg.0
IL_0421: call Rewired.ReInput/ConfigHelper Rewired.ReInput::get_configuration()
IL_0426: callvirt System.Boolean Rewired.ReInput/ConfigHelper::get_ignoreInputWhenAppNotInFocus()
IL_042b: newobj System.Void System.Nullable`1<System.Boolean>::.ctor(!0)
IL_0430: stfld System.Nullable`1<System.Boolean> ForestProbe::originalIgnoreUnfocused
IL_0435: call Rewired.ReInput/ConfigHelper Rewired.ReInput::get_configuration()
IL_043a: ldc.i4.0
IL_043b: callvirt System.Void Rewired.ReInput/ConfigHelper::set_ignoreInputWhenAppNotInFocus(System.Boolean)
IL_0440: nop
IL_0441: call Rewired.ReInput/ConfigHelper Rewired.ReInput::get_configuration()
IL_0446: callvirt System.Boolean Rewired.ReInput/ConfigHelper::get_ignoreInputWhenAppNotInFocus()
IL_044b: stloc.s V_21
IL_044d: ldloc.s V_21
IL_044f: brfalse.s IL_045c
IL_0451: ldstr "Public Rewired background policy did not apply"
IL_0456: newobj System.Void System.Exception::.ctor(System.String)
IL_045b: throw
IL_045c: nop
IL_045d: br IL_125d
IL_0462: ldloc.1
IL_0463: ldstr "restore-input-policy"
IL_0468: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_046d: stloc.s V_22
IL_046f: ldloc.s V_22
IL_0471: brfalse.s IL_047f
IL_0473: ldarg.0
IL_0474: call System.Void ForestProbe::RestoreInputPolicy()
IL_0479: nop
IL_047a: br IL_125d
IL_047f: ldloc.1
IL_0480: ldstr "sample-keyboard-start"
IL_0485: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_048a: stloc.s V_23
IL_048c: ldloc.s V_23
IL_048e: brfalse.s IL_04c1
IL_0490: nop
IL_0491: ldarg.0
IL_0492: ldfld System.Boolean ForestProbe::samplingKeyboard
IL_0497: stloc.s V_24
IL_0499: ldloc.s V_24
IL_049b: brfalse.s IL_04a8
IL_049d: ldstr "Keyboard sample already active"
IL_04a2: newobj System.Void System.Exception::.ctor(System.String)
IL_04a7: throw
IL_04a8: ldarg.0
IL_04a9: ldfld System.Collections.Generic.List`1<System.String> ForestProbe::keyboardSamples
IL_04ae: callvirt System.Void System.Collections.Generic.List`1<System.String>::Clear()
IL_04b3: nop
IL_04b4: ldarg.0
IL_04b5: ldc.i4.1
IL_04b6: stfld System.Boolean ForestProbe::samplingKeyboard
IL_04bb: nop
IL_04bc: br IL_125d
IL_04c1: ldloc.1
IL_04c2: ldstr "sample-keyboard-stop"
IL_04c7: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_04cc: stloc.s V_25
IL_04ce: ldloc.s V_25
IL_04d0: brfalse.s IL_051b
IL_04d2: nop
IL_04d3: ldarg.0
IL_04d4: ldfld System.Boolean ForestProbe::samplingKeyboard
IL_04d9: ldc.i4.0
IL_04da: ceq
IL_04dc: stloc.s V_26
IL_04de: ldloc.s V_26
IL_04e0: brfalse.s IL_04ed
IL_04e2: ldstr "No active keyboard sample"
IL_04e7: newobj System.Void System.Exception::.ctor(System.String)
IL_04ec: throw
IL_04ed: ldarg.0
IL_04ee: ldc.i4.0
IL_04ef: stfld System.Boolean ForestProbe::samplingKeyboard
IL_04f4: ldarg.0
IL_04f5: ldfld System.String ForestProbe::root
IL_04fa: ldstr "keyboard-samples.txt"
IL_04ff: call System.String System.IO.Path::Combine(System.String,System.String)
IL_0504: ldarg.0
IL_0505: ldfld System.Collections.Generic.List`1<System.String> ForestProbe::keyboardSamples
IL_050a: callvirt !0[] System.Collections.Generic.List`1<System.String>::ToArray()
IL_050f: call System.Void System.IO.File::WriteAllLines(System.String,System.String[])
IL_0514: nop
IL_0515: nop
IL_0516: br IL_125d
IL_051b: ldloc.1
IL_051c: ldstr "sample-keyboard-snapshot"
IL_0521: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0526: stloc.s V_27
IL_0528: ldloc.s V_27
IL_052a: brfalse.s IL_056e
IL_052c: nop
IL_052d: ldarg.0
IL_052e: ldfld System.Boolean ForestProbe::samplingKeyboard
IL_0533: ldc.i4.0
IL_0534: ceq
IL_0536: stloc.s V_28
IL_0538: ldloc.s V_28
IL_053a: brfalse.s IL_0547
IL_053c: ldstr "No active keyboard sample"
IL_0541: newobj System.Void System.Exception::.ctor(System.String)
IL_0546: throw
IL_0547: ldarg.0
IL_0548: ldfld System.String ForestProbe::root
IL_054d: ldstr "keyboard-samples.txt"
IL_0552: call System.String System.IO.Path::Combine(System.String,System.String)
IL_0557: ldarg.0
IL_0558: ldfld System.Collections.Generic.List`1<System.String> ForestProbe::keyboardSamples
IL_055d: callvirt !0[] System.Collections.Generic.List`1<System.String>::ToArray()
IL_0562: call System.Void System.IO.File::WriteAllLines(System.String,System.String[])
IL_0567: nop
IL_0568: nop
IL_0569: br IL_125d
IL_056e: ldloc.1
IL_056f: ldstr "quit"
IL_0574: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0579: stloc.s V_29
IL_057b: ldloc.s V_29
IL_057d: brfalse.s IL_0593
IL_057f: nop
IL_0580: ldarg.0
IL_0581: call System.Void ForestProbe::RestoreInputPolicy()
IL_0586: nop
IL_0587: call System.Void UnityEngine.Application::Quit()
IL_058c: nop
IL_058d: nop
IL_058e: br IL_125d
IL_0593: ldloc.1
IL_0594: ldstr "show-menu"
IL_0599: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_059e: stloc.s V_30
IL_05a0: ldloc.s V_30
IL_05a2: brfalse.s IL_05e7
IL_05a4: nop
IL_05a5: call !!0 UnityEngine.Object::FindObjectOfType<TheForestOfLove.MainMenuController>()
IL_05aa: stloc.s V_31
IL_05ac: ldloc.s V_31
IL_05ae: ldnull
IL_05af: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_05b4: stloc.s V_32
IL_05b6: ldloc.s V_32
IL_05b8: brfalse.s IL_05c5
IL_05ba: ldstr "Main menu controller not active"
IL_05bf: newobj System.Void System.Exception::.ctor(System.String)
IL_05c4: throw
IL_05c5: ldloc.s V_31
IL_05c7: callvirt System.Type System.Object::GetType()
IL_05cc: ldstr "FinishShowingMenu"
IL_05d1: ldc.i4.s 36
IL_05d3: callvirt System.Reflection.MethodInfo System.Type::GetMethod(System.String,System.Reflection.BindingFlags)
IL_05d8: ldloc.s V_31
IL_05da: ldnull
IL_05db: callvirt System.Object System.Reflection.MethodBase::Invoke(System.Object,System.Object[])
IL_05e0: pop
IL_05e1: nop
IL_05e2: br IL_125d
IL_05e7: ldloc.1
IL_05e8: ldstr "complete-tutorial158"
IL_05ed: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_05f2: stloc.s V_33
IL_05f4: ldloc.s V_33
IL_05f6: brfalse IL_0699
IL_05fb: nop
IL_05fc: ldarg.0
IL_05fd: ldfld System.Boolean ForestProbe::tutorial158Completed
IL_0602: stloc.s V_36
IL_0604: ldloc.s V_36
IL_0606: brfalse.s IL_0613
IL_0608: ldstr "Tutorial158 completion already acknowledged; no replay"
IL_060d: newobj System.Void System.Exception::.ctor(System.String)
IL_0612: throw
IL_0613: ldarg.0
IL_0614: ldloca.s V_34
IL_0616: call ForestProbe/TutorialCompletion ForestProbe::ReadTutorialCompletion(UnityEngine.UI.Button&)
IL_061b: stloc.s V_35
IL_061d: ldloc.s V_35
IL_061f: ldfld System.Boolean ForestProbe/TutorialCompletion::typing
IL_0624: stloc.s V_37
IL_0626: ldloc.s V_37
IL_0628: brfalse.s IL_0635
IL_062a: ldstr "Tutorial158 still typing; no completion"
IL_062f: newobj System.Void System.Exception::.ctor(System.String)
IL_0634: throw
IL_0635: ldloc.s V_35
IL_0637: ldloc.s V_35
IL_0639: ldfld System.Boolean ForestProbe/TutorialCompletion::menuPresent
IL_063e: brtrue.s IL_0647
IL_0640: ldstr "applied"
IL_0645: br.s IL_064c
IL_0647: ldstr "menu-present"
IL_064c: stfld System.String ForestProbe/TutorialCompletion::result
IL_0651: ldloc.s V_35
IL_0653: ldfld System.Boolean ForestProbe/TutorialCompletion::menuPresent
IL_0658: ldc.i4.0
IL_0659: ceq
IL_065b: stloc.s V_38
IL_065d: ldloc.s V_38
IL_065f: brfalse.s IL_066e
IL_0661: ldloc.s V_34
IL_0663: callvirt UnityEngine.UI.Button/ButtonClickedEvent UnityEngine.UI.Button::get_onClick()
IL_0668: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_066d: nop
IL_066e: ldarg.0
IL_066f: ldc.i4.1
IL_0670: stfld System.Boolean ForestProbe::tutorial158Completed
IL_0675: ldarg.0
IL_0676: ldfld System.String ForestProbe::root
IL_067b: ldstr "completion158-receipt.json"
IL_0680: call System.String System.IO.Path::Combine(System.String,System.String)
IL_0685: ldloc.s V_35
IL_0687: ldc.i4.1
IL_0688: call System.String UnityEngine.JsonUtility::ToJson(System.Object,System.Boolean)
IL_068d: call System.Void System.IO.File::WriteAllText(System.String,System.String)
IL_0692: nop
IL_0693: nop
IL_0694: br IL_125d
IL_0699: ldloc.1
IL_069a: ldstr "select-tutorial181 "
IL_069f: callvirt System.Boolean System.String::StartsWith(System.String)
IL_06a4: stloc.s V_39
IL_06a6: ldloc.s V_39
IL_06a8: brfalse IL_079e
IL_06ad: nop
IL_06ae: ldarg.0
IL_06af: ldfld System.Boolean ForestProbe::tutorial181Selected
IL_06b4: stloc.s V_45
IL_06b6: ldloc.s V_45
IL_06b8: brfalse.s IL_06c5
IL_06ba: ldstr "Tutorial181 already selected; no replay"
IL_06bf: newobj System.Void System.Exception::.ctor(System.String)
IL_06c4: throw
IL_06c5: ldloc.1
IL_06c6: ldc.i4.s 19
IL_06c8: callvirt System.String System.String::Substring(System.Int32)
IL_06cd: ldc.i4.1
IL_06ce: newarr System.Char
IL_06d3: dup
IL_06d4: ldc.i4.0
IL_06d5: ldc.i4.s 32
IL_06d7: stelem.i2
IL_06d8: callvirt System.String[] System.String::Split(System.Char[])
IL_06dd: stloc.s V_40
IL_06df: ldloc.s V_40
IL_06e1: ldlen
IL_06e2: conv.i4
IL_06e3: ldc.i4.2
IL_06e4: ceq
IL_06e6: ldc.i4.0
IL_06e7: ceq
IL_06e9: stloc.s V_46
IL_06eb: ldloc.s V_46
IL_06ed: brfalse.s IL_06fa
IL_06ef: ldstr "Expected observed frame and original button identity"
IL_06f4: newobj System.Void System.Exception::.ctor(System.String)
IL_06f9: throw
IL_06fa: ldloc.s V_40
IL_06fc: ldc.i4.0
IL_06fd: ldelem.ref
IL_06fe: call System.Int32 System.Int32::Parse(System.String)
IL_0703: stloc.s V_41
IL_0705: ldloc.s V_40
IL_0707: ldc.i4.1
IL_0708: ldelem.ref
IL_0709: call System.Int32 System.Int32::Parse(System.String)
IL_070e: stloc.s V_42
IL_0710: ldarg.0
IL_0711: ldloca.s V_43
IL_0713: call ForestProbe/Tutorial181Selection ForestProbe::ReadTutorial181(UnityEngine.UI.Button&)
IL_0718: stloc.s V_44
IL_071a: ldloc.s V_41
IL_071c: ldc.i4.0
IL_071d: ble.s IL_0748
IL_071f: ldloc.s V_41
IL_0721: ldloc.s V_44
IL_0723: ldfld System.Int32 ForestProbe/Tutorial181Selection::frame
IL_0728: bgt.s IL_0748
IL_072a: ldloc.s V_44
IL_072c: ldfld System.Int32 ForestProbe/Tutorial181Selection::frame
IL_0731: ldloc.s V_41
IL_0733: sub
IL_0734: ldc.i4.s 120
IL_0736: bgt.s IL_0748
IL_0738: ldloc.s V_44
IL_073a: ldfld System.Int32 ForestProbe/Tutorial181Selection::buttonInstance
IL_073f: ldloc.s V_42
IL_0741: ceq
IL_0743: ldc.i4.0
IL_0744: ceq
IL_0746: br.s IL_0749
IL_0748: ldc.i4.1
IL_0749: stloc.s V_47
IL_074b: ldloc.s V_47
IL_074d: brfalse.s IL_075a
IL_074f: ldstr "Stale Tutorial181 menu/control"
IL_0754: newobj System.Void System.Exception::.ctor(System.String)
IL_0759: throw
IL_075a: ldarg.0
IL_075b: ldc.i4.1
IL_075c: stfld System.Boolean ForestProbe::tutorial181Selected
IL_0761: ldloc.s V_44
IL_0763: ldstr "submitted"
IL_0768: stfld System.String ForestProbe/Tutorial181Selection::result
IL_076d: ldarg.0
IL_076e: ldfld System.String ForestProbe::root
IL_0773: ldstr "selection181-receipt.json"
IL_0778: call System.String System.IO.Path::Combine(System.String,System.String)
IL_077d: ldloc.s V_44
IL_077f: ldc.i4.1
IL_0780: call System.String UnityEngine.JsonUtility::ToJson(System.Object,System.Boolean)
IL_0785: call System.Void System.IO.File::WriteAllText(System.String,System.String)
IL_078a: nop
IL_078b: ldloc.s V_43
IL_078d: callvirt UnityEngine.UI.Button/ButtonClickedEvent UnityEngine.UI.Button::get_onClick()
IL_0792: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_0797: nop
IL_0798: nop
IL_0799: br IL_125d
IL_079e: ldloc.1
IL_079f: ldstr "select-bucky217 "
IL_07a4: callvirt System.Boolean System.String::StartsWith(System.String)
IL_07a9: stloc.s V_48
IL_07ab: ldloc.s V_48
IL_07ad: brfalse IL_08e0
IL_07b2: nop
IL_07b3: ldarg.0
IL_07b4: ldfld System.Boolean ForestProbe::bucky217Selected
IL_07b9: stloc.s V_54
IL_07bb: ldloc.s V_54
IL_07bd: brfalse.s IL_07ca
IL_07bf: ldstr "Bucky217 already selected; no replay"
IL_07c4: newobj System.Void System.Exception::.ctor(System.String)
IL_07c9: throw
IL_07ca: ldloc.1
IL_07cb: ldc.i4.s 16
IL_07cd: callvirt System.String System.String::Substring(System.Int32)
IL_07d2: ldc.i4.1
IL_07d3: newarr System.Char
IL_07d8: dup
IL_07d9: ldc.i4.0
IL_07da: ldc.i4.s 32
IL_07dc: stelem.i2
IL_07dd: callvirt System.String[] System.String::Split(System.Char[])
IL_07e2: stloc.s V_49
IL_07e4: ldloc.s V_49
IL_07e6: ldlen
IL_07e7: conv.i4
IL_07e8: ldc.i4.2
IL_07e9: ceq
IL_07eb: ldc.i4.0
IL_07ec: ceq
IL_07ee: stloc.s V_55
IL_07f0: ldloc.s V_55
IL_07f2: brfalse.s IL_07ff
IL_07f4: ldstr "Expected observed frame and original button identity"
IL_07f9: newobj System.Void System.Exception::.ctor(System.String)
IL_07fe: throw
IL_07ff: ldloc.s V_49
IL_0801: ldc.i4.0
IL_0802: ldelem.ref
IL_0803: call System.Int32 System.Int32::Parse(System.String)
IL_0808: stloc.s V_50
IL_080a: ldloc.s V_49
IL_080c: ldc.i4.1
IL_080d: ldelem.ref
IL_080e: call System.Int32 System.Int32::Parse(System.String)
IL_0813: stloc.s V_51
IL_0815: ldarg.0
IL_0816: ldloca.s V_52
IL_0818: call ForestProbe/Bucky217Selection ForestProbe::ReadBucky217(UnityEngine.UI.Button&)
IL_081d: stloc.s V_53
IL_081f: ldloc.s V_50
IL_0821: ldc.i4.0
IL_0822: ble.s IL_084d
IL_0824: ldloc.s V_50
IL_0826: ldloc.s V_53
IL_0828: ldfld System.Int32 ForestProbe/Bucky217Selection::frame
IL_082d: bgt.s IL_084d
IL_082f: ldloc.s V_53
IL_0831: ldfld System.Int32 ForestProbe/Bucky217Selection::frame
IL_0836: ldloc.s V_50
IL_0838: sub
IL_0839: ldc.i4.s 120
IL_083b: bgt.s IL_084d
IL_083d: ldloc.s V_53
IL_083f: ldfld System.Int32 ForestProbe/Bucky217Selection::buttonInstance
IL_0844: ldloc.s V_51
IL_0846: ceq
IL_0848: ldc.i4.0
IL_0849: ceq
IL_084b: br.s IL_084e
IL_084d: ldc.i4.1
IL_084e: stloc.s V_56
IL_0850: ldloc.s V_56
IL_0852: brfalse.s IL_085f
IL_0854: ldstr "Stale Bucky217 menu/control"
IL_0859: newobj System.Void System.Exception::.ctor(System.String)
IL_085e: throw
IL_085f: ldarg.0
IL_0860: ldc.i4.1
IL_0861: stfld System.Boolean ForestProbe::bucky217Selected
IL_0866: ldarg.0
IL_0867: ldsfld UnityEngine.Events.UnityEvent`4<TheForestOfLove.Narrative.Dialogue,TheForestOfLove.Narrative.Arc,System.Int32,System.Int32> TheForestOfLove.Narrative.DialogueService::onDialogueLineArcTriggerCheck
IL_086c: stfld UnityEngine.Events.UnityEvent`4<TheForestOfLove.Narrative.Dialogue,TheForestOfLove.Narrative.Arc,System.Int32,System.Int32> ForestProbe::buckyLineEndSource
IL_0871: ldarg.0
IL_0872: ldfld UnityEngine.Events.UnityEvent`4<TheForestOfLove.Narrative.Dialogue,TheForestOfLove.Narrative.Arc,System.Int32,System.Int32> ForestProbe::buckyLineEndSource
IL_0877: ldnull
IL_0878: ceq
IL_087a: stloc.s V_57
IL_087c: ldloc.s V_57
IL_087e: brfalse.s IL_088b
IL_0880: ldstr "Bucky original line-end event absent"
IL_0885: newobj System.Void System.Exception::.ctor(System.String)
IL_088a: throw
IL_088b: ldarg.0
IL_088c: ldfld UnityEngine.Events.UnityEvent`4<TheForestOfLove.Narrative.Dialogue,TheForestOfLove.Narrative.Arc,System.Int32,System.Int32> ForestProbe::buckyLineEndSource
IL_0891: ldarg.0
IL_0892: ldftn System.Void ForestProbe::ObserveBucky212End(TheForestOfLove.Narrative.Dialogue,TheForestOfLove.Narrative.Arc,System.Int32,System.Int32)
IL_0898: newobj System.Void UnityEngine.Events.UnityAction`4<TheForestOfLove.Narrative.Dialogue,TheForestOfLove.Narrative.Arc,System.Int32,System.Int32>::.ctor(System.Object,System.IntPtr)
IL_089d: callvirt System.Void UnityEngine.Events.UnityEvent`4<TheForestOfLove.Narrative.Dialogue,TheForestOfLove.Narrative.Arc,System.Int32,System.Int32>::AddListener(UnityEngine.Events.UnityAction`4<!0,!1,!2,!3>)
IL_08a2: nop
IL_08a3: ldloc.s V_53
IL_08a5: ldstr "submitted"
IL_08aa: stfld System.String ForestProbe/Bucky217Selection::result
IL_08af: ldarg.0
IL_08b0: ldfld System.String ForestProbe::root
IL_08b5: ldstr "selection217-receipt.json"
IL_08ba: call System.String System.IO.Path::Combine(System.String,System.String)
IL_08bf: ldloc.s V_53
IL_08c1: ldc.i4.1
IL_08c2: call System.String UnityEngine.JsonUtility::ToJson(System.Object,System.Boolean)
IL_08c7: call System.Void System.IO.File::WriteAllText(System.String,System.String)
IL_08cc: nop
IL_08cd: ldloc.s V_52
IL_08cf: callvirt UnityEngine.UI.Button/ButtonClickedEvent UnityEngine.UI.Button::get_onClick()
IL_08d4: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_08d9: nop
IL_08da: nop
IL_08db: br IL_125d
IL_08e0: ldloc.1
IL_08e1: ldstr "continue-bound "
IL_08e6: callvirt System.Boolean System.String::StartsWith(System.String)
IL_08eb: stloc.s V_58
IL_08ed: ldloc.s V_58
IL_08ef: brfalse IL_0a3f
IL_08f4: nop
IL_08f5: ldloc.1
IL_08f6: ldc.i4.s 15
IL_08f8: callvirt System.String System.String::Substring(System.Int32)
IL_08fd: ldc.i4.1
IL_08fe: newarr System.Char
IL_0903: dup
IL_0904: ldc.i4.0
IL_0905: ldc.i4.s 32
IL_0907: stelem.i2
IL_0908: callvirt System.String[] System.String::Split(System.Char[])
IL_090d: stloc.s V_59
IL_090f: ldloc.s V_59
IL_0911: ldlen
IL_0912: conv.i4
IL_0913: ldc.i4.2
IL_0914: ceq
IL_0916: ldc.i4.0
IL_0917: ceq
IL_0919: stloc.s V_66
IL_091b: ldloc.s V_66
IL_091d: brfalse.s IL_092a
IL_091f: ldstr "Expected conversation and source entry"
IL_0924: newobj System.Void System.Exception::.ctor(System.String)
IL_0929: throw
IL_092a: ldloc.s V_59
IL_092c: ldc.i4.0
IL_092d: ldelem.ref
IL_092e: call System.Int32 System.Int32::Parse(System.String)
IL_0933: stloc.s V_60
IL_0935: ldloc.s V_59
IL_0937: ldc.i4.1
IL_0938: ldelem.ref
IL_0939: call System.Int32 System.Int32::Parse(System.String)
IL_093e: stloc.s V_61
IL_0940: ldloc.s V_60
IL_0942: ldc.i4.s 120
IL_0944: bne.un.s IL_0951
IL_0946: ldloc.s V_61
IL_0948: ldc.i4 158
IL_094d: ceq
IL_094f: br.s IL_0952
IL_0951: ldc.i4.0
IL_0952: stloc.s V_67
IL_0954: ldloc.s V_67
IL_0956: brfalse.s IL_0963
IL_0958: ldstr "Tutorial158 requires guarded completion"
IL_095d: newobj System.Void System.Exception::.ctor(System.String)
IL_0962: throw
IL_0963: call PixelCrushers.DialogueSystem.ConversationState PixelCrushers.DialogueSystem.DialogueManager::get_currentConversationState()
IL_0968: stloc.s V_62
IL_096a: ldloc.s V_62
IL_096c: brfalse.s IL_0985
IL_096e: ldloc.s V_62
IL_0970: ldfld PixelCrushers.DialogueSystem.Subtitle PixelCrushers.DialogueSystem.ConversationState::subtitle
IL_0975: brfalse.s IL_0985
IL_0977: ldloc.s V_62
IL_0979: ldfld PixelCrushers.DialogueSystem.Subtitle PixelCrushers.DialogueSystem.ConversationState::subtitle
IL_097e: ldfld PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Subtitle::dialogueEntry
IL_0983: br.s IL_0986
IL_0985: ldnull
IL_0986: stloc.s V_63
IL_0988: newobj System.Void ForestProbe/ContinueReceipt::.ctor()
IL_098d: dup
IL_098e: call System.Boolean PixelCrushers.DialogueSystem.DialogueManager::get_isConversationActive()
IL_0993: stfld System.Boolean ForestProbe/ContinueReceipt::active
IL_0998: dup
IL_0999: ldloc.s V_60
IL_099b: stfld System.Int32 ForestProbe/ContinueReceipt::expectedConversationId
IL_09a0: dup
IL_09a1: ldloc.s V_61
IL_09a3: stfld System.Int32 ForestProbe/ContinueReceipt::expectedEntryId
IL_09a8: dup
IL_09a9: ldloc.s V_63
IL_09ab: brfalse.s IL_09b6
IL_09ad: ldloc.s V_63
IL_09af: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::conversationID
IL_09b4: br.s IL_09b7
IL_09b6: ldc.i4.m1
IL_09b7: stfld System.Int32 ForestProbe/ContinueReceipt::actualConversationId
IL_09bc: dup
IL_09bd: ldloc.s V_63
IL_09bf: brfalse.s IL_09ca
IL_09c1: ldloc.s V_63
IL_09c3: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_09c8: br.s IL_09cb
IL_09ca: ldc.i4.m1
IL_09cb: stfld System.Int32 ForestProbe/ContinueReceipt::actualEntryId
IL_09d0: stloc.s V_64
IL_09d2: ldloc.s V_64
IL_09d4: ldfld System.Boolean ForestProbe/ContinueReceipt::active
IL_09d9: brfalse.s IL_09f3
IL_09db: ldloc.s V_64
IL_09dd: ldfld System.Int32 ForestProbe/ContinueReceipt::actualConversationId
IL_09e2: ldloc.s V_60
IL_09e4: bne.un.s IL_09f3
IL_09e6: ldloc.s V_64
IL_09e8: ldfld System.Int32 ForestProbe/ContinueReceipt::actualEntryId
IL_09ed: ldloc.s V_61
IL_09ef: ceq
IL_09f1: br.s IL_09f4
IL_09f3: ldc.i4.0
IL_09f4: stloc.s V_65
IL_09f6: ldloc.s V_65
IL_09f8: stloc.s V_68
IL_09fa: ldloc.s V_68
IL_09fc: brfalse.s IL_0a04
IL_09fe: call System.Void TheForestOfLove.CustomTypewriterEffectTextMeshPro::FastForwardTextOrAdvanceDialogue()
IL_0a03: nop
IL_0a04: ldloc.s V_64
IL_0a06: ldloc.s V_65
IL_0a08: brtrue.s IL_0a11
IL_0a0a: ldstr "stale"
IL_0a0f: br.s IL_0a16
IL_0a11: ldstr "applied"
IL_0a16: stfld System.String ForestProbe/ContinueReceipt::result
IL_0a1b: ldarg.0
IL_0a1c: ldfld System.String ForestProbe::root
IL_0a21: ldstr "continue-receipt.json"
IL_0a26: call System.String System.IO.Path::Combine(System.String,System.String)
IL_0a2b: ldloc.s V_64
IL_0a2d: ldc.i4.1
IL_0a2e: call System.String UnityEngine.JsonUtility::ToJson(System.Object,System.Boolean)
IL_0a33: call System.Void System.IO.File::WriteAllText(System.String,System.String)
IL_0a38: nop
IL_0a39: nop
IL_0a3a: br IL_125d
IL_0a3f: ldloc.1
IL_0a40: ldstr "continue"
IL_0a45: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0a4a: stloc.s V_69
IL_0a4c: ldloc.s V_69
IL_0a4e: brfalse.s IL_0a76
IL_0a50: nop
IL_0a51: call System.Boolean PixelCrushers.DialogueSystem.DialogueManager::get_isConversationActive()
IL_0a56: ldc.i4.0
IL_0a57: ceq
IL_0a59: stloc.s V_70
IL_0a5b: ldloc.s V_70
IL_0a5d: brfalse.s IL_0a6a
IL_0a5f: ldstr "No active conversation"
IL_0a64: newobj System.Void System.Exception::.ctor(System.String)
IL_0a69: throw
IL_0a6a: call System.Void TheForestOfLove.CustomTypewriterEffectTextMeshPro::FastForwardTextOrAdvanceDialogue()
IL_0a6f: nop
IL_0a70: nop
IL_0a71: br IL_125d
IL_0a76: ldloc.1
IL_0a77: ldstr "response "
IL_0a7c: callvirt System.Boolean System.String::StartsWith(System.String)
IL_0a81: stloc.s V_71
IL_0a83: ldloc.s V_71
IL_0a85: brfalse IL_0c79
IL_0a8a: nop
IL_0a8b: ldloc.1
IL_0a8c: ldc.i4.s 9
IL_0a8e: callvirt System.String System.String::Substring(System.Int32)
IL_0a93: ldc.i4.1
IL_0a94: newarr System.Char
IL_0a99: dup
IL_0a9a: ldc.i4.0
IL_0a9b: ldc.i4.s 32
IL_0a9d: stelem.i2
IL_0a9e: callvirt System.String[] System.String::Split(System.Char[])
IL_0aa3: stloc.s V_72
IL_0aa5: ldloc.s V_72
IL_0aa7: ldlen
IL_0aa8: conv.i4
IL_0aa9: ldc.i4.3
IL_0aaa: ceq
IL_0aac: ldc.i4.0
IL_0aad: ceq
IL_0aaf: stloc.s V_78
IL_0ab1: ldloc.s V_78
IL_0ab3: brfalse.s IL_0ac0
IL_0ab5: ldstr "Expected source entry, conversation and destination entry"
IL_0aba: newobj System.Void System.Exception::.ctor(System.String)
IL_0abf: throw
IL_0ac0: ldloc.s V_72
IL_0ac2: ldc.i4.0
IL_0ac3: ldelem.ref
IL_0ac4: call System.Int32 System.Int32::Parse(System.String)
IL_0ac9: stloc.s V_73
IL_0acb: ldloc.s V_72
IL_0acd: ldc.i4.1
IL_0ace: ldelem.ref
IL_0acf: call System.Int32 System.Int32::Parse(System.String)
IL_0ad4: stloc.s V_74
IL_0ad6: ldloc.s V_72
IL_0ad8: ldc.i4.2
IL_0ad9: ldelem.ref
IL_0ada: call System.Int32 System.Int32::Parse(System.String)
IL_0adf: stloc.s V_75
IL_0ae1: ldloc.s V_74
IL_0ae3: ldc.i4.s 120
IL_0ae5: bne.un.s IL_0af2
IL_0ae7: ldloc.s V_73
IL_0ae9: ldc.i4 158
IL_0aee: ceq
IL_0af0: br.s IL_0af3
IL_0af2: ldc.i4.0
IL_0af3: stloc.s V_79
IL_0af5: ldloc.s V_79
IL_0af7: brfalse.s IL_0b04
IL_0af9: ldstr "Tutorial159/181 choices forbidden"
IL_0afe: newobj System.Void System.Exception::.ctor(System.String)
IL_0b03: throw
IL_0b04: call PixelCrushers.DialogueSystem.ConversationState PixelCrushers.DialogueSystem.DialogueManager::get_currentConversationState()
IL_0b09: stloc.s V_76
IL_0b0b: call System.Boolean PixelCrushers.DialogueSystem.DialogueManager::get_isConversationActive()
IL_0b10: brfalse.s IL_0b5c
IL_0b12: ldloc.s V_76
IL_0b14: brfalse.s IL_0b5c
IL_0b16: ldloc.s V_76
IL_0b18: ldfld PixelCrushers.DialogueSystem.Subtitle PixelCrushers.DialogueSystem.ConversationState::subtitle
IL_0b1d: brfalse.s IL_0b5c
IL_0b1f: ldloc.s V_76
IL_0b21: ldfld PixelCrushers.DialogueSystem.Subtitle PixelCrushers.DialogueSystem.ConversationState::subtitle
IL_0b26: ldfld PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Subtitle::dialogueEntry
IL_0b2b: brfalse.s IL_0b5c
IL_0b2d: ldloc.s V_76
IL_0b2f: ldfld PixelCrushers.DialogueSystem.Subtitle PixelCrushers.DialogueSystem.ConversationState::subtitle
IL_0b34: ldfld PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Subtitle::dialogueEntry
IL_0b39: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::conversationID
IL_0b3e: ldloc.s V_74
IL_0b40: bne.un.s IL_0b5c
IL_0b42: ldloc.s V_76
IL_0b44: ldfld PixelCrushers.DialogueSystem.Subtitle PixelCrushers.DialogueSystem.ConversationState::subtitle
IL_0b49: ldfld PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Subtitle::dialogueEntry
IL_0b4e: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_0b53: ldloc.s V_73
IL_0b55: ceq
IL_0b57: ldc.i4.0
IL_0b58: ceq
IL_0b5a: br.s IL_0b5d
IL_0b5c: ldc.i4.1
IL_0b5d: stloc.s V_80
IL_0b5f: ldloc.s V_80
IL_0b61: brfalse.s IL_0b6e
IL_0b63: ldstr "Response source changed"
IL_0b68: newobj System.Void System.Exception::.ctor(System.String)
IL_0b6d: throw
IL_0b6e: ldnull
IL_0b6f: stloc.s V_77
IL_0b71: nop
IL_0b72: call !!0[] UnityEngine.Resources::FindObjectsOfTypeAll<PixelCrushers.DialogueSystem.StandardUIResponseButton>()
IL_0b77: stloc.s V_81
IL_0b79: ldc.i4.0
IL_0b7a: stloc.s V_82
IL_0b7c: br.s IL_0be8
IL_0b7e: ldloc.s V_81
IL_0b80: ldloc.s V_82
IL_0b82: ldelem.ref
IL_0b83: stloc.s V_83
IL_0b85: ldloc.s V_83
IL_0b87: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0b8c: callvirt UnityEngine.SceneManagement.Scene UnityEngine.GameObject::get_scene()
IL_0b91: stloc.s V_10
IL_0b93: ldloca.s V_10
IL_0b95: call System.Boolean UnityEngine.SceneManagement.Scene::IsValid()
IL_0b9a: brfalse.s IL_0bbc
IL_0b9c: ldloc.s V_83
IL_0b9e: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0ba3: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_0ba8: brfalse.s IL_0bbc
IL_0baa: ldloc.s V_83
IL_0bac: callvirt System.Boolean PixelCrushers.DialogueSystem.StandardUIResponseButton::get_isVisible()
IL_0bb1: brfalse.s IL_0bbc
IL_0bb3: ldloc.s V_83
IL_0bb5: callvirt System.Boolean PixelCrushers.DialogueSystem.StandardUIResponseButton::get_isClickable()
IL_0bba: br.s IL_0bbd
IL_0bbc: ldc.i4.0
IL_0bbd: stloc.s V_84
IL_0bbf: ldloc.s V_84
IL_0bc1: brfalse.s IL_0be2
IL_0bc3: nop
IL_0bc4: ldloc.s V_77
IL_0bc6: ldnull
IL_0bc7: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0bcc: stloc.s V_85
IL_0bce: ldloc.s V_85
IL_0bd0: brfalse.s IL_0bdd
IL_0bd2: ldstr "More than one live response; hold for source review"
IL_0bd7: newobj System.Void System.Exception::.ctor(System.String)
IL_0bdc: throw
IL_0bdd: ldloc.s V_83
IL_0bdf: stloc.s V_77
IL_0be1: nop
IL_0be2: ldloc.s V_82
IL_0be4: ldc.i4.1
IL_0be5: add
IL_0be6: stloc.s V_82
IL_0be8: ldloc.s V_82
IL_0bea: ldloc.s V_81
IL_0bec: ldlen
IL_0bed: conv.i4
IL_0bee: blt.s IL_0b7e
IL_0bf0: ldloc.s V_77
IL_0bf2: ldnull
IL_0bf3: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0bf8: brtrue.s IL_0c4f
IL_0bfa: ldloc.s V_77
IL_0bfc: callvirt PixelCrushers.DialogueSystem.Response PixelCrushers.DialogueSystem.StandardUIResponseButton::get_response()
IL_0c01: brfalse.s IL_0c4f
IL_0c03: ldloc.s V_77
IL_0c05: callvirt PixelCrushers.DialogueSystem.Response PixelCrushers.DialogueSystem.StandardUIResponseButton::get_response()
IL_0c0a: ldfld PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Response::destinationEntry
IL_0c0f: brfalse.s IL_0c4f
IL_0c11: ldloc.s V_77
IL_0c13: callvirt UnityEngine.Transform PixelCrushers.DialogueSystem.StandardUIResponseButton::get_target()
IL_0c18: ldnull
IL_0c19: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0c1e: brtrue.s IL_0c4f
IL_0c20: ldloc.s V_77
IL_0c22: callvirt PixelCrushers.DialogueSystem.Response PixelCrushers.DialogueSystem.StandardUIResponseButton::get_response()
IL_0c27: ldfld PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Response::destinationEntry
IL_0c2c: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::conversationID
IL_0c31: ldloc.s V_74
IL_0c33: bne.un.s IL_0c4f
IL_0c35: ldloc.s V_77
IL_0c37: callvirt PixelCrushers.DialogueSystem.Response PixelCrushers.DialogueSystem.StandardUIResponseButton::get_response()
IL_0c3c: ldfld PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Response::destinationEntry
IL_0c41: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_0c46: ldloc.s V_75
IL_0c48: ceq
IL_0c4a: ldc.i4.0
IL_0c4b: ceq
IL_0c4d: br.s IL_0c50
IL_0c4f: ldc.i4.1
IL_0c50: stloc.s V_86
IL_0c52: ldloc.s V_86
IL_0c54: brfalse.s IL_0c61
IL_0c56: ldstr "Response does not match source-bound successor"
IL_0c5b: newobj System.Void System.Exception::.ctor(System.String)
IL_0c60: throw
IL_0c61: ldloc.s V_77
IL_0c63: ldfld UnityEngine.UI.Button PixelCrushers.DialogueSystem.StandardUIResponseButton::button
IL_0c68: callvirt UnityEngine.UI.Button/ButtonClickedEvent UnityEngine.UI.Button::get_onClick()
IL_0c6d: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_0c72: nop
IL_0c73: nop
IL_0c74: br IL_125d
IL_0c79: ldloc.1
IL_0c7a: ldstr "probe-nameplate"
IL_0c7f: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0c84: stloc.s V_87
IL_0c86: ldloc.s V_87
IL_0c88: brfalse.s IL_0cf8
IL_0c8a: nop
IL_0c8b: call System.Boolean PixelCrushers.DialogueSystem.DialogueManager::get_isConversationActive()
IL_0c90: ldc.i4.0
IL_0c91: ceq
IL_0c93: stloc.s V_89
IL_0c95: ldloc.s V_89
IL_0c97: brfalse.s IL_0ca4
IL_0c99: ldstr "No active conversation"
IL_0c9e: newobj System.Void System.Exception::.ctor(System.String)
IL_0ca3: throw
IL_0ca4: call !!0 UnityEngine.Object::FindObjectOfType<TheForestOfLove.DialogueNameplateController>()
IL_0ca9: stloc.s V_88
IL_0cab: ldloc.s V_88
IL_0cad: ldnull
IL_0cae: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0cb3: stloc.s V_90
IL_0cb5: ldloc.s V_90
IL_0cb7: brfalse.s IL_0cc4
IL_0cb9: ldstr "No active nameplate controller"
IL_0cbe: newobj System.Void System.Exception::.ctor(System.String)
IL_0cc3: throw
IL_0cc4: ldloc.s V_88
IL_0cc6: ldstr "Ёж Йй 123"
IL_0ccb: callvirt System.Void TheForestOfLove.DialogueNameplateController::SetCustomNameplateUntilCleared(System.String)
IL_0cd0: nop
IL_0cd1: ldloc.s V_88
IL_0cd3: callvirt System.Type System.Object::GetType()
IL_0cd8: ldstr "UpdateNameplate"
IL_0cdd: ldc.i4.s 36
IL_0cdf: callvirt System.Reflection.MethodInfo System.Type::GetMethod(System.String,System.Reflection.BindingFlags)
IL_0ce4: ldloc.s V_88
IL_0ce6: ldc.i4.1
IL_0ce7: newarr System.Object
IL_0cec: callvirt System.Object System.Reflection.MethodBase::Invoke(System.Object,System.Object[])
IL_0cf1: pop
IL_0cf2: nop
IL_0cf3: br IL_125d
IL_0cf8: ldloc.1
IL_0cf9: ldstr "capture "
IL_0cfe: callvirt System.Boolean System.String::StartsWith(System.String)
IL_0d03: stloc.s V_91
IL_0d05: ldloc.s V_91
IL_0d07: brfalse.s IL_0d82
IL_0d09: nop
IL_0d0a: ldloc.1
IL_0d0b: ldc.i4.8
IL_0d0c: callvirt System.String System.String::Substring(System.Int32)
IL_0d11: stloc.s V_92
IL_0d13: ldloc.s V_92
IL_0d15: call System.String System.IO.Path::GetFileName(System.String)
IL_0d1a: ldloc.s V_92
IL_0d1c: call System.Boolean System.String::op_Inequality(System.String,System.String)
IL_0d21: brtrue.s IL_0d34
IL_0d23: ldloc.s V_92
IL_0d25: ldstr ".png"
IL_0d2a: callvirt System.Boolean System.String::EndsWith(System.String)
IL_0d2f: ldc.i4.0
IL_0d30: ceq
IL_0d32: br.s IL_0d35
IL_0d34: ldc.i4.1
IL_0d35: stloc.s V_94
IL_0d37: ldloc.s V_94
IL_0d39: brfalse.s IL_0d46
IL_0d3b: ldstr "Invalid capture name"
IL_0d40: newobj System.Void System.Exception::.ctor(System.String)
IL_0d45: throw
IL_0d46: ldarg.0
IL_0d47: ldfld System.String ForestProbe::root
IL_0d4c: ldloc.s V_92
IL_0d4e: call System.String System.IO.Path::Combine(System.String,System.String)
IL_0d53: stloc.s V_93
IL_0d55: ldloc.s V_93
IL_0d57: call System.Boolean System.IO.File::Exists(System.String)
IL_0d5c: stloc.s V_95
IL_0d5e: ldloc.s V_95
IL_0d60: brfalse.s IL_0d6d
IL_0d62: ldstr "Capture already exists"
IL_0d67: newobj System.Void System.Exception::.ctor(System.String)
IL_0d6c: throw
IL_0d6d: ldarg.0
IL_0d6e: ldarg.0
IL_0d6f: ldloc.s V_93
IL_0d71: call System.Collections.IEnumerator ForestProbe::Capture(System.String)
IL_0d76: call UnityEngine.Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)
IL_0d7b: pop
IL_0d7c: nop
IL_0d7d: br IL_125d
IL_0d82: ldloc.1
IL_0d83: ldstr "select "
IL_0d88: callvirt System.Boolean System.String::StartsWith(System.String)
IL_0d8d: stloc.s V_96
IL_0d8f: ldloc.s V_96
IL_0d91: brfalse IL_0e76
IL_0d96: nop
IL_0d97: ldloc.1
IL_0d98: ldc.i4.7
IL_0d99: callvirt System.String System.String::Substring(System.Int32)
IL_0d9e: stloc.s V_97
IL_0da0: ldnull
IL_0da1: stloc.s V_98
IL_0da3: nop
IL_0da4: call !!0[] UnityEngine.Resources::FindObjectsOfTypeAll<UnityEngine.UI.Selectable>()
IL_0da9: stloc.s V_99
IL_0dab: ldc.i4.0
IL_0dac: stloc.s V_100
IL_0dae: br.s IL_0e26
IL_0db0: ldloc.s V_99
IL_0db2: ldloc.s V_100
IL_0db4: ldelem.ref
IL_0db5: stloc.s V_101
IL_0db7: ldloc.s V_101
IL_0db9: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0dbe: callvirt UnityEngine.SceneManagement.Scene UnityEngine.GameObject::get_scene()
IL_0dc3: stloc.s V_10
IL_0dc5: ldloca.s V_10
IL_0dc7: call System.Boolean UnityEngine.SceneManagement.Scene::IsValid()
IL_0dcc: brfalse.s IL_0dfa
IL_0dce: ldloc.s V_101
IL_0dd0: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0dd5: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_0dda: brfalse.s IL_0dfa
IL_0ddc: ldloc.s V_101
IL_0dde: callvirt System.Boolean UnityEngine.UI.Selectable::IsInteractable()
IL_0de3: brfalse.s IL_0dfa
IL_0de5: ldloc.s V_101
IL_0de7: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0dec: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_0df1: ldloc.s V_97
IL_0df3: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0df8: br.s IL_0dfb
IL_0dfa: ldc.i4.0
IL_0dfb: stloc.s V_102
IL_0dfd: ldloc.s V_102
IL_0dff: brfalse.s IL_0e20
IL_0e01: nop
IL_0e02: ldloc.s V_98
IL_0e04: ldnull
IL_0e05: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0e0a: stloc.s V_103
IL_0e0c: ldloc.s V_103
IL_0e0e: brfalse.s IL_0e1b
IL_0e10: ldstr "Duplicate active selectable"
IL_0e15: newobj System.Void System.Exception::.ctor(System.String)
IL_0e1a: throw
IL_0e1b: ldloc.s V_101
IL_0e1d: stloc.s V_98
IL_0e1f: nop
IL_0e20: ldloc.s V_100
IL_0e22: ldc.i4.1
IL_0e23: add
IL_0e24: stloc.s V_100
IL_0e26: ldloc.s V_100
IL_0e28: ldloc.s V_99
IL_0e2a: ldlen
IL_0e2b: conv.i4
IL_0e2c: blt.s IL_0db0
IL_0e2e: ldloc.s V_98
IL_0e30: ldnull
IL_0e31: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0e36: brtrue.s IL_0e45
IL_0e38: call UnityEngine.EventSystems.EventSystem UnityEngine.EventSystems.EventSystem::get_current()
IL_0e3d: ldnull
IL_0e3e: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0e43: br.s IL_0e46
IL_0e45: ldc.i4.1
IL_0e46: stloc.s V_104
IL_0e48: ldloc.s V_104
IL_0e4a: brfalse.s IL_0e5e
IL_0e4c: ldstr "No selectable/event system: "
IL_0e51: ldloc.s V_97
IL_0e53: call System.String System.String::Concat(System.String,System.String)
IL_0e58: newobj System.Void System.Exception::.ctor(System.String)
IL_0e5d: throw
IL_0e5e: call UnityEngine.EventSystems.EventSystem UnityEngine.EventSystems.EventSystem::get_current()
IL_0e63: ldloc.s V_98
IL_0e65: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0e6a: callvirt System.Void UnityEngine.EventSystems.EventSystem::SetSelectedGameObject(UnityEngine.GameObject)
IL_0e6f: nop
IL_0e70: nop
IL_0e71: br IL_125d
IL_0e76: ldloc.1
IL_0e77: ldstr "move-left"
IL_0e7c: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0e81: brtrue.s IL_0e90
IL_0e83: ldloc.1
IL_0e84: ldstr "move-right"
IL_0e89: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0e8e: br.s IL_0e91
IL_0e90: ldc.i4.1
IL_0e91: stloc.s V_105
IL_0e93: ldloc.s V_105
IL_0e95: brfalse IL_0f1b
IL_0e9a: nop
IL_0e9b: call UnityEngine.EventSystems.EventSystem UnityEngine.EventSystems.EventSystem::get_current()
IL_0ea0: stloc.s V_106
IL_0ea2: ldloc.s V_106
IL_0ea4: ldnull
IL_0ea5: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0eaa: brtrue.s IL_0ebb
IL_0eac: ldloc.s V_106
IL_0eae: callvirt UnityEngine.GameObject UnityEngine.EventSystems.EventSystem::get_currentSelectedGameObject()
IL_0eb3: ldnull
IL_0eb4: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0eb9: br.s IL_0ebc
IL_0ebb: ldc.i4.1
IL_0ebc: stloc.s V_108
IL_0ebe: ldloc.s V_108
IL_0ec0: brfalse.s IL_0ecd
IL_0ec2: ldstr "No selected control"
IL_0ec7: newobj System.Void System.Exception::.ctor(System.String)
IL_0ecc: throw
IL_0ecd: ldloc.s V_106
IL_0ecf: newobj System.Void UnityEngine.EventSystems.AxisEventData::.ctor(UnityEngine.EventSystems.EventSystem)
IL_0ed4: dup
IL_0ed5: ldloc.1
IL_0ed6: ldstr "move-left"
IL_0edb: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0ee0: brtrue.s IL_0ee5
IL_0ee2: ldc.i4.2
IL_0ee3: br.s IL_0ee6
IL_0ee5: ldc.i4.0
IL_0ee6: callvirt System.Void UnityEngine.EventSystems.AxisEventData::set_moveDir(UnityEngine.EventSystems.MoveDirection)
IL_0eeb: nop
IL_0eec: stloc.s V_107
IL_0eee: ldloc.s V_106
IL_0ef0: callvirt UnityEngine.GameObject UnityEngine.EventSystems.EventSystem::get_currentSelectedGameObject()
IL_0ef5: ldloc.s V_107
IL_0ef7: call UnityEngine.EventSystems.ExecuteEvents/EventFunction`1<UnityEngine.EventSystems.IMoveHandler> UnityEngine.EventSystems.ExecuteEvents::get_moveHandler()
IL_0efc: call System.Boolean UnityEngine.EventSystems.ExecuteEvents::Execute<UnityEngine.EventSystems.IMoveHandler>(UnityEngine.GameObject,UnityEngine.EventSystems.BaseEventData,UnityEngine.EventSystems.ExecuteEvents/EventFunction`1<!!0>)
IL_0f01: ldc.i4.0
IL_0f02: ceq
IL_0f04: stloc.s V_109
IL_0f06: ldloc.s V_109
IL_0f08: brfalse.s IL_0f15
IL_0f0a: ldstr "No move handler"
IL_0f0f: newobj System.Void System.Exception::.ctor(System.String)
IL_0f14: throw
IL_0f15: nop
IL_0f16: br IL_125d
IL_0f1b: ldloc.1
IL_0f1c: ldstr "click "
IL_0f21: callvirt System.Boolean System.String::StartsWith(System.String)
IL_0f26: stloc.s V_110
IL_0f28: ldloc.s V_110
IL_0f2a: brfalse IL_0fe3
IL_0f2f: nop
IL_0f30: ldloc.1
IL_0f31: ldc.i4.6
IL_0f32: callvirt System.String System.String::Substring(System.Int32)
IL_0f37: stloc.s V_111
IL_0f39: ldnull
IL_0f3a: stloc.s V_112
IL_0f3c: nop
IL_0f3d: call !!0[] UnityEngine.Resources::FindObjectsOfTypeAll<UnityEngine.UI.Button>()
IL_0f42: stloc.s V_113
IL_0f44: ldc.i4.0
IL_0f45: stloc.s V_114
IL_0f47: br.s IL_0fa8
IL_0f49: ldloc.s V_113
IL_0f4b: ldloc.s V_114
IL_0f4d: ldelem.ref
IL_0f4e: stloc.s V_115
IL_0f50: ldloc.s V_115
IL_0f52: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0f57: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_0f5c: brfalse.s IL_0f7c
IL_0f5e: ldloc.s V_115
IL_0f60: callvirt System.Boolean UnityEngine.UI.Selectable::get_interactable()
IL_0f65: brfalse.s IL_0f7c
IL_0f67: ldloc.s V_115
IL_0f69: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0f6e: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_0f73: ldloc.s V_111
IL_0f75: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0f7a: br.s IL_0f7d
IL_0f7c: ldc.i4.0
IL_0f7d: stloc.s V_116
IL_0f7f: ldloc.s V_116
IL_0f81: brfalse.s IL_0fa2
IL_0f83: nop
IL_0f84: ldloc.s V_112
IL_0f86: ldnull
IL_0f87: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0f8c: stloc.s V_117
IL_0f8e: ldloc.s V_117
IL_0f90: brfalse.s IL_0f9d
IL_0f92: ldstr "Duplicate active button"
IL_0f97: newobj System.Void System.Exception::.ctor(System.String)
IL_0f9c: throw
IL_0f9d: ldloc.s V_115
IL_0f9f: stloc.s V_112
IL_0fa1: nop
IL_0fa2: ldloc.s V_114
IL_0fa4: ldc.i4.1
IL_0fa5: add
IL_0fa6: stloc.s V_114
IL_0fa8: ldloc.s V_114
IL_0faa: ldloc.s V_113
IL_0fac: ldlen
IL_0fad: conv.i4
IL_0fae: blt.s IL_0f49
IL_0fb0: ldloc.s V_112
IL_0fb2: ldnull
IL_0fb3: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0fb8: stloc.s V_118
IL_0fba: ldloc.s V_118
IL_0fbc: brfalse.s IL_0fd0
IL_0fbe: ldstr "No matching active button: "
IL_0fc3: ldloc.s V_111
IL_0fc5: call System.String System.String::Concat(System.String,System.String)
IL_0fca: newobj System.Void System.Exception::.ctor(System.String)
IL_0fcf: throw
IL_0fd0: ldloc.s V_112
IL_0fd2: callvirt UnityEngine.UI.Button/ButtonClickedEvent UnityEngine.UI.Button::get_onClick()
IL_0fd7: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_0fdc: nop
IL_0fdd: nop
IL_0fde: br IL_125d
IL_0fe3: ldloc.1
IL_0fe4: ldstr "menu "
IL_0fe9: callvirt System.Boolean System.String::StartsWith(System.String)
IL_0fee: stloc.s V_119
IL_0ff0: ldloc.s V_119
IL_0ff2: brfalse IL_1252
IL_0ff7: nop
IL_0ff8: ldloc.1
IL_0ff9: ldc.i4.5
IL_0ffa: callvirt System.String System.String::Substring(System.Int32)
IL_0fff: ldc.i4.1
IL_1000: newarr System.Char
IL_1005: dup
IL_1006: ldc.i4.0
IL_1007: ldc.i4.s 32
IL_1009: stelem.i2
IL_100a: callvirt System.String[] System.String::Split(System.Char[])
IL_100f: stloc.s V_120
IL_1011: ldloc.s V_120
IL_1013: ldlen
IL_1014: conv.i4
IL_1015: ldc.i4.2
IL_1016: bne.un.s IL_1038
IL_1018: ldloc.s V_120
IL_101a: ldc.i4.0
IL_101b: ldelem.ref
IL_101c: ldstr "PlayMenu"
IL_1021: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_1026: brfalse.s IL_1038
IL_1028: ldloc.s V_120
IL_102a: ldc.i4.1
IL_102b: ldelem.ref
IL_102c: ldstr "OnClickContinue"
IL_1031: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_1036: br.s IL_1039
IL_1038: ldc.i4.0
IL_1039: stloc.s V_121
IL_103b: ldloc.s V_120
IL_103d: ldlen
IL_103e: conv.i4
IL_103f: ldc.i4.2
IL_1040: bne.un.s IL_10ab
IL_1042: ldloc.s V_120
IL_1044: ldc.i4.0
IL_1045: ldelem.ref
IL_1046: ldstr "StartScreenMainMenu"
IL_104b: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_1050: brtrue.s IL_1072
IL_1052: ldloc.s V_120
IL_1054: ldc.i4.0
IL_1055: ldelem.ref
IL_1056: ldstr "PlayMenu"
IL_105b: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_1060: brtrue.s IL_1072
IL_1062: ldloc.s V_120
IL_1064: ldc.i4.0
IL_1065: ldelem.ref
IL_1066: ldstr "OptionsMenu"
IL_106b: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_1070: brfalse.s IL_10ab
IL_1072: ldloc.s V_120
IL_1074: ldc.i4.1
IL_1075: ldelem.ref
IL_1076: ldstr "OnClickStart"
IL_107b: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_1080: brtrue.s IL_10a2
IL_1082: ldloc.s V_120
IL_1084: ldc.i4.1
IL_1085: ldelem.ref
IL_1086: ldstr "OnClickOptions"
IL_108b: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_1090: brtrue.s IL_10a2
IL_1092: ldloc.s V_120
IL_1094: ldc.i4.1
IL_1095: ldelem.ref
IL_1096: ldstr "OnClickBack"
IL_109b: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_10a0: br.s IL_10a3
IL_10a2: ldc.i4.1
IL_10a3: ldloc.s V_121
IL_10a5: or
IL_10a6: ldc.i4.0
IL_10a7: ceq
IL_10a9: br.s IL_10ac
IL_10ab: ldc.i4.1
IL_10ac: stloc.s V_123
IL_10ae: ldloc.s V_123
IL_10b0: brfalse.s IL_10bd
IL_10b2: ldstr "Unsupported menu command"
IL_10b7: newobj System.Void System.Exception::.ctor(System.String)
IL_10bc: throw
IL_10bd: ldloc.s V_121
IL_10bf: stloc.s V_124
IL_10c1: ldloc.s V_124
IL_10c3: brfalse IL_11a3
IL_10c8: nop
IL_10c9: call System.Boolean TheForestOfLove.Services.Persistence.SaveManager::get_HasSavedPlaySession()
IL_10ce: brfalse.s IL_10ff
IL_10d0: call UnityEngine.SceneManagement.Scene UnityEngine.SceneManagement.SceneManager::GetActiveScene()
IL_10d5: stloc.s V_10
IL_10d7: ldloca.s V_10
IL_10d9: call System.String UnityEngine.SceneManagement.Scene::get_name()
IL_10de: ldstr "StartMenu"
IL_10e3: call System.Boolean System.String::op_Inequality(System.String,System.String)
IL_10e8: brtrue.s IL_10ff
IL_10ea: ldsfld System.Boolean Globals::isChapterSelect
IL_10ef: brtrue.s IL_10ff
IL_10f1: ldsfld System.Boolean Globals::isCheatCode
IL_10f6: brtrue.s IL_10ff
IL_10f8: call System.Boolean PixelCrushers.DialogueSystem.DialogueManager::get_isConversationActive()
IL_10fd: br.s IL_1100
IL_10ff: ldc.i4.1
IL_1100: stloc.s V_126
IL_1102: ldloc.s V_126
IL_1104: brfalse.s IL_1111
IL_1106: ldstr "Original saved Continue state unavailable"
IL_110b: newobj System.Void System.Exception::.ctor(System.String)
IL_1110: throw
IL_1111: ldc.i4.0
IL_1112: stloc.s V_125
IL_1114: nop
IL_1115: call !!0[] UnityEngine.Resources::FindObjectsOfTypeAll<UnityEngine.UI.Button>()
IL_111a: stloc.s V_127
IL_111c: ldc.i4.0
IL_111d: stloc.s V_128
IL_111f: br.s IL_1181
IL_1121: ldloc.s V_127
IL_1123: ldloc.s V_128
IL_1125: ldelem.ref
IL_1126: stloc.s V_129
IL_1128: ldloc.s V_129
IL_112a: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_112f: callvirt UnityEngine.SceneManagement.Scene UnityEngine.GameObject::get_scene()
IL_1134: stloc.s V_10
IL_1136: ldloca.s V_10
IL_1138: call System.Boolean UnityEngine.SceneManagement.Scene::IsValid()
IL_113d: brfalse.s IL_116e
IL_113f: ldloc.s V_129
IL_1141: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_1146: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_114b: brfalse.s IL_116e
IL_114d: ldloc.s V_129
IL_114f: callvirt System.Boolean UnityEngine.UI.Selectable::get_interactable()
IL_1154: brfalse.s IL_116e
IL_1156: ldloc.s V_129
IL_1158: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_115d: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_1162: ldstr "Canvas/PlayMenu/Controls/Continue"
IL_1167: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_116c: br.s IL_116f
IL_116e: ldc.i4.0
IL_116f: stloc.s V_130
IL_1171: ldloc.s V_130
IL_1173: brfalse.s IL_117b
IL_1175: ldloc.s V_125
IL_1177: ldc.i4.1
IL_1178: add
IL_1179: stloc.s V_125
IL_117b: ldloc.s V_128
IL_117d: ldc.i4.1
IL_117e: add
IL_117f: stloc.s V_128
IL_1181: ldloc.s V_128
IL_1183: ldloc.s V_127
IL_1185: ldlen
IL_1186: conv.i4
IL_1187: blt.s IL_1121
IL_1189: ldloc.s V_125
IL_118b: ldc.i4.1
IL_118c: ceq
IL_118e: ldc.i4.0
IL_118f: ceq
IL_1191: stloc.s V_131
IL_1193: ldloc.s V_131
IL_1195: brfalse.s IL_11a2
IL_1197: ldstr "Exact original Continue control unavailable"
IL_119c: newobj System.Void System.Exception::.ctor(System.String)
IL_11a1: throw
IL_11a2: nop
IL_11a3: ldnull
IL_11a4: stloc.s V_122
IL_11a6: nop
IL_11a7: call !!0[] UnityEngine.Resources::FindObjectsOfTypeAll<UnityEngine.MonoBehaviour>()
IL_11ac: stloc.s V_132
IL_11ae: ldc.i4.0
IL_11af: stloc.s V_133
IL_11b1: br.s IL_1215
IL_11b3: ldloc.s V_132
IL_11b5: ldloc.s V_133
IL_11b7: ldelem.ref
IL_11b8: stloc.s V_134
IL_11ba: ldloc.s V_134
IL_11bc: ldnull
IL_11bd: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_11c2: brfalse.s IL_11e9
IL_11c4: ldloc.s V_134
IL_11c6: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_11cb: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_11d0: brfalse.s IL_11e9
IL_11d2: ldloc.s V_134
IL_11d4: callvirt System.Type System.Object::GetType()
IL_11d9: callvirt System.String System.Reflection.MemberInfo::get_Name()
IL_11de: ldloc.s V_120
IL_11e0: ldc.i4.0
IL_11e1: ldelem.ref
IL_11e2: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_11e7: br.s IL_11ea
IL_11e9: ldc.i4.0
IL_11ea: stloc.s V_135
IL_11ec: ldloc.s V_135
IL_11ee: brfalse.s IL_120f
IL_11f0: nop
IL_11f1: ldloc.s V_122
IL_11f3: ldnull
IL_11f4: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_11f9: stloc.s V_136
IL_11fb: ldloc.s V_136
IL_11fd: brfalse.s IL_120a
IL_11ff: ldstr "Duplicate active menu"
IL_1204: newobj System.Void System.Exception::.ctor(System.String)
IL_1209: throw
IL_120a: ldloc.s V_134
IL_120c: stloc.s V_122
IL_120e: nop
IL_120f: ldloc.s V_133
IL_1211: ldc.i4.1
IL_1212: add
IL_1213: stloc.s V_133
IL_1215: ldloc.s V_133
IL_1217: ldloc.s V_132
IL_1219: ldlen
IL_121a: conv.i4
IL_121b: blt.s IL_11b3
IL_121d: ldloc.s V_122
IL_121f: ldnull
IL_1220: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_1225: stloc.s V_137
IL_1227: ldloc.s V_137
IL_1229: brfalse.s IL_1236
IL_122b: ldstr "Menu not active"
IL_1230: newobj System.Void System.Exception::.ctor(System.String)
IL_1235: throw
IL_1236: ldloc.s V_122
IL_1238: callvirt System.Type System.Object::GetType()
IL_123d: ldloc.s V_120
IL_123f: ldc.i4.1
IL_1240: ldelem.ref
IL_1241: callvirt System.Reflection.MethodInfo System.Type::GetMethod(System.String)
IL_1246: ldloc.s V_122
IL_1248: ldnull
IL_1249: callvirt System.Object System.Reflection.MethodBase::Invoke(System.Object,System.Object[])
IL_124e: pop
IL_124f: nop
IL_1250: br.s IL_125d
IL_1252: ldstr "Unsupported command"
IL_1257: newobj System.Void System.Exception::.ctor(System.String)
IL_125c: throw
IL_125d: ldarg.0
IL_125e: ldfld System.String ForestProbe::root
IL_1263: ldstr "actions.log"
IL_1268: call System.String System.IO.Path::Combine(System.String,System.String)
IL_126d: call System.DateTime System.DateTime::get_UtcNow()
IL_1272: stloc.s V_138
IL_1274: ldloca.s V_138
IL_1276: ldstr "O"
IL_127b: call System.String System.DateTime::ToString(System.String)
IL_1280: ldstr " OK "
IL_1285: ldloc.1
IL_1286: ldstr "
"
IL_128b: call System.String System.String::Concat(System.String,System.String,System.String,System.String)
IL_1290: call System.Void System.IO.File::AppendAllText(System.String,System.String)
IL_1295: nop
IL_1296: ldarg.0
IL_1297: ldstr "command-ack"
IL_129c: call System.Void ForestProbe::ObserveLifecycle(System.String)
IL_12a1: nop
IL_12a2: nop
IL_12a3: leave.s IL_1323
IL_12a5: stloc.s V_139
IL_12a7: nop
IL_12a8: ldarg.0
IL_12a9: ldfld System.String ForestProbe::root
IL_12ae: ldstr "actions.log"
IL_12b3: call System.String System.IO.Path::Combine(System.String,System.String)
IL_12b8: ldc.i4.6
IL_12b9: newarr System.String
IL_12be: dup
IL_12bf: ldc.i4.0
IL_12c0: call System.DateTime System.DateTime::get_UtcNow()
IL_12c5: stloc.s V_138
IL_12c7: ldloca.s V_138
IL_12c9: ldstr "O"
IL_12ce: call System.String System.DateTime::ToString(System.String)
IL_12d3: stelem.ref
IL_12d4: dup
IL_12d5: ldc.i4.1
IL_12d6: ldstr " FAIL "
IL_12db: stelem.ref
IL_12dc: dup
IL_12dd: ldc.i4.2
IL_12de: ldloc.1
IL_12df: stelem.ref
IL_12e0: dup
IL_12e1: ldc.i4.3
IL_12e2: ldstr " "
IL_12e7: stelem.ref
IL_12e8: dup
IL_12e9: ldc.i4.4
IL_12ea: ldloc.s V_139
IL_12ec: dup
IL_12ed: brtrue.s IL_12f3
IL_12ef: pop
IL_12f0: ldnull
IL_12f1: br.s IL_12f8
IL_12f3: callvirt System.String System.Object::ToString()
IL_12f8: stelem.ref
IL_12f9: dup
IL_12fa: ldc.i4.5
IL_12fb: ldstr "
"
IL_1300: stelem.ref
IL_1301: call System.String System.String::Concat(System.String[])
IL_1306: call System.Void System.IO.File::AppendAllText(System.String,System.String)
IL_130b: nop
IL_130c: ldarg.0
IL_130d: ldstr "command-fail"
IL_1312: call System.Void ForestProbe::ObserveLifecycle(System.String)
IL_1317: nop
IL_1318: ldloc.s V_139
IL_131a: call System.Void UnityEngine.Debug::LogException(System.Exception)
IL_131f: nop
IL_1320: nop
IL_1321: leave.s IL_1323
IL_1323: leave.s IL_132f
IL_1325: nop
IL_1326: ldarg.0
IL_1327: ldnull
IL_1328: stfld System.String ForestProbe::lifecycleCommand
IL_132d: nop
IL_132e: endfinally
IL_132f: ret
