TYPE TheForestOfLove.Services.Persistence.QuicksaveFileHelper
METHOD System.Boolean TheForestOfLove.Services.Persistence.QuicksaveFileHelper::DebugArchiveSavestate(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: call System.Boolean TheForestOfLove.Services.Persistence.SavegameFileHelper::get_savingEnabled()
IL_0005: brtrue.s IL_0009
IL_0007: ldc.i4.0
IL_0008: ret
IL_0009: ldc.i4.0
IL_000a: stloc.0
IL_000b: ldarg.0
IL_000c: ldsfld ES3Settings TheForestOfLove.Services.Persistence.SavegameFileHelper::settingsLocalGameDirectory
IL_0011: call System.Boolean TheForestOfLove.Services.Persistence.QuicksaveFileHelper::DebugArchiveSavestate_Intermediate(System.String,ES3Settings)
IL_0016: brfalse.s IL_001a
IL_0018: ldc.i4.1
IL_0019: stloc.0
IL_001a: ldarg.0
IL_001b: ldsfld ES3Settings TheForestOfLove.Services.Persistence.SavegameFileHelper::settingsPersistentData
IL_0020: call System.Boolean TheForestOfLove.Services.Persistence.QuicksaveFileHelper::DebugArchiveSavestate_Intermediate(System.String,ES3Settings)
IL_0025: brfalse.s IL_0029
IL_0027: ldc.i4.1
IL_0028: stloc.0
IL_0029: ldloc.0
IL_002a: ret
METHOD System.Boolean TheForestOfLove.Services.Persistence.QuicksaveFileHelper::DebugRestoreSavestate(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: call System.Boolean TheForestOfLove.Services.Persistence.SavegameFileHelper::get_savingEnabled()
IL_0005: brtrue.s IL_0009
IL_0007: ldc.i4.0
IL_0008: ret
IL_0009: ldarg.0
IL_000a: ldsfld ES3Settings TheForestOfLove.Services.Persistence.SavegameFileHelper::settingsLocalGameDirectory
IL_000f: call System.Boolean TheForestOfLove.Services.Persistence.QuicksaveFileHelper::DebugRestoreSavestate_Intermediate(System.String,ES3Settings)
IL_0014: brfalse.s IL_0018
IL_0016: ldc.i4.1
IL_0017: ret
IL_0018: ldarg.0
IL_0019: ldsfld ES3Settings TheForestOfLove.Services.Persistence.SavegameFileHelper::settingsPersistentData
IL_001e: call System.Boolean TheForestOfLove.Services.Persistence.QuicksaveFileHelper::DebugRestoreSavestate_Intermediate(System.String,ES3Settings)
IL_0023: brfalse.s IL_0027
IL_0025: ldc.i4.1
IL_0026: ret
IL_0027: ldc.i4.0
IL_0028: ret
