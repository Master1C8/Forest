TYPE TheForestOfLove.Services.Persistence.SaveManager
METHOD System.Boolean TheForestOfLove.Services.Persistence.SaveManager::get_HasSavedPlaySession() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld TheForestOfLove.Services.Persistence.Savestate TheForestOfLove.Services.Persistence.SaveManager::_savestate
IL_0005: brfalse.s IL_000d
IL_0007: ldsfld System.Boolean TheForestOfLove.Services.Persistence.SaveManager::_hasSavestateOnDisk
IL_000c: ret
IL_000d: ldc.i4.0
IL_000e: ret
