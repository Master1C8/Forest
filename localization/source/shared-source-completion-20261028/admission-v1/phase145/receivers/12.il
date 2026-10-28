TYPE TheForestOfLove.Audio.MusicManager
METHOD System.Void TheForestOfLove.Audio.MusicManager::Play(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldsfld TheForestOfLove.Audio.MusicManager TheForestOfLove.Audio.MusicManager::instance
IL_0005: ldarg.0
IL_0006: callvirt System.Void TheForestOfLove.Audio.MusicManager::ChooseMusic(System.String)
IL_000b: ret
METHOD System.Void TheForestOfLove.Audio.MusicManager::Play() | attributes=Public, Static, HideBySig | impl=IL
IL_0000: call System.String TheForestOfLove.Services.SceneManagement.SceneHelper::get_CurrentSceneName()
IL_0005: stloc.0
IL_0006: ldloc.0
IL_0007: brfalse.s IL_0061
IL_0009: ldloc.0
IL_000a: ldstr "StartMenu"
IL_000f: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0014: brfalse.s IL_0061
IL_0016: ldsfld TheForestOfLove.Audio.MusicManager TheForestOfLove.Audio.MusicManager::instance
IL_001b: ldfld System.Boolean TheForestOfLove.Audio.MusicManager::waitForManualPlay
IL_0020: brfalse.s IL_0056
IL_0022: ldsfld TheForestOfLove.Audio.MusicManager TheForestOfLove.Audio.MusicManager::instance
IL_0027: ldfld DarkTonic.MasterAudio.PlaylistController TheForestOfLove.Audio.MusicManager::playlistControllerMain
IL_002c: ldsfld TheForestOfLove.Audio.MusicManager TheForestOfLove.Audio.MusicManager::instance
IL_0031: ldfld System.String TheForestOfLove.Audio.MusicManager::titleScreenPlaylistName
IL_0036: ldnull
IL_0037: callvirt System.Void DarkTonic.MasterAudio.PlaylistController::StartPlaylist(System.String,System.String)
IL_003c: ldsfld TheForestOfLove.Audio.MusicManager TheForestOfLove.Audio.MusicManager::instance
IL_0041: ldfld DarkTonic.MasterAudio.PlaylistController TheForestOfLove.Audio.MusicManager::playlistControllerSecondary
IL_0046: ldsfld TheForestOfLove.Audio.MusicManager TheForestOfLove.Audio.MusicManager::instance
IL_004b: ldfld System.String TheForestOfLove.Audio.MusicManager::titleScreenPlaylistName
IL_0050: ldnull
IL_0051: callvirt System.Void DarkTonic.MasterAudio.PlaylistController::StartPlaylist(System.String,System.String)
IL_0056: ldsfld TheForestOfLove.Audio.MusicManager TheForestOfLove.Audio.MusicManager::instance
IL_005b: ldc.i4.0
IL_005c: stfld System.Boolean TheForestOfLove.Audio.MusicManager::waitForManualPlay
IL_0061: ret
