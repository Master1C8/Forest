TYPE TheForestOfLove.StartScreenGalleryMenu
METHOD System.Void TheForestOfLove.StartScreenGalleryMenu::OnClickPlay(System.String) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Boolean TheForestOfLove.StartScreenGalleryMenu::isSuspendedForHint
IL_0006: brfalse.s IL_0009
IL_0008: ret
IL_0009: call System.Boolean TheForestOfLove.MovieManager::get_isPlayingMovie()
IL_000e: brfalse.s IL_0011
IL_0010: ret
IL_0011: ldtoken TheForestOfLove.Narrative.Movie
IL_0016: call System.Type System.Type::GetTypeFromHandle(System.RuntimeTypeHandle)
IL_001b: ldarg.1
IL_001c: call System.Object System.Enum::Parse(System.Type,System.String)
IL_0021: unbox.any TheForestOfLove.Narrative.Movie
IL_0026: stloc.0
IL_0027: ldnull
IL_0028: stloc.1
IL_0029: ldc.i4.0
IL_002a: stloc.2
IL_002b: ldc.i4.0
IL_002c: stloc.3
IL_002d: ldc.i4.0
IL_002e: stloc.s V_4
IL_0030: ldarg.0
IL_0031: ldfld TheForestOfLove.StartScreenGalleryMenuMovie[] TheForestOfLove.StartScreenGalleryMenu::movieOptions
IL_0036: stloc.s V_5
IL_0038: ldc.i4.0
IL_0039: stloc.s V_6
IL_003b: br.s IL_005f
IL_003d: ldloc.s V_5
IL_003f: ldloc.s V_6
IL_0041: ldelem.ref
IL_0042: stloc.s V_7
IL_0044: ldloc.0
IL_0045: ldloc.s V_7
IL_0047: ldfld TheForestOfLove.Narrative.Movie TheForestOfLove.StartScreenGalleryMenuMovie::movie
IL_004c: bne.un.s IL_0055
IL_004e: ldloc.s V_7
IL_0050: stloc.1
IL_0051: ldc.i4.1
IL_0052: stloc.2
IL_0053: br.s IL_0067
IL_0055: ldloc.3
IL_0056: ldc.i4.1
IL_0057: add
IL_0058: stloc.3
IL_0059: ldloc.s V_6
IL_005b: ldc.i4.1
IL_005c: add
IL_005d: stloc.s V_6
IL_005f: ldloc.s V_6
IL_0061: ldloc.s V_5
IL_0063: ldlen
IL_0064: conv.i4
IL_0065: blt.s IL_003d
IL_0067: ldarg.0
IL_0068: ldfld TheForestOfLove.StartScreenGalleryMenuMovie[] TheForestOfLove.StartScreenGalleryMenu::storyOptions
IL_006d: stloc.s V_5
IL_006f: ldc.i4.0
IL_0070: stloc.s V_6
IL_0072: br.s IL_0096
IL_0074: ldloc.s V_5
IL_0076: ldloc.s V_6
IL_0078: ldelem.ref
IL_0079: stloc.s V_8
IL_007b: ldloc.0
IL_007c: ldloc.s V_8
IL_007e: ldfld TheForestOfLove.Narrative.Movie TheForestOfLove.StartScreenGalleryMenuMovie::movie
IL_0083: bne.un.s IL_008a
IL_0085: ldloc.s V_8
IL_0087: stloc.1
IL_0088: br.s IL_009e
IL_008a: ldloc.s V_4
IL_008c: ldc.i4.1
IL_008d: add
IL_008e: stloc.s V_4
IL_0090: ldloc.s V_6
IL_0092: ldc.i4.1
IL_0093: add
IL_0094: stloc.s V_6
IL_0096: ldloc.s V_6
IL_0098: ldloc.s V_5
IL_009a: ldlen
IL_009b: conv.i4
IL_009c: blt.s IL_0074
IL_009e: ldloc.1
IL_009f: ldfld TheForestOfLove.Narrative.Movie TheForestOfLove.StartScreenGalleryMenuMovie::movie
IL_00a4: stsfld TheForestOfLove.Narrative.Movie TheForestOfLove.StartScreenGalleryMenu::lastAttemptedMovie
IL_00a9: ldarg.0
IL_00aa: ldloc.2
IL_00ab: ldloc.3
IL_00ac: ldloc.s V_4
IL_00ae: call System.String TheForestOfLove.StartScreenGalleryMenu::BuildLastAttemptedMovieIdentifierPhrase(System.Boolean,System.Int32,System.Int32)
IL_00b3: stsfld System.String TheForestOfLove.StartScreenGalleryMenu::lastAttemptedMovieIdentifierPhrase
IL_00b8: ldloc.1
IL_00b9: ldfld System.Boolean TheForestOfLove.StartScreenGalleryMenuMovie::isUnlocked
IL_00be: brfalse.s IL_00fc
IL_00c0: call T TheForestOfLove.Services.ServiceLocator::Get<TheForestOfLove.ResponseOptionsUIMovieSwapper>()
IL_00c5: callvirt System.Void TheForestOfLove.ResponseOptionsUIMovieSwapper::DisableOverworldResponseOptionsUiForNextMovie()
IL_00ca: ldloc.0
IL_00cb: ldc.i4 5600
IL_00d0: bne.un.s IL_00eb
IL_00d2: ldc.r4 0
IL_00d7: ldc.r4 2
IL_00dc: newobj System.Void System.Nullable`1<System.Single>::.ctor(!0)
IL_00e1: call System.Void TheForestOfLove.Audio.MusicManager::FadeToVolume(System.Single,System.Nullable`1<System.Single>)
IL_00e6: call System.Void TheForestOfLove.GlitchRascalPart1Story::SetTargetMode_Part2_SexScene()
IL_00eb: ldc.i4 200
IL_00f0: call System.Void TheForestOfLove.Audio.SoundManager::Play(TheForestOfLove.Audio.SoundEffect)
IL_00f5: ldloc.0
IL_00f6: call System.Void TheForestOfLove.MovieManager::PlayMovie(TheForestOfLove.Narrative.Movie)
IL_00fb: ret
IL_00fc: ldc.i4 300
IL_0101: call System.Void TheForestOfLove.Audio.SoundManager::Play(TheForestOfLove.Audio.SoundEffect)
IL_0106: ldarg.0
IL_0107: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.StartScreenGalleryMenu::onExitGalleryShowHint
IL_010c: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_0111: ret
