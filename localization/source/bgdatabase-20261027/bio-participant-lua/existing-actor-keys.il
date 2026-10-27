TYPE PixelCrushers.DialogueSystem.DialogueLua
METHOD System.Collections.Generic.HashSet`1<System.String> PixelCrushers.DialogueSystem.DialogueLua::GetExistingAssetNames(System.String,System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueDatabase>) | attributes=Private, Static, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: brfalse.s IL_000b
IL_0003: ldarg.1
IL_0004: callvirt System.Int32 System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueDatabase>::get_Count()
IL_0009: brtrue.s IL_000d
IL_000b: ldnull
IL_000c: ret
IL_000d: newobj System.Void System.Collections.Generic.HashSet`1<System.String>::.ctor()
IL_0012: stloc.0
IL_0013: ldarg.0
IL_0014: brfalse IL_01fa
IL_0019: ldarg.0
IL_001a: ldstr "Actor"
IL_001f: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0024: brtrue.s IL_005b
IL_0026: ldarg.0
IL_0027: ldstr "Item"
IL_002c: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0031: brtrue IL_00c2
IL_0036: ldarg.0
IL_0037: ldstr "Location"
IL_003c: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0041: brtrue IL_012c
IL_0046: ldarg.0
IL_0047: ldstr "Variable"
IL_004c: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0051: brtrue IL_0193
IL_0056: br IL_01fa
IL_005b: ldarg.1
IL_005c: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueDatabase>::GetEnumerator()
IL_0061: stloc.1
IL_0062: br.s IL_00a6
IL_0064: ldloca.s V_1
IL_0066: call !0 System.Collections.Generic.List`1/Enumerator<PixelCrushers.DialogueSystem.DialogueDatabase>::get_Current()
IL_006b: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Actor> PixelCrushers.DialogueSystem.DialogueDatabase::actors
IL_0070: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Actor>::GetEnumerator()
IL_0075: stloc.2
IL_0076: br.s IL_008d
IL_0078: ldloca.s V_2
IL_007a: call !0 System.Collections.Generic.List`1/Enumerator<PixelCrushers.DialogueSystem.Actor>::get_Current()
IL_007f: stloc.3
IL_0080: ldloc.0
IL_0081: ldloc.3
IL_0082: callvirt System.String PixelCrushers.DialogueSystem.Asset::get_Name()
IL_0087: callvirt System.Boolean System.Collections.Generic.HashSet`1<System.String>::Add(!0)
IL_008c: pop
IL_008d: ldloca.s V_2
IL_008f: call System.Boolean System.Collections.Generic.List`1/Enumerator<PixelCrushers.DialogueSystem.Actor>::MoveNext()
IL_0094: brtrue.s IL_0078
IL_0096: leave.s IL_00a6
IL_0098: ldloca.s V_2
IL_009a: constrained. System.Collections.Generic.List`1/Enumerator<PixelCrushers.DialogueSystem.Actor>
IL_00a0: callvirt System.Void System.IDisposable::Dispose()
IL_00a5: endfinally
IL_00a6: ldloca.s V_1
IL_00a8: call System.Boolean System.Collections.Generic.List`1/Enumerator<PixelCrushers.DialogueSystem.DialogueDatabase>::MoveNext()
IL_00ad: brtrue.s IL_0064
IL_00af: leave IL_01fa
IL_00b4: ldloca.s V_1
IL_00b6: constrained. System.Collections.Generic.List`1/Enumerator<PixelCrushers.DialogueSystem.DialogueDatabase>
IL_00bc: callvirt System.Void System.IDisposable::Dispose()
IL_00c1: endfinally
IL_00c2: ldarg.1
IL_00c3: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueDatabase>::GetEnumerator()
IL_00c8: stloc.1
IL_00c9: br.s IL_0110
IL_00cb: ldloca.s V_1
IL_00cd: call !0 System.Collections.Generic.List`1/Enumerator<PixelCrushers.DialogueSystem.DialogueDatabase>::get_Current()
IL_00d2: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Item> PixelCrushers.DialogueSystem.DialogueDatabase::items
IL_00d7: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Item>::GetEnumerator()
IL_00dc: stloc.s V_4
IL_00de: br.s IL_00f7
IL_00e0: ldloca.s V_4
IL_00e2: call !0 System.Collections.Generic.List`1/Enumerator<PixelCrushers.DialogueSystem.Item>::get_Current()
IL_00e7: stloc.s V_5
IL_00e9: ldloc.0
IL_00ea: ldloc.s V_5
IL_00ec: callvirt System.String PixelCrushers.DialogueSystem.Asset::get_Name()
IL_00f1: callvirt System.Boolean System.Collections.Generic.HashSet`1<System.String>::Add(!0)
IL_00f6: pop
IL_00f7: ldloca.s V_4
IL_00f9: call System.Boolean System.Collections.Generic.List`1/Enumerator<PixelCrushers.DialogueSystem.Item>::MoveNext()
IL_00fe: brtrue.s IL_00e0
IL_0100: leave.s IL_0110
IL_0102: ldloca.s V_4
IL_0104: constrained. System.Collections.Generic.List`1/Enumerator<PixelCrushers.DialogueSystem.Item>
IL_010a: callvirt System.Void System.IDisposable::Dispose()
IL_010f: endfinally
IL_0110: ldloca.s V_1
IL_0112: call System.Boolean System.Collections.Generic.List`1/Enumerator<PixelCrushers.DialogueSystem.DialogueDatabase>::MoveNext()
IL_0117: brtrue.s IL_00cb
IL_0119: leave IL_01fa
IL_011e: ldloca.s V_1
IL_0120: constrained. System.Collections.Generic.List`1/Enumerator<PixelCrushers.DialogueSystem.DialogueDatabase>
IL_0126: callvirt System.Void System.IDisposable::Dispose()
IL_012b: endfinally
IL_012c: ldarg.1
IL_012d: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueDatabase>::GetEnumerator()
IL_0132: stloc.1
IL_0133: br.s IL_017a
IL_0135: ldloca.s V_1
IL_0137: call !0 System.Collections.Generic.List`1/Enumerator<PixelCrushers.DialogueSystem.DialogueDatabase>::get_Current()
IL_013c: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Location> PixelCrushers.DialogueSystem.DialogueDatabase::locations
IL_0141: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Location>::GetEnumerator()
IL_0146: stloc.s V_6
IL_0148: br.s IL_0161
IL_014a: ldloca.s V_6
IL_014c: call !0 System.Collections.Generic.List`1/Enumerator<PixelCrushers.DialogueSystem.Location>::get_Current()
IL_0151: stloc.s V_7
IL_0153: ldloc.0
IL_0154: ldloc.s V_7
IL_0156: callvirt System.String PixelCrushers.DialogueSystem.Asset::get_Name()
IL_015b: callvirt System.Boolean System.Collections.Generic.HashSet`1<System.String>::Add(!0)
IL_0160: pop
IL_0161: ldloca.s V_6
IL_0163: call System.Boolean System.Collections.Generic.List`1/Enumerator<PixelCrushers.DialogueSystem.Location>::MoveNext()
IL_0168: brtrue.s IL_014a
IL_016a: leave.s IL_017a
IL_016c: ldloca.s V_6
IL_016e: constrained. System.Collections.Generic.List`1/Enumerator<PixelCrushers.DialogueSystem.Location>
IL_0174: callvirt System.Void System.IDisposable::Dispose()
IL_0179: endfinally
IL_017a: ldloca.s V_1
IL_017c: call System.Boolean System.Collections.Generic.List`1/Enumerator<PixelCrushers.DialogueSystem.DialogueDatabase>::MoveNext()
IL_0181: brtrue.s IL_0135
IL_0183: leave.s IL_01fa
IL_0185: ldloca.s V_1
IL_0187: constrained. System.Collections.Generic.List`1/Enumerator<PixelCrushers.DialogueSystem.DialogueDatabase>
IL_018d: callvirt System.Void System.IDisposable::Dispose()
IL_0192: endfinally
IL_0193: ldarg.1
IL_0194: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueDatabase>::GetEnumerator()
IL_0199: stloc.1
IL_019a: br.s IL_01e1
IL_019c: ldloca.s V_1
IL_019e: call !0 System.Collections.Generic.List`1/Enumerator<PixelCrushers.DialogueSystem.DialogueDatabase>::get_Current()
IL_01a3: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Variable> PixelCrushers.DialogueSystem.DialogueDatabase::variables
IL_01a8: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Variable>::GetEnumerator()
IL_01ad: stloc.s V_8
IL_01af: br.s IL_01c8
IL_01b1: ldloca.s V_8
IL_01b3: call !0 System.Collections.Generic.List`1/Enumerator<PixelCrushers.DialogueSystem.Variable>::get_Current()
IL_01b8: stloc.s V_9
IL_01ba: ldloc.0
IL_01bb: ldloc.s V_9
IL_01bd: callvirt System.String PixelCrushers.DialogueSystem.Asset::get_Name()
IL_01c2: callvirt System.Boolean System.Collections.Generic.HashSet`1<System.String>::Add(!0)
IL_01c7: pop
IL_01c8: ldloca.s V_8
IL_01ca: call System.Boolean System.Collections.Generic.List`1/Enumerator<PixelCrushers.DialogueSystem.Variable>::MoveNext()
IL_01cf: brtrue.s IL_01b1
IL_01d1: leave.s IL_01e1
IL_01d3: ldloca.s V_8
IL_01d5: constrained. System.Collections.Generic.List`1/Enumerator<PixelCrushers.DialogueSystem.Variable>
IL_01db: callvirt System.Void System.IDisposable::Dispose()
IL_01e0: endfinally
IL_01e1: ldloca.s V_1
IL_01e3: call System.Boolean System.Collections.Generic.List`1/Enumerator<PixelCrushers.DialogueSystem.DialogueDatabase>::MoveNext()
IL_01e8: brtrue.s IL_019c
IL_01ea: leave.s IL_01fa
IL_01ec: ldloca.s V_1
IL_01ee: constrained. System.Collections.Generic.List`1/Enumerator<PixelCrushers.DialogueSystem.DialogueDatabase>
IL_01f4: callvirt System.Void System.IDisposable::Dispose()
IL_01f9: endfinally
IL_01fa: ldloc.0
IL_01fb: ret
