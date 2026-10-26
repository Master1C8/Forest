TYPE BansheeGz.BGDatabase.BGFieldStringA
METHOD System.String BansheeGz.BGDatabase.BGFieldStringA::ValueFromBytes(System.ArraySegment`1<System.Byte>) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldarga.s segment
IL_0002: call System.Int32 System.ArraySegment`1<System.Byte>::get_Count()
IL_0007: brfalse.s IL_0029
IL_0009: call System.Text.Encoding System.Text.Encoding::get_UTF8()
IL_000e: ldarga.s segment
IL_0010: call !0[] System.ArraySegment`1<System.Byte>::get_Array()
IL_0015: ldarga.s segment
IL_0017: call System.Int32 System.ArraySegment`1<System.Byte>::get_Offset()
IL_001c: ldarga.s segment
IL_001e: call System.Int32 System.ArraySegment`1<System.Byte>::get_Count()
IL_0023: callvirt System.String System.Text.Encoding::GetString(System.Byte[],System.Int32,System.Int32)
IL_0028: ret
IL_0029: ldnull
IL_002a: ret
