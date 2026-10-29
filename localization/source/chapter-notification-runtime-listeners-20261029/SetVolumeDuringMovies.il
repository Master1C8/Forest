TYPE TheForestOfLove.SetVolumeDuringMovies
METHOD System.Void TheForestOfLove.SetVolumeDuringMovies::AddEventListeners() | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.Core.BaseBehavior::AddEventListeners()
IL_0006: ldsfld TheForestOfLove.Events.MovieEvent TheForestOfLove.Events.GameEvents::onMovieStarting
IL_000b: ldarg.0
IL_000c: ldftn System.Void TheForestOfLove.SetVolumeDuringMovies::OnMovieStarting(TheForestOfLove.Narrative.Movie)
IL_0012: newobj System.Void UnityEngine.Events.UnityAction`1<TheForestOfLove.Narrative.Movie>::.ctor(System.Object,System.IntPtr)
IL_0017: callvirt System.Void UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Movie>::AddListener(UnityEngine.Events.UnityAction`1<!0>)
IL_001c: ldsfld TheForestOfLove.Events.MovieEvent TheForestOfLove.Events.GameEvents::onMovieEnding
IL_0021: ldarg.0
IL_0022: ldftn System.Void TheForestOfLove.SetVolumeDuringMovies::OnMovieEnding(TheForestOfLove.Narrative.Movie)
IL_0028: newobj System.Void UnityEngine.Events.UnityAction`1<TheForestOfLove.Narrative.Movie>::.ctor(System.Object,System.IntPtr)
IL_002d: callvirt System.Void UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Movie>::AddListener(UnityEngine.Events.UnityAction`1<!0>)
IL_0032: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onShowItemGetAchievement
IL_0037: ldarg.0
IL_0038: ldftn System.Void TheForestOfLove.SetVolumeDuringMovies::OnShowItemGetNotification()
IL_003e: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0043: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_0048: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onHideItemGetAchievement
IL_004d: ldarg.0
IL_004e: ldftn System.Void TheForestOfLove.SetVolumeDuringMovies::OnHideItemGetNotification()
IL_0054: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0059: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_005e: ret
METHOD System.Void TheForestOfLove.SetVolumeDuringMovies::OnShowItemGetNotification() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.SetVolumeDuringMovies::AudioFadeOut()
IL_0006: ret
