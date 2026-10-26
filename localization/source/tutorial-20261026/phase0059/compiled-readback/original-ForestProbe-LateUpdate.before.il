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
