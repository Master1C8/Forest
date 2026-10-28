TYPE viperOSK.OSK_UI_Keyboard
METHOD System.Void viperOSK.OSK_UI_Keyboard::Prep() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.0
IL_0002: ldfld System.Boolean viperOSK.OSK_UI_Keyboard::acceptPhysicalKeyboard
IL_0007: call System.Void viperOSK.OSK_UI_Keyboard::AcceptPhysicalKeyboard(System.Boolean)
IL_000c: ldarg.0
IL_000d: ldfld viperOSK.OSK_Receiver viperOSK.OSK_UI_Keyboard::output
IL_0012: ldnull
IL_0013: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0018: brfalse.s IL_0025
IL_001a: ldarg.0
IL_001b: ldfld viperOSK.OSK_Receiver viperOSK.OSK_UI_Keyboard::output
IL_0020: callvirt System.Void viperOSK.OSK_Receiver::OnFocus()
IL_0025: ldarg.0
IL_0026: call !!0 UnityEngine.Component::GetComponent<viperOSK.OSK_KeySounds>()
IL_002b: stloc.0
IL_002c: ldloc.0
IL_002d: ldnull
IL_002e: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0033: brfalse.s IL_0057
IL_0035: ldarg.0
IL_0036: ldarg.0
IL_0037: ldfld System.Action`1<System.Int32> viperOSK.OSK_UI_Keyboard::sound
IL_003c: ldloc.0
IL_003d: ldftn System.Void viperOSK.OSK_KeySounds::PlaySound(System.Int32)
IL_0043: newobj System.Void System.Action`1<System.Int32>::.ctor(System.Object,System.IntPtr)
IL_0048: call System.Delegate System.Delegate::Combine(System.Delegate,System.Delegate)
IL_004d: castclass System.Action`1<System.Int32>
IL_0052: stfld System.Action`1<System.Int32> viperOSK.OSK_UI_Keyboard::sound
IL_0057: ldarg.0
IL_0058: ldstr "TextUpdate"
IL_005d: ldc.r4 1
IL_0062: ldc.r4 1
IL_0067: call System.Void UnityEngine.MonoBehaviour::InvokeRepeating(System.String,System.Single,System.Single)
IL_006c: ret
METHOD System.Void viperOSK.OSK_UI_Keyboard::TextUpdate() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldstr ""
IL_0006: call System.Void viperOSK.OSK_UI_Keyboard::OutputTextUpdate(System.String)
IL_000b: ret
METHOD System.Void viperOSK.OSK_UI_Keyboard::Generate() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0006: callvirt !!0[] UnityEngine.Component::GetComponentsInChildren<viperOSK.OSK_UI_Key>()
IL_000b: stloc.0
IL_000c: ldloc.0
IL_000d: ldlen
IL_000e: brfalse.s IL_0035
IL_0010: ldloc.0
IL_0011: stloc.s V_7
IL_0013: ldc.i4.0
IL_0014: stloc.s V_8
IL_0016: br.s IL_002d
IL_0018: ldloc.s V_7
IL_001a: ldloc.s V_8
IL_001c: ldelem.ref
IL_001d: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0022: call System.Void UnityEngine.Object::DestroyImmediate(UnityEngine.Object)
IL_0027: ldloc.s V_8
IL_0029: ldc.i4.1
IL_002a: add
IL_002b: stloc.s V_8
IL_002d: ldloc.s V_8
IL_002f: ldloc.s V_7
IL_0031: ldlen
IL_0032: conv.i4
IL_0033: blt.s IL_0018
IL_0035: ldarg.0
IL_0036: ldfld System.Collections.Generic.Dictionary`2<UnityEngine.KeyCode,viperOSK.OSK_UI_Key> viperOSK.OSK_UI_Keyboard::keyDict
IL_003b: callvirt System.Void System.Collections.Generic.Dictionary`2<UnityEngine.KeyCode,viperOSK.OSK_UI_Key>::Clear()
IL_0040: ldarg.0
IL_0041: ldfld System.String viperOSK.OSK_UI_Keyboard::layout
IL_0046: ldc.i4.1
IL_0047: newarr System.Char
IL_004c: dup
IL_004d: ldc.i4.0
IL_004e: ldc.i4.s 32
IL_0050: stelem.i2
IL_0051: callvirt System.String[] System.String::Split(System.Char[])
IL_0056: stloc.1
IL_0057: ldarg.0
IL_0058: ldfld UnityEngine.GameObject viperOSK.OSK_UI_Keyboard::KeyPrefab
IL_005d: callvirt !!0 UnityEngine.GameObject::GetComponent<UnityEngine.RectTransform>()
IL_0062: stloc.2
IL_0063: ldloca.s V_3
IL_0065: ldarg.0
IL_0066: ldflda UnityEngine.Vector3 viperOSK.OSK_UI_Keyboard::keySize
IL_006b: ldfld System.Single UnityEngine.Vector3::x
IL_0070: ldloc.2
IL_0071: callvirt UnityEngine.Rect UnityEngine.RectTransform::get_rect()
IL_0076: stloc.s V_9
IL_0078: ldloca.s V_9
IL_007a: call System.Single UnityEngine.Rect::get_width()
IL_007f: mul
IL_0080: ldarg.0
IL_0081: ldflda UnityEngine.Vector3 viperOSK.OSK_UI_Keyboard::keySize
IL_0086: ldfld System.Single UnityEngine.Vector3::y
IL_008b: ldloc.2
IL_008c: callvirt UnityEngine.Rect UnityEngine.RectTransform::get_rect()
IL_0091: stloc.s V_9
IL_0093: ldloca.s V_9
IL_0095: call System.Single UnityEngine.Rect::get_height()
IL_009a: mul
IL_009b: ldarg.0
IL_009c: ldflda UnityEngine.Vector3 viperOSK.OSK_UI_Keyboard::keySize
IL_00a1: ldfld System.Single UnityEngine.Vector3::z
IL_00a6: call System.Void UnityEngine.Vector3::.ctor(System.Single,System.Single,System.Single)
IL_00ab: ldarg.0
IL_00ac: ldfld UnityEngine.Transform viperOSK.OSK_UI_Keyboard::topLeft
IL_00b1: callvirt UnityEngine.Vector3 UnityEngine.Transform::get_localPosition()
IL_00b6: stloc.s V_4
IL_00b8: ldc.i4.0
IL_00b9: stloc.s V_5
IL_00bb: ldc.i4.0
IL_00bc: stloc.s V_6
IL_00be: ldarg.0
IL_00bf: ldfld System.Collections.Generic.List`1<System.Collections.Generic.List`1<viperOSK.OSK_UI_Key>> viperOSK.OSK_UI_Keyboard::keyLayout
IL_00c4: newobj System.Void System.Collections.Generic.List`1<viperOSK.OSK_UI_Key>::.ctor()
IL_00c9: callvirt System.Void System.Collections.Generic.List`1<System.Collections.Generic.List`1<viperOSK.OSK_UI_Key>>::Add(!0)
IL_00ce: ldc.i4.0
IL_00cf: stloc.s V_10
IL_00d1: br IL_0598
IL_00d6: ldloc.1
IL_00d7: ldloc.s V_10
IL_00d9: ldelem.ref
IL_00da: ldc.i4.0
IL_00db: callvirt System.Char System.String::get_Chars(System.Int32)
IL_00e0: ldc.i4.s 10
IL_00e2: bne.un.s IL_012a
IL_00e4: ldloca.s V_4
IL_00e6: ldarg.0
IL_00e7: ldfld UnityEngine.Transform viperOSK.OSK_UI_Keyboard::topLeft
IL_00ec: callvirt UnityEngine.Vector3 UnityEngine.Transform::get_localPosition()
IL_00f1: ldfld System.Single UnityEngine.Vector3::x
IL_00f6: stfld System.Single UnityEngine.Vector3::x
IL_00fb: ldloca.s V_4
IL_00fd: ldflda System.Single UnityEngine.Vector3::y
IL_0102: dup
IL_0103: ldind.r4
IL_0104: ldloc.3
IL_0105: ldfld System.Single UnityEngine.Vector3::y
IL_010a: sub
IL_010b: stind.r4
IL_010c: ldloc.s V_6
IL_010e: ldc.i4.1
IL_010f: add
IL_0110: stloc.s V_6
IL_0112: ldc.i4.0
IL_0113: stloc.s V_5
IL_0115: ldarg.0
IL_0116: ldfld System.Collections.Generic.List`1<System.Collections.Generic.List`1<viperOSK.OSK_UI_Key>> viperOSK.OSK_UI_Keyboard::keyLayout
IL_011b: newobj System.Void System.Collections.Generic.List`1<viperOSK.OSK_UI_Key>::.ctor()
IL_0120: callvirt System.Void System.Collections.Generic.List`1<System.Collections.Generic.List`1<viperOSK.OSK_UI_Key>>::Add(!0)
IL_0125: br IL_0592
IL_012a: ldloc.1
IL_012b: ldloc.s V_10
IL_012d: ldelem.ref
IL_012e: ldstr "Skip"
IL_0133: callvirt System.Boolean System.String::Contains(System.String)
IL_0138: brfalse IL_01c5
IL_013d: ldstr ""
IL_0142: ldloc.1
IL_0143: ldloc.s V_10
IL_0145: ldelem.ref
IL_0146: callvirt System.Char[] System.String::ToCharArray()
IL_014b: ldsfld System.Func`2<System.Char,System.Boolean> viperOSK.OSK_UI_Keyboard/<>c::<>9__33_0
IL_0150: dup
IL_0151: brtrue.s IL_016a
IL_0153: pop
IL_0154: ldsfld viperOSK.OSK_UI_Keyboard/<>c viperOSK.OSK_UI_Keyboard/<>c::<>9
IL_0159: ldftn System.Boolean viperOSK.OSK_UI_Keyboard/<>c::<Generate>b__33_0(System.Char)
IL_015f: newobj System.Void System.Func`2<System.Char,System.Boolean>::.ctor(System.Object,System.IntPtr)
IL_0164: dup
IL_0165: stsfld System.Func`2<System.Char,System.Boolean> viperOSK.OSK_UI_Keyboard/<>c::<>9__33_0
IL_016a: call System.Collections.Generic.IEnumerable`1<!!0> System.Linq.Enumerable::Where<System.Char>(System.Collections.Generic.IEnumerable`1<!!0>,System.Func`2<!!0,System.Boolean>)
IL_016f: call System.String System.String::Join<System.Char>(System.String,System.Collections.Generic.IEnumerable`1<!!0>)
IL_0174: stloc.s V_11
IL_0176: ldloc.s V_11
IL_0178: callvirt System.Int32 System.String::get_Length()
IL_017d: ldc.i4.0
IL_017e: ble IL_0592
IL_0183: ldloc.s V_11
IL_0185: ldloca.s V_12
IL_0187: call System.Boolean System.Single::TryParse(System.String,System.Single&)
IL_018c: brfalse.s IL_01ab
IL_018e: ldloca.s V_4
IL_0190: ldloc.s V_4
IL_0192: ldfld System.Single UnityEngine.Vector3::x
IL_0197: ldloc.3
IL_0198: ldfld System.Single UnityEngine.Vector3::x
IL_019d: ldloc.s V_12
IL_019f: mul
IL_01a0: add
IL_01a1: stfld System.Single UnityEngine.Vector3::x
IL_01a6: br IL_0592
IL_01ab: ldloca.s V_4
IL_01ad: ldloc.s V_4
IL_01af: ldfld System.Single UnityEngine.Vector3::x
IL_01b4: ldloc.3
IL_01b5: ldfld System.Single UnityEngine.Vector3::x
IL_01ba: add
IL_01bb: stfld System.Single UnityEngine.Vector3::x
IL_01c0: br IL_0592
IL_01c5: ldloc.1
IL_01c6: ldloc.s V_10
IL_01c8: ldelem.ref
IL_01c9: callvirt System.Int32 System.String::get_Length()
IL_01ce: ldc.i4.1
IL_01cf: blt IL_0592
IL_01d4: newobj System.Void viperOSK.OSK_UI_Keyboard/<>c__DisplayClass33_0::.ctor()
IL_01d9: stloc.s V_13
IL_01db: ldarg.0
IL_01dc: ldfld UnityEngine.GameObject viperOSK.OSK_UI_Keyboard::KeyPrefab
IL_01e1: ldarg.0
IL_01e2: call UnityEngine.Transform UnityEngine.Component::get_transform()
IL_01e7: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_01ec: dup
IL_01ed: callvirt !!0 UnityEngine.GameObject::GetComponent<UnityEngine.RectTransform>()
IL_01f2: stloc.2
IL_01f3: dup
IL_01f4: callvirt !!0 UnityEngine.GameObject::GetComponent<viperOSK.OSK_UI_Key>()
IL_01f9: stloc.s V_14
IL_01fb: ldarg.0
IL_01fc: ldfld TMPro.TMP_FontAsset viperOSK.OSK_UI_Keyboard::keyFont
IL_0201: ldnull
IL_0202: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0207: brfalse.s IL_0216
IL_0209: ldloc.s V_14
IL_020b: ldarg.0
IL_020c: ldfld TMPro.TMP_FontAsset viperOSK.OSK_UI_Keyboard::keyFont
IL_0211: callvirt System.Void viperOSK.OSK_UI_Key::KeyFont(TMPro.TMP_FontAsset)
IL_0216: ldloc.1
IL_0217: ldloc.s V_10
IL_0219: ldelem.ref
IL_021a: callvirt System.Void UnityEngine.Object::set_name(System.String)
IL_021f: ldstr ""
IL_0224: stloc.s V_15
IL_0226: ldloc.1
IL_0227: ldloc.s V_10
IL_0229: ldelem.ref
IL_022a: ldc.i4.0
IL_022b: callvirt System.Char System.String::get_Chars(System.Int32)
IL_0230: ldc.i4.s 48
IL_0232: blt.s IL_0249
IL_0234: ldloc.1
IL_0235: ldloc.s V_10
IL_0237: ldelem.ref
IL_0238: ldc.i4.0
IL_0239: callvirt System.Char System.String::get_Chars(System.Int32)
IL_023e: ldc.i4.s 57
IL_0240: bgt.s IL_0249
IL_0242: ldstr "Alpha"
IL_0247: stloc.s V_15
IL_0249: ldloc.s V_13
IL_024b: ldc.i4.s 42
IL_024d: stfld UnityEngine.KeyCode viperOSK.OSK_UI_Keyboard/<>c__DisplayClass33_0::key
IL_0252: ldsfld System.Collections.Generic.Dictionary`2<System.String,UnityEngine.KeyCode> viperOSK.OSK_Keymap::chartoKeycode
IL_0257: ldloc.1
IL_0258: ldloc.s V_10
IL_025a: ldelem.ref
IL_025b: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,UnityEngine.KeyCode>::ContainsKey(!0)
IL_0260: brfalse.s IL_0279
IL_0262: ldloc.s V_13
IL_0264: ldsfld System.Collections.Generic.Dictionary`2<System.String,UnityEngine.KeyCode> viperOSK.OSK_Keymap::chartoKeycode
IL_0269: ldloc.1
IL_026a: ldloc.s V_10
IL_026c: ldelem.ref
IL_026d: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,UnityEngine.KeyCode>::get_Item(!0)
IL_0272: stfld UnityEngine.KeyCode viperOSK.OSK_UI_Keyboard/<>c__DisplayClass33_0::key
IL_0277: br.s IL_02c5
IL_0279: nop
IL_027a: ldloc.s V_13
IL_027c: ldtoken UnityEngine.KeyCode
IL_0281: call System.Type System.Type::GetTypeFromHandle(System.RuntimeTypeHandle)
IL_0286: ldloc.s V_15
IL_0288: ldloc.1
IL_0289: ldloc.s V_10
IL_028b: ldelem.ref
IL_028c: call System.String System.String::Concat(System.String,System.String)
IL_0291: call System.Object System.Enum::Parse(System.Type,System.String)
IL_0296: unbox.any UnityEngine.KeyCode
IL_029b: stfld UnityEngine.KeyCode viperOSK.OSK_UI_Keyboard/<>c__DisplayClass33_0::key
IL_02a0: leave.s IL_02c5
IL_02a2: stloc.s V_17
IL_02a4: ldstr "OSK_Keyboard could not parse the layout for this text="
IL_02a9: ldloc.1
IL_02aa: ldloc.s V_10
IL_02ac: ldelem.ref
IL_02ad: ldstr " make sure you are using KeyCode names for the characters
Exception error: "
IL_02b2: ldloc.s V_17
IL_02b4: callvirt System.String System.Exception::get_Message()
IL_02b9: call System.String System.String::Concat(System.String,System.String,System.String,System.String)
IL_02be: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_02c3: leave.s IL_02c5
IL_02c5: ldarg.0
IL_02c6: ldfld System.Collections.Generic.List`1<viperOSK.OSK_SpecialKeys> viperOSK.OSK_UI_Keyboard::specialKeys
IL_02cb: ldloc.s V_13
IL_02cd: ldftn System.Boolean viperOSK.OSK_UI_Keyboard/<>c__DisplayClass33_0::<Generate>b__1(viperOSK.OSK_SpecialKeys)
IL_02d3: newobj System.Void System.Predicate`1<viperOSK.OSK_SpecialKeys>::.ctor(System.Object,System.IntPtr)
IL_02d8: callvirt !0 System.Collections.Generic.List`1<viperOSK.OSK_SpecialKeys>::Find(System.Predicate`1<!0>)
IL_02dd: stloc.s V_16
IL_02df: ldloc.s V_13
IL_02e1: ldloc.s V_13
IL_02e3: ldfld UnityEngine.KeyCode viperOSK.OSK_UI_Keyboard/<>c__DisplayClass33_0::key
IL_02e8: call viperOSK.OSK_KEY_TYPES viperOSK.OSK_KeyTypeMeta::KeyType(UnityEngine.KeyCode)
IL_02ed: stfld viperOSK.OSK_KEY_TYPES viperOSK.OSK_UI_Keyboard/<>c__DisplayClass33_0::keyType
IL_02f2: ldloc.s V_16
IL_02f4: brfalse IL_046c
IL_02f9: ldarg.0
IL_02fa: call UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_02ff: callvirt System.String UnityEngine.Object::get_name()
IL_0304: ldstr "KeyBoard (2.1)"
IL_0309: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_030e: brfalse.s IL_033d
IL_0310: ldstr "special key "
IL_0315: ldloc.s V_13
IL_0317: ldflda UnityEngine.KeyCode viperOSK.OSK_UI_Keyboard/<>c__DisplayClass33_0::key
IL_031c: constrained. UnityEngine.KeyCode
IL_0322: callvirt System.String System.Object::ToString()
IL_0327: ldstr " named:"
IL_032c: ldloc.s V_16
IL_032e: ldfld System.String viperOSK.OSK_SpecialKeys::name
IL_0333: call System.String System.String::Concat(System.String,System.String,System.String,System.String)
IL_0338: call System.Void UnityEngine.Debug::Log(System.Object)
IL_033d: ldloc.s V_14
IL_033f: ldloc.s V_13
IL_0341: ldfld UnityEngine.KeyCode viperOSK.OSK_UI_Keyboard/<>c__DisplayClass33_0::key
IL_0346: ldloc.s V_13
IL_0348: ldfld viperOSK.OSK_KEY_TYPES viperOSK.OSK_UI_Keyboard/<>c__DisplayClass33_0::keyType
IL_034d: ldloc.s V_16
IL_034f: ldfld System.String viperOSK.OSK_SpecialKeys::name
IL_0354: callvirt System.Void viperOSK.OSK_UI_Key::Assign(UnityEngine.KeyCode,viperOSK.OSK_KEY_TYPES,System.String)
IL_0359: ldloc.s V_14
IL_035b: ldloc.s V_16
IL_035d: ldfld UnityEngine.Color viperOSK.OSK_SpecialKeys::col
IL_0362: ldarg.0
IL_0363: ldfld UnityEngine.Color viperOSK.OSK_UI_Keyboard::keyLabelColor
IL_0368: callvirt System.Void viperOSK.OSK_UI_Key::SetColors(UnityEngine.Color,UnityEngine.Color)
IL_036d: ldloc.3
IL_036e: stloc.s V_18
IL_0370: ldloca.s V_18
IL_0372: ldflda System.Single UnityEngine.Vector3::x
IL_0377: dup
IL_0378: ldind.r4
IL_0379: ldloc.s V_16
IL_037b: ldfld System.Single viperOSK.OSK_SpecialKeys::x_size
IL_0380: mul
IL_0381: stind.r4
IL_0382: ldloc.s V_14
IL_0384: ldloc.s V_18
IL_0386: callvirt System.Void viperOSK.OSK_UI_Key::BackScale(UnityEngine.Vector3)
IL_038b: ldloca.s V_4
IL_038d: ldloc.s V_4
IL_038f: ldfld System.Single UnityEngine.Vector3::x
IL_0394: ldloc.s V_18
IL_0396: ldfld System.Single UnityEngine.Vector3::x
IL_039b: ldc.r4 0.5
IL_03a0: mul
IL_03a1: add
IL_03a2: stfld System.Single UnityEngine.Vector3::x
IL_03a7: ldloc.2
IL_03a8: ldloc.s V_4
IL_03aa: callvirt System.Void UnityEngine.Transform::set_localPosition(UnityEngine.Vector3)
IL_03af: ldloca.s V_4
IL_03b1: ldloc.s V_4
IL_03b3: ldfld System.Single UnityEngine.Vector3::x
IL_03b8: ldloc.s V_18
IL_03ba: ldfld System.Single UnityEngine.Vector3::x
IL_03bf: ldc.r4 0.5
IL_03c4: mul
IL_03c5: add
IL_03c6: stfld System.Single UnityEngine.Vector3::x
IL_03cb: ldc.i4.0
IL_03cc: stloc.s V_19
IL_03ce: br.s IL_03f0
IL_03d0: ldarg.0
IL_03d1: ldfld System.Collections.Generic.List`1<System.Collections.Generic.List`1<viperOSK.OSK_UI_Key>> viperOSK.OSK_UI_Keyboard::keyLayout
IL_03d6: ldloc.s V_6
IL_03d8: callvirt !0 System.Collections.Generic.List`1<System.Collections.Generic.List`1<viperOSK.OSK_UI_Key>>::get_Item(System.Int32)
IL_03dd: ldloc.s V_14
IL_03df: callvirt System.Void System.Collections.Generic.List`1<viperOSK.OSK_UI_Key>::Add(!0)
IL_03e4: ldloc.s V_5
IL_03e6: ldc.i4.1
IL_03e7: add
IL_03e8: stloc.s V_5
IL_03ea: ldloc.s V_19
IL_03ec: ldc.i4.1
IL_03ed: add
IL_03ee: stloc.s V_19
IL_03f0: ldloc.s V_19
IL_03f2: conv.r4
IL_03f3: ldloc.s V_16
IL_03f5: ldfld System.Single viperOSK.OSK_SpecialKeys::x_size
IL_03fa: blt.s IL_03d0
IL_03fc: ldloc.s V_16
IL_03fe: ldfld System.Int32 viperOSK.OSK_SpecialKeys::keySoundCode
IL_0403: ldc.i4.0
IL_0404: blt.s IL_042e
IL_0406: ldarg.0
IL_0407: ldfld System.Collections.Generic.Dictionary`2<UnityEngine.KeyCode,viperOSK.OSK_SpecialKeys> viperOSK.OSK_UI_Keyboard::keySounds
IL_040c: ldloc.s V_13
IL_040e: ldfld UnityEngine.KeyCode viperOSK.OSK_UI_Keyboard/<>c__DisplayClass33_0::key
IL_0413: callvirt System.Boolean System.Collections.Generic.Dictionary`2<UnityEngine.KeyCode,viperOSK.OSK_SpecialKeys>::ContainsKey(!0)
IL_0418: brtrue.s IL_042e
IL_041a: ldarg.0
IL_041b: ldfld System.Collections.Generic.Dictionary`2<UnityEngine.KeyCode,viperOSK.OSK_SpecialKeys> viperOSK.OSK_UI_Keyboard::keySounds
IL_0420: ldloc.s V_13
IL_0422: ldfld UnityEngine.KeyCode viperOSK.OSK_UI_Keyboard/<>c__DisplayClass33_0::key
IL_0427: ldloc.s V_16
IL_0429: callvirt System.Void System.Collections.Generic.Dictionary`2<UnityEngine.KeyCode,viperOSK.OSK_SpecialKeys>::Add(!0,!1)
IL_042e: ldloc.s V_16
IL_0430: ldfld UnityEngine.Events.UnityEvent`2<UnityEngine.KeyCode,viperOSK.OSK_KEY_TYPES> viperOSK.OSK_SpecialKeys::specialAction
IL_0435: callvirt System.Int32 UnityEngine.Events.UnityEventBase::GetPersistentEventCount()
IL_043a: brtrue.s IL_0459
IL_043c: ldloc.s V_14
IL_043e: ldfld UnityEngine.Events.UnityEvent`2<UnityEngine.KeyCode,viperOSK.OSK_KEY_TYPES> viperOSK.OSK_UI_Key::callBack
IL_0443: ldarg.0
IL_0444: ldftn System.Void viperOSK.OSK_UI_Keyboard::KeyCall(UnityEngine.KeyCode,viperOSK.OSK_KEY_TYPES)
IL_044a: newobj System.Void UnityEngine.Events.UnityAction`2<UnityEngine.KeyCode,viperOSK.OSK_KEY_TYPES>::.ctor(System.Object,System.IntPtr)
IL_044f: callvirt System.Void UnityEngine.Events.UnityEvent`2<UnityEngine.KeyCode,viperOSK.OSK_KEY_TYPES>::AddListener(UnityEngine.Events.UnityAction`2<!0,!1>)
IL_0454: br IL_0568
IL_0459: ldloc.s V_14
IL_045b: ldloc.s V_16
IL_045d: ldfld UnityEngine.Events.UnityEvent`2<UnityEngine.KeyCode,viperOSK.OSK_KEY_TYPES> viperOSK.OSK_SpecialKeys::specialAction
IL_0462: stfld UnityEngine.Events.UnityEvent`2<UnityEngine.KeyCode,viperOSK.OSK_KEY_TYPES> viperOSK.OSK_UI_Key::callBack
IL_0467: br IL_0568
IL_046c: ldarg.0
IL_046d: call UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0472: callvirt System.String UnityEngine.Object::get_name()
IL_0477: ldstr "KeyBoard (2.1)"
IL_047c: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0481: brfalse.s IL_04a4
IL_0483: ldstr "regular key "
IL_0488: ldloc.s V_13
IL_048a: ldflda UnityEngine.KeyCode viperOSK.OSK_UI_Keyboard/<>c__DisplayClass33_0::key
IL_048f: constrained. UnityEngine.KeyCode
IL_0495: callvirt System.String System.Object::ToString()
IL_049a: call System.String System.String::Concat(System.String,System.String)
IL_049f: call System.Void UnityEngine.Debug::Log(System.Object)
IL_04a4: ldloc.s V_14
IL_04a6: ldloc.s V_13
IL_04a8: ldfld UnityEngine.KeyCode viperOSK.OSK_UI_Keyboard/<>c__DisplayClass33_0::key
IL_04ad: ldloc.s V_13
IL_04af: ldfld viperOSK.OSK_KEY_TYPES viperOSK.OSK_UI_Keyboard/<>c__DisplayClass33_0::keyType
IL_04b4: ldstr ""
IL_04b9: callvirt System.Void viperOSK.OSK_UI_Key::Assign(UnityEngine.KeyCode,viperOSK.OSK_KEY_TYPES,System.String)
IL_04be: ldarg.0
IL_04bf: ldfld System.Collections.Generic.List`1<viperOSK.OSK_KeyTypeMeta> viperOSK.OSK_UI_Keyboard::keyTypeMeta
IL_04c4: ldloc.s V_13
IL_04c6: ldftn System.Boolean viperOSK.OSK_UI_Keyboard/<>c__DisplayClass33_0::<Generate>b__2(viperOSK.OSK_KeyTypeMeta)
IL_04cc: newobj System.Void System.Predicate`1<viperOSK.OSK_KeyTypeMeta>::.ctor(System.Object,System.IntPtr)
IL_04d1: callvirt !0 System.Collections.Generic.List`1<viperOSK.OSK_KeyTypeMeta>::Find(System.Predicate`1<!0>)
IL_04d6: stloc.s V_20
IL_04d8: ldloc.s V_20
IL_04da: brfalse.s IL_04f0
IL_04dc: ldloc.s V_14
IL_04de: ldloc.s V_20
IL_04e0: ldfld UnityEngine.Color viperOSK.OSK_KeyTypeMeta::col
IL_04e5: ldarg.0
IL_04e6: ldfld UnityEngine.Color viperOSK.OSK_UI_Keyboard::keyLabelColor
IL_04eb: callvirt System.Void viperOSK.OSK_UI_Key::SetColors(UnityEngine.Color,UnityEngine.Color)
IL_04f0: ldloc.s V_14
IL_04f2: ldloc.3
IL_04f3: callvirt System.Void viperOSK.OSK_UI_Key::BackScale(UnityEngine.Vector3)
IL_04f8: ldloca.s V_4
IL_04fa: ldloc.s V_4
IL_04fc: ldfld System.Single UnityEngine.Vector3::x
IL_0501: ldloc.3
IL_0502: ldfld System.Single UnityEngine.Vector3::x
IL_0507: ldc.r4 0.5
IL_050c: mul
IL_050d: add
IL_050e: stfld System.Single UnityEngine.Vector3::x
IL_0513: ldloc.2
IL_0514: ldloc.s V_4
IL_0516: callvirt System.Void UnityEngine.Transform::set_localPosition(UnityEngine.Vector3)
IL_051b: ldloca.s V_4
IL_051d: ldloc.s V_4
IL_051f: ldfld System.Single UnityEngine.Vector3::x
IL_0524: ldloc.3
IL_0525: ldfld System.Single UnityEngine.Vector3::x
IL_052a: ldc.r4 0.5
IL_052f: mul
IL_0530: add
IL_0531: stfld System.Single UnityEngine.Vector3::x
IL_0536: ldarg.0
IL_0537: ldfld System.Collections.Generic.List`1<System.Collections.Generic.List`1<viperOSK.OSK_UI_Key>> viperOSK.OSK_UI_Keyboard::keyLayout
IL_053c: ldloc.s V_6
IL_053e: callvirt !0 System.Collections.Generic.List`1<System.Collections.Generic.List`1<viperOSK.OSK_UI_Key>>::get_Item(System.Int32)
IL_0543: ldloc.s V_14
IL_0545: callvirt System.Void System.Collections.Generic.List`1<viperOSK.OSK_UI_Key>::Add(!0)
IL_054a: ldloc.s V_5
IL_054c: ldc.i4.1
IL_054d: add
IL_054e: stloc.s V_5
IL_0550: ldloc.s V_14
IL_0552: ldfld UnityEngine.Events.UnityEvent`2<UnityEngine.KeyCode,viperOSK.OSK_KEY_TYPES> viperOSK.OSK_UI_Key::callBack
IL_0557: ldarg.0
IL_0558: ldftn System.Void viperOSK.OSK_UI_Keyboard::KeyCall(UnityEngine.KeyCode,viperOSK.OSK_KEY_TYPES)
IL_055e: newobj System.Void UnityEngine.Events.UnityAction`2<UnityEngine.KeyCode,viperOSK.OSK_KEY_TYPES>::.ctor(System.Object,System.IntPtr)
IL_0563: callvirt System.Void UnityEngine.Events.UnityEvent`2<UnityEngine.KeyCode,viperOSK.OSK_KEY_TYPES>::AddListener(UnityEngine.Events.UnityAction`2<!0,!1>)
IL_0568: ldarg.0
IL_0569: ldfld System.Collections.Generic.Dictionary`2<UnityEngine.KeyCode,viperOSK.OSK_UI_Key> viperOSK.OSK_UI_Keyboard::keyDict
IL_056e: ldloc.s V_13
IL_0570: ldfld UnityEngine.KeyCode viperOSK.OSK_UI_Keyboard/<>c__DisplayClass33_0::key
IL_0575: ldloc.s V_14
IL_0577: callvirt System.Void System.Collections.Generic.Dictionary`2<UnityEngine.KeyCode,viperOSK.OSK_UI_Key>::Add(!0,!1)
IL_057c: call System.Boolean UnityEngine.Application::get_isEditor()
IL_0581: brfalse.s IL_0592
IL_0583: ldarg.0
IL_0584: ldfld System.Boolean viperOSK.OSK_UI_Keyboard::shift
IL_0589: brfalse.s IL_0592
IL_058b: ldloc.s V_14
IL_058d: callvirt System.Void viperOSK.OSK_UI_Key::ShiftUp()
IL_0592: ldloc.s V_10
IL_0594: ldc.i4.1
IL_0595: add
IL_0596: stloc.s V_10
IL_0598: ldloc.s V_10
IL_059a: ldloc.1
IL_059b: ldlen
IL_059c: conv.i4
IL_059d: blt IL_00d6
IL_05a2: call System.Boolean UnityEngine.Application::get_isPlaying()
IL_05a7: brfalse.s IL_05c8
IL_05a9: ldarg.0
IL_05aa: ldfld System.Boolean viperOSK.OSK_UI_Keyboard::shift
IL_05af: brfalse.s IL_05bd
IL_05b1: ldarg.0
IL_05b2: ldstr "ShiftUp"
IL_05b7: call System.Void UnityEngine.Component::BroadcastMessage(System.String)
IL_05bc: ret
IL_05bd: ldarg.0
IL_05be: ldstr "ShiftDown"
IL_05c3: call System.Void UnityEngine.Component::BroadcastMessage(System.String)
IL_05c8: ret
METHOD System.Void viperOSK.OSK_UI_Keyboard::KeyBackspace() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldstr ""
IL_0006: call System.Void viperOSK.OSK_UI_Keyboard::OutputTextUpdate(System.String)
IL_000b: ret
METHOD System.Void viperOSK.OSK_UI_Keyboard::KeyDelete() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld viperOSK.OSK_Receiver viperOSK.OSK_UI_Keyboard::output
IL_0006: callvirt System.String viperOSK.OSK_Receiver::Text()
IL_000b: callvirt System.Int32 System.String::get_Length()
IL_0010: ldc.i4.0
IL_0011: ble.s IL_001e
IL_0013: ldarg.0
IL_0014: ldstr ""
IL_0019: call System.Void viperOSK.OSK_UI_Keyboard::OutputTextUpdate(System.String)
IL_001e: ret
METHOD System.Void viperOSK.OSK_UI_Keyboard::.ctor() | attributes=Public, HideBySig, SpecialName, RTSpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldc.i4.1
IL_0002: stfld System.Boolean viperOSK.OSK_UI_Keyboard::hasFocus
IL_0007: ldarg.0
IL_0008: call UnityEngine.Color UnityEngine.Color::get_white()
IL_000d: stfld UnityEngine.Color viperOSK.OSK_UI_Keyboard::keyLabelColor
IL_0012: ldarg.0
IL_0013: ldc.r4 0.7
IL_0018: ldc.r4 0.5
IL_001d: ldc.r4 0.5
IL_0022: newobj System.Void UnityEngine.Color::.ctor(System.Single,System.Single,System.Single)
IL_0027: stfld UnityEngine.Color viperOSK.OSK_UI_Keyboard::highlighterColor
IL_002c: ldarg.0
IL_002d: ldc.r4 0.15
IL_0032: stfld System.Single viperOSK.OSK_UI_Keyboard::inputTimerThreshold
IL_0037: ldarg.0
IL_0038: newobj System.Void System.Collections.Generic.List`1<System.Collections.Generic.List`1<viperOSK.OSK_UI_Key>>::.ctor()
IL_003d: stfld System.Collections.Generic.List`1<System.Collections.Generic.List`1<viperOSK.OSK_UI_Key>> viperOSK.OSK_UI_Keyboard::keyLayout
IL_0042: ldarg.0
IL_0043: ldstr "1 2 3 4 5 6 7 8 9 0 
 Q W E R T Y U I O P 
 A S D F G H J K L Exclaim 
 Z X C V B N M Period Backspace 
 LeftShift Space Return"
IL_0048: stfld System.String viperOSK.OSK_UI_Keyboard::layout
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
IL_0101: stfld System.Collections.Generic.List`1<viperOSK.OSK_SpecialKeys> viperOSK.OSK_UI_Keyboard::specialKeys
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
IL_018d: stfld System.Collections.Generic.List`1<viperOSK.OSK_KeyTypeMeta> viperOSK.OSK_UI_Keyboard::keyTypeMeta
IL_0192: ldarg.0
IL_0193: newobj System.Void System.Collections.Generic.Dictionary`2<UnityEngine.KeyCode,viperOSK.OSK_SpecialKeys>::.ctor()
IL_0198: stfld System.Collections.Generic.Dictionary`2<UnityEngine.KeyCode,viperOSK.OSK_SpecialKeys> viperOSK.OSK_UI_Keyboard::keySounds
IL_019d: ldarg.0
IL_019e: newobj System.Void System.Collections.Generic.Dictionary`2<UnityEngine.KeyCode,viperOSK.OSK_UI_Key>::.ctor()
IL_01a3: stfld System.Collections.Generic.Dictionary`2<UnityEngine.KeyCode,viperOSK.OSK_UI_Key> viperOSK.OSK_UI_Keyboard::keyDict
IL_01a8: ldarg.0
IL_01a9: call System.Void UnityEngine.MonoBehaviour::.ctor()
IL_01ae: ret
