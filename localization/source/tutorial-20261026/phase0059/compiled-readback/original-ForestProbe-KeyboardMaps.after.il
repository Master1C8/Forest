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
IL_000f: br IL_032b
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
IL_0032: br IL_02f1
IL_0037: ldloc.3
IL_0038: callvirt !0 System.Collections.Generic.IEnumerator`1<Rewired.ControllerMap>::get_Current()
IL_003d: stloc.s V_4
IL_003f: nop
IL_0040: newobj System.Void System.Collections.Generic.List`1<System.String>::.ctor()
IL_0045: stloc.s V_5
IL_0047: newobj System.Void System.Collections.Generic.List`1<System.String>::.ctor()
IL_004c: stloc.s V_6
IL_004e: nop
IL_004f: ldloc.s V_4
IL_0051: callvirt System.Collections.Generic.IList`1<Rewired.ActionElementMap> Rewired.ControllerMap::get_AllMaps()
IL_0056: callvirt System.Collections.Generic.IEnumerator`1<!0> System.Collections.Generic.IEnumerable`1<Rewired.ActionElementMap>::GetEnumerator()
IL_005b: stloc.s V_7
IL_005d: br IL_020d
IL_0062: ldloc.s V_7
IL_0064: callvirt !0 System.Collections.Generic.IEnumerator`1<Rewired.ActionElementMap>::get_Current()
IL_0069: stloc.s V_8
IL_006b: ldloc.s V_8
IL_006d: callvirt System.Int32 Rewired.ActionElementMap::get_actionId()
IL_0072: brfalse.s IL_0095
IL_0074: ldloc.s V_8
IL_0076: callvirt System.Int32 Rewired.ActionElementMap::get_actionId()
IL_007b: ldc.i4.1
IL_007c: beq.s IL_0095
IL_007e: ldloc.s V_8
IL_0080: callvirt System.Int32 Rewired.ActionElementMap::get_actionId()
IL_0085: ldc.i4.2
IL_0086: beq.s IL_0095
IL_0088: ldloc.s V_8
IL_008a: callvirt System.Int32 Rewired.ActionElementMap::get_actionId()
IL_008f: ldc.i4.s 18
IL_0091: ceq
IL_0093: br.s IL_0096
IL_0095: ldc.i4.1
IL_0096: stloc.s V_9
IL_0098: ldloc.s V_9
IL_009a: brfalse IL_020d
IL_009f: nop
IL_00a0: ldc.i4.s 21
IL_00a2: newarr System.String
IL_00a7: dup
IL_00a8: ldc.i4.0
IL_00a9: ldstr "{"action":"
IL_00ae: stelem.ref
IL_00af: dup
IL_00b0: ldc.i4.1
IL_00b1: ldloc.s V_8
IL_00b3: callvirt System.Int32 Rewired.ActionElementMap::get_actionId()
IL_00b8: stloc.s V_11
IL_00ba: ldloca.s V_11
IL_00bc: call System.String System.Int32::ToString()
IL_00c1: stelem.ref
IL_00c2: dup
IL_00c3: ldc.i4.2
IL_00c4: ldstr ","key":"
IL_00c9: stelem.ref
IL_00ca: dup
IL_00cb: ldc.i4.3
IL_00cc: ldloc.s V_8
IL_00ce: callvirt UnityEngine.KeyCode Rewired.ActionElementMap::get_keyCode()
IL_00d3: stloc.s V_11
IL_00d5: ldloca.s V_11
IL_00d7: call System.String System.Int32::ToString()
IL_00dc: stelem.ref
IL_00dd: dup
IL_00de: ldc.i4.4
IL_00df: ldstr ","type":"
IL_00e4: stelem.ref
IL_00e5: dup
IL_00e6: ldc.i4.5
IL_00e7: ldloc.s V_8
IL_00e9: callvirt Rewired.ControllerElementType Rewired.ActionElementMap::get_elementType()
IL_00ee: stloc.s V_11
IL_00f0: ldloca.s V_11
IL_00f2: call System.String System.Int32::ToString()
IL_00f7: stelem.ref
IL_00f8: dup
IL_00f9: ldc.i4.6
IL_00fa: ldstr ","range":"
IL_00ff: stelem.ref
IL_0100: dup
IL_0101: ldc.i4.7
IL_0102: ldloc.s V_8
IL_0104: callvirt Rewired.AxisRange Rewired.ActionElementMap::get_axisRange()
IL_0109: stloc.s V_11
IL_010b: ldloca.s V_11
IL_010d: call System.String System.Int32::ToString()
IL_0112: stelem.ref
IL_0113: dup
IL_0114: ldc.i4.8
IL_0115: ldstr ","pole":"
IL_011a: stelem.ref
IL_011b: dup
IL_011c: ldc.i4.s 9
IL_011e: ldloc.s V_8
IL_0120: callvirt Rewired.Pole Rewired.ActionElementMap::get_axisContribution()
IL_0125: stloc.s V_11
IL_0127: ldloca.s V_11
IL_0129: call System.String System.Int32::ToString()
IL_012e: stelem.ref
IL_012f: dup
IL_0130: ldc.i4.s 10
IL_0132: ldstr ","invert":"
IL_0137: stelem.ref
IL_0138: dup
IL_0139: ldc.i4.s 11
IL_013b: ldloc.s V_8
IL_013d: callvirt System.Boolean Rewired.ActionElementMap::get_invert()
IL_0142: brtrue.s IL_014b
IL_0144: ldstr "false"
IL_0149: br.s IL_0150
IL_014b: ldstr "true"
IL_0150: stelem.ref
IL_0151: dup
IL_0152: ldc.i4.s 12
IL_0154: ldstr ","enabled":"
IL_0159: stelem.ref
IL_015a: dup
IL_015b: ldc.i4.s 13
IL_015d: ldloc.s V_8
IL_015f: callvirt System.Boolean Rewired.ActionElementMap::get_enabled()
IL_0164: brtrue.s IL_016d
IL_0166: ldstr "false"
IL_016b: br.s IL_0172
IL_016d: ldstr "true"
IL_0172: stelem.ref
IL_0173: dup
IL_0174: ldc.i4.s 14
IL_0176: ldstr ","modifier1":"
IL_017b: stelem.ref
IL_017c: dup
IL_017d: ldc.i4.s 15
IL_017f: ldloc.s V_8
IL_0181: callvirt Rewired.ModifierKey Rewired.ActionElementMap::get_modifierKey1()
IL_0186: stloc.s V_11
IL_0188: ldloca.s V_11
IL_018a: call System.String System.Int32::ToString()
IL_018f: stelem.ref
IL_0190: dup
IL_0191: ldc.i4.s 16
IL_0193: ldstr ","modifier2":"
IL_0198: stelem.ref
IL_0199: dup
IL_019a: ldc.i4.s 17
IL_019c: ldloc.s V_8
IL_019e: callvirt Rewired.ModifierKey Rewired.ActionElementMap::get_modifierKey2()
IL_01a3: stloc.s V_11
IL_01a5: ldloca.s V_11
IL_01a7: call System.String System.Int32::ToString()
IL_01ac: stelem.ref
IL_01ad: dup
IL_01ae: ldc.i4.s 18
IL_01b0: ldstr ","modifier3":"
IL_01b5: stelem.ref
IL_01b6: dup
IL_01b7: ldc.i4.s 19
IL_01b9: ldloc.s V_8
IL_01bb: callvirt Rewired.ModifierKey Rewired.ActionElementMap::get_modifierKey3()
IL_01c0: stloc.s V_11
IL_01c2: ldloca.s V_11
IL_01c4: call System.String System.Int32::ToString()
IL_01c9: stelem.ref
IL_01ca: dup
IL_01cb: ldc.i4.s 20
IL_01cd: ldstr "}"
IL_01d2: stelem.ref
IL_01d3: call System.String System.String::Concat(System.String[])
IL_01d8: stloc.s V_10
IL_01da: ldloc.s V_8
IL_01dc: callvirt System.Int32 Rewired.ActionElementMap::get_actionId()
IL_01e1: brfalse.s IL_01ef
IL_01e3: ldloc.s V_8
IL_01e5: callvirt System.Int32 Rewired.ActionElementMap::get_actionId()
IL_01ea: ldc.i4.1
IL_01eb: ceq
IL_01ed: br.s IL_01f0
IL_01ef: ldc.i4.1
IL_01f0: stloc.s V_12
IL_01f2: ldloc.s V_12
IL_01f4: brfalse.s IL_0202
IL_01f6: ldloc.s V_5
IL_01f8: ldloc.s V_10
IL_01fa: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_01ff: nop
IL_0200: br.s IL_020c
IL_0202: ldloc.s V_6
IL_0204: ldloc.s V_10
IL_0206: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_020b: nop
IL_020c: nop
IL_020d: ldloc.s V_7
IL_020f: callvirt System.Boolean System.Collections.IEnumerator::MoveNext()
IL_0214: brtrue IL_0062
IL_0219: leave.s IL_0228
IL_021b: ldloc.s V_7
IL_021d: brfalse.s IL_0227
IL_021f: ldloc.s V_7
IL_0221: callvirt System.Void System.IDisposable::Dispose()
IL_0226: nop
IL_0227: endfinally
IL_0228: ldloc.0
IL_0229: ldc.i4.s 13
IL_022b: newarr System.String
IL_0230: dup
IL_0231: ldc.i4.0
IL_0232: ldstr "{"source":"
IL_0237: stelem.ref
IL_0238: dup
IL_0239: ldc.i4.1
IL_023a: ldloc.s V_4
IL_023c: callvirt System.Int32 Rewired.ControllerMap::get_sourceMapId()
IL_0241: stloc.s V_11
IL_0243: ldloca.s V_11
IL_0245: call System.String System.Int32::ToString()
IL_024a: stelem.ref
IL_024b: dup
IL_024c: ldc.i4.2
IL_024d: ldstr ","category":"
IL_0252: stelem.ref
IL_0253: dup
IL_0254: ldc.i4.3
IL_0255: ldloc.s V_4
IL_0257: callvirt System.Int32 Rewired.ControllerMap::get_categoryId()
IL_025c: stloc.s V_11
IL_025e: ldloca.s V_11
IL_0260: call System.String System.Int32::ToString()
IL_0265: stelem.ref
IL_0266: dup
IL_0267: ldc.i4.4
IL_0268: ldstr ","layout":"
IL_026d: stelem.ref
IL_026e: dup
IL_026f: ldc.i4.5
IL_0270: ldloc.s V_4
IL_0272: callvirt System.Int32 Rewired.ControllerMap::get_layoutId()
IL_0277: stloc.s V_11
IL_0279: ldloca.s V_11
IL_027b: call System.String System.Int32::ToString()
IL_0280: stelem.ref
IL_0281: dup
IL_0282: ldc.i4.6
IL_0283: ldstr ","enabled":"
IL_0288: stelem.ref
IL_0289: dup
IL_028a: ldc.i4.7
IL_028b: ldloc.s V_4
IL_028d: callvirt System.Boolean Rewired.ControllerMap::get_enabled()
IL_0292: brtrue.s IL_029b
IL_0294: ldstr "false"
IL_0299: br.s IL_02a0
IL_029b: ldstr "true"
IL_02a0: stelem.ref
IL_02a1: dup
IL_02a2: ldc.i4.8
IL_02a3: ldstr ","movement":["
IL_02a8: stelem.ref
IL_02a9: dup
IL_02aa: ldc.i4.s 9
IL_02ac: ldstr ","
IL_02b1: ldloc.s V_5
IL_02b3: callvirt !0[] System.Collections.Generic.List`1<System.String>::ToArray()
IL_02b8: call System.String System.String::Join(System.String,System.String[])
IL_02bd: stelem.ref
IL_02be: dup
IL_02bf: ldc.i4.s 10
IL_02c1: ldstr "],"submit":["
IL_02c6: stelem.ref
IL_02c7: dup
IL_02c8: ldc.i4.s 11
IL_02ca: ldstr ","
IL_02cf: ldloc.s V_6
IL_02d1: callvirt !0[] System.Collections.Generic.List`1<System.String>::ToArray()
IL_02d6: call System.String System.String::Join(System.String,System.String[])
IL_02db: stelem.ref
IL_02dc: dup
IL_02dd: ldc.i4.s 12
IL_02df: ldstr "]}"
IL_02e4: stelem.ref
IL_02e5: call System.String System.String::Concat(System.String[])
IL_02ea: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_02ef: nop
IL_02f0: nop
IL_02f1: ldloc.3
IL_02f2: callvirt System.Boolean System.Collections.IEnumerator::MoveNext()
IL_02f7: brtrue IL_0037
IL_02fc: leave.s IL_0309
IL_02fe: ldloc.3
IL_02ff: brfalse.s IL_0308
IL_0301: ldloc.3
IL_0302: callvirt System.Void System.IDisposable::Dispose()
IL_0307: nop
IL_0308: endfinally
IL_0309: ldstr "{"maps":["
IL_030e: ldstr ","
IL_0313: ldloc.0
IL_0314: callvirt !0[] System.Collections.Generic.List`1<System.String>::ToArray()
IL_0319: call System.String System.String::Join(System.String,System.String[])
IL_031e: ldstr "]}"
IL_0323: call System.String System.String::Concat(System.String,System.String,System.String)
IL_0328: stloc.2
IL_0329: br.s IL_032b
IL_032b: ldloc.2
IL_032c: ret
