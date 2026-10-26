TYPE BansheeGz.BGDatabase.BGRepo
METHOD System.Void BansheeGz.BGDatabase.BGRepo::.cctor() | attributes=Private, Static, HideBySig, SpecialName, RTSpecialName | impl=IL
IL_0000: newobj System.Void BansheeGz.BGDatabase.BGRepo::.ctor()
IL_0005: stsfld BansheeGz.BGDatabase.BGRepo BansheeGz.BGDatabase.BGRepo::instance
IL_000a: ldc.i4.3
IL_000b: newarr BansheeGz.BGDatabase.BGLoaderForRepo
IL_0010: dup
IL_0011: ldc.i4.0
IL_0012: newobj System.Void BansheeGz.BGDatabase.BGLoaderForRepoCustom::.ctor()
IL_0017: stelem.ref
IL_0018: dup
IL_0019: ldc.i4.1
IL_001a: newobj System.Void BansheeGz.BGDatabase.BGLoaderForRepoStreamingAssets::.ctor()
IL_001f: stelem.ref
IL_0020: dup
IL_0021: ldc.i4.2
IL_0022: newobj System.Void BansheeGz.BGDatabase.BGLoaderForRepoResources::.ctor()
IL_0027: stelem.ref
IL_0028: stsfld BansheeGz.BGDatabase.BGLoaderForRepo[] BansheeGz.BGDatabase.BGRepo::Loaders
IL_002d: newobj System.Void BansheeGz.BGDatabase.BGRepoBinary::.ctor()
IL_0032: stsfld BansheeGz.BGDatabase.BGRepo/RepoReaderI BansheeGz.BGDatabase.BGRepo::Reader
IL_0037: ret
