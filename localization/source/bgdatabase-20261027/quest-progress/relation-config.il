TYPE BansheeGz.BGDatabase.BGFieldRelationA`2
METHOD System.Byte[] BansheeGz.BGDatabase.BGFieldRelationA`2::ConfigToBytes() | attributes=Public, Virtual, HideBySig | impl=IL
IL_0000: ldc.i4.s 20
IL_0002: newobj System.Void BansheeGz.BGDatabase.BGBinaryWriter::.ctor(System.Int32)
IL_0007: dup
IL_0008: ldc.i4.1
IL_0009: callvirt System.Void BansheeGz.BGDatabase.BGBinaryWriter::AddInt(System.Int32)
IL_000e: dup
IL_000f: ldarg.0
IL_0010: ldfld BansheeGz.BGDatabase.BGId BansheeGz.BGDatabase.BGFieldRelationA`2<T,TStoreType>::toId
IL_0015: callvirt System.Void BansheeGz.BGDatabase.BGBinaryWriter::AddId(BansheeGz.BGDatabase.BGId)
IL_001a: callvirt System.Byte[] BansheeGz.BGDatabase.BGBinaryWriter::ToArray()
IL_001f: ret
METHOD System.Void BansheeGz.BGDatabase.BGFieldRelationA`2::ConfigFromBytes(System.ArraySegment`1<System.Byte>) | attributes=Public, Virtual, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: newobj System.Void BansheeGz.BGDatabase.BGBinaryReader::.ctor(System.ArraySegment`1<System.Byte>)
IL_0006: stloc.0
IL_0007: ldloc.0
IL_0008: callvirt System.Int32 BansheeGz.BGDatabase.BGBinaryReader::ReadInt()
IL_000d: stloc.1
IL_000e: ldloc.1
IL_000f: ldc.i4.1
IL_0010: bne.un.s IL_001f
IL_0012: ldarg.0
IL_0013: ldloc.0
IL_0014: callvirt BansheeGz.BGDatabase.BGId BansheeGz.BGDatabase.BGBinaryReader::ReadId()
IL_0019: stfld BansheeGz.BGDatabase.BGId BansheeGz.BGDatabase.BGFieldRelationA`2<T,TStoreType>::toId
IL_001e: ret
IL_001f: ldstr "Unknown version: $"
IL_0024: ldc.i4.1
IL_0025: newarr System.Object
IL_002a: dup
IL_002b: ldc.i4.0
IL_002c: ldloc.1
IL_002d: box System.Int32
IL_0032: stelem.ref
IL_0033: newobj System.Void BansheeGz.BGDatabase.BGException::.ctor(System.String,System.Object[])
IL_0038: throw
