METHOD System.String ForestProbe::KeyboardEligibility() | attributes=Private, Static, HideBySig | impl=IL
IL_0000: newobj System.Void ForestProbe/<>c__DisplayClass36_0::.ctor()
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
IL_0028: stfld System.Object ForestProbe/<>c__DisplayClass36_0::watchers
IL_002d: ldloc.0
IL_002e: ldftn System.Object ForestProbe/<>c__DisplayClass36_0::<KeyboardEligibility>b__0(System.String)
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
