TYPE TheForestOfLove.SneakyInputFieldOSKTranslator
METHOD System.Void TheForestOfLove.SneakyInputFieldOSKTranslator::Awake() | attributes=Private, HideBySig | impl=IL
IL_0000: ldsfld System.Collections.Generic.HashSet`1<System.Char> TheForestOfLove.SneakyInputFieldOSKTranslator::allowedInputCharacters
IL_0005: callvirt System.Int32 System.Collections.Generic.HashSet`1<System.Char>::get_Count()
IL_000a: brtrue IL_017e
IL_000f: ldc.i4.s 48
IL_0011: stloc.0
IL_0012: br.s IL_0025
IL_0014: ldsfld System.Collections.Generic.HashSet`1<System.Char> TheForestOfLove.SneakyInputFieldOSKTranslator::allowedInputCharacters
IL_0019: ldloc.0
IL_001a: callvirt System.Boolean System.Collections.Generic.HashSet`1<System.Char>::Add(!0)
IL_001f: pop
IL_0020: ldloc.0
IL_0021: ldc.i4.1
IL_0022: add
IL_0023: conv.u2
IL_0024: stloc.0
IL_0025: ldloc.0
IL_0026: ldc.i4.s 57
IL_0028: ble.s IL_0014
IL_002a: ldc.i4.s 65
IL_002c: stloc.1
IL_002d: br.s IL_0040
IL_002f: ldsfld System.Collections.Generic.HashSet`1<System.Char> TheForestOfLove.SneakyInputFieldOSKTranslator::allowedInputCharacters
IL_0034: ldloc.1
IL_0035: callvirt System.Boolean System.Collections.Generic.HashSet`1<System.Char>::Add(!0)
IL_003a: pop
IL_003b: ldloc.1
IL_003c: ldc.i4.1
IL_003d: add
IL_003e: conv.u2
IL_003f: stloc.1
IL_0040: ldloc.1
IL_0041: ldc.i4.s 90
IL_0043: ble.s IL_002f
IL_0045: ldc.i4.s 97
IL_0047: stloc.2
IL_0048: br.s IL_005b
IL_004a: ldsfld System.Collections.Generic.HashSet`1<System.Char> TheForestOfLove.SneakyInputFieldOSKTranslator::allowedInputCharacters
IL_004f: ldloc.2
IL_0050: callvirt System.Boolean System.Collections.Generic.HashSet`1<System.Char>::Add(!0)
IL_0055: pop
IL_0056: ldloc.2
IL_0057: ldc.i4.1
IL_0058: add
IL_0059: conv.u2
IL_005a: stloc.2
IL_005b: ldloc.2
IL_005c: ldc.i4.s 122
IL_005e: ble.s IL_004a
IL_0060: ldsfld System.Collections.Generic.HashSet`1<System.Char> TheForestOfLove.SneakyInputFieldOSKTranslator::allowedInputCharacters
IL_0065: ldc.i4.s 13
IL_0067: callvirt System.Boolean System.Collections.Generic.HashSet`1<System.Char>::Add(!0)
IL_006c: pop
IL_006d: ldsfld System.Collections.Generic.HashSet`1<System.Char> TheForestOfLove.SneakyInputFieldOSKTranslator::allowedInputCharacters
IL_0072: ldc.i4.s 10
IL_0074: callvirt System.Boolean System.Collections.Generic.HashSet`1<System.Char>::Add(!0)
IL_0079: pop
IL_007a: ldsfld System.Collections.Generic.HashSet`1<System.Char> TheForestOfLove.SneakyInputFieldOSKTranslator::allowedInputCharacters
IL_007f: ldc.i4.s 45
IL_0081: callvirt System.Boolean System.Collections.Generic.HashSet`1<System.Char>::Add(!0)
IL_0086: pop
IL_0087: ldsfld System.Collections.Generic.HashSet`1<System.Char> TheForestOfLove.SneakyInputFieldOSKTranslator::allowedInputCharacters
IL_008c: ldc.i4.s 47
IL_008e: callvirt System.Boolean System.Collections.Generic.HashSet`1<System.Char>::Add(!0)
IL_0093: pop
IL_0094: ldsfld System.Collections.Generic.HashSet`1<System.Char> TheForestOfLove.SneakyInputFieldOSKTranslator::allowedInputCharacters
IL_0099: ldc.i4.s 58
IL_009b: callvirt System.Boolean System.Collections.Generic.HashSet`1<System.Char>::Add(!0)
IL_00a0: pop
IL_00a1: ldsfld System.Collections.Generic.HashSet`1<System.Char> TheForestOfLove.SneakyInputFieldOSKTranslator::allowedInputCharacters
IL_00a6: ldc.i4.s 59
IL_00a8: callvirt System.Boolean System.Collections.Generic.HashSet`1<System.Char>::Add(!0)
IL_00ad: pop
IL_00ae: ldsfld System.Collections.Generic.HashSet`1<System.Char> TheForestOfLove.SneakyInputFieldOSKTranslator::allowedInputCharacters
IL_00b3: ldc.i4.s 40
IL_00b5: callvirt System.Boolean System.Collections.Generic.HashSet`1<System.Char>::Add(!0)
IL_00ba: pop
IL_00bb: ldsfld System.Collections.Generic.HashSet`1<System.Char> TheForestOfLove.SneakyInputFieldOSKTranslator::allowedInputCharacters
IL_00c0: ldc.i4.s 41
IL_00c2: callvirt System.Boolean System.Collections.Generic.HashSet`1<System.Char>::Add(!0)
IL_00c7: pop
IL_00c8: ldsfld System.Collections.Generic.HashSet`1<System.Char> TheForestOfLove.SneakyInputFieldOSKTranslator::allowedInputCharacters
IL_00cd: ldc.i4.s 36
IL_00cf: callvirt System.Boolean System.Collections.Generic.HashSet`1<System.Char>::Add(!0)
IL_00d4: pop
IL_00d5: ldsfld System.Collections.Generic.HashSet`1<System.Char> TheForestOfLove.SneakyInputFieldOSKTranslator::allowedInputCharacters
IL_00da: ldc.i4.s 34
IL_00dc: callvirt System.Boolean System.Collections.Generic.HashSet`1<System.Char>::Add(!0)
IL_00e1: pop
IL_00e2: ldsfld System.Collections.Generic.HashSet`1<System.Char> TheForestOfLove.SneakyInputFieldOSKTranslator::allowedInputCharacters
IL_00e7: ldc.i4.s 39
IL_00e9: callvirt System.Boolean System.Collections.Generic.HashSet`1<System.Char>::Add(!0)
IL_00ee: pop
IL_00ef: ldsfld System.Collections.Generic.HashSet`1<System.Char> TheForestOfLove.SneakyInputFieldOSKTranslator::allowedInputCharacters
IL_00f4: ldc.i4.s 43
IL_00f6: callvirt System.Boolean System.Collections.Generic.HashSet`1<System.Char>::Add(!0)
IL_00fb: pop
IL_00fc: ldsfld System.Collections.Generic.HashSet`1<System.Char> TheForestOfLove.SneakyInputFieldOSKTranslator::allowedInputCharacters
IL_0101: ldc.i4.s 95
IL_0103: callvirt System.Boolean System.Collections.Generic.HashSet`1<System.Char>::Add(!0)
IL_0108: pop
IL_0109: ldsfld System.Collections.Generic.HashSet`1<System.Char> TheForestOfLove.SneakyInputFieldOSKTranslator::allowedInputCharacters
IL_010e: ldc.i4.s 64
IL_0110: callvirt System.Boolean System.Collections.Generic.HashSet`1<System.Char>::Add(!0)
IL_0115: pop
IL_0116: ldsfld System.Collections.Generic.HashSet`1<System.Char> TheForestOfLove.SneakyInputFieldOSKTranslator::allowedInputCharacters
IL_011b: ldc.i4.s 35
IL_011d: callvirt System.Boolean System.Collections.Generic.HashSet`1<System.Char>::Add(!0)
IL_0122: pop
IL_0123: ldsfld System.Collections.Generic.HashSet`1<System.Char> TheForestOfLove.SneakyInputFieldOSKTranslator::allowedInputCharacters
IL_0128: ldc.i4.s 63
IL_012a: callvirt System.Boolean System.Collections.Generic.HashSet`1<System.Char>::Add(!0)
IL_012f: pop
IL_0130: ldsfld System.Collections.Generic.HashSet`1<System.Char> TheForestOfLove.SneakyInputFieldOSKTranslator::allowedInputCharacters
IL_0135: ldc.i4.s 33
IL_0137: callvirt System.Boolean System.Collections.Generic.HashSet`1<System.Char>::Add(!0)
IL_013c: pop
IL_013d: ldsfld System.Collections.Generic.HashSet`1<System.Char> TheForestOfLove.SneakyInputFieldOSKTranslator::allowedInputCharacters
IL_0142: ldc.i4.s 37
IL_0144: callvirt System.Boolean System.Collections.Generic.HashSet`1<System.Char>::Add(!0)
IL_0149: pop
IL_014a: ldsfld System.Collections.Generic.HashSet`1<System.Char> TheForestOfLove.SneakyInputFieldOSKTranslator::allowedInputCharacters
IL_014f: ldc.i4.s 61
IL_0151: callvirt System.Boolean System.Collections.Generic.HashSet`1<System.Char>::Add(!0)
IL_0156: pop
IL_0157: ldsfld System.Collections.Generic.HashSet`1<System.Char> TheForestOfLove.SneakyInputFieldOSKTranslator::allowedInputCharacters
IL_015c: ldc.i4.s 44
IL_015e: callvirt System.Boolean System.Collections.Generic.HashSet`1<System.Char>::Add(!0)
IL_0163: pop
IL_0164: ldsfld System.Collections.Generic.HashSet`1<System.Char> TheForestOfLove.SneakyInputFieldOSKTranslator::allowedInputCharacters
IL_0169: ldc.i4.s 46
IL_016b: callvirt System.Boolean System.Collections.Generic.HashSet`1<System.Char>::Add(!0)
IL_0170: pop
IL_0171: ldsfld System.Collections.Generic.HashSet`1<System.Char> TheForestOfLove.SneakyInputFieldOSKTranslator::allowedInputCharacters
IL_0176: ldc.i4.s 32
IL_0178: callvirt System.Boolean System.Collections.Generic.HashSet`1<System.Char>::Add(!0)
IL_017d: pop
IL_017e: ret
METHOD System.Void TheForestOfLove.SneakyInputFieldOSKTranslator::Start() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.0
IL_0002: ldfld viperOSK.OSK_Receiver TheForestOfLove.SneakyInputFieldOSKTranslator::receiver
IL_0007: callvirt System.String viperOSK.OSK_Receiver::Text()
IL_000c: stfld System.String TheForestOfLove.SneakyInputFieldOSKTranslator::lastOskReceiverText
IL_0011: ldarg.0
IL_0012: ldfld TMPro.TMP_InputField TheForestOfLove.SneakyInputFieldOSKTranslator::textReceiverInputField
IL_0017: callvirt TMPro.TMP_InputField/OnChangeEvent TMPro.TMP_InputField::get_onValueChanged()
IL_001c: ldarg.0
IL_001d: ldftn System.Void TheForestOfLove.SneakyInputFieldOSKTranslator::OnInputFieldValueChanged(System.String)
IL_0023: newobj System.Void UnityEngine.Events.UnityAction`1<System.String>::.ctor(System.Object,System.IntPtr)
IL_0028: callvirt System.Void UnityEngine.Events.UnityEvent`1<System.String>::AddListener(UnityEngine.Events.UnityAction`1<!0>)
IL_002d: ldarg.0
IL_002e: ldfld TheForestOfLove.UserInput.OSKKeyboardManager TheForestOfLove.SneakyInputFieldOSKTranslator::keyboardManager
IL_0033: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.UserInput.OSKKeyboardManager::onKeyboardEnabled
IL_0038: ldarg.0
IL_0039: ldftn System.Void TheForestOfLove.SneakyInputFieldOSKTranslator::OnVirtualKeyboardEnabled()
IL_003f: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0044: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_0049: ldarg.0
IL_004a: ldfld TheForestOfLove.UserInput.OSKKeyboardManager TheForestOfLove.SneakyInputFieldOSKTranslator::keyboardManager
IL_004f: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.UserInput.OSKKeyboardManager::onKeyboardDisabled
IL_0054: ldarg.0
IL_0055: ldftn System.Void TheForestOfLove.SneakyInputFieldOSKTranslator::OnVirtualKeyboardDisabled()
IL_005b: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0060: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_0065: ret
METHOD System.Void TheForestOfLove.SneakyInputFieldOSKTranslator::OnInputFieldValueChanged(System.String) | attributes=Private, HideBySig | impl=IL
IL_0000: ldc.i4.0
IL_0001: stloc.0
IL_0002: ldarg.1
IL_0003: call System.String TheForestOfLove.SneakyInputFieldOSKTranslator::SanitizeInputString(System.String)
IL_0008: starg.s value
IL_000a: call TheForestOfLove.Services.Persistence.GlitchRascalPart1Data TheForestOfLove.Services.Persistence.DataService::GetGlitchRascalPart1Data()
IL_000f: ldfld System.Boolean TheForestOfLove.Services.Persistence.GlitchRascalPart1Data::metGlitch
IL_0014: brfalse.s IL_002c
IL_0016: call TheForestOfLove.Services.Persistence.GlitchRascalPart1Data TheForestOfLove.Services.Persistence.DataService::GetGlitchRascalPart1Data()
IL_001b: ldfld System.Boolean TheForestOfLove.Services.Persistence.GlitchRascalPart1Data::typedBugReportCommand
IL_0020: brtrue.s IL_002c
IL_0022: ldarg.1
IL_0023: ldloca.s V_0
IL_0025: call System.String TheForestOfLove.SneakyInputFieldOSKTranslator::CheckForGlitchRascalCodeActivation(System.String,System.Boolean&)
IL_002a: starg.s value
IL_002c: ldarg.1
IL_002d: callvirt System.Int32 System.String::get_Length()
IL_0032: ldarg.0
IL_0033: ldfld System.String TheForestOfLove.SneakyInputFieldOSKTranslator::lastOskReceiverText
IL_0038: callvirt System.Int32 System.String::get_Length()
IL_003d: sub
IL_003e: stloc.1
IL_003f: ldarg.0
IL_0040: ldfld viperOSK.OSK_Receiver TheForestOfLove.SneakyInputFieldOSKTranslator::receiver
IL_0045: ldarg.1
IL_0046: callvirt System.Void viperOSK.OSK_Receiver::SetText(System.String)
IL_004b: ldarg.0
IL_004c: ldfld TMPro.TMP_InputField TheForestOfLove.SneakyInputFieldOSKTranslator::textReceiverInputField
IL_0051: ldarg.1
IL_0052: callvirt System.Void TMPro.TMP_InputField::SetTextWithoutNotify(System.String)
IL_0057: ldarg.0
IL_0058: ldarg.0
IL_0059: ldfld viperOSK.OSK_Receiver TheForestOfLove.SneakyInputFieldOSKTranslator::receiver
IL_005e: callvirt System.String viperOSK.OSK_Receiver::Text()
IL_0063: stfld System.String TheForestOfLove.SneakyInputFieldOSKTranslator::lastOskReceiverText
IL_0068: ldloc.1
IL_0069: ldc.i4.1
IL_006a: bne.un.s IL_0093
IL_006c: ldarg.1
IL_006d: ldarg.0
IL_006e: ldfld System.Int32 TheForestOfLove.SneakyInputFieldOSKTranslator::authorityCursorIndex
IL_0073: ldc.i4.1
IL_0074: callvirt System.String System.String::Substring(System.Int32,System.Int32)
IL_0079: ldstr " "
IL_007e: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0083: brfalse.s IL_008c
IL_0085: call System.Void TheForestOfLove.Audio.SoundManager::PlayTypingSound_Spacebar()
IL_008a: br.s IL_0098
IL_008c: call System.Void TheForestOfLove.Audio.SoundManager::PlayTypingSound_Keys()
IL_0091: br.s IL_0098
IL_0093: call System.Void TheForestOfLove.Audio.SoundManager::PlayTypingSound_Keys()
IL_0098: ldarg.0
IL_0099: ldarg.0
IL_009a: ldfld System.Int32 TheForestOfLove.SneakyInputFieldOSKTranslator::authorityCursorIndex
IL_009f: ldloc.1
IL_00a0: add
IL_00a1: ldc.i4.0
IL_00a2: ldarg.0
IL_00a3: ldfld TMPro.TMP_InputField TheForestOfLove.SneakyInputFieldOSKTranslator::textReceiverInputField
IL_00a8: callvirt System.String TMPro.TMP_InputField::get_text()
IL_00ad: callvirt System.Int32 System.String::get_Length()
IL_00b2: call System.Int32 UnityEngine.Mathf::Clamp(System.Int32,System.Int32,System.Int32)
IL_00b7: stfld System.Int32 TheForestOfLove.SneakyInputFieldOSKTranslator::authorityCursorIndex
IL_00bc: ldloc.0
IL_00bd: brfalse.s IL_00ca
IL_00bf: ldarg.0
IL_00c0: call UnityEngine.Events.UnityEvent TheForestOfLove.SneakyInputFieldOSKTranslator::get_onGlitchRascalCodeActivation()
IL_00c5: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_00ca: ret
METHOD System.String TheForestOfLove.SneakyInputFieldOSKTranslator::SanitizeInputString(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: callvirt System.Int32 System.String::get_Length()
IL_0006: newarr System.Char
IL_000b: stloc.0
IL_000c: ldc.i4.0
IL_000d: stloc.1
IL_000e: ldarg.0
IL_000f: stloc.2
IL_0010: ldc.i4.0
IL_0011: stloc.3
IL_0012: br.s IL_0038
IL_0014: ldloc.2
IL_0015: ldloc.3
IL_0016: callvirt System.Char System.String::get_Chars(System.Int32)
IL_001b: stloc.s V_4
IL_001d: ldsfld System.Collections.Generic.HashSet`1<System.Char> TheForestOfLove.SneakyInputFieldOSKTranslator::allowedInputCharacters
IL_0022: ldloc.s V_4
IL_0024: callvirt System.Boolean System.Collections.Generic.HashSet`1<System.Char>::Contains(!0)
IL_0029: brfalse.s IL_0034
IL_002b: ldloc.0
IL_002c: ldloc.1
IL_002d: ldloc.s V_4
IL_002f: stelem.i2
IL_0030: ldloc.1
IL_0031: ldc.i4.1
IL_0032: add
IL_0033: stloc.1
IL_0034: ldloc.3
IL_0035: ldc.i4.1
IL_0036: add
IL_0037: stloc.3
IL_0038: ldloc.3
IL_0039: ldloc.2
IL_003a: callvirt System.Int32 System.String::get_Length()
IL_003f: blt.s IL_0014
IL_0041: ldloc.0
IL_0042: ldc.i4.0
IL_0043: ldloc.1
IL_0044: newobj System.Void System.String::.ctor(System.Char[],System.Int32,System.Int32)
IL_0049: starg.s str
IL_004b: ldarg.0
IL_004c: ldstr "
"
IL_0051: ldstr "~"
IL_0056: callvirt System.String System.String::Replace(System.String,System.String)
IL_005b: ldstr "
"
IL_0060: ldstr "~"
IL_0065: callvirt System.String System.String::Replace(System.String,System.String)
IL_006a: ldstr "
"
IL_006f: ldstr "~"
IL_0074: callvirt System.String System.String::Replace(System.String,System.String)
IL_0079: ldstr "~"
IL_007e: ldstr "
"
IL_0083: callvirt System.String System.String::Replace(System.String,System.String)
IL_0088: starg.s str
IL_008a: ldarg.0
IL_008b: ret
METHOD System.Void TheForestOfLove.SneakyInputFieldOSKTranslator::ClearInputText() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.UserInput.OSKKeyboardManager TheForestOfLove.SneakyInputFieldOSKTranslator::keyboardManager
IL_0006: callvirt System.Boolean TheForestOfLove.UserInput.OSKKeyboardManager::get_isKeyboardEnabled()
IL_000b: brfalse.s IL_000e
IL_000d: ret
IL_000e: ldarg.0
IL_000f: ldfld TMPro.TMP_InputField TheForestOfLove.SneakyInputFieldOSKTranslator::textReceiverInputField
IL_0014: ldsfld System.String System.String::Empty
IL_0019: callvirt System.Void TMPro.TMP_InputField::set_text(System.String)
IL_001e: ldarg.0
IL_001f: ldfld TMPro.TMP_InputField TheForestOfLove.SneakyInputFieldOSKTranslator::textReceiverInputField
IL_0024: ldc.i4.0
IL_0025: callvirt System.Void TMPro.TMP_InputField::MoveTextEnd(System.Boolean)
IL_002a: ldarg.0
IL_002b: ldfld viperOSK.OSK_Receiver TheForestOfLove.SneakyInputFieldOSKTranslator::receiver
IL_0030: ldsfld System.String System.String::Empty
IL_0035: callvirt System.Void viperOSK.OSK_Receiver::SetText(System.String)
IL_003a: ldarg.0
IL_003b: ldarg.0
IL_003c: ldfld viperOSK.OSK_Receiver TheForestOfLove.SneakyInputFieldOSKTranslator::receiver
IL_0041: callvirt System.String viperOSK.OSK_Receiver::Text()
IL_0046: stfld System.String TheForestOfLove.SneakyInputFieldOSKTranslator::lastOskReceiverText
IL_004b: ret
METHOD System.Void TheForestOfLove.SneakyInputFieldOSKTranslator::UpdateSystemInfo(System.String&,System.String&,System.Int32) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: ldsfld System.String System.String::Empty
IL_0006: stind.ref
IL_0007: ldarg.2
IL_0008: ldsfld System.String System.String::Empty
IL_000d: stind.ref
IL_000e: call T TheForestOfLove.Services.ServiceLocator::Get<TheForestOfLove.BugReportApiHelper>()
IL_0013: stloc.0
IL_0014: ldloc.0
IL_0015: ldnull
IL_0016: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_001b: brfalse.s IL_002f
IL_001d: ldarg.1
IL_001e: ldloc.0
IL_001f: ldarg.3
IL_0020: callvirt System.String TheForestOfLove.BugReportApiHelper::GenerateApplicationInfo(System.Int32)
IL_0025: stind.ref
IL_0026: ldarg.2
IL_0027: ldloc.0
IL_0028: ldarg.3
IL_0029: callvirt System.String TheForestOfLove.BugReportApiHelper::GenerateSystemSpecs(System.Int32)
IL_002e: stind.ref
IL_002f: ret
METHOD System.Void TheForestOfLove.SneakyInputFieldOSKTranslator::SubmitBugReport(System.Int32) | attributes=Public, HideBySig | impl=IL
IL_0000: call T TheForestOfLove.Services.ServiceLocator::Get<TheForestOfLove.BugReportApiHelper>()
IL_0005: stloc.0
IL_0006: ldloc.0
IL_0007: ldnull
IL_0008: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_000d: brfalse.s IL_0021
IL_000f: ldloc.0
IL_0010: ldarg.0
IL_0011: ldfld TMPro.TMP_InputField TheForestOfLove.SneakyInputFieldOSKTranslator::textReceiverInputField
IL_0016: callvirt System.String TMPro.TMP_InputField::get_text()
IL_001b: ldarg.1
IL_001c: callvirt System.Void TheForestOfLove.BugReportApiHelper::SubmitBugReport(System.String,System.Int32)
IL_0021: ret
