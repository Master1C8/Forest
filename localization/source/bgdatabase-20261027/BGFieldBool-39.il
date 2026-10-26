TYPE BansheeGz.BGDatabase.BGFieldBool
METHOD System.Int32 BansheeGz.BGDatabase.BGFieldBool::get_ValueSize() | attributes=Family, Virtual, HideBySig, SpecialName | impl=IL
IL_0000: ldc.i4.1
IL_0001: ret
METHOD System.Boolean BansheeGz.BGDatabase.BGFieldBool::ValueFromBytes(System.ArraySegment`1<System.Byte>) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldarga.s segment
IL_0002: call System.Int32 System.ArraySegment`1<System.Byte>::get_Count()
IL_0007: ldc.i4.1
IL_0008: bne.un.s IL_001d
IL_000a: ldarga.s segment
IL_000c: call !0[] System.ArraySegment`1<System.Byte>::get_Array()
IL_0011: ldarga.s segment
IL_0013: call System.Int32 System.ArraySegment`1<System.Byte>::get_Offset()
IL_0018: ldelem.u1
IL_0019: ldc.i4.0
IL_001a: cgt.un
IL_001c: ret
IL_001d: ldc.i4.0
IL_001e: ret
