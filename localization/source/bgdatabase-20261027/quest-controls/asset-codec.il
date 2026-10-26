TYPE BansheeGz.BGDatabase.BGFieldUnityAssetA`1
METHOD System.Void BansheeGz.BGDatabase.BGFieldUnityAssetA`1::ConfigFromBytes(System.ArraySegment`1<System.Byte>) | attributes=Public, Virtual, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: newobj System.Void BansheeGz.BGDatabase.BGBinaryReader::.ctor(System.ArraySegment`1<System.Byte>)
IL_0006: stloc.0
IL_0007: ldloc.0
IL_0008: callvirt System.Int32 BansheeGz.BGDatabase.BGBinaryReader::ReadInt()
IL_000d: stloc.1
IL_000e: ldloc.1
IL_000f: ldc.i4.1
IL_0010: bne.un.s IL_0044
IL_0012: ldarg.0
IL_0013: ldloc.0
IL_0014: callvirt System.String BansheeGz.BGDatabase.BGBinaryReader::ReadString()
IL_0019: ldc.i4.0
IL_001a: ldc.i4.0
IL_001b: newarr System.Object
IL_0020: call T BansheeGz.BGDatabase.BGUtil::Create<BansheeGz.BGDatabase.BGAssetLoaderA>(System.String,System.Boolean,System.Object[])
IL_0025: stfld BansheeGz.BGDatabase.BGAssetLoaderA BansheeGz.BGDatabase.BGFieldUnityAssetA`1<T>::assetLoader
IL_002a: ldarg.0
IL_002b: ldfld BansheeGz.BGDatabase.BGAssetLoaderA BansheeGz.BGDatabase.BGFieldUnityAssetA`1<T>::assetLoader
IL_0030: ldloc.0
IL_0031: callvirt System.ArraySegment`1<System.Byte> BansheeGz.BGDatabase.BGBinaryReader::ReadByteArray()
IL_0036: callvirt System.Void BansheeGz.BGDatabase.BGAssetLoaderA::ConfigFromBytes(System.ArraySegment`1<System.Byte>)
IL_003b: ldarg.0
IL_003c: ldloc.1
IL_003d: ldloc.0
IL_003e: callvirt System.Void BansheeGz.BGDatabase.BGFieldUnityAssetA`1<T>::ConfigFromBytes(System.Int32,BansheeGz.BGDatabase.BGBinaryReader)
IL_0043: ret
IL_0044: ldstr "Unknown version: $"
IL_0049: ldc.i4.1
IL_004a: newarr System.Object
IL_004f: dup
IL_0050: ldc.i4.0
IL_0051: ldloc.1
IL_0052: box System.Int32
IL_0057: stelem.ref
IL_0058: newobj System.Void BansheeGz.BGDatabase.BGException::.ctor(System.String,System.Object[])
IL_005d: throw
METHOD System.Void BansheeGz.BGDatabase.BGFieldUnityAssetA`1::ConfigFromBytes(System.Int32,BansheeGz.BGDatabase.BGBinaryReader) | attributes=Family, Virtual, HideBySig, VtableLayoutMask | impl=IL
IL_0000: ret
METHOD System.String BansheeGz.BGDatabase.BGFieldUnityAssetA`1::GetAddressablesAddress(System.Int32) | attributes=Public, Virtual, HideBySig, VtableLayoutMask | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: call TStoreType BansheeGz.BGDatabase.BGFieldCachedA`2<T,System.String>::GetStoredValue(System.Int32)
IL_0007: ret
METHOD System.Byte[] BansheeGz.BGDatabase.BGFieldUnityAssetA`1::ToBytes(System.Int32) | attributes=Public, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: call TStoreType BansheeGz.BGDatabase.BGFieldCachedA`2<T,System.String>::GetStoredValue(System.Int32)
IL_0007: stloc.0
IL_0008: ldloc.0
IL_0009: brfalse.s IL_0017
IL_000b: call System.Text.Encoding System.Text.Encoding::get_UTF8()
IL_0010: ldloc.0
IL_0011: callvirt System.Byte[] System.Text.Encoding::GetBytes(System.String)
IL_0016: ret
IL_0017: ldnull
IL_0018: ret
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
