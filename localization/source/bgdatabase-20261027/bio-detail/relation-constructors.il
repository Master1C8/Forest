TYPE BansheeGz.BGDatabase.BGFieldRelationA`2
METHOD System.Void BansheeGz.BGDatabase.BGFieldRelationA`2::.ctor(BansheeGz.BGDatabase.BGMetaEntity,System.String) | attributes=Family, HideBySig, SpecialName, RTSpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: ldarg.2
IL_0003: call System.Void BansheeGz.BGDatabase.BGFieldCachedA`2<T,TStoreType>::.ctor(BansheeGz.BGDatabase.BGMetaEntity,System.String)
IL_0008: ldarg.0
IL_0009: ldarg.0
IL_000a: newobj System.Void BansheeGz.BGDatabase.BGFieldRelationA`2/ReverseRelationCache<T,TStoreType>::.ctor(BansheeGz.BGDatabase.BGFieldRelationA`2<T,TStoreType>)
IL_000f: stfld BansheeGz.BGDatabase.BGFieldRelationA`2/ReverseRelationCache<T,TStoreType> BansheeGz.BGDatabase.BGFieldRelationA`2<T,TStoreType>::ReverseCache
IL_0014: ret
METHOD System.Void BansheeGz.BGDatabase.BGFieldRelationA`2::.ctor(BansheeGz.BGDatabase.BGMetaEntity,BansheeGz.BGDatabase.BGId,System.String) | attributes=Family, HideBySig, SpecialName, RTSpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: ldarg.2
IL_0003: ldarg.3
IL_0004: call System.Void BansheeGz.BGDatabase.BGFieldCachedA`2<T,TStoreType>::.ctor(BansheeGz.BGDatabase.BGMetaEntity,BansheeGz.BGDatabase.BGId,System.String)
IL_0009: ldarg.0
IL_000a: ldarg.0
IL_000b: newobj System.Void BansheeGz.BGDatabase.BGFieldRelationA`2/ReverseRelationCache<T,TStoreType>::.ctor(BansheeGz.BGDatabase.BGFieldRelationA`2<T,TStoreType>)
IL_0010: stfld BansheeGz.BGDatabase.BGFieldRelationA`2/ReverseRelationCache<T,TStoreType> BansheeGz.BGDatabase.BGFieldRelationA`2<T,TStoreType>::ReverseCache
IL_0015: ret
METHOD System.Void BansheeGz.BGDatabase.BGFieldRelationA`2::.ctor(BansheeGz.BGDatabase.BGMetaEntity,System.String,BansheeGz.BGDatabase.BGMetaEntity) | attributes=Family, HideBySig, SpecialName, RTSpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: ldarg.2
IL_0003: call System.Void BansheeGz.BGDatabase.BGFieldCachedA`2<T,TStoreType>::.ctor(BansheeGz.BGDatabase.BGMetaEntity,System.String)
IL_0008: ldarg.3
IL_0009: brtrue.s IL_0028
IL_000b: ldarg.0
IL_000c: call BansheeGz.BGDatabase.BGMetaEntity BansheeGz.BGDatabase.BGField::get_Meta()
IL_0011: ldarg.0
IL_0012: callvirt System.Void BansheeGz.BGDatabase.BGMetaEntity::Unregister(BansheeGz.BGDatabase.BGField)
IL_0017: ldstr "'To' can not be null"
IL_001c: ldc.i4.0
IL_001d: newarr System.Object
IL_0022: newobj System.Void BansheeGz.BGDatabase.BGException::.ctor(System.String,System.Object[])
IL_0027: throw
IL_0028: ldarg.0
IL_0029: ldarg.0
IL_002a: newobj System.Void BansheeGz.BGDatabase.BGFieldRelationA`2/ReverseRelationCache<T,TStoreType>::.ctor(BansheeGz.BGDatabase.BGFieldRelationA`2<T,TStoreType>)
IL_002f: stfld BansheeGz.BGDatabase.BGFieldRelationA`2/ReverseRelationCache<T,TStoreType> BansheeGz.BGDatabase.BGFieldRelationA`2<T,TStoreType>::ReverseCache
IL_0034: ldarg.0
IL_0035: ldarg.3
IL_0036: callvirt BansheeGz.BGDatabase.BGId BansheeGz.BGDatabase.BGObject::get_Id()
IL_003b: stfld BansheeGz.BGDatabase.BGId BansheeGz.BGDatabase.BGFieldRelationA`2<T,TStoreType>::toId
IL_0040: ret
