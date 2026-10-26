TYPE ForestProbe
METHOD System.String ForestProbe::KeyboardMaps(Rewired.Player) | attributes=Private, Static, HideBySig | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: ldnull
IL_0003: ceq
IL_0005: stloc.1
IL_0006: ldloc.1
IL_0007: brfalse.s IL_0014
IL_0009: ldstr "null"
IL_000e: stloc.2
IL_000f: br IL_02c3
IL_0014: newobj System.Void System.Collections.Generic.List`1<System.String>::.ctor()
IL_0019: stloc.0
IL_001a: nop
IL_001b: ldarg.0
IL_001c: ldfld Rewired.Player/ControllerHelper Rewired.Player::controllers
IL_0021: ldfld Rewired.Player/ControllerHelper/MapHelper Rewired.Player/ControllerHelper::maps
IL_0026: ldc.i4.0
IL_0027: callvirt System.Collections.Generic.IEnumerable`1<Rewired.ControllerMap> Rewired.Player/ControllerHelper/MapHelper::GetAllMaps(Rewired.ControllerType)
IL_002c: callvirt System.Collections.Generic.IEnumerator`1<!0> System.Collections.Generic.IEnumerable`1<Rewired.ControllerMap>::GetEnumerator()
IL_0031: stloc.3
IL_0032: br IL_0289
IL_0037: ldloc.3
IL_0038: callvirt !0 System.Collections.Generic.IEnumerator`1<Rewired.ControllerMap>::get_Current()
IL_003d: stloc.s V_4
IL_003f: nop
IL_0040: newobj System.Void System.Collections.Generic.List`1<System.String>::.ctor()
IL_0045: stloc.s V_5
IL_0047: nop
IL_0048: ldloc.s V_4
IL_004a: callvirt System.Collections.Generic.IList`1<Rewired.ActionElementMap> Rewired.ControllerMap::get_AllMaps()
IL_004f: callvirt System.Collections.Generic.IEnumerator`1<!0> System.Collections.Generic.IEnumerable`1<Rewired.ActionElementMap>::GetEnumerator()
IL_0054: stloc.s V_6
IL_0056: br IL_01c3
IL_005b: ldloc.s V_6
IL_005d: callvirt !0 System.Collections.Generic.IEnumerator`1<Rewired.ActionElementMap>::get_Current()
IL_0062: stloc.s V_7
IL_0064: ldloc.s V_7
IL_0066: callvirt System.Int32 Rewired.ActionElementMap::get_actionId()
IL_006b: brfalse.s IL_0079
IL_006d: ldloc.s V_7
IL_006f: callvirt System.Int32 Rewired.ActionElementMap::get_actionId()
IL_0074: ldc.i4.1
IL_0075: ceq
IL_0077: br.s IL_007a
IL_0079: ldc.i4.1
IL_007a: stloc.s V_8
IL_007c: ldloc.s V_8
IL_007e: brfalse IL_01c3
IL_0083: ldloc.s V_5
IL_0085: ldc.i4.s 21
IL_0087: newarr System.String
IL_008c: dup
IL_008d: ldc.i4.0
IL_008e: ldstr "{"action":"
IL_0093: stelem.ref
IL_0094: dup
IL_0095: ldc.i4.1
IL_0096: ldloc.s V_7
IL_0098: callvirt System.Int32 Rewired.ActionElementMap::get_actionId()
IL_009d: stloc.s V_9
IL_009f: ldloca.s V_9
IL_00a1: call System.String System.Int32::ToString()
IL_00a6: stelem.ref
IL_00a7: dup
IL_00a8: ldc.i4.2
IL_00a9: ldstr ","key":"
IL_00ae: stelem.ref
IL_00af: dup
IL_00b0: ldc.i4.3
IL_00b1: ldloc.s V_7
IL_00b3: callvirt UnityEngine.KeyCode Rewired.ActionElementMap::get_keyCode()
IL_00b8: stloc.s V_9
IL_00ba: ldloca.s V_9
IL_00bc: call System.String System.Int32::ToString()
IL_00c1: stelem.ref
IL_00c2: dup
IL_00c3: ldc.i4.4
IL_00c4: ldstr ","type":"
IL_00c9: stelem.ref
IL_00ca: dup
IL_00cb: ldc.i4.5
IL_00cc: ldloc.s V_7
IL_00ce: callvirt Rewired.ControllerElementType Rewired.ActionElementMap::get_elementType()
IL_00d3: stloc.s V_9
IL_00d5: ldloca.s V_9
IL_00d7: call System.String System.Int32::ToString()
IL_00dc: stelem.ref
IL_00dd: dup
IL_00de: ldc.i4.6
IL_00df: ldstr ","range":"
IL_00e4: stelem.ref
IL_00e5: dup
IL_00e6: ldc.i4.7
IL_00e7: ldloc.s V_7
IL_00e9: callvirt Rewired.AxisRange Rewired.ActionElementMap::get_axisRange()
IL_00ee: stloc.s V_9
IL_00f0: ldloca.s V_9
IL_00f2: call System.String System.Int32::ToString()
IL_00f7: stelem.ref
IL_00f8: dup
IL_00f9: ldc.i4.8
IL_00fa: ldstr ","pole":"
IL_00ff: stelem.ref
IL_0100: dup
IL_0101: ldc.i4.s 9
IL_0103: ldloc.s V_7
IL_0105: callvirt Rewired.Pole Rewired.ActionElementMap::get_axisContribution()
IL_010a: stloc.s V_9
IL_010c: ldloca.s V_9
IL_010e: call System.String System.Int32::ToString()
IL_0113: stelem.ref
IL_0114: dup
IL_0115: ldc.i4.s 10
IL_0117: ldstr ","invert":"
IL_011c: stelem.ref
IL_011d: dup
IL_011e: ldc.i4.s 11
IL_0120: ldloc.s V_7
IL_0122: callvirt System.Boolean Rewired.ActionElementMap::get_invert()
IL_0127: brtrue.s IL_0130
IL_0129: ldstr "false"
IL_012e: br.s IL_0135
IL_0130: ldstr "true"
IL_0135: stelem.ref
IL_0136: dup
IL_0137: ldc.i4.s 12
IL_0139: ldstr ","enabled":"
IL_013e: stelem.ref
IL_013f: dup
IL_0140: ldc.i4.s 13
IL_0142: ldloc.s V_7
IL_0144: callvirt System.Boolean Rewired.ActionElementMap::get_enabled()
IL_0149: brtrue.s IL_0152
IL_014b: ldstr "false"
IL_0150: br.s IL_0157
IL_0152: ldstr "true"
IL_0157: stelem.ref
IL_0158: dup
IL_0159: ldc.i4.s 14
IL_015b: ldstr ","modifier1":"
IL_0160: stelem.ref
IL_0161: dup
IL_0162: ldc.i4.s 15
IL_0164: ldloc.s V_7
IL_0166: callvirt Rewired.ModifierKey Rewired.ActionElementMap::get_modifierKey1()
IL_016b: stloc.s V_9
IL_016d: ldloca.s V_9
IL_016f: call System.String System.Int32::ToString()
IL_0174: stelem.ref
IL_0175: dup
IL_0176: ldc.i4.s 16
IL_0178: ldstr ","modifier2":"
IL_017d: stelem.ref
IL_017e: dup
IL_017f: ldc.i4.s 17
IL_0181: ldloc.s V_7
IL_0183: callvirt Rewired.ModifierKey Rewired.ActionElementMap::get_modifierKey2()
IL_0188: stloc.s V_9
IL_018a: ldloca.s V_9
IL_018c: call System.String System.Int32::ToString()
IL_0191: stelem.ref
IL_0192: dup
IL_0193: ldc.i4.s 18
IL_0195: ldstr ","modifier3":"
IL_019a: stelem.ref
IL_019b: dup
IL_019c: ldc.i4.s 19
IL_019e: ldloc.s V_7
IL_01a0: callvirt Rewired.ModifierKey Rewired.ActionElementMap::get_modifierKey3()
IL_01a5: stloc.s V_9
IL_01a7: ldloca.s V_9
IL_01a9: call System.String System.Int32::ToString()
IL_01ae: stelem.ref
IL_01af: dup
IL_01b0: ldc.i4.s 20
IL_01b2: ldstr "}"
IL_01b7: stelem.ref
IL_01b8: call System.String System.String::Concat(System.String[])
IL_01bd: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_01c2: nop
IL_01c3: ldloc.s V_6
IL_01c5: callvirt System.Boolean System.Collections.IEnumerator::MoveNext()
IL_01ca: brtrue IL_005b
IL_01cf: leave.s IL_01de
IL_01d1: ldloc.s V_6
IL_01d3: brfalse.s IL_01dd
IL_01d5: ldloc.s V_6
IL_01d7: callvirt System.Void System.IDisposable::Dispose()
IL_01dc: nop
IL_01dd: endfinally
IL_01de: ldloc.0
IL_01df: ldc.i4.s 11
IL_01e1: newarr System.String
IL_01e6: dup
IL_01e7: ldc.i4.0
IL_01e8: ldstr "{"source":"
IL_01ed: stelem.ref
IL_01ee: dup
IL_01ef: ldc.i4.1
IL_01f0: ldloc.s V_4
IL_01f2: callvirt System.Int32 Rewired.ControllerMap::get_sourceMapId()
IL_01f7: stloc.s V_9
IL_01f9: ldloca.s V_9
IL_01fb: call System.String System.Int32::ToString()
IL_0200: stelem.ref
IL_0201: dup
IL_0202: ldc.i4.2
IL_0203: ldstr ","category":"
IL_0208: stelem.ref
IL_0209: dup
IL_020a: ldc.i4.3
IL_020b: ldloc.s V_4
IL_020d: callvirt System.Int32 Rewired.ControllerMap::get_categoryId()
IL_0212: stloc.s V_9
IL_0214: ldloca.s V_9
IL_0216: call System.String System.Int32::ToString()
IL_021b: stelem.ref
IL_021c: dup
IL_021d: ldc.i4.4
IL_021e: ldstr ","layout":"
IL_0223: stelem.ref
IL_0224: dup
IL_0225: ldc.i4.5
IL_0226: ldloc.s V_4
IL_0228: callvirt System.Int32 Rewired.ControllerMap::get_layoutId()
IL_022d: stloc.s V_9
IL_022f: ldloca.s V_9
IL_0231: call System.String System.Int32::ToString()
IL_0236: stelem.ref
IL_0237: dup
IL_0238: ldc.i4.6
IL_0239: ldstr ","enabled":"
IL_023e: stelem.ref
IL_023f: dup
IL_0240: ldc.i4.7
IL_0241: ldloc.s V_4
IL_0243: callvirt System.Boolean Rewired.ControllerMap::get_enabled()
IL_0248: brtrue.s IL_0251
IL_024a: ldstr "false"
IL_024f: br.s IL_0256
IL_0251: ldstr "true"
IL_0256: stelem.ref
IL_0257: dup
IL_0258: ldc.i4.8
IL_0259: ldstr ","movement":["
IL_025e: stelem.ref
IL_025f: dup
IL_0260: ldc.i4.s 9
IL_0262: ldstr ","
IL_0267: ldloc.s V_5
IL_0269: callvirt !0[] System.Collections.Generic.List`1<System.String>::ToArray()
IL_026e: call System.String System.String::Join(System.String,System.String[])
IL_0273: stelem.ref
IL_0274: dup
IL_0275: ldc.i4.s 10
IL_0277: ldstr "]}"
IL_027c: stelem.ref
IL_027d: call System.String System.String::Concat(System.String[])
IL_0282: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0287: nop
IL_0288: nop
IL_0289: ldloc.3
IL_028a: callvirt System.Boolean System.Collections.IEnumerator::MoveNext()
IL_028f: brtrue IL_0037
IL_0294: leave.s IL_02a1
IL_0296: ldloc.3
IL_0297: brfalse.s IL_02a0
IL_0299: ldloc.3
IL_029a: callvirt System.Void System.IDisposable::Dispose()
IL_029f: nop
IL_02a0: endfinally
IL_02a1: ldstr "{"maps":["
IL_02a6: ldstr ","
IL_02ab: ldloc.0
IL_02ac: callvirt !0[] System.Collections.Generic.List`1<System.String>::ToArray()
IL_02b1: call System.String System.String::Join(System.String,System.String[])
IL_02b6: ldstr "]}"
IL_02bb: call System.String System.String::Concat(System.String,System.String,System.String)
IL_02c0: stloc.2
IL_02c1: br.s IL_02c3
IL_02c3: ldloc.2
IL_02c4: ret
