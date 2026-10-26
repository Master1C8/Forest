TYPE TheForestOfLove.IntroForestCutscene/<>c
METHOD System.Void TheForestOfLove.IntroForestCutscene/<>c::<EndCutscene>b__15_0()
IL_0000: ldc.i4 1600
IL_0005: call System.Void TheForestOfLove.Audio.SoundManager::Play(TheForestOfLove.Audio.SoundEffect)
IL_000a: ldc.r4 0
IL_000f: ldc.r4 2
IL_0014: newobj System.Void System.Nullable`1<System.Single>::.ctor(!0)
IL_0019: call System.Void TheForestOfLove.Audio.MusicManager::FadeToVolume(System.Single,System.Nullable`1<System.Single>)
IL_001e: ldc.r4 2.25
IL_0023: ldsfld System.Action TheForestOfLove.IntroForestCutscene/<>c::<>9__15_1
IL_0028: dup
IL_0029: brtrue.s IL_0042
IL_002b: pop
IL_002c: ldsfld TheForestOfLove.IntroForestCutscene/<>c TheForestOfLove.IntroForestCutscene/<>c::<>9
IL_0031: ldftn System.Void TheForestOfLove.IntroForestCutscene/<>c::<EndCutscene>b__15_1()
IL_0037: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_003c: dup
IL_003d: stsfld System.Action TheForestOfLove.IntroForestCutscene/<>c::<>9__15_1
IL_0042: call System.Void TheForestOfLove.Core.Timing.TimerHelper::StartTimer(System.Single,System.Action)
IL_0047: ret
METHOD System.Void TheForestOfLove.IntroForestCutscene/<>c::<EndCutscene>b__15_1()
IL_0000: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onCutsceneEnd
IL_0005: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_000a: ldstr "BunnyHouse"
IL_000f: call System.Void UnityEngine.SceneManagement.SceneManager::LoadScene(System.String)
IL_0014: ret
