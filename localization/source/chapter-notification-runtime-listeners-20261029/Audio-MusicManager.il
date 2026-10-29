TYPE TheForestOfLove.Audio.MusicManager
METHOD System.Void TheForestOfLove.Audio.MusicManager::AddEventListeners() | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.Core.BaseBehavior::AddEventListeners()
IL_0006: ldsfld UnityEngine.Events.UnityEvent`1<System.Boolean> TheForestOfLove.Events.GameEvents::onShowItemGetAchievementOverloadedForAdventures
IL_000b: ldnull
IL_000c: ldftn System.Void TheForestOfLove.Audio.MusicManager::HandleItemGetNotificationStart(System.Boolean)
IL_0012: newobj System.Void UnityEngine.Events.UnityAction`1<System.Boolean>::.ctor(System.Object,System.IntPtr)
IL_0017: callvirt System.Void UnityEngine.Events.UnityEvent`1<System.Boolean>::AddListener(UnityEngine.Events.UnityAction`1<!0>)
IL_001c: ldsfld UnityEngine.Events.UnityEvent`1<System.Boolean> TheForestOfLove.Events.GameEvents::onHideItemGetAchievementOverloadedForAdventures
IL_0021: ldnull
IL_0022: ldftn System.Void TheForestOfLove.Audio.MusicManager::HandleItemGetNotificationEnd(System.Boolean)
IL_0028: newobj System.Void UnityEngine.Events.UnityAction`1<System.Boolean>::.ctor(System.Object,System.IntPtr)
IL_002d: callvirt System.Void UnityEngine.Events.UnityEvent`1<System.Boolean>::AddListener(UnityEngine.Events.UnityAction`1<!0>)
IL_0032: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onPause
IL_0037: ldnull
IL_0038: ldftn System.Void TheForestOfLove.Audio.MusicManager::QuietMusic()
IL_003e: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0043: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_0048: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onUnpause
IL_004d: ldnull
IL_004e: ldftn System.Void TheForestOfLove.Audio.MusicManager::UnquietMusic()
IL_0054: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0059: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_005e: ldsfld TheForestOfLove.Events.MovieEvent TheForestOfLove.Events.GameEvents::onMovieStarting
IL_0063: ldarg.0
IL_0064: ldftn System.Void TheForestOfLove.Audio.MusicManager::OnMovieStarting(TheForestOfLove.Narrative.Movie)
IL_006a: newobj System.Void UnityEngine.Events.UnityAction`1<TheForestOfLove.Narrative.Movie>::.ctor(System.Object,System.IntPtr)
IL_006f: callvirt System.Void UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Movie>::AddListener(UnityEngine.Events.UnityAction`1<!0>)
IL_0074: ldsfld TheForestOfLove.Events.MovieEvent TheForestOfLove.Events.GameEvents::onMovieEnding
IL_0079: ldarg.0
IL_007a: ldftn System.Void TheForestOfLove.Audio.MusicManager::OnMovieEnding(TheForestOfLove.Narrative.Movie)
IL_0080: newobj System.Void UnityEngine.Events.UnityAction`1<TheForestOfLove.Narrative.Movie>::.ctor(System.Object,System.IntPtr)
IL_0085: callvirt System.Void UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Movie>::AddListener(UnityEngine.Events.UnityAction`1<!0>)
IL_008a: ret
METHOD System.Void TheForestOfLove.Audio.MusicManager::HandleItemGetNotificationStart(System.Boolean) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: brfalse.s IL_0009
IL_0003: call System.Void TheForestOfLove.Audio.MusicManager::QuietMusic()
IL_0008: ret
IL_0009: call System.Void TheForestOfLove.Audio.MusicManager::MuteMusic()
IL_000e: ret
