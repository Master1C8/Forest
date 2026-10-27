TYPE BansheeGz.BGDatabase.BGFieldEnum
METHOD System.Int32 BansheeGz.BGDatabase.BGFieldEnum::get_ValueSize() | attributes=Family, Virtual, HideBySig, SpecialName | impl=IL
IL_0000: ldc.i4.4
IL_0001: ret
METHOD System.Enum BansheeGz.BGDatabase.BGFieldEnum::StoredValueToEnum(System.Int32) | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Type BansheeGz.BGDatabase.BGFieldEnumA`1<System.Int32>::get_EnumType()
IL_0006: ldarg.1
IL_0007: call System.Object System.Enum::ToObject(System.Type,System.Int32)
IL_000c: castclass System.Enum
IL_0011: ret
METHOD System.Int32 BansheeGz.BGDatabase.BGFieldEnum::EnumToStoredValue(System.Enum) | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: call System.Int32 System.Convert::ToInt32(System.Object)
IL_0006: ret
METHOD System.Byte[] BansheeGz.BGDatabase.BGFieldEnum::ToBytes(System.Int32) | attributes=Public, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: call TStoreType BansheeGz.BGDatabase.BGFieldCachedA`2<System.Enum,System.Int32>::GetStoredValue(System.Int32)
IL_0007: call System.Byte[] BansheeGz.BGDatabase.BGFieldInt::ValueToBytes(System.Int32)
IL_000c: ret
METHOD System.Void BansheeGz.BGDatabase.BGFieldEnum::FromBytes(System.Int32,System.ArraySegment`1<System.Byte>) | attributes=Public, Virtual, HideBySig | impl=IL
IL_0000: ldarga.s segment
IL_0002: call System.Int32 System.ArraySegment`1<System.Byte>::get_Count()
IL_0007: ldc.i4.4
IL_0008: beq.s IL_000b
IL_000a: ret
IL_000b: ldarg.0
IL_000c: ldarg.1
IL_000d: ldarg.2
IL_000e: call System.Int32 BansheeGz.BGDatabase.BGFieldInt::ValueFromBytes(System.ArraySegment`1<System.Byte>)
IL_0013: callvirt System.Void BansheeGz.BGDatabase.BGFieldCachedA`2<System.Enum,System.Int32>::SetStoredValue(System.Int32,TStoreType)
IL_0018: ret
