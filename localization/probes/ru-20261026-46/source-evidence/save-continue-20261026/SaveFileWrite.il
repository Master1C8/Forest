TYPE TheForestOfLove.Services.Persistence.SavegameFileHelper
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
