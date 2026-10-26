METHOD System.Void ForestProbe::LateUpdate() | attributes=Private, HideBySig | impl=IL
IL_0000: nop
IL_0001: call System.Single UnityEngine.Time::get_realtimeSinceStartup()
IL_0006: ldarg.0
IL_0007: ldfld System.Single ForestProbe::nextLifecycleRecord
IL_000c: clt.un
IL_000e: ldc.i4.0
IL_000f: ceq
IL_0011: stloc.s V_31
IL_0013: ldloc.s V_31
IL_0015: brfalse.s IL_0036
IL_0017: nop
IL_0018: ldarg.0
IL_0019: call System.Single UnityEngine.Time::get_realtimeSinceStartup()
IL_001e: ldc.r4 1
IL_0023: add
IL_0024: stfld System.Single ForestProbe::nextLifecycleRecord
IL_0029: ldarg.0
IL_002a: ldstr "heartbeat"
IL_002f: call System.Void ForestProbe::ObserveLifecycle(System.String)
IL_0034: nop
IL_0035: nop
IL_0036: ldarg.0
IL_0037: ldstr "late"
IL_003c: ldstr "unknown"
IL_0041: call System.Void ForestProbe::ObserveFocus(System.String,System.String)
IL_0046: nop
IL_0047: ldarg.0
IL_0048: ldfld System.Boolean ForestProbe::samplingKeyboard
IL_004d: ldc.i4.0
IL_004e: ceq
IL_0050: stloc.s V_32
IL_0052: ldloc.s V_32
IL_0054: brfalse.s IL_005b
IL_0056: br IL_0a4d
IL_005b: ldarg.0
IL_005c: ldfld System.Collections.Generic.List`1<System.String> ForestProbe::keyboardSamples
IL_0061: callvirt System.Int32 System.Collections.Generic.List`1<System.String>::get_Count()
IL_0066: ldc.i4 1200
IL_006b: clt
IL_006d: ldc.i4.0
IL_006e: ceq
IL_0070: stloc.s V_33
IL_0072: ldloc.s V_33
IL_0074: brfalse.s IL_0089
IL_0076: nop
IL_0077: ldarg.0
IL_0078: ldc.i4.0
IL_0079: stfld System.Boolean ForestProbe::samplingKeyboard
IL_007e: ldstr "Keyboard sample exceeded bound"
IL_0083: newobj System.Void System.Exception::.ctor(System.String)
IL_0088: throw
IL_0089: ldc.i4 256
IL_008e: newarr System.Byte
IL_0093: stloc.0
IL_0094: ldloc.0
IL_0095: call System.Boolean ForestProbe::GetKeyboardState(System.Byte[])
IL_009a: stloc.1
IL_009b: call Rewired.ReInput/ControllerHelper Rewired.ReInput::get_controllers()
IL_00a0: callvirt Rewired.Keyboard Rewired.ReInput/ControllerHelper::get_Keyboard()
IL_00a5: stloc.2
IL_00a6: call !!0 UnityEngine.Object::FindObjectOfType<TheForestOfLove.InputHelper>()
IL_00ab: stloc.3
IL_00ac: ldloc.3
IL_00ad: ldnull
IL_00ae: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_00b3: brtrue.s IL_00c7
IL_00b5: ldloc.3
IL_00b6: ldstr "player"
IL_00bb: call System.Object ForestProbe::ReadField(System.Object,System.String)
IL_00c0: isinst Rewired.Player
IL_00c5: br.s IL_00c8
IL_00c7: ldnull
IL_00c8: stloc.s V_4
IL_00ca: call !!0 UnityEngine.Object::FindObjectOfType<TheForestOfLove.Player>()
IL_00cf: stloc.s V_5
IL_00d1: ldloc.s V_5
IL_00d3: ldnull
IL_00d4: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_00d9: brtrue.s IL_00e4
IL_00db: ldloc.s V_5
IL_00dd: callvirt !!0 UnityEngine.Component::GetComponent<UnityEngine.Rigidbody2D>()
IL_00e2: br.s IL_00e5
IL_00e4: ldnull
IL_00e5: stloc.s V_6
IL_00e7: ldloc.1
IL_00e8: stloc.s V_7
IL_00ea: ldc.i4.1
IL_00eb: stloc.s V_8
IL_00ed: ldc.i4.1
IL_00ee: stloc.s V_9
IL_00f0: ldc.i4.1
IL_00f1: stloc.s V_10
IL_00f3: ldloc.1
IL_00f4: stloc.s V_11
IL_00f6: ldc.i4.1
IL_00f7: stloc.s V_12
IL_00f9: ldc.i4.1
IL_00fa: stloc.s V_13
IL_00fc: ldc.i4.1
IL_00fd: stloc.s V_14
IL_00ff: newobj System.Void System.Collections.Generic.List`1<System.String>::.ctor()
IL_0104: stloc.s V_15
IL_0106: newobj System.Void System.Collections.Generic.List`1<System.String>::.ctor()
IL_010b: stloc.s V_16
IL_010d: newobj System.Void System.Collections.Generic.List`1<System.String>::.ctor()
IL_0112: stloc.s V_17
IL_0114: newobj System.Void System.Collections.Generic.List`1<System.String>::.ctor()
IL_0119: stloc.s V_18
IL_011b: ldc.i4.8
IL_011c: newarr System.Int32
IL_0121: dup
IL_0122: ldtoken <PrivateImplementationDetails>/__StaticArrayInitTypeSize=32 <PrivateImplementationDetails>::FA9DA32EF86D16DF93F9B68A1A3F1B6CCDF0CC0AFE42E955879466B9A07FA39C
IL_0127: call System.Void System.Runtime.CompilerServices.RuntimeHelpers::InitializeArray(System.Array,System.RuntimeFieldHandle)
IL_012c: stloc.s V_19
IL_012e: ldc.i4.8
IL_012f: newarr UnityEngine.KeyCode
IL_0134: dup
IL_0135: ldtoken <PrivateImplementationDetails>/__StaticArrayInitTypeSize=32 <PrivateImplementationDetails>::4FC069E5F273C875F43BF5FF04803EE4E98A9BB05490E5E1EA9139F51CBACE4A
IL_013a: call System.Void System.Runtime.CompilerServices.RuntimeHelpers::InitializeArray(System.Array,System.RuntimeFieldHandle)
IL_013f: stloc.s V_20
IL_0141: ldc.i4.0
IL_0142: stloc.s V_34
IL_0144: br IL_024c
IL_0149: nop
IL_014a: ldloc.0
IL_014b: ldloc.s V_19
IL_014d: ldloc.s V_34
IL_014f: ldelem.i4
IL_0150: ldelem.u1
IL_0151: ldc.i4 128
IL_0156: and
IL_0157: ldc.i4.0
IL_0158: cgt.un
IL_015a: stloc.s V_35
IL_015c: ldloc.s V_19
IL_015e: ldloc.s V_34
IL_0160: ldelem.i4
IL_0161: call System.Int16 ForestProbe::GetAsyncKeyState(System.Int32)
IL_0166: ldc.i4 32768
IL_016b: and
IL_016c: ldc.i4.0
IL_016d: cgt.un
IL_016f: stloc.s V_36
IL_0171: ldloc.2
IL_0172: ldloc.s V_20
IL_0174: ldloc.s V_34
IL_0176: ldelem.i4
IL_0177: callvirt System.Boolean Rewired.Keyboard::GetKey(UnityEngine.KeyCode)
IL_017c: stloc.s V_37
IL_017e: ldloc.s V_20
IL_0180: ldloc.s V_34
IL_0182: ldelem.i4
IL_0183: call System.Boolean UnityEngine.Input::GetKey(UnityEngine.KeyCode)
IL_0188: stloc.s V_38
IL_018a: ldloc.s V_20
IL_018c: ldloc.s V_34
IL_018e: ldelema UnityEngine.KeyCode
IL_0193: constrained. UnityEngine.KeyCode
IL_0199: callvirt System.String System.Object::ToString()
IL_019e: stloc.s V_39
IL_01a0: ldloc.s V_35
IL_01a2: stloc.s V_40
IL_01a4: ldloc.s V_40
IL_01a6: brfalse.s IL_01b2
IL_01a8: ldloc.s V_15
IL_01aa: ldloc.s V_39
IL_01ac: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_01b1: nop
IL_01b2: ldloc.s V_36
IL_01b4: stloc.s V_41
IL_01b6: ldloc.s V_41
IL_01b8: brfalse.s IL_01c4
IL_01ba: ldloc.s V_16
IL_01bc: ldloc.s V_39
IL_01be: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_01c3: nop
IL_01c4: ldloc.s V_37
IL_01c6: stloc.s V_42
IL_01c8: ldloc.s V_42
IL_01ca: brfalse.s IL_01d6
IL_01cc: ldloc.s V_17
IL_01ce: ldloc.s V_39
IL_01d0: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_01d5: nop
IL_01d6: ldloc.s V_38
IL_01d8: stloc.s V_43
IL_01da: ldloc.s V_43
IL_01dc: brfalse.s IL_01e8
IL_01de: ldloc.s V_18
IL_01e0: ldloc.s V_39
IL_01e2: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_01e7: nop
IL_01e8: ldloc.s V_11
IL_01ea: ldloc.s V_35
IL_01ec: ldc.i4.0
IL_01ed: ceq
IL_01ef: and
IL_01f0: stloc.s V_11
IL_01f2: ldloc.s V_12
IL_01f4: ldloc.s V_36
IL_01f6: ldc.i4.0
IL_01f7: ceq
IL_01f9: and
IL_01fa: stloc.s V_12
IL_01fc: ldloc.s V_13
IL_01fe: ldloc.s V_37
IL_0200: ldc.i4.0
IL_0201: ceq
IL_0203: and
IL_0204: stloc.s V_13
IL_0206: ldloc.s V_14
IL_0208: ldloc.s V_38
IL_020a: ldc.i4.0
IL_020b: ceq
IL_020d: and
IL_020e: stloc.s V_14
IL_0210: ldloc.s V_34
IL_0212: ldc.i4.4
IL_0213: clt
IL_0215: stloc.s V_44
IL_0217: ldloc.s V_44
IL_0219: brfalse.s IL_0245
IL_021b: nop
IL_021c: ldloc.s V_7
IL_021e: ldloc.s V_35
IL_0220: ldc.i4.0
IL_0221: ceq
IL_0223: and
IL_0224: stloc.s V_7
IL_0226: ldloc.s V_8
IL_0228: ldloc.s V_36
IL_022a: ldc.i4.0
IL_022b: ceq
IL_022d: and
IL_022e: stloc.s V_8
IL_0230: ldloc.s V_9
IL_0232: ldloc.s V_37
IL_0234: ldc.i4.0
IL_0235: ceq
IL_0237: and
IL_0238: stloc.s V_9
IL_023a: ldloc.s V_10
IL_023c: ldloc.s V_38
IL_023e: ldc.i4.0
IL_023f: ceq
IL_0241: and
IL_0242: stloc.s V_10
IL_0244: nop
IL_0245: nop
IL_0246: ldloc.s V_34
IL_0248: ldc.i4.1
IL_0249: add
IL_024a: stloc.s V_34
IL_024c: ldloc.s V_34
IL_024e: ldloc.s V_19
IL_0250: ldlen
IL_0251: conv.i4
IL_0252: clt
IL_0254: stloc.s V_45
IL_0256: ldloc.s V_45
IL_0258: brtrue IL_0149
IL_025d: ldloc.1
IL_025e: stloc.s V_21
IL_0260: ldc.i4.1
IL_0261: stloc.s V_22
IL_0263: ldc.i4.1
IL_0264: stloc.s V_23
IL_0266: ldc.i4.1
IL_0267: stloc.s V_24
IL_0269: newobj System.Void System.Collections.Generic.List`1<System.String>::.ctor()
IL_026e: stloc.s V_25
IL_0270: newobj System.Void System.Collections.Generic.List`1<System.String>::.ctor()
IL_0275: stloc.s V_26
IL_0277: newobj System.Void System.Collections.Generic.List`1<System.String>::.ctor()
IL_027c: stloc.s V_27
IL_027e: newobj System.Void System.Collections.Generic.List`1<System.String>::.ctor()
IL_0283: stloc.s V_28
IL_0285: ldc.i4.4
IL_0286: newarr System.Int32
IL_028b: dup
IL_028c: ldtoken <PrivateImplementationDetails>/__StaticArrayInitTypeSize=16 <PrivateImplementationDetails>::5945A0BB42C5CD8B04846A61EFE2682F135810150E3A13C29D3C3E7C426193DC
IL_0291: call System.Void System.Runtime.CompilerServices.RuntimeHelpers::InitializeArray(System.Array,System.RuntimeFieldHandle)
IL_0296: stloc.s V_29
IL_0298: ldc.i4.4
IL_0299: newarr UnityEngine.KeyCode
IL_029e: dup
IL_029f: ldtoken <PrivateImplementationDetails>/__StaticArrayInitTypeSize=16 <PrivateImplementationDetails>::ADDFE4E9F49C08C646FD569EE8B772C41DD71E156AE33030B307B1C28EABD905
IL_02a4: call System.Void System.Runtime.CompilerServices.RuntimeHelpers::InitializeArray(System.Array,System.RuntimeFieldHandle)
IL_02a9: stloc.s V_30
IL_02ab: ldc.i4.0
IL_02ac: stloc.s V_46
IL_02ae: br IL_0381
IL_02b3: nop
IL_02b4: ldloc.0
IL_02b5: ldloc.s V_29
IL_02b7: ldloc.s V_46
IL_02b9: ldelem.i4
IL_02ba: ldelem.u1
IL_02bb: ldc.i4 128
IL_02c0: and
IL_02c1: ldc.i4.0
IL_02c2: cgt.un
IL_02c4: stloc.s V_47
IL_02c6: ldloc.s V_29
IL_02c8: ldloc.s V_46
IL_02ca: ldelem.i4
IL_02cb: call System.Int16 ForestProbe::GetAsyncKeyState(System.Int32)
IL_02d0: ldc.i4 32768
IL_02d5: and
IL_02d6: ldc.i4.0
IL_02d7: cgt.un
IL_02d9: stloc.s V_48
IL_02db: ldloc.2
IL_02dc: ldloc.s V_30
IL_02de: ldloc.s V_46
IL_02e0: ldelem.i4
IL_02e1: callvirt System.Boolean Rewired.Keyboard::GetKey(UnityEngine.KeyCode)
IL_02e6: stloc.s V_49
IL_02e8: ldloc.s V_30
IL_02ea: ldloc.s V_46
IL_02ec: ldelem.i4
IL_02ed: call System.Boolean UnityEngine.Input::GetKey(UnityEngine.KeyCode)
IL_02f2: stloc.s V_50
IL_02f4: ldloc.s V_30
IL_02f6: ldloc.s V_46
IL_02f8: ldelema UnityEngine.KeyCode
IL_02fd: constrained. UnityEngine.KeyCode
IL_0303: callvirt System.String System.Object::ToString()
IL_0308: stloc.s V_51
IL_030a: ldloc.s V_47
IL_030c: stloc.s V_52
IL_030e: ldloc.s V_52
IL_0310: brfalse.s IL_031c
IL_0312: ldloc.s V_25
IL_0314: ldloc.s V_51
IL_0316: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_031b: nop
IL_031c: ldloc.s V_48
IL_031e: stloc.s V_53
IL_0320: ldloc.s V_53
IL_0322: brfalse.s IL_032e
IL_0324: ldloc.s V_26
IL_0326: ldloc.s V_51
IL_0328: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_032d: nop
IL_032e: ldloc.s V_49
IL_0330: stloc.s V_54
IL_0332: ldloc.s V_54
IL_0334: brfalse.s IL_0340
IL_0336: ldloc.s V_27
IL_0338: ldloc.s V_51
IL_033a: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_033f: nop
IL_0340: ldloc.s V_50
IL_0342: stloc.s V_55
IL_0344: ldloc.s V_55
IL_0346: brfalse.s IL_0352
IL_0348: ldloc.s V_28
IL_034a: ldloc.s V_51
IL_034c: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0351: nop
IL_0352: ldloc.s V_21
IL_0354: ldloc.s V_47
IL_0356: ldc.i4.0
IL_0357: ceq
IL_0359: and
IL_035a: stloc.s V_21
IL_035c: ldloc.s V_22
IL_035e: ldloc.s V_48
IL_0360: ldc.i4.0
IL_0361: ceq
IL_0363: and
IL_0364: stloc.s V_22
IL_0366: ldloc.s V_23
IL_0368: ldloc.s V_49
IL_036a: ldc.i4.0
IL_036b: ceq
IL_036d: and
IL_036e: stloc.s V_23
IL_0370: ldloc.s V_24
IL_0372: ldloc.s V_50
IL_0374: ldc.i4.0
IL_0375: ceq
IL_0377: and
IL_0378: stloc.s V_24
IL_037a: nop
IL_037b: ldloc.s V_46
IL_037d: ldc.i4.1
IL_037e: add
IL_037f: stloc.s V_46
IL_0381: ldloc.s V_46
IL_0383: ldloc.s V_29
IL_0385: ldlen
IL_0386: conv.i4
IL_0387: clt
IL_0389: stloc.s V_56
IL_038b: ldloc.s V_56
IL_038d: brtrue IL_02b3
IL_0392: ldarg.0
IL_0393: ldfld System.Collections.Generic.List`1<System.String> ForestProbe::keyboardSamples
IL_0398: ldc.i4.s 115
IL_039a: newarr System.String
IL_039f: dup
IL_03a0: ldc.i4.0
IL_03a1: ldstr "keyboard | frame="
IL_03a6: stelem.ref
IL_03a7: dup
IL_03a8: ldc.i4.1
IL_03a9: call System.Int32 UnityEngine.Time::get_frameCount()
IL_03ae: stloc.s V_57
IL_03b0: ldloca.s V_57
IL_03b2: call System.String System.Int32::ToString()
IL_03b7: stelem.ref
IL_03b8: dup
IL_03b9: ldc.i4.2
IL_03ba: ldstr " | scaledTime="
IL_03bf: stelem.ref
IL_03c0: dup
IL_03c1: ldc.i4.3
IL_03c2: call System.Single UnityEngine.Time::get_time()
IL_03c7: stloc.s V_58
IL_03c9: ldloca.s V_58
IL_03cb: call System.String System.Single::ToString()
IL_03d0: stelem.ref
IL_03d1: dup
IL_03d2: ldc.i4.4
IL_03d3: ldstr " | timeScale="
IL_03d8: stelem.ref
IL_03d9: dup
IL_03da: ldc.i4.5
IL_03db: call System.Single UnityEngine.Time::get_timeScale()
IL_03e0: stloc.s V_58
IL_03e2: ldloca.s V_58
IL_03e4: call System.String System.Single::ToString()
IL_03e9: stelem.ref
IL_03ea: dup
IL_03eb: ldc.i4.6
IL_03ec: ldstr " | time="
IL_03f1: stelem.ref
IL_03f2: dup
IL_03f3: ldc.i4.7
IL_03f4: call System.Single UnityEngine.Time::get_realtimeSinceStartup()
IL_03f9: stloc.s V_58
IL_03fb: ldloca.s V_58
IL_03fd: call System.String System.Single::ToString()
IL_0402: stelem.ref
IL_0403: dup
IL_0404: ldc.i4.8
IL_0405: ldstr " | winPid="
IL_040a: stelem.ref
IL_040b: dup
IL_040c: ldc.i4.s 9
IL_040e: call System.UInt32 ForestProbe::GetCurrentProcessId()
IL_0413: stloc.s V_59
IL_0415: ldloca.s V_59
IL_0417: call System.String System.UInt32::ToString()
IL_041c: stelem.ref
IL_041d: dup
IL_041e: ldc.i4.s 10
IL_0420: ldstr " | focused="
IL_0425: stelem.ref
IL_0426: dup
IL_0427: ldc.i4.s 11
IL_0429: call System.Boolean UnityEngine.Application::get_isFocused()
IL_042e: stloc.s V_60
IL_0430: ldloca.s V_60
IL_0432: call System.String System.Boolean::ToString()
IL_0437: stelem.ref
IL_0438: dup
IL_0439: ldc.i4.s 12
IL_043b: ldstr " | ignoreUnfocused="
IL_0440: stelem.ref
IL_0441: dup
IL_0442: ldc.i4.s 13
IL_0444: call Rewired.ReInput/ConfigHelper Rewired.ReInput::get_configuration()
IL_0449: callvirt System.Boolean Rewired.ReInput/ConfigHelper::get_ignoreInputWhenAppNotInFocus()
IL_044e: stloc.s V_60
IL_0450: ldloca.s V_60
IL_0452: call System.String System.Boolean::ToString()
IL_0457: stelem.ref
IL_0458: dup
IL_0459: ldc.i4.s 14
IL_045b: call System.String ForestProbe::KeyboardEligibility()
IL_0460: stelem.ref
IL_0461: dup
IL_0462: ldc.i4.s 15
IL_0464: ldstr " | nativeValid="
IL_0469: stelem.ref
IL_046a: dup
IL_046b: ldc.i4.s 16
IL_046d: ldloca.s V_1
IL_046f: call System.String System.Boolean::ToString()
IL_0474: stelem.ref
IL_0475: dup
IL_0476: ldc.i4.s 17
IL_0478: ldstr " | nativeLeft="
IL_047d: stelem.ref
IL_047e: dup
IL_047f: ldc.i4.s 18
IL_0481: ldloc.0
IL_0482: ldc.i4.s 37
IL_0484: ldelem.u1
IL_0485: ldc.i4 128
IL_048a: and
IL_048b: ldc.i4.0
IL_048c: cgt.un
IL_048e: stloc.s V_60
IL_0490: ldloca.s V_60
IL_0492: call System.String System.Boolean::ToString()
IL_0497: stelem.ref
IL_0498: dup
IL_0499: ldc.i4.s 19
IL_049b: ldstr " | asyncLeft="
IL_04a0: stelem.ref
IL_04a1: dup
IL_04a2: ldc.i4.s 20
IL_04a4: ldc.i4.s 37
IL_04a6: call System.Int16 ForestProbe::GetAsyncKeyState(System.Int32)
IL_04ab: ldc.i4 32768
IL_04b0: and
IL_04b1: ldc.i4.0
IL_04b2: cgt.un
IL_04b4: stloc.s V_60
IL_04b6: ldloca.s V_60
IL_04b8: call System.String System.Boolean::ToString()
IL_04bd: stelem.ref
IL_04be: dup
IL_04bf: ldc.i4.s 21
IL_04c1: ldstr " | rewiredLeft="
IL_04c6: stelem.ref
IL_04c7: dup
IL_04c8: ldc.i4.s 22
IL_04ca: ldloc.2
IL_04cb: ldc.i4 276
IL_04d0: callvirt System.Boolean Rewired.Keyboard::GetKey(UnityEngine.KeyCode)
IL_04d5: stloc.s V_60
IL_04d7: ldloca.s V_60
IL_04d9: call System.String System.Boolean::ToString()
IL_04de: stelem.ref
IL_04df: dup
IL_04e0: ldc.i4.s 23
IL_04e2: ldstr " | keyboardEnabled="
IL_04e7: stelem.ref
IL_04e8: dup
IL_04e9: ldc.i4.s 24
IL_04eb: ldloc.2
IL_04ec: callvirt System.Boolean Rewired.Controller::get_enabled()
IL_04f1: stloc.s V_60
IL_04f3: ldloca.s V_60
IL_04f5: call System.String System.Boolean::ToString()
IL_04fa: stelem.ref
IL_04fb: dup
IL_04fc: ldc.i4.s 25
IL_04fe: ldstr " | unityLeft="
IL_0503: stelem.ref
IL_0504: dup
IL_0505: ldc.i4.s 26
IL_0507: ldc.i4 276
IL_050c: call System.Boolean UnityEngine.Input::GetKey(UnityEngine.KeyCode)
IL_0511: stloc.s V_60
IL_0513: ldloca.s V_60
IL_0515: call System.String System.Boolean::ToString()
IL_051a: stelem.ref
IL_051b: dup
IL_051c: ldc.i4.s 27
IL_051e: ldstr " | player="
IL_0523: stelem.ref
IL_0524: dup
IL_0525: ldc.i4.s 28
IL_0527: ldloc.s V_4
IL_0529: brfalse.s IL_054e
IL_052b: ldloc.s V_4
IL_052d: callvirt System.Int32 Rewired.Player::get_id()
IL_0532: stloc.s V_57
IL_0534: ldloca.s V_57
IL_0536: call System.String System.Int32::ToString()
IL_053b: ldstr ":"
IL_0540: ldloc.s V_4
IL_0542: callvirt System.String Rewired.Player::get_name()
IL_0547: call System.String System.String::Concat(System.String,System.String,System.String)
IL_054c: br.s IL_0553
IL_054e: ldstr "null"
IL_0553: stelem.ref
IL_0554: dup
IL_0555: ldc.i4.s 29
IL_0557: ldstr " | keyboardMaps="
IL_055c: stelem.ref
IL_055d: dup
IL_055e: ldc.i4.s 30
IL_0560: ldloc.s V_4
IL_0562: call System.String ForestProbe::KeyboardMaps(Rewired.Player)
IL_0567: stelem.ref
IL_0568: dup
IL_0569: ldc.i4.s 31
IL_056b: ldstr " | actionAxes="
IL_0570: stelem.ref
IL_0571: dup
IL_0572: ldc.i4.s 32
IL_0574: ldloc.s V_4
IL_0576: brfalse.s IL_058d
IL_0578: ldloc.s V_4
IL_057a: ldc.i4.0
IL_057b: ldc.i4.1
IL_057c: callvirt UnityEngine.Vector2 Rewired.Player::GetAxis2D(System.Int32,System.Int32)
IL_0581: call UnityEngine.Vector3 UnityEngine.Vector2::op_Implicit(UnityEngine.Vector2)
IL_0586: call System.String ForestProbe::Vector(UnityEngine.Vector3)
IL_058b: br.s IL_0592
IL_058d: ldstr "null"
IL_0592: stelem.ref
IL_0593: dup
IL_0594: ldc.i4.s 33
IL_0596: ldstr " | fullAxis="
IL_059b: stelem.ref
IL_059c: dup
IL_059d: ldc.i4.s 34
IL_059f: call UnityEngine.Vector3 TheForestOfLove.InputHelper::get_FullAxis()
IL_05a4: call System.String ForestProbe::Vector(UnityEngine.Vector3)
IL_05a9: stelem.ref
IL_05aa: dup
IL_05ab: ldc.i4.s 35
IL_05ad: ldstr " | nativeArrowsUp="
IL_05b2: stelem.ref
IL_05b3: dup
IL_05b4: ldc.i4.s 36
IL_05b6: ldloca.s V_7
IL_05b8: call System.String System.Boolean::ToString()
IL_05bd: stelem.ref
IL_05be: dup
IL_05bf: ldc.i4.s 37
IL_05c1: ldstr " | asyncArrowsUp="
IL_05c6: stelem.ref
IL_05c7: dup
IL_05c8: ldc.i4.s 38
IL_05ca: ldloca.s V_8
IL_05cc: call System.String System.Boolean::ToString()
IL_05d1: stelem.ref
IL_05d2: dup
IL_05d3: ldc.i4.s 39
IL_05d5: ldstr " | rewiredArrowsUp="
IL_05da: stelem.ref
IL_05db: dup
IL_05dc: ldc.i4.s 40
IL_05de: ldloca.s V_9
IL_05e0: call System.String System.Boolean::ToString()
IL_05e5: stelem.ref
IL_05e6: dup
IL_05e7: ldc.i4.s 41
IL_05e9: ldstr " | unityArrowsUp="
IL_05ee: stelem.ref
IL_05ef: dup
IL_05f0: ldc.i4.s 42
IL_05f2: ldloca.s V_10
IL_05f4: call System.String System.Boolean::ToString()
IL_05f9: stelem.ref
IL_05fa: dup
IL_05fb: ldc.i4.s 43
IL_05fd: ldstr " | nativeMovementUp="
IL_0602: stelem.ref
IL_0603: dup
IL_0604: ldc.i4.s 44
IL_0606: ldloca.s V_11
IL_0608: call System.String System.Boolean::ToString()
IL_060d: stelem.ref
IL_060e: dup
IL_060f: ldc.i4.s 45
IL_0611: ldstr " | asyncMovementUp="
IL_0616: stelem.ref
IL_0617: dup
IL_0618: ldc.i4.s 46
IL_061a: ldloca.s V_12
IL_061c: call System.String System.Boolean::ToString()
IL_0621: stelem.ref
IL_0622: dup
IL_0623: ldc.i4.s 47
IL_0625: ldstr " | rewiredMovementUp="
IL_062a: stelem.ref
IL_062b: dup
IL_062c: ldc.i4.s 48
IL_062e: ldloca.s V_13
IL_0630: call System.String System.Boolean::ToString()
IL_0635: stelem.ref
IL_0636: dup
IL_0637: ldc.i4.s 49
IL_0639: ldstr " | unityMovementUp="
IL_063e: stelem.ref
IL_063f: dup
IL_0640: ldc.i4.s 50
IL_0642: ldloca.s V_14
IL_0644: call System.String System.Boolean::ToString()
IL_0649: stelem.ref
IL_064a: dup
IL_064b: ldc.i4.s 51
IL_064d: ldstr " | nativeMovementDown="
IL_0652: stelem.ref
IL_0653: dup
IL_0654: ldc.i4.s 52
IL_0656: ldstr ","
IL_065b: ldloc.s V_15
IL_065d: callvirt !0[] System.Collections.Generic.List`1<System.String>::ToArray()
IL_0662: call System.String System.String::Join(System.String,System.String[])
IL_0667: stelem.ref
IL_0668: dup
IL_0669: ldc.i4.s 53
IL_066b: ldstr " | asyncMovementDown="
IL_0670: stelem.ref
IL_0671: dup
IL_0672: ldc.i4.s 54
IL_0674: ldstr ","
IL_0679: ldloc.s V_16
IL_067b: callvirt !0[] System.Collections.Generic.List`1<System.String>::ToArray()
IL_0680: call System.String System.String::Join(System.String,System.String[])
IL_0685: stelem.ref
IL_0686: dup
IL_0687: ldc.i4.s 55
IL_0689: ldstr " | rewiredMovementDown="
IL_068e: stelem.ref
IL_068f: dup
IL_0690: ldc.i4.s 56
IL_0692: ldstr ","
IL_0697: ldloc.s V_17
IL_0699: callvirt !0[] System.Collections.Generic.List`1<System.String>::ToArray()
IL_069e: call System.String System.String::Join(System.String,System.String[])
IL_06a3: stelem.ref
IL_06a4: dup
IL_06a5: ldc.i4.s 57
IL_06a7: ldstr " | unityMovementDown="
IL_06ac: stelem.ref
IL_06ad: dup
IL_06ae: ldc.i4.s 58
IL_06b0: ldstr ","
IL_06b5: ldloc.s V_18
IL_06b7: callvirt !0[] System.Collections.Generic.List`1<System.String>::ToArray()
IL_06bc: call System.String System.String::Join(System.String,System.String[])
IL_06c1: stelem.ref
IL_06c2: dup
IL_06c3: ldc.i4.s 59
IL_06c5: ldstr " | nativeSubmitUp="
IL_06ca: stelem.ref
IL_06cb: dup
IL_06cc: ldc.i4.s 60
IL_06ce: ldloca.s V_21
IL_06d0: call System.String System.Boolean::ToString()
IL_06d5: stelem.ref
IL_06d6: dup
IL_06d7: ldc.i4.s 61
IL_06d9: ldstr " | asyncSubmitUp="
IL_06de: stelem.ref
IL_06df: dup
IL_06e0: ldc.i4.s 62
IL_06e2: ldloca.s V_22
IL_06e4: call System.String System.Boolean::ToString()
IL_06e9: stelem.ref
IL_06ea: dup
IL_06eb: ldc.i4.s 63
IL_06ed: ldstr " | rewiredSubmitUp="
IL_06f2: stelem.ref
IL_06f3: dup
IL_06f4: ldc.i4.s 64
IL_06f6: ldloca.s V_23
IL_06f8: call System.String System.Boolean::ToString()
IL_06fd: stelem.ref
IL_06fe: dup
IL_06ff: ldc.i4.s 65
IL_0701: ldstr " | unitySubmitUp="
IL_0706: stelem.ref
IL_0707: dup
IL_0708: ldc.i4.s 66
IL_070a: ldloca.s V_24
IL_070c: call System.String System.Boolean::ToString()
IL_0711: stelem.ref
IL_0712: dup
IL_0713: ldc.i4.s 67
IL_0715: ldstr " | nativeSubmitDown="
IL_071a: stelem.ref
IL_071b: dup
IL_071c: ldc.i4.s 68
IL_071e: ldstr ","
IL_0723: ldloc.s V_25
IL_0725: callvirt !0[] System.Collections.Generic.List`1<System.String>::ToArray()
IL_072a: call System.String System.String::Join(System.String,System.String[])
IL_072f: stelem.ref
IL_0730: dup
IL_0731: ldc.i4.s 69
IL_0733: ldstr " | asyncSubmitDown="
IL_0738: stelem.ref
IL_0739: dup
IL_073a: ldc.i4.s 70
IL_073c: ldstr ","
IL_0741: ldloc.s V_26
IL_0743: callvirt !0[] System.Collections.Generic.List`1<System.String>::ToArray()
IL_0748: call System.String System.String::Join(System.String,System.String[])
IL_074d: stelem.ref
IL_074e: dup
IL_074f: ldc.i4.s 71
IL_0751: ldstr " | rewiredSubmitDown="
IL_0756: stelem.ref
IL_0757: dup
IL_0758: ldc.i4.s 72
IL_075a: ldstr ","
IL_075f: ldloc.s V_27
IL_0761: callvirt !0[] System.Collections.Generic.List`1<System.String>::ToArray()
IL_0766: call System.String System.String::Join(System.String,System.String[])
IL_076b: stelem.ref
IL_076c: dup
IL_076d: ldc.i4.s 73
IL_076f: ldstr " | unitySubmitDown="
IL_0774: stelem.ref
IL_0775: dup
IL_0776: ldc.i4.s 74
IL_0778: ldstr ","
IL_077d: ldloc.s V_28
IL_077f: callvirt !0[] System.Collections.Generic.List`1<System.String>::ToArray()
IL_0784: call System.String System.String::Join(System.String,System.String[])
IL_0789: stelem.ref
IL_078a: dup
IL_078b: ldc.i4.s 75
IL_078d: ldstr " | rewiredAction2Held="
IL_0792: stelem.ref
IL_0793: dup
IL_0794: ldc.i4.s 76
IL_0796: ldloc.s V_4
IL_0798: brfalse.s IL_07ad
IL_079a: ldloc.s V_4
IL_079c: ldc.i4.2
IL_079d: callvirt System.Boolean Rewired.Player::GetButton(System.Int32)
IL_07a2: stloc.s V_60
IL_07a4: ldloca.s V_60
IL_07a6: call System.String System.Boolean::ToString()
IL_07ab: br.s IL_07b2
IL_07ad: ldstr "null"
IL_07b2: stelem.ref
IL_07b3: dup
IL_07b4: ldc.i4.s 77
IL_07b6: ldstr " | rewiredAction2Down="
IL_07bb: stelem.ref
IL_07bc: dup
IL_07bd: ldc.i4.s 78
IL_07bf: ldloc.s V_4
IL_07c1: brfalse.s IL_07d6
IL_07c3: ldloc.s V_4
IL_07c5: ldc.i4.2
IL_07c6: callvirt System.Boolean Rewired.Player::GetButtonDown(System.Int32)
IL_07cb: stloc.s V_60
IL_07cd: ldloca.s V_60
IL_07cf: call System.String System.Boolean::ToString()
IL_07d4: br.s IL_07db
IL_07d6: ldstr "null"
IL_07db: stelem.ref
IL_07dc: dup
IL_07dd: ldc.i4.s 79
IL_07df: ldstr " | helperSubmitDown="
IL_07e4: stelem.ref
IL_07e5: dup
IL_07e6: ldc.i4.s 80
IL_07e8: call System.Boolean TheForestOfLove.InputHelper::get_IsSubmitButtonDown()
IL_07ed: stloc.s V_60
IL_07ef: ldloca.s V_60
IL_07f1: call System.String System.Boolean::ToString()
IL_07f6: stelem.ref
IL_07f7: dup
IL_07f8: ldc.i4.s 81
IL_07fa: ldstr " | unityReturnDown="
IL_07ff: stelem.ref
IL_0800: dup
IL_0801: ldc.i4.s 82
IL_0803: ldc.i4.s 13
IL_0805: call System.Boolean UnityEngine.Input::GetKeyDown(UnityEngine.KeyCode)
IL_080a: stloc.s V_60
IL_080c: ldloca.s V_60
IL_080e: call System.String System.Boolean::ToString()
IL_0813: stelem.ref
IL_0814: dup
IL_0815: ldc.i4.s 83
IL_0817: ldstr " | scene="
IL_081c: stelem.ref
IL_081d: dup
IL_081e: ldc.i4.s 84
IL_0820: call UnityEngine.SceneManagement.Scene UnityEngine.SceneManagement.SceneManager::GetActiveScene()
IL_0825: stloc.s V_61
IL_0827: ldloca.s V_61
IL_0829: call System.String UnityEngine.SceneManagement.Scene::get_name()
IL_082e: stelem.ref
IL_082f: dup
IL_0830: ldc.i4.s 85
IL_0832: ldstr " | routeDoorTransition="
IL_0837: stelem.ref
IL_0838: dup
IL_0839: ldc.i4.s 86
IL_083b: call System.String ForestProbe::NaturalDoorTransition()
IL_0840: stelem.ref
IL_0841: dup
IL_0842: ldc.i4.s 87
IL_0844: ldstr " | gameplay="
IL_0849: stelem.ref
IL_084a: dup
IL_084b: ldc.i4.s 88
IL_084d: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inGameplayScene()
IL_0852: stloc.s V_60
IL_0854: ldloca.s V_60
IL_0856: call System.String System.Boolean::ToString()
IL_085b: stelem.ref
IL_085c: dup
IL_085d: ldc.i4.s 89
IL_085f: ldstr " | anyEvent="
IL_0864: stelem.ref
IL_0865: dup
IL_0866: ldc.i4.s 90
IL_0868: call System.Boolean TheForestOfLove.Events.GameStateManager::get_isAnyEventActive()
IL_086d: stloc.s V_60
IL_086f: ldloca.s V_60
IL_0871: call System.String System.Boolean::ToString()
IL_0876: stelem.ref
IL_0877: dup
IL_0878: ldc.i4.s 91
IL_087a: ldstr " | conversation="
IL_087f: stelem.ref
IL_0880: dup
IL_0881: ldc.i4.s 92
IL_0883: call System.Boolean PixelCrushers.DialogueSystem.DialogueManager::get_isConversationActive()
IL_0888: stloc.s V_60
IL_088a: ldloca.s V_60
IL_088c: call System.String System.Boolean::ToString()
IL_0891: stelem.ref
IL_0892: dup
IL_0893: ldc.i4.s 93
IL_0895: ldstr " | dustin="
IL_089a: stelem.ref
IL_089b: dup
IL_089c: ldc.i4.s 94
IL_089e: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inDustinMinigame()
IL_08a3: stloc.s V_60
IL_08a5: ldloca.s V_60
IL_08a7: call System.String System.Boolean::ToString()
IL_08ac: stelem.ref
IL_08ad: dup
IL_08ae: ldc.i4.s 95
IL_08b0: ldstr " | glitch="
IL_08b5: stelem.ref
IL_08b6: dup
IL_08b7: ldc.i4.s 96
IL_08b9: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inGlitchRoom()
IL_08be: stloc.s V_60
IL_08c0: ldloca.s V_60
IL_08c2: call System.String System.Boolean::ToString()
IL_08c7: stelem.ref
IL_08c8: dup
IL_08c9: ldc.i4.s 97
IL_08cb: ldstr " | actor="
IL_08d0: stelem.ref
IL_08d1: dup
IL_08d2: ldc.i4.s 98
IL_08d4: ldloc.s V_5
IL_08d6: call System.String ForestProbe::ObjectAddress(System.Object)
IL_08db: stelem.ref
IL_08dc: dup
IL_08dd: ldc.i4.s 99
IL_08df: ldstr " | body="
IL_08e4: stelem.ref
IL_08e5: dup
IL_08e6: ldc.i4.s 100
IL_08e8: ldloc.s V_6
IL_08ea: call System.String ForestProbe::ObjectAddress(System.Object)
IL_08ef: stelem.ref
IL_08f0: dup
IL_08f1: ldc.i4.s 101
IL_08f3: ldstr " | actorPosition="
IL_08f8: stelem.ref
IL_08f9: dup
IL_08fa: ldc.i4.s 102
IL_08fc: ldloc.s V_5
IL_08fe: ldnull
IL_08ff: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0904: brtrue.s IL_0919
IL_0906: ldloc.s V_5
IL_0908: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_090d: callvirt UnityEngine.Vector3 UnityEngine.Transform::get_position()
IL_0912: call System.String ForestProbe::Vector(UnityEngine.Vector3)
IL_0917: br.s IL_091e
IL_0919: ldstr "null"
IL_091e: stelem.ref
IL_091f: dup
IL_0920: ldc.i4.s 103
IL_0922: ldstr " | bodyPosition="
IL_0927: stelem.ref
IL_0928: dup
IL_0929: ldc.i4.s 104
IL_092b: ldloc.s V_6
IL_092d: ldnull
IL_092e: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0933: brtrue.s IL_0948
IL_0935: ldloc.s V_6
IL_0937: callvirt UnityEngine.Vector2 UnityEngine.Rigidbody2D::get_position()
IL_093c: call UnityEngine.Vector3 UnityEngine.Vector2::op_Implicit(UnityEngine.Vector2)
IL_0941: call System.String ForestProbe::Vector(UnityEngine.Vector3)
IL_0946: br.s IL_094d
IL_0948: ldstr "null"
IL_094d: stelem.ref
IL_094e: dup
IL_094f: ldc.i4.s 105
IL_0951: ldstr " | bodyVelocity="
IL_0956: stelem.ref
IL_0957: dup
IL_0958: ldc.i4.s 106
IL_095a: ldloc.s V_6
IL_095c: ldnull
IL_095d: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0962: brtrue.s IL_0977
IL_0964: ldloc.s V_6
IL_0966: callvirt UnityEngine.Vector2 UnityEngine.Rigidbody2D::get_velocity()
IL_096b: call UnityEngine.Vector3 UnityEngine.Vector2::op_Implicit(UnityEngine.Vector2)
IL_0970: call System.String ForestProbe::Vector(UnityEngine.Vector3)
IL_0975: br.s IL_097c
IL_0977: ldstr "null"
IL_097c: stelem.ref
IL_097d: dup
IL_097e: ldc.i4.s 107
IL_0980: ldstr " | movement="
IL_0985: stelem.ref
IL_0986: dup
IL_0987: ldc.i4.s 108
IL_0989: ldloc.s V_5
IL_098b: ldnull
IL_098c: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0991: brtrue.s IL_09a6
IL_0993: ldloc.s V_5
IL_0995: ldstr "enableMovement"
IL_099a: call System.Object ForestProbe::ReadField(System.Object,System.String)
IL_099f: call System.String ForestProbe::DiagnosticValue(System.Object)
IL_09a4: br.s IL_09ab
IL_09a6: ldstr "null"
IL_09ab: stelem.ref
IL_09ac: dup
IL_09ad: ldc.i4.s 109
IL_09af: ldstr " | lanternTransition="
IL_09b4: stelem.ref
IL_09b5: dup
IL_09b6: ldc.i4.s 110
IL_09b8: ldloc.s V_5
IL_09ba: ldnull
IL_09bb: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_09c0: brfalse.s IL_09cb
IL_09c2: ldloc.s V_5
IL_09c4: callvirt System.Boolean TheForestOfLove.Player::get_lanternTransitioning()
IL_09c9: br.s IL_09cc
IL_09cb: ldc.i4.0
IL_09cc: stloc.s V_60
IL_09ce: ldloca.s V_60
IL_09d0: call System.String System.Boolean::ToString()
IL_09d5: stelem.ref
IL_09d6: dup
IL_09d7: ldc.i4.s 111
IL_09d9: ldstr " | sweaterTransition="
IL_09de: stelem.ref
IL_09df: dup
IL_09e0: ldc.i4.s 112
IL_09e2: ldloc.s V_5
IL_09e4: ldnull
IL_09e5: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_09ea: brfalse.s IL_09f5
IL_09ec: ldloc.s V_5
IL_09ee: callvirt System.Boolean TheForestOfLove.Player::get_sweaterTransitioning()
IL_09f3: br.s IL_09f6
IL_09f5: ldc.i4.0
IL_09f6: stloc.s V_60
IL_09f8: ldloca.s V_60
IL_09fa: call System.String System.Boolean::ToString()
IL_09ff: stelem.ref
IL_0a00: dup
IL_0a01: ldc.i4.s 113
IL_0a03: ldstr " | waypoints="
IL_0a08: stelem.ref
IL_0a09: dup
IL_0a0a: ldc.i4.s 114
IL_0a0c: ldloc.s V_5
IL_0a0e: ldnull
IL_0a0f: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0a14: brtrue.s IL_0a3c
IL_0a16: ldloc.s V_5
IL_0a18: callvirt TheForestOfLove.WaypointController TheForestOfLove.Player::get_waypointController()
IL_0a1d: ldnull
IL_0a1e: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0a23: brtrue.s IL_0a3c
IL_0a25: ldloc.s V_5
IL_0a27: callvirt TheForestOfLove.WaypointController TheForestOfLove.Player::get_waypointController()
IL_0a2c: callvirt System.Boolean TheForestOfLove.WaypointController::get_HasWaypoints()
IL_0a31: stloc.s V_60
IL_0a33: ldloca.s V_60
IL_0a35: call System.String System.Boolean::ToString()
IL_0a3a: br.s IL_0a41
IL_0a3c: ldstr "absent"
IL_0a41: stelem.ref
IL_0a42: call System.String System.String::Concat(System.String[])
IL_0a47: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0a4c: nop
IL_0a4d: ret
