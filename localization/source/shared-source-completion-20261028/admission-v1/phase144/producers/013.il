TYPE TheForestOfLove.Audio.VolumeController
METHOD System.Void TheForestOfLove.Audio.VolumeController::SetMusicValues(System.Single) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: stsfld System.Single TheForestOfLove.Audio.VolumeController::lastMusicVolumeSliderValue
IL_0006: ldarg.0
IL_0007: ldfld UnityEngine.Audio.AudioMixer TheForestOfLove.Audio.VolumeController::mainMixer
IL_000c: ldstr "MusicVol"
IL_0011: ldarg.0
IL_0012: ldfld UnityEngine.AnimationCurve TheForestOfLove.Audio.VolumeController::falloff
IL_0017: ldc.r4 1
IL_001c: ldarg.1
IL_001d: sub
IL_001e: callvirt System.Single UnityEngine.AnimationCurve::Evaluate(System.Single)
IL_0023: ldarg.0
IL_0024: ldfld System.Int32 TheForestOfLove.Audio.VolumeController::minimumVolumeDb
IL_0029: conv.r4
IL_002a: mul
IL_002b: callvirt System.Boolean UnityEngine.Audio.AudioMixer::SetFloat(System.String,System.Single)
IL_0030: pop
IL_0031: ret
METHOD System.Void TheForestOfLove.Audio.VolumeController::SetEffectsValues(System.Single) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: stsfld System.Single TheForestOfLove.Audio.VolumeController::lastEffectsVolumeSliderValue
IL_0006: ldarg.0
IL_0007: ldfld UnityEngine.Audio.AudioMixer TheForestOfLove.Audio.VolumeController::mainMixer
IL_000c: ldstr "FXVol"
IL_0011: ldarg.0
IL_0012: ldfld UnityEngine.AnimationCurve TheForestOfLove.Audio.VolumeController::falloff
IL_0017: ldc.r4 1
IL_001c: ldarg.1
IL_001d: sub
IL_001e: callvirt System.Single UnityEngine.AnimationCurve::Evaluate(System.Single)
IL_0023: ldarg.0
IL_0024: ldfld System.Int32 TheForestOfLove.Audio.VolumeController::minimumVolumeDb
IL_0029: conv.r4
IL_002a: mul
IL_002b: callvirt System.Boolean UnityEngine.Audio.AudioMixer::SetFloat(System.String,System.Single)
IL_0030: pop
IL_0031: ret
