TYPE TheForestOfLove.SetVolumeDuringMovies
METHOD System.Void TheForestOfLove.SetVolumeDuringMovies::AudioFadeOut() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld UnityEngine.AudioSource[] TheForestOfLove.SetVolumeDuringMovies::audioSources
IL_0006: brtrue.s IL_0009
IL_0008: ret
IL_0009: ldarg.0
IL_000a: ldfld VolumetricAudio.VA_AudioSource[] TheForestOfLove.SetVolumeDuringMovies::vaAudioSources
IL_000f: brfalse.s IL_003a
IL_0011: ldarg.0
IL_0012: ldfld VolumetricAudio.VA_AudioSource[] TheForestOfLove.SetVolumeDuringMovies::vaAudioSources
IL_0017: stloc.0
IL_0018: ldc.i4.0
IL_0019: stloc.1
IL_001a: br.s IL_0034
IL_001c: ldloc.0
IL_001d: ldloc.1
IL_001e: ldelem.ref
IL_001f: stloc.2
IL_0020: ldloc.2
IL_0021: ldnull
IL_0022: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0027: brfalse.s IL_0030
IL_0029: ldloc.2
IL_002a: ldc.i4.0
IL_002b: callvirt System.Void UnityEngine.Behaviour::set_enabled(System.Boolean)
IL_0030: ldloc.1
IL_0031: ldc.i4.1
IL_0032: add
IL_0033: stloc.1
IL_0034: ldloc.1
IL_0035: ldloc.0
IL_0036: ldlen
IL_0037: conv.i4
IL_0038: blt.s IL_001c
IL_003a: ldarg.0
IL_003b: ldfld System.Single TheForestOfLove.SetVolumeDuringMovies::fadeSeconds
IL_0040: ldc.r4 0
IL_0045: bgt.un.s IL_007a
IL_0047: ldarg.0
IL_0048: ldfld UnityEngine.AudioSource[] TheForestOfLove.SetVolumeDuringMovies::audioSources
IL_004d: stloc.3
IL_004e: ldc.i4.0
IL_004f: stloc.1
IL_0050: br.s IL_006d
IL_0052: ldloc.3
IL_0053: ldloc.1
IL_0054: ldelem.ref
IL_0055: stloc.s V_4
IL_0057: ldloc.s V_4
IL_0059: ldnull
IL_005a: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_005f: brfalse.s IL_0069
IL_0061: ldarg.0
IL_0062: ldloc.s V_4
IL_0064: call System.Void TheForestOfLove.SetVolumeDuringMovies::CaptureOriginalVolume(UnityEngine.AudioSource)
IL_0069: ldloc.1
IL_006a: ldc.i4.1
IL_006b: add
IL_006c: stloc.1
IL_006d: ldloc.1
IL_006e: ldloc.3
IL_006f: ldlen
IL_0070: conv.i4
IL_0071: blt.s IL_0052
IL_0073: ldarg.0
IL_0074: call System.Void TheForestOfLove.SetVolumeDuringMovies::SetFinalVolume()
IL_0079: ret
IL_007a: ldarg.0
IL_007b: ldfld UnityEngine.AudioSource[] TheForestOfLove.SetVolumeDuringMovies::audioSources
IL_0080: stloc.3
IL_0081: ldc.i4.0
IL_0082: stloc.1
IL_0083: br.s IL_00c5
IL_0085: ldloc.3
IL_0086: ldloc.1
IL_0087: ldelem.ref
IL_0088: stloc.s V_5
IL_008a: ldloc.s V_5
IL_008c: ldnull
IL_008d: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0092: brfalse.s IL_00c1
IL_0094: ldarg.0
IL_0095: ldloc.s V_5
IL_0097: call System.Void TheForestOfLove.SetVolumeDuringMovies::CaptureOriginalVolume(UnityEngine.AudioSource)
IL_009c: ldloc.s V_5
IL_009e: ldarg.0
IL_009f: ldfld System.Single TheForestOfLove.SetVolumeDuringMovies::targetVolume
IL_00a4: ldarg.0
IL_00a5: ldfld System.Single TheForestOfLove.SetVolumeDuringMovies::fadeSeconds
IL_00aa: call DG.Tweening.Core.TweenerCore`3<System.Single,System.Single,DG.Tweening.Plugins.Options.FloatOptions> DG.Tweening.DOTweenModuleAudio::DOFade(UnityEngine.AudioSource,System.Single,System.Single)
IL_00af: ldarg.0
IL_00b0: ldftn System.Void TheForestOfLove.SetVolumeDuringMovies::<AudioFadeOut>b__9_0()
IL_00b6: newobj System.Void DG.Tweening.TweenCallback::.ctor(System.Object,System.IntPtr)
IL_00bb: call !!0 DG.Tweening.TweenSettingsExtensions::OnComplete<DG.Tweening.Core.TweenerCore`3<System.Single,System.Single,DG.Tweening.Plugins.Options.FloatOptions>>(!!0,DG.Tweening.TweenCallback)
IL_00c0: pop
IL_00c1: ldloc.1
IL_00c2: ldc.i4.1
IL_00c3: add
IL_00c4: stloc.1
IL_00c5: ldloc.1
IL_00c6: ldloc.3
IL_00c7: ldlen
IL_00c8: conv.i4
IL_00c9: blt.s IL_0085
IL_00cb: ret
