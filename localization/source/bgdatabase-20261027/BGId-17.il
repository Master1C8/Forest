TYPE BansheeGz.BGDatabase.BGId
METHOD System.String BansheeGz.BGDatabase.BGId::ToString() | attributes=Public, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Byte[] BansheeGz.BGDatabase.BGId::ToByteArray()
IL_0006: call System.String System.Convert::ToBase64String(System.Byte[])
IL_000b: ldc.i4.0
IL_000c: ldc.i4.s 22
IL_000e: callvirt System.String System.String::Substring(System.Int32,System.Int32)
IL_0013: ret
METHOD System.Byte[] BansheeGz.BGDatabase.BGId::ToByteArray() | attributes=Public, HideBySig | impl=IL
IL_0000: ldc.i4.s 16
IL_0002: newarr System.Byte
IL_0007: dup
IL_0008: ldc.i4.0
IL_0009: ldarg.0
IL_000a: ldfld System.UInt64 BansheeGz.BGDatabase.BGId::key1
IL_000f: call System.Void BansheeGz.BGDatabase.BGId::ToBytes(System.Byte[],System.Int32,System.UInt64)
IL_0014: dup
IL_0015: ldc.i4.8
IL_0016: ldarg.0
IL_0017: ldfld System.UInt64 BansheeGz.BGDatabase.BGId::key2
IL_001c: call System.Void BansheeGz.BGDatabase.BGId::ToBytes(System.Byte[],System.Int32,System.UInt64)
IL_0021: ret
METHOD System.Void BansheeGz.BGDatabase.BGId::ToByteArray(System.Byte[],System.Int32) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: ldarg.2
IL_0002: ldarg.0
IL_0003: ldfld System.UInt64 BansheeGz.BGDatabase.BGId::key1
IL_0008: call System.Void BansheeGz.BGDatabase.BGId::ToBytes(System.Byte[],System.Int32,System.UInt64)
IL_000d: ldarg.1
IL_000e: ldarg.2
IL_000f: ldc.i4.8
IL_0010: add
IL_0011: ldarg.0
IL_0012: ldfld System.UInt64 BansheeGz.BGDatabase.BGId::key2
IL_0017: call System.Void BansheeGz.BGDatabase.BGId::ToBytes(System.Byte[],System.Int32,System.UInt64)
IL_001c: ret
