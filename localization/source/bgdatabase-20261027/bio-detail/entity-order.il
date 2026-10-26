TYPE BansheeGz.BGDatabase.BGEntity
METHOD System.Int32 BansheeGz.BGDatabase.BGEntity::CompareTo(BansheeGz.BGDatabase.BGEntity) | attributes=Public, Final, Virtual, HideBySig, VtableLayoutMask | impl=IL
IL_0000: ldarg.1
IL_0001: brfalse.s IL_0018
IL_0003: ldarg.0
IL_0004: call System.Int32 BansheeGz.BGDatabase.BGEntity::get_Index()
IL_0009: stloc.0
IL_000a: ldloca.s V_0
IL_000c: ldarg.1
IL_000d: callvirt System.Int32 BansheeGz.BGDatabase.BGEntity::get_Index()
IL_0012: call System.Int32 System.Int32::CompareTo(System.Int32)
IL_0017: ret
IL_0018: ldc.i4.0
IL_0019: ret
