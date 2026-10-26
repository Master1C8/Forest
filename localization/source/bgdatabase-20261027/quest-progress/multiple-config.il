TYPE BansheeGz.BGDatabase.BGFieldRelationMultiple
METHOD System.Byte[] BansheeGz.BGDatabase.BGFieldRelationMultiple::ConfigToBytes() | attributes=Public, Virtual, HideBySig | impl=IL
IL_0000: ldc.i4.s 20
IL_0002: newobj System.Void BansheeGz.BGDatabase.BGBinaryWriter::.ctor(System.Int32)
IL_0007: dup
IL_0008: ldc.i4.2
IL_0009: callvirt System.Void BansheeGz.BGDatabase.BGBinaryWriter::AddInt(System.Int32)
IL_000e: dup
IL_000f: ldarg.0
IL_0010: ldfld BansheeGz.BGDatabase.BGId BansheeGz.BGDatabase.BGFieldRelationA`2<System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity>,System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGId>>::toId
IL_0015: callvirt System.Void BansheeGz.BGDatabase.BGBinaryWriter::AddId(BansheeGz.BGDatabase.BGId)
IL_001a: dup
IL_001b: ldarg.0
IL_001c: ldfld System.Boolean BansheeGz.BGDatabase.BGFieldRelationMultiple::allowDuplicates
IL_0021: callvirt System.Void BansheeGz.BGDatabase.BGBinaryWriter::AddBool(System.Boolean)
IL_0026: callvirt System.Byte[] BansheeGz.BGDatabase.BGBinaryWriter::ToArray()
IL_002b: ret
METHOD System.Void BansheeGz.BGDatabase.BGFieldRelationMultiple::ConfigFromBytes(System.ArraySegment`1<System.Byte>) | attributes=Public, Virtual, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: newobj System.Void BansheeGz.BGDatabase.BGBinaryReader::.ctor(System.ArraySegment`1<System.Byte>)
IL_0006: stloc.0
IL_0007: ldloc.0
IL_0008: callvirt System.Int32 BansheeGz.BGDatabase.BGBinaryReader::ReadInt()
IL_000d: stloc.1
IL_000e: ldloc.1
IL_000f: ldc.i4.1
IL_0010: beq.s IL_0018
IL_0012: ldloc.1
IL_0013: ldc.i4.2
IL_0014: beq.s IL_0025
IL_0016: br.s IL_004f
IL_0018: ldarg.0
IL_0019: ldloc.0
IL_001a: callvirt BansheeGz.BGDatabase.BGId BansheeGz.BGDatabase.BGBinaryReader::ReadId()
IL_001f: stfld BansheeGz.BGDatabase.BGId BansheeGz.BGDatabase.BGFieldRelationA`2<System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity>,System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGId>>::toId
IL_0024: ret
IL_0025: ldarg.0
IL_0026: ldloc.0
IL_0027: callvirt BansheeGz.BGDatabase.BGId BansheeGz.BGDatabase.BGBinaryReader::ReadId()
IL_002c: stfld BansheeGz.BGDatabase.BGId BansheeGz.BGDatabase.BGFieldRelationA`2<System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity>,System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGId>>::toId
IL_0031: ldarg.0
IL_0032: ldloc.0
IL_0033: callvirt System.Boolean BansheeGz.BGDatabase.BGBinaryReader::ReadBool()
IL_0038: stfld System.Boolean BansheeGz.BGDatabase.BGFieldRelationMultiple::allowDuplicates
IL_003d: ldarg.0
IL_003e: ldfld BansheeGz.BGDatabase.BGFieldRelationA`2/ReverseRelationCache<T,TStoreType> BansheeGz.BGDatabase.BGFieldRelationA`2<System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity>,System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGId>>::ReverseCache
IL_0043: ldarg.0
IL_0044: ldfld System.Boolean BansheeGz.BGDatabase.BGFieldRelationMultiple::allowDuplicates
IL_0049: callvirt System.Void BansheeGz.BGDatabase.BGFieldRelationA`2/ReverseRelationCache<System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity>,System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGId>>::set_AllowDuplicates(System.Boolean)
IL_004e: ret
IL_004f: ldstr "Unknown version: $"
IL_0054: ldc.i4.1
IL_0055: newarr System.Object
IL_005a: dup
IL_005b: ldc.i4.0
IL_005c: ldloc.1
IL_005d: box System.Int32
IL_0062: stelem.ref
IL_0063: newobj System.Void BansheeGz.BGDatabase.BGException::.ctor(System.String,System.Object[])
IL_0068: throw
