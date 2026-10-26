TYPE BansheeGz.BGDatabase.BGMetaEntity
METHOD BansheeGz.BGDatabase.BGMetaEntity BansheeGz.BGDatabase.BGMetaEntity::FromBinary(BansheeGz.BGDatabase.BGBinaryReader,BansheeGz.BGDatabase.BGRepo) | attributes=Assembly, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: callvirt System.Int32 BansheeGz.BGDatabase.BGBinaryReader::ReadInt()
IL_0006: stloc.0
IL_0007: ldloc.0
IL_0008: ldc.i4.1
IL_0009: bne.un.s IL_0072
IL_000b: ldarg.0
IL_000c: callvirt BansheeGz.BGDatabase.BGId BansheeGz.BGDatabase.BGBinaryReader::ReadId()
IL_0011: stloc.1
IL_0012: ldarg.0
IL_0013: callvirt System.String BansheeGz.BGDatabase.BGBinaryReader::ReadString()
IL_0018: stloc.2
IL_0019: ldarg.0
IL_001a: callvirt System.String BansheeGz.BGDatabase.BGBinaryReader::ReadString()
IL_001f: stloc.3
IL_0020: ldarg.0
IL_0021: callvirt System.ArraySegment`1<System.Byte> BansheeGz.BGDatabase.BGBinaryReader::ReadByteArray()
IL_0026: stloc.s V_4
IL_0028: ldarg.0
IL_0029: callvirt System.Boolean BansheeGz.BGDatabase.BGBinaryReader::ReadBool()
IL_002e: stloc.s V_5
IL_0030: ldarg.0
IL_0031: callvirt System.String BansheeGz.BGDatabase.BGBinaryReader::ReadString()
IL_0036: stloc.s V_6
IL_0038: ldarg.0
IL_0039: callvirt System.Boolean BansheeGz.BGDatabase.BGBinaryReader::ReadBool()
IL_003e: stloc.s V_7
IL_0040: ldarg.0
IL_0041: callvirt System.Boolean BansheeGz.BGDatabase.BGBinaryReader::ReadBool()
IL_0046: stloc.s V_8
IL_0048: ldarg.0
IL_0049: callvirt System.Boolean BansheeGz.BGDatabase.BGBinaryReader::ReadBool()
IL_004e: stloc.s V_9
IL_0050: ldarg.1
IL_0051: ldloc.3
IL_0052: ldloc.1
IL_0053: ldloc.2
IL_0054: ldloc.s V_4
IL_0056: ldloc.s V_5
IL_0058: ldloc.s V_6
IL_005a: ldloc.s V_7
IL_005c: ldloc.s V_8
IL_005e: ldloc.s V_9
IL_0060: call BansheeGz.BGDatabase.BGMetaEntity BansheeGz.BGDatabase.BGMetaEntity::Create(BansheeGz.BGDatabase.BGRepo,System.String,BansheeGz.BGDatabase.BGId,System.String,System.ArraySegment`1<System.Byte>,System.Boolean,System.String,System.Boolean,System.Boolean,System.Boolean)
IL_0065: dup
IL_0066: ldarg.0
IL_0067: callvirt System.String BansheeGz.BGDatabase.BGBinaryReader::ReadString()
IL_006c: callvirt System.Void BansheeGz.BGDatabase.BGMetaEntity::SetComment(System.String)
IL_0071: ret
IL_0072: ldstr "Can not read meta from binary array: unsupported version $"
IL_0077: ldc.i4.1
IL_0078: newarr System.Object
IL_007d: dup
IL_007e: ldc.i4.0
IL_007f: ldloc.0
IL_0080: box System.Int32
IL_0085: stelem.ref
IL_0086: newobj System.Void BansheeGz.BGDatabase.BGException::.ctor(System.String,System.Object[])
IL_008b: throw
