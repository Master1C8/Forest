TYPE DarkTonic.MasterAudio.PlaylistController
METHOD DarkTonic.MasterAudio.PlaylistController DarkTonic.MasterAudio.PlaylistController::InstanceByName(System.String,System.Boolean) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldc.i4.0
IL_0001: stloc.0
IL_0002: br.s IL_002d
IL_0004: call System.Collections.Generic.List`1<DarkTonic.MasterAudio.PlaylistController> DarkTonic.MasterAudio.PlaylistController::get_Instances()
IL_0009: ldloc.0
IL_000a: callvirt !0 System.Collections.Generic.List`1<DarkTonic.MasterAudio.PlaylistController>::get_Item(System.Int32)
IL_000f: stloc.1
IL_0010: ldloc.1
IL_0011: ldnull
IL_0012: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0017: brfalse.s IL_0029
IL_0019: ldloc.1
IL_001a: callvirt System.String DarkTonic.MasterAudio.PlaylistController::get_ControllerName()
IL_001f: ldarg.0
IL_0020: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0025: brfalse.s IL_0029
IL_0027: ldloc.1
IL_0028: ret
IL_0029: ldloc.0
IL_002a: ldc.i4.1
IL_002b: add
IL_002c: stloc.0
IL_002d: ldloc.0
IL_002e: call System.Collections.Generic.List`1<DarkTonic.MasterAudio.PlaylistController> DarkTonic.MasterAudio.PlaylistController::get_Instances()
IL_0033: callvirt System.Int32 System.Collections.Generic.List`1<DarkTonic.MasterAudio.PlaylistController>::get_Count()
IL_0038: blt.s IL_0004
IL_003a: ldarg.1
IL_003b: brfalse.s IL_0052
IL_003d: ldstr "Could not find Playlist Controller '"
IL_0042: ldarg.0
IL_0043: ldstr "'."
IL_0048: call System.String System.String::Concat(System.String,System.String,System.String)
IL_004d: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_0052: ldnull
IL_0053: ret
METHOD System.Boolean DarkTonic.MasterAudio.PlaylistController::IsSongPlaying(System.String) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Boolean DarkTonic.MasterAudio.PlaylistController::get_HasPlaylist()
IL_0006: brtrue.s IL_000a
IL_0008: ldc.i4.0
IL_0009: ret
IL_000a: ldarg.0
IL_000b: call UnityEngine.AudioSource DarkTonic.MasterAudio.PlaylistController::get_ActiveAudioSource()
IL_0010: ldnull
IL_0011: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0016: brtrue.s IL_002b
IL_0018: ldarg.0
IL_0019: call UnityEngine.AudioSource DarkTonic.MasterAudio.PlaylistController::get_ActiveAudioSource()
IL_001e: callvirt UnityEngine.AudioClip UnityEngine.AudioSource::get_clip()
IL_0023: ldnull
IL_0024: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0029: brfalse.s IL_002d
IL_002b: ldc.i4.0
IL_002c: ret
IL_002d: ldarg.0
IL_002e: call UnityEngine.AudioSource DarkTonic.MasterAudio.PlaylistController::get_ActiveAudioSource()
IL_0033: callvirt UnityEngine.AudioClip UnityEngine.AudioSource::get_clip()
IL_0038: call System.String AudioClipOptimizer::CachedName(UnityEngine.AudioClip)
IL_003d: ldarg.1
IL_003e: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0043: brfalse.s IL_0047
IL_0045: ldc.i4.1
IL_0046: ret
IL_0047: ldarg.0
IL_0048: ldfld System.String DarkTonic.MasterAudio.PlaylistController::_activeSongAlias
IL_004d: ldarg.1
IL_004e: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0053: ret
