TYPE BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass4_0
METHOD System.Void BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass4_0::<ReadMetas>b__0() | attributes=Assembly, HideBySig | impl=IL
IL_0000: newobj System.Void BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass4_1::.ctor()
IL_0005: stloc.0
IL_0006: ldloc.0
IL_0007: ldarg.0
IL_0008: stfld BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass4_0 BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass4_1::CS$<>8__locals1
IL_000d: ldloc.0
IL_000e: ldarg.0
IL_000f: ldfld BansheeGz.BGDatabase.BGBinaryReader BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass4_0::binder
IL_0014: ldarg.0
IL_0015: ldfld BansheeGz.BGDatabase.BGRepo BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass4_0::repo
IL_001a: call BansheeGz.BGDatabase.BGMetaEntity BansheeGz.BGDatabase.BGMetaEntity::FromBinary(BansheeGz.BGDatabase.BGBinaryReader,BansheeGz.BGDatabase.BGRepo)
IL_001f: stfld BansheeGz.BGDatabase.BGMetaEntity BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass4_1::meta
IL_0024: ldarg.0
IL_0025: ldfld BansheeGz.BGDatabase.BGBinaryReader BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass4_0::binder
IL_002a: callvirt System.ArraySegment`1<System.Byte> BansheeGz.BGDatabase.BGBinaryReader::ReadByteArray()
IL_002f: stloc.1
IL_0030: ldloca.s V_1
IL_0032: call System.Int32 System.ArraySegment`1<System.Byte>::get_Count()
IL_0037: brfalse.s IL_0045
IL_0039: ldloca.s V_1
IL_003b: call System.Int32 System.ArraySegment`1<System.Byte>::get_Count()
IL_0040: ldc.i4.s 16
IL_0042: div
IL_0043: br.s IL_0046
IL_0045: ldc.i4.0
IL_0046: stloc.2
IL_0047: ldloc.2
IL_0048: ldc.i4.0
IL_0049: ble.s IL_0093
IL_004b: ldloc.0
IL_004c: ldfld BansheeGz.BGDatabase.BGMetaEntity BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass4_1::meta
IL_0051: ldloc.2
IL_0052: callvirt System.Void BansheeGz.BGDatabase.BGMetaEntity::set_EntitiesCapacity(System.Int32)
IL_0057: ldloca.s V_1
IL_0059: call !0[] System.ArraySegment`1<System.Byte>::get_Array()
IL_005e: stloc.3
IL_005f: ldloca.s V_1
IL_0061: call System.Int32 System.ArraySegment`1<System.Byte>::get_Offset()
IL_0066: dup
IL_0067: ldloc.2
IL_0068: ldc.i4.s 16
IL_006a: mul
IL_006b: add
IL_006c: stloc.s V_4
IL_006e: stloc.s V_5
IL_0070: br.s IL_008d
IL_0072: ldloc.0
IL_0073: ldfld BansheeGz.BGDatabase.BGMetaEntity BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass4_1::meta
IL_0078: ldloc.3
IL_0079: ldloc.s V_5
IL_007b: newobj System.Void BansheeGz.BGDatabase.BGId::.ctor(System.Byte[],System.Int32)
IL_0080: callvirt BansheeGz.BGDatabase.BGEntity BansheeGz.BGDatabase.BGMetaEntity::NewEntity(BansheeGz.BGDatabase.BGId)
IL_0085: pop
IL_0086: ldloc.s V_5
IL_0088: ldc.i4.s 16
IL_008a: add
IL_008b: stloc.s V_5
IL_008d: ldloc.s V_5
IL_008f: ldloc.s V_4
IL_0091: blt.s IL_0072
IL_0093: ldloc.0
IL_0094: ldarg.0
IL_0095: ldfld System.Boolean BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass4_0::lazyLoadEnabled
IL_009a: brtrue.s IL_009f
IL_009c: ldnull
IL_009d: br.s IL_00b6
IL_009f: ldloc.0
IL_00a0: ldfld BansheeGz.BGDatabase.BGMetaEntity BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass4_1::meta
IL_00a5: ldloc.0
IL_00a6: ldfld BansheeGz.BGDatabase.BGMetaEntity BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass4_1::meta
IL_00ab: ldnull
IL_00ac: callvirt System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity> BansheeGz.BGDatabase.BGMetaEntity::EntitiesToList(System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity>)
IL_00b1: newobj System.Void BansheeGz.BGDatabase.BGLazyLoaderMeta::.ctor(BansheeGz.BGDatabase.BGMetaEntity,System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity>)
IL_00b6: stfld BansheeGz.BGDatabase.BGLazyLoaderMeta BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass4_1::loader
IL_00bb: ldarg.0
IL_00bc: ldfld BansheeGz.BGDatabase.BGBinaryReader BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass4_0::binder
IL_00c1: ldloc.0
IL_00c2: ldftn System.Void BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass4_1::<ReadMetas>b__1()
IL_00c8: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_00cd: callvirt System.Void BansheeGz.BGDatabase.BGBinaryReader::ReadArray(System.Action)
IL_00d2: ldarg.0
IL_00d3: ldfld BansheeGz.BGDatabase.BGBinaryReader BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass4_0::binder
IL_00d8: ldloc.0
IL_00d9: ldftn System.Void BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass4_1::<ReadMetas>b__2()
IL_00df: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_00e4: callvirt System.Void BansheeGz.BGDatabase.BGBinaryReader::ReadArray(System.Action)
IL_00e9: ret
