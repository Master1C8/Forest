TYPE viperOSK.OSK_Keyboard
METHOD System.Void viperOSK.OSK_Keyboard::KeyCall(UnityEngine.KeyCode,viperOSK.OSK_KEY_TYPES) | attributes=Public, Virtual, HideBySig, VtableLayoutMask | impl=IL
IL_0000: newobj System.Void viperOSK.OSK_Keyboard/<>c__DisplayClass34_0::.ctor()
IL_0005: stloc.0
IL_0006: ldloc.0
IL_0007: ldarg.0
IL_0008: stfld viperOSK.OSK_Keyboard viperOSK.OSK_Keyboard/<>c__DisplayClass34_0::<>4__this
IL_000d: ldloc.0
IL_000e: ldarg.1
IL_000f: stfld UnityEngine.KeyCode viperOSK.OSK_Keyboard/<>c__DisplayClass34_0::k
IL_0014: ldarg.0
IL_0015: ldfld System.Boolean viperOSK.OSK_Keyboard::hasFocus
IL_001a: brtrue.s IL_001d
IL_001c: ret
IL_001d: ldarg.0
IL_001e: ldfld System.Collections.Generic.Dictionary`2<UnityEngine.KeyCode,viperOSK.OSK_Key> viperOSK.OSK_Keyboard::keyDict
IL_0023: ldloc.0
IL_0024: ldfld UnityEngine.KeyCode viperOSK.OSK_Keyboard/<>c__DisplayClass34_0::k
IL_0029: callvirt System.Boolean System.Collections.Generic.Dictionary`2<UnityEngine.KeyCode,viperOSK.OSK_Key>::ContainsKey(!0)
IL_002e: brtrue.s IL_0031
IL_0030: ret
IL_0031: ldarg.0
IL_0032: ldfld System.Collections.Generic.Dictionary`2<UnityEngine.KeyCode,viperOSK.OSK_SpecialKeys> viperOSK.OSK_Keyboard::keySounds
IL_0037: ldloc.0
IL_0038: ldfld UnityEngine.KeyCode viperOSK.OSK_Keyboard/<>c__DisplayClass34_0::k
IL_003d: callvirt System.Boolean System.Collections.Generic.Dictionary`2<UnityEngine.KeyCode,viperOSK.OSK_SpecialKeys>::ContainsKey(!0)
IL_0042: brfalse.s IL_0062
IL_0044: ldarg.0
IL_0045: ldarg.0
IL_0046: ldfld System.Collections.Generic.Dictionary`2<UnityEngine.KeyCode,viperOSK.OSK_SpecialKeys> viperOSK.OSK_Keyboard::keySounds
IL_004b: ldloc.0
IL_004c: ldfld UnityEngine.KeyCode viperOSK.OSK_Keyboard/<>c__DisplayClass34_0::k
IL_0051: callvirt !1 System.Collections.Generic.Dictionary`2<UnityEngine.KeyCode,viperOSK.OSK_SpecialKeys>::get_Item(!0)
IL_0056: ldfld System.Int32 viperOSK.OSK_SpecialKeys::keySoundCode
IL_005b: call System.Void viperOSK.OSK_Keyboard::ClickSound(System.Int32)
IL_0060: br.s IL_0092
IL_0062: ldarg.0
IL_0063: ldfld System.Collections.Generic.List`1<viperOSK.OSK_KeyTypeMeta> viperOSK.OSK_Keyboard::keyTypeMeta
IL_0068: ldloc.0
IL_0069: ldftn System.Boolean viperOSK.OSK_Keyboard/<>c__DisplayClass34_0::<KeyCall>b__0(viperOSK.OSK_KeyTypeMeta)
IL_006f: newobj System.Void System.Predicate`1<viperOSK.OSK_KeyTypeMeta>::.ctor(System.Object,System.IntPtr)
IL_0074: callvirt !0 System.Collections.Generic.List`1<viperOSK.OSK_KeyTypeMeta>::Find(System.Predicate`1<!0>)
IL_0079: stloc.2
IL_007a: ldloc.2
IL_007b: brfalse.s IL_008b
IL_007d: ldarg.0
IL_007e: ldloc.2
IL_007f: ldfld System.Int32 viperOSK.OSK_KeyTypeMeta::keySoundCode
IL_0084: call System.Void viperOSK.OSK_Keyboard::ClickSound(System.Int32)
IL_0089: br.s IL_0092
IL_008b: ldarg.0
IL_008c: ldc.i4.0
IL_008d: call System.Void viperOSK.OSK_Keyboard::ClickSound(System.Int32)
IL_0092: ldloc.0
IL_0093: ldfld UnityEngine.KeyCode viperOSK.OSK_Keyboard/<>c__DisplayClass34_0::k
IL_0098: ldc.i4.8
IL_0099: bne.un.s IL_00a2
IL_009b: ldarg.0
IL_009c: call System.Void viperOSK.OSK_Keyboard::KeyBackspace()
IL_00a1: ret
IL_00a2: ldloc.0
IL_00a3: ldfld UnityEngine.KeyCode viperOSK.OSK_Keyboard/<>c__DisplayClass34_0::k
IL_00a8: ldc.i4.s 127
IL_00aa: bne.un.s IL_00b3
IL_00ac: ldarg.0
IL_00ad: call System.Void viperOSK.OSK_Keyboard::KeyDelete()
IL_00b2: ret
IL_00b3: ldloc.0
IL_00b4: ldfld UnityEngine.KeyCode viperOSK.OSK_Keyboard/<>c__DisplayClass34_0::k
IL_00b9: ldc.i4.s 13
IL_00bb: bne.un.s IL_00d7
IL_00bd: ldarg.0
IL_00be: ldfld viperOSK.OSK_Receiver viperOSK.OSK_Keyboard::output
IL_00c3: ldnull
IL_00c4: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_00c9: brfalse.s IL_00d6
IL_00cb: ldarg.0
IL_00cc: ldfld viperOSK.OSK_Receiver viperOSK.OSK_Keyboard::output
IL_00d1: callvirt System.Void viperOSK.OSK_Receiver::Submit()
IL_00d6: ret
IL_00d7: ldloc.0
IL_00d8: ldfld UnityEngine.KeyCode viperOSK.OSK_Keyboard/<>c__DisplayClass34_0::k
IL_00dd: ldc.i4 304
IL_00e2: beq.s IL_00f1
IL_00e4: ldloc.0
IL_00e5: ldfld UnityEngine.KeyCode viperOSK.OSK_Keyboard/<>c__DisplayClass34_0::k
IL_00ea: ldc.i4 303
IL_00ef: bne.un.s IL_00f8
IL_00f1: ldarg.0
IL_00f2: call System.Void viperOSK.OSK_Keyboard::KeyShift()
IL_00f7: ret
IL_00f8: ldloc.0
IL_00f9: ldfld UnityEngine.KeyCode viperOSK.OSK_Keyboard/<>c__DisplayClass34_0::k
IL_00fe: ldc.i4 301
IL_0103: bne.un.s IL_012a
IL_0105: ldarg.0
IL_0106: ldarg.0
IL_0107: ldfld System.Boolean viperOSK.OSK_Keyboard::caps
IL_010c: ldc.i4.0
IL_010d: ceq
IL_010f: stfld System.Boolean viperOSK.OSK_Keyboard::caps
IL_0114: ldarg.0
IL_0115: ldarg.0
IL_0116: ldfld System.Boolean viperOSK.OSK_Keyboard::caps
IL_011b: ldc.i4.0
IL_011c: ceq
IL_011e: stfld System.Boolean viperOSK.OSK_Keyboard::shift
IL_0123: ldarg.0
IL_0124: call System.Void viperOSK.OSK_Keyboard::KeyShift()
IL_0129: ret
IL_012a: ldloc.0
IL_012b: ldfld UnityEngine.KeyCode viperOSK.OSK_Keyboard/<>c__DisplayClass34_0::k
IL_0130: ldc.i4 306
IL_0135: beq.s IL_0144
IL_0137: ldloc.0
IL_0138: ldfld UnityEngine.KeyCode viperOSK.OSK_Keyboard/<>c__DisplayClass34_0::k
IL_013d: ldc.i4 305
IL_0142: bne.un.s IL_0145
IL_0144: ret
IL_0145: ldloc.0
IL_0146: ldfld UnityEngine.KeyCode viperOSK.OSK_Keyboard/<>c__DisplayClass34_0::k
IL_014b: ldc.i4 308
IL_0150: beq.s IL_015f
IL_0152: ldloc.0
IL_0153: ldfld UnityEngine.KeyCode viperOSK.OSK_Keyboard/<>c__DisplayClass34_0::k
IL_0158: ldc.i4 307
IL_015d: bne.un.s IL_0160
IL_015f: ret
IL_0160: ldarg.0
IL_0161: ldfld System.Boolean viperOSK.OSK_Keyboard::shift
IL_0166: brtrue.s IL_0179
IL_0168: ldloc.0
IL_0169: ldfld UnityEngine.KeyCode viperOSK.OSK_Keyboard/<>c__DisplayClass34_0::k
IL_016e: conv.u2
IL_016f: stloc.3
IL_0170: ldloca.s V_3
IL_0172: call System.String System.Char::ToString()
IL_0177: br.s IL_018d
IL_0179: ldloc.0
IL_017a: ldfld UnityEngine.KeyCode viperOSK.OSK_Keyboard/<>c__DisplayClass34_0::k
IL_017f: conv.u2
IL_0180: stloc.3
IL_0181: ldloca.s V_3
IL_0183: call System.String System.Char::ToString()
IL_0188: callvirt System.String System.String::ToUpper()
IL_018d: stloc.1
IL_018e: ldarg.0
IL_018f: ldloc.1
IL_0190: call System.Void viperOSK.OSK_Keyboard::OutputTextUpdate(System.String)
IL_0195: ldarg.0
IL_0196: ldfld System.Boolean viperOSK.OSK_Keyboard::caps
IL_019b: brtrue.s IL_01ab
IL_019d: ldarg.0
IL_019e: ldfld System.Boolean viperOSK.OSK_Keyboard::shift
IL_01a3: brfalse.s IL_01ab
IL_01a5: ldarg.0
IL_01a6: call System.Void viperOSK.OSK_Keyboard::KeyShift()
IL_01ab: ret
METHOD System.Void viperOSK.OSK_Keyboard::KeySpace() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldstr " "
IL_0006: call System.Void viperOSK.OSK_Keyboard::OutputTextUpdate(System.String)
IL_000b: ret
METHOD System.Void viperOSK.OSK_Keyboard::KeyShift() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.0
IL_0002: ldfld System.Boolean viperOSK.OSK_Keyboard::shift
IL_0007: ldc.i4.0
IL_0008: ceq
IL_000a: stfld System.Boolean viperOSK.OSK_Keyboard::shift
IL_000f: ldarg.0
IL_0010: ldfld System.Boolean viperOSK.OSK_Keyboard::shift
IL_0015: brfalse.s IL_0023
IL_0017: ldarg.0
IL_0018: ldstr "ShiftUp"
IL_001d: call System.Void UnityEngine.Component::BroadcastMessage(System.String)
IL_0022: ret
IL_0023: ldarg.0
IL_0024: ldstr "ShiftDown"
IL_0029: call System.Void UnityEngine.Component::BroadcastMessage(System.String)
IL_002e: ret
METHOD System.Void viperOSK.OSK_Keyboard::OnPhysicalKeyStroke(System.Char) | attributes=Family, Virtual, HideBySig, VtableLayoutMask | impl=IL
IL_0000: ldsfld System.Collections.Generic.Dictionary`2<System.String,UnityEngine.KeyCode> viperOSK.OSK_Keymap::chartoKeycode
IL_0005: ldarga.s c
IL_0007: call System.String System.Char::ToString()
IL_000c: ldloca.s V_0
IL_000e: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,UnityEngine.KeyCode>::TryGetValue(!0,!1&)
IL_0013: brfalse.s IL_002b
IL_0015: ldarg.0
IL_0016: ldfld System.Collections.Generic.Dictionary`2<UnityEngine.KeyCode,viperOSK.OSK_Key> viperOSK.OSK_Keyboard::keyDict
IL_001b: ldloc.0
IL_001c: ldloca.s V_1
IL_001e: callvirt System.Boolean System.Collections.Generic.Dictionary`2<UnityEngine.KeyCode,viperOSK.OSK_Key>::TryGetValue(!0,!1&)
IL_0023: brfalse.s IL_002b
IL_0025: ldloc.1
IL_0026: callvirt System.Void viperOSK.OSK_Key::Click()
IL_002b: ret
