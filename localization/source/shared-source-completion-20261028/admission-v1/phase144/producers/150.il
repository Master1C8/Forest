TYPE TheForestOfLove.SneakyInputFieldOSKTranslator
METHOD System.Void TheForestOfLove.SneakyInputFieldOSKTranslator::SetCarretVisible(System.Int32) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: stfld System.Int32 TheForestOfLove.SneakyInputFieldOSKTranslator::authorityCursorIndex
IL_0007: ldarg.0
IL_0008: ldfld TMPro.TMP_InputField TheForestOfLove.SneakyInputFieldOSKTranslator::textReceiverInputField
IL_000d: callvirt System.Type System.Object::GetType()
IL_0012: ldstr "m_CaretPosition"
IL_0017: ldc.i4.s 36
IL_0019: callvirt System.Reflection.FieldInfo System.Type::GetField(System.String,System.Reflection.BindingFlags)
IL_001e: ldarg.0
IL_001f: ldfld TMPro.TMP_InputField TheForestOfLove.SneakyInputFieldOSKTranslator::textReceiverInputField
IL_0024: ldarg.1
IL_0025: box System.Int32
IL_002a: callvirt System.Void System.Reflection.FieldInfo::SetValue(System.Object,System.Object)
IL_002f: ldarg.0
IL_0030: ldfld TMPro.TMP_InputField TheForestOfLove.SneakyInputFieldOSKTranslator::textReceiverInputField
IL_0035: callvirt System.Type System.Object::GetType()
IL_003a: ldstr "m_AllowInput"
IL_003f: ldc.i4.s 36
IL_0041: callvirt System.Reflection.FieldInfo System.Type::GetField(System.String,System.Reflection.BindingFlags)
IL_0046: ldarg.0
IL_0047: ldfld TMPro.TMP_InputField TheForestOfLove.SneakyInputFieldOSKTranslator::textReceiverInputField
IL_004c: ldc.i4.1
IL_004d: box System.Boolean
IL_0052: callvirt System.Void System.Reflection.FieldInfo::SetValue(System.Object,System.Object)
IL_0057: ldarg.0
IL_0058: ldfld TMPro.TMP_InputField TheForestOfLove.SneakyInputFieldOSKTranslator::textReceiverInputField
IL_005d: callvirt System.Type System.Object::GetType()
IL_0062: ldstr "SetCaretVisible"
IL_0067: ldc.i4 292
IL_006c: ldnull
IL_006d: ldarg.0
IL_006e: ldfld TMPro.TMP_InputField TheForestOfLove.SneakyInputFieldOSKTranslator::textReceiverInputField
IL_0073: ldnull
IL_0074: callvirt System.Object System.Type::InvokeMember(System.String,System.Reflection.BindingFlags,System.Reflection.Binder,System.Object,System.Object[])
IL_0079: pop
IL_007a: ldarg.0
IL_007b: ldfld viperOSK.OSK_Receiver TheForestOfLove.SneakyInputFieldOSKTranslator::receiver
IL_0080: ldarg.1
IL_0081: stfld System.Int32 viperOSK.OSK_Receiver::cursorIndex
IL_0086: ldarg.0
IL_0087: ldarg.1
IL_0088: stfld System.Int32 TheForestOfLove.SneakyInputFieldOSKTranslator::cursorPositionAndroid
IL_008d: ldarg.0
IL_008e: ldfld viperOSK.OSK_Receiver TheForestOfLove.SneakyInputFieldOSKTranslator::receiver
IL_0093: ldfld viperOSK.I_OSK_Cursor viperOSK.OSK_Receiver::cursor
IL_0098: callvirt System.Void viperOSK.I_OSK_Cursor::Cursor()
IL_009d: ret
METHOD System.Void TheForestOfLove.SneakyInputFieldOSKTranslator::SetCarretInvisibleOnlyUseFauxCursor(System.Int32) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: stfld System.Int32 TheForestOfLove.SneakyInputFieldOSKTranslator::authorityCursorIndex
IL_0007: ldarg.0
IL_0008: ldfld TMPro.TMP_InputField TheForestOfLove.SneakyInputFieldOSKTranslator::textReceiverInputField
IL_000d: ldarg.1
IL_000e: callvirt System.Void TMPro.TMP_InputField::set_stringPosition(System.Int32)
IL_0013: ldarg.0
IL_0014: ldfld TMPro.TMP_InputField TheForestOfLove.SneakyInputFieldOSKTranslator::textReceiverInputField
IL_0019: ldarg.1
IL_001a: callvirt System.Void TMPro.TMP_InputField::set_caretPosition(System.Int32)
IL_001f: ldarg.0
IL_0020: ldfld TMPro.TMP_InputField TheForestOfLove.SneakyInputFieldOSKTranslator::textReceiverInputField
IL_0025: callvirt System.Type System.Object::GetType()
IL_002a: ldstr "m_CaretPosition"
IL_002f: ldc.i4.s 36
IL_0031: callvirt System.Reflection.FieldInfo System.Type::GetField(System.String,System.Reflection.BindingFlags)
IL_0036: ldarg.0
IL_0037: ldfld TMPro.TMP_InputField TheForestOfLove.SneakyInputFieldOSKTranslator::textReceiverInputField
IL_003c: ldarg.1
IL_003d: box System.Int32
IL_0042: callvirt System.Void System.Reflection.FieldInfo::SetValue(System.Object,System.Object)
IL_0047: ldarg.0
IL_0048: ldfld TMPro.TMP_InputField TheForestOfLove.SneakyInputFieldOSKTranslator::textReceiverInputField
IL_004d: callvirt System.Type System.Object::GetType()
IL_0052: ldstr "m_AllowInput"
IL_0057: ldc.i4.s 36
IL_0059: callvirt System.Reflection.FieldInfo System.Type::GetField(System.String,System.Reflection.BindingFlags)
IL_005e: ldarg.0
IL_005f: ldfld TMPro.TMP_InputField TheForestOfLove.SneakyInputFieldOSKTranslator::textReceiverInputField
IL_0064: ldc.i4.0
IL_0065: box System.Boolean
IL_006a: callvirt System.Void System.Reflection.FieldInfo::SetValue(System.Object,System.Object)
IL_006f: ldarg.0
IL_0070: ldfld TMPro.TMP_InputField TheForestOfLove.SneakyInputFieldOSKTranslator::textReceiverInputField
IL_0075: callvirt System.Type System.Object::GetType()
IL_007a: ldstr "m_CaretVisible"
IL_007f: ldc.i4.s 36
IL_0081: callvirt System.Reflection.FieldInfo System.Type::GetField(System.String,System.Reflection.BindingFlags)
IL_0086: ldarg.0
IL_0087: ldfld TMPro.TMP_InputField TheForestOfLove.SneakyInputFieldOSKTranslator::textReceiverInputField
IL_008c: ldc.i4.0
IL_008d: box System.Boolean
IL_0092: callvirt System.Void System.Reflection.FieldInfo::SetValue(System.Object,System.Object)
IL_0097: ldarg.0
IL_0098: ldfld TMPro.TMP_InputField TheForestOfLove.SneakyInputFieldOSKTranslator::textReceiverInputField
IL_009d: callvirt System.Type System.Object::GetType()
IL_00a2: ldstr "MarkGeometryAsDirty"
IL_00a7: ldc.i4 292
IL_00ac: ldnull
IL_00ad: ldarg.0
IL_00ae: ldfld TMPro.TMP_InputField TheForestOfLove.SneakyInputFieldOSKTranslator::textReceiverInputField
IL_00b3: ldnull
IL_00b4: callvirt System.Object System.Type::InvokeMember(System.String,System.Reflection.BindingFlags,System.Reflection.Binder,System.Object,System.Object[])
IL_00b9: pop
IL_00ba: ldarg.0
IL_00bb: ldfld viperOSK.OSK_Receiver TheForestOfLove.SneakyInputFieldOSKTranslator::receiver
IL_00c0: ldarg.1
IL_00c1: stfld System.Int32 viperOSK.OSK_Receiver::cursorIndex
IL_00c6: ldarg.0
IL_00c7: ldarg.1
IL_00c8: stfld System.Int32 TheForestOfLove.SneakyInputFieldOSKTranslator::cursorPositionAndroid
IL_00cd: ldarg.0
IL_00ce: ldfld viperOSK.OSK_Receiver TheForestOfLove.SneakyInputFieldOSKTranslator::receiver
IL_00d3: ldfld viperOSK.I_OSK_Cursor viperOSK.OSK_Receiver::cursor
IL_00d8: callvirt System.Void viperOSK.I_OSK_Cursor::Cursor()
IL_00dd: ret
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
IL_006a: ldstr ""
IL_006f: ldstr "~"
IL_0074: callvirt System.String System.String::Replace(System.String,System.String)
IL_0079: ldstr "~"
IL_007e: ldstr "
"
IL_0083: callvirt System.String System.String::Replace(System.String,System.String)
IL_0088: starg.s str
IL_008a: ldarg.0
IL_008b: ret
METHOD System.String TheForestOfLove.SneakyInputFieldOSKTranslator::CheckForGlitchRascalCodeActivation(System.String,System.Boolean&) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: brfalse.s IL_0026
IL_0003: ldarg.0
IL_0004: ldstr "inventory.Add(ItemNumber.621)"
IL_0009: ldc.i4.4
IL_000a: callvirt System.Int32 System.String::IndexOf(System.String,System.StringComparison)
IL_000f: ldc.i4.0
IL_0010: blt.s IL_0026
IL_0012: ldarg.1
IL_0013: ldc.i4.1
IL_0014: stind.i1
IL_0015: ldarg.0
IL_0016: ldstr "inventory.Add(ItemNumber.621)"
IL_001b: ldsfld System.String System.String::Empty
IL_0020: callvirt System.String System.String::Replace(System.String,System.String)
IL_0025: ret
IL_0026: ldarg.1
IL_0027: ldc.i4.0
IL_0028: stind.i1
IL_0029: ldarg.0
IL_002a: ret
