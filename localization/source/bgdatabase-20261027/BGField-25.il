TYPE BansheeGz.BGDatabase.BGField
METHOD BansheeGz.BGDatabase.BGField BansheeGz.BGDatabase.BGField::FromBinary(BansheeGz.BGDatabase.BGBinaryReader,BansheeGz.BGDatabase.BGMetaEntity) | attributes=Assembly, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: callvirt System.Int32 BansheeGz.BGDatabase.BGBinaryReader::ReadInt()
IL_0006: stloc.0
IL_0007: ldloc.0
IL_0008: ldc.i4.1
IL_0009: bne.un IL_008f
IL_000e: ldarg.0
IL_000f: callvirt BansheeGz.BGDatabase.BGId BansheeGz.BGDatabase.BGBinaryReader::ReadId()
IL_0014: stloc.1
IL_0015: ldarg.0
IL_0016: callvirt System.String BansheeGz.BGDatabase.BGBinaryReader::ReadString()
IL_001b: stloc.2
IL_001c: ldarg.0
IL_001d: callvirt System.String BansheeGz.BGDatabase.BGBinaryReader::ReadString()
IL_0022: stloc.3
IL_0023: ldarg.0
IL_0024: callvirt System.ArraySegment`1<System.Byte> BansheeGz.BGDatabase.BGBinaryReader::ReadByteArray()
IL_0029: stloc.s V_4
IL_002b: ldarg.0
IL_002c: callvirt System.Boolean BansheeGz.BGDatabase.BGBinaryReader::ReadBool()
IL_0031: stloc.s V_5
IL_0033: ldarg.0
IL_0034: callvirt System.String BansheeGz.BGDatabase.BGBinaryReader::ReadString()
IL_0039: stloc.s V_6
IL_003b: ldarg.0
IL_003c: callvirt System.String BansheeGz.BGDatabase.BGBinaryReader::ReadString()
IL_0041: stloc.s V_7
IL_0043: ldarg.0
IL_0044: callvirt System.Boolean BansheeGz.BGDatabase.BGBinaryReader::ReadBool()
IL_0049: stloc.s V_8
IL_004b: ldarg.0
IL_004c: callvirt System.String BansheeGz.BGDatabase.BGBinaryReader::ReadString()
IL_0051: stloc.s V_9
IL_0053: ldarg.0
IL_0054: callvirt System.String BansheeGz.BGDatabase.BGBinaryReader::ReadString()
IL_0059: stloc.s V_10
IL_005b: ldarg.0
IL_005c: callvirt System.String BansheeGz.BGDatabase.BGBinaryReader::ReadString()
IL_0061: stloc.s V_11
IL_0063: ldarg.1
IL_0064: ldloc.3
IL_0065: ldloc.1
IL_0066: ldloc.2
IL_0067: ldloc.s V_4
IL_0069: ldloc.s V_5
IL_006b: ldloc.s V_6
IL_006d: ldloc.s V_7
IL_006f: ldloc.s V_8
IL_0071: call BansheeGz.BGDatabase.BGField BansheeGz.BGDatabase.BGField::Create(BansheeGz.BGDatabase.BGMetaEntity,System.String,BansheeGz.BGDatabase.BGId,System.String,System.ArraySegment`1<System.Byte>,System.Boolean,System.String,System.String,System.Boolean)
IL_0076: dup
IL_0077: ldloc.s V_9
IL_0079: callvirt System.Void BansheeGz.BGDatabase.BGField::set_CustomStringFormatterTypeAsString(System.String)
IL_007e: dup
IL_007f: ldloc.s V_10
IL_0081: callvirt System.Void BansheeGz.BGDatabase.BGField::set_CustomEditorTypeAsString(System.String)
IL_0086: dup
IL_0087: ldloc.s V_11
IL_0089: callvirt System.Void BansheeGz.BGDatabase.BGField::SetComment(System.String)
IL_008e: ret
IL_008f: ldstr "Can not read field from binary array: unsupported version $"
IL_0094: ldc.i4.1
IL_0095: newarr System.Object
IL_009a: dup
IL_009b: ldc.i4.0
IL_009c: ldloc.0
IL_009d: box System.Int32
IL_00a2: stelem.ref
IL_00a3: newobj System.Void BansheeGz.BGDatabase.BGException::.ctor(System.String,System.Object[])
IL_00a8: throw
