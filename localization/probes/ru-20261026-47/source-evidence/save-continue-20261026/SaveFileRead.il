TYPE TheForestOfLove.Services.Persistence.SavegameFileHelper
METHOD System.Boolean TheForestOfLove.Services.Persistence.SavegameFileHelper::get_savingEnabled() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldc.i4.1
IL_0001: ret
METHOD TheForestOfLove.Services.Persistence.Savestate TheForestOfLove.Services.Persistence.SavegameFileHelper::ReadSavegameData() | attributes=Public, Static, HideBySig | impl=IL
IL_0000: call System.Boolean TheForestOfLove.Services.Persistence.SavegameFileHelper::get_savingEnabled()
IL_0005: brtrue.s IL_0009
IL_0007: ldnull
IL_0008: ret
IL_0009: call System.Void TheForestOfLove.Services.Persistence.SavegameFileHelper::CleanupLegacySavegameFiles()
IL_000e: ldstr "tfol.savegame"
IL_0013: call TheForestOfLove.Services.Persistence.Savestate TheForestOfLove.Services.Persistence.SavegameFileHelper::ReadDataFromGameDirectory(System.String)
IL_0018: ret
METHOD System.Void TheForestOfLove.Services.Persistence.SavegameFileHelper::CleanupLegacySavegameFiles() | attributes=Private, Static, HideBySig | impl=IL
IL_0000: ldsfld ES3Settings TheForestOfLove.Services.Persistence.SavegameFileHelper::settingsLocalGameDirectory
IL_0005: call System.Void TheForestOfLove.Services.Persistence.SavegameFileHelper::CleanupLegacySavegameFiles_Intermediate(ES3Settings)
IL_000a: ldsfld ES3Settings TheForestOfLove.Services.Persistence.SavegameFileHelper::settingsPersistentData
IL_000f: call System.Void TheForestOfLove.Services.Persistence.SavegameFileHelper::CleanupLegacySavegameFiles_Intermediate(ES3Settings)
IL_0014: leave.s IL_0037
IL_0016: ldstr "Savestate File Delete Failed!"
IL_001b: call System.Void UnityEngine.Debug::Log(System.Object)
IL_0020: dup
IL_0021: callvirt System.String System.Exception::get_Message()
IL_0026: call System.Void UnityEngine.Debug::Log(System.Object)
IL_002b: callvirt System.String System.Exception::get_StackTrace()
IL_0030: call System.Void UnityEngine.Debug::Log(System.Object)
IL_0035: leave.s IL_0037
IL_0037: ret
METHOD System.Void TheForestOfLove.Services.Persistence.SavegameFileHelper::CleanupLegacySavegameFiles_Intermediate(ES3Settings) | attributes=Private, Static, HideBySig | impl=IL
IL_0000: ldstr "tfol.savegame"
IL_0005: ldarg.0
IL_0006: call System.Boolean ES3::FileExists(System.String,ES3Settings)
IL_000b: brfalse.s IL_004e
IL_000d: ldstr "savegame_version"
IL_0012: ldstr "tfol.savegame"
IL_0017: ldarg.0
IL_0018: call System.Boolean ES3::KeyExists(System.String,System.String,ES3Settings)
IL_001d: brtrue.s IL_0022
IL_001f: ldnull
IL_0020: br.s IL_0032
IL_0022: ldstr "savegame_version"
IL_0027: ldstr "tfol.savegame"
IL_002c: ldarg.0
IL_002d: call !!0 ES3::Load<System.String>(System.String,System.String,ES3Settings)
IL_0032: stloc.0
IL_0033: ldloc.0
IL_0034: brfalse.s IL_0043
IL_0036: ldloc.0
IL_0037: ldstr "231129"
IL_003c: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0041: brtrue.s IL_004e
IL_0043: ldstr "tfol.savegame"
IL_0048: ldarg.0
IL_0049: call System.Void ES3::DeleteFile(System.String,ES3Settings)
IL_004e: ret
METHOD TheForestOfLove.Services.Persistence.Savestate TheForestOfLove.Services.Persistence.SavegameFileHelper::ReadDataFromGameDirectory(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldsfld ES3Settings TheForestOfLove.Services.Persistence.SavegameFileHelper::settingsLocalGameDirectory
IL_0006: call System.Boolean ES3::FileExists(System.String,ES3Settings)
IL_000b: brfalse.s IL_0020
IL_000d: ldstr "savegame_data"
IL_0012: ldarg.0
IL_0013: ldsfld ES3Settings TheForestOfLove.Services.Persistence.SavegameFileHelper::settingsLocalGameDirectory
IL_0018: call !!0 ES3::Load<TheForestOfLove.Services.Persistence.Savestate>(System.String,System.String,ES3Settings)
IL_001d: stloc.0
IL_001e: leave.s IL_0065
IL_0020: ldarg.0
IL_0021: ldsfld ES3Settings TheForestOfLove.Services.Persistence.SavegameFileHelper::settingsPersistentData
IL_0026: call System.Boolean ES3::FileExists(System.String,ES3Settings)
IL_002b: brfalse.s IL_0040
IL_002d: ldstr "savegame_data"
IL_0032: ldarg.0
IL_0033: ldsfld ES3Settings TheForestOfLove.Services.Persistence.SavegameFileHelper::settingsPersistentData
IL_0038: call !!0 ES3::Load<TheForestOfLove.Services.Persistence.Savestate>(System.String,System.String,ES3Settings)
IL_003d: stloc.0
IL_003e: leave.s IL_0065
IL_0040: leave.s IL_0063
IL_0042: ldstr "Savestate File Read Failed!"
IL_0047: call System.Void UnityEngine.Debug::Log(System.Object)
IL_004c: dup
IL_004d: callvirt System.String System.Exception::get_Message()
IL_0052: call System.Void UnityEngine.Debug::Log(System.Object)
IL_0057: callvirt System.String System.Exception::get_StackTrace()
IL_005c: call System.Void UnityEngine.Debug::Log(System.Object)
IL_0061: leave.s IL_0063
IL_0063: ldnull
IL_0064: ret
IL_0065: ldloc.0
IL_0066: ret
METHOD System.Void TheForestOfLove.Services.Persistence.SavegameFileHelper::.cctor() | attributes=Private, Static, HideBySig, SpecialName, RTSpecialName | impl=IL
IL_0000: ldnull
IL_0001: ldnull
IL_0002: newobj System.Void ES3Settings::.ctor(System.String,ES3Settings)
IL_0007: dup
IL_0008: ldc.i4.0
IL_0009: stfld ES3/Directory ES3Settings::directory
IL_000e: dup
IL_000f: ldc.i4.1
IL_0010: callvirt System.Void ES3Settings::set_location(ES3/Location)
IL_0015: stsfld ES3Settings TheForestOfLove.Services.Persistence.SavegameFileHelper::settingsPersistentData
IL_001a: ldnull
IL_001b: ldnull
IL_001c: newobj System.Void ES3Settings::.ctor(System.String,ES3Settings)
IL_0021: dup
IL_0022: ldc.i4.1
IL_0023: stfld ES3/Directory ES3Settings::directory
IL_0028: dup
IL_0029: ldc.i4.0
IL_002a: callvirt System.Void ES3Settings::set_location(ES3/Location)
IL_002f: stsfld ES3Settings TheForestOfLove.Services.Persistence.SavegameFileHelper::settingsLocalGameDirectory
IL_0034: ret
