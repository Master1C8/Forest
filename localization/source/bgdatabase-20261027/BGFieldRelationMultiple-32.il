TYPE BansheeGz.BGDatabase.BGFieldRelationMultiple
METHOD System.Void BansheeGz.BGDatabase.BGFieldRelationMultiple::FromBytes(System.Int32,System.ArraySegment`1<System.Byte>) | attributes=Public, Virtual, HideBySig | impl=IL
IL_0000: ldarga.s segment
IL_0002: call System.Int32 System.ArraySegment`1<System.Byte>::get_Count()
IL_0007: brtrue.s IL_0011
IL_0009: ldarg.0
IL_000a: ldarg.1
IL_000b: call System.Void BansheeGz.BGDatabase.BGFieldRelationMultiple::ClearValueNoEventForRelation(System.Int32)
IL_0010: ret
IL_0011: ldarg.0
IL_0012: ldfld BansheeGz.BGDatabase.BGStoreField`1<TStoreType> BansheeGz.BGDatabase.BGFieldCachedA`2<System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity>,System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGId>>::Store
IL_0017: ldarg.1
IL_0018: callvirt T BansheeGz.BGDatabase.BGStoreField`1<System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGId>>::get_Item(System.Int32)
IL_001d: dup
IL_001e: brtrue.s IL_0026
IL_0020: pop
IL_0021: newobj System.Void System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGId>::.ctor()
IL_0026: stloc.0
IL_0027: ldc.i4.0
IL_0028: stloc.1
IL_0029: br.s IL_004b
IL_002b: ldloc.0
IL_002c: ldarga.s segment
IL_002e: call !0[] System.ArraySegment`1<System.Byte>::get_Array()
IL_0033: ldarga.s segment
IL_0035: call System.Int32 System.ArraySegment`1<System.Byte>::get_Offset()
IL_003a: ldloc.1
IL_003b: add
IL_003c: newobj System.Void BansheeGz.BGDatabase.BGId::.ctor(System.Byte[],System.Int32)
IL_0041: callvirt System.Void System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGId>::Add(!0)
IL_0046: ldloc.1
IL_0047: ldc.i4.s 16
IL_0049: add
IL_004a: stloc.1
IL_004b: ldloc.1
IL_004c: ldarga.s segment
IL_004e: call System.Int32 System.ArraySegment`1<System.Byte>::get_Count()
IL_0053: blt.s IL_002b
IL_0055: ldarg.0
IL_0056: ldfld BansheeGz.BGDatabase.BGFieldRelationA`2/ReverseRelationCache<T,TStoreType> BansheeGz.BGDatabase.BGFieldRelationA`2<System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity>,System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGId>>::ReverseCache
IL_005b: callvirt System.Boolean BansheeGz.BGDatabase.BGFieldRelationA`2/ReverseRelationCache<System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity>,System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGId>>::get_Enabled()
IL_0060: brfalse.s IL_006a
IL_0062: ldarg.0
IL_0063: ldarg.1
IL_0064: ldloc.0
IL_0065: call System.Void BansheeGz.BGDatabase.BGFieldRelationMultiple::ReverseSetRelated(System.Int32,System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGId>)
IL_006a: ldarg.0
IL_006b: ldfld BansheeGz.BGDatabase.BGStoreField`1<TStoreType> BansheeGz.BGDatabase.BGFieldCachedA`2<System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity>,System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGId>>::Store
IL_0070: ldarg.1
IL_0071: ldloc.0
IL_0072: callvirt System.Void BansheeGz.BGDatabase.BGStoreField`1<System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGId>>::set_Item(System.Int32,T)
IL_0077: ret
