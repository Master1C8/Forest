TYPE BansheeGz.BGDatabase.BGBinaryReader
METHOD System.Int32 BansheeGz.BGDatabase.BGBinaryReader::ReadInt() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Byte[] BansheeGz.BGDatabase.BGBinaryReader::array
IL_0006: ldarg.0
IL_0007: ldfld System.Int32 BansheeGz.BGDatabase.BGBinaryReader::cursor
IL_000c: ldc.i4.4
IL_000d: newobj System.Void System.ArraySegment`1<System.Byte>::.ctor(!0[],System.Int32,System.Int32)
IL_0012: call System.Int32 BansheeGz.BGDatabase.BGFieldInt::ValueFromBytes(System.ArraySegment`1<System.Byte>)
IL_0017: ldarg.0
IL_0018: ldarg.0
IL_0019: ldfld System.Int32 BansheeGz.BGDatabase.BGBinaryReader::cursor
IL_001e: ldc.i4.4
IL_001f: add
IL_0020: stfld System.Int32 BansheeGz.BGDatabase.BGBinaryReader::cursor
IL_0025: ret
METHOD BansheeGz.BGDatabase.BGId BansheeGz.BGDatabase.BGBinaryReader::ReadId() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Byte[] BansheeGz.BGDatabase.BGBinaryReader::array
IL_0006: ldarg.0
IL_0007: ldfld System.Int32 BansheeGz.BGDatabase.BGBinaryReader::cursor
IL_000c: newobj System.Void BansheeGz.BGDatabase.BGId::.ctor(System.Byte[],System.Int32)
IL_0011: ldarg.0
IL_0012: ldarg.0
IL_0013: ldfld System.Int32 BansheeGz.BGDatabase.BGBinaryReader::cursor
IL_0018: ldc.i4.s 16
IL_001a: add
IL_001b: stfld System.Int32 BansheeGz.BGDatabase.BGBinaryReader::cursor
IL_0020: ret
METHOD System.String BansheeGz.BGDatabase.BGBinaryReader::ReadString() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.ArraySegment`1<System.Byte> BansheeGz.BGDatabase.BGBinaryReader::ReadByteArray()
IL_0006: stloc.0
IL_0007: ldloca.s V_0
IL_0009: call System.Int32 System.ArraySegment`1<System.Byte>::get_Count()
IL_000e: brfalse.s IL_0030
IL_0010: call System.Text.Encoding System.Text.Encoding::get_UTF8()
IL_0015: ldloca.s V_0
IL_0017: call !0[] System.ArraySegment`1<System.Byte>::get_Array()
IL_001c: ldloca.s V_0
IL_001e: call System.Int32 System.ArraySegment`1<System.Byte>::get_Offset()
IL_0023: ldloca.s V_0
IL_0025: call System.Int32 System.ArraySegment`1<System.Byte>::get_Count()
IL_002a: callvirt System.String System.Text.Encoding::GetString(System.Byte[],System.Int32,System.Int32)
IL_002f: ret
IL_0030: ldnull
IL_0031: ret
METHOD System.ArraySegment`1<System.Byte> BansheeGz.BGDatabase.BGBinaryReader::ReadByteArray() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Int32 BansheeGz.BGDatabase.BGBinaryReader::ReadInt()
IL_0006: stloc.0
IL_0007: ldarg.0
IL_0008: ldfld System.Byte[] BansheeGz.BGDatabase.BGBinaryReader::array
IL_000d: ldarg.0
IL_000e: ldfld System.Int32 BansheeGz.BGDatabase.BGBinaryReader::cursor
IL_0013: ldloc.0
IL_0014: newobj System.Void System.ArraySegment`1<System.Byte>::.ctor(!0[],System.Int32,System.Int32)
IL_0019: ldarg.0
IL_001a: ldarg.0
IL_001b: ldfld System.Int32 BansheeGz.BGDatabase.BGBinaryReader::cursor
IL_0020: ldloc.0
IL_0021: add
IL_0022: stfld System.Int32 BansheeGz.BGDatabase.BGBinaryReader::cursor
IL_0027: ret
METHOD System.Void BansheeGz.BGDatabase.BGBinaryReader::ReadArray(System.Action) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Int32 BansheeGz.BGDatabase.BGBinaryReader::ReadInt()
IL_0006: stloc.0
IL_0007: ldc.i4.0
IL_0008: stloc.1
IL_0009: br.s IL_0015
IL_000b: ldarg.1
IL_000c: callvirt System.Void System.Action::Invoke()
IL_0011: ldloc.1
IL_0012: ldc.i4.1
IL_0013: add
IL_0014: stloc.1
IL_0015: ldloc.1
IL_0016: ldloc.0
IL_0017: blt.s IL_000b
IL_0019: ret
