TYPE BansheeGz.BGDatabase.BGBinaryReader
METHOD System.Boolean BansheeGz.BGDatabase.BGBinaryReader::ReadBool() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Byte[] BansheeGz.BGDatabase.BGBinaryReader::array
IL_0006: ldarg.0
IL_0007: ldfld System.Int32 BansheeGz.BGDatabase.BGBinaryReader::cursor
IL_000c: ldc.i4.1
IL_000d: newobj System.Void System.ArraySegment`1<System.Byte>::.ctor(!0[],System.Int32,System.Int32)
IL_0012: call System.Boolean BansheeGz.BGDatabase.BGFieldBool::ValueFromBytes(System.ArraySegment`1<System.Byte>)
IL_0017: ldarg.0
IL_0018: ldarg.0
IL_0019: ldfld System.Int32 BansheeGz.BGDatabase.BGBinaryReader::cursor
IL_001e: ldc.i4.1
IL_001f: add
IL_0020: stfld System.Int32 BansheeGz.BGDatabase.BGBinaryReader::cursor
IL_0025: ret
