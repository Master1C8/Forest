TYPE BansheeGz.BGDatabase.BGFieldVector2
METHOD System.Int32 BansheeGz.BGDatabase.BGFieldVector2::get_ValueSize() | attributes=Family, Virtual, HideBySig, SpecialName | impl=IL
IL_0000: ldc.i4.8
IL_0001: ret
METHOD System.Void BansheeGz.BGDatabase.BGFieldVector2::FromBytes(System.Int32,System.ArraySegment`1<System.Byte>) | attributes=Public, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: ldarg.2
IL_0003: call UnityEngine.Vector2 BansheeGz.BGDatabase.BGFieldVector2::ValueFromBytes(System.ArraySegment`1<System.Byte>)
IL_0008: callvirt System.Void BansheeGz.BGDatabase.BGField`1<UnityEngine.Vector2>::set_Item(System.Int32,T)
IL_000d: ret
