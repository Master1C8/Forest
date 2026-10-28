TYPE TheForestOfLove.Services.Persistence.SavegameFileHelper
METHOD TheForestOfLove.Services.Persistence.Savestate TheForestOfLove.Services.Persistence.SavegameFileHelper::ReadSavegameData() | attributes=Public, Static, HideBySig | impl=IL
IL_0000: call System.Boolean TheForestOfLove.Services.Persistence.SavegameFileHelper::get_savingEnabled()
IL_0005: brtrue.s IL_0009
IL_0007: ldnull
IL_0008: ret
IL_0009: call System.Void TheForestOfLove.Services.Persistence.SavegameFileHelper::CleanupLegacySavegameFiles()
IL_000e: ldstr "tfol.savegame"
IL_0013: call TheForestOfLove.Services.Persistence.Savestate TheForestOfLove.Services.Persistence.SavegameFileHelper::ReadDataFromGameDirectory(System.String)
IL_0018: ret
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
METHOD System.Void TheForestOfLove.Services.Persistence.SavegameFileHelper::WriteSavegameData(TheForestOfLove.Services.Persistence.Savestate) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: call System.Boolean TheForestOfLove.Services.Persistence.SavegameFileHelper::get_savingEnabled()
IL_0005: brtrue.s IL_0008
IL_0007: ret
IL_0008: ldstr "tfol.savegame"
IL_000d: ldarg.0
IL_000e: ldsfld ES3Settings TheForestOfLove.Services.Persistence.SavegameFileHelper::settingsLocalGameDirectory
IL_0013: call System.Boolean TheForestOfLove.Services.Persistence.SavegameFileHelper::WriteDataToGameDirectory(System.String,TheForestOfLove.Services.Persistence.Savestate,ES3Settings)
IL_0018: pop
IL_0019: ldstr "tfol.savegame"
IL_001e: ldarg.0
IL_001f: ldsfld ES3Settings TheForestOfLove.Services.Persistence.SavegameFileHelper::settingsPersistentData
IL_0024: call System.Boolean TheForestOfLove.Services.Persistence.SavegameFileHelper::WriteDataToGameDirectory(System.String,TheForestOfLove.Services.Persistence.Savestate,ES3Settings)
IL_0029: pop
IL_002a: ret
METHOD System.Boolean TheForestOfLove.Services.Persistence.SavegameFileHelper::WriteDataToGameDirectory(System.String,TheForestOfLove.Services.Persistence.Savestate,ES3Settings) | attributes=Private, Static, HideBySig | impl=IL
IL_0000: ldstr "savegame_version"
IL_0005: ldstr "231129"
IL_000a: ldarg.0
IL_000b: ldarg.2
IL_000c: call System.Void ES3::Save<System.String>(System.String,!!0,System.String,ES3Settings)
IL_0011: ldstr "savegame_data"
IL_0016: ldarg.1
IL_0017: ldarg.0
IL_0018: ldarg.2
IL_0019: call System.Void ES3::Save<TheForestOfLove.Services.Persistence.Savestate>(System.String,!!0,System.String,ES3Settings)
IL_001e: ldc.i4.1
IL_001f: stloc.0
IL_0020: leave.s IL_0045
IL_0022: ldstr "Savestate File Write Failed!"
IL_0027: call System.Void UnityEngine.Debug::Log(System.Object)
IL_002c: dup
IL_002d: callvirt System.String System.Exception::get_Message()
IL_0032: call System.Void UnityEngine.Debug::Log(System.Object)
IL_0037: callvirt System.String System.Exception::get_StackTrace()
IL_003c: call System.Void UnityEngine.Debug::Log(System.Object)
IL_0041: leave.s IL_0043
IL_0043: ldc.i4.0
IL_0044: ret
IL_0045: ldloc.0
IL_0046: ret
METHOD System.Boolean TheForestOfLove.Services.Persistence.SavegameFileHelper::WriteDataToPlayerPrefs(TheForestOfLove.Services.Persistence.Savestate) | attributes=Private, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldnull
IL_0002: call System.Byte[] ES3::Serialize<TheForestOfLove.Services.Persistence.Savestate>(!!0,ES3Settings)
IL_0007: call System.String System.Convert::ToBase64String(System.Byte[])
IL_000c: stloc.0
IL_000d: ldstr "savegame_data"
IL_0012: ldloc.0
IL_0013: call System.Void UnityEngine.PlayerPrefs::SetString(System.String,System.String)
IL_0018: call System.Void UnityEngine.PlayerPrefs::Save()
IL_001d: ldc.i4.1
IL_001e: stloc.1
IL_001f: leave.s IL_0044
IL_0021: ldstr "PlayerPrefs: Savestate File Write Failed!"
IL_0026: call System.Void UnityEngine.Debug::Log(System.Object)
IL_002b: dup
IL_002c: callvirt System.String System.Exception::get_Message()
IL_0031: call System.Void UnityEngine.Debug::Log(System.Object)
IL_0036: callvirt System.String System.Exception::get_StackTrace()
IL_003b: call System.Void UnityEngine.Debug::Log(System.Object)
IL_0040: leave.s IL_0042
IL_0042: ldc.i4.0
IL_0043: ret
IL_0044: ldloc.1
IL_0045: ret
METHOD System.Void TheForestOfLove.Services.Persistence.SavegameFileHelper::DeleteDataInGameDirectory(ES3Settings) | attributes=Private, Static, HideBySig | impl=IL
IL_0000: ldstr "tfol.savegame"
IL_0005: ldarg.0
IL_0006: call System.Boolean ES3::FileExists(System.String,ES3Settings)
IL_000b: brfalse.s IL_0018
IL_000d: ldstr "tfol.savegame"
IL_0012: ldarg.0
IL_0013: call System.Void ES3::DeleteFile(System.String,ES3Settings)
IL_0018: leave.s IL_003b
IL_001a: ldstr "Savestate File Delete Failed!"
IL_001f: call System.Void UnityEngine.Debug::Log(System.Object)
IL_0024: dup
IL_0025: callvirt System.String System.Exception::get_Message()
IL_002a: call System.Void UnityEngine.Debug::Log(System.Object)
IL_002f: callvirt System.String System.Exception::get_StackTrace()
IL_0034: call System.Void UnityEngine.Debug::Log(System.Object)
IL_0039: leave.s IL_003b
IL_003b: ret
