TYPE viperOSK.OSK_Keyboard_TFOL
METHOD System.Void viperOSK.OSK_Keyboard_TFOL::Generate() | attributes=Public, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0006: callvirt !!0[] UnityEngine.Component::GetComponentsInChildren<viperOSK.OSK_Key>()
IL_000b: newobj System.Void System.Collections.Generic.Queue`1<viperOSK.OSK_Key>::.ctor(System.Collections.Generic.IEnumerable`1<!0>)
IL_0010: stloc.0
IL_0011: ldarg.0
IL_0012: ldfld System.Collections.Generic.Dictionary`2<UnityEngine.KeyCode,viperOSK.OSK_Key> viperOSK.OSK_Keyboard::keyDict
IL_0017: callvirt System.Void System.Collections.Generic.Dictionary`2<UnityEngine.KeyCode,viperOSK.OSK_Key>::Clear()
IL_001c: ldarg.0
IL_001d: ldfld System.Collections.Generic.Dictionary`2<UnityEngine.KeyCode,viperOSK.OSK_Key_TFOL> viperOSK.OSK_Keyboard_TFOL::keyDictTfolMirror
IL_0022: callvirt System.Void System.Collections.Generic.Dictionary`2<UnityEngine.KeyCode,viperOSK.OSK_Key_TFOL>::Clear()
IL_0027: ldarg.0
IL_0028: ldfld System.String viperOSK.OSK_Keyboard::layout
IL_002d: ldc.i4.1
IL_002e: newarr System.Char
IL_0033: dup
IL_0034: ldc.i4.0
IL_0035: ldc.i4.s 32
IL_0037: stelem.i2
IL_0038: callvirt System.String[] System.String::Split(System.Char[])
IL_003d: stloc.1
IL_003e: ldloca.s V_2
IL_0040: ldarg.0
IL_0041: ldflda UnityEngine.Vector3 viperOSK.OSK_Keyboard::keySize
IL_0046: ldfld System.Single UnityEngine.Vector3::x
IL_004b: ldarg.0
IL_004c: ldflda UnityEngine.Vector3 viperOSK.OSK_Keyboard::keySize
IL_0051: ldfld System.Single UnityEngine.Vector3::y
IL_0056: neg
IL_0057: ldarg.0
IL_0058: ldflda UnityEngine.Vector3 viperOSK.OSK_Keyboard::keySize
IL_005d: ldfld System.Single UnityEngine.Vector3::z
IL_0062: call System.Void UnityEngine.Vector3::.ctor(System.Single,System.Single,System.Single)
IL_0067: ldarg.0
IL_0068: ldfld UnityEngine.Transform viperOSK.OSK_Keyboard::topLeft
IL_006d: callvirt UnityEngine.Vector3 UnityEngine.Transform::get_localPosition()
IL_0072: stloc.3
IL_0073: ldc.i4.0
IL_0074: stloc.s V_4
IL_0076: ldc.i4.0
IL_0077: stloc.s V_5
IL_0079: ldarg.0
IL_007a: ldfld System.Collections.Generic.List`1<System.Collections.Generic.List`1<viperOSK.OSK_Key>> viperOSK.OSK_Keyboard::keyLayout
IL_007f: newobj System.Void System.Collections.Generic.List`1<viperOSK.OSK_Key>::.ctor()
IL_0084: callvirt System.Void System.Collections.Generic.List`1<System.Collections.Generic.List`1<viperOSK.OSK_Key>>::Add(!0)
IL_0089: ldarg.0
IL_008a: ldfld System.Collections.Generic.List`1<System.Collections.Generic.List`1<viperOSK.OSK_Key_TFOL>> viperOSK.OSK_Keyboard_TFOL::keyLayoutTfolMirror
IL_008f: newobj System.Void System.Collections.Generic.List`1<viperOSK.OSK_Key_TFOL>::.ctor()
IL_0094: callvirt System.Void System.Collections.Generic.List`1<System.Collections.Generic.List`1<viperOSK.OSK_Key_TFOL>>::Add(!0)
IL_0099: ldc.i4.0
IL_009a: stloc.s V_6
IL_009c: br IL_06b3
IL_00a1: ldloc.1
IL_00a2: ldloc.s V_6
IL_00a4: ldelem.ref
IL_00a5: ldc.i4.0
IL_00a6: callvirt System.Char System.String::get_Chars(System.Int32)
IL_00ab: ldc.i4.s 10
IL_00ad: bne.un.s IL_0105
IL_00af: ldloca.s V_3
IL_00b1: ldarg.0
IL_00b2: ldfld UnityEngine.Transform viperOSK.OSK_Keyboard::topLeft
IL_00b7: callvirt UnityEngine.Vector3 UnityEngine.Transform::get_localPosition()
IL_00bc: ldfld System.Single UnityEngine.Vector3::x
IL_00c1: stfld System.Single UnityEngine.Vector3::x
IL_00c6: ldloca.s V_3
IL_00c8: ldflda System.Single UnityEngine.Vector3::y
IL_00cd: dup
IL_00ce: ldind.r4
IL_00cf: ldloc.2
IL_00d0: ldfld System.Single UnityEngine.Vector3::y
IL_00d5: add
IL_00d6: stind.r4
IL_00d7: ldloc.s V_5
IL_00d9: ldc.i4.1
IL_00da: add
IL_00db: stloc.s V_5
IL_00dd: ldc.i4.0
IL_00de: stloc.s V_4
IL_00e0: ldarg.0
IL_00e1: ldfld System.Collections.Generic.List`1<System.Collections.Generic.List`1<viperOSK.OSK_Key>> viperOSK.OSK_Keyboard::keyLayout
IL_00e6: newobj System.Void System.Collections.Generic.List`1<viperOSK.OSK_Key>::.ctor()
IL_00eb: callvirt System.Void System.Collections.Generic.List`1<System.Collections.Generic.List`1<viperOSK.OSK_Key>>::Add(!0)
IL_00f0: ldarg.0
IL_00f1: ldfld System.Collections.Generic.List`1<System.Collections.Generic.List`1<viperOSK.OSK_Key_TFOL>> viperOSK.OSK_Keyboard_TFOL::keyLayoutTfolMirror
IL_00f6: newobj System.Void System.Collections.Generic.List`1<viperOSK.OSK_Key_TFOL>::.ctor()
IL_00fb: callvirt System.Void System.Collections.Generic.List`1<System.Collections.Generic.List`1<viperOSK.OSK_Key_TFOL>>::Add(!0)
IL_0100: br IL_06ad
IL_0105: ldloc.1
IL_0106: ldloc.s V_6
IL_0108: ldelem.ref
IL_0109: ldstr "Skip"
IL_010e: callvirt System.Boolean System.String::Contains(System.String)
IL_0113: brfalse IL_01a8
IL_0118: ldstr ""
IL_011d: ldloc.1
IL_011e: ldloc.s V_6
IL_0120: ldelem.ref
IL_0121: callvirt System.Char[] System.String::ToCharArray()
IL_0126: ldsfld System.Func`2<System.Char,System.Boolean> viperOSK.OSK_Keyboard_TFOL/<>c::<>9__18_0
IL_012b: dup
IL_012c: brtrue.s IL_0145
IL_012e: pop
IL_012f: ldsfld viperOSK.OSK_Keyboard_TFOL/<>c viperOSK.OSK_Keyboard_TFOL/<>c::<>9
IL_0134: ldftn System.Boolean viperOSK.OSK_Keyboard_TFOL/<>c::<Generate>b__18_0(System.Char)
IL_013a: newobj System.Void System.Func`2<System.Char,System.Boolean>::.ctor(System.Object,System.IntPtr)
IL_013f: dup
IL_0140: stsfld System.Func`2<System.Char,System.Boolean> viperOSK.OSK_Keyboard_TFOL/<>c::<>9__18_0
IL_0145: call System.Collections.Generic.IEnumerable`1<!!0> System.Linq.Enumerable::Where<System.Char>(System.Collections.Generic.IEnumerable`1<!!0>,System.Func`2<!!0,System.Boolean>)
IL_014a: call System.String System.String::Join<System.Char>(System.String,System.Collections.Generic.IEnumerable`1<!!0>)
IL_014f: stloc.s V_7
IL_0151: ldloc.s V_7
IL_0153: callvirt System.Int32 System.String::get_Length()
IL_0158: ldc.i4.0
IL_0159: ble IL_06ad
IL_015e: ldloc.s V_7
IL_0160: ldloca.s V_8
IL_0162: call System.Boolean System.Single::TryParse(System.String,System.Single&)
IL_0167: brfalse.s IL_018a
IL_0169: ldloca.s V_3
IL_016b: ldloc.3
IL_016c: ldfld System.Single UnityEngine.Vector3::x
IL_0171: ldarg.0
IL_0172: ldflda UnityEngine.Vector3 viperOSK.OSK_Keyboard::keySize
IL_0177: ldfld System.Single UnityEngine.Vector3::x
IL_017c: ldloc.s V_8
IL_017e: mul
IL_017f: add
IL_0180: stfld System.Single UnityEngine.Vector3::x
IL_0185: br IL_06ad
IL_018a: ldloca.s V_3
IL_018c: ldloc.3
IL_018d: ldfld System.Single UnityEngine.Vector3::x
IL_0192: ldarg.0
IL_0193: ldflda UnityEngine.Vector3 viperOSK.OSK_Keyboard::keySize
IL_0198: ldfld System.Single UnityEngine.Vector3::x
IL_019d: add
IL_019e: stfld System.Single UnityEngine.Vector3::x
IL_01a3: br IL_06ad
IL_01a8: ldloc.1
IL_01a9: ldloc.s V_6
IL_01ab: ldelem.ref
IL_01ac: callvirt System.Int32 System.String::get_Length()
IL_01b1: ldc.i4.1
IL_01b2: blt IL_06ad
IL_01b7: newobj System.Void viperOSK.OSK_Keyboard_TFOL/<>c__DisplayClass18_0::.ctor()
IL_01bc: stloc.s V_9
IL_01be: ldloc.0
IL_01bf: callvirt !0 System.Collections.Generic.Queue`1<viperOSK.OSK_Key>::Dequeue()
IL_01c4: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_01c9: stloc.s V_10
IL_01cb: ldloc.s V_10
IL_01cd: callvirt !!0 UnityEngine.GameObject::GetComponent<viperOSK.OSK_Key_TFOL>()
IL_01d2: stloc.s V_11
IL_01d4: ldarg.0
IL_01d5: ldfld TMPro.TMP_FontAsset viperOSK.OSK_Keyboard::keyFont
IL_01da: ldnull
IL_01db: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_01e0: brfalse.s IL_01ef
IL_01e2: ldloc.s V_11
IL_01e4: ldarg.0
IL_01e5: ldfld TMPro.TMP_FontAsset viperOSK.OSK_Keyboard::keyFont
IL_01ea: callvirt System.Void viperOSK.OSK_Key::KeyFont(TMPro.TMP_FontAsset)
IL_01ef: ldloc.s V_10
IL_01f1: ldloc.1
IL_01f2: ldloc.s V_6
IL_01f4: ldelem.ref
IL_01f5: callvirt System.Void UnityEngine.Object::set_name(System.String)
IL_01fa: ldstr ""
IL_01ff: stloc.s V_12
IL_0201: ldloc.1
IL_0202: ldloc.s V_6
IL_0204: ldelem.ref
IL_0205: ldc.i4.0
IL_0206: callvirt System.Char System.String::get_Chars(System.Int32)
IL_020b: ldc.i4.s 48
IL_020d: blt.s IL_0224
IL_020f: ldloc.1
IL_0210: ldloc.s V_6
IL_0212: ldelem.ref
IL_0213: ldc.i4.0
IL_0214: callvirt System.Char System.String::get_Chars(System.Int32)
IL_0219: ldc.i4.s 57
IL_021b: bgt.s IL_0224
IL_021d: ldstr "Alpha"
IL_0222: stloc.s V_12
IL_0224: ldloc.s V_9
IL_0226: ldc.i4.s 42
IL_0228: stfld UnityEngine.KeyCode viperOSK.OSK_Keyboard_TFOL/<>c__DisplayClass18_0::key
IL_022d: ldsfld System.Collections.Generic.Dictionary`2<System.String,UnityEngine.KeyCode> viperOSK.OSK_Keymap::chartoKeycode
IL_0232: ldloc.1
IL_0233: ldloc.s V_6
IL_0235: ldelem.ref
IL_0236: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,UnityEngine.KeyCode>::ContainsKey(!0)
IL_023b: brfalse.s IL_0254
IL_023d: ldloc.s V_9
IL_023f: ldsfld System.Collections.Generic.Dictionary`2<System.String,UnityEngine.KeyCode> viperOSK.OSK_Keymap::chartoKeycode
IL_0244: ldloc.1
IL_0245: ldloc.s V_6
IL_0247: ldelem.ref
IL_0248: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,UnityEngine.KeyCode>::get_Item(!0)
IL_024d: stfld UnityEngine.KeyCode viperOSK.OSK_Keyboard_TFOL/<>c__DisplayClass18_0::key
IL_0252: br.s IL_02a0
IL_0254: nop
IL_0255: ldloc.s V_9
IL_0257: ldtoken UnityEngine.KeyCode
IL_025c: call System.Type System.Type::GetTypeFromHandle(System.RuntimeTypeHandle)
IL_0261: ldloc.s V_12
IL_0263: ldloc.1
IL_0264: ldloc.s V_6
IL_0266: ldelem.ref
IL_0267: call System.String System.String::Concat(System.String,System.String)
IL_026c: call System.Object System.Enum::Parse(System.Type,System.String)
IL_0271: unbox.any UnityEngine.KeyCode
IL_0276: stfld UnityEngine.KeyCode viperOSK.OSK_Keyboard_TFOL/<>c__DisplayClass18_0::key
IL_027b: leave.s IL_02a0
IL_027d: stloc.s V_14
IL_027f: ldstr "OSK_Keyboard could not parse the layout for this text="
IL_0284: ldloc.1
IL_0285: ldloc.s V_6
IL_0287: ldelem.ref
IL_0288: ldstr " make sure you are using KeyCode names for the characters
Exception error: "
IL_028d: ldloc.s V_14
IL_028f: callvirt System.String System.Exception::get_Message()
IL_0294: call System.String System.String::Concat(System.String,System.String,System.String,System.String)
IL_0299: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_029e: leave.s IL_02a0
IL_02a0: ldarg.0
IL_02a1: ldfld System.Collections.Generic.List`1<viperOSK.OSK_SpecialKeys> viperOSK.OSK_Keyboard::specialKeys
IL_02a6: ldloc.s V_9
IL_02a8: ldftn System.Boolean viperOSK.OSK_Keyboard_TFOL/<>c__DisplayClass18_0::<Generate>b__1(viperOSK.OSK_SpecialKeys)
IL_02ae: newobj System.Void System.Predicate`1<viperOSK.OSK_SpecialKeys>::.ctor(System.Object,System.IntPtr)
IL_02b3: callvirt !0 System.Collections.Generic.List`1<viperOSK.OSK_SpecialKeys>::Find(System.Predicate`1<!0>)
IL_02b8: stloc.s V_13
IL_02ba: ldloc.s V_9
IL_02bc: ldloc.s V_11
IL_02be: ldfld viperOSK.OSK_KEY_TYPES viperOSK.OSK_Key::keyType
IL_02c3: stfld viperOSK.OSK_KEY_TYPES viperOSK.OSK_Keyboard_TFOL/<>c__DisplayClass18_0::keyType
IL_02c8: ldloc.s V_13
IL_02ca: brfalse IL_046a
IL_02cf: ldarg.0
IL_02d0: call UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_02d5: callvirt System.String UnityEngine.Object::get_name()
IL_02da: ldstr "KeyBoard (2.1)"
IL_02df: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_02e4: brfalse.s IL_0313
IL_02e6: ldstr "special key "
IL_02eb: ldloc.s V_9
IL_02ed: ldflda UnityEngine.KeyCode viperOSK.OSK_Keyboard_TFOL/<>c__DisplayClass18_0::key
IL_02f2: constrained. UnityEngine.KeyCode
IL_02f8: callvirt System.String System.Object::ToString()
IL_02fd: ldstr " named:"
IL_0302: ldloc.s V_13
IL_0304: ldfld System.String viperOSK.OSK_SpecialKeys::name
IL_0309: call System.String System.String::Concat(System.String,System.String,System.String,System.String)
IL_030e: call System.Void UnityEngine.Debug::Log(System.Object)
IL_0313: ldloc.s V_11
IL_0315: ldloc.s V_9
IL_0317: ldfld UnityEngine.KeyCode viperOSK.OSK_Keyboard_TFOL/<>c__DisplayClass18_0::key
IL_031c: ldloc.s V_9
IL_031e: ldfld viperOSK.OSK_KEY_TYPES viperOSK.OSK_Keyboard_TFOL/<>c__DisplayClass18_0::keyType
IL_0323: ldloc.s V_13
IL_0325: ldfld System.String viperOSK.OSK_SpecialKeys::name
IL_032a: callvirt System.Void viperOSK.OSK_Key::Assign(UnityEngine.KeyCode,viperOSK.OSK_KEY_TYPES,System.String)
IL_032f: ldloc.s V_11
IL_0331: ldloc.s V_11
IL_0333: ldfld UnityEngine.SpriteRenderer viperOSK.OSK_Key::bk
IL_0338: callvirt UnityEngine.Color UnityEngine.SpriteRenderer::get_color()
IL_033d: ldloc.s V_11
IL_033f: ldfld TMPro.TextMeshPro viperOSK.OSK_Key::keyName
IL_0344: callvirt UnityEngine.Color UnityEngine.UI.Graphic::get_color()
IL_0349: callvirt System.Void viperOSK.OSK_Key::SetColors(UnityEngine.Color,UnityEngine.Color)
IL_034e: ldarg.0
IL_034f: ldfld UnityEngine.Vector3 viperOSK.OSK_Keyboard::keySize
IL_0354: stloc.s V_15
IL_0356: ldloca.s V_15
IL_0358: ldflda System.Single UnityEngine.Vector3::x
IL_035d: dup
IL_035e: ldind.r4
IL_035f: ldloc.s V_13
IL_0361: ldfld System.Single viperOSK.OSK_SpecialKeys::x_size
IL_0366: mul
IL_0367: stind.r4
IL_0368: ldloc.s V_11
IL_036a: ldloc.s V_15
IL_036c: callvirt System.Void viperOSK.OSK_Key::BackScale(UnityEngine.Vector3)
IL_0371: ldloca.s V_3
IL_0373: ldloc.3
IL_0374: ldfld System.Single UnityEngine.Vector3::x
IL_0379: ldloc.s V_15
IL_037b: ldfld System.Single UnityEngine.Vector3::x
IL_0380: ldc.r4 0.5
IL_0385: mul
IL_0386: add
IL_0387: stfld System.Single UnityEngine.Vector3::x
IL_038c: ldloc.s V_10
IL_038e: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_0393: ldloc.3
IL_0394: callvirt System.Void UnityEngine.Transform::set_localPosition(UnityEngine.Vector3)
IL_0399: ldloca.s V_3
IL_039b: ldloc.3
IL_039c: ldfld System.Single UnityEngine.Vector3::x
IL_03a1: ldloc.s V_15
IL_03a3: ldfld System.Single UnityEngine.Vector3::x
IL_03a8: ldc.r4 0.5
IL_03ad: mul
IL_03ae: add
IL_03af: stfld System.Single UnityEngine.Vector3::x
IL_03b4: ldc.i4.0
IL_03b5: stloc.s V_16
IL_03b7: br.s IL_03ed
IL_03b9: ldarg.0
IL_03ba: ldfld System.Collections.Generic.List`1<System.Collections.Generic.List`1<viperOSK.OSK_Key>> viperOSK.OSK_Keyboard::keyLayout
IL_03bf: ldloc.s V_5
IL_03c1: callvirt !0 System.Collections.Generic.List`1<System.Collections.Generic.List`1<viperOSK.OSK_Key>>::get_Item(System.Int32)
IL_03c6: ldloc.s V_11
IL_03c8: callvirt System.Void System.Collections.Generic.List`1<viperOSK.OSK_Key>::Add(!0)
IL_03cd: ldarg.0
IL_03ce: ldfld System.Collections.Generic.List`1<System.Collections.Generic.List`1<viperOSK.OSK_Key_TFOL>> viperOSK.OSK_Keyboard_TFOL::keyLayoutTfolMirror
IL_03d3: ldloc.s V_5
IL_03d5: callvirt !0 System.Collections.Generic.List`1<System.Collections.Generic.List`1<viperOSK.OSK_Key_TFOL>>::get_Item(System.Int32)
IL_03da: ldloc.s V_11
IL_03dc: callvirt System.Void System.Collections.Generic.List`1<viperOSK.OSK_Key_TFOL>::Add(!0)
IL_03e1: ldloc.s V_4
IL_03e3: ldc.i4.1
IL_03e4: add
IL_03e5: stloc.s V_4
IL_03e7: ldloc.s V_16
IL_03e9: ldc.i4.1
IL_03ea: add
IL_03eb: stloc.s V_16
IL_03ed: ldloc.s V_16
IL_03ef: conv.r4
IL_03f0: ldloc.s V_13
IL_03f2: ldfld System.Single viperOSK.OSK_SpecialKeys::x_size
IL_03f7: blt.s IL_03b9
IL_03f9: ldloc.s V_13
IL_03fb: ldfld System.Int32 viperOSK.OSK_SpecialKeys::keySoundCode
IL_0400: ldc.i4.0
IL_0401: blt.s IL_042b
IL_0403: ldarg.0
IL_0404: ldfld System.Collections.Generic.Dictionary`2<UnityEngine.KeyCode,viperOSK.OSK_SpecialKeys> viperOSK.OSK_Keyboard::keySounds
IL_0409: ldloc.s V_9
IL_040b: ldfld UnityEngine.KeyCode viperOSK.OSK_Keyboard_TFOL/<>c__DisplayClass18_0::key
IL_0410: callvirt System.Boolean System.Collections.Generic.Dictionary`2<UnityEngine.KeyCode,viperOSK.OSK_SpecialKeys>::ContainsKey(!0)
IL_0415: brtrue.s IL_042b
IL_0417: ldarg.0
IL_0418: ldfld System.Collections.Generic.Dictionary`2<UnityEngine.KeyCode,viperOSK.OSK_SpecialKeys> viperOSK.OSK_Keyboard::keySounds
IL_041d: ldloc.s V_9
IL_041f: ldfld UnityEngine.KeyCode viperOSK.OSK_Keyboard_TFOL/<>c__DisplayClass18_0::key
IL_0424: ldloc.s V_13
IL_0426: callvirt System.Void System.Collections.Generic.Dictionary`2<UnityEngine.KeyCode,viperOSK.OSK_SpecialKeys>::Add(!0,!1)
IL_042b: ldloc.s V_13
IL_042d: ldfld UnityEngine.Events.UnityEvent`2<UnityEngine.KeyCode,viperOSK.OSK_KEY_TYPES> viperOSK.OSK_SpecialKeys::specialAction
IL_0432: callvirt System.Int32 UnityEngine.Events.UnityEventBase::GetPersistentEventCount()
IL_0437: brtrue.s IL_0457
IL_0439: ldloc.s V_11
IL_043b: ldfld UnityEngine.Events.UnityEvent`2<UnityEngine.KeyCode,viperOSK.OSK_KEY_TYPES> viperOSK.OSK_Key::callBack
IL_0440: ldarg.0
IL_0441: dup
IL_0442: ldvirtftn System.Void viperOSK.OSK_Keyboard::KeyCall(UnityEngine.KeyCode,viperOSK.OSK_KEY_TYPES)
IL_0448: newobj System.Void UnityEngine.Events.UnityAction`2<UnityEngine.KeyCode,viperOSK.OSK_KEY_TYPES>::.ctor(System.Object,System.IntPtr)
IL_044d: callvirt System.Void UnityEngine.Events.UnityEvent`2<UnityEngine.KeyCode,viperOSK.OSK_KEY_TYPES>::AddListener(UnityEngine.Events.UnityAction`2<!0,!1>)
IL_0452: br IL_0594
IL_0457: ldloc.s V_11
IL_0459: ldloc.s V_13
IL_045b: ldfld UnityEngine.Events.UnityEvent`2<UnityEngine.KeyCode,viperOSK.OSK_KEY_TYPES> viperOSK.OSK_SpecialKeys::specialAction
IL_0460: stfld UnityEngine.Events.UnityEvent`2<UnityEngine.KeyCode,viperOSK.OSK_KEY_TYPES> viperOSK.OSK_Key::callBack
IL_0465: br IL_0594
IL_046a: ldarg.0
IL_046b: call UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0470: callvirt System.String UnityEngine.Object::get_name()
IL_0475: ldstr "KeyBoard (2.1)"
IL_047a: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_047f: brfalse.s IL_04a2
IL_0481: ldstr "regular key "
IL_0486: ldloc.s V_9
IL_0488: ldflda UnityEngine.KeyCode viperOSK.OSK_Keyboard_TFOL/<>c__DisplayClass18_0::key
IL_048d: constrained. UnityEngine.KeyCode
IL_0493: callvirt System.String System.Object::ToString()
IL_0498: call System.String System.String::Concat(System.String,System.String)
IL_049d: call System.Void UnityEngine.Debug::Log(System.Object)
IL_04a2: ldloc.s V_11
IL_04a4: ldloc.s V_9
IL_04a6: ldfld UnityEngine.KeyCode viperOSK.OSK_Keyboard_TFOL/<>c__DisplayClass18_0::key
IL_04ab: ldloc.s V_9
IL_04ad: ldfld viperOSK.OSK_KEY_TYPES viperOSK.OSK_Keyboard_TFOL/<>c__DisplayClass18_0::keyType
IL_04b2: ldstr ""
IL_04b7: callvirt System.Void viperOSK.OSK_Key::Assign(UnityEngine.KeyCode,viperOSK.OSK_KEY_TYPES,System.String)
IL_04bc: ldarg.0
IL_04bd: ldfld System.Collections.Generic.List`1<viperOSK.OSK_KeyTypeMeta> viperOSK.OSK_Keyboard::keyTypeMeta
IL_04c2: ldloc.s V_9
IL_04c4: ldftn System.Boolean viperOSK.OSK_Keyboard_TFOL/<>c__DisplayClass18_0::<Generate>b__2(viperOSK.OSK_KeyTypeMeta)
IL_04ca: newobj System.Void System.Predicate`1<viperOSK.OSK_KeyTypeMeta>::.ctor(System.Object,System.IntPtr)
IL_04cf: callvirt !0 System.Collections.Generic.List`1<viperOSK.OSK_KeyTypeMeta>::Find(System.Predicate`1<!0>)
IL_04d4: brfalse.s IL_04f5
IL_04d6: ldloc.s V_11
IL_04d8: ldloc.s V_11
IL_04da: ldfld UnityEngine.SpriteRenderer viperOSK.OSK_Key::bk
IL_04df: callvirt UnityEngine.Color UnityEngine.SpriteRenderer::get_color()
IL_04e4: ldloc.s V_11
IL_04e6: ldfld TMPro.TextMeshPro viperOSK.OSK_Key::keyName
IL_04eb: callvirt UnityEngine.Color UnityEngine.UI.Graphic::get_color()
IL_04f0: callvirt System.Void viperOSK.OSK_Key::SetColors(UnityEngine.Color,UnityEngine.Color)
IL_04f5: ldloc.s V_11
IL_04f7: ldarg.0
IL_04f8: ldfld UnityEngine.Vector3 viperOSK.OSK_Keyboard::keySize
IL_04fd: callvirt System.Void viperOSK.OSK_Key::BackScale(UnityEngine.Vector3)
IL_0502: ldloca.s V_3
IL_0504: ldloc.3
IL_0505: ldfld System.Single UnityEngine.Vector3::x
IL_050a: ldarg.0
IL_050b: ldflda UnityEngine.Vector3 viperOSK.OSK_Keyboard::keySize
IL_0510: ldfld System.Single UnityEngine.Vector3::x
IL_0515: ldc.r4 0.5
IL_051a: mul
IL_051b: add
IL_051c: stfld System.Single UnityEngine.Vector3::x
IL_0521: ldloc.s V_10
IL_0523: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_0528: ldloc.3
IL_0529: callvirt System.Void UnityEngine.Transform::set_localPosition(UnityEngine.Vector3)
IL_052e: ldloca.s V_3
IL_0530: ldloc.3
IL_0531: ldfld System.Single UnityEngine.Vector3::x
IL_0536: ldarg.0
IL_0537: ldflda UnityEngine.Vector3 viperOSK.OSK_Keyboard::keySize
IL_053c: ldfld System.Single UnityEngine.Vector3::x
IL_0541: ldc.r4 0.5
IL_0546: mul
IL_0547: add
IL_0548: stfld System.Single UnityEngine.Vector3::x
IL_054d: ldarg.0
IL_054e: ldfld System.Collections.Generic.List`1<System.Collections.Generic.List`1<viperOSK.OSK_Key>> viperOSK.OSK_Keyboard::keyLayout
IL_0553: ldloc.s V_5
IL_0555: callvirt !0 System.Collections.Generic.List`1<System.Collections.Generic.List`1<viperOSK.OSK_Key>>::get_Item(System.Int32)
IL_055a: ldloc.s V_11
IL_055c: callvirt System.Void System.Collections.Generic.List`1<viperOSK.OSK_Key>::Add(!0)
IL_0561: ldarg.0
IL_0562: ldfld System.Collections.Generic.List`1<System.Collections.Generic.List`1<viperOSK.OSK_Key_TFOL>> viperOSK.OSK_Keyboard_TFOL::keyLayoutTfolMirror
IL_0567: ldloc.s V_5
IL_0569: callvirt !0 System.Collections.Generic.List`1<System.Collections.Generic.List`1<viperOSK.OSK_Key_TFOL>>::get_Item(System.Int32)
IL_056e: ldloc.s V_11
IL_0570: callvirt System.Void System.Collections.Generic.List`1<viperOSK.OSK_Key_TFOL>::Add(!0)
IL_0575: ldloc.s V_4
IL_0577: ldc.i4.1
IL_0578: add
IL_0579: stloc.s V_4
IL_057b: ldloc.s V_11
IL_057d: ldfld UnityEngine.Events.UnityEvent`2<UnityEngine.KeyCode,viperOSK.OSK_KEY_TYPES> viperOSK.OSK_Key::callBack
IL_0582: ldarg.0
IL_0583: dup
IL_0584: ldvirtftn System.Void viperOSK.OSK_Keyboard::KeyCall(UnityEngine.KeyCode,viperOSK.OSK_KEY_TYPES)
IL_058a: newobj System.Void UnityEngine.Events.UnityAction`2<UnityEngine.KeyCode,viperOSK.OSK_KEY_TYPES>::.ctor(System.Object,System.IntPtr)
IL_058f: callvirt System.Void UnityEngine.Events.UnityEvent`2<UnityEngine.KeyCode,viperOSK.OSK_KEY_TYPES>::AddListener(UnityEngine.Events.UnityAction`2<!0,!1>)
IL_0594: ldloc.s V_11
IL_0596: ldfld UnityEngine.KeyCode viperOSK.OSK_Key::key
IL_059b: ldc.i4.s 13
IL_059d: bne.un.s IL_05e8
IL_059f: ldloc.s V_11
IL_05a1: ldarg.0
IL_05a2: ldfld UnityEngine.Color viperOSK.OSK_Keyboard_TFOL::enterKeyFontColor
IL_05a7: callvirt System.Void viperOSK.OSK_Key_TFOL::set_textColor(UnityEngine.Color)
IL_05ac: ldloc.s V_11
IL_05ae: ldarg.0
IL_05af: ldfld UnityEngine.Color viperOSK.OSK_Keyboard_TFOL::enterKeyFontColorSelected
IL_05b4: callvirt System.Void viperOSK.OSK_Key_TFOL::set_textColorSelected(UnityEngine.Color)
IL_05b9: ldloc.s V_11
IL_05bb: ldloc.s V_11
IL_05bd: ldfld UnityEngine.SpriteRenderer viperOSK.OSK_Key::bk
IL_05c2: callvirt UnityEngine.Color UnityEngine.SpriteRenderer::get_color()
IL_05c7: callvirt System.Void viperOSK.OSK_Key_TFOL::set_bgColor(UnityEngine.Color)
IL_05cc: ldloc.s V_11
IL_05ce: ldarg.0
IL_05cf: ldfld UnityEngine.Color viperOSK.OSK_Keyboard::highlighterColor
IL_05d4: callvirt System.Void viperOSK.OSK_Key_TFOL::set_bgColorSelected(UnityEngine.Color)
IL_05d9: ldloc.s V_11
IL_05db: ldarg.0
IL_05dc: ldfld UnityEngine.Color viperOSK.OSK_Keyboard_TFOL::keyPressedColor
IL_05e1: callvirt System.Void viperOSK.OSK_Key_TFOL::set_bgColorPressed(UnityEngine.Color)
IL_05e6: br.s IL_063b
IL_05e8: ldloc.s V_11
IL_05ea: ldloc.s V_11
IL_05ec: ldfld TMPro.TextMeshPro viperOSK.OSK_Key::keyName
IL_05f1: callvirt UnityEngine.Color UnityEngine.UI.Graphic::get_color()
IL_05f6: callvirt System.Void viperOSK.OSK_Key_TFOL::set_textColor(UnityEngine.Color)
IL_05fb: ldloc.s V_11
IL_05fd: ldloc.s V_11
IL_05ff: ldfld TMPro.TextMeshPro viperOSK.OSK_Key::keyName
IL_0604: callvirt UnityEngine.Color UnityEngine.UI.Graphic::get_color()
IL_0609: callvirt System.Void viperOSK.OSK_Key_TFOL::set_textColorSelected(UnityEngine.Color)
IL_060e: ldloc.s V_11
IL_0610: ldloc.s V_11
IL_0612: ldfld UnityEngine.SpriteRenderer viperOSK.OSK_Key::bk
IL_0617: callvirt UnityEngine.Color UnityEngine.SpriteRenderer::get_color()
IL_061c: callvirt System.Void viperOSK.OSK_Key_TFOL::set_bgColor(UnityEngine.Color)
IL_0621: ldloc.s V_11
IL_0623: ldarg.0
IL_0624: ldfld UnityEngine.Color viperOSK.OSK_Keyboard::highlighterColor
IL_0629: callvirt System.Void viperOSK.OSK_Key_TFOL::set_bgColorSelected(UnityEngine.Color)
IL_062e: ldloc.s V_11
IL_0630: ldarg.0
IL_0631: ldfld UnityEngine.Color viperOSK.OSK_Keyboard_TFOL::keyPressedColor
IL_0636: callvirt System.Void viperOSK.OSK_Key_TFOL::set_bgColorPressed(UnityEngine.Color)
IL_063b: ldloc.s V_11
IL_063d: ldfld UnityEngine.KeyCode viperOSK.OSK_Key::key
IL_0642: ldc.i4 304
IL_0647: beq.s IL_0657
IL_0649: ldloc.s V_11
IL_064b: ldfld UnityEngine.KeyCode viperOSK.OSK_Key::key
IL_0650: ldc.i4 303
IL_0655: bne.un.s IL_066f
IL_0657: ldloc.s V_11
IL_0659: ldfld UnityEngine.Events.UnityEvent viperOSK.OSK_Key_TFOL::onClickShiftKey
IL_065e: ldarg.0
IL_065f: ldftn System.Void viperOSK.OSK_Keyboard_TFOL::SubmitShiftAsButton()
IL_0665: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_066a: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_066f: ldarg.0
IL_0670: ldfld System.Collections.Generic.Dictionary`2<UnityEngine.KeyCode,viperOSK.OSK_Key> viperOSK.OSK_Keyboard::keyDict
IL_0675: ldloc.s V_11
IL_0677: ldfld UnityEngine.KeyCode viperOSK.OSK_Key::key
IL_067c: ldloc.s V_11
IL_067e: callvirt System.Void System.Collections.Generic.Dictionary`2<UnityEngine.KeyCode,viperOSK.OSK_Key>::Add(!0,!1)
IL_0683: ldarg.0
IL_0684: ldfld System.Collections.Generic.Dictionary`2<UnityEngine.KeyCode,viperOSK.OSK_Key_TFOL> viperOSK.OSK_Keyboard_TFOL::keyDictTfolMirror
IL_0689: ldloc.s V_11
IL_068b: ldfld UnityEngine.KeyCode viperOSK.OSK_Key::key
IL_0690: ldloc.s V_11
IL_0692: callvirt System.Void System.Collections.Generic.Dictionary`2<UnityEngine.KeyCode,viperOSK.OSK_Key_TFOL>::Add(!0,!1)
IL_0697: call System.Boolean UnityEngine.Application::get_isEditor()
IL_069c: brfalse.s IL_06ad
IL_069e: ldarg.0
IL_069f: ldfld System.Boolean viperOSK.OSK_Keyboard::shift
IL_06a4: brfalse.s IL_06ad
IL_06a6: ldloc.s V_11
IL_06a8: callvirt System.Void viperOSK.OSK_Key::ShiftUp()
IL_06ad: ldloc.s V_6
IL_06af: ldc.i4.1
IL_06b0: add
IL_06b1: stloc.s V_6
IL_06b3: ldloc.s V_6
IL_06b5: ldloc.1
IL_06b6: ldlen
IL_06b7: conv.i4
IL_06b8: blt IL_00a1
IL_06bd: ldarg.0
IL_06be: ldfld viperOSK.OSK_Key_TFOL viperOSK.OSK_Keyboard_TFOL::doneKey
IL_06c3: ldnull
IL_06c4: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_06c9: brfalse.s IL_06dc
IL_06cb: ldarg.0
IL_06cc: ldfld viperOSK.OSK_Key_TFOL viperOSK.OSK_Keyboard_TFOL::doneKey
IL_06d1: ldarg.0
IL_06d2: ldfld UnityEngine.Color viperOSK.OSK_Keyboard_TFOL::enterKeyFontColorSelected
IL_06d7: callvirt System.Void viperOSK.OSK_Key_TFOL::set_textColorSelected(UnityEngine.Color)
IL_06dc: call System.Boolean UnityEngine.Application::get_isPlaying()
IL_06e1: brfalse.s IL_0703
IL_06e3: ldarg.0
IL_06e4: ldfld System.Boolean viperOSK.OSK_Keyboard::shift
IL_06e9: brfalse.s IL_06f8
IL_06eb: ldarg.0
IL_06ec: ldstr "ShiftUp"
IL_06f1: call System.Void UnityEngine.Component::BroadcastMessage(System.String)
IL_06f6: br.s IL_0703
IL_06f8: ldarg.0
IL_06f9: ldstr "ShiftDown"
IL_06fe: call System.Void UnityEngine.Component::BroadcastMessage(System.String)
IL_0703: ldarg.0
IL_0704: call System.Void viperOSK.OSK_Keyboard_TFOL::SelectDefaultKey()
IL_0709: ret
METHOD System.Void viperOSK.OSK_Keyboard_TFOL::ShiftUp() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Boolean viperOSK.OSK_Keyboard::shift
IL_0006: brfalse.s IL_0009
IL_0008: ret
IL_0009: ldarg.0
IL_000a: ldc.i4.1
IL_000b: stfld System.Boolean viperOSK.OSK_Keyboard::shift
IL_0010: ldarg.0
IL_0011: ldstr "ShiftUp"
IL_0016: call System.Void UnityEngine.Component::BroadcastMessage(System.String)
IL_001b: ret
METHOD System.Void viperOSK.OSK_Keyboard_TFOL::ShiftDown() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Boolean viperOSK.OSK_Keyboard::shift
IL_0006: brtrue.s IL_0009
IL_0008: ret
IL_0009: ldarg.0
IL_000a: ldc.i4.0
IL_000b: stfld System.Boolean viperOSK.OSK_Keyboard::shift
IL_0010: ldarg.0
IL_0011: ldstr "ShiftDown"
IL_0016: call System.Void UnityEngine.Component::BroadcastMessage(System.String)
IL_001b: ret
