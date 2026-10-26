TYPE BansheeGz.BGDatabase.BGFieldRelationA`2/ReverseRelationCacheValue
METHOD System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity> BansheeGz.BGDatabase.BGFieldRelationA`2/ReverseRelationCacheValue::get_List() | attributes=Public, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Boolean BansheeGz.BGDatabase.BGFieldRelationA`2/ReverseRelationCacheValue<T,TStoreType>::isDirty
IL_0006: brfalse.s IL_0036
IL_0008: ldarg.0
IL_0009: ldc.i4.0
IL_000a: stfld System.Boolean BansheeGz.BGDatabase.BGFieldRelationA`2/ReverseRelationCacheValue<T,TStoreType>::isDirty
IL_000f: ldarg.0
IL_0010: ldfld System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity> BansheeGz.BGDatabase.BGFieldRelationA`2/ReverseRelationCacheValue<T,TStoreType>::list
IL_0015: callvirt System.Void System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity>::Clear()
IL_001a: ldarg.0
IL_001b: ldfld System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity> BansheeGz.BGDatabase.BGFieldRelationA`2/ReverseRelationCacheValue<T,TStoreType>::list
IL_0020: ldarg.0
IL_0021: ldfld System.Collections.Generic.HashSet`1<BansheeGz.BGDatabase.BGEntity> BansheeGz.BGDatabase.BGFieldRelationA`2/ReverseRelationCacheValue<T,TStoreType>::set
IL_0026: callvirt System.Void System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity>::AddRange(System.Collections.Generic.IEnumerable`1<!0>)
IL_002b: ldarg.0
IL_002c: ldfld System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity> BansheeGz.BGDatabase.BGFieldRelationA`2/ReverseRelationCacheValue<T,TStoreType>::list
IL_0031: callvirt System.Void System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity>::Sort()
IL_0036: ldarg.0
IL_0037: ldfld System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity> BansheeGz.BGDatabase.BGFieldRelationA`2/ReverseRelationCacheValue<T,TStoreType>::list
IL_003c: ret
METHOD System.Void BansheeGz.BGDatabase.BGFieldRelationA`2/ReverseRelationCacheValue::.ctor() | attributes=Assembly, HideBySig, SpecialName, RTSpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: newobj System.Void System.Collections.Generic.HashSet`1<BansheeGz.BGDatabase.BGEntity>::.ctor()
IL_0006: stfld System.Collections.Generic.HashSet`1<BansheeGz.BGDatabase.BGEntity> BansheeGz.BGDatabase.BGFieldRelationA`2/ReverseRelationCacheValue<T,TStoreType>::set
IL_000b: ldarg.0
IL_000c: newobj System.Void System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity>::.ctor()
IL_0011: stfld System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity> BansheeGz.BGDatabase.BGFieldRelationA`2/ReverseRelationCacheValue<T,TStoreType>::list
IL_0016: ldarg.0
IL_0017: call System.Void System.Object::.ctor()
IL_001c: ret
METHOD System.Void BansheeGz.BGDatabase.BGFieldRelationA`2/ReverseRelationCacheValue::Add(BansheeGz.BGDatabase.BGEntity) | attributes=Public, Final, Virtual, HideBySig, VtableLayoutMask | impl=IL
IL_0000: ldarg.1
IL_0001: brtrue.s IL_0004
IL_0003: ret
IL_0004: ldarg.0
IL_0005: ldfld System.Collections.Generic.HashSet`1<BansheeGz.BGDatabase.BGEntity> BansheeGz.BGDatabase.BGFieldRelationA`2/ReverseRelationCacheValue<T,TStoreType>::set
IL_000a: ldarg.1
IL_000b: callvirt System.Boolean System.Collections.Generic.HashSet`1<BansheeGz.BGDatabase.BGEntity>::Add(!0)
IL_0010: brtrue.s IL_0013
IL_0012: ret
IL_0013: ldarg.0
IL_0014: call System.Void BansheeGz.BGDatabase.BGFieldRelationA`2/ReverseRelationCacheValue<T,TStoreType>::MarkDirty()
IL_0019: ret
METHOD System.Void BansheeGz.BGDatabase.BGFieldRelationA`2/ReverseRelationCacheValue::MarkDirty() | attributes=Public, Final, Virtual, HideBySig, VtableLayoutMask | impl=IL
IL_0000: ldarg.0
IL_0001: ldc.i4.1
IL_0002: stfld System.Boolean BansheeGz.BGDatabase.BGFieldRelationA`2/ReverseRelationCacheValue<T,TStoreType>::isDirty
IL_0007: ldarg.0
IL_0008: ldfld System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity> BansheeGz.BGDatabase.BGFieldRelationA`2/ReverseRelationCacheValue<T,TStoreType>::list
IL_000d: callvirt System.Void System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity>::Clear()
IL_0012: ret
