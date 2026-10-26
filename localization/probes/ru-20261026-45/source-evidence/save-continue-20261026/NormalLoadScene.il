TYPE TheForestOfLove.ChapterSelectUI
METHOD System.Void TheForestOfLove.ChapterSelectUI::Start() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.Core.BaseBehavior::Start()
IL_0006: ldarg.0
IL_0007: ldfld UnityEngine.Animator TheForestOfLove.ChapterSelectUI::moreOptionsAboveAnimator
IL_000c: ldstr "above"
IL_0011: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0016: ldarg.0
IL_0017: ldfld UnityEngine.Animator TheForestOfLove.ChapterSelectUI::moreOptionsBelowAnimator
IL_001c: ldstr "below"
IL_0021: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0026: ldarg.0
IL_0027: call System.Void TheForestOfLove.ChapterSelectUI::FilterAvailableChapters()
IL_002c: ret
METHOD System.Void TheForestOfLove.ChapterSelectUI::OnSceneLoaded(UnityEngine.SceneManagement.Scene,UnityEngine.SceneManagement.LoadSceneMode) | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: ldarg.2
IL_0003: call System.Void TheForestOfLove.Core.BaseBehavior::OnSceneLoaded(UnityEngine.SceneManagement.Scene,UnityEngine.SceneManagement.LoadSceneMode)
IL_0008: ldarg.0
IL_0009: call System.Void TheForestOfLove.ChapterSelectUI::FilterAvailableChapters()
IL_000e: ret
