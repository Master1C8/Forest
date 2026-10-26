TYPE BansheeGz.BGDatabase.BGFieldUnityAssetA`1
METHOD System.Void BansheeGz.BGDatabase.BGFieldUnityAssetA`1::FromBytes(System.Int32,System.ArraySegment`1<System.Byte>) | attributes=Public, Virtual, HideBySig | impl=IL
IL_0000: ldarga.s segment
IL_0002: call System.Int32 System.ArraySegment`1<System.Byte>::get_Count()
IL_0007: brtrue.s IL_0017
IL_0009: ldarg.0
IL_000a: ldfld BansheeGz.BGDatabase.BGStoreField`1<TStoreType> BansheeGz.BGDatabase.BGFieldCachedA`2<T,System.String>::Store
IL_000f: ldarg.1
IL_0010: ldnull
IL_0011: callvirt System.Void BansheeGz.BGDatabase.BGStoreField`1<System.String>::set_Item(System.Int32,T)
IL_0016: ret
IL_0017: ldarg.0
IL_0018: ldfld BansheeGz.BGDatabase.BGStoreField`1<TStoreType> BansheeGz.BGDatabase.BGFieldCachedA`2<T,System.String>::Store
IL_001d: ldarg.1
IL_001e: call System.Text.Encoding System.Text.Encoding::get_UTF8()
IL_0023: ldarga.s segment
IL_0025: call !0[] System.ArraySegment`1<System.Byte>::get_Array()
IL_002a: ldarga.s segment
IL_002c: call System.Int32 System.ArraySegment`1<System.Byte>::get_Offset()
IL_0031: ldarga.s segment
IL_0033: call System.Int32 System.ArraySegment`1<System.Byte>::get_Count()
IL_0038: callvirt System.String System.Text.Encoding::GetString(System.Byte[],System.Int32,System.Int32)
IL_003d: callvirt System.Void BansheeGz.BGDatabase.BGStoreField`1<System.String>::set_Item(System.Int32,T)
IL_0042: ret
