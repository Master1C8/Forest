TYPE BansheeGz.BGDatabase.BGFieldRelationSingle
METHOD System.Byte[] BansheeGz.BGDatabase.BGFieldRelationSingle::ToBytes(System.Int32) | attributes=Public, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld BansheeGz.BGDatabase.BGStoreField`1<TStoreType> BansheeGz.BGDatabase.BGFieldCachedA`2<BansheeGz.BGDatabase.BGEntity,BansheeGz.BGDatabase.BGId>::Store
IL_0006: ldarg.1
IL_0007: callvirt T BansheeGz.BGDatabase.BGStoreField`1<BansheeGz.BGDatabase.BGId>::get_Item(System.Int32)
IL_000c: stloc.0
IL_000d: ldloc.0
IL_000e: ldsfld BansheeGz.BGDatabase.BGId BansheeGz.BGDatabase.BGId::Empty
IL_0013: call System.Boolean BansheeGz.BGDatabase.BGId::op_Equality(BansheeGz.BGDatabase.BGId,BansheeGz.BGDatabase.BGId)
IL_0018: brtrue.s IL_0022
IL_001a: ldloca.s V_0
IL_001c: call System.Byte[] BansheeGz.BGDatabase.BGId::ToByteArray()
IL_0021: ret
IL_0022: ldnull
IL_0023: ret
METHOD System.Void BansheeGz.BGDatabase.BGFieldRelationSingle::FromBytes(System.Int32,System.ArraySegment`1<System.Byte>) | attributes=Public, Virtual, HideBySig | impl=IL
IL_0000: ldarga.s segment
IL_0002: call System.Int32 System.ArraySegment`1<System.Byte>::get_Count()
IL_0007: ldc.i4.s 16
IL_0009: beq.s IL_0013
IL_000b: ldarg.0
IL_000c: ldarg.1
IL_000d: call System.Void BansheeGz.BGDatabase.BGFieldRelationSingle::ClearValueNoEventForRelation(System.Int32)
IL_0012: ret
IL_0013: ldloca.s V_0
IL_0015: ldarga.s segment
IL_0017: call !0[] System.ArraySegment`1<System.Byte>::get_Array()
IL_001c: ldarga.s segment
IL_001e: call System.Int32 System.ArraySegment`1<System.Byte>::get_Offset()
IL_0023: call System.Void BansheeGz.BGDatabase.BGId::.ctor(System.Byte[],System.Int32)
IL_0028: ldarg.0
IL_0029: ldfld BansheeGz.BGDatabase.BGFieldRelationA`2/ReverseRelationCache<T,TStoreType> BansheeGz.BGDatabase.BGFieldRelationA`2<BansheeGz.BGDatabase.BGEntity,BansheeGz.BGDatabase.BGId>::ReverseCache
IL_002e: callvirt System.Boolean BansheeGz.BGDatabase.BGFieldRelationA`2/ReverseRelationCache<BansheeGz.BGDatabase.BGEntity,BansheeGz.BGDatabase.BGId>::get_Enabled()
IL_0033: brfalse.s IL_003d
IL_0035: ldarg.0
IL_0036: ldarg.1
IL_0037: ldloc.0
IL_0038: call System.Void BansheeGz.BGDatabase.BGFieldRelationSingle::ReverseSetRelated(System.Int32,BansheeGz.BGDatabase.BGId)
IL_003d: ldarg.0
IL_003e: ldfld BansheeGz.BGDatabase.BGStoreField`1<TStoreType> BansheeGz.BGDatabase.BGFieldCachedA`2<BansheeGz.BGDatabase.BGEntity,BansheeGz.BGDatabase.BGId>::Store
IL_0043: ldarg.1
IL_0044: ldloc.0
IL_0045: callvirt System.Void BansheeGz.BGDatabase.BGStoreField`1<BansheeGz.BGDatabase.BGId>::set_Item(System.Int32,T)
IL_004a: ret
