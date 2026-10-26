TYPE TheForestOfLove.Services.Persistence.GlobalSavegameFileHelper
METHOD TheForestOfLove.Services.Persistence.GlobalSavestate TheForestOfLove.Services.Persistence.GlobalSavegameFileHelper::ReadGlobalData() | attributes=Public, Static, HideBySig | impl=IL
IL_0000: call System.Boolean TheForestOfLove.Services.Persistence.SavegameFileHelper::get_savingEnabled()
IL_0005: brtrue.s IL_0009
IL_0007: ldnull
IL_0008: ret
IL_0009: call System.Void TheForestOfLove.Services.Persistence.GlobalSavegameFileHelper::CleanupLegacyGlobalFiles()
IL_000e: call TheForestOfLove.Services.Persistence.GlobalSavestate TheForestOfLove.Services.Persistence.GlobalSavegameFileHelper::ReadDataFromPlayerPrefs()
IL_0013: call TheForestOfLove.Services.Persistence.GlobalSavestate TheForestOfLove.Services.Persistence.GlobalSavegameFileHelper::ReadDataFromGameDirectory()
IL_0018: stloc.0
IL_0019: ldloc.0
IL_001a: call TheForestOfLove.Services.Persistence.GlobalSavestate TheForestOfLove.Services.Persistence.GlobalSavegameFileHelper::DiffGlobalData(TheForestOfLove.Services.Persistence.GlobalSavestate,TheForestOfLove.Services.Persistence.GlobalSavestate)
IL_001f: ret
METHOD System.Void TheForestOfLove.Services.Persistence.GlobalSavegameFileHelper::CleanupLegacyGlobalFiles() | attributes=Private, Static, HideBySig | impl=IL
IL_0000: ldsfld ES3Settings TheForestOfLove.Services.Persistence.SavegameFileHelper::settingsLocalGameDirectory
IL_0005: call System.Void TheForestOfLove.Services.Persistence.GlobalSavegameFileHelper::CleanupLegacyGlobalFiles_Intermediate(ES3Settings)
IL_000a: ldsfld ES3Settings TheForestOfLove.Services.Persistence.SavegameFileHelper::settingsPersistentData
IL_000f: call System.Void TheForestOfLove.Services.Persistence.GlobalSavegameFileHelper::CleanupLegacyGlobalFiles_Intermediate(ES3Settings)
IL_0014: leave.s IL_0037
IL_0016: ldstr "Global Savestate File Delete Failed!"
IL_001b: call System.Void UnityEngine.Debug::Log(System.Object)
IL_0020: dup
IL_0021: callvirt System.String System.Exception::get_Message()
IL_0026: call System.Void UnityEngine.Debug::Log(System.Object)
IL_002b: callvirt System.String System.Exception::get_StackTrace()
IL_0030: call System.Void UnityEngine.Debug::Log(System.Object)
IL_0035: leave.s IL_0037
IL_0037: ret
METHOD System.Void TheForestOfLove.Services.Persistence.GlobalSavegameFileHelper::CleanupLegacyGlobalFiles_Intermediate(ES3Settings) | attributes=Private, Static, HideBySig | impl=IL
IL_0000: ldstr "tfol.settings"
IL_0005: ldarg.0
IL_0006: call System.Boolean ES3::FileExists(System.String,ES3Settings)
IL_000b: brfalse.s IL_004e
IL_000d: ldstr "config_version"
IL_0012: ldstr "tfol.settings"
IL_0017: ldarg.0
IL_0018: call System.Boolean ES3::KeyExists(System.String,System.String,ES3Settings)
IL_001d: brtrue.s IL_0022
IL_001f: ldnull
IL_0020: br.s IL_0032
IL_0022: ldstr "config_version"
IL_0027: ldstr "tfol.settings"
IL_002c: ldarg.0
IL_002d: call !!0 ES3::Load<System.String>(System.String,System.String,ES3Settings)
IL_0032: stloc.0
IL_0033: ldloc.0
IL_0034: brfalse.s IL_0043
IL_0036: ldloc.0
IL_0037: ldstr "220308"
IL_003c: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0041: brtrue.s IL_004e
IL_0043: ldstr "tfol.settings"
IL_0048: ldarg.0
IL_0049: call System.Void ES3::DeleteFile(System.String,ES3Settings)
IL_004e: ret
METHOD TheForestOfLove.Services.Persistence.GlobalSavestate TheForestOfLove.Services.Persistence.GlobalSavegameFileHelper::ReadDataFromGameDirectory() | attributes=Private, Static, HideBySig | impl=IL
IL_0000: ldstr "tfol.settings"
IL_0005: ldsfld ES3Settings TheForestOfLove.Services.Persistence.SavegameFileHelper::settingsLocalGameDirectory
IL_000a: call System.Boolean ES3::FileExists(System.String,ES3Settings)
IL_000f: brfalse.s IL_0028
IL_0011: ldstr "config_data"
IL_0016: ldstr "tfol.settings"
IL_001b: ldsfld ES3Settings TheForestOfLove.Services.Persistence.SavegameFileHelper::settingsLocalGameDirectory
IL_0020: call !!0 ES3::Load<TheForestOfLove.Services.Persistence.GlobalSavestate>(System.String,System.String,ES3Settings)
IL_0025: stloc.0
IL_0026: leave.s IL_0079
IL_0028: ldstr "tfol.settings"
IL_002d: ldsfld ES3Settings TheForestOfLove.Services.Persistence.SavegameFileHelper::settingsPersistentData
IL_0032: call System.Boolean ES3::FileExists(System.String,ES3Settings)
IL_0037: brfalse.s IL_0050
IL_0039: ldstr "config_data"
IL_003e: ldstr "tfol.settings"
IL_0043: ldsfld ES3Settings TheForestOfLove.Services.Persistence.SavegameFileHelper::settingsPersistentData
IL_0048: call !!0 ES3::Load<TheForestOfLove.Services.Persistence.GlobalSavestate>(System.String,System.String,ES3Settings)
IL_004d: stloc.0
IL_004e: leave.s IL_0079
IL_0050: leave.s IL_0073
IL_0052: ldstr "Global Savestate File Read Failed!"
IL_0057: call System.Void UnityEngine.Debug::Log(System.Object)
IL_005c: dup
IL_005d: callvirt System.String System.Exception::get_Message()
IL_0062: call System.Void UnityEngine.Debug::Log(System.Object)
IL_0067: callvirt System.String System.Exception::get_StackTrace()
IL_006c: call System.Void UnityEngine.Debug::Log(System.Object)
IL_0071: leave.s IL_0073
IL_0073: newobj System.Void TheForestOfLove.Services.Persistence.GlobalSavestate::.ctor()
IL_0078: ret
IL_0079: ldloc.0
IL_007a: ret
