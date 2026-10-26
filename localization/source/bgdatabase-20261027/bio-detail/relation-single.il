TYPE BansheeGz.BGDatabase.BGFieldRelationSingle
METHOD System.Void BansheeGz.BGDatabase.BGFieldRelationSingle::BuildReverseCache() | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld BansheeGz.BGDatabase.BGStoreField`1<TStoreType> BansheeGz.BGDatabase.BGFieldCachedA`2<BansheeGz.BGDatabase.BGEntity,BansheeGz.BGDatabase.BGId>::Store
IL_0006: ldarg.0
IL_0007: ldftn System.Void BansheeGz.BGDatabase.BGFieldRelationSingle::<BuildReverseCache>b__14_0(System.Int32,BansheeGz.BGDatabase.BGId)
IL_000d: newobj System.Void System.Action`2<System.Int32,BansheeGz.BGDatabase.BGId>::.ctor(System.Object,System.IntPtr)
IL_0012: callvirt System.Void BansheeGz.BGDatabase.BGStoreField`1<BansheeGz.BGDatabase.BGId>::ForEachKeyValue(System.Action`2<System.Int32,T>)
IL_0017: ret
METHOD System.Void BansheeGz.BGDatabase.BGFieldRelationSingle::ReverseSetRelated(System.Int32,BansheeGz.BGDatabase.BGId) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld BansheeGz.BGDatabase.BGFieldRelationA`2/ReverseRelationCache<T,TStoreType> BansheeGz.BGDatabase.BGFieldRelationA`2<BansheeGz.BGDatabase.BGEntity,BansheeGz.BGDatabase.BGId>::ReverseCache
IL_0006: callvirt System.Boolean BansheeGz.BGDatabase.BGFieldRelationA`2/ReverseRelationCache<BansheeGz.BGDatabase.BGEntity,BansheeGz.BGDatabase.BGId>::get_Enabled()
IL_000b: brtrue.s IL_000e
IL_000d: ret
IL_000e: ldarg.0
IL_000f: ldarg.1
IL_0010: call TStoreType BansheeGz.BGDatabase.BGFieldCachedA`2<BansheeGz.BGDatabase.BGEntity,BansheeGz.BGDatabase.BGId>::GetStoredValue(System.Int32)
IL_0015: stloc.0
IL_0016: ldarg.2
IL_0017: ldloc.0
IL_0018: call System.Boolean BansheeGz.BGDatabase.BGId::op_Equality(BansheeGz.BGDatabase.BGId,BansheeGz.BGDatabase.BGId)
IL_001d: brfalse.s IL_0020
IL_001f: ret
IL_0020: ldarg.0
IL_0021: ldfld BansheeGz.BGDatabase.BGFieldRelationA`2/ReverseRelationCache<T,TStoreType> BansheeGz.BGDatabase.BGFieldRelationA`2<BansheeGz.BGDatabase.BGEntity,BansheeGz.BGDatabase.BGId>::ReverseCache
IL_0026: ldarg.1
IL_0027: ldloc.0
IL_0028: callvirt System.Void BansheeGz.BGDatabase.BGFieldRelationA`2/ReverseRelationCache<BansheeGz.BGDatabase.BGEntity,BansheeGz.BGDatabase.BGId>::RemoveRelated(System.Int32,BansheeGz.BGDatabase.BGId)
IL_002d: ldarg.0
IL_002e: ldfld BansheeGz.BGDatabase.BGFieldRelationA`2/ReverseRelationCache<T,TStoreType> BansheeGz.BGDatabase.BGFieldRelationA`2<BansheeGz.BGDatabase.BGEntity,BansheeGz.BGDatabase.BGId>::ReverseCache
IL_0033: ldarg.1
IL_0034: ldarg.2
IL_0035: callvirt System.Void BansheeGz.BGDatabase.BGFieldRelationA`2/ReverseRelationCache<BansheeGz.BGDatabase.BGEntity,BansheeGz.BGDatabase.BGId>::AddRelated(System.Int32,BansheeGz.BGDatabase.BGId)
IL_003a: ret
METHOD System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity> BansheeGz.BGDatabase.BGFieldRelationSingle::GetRelatedIn(BansheeGz.BGDatabase.BGId,System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity>) | attributes=Public, Virtual, HideBySig | impl=IL
IL_0000: newobj System.Void BansheeGz.BGDatabase.BGFieldRelationSingle/<>c__DisplayClass19_0::.ctor()
IL_0005: stloc.0
IL_0006: ldloc.0
IL_0007: ldarg.1
IL_0008: stfld BansheeGz.BGDatabase.BGId BansheeGz.BGDatabase.BGFieldRelationSingle/<>c__DisplayClass19_0::entityId
IL_000d: ldloc.0
IL_000e: ldarg.0
IL_000f: stfld BansheeGz.BGDatabase.BGFieldRelationSingle BansheeGz.BGDatabase.BGFieldRelationSingle/<>c__DisplayClass19_0::<>4__this
IL_0014: ldloc.0
IL_0015: ldarg.2
IL_0016: stfld System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity> BansheeGz.BGDatabase.BGFieldRelationSingle/<>c__DisplayClass19_0::result
IL_001b: ldarg.0
IL_001c: ldfld BansheeGz.BGDatabase.BGFieldRelationA`2/ReverseRelationCache<T,TStoreType> BansheeGz.BGDatabase.BGFieldRelationA`2<BansheeGz.BGDatabase.BGEntity,BansheeGz.BGDatabase.BGId>::ReverseCache
IL_0021: ldc.i4.1
IL_0022: callvirt System.Void BansheeGz.BGDatabase.BGFieldRelationA`2/ReverseRelationCache<BansheeGz.BGDatabase.BGEntity,BansheeGz.BGDatabase.BGId>::Enable(System.Boolean)
IL_0027: ldarg.0
IL_0028: ldfld BansheeGz.BGDatabase.BGFieldRelationA`2/ReverseRelationCache<T,TStoreType> BansheeGz.BGDatabase.BGFieldRelationA`2<BansheeGz.BGDatabase.BGEntity,BansheeGz.BGDatabase.BGId>::ReverseCache
IL_002d: callvirt System.Boolean BansheeGz.BGDatabase.BGFieldRelationA`2/ReverseRelationCache<BansheeGz.BGDatabase.BGEntity,BansheeGz.BGDatabase.BGId>::get_Enabled()
IL_0032: brfalse.s IL_0082
IL_0034: ldarg.0
IL_0035: ldfld BansheeGz.BGDatabase.BGFieldRelationA`2/ReverseRelationCache<T,TStoreType> BansheeGz.BGDatabase.BGFieldRelationA`2<BansheeGz.BGDatabase.BGEntity,BansheeGz.BGDatabase.BGId>::ReverseCache
IL_003a: ldloc.0
IL_003b: ldfld BansheeGz.BGDatabase.BGId BansheeGz.BGDatabase.BGFieldRelationSingle/<>c__DisplayClass19_0::entityId
IL_0040: callvirt System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity> BansheeGz.BGDatabase.BGFieldRelationA`2/ReverseRelationCache<BansheeGz.BGDatabase.BGEntity,BansheeGz.BGDatabase.BGId>::Get(BansheeGz.BGDatabase.BGId)
IL_0045: stloc.1
IL_0046: ldloc.0
IL_0047: ldfld System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity> BansheeGz.BGDatabase.BGFieldRelationSingle/<>c__DisplayClass19_0::result
IL_004c: brfalse.s IL_006a
IL_004e: ldloc.0
IL_004f: ldfld System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity> BansheeGz.BGDatabase.BGFieldRelationSingle/<>c__DisplayClass19_0::result
IL_0054: callvirt System.Void System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity>::Clear()
IL_0059: ldloc.1
IL_005a: brfalse.s IL_00b9
IL_005c: ldloc.0
IL_005d: ldfld System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity> BansheeGz.BGDatabase.BGFieldRelationSingle/<>c__DisplayClass19_0::result
IL_0062: ldloc.1
IL_0063: callvirt System.Void System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity>::AddRange(System.Collections.Generic.IEnumerable`1<!0>)
IL_0068: br.s IL_00b9
IL_006a: ldloc.0
IL_006b: ldloc.1
IL_006c: brfalse.s IL_0076
IL_006e: ldloc.1
IL_006f: newobj System.Void System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity>::.ctor(System.Collections.Generic.IEnumerable`1<!0>)
IL_0074: br.s IL_007b
IL_0076: newobj System.Void System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity>::.ctor()
IL_007b: stfld System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity> BansheeGz.BGDatabase.BGFieldRelationSingle/<>c__DisplayClass19_0::result
IL_0080: br.s IL_00b9
IL_0082: ldloc.0
IL_0083: ldloc.0
IL_0084: ldfld System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity> BansheeGz.BGDatabase.BGFieldRelationSingle/<>c__DisplayClass19_0::result
IL_0089: dup
IL_008a: brtrue.s IL_0092
IL_008c: pop
IL_008d: newobj System.Void System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity>::.ctor()
IL_0092: stfld System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity> BansheeGz.BGDatabase.BGFieldRelationSingle/<>c__DisplayClass19_0::result
IL_0097: ldloc.0
IL_0098: ldfld System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity> BansheeGz.BGDatabase.BGFieldRelationSingle/<>c__DisplayClass19_0::result
IL_009d: callvirt System.Void System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity>::Clear()
IL_00a2: ldarg.0
IL_00a3: ldfld BansheeGz.BGDatabase.BGStoreField`1<TStoreType> BansheeGz.BGDatabase.BGFieldCachedA`2<BansheeGz.BGDatabase.BGEntity,BansheeGz.BGDatabase.BGId>::Store
IL_00a8: ldloc.0
IL_00a9: ldftn System.Void BansheeGz.BGDatabase.BGFieldRelationSingle/<>c__DisplayClass19_0::<GetRelatedIn>b__0(System.Int32,BansheeGz.BGDatabase.BGId)
IL_00af: newobj System.Void System.Action`2<System.Int32,BansheeGz.BGDatabase.BGId>::.ctor(System.Object,System.IntPtr)
IL_00b4: callvirt System.Void BansheeGz.BGDatabase.BGStoreField`1<BansheeGz.BGDatabase.BGId>::ForEachKeyValue(System.Action`2<System.Int32,T>)
IL_00b9: ldloc.0
IL_00ba: ldfld System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity> BansheeGz.BGDatabase.BGFieldRelationSingle/<>c__DisplayClass19_0::result
IL_00bf: ret
METHOD System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity> BansheeGz.BGDatabase.BGFieldRelationSingle::GetRelatedIn(System.Collections.Generic.HashSet`1<BansheeGz.BGDatabase.BGId>,System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity>) | attributes=Public, Virtual, HideBySig | impl=IL
IL_0000: newobj System.Void BansheeGz.BGDatabase.BGFieldRelationSingle/<>c__DisplayClass20_0::.ctor()
IL_0005: stloc.0
IL_0006: ldloc.0
IL_0007: ldarg.1
IL_0008: stfld System.Collections.Generic.HashSet`1<BansheeGz.BGDatabase.BGId> BansheeGz.BGDatabase.BGFieldRelationSingle/<>c__DisplayClass20_0::entityIds
IL_000d: ldloc.0
IL_000e: ldarg.0
IL_000f: stfld BansheeGz.BGDatabase.BGFieldRelationSingle BansheeGz.BGDatabase.BGFieldRelationSingle/<>c__DisplayClass20_0::<>4__this
IL_0014: ldloc.0
IL_0015: ldarg.2
IL_0016: stfld System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity> BansheeGz.BGDatabase.BGFieldRelationSingle/<>c__DisplayClass20_0::result
IL_001b: ldloc.0
IL_001c: ldfld System.Collections.Generic.HashSet`1<BansheeGz.BGDatabase.BGId> BansheeGz.BGDatabase.BGFieldRelationSingle/<>c__DisplayClass20_0::entityIds
IL_0021: brfalse.s IL_0030
IL_0023: ldloc.0
IL_0024: ldfld System.Collections.Generic.HashSet`1<BansheeGz.BGDatabase.BGId> BansheeGz.BGDatabase.BGFieldRelationSingle/<>c__DisplayClass20_0::entityIds
IL_0029: callvirt System.Int32 System.Collections.Generic.HashSet`1<BansheeGz.BGDatabase.BGId>::get_Count()
IL_002e: brtrue.s IL_004a
IL_0030: ldloc.0
IL_0031: ldfld System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity> BansheeGz.BGDatabase.BGFieldRelationSingle/<>c__DisplayClass20_0::result
IL_0036: brfalse.s IL_0043
IL_0038: ldloc.0
IL_0039: ldfld System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity> BansheeGz.BGDatabase.BGFieldRelationSingle/<>c__DisplayClass20_0::result
IL_003e: callvirt System.Void System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity>::Clear()
IL_0043: ldloc.0
IL_0044: ldfld System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity> BansheeGz.BGDatabase.BGFieldRelationSingle/<>c__DisplayClass20_0::result
IL_0049: ret
IL_004a: ldarg.0
IL_004b: ldfld BansheeGz.BGDatabase.BGFieldRelationA`2/ReverseRelationCache<T,TStoreType> BansheeGz.BGDatabase.BGFieldRelationA`2<BansheeGz.BGDatabase.BGEntity,BansheeGz.BGDatabase.BGId>::ReverseCache
IL_0050: ldc.i4.1
IL_0051: callvirt System.Void BansheeGz.BGDatabase.BGFieldRelationA`2/ReverseRelationCache<BansheeGz.BGDatabase.BGEntity,BansheeGz.BGDatabase.BGId>::Enable(System.Boolean)
IL_0056: ldarg.0
IL_0057: ldfld BansheeGz.BGDatabase.BGFieldRelationA`2/ReverseRelationCache<T,TStoreType> BansheeGz.BGDatabase.BGFieldRelationA`2<BansheeGz.BGDatabase.BGEntity,BansheeGz.BGDatabase.BGId>::ReverseCache
IL_005c: callvirt System.Boolean BansheeGz.BGDatabase.BGFieldRelationA`2/ReverseRelationCache<BansheeGz.BGDatabase.BGEntity,BansheeGz.BGDatabase.BGId>::get_Enabled()
IL_0061: brfalse IL_0112
IL_0066: newobj System.Void System.Collections.Generic.HashSet`1<BansheeGz.BGDatabase.BGEntity>::.ctor()
IL_006b: stloc.1
IL_006c: ldloc.0
IL_006d: ldfld System.Collections.Generic.HashSet`1<BansheeGz.BGDatabase.BGId> BansheeGz.BGDatabase.BGFieldRelationSingle/<>c__DisplayClass20_0::entityIds
IL_0072: callvirt System.Collections.Generic.HashSet`1/Enumerator<!0> System.Collections.Generic.HashSet`1<BansheeGz.BGDatabase.BGId>::GetEnumerator()
IL_0077: stloc.2
IL_0078: br.s IL_00ca
IL_007a: ldloca.s V_2
IL_007c: call !0 System.Collections.Generic.HashSet`1/Enumerator<BansheeGz.BGDatabase.BGId>::get_Current()
IL_0081: stloc.3
IL_0082: ldarg.0
IL_0083: ldfld BansheeGz.BGDatabase.BGFieldRelationA`2/ReverseRelationCache<T,TStoreType> BansheeGz.BGDatabase.BGFieldRelationA`2<BansheeGz.BGDatabase.BGEntity,BansheeGz.BGDatabase.BGId>::ReverseCache
IL_0088: ldloc.3
IL_0089: callvirt System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity> BansheeGz.BGDatabase.BGFieldRelationA`2/ReverseRelationCache<BansheeGz.BGDatabase.BGEntity,BansheeGz.BGDatabase.BGId>::Get(BansheeGz.BGDatabase.BGId)
IL_008e: stloc.s V_4
IL_0090: ldloc.s V_4
IL_0092: brfalse.s IL_00ca
IL_0094: ldloc.s V_4
IL_0096: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity>::GetEnumerator()
IL_009b: stloc.s V_5
IL_009d: br.s IL_00b1
IL_009f: ldloca.s V_5
IL_00a1: call !0 System.Collections.Generic.List`1/Enumerator<BansheeGz.BGDatabase.BGEntity>::get_Current()
IL_00a6: stloc.s V_6
IL_00a8: ldloc.1
IL_00a9: ldloc.s V_6
IL_00ab: callvirt System.Boolean System.Collections.Generic.HashSet`1<BansheeGz.BGDatabase.BGEntity>::Add(!0)
IL_00b0: pop
IL_00b1: ldloca.s V_5
IL_00b3: call System.Boolean System.Collections.Generic.List`1/Enumerator<BansheeGz.BGDatabase.BGEntity>::MoveNext()
IL_00b8: brtrue.s IL_009f
IL_00ba: leave.s IL_00ca
IL_00bc: ldloca.s V_5
IL_00be: constrained. System.Collections.Generic.List`1/Enumerator<BansheeGz.BGDatabase.BGEntity>
IL_00c4: callvirt System.Void System.IDisposable::Dispose()
IL_00c9: endfinally
IL_00ca: ldloca.s V_2
IL_00cc: call System.Boolean System.Collections.Generic.HashSet`1/Enumerator<BansheeGz.BGDatabase.BGId>::MoveNext()
IL_00d1: brtrue.s IL_007a
IL_00d3: leave.s IL_00e3
IL_00d5: ldloca.s V_2
IL_00d7: constrained. System.Collections.Generic.HashSet`1/Enumerator<BansheeGz.BGDatabase.BGId>
IL_00dd: callvirt System.Void System.IDisposable::Dispose()
IL_00e2: endfinally
IL_00e3: ldloc.0
IL_00e4: ldfld System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity> BansheeGz.BGDatabase.BGFieldRelationSingle/<>c__DisplayClass20_0::result
IL_00e9: brtrue.s IL_00f9
IL_00eb: ldloc.0
IL_00ec: ldloc.1
IL_00ed: newobj System.Void System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity>::.ctor(System.Collections.Generic.IEnumerable`1<!0>)
IL_00f2: stfld System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity> BansheeGz.BGDatabase.BGFieldRelationSingle/<>c__DisplayClass20_0::result
IL_00f7: br.s IL_0149
IL_00f9: ldloc.0
IL_00fa: ldfld System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity> BansheeGz.BGDatabase.BGFieldRelationSingle/<>c__DisplayClass20_0::result
IL_00ff: callvirt System.Void System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity>::Clear()
IL_0104: ldloc.0
IL_0105: ldfld System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity> BansheeGz.BGDatabase.BGFieldRelationSingle/<>c__DisplayClass20_0::result
IL_010a: ldloc.1
IL_010b: callvirt System.Void System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity>::AddRange(System.Collections.Generic.IEnumerable`1<!0>)
IL_0110: br.s IL_0149
IL_0112: ldloc.0
IL_0113: ldloc.0
IL_0114: ldfld System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity> BansheeGz.BGDatabase.BGFieldRelationSingle/<>c__DisplayClass20_0::result
IL_0119: dup
IL_011a: brtrue.s IL_0122
IL_011c: pop
IL_011d: newobj System.Void System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity>::.ctor()
IL_0122: stfld System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity> BansheeGz.BGDatabase.BGFieldRelationSingle/<>c__DisplayClass20_0::result
IL_0127: ldloc.0
IL_0128: ldfld System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity> BansheeGz.BGDatabase.BGFieldRelationSingle/<>c__DisplayClass20_0::result
IL_012d: callvirt System.Void System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity>::Clear()
IL_0132: ldarg.0
IL_0133: ldfld BansheeGz.BGDatabase.BGStoreField`1<TStoreType> BansheeGz.BGDatabase.BGFieldCachedA`2<BansheeGz.BGDatabase.BGEntity,BansheeGz.BGDatabase.BGId>::Store
IL_0138: ldloc.0
IL_0139: ldftn System.Void BansheeGz.BGDatabase.BGFieldRelationSingle/<>c__DisplayClass20_0::<GetRelatedIn>b__0(System.Int32,BansheeGz.BGDatabase.BGId)
IL_013f: newobj System.Void System.Action`2<System.Int32,BansheeGz.BGDatabase.BGId>::.ctor(System.Object,System.IntPtr)
IL_0144: callvirt System.Void BansheeGz.BGDatabase.BGStoreField`1<BansheeGz.BGDatabase.BGId>::ForEachKeyValue(System.Action`2<System.Int32,T>)
IL_0149: ldloc.0
IL_014a: ldfld System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity> BansheeGz.BGDatabase.BGFieldRelationSingle/<>c__DisplayClass20_0::result
IL_014f: ret
METHOD System.Void BansheeGz.BGDatabase.BGFieldRelationSingle::<BuildReverseCache>b__14_0(System.Int32,BansheeGz.BGDatabase.BGId) | attributes=Private, HideBySig | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldarga.s val
IL_0002: call System.Boolean BansheeGz.BGDatabase.BGId::get_IsEmpty()
IL_0007: brfalse.s IL_000a
IL_0009: ret
IL_000a: ldarg.0
IL_000b: ldfld BansheeGz.BGDatabase.BGFieldRelationA`2/ReverseRelationCache<T,TStoreType> BansheeGz.BGDatabase.BGFieldRelationA`2<BansheeGz.BGDatabase.BGEntity,BansheeGz.BGDatabase.BGId>::ReverseCache
IL_0010: ldarg.2
IL_0011: callvirt BansheeGz.BGDatabase.BGFieldRelationA`2/ReverseRelationCacheValueI<T,TStoreType> BansheeGz.BGDatabase.BGFieldRelationA`2/ReverseRelationCache<BansheeGz.BGDatabase.BGEntity,BansheeGz.BGDatabase.BGId>::Ensure(BansheeGz.BGDatabase.BGId)
IL_0016: ldarg.0
IL_0017: call BansheeGz.BGDatabase.BGMetaEntity BansheeGz.BGDatabase.BGField::get_Meta()
IL_001c: ldarg.1
IL_001d: callvirt BansheeGz.BGDatabase.BGEntity BansheeGz.BGDatabase.BGMetaEntity::get_Item(System.Int32)
IL_0022: callvirt System.Void BansheeGz.BGDatabase.BGFieldRelationA`2/ReverseRelationCacheValueI<BansheeGz.BGDatabase.BGEntity,BansheeGz.BGDatabase.BGId>::Add(BansheeGz.BGDatabase.BGEntity)
IL_0027: ret
