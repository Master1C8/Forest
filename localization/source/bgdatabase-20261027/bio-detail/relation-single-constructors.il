TYPE BansheeGz.BGDatabase.BGFieldRelationSingle
METHOD System.Void BansheeGz.BGDatabase.BGFieldRelationSingle::.ctor(BansheeGz.BGDatabase.BGMetaEntity,System.String,BansheeGz.BGDatabase.BGMetaEntity) | attributes=Public, HideBySig, SpecialName, RTSpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: ldarg.2
IL_0003: ldarg.3
IL_0004: call System.Void BansheeGz.BGDatabase.BGFieldRelationA`2<BansheeGz.BGDatabase.BGEntity,BansheeGz.BGDatabase.BGId>::.ctor(BansheeGz.BGDatabase.BGMetaEntity,System.String,BansheeGz.BGDatabase.BGMetaEntity)
IL_0009: ret
METHOD System.Void BansheeGz.BGDatabase.BGFieldRelationSingle::.ctor(BansheeGz.BGDatabase.BGMetaEntity,BansheeGz.BGDatabase.BGId,System.String) | attributes=Private, HideBySig, SpecialName, RTSpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: ldarg.2
IL_0003: ldarg.3
IL_0004: call System.Void BansheeGz.BGDatabase.BGFieldRelationA`2<BansheeGz.BGDatabase.BGEntity,BansheeGz.BGDatabase.BGId>::.ctor(BansheeGz.BGDatabase.BGMetaEntity,BansheeGz.BGDatabase.BGId,System.String)
IL_0009: ret
