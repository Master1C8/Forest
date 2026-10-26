TYPE BansheeGz.BGDatabase.BGFieldRelationMultiple
METHOD System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity> BansheeGz.BGDatabase.BGFieldRelationMultiple::get_Item(System.Int32) | attributes=Public, Virtual, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld BansheeGz.BGDatabase.BGStoreField`1<TStoreType> BansheeGz.BGDatabase.BGFieldCachedA`2<System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity>,System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGId>>::Store
IL_0006: ldarg.1
IL_0007: callvirt T BansheeGz.BGDatabase.BGStoreField`1<System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGId>>::get_Item(System.Int32)
IL_000c: stloc.0
IL_000d: ldloc.0
IL_000e: brfalse.s IL_0018
IL_0010: ldloc.0
IL_0011: callvirt System.Int32 System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGId>::get_Count()
IL_0016: brtrue.s IL_001a
IL_0018: ldnull
IL_0019: ret
IL_001a: newobj System.Void System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity>::.ctor()
IL_001f: stloc.1
IL_0020: ldc.i4.0
IL_0021: stloc.2
IL_0022: br.s IL_004a
IL_0024: ldloc.0
IL_0025: ldloc.2
IL_0026: callvirt !0 System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGId>::get_Item(System.Int32)
IL_002b: stloc.3
IL_002c: ldarg.0
IL_002d: call BansheeGz.BGDatabase.BGMetaEntity BansheeGz.BGDatabase.BGFieldRelationA`2<System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity>,System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGId>>::get_To()
IL_0032: ldloc.3
IL_0033: callvirt BansheeGz.BGDatabase.BGEntity BansheeGz.BGDatabase.BGMetaEntity::get_Item(BansheeGz.BGDatabase.BGId)
IL_0038: stloc.s V_4
IL_003a: ldloc.s V_4
IL_003c: brfalse.s IL_0046
IL_003e: ldloc.1
IL_003f: ldloc.s V_4
IL_0041: callvirt System.Void System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity>::Add(!0)
IL_0046: ldloc.2
IL_0047: ldc.i4.1
IL_0048: add
IL_0049: stloc.2
IL_004a: ldloc.2
IL_004b: ldloc.0
IL_004c: callvirt System.Int32 System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGId>::get_Count()
IL_0051: blt.s IL_0024
IL_0053: ldloc.1
IL_0054: ret
