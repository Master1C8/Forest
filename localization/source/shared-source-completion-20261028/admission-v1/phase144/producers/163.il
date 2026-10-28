TYPE viperOSK.OSK_Keyboard
METHOD System.Void viperOSK.OSK_Keyboard::Generate() | attributes=Public, Virtual, HideBySig, VtableLayoutMask | impl=IL
IL_0000: ldarg.0
IL_0001: call UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0006: callvirt !!0[] UnityEngine.Component::GetComponentsInChildren<viperOSK.OSK_Key>()
IL_000b: stloc.0
IL_000c: ldloc.0
IL_000d: ldlen
IL_000e: brfalse.s IL_0035
IL_0010: ldloc.0
IL_0011: stloc.s V_6
IL_0013: ldc.i4.0
IL_0014: stloc.s V_7
IL_0016: br.s IL_002d
IL_0018: ldloc.s V_6
IL_001a: ldloc.s V_7
IL_001c: ldelem.ref
IL_001d: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0022: call System.Void UnityEngine.Object::DestroyImmediate(UnityEngine.Object)
IL_0027: ldloc.s V_7
IL_0029: ldc.i4.1
IL_002a: add
IL_002b: stloc.s V_7
IL_002d: ldloc.s V_7
IL_002f: ldloc.s V_6
IL_0031: ldlen
IL_0032: conv.i4
IL_0033: blt.s IL_0018
IL_0035: ldarg.0
IL_0036: ldfld System.Collections.Generic.Dictionary`2<UnityEngine.KeyCode,viperOSK.OSK_Key> viperOSK.OSK_Keyboard::keyDict
IL_003b: callvirt System.Void System.Collections.Generic.Dictionary`2<UnityEngine.KeyCode,viperOSK.OSK_Key>::Clear()
IL_0040: ldarg.0
IL_0041: ldfld System.String viperOSK.OSK_Keyboard::layout
IL_0046: ldc.i4.1
IL_0047: newarr System.Char
IL_004c: dup
IL_004d: ldc.i4.0
IL_004e: ldc.i4.s 32
IL_0050: stelem.i2
IL_0051: callvirt System.String[] System.String::Split(System.Char[])
IL_0056: stloc.1
IL_0057: ldloca.s V_2
IL_0059: ldarg.0
IL_005a: ldflda UnityEngine.Vector3 viperOSK.OSK_Keyboard::keySize
IL_005f: ldfld System.Single UnityEngine.Vector3::x
IL_0064: ldarg.0
IL_0065: ldflda UnityEngine.Vector3 viperOSK.OSK_Keyboard::keySize
IL_006a: ldfld System.Single UnityEngine.Vector3::y
IL_006f: neg
IL_0070: ldarg.0
IL_0071: ldflda UnityEngine.Vector3 viperOSK.OSK_Keyboard::keySize
IL_0076: ldfld System.Single UnityEngine.Vector3::z
IL_007b: call System.Void UnityEngine.Vector3::.ctor(System.Single,System.Single,System.Single)
IL_0080: ldarg.0
IL_0081: ldfld UnityEngine.Transform viperOSK.OSK_Keyboard::topLeft
IL_0086: callvirt UnityEngine.Vector3 UnityEngine.Transform::get_localPosition()
IL_008b: stloc.3
IL_008c: ldc.i4.0
IL_008d: stloc.s V_4
IL_008f: ldc.i4.0
IL_0090: stloc.s V_5
IL_0092: ldarg.0
IL_0093: ldfld System.Collections.Generic.List`1<System.Collections.Generic.List`1<viperOSK.OSK_Key>> viperOSK.OSK_Keyboard::keyLayout
IL_0098: newobj System.Void System.Collections.Generic.List`1<viperOSK.OSK_Key>::.ctor()
IL_009d: callvirt System.Void System.Collections.Generic.List`1<System.Collections.Generic.List`1<viperOSK.OSK_Key>>::Add(!0)
IL_00a2: ldc.i4.0
IL_00a3: stloc.s V_8
IL_00a5: br IL_058e
IL_00aa: ldloc.1
IL_00ab: ldloc.s V_8
IL_00ad: ldelem.ref
IL_00ae: ldc.i4.0
IL_00af: callvirt System.Char System.String::get_Chars(System.Int32)
IL_00b4: ldc.i4.s 10
IL_00b6: bne.un.s IL_00fe
IL_00b8: ldloca.s V_3
IL_00ba: ldarg.0
IL_00bb: ldfld UnityEngine.Transform viperOSK.OSK_Keyboard::topLeft
IL_00c0: callvirt UnityEngine.Vector3 UnityEngine.Transform::get_localPosition()
IL_00c5: ldfld System.Single UnityEngine.Vector3::x
IL_00ca: stfld System.Single UnityEngine.Vector3::x
IL_00cf: ldloca.s V_3
IL_00d1: ldflda System.Single UnityEngine.Vector3::y
IL_00d6: dup
IL_00d7: ldind.r4
IL_00d8: ldloc.2
IL_00d9: ldfld System.Single UnityEngine.Vector3::y
IL_00de: add
IL_00df: stind.r4
IL_00e0: ldloc.s V_5
IL_00e2: ldc.i4.1
IL_00e3: add
IL_00e4: stloc.s V_5
IL_00e6: ldc.i4.0
IL_00e7: stloc.s V_4
IL_00e9: ldarg.0
IL_00ea: ldfld System.Collections.Generic.List`1<System.Collections.Generic.List`1<viperOSK.OSK_Key>> viperOSK.OSK_Keyboard::keyLayout
IL_00ef: newobj System.Void System.Collections.Generic.List`1<viperOSK.OSK_Key>::.ctor()
IL_00f4: callvirt System.Void System.Collections.Generic.List`1<System.Collections.Generic.List`1<viperOSK.OSK_Key>>::Add(!0)
IL_00f9: br IL_0588
IL_00fe: ldloc.1
IL_00ff: ldloc.s V_8
IL_0101: ldelem.ref
IL_0102: ldstr "Skip"
IL_0107: callvirt System.Boolean System.String::Contains(System.String)
IL_010c: brfalse IL_01a1
IL_0111: ldstr ""
IL_0116: ldloc.1
IL_0117: ldloc.s V_8
IL_0119: ldelem.ref
IL_011a: callvirt System.Char[] System.String::ToCharArray()
IL_011f: ldsfld System.Func`2<System.Char,System.Boolean> viperOSK.OSK_Keyboard/<>c::<>9__31_0
IL_0124: dup
IL_0125: brtrue.s IL_013e
IL_0127: pop
IL_0128: ldsfld viperOSK.OSK_Keyboard/<>c viperOSK.OSK_Keyboard/<>c::<>9
IL_012d: ldftn System.Boolean viperOSK.OSK_Keyboard/<>c::<Generate>b__31_0(System.Char)
IL_0133: newobj System.Void System.Func`2<System.Char,System.Boolean>::.ctor(System.Object,System.IntPtr)
IL_0138: dup
IL_0139: stsfld System.Func`2<System.Char,System.Boolean> viperOSK.OSK_Keyboard/<>c::<>9__31_0
IL_013e: call System.Collections.Generic.IEnumerable`1<!!0> System.Linq.Enumerable::Where<System.Char>(System.Collections.Generic.IEnumerable`1<!!0>,System.Func`2<!!0,System.Boolean>)
IL_0143: call System.String System.String::Join<System.Char>(System.String,System.Collections.Generic.IEnumerable`1<!!0>)
IL_0148: stloc.s V_9
IL_014a: ldloc.s V_9
IL_014c: callvirt System.Int32 System.String::get_Length()
IL_0151: ldc.i4.0
IL_0152: ble IL_0588
IL_0157: ldloc.s V_9
IL_0159: ldloca.s V_10
IL_015b: call System.Boolean System.Single::TryParse(System.String,System.Single&)
IL_0160: brfalse.s IL_0183
IL_0162: ldloca.s V_3
IL_0164: ldloc.3
IL_0165: ldfld System.Single UnityEngine.Vector3::x
IL_016a: ldarg.0
IL_016b: ldflda UnityEngine.Vector3 viperOSK.OSK_Keyboard::keySize
IL_0170: ldfld System.Single UnityEngine.Vector3::x
IL_0175: ldloc.s V_10
IL_0177: mul
IL_0178: add
IL_0179: stfld System.Single UnityEngine.Vector3::x
IL_017e: br IL_0588
IL_0183: ldloca.s V_3
IL_0185: ldloc.3
IL_0186: ldfld System.Single UnityEngine.Vector3::x
IL_018b: ldarg.0
IL_018c: ldflda UnityEngine.Vector3 viperOSK.OSK_Keyboard::keySize
IL_0191: ldfld System.Single UnityEngine.Vector3::x
IL_0196: add
IL_0197: stfld System.Single UnityEngine.Vector3::x
IL_019c: br IL_0588
IL_01a1: ldloc.1
IL_01a2: ldloc.s V_8
IL_01a4: ldelem.ref
IL_01a5: callvirt System.Int32 System.String::get_Length()
IL_01aa: ldc.i4.1
IL_01ab: blt IL_0588
IL_01b0: newobj System.Void viperOSK.OSK_Keyboard/<>c__DisplayClass31_0::.ctor()
IL_01b5: stloc.s V_11
IL_01b7: ldarg.0
IL_01b8: ldfld UnityEngine.GameObject viperOSK.OSK_Keyboard::KeyPrefab
IL_01bd: ldarg.0
IL_01be: call UnityEngine.Transform UnityEngine.Component::get_transform()
IL_01c3: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_01c8: stloc.s V_12
IL_01ca: ldloc.s V_12
IL_01cc: callvirt !!0 UnityEngine.GameObject::GetComponent<viperOSK.OSK_Key>()
IL_01d1: stloc.s V_13
IL_01d3: ldarg.0
IL_01d4: ldfld TMPro.TMP_FontAsset viperOSK.OSK_Keyboard::keyFont
IL_01d9: ldnull
IL_01da: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_01df: brfalse.s IL_01ee
IL_01e1: ldloc.s V_13
IL_01e3: ldarg.0
IL_01e4: ldfld TMPro.TMP_FontAsset viperOSK.OSK_Keyboard::keyFont
IL_01e9: callvirt System.Void viperOSK.OSK_Key::KeyFont(TMPro.TMP_FontAsset)
IL_01ee: ldloc.s V_12
IL_01f0: ldloc.1
IL_01f1: ldloc.s V_8
IL_01f3: ldelem.ref
IL_01f4: callvirt System.Void UnityEngine.Object::set_name(System.String)
IL_01f9: ldstr ""
IL_01fe: stloc.s V_14
IL_0200: ldloc.1
IL_0201: ldloc.s V_8
IL_0203: ldelem.ref
IL_0204: ldc.i4.0
IL_0205: callvirt System.Char System.String::get_Chars(System.Int32)
IL_020a: ldc.i4.s 48
IL_020c: blt.s IL_0223
IL_020e: ldloc.1
IL_020f: ldloc.s V_8
IL_0211: ldelem.ref
IL_0212: ldc.i4.0
IL_0213: callvirt System.Char System.String::get_Chars(System.Int32)
IL_0218: ldc.i4.s 57
IL_021a: bgt.s IL_0223
IL_021c: ldstr "Alpha"
IL_0221: stloc.s V_14
IL_0223: ldloc.s V_11
IL_0225: ldc.i4.s 42
IL_0227: stfld UnityEngine.KeyCode viperOSK.OSK_Keyboard/<>c__DisplayClass31_0::key
IL_022c: ldsfld System.Collections.Generic.Dictionary`2<System.String,UnityEngine.KeyCode> viperOSK.OSK_Keymap::chartoKeycode
IL_0231: ldloc.1
IL_0232: ldloc.s V_8
IL_0234: ldelem.ref
IL_0235: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,UnityEngine.KeyCode>::ContainsKey(!0)
IL_023a: brfalse.s IL_0253
IL_023c: ldloc.s V_11
IL_023e: ldsfld System.Collections.Generic.Dictionary`2<System.String,UnityEngine.KeyCode> viperOSK.OSK_Keymap::chartoKeycode
IL_0243: ldloc.1
IL_0244: ldloc.s V_8
IL_0246: ldelem.ref
IL_0247: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,UnityEngine.KeyCode>::get_Item(!0)
IL_024c: stfld UnityEngine.KeyCode viperOSK.OSK_Keyboard/<>c__DisplayClass31_0::key
IL_0251: br.s IL_029f
IL_0253: nop
IL_0254: ldloc.s V_11
IL_0256: ldtoken UnityEngine.KeyCode
IL_025b: call System.Type System.Type::GetTypeFromHandle(System.RuntimeTypeHandle)
IL_0260: ldloc.s V_14
IL_0262: ldloc.1
IL_0263: ldloc.s V_8
IL_0265: ldelem.ref
IL_0266: call System.String System.String::Concat(System.String,System.String)
IL_026b: call System.Object System.Enum::Parse(System.Type,System.String)
IL_0270: unbox.any UnityEngine.KeyCode
IL_0275: stfld UnityEngine.KeyCode viperOSK.OSK_Keyboard/<>c__DisplayClass31_0::key
IL_027a: leave.s IL_029f
IL_027c: stloc.s V_16
IL_027e: ldstr "OSK_Keyboard could not parse the layout for this text="
IL_0283: ldloc.1
IL_0284: ldloc.s V_8
IL_0286: ldelem.ref
IL_0287: ldstr " make sure you are using KeyCode names for the characters
Exception error: "
IL_028c: ldloc.s V_16
IL_028e: callvirt System.String System.Exception::get_Message()
IL_0293: call System.String System.String::Concat(System.String,System.String,System.String,System.String)
IL_0298: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_029d: leave.s IL_029f
IL_029f: ldarg.0
IL_02a0: ldfld System.Collections.Generic.List`1<viperOSK.OSK_SpecialKeys> viperOSK.OSK_Keyboard::specialKeys
IL_02a5: ldloc.s V_11
IL_02a7: ldftn System.Boolean viperOSK.OSK_Keyboard/<>c__DisplayClass31_0::<Generate>b__1(viperOSK.OSK_SpecialKeys)
IL_02ad: newobj System.Void System.Predicate`1<viperOSK.OSK_SpecialKeys>::.ctor(System.Object,System.IntPtr)
IL_02b2: callvirt !0 System.Collections.Generic.List`1<viperOSK.OSK_SpecialKeys>::Find(System.Predicate`1<!0>)
IL_02b7: stloc.s V_15
IL_02b9: ldloc.s V_11
IL_02bb: ldloc.s V_11
IL_02bd: ldfld UnityEngine.KeyCode viperOSK.OSK_Keyboard/<>c__DisplayClass31_0::key
IL_02c2: call viperOSK.OSK_KEY_TYPES viperOSK.OSK_KeyTypeMeta::KeyType(UnityEngine.KeyCode)
IL_02c7: stfld viperOSK.OSK_KEY_TYPES viperOSK.OSK_Keyboard/<>c__DisplayClass31_0::keyType
IL_02cc: ldloc.s V_15
IL_02ce: brfalse IL_044f
IL_02d3: ldarg.0
IL_02d4: call UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_02d9: callvirt System.String UnityEngine.Object::get_name()
IL_02de: ldstr "KeyBoard (2.1)"
IL_02e3: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_02e8: brfalse.s IL_0317
IL_02ea: ldstr "special key "
IL_02ef: ldloc.s V_11
IL_02f1: ldflda UnityEngine.KeyCode viperOSK.OSK_Keyboard/<>c__DisplayClass31_0::key
IL_02f6: constrained. UnityEngine.KeyCode
IL_02fc: callvirt System.String System.Object::ToString()
IL_0301: ldstr " named:"
IL_0306: ldloc.s V_15
IL_0308: ldfld System.String viperOSK.OSK_SpecialKeys::name
IL_030d: call System.String System.String::Concat(System.String,System.String,System.String,System.String)
IL_0312: call System.Void UnityEngine.Debug::Log(System.Object)
IL_0317: ldloc.s V_13
IL_0319: ldloc.s V_11
IL_031b: ldfld UnityEngine.KeyCode viperOSK.OSK_Keyboard/<>c__DisplayClass31_0::key
IL_0320: ldloc.s V_11
IL_0322: ldfld viperOSK.OSK_KEY_TYPES viperOSK.OSK_Keyboard/<>c__DisplayClass31_0::keyType
IL_0327: ldloc.s V_15
IL_0329: ldfld System.String viperOSK.OSK_SpecialKeys::name
IL_032e: callvirt System.Void viperOSK.OSK_Key::Assign(UnityEngine.KeyCode,viperOSK.OSK_KEY_TYPES,System.String)
IL_0333: ldloc.s V_13
IL_0335: ldloc.s V_15
IL_0337: ldfld UnityEngine.Color viperOSK.OSK_SpecialKeys::col
IL_033c: ldarg.0
IL_033d: ldfld UnityEngine.Color viperOSK.OSK_Keyboard::keyLabelColor
IL_0342: callvirt System.Void viperOSK.OSK_Key::SetColors(UnityEngine.Color,UnityEngine.Color)
IL_0347: ldarg.0
IL_0348: ldfld UnityEngine.Vector3 viperOSK.OSK_Keyboard::keySize
IL_034d: stloc.s V_17
IL_034f: ldloca.s V_17
IL_0351: ldflda System.Single UnityEngine.Vector3::x
IL_0356: dup
IL_0357: ldind.r4
IL_0358: ldloc.s V_15
IL_035a: ldfld System.Single viperOSK.OSK_SpecialKeys::x_size
IL_035f: mul
IL_0360: stind.r4
IL_0361: ldloc.s V_13
IL_0363: ldloc.s V_17
IL_0365: callvirt System.Void viperOSK.OSK_Key::BackScale(UnityEngine.Vector3)
IL_036a: ldloca.s V_3
IL_036c: ldloc.3
IL_036d: ldfld System.Single UnityEngine.Vector3::x
IL_0372: ldloc.s V_17
IL_0374: ldfld System.Single UnityEngine.Vector3::x
IL_0379: ldc.r4 0.5
IL_037e: mul
IL_037f: add
IL_0380: stfld System.Single UnityEngine.Vector3::x
IL_0385: ldloc.s V_12
IL_0387: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_038c: ldloc.3
IL_038d: callvirt System.Void UnityEngine.Transform::set_localPosition(UnityEngine.Vector3)
IL_0392: ldloca.s V_3
IL_0394: ldloc.3
IL_0395: ldfld System.Single UnityEngine.Vector3::x
IL_039a: ldloc.s V_17
IL_039c: ldfld System.Single UnityEngine.Vector3::x
IL_03a1: ldc.r4 0.5
IL_03a6: mul
IL_03a7: add
IL_03a8: stfld System.Single UnityEngine.Vector3::x
IL_03ad: ldc.i4.0
IL_03ae: stloc.s V_18
IL_03b0: br.s IL_03d2
IL_03b2: ldarg.0
IL_03b3: ldfld System.Collections.Generic.List`1<System.Collections.Generic.List`1<viperOSK.OSK_Key>> viperOSK.OSK_Keyboard::keyLayout
IL_03b8: ldloc.s V_5
IL_03ba: callvirt !0 System.Collections.Generic.List`1<System.Collections.Generic.List`1<viperOSK.OSK_Key>>::get_Item(System.Int32)
IL_03bf: ldloc.s V_13
IL_03c1: callvirt System.Void System.Collections.Generic.List`1<viperOSK.OSK_Key>::Add(!0)
IL_03c6: ldloc.s V_4
IL_03c8: ldc.i4.1
IL_03c9: add
IL_03ca: stloc.s V_4
IL_03cc: ldloc.s V_18
IL_03ce: ldc.i4.1
IL_03cf: add
IL_03d0: stloc.s V_18
IL_03d2: ldloc.s V_18
IL_03d4: conv.r4
IL_03d5: ldloc.s V_15
IL_03d7: ldfld System.Single viperOSK.OSK_SpecialKeys::x_size
IL_03dc: blt.s IL_03b2
IL_03de: ldloc.s V_15
IL_03e0: ldfld System.Int32 viperOSK.OSK_SpecialKeys::keySoundCode
IL_03e5: ldc.i4.0
IL_03e6: blt.s IL_0410
IL_03e8: ldarg.0
IL_03e9: ldfld System.Collections.Generic.Dictionary`2<UnityEngine.KeyCode,viperOSK.OSK_SpecialKeys> viperOSK.OSK_Keyboard::keySounds
IL_03ee: ldloc.s V_11
IL_03f0: ldfld UnityEngine.KeyCode viperOSK.OSK_Keyboard/<>c__DisplayClass31_0::key
IL_03f5: callvirt System.Boolean System.Collections.Generic.Dictionary`2<UnityEngine.KeyCode,viperOSK.OSK_SpecialKeys>::ContainsKey(!0)
IL_03fa: brtrue.s IL_0410
IL_03fc: ldarg.0
IL_03fd: ldfld System.Collections.Generic.Dictionary`2<UnityEngine.KeyCode,viperOSK.OSK_SpecialKeys> viperOSK.OSK_Keyboard::keySounds
IL_0402: ldloc.s V_11
IL_0404: ldfld UnityEngine.KeyCode viperOSK.OSK_Keyboard/<>c__DisplayClass31_0::key
IL_0409: ldloc.s V_15
IL_040b: callvirt System.Void System.Collections.Generic.Dictionary`2<UnityEngine.KeyCode,viperOSK.OSK_SpecialKeys>::Add(!0,!1)
IL_0410: ldloc.s V_15
IL_0412: ldfld UnityEngine.Events.UnityEvent`2<UnityEngine.KeyCode,viperOSK.OSK_KEY_TYPES> viperOSK.OSK_SpecialKeys::specialAction
IL_0417: callvirt System.Int32 UnityEngine.Events.UnityEventBase::GetPersistentEventCount()
IL_041c: brtrue.s IL_043c
IL_041e: ldloc.s V_13
IL_0420: ldfld UnityEngine.Events.UnityEvent`2<UnityEngine.KeyCode,viperOSK.OSK_KEY_TYPES> viperOSK.OSK_Key::callBack
IL_0425: ldarg.0
IL_0426: dup
IL_0427: ldvirtftn System.Void viperOSK.OSK_Keyboard::KeyCall(UnityEngine.KeyCode,viperOSK.OSK_KEY_TYPES)
IL_042d: newobj System.Void UnityEngine.Events.UnityAction`2<UnityEngine.KeyCode,viperOSK.OSK_KEY_TYPES>::.ctor(System.Object,System.IntPtr)
IL_0432: callvirt System.Void UnityEngine.Events.UnityEvent`2<UnityEngine.KeyCode,viperOSK.OSK_KEY_TYPES>::AddListener(UnityEngine.Events.UnityAction`2<!0,!1>)
IL_0437: br IL_055e
IL_043c: ldloc.s V_13
IL_043e: ldloc.s V_15
IL_0440: ldfld UnityEngine.Events.UnityEvent`2<UnityEngine.KeyCode,viperOSK.OSK_KEY_TYPES> viperOSK.OSK_SpecialKeys::specialAction
IL_0445: stfld UnityEngine.Events.UnityEvent`2<UnityEngine.KeyCode,viperOSK.OSK_KEY_TYPES> viperOSK.OSK_Key::callBack
IL_044a: br IL_055e
IL_044f: ldarg.0
IL_0450: call UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0455: callvirt System.String UnityEngine.Object::get_name()
IL_045a: ldstr "KeyBoard (2.1)"
IL_045f: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0464: brfalse.s IL_0487
IL_0466: ldstr "regular key "
IL_046b: ldloc.s V_11
IL_046d: ldflda UnityEngine.KeyCode viperOSK.OSK_Keyboard/<>c__DisplayClass31_0::key
IL_0472: constrained. UnityEngine.KeyCode
IL_0478: callvirt System.String System.Object::ToString()
IL_047d: call System.String System.String::Concat(System.String,System.String)
IL_0482: call System.Void UnityEngine.Debug::Log(System.Object)
IL_0487: ldloc.s V_13
IL_0489: ldloc.s V_11
IL_048b: ldfld UnityEngine.KeyCode viperOSK.OSK_Keyboard/<>c__DisplayClass31_0::key
IL_0490: ldloc.s V_11
IL_0492: ldfld viperOSK.OSK_KEY_TYPES viperOSK.OSK_Keyboard/<>c__DisplayClass31_0::keyType
IL_0497: ldstr ""
IL_049c: callvirt System.Void viperOSK.OSK_Key::Assign(UnityEngine.KeyCode,viperOSK.OSK_KEY_TYPES,System.String)
IL_04a1: ldarg.0
IL_04a2: ldfld System.Collections.Generic.List`1<viperOSK.OSK_KeyTypeMeta> viperOSK.OSK_Keyboard::keyTypeMeta
IL_04a7: ldloc.s V_11
IL_04a9: ldftn System.Boolean viperOSK.OSK_Keyboard/<>c__DisplayClass31_0::<Generate>b__2(viperOSK.OSK_KeyTypeMeta)
IL_04af: newobj System.Void System.Predicate`1<viperOSK.OSK_KeyTypeMeta>::.ctor(System.Object,System.IntPtr)
IL_04b4: callvirt !0 System.Collections.Generic.List`1<viperOSK.OSK_KeyTypeMeta>::Find(System.Predicate`1<!0>)
IL_04b9: stloc.s V_19
IL_04bb: ldloc.s V_19
IL_04bd: brfalse.s IL_04d3
IL_04bf: ldloc.s V_13
IL_04c1: ldloc.s V_19
IL_04c3: ldfld UnityEngine.Color viperOSK.OSK_KeyTypeMeta::col
IL_04c8: ldarg.0
IL_04c9: ldfld UnityEngine.Color viperOSK.OSK_Keyboard::keyLabelColor
IL_04ce: callvirt System.Void viperOSK.OSK_Key::SetColors(UnityEngine.Color,UnityEngine.Color)
IL_04d3: ldloc.s V_13
IL_04d5: ldarg.0
IL_04d6: ldfld UnityEngine.Vector3 viperOSK.OSK_Keyboard::keySize
IL_04db: callvirt System.Void viperOSK.OSK_Key::BackScale(UnityEngine.Vector3)
IL_04e0: ldloca.s V_3
IL_04e2: ldloc.3
IL_04e3: ldfld System.Single UnityEngine.Vector3::x
IL_04e8: ldarg.0
IL_04e9: ldflda UnityEngine.Vector3 viperOSK.OSK_Keyboard::keySize
IL_04ee: ldfld System.Single UnityEngine.Vector3::x
IL_04f3: ldc.r4 0.5
IL_04f8: mul
IL_04f9: add
IL_04fa: stfld System.Single UnityEngine.Vector3::x
IL_04ff: ldloc.s V_12
IL_0501: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_0506: ldloc.3
IL_0507: callvirt System.Void UnityEngine.Transform::set_localPosition(UnityEngine.Vector3)
IL_050c: ldloca.s V_3
IL_050e: ldloc.3
IL_050f: ldfld System.Single UnityEngine.Vector3::x
IL_0514: ldarg.0
IL_0515: ldflda UnityEngine.Vector3 viperOSK.OSK_Keyboard::keySize
IL_051a: ldfld System.Single UnityEngine.Vector3::x
IL_051f: ldc.r4 0.5
IL_0524: mul
IL_0525: add
IL_0526: stfld System.Single UnityEngine.Vector3::x
IL_052b: ldarg.0
IL_052c: ldfld System.Collections.Generic.List`1<System.Collections.Generic.List`1<viperOSK.OSK_Key>> viperOSK.OSK_Keyboard::keyLayout
IL_0531: ldloc.s V_5
IL_0533: callvirt !0 System.Collections.Generic.List`1<System.Collections.Generic.List`1<viperOSK.OSK_Key>>::get_Item(System.Int32)
IL_0538: ldloc.s V_13
IL_053a: callvirt System.Void System.Collections.Generic.List`1<viperOSK.OSK_Key>::Add(!0)
IL_053f: ldloc.s V_4
IL_0541: ldc.i4.1
IL_0542: add
IL_0543: stloc.s V_4
IL_0545: ldloc.s V_13
IL_0547: ldfld UnityEngine.Events.UnityEvent`2<UnityEngine.KeyCode,viperOSK.OSK_KEY_TYPES> viperOSK.OSK_Key::callBack
IL_054c: ldarg.0
IL_054d: dup
IL_054e: ldvirtftn System.Void viperOSK.OSK_Keyboard::KeyCall(UnityEngine.KeyCode,viperOSK.OSK_KEY_TYPES)
IL_0554: newobj System.Void UnityEngine.Events.UnityAction`2<UnityEngine.KeyCode,viperOSK.OSK_KEY_TYPES>::.ctor(System.Object,System.IntPtr)
IL_0559: callvirt System.Void UnityEngine.Events.UnityEvent`2<UnityEngine.KeyCode,viperOSK.OSK_KEY_TYPES>::AddListener(UnityEngine.Events.UnityAction`2<!0,!1>)
IL_055e: ldarg.0
IL_055f: ldfld System.Collections.Generic.Dictionary`2<UnityEngine.KeyCode,viperOSK.OSK_Key> viperOSK.OSK_Keyboard::keyDict
IL_0564: ldloc.s V_13
IL_0566: ldfld UnityEngine.KeyCode viperOSK.OSK_Key::key
IL_056b: ldloc.s V_13
IL_056d: callvirt System.Void System.Collections.Generic.Dictionary`2<UnityEngine.KeyCode,viperOSK.OSK_Key>::Add(!0,!1)
IL_0572: call System.Boolean UnityEngine.Application::get_isEditor()
IL_0577: brfalse.s IL_0588
IL_0579: ldarg.0
IL_057a: ldfld System.Boolean viperOSK.OSK_Keyboard::shift
IL_057f: brfalse.s IL_0588
IL_0581: ldloc.s V_13
IL_0583: callvirt System.Void viperOSK.OSK_Key::ShiftUp()
IL_0588: ldloc.s V_8
IL_058a: ldc.i4.1
IL_058b: add
IL_058c: stloc.s V_8
IL_058e: ldloc.s V_8
IL_0590: ldloc.1
IL_0591: ldlen
IL_0592: conv.i4
IL_0593: blt IL_00aa
IL_0598: call System.Boolean UnityEngine.Application::get_isPlaying()
IL_059d: brfalse.s IL_05be
IL_059f: ldarg.0
IL_05a0: ldfld System.Boolean viperOSK.OSK_Keyboard::shift
IL_05a5: brfalse.s IL_05b3
IL_05a7: ldarg.0
IL_05a8: ldstr "ShiftUp"
IL_05ad: call System.Void UnityEngine.Component::BroadcastMessage(System.String)
IL_05b2: ret
IL_05b3: ldarg.0
IL_05b4: ldstr "ShiftDown"
IL_05b9: call System.Void UnityEngine.Component::BroadcastMessage(System.String)
IL_05be: ret
METHOD System.Void viperOSK.OSK_Keyboard::KeyBackspace() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldstr ""
IL_0006: call System.Void viperOSK.OSK_Keyboard::OutputTextUpdate(System.String)
IL_000b: ret
METHOD System.Void viperOSK.OSK_Keyboard::KeyDelete() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldstr ""
IL_0006: call System.Void viperOSK.OSK_Keyboard::OutputTextUpdate(System.String)
IL_000b: ret
METHOD System.Void viperOSK.OSK_Keyboard::.ctor() | attributes=Public, HideBySig, SpecialName, RTSpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldc.i4.1
IL_0002: stfld System.Boolean viperOSK.OSK_Keyboard::hasFocus
IL_0007: ldarg.0
IL_0008: call UnityEngine.Color UnityEngine.Color::get_white()
IL_000d: stfld UnityEngine.Color viperOSK.OSK_Keyboard::keyLabelColor
IL_0012: ldarg.0
IL_0013: ldc.r4 0.7
IL_0018: ldc.r4 0.5
IL_001d: ldc.r4 0.5
IL_0022: newobj System.Void UnityEngine.Color::.ctor(System.Single,System.Single,System.Single)
IL_0027: stfld UnityEngine.Color viperOSK.OSK_Keyboard::highlighterColor
IL_002c: ldarg.0
IL_002d: ldc.r4 0.15
IL_0032: stfld System.Single viperOSK.OSK_Keyboard::inputTimerThreshold
IL_0037: ldarg.0
IL_0038: newobj System.Void System.Collections.Generic.List`1<System.Collections.Generic.List`1<viperOSK.OSK_Key>>::.ctor()
IL_003d: stfld System.Collections.Generic.List`1<System.Collections.Generic.List`1<viperOSK.OSK_Key>> viperOSK.OSK_Keyboard::keyLayout
IL_0042: ldarg.0
IL_0043: ldstr "1 2 3 4 5 6 7 8 9 0 
 Q W E R T Y U I O P 
 A S D F G H J K L Exclaim 
 Z X C V B N M Period Backspace 
 LeftShift Space Return"
IL_0048: stfld System.String viperOSK.OSK_Keyboard::layout
IL_004d: ldarg.0
IL_004e: newobj System.Void System.Collections.Generic.List`1<viperOSK.OSK_SpecialKeys>::.ctor()
IL_0053: dup
IL_0054: ldc.i4.8
IL_0055: ldstr "«"
IL_005a: ldc.r4 0.93
IL_005f: ldc.r4 0.77
IL_0064: ldc.r4 0.22
IL_0069: newobj System.Void UnityEngine.Color::.ctor(System.Single,System.Single,System.Single)
IL_006e: ldc.r4 2
IL_0073: newobj System.Void viperOSK.OSK_SpecialKeys::.ctor(UnityEngine.KeyCode,System.String,UnityEngine.Color,System.Single)
IL_0078: callvirt System.Void System.Collections.Generic.List`1<viperOSK.OSK_SpecialKeys>::Add(!0)
IL_007d: dup
IL_007e: ldc.i4.s 13
IL_0080: ldstr "Send"
IL_0085: ldc.r4 0.21
IL_008a: ldc.r4 0.57
IL_008f: ldc.r4 0.74
IL_0094: newobj System.Void UnityEngine.Color::.ctor(System.Single,System.Single,System.Single)
IL_0099: ldc.r4 2
IL_009e: newobj System.Void viperOSK.OSK_SpecialKeys::.ctor(UnityEngine.KeyCode,System.String,UnityEngine.Color,System.Single)
IL_00a3: callvirt System.Void System.Collections.Generic.List`1<viperOSK.OSK_SpecialKeys>::Add(!0)
IL_00a8: dup
IL_00a9: ldc.i4 304
IL_00ae: ldstr "Shft"
IL_00b3: ldc.r4 0.93
IL_00b8: ldc.r4 0.77
IL_00bd: ldc.r4 0.22
IL_00c2: newobj System.Void UnityEngine.Color::.ctor(System.Single,System.Single,System.Single)
IL_00c7: ldc.r4 2
IL_00cc: newobj System.Void viperOSK.OSK_SpecialKeys::.ctor(UnityEngine.KeyCode,System.String,UnityEngine.Color,System.Single)
IL_00d1: callvirt System.Void System.Collections.Generic.List`1<viperOSK.OSK_SpecialKeys>::Add(!0)
IL_00d6: dup
IL_00d7: ldc.i4.s 32
IL_00d9: ldstr " "
IL_00de: ldc.r4 0.93
IL_00e3: ldc.r4 0.77
IL_00e8: ldc.r4 0.22
IL_00ed: newobj System.Void UnityEngine.Color::.ctor(System.Single,System.Single,System.Single)
IL_00f2: ldc.r4 4
IL_00f7: newobj System.Void viperOSK.OSK_SpecialKeys::.ctor(UnityEngine.KeyCode,System.String,UnityEngine.Color,System.Single)
IL_00fc: callvirt System.Void System.Collections.Generic.List`1<viperOSK.OSK_SpecialKeys>::Add(!0)
IL_0101: stfld System.Collections.Generic.List`1<viperOSK.OSK_SpecialKeys> viperOSK.OSK_Keyboard::specialKeys
IL_0106: ldarg.0
IL_0107: ldc.i4.4
IL_0108: newobj System.Void System.Collections.Generic.List`1<viperOSK.OSK_KeyTypeMeta>::.ctor(System.Int32)
IL_010d: dup
IL_010e: ldc.i4.0
IL_010f: ldc.r4 0.4
IL_0114: ldc.r4 0.4
IL_0119: ldc.r4 0.4
IL_011e: newobj System.Void UnityEngine.Color::.ctor(System.Single,System.Single,System.Single)
IL_0123: newobj System.Void viperOSK.OSK_KeyTypeMeta::.ctor(viperOSK.OSK_KEY_TYPES,UnityEngine.Color)
IL_0128: callvirt System.Void System.Collections.Generic.List`1<viperOSK.OSK_KeyTypeMeta>::Add(!0)
IL_012d: dup
IL_012e: ldc.i4.1
IL_012f: ldc.r4 0.35
IL_0134: ldc.r4 0.35
IL_0139: ldc.r4 0.35
IL_013e: newobj System.Void UnityEngine.Color::.ctor(System.Single,System.Single,System.Single)
IL_0143: newobj System.Void viperOSK.OSK_KeyTypeMeta::.ctor(viperOSK.OSK_KEY_TYPES,UnityEngine.Color)
IL_0148: callvirt System.Void System.Collections.Generic.List`1<viperOSK.OSK_KeyTypeMeta>::Add(!0)
IL_014d: dup
IL_014e: ldc.i4.2
IL_014f: ldc.r4 0.45
IL_0154: ldc.r4 0.45
IL_0159: ldc.r4 0.45
IL_015e: newobj System.Void UnityEngine.Color::.ctor(System.Single,System.Single,System.Single)
IL_0163: newobj System.Void viperOSK.OSK_KeyTypeMeta::.ctor(viperOSK.OSK_KEY_TYPES,UnityEngine.Color)
IL_0168: callvirt System.Void System.Collections.Generic.List`1<viperOSK.OSK_KeyTypeMeta>::Add(!0)
IL_016d: dup
IL_016e: ldc.i4.3
IL_016f: ldc.r4 0.55
IL_0174: ldc.r4 0.55
IL_0179: ldc.r4 0.55
IL_017e: newobj System.Void UnityEngine.Color::.ctor(System.Single,System.Single,System.Single)
IL_0183: newobj System.Void viperOSK.OSK_KeyTypeMeta::.ctor(viperOSK.OSK_KEY_TYPES,UnityEngine.Color)
IL_0188: callvirt System.Void System.Collections.Generic.List`1<viperOSK.OSK_KeyTypeMeta>::Add(!0)
IL_018d: stfld System.Collections.Generic.List`1<viperOSK.OSK_KeyTypeMeta> viperOSK.OSK_Keyboard::keyTypeMeta
IL_0192: ldarg.0
IL_0193: newobj System.Void System.Collections.Generic.Dictionary`2<UnityEngine.KeyCode,viperOSK.OSK_SpecialKeys>::.ctor()
IL_0198: stfld System.Collections.Generic.Dictionary`2<UnityEngine.KeyCode,viperOSK.OSK_SpecialKeys> viperOSK.OSK_Keyboard::keySounds
IL_019d: ldarg.0
IL_019e: newobj System.Void System.Collections.Generic.Dictionary`2<UnityEngine.KeyCode,viperOSK.OSK_Key>::.ctor()
IL_01a3: stfld System.Collections.Generic.Dictionary`2<UnityEngine.KeyCode,viperOSK.OSK_Key> viperOSK.OSK_Keyboard::keyDict
IL_01a8: ldarg.0
IL_01a9: call System.Void UnityEngine.MonoBehaviour::.ctor()
IL_01ae: ret
