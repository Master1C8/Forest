TYPE TheForestOfLove.PauseScreenMainMenu
METHOD System.Void TheForestOfLove.PauseScreenMainMenu::OnClickChapterSelect() | attributes=Public, HideBySig | impl=IL
IL_0000: ldc.i4 200
IL_0005: call System.Void TheForestOfLove.Audio.SoundManager::Play(TheForestOfLove.Audio.SoundEffect)
IL_000a: ldarg.0
IL_000b: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.PauseScreenMainMenu::onClickChapterSelect
IL_0010: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_0015: ret
