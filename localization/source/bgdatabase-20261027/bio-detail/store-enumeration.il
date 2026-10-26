TYPE BansheeGz.BGDatabase.BGStoreField`1
METHOD System.Void BansheeGz.BGDatabase.BGStoreField`1::ForEachKeyValue(System.Action`2<System.Int32,T>) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call BansheeGz.BGDatabase.BGLazyLoaderFieldI BansheeGz.BGDatabase.BGStoreField`1<T>::get_Loader()
IL_0006: brfalse.s IL_001f
IL_0008: ldarg.0
IL_0009: call BansheeGz.BGDatabase.BGLazyLoaderFieldI BansheeGz.BGDatabase.BGStoreField`1<T>::get_Loader()
IL_000e: callvirt BansheeGz.BGDatabase.BGLazyLoaderMetaI BansheeGz.BGDatabase.BGLazyLoaderFieldI::get_LoaderMeta()
IL_0013: callvirt System.Void BansheeGz.BGDatabase.BGLazyLoaderMetaI::LoadAll()
IL_0018: ldarg.0
IL_0019: ldnull
IL_001a: call System.Void BansheeGz.BGDatabase.BGStoreField`1<T>::set_Loader(BansheeGz.BGDatabase.BGLazyLoaderFieldI)
IL_001f: ldarg.0
IL_0020: call System.Int32 BansheeGz.BGDatabase.BGArrayStore`1<T>::get_Count()
IL_0025: stloc.0
IL_0026: ldc.i4.0
IL_0027: stloc.1
IL_0028: br.s IL_0041
IL_002a: ldarg.1
IL_002b: ldloc.1
IL_002c: ldarg.0
IL_002d: ldfld T[] BansheeGz.BGDatabase.BGArrayStore`1<T>::Items
IL_0032: ldloc.1
IL_0033: ldelem.any T
IL_0038: callvirt System.Void System.Action`2<System.Int32,T>::Invoke(!0,!1)
IL_003d: ldloc.1
IL_003e: ldc.i4.1
IL_003f: add
IL_0040: stloc.1
IL_0041: ldloc.1
IL_0042: ldloc.0
IL_0043: blt.s IL_002a
IL_0045: ret
