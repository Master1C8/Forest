TYPE BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass4_1
METHOD System.Void BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass4_1::<ReadMetas>b__1() | attributes=Assembly, HideBySig | impl=IL
IL_0000: newobj System.Void BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass4_2::.ctor()
IL_0005: stloc.0
IL_0006: ldloc.0
IL_0007: ldarg.0
IL_0008: stfld BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass4_1 BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass4_2::CS$<>8__locals2
IL_000d: ldloc.0
IL_000e: ldarg.0
IL_000f: ldfld BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass4_0 BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass4_1::CS$<>8__locals1
IL_0014: ldfld BansheeGz.BGDatabase.BGBinaryReader BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass4_0::binder
IL_0019: ldarg.0
IL_001a: ldfld BansheeGz.BGDatabase.BGMetaEntity BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass4_1::meta
IL_001f: call BansheeGz.BGDatabase.BGField BansheeGz.BGDatabase.BGField::FromBinary(BansheeGz.BGDatabase.BGBinaryReader,BansheeGz.BGDatabase.BGMetaEntity)
IL_0024: stfld BansheeGz.BGDatabase.BGField BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass4_2::field
IL_0029: ldloc.0
IL_002a: ldarg.0
IL_002b: ldfld BansheeGz.BGDatabase.BGMetaEntity BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass4_1::meta
IL_0030: callvirt System.Int32 BansheeGz.BGDatabase.BGMetaEntity::get_CountEntities()
IL_0035: stfld System.Int32 BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass4_2::entitiesCount
IL_003a: ldloc.0
IL_003b: ldarg.0
IL_003c: ldfld BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass4_0 BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass4_1::CS$<>8__locals1
IL_0041: ldfld BansheeGz.BGDatabase.BGBinaryReader BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass4_0::binder
IL_0046: callvirt System.ArraySegment`1<System.Byte> BansheeGz.BGDatabase.BGBinaryReader::ReadByteArray()
IL_004b: stfld System.ArraySegment`1<System.Byte> BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass4_2::fieldValues
IL_0050: ldloc.0
IL_0051: ldflda System.ArraySegment`1<System.Byte> BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass4_2::fieldValues
IL_0056: call System.Int32 System.ArraySegment`1<System.Byte>::get_Count()
IL_005b: ldc.i4.0
IL_005c: ble IL_0118
IL_0061: ldarg.0
IL_0062: ldfld BansheeGz.BGDatabase.BGLazyLoaderMeta BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass4_1::loader
IL_0067: brfalse.s IL_00bd
IL_0069: ldloc.0
IL_006a: ldfld BansheeGz.BGDatabase.BGField BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass4_2::field
IL_006f: callvirt System.Int32 BansheeGz.BGDatabase.BGField::get_ConstantSize()
IL_0074: ldc.i4.0
IL_0075: ble.s IL_009a
IL_0077: ldloc.0
IL_0078: ldfld BansheeGz.BGDatabase.BGField BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass4_2::field
IL_007d: ldloc.0
IL_007e: ldfld BansheeGz.BGDatabase.BGField BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass4_2::field
IL_0083: ldloc.0
IL_0084: ldfld System.ArraySegment`1<System.Byte> BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass4_2::fieldValues
IL_0089: ldarg.0
IL_008a: ldfld BansheeGz.BGDatabase.BGLazyLoaderMeta BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass4_1::loader
IL_008f: newobj System.Void BansheeGz.BGDatabase.BGLazyLoaderFieldConstantSize::.ctor(BansheeGz.BGDatabase.BGField,System.ArraySegment`1<System.Byte>,BansheeGz.BGDatabase.BGLazyLoaderMeta)
IL_0094: callvirt System.Void BansheeGz.BGDatabase.BGField::set_Loader(BansheeGz.BGDatabase.BGLazyLoaderFieldI)
IL_0099: ret
IL_009a: ldloc.0
IL_009b: ldfld BansheeGz.BGDatabase.BGField BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass4_2::field
IL_00a0: ldloc.0
IL_00a1: ldfld BansheeGz.BGDatabase.BGField BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass4_2::field
IL_00a6: ldloc.0
IL_00a7: ldfld System.ArraySegment`1<System.Byte> BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass4_2::fieldValues
IL_00ac: ldarg.0
IL_00ad: ldfld BansheeGz.BGDatabase.BGLazyLoaderMeta BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass4_1::loader
IL_00b2: newobj System.Void BansheeGz.BGDatabase.BGLazyLoaderFieldVariantSize::.ctor(BansheeGz.BGDatabase.BGField,System.ArraySegment`1<System.Byte>,BansheeGz.BGDatabase.BGLazyLoaderMeta)
IL_00b7: callvirt System.Void BansheeGz.BGDatabase.BGField::set_Loader(BansheeGz.BGDatabase.BGLazyLoaderFieldI)
IL_00bc: ret
IL_00bd: ldarg.0
IL_00be: ldfld BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass4_0 BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass4_1::CS$<>8__locals1
IL_00c3: ldfld System.Boolean BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass4_0::multithreaded
IL_00c8: brfalse.s IL_00f5
IL_00ca: ldarg.0
IL_00cb: ldfld BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass4_0 BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass4_1::CS$<>8__locals1
IL_00d0: ldfld BansheeGz.BGDatabase.BGMultiThreadedLoader BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass4_0::multiThreadedLoader
IL_00d5: ldloc.0
IL_00d6: ldftn System.Void BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass4_2::<ReadMetas>b__3()
IL_00dc: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_00e1: ldloc.0
IL_00e2: ldfld BansheeGz.BGDatabase.BGField BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass4_2::field
IL_00e7: callvirt System.Boolean BansheeGz.BGDatabase.BGField::get_SupportMultiThreadedLoading()
IL_00ec: ldc.i4.0
IL_00ed: ceq
IL_00ef: callvirt System.Void BansheeGz.BGDatabase.BGMultiThreadedLoader::AddAction(System.Action,System.Boolean)
IL_00f4: ret
IL_00f5: ldloc.0
IL_00f6: ldfld System.ArraySegment`1<System.Byte> BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass4_2::fieldValues
IL_00fb: ldloc.0
IL_00fc: ldfld BansheeGz.BGDatabase.BGField BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass4_2::field
IL_0101: ldloc.0
IL_0102: ldfld System.Int32 BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass4_2::entitiesCount
IL_0107: ldloc.0
IL_0108: ldftn System.Void BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass4_2::<ReadMetas>b__4(System.Exception)
IL_010e: newobj System.Void System.Action`1<System.Exception>::.ctor(System.Object,System.IntPtr)
IL_0113: call System.Void BansheeGz.BGDatabase.BGRepoBinaryV5::ReadFieldValues(System.ArraySegment`1<System.Byte>,BansheeGz.BGDatabase.BGField,System.Int32,System.Action`1<System.Exception>)
IL_0118: ret
METHOD System.Void BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass4_1::<ReadMetas>b__2() | attributes=Assembly, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass4_0 BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass4_1::CS$<>8__locals1
IL_0006: ldfld BansheeGz.BGDatabase.BGBinaryReader BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass4_0::binder
IL_000b: ldarg.0
IL_000c: ldfld BansheeGz.BGDatabase.BGMetaEntity BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass4_1::meta
IL_0011: call BansheeGz.BGDatabase.BGKey BansheeGz.BGDatabase.BGKey::FromBinary(BansheeGz.BGDatabase.BGBinaryReader,BansheeGz.BGDatabase.BGMetaEntity)
IL_0016: pop
IL_0017: ret
