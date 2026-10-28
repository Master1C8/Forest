TYPE TheForestOfLove.Services.Persistence.GlobalSavegameFileHelper
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
METHOD TheForestOfLove.Services.Persistence.GlobalSavestate TheForestOfLove.Services.Persistence.GlobalSavegameFileHelper::ReadDataFromPlayerPrefs() | attributes=Private, Static, HideBySig | impl=IL
IL_0000: newobj System.Void TheForestOfLove.Services.Persistence.GlobalSavestate::.ctor()
IL_0005: stloc.0
IL_0006: ldloc.0
IL_0007: callvirt TheForestOfLove.Services.Persistence.SavegameGlobalGeneralData TheForestOfLove.Services.Persistence.GlobalSavestate::LoadGeneralData()
IL_000c: stloc.1
IL_000d: ldstr "effectsVolume"
IL_0012: call System.Boolean UnityEngine.PlayerPrefs::HasKey(System.String)
IL_0017: brfalse.s IL_0029
IL_0019: ldloc.1
IL_001a: ldstr "effectsVolume"
IL_001f: call System.Single UnityEngine.PlayerPrefs::GetFloat(System.String)
IL_0024: stfld System.Single TheForestOfLove.Services.Persistence.SavegameGlobalGeneralData::effectsVolumeValue
IL_0029: ldstr "musicVolume"
IL_002e: call System.Boolean UnityEngine.PlayerPrefs::HasKey(System.String)
IL_0033: brfalse.s IL_004b
IL_0035: ldloc.1
IL_0036: ldstr "musicVolume"
IL_003b: ldloc.1
IL_003c: ldfld System.Single TheForestOfLove.Services.Persistence.SavegameGlobalGeneralData::musicVolumeValue
IL_0041: call System.Single UnityEngine.PlayerPrefs::GetFloat(System.String,System.Single)
IL_0046: stfld System.Single TheForestOfLove.Services.Persistence.SavegameGlobalGeneralData::musicVolumeValue
IL_004b: ldstr "enableFullscreen"
IL_0050: call System.Boolean UnityEngine.PlayerPrefs::HasKey(System.String)
IL_0055: brfalse.s IL_006e
IL_0057: ldloc.1
IL_0058: ldstr "enableFullscreen"
IL_005d: call System.Int32 UnityEngine.PlayerPrefs::GetInt(System.String)
IL_0062: ldc.i4.1
IL_0063: beq.s IL_0068
IL_0065: ldc.i4.0
IL_0066: br.s IL_0069
IL_0068: ldc.i4.1
IL_0069: stfld System.Boolean TheForestOfLove.Services.Persistence.SavegameGlobalGeneralData::isFullscreen
IL_006e: ldstr "enableFullscreenStretch"
IL_0073: call System.Boolean UnityEngine.PlayerPrefs::HasKey(System.String)
IL_0078: brfalse.s IL_0091
IL_007a: ldloc.1
IL_007b: ldstr "enableFullscreenStretch"
IL_0080: call System.Int32 UnityEngine.PlayerPrefs::GetInt(System.String)
IL_0085: ldc.i4.1
IL_0086: beq.s IL_008b
IL_0088: ldc.i4.0
IL_0089: br.s IL_008c
IL_008b: ldc.i4.1
IL_008c: stfld System.Boolean TheForestOfLove.Services.Persistence.SavegameGlobalGeneralData::enableFullscreenStretch
IL_0091: ldstr "windowScaleFactorIndex"
IL_0096: call System.Boolean UnityEngine.PlayerPrefs::HasKey(System.String)
IL_009b: brfalse.s IL_00b3
IL_009d: ldloc.1
IL_009e: ldstr "windowScaleFactorIndex"
IL_00a3: ldloc.1
IL_00a4: ldfld System.Int32 TheForestOfLove.Services.Persistence.SavegameGlobalGeneralData::windowScalingIndex
IL_00a9: call System.Int32 UnityEngine.PlayerPrefs::GetInt(System.String,System.Int32)
IL_00ae: stfld System.Int32 TheForestOfLove.Services.Persistence.SavegameGlobalGeneralData::windowScalingIndex
IL_00b3: ldstr "finishedFirstLaunch"
IL_00b8: call System.Boolean UnityEngine.PlayerPrefs::HasKey(System.String)
IL_00bd: brfalse.s IL_00d6
IL_00bf: ldloc.1
IL_00c0: ldstr "finishedFirstLaunch"
IL_00c5: call System.Int32 UnityEngine.PlayerPrefs::GetInt(System.String)
IL_00ca: ldc.i4.1
IL_00cb: beq.s IL_00d0
IL_00cd: ldc.i4.0
IL_00ce: br.s IL_00d1
IL_00d0: ldc.i4.1
IL_00d1: stfld System.Boolean TheForestOfLove.Services.Persistence.SavegameGlobalGeneralData::finishedFirstLaunch
IL_00d6: ldstr "finishedGalleryTutorial"
IL_00db: call System.Boolean UnityEngine.PlayerPrefs::HasKey(System.String)
IL_00e0: brfalse.s IL_00f9
IL_00e2: ldloc.1
IL_00e3: ldstr "finishedGalleryTutorial"
IL_00e8: call System.Int32 UnityEngine.PlayerPrefs::GetInt(System.String)
IL_00ed: ldc.i4.1
IL_00ee: beq.s IL_00f3
IL_00f0: ldc.i4.0
IL_00f1: br.s IL_00f4
IL_00f3: ldc.i4.1
IL_00f4: stfld System.Boolean TheForestOfLove.Services.Persistence.SavegameGlobalGeneralData::finishedGalleryTutorial
IL_00f9: ldstr "showGalleryDialogue"
IL_00fe: call System.Boolean UnityEngine.PlayerPrefs::HasKey(System.String)
IL_0103: brfalse.s IL_011c
IL_0105: ldloc.1
IL_0106: ldstr "showGalleryDialogue"
IL_010b: call System.Int32 UnityEngine.PlayerPrefs::GetInt(System.String)
IL_0110: ldc.i4.1
IL_0111: beq.s IL_0116
IL_0113: ldc.i4.0
IL_0114: br.s IL_0117
IL_0116: ldc.i4.1
IL_0117: stfld System.Boolean TheForestOfLove.Services.Persistence.SavegameGlobalGeneralData::showDialogueInGalleryMovies
IL_011c: ldstr "totalPlaytime"
IL_0121: call System.Boolean UnityEngine.PlayerPrefs::HasKey(System.String)
IL_0126: brfalse.s IL_0138
IL_0128: ldloc.1
IL_0129: ldstr "totalPlaytime"
IL_012e: call System.Single UnityEngine.PlayerPrefs::GetFloat(System.String)
IL_0133: stfld System.Single TheForestOfLove.Services.Persistence.SavegameGlobalGeneralData::totalPlaytime
IL_0138: ldstr "bugReportToolPreferredSystemInfoDetailLevel"
IL_013d: call System.Boolean UnityEngine.PlayerPrefs::HasKey(System.String)
IL_0142: brfalse.s IL_0154
IL_0144: ldloc.1
IL_0145: ldstr "bugReportToolPreferredSystemInfoDetailLevel"
IL_014a: call System.Int32 UnityEngine.PlayerPrefs::GetInt(System.String)
IL_014f: stfld System.Int32 TheForestOfLove.Services.Persistence.SavegameGlobalGeneralData::bugReportToolPreferredSystemInfoDetailLevel
IL_0154: ldstr "lastKnownScreenResolutionWidth"
IL_0159: call System.Boolean UnityEngine.PlayerPrefs::HasKey(System.String)
IL_015e: brfalse.s IL_0170
IL_0160: ldloc.1
IL_0161: ldstr "lastKnownScreenResolutionWidth"
IL_0166: call System.Int32 UnityEngine.PlayerPrefs::GetInt(System.String)
IL_016b: stfld System.Int32 TheForestOfLove.Services.Persistence.SavegameGlobalGeneralData::lastKnownScreenResolutionWidth
IL_0170: ldstr "lastKnownScreenResolutionHeight"
IL_0175: call System.Boolean UnityEngine.PlayerPrefs::HasKey(System.String)
IL_017a: brfalse.s IL_018c
IL_017c: ldloc.1
IL_017d: ldstr "lastKnownScreenResolutionHeight"
IL_0182: call System.Int32 UnityEngine.PlayerPrefs::GetInt(System.String)
IL_0187: stfld System.Int32 TheForestOfLove.Services.Persistence.SavegameGlobalGeneralData::lastKnownScreenResolutionHeight
IL_018c: ldstr "chapterUnlocks"
IL_0191: call System.Collections.Generic.List`1<System.String> TheForestOfLove.Services.Persistence.GlobalSavegameFileHelper::ReadPlayerPrefsJsonStringList(System.String)
IL_0196: ldstr "movieUnlocks"
IL_019b: call System.Collections.Generic.List`1<System.String> TheForestOfLove.Services.Persistence.GlobalSavegameFileHelper::ReadPlayerPrefsJsonStringList(System.String)
IL_01a0: stloc.2
IL_01a1: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<System.String>::GetEnumerator()
IL_01a6: stloc.3
IL_01a7: br.s IL_01ba
IL_01a9: ldloca.s V_3
IL_01ab: call !0 System.Collections.Generic.List`1/Enumerator<System.String>::get_Current()
IL_01b0: stloc.s V_4
IL_01b2: ldloc.0
IL_01b3: ldloc.s V_4
IL_01b5: callvirt System.Void TheForestOfLove.Services.Persistence.GlobalSavestate::SaveChapterUnlock(System.String)
IL_01ba: ldloca.s V_3
IL_01bc: call System.Boolean System.Collections.Generic.List`1/Enumerator<System.String>::MoveNext()
IL_01c1: brtrue.s IL_01a9
IL_01c3: leave.s IL_01d3
IL_01c5: ldloca.s V_3
IL_01c7: constrained. System.Collections.Generic.List`1/Enumerator<System.String>
IL_01cd: callvirt System.Void System.IDisposable::Dispose()
IL_01d2: endfinally
IL_01d3: ldloc.2
IL_01d4: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<System.String>::GetEnumerator()
IL_01d9: stloc.3
IL_01da: br.s IL_01ed
IL_01dc: ldloca.s V_3
IL_01de: call !0 System.Collections.Generic.List`1/Enumerator<System.String>::get_Current()
IL_01e3: stloc.s V_5
IL_01e5: ldloc.0
IL_01e6: ldloc.s V_5
IL_01e8: callvirt System.Void TheForestOfLove.Services.Persistence.GlobalSavestate::SaveMovieUnlock(System.String)
IL_01ed: ldloca.s V_3
IL_01ef: call System.Boolean System.Collections.Generic.List`1/Enumerator<System.String>::MoveNext()
IL_01f4: brtrue.s IL_01dc
IL_01f6: leave.s IL_0206
IL_01f8: ldloca.s V_3
IL_01fa: constrained. System.Collections.Generic.List`1/Enumerator<System.String>
IL_0200: callvirt System.Void System.IDisposable::Dispose()
IL_0205: endfinally
IL_0206: ldloc.0
IL_0207: stloc.s V_6
IL_0209: leave.s IL_0232
IL_020b: ldstr "Global Savestate PlayerPrefs Read Failed!"
IL_0210: call System.Void UnityEngine.Debug::Log(System.Object)
IL_0215: dup
IL_0216: callvirt System.String System.Exception::get_Message()
IL_021b: call System.Void UnityEngine.Debug::Log(System.Object)
IL_0220: callvirt System.String System.Exception::get_StackTrace()
IL_0225: call System.Void UnityEngine.Debug::Log(System.Object)
IL_022a: leave.s IL_022c
IL_022c: newobj System.Void TheForestOfLove.Services.Persistence.GlobalSavestate::.ctor()
IL_0231: ret
IL_0232: ldloc.s V_6
IL_0234: ret
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
METHOD System.Boolean TheForestOfLove.Services.Persistence.GlobalSavegameFileHelper::WriteDataToPlayerPrefs(TheForestOfLove.Services.Persistence.GlobalSavestate) | attributes=Private, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: callvirt TheForestOfLove.Services.Persistence.SavegameGlobalGeneralData TheForestOfLove.Services.Persistence.GlobalSavestate::LoadGeneralData()
IL_0006: stloc.0
IL_0007: ldstr "effectsVolume"
IL_000c: ldloc.0
IL_000d: ldfld System.Single TheForestOfLove.Services.Persistence.SavegameGlobalGeneralData::effectsVolumeValue
IL_0012: call System.Void UnityEngine.PlayerPrefs::SetFloat(System.String,System.Single)
IL_0017: ldstr "musicVolume"
IL_001c: ldloc.0
IL_001d: ldfld System.Single TheForestOfLove.Services.Persistence.SavegameGlobalGeneralData::musicVolumeValue
IL_0022: call System.Void UnityEngine.PlayerPrefs::SetFloat(System.String,System.Single)
IL_0027: ldstr "enableFullscreen"
IL_002c: ldloc.0
IL_002d: ldfld System.Boolean TheForestOfLove.Services.Persistence.SavegameGlobalGeneralData::isFullscreen
IL_0032: brtrue.s IL_0037
IL_0034: ldc.i4.0
IL_0035: br.s IL_0038
IL_0037: ldc.i4.1
IL_0038: call System.Void UnityEngine.PlayerPrefs::SetInt(System.String,System.Int32)
IL_003d: ldstr "enableFullscreenStretch"
IL_0042: ldloc.0
IL_0043: ldfld System.Boolean TheForestOfLove.Services.Persistence.SavegameGlobalGeneralData::enableFullscreenStretch
IL_0048: brtrue.s IL_004d
IL_004a: ldc.i4.0
IL_004b: br.s IL_004e
IL_004d: ldc.i4.1
IL_004e: call System.Void UnityEngine.PlayerPrefs::SetInt(System.String,System.Int32)
IL_0053: ldstr "windowScaleFactorIndex"
IL_0058: ldloc.0
IL_0059: ldfld System.Int32 TheForestOfLove.Services.Persistence.SavegameGlobalGeneralData::windowScalingIndex
IL_005e: call System.Void UnityEngine.PlayerPrefs::SetInt(System.String,System.Int32)
IL_0063: ldstr "finishedFirstLaunch"
IL_0068: ldloc.0
IL_0069: ldfld System.Boolean TheForestOfLove.Services.Persistence.SavegameGlobalGeneralData::finishedFirstLaunch
IL_006e: brtrue.s IL_0073
IL_0070: ldc.i4.0
IL_0071: br.s IL_0074
IL_0073: ldc.i4.1
IL_0074: call System.Void UnityEngine.PlayerPrefs::SetInt(System.String,System.Int32)
IL_0079: ldstr "finishedGalleryTutorial"
IL_007e: ldloc.0
IL_007f: ldfld System.Boolean TheForestOfLove.Services.Persistence.SavegameGlobalGeneralData::finishedGalleryTutorial
IL_0084: brtrue.s IL_0089
IL_0086: ldc.i4.0
IL_0087: br.s IL_008a
IL_0089: ldc.i4.1
IL_008a: call System.Void UnityEngine.PlayerPrefs::SetInt(System.String,System.Int32)
IL_008f: ldstr "showGalleryDialogue"
IL_0094: ldloc.0
IL_0095: ldfld System.Boolean TheForestOfLove.Services.Persistence.SavegameGlobalGeneralData::showDialogueInGalleryMovies
IL_009a: brtrue.s IL_009f
IL_009c: ldc.i4.0
IL_009d: br.s IL_00a0
IL_009f: ldc.i4.1
IL_00a0: call System.Void UnityEngine.PlayerPrefs::SetInt(System.String,System.Int32)
IL_00a5: ldstr "totalPlaytime"
IL_00aa: ldloc.0
IL_00ab: ldfld System.Boolean TheForestOfLove.Services.Persistence.SavegameGlobalGeneralData::showDialogueInGalleryMovies
IL_00b0: brtrue.s IL_00b5
IL_00b2: ldc.i4.0
IL_00b3: br.s IL_00b6
IL_00b5: ldc.i4.1
IL_00b6: call System.Void UnityEngine.PlayerPrefs::SetInt(System.String,System.Int32)
IL_00bb: ldstr "bugReportToolPreferredSystemInfoDetailLevel"
IL_00c0: ldloc.0
IL_00c1: ldfld System.Int32 TheForestOfLove.Services.Persistence.SavegameGlobalGeneralData::bugReportToolPreferredSystemInfoDetailLevel
IL_00c6: call System.Void UnityEngine.PlayerPrefs::SetInt(System.String,System.Int32)
IL_00cb: ldstr "lastKnownScreenResolutionWidth"
IL_00d0: ldloc.0
IL_00d1: ldfld System.Int32 TheForestOfLove.Services.Persistence.SavegameGlobalGeneralData::lastKnownScreenResolutionWidth
IL_00d6: call System.Void UnityEngine.PlayerPrefs::SetInt(System.String,System.Int32)
IL_00db: ldstr "lastKnownScreenResolutionHeight"
IL_00e0: ldloc.0
IL_00e1: ldfld System.Int32 TheForestOfLove.Services.Persistence.SavegameGlobalGeneralData::lastKnownScreenResolutionHeight
IL_00e6: call System.Void UnityEngine.PlayerPrefs::SetInt(System.String,System.Int32)
IL_00eb: ldarg.0
IL_00ec: callvirt System.Collections.Generic.IEnumerable`1<System.String> TheForestOfLove.Services.Persistence.GlobalSavestate::LoadChapterUnlocks()
IL_00f1: newobj System.Void System.Collections.Generic.List`1<System.String>::.ctor(System.Collections.Generic.IEnumerable`1<!0>)
IL_00f6: stloc.1
IL_00f7: ldstr "chapterUnlocks"
IL_00fc: ldloc.1
IL_00fd: call System.String SRF.Json::Serialize(System.Object)
IL_0102: call System.Void UnityEngine.PlayerPrefs::SetString(System.String,System.String)
IL_0107: ldarg.0
IL_0108: callvirt System.Collections.Generic.IEnumerable`1<System.String> TheForestOfLove.Services.Persistence.GlobalSavestate::LoadMovieUnlocks()
IL_010d: newobj System.Void System.Collections.Generic.List`1<System.String>::.ctor(System.Collections.Generic.IEnumerable`1<!0>)
IL_0112: stloc.2
IL_0113: ldstr "movieUnlocks"
IL_0118: ldloc.2
IL_0119: call System.String SRF.Json::Serialize(System.Object)
IL_011e: call System.Void UnityEngine.PlayerPrefs::SetString(System.String,System.String)
IL_0123: call System.Void UnityEngine.PlayerPrefs::Save()
IL_0128: ldc.i4.1
IL_0129: stloc.3
IL_012a: leave.s IL_014f
IL_012c: ldstr "Global Savestate PlayerPrefs Write Failed!"
IL_0131: call System.Void UnityEngine.Debug::Log(System.Object)
IL_0136: dup
IL_0137: callvirt System.String System.Exception::get_Message()
IL_013c: call System.Void UnityEngine.Debug::Log(System.Object)
IL_0141: callvirt System.String System.Exception::get_StackTrace()
IL_0146: call System.Void UnityEngine.Debug::Log(System.Object)
IL_014b: leave.s IL_014d
IL_014d: ldc.i4.0
IL_014e: ret
IL_014f: ldloc.3
IL_0150: ret
METHOD System.Boolean TheForestOfLove.Services.Persistence.GlobalSavegameFileHelper::WriteDataToGameDirectory(TheForestOfLove.Services.Persistence.GlobalSavestate,ES3Settings) | attributes=Private, Static, HideBySig | impl=IL
IL_0000: ldstr "config_version"
IL_0005: ldstr "220308"
IL_000a: ldstr "tfol.settings"
IL_000f: ldarg.1
IL_0010: call System.Void ES3::Save<System.String>(System.String,!!0,System.String,ES3Settings)
IL_0015: ldstr "config_data"
IL_001a: ldarg.0
IL_001b: ldstr "tfol.settings"
IL_0020: ldarg.1
IL_0021: call System.Void ES3::Save<TheForestOfLove.Services.Persistence.GlobalSavestate>(System.String,!!0,System.String,ES3Settings)
IL_0026: ldc.i4.1
IL_0027: stloc.0
IL_0028: leave.s IL_004d
IL_002a: ldstr "Global Savestate File Write Failed!"
IL_002f: call System.Void UnityEngine.Debug::Log(System.Object)
IL_0034: dup
IL_0035: callvirt System.String System.Exception::get_Message()
IL_003a: call System.Void UnityEngine.Debug::Log(System.Object)
IL_003f: callvirt System.String System.Exception::get_StackTrace()
IL_0044: call System.Void UnityEngine.Debug::Log(System.Object)
IL_0049: leave.s IL_004b
IL_004b: ldc.i4.0
IL_004c: ret
IL_004d: ldloc.0
IL_004e: ret
METHOD System.Void TheForestOfLove.Services.Persistence.GlobalSavegameFileHelper::DeleteDataInGameDirectory(ES3Settings) | attributes=Private, Static, HideBySig | impl=IL
IL_0000: ldstr "tfol.settings"
IL_0005: ldarg.0
IL_0006: call System.Boolean ES3::FileExists(System.String,ES3Settings)
IL_000b: brfalse.s IL_0018
IL_000d: ldstr "tfol.settings"
IL_0012: ldarg.0
IL_0013: call System.Void ES3::DeleteFile(System.String,ES3Settings)
IL_0018: leave.s IL_003b
IL_001a: ldstr "Global Savestate File Delete Failed!"
IL_001f: call System.Void UnityEngine.Debug::Log(System.Object)
IL_0024: dup
IL_0025: callvirt System.String System.Exception::get_Message()
IL_002a: call System.Void UnityEngine.Debug::Log(System.Object)
IL_002f: callvirt System.String System.Exception::get_StackTrace()
IL_0034: call System.Void UnityEngine.Debug::Log(System.Object)
IL_0039: leave.s IL_003b
IL_003b: ret
