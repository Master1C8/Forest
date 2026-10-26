TYPE ForestProbe
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
IL_001b: stloc.s V_31
IL_001d: ldloc.s V_31
IL_001f: brfalse.s IL_0026
IL_0021: br IL_0a18
IL_0026: ldarg.0
IL_0027: ldfld System.Collections.Generic.List`1<System.String> ForestProbe::keyboardSamples
IL_002c: callvirt System.Int32 System.Collections.Generic.List`1<System.String>::get_Count()
IL_0031: ldc.i4 1200
IL_0036: clt
IL_0038: ldc.i4.0
IL_0039: ceq
IL_003b: stloc.s V_32
IL_003d: ldloc.s V_32
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
IL_010d: stloc.s V_33
IL_010f: br IL_0217
IL_0114: nop
IL_0115: ldloc.0
IL_0116: ldloc.s V_19
IL_0118: ldloc.s V_33
IL_011a: ldelem.i4
IL_011b: ldelem.u1
IL_011c: ldc.i4 128
IL_0121: and
IL_0122: ldc.i4.0
IL_0123: cgt.un
IL_0125: stloc.s V_34
IL_0127: ldloc.s V_19
IL_0129: ldloc.s V_33
IL_012b: ldelem.i4
IL_012c: call System.Int16 ForestProbe::GetAsyncKeyState(System.Int32)
IL_0131: ldc.i4 32768
IL_0136: and
IL_0137: ldc.i4.0
IL_0138: cgt.un
IL_013a: stloc.s V_35
IL_013c: ldloc.2
IL_013d: ldloc.s V_20
IL_013f: ldloc.s V_33
IL_0141: ldelem.i4
IL_0142: callvirt System.Boolean Rewired.Keyboard::GetKey(UnityEngine.KeyCode)
IL_0147: stloc.s V_36
IL_0149: ldloc.s V_20
IL_014b: ldloc.s V_33
IL_014d: ldelem.i4
IL_014e: call System.Boolean UnityEngine.Input::GetKey(UnityEngine.KeyCode)
IL_0153: stloc.s V_37
IL_0155: ldloc.s V_20
IL_0157: ldloc.s V_33
IL_0159: ldelema UnityEngine.KeyCode
IL_015e: constrained. UnityEngine.KeyCode
IL_0164: callvirt System.String System.Object::ToString()
IL_0169: stloc.s V_38
IL_016b: ldloc.s V_34
IL_016d: stloc.s V_39
IL_016f: ldloc.s V_39
IL_0171: brfalse.s IL_017d
IL_0173: ldloc.s V_15
IL_0175: ldloc.s V_38
IL_0177: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_017c: nop
IL_017d: ldloc.s V_35
IL_017f: stloc.s V_40
IL_0181: ldloc.s V_40
IL_0183: brfalse.s IL_018f
IL_0185: ldloc.s V_16
IL_0187: ldloc.s V_38
IL_0189: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_018e: nop
IL_018f: ldloc.s V_36
IL_0191: stloc.s V_41
IL_0193: ldloc.s V_41
IL_0195: brfalse.s IL_01a1
IL_0197: ldloc.s V_17
IL_0199: ldloc.s V_38
IL_019b: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_01a0: nop
IL_01a1: ldloc.s V_37
IL_01a3: stloc.s V_42
IL_01a5: ldloc.s V_42
IL_01a7: brfalse.s IL_01b3
IL_01a9: ldloc.s V_18
IL_01ab: ldloc.s V_38
IL_01ad: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_01b2: nop
IL_01b3: ldloc.s V_11
IL_01b5: ldloc.s V_34
IL_01b7: ldc.i4.0
IL_01b8: ceq
IL_01ba: and
IL_01bb: stloc.s V_11
IL_01bd: ldloc.s V_12
IL_01bf: ldloc.s V_35
IL_01c1: ldc.i4.0
IL_01c2: ceq
IL_01c4: and
IL_01c5: stloc.s V_12
IL_01c7: ldloc.s V_13
IL_01c9: ldloc.s V_36
IL_01cb: ldc.i4.0
IL_01cc: ceq
IL_01ce: and
IL_01cf: stloc.s V_13
IL_01d1: ldloc.s V_14
IL_01d3: ldloc.s V_37
IL_01d5: ldc.i4.0
IL_01d6: ceq
IL_01d8: and
IL_01d9: stloc.s V_14
IL_01db: ldloc.s V_33
IL_01dd: ldc.i4.4
IL_01de: clt
IL_01e0: stloc.s V_43
IL_01e2: ldloc.s V_43
IL_01e4: brfalse.s IL_0210
IL_01e6: nop
IL_01e7: ldloc.s V_7
IL_01e9: ldloc.s V_34
IL_01eb: ldc.i4.0
IL_01ec: ceq
IL_01ee: and
IL_01ef: stloc.s V_7
IL_01f1: ldloc.s V_8
IL_01f3: ldloc.s V_35
IL_01f5: ldc.i4.0
IL_01f6: ceq
IL_01f8: and
IL_01f9: stloc.s V_8
IL_01fb: ldloc.s V_9
IL_01fd: ldloc.s V_36
IL_01ff: ldc.i4.0
IL_0200: ceq
IL_0202: and
IL_0203: stloc.s V_9
IL_0205: ldloc.s V_10
IL_0207: ldloc.s V_37
IL_0209: ldc.i4.0
IL_020a: ceq
IL_020c: and
IL_020d: stloc.s V_10
IL_020f: nop
IL_0210: nop
IL_0211: ldloc.s V_33
IL_0213: ldc.i4.1
IL_0214: add
IL_0215: stloc.s V_33
IL_0217: ldloc.s V_33
IL_0219: ldloc.s V_19
IL_021b: ldlen
IL_021c: conv.i4
IL_021d: clt
IL_021f: stloc.s V_44
IL_0221: ldloc.s V_44
IL_0223: brtrue IL_0114
IL_0228: ldloc.1
IL_0229: stloc.s V_21
IL_022b: ldc.i4.1
IL_022c: stloc.s V_22
IL_022e: ldc.i4.1
IL_022f: stloc.s V_23
IL_0231: ldc.i4.1
IL_0232: stloc.s V_24
IL_0234: newobj System.Void System.Collections.Generic.List`1<System.String>::.ctor()
IL_0239: stloc.s V_25
IL_023b: newobj System.Void System.Collections.Generic.List`1<System.String>::.ctor()
IL_0240: stloc.s V_26
IL_0242: newobj System.Void System.Collections.Generic.List`1<System.String>::.ctor()
IL_0247: stloc.s V_27
IL_0249: newobj System.Void System.Collections.Generic.List`1<System.String>::.ctor()
IL_024e: stloc.s V_28
IL_0250: ldc.i4.4
IL_0251: newarr System.Int32
IL_0256: dup
IL_0257: ldtoken <PrivateImplementationDetails>/__StaticArrayInitTypeSize=16 <PrivateImplementationDetails>::5945A0BB42C5CD8B04846A61EFE2682F135810150E3A13C29D3C3E7C426193DC
IL_025c: call System.Void System.Runtime.CompilerServices.RuntimeHelpers::InitializeArray(System.Array,System.RuntimeFieldHandle)
IL_0261: stloc.s V_29
IL_0263: ldc.i4.4
IL_0264: newarr UnityEngine.KeyCode
IL_0269: dup
IL_026a: ldtoken <PrivateImplementationDetails>/__StaticArrayInitTypeSize=16 <PrivateImplementationDetails>::ADDFE4E9F49C08C646FD569EE8B772C41DD71E156AE33030B307B1C28EABD905
IL_026f: call System.Void System.Runtime.CompilerServices.RuntimeHelpers::InitializeArray(System.Array,System.RuntimeFieldHandle)
IL_0274: stloc.s V_30
IL_0276: ldc.i4.0
IL_0277: stloc.s V_45
IL_0279: br IL_034c
IL_027e: nop
IL_027f: ldloc.0
IL_0280: ldloc.s V_29
IL_0282: ldloc.s V_45
IL_0284: ldelem.i4
IL_0285: ldelem.u1
IL_0286: ldc.i4 128
IL_028b: and
IL_028c: ldc.i4.0
IL_028d: cgt.un
IL_028f: stloc.s V_46
IL_0291: ldloc.s V_29
IL_0293: ldloc.s V_45
IL_0295: ldelem.i4
IL_0296: call System.Int16 ForestProbe::GetAsyncKeyState(System.Int32)
IL_029b: ldc.i4 32768
IL_02a0: and
IL_02a1: ldc.i4.0
IL_02a2: cgt.un
IL_02a4: stloc.s V_47
IL_02a6: ldloc.2
IL_02a7: ldloc.s V_30
IL_02a9: ldloc.s V_45
IL_02ab: ldelem.i4
IL_02ac: callvirt System.Boolean Rewired.Keyboard::GetKey(UnityEngine.KeyCode)
IL_02b1: stloc.s V_48
IL_02b3: ldloc.s V_30
IL_02b5: ldloc.s V_45
IL_02b7: ldelem.i4
IL_02b8: call System.Boolean UnityEngine.Input::GetKey(UnityEngine.KeyCode)
IL_02bd: stloc.s V_49
IL_02bf: ldloc.s V_30
IL_02c1: ldloc.s V_45
IL_02c3: ldelema UnityEngine.KeyCode
IL_02c8: constrained. UnityEngine.KeyCode
IL_02ce: callvirt System.String System.Object::ToString()
IL_02d3: stloc.s V_50
IL_02d5: ldloc.s V_46
IL_02d7: stloc.s V_51
IL_02d9: ldloc.s V_51
IL_02db: brfalse.s IL_02e7
IL_02dd: ldloc.s V_25
IL_02df: ldloc.s V_50
IL_02e1: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_02e6: nop
IL_02e7: ldloc.s V_47
IL_02e9: stloc.s V_52
IL_02eb: ldloc.s V_52
IL_02ed: brfalse.s IL_02f9
IL_02ef: ldloc.s V_26
IL_02f1: ldloc.s V_50
IL_02f3: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_02f8: nop
IL_02f9: ldloc.s V_48
IL_02fb: stloc.s V_53
IL_02fd: ldloc.s V_53
IL_02ff: brfalse.s IL_030b
IL_0301: ldloc.s V_27
IL_0303: ldloc.s V_50
IL_0305: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_030a: nop
IL_030b: ldloc.s V_49
IL_030d: stloc.s V_54
IL_030f: ldloc.s V_54
IL_0311: brfalse.s IL_031d
IL_0313: ldloc.s V_28
IL_0315: ldloc.s V_50
IL_0317: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_031c: nop
IL_031d: ldloc.s V_21
IL_031f: ldloc.s V_46
IL_0321: ldc.i4.0
IL_0322: ceq
IL_0324: and
IL_0325: stloc.s V_21
IL_0327: ldloc.s V_22
IL_0329: ldloc.s V_47
IL_032b: ldc.i4.0
IL_032c: ceq
IL_032e: and
IL_032f: stloc.s V_22
IL_0331: ldloc.s V_23
IL_0333: ldloc.s V_48
IL_0335: ldc.i4.0
IL_0336: ceq
IL_0338: and
IL_0339: stloc.s V_23
IL_033b: ldloc.s V_24
IL_033d: ldloc.s V_49
IL_033f: ldc.i4.0
IL_0340: ceq
IL_0342: and
IL_0343: stloc.s V_24
IL_0345: nop
IL_0346: ldloc.s V_45
IL_0348: ldc.i4.1
IL_0349: add
IL_034a: stloc.s V_45
IL_034c: ldloc.s V_45
IL_034e: ldloc.s V_29
IL_0350: ldlen
IL_0351: conv.i4
IL_0352: clt
IL_0354: stloc.s V_55
IL_0356: ldloc.s V_55
IL_0358: brtrue IL_027e
IL_035d: ldarg.0
IL_035e: ldfld System.Collections.Generic.List`1<System.String> ForestProbe::keyboardSamples
IL_0363: ldc.i4.s 115
IL_0365: newarr System.String
IL_036a: dup
IL_036b: ldc.i4.0
IL_036c: ldstr "keyboard | frame="
IL_0371: stelem.ref
IL_0372: dup
IL_0373: ldc.i4.1
IL_0374: call System.Int32 UnityEngine.Time::get_frameCount()
IL_0379: stloc.s V_56
IL_037b: ldloca.s V_56
IL_037d: call System.String System.Int32::ToString()
IL_0382: stelem.ref
IL_0383: dup
IL_0384: ldc.i4.2
IL_0385: ldstr " | scaledTime="
IL_038a: stelem.ref
IL_038b: dup
IL_038c: ldc.i4.3
IL_038d: call System.Single UnityEngine.Time::get_time()
IL_0392: stloc.s V_57
IL_0394: ldloca.s V_57
IL_0396: call System.String System.Single::ToString()
IL_039b: stelem.ref
IL_039c: dup
IL_039d: ldc.i4.4
IL_039e: ldstr " | timeScale="
IL_03a3: stelem.ref
IL_03a4: dup
IL_03a5: ldc.i4.5
IL_03a6: call System.Single UnityEngine.Time::get_timeScale()
IL_03ab: stloc.s V_57
IL_03ad: ldloca.s V_57
IL_03af: call System.String System.Single::ToString()
IL_03b4: stelem.ref
IL_03b5: dup
IL_03b6: ldc.i4.6
IL_03b7: ldstr " | time="
IL_03bc: stelem.ref
IL_03bd: dup
IL_03be: ldc.i4.7
IL_03bf: call System.Single UnityEngine.Time::get_realtimeSinceStartup()
IL_03c4: stloc.s V_57
IL_03c6: ldloca.s V_57
IL_03c8: call System.String System.Single::ToString()
IL_03cd: stelem.ref
IL_03ce: dup
IL_03cf: ldc.i4.8
IL_03d0: ldstr " | winPid="
IL_03d5: stelem.ref
IL_03d6: dup
IL_03d7: ldc.i4.s 9
IL_03d9: call System.UInt32 ForestProbe::GetCurrentProcessId()
IL_03de: stloc.s V_58
IL_03e0: ldloca.s V_58
IL_03e2: call System.String System.UInt32::ToString()
IL_03e7: stelem.ref
IL_03e8: dup
IL_03e9: ldc.i4.s 10
IL_03eb: ldstr " | focused="
IL_03f0: stelem.ref
IL_03f1: dup
IL_03f2: ldc.i4.s 11
IL_03f4: call System.Boolean UnityEngine.Application::get_isFocused()
IL_03f9: stloc.s V_59
IL_03fb: ldloca.s V_59
IL_03fd: call System.String System.Boolean::ToString()
IL_0402: stelem.ref
IL_0403: dup
IL_0404: ldc.i4.s 12
IL_0406: ldstr " | ignoreUnfocused="
IL_040b: stelem.ref
IL_040c: dup
IL_040d: ldc.i4.s 13
IL_040f: call Rewired.ReInput/ConfigHelper Rewired.ReInput::get_configuration()
IL_0414: callvirt System.Boolean Rewired.ReInput/ConfigHelper::get_ignoreInputWhenAppNotInFocus()
IL_0419: stloc.s V_59
IL_041b: ldloca.s V_59
IL_041d: call System.String System.Boolean::ToString()
IL_0422: stelem.ref
IL_0423: dup
IL_0424: ldc.i4.s 14
IL_0426: call System.String ForestProbe::KeyboardEligibility()
IL_042b: stelem.ref
IL_042c: dup
IL_042d: ldc.i4.s 15
IL_042f: ldstr " | nativeValid="
IL_0434: stelem.ref
IL_0435: dup
IL_0436: ldc.i4.s 16
IL_0438: ldloca.s V_1
IL_043a: call System.String System.Boolean::ToString()
IL_043f: stelem.ref
IL_0440: dup
IL_0441: ldc.i4.s 17
IL_0443: ldstr " | nativeLeft="
IL_0448: stelem.ref
IL_0449: dup
IL_044a: ldc.i4.s 18
IL_044c: ldloc.0
IL_044d: ldc.i4.s 37
IL_044f: ldelem.u1
IL_0450: ldc.i4 128
IL_0455: and
IL_0456: ldc.i4.0
IL_0457: cgt.un
IL_0459: stloc.s V_59
IL_045b: ldloca.s V_59
IL_045d: call System.String System.Boolean::ToString()
IL_0462: stelem.ref
IL_0463: dup
IL_0464: ldc.i4.s 19
IL_0466: ldstr " | asyncLeft="
IL_046b: stelem.ref
IL_046c: dup
IL_046d: ldc.i4.s 20
IL_046f: ldc.i4.s 37
IL_0471: call System.Int16 ForestProbe::GetAsyncKeyState(System.Int32)
IL_0476: ldc.i4 32768
IL_047b: and
IL_047c: ldc.i4.0
IL_047d: cgt.un
IL_047f: stloc.s V_59
IL_0481: ldloca.s V_59
IL_0483: call System.String System.Boolean::ToString()
IL_0488: stelem.ref
IL_0489: dup
IL_048a: ldc.i4.s 21
IL_048c: ldstr " | rewiredLeft="
IL_0491: stelem.ref
IL_0492: dup
IL_0493: ldc.i4.s 22
IL_0495: ldloc.2
IL_0496: ldc.i4 276
IL_049b: callvirt System.Boolean Rewired.Keyboard::GetKey(UnityEngine.KeyCode)
IL_04a0: stloc.s V_59
IL_04a2: ldloca.s V_59
IL_04a4: call System.String System.Boolean::ToString()
IL_04a9: stelem.ref
IL_04aa: dup
IL_04ab: ldc.i4.s 23
IL_04ad: ldstr " | keyboardEnabled="
IL_04b2: stelem.ref
IL_04b3: dup
IL_04b4: ldc.i4.s 24
IL_04b6: ldloc.2
IL_04b7: callvirt System.Boolean Rewired.Controller::get_enabled()
IL_04bc: stloc.s V_59
IL_04be: ldloca.s V_59
IL_04c0: call System.String System.Boolean::ToString()
IL_04c5: stelem.ref
IL_04c6: dup
IL_04c7: ldc.i4.s 25
IL_04c9: ldstr " | unityLeft="
IL_04ce: stelem.ref
IL_04cf: dup
IL_04d0: ldc.i4.s 26
IL_04d2: ldc.i4 276
IL_04d7: call System.Boolean UnityEngine.Input::GetKey(UnityEngine.KeyCode)
IL_04dc: stloc.s V_59
IL_04de: ldloca.s V_59
IL_04e0: call System.String System.Boolean::ToString()
IL_04e5: stelem.ref
IL_04e6: dup
IL_04e7: ldc.i4.s 27
IL_04e9: ldstr " | player="
IL_04ee: stelem.ref
IL_04ef: dup
IL_04f0: ldc.i4.s 28
IL_04f2: ldloc.s V_4
IL_04f4: brfalse.s IL_0519
IL_04f6: ldloc.s V_4
IL_04f8: callvirt System.Int32 Rewired.Player::get_id()
IL_04fd: stloc.s V_56
IL_04ff: ldloca.s V_56
IL_0501: call System.String System.Int32::ToString()
IL_0506: ldstr ":"
IL_050b: ldloc.s V_4
IL_050d: callvirt System.String Rewired.Player::get_name()
IL_0512: call System.String System.String::Concat(System.String,System.String,System.String)
IL_0517: br.s IL_051e
IL_0519: ldstr "null"
IL_051e: stelem.ref
IL_051f: dup
IL_0520: ldc.i4.s 29
IL_0522: ldstr " | keyboardMaps="
IL_0527: stelem.ref
IL_0528: dup
IL_0529: ldc.i4.s 30
IL_052b: ldloc.s V_4
IL_052d: call System.String ForestProbe::KeyboardMaps(Rewired.Player)
IL_0532: stelem.ref
IL_0533: dup
IL_0534: ldc.i4.s 31
IL_0536: ldstr " | actionAxes="
IL_053b: stelem.ref
IL_053c: dup
IL_053d: ldc.i4.s 32
IL_053f: ldloc.s V_4
IL_0541: brfalse.s IL_0558
IL_0543: ldloc.s V_4
IL_0545: ldc.i4.0
IL_0546: ldc.i4.1
IL_0547: callvirt UnityEngine.Vector2 Rewired.Player::GetAxis2D(System.Int32,System.Int32)
IL_054c: call UnityEngine.Vector3 UnityEngine.Vector2::op_Implicit(UnityEngine.Vector2)
IL_0551: call System.String ForestProbe::Vector(UnityEngine.Vector3)
IL_0556: br.s IL_055d
IL_0558: ldstr "null"
IL_055d: stelem.ref
IL_055e: dup
IL_055f: ldc.i4.s 33
IL_0561: ldstr " | fullAxis="
IL_0566: stelem.ref
IL_0567: dup
IL_0568: ldc.i4.s 34
IL_056a: call UnityEngine.Vector3 TheForestOfLove.InputHelper::get_FullAxis()
IL_056f: call System.String ForestProbe::Vector(UnityEngine.Vector3)
IL_0574: stelem.ref
IL_0575: dup
IL_0576: ldc.i4.s 35
IL_0578: ldstr " | nativeArrowsUp="
IL_057d: stelem.ref
IL_057e: dup
IL_057f: ldc.i4.s 36
IL_0581: ldloca.s V_7
IL_0583: call System.String System.Boolean::ToString()
IL_0588: stelem.ref
IL_0589: dup
IL_058a: ldc.i4.s 37
IL_058c: ldstr " | asyncArrowsUp="
IL_0591: stelem.ref
IL_0592: dup
IL_0593: ldc.i4.s 38
IL_0595: ldloca.s V_8
IL_0597: call System.String System.Boolean::ToString()
IL_059c: stelem.ref
IL_059d: dup
IL_059e: ldc.i4.s 39
IL_05a0: ldstr " | rewiredArrowsUp="
IL_05a5: stelem.ref
IL_05a6: dup
IL_05a7: ldc.i4.s 40
IL_05a9: ldloca.s V_9
IL_05ab: call System.String System.Boolean::ToString()
IL_05b0: stelem.ref
IL_05b1: dup
IL_05b2: ldc.i4.s 41
IL_05b4: ldstr " | unityArrowsUp="
IL_05b9: stelem.ref
IL_05ba: dup
IL_05bb: ldc.i4.s 42
IL_05bd: ldloca.s V_10
IL_05bf: call System.String System.Boolean::ToString()
IL_05c4: stelem.ref
IL_05c5: dup
IL_05c6: ldc.i4.s 43
IL_05c8: ldstr " | nativeMovementUp="
IL_05cd: stelem.ref
IL_05ce: dup
IL_05cf: ldc.i4.s 44
IL_05d1: ldloca.s V_11
IL_05d3: call System.String System.Boolean::ToString()
IL_05d8: stelem.ref
IL_05d9: dup
IL_05da: ldc.i4.s 45
IL_05dc: ldstr " | asyncMovementUp="
IL_05e1: stelem.ref
IL_05e2: dup
IL_05e3: ldc.i4.s 46
IL_05e5: ldloca.s V_12
IL_05e7: call System.String System.Boolean::ToString()
IL_05ec: stelem.ref
IL_05ed: dup
IL_05ee: ldc.i4.s 47
IL_05f0: ldstr " | rewiredMovementUp="
IL_05f5: stelem.ref
IL_05f6: dup
IL_05f7: ldc.i4.s 48
IL_05f9: ldloca.s V_13
IL_05fb: call System.String System.Boolean::ToString()
IL_0600: stelem.ref
IL_0601: dup
IL_0602: ldc.i4.s 49
IL_0604: ldstr " | unityMovementUp="
IL_0609: stelem.ref
IL_060a: dup
IL_060b: ldc.i4.s 50
IL_060d: ldloca.s V_14
IL_060f: call System.String System.Boolean::ToString()
IL_0614: stelem.ref
IL_0615: dup
IL_0616: ldc.i4.s 51
IL_0618: ldstr " | nativeMovementDown="
IL_061d: stelem.ref
IL_061e: dup
IL_061f: ldc.i4.s 52
IL_0621: ldstr ","
IL_0626: ldloc.s V_15
IL_0628: callvirt !0[] System.Collections.Generic.List`1<System.String>::ToArray()
IL_062d: call System.String System.String::Join(System.String,System.String[])
IL_0632: stelem.ref
IL_0633: dup
IL_0634: ldc.i4.s 53
IL_0636: ldstr " | asyncMovementDown="
IL_063b: stelem.ref
IL_063c: dup
IL_063d: ldc.i4.s 54
IL_063f: ldstr ","
IL_0644: ldloc.s V_16
IL_0646: callvirt !0[] System.Collections.Generic.List`1<System.String>::ToArray()
IL_064b: call System.String System.String::Join(System.String,System.String[])
IL_0650: stelem.ref
IL_0651: dup
IL_0652: ldc.i4.s 55
IL_0654: ldstr " | rewiredMovementDown="
IL_0659: stelem.ref
IL_065a: dup
IL_065b: ldc.i4.s 56
IL_065d: ldstr ","
IL_0662: ldloc.s V_17
IL_0664: callvirt !0[] System.Collections.Generic.List`1<System.String>::ToArray()
IL_0669: call System.String System.String::Join(System.String,System.String[])
IL_066e: stelem.ref
IL_066f: dup
IL_0670: ldc.i4.s 57
IL_0672: ldstr " | unityMovementDown="
IL_0677: stelem.ref
IL_0678: dup
IL_0679: ldc.i4.s 58
IL_067b: ldstr ","
IL_0680: ldloc.s V_18
IL_0682: callvirt !0[] System.Collections.Generic.List`1<System.String>::ToArray()
IL_0687: call System.String System.String::Join(System.String,System.String[])
IL_068c: stelem.ref
IL_068d: dup
IL_068e: ldc.i4.s 59
IL_0690: ldstr " | nativeSubmitUp="
IL_0695: stelem.ref
IL_0696: dup
IL_0697: ldc.i4.s 60
IL_0699: ldloca.s V_21
IL_069b: call System.String System.Boolean::ToString()
IL_06a0: stelem.ref
IL_06a1: dup
IL_06a2: ldc.i4.s 61
IL_06a4: ldstr " | asyncSubmitUp="
IL_06a9: stelem.ref
IL_06aa: dup
IL_06ab: ldc.i4.s 62
IL_06ad: ldloca.s V_22
IL_06af: call System.String System.Boolean::ToString()
IL_06b4: stelem.ref
IL_06b5: dup
IL_06b6: ldc.i4.s 63
IL_06b8: ldstr " | rewiredSubmitUp="
IL_06bd: stelem.ref
IL_06be: dup
IL_06bf: ldc.i4.s 64
IL_06c1: ldloca.s V_23
IL_06c3: call System.String System.Boolean::ToString()
IL_06c8: stelem.ref
IL_06c9: dup
IL_06ca: ldc.i4.s 65
IL_06cc: ldstr " | unitySubmitUp="
IL_06d1: stelem.ref
IL_06d2: dup
IL_06d3: ldc.i4.s 66
IL_06d5: ldloca.s V_24
IL_06d7: call System.String System.Boolean::ToString()
IL_06dc: stelem.ref
IL_06dd: dup
IL_06de: ldc.i4.s 67
IL_06e0: ldstr " | nativeSubmitDown="
IL_06e5: stelem.ref
IL_06e6: dup
IL_06e7: ldc.i4.s 68
IL_06e9: ldstr ","
IL_06ee: ldloc.s V_25
IL_06f0: callvirt !0[] System.Collections.Generic.List`1<System.String>::ToArray()
IL_06f5: call System.String System.String::Join(System.String,System.String[])
IL_06fa: stelem.ref
IL_06fb: dup
IL_06fc: ldc.i4.s 69
IL_06fe: ldstr " | asyncSubmitDown="
IL_0703: stelem.ref
IL_0704: dup
IL_0705: ldc.i4.s 70
IL_0707: ldstr ","
IL_070c: ldloc.s V_26
IL_070e: callvirt !0[] System.Collections.Generic.List`1<System.String>::ToArray()
IL_0713: call System.String System.String::Join(System.String,System.String[])
IL_0718: stelem.ref
IL_0719: dup
IL_071a: ldc.i4.s 71
IL_071c: ldstr " | rewiredSubmitDown="
IL_0721: stelem.ref
IL_0722: dup
IL_0723: ldc.i4.s 72
IL_0725: ldstr ","
IL_072a: ldloc.s V_27
IL_072c: callvirt !0[] System.Collections.Generic.List`1<System.String>::ToArray()
IL_0731: call System.String System.String::Join(System.String,System.String[])
IL_0736: stelem.ref
IL_0737: dup
IL_0738: ldc.i4.s 73
IL_073a: ldstr " | unitySubmitDown="
IL_073f: stelem.ref
IL_0740: dup
IL_0741: ldc.i4.s 74
IL_0743: ldstr ","
IL_0748: ldloc.s V_28
IL_074a: callvirt !0[] System.Collections.Generic.List`1<System.String>::ToArray()
IL_074f: call System.String System.String::Join(System.String,System.String[])
IL_0754: stelem.ref
IL_0755: dup
IL_0756: ldc.i4.s 75
IL_0758: ldstr " | rewiredAction2Held="
IL_075d: stelem.ref
IL_075e: dup
IL_075f: ldc.i4.s 76
IL_0761: ldloc.s V_4
IL_0763: brfalse.s IL_0778
IL_0765: ldloc.s V_4
IL_0767: ldc.i4.2
IL_0768: callvirt System.Boolean Rewired.Player::GetButton(System.Int32)
IL_076d: stloc.s V_59
IL_076f: ldloca.s V_59
IL_0771: call System.String System.Boolean::ToString()
IL_0776: br.s IL_077d
IL_0778: ldstr "null"
IL_077d: stelem.ref
IL_077e: dup
IL_077f: ldc.i4.s 77
IL_0781: ldstr " | rewiredAction2Down="
IL_0786: stelem.ref
IL_0787: dup
IL_0788: ldc.i4.s 78
IL_078a: ldloc.s V_4
IL_078c: brfalse.s IL_07a1
IL_078e: ldloc.s V_4
IL_0790: ldc.i4.2
IL_0791: callvirt System.Boolean Rewired.Player::GetButtonDown(System.Int32)
IL_0796: stloc.s V_59
IL_0798: ldloca.s V_59
IL_079a: call System.String System.Boolean::ToString()
IL_079f: br.s IL_07a6
IL_07a1: ldstr "null"
IL_07a6: stelem.ref
IL_07a7: dup
IL_07a8: ldc.i4.s 79
IL_07aa: ldstr " | helperSubmitDown="
IL_07af: stelem.ref
IL_07b0: dup
IL_07b1: ldc.i4.s 80
IL_07b3: call System.Boolean TheForestOfLove.InputHelper::get_IsSubmitButtonDown()
IL_07b8: stloc.s V_59
IL_07ba: ldloca.s V_59
IL_07bc: call System.String System.Boolean::ToString()
IL_07c1: stelem.ref
IL_07c2: dup
IL_07c3: ldc.i4.s 81
IL_07c5: ldstr " | unityReturnDown="
IL_07ca: stelem.ref
IL_07cb: dup
IL_07cc: ldc.i4.s 82
IL_07ce: ldc.i4.s 13
IL_07d0: call System.Boolean UnityEngine.Input::GetKeyDown(UnityEngine.KeyCode)
IL_07d5: stloc.s V_59
IL_07d7: ldloca.s V_59
IL_07d9: call System.String System.Boolean::ToString()
IL_07de: stelem.ref
IL_07df: dup
IL_07e0: ldc.i4.s 83
IL_07e2: ldstr " | scene="
IL_07e7: stelem.ref
IL_07e8: dup
IL_07e9: ldc.i4.s 84
IL_07eb: call UnityEngine.SceneManagement.Scene UnityEngine.SceneManagement.SceneManager::GetActiveScene()
IL_07f0: stloc.s V_60
IL_07f2: ldloca.s V_60
IL_07f4: call System.String UnityEngine.SceneManagement.Scene::get_name()
IL_07f9: stelem.ref
IL_07fa: dup
IL_07fb: ldc.i4.s 85
IL_07fd: ldstr " | routeDoorTransition="
IL_0802: stelem.ref
IL_0803: dup
IL_0804: ldc.i4.s 86
IL_0806: call System.String ForestProbe::NaturalDoorTransition()
IL_080b: stelem.ref
IL_080c: dup
IL_080d: ldc.i4.s 87
IL_080f: ldstr " | gameplay="
IL_0814: stelem.ref
IL_0815: dup
IL_0816: ldc.i4.s 88
IL_0818: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inGameplayScene()
IL_081d: stloc.s V_59
IL_081f: ldloca.s V_59
IL_0821: call System.String System.Boolean::ToString()
IL_0826: stelem.ref
IL_0827: dup
IL_0828: ldc.i4.s 89
IL_082a: ldstr " | anyEvent="
IL_082f: stelem.ref
IL_0830: dup
IL_0831: ldc.i4.s 90
IL_0833: call System.Boolean TheForestOfLove.Events.GameStateManager::get_isAnyEventActive()
IL_0838: stloc.s V_59
IL_083a: ldloca.s V_59
IL_083c: call System.String System.Boolean::ToString()
IL_0841: stelem.ref
IL_0842: dup
IL_0843: ldc.i4.s 91
IL_0845: ldstr " | conversation="
IL_084a: stelem.ref
IL_084b: dup
IL_084c: ldc.i4.s 92
IL_084e: call System.Boolean PixelCrushers.DialogueSystem.DialogueManager::get_isConversationActive()
IL_0853: stloc.s V_59
IL_0855: ldloca.s V_59
IL_0857: call System.String System.Boolean::ToString()
IL_085c: stelem.ref
IL_085d: dup
IL_085e: ldc.i4.s 93
IL_0860: ldstr " | dustin="
IL_0865: stelem.ref
IL_0866: dup
IL_0867: ldc.i4.s 94
IL_0869: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inDustinMinigame()
IL_086e: stloc.s V_59
IL_0870: ldloca.s V_59
IL_0872: call System.String System.Boolean::ToString()
IL_0877: stelem.ref
IL_0878: dup
IL_0879: ldc.i4.s 95
IL_087b: ldstr " | glitch="
IL_0880: stelem.ref
IL_0881: dup
IL_0882: ldc.i4.s 96
IL_0884: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inGlitchRoom()
IL_0889: stloc.s V_59
IL_088b: ldloca.s V_59
IL_088d: call System.String System.Boolean::ToString()
IL_0892: stelem.ref
IL_0893: dup
IL_0894: ldc.i4.s 97
IL_0896: ldstr " | actor="
IL_089b: stelem.ref
IL_089c: dup
IL_089d: ldc.i4.s 98
IL_089f: ldloc.s V_5
IL_08a1: call System.String ForestProbe::ObjectAddress(System.Object)
IL_08a6: stelem.ref
IL_08a7: dup
IL_08a8: ldc.i4.s 99
IL_08aa: ldstr " | body="
IL_08af: stelem.ref
IL_08b0: dup
IL_08b1: ldc.i4.s 100
IL_08b3: ldloc.s V_6
IL_08b5: call System.String ForestProbe::ObjectAddress(System.Object)
IL_08ba: stelem.ref
IL_08bb: dup
IL_08bc: ldc.i4.s 101
IL_08be: ldstr " | actorPosition="
IL_08c3: stelem.ref
IL_08c4: dup
IL_08c5: ldc.i4.s 102
IL_08c7: ldloc.s V_5
IL_08c9: ldnull
IL_08ca: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_08cf: brtrue.s IL_08e4
IL_08d1: ldloc.s V_5
IL_08d3: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_08d8: callvirt UnityEngine.Vector3 UnityEngine.Transform::get_position()
IL_08dd: call System.String ForestProbe::Vector(UnityEngine.Vector3)
IL_08e2: br.s IL_08e9
IL_08e4: ldstr "null"
IL_08e9: stelem.ref
IL_08ea: dup
IL_08eb: ldc.i4.s 103
IL_08ed: ldstr " | bodyPosition="
IL_08f2: stelem.ref
IL_08f3: dup
IL_08f4: ldc.i4.s 104
IL_08f6: ldloc.s V_6
IL_08f8: ldnull
IL_08f9: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_08fe: brtrue.s IL_0913
IL_0900: ldloc.s V_6
IL_0902: callvirt UnityEngine.Vector2 UnityEngine.Rigidbody2D::get_position()
IL_0907: call UnityEngine.Vector3 UnityEngine.Vector2::op_Implicit(UnityEngine.Vector2)
IL_090c: call System.String ForestProbe::Vector(UnityEngine.Vector3)
IL_0911: br.s IL_0918
IL_0913: ldstr "null"
IL_0918: stelem.ref
IL_0919: dup
IL_091a: ldc.i4.s 105
IL_091c: ldstr " | bodyVelocity="
IL_0921: stelem.ref
IL_0922: dup
IL_0923: ldc.i4.s 106
IL_0925: ldloc.s V_6
IL_0927: ldnull
IL_0928: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_092d: brtrue.s IL_0942
IL_092f: ldloc.s V_6
IL_0931: callvirt UnityEngine.Vector2 UnityEngine.Rigidbody2D::get_velocity()
IL_0936: call UnityEngine.Vector3 UnityEngine.Vector2::op_Implicit(UnityEngine.Vector2)
IL_093b: call System.String ForestProbe::Vector(UnityEngine.Vector3)
IL_0940: br.s IL_0947
IL_0942: ldstr "null"
IL_0947: stelem.ref
IL_0948: dup
IL_0949: ldc.i4.s 107
IL_094b: ldstr " | movement="
IL_0950: stelem.ref
IL_0951: dup
IL_0952: ldc.i4.s 108
IL_0954: ldloc.s V_5
IL_0956: ldnull
IL_0957: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_095c: brtrue.s IL_0971
IL_095e: ldloc.s V_5
IL_0960: ldstr "enableMovement"
IL_0965: call System.Object ForestProbe::ReadField(System.Object,System.String)
IL_096a: call System.String ForestProbe::DiagnosticValue(System.Object)
IL_096f: br.s IL_0976
IL_0971: ldstr "null"
IL_0976: stelem.ref
IL_0977: dup
IL_0978: ldc.i4.s 109
IL_097a: ldstr " | lanternTransition="
IL_097f: stelem.ref
IL_0980: dup
IL_0981: ldc.i4.s 110
IL_0983: ldloc.s V_5
IL_0985: ldnull
IL_0986: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_098b: brfalse.s IL_0996
IL_098d: ldloc.s V_5
IL_098f: callvirt System.Boolean TheForestOfLove.Player::get_lanternTransitioning()
IL_0994: br.s IL_0997
IL_0996: ldc.i4.0
IL_0997: stloc.s V_59
IL_0999: ldloca.s V_59
IL_099b: call System.String System.Boolean::ToString()
IL_09a0: stelem.ref
IL_09a1: dup
IL_09a2: ldc.i4.s 111
IL_09a4: ldstr " | sweaterTransition="
IL_09a9: stelem.ref
IL_09aa: dup
IL_09ab: ldc.i4.s 112
IL_09ad: ldloc.s V_5
IL_09af: ldnull
IL_09b0: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_09b5: brfalse.s IL_09c0
IL_09b7: ldloc.s V_5
IL_09b9: callvirt System.Boolean TheForestOfLove.Player::get_sweaterTransitioning()
IL_09be: br.s IL_09c1
IL_09c0: ldc.i4.0
IL_09c1: stloc.s V_59
IL_09c3: ldloca.s V_59
IL_09c5: call System.String System.Boolean::ToString()
IL_09ca: stelem.ref
IL_09cb: dup
IL_09cc: ldc.i4.s 113
IL_09ce: ldstr " | waypoints="
IL_09d3: stelem.ref
IL_09d4: dup
IL_09d5: ldc.i4.s 114
IL_09d7: ldloc.s V_5
IL_09d9: ldnull
IL_09da: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_09df: brtrue.s IL_0a07
IL_09e1: ldloc.s V_5
IL_09e3: callvirt TheForestOfLove.WaypointController TheForestOfLove.Player::get_waypointController()
IL_09e8: ldnull
IL_09e9: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_09ee: brtrue.s IL_0a07
IL_09f0: ldloc.s V_5
IL_09f2: callvirt TheForestOfLove.WaypointController TheForestOfLove.Player::get_waypointController()
IL_09f7: callvirt System.Boolean TheForestOfLove.WaypointController::get_HasWaypoints()
IL_09fc: stloc.s V_59
IL_09fe: ldloca.s V_59
IL_0a00: call System.String System.Boolean::ToString()
IL_0a05: br.s IL_0a0c
IL_0a07: ldstr "absent"
IL_0a0c: stelem.ref
IL_0a0d: call System.String System.String::Concat(System.String[])
IL_0a12: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0a17: nop
IL_0a18: ret
