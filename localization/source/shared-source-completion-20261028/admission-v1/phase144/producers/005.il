TYPE RandomUltimate.Randomization
METHOD System.Int32[] RandomUltimate.Randomization::Random_Int_TEST(System.Int32,System.Int32,System.Int32,System.Single,System.Int32,System.Int32,System.Boolean) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldarg.s numberOfPercentiles
IL_0002: ldc.i4.1
IL_0003: call System.Int32 UnityEngine.Mathf::Max(System.Int32,System.Int32)
IL_0008: starg.s numberOfPercentiles
IL_000a: ldarg.s numberOfPercentiles
IL_000c: newarr System.Int32
IL_0011: stloc.0
IL_0012: ldarg.s testValueCount
IL_0014: ldc.i4.0
IL_0015: ble IL_00ff
IL_001a: newobj System.Void System.Collections.Generic.List`1<System.Int32>::.ctor()
IL_001f: stloc.1
IL_0020: ldc.i4.0
IL_0021: stloc.2
IL_0022: br.s IL_0037
IL_0024: ldloc.1
IL_0025: ldarg.0
IL_0026: ldarg.1
IL_0027: ldarg.2
IL_0028: ldarg.3
IL_0029: call System.Int32 RandomUltimate.Randomization::Random_Int(System.Int32,System.Int32,System.Int32,System.Single)
IL_002e: callvirt System.Void System.Collections.Generic.List`1<System.Int32>::Add(!0)
IL_0033: ldloc.2
IL_0034: ldc.i4.1
IL_0035: add
IL_0036: stloc.2
IL_0037: ldloc.2
IL_0038: ldarg.s testValueCount
IL_003a: blt.s IL_0024
IL_003c: ldloc.1
IL_003d: callvirt System.Void System.Collections.Generic.List`1<System.Int32>::Sort()
IL_0042: ldc.i4.0
IL_0043: stloc.3
IL_0044: br.s IL_006b
IL_0046: ldloc.1
IL_0047: callvirt System.Int32 System.Collections.Generic.List`1<System.Int32>::get_Count()
IL_004c: ldloc.3
IL_004d: mul
IL_004e: conv.r4
IL_004f: ldarg.s numberOfPercentiles
IL_0051: ldc.i4.1
IL_0052: sub
IL_0053: conv.r4
IL_0054: div
IL_0055: call System.Int32 UnityEngine.Mathf::FloorToInt(System.Single)
IL_005a: stloc.s V_4
IL_005c: ldloc.0
IL_005d: ldloc.3
IL_005e: ldloc.1
IL_005f: ldloc.s V_4
IL_0061: callvirt !0 System.Collections.Generic.List`1<System.Int32>::get_Item(System.Int32)
IL_0066: stelem.i4
IL_0067: ldloc.3
IL_0068: ldc.i4.1
IL_0069: add
IL_006a: stloc.3
IL_006b: ldloc.3
IL_006c: ldloc.0
IL_006d: ldlen
IL_006e: conv.i4
IL_006f: ldc.i4.1
IL_0070: sub
IL_0071: blt.s IL_0046
IL_0073: ldloc.0
IL_0074: ldarg.s numberOfPercentiles
IL_0076: ldc.i4.1
IL_0077: sub
IL_0078: ldloc.1
IL_0079: ldloc.1
IL_007a: callvirt System.Int32 System.Collections.Generic.List`1<System.Int32>::get_Count()
IL_007f: ldc.i4.1
IL_0080: sub
IL_0081: callvirt !0 System.Collections.Generic.List`1<System.Int32>::get_Item(System.Int32)
IL_0086: stelem.i4
IL_0087: ldarg.s printPercentilesToDebug
IL_0089: brfalse.s IL_00ff
IL_008b: ldc.i4.0
IL_008c: stloc.s V_5
IL_008e: br.s IL_00f8
IL_0090: ldloc.s V_5
IL_0092: conv.r4
IL_0093: ldc.r4 100
IL_0098: ldarg.s numberOfPercentiles
IL_009a: ldc.i4.1
IL_009b: sub
IL_009c: conv.r4
IL_009d: div
IL_009e: mul
IL_009f: call System.Int32 UnityEngine.Mathf::FloorToInt(System.Single)
IL_00a4: stloc.s V_6
IL_00a6: ldc.i4.6
IL_00a7: newarr System.String
IL_00ac: dup
IL_00ad: ldc.i4.0
IL_00ae: ldstr "("
IL_00b3: stelem.ref
IL_00b4: dup
IL_00b5: ldc.i4.1
IL_00b6: ldloca.s V_5
IL_00b8: call System.String System.Int32::ToString()
IL_00bd: stelem.ref
IL_00be: dup
IL_00bf: ldc.i4.2
IL_00c0: ldstr ") "
IL_00c5: stelem.ref
IL_00c6: dup
IL_00c7: ldc.i4.3
IL_00c8: ldloca.s V_6
IL_00ca: call System.String System.Int32::ToString()
IL_00cf: stelem.ref
IL_00d0: dup
IL_00d1: ldc.i4.4
IL_00d2: ldstr " Percentile: "
IL_00d7: stelem.ref
IL_00d8: dup
IL_00d9: ldc.i4.5
IL_00da: ldloc.0
IL_00db: ldloc.s V_5
IL_00dd: ldelema System.Int32
IL_00e2: call System.String System.Int32::ToString()
IL_00e7: stelem.ref
IL_00e8: call System.String System.String::Concat(System.String[])
IL_00ed: call System.Void UnityEngine.Debug::Log(System.Object)
IL_00f2: ldloc.s V_5
IL_00f4: ldc.i4.1
IL_00f5: add
IL_00f6: stloc.s V_5
IL_00f8: ldloc.s V_5
IL_00fa: ldloc.0
IL_00fb: ldlen
IL_00fc: conv.i4
IL_00fd: blt.s IL_0090
IL_00ff: ldloc.0
IL_0100: ret
METHOD System.Single[] RandomUltimate.Randomization::Random_Float_TEST(System.Single,System.Single,System.Single,System.Single,System.Int32,System.Int32,System.Boolean) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldarg.s numberOfPercentiles
IL_0002: ldc.i4.1
IL_0003: call System.Int32 UnityEngine.Mathf::Max(System.Int32,System.Int32)
IL_0008: starg.s numberOfPercentiles
IL_000a: ldarg.s numberOfPercentiles
IL_000c: newarr System.Single
IL_0011: stloc.0
IL_0012: ldarg.s testValueCount
IL_0014: ldc.i4.0
IL_0015: ble IL_00ff
IL_001a: newobj System.Void System.Collections.Generic.List`1<System.Single>::.ctor()
IL_001f: stloc.1
IL_0020: ldc.i4.0
IL_0021: stloc.2
IL_0022: br.s IL_0037
IL_0024: ldloc.1
IL_0025: ldarg.0
IL_0026: ldarg.1
IL_0027: ldarg.2
IL_0028: ldarg.3
IL_0029: call System.Single RandomUltimate.Randomization::Random_Float(System.Single,System.Single,System.Single,System.Single)
IL_002e: callvirt System.Void System.Collections.Generic.List`1<System.Single>::Add(!0)
IL_0033: ldloc.2
IL_0034: ldc.i4.1
IL_0035: add
IL_0036: stloc.2
IL_0037: ldloc.2
IL_0038: ldarg.s testValueCount
IL_003a: blt.s IL_0024
IL_003c: ldloc.1
IL_003d: callvirt System.Void System.Collections.Generic.List`1<System.Single>::Sort()
IL_0042: ldc.i4.0
IL_0043: stloc.3
IL_0044: br.s IL_006b
IL_0046: ldloc.1
IL_0047: callvirt System.Int32 System.Collections.Generic.List`1<System.Single>::get_Count()
IL_004c: ldloc.3
IL_004d: mul
IL_004e: conv.r4
IL_004f: ldarg.s numberOfPercentiles
IL_0051: ldc.i4.1
IL_0052: sub
IL_0053: conv.r4
IL_0054: div
IL_0055: call System.Int32 UnityEngine.Mathf::FloorToInt(System.Single)
IL_005a: stloc.s V_4
IL_005c: ldloc.0
IL_005d: ldloc.3
IL_005e: ldloc.1
IL_005f: ldloc.s V_4
IL_0061: callvirt !0 System.Collections.Generic.List`1<System.Single>::get_Item(System.Int32)
IL_0066: stelem.r4
IL_0067: ldloc.3
IL_0068: ldc.i4.1
IL_0069: add
IL_006a: stloc.3
IL_006b: ldloc.3
IL_006c: ldloc.0
IL_006d: ldlen
IL_006e: conv.i4
IL_006f: ldc.i4.1
IL_0070: sub
IL_0071: blt.s IL_0046
IL_0073: ldloc.0
IL_0074: ldarg.s numberOfPercentiles
IL_0076: ldc.i4.1
IL_0077: sub
IL_0078: ldloc.1
IL_0079: ldloc.1
IL_007a: callvirt System.Int32 System.Collections.Generic.List`1<System.Single>::get_Count()
IL_007f: ldc.i4.1
IL_0080: sub
IL_0081: callvirt !0 System.Collections.Generic.List`1<System.Single>::get_Item(System.Int32)
IL_0086: stelem.r4
IL_0087: ldarg.s printPercentilesToDebug
IL_0089: brfalse.s IL_00ff
IL_008b: ldc.i4.0
IL_008c: stloc.s V_5
IL_008e: br.s IL_00f8
IL_0090: ldloc.s V_5
IL_0092: conv.r4
IL_0093: ldc.r4 100
IL_0098: ldarg.s numberOfPercentiles
IL_009a: ldc.i4.1
IL_009b: sub
IL_009c: conv.r4
IL_009d: div
IL_009e: mul
IL_009f: call System.Int32 UnityEngine.Mathf::FloorToInt(System.Single)
IL_00a4: stloc.s V_6
IL_00a6: ldc.i4.6
IL_00a7: newarr System.String
IL_00ac: dup
IL_00ad: ldc.i4.0
IL_00ae: ldstr "("
IL_00b3: stelem.ref
IL_00b4: dup
IL_00b5: ldc.i4.1
IL_00b6: ldloca.s V_5
IL_00b8: call System.String System.Int32::ToString()
IL_00bd: stelem.ref
IL_00be: dup
IL_00bf: ldc.i4.2
IL_00c0: ldstr ") "
IL_00c5: stelem.ref
IL_00c6: dup
IL_00c7: ldc.i4.3
IL_00c8: ldloca.s V_6
IL_00ca: call System.String System.Int32::ToString()
IL_00cf: stelem.ref
IL_00d0: dup
IL_00d1: ldc.i4.4
IL_00d2: ldstr " Percentile: "
IL_00d7: stelem.ref
IL_00d8: dup
IL_00d9: ldc.i4.5
IL_00da: ldloc.0
IL_00db: ldloc.s V_5
IL_00dd: ldelema System.Single
IL_00e2: call System.String System.Single::ToString()
IL_00e7: stelem.ref
IL_00e8: call System.String System.String::Concat(System.String[])
IL_00ed: call System.Void UnityEngine.Debug::Log(System.Object)
IL_00f2: ldloc.s V_5
IL_00f4: ldc.i4.1
IL_00f5: add
IL_00f6: stloc.s V_5
IL_00f8: ldloc.s V_5
IL_00fa: ldloc.0
IL_00fb: ldlen
IL_00fc: conv.i4
IL_00fd: blt.s IL_0090
IL_00ff: ldloc.0
IL_0100: ret
