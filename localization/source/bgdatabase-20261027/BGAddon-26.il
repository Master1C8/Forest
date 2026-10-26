TYPE BansheeGz.BGDatabase.BGAddon
METHOD BansheeGz.BGDatabase.BGAddon BansheeGz.BGDatabase.BGAddon::FromBinary(BansheeGz.BGDatabase.BGBinaryReader) | attributes=Assembly, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: callvirt System.Int32 BansheeGz.BGDatabase.BGBinaryReader::ReadInt()
IL_0006: stloc.0
IL_0007: ldloc.0
IL_0008: ldc.i4.1
IL_0009: bne.un.s IL_002c
IL_000b: ldarg.0
IL_000c: callvirt System.String BansheeGz.BGDatabase.BGBinaryReader::ReadString()
IL_0011: ldarg.0
IL_0012: callvirt System.ArraySegment`1<System.Byte> BansheeGz.BGDatabase.BGBinaryReader::ReadByteArray()
IL_0017: stloc.1
IL_0018: ldc.i4.0
IL_0019: ldc.i4.0
IL_001a: newarr System.Object
IL_001f: call T BansheeGz.BGDatabase.BGUtil::Create<BansheeGz.BGDatabase.BGAddon>(System.String,System.Boolean,System.Object[])
IL_0024: dup
IL_0025: ldloc.1
IL_0026: callvirt System.Void BansheeGz.BGDatabase.BGAddon::ConfigFromBytes(System.ArraySegment`1<System.Byte>)
IL_002b: ret
IL_002c: ldstr "Can not read addon from binary array: unsupported version $"
IL_0031: ldc.i4.1
IL_0032: newarr System.Object
IL_0037: dup
IL_0038: ldc.i4.0
IL_0039: ldloc.0
IL_003a: box System.Int32
IL_003f: stelem.ref
IL_0040: newobj System.Void BansheeGz.BGDatabase.BGException::.ctor(System.String,System.Object[])
IL_0045: throw
