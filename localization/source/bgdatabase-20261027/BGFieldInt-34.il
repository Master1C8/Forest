TYPE BansheeGz.BGDatabase.BGFieldInt
METHOD System.Int32 BansheeGz.BGDatabase.BGFieldInt::ValueFromBytes(System.ArraySegment`1<System.Byte>) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldarga.s segment
IL_0002: call System.Int32 System.ArraySegment`1<System.Byte>::get_Count()
IL_0007: ldc.i4.4
IL_0008: beq.s IL_000c
IL_000a: ldc.i4.0
IL_000b: ret
IL_000c: ldarga.s segment
IL_000e: call !0[] System.ArraySegment`1<System.Byte>::get_Array()
IL_0013: stloc.0
IL_0014: ldarga.s segment
IL_0016: call System.Int32 System.ArraySegment`1<System.Byte>::get_Offset()
IL_001b: stloc.1
IL_001c: ldloc.0
IL_001d: ldloc.1
IL_001e: ldc.i4.3
IL_001f: add
IL_0020: ldelem.u1
IL_0021: ldc.i4.s 24
IL_0023: shl
IL_0024: ldloc.0
IL_0025: ldloc.1
IL_0026: ldc.i4.2
IL_0027: add
IL_0028: ldelem.u1
IL_0029: ldc.i4.s 16
IL_002b: shl
IL_002c: or
IL_002d: ldloc.0
IL_002e: ldloc.1
IL_002f: ldc.i4.1
IL_0030: add
IL_0031: ldelem.u1
IL_0032: ldc.i4.8
IL_0033: shl
IL_0034: or
IL_0035: ldloc.0
IL_0036: ldloc.1
IL_0037: ldelem.u1
IL_0038: or
IL_0039: ret
