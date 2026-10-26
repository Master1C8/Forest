TYPE ForestProbe
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
