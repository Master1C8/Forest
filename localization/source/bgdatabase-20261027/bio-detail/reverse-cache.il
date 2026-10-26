TYPE BansheeGz.BGDatabase.BGFieldRelationA`2/ReverseRelationCache
METHOD System.Void BansheeGz.BGDatabase.BGFieldRelationA`2/ReverseRelationCache::Enable(System.Boolean) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: brfalse.s IL_0039
IL_0003: ldarg.0
IL_0004: ldfld System.Collections.Generic.Dictionary`2<BansheeGz.BGDatabase.BGId,BansheeGz.BGDatabase.BGFieldRelationA`2/ReverseRelationCacheValueI<T,TStoreType>> BansheeGz.BGDatabase.BGFieldRelationA`2/ReverseRelationCache<T,TStoreType>::reverseEntityId2Related
IL_0009: brfalse.s IL_000c
IL_000b: ret
IL_000c: ldarg.0
IL_000d: ldfld BansheeGz.BGDatabase.BGFieldRelationA`2<T,TStoreType> BansheeGz.BGDatabase.BGFieldRelationA`2/ReverseRelationCache<T,TStoreType>::relation
IL_0012: callvirt BansheeGz.BGDatabase.BGMetaEntity BansheeGz.BGDatabase.BGFieldRelationA`2<T,TStoreType>::get_RelatedMeta()
IL_0017: stloc.0
IL_0018: ldloc.0
IL_0019: brtrue.s IL_001c
IL_001b: ret
IL_001c: ldarg.0
IL_001d: ldloc.0
IL_001e: callvirt System.Int32 BansheeGz.BGDatabase.BGMetaEntity::get_CountEntities()
IL_0023: newobj System.Void System.Collections.Generic.Dictionary`2<BansheeGz.BGDatabase.BGId,BansheeGz.BGDatabase.BGFieldRelationA`2/ReverseRelationCacheValueI<T,TStoreType>>::.ctor(System.Int32)
IL_0028: stfld System.Collections.Generic.Dictionary`2<BansheeGz.BGDatabase.BGId,BansheeGz.BGDatabase.BGFieldRelationA`2/ReverseRelationCacheValueI<T,TStoreType>> BansheeGz.BGDatabase.BGFieldRelationA`2/ReverseRelationCache<T,TStoreType>::reverseEntityId2Related
IL_002d: ldarg.0
IL_002e: ldfld BansheeGz.BGDatabase.BGFieldRelationA`2<T,TStoreType> BansheeGz.BGDatabase.BGFieldRelationA`2/ReverseRelationCache<T,TStoreType>::relation
IL_0033: callvirt System.Void BansheeGz.BGDatabase.BGFieldRelationA`2<T,TStoreType>::BuildReverseCache()
IL_0038: ret
IL_0039: ldarg.0
IL_003a: ldnull
IL_003b: stfld System.Collections.Generic.Dictionary`2<BansheeGz.BGDatabase.BGId,BansheeGz.BGDatabase.BGFieldRelationA`2/ReverseRelationCacheValueI<T,TStoreType>> BansheeGz.BGDatabase.BGFieldRelationA`2/ReverseRelationCache<T,TStoreType>::reverseEntityId2Related
IL_0040: ret
METHOD System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity> BansheeGz.BGDatabase.BGFieldRelationA`2/ReverseRelationCache::Get(BansheeGz.BGDatabase.BGId) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Collections.Generic.Dictionary`2<BansheeGz.BGDatabase.BGId,BansheeGz.BGDatabase.BGFieldRelationA`2/ReverseRelationCacheValueI<T,TStoreType>> BansheeGz.BGDatabase.BGFieldRelationA`2/ReverseRelationCache<T,TStoreType>::reverseEntityId2Related
IL_0006: brtrue.s IL_000a
IL_0008: ldnull
IL_0009: ret
IL_000a: ldarg.0
IL_000b: ldfld System.Collections.Generic.Dictionary`2<BansheeGz.BGDatabase.BGId,BansheeGz.BGDatabase.BGFieldRelationA`2/ReverseRelationCacheValueI<T,TStoreType>> BansheeGz.BGDatabase.BGFieldRelationA`2/ReverseRelationCache<T,TStoreType>::reverseEntityId2Related
IL_0010: ldarg.1
IL_0011: ldloca.s V_0
IL_0013: callvirt System.Boolean System.Collections.Generic.Dictionary`2<BansheeGz.BGDatabase.BGId,BansheeGz.BGDatabase.BGFieldRelationA`2/ReverseRelationCacheValueI<T,TStoreType>>::TryGetValue(!0,!1&)
IL_0018: brfalse.s IL_0021
IL_001a: ldloc.0
IL_001b: callvirt System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity> BansheeGz.BGDatabase.BGFieldRelationA`2/ReverseRelationCacheValueI<T,TStoreType>::get_List()
IL_0020: ret
IL_0021: ldnull
IL_0022: ret
METHOD BansheeGz.BGDatabase.BGFieldRelationA`2/ReverseRelationCacheValueI<T,TStoreType> BansheeGz.BGDatabase.BGFieldRelationA`2/ReverseRelationCache::Ensure(BansheeGz.BGDatabase.BGId) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Collections.Generic.Dictionary`2<BansheeGz.BGDatabase.BGId,BansheeGz.BGDatabase.BGFieldRelationA`2/ReverseRelationCacheValueI<T,TStoreType>> BansheeGz.BGDatabase.BGFieldRelationA`2/ReverseRelationCache<T,TStoreType>::reverseEntityId2Related
IL_0006: ldarg.1
IL_0007: ldloca.s V_0
IL_0009: callvirt System.Boolean System.Collections.Generic.Dictionary`2<BansheeGz.BGDatabase.BGId,BansheeGz.BGDatabase.BGFieldRelationA`2/ReverseRelationCacheValueI<T,TStoreType>>::TryGetValue(!0,!1&)
IL_000e: brfalse.s IL_0012
IL_0010: ldloc.0
IL_0011: ret
IL_0012: ldarg.0
IL_0013: ldfld System.Boolean BansheeGz.BGDatabase.BGFieldRelationA`2/ReverseRelationCache<T,TStoreType>::allowDuplicates
IL_0018: brtrue.s IL_0023
IL_001a: newobj System.Void BansheeGz.BGDatabase.BGFieldRelationA`2/ReverseRelationCacheValue<T,TStoreType>::.ctor()
IL_001f: stloc.1
IL_0020: ldloc.1
IL_0021: br.s IL_002a
IL_0023: newobj System.Void BansheeGz.BGDatabase.BGFieldRelationA`2/ReverseRelationCacheValueMulti<T,TStoreType>::.ctor()
IL_0028: stloc.1
IL_0029: ldloc.1
IL_002a: stloc.0
IL_002b: ldarg.0
IL_002c: ldfld System.Collections.Generic.Dictionary`2<BansheeGz.BGDatabase.BGId,BansheeGz.BGDatabase.BGFieldRelationA`2/ReverseRelationCacheValueI<T,TStoreType>> BansheeGz.BGDatabase.BGFieldRelationA`2/ReverseRelationCache<T,TStoreType>::reverseEntityId2Related
IL_0031: ldarg.1
IL_0032: ldloc.0
IL_0033: callvirt System.Void System.Collections.Generic.Dictionary`2<BansheeGz.BGDatabase.BGId,BansheeGz.BGDatabase.BGFieldRelationA`2/ReverseRelationCacheValueI<T,TStoreType>>::set_Item(!0,!1)
IL_0038: ldloc.0
IL_0039: ret
