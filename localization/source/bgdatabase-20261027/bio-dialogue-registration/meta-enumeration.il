TYPE BansheeGz.BGDatabase.BGMetaEntity
METHOD System.Void BansheeGz.BGDatabase.BGMetaEntity::ForEachEntity(System.Action`1<BansheeGz.BGDatabase.BGEntity>,System.Predicate`1<BansheeGz.BGDatabase.BGEntity>,System.Comparison`1<BansheeGz.BGDatabase.BGEntity>) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.3
IL_0001: brtrue.s IL_003c
IL_0003: ldarg.0
IL_0004: ldfld BansheeGz.BGDatabase.BGStoreMeta BansheeGz.BGDatabase.BGMetaEntity::Store
IL_0009: callvirt System.Int32 BansheeGz.BGDatabase.BGArrayStore`1<BansheeGz.BGDatabase.BGEntity>::get_Count()
IL_000e: stloc.0
IL_000f: ldc.i4.0
IL_0010: stloc.1
IL_0011: br.s IL_0037
IL_0013: ldarg.0
IL_0014: ldfld BansheeGz.BGDatabase.BGStoreMeta BansheeGz.BGDatabase.BGMetaEntity::Store
IL_0019: ldloc.1
IL_001a: callvirt BansheeGz.BGDatabase.BGEntity BansheeGz.BGDatabase.BGStoreMeta::get_Item(System.Int32)
IL_001f: stloc.2
IL_0020: ldarg.2
IL_0021: brfalse.s IL_002c
IL_0023: ldarg.2
IL_0024: ldloc.2
IL_0025: callvirt System.Boolean System.Predicate`1<BansheeGz.BGDatabase.BGEntity>::Invoke(!0)
IL_002a: brfalse.s IL_0033
IL_002c: ldarg.1
IL_002d: ldloc.2
IL_002e: callvirt System.Void System.Action`1<BansheeGz.BGDatabase.BGEntity>::Invoke(!0)
IL_0033: ldloc.1
IL_0034: ldc.i4.1
IL_0035: add
IL_0036: stloc.1
IL_0037: ldloc.1
IL_0038: ldloc.0
IL_0039: blt.s IL_0013
IL_003b: ret
IL_003c: ldsfld System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity> BansheeGz.BGDatabase.BGMetaEntity::TempList
IL_0041: callvirt System.Void System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity>::Clear()
IL_0046: ldarg.0
IL_0047: ldfld BansheeGz.BGDatabase.BGStoreMeta BansheeGz.BGDatabase.BGMetaEntity::Store
IL_004c: callvirt System.Int32 BansheeGz.BGDatabase.BGArrayStore`1<BansheeGz.BGDatabase.BGEntity>::get_Count()
IL_0051: stloc.3
IL_0052: ldc.i4.0
IL_0053: stloc.s V_5
IL_0055: br.s IL_0085
IL_0057: ldarg.0
IL_0058: ldfld BansheeGz.BGDatabase.BGStoreMeta BansheeGz.BGDatabase.BGMetaEntity::Store
IL_005d: ldloc.s V_5
IL_005f: callvirt BansheeGz.BGDatabase.BGEntity BansheeGz.BGDatabase.BGStoreMeta::get_Item(System.Int32)
IL_0064: stloc.s V_6
IL_0066: ldarg.2
IL_0067: brfalse.s IL_0073
IL_0069: ldarg.2
IL_006a: ldloc.s V_6
IL_006c: callvirt System.Boolean System.Predicate`1<BansheeGz.BGDatabase.BGEntity>::Invoke(!0)
IL_0071: brfalse.s IL_007f
IL_0073: ldsfld System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity> BansheeGz.BGDatabase.BGMetaEntity::TempList
IL_0078: ldloc.s V_6
IL_007a: callvirt System.Void System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity>::Add(!0)
IL_007f: ldloc.s V_5
IL_0081: ldc.i4.1
IL_0082: add
IL_0083: stloc.s V_5
IL_0085: ldloc.s V_5
IL_0087: ldloc.3
IL_0088: blt.s IL_0057
IL_008a: ldsfld System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity> BansheeGz.BGDatabase.BGMetaEntity::TempList
IL_008f: ldarg.3
IL_0090: callvirt System.Void System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity>::Sort(System.Comparison`1<!0>)
IL_0095: ldsfld System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity> BansheeGz.BGDatabase.BGMetaEntity::TempList
IL_009a: callvirt System.Int32 System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity>::get_Count()
IL_009f: stloc.s V_4
IL_00a1: ldc.i4.0
IL_00a2: stloc.s V_7
IL_00a4: br.s IL_00be
IL_00a6: ldarg.1
IL_00a7: ldsfld System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity> BansheeGz.BGDatabase.BGMetaEntity::TempList
IL_00ac: ldloc.s V_7
IL_00ae: callvirt !0 System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity>::get_Item(System.Int32)
IL_00b3: callvirt System.Void System.Action`1<BansheeGz.BGDatabase.BGEntity>::Invoke(!0)
IL_00b8: ldloc.s V_7
IL_00ba: ldc.i4.1
IL_00bb: add
IL_00bc: stloc.s V_7
IL_00be: ldloc.s V_7
IL_00c0: ldloc.s V_4
IL_00c2: blt.s IL_00a6
IL_00c4: ret
